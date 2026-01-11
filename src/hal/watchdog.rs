//! Watchdog timer for RustOS
//!
//! Provides system watchdog functionality

/// Watchdog peripheral base address
const WATCHDOG_BASE: usize = 0x6007_0000;

/// Watchdog registers
#[repr(C)]
struct WatchdogRegisters {
    control: u32,       // Control register
    reload: u32,        // Reload value
    counter: u32,       // Current counter value
    status: u32,        // Status register
}

/// Watchdog device
pub struct Watchdog {
    registers: *mut WatchdogRegisters,
}

impl Watchdog {
    /// Create a new Watchdog instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut WatchdogRegisters,
        }
    }

    /// Initialize the watchdog with timeout in milliseconds
    pub fn init(&mut self, timeout_ms: u32) {
        unsafe {
            // Assuming 100MHz clock and prescaler of 1000
            // This gives us 100kHz watchdog clock
            let reload_value = (timeout_ms * 100_000) / 1000;
            (*self.registers).reload = reload_value;
        }
    }

    /// Start the watchdog
    pub fn start(&mut self) {
        unsafe {
            (*self.registers).control |= 0x01;
        }
    }

    /// Stop the watchdog
    pub fn stop(&mut self) {
        unsafe {
            (*self.registers).control &= !0x01;
        }
    }

    /// Feed the watchdog (reset counter)
    pub fn feed(&mut self) {
        unsafe {
            // Write magic value to reload counter
            (*self.registers).counter = 0xABCD_1234;
        }
    }

    /// Enable watchdog reset
    pub fn enable_reset(&mut self) {
        unsafe {
            (*self.registers).control |= 0x02;
        }
    }

    /// Disable watchdog reset
    pub fn disable_reset(&mut self) {
        unsafe {
            (*self.registers).control &= !0x02;
        }
    }

    /// Enable watchdog interrupt
    pub fn enable_interrupt(&mut self) {
        unsafe {
            (*self.registers).control |= 0x04;
        }
    }

    /// Disable watchdog interrupt
    pub fn disable_interrupt(&mut self) {
        unsafe {
            (*self.registers).control &= !0x04;
        }
    }

    /// Check if watchdog has triggered
    pub fn has_triggered(&self) -> bool {
        unsafe { ((*self.registers).status & 0x01) != 0 }
    }

    /// Clear watchdog trigger flag
    pub fn clear_trigger(&mut self) {
        unsafe {
            (*self.registers).status = 0x01;
        }
    }

    /// Get current counter value
    pub fn counter(&self) -> u32 {
        unsafe { (*self.registers).counter }
    }
}

unsafe impl Send for Watchdog {}

/// Global watchdog instance
pub static mut WATCHDOG: Watchdog = unsafe { Watchdog::new(WATCHDOG_BASE) };

/// Initialize watchdog with default timeout
pub fn init_watchdog() {
    unsafe {
        WATCHDOG.init(5000); // 5 second timeout
        WATCHDOG.enable_reset();
    }
}

/// Feed the global watchdog
pub fn feed_watchdog() {
    unsafe {
        WATCHDOG.feed();
    }
}
