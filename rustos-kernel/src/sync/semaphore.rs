//! REQ: SEM-001 - Semaphore Implementation
//! 
//! Counting semaphore for resource management.

use crate::critical::CriticalSection;
use portable_atomic::{AtomicU32, Ordering};

/// REQ: SEM-001 - Counting semaphore
pub struct Semaphore {
    /// Current count
    count: AtomicU32,
    /// Maximum count
    max_count: u32,
}

impl Semaphore {
    /// REQ: SEM-002 - Create a new semaphore
    /// 
    /// # Arguments
    /// - `initial_count`: Initial semaphore count
    /// - `max_count`: Maximum semaphore count
    pub const fn new(initial_count: u32, max_count: u32) -> Self {
        Self {
            count: AtomicU32::new(initial_count),
            max_count,
        }
    }

    /// REQ: SEM-003 - Binary semaphore (mutex-like)
    pub const fn binary() -> Self {
        Self::new(1, 1)
    }

    /// REQ: SEM-004 - Take/acquire semaphore (non-blocking)
    pub fn try_take(&self) -> bool {
        let _cs = CriticalSection::new();
        
        let count = self.count.load(Ordering::Acquire);
        if count > 0 {
            self.count.store(count - 1, Ordering::Release);
            true
        } else {
            false
        }
    }

    /// REQ: SEM-005 - Give/release semaphore
    pub fn give(&self) -> bool {
        let _cs = CriticalSection::new();
        
        let count = self.count.load(Ordering::Acquire);
        if count < self.max_count {
            self.count.store(count + 1, Ordering::Release);
            true
        } else {
            false  // Semaphore at maximum
        }
    }

    /// Get current count
    pub fn count(&self) -> u32 {
        self.count.load(Ordering::Acquire)
    }
}
