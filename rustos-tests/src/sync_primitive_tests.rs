//! REQ: SYNC-002, SYNC-003, SYNC-004 - Synchronization primitive tests
//!
//! Tests for Mutex, Semaphore, and other synchronization primitives.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use core::marker::{Send, Sync};
use core::option::Option::{self, None, Some};
use core::result::Result::{self, Err, Ok};
use std::sync::atomic::{AtomicBool, AtomicI32, AtomicU32, Ordering};
use std::sync::Arc;
use std::thread;
use std::time::Duration;
use std::vec::Vec;

// ============================================================================
// Mock Mutex Implementation
// ============================================================================

struct MockMutex {
    locked: AtomicBool,
    owner: AtomicI32,      // -1 = no owner, otherwise thread/task ID
    lock_count: AtomicU32, // For recursive locks
    contention_count: AtomicU32,
}

impl MockMutex {
    const fn new() -> Self {
        Self {
            locked: AtomicBool::new(false),
            owner: AtomicI32::new(-1),
            lock_count: AtomicU32::new(0),
            contention_count: AtomicU32::new(0),
        }
    }

    fn try_lock(&self, task_id: i32) -> bool {
        // Check for recursive lock
        if self.owner.load(Ordering::SeqCst) == task_id {
            self.lock_count.fetch_add(1, Ordering::SeqCst);
            return true;
        }

        match self
            .locked
            .compare_exchange(false, true, Ordering::SeqCst, Ordering::SeqCst)
        {
            Ok(_) => {
                self.owner.store(task_id, Ordering::SeqCst);
                self.lock_count.store(1, Ordering::SeqCst);
                true
            }
            Err(_) => {
                self.contention_count.fetch_add(1, Ordering::SeqCst);
                false
            }
        }
    }

    fn unlock(&self, task_id: i32) -> bool {
        if self.owner.load(Ordering::SeqCst) != task_id {
            return false; // Not the owner
        }

        let count = self.lock_count.fetch_sub(1, Ordering::SeqCst);
        if count == 1 {
            self.owner.store(-1, Ordering::SeqCst);
            self.locked.store(false, Ordering::SeqCst);
        }
        true
    }

    fn is_locked(&self) -> bool {
        self.locked.load(Ordering::SeqCst)
    }

    fn get_owner(&self) -> i32 {
        self.owner.load(Ordering::SeqCst)
    }

    fn reset(&self) {
        self.locked.store(false, Ordering::SeqCst);
        self.owner.store(-1, Ordering::SeqCst);
        self.lock_count.store(0, Ordering::SeqCst);
        self.contention_count.store(0, Ordering::SeqCst);
    }
}

// Make mutex safe to share between threads for testing
unsafe impl Send for MockMutex {}
unsafe impl Sync for MockMutex {}

#[test]
fn test_mutex_lock_unlock() {
    let mutex = MockMutex::new();

    assert_test!(!mutex.is_locked(), "Mutex should be unlocked initially");
    assert_test!(mutex.try_lock(1), "Lock should succeed");
    assert_test!(mutex.is_locked(), "Mutex should be locked");
    assert_test!(mutex.get_owner() == 1, "Owner should be task 1");

    assert_test!(mutex.unlock(1), "Unlock should succeed");
    assert_test!(!mutex.is_locked(), "Mutex should be unlocked");
}

#[test]
fn test_mutex_contention() {
    let mutex = MockMutex::new();

    assert_test!(mutex.try_lock(1), "Task 1 should get lock");
    assert_test!(!mutex.try_lock(2), "Task 2 should fail to get lock");

    mutex.unlock(1);
    assert_test!(mutex.try_lock(2), "Task 2 should get lock after release");
}

#[test]
fn test_mutex_wrong_owner_unlock() {
    let mutex = MockMutex::new();

    mutex.try_lock(1);
    assert_test!(!mutex.unlock(2), "Task 2 should not be able to unlock");
    assert_test!(mutex.is_locked(), "Mutex should still be locked");
}

#[test]
fn test_mutex_recursive() {
    let mutex = MockMutex::new();

    assert_test!(mutex.try_lock(1), "First lock should succeed");
    assert_test!(mutex.try_lock(1), "Second lock (recursive) should succeed");
    assert_test!(
        mutex.lock_count.load(Ordering::SeqCst) == 2,
        "Lock count should be 2"
    );

    assert_test!(mutex.unlock(1), "First unlock should succeed");
    assert_test!(mutex.is_locked(), "Mutex should still be locked (count=1)");

    assert_test!(mutex.unlock(1), "Second unlock should succeed");
    assert_test!(!mutex.is_locked(), "Mutex should be unlocked (count=0)");
}

#[test]
fn test_mutex_multithread() {
    let mutex = Arc::new(MockMutex::new());
    let counter = Arc::new(AtomicU32::new(0));

    let handles: Vec<_> = (0..4)
        .map(|id| {
            let mutex = Arc::clone(&mutex);
            let counter = Arc::clone(&counter);

            thread::spawn(move || {
                for _ in 0..100 {
                    while !mutex.try_lock(id) {
                        thread::yield_now();
                    }

                    // Critical section
                    let val = counter.load(Ordering::SeqCst);
                    counter.store(val + 1, Ordering::SeqCst);

                    mutex.unlock(id);
                }
            })
        })
        .collect();

    for handle in handles {
        handle.join().unwrap();
    }

    assert_test!(
        counter.load(Ordering::SeqCst) == 400,
        "Counter should be 400"
    );
}

// ============================================================================
// Mock Semaphore Implementation
// ============================================================================

struct MockSemaphore {
    count: AtomicI32,
    max_count: i32,
    waiters: AtomicU32,
}

impl MockSemaphore {
    fn new(initial: i32, max: i32) -> Self {
        Self {
            count: AtomicI32::new(initial),
            max_count: max,
            waiters: AtomicU32::new(0),
        }
    }

    fn try_acquire(&self) -> bool {
        loop {
            let current = self.count.load(Ordering::SeqCst);
            if current <= 0 {
                return false;
            }

            match self.count.compare_exchange(
                current,
                current - 1,
                Ordering::SeqCst,
                Ordering::SeqCst,
            ) {
                Ok(_) => return true,
                Err(_) => continue, // Retry
            }
        }
    }

    fn release(&self) -> bool {
        loop {
            let current = self.count.load(Ordering::SeqCst);
            if current >= self.max_count {
                return false; // Would exceed max
            }

            match self.count.compare_exchange(
                current,
                current + 1,
                Ordering::SeqCst,
                Ordering::SeqCst,
            ) {
                Ok(_) => return true,
                Err(_) => continue, // Retry
            }
        }
    }

    fn get_count(&self) -> i32 {
        self.count.load(Ordering::SeqCst)
    }
}

unsafe impl Send for MockSemaphore {}
unsafe impl Sync for MockSemaphore {}

#[test]
fn test_semaphore_counting() {
    let sem = MockSemaphore::new(3, 5);

    assert_test!(sem.get_count() == 3, "Initial count should be 3");

    assert_test!(sem.try_acquire(), "First acquire should succeed");
    assert_test!(sem.get_count() == 2, "Count should be 2");

    assert_test!(sem.try_acquire(), "Second acquire should succeed");
    assert_test!(sem.get_count() == 1, "Count should be 1");

    assert_test!(sem.try_acquire(), "Third acquire should succeed");
    assert_test!(sem.get_count() == 0, "Count should be 0");

    assert_test!(!sem.try_acquire(), "Fourth acquire should fail");
}

#[test]
fn test_semaphore_release() {
    let sem = MockSemaphore::new(0, 2);

    assert_test!(!sem.try_acquire(), "Acquire should fail with count 0");

    assert_test!(sem.release(), "Release should succeed");
    assert_test!(sem.get_count() == 1, "Count should be 1");

    assert_test!(sem.try_acquire(), "Acquire should succeed");
    assert_test!(sem.get_count() == 0, "Count should be 0");
}

#[test]
fn test_semaphore_max() {
    let sem = MockSemaphore::new(2, 2);

    assert_test!(!sem.release(), "Release should fail at max");
    assert_test!(sem.get_count() == 2, "Count should still be 2");
}

#[test]
fn test_semaphore_binary() {
    let sem = MockSemaphore::new(1, 1); // Binary semaphore (like mutex)

    assert_test!(sem.try_acquire(), "First acquire should succeed");
    assert_test!(!sem.try_acquire(), "Second acquire should fail");

    sem.release();
    assert_test!(sem.try_acquire(), "Acquire after release should succeed");
}

#[test]
fn test_semaphore_producer_consumer() {
    let sem_empty = Arc::new(MockSemaphore::new(5, 5)); // 5 empty slots
    let sem_full = Arc::new(MockSemaphore::new(0, 5)); // 0 full slots
    let produced = Arc::new(AtomicU32::new(0));
    let consumed = Arc::new(AtomicU32::new(0));

    let sem_empty_prod = Arc::clone(&sem_empty);
    let sem_full_prod = Arc::clone(&sem_full);
    let produced_prod = Arc::clone(&produced);

    // Producer
    let producer = thread::spawn(move || {
        for _ in 0..10 {
            while !sem_empty_prod.try_acquire() {
                thread::yield_now();
            }
            produced_prod.fetch_add(1, Ordering::SeqCst);
            sem_full_prod.release();
        }
    });

    // Consumer
    let consumer = thread::spawn(move || {
        for _ in 0..10 {
            while !sem_full.try_acquire() {
                thread::yield_now();
            }
            consumed.fetch_add(1, Ordering::SeqCst);
            sem_empty.release();
        }
    });

    producer.join().unwrap();
    consumer.join().unwrap();

    assert_test!(
        produced.load(Ordering::SeqCst) == 10,
        "Should produce 10 items"
    );
}

// ============================================================================
// Mock Condition Variable Implementation
// ============================================================================

struct MockCondVar {
    waiters: AtomicU32,
    signal_count: AtomicU32,
    broadcast_count: AtomicU32,
}

impl MockCondVar {
    const fn new() -> Self {
        Self {
            waiters: AtomicU32::new(0),
            signal_count: AtomicU32::new(0),
            broadcast_count: AtomicU32::new(0),
        }
    }

    fn wait(&self, mutex: &MockMutex, task_id: i32) -> bool {
        // Release mutex before waiting
        if !mutex.unlock(task_id) {
            return false;
        }

        self.waiters.fetch_add(1, Ordering::SeqCst);

        // Wait for signal (simplified - real impl would block)
        while self.signal_count.load(Ordering::SeqCst) == 0
            && self.broadcast_count.load(Ordering::SeqCst) == 0
        {
            thread::yield_now();
        }

        // Consume signal
        if self.signal_count.load(Ordering::SeqCst) > 0 {
            self.signal_count.fetch_sub(1, Ordering::SeqCst);
        }

        self.waiters.fetch_sub(1, Ordering::SeqCst);

        // Re-acquire mutex
        while !mutex.try_lock(task_id) {
            thread::yield_now();
        }

        true
    }

    fn signal(&self) {
        if self.waiters.load(Ordering::SeqCst) > 0 {
            self.signal_count.fetch_add(1, Ordering::SeqCst);
        }
    }

    fn broadcast(&self) {
        let waiters = self.waiters.load(Ordering::SeqCst);
        if waiters > 0 {
            self.broadcast_count.store(1, Ordering::SeqCst);
            self.signal_count.store(waiters, Ordering::SeqCst);
        }
    }

    fn reset(&self) {
        self.waiters.store(0, Ordering::SeqCst);
        self.signal_count.store(0, Ordering::SeqCst);
        self.broadcast_count.store(0, Ordering::SeqCst);
    }
}

unsafe impl Send for MockCondVar {}
unsafe impl Sync for MockCondVar {}

#[test]
fn test_condvar_signal() {
    let mutex = Arc::new(MockMutex::new());
    let condvar = Arc::new(MockCondVar::new());
    let data = Arc::new(AtomicU32::new(0));

    let mutex_waiter = Arc::clone(&mutex);
    let condvar_waiter = Arc::clone(&condvar);
    let data_waiter = Arc::clone(&data);

    let waiter = thread::spawn(move || {
        while !mutex_waiter.try_lock(1) {
            thread::yield_now();
        }

        while data_waiter.load(Ordering::SeqCst) == 0 {
            condvar_waiter.wait(&mutex_waiter, 1);
        }

        let val = data_waiter.load(Ordering::SeqCst);
        mutex_waiter.unlock(1);
        val
    });

    thread::sleep(Duration::from_millis(10));

    while !mutex.try_lock(2) {
        thread::yield_now();
    }
    data.store(42, Ordering::SeqCst);
    mutex.unlock(2);
    condvar.signal();

    let result = waiter.join().unwrap();
    assert_test!(result == 42, "Waiter should receive 42");
}

// ============================================================================
// Mock Barrier Implementation
// ============================================================================

struct MockBarrier {
    count: AtomicU32,
    threshold: u32,
    generation: AtomicU32,
}

impl MockBarrier {
    fn new(count: u32) -> Self {
        Self {
            count: AtomicU32::new(0),
            threshold: count,
            generation: AtomicU32::new(0),
        }
    }

    fn wait(&self) -> bool {
        let gen = self.generation.load(Ordering::SeqCst);

        let arrived = self.count.fetch_add(1, Ordering::SeqCst) + 1;

        if arrived == self.threshold {
            // Last one - release all
            self.count.store(0, Ordering::SeqCst);
            self.generation.fetch_add(1, Ordering::SeqCst);
            true // Leader
        } else {
            // Wait for others
            while self.generation.load(Ordering::SeqCst) == gen {
                thread::yield_now();
            }
            false
        }
    }
}

unsafe impl Send for MockBarrier {}
unsafe impl Sync for MockBarrier {}

#[test]
fn test_barrier() {
    let barrier = Arc::new(MockBarrier::new(4));
    let counter = Arc::new(AtomicU32::new(0));

    let handles: Vec<_> = (0..4)
        .map(|_| {
            let barrier = Arc::clone(&barrier);
            let counter = Arc::clone(&counter);

            thread::spawn(move || {
                // Phase 1
                counter.fetch_add(1, Ordering::SeqCst);
                barrier.wait();

                // All threads should have incremented by now
                let val = counter.load(Ordering::SeqCst);
                assert!(val >= 4, "All threads should have reached barrier");
            })
        })
        .collect();

    for handle in handles {
        handle.join().unwrap();
    }
}

// ============================================================================
// Mock Spinlock Implementation
// ============================================================================

struct MockSpinlock {
    locked: AtomicBool,
    spin_count: AtomicU32,
}

impl MockSpinlock {
    const fn new() -> Self {
        Self {
            locked: AtomicBool::new(false),
            spin_count: AtomicU32::new(0),
        }
    }

    fn lock(&self) {
        while self
            .locked
            .compare_exchange_weak(false, true, Ordering::Acquire, Ordering::Relaxed)
            .is_err()
        {
            self.spin_count.fetch_add(1, Ordering::Relaxed);
            core::hint::spin_loop();
        }
    }

    fn try_lock(&self) -> bool {
        self.locked
            .compare_exchange(false, true, Ordering::Acquire, Ordering::Relaxed)
            .is_ok()
    }

    fn unlock(&self) {
        self.locked.store(false, Ordering::Release);
    }

    fn is_locked(&self) -> bool {
        self.locked.load(Ordering::SeqCst)
    }
}

unsafe impl Send for MockSpinlock {}
unsafe impl Sync for MockSpinlock {}

#[test]
fn test_spinlock_lock_unlock() {
    let lock = MockSpinlock::new();

    assert_test!(!lock.is_locked(), "Should be unlocked initially");

    lock.lock();
    assert_test!(lock.is_locked(), "Should be locked");

    lock.unlock();
    assert_test!(!lock.is_locked(), "Should be unlocked");
}

#[test]
fn test_spinlock_try_lock() {
    let lock = MockSpinlock::new();

    assert_test!(lock.try_lock(), "Try lock should succeed");
    assert_test!(!lock.try_lock(), "Second try lock should fail");

    lock.unlock();
    assert_test!(lock.try_lock(), "Try lock should succeed after unlock");
}

#[test]
fn test_spinlock_multithread() {
    let lock = Arc::new(MockSpinlock::new());
    let counter = Arc::new(AtomicU32::new(0));

    let handles: Vec<_> = (0..4)
        .map(|_| {
            let lock = Arc::clone(&lock);
            let counter = Arc::clone(&counter);

            thread::spawn(move || {
                for _ in 0..1000 {
                    lock.lock();
                    let val = counter.load(Ordering::SeqCst);
                    counter.store(val + 1, Ordering::SeqCst);
                    lock.unlock();
                }
            })
        })
        .collect();

    for handle in handles {
        handle.join().unwrap();
    }

    assert_test!(
        counter.load(Ordering::SeqCst) == 4000,
        "Counter should be 4000"
    );
}

// ============================================================================
// Mock Reader-Writer Lock Implementation
// ============================================================================

struct MockRwLock {
    readers: AtomicI32,
    writer: AtomicBool,
    writer_waiting: AtomicBool,
}

impl MockRwLock {
    const fn new() -> Self {
        Self {
            readers: AtomicI32::new(0),
            writer: AtomicBool::new(false),
            writer_waiting: AtomicBool::new(false),
        }
    }

    fn read_lock(&self) {
        loop {
            // Wait for no writer and no waiting writer
            while self.writer.load(Ordering::SeqCst) || self.writer_waiting.load(Ordering::SeqCst) {
                thread::yield_now();
            }

            self.readers.fetch_add(1, Ordering::SeqCst);

            // Double-check no writer acquired
            if !self.writer.load(Ordering::SeqCst) {
                return;
            }

            // Writer got in, back off
            self.readers.fetch_sub(1, Ordering::SeqCst);
        }
    }

    fn read_unlock(&self) {
        self.readers.fetch_sub(1, Ordering::SeqCst);
    }

    fn write_lock(&self) {
        self.writer_waiting.store(true, Ordering::SeqCst);

        // Wait for no other writers
        while self
            .writer
            .compare_exchange(false, true, Ordering::SeqCst, Ordering::SeqCst)
            .is_err()
        {
            thread::yield_now();
        }

        // Wait for all readers to finish
        while self.readers.load(Ordering::SeqCst) > 0 {
            thread::yield_now();
        }

        self.writer_waiting.store(false, Ordering::SeqCst);
    }

    fn write_unlock(&self) {
        self.writer.store(false, Ordering::SeqCst);
    }
}

unsafe impl Send for MockRwLock {}
unsafe impl Sync for MockRwLock {}

#[test]
fn test_rwlock_read() {
    let lock = Arc::new(MockRwLock::new());
    let data = Arc::new(AtomicU32::new(42));

    // Multiple readers can read simultaneously
    let handles: Vec<_> = (0..4)
        .map(|_| {
            let lock = Arc::clone(&lock);
            let data = Arc::clone(&data);

            thread::spawn(move || {
                lock.read_lock();
                let val = data.load(Ordering::SeqCst);
                thread::sleep(Duration::from_millis(1));
                lock.read_unlock();
                val
            })
        })
        .collect();

    for handle in handles {
        let val = handle.join().unwrap();
        assert_test!(val == 42, "All readers should see 42");
    }
}

#[test]
fn test_rwlock_write() {
    let lock = Arc::new(MockRwLock::new());
    let data = Arc::new(AtomicU32::new(0));

    // Writers are exclusive
    let handles: Vec<_> = (0..4)
        .map(|_| {
            let lock = Arc::clone(&lock);
            let data = Arc::clone(&data);

            thread::spawn(move || {
                lock.write_lock();
                let val = data.load(Ordering::SeqCst);
                data.store(val + 1, Ordering::SeqCst);
                lock.write_unlock();
            })
        })
        .collect();

    for handle in handles {
        handle.join().unwrap();
    }

    assert_test!(data.load(Ordering::SeqCst) == 4, "Data should be 4");
}
