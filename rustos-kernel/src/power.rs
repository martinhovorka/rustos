//! REQ: PWR-001, PWR-002 - Power Management
//! 
//! Power saving features for RustOS kernel.

/// REQ: PWR-001 - Wait For Interrupt instruction
/// REQ: PWR-002 - Configurable via wfi-idle feature flag
/// 
/// Puts the CPU into low-power mode until an interrupt arrives.
/// This should be called from the idle task when no work is available.
/// 
/// # Safety
/// - Must be called with interrupts enabled
/// - Will return when any interrupt occurs
#[inline]
pub fn wait_for_interrupt() {
    #[cfg(feature = "wfi-idle")]
    {
        // REQ: PWR-001 - Use WFI instruction on RISC-V
        unsafe {
            core::arch::asm!("wfi");
        }
    }
    
    #[cfg(not(feature = "wfi-idle"))]
    {
        // When WFI is disabled (e.g., for debugging), use a hint
        core::hint::spin_loop();
    }
}

/// REQ: PWR-008 - Check if WFI is enabled
pub const fn is_wfi_enabled() -> bool {
    cfg!(feature = "wfi-idle")
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_wfi_compiles() {
        // Just ensure the function compiles and can be called
        // Actual testing requires hardware or emulator
        let _enabled = is_wfi_enabled();
    }
}
