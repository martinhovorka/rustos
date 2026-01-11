//! REQ: EVT-001 - Event Flags Implementation
//! 
//! 32-bit event flags for task synchronization.

use crate::critical::CriticalSection;
use portable_atomic::{AtomicU32, Ordering};

/// REQ: EVT-001 - Event flags (32-bit)
pub struct EventFlags {
    /// Event flags bitfield
    flags: AtomicU32,
}

/// REQ: EVT-002 - Wait conditions
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum WaitCondition {
    /// Wait for all specified bits to be set
    All,
    /// Wait for any of the specified bits to be set
    Any,
}

impl EventFlags {
    /// REQ: EVT-003 - Create new event flags
    pub const fn new() -> Self {
        Self {
            flags: AtomicU32::new(0),
        }
    }

    /// REQ: EVT-004 - Set event flags
    pub fn set(&self, mask: u32) {
        let _cs = CriticalSection::new();
        self.flags.fetch_or(mask, Ordering::Release);
    }

    /// REQ: EVT-005 - Clear event flags
    pub fn clear(&self, mask: u32) {
        let _cs = CriticalSection::new();
        self.flags.fetch_and(!mask, Ordering::Release);
    }

    /// REQ: EVT-006 - Check if flags match condition
    pub fn check(&self, mask: u32, condition: WaitCondition) -> bool {
        let flags = self.flags.load(Ordering::Acquire);
        
        match condition {
            WaitCondition::All => (flags & mask) == mask,
            WaitCondition::Any => (flags & mask) != 0,
        }
    }

    /// REQ: EVT-007 - Wait for flags (non-blocking check)
    pub fn try_wait(&self, mask: u32, condition: WaitCondition, clear: bool) -> bool {
        let _cs = CriticalSection::new();
        
        if self.check(mask, condition) {
            if clear {
                self.clear(mask);
            }
            true
        } else {
            false
        }
    }

    /// Get current flags value
    pub fn get(&self) -> u32 {
        self.flags.load(Ordering::Acquire)
    }
}
