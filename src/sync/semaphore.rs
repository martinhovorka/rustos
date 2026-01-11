//! Semaphore implementation
//!
//! Provides counting and binary semaphores

use core::sync::atomic::{AtomicUsize, Ordering};

/// A counting semaphore
pub struct Semaphore {
    count: AtomicUsize,
    max_count: usize,
}

impl Semaphore {
    /// Create a new counting semaphore
    pub const fn new(initial: usize, max: usize) -> Self {
        Self {
            count: AtomicUsize::new(initial),
            max_count: max,
        }
    }

    /// Wait on the semaphore (decrement count)
    pub fn wait(&self) {
        loop {
            let current = self.count.load(Ordering::Acquire);
            if current > 0 {
                if self
                    .count
                    .compare_exchange(current, current - 1, Ordering::Acquire, Ordering::Relaxed)
                    .is_ok()
                {
                    return;
                }
            } else {
                // In a real implementation, this would block the task
                core::hint::spin_loop();
            }
        }
    }

    /// Try to wait on the semaphore (non-blocking)
    pub fn try_wait(&self) -> bool {
        loop {
            let current = self.count.load(Ordering::Acquire);
            if current > 0 {
                if self
                    .count
                    .compare_exchange(current, current - 1, Ordering::Acquire, Ordering::Relaxed)
                    .is_ok()
                {
                    return true;
                }
                // Retry if CAS failed due to concurrent modification
            } else {
                return false;
            }
        }
    }

    /// Signal the semaphore (increment count)
    pub fn signal(&self) {
        loop {
            let current = self.count.load(Ordering::Acquire);
            if current < self.max_count {
                if self
                    .count
                    .compare_exchange(current, current + 1, Ordering::Release, Ordering::Relaxed)
                    .is_ok()
                {
                    return;
                }
            } else {
                return; // Already at max
            }
        }
    }

    /// Get current count
    pub fn count(&self) -> usize {
        self.count.load(Ordering::Acquire)
    }
}

unsafe impl Send for Semaphore {}
unsafe impl Sync for Semaphore {}

/// A binary semaphore (mutex-like)
pub struct BinarySemaphore {
    inner: Semaphore,
}

impl BinarySemaphore {
    /// Create a new binary semaphore
    pub const fn new(initial: bool) -> Self {
        Self {
            inner: Semaphore::new(if initial { 1 } else { 0 }, 1),
        }
    }

    /// Take the semaphore
    pub fn take(&self) {
        self.inner.wait();
    }

    /// Try to take the semaphore (non-blocking)
    pub fn try_take(&self) -> bool {
        self.inner.try_wait()
    }

    /// Give the semaphore
    pub fn give(&self) {
        self.inner.signal();
    }
}

unsafe impl Send for BinarySemaphore {}
unsafe impl Sync for BinarySemaphore {}
