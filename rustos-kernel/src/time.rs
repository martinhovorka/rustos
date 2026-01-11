//! REQ: TIME-001 - Time Management
//! 
//! System tick and time tracking functionality.

use portable_atomic::{AtomicU32, Ordering};

/// REQ: TIME-001 - System tick rate: 1000 Hz (1 ms period)
pub const TICK_RATE_HZ: u32 = 1000;
/// REQ: TIME-001 - System tick period in milliseconds
/// REQ: TIME-001 - System tick period in milliseconds
pub const TICK_PERIOD_MS: u32 = 1;

/// REQ: TIME-002 - Global tick counter (32-bit, wraps after ~49.7 days)
static TICK_COUNT: AtomicU32 = AtomicU32::new(0);

/// REQ: TIME-003 - Extended uptime counter (32-bit, milliseconds, wraps after ~49.7 days)
static UPTIME_MS: AtomicU32 = AtomicU32::new(0);

/// REQ: KERN-003 - Initialize time management
pub(crate) fn init() {
    TICK_COUNT.store(0, Ordering::Release);
    UPTIME_MS.store(0, Ordering::Release);
}

/// REQ: SCHED-004, TIME-002 - Increment tick count (called from timer ISR)
/// 
/// # Safety
/// Must be called from timer interrupt handler
pub unsafe fn tick() {
    let ticks = TICK_COUNT.fetch_add(1, Ordering::Relaxed);
    
    // REQ: TIME-003 - Update uptime counter
    if (ticks & 0xFF) == 0 {
        // Update every 256 ticks to reduce atomic overhead
        let uptime_ms = ticks * TICK_PERIOD_MS;
        UPTIME_MS.store(uptime_ms, Ordering::Relaxed);
    }
}

/// REQ: TIME-002 - Get current tick count
#[inline]
pub fn get_ticks() -> u32 {
    TICK_COUNT.load(Ordering::Acquire)
}

/// REQ: TIME-003 - Get system uptime in milliseconds
#[inline]
pub fn get_uptime_ms() -> u32 {
    UPTIME_MS.load(Ordering::Acquire)
}

/// REQ: TIME-004 - Convert ticks to milliseconds
#[inline]
pub const fn ticks_to_ms(ticks: u32) -> u32 {
    ticks * TICK_PERIOD_MS
}

/// REQ: TIME-004 - Convert milliseconds to ticks
#[inline]
pub const fn ms_to_ticks(ms: u32) -> u32 {
    ms / TICK_PERIOD_MS
}

/// REQ: TIME-009 - Delay for specified number of ticks
/// 
/// Busy-wait delay. In a full RTOS implementation, this would
/// block the task and reschedule.
pub fn delay_ticks(ticks: u32) {
    let start = get_ticks();
    while get_ticks().wrapping_sub(start) < ticks {
        core::hint::spin_loop();
    }
}

/// REQ: TIME-009 - Delay for specified number of milliseconds
pub fn delay_ms(ms: u32) {
    delay_ticks(ms_to_ticks(ms));
}

/// REQ: TIME-008 - Check if time1 is after time2 (handles wrap-around)
#[inline]
pub fn is_after(time1: u32, time2: u32) -> bool {
    time1.wrapping_sub(time2) < (u32::MAX / 2)
}

/// REQ: TIME-008 - Get elapsed ticks since a reference time (handles wrap-around)
#[inline]
pub fn elapsed_ticks(reference: u32) -> u32 {
    get_ticks().wrapping_sub(reference)
}

/// REQ: TIME-005 - Software timer (simplified implementation)
pub struct Timer {
    /// Timer expiration tick
    expiry: AtomicU32,
    /// Timer active flag
    active: portable_atomic::AtomicBool,
}

impl Timer {
    /// Create a new timer
    pub const fn new() -> Self {
        Self {
            expiry: AtomicU32::new(0),
            active: portable_atomic::AtomicBool::new(false),
        }
    }

    /// Start timer with specified tick delay
    pub fn start(&self, delay_ticks: u32) {
        let expiry = get_ticks().wrapping_add(delay_ticks);
        self.expiry.store(expiry, Ordering::Release);
        self.active.store(true, Ordering::Release);
    }

    /// Check if timer has expired
    pub fn is_expired(&self) -> bool {
        if !self.active.load(Ordering::Acquire) {
            return false;
        }

        let expiry = self.expiry.load(Ordering::Acquire);
        is_after(get_ticks(), expiry)
    }

    /// Stop timer
    pub fn stop(&self) {
        self.active.store(false, Ordering::Release);
    }

    /// Check if timer is active
    pub fn is_active(&self) -> bool {
        self.active.load(Ordering::Acquire)
    }
}
