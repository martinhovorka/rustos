//! Event Flags implementation
//!
//! Provides event flag groups for task synchronization

use core::sync::atomic::{AtomicU32, Ordering};

/// Event flag options
#[derive(Debug, Clone, Copy)]
pub enum WaitOption {
    /// Wait for all specified flags
    All,
    /// Wait for any of the specified flags
    Any,
}

/// Event flags group
pub struct EventFlags {
    flags: AtomicU32,
}

impl EventFlags {
    /// Create a new event flags group
    pub const fn new() -> Self {
        Self {
            flags: AtomicU32::new(0),
        }
    }

    /// Set specified flags
    pub fn set(&self, flags: u32) {
        self.flags.fetch_or(flags, Ordering::Release);
    }

    /// Clear specified flags
    pub fn clear(&self, flags: u32) {
        self.flags.fetch_and(!flags, Ordering::Release);
    }

    /// Get current flags
    pub fn get(&self) -> u32 {
        self.flags.load(Ordering::Acquire)
    }

    /// Wait for flags with specified option
    pub fn wait(&self, flags: u32, option: WaitOption) {
        loop {
            let current = self.flags.load(Ordering::Acquire);
            match option {
                WaitOption::All => {
                    if (current & flags) == flags {
                        return;
                    }
                }
                WaitOption::Any => {
                    if (current & flags) != 0 {
                        return;
                    }
                }
            }
            // In a real implementation, this would block the task
            core::hint::spin_loop();
        }
    }

    /// Try to wait for flags (non-blocking)
    pub fn try_wait(&self, flags: u32, option: WaitOption) -> bool {
        let current = self.flags.load(Ordering::Acquire);
        match option {
            WaitOption::All => (current & flags) == flags,
            WaitOption::Any => (current & flags) != 0,
        }
    }

    /// Wait for flags and clear them atomically
    pub fn wait_and_clear(&self, flags: u32, option: WaitOption) {
        loop {
            let current = self.flags.load(Ordering::Acquire);
            let matched = match option {
                WaitOption::All => (current & flags) == flags,
                WaitOption::Any => (current & flags) != 0,
            };

            if matched {
                if self
                    .flags
                    .compare_exchange(
                        current,
                        current & !flags,
                        Ordering::Release,
                        Ordering::Relaxed,
                    )
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
}

unsafe impl Send for EventFlags {}
unsafe impl Sync for EventFlags {}

impl Default for EventFlags {
    fn default() -> Self {
        Self::new()
    }
}
