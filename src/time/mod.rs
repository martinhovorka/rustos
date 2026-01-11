//! Time management for RustOS
//!
//! Provides timing and delay functions

use core::sync::atomic::{AtomicU32, Ordering};

/// System tick counter (32-bit to support RISC-V atomic operations)
static SYSTEM_TICKS: AtomicU32 = AtomicU32::new(0);

/// System tick frequency in Hz
pub const TICK_FREQ_HZ: u32 = 1000;

/// Initialize the time subsystem
pub fn init() {
    SYSTEM_TICKS.store(0, Ordering::Release);
}

/// Increment system tick (called from timer interrupt)
pub fn tick() {
    SYSTEM_TICKS.fetch_add(1, Ordering::Release);
}

/// Get current system ticks
pub fn ticks() -> u32 {
    SYSTEM_TICKS.load(Ordering::Acquire)
}

/// Convert ticks to milliseconds
pub fn ticks_to_ms(ticks: u32) -> u32 {
    ticks * 1000 / TICK_FREQ_HZ
}

/// Convert milliseconds to ticks
pub fn ms_to_ticks(ms: u32) -> u32 {
    ms * TICK_FREQ_HZ / 1000
}

/// Delay for specified number of ticks
pub fn delay_ticks(ticks: u32) {
    let start = self::ticks();
    while self::ticks().wrapping_sub(start) < ticks {
        core::hint::spin_loop();
    }
}

/// Delay for specified number of milliseconds
pub fn delay_ms(ms: u32) {
    delay_ticks(ms_to_ticks(ms));
}
