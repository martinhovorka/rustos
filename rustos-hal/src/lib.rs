//! REQ: HAL-001 - Hardware Abstraction Layer for RustOS
//!
//! Provides safe, high-level drivers for all peripherals.
//!
//! # Overview
//!
//! The HAL provides type-safe, memory-safe drivers for all hardware peripherals
//! in the RustOS system. Each driver is feature-gated for minimal binary size.
//!
//! # Available Drivers
//!
//! - **UART** (`uart` feature): Serial communication with TX/RX buffering
//! - **GPIO** (`gpio` feature): General-purpose I/O with interrupt support
//! - **Timer** (`timer` feature): System timer and delay functions
//! - **SPI** (`spi` feature): SPI master mode with configurable clock and mode
//! - **I2C** (`i2c` feature): I2C master with 7-bit/10-bit addressing
//! - **Ethernet** (`ethernet` feature): Ethernet MAC with ARP/ICMP support
//! - **Watchdog** (`wdt` feature): Watchdog timer with window mode and early warning
//! - **Interrupt Controller** (`intc` feature): Central interrupt management
//!
//! # Example: UART
//!
//! ```no_run
//! use rustos_hal::uart::Uart;
//!
//! // SAFETY: Called once during initialization with valid UART base address
//! unsafe {
//!     let uart = Uart::new();
//!     uart.write(b"Hello, World!\r\n").ok();
//! }
//! ```
//!
//! # Example: GPIO
//!
//! ```no_run
//! use rustos_hal::gpio::{GpioPort, PinMode};
//!
//! // SAFETY: Valid GPIO base address, exclusive access guaranteed
//! unsafe {
//!     let gpio = GpioPort::new(0x4020_0000);
//!     gpio.set_pin_mode(0, PinMode::Output);
//!     gpio.set_pin_high(0);
//! }
//! ```
//!
//! # Error Handling
//!
//! All drivers use a common [`HalError`] type with [`Result<T>`] for operations
//! that can fail. Critical errors are propagated to the caller for handling.
//!
//! # Safety
//!
// SAFETY: Documentation section describing safety requirements
//! Driver constructors are marked `unsafe` as they create singleton instances
//! with raw pointer access to hardware. Callers must ensure exclusive access.

#![no_std]
#![deny(missing_docs)]
#![deny(warnings)]

/// REQ: UART-010 - Re-export critical_section for UART print macros
pub use critical_section;

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
