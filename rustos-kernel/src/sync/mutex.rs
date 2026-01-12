//! REQ: MTX-001 - Mutex Implementation
//! 
//! Provides mutual exclusion for shared resources.
//! 
//! # Priority Inheritance (Optional)
//! 
//! When the `priority-inheritance` feature is enabled, the mutex implements
//! the priority inheritance protocol to prevent priority inversion:
//! 
//! - When a high-priority task blocks on a mutex held by a lower-priority task,
//!   the holding task's priority is temporarily boosted to the blocked task's priority
//! - When the mutex is released, the holding task's priority is restored
//! - This ensures bounded priority inversion time
//!
//! # Example
//!
//! ```no_run
//! use rustos_kernel::sync::Mutex;
//!
//! static COUNTER: Mutex<u32> = Mutex::new(0);
//!
//! fn increment() {
//!     let mut guard = COUNTER.lock();
//!     *guard += 1;
//!     // Mutex automatically released when guard is dropped
//! }
//! ```

use crate::critical::CriticalSection;
use crate::task::TaskId;
#[cfg(feature = "priority-inheritance")]
use crate::task::TaskPriority;
use portable_atomic::{AtomicBool, AtomicU8, Ordering};

/// REQ: MTX-001 - Mutex for mutual exclusion
/// REQ: MTX-008, SCHED-015 - Priority inheritance support (feature-gated)
pub struct Mutex<T> {
    /// Locked flag
    locked: AtomicBool,
    /// Owner task ID (0xFF = no owner)
    owner: AtomicU8,
    /// Original priority of owner (for priority inheritance)
    #[cfg(feature = "priority-inheritance")]
    original_priority: AtomicU8,
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
            #[cfg(feature = "priority-inheritance")]
            original_priority: AtomicU8::new(0xFF),
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
                #[cfg(feature = "priority-inheritance")]
                {
                    // Store original priority for restoration on unlock
                    if let Some(task) = crate::scheduler::get().get_task(current_task) {
                        self.original_priority.store(task.priority().0, Ordering::Release);
                    }
                }
            }
            Some(MutexGuard { mutex: self })
        }
    }

    /// REQ: MTX-004 - Lock the mutex (blocking)
    /// REQ: MTX-008, SCHED-015 - With priority inheritance support
    /// 
    /// Note: This is a simplified implementation. A full RTOS would block
    /// the task and reschedule when the mutex becomes available.
    pub fn lock(&self) -> MutexGuard<'_, T> {
        loop {
            if let Some(guard) = self.try_lock() {
                return guard;
            }
            
            #[cfg(feature = "priority-inheritance")]
            {
                // Boost owner's priority to prevent priority inversion
                self.boost_owner_priority();
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
        
        #[cfg(feature = "priority-inheritance")]
        {
            // Restore original priority
            self.restore_owner_priority();
        }
        
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

    /// REQ: MTX-008, SCHED-015 - Boost owner's priority to waiting task's priority
    #[cfg(feature = "priority-inheritance")]
    fn boost_owner_priority(&self) {
        let _cs = CriticalSection::new();
        
        let owner_id = self.owner.load(Ordering::Acquire);
        if owner_id == 0xFF {
            return;
        }
        
        // Get waiting task's priority (current task)
        let waiter_priority = if let Some(current_id) = crate::scheduler::get().current_task() {
            if let Some(task) = crate::scheduler::get().get_task(current_id) {
                task.priority()
            } else {
                return;
            }
        } else {
            return;
        };
        
        // Boost owner's priority if waiter has higher priority (lower number)
        if let Some(owner_task) = unsafe { crate::scheduler::get().get_task_mut(TaskId(owner_id)) } {
            let owner_priority = owner_task.priority();
            if waiter_priority.0 < owner_priority.0 {
                // Boost: Higher priority = lower number
                owner_task.set_priority(waiter_priority);
            }
        }
    }

    /// REQ: MTX-008, SCHED-015 - Restore owner's original priority
    #[cfg(feature = "priority-inheritance")]
    fn restore_owner_priority(&self) {
        let owner_id = self.owner.load(Ordering::Acquire);
        if owner_id == 0xFF {
            return;
        }
        
        let original = self.original_priority.load(Ordering::Acquire);
        if original == 0xFF {
            return;
        }
        
        // Restore original priority
        if let Some(owner_task) = unsafe { crate::scheduler::get().get_task_mut(TaskId(owner_id)) } {
            owner_task.set_priority(TaskPriority(original));
        }
        
        self.original_priority.store(0xFF, Ordering::Release);
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
