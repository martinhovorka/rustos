//! REQ: HAL-001 - Hardware Abstraction Layer for RustOS
//! 
//! Provides safe, high-level drivers for all peripherals.

#![no_std]
#![deny(missing_docs)]
#![deny(warnings)]

#[cfg(feature = "uart")]
pub mod uart;

#[cfg(feature = "gpio")]
pub mod gpio;

#[cfg(feature = "timer")]
pub mod timer;

#[cfg(feature = "spi")]
pub mod spi;

#[cfg(feature = "i2c")]
pub mod i2c;

#[cfg(feature = "ethernet")]
pub mod ethernet;

#[cfg(feature = "wdt")]
pub mod wdt;

#[cfg(feature = "intc")]
pub mod intc;

/// REQ: HAL-002 - HAL error types
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum HalError {
    /// Operation would block
    WouldBlock,
    /// Buffer is full
    BufferFull,
    /// Buffer is empty
    BufferEmpty,
    /// Invalid parameter
    InvalidParameter,
    /// Hardware error
    HardwareError,
    /// Timeout occurred
    Timeout,
    /// I2C-specific error
    #[cfg(feature = "i2c")]
    I2cError(i2c::I2cError),
}

/// From<()> implementation for HalError
impl From<()> for HalError {
    fn from(_: ()) -> Self {
        HalError::HardwareError
    }
}

/// REQ: API-002 - HAL result type
pub type Result<T> = core::result::Result<T, HalError>;
