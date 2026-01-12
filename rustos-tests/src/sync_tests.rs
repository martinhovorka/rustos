//! REQ: TEST-006 - Dedicated test modules for synchronization primitives
//!
//! Tests for Mutex, Semaphore, Queue, and EventFlags.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use crate::utils::{boundary, concurrent};
use core::option::Option::{self, None, Some};
use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};
use std::vec::Vec;

/// Mock Mutex implementation for testing
struct MockMutex {
    locked: AtomicU32,
    owner: AtomicU32,
}

impl MockMutex {
    fn new() -> Self {
        Self {
            locked: AtomicU32::new(0),
            owner: AtomicU32::new(0),
        }
    }

    fn try_lock(&self, task_id: u32) -> bool {
        self.locked
            .compare_exchange(0, 1, Ordering::Acquire, Ordering::Relaxed)
            .is_ok()
            .then(|| {
                self.owner.store(task_id, Ordering::Relaxed);
                true
            })
            .unwrap_or(false)
    }

    fn unlock(&self) {
        self.owner.store(0, Ordering::Relaxed);
        self.locked.store(0, Ordering::Release);
    }

    fn is_locked(&self) -> bool {
        self.locked.load(Ordering::Relaxed) != 0
    }

    fn get_owner(&self) -> u32 {
        self.owner.load(Ordering::Relaxed)
    }
}

/// Mock Semaphore implementation for testing
struct MockSemaphore {
    count: AtomicU32,
    max_count: u32,
}

impl MockSemaphore {
    fn new(initial_count: u32, max_count: u32) -> Self {
        Self {
            count: AtomicU32::new(initial_count),
            max_count,
        }
    }

    fn wait(&self) -> bool {
        loop {
            let current = self.count.load(Ordering::Acquire);
            if current == 0 {
                return false; // Would block
            }
            if self.count
                .compare_exchange(current, current - 1, Ordering::Acquire, Ordering::Relaxed)
                .is_ok()
            {
                return true;
            }
        }
    }

    fn signal(&self) -> bool {
        loop {
            let current = self.count.load(Ordering::Acquire);
            if current >= self.max_count {
                return false; // At maximum
            }
            if self.count
                .compare_exchange(current, current + 1, Ordering::Release, Ordering::Relaxed)
                .is_ok()
            {
                return true;
            }
        }
    }

    fn get_count(&self) -> u32 {
        self.count.load(Ordering::Relaxed)
    }
}

/// Mock Queue implementation for testing
struct MockQueue<T> {
    items: std::sync::Mutex<Vec<T>>,
    capacity: usize,
}

impl<T> MockQueue<T> {
    fn new(capacity: usize) -> Self {
        Self {
            items: std::sync::Mutex::new(Vec::with_capacity(capacity)),
            capacity,
        }
    }

    fn enqueue(&self, item: T) -> bool {
        let mut items = self.items.lock().unwrap();
        if items.len() >= self.capacity {
            return false; // Queue full
        }
        items.push(item);
        true
    }

    fn dequeue(&self) -> Option<T> {
        let mut items = self.items.lock().unwrap();
        if items.is_empty() {
            None
        } else {
            Some(items.remove(0))
        }
    }

    fn len(&self) -> usize {
        self.items.lock().unwrap().len()
    }

    fn is_empty(&self) -> bool {
        self.items.lock().unwrap().is_empty()
    }

    fn is_full(&self) -> bool {
        self.items.lock().unwrap().len() >= self.capacity
    }
}

/// Mock EventFlags implementation for testing
struct MockEventFlags {
    flags: AtomicU32,
}

impl MockEventFlags {
    fn new() -> Self {
        Self {
            flags: AtomicU32::new(0),
        }
    }

    fn set(&self, mask: u32) {
        self.flags.fetch_or(mask, Ordering::Release);
    }

    fn clear(&self, mask: u32) {
        self.flags.fetch_and(!mask, Ordering::Release);
    }

    fn wait_all(&self, mask: u32) -> bool {
        (self.flags.load(Ordering::Acquire) & mask) == mask
    }

    fn wait_any(&self, mask: u32) -> bool {
        (self.flags.load(Ordering::Acquire) & mask) != 0
    }

    fn get(&self) -> u32 {
        self.flags.load(Ordering::Relaxed)
    }
}

// ============================================================================
// Mutex Tests
// ============================================================================

#[test]
fn test_mutex_lock_unlock() {
    // REQ: TEST-006 - Mutex test module
    // REQ: MUTEX-001 - Basic lock/unlock
    let mutex = MockMutex::new();

    assert_test!(!mutex.is_locked(), "Mutex should initially be unlocked");

    // Lock the mutex
    assert_test!(mutex.try_lock(1), "Should successfully lock mutex");
    assert_test!(mutex.is_locked(), "Mutex should be locked");
    assert_eq!(mutex.get_owner(), 1);

    // Unlock the mutex
    mutex.unlock();
    assert_test!(!mutex.is_locked(), "Mutex should be unlocked after unlock()");
}

#[test]
fn test_mutex_double_lock() {
    // REQ: TEST-008 - Edge case: double lock attempt
    let mutex = MockMutex::new();

    assert_test!(mutex.try_lock(1), "First lock should succeed");
    assert_test!(!mutex.try_lock(2), "Second lock should fail (already locked)");

    mutex.unlock();
    assert_test!(mutex.try_lock(2), "Lock after unlock should succeed");
}

#[test]
fn test_mutex_concurrent_access() {
    // REQ: TEST-009 - Concurrent access patterns
    let mutex = Arc::new(MockMutex::new());
    let counter = Arc::new(AtomicU32::new(0));

    concurrent::run_concurrent(10, {
        let mutex = Arc::clone(&mutex);
        let counter = Arc::clone(&counter);
        move |thread_id| {
            // Try to acquire lock
            while !mutex.try_lock(thread_id as u32) {
                std::thread::yield_now();
            }

            // Critical section
            let current = counter.load(Ordering::Relaxed);
            std::thread::sleep(std::time::Duration::from_micros(10));
            counter.store(current + 1, Ordering::Relaxed);

            // Release lock
            mutex.unlock();
        }
    });

    assert_eq!(counter.load(Ordering::Relaxed), 10);
}

// ============================================================================
// Semaphore Tests
// ============================================================================

#[test]
fn test_semaphore_wait_signal() {
    // REQ: TEST-006 - Semaphore test module
    // REQ: SEM-001 - Basic wait/signal
    let sem = MockSemaphore::new(1, 3);

    assert_eq!(sem.get_count(), 1);

    // Wait (decrement)
    assert_test!(sem.wait(), "Wait should succeed");
    assert_eq!(sem.get_count(), 0);

    // Signal (increment)
    assert_test!(sem.signal(), "Signal should succeed");
    assert_eq!(sem.get_count(), 1);
}

#[test]
fn test_semaphore_zero_count() {
    // REQ: TEST-008 - Edge case: zero count
    let sem = MockSemaphore::new(0, 3);

    assert_eq!(sem.get_count(), 0);
    assert_test!(!sem.wait(), "Wait on zero count should fail (would block)");

    // Signal to make count non-zero
    assert_test!(sem.signal(), "Signal should succeed");
    assert_eq!(sem.get_count(), 1);
    assert_test!(sem.wait(), "Wait should now succeed");
}

#[test]
fn test_semaphore_max_count() {
    // REQ: TEST-008 - Edge case: maximum count
    let sem = MockSemaphore::new(3, 3);

    assert_eq!(sem.get_count(), 3);
    assert_test!(!sem.signal(), "Signal at max count should fail");

    // Wait to reduce count
    assert_test!(sem.wait(), "Wait should succeed");
    assert_eq!(sem.get_count(), 2);
    assert_test!(sem.signal(), "Signal should now succeed");
}

#[test]
fn test_semaphore_concurrent() {
    // REQ: TEST-009 - Concurrent semaphore access
    let sem = Arc::new(MockSemaphore::new(5, 10));
    let success_count = Arc::new(AtomicU32::new(0));

    concurrent::run_concurrent(10, {
        let sem = Arc::clone(&sem);
        let success_count = Arc::clone(&success_count);
        move |_| {
            if sem.wait() {
                success_count.fetch_add(1, Ordering::Relaxed);
                std::thread::sleep(std::time::Duration::from_micros(10));
                sem.signal();
            }
        }
    });

    // All threads should eventually succeed
    assert_eq!(success_count.load(Ordering::Relaxed), 10);
}

// ============================================================================
// Queue Tests
// ============================================================================

#[test]
fn test_queue_enqueue_dequeue() {
    // REQ: TEST-006 - Queue test module
    // REQ: QUEUE-001 - Basic enqueue/dequeue
    let queue = MockQueue::new(5);

    assert_test!(queue.is_empty(), "Queue should initially be empty");

    // Enqueue items
    assert_test!(queue.enqueue(1), "Enqueue should succeed");
    assert_test!(queue.enqueue(2), "Enqueue should succeed");
    assert_eq!(queue.len(), 2);

    // Dequeue items
    assert_eq!(queue.dequeue(), Some(1));
    assert_eq!(queue.dequeue(), Some(2));
    assert_test!(queue.is_empty(), "Queue should be empty after dequeue all");
}

#[test]
fn test_queue_full() {
    // REQ: TEST-008 - Edge case: full queue
    let queue = MockQueue::new(3);

    assert_test!(queue.enqueue(1), "Enqueue 1 should succeed");
    assert_test!(queue.enqueue(2), "Enqueue 2 should succeed");
    assert_test!(queue.enqueue(3), "Enqueue 3 should succeed");
    assert_test!(queue.is_full(), "Queue should be full");

    // Try to enqueue when full
    assert_test!(!queue.enqueue(4), "Enqueue on full queue should fail");

    // Dequeue one item
    assert_eq!(queue.dequeue(), Some(1));
    assert_test!(!queue.is_full(), "Queue should not be full after dequeue");

    // Now enqueue should succeed
    assert_test!(queue.enqueue(4), "Enqueue after dequeue should succeed");
}

#[test]
fn test_queue_empty() {
    // REQ: TEST-008 - Edge case: empty queue
    let queue = MockQueue::<u32>::new(5);

    assert_test!(queue.is_empty(), "Queue should be empty");
    assert_eq!(queue.dequeue(), None);
}

#[test]
fn test_queue_fifo_order() {
    // REQ: QUEUE-002 - FIFO ordering
    let queue = MockQueue::new(10);

    for i in 1..=5 {
        queue.enqueue(i);
    }

    for i in 1..=5 {
        assert_eq!(queue.dequeue(), Some(i));
    }
}

#[test]
fn test_queue_concurrent() {
    // REQ: TEST-009 - Concurrent queue access
    let queue = Arc::new(MockQueue::new(100));
    let enqueued = Arc::new(AtomicU32::new(0));

    // Producer threads
    concurrent::run_concurrent(5, {
        let queue = Arc::clone(&queue);
        let enqueued = Arc::clone(&enqueued);
        move |thread_id| {
            for i in 0..10 {
                let value = thread_id * 10 + i;
                if queue.enqueue(value as u32) {
                    enqueued.fetch_add(1, Ordering::Relaxed);
                }
            }
        }
    });

    assert_eq!(enqueued.load(Ordering::Relaxed), 50);
}

// ============================================================================
// EventFlags Tests
// ============================================================================

#[test]
fn test_event_flags_set_clear() {
    // REQ: TEST-006 - EventFlags test module
    // REQ: EVENT-001 - Set/clear flags
    let flags = MockEventFlags::new();

    assert_eq!(flags.get(), 0);

    // Set flags
    flags.set(0x01);
    assert_eq!(flags.get(), 0x01);

    flags.set(0x02);
    assert_eq!(flags.get(), 0x03);

    // Clear flags
    flags.clear(0x01);
    assert_eq!(flags.get(), 0x02);

    flags.clear(0x02);
    assert_eq!(flags.get(), 0x00);
}

#[test]
fn test_event_flags_wait_all() {
    // REQ: EVENT-003 - Wait for all flags
    let flags = MockEventFlags::new();

    flags.set(0x05); // Set bits 0 and 2

    assert_test!(flags.wait_all(0x05), "Wait for 0x05 should succeed");
    assert_test!(!flags.wait_all(0x07), "Wait for 0x07 should fail (bit 1 not set)");
}

#[test]
fn test_event_flags_wait_any() {
    // REQ: EVENT-004 - Wait for any flag
    let flags = MockEventFlags::new();

    flags.set(0x02); // Set bit 1

    assert_test!(flags.wait_any(0x06), "Wait any for 0x06 should succeed (bit 1 is set)");
    assert_test!(!flags.wait_any(0x01), "Wait any for 0x01 should fail (bit 0 not set)");
}

#[test]
fn test_event_flags_boundary() {
    // REQ: TEST-008 - Boundary values
    let flags = MockEventFlags::new();

    // Set all bits
    flags.set(boundary::MAX_U32);
    assert_eq!(flags.get(), boundary::MAX_U32);

    // Clear all bits
    flags.clear(boundary::MAX_U32);
    assert_eq!(flags.get(), 0);
}

#[test]
fn test_event_flags_concurrent() {
    // REQ: TEST-009 - Concurrent event flags
    let flags = Arc::new(MockEventFlags::new());

    concurrent::run_concurrent(10, {
        let flags = Arc::clone(&flags);
        move |thread_id| {
            let bit = 1 << (thread_id % 32);
            flags.set(bit);
            std::thread::sleep(std::time::Duration::from_micros(10));
            assert_test!(flags.wait_any(bit), "Bit should be set");
        }
    });
}
