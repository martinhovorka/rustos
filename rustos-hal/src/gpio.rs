//! REQ: GPIO-001 - GPIO Driver
//!
//! High-level GPIO driver with pin abstraction and interrupt support.

use crate::{HalError, Result};
use rustos_pac::gpio;

/// REQ: GPIO-020 - GPIO pin mode
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PinMode {
    /// Input (high-impedance)
    Input,
    /// Output
    Output,
}

/// REQ: GPIO-007 - Interrupt trigger mode
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum InterruptMode {
    /// REQ: GPIO-008 - Edge-triggered interrupt (rising edge)
    RisingEdge,
    /// REQ: GPIO-008 - Edge-triggered interrupt (falling edge)
    FallingEdge,
    /// REQ: GPIO-008 - Edge-triggered interrupt (both edges)
    BothEdges,
    /// REQ: GPIO-009 - Level-triggered interrupt (high level)
    HighLevel,
    /// REQ: GPIO-009 - Level-triggered interrupt (low level)
    LowLevel,
}

/// REQ: GPIO-001 - GPIO port driver
pub struct GpioPort {
    periph: &'static gpio::Gpio,
}

impl GpioPort {
    /// Create a new GPIO port driver
    ///
    /// # Safety
    /// Must ensure exclusive access to the peripheral
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn new(base_addr: usize) -> Self {
        Self {
            periph: &*(base_addr as *const gpio::Gpio),
        }
    }

    /// REQ: GPIO-021 - Set pin mode
    pub fn set_pin_mode(&self, pin: u32, mode: PinMode) {
        let tri = self.periph.read_tri();
        match mode {
            PinMode::Input => self.periph.write_tri(tri | (1 << pin)),
            PinMode::Output => self.periph.write_tri(tri & !(1 << pin)),
        }
    }

    /// REQ: GPIO-022 - Write pin high
    pub fn set_pin_high(&self, pin: u32) {
        self.periph.set_pin(pin);
    }

    /// REQ: GPIO-023 - Write pin low
    pub fn set_pin_low(&self, pin: u32) {
        self.periph.clear_pin(pin);
    }

    /// REQ: GPIO-024 - Toggle pin
    pub fn toggle_pin(&self, pin: u32) {
        self.periph.toggle_pin(pin);
    }

    /// REQ: GPIO-025 - Read pin state
    pub fn read_pin(&self, pin: u32) -> bool {
        self.periph.read_pin(pin)
    }

    /// REQ: GPIO-026 - Write entire port
    pub fn write_port(&self, value: u32) {
        self.periph.write_data(value);
    }

    /// REQ: GPIO-027 - Read entire port
    pub fn read_port(&self) -> u32 {
        self.periph.read_data()
    }

    /// REQ: GPIO-007 - Enable interrupt for specific pin
    /// REQ: GPIO-008 - Configure edge-triggered interrupts
    /// REQ: GPIO-009 - Configure level-triggered interrupts
    pub fn enable_pin_interrupt(&self, pin: u32, mode: InterruptMode) -> Result<()> {
        if pin >= 32 {
            return Err(HalError::InvalidParameter);
        }

        // REQ: GPIO-008, GPIO-009 - Configure interrupt mode
        let mode_val = match mode {
            InterruptMode::RisingEdge => 0,
            InterruptMode::FallingEdge => 1,
            InterruptMode::BothEdges => 2,
            InterruptMode::HighLevel => 3,
            InterruptMode::LowLevel => 4,
        };
        self.periph.configure_interrupt_mode(pin, mode_val)?;

        // REQ: GPIO-007 - Enable interrupt for this pin
        self.periph.enable_pin_interrupt(pin)?;

        // REQ: GPIO-007 - Enable global GPIO interrupt
        self.periph.enable_global_interrupt();

        Ok(())
    }

    /// REQ: GPIO-010 - Disable interrupt for specific pin
    pub fn disable_pin_interrupt(&self, pin: u32) -> Result<()> {
        if pin >= 32 {
            return Err(HalError::InvalidParameter);
        }

        self.periph.disable_pin_interrupt(pin)?;
        Ok(())
    }

    /// REQ: GPIO-010 - Disable all GPIO interrupts
    pub fn disable_all_interrupts(&self) {
        self.periph.disable_global_interrupt();
    }

    /// REQ: GPIO-007 - Check which pin triggered interrupt
    pub fn get_interrupt_status(&self) -> u32 {
        self.periph.read_interrupt_status()
    }

    /// REQ: GPIO-007 - Clear interrupt flag for pin
    pub fn clear_interrupt(&self, pin: u32) -> Result<()> {
        if pin >= 32 {
            return Err(HalError::InvalidParameter);
        }

        self.periph.clear_interrupt(pin)?;
        Ok(())
    }
}
