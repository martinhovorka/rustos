//! REQ: TMR-001 - Timer Driver
//!
//! System timer functionality.

/// REQ: TMR-002 - System timer management
pub struct SystemTimer;

impl Default for SystemTimer {
    fn default() -> Self {
        Self::new()
    }
}

impl SystemTimer {
    /// Create system timer driver
    pub const fn new() -> Self {
        Self
    }

    /// REQ: TMR-003 - Get current ticks
    pub fn get_ticks(&self) -> u32 {
        // This will be provided by the kernel time module
        rustos_kernel::time::get_ticks()
    }

    /// REQ: TMR-004 - Get uptime in milliseconds (wraps after ~49.7 days on 32-bit)
    pub fn get_uptime_ms(&self) -> u32 {
        rustos_kernel::time::get_uptime_ms()
    }

    /// REQ: TMR-005 - Delay in milliseconds
    pub fn delay_ms(&self, ms: u32) {
        rustos_kernel::time::delay_ms(ms);
    }

    /// REQ: TMR-006 - Delay in ticks
    pub fn delay_ticks(&self, ticks: u32) {
        rustos_kernel::time::delay_ticks(ticks);
    }
}
