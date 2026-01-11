//! GPIO driver for RustOS
//!
//! Provides General Purpose Input/Output control

/// GPIO peripheral base address
const GPIO_BASE: usize = 0x6002_0000;

/// GPIO registers
#[repr(C)]
struct GpioRegisters {
    data: u32,          // Data register
    direction: u32,     // Direction register (0=input, 1=output)
    interrupt: u32,     // Interrupt enable
}

/// GPIO pin direction
#[derive(Debug, Clone, Copy)]
pub enum Direction {
    Input,
    Output,
}

/// GPIO pin state
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PinState {
    Low,
    High,
}

/// GPIO device
pub struct Gpio {
    registers: *mut GpioRegisters,
}

impl Gpio {
    /// Create a new GPIO instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut GpioRegisters,
        }
    }

    /// Set pin direction
    pub fn set_direction(&mut self, pin: u8, direction: Direction) {
        unsafe {
            let mut dir = (*self.registers).direction;
            match direction {
                Direction::Output => dir |= 1 << pin,
                Direction::Input => dir &= !(1 << pin),
            }
            (*self.registers).direction = dir;
        }
    }

    /// Write to a pin
    pub fn write_pin(&mut self, pin: u8, state: PinState) {
        unsafe {
            let mut data = (*self.registers).data;
            match state {
                PinState::High => data |= 1 << pin,
                PinState::Low => data &= !(1 << pin),
            }
            (*self.registers).data = data;
        }
    }

    /// Read from a pin
    pub fn read_pin(&self, pin: u8) -> PinState {
        unsafe {
            let data = (*self.registers).data;
            if (data & (1 << pin)) != 0 {
                PinState::High
            } else {
                PinState::Low
            }
        }
    }

    /// Toggle a pin
    pub fn toggle_pin(&mut self, pin: u8) {
        unsafe {
            (*self.registers).data ^= 1 << pin;
        }
    }

    /// Enable interrupt for a pin
    pub fn enable_interrupt(&mut self, pin: u8) {
        unsafe {
            (*self.registers).interrupt |= 1 << pin;
        }
    }

    /// Disable interrupt for a pin
    pub fn disable_interrupt(&mut self, pin: u8) {
        unsafe {
            (*self.registers).interrupt &= !(1 << pin);
        }
    }
}

unsafe impl Send for Gpio {}

/// Global GPIO instance
pub static mut GPIO: Gpio = unsafe { Gpio::new(GPIO_BASE) };

/// Initialize GPIO
pub fn init_gpio() {
    // GPIO initialization if needed
}
