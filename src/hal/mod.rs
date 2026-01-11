//! Hardware Abstraction Layer (HAL)
//!
//! Provides drivers for hardware peripherals on the MicroBlaze V / Arty A7-35

pub mod uart;
pub mod timer;
pub mod gpio;
pub mod spi;
pub mod i2c;
pub mod ethernet;
pub mod interrupt;
pub mod watchdog;

pub use uart::Uart;
pub use timer::Timer;
pub use gpio::Gpio;
pub use spi::Spi;
pub use i2c::I2c;
pub use ethernet::Ethernet;
pub use interrupt::InterruptController;
pub use watchdog::Watchdog;
