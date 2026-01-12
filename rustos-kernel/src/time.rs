//! REQ: TIME-001 - Time Management
//! 
//! System tick, timers, and time tracking functionality.
//!
//! # Overview
//!
//! The time module provides:
//! - System tick counter (1ms resolution, 1000 Hz)
//! - Software timers (one-shot and periodic)
//! - Timer callbacks (with `timers` feature)
//! - Delay functions
//! - Time conversion utilities
//!
//! # System Tick
//!
//! The system tick runs at 1000 Hz (1ms period) and is used for:
//! - Task preemption
//! - Software timer expiration
//! - Timeout handling
//!
//! # Example: Delays
//!
//! ```no_run
//! use rustos_kernel::time::{delay_ms, delay_ticks};
//!
//! // Delay for 100 milliseconds
//! delay_ms(100);
//!
//! // Delay for 50 ticks (50ms at 1kHz tick rate)
//! delay_ticks(50);
//! ```
//!
//! # Example: Software Timers
//!
//! ```no_run
//! use rustos_kernel::time::Timer;
//!
//! static TIMER: Timer = Timer::new();
//!
//! // Start a 500ms one-shot timer
//! TIMER.start(500);
//!
//! // Check if expired
//! if TIMER.is_expired() {
//!     // Timer has expired
//! }
//! ```
//!
//! # Example: Periodic Timer with Callback
//!
//! ```no_run
//! # #[cfg(feature = "timers")]
//! # {
//! use rustos_kernel::time::CallbackTimer;
//!
//! fn on_timer() {
//!     // Called every 1000ms
//! }
//!
//! let mut timer = CallbackTimer::new();
//! timer.start_periodic_with_callback(1000, on_timer);
//!
//! loop {
//!     timer.poll(); // Check and invoke callback if expired
//! }
//! # }
//! ```

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

/// REQ: TIME-005, TIME-006 - Software timer with callback support
pub struct Timer {
    /// Timer expiration tick
    expiry: AtomicU32,
    /// Timer active flag
    active: portable_atomic::AtomicBool,
    /// Timer mode (one-shot or periodic)
    #[cfg(feature = "timers")]
    periodic: portable_atomic::AtomicBool,
    /// Period for periodic timers (in ticks)
    #[cfg(feature = "timers")]
    period: AtomicU32,
}

impl Timer {
    /// Create a new timer
    pub const fn new() -> Self {
        Self {
            expiry: AtomicU32::new(0),
            active: portable_atomic::AtomicBool::new(false),
            #[cfg(feature = "timers")]
            periodic: portable_atomic::AtomicBool::new(false),
            #[cfg(feature = "timers")]
            period: AtomicU32::new(0),
        }
    }

    /// REQ: TIME-005 - Start one-shot timer with specified tick delay
    pub fn start(&self, delay_ticks: u32) {
        let expiry = get_ticks().wrapping_add(delay_ticks);
        self.expiry.store(expiry, Ordering::Release);
        self.active.store(true, Ordering::Release);
        #[cfg(feature = "timers")]
        self.periodic.store(false, Ordering::Release);
    }

    /// REQ: TIME-005 - Start periodic timer
    #[cfg(feature = "timers")]
    pub fn start_periodic(&self, period_ticks: u32) {
        self.period.store(period_ticks, Ordering::Release);
        let expiry = get_ticks().wrapping_add(period_ticks);
        self.expiry.store(expiry, Ordering::Release);
        self.periodic.store(true, Ordering::Release);
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

    /// REQ: TIME-005 - Reset timer for periodic mode
    /// 
    /// Call this after is_expired() returns true for periodic timers.
    /// Returns true if timer was reset, false if not periodic/active.
    #[cfg(feature = "timers")]
    pub fn reset(&self) -> bool {
        if !self.periodic.load(Ordering::Acquire) || !self.active.load(Ordering::Acquire) {
            return false;
        }

        let period = self.period.load(Ordering::Acquire);
        let new_expiry = self.expiry.load(Ordering::Acquire).wrapping_add(period);
        self.expiry.store(new_expiry, Ordering::Release);
        true
    }

    /// Stop timer
    pub fn stop(&self) {
        self.active.store(false, Ordering::Release);
    }

    /// Check if timer is active
    pub fn is_active(&self) -> bool {
        self.active.load(Ordering::Acquire)
    }

    /// REQ: TIME-005 - Check if timer is periodic
    #[cfg(feature = "timers")]
    pub fn is_periodic(&self) -> bool {
        self.periodic.load(Ordering::Acquire)
    }
}

/// REQ: TIME-006 - Timer callback function type
#[cfg(feature = "timers")]
pub type TimerCallback = fn();

/// REQ: TIME-006 - Timer with callback support
#[cfg(feature = "timers")]
pub struct CallbackTimer {
    /// Base timer functionality
    timer: Timer,
    /// Callback function
    callback: Option<TimerCallback>,
}

#[cfg(feature = "timers")]
impl CallbackTimer {
    /// Create a new callback timer
    pub const fn new() -> Self {
        Self {
            timer: Timer::new(),
            callback: None,
        }
    }

    /// REQ: TIME-006 - Start one-shot timer with callback
    pub fn start_with_callback(&mut self, delay_ticks: u32, callback: TimerCallback) {
        self.callback = Some(callback);
        self.timer.start(delay_ticks);
    }

    /// REQ: TIME-006 - Start periodic timer with callback
    pub fn start_periodic_with_callback(&mut self, period_ticks: u32, callback: TimerCallback) {
        self.callback = Some(callback);
        self.timer.start_periodic(period_ticks);
    }

    /// Check if timer has expired and invoke callback if set
    /// 
    /// Returns true if callback was invoked
    pub fn poll(&mut self) -> bool {
        if self.timer.is_expired() {
            if let Some(callback) = self.callback {
                callback();
                
                if self.timer.is_periodic() {
                    self.timer.reset();
                } else {
                    self.callback = None;
                }
                return true;
            }
        }
        false
    }

    /// Stop timer and clear callback
    pub fn stop(&mut self) {
        self.timer.stop();
        self.callback = None;
    }

    /// Check if timer is active
    pub fn is_active(&self) -> bool {
        self.timer.is_active()
    }
}
