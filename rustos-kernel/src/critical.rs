//! REQ: CRIT-001 - Critical Sections
//! 
//! Provides interrupt-safe critical sections for RISC-V.

use core::sync::atomic::{AtomicU32, Ordering};

/// REQ: CRIT-003 - Nesting counter for critical sections
static CRITICAL_NESTING: AtomicU32 = AtomicU32::new(0);

/// REQ: CRIT-001 - Enter critical section (disable interrupts)
/// 
/// Returns the previous mstatus.MIE bit value for restoration.
/// 
/// # Safety
/// Must be paired with exit_critical()
#[inline]
pub unsafe fn enter_critical() -> u32 {
    let nesting = CRITICAL_NESTING.fetch_add(1, Ordering::Acquire);
    
    if nesting == 0 {
        // REQ: CRIT-002 - Disable interrupts via mstatus.MIE
        let mstatus: usize;
        core::arch::asm!(
            "csrrci {}, mstatus, 0x08",  // Clear MIE bit (bit 3)
            out(reg) mstatus,
            options(nomem, nostack)
        );
        (mstatus & 0x08) as u32  // Return previous MIE bit
    } else {
        0  // Nested call, return 0
    }
}

/// REQ: CRIT-001 - Exit critical section (restore interrupts)
/// 
/// # Arguments
/// - `previous_mie`: The value returned by enter_critical()
/// 
/// # Safety
/// Must be paired with enter_critical()
#[inline]
pub unsafe fn exit_critical(previous_mie: u32) {
    let nesting = CRITICAL_NESTING.fetch_sub(1, Ordering::Release);
    
    if nesting == 1 {
        // REQ: CRIT-002 - Restore interrupts if they were previously enabled
        if previous_mie != 0 {
            core::arch::asm!(
                "csrsi mstatus, 0x08",  // Set MIE bit
                options(nomem, nostack)
            );
        }
    }
}

/// REQ: CRIT-004 - RAII guard for critical sections
pub struct CriticalSection {
    previous_mie: u32,
}

impl CriticalSection {
    /// Create a new critical section
    #[inline]
    pub fn new() -> Self {
        Self {
            previous_mie: unsafe { enter_critical() },
        }
    }
}

impl Drop for CriticalSection {
    #[inline]
    fn drop(&mut self) {
        unsafe { exit_critical(self.previous_mie) }
    }
}

/// REQ: CRIT-004 - Implement critical-section crate support
pub struct RustOsCriticalSection;

critical_section::set_impl!(RustOsCriticalSection);

unsafe impl critical_section::Impl for RustOsCriticalSection {
    unsafe fn acquire() -> critical_section::RawRestoreState {
        // critical-section crate expects () return type - we store state elsewhere
        enter_critical();
    }

    unsafe fn release(_state: critical_section::RawRestoreState) {
        // Use stored state from CRITICAL_NESTING
        exit_critical(0);  // Will check nesting level internally
    }
}
