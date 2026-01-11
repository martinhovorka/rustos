//! Timer driver for RustOS
//!
//! Provides hardware timer functionality

/// Timer peripheral base address
const TIMER_BASE: usize = 0x6001_0000;

/// Timer registers
#[repr(C)]
struct TimerRegisters {
    control: u32,       // Control register
    status: u32,        // Status register
    load: u32,          // Load value
    counter: u32,       // Current counter value
    prescaler: u32,     // Prescaler value
}

/// Timer device
pub struct Timer {
    registers: *mut TimerRegisters,
}

impl Timer {
    /// Create a new Timer instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut TimerRegisters,
        }
    }

    /// Initialize the timer
    pub fn init(&mut self, frequency_hz: u32) {
        unsafe {
            // Assuming 100MHz system clock
            let load_value = 100_000_000 / frequency_hz;
            (*self.registers).load = load_value;
            (*self.registers).prescaler = 0;
        }
    }

    /// Start the timer
    pub fn start(&mut self) {
        unsafe {
            (*self.registers).control |= 0x01; // Enable timer
        }
    }

    /// Stop the timer
    pub fn stop(&mut self) {
        unsafe {
            (*self.registers).control &= !0x01; // Disable timer
        }
    }

    /// Enable timer interrupt
    pub fn enable_interrupt(&mut self) {
        unsafe {
            (*self.registers).control |= 0x02;
        }
    }

    /// Disable timer interrupt
    pub fn disable_interrupt(&mut self) {
        unsafe {
            (*self.registers).control &= !0x02;
        }
    }

    /// Clear timer interrupt flag
    pub fn clear_interrupt(&mut self) {
        unsafe {
            (*self.registers).status = 0x01;
        }
    }

    /// Get current counter value
    pub fn counter(&self) -> u32 {
        unsafe { (*self.registers).counter }
    }

    /// Check if timer interrupt is pending
    pub fn is_interrupt_pending(&self) -> bool {
        unsafe { ((*self.registers).status & 0x01) != 0 }
    }
}

unsafe impl Send for Timer {}

/// Global system timer instance
pub static mut SYSTEM_TIMER: Timer = unsafe { Timer::new(TIMER_BASE) };

/// Initialize system timer for RTOS tick
pub fn init_system_timer() {
    unsafe {
        SYSTEM_TIMER.init(crate::time::TICK_FREQ_HZ as u32);
        SYSTEM_TIMER.enable_interrupt();
        SYSTEM_TIMER.start();
    }
}
