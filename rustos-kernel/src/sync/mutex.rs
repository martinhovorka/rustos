//! REQ: MTX-001 - Mutex Implementation
//! 
//! Provides mutual exclusion for shared resources.

use crate::critical::CriticalSection;
use crate::task::TaskId;
use portable_atomic::{AtomicBool, AtomicU8, Ordering};

/// REQ: MTX-001 - Mutex for mutual exclusion
pub struct Mutex<T> {
    /// Locked flag
    locked: AtomicBool,
    /// Owner task ID (0xFF = no owner)
    owner: AtomicU8,
    /// Protected data
    data: core::cell::UnsafeCell<T>,
}

unsafe impl<T: Send> Send for Mutex<T> {}
unsafe impl<T: Send> Sync for Mutex<T> {}

impl<T> Mutex<T> {
    /// REQ: MTX-002 - Create a new mutex
    pub const fn new(data: T) -> Self {
        Self {
            locked: AtomicBool::new(false),
            owner: AtomicU8::new(0xFF),
            data: core::cell::UnsafeCell::new(data),
        }
    }

    /// REQ: MTX-003 - Try to lock the mutex (non-blocking)
    pub fn try_lock(&self) -> Option<MutexGuard<'_, T>> {
        let _cs = CriticalSection::new();
        
        if self.locked.swap(true, Ordering::Acquire) {
            // Already locked
            None
        } else {
            // Successfully locked
            if let Some(current_task) = crate::scheduler::get().current_task() {
                self.owner.store(current_task.0, Ordering::Release);
            }
            Some(MutexGuard { mutex: self })
        }
    }

    /// REQ: MTX-004 - Lock the mutex (blocking)
    /// 
    /// Note: This is a simplified implementation. A full RTOS would block
    /// the task and reschedule when the mutex becomes available.
    pub fn lock(&self) -> MutexGuard<'_, T> {
        loop {
            if let Some(guard) = self.try_lock() {
                return guard;
            }
            // In a full implementation, would call scheduler to yield
            core::hint::spin_loop();
        }
    }

    /// REQ: MTX-005 - Unlock the mutex
    /// 
    /// # Safety
    /// Must only be called by the owning task
    unsafe fn unlock(&self) {
        let _cs = CriticalSection::new();
        self.owner.store(0xFF, Ordering::Release);
        self.locked.store(false, Ordering::Release);
    }

    /// Get the current owner task ID
    pub fn owner(&self) -> Option<TaskId> {
        let owner = self.owner.load(Ordering::Acquire);
        if owner == 0xFF {
            None
        } else {
            Some(TaskId(owner))
        }
    }
}

/// REQ: MTX-006 - RAII guard for mutex
pub struct MutexGuard<'a, T> {
    mutex: &'a Mutex<T>,
}

impl<'a, T> core::ops::Deref for MutexGuard<'a, T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        unsafe { &*self.mutex.data.get() }
    }
}

impl<'a, T> core::ops::DerefMut for MutexGuard<'a, T> {
    fn deref_mut(&mut self) -> &mut Self::Target {
        unsafe { &mut *self.mutex.data.get() }
    }
}

impl<'a, T> Drop for MutexGuard<'a, T> {
    fn drop(&mut self) {
        unsafe { self.mutex.unlock() }
    }
}
