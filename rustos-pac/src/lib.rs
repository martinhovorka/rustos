//! REQ: PAC-001 - Peripheral Access Crate for MicroBlaze V RISC-V
//! 
//! This crate provides type-safe, low-level access to all hardware peripherals
//! on the MicroBlaze V RISC-V processor targeting the Digilent Arty A7-35 board.
//!
//! # Memory Map
//! 
//! REQ: PAC-006 - Memory map derived from hardware/artifacts/address_segments/
//! 
//! - 0x0000_0000 - 0x0001_FFFF: Local BRAM (128 KB)
//! - 0x4000_0000 - 0x4000_FFFF: GPIO Shield Pins 0-19
//! - 0x4001_0000 - 0x4001_FFFF: GPIO Shield Pins 26-41
//! - 0x4002_0000 - 0x4002_FFFF: GPIO Push Buttons
//! - 0x4003_0000 - 0x4003_FFFF: GPIO DIP Switches
//! - 0x4004_0000 - 0x4004_FFFF: GPIO LED 4-bits
//! - 0x4005_0000 - 0x4005_FFFF: GPIO RGB LEDs
//! - 0x4006_0000 - 0x4006_FFFF: GPIO I2C Pullups
//! - 0x4060_0000 - 0x4060_FFFF: AXI UART Lite
//! - 0x4080_0000 - 0x4080_FFFF: AXI IIC (I2C)
//! - 0x40E0_0000 - 0x40E0_FFFF: AXI Ethernet Lite
//! - 0x4120_0000 - 0x4120_FFFF: AXI Interrupt Controller
//! - 0x41A0_0000 - 0x41A0_FFFF: AXI Timebase Watchdog Timer
//! - 0x44A0_0000 - 0x44A0_FFFF: AXI Quad SPI Flash
//! - 0x44A1_0000 - 0x44A1_FFFF: AXI Quad SPI External

#![no_std]
#![deny(missing_docs)]
#![deny(warnings)]

// REQ: PAC-002 - Type-safe register definitions
pub mod uart;
pub mod gpio;
pub mod intc;
pub mod spi;
pub mod i2c;
pub mod ethernet;
pub mod wdt;

// REQ: PAC-003 - Base address constants
/// REQ: PER-001 - AXI UART Lite base address
pub const UART_BASE: usize = 0x4060_0000;

/// REQ: PER-005 - GPIO LED 4-bits base address
pub const GPIO_LED_BASE: usize = 0x4004_0000;

/// REQ: PER-006 - GPIO RGB LEDs base address
pub const GPIO_RGB_BASE: usize = 0x4005_0000;

/// REQ: PER-007 - GPIO Push Buttons base address
pub const GPIO_BUTTONS_BASE: usize = 0x4002_0000;

/// REQ: PER-008 - GPIO DIP Switches base address
pub const GPIO_SWITCHES_BASE: usize = 0x4003_0000;

/// REQ: PER-009 - GPIO Shield Pins 0-19 base address
pub const GPIO_SHIELD_0_19_BASE: usize = 0x4000_0000;

/// REQ: PER-010 - GPIO Shield Pins 26-41 base address
pub const GPIO_SHIELD_26_41_BASE: usize = 0x4001_0000;

/// REQ: PER-011 - GPIO I2C Pullups base address
pub const GPIO_I2C_PULLUPS_BASE: usize = 0x4006_0000;

/// REQ: PER-003 - AXI Interrupt Controller base address
pub const INTC_BASE: usize = 0x4120_0000;

/// REQ: PER-012 - AXI IIC (I2C) base address
pub const I2C_BASE: usize = 0x4080_0000;

/// REQ: PER-013 - AXI Ethernet Lite base address
pub const ETHERNET_BASE: usize = 0x40E0_0000;

/// REQ: PER-014 - AXI Timebase Watchdog Timer base address
pub const WDT_BASE: usize = 0x41A0_0000;

/// REQ: PER-015 - AXI Quad SPI Flash base address
pub const SPI_FLASH_BASE: usize = 0x44A0_0000;

/// REQ: PER-017 - AXI Quad SPI External base address
pub const SPI_EXTERNAL_BASE: usize = 0x44A1_0000;

// REQ: PAC-004 - Peripheral instance creation
/// Returns a reference to the UART peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races with other UART accesses
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn uart() -> &'static uart::Uart {
    // SAFETY: Casting memory-mapped UART base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(UART_BASE as *const uart::Uart)
}

/// Returns a reference to the GPIO LED peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_led() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO LED base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_LED_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO RGB LED peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_rgb() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO RGB base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_RGB_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO Buttons peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_buttons() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO buttons base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_BUTTONS_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO Switches peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_switches() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO switches base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_SWITCHES_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO Shield 0-19 peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_shield_0_19() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO shield base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_SHIELD_0_19_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO Shield 26-41 peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_shield_26_41() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO shield base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_SHIELD_26_41_BASE as *const gpio::Gpio)
}

/// Returns a reference to the GPIO I2C Pullups peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn gpio_i2c_pullups() -> &'static gpio::Gpio {
    // SAFETY: Casting memory-mapped GPIO I2C pullups base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(GPIO_I2C_PULLUPS_BASE as *const gpio::Gpio)
}

/// Returns a reference to the Interrupt Controller peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn intc() -> &'static intc::Intc {
    // SAFETY: Casting memory-mapped interrupt controller base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(INTC_BASE as *const intc::Intc)
}

/// Returns a reference to the I2C peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn i2c() -> &'static i2c::I2c {
    // SAFETY: Casting memory-mapped I2C base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(I2C_BASE as *const i2c::I2c)
}

/// Returns a reference to the Ethernet peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn ethernet() -> &'static ethernet::Ethernet {
    // SAFETY: Casting memory-mapped Ethernet base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(ETHERNET_BASE as *const ethernet::Ethernet)
}

/// Returns a reference to the Watchdog Timer peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn wdt() -> &'static wdt::Wdt {
    // SAFETY: Casting memory-mapped watchdog timer base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(WDT_BASE as *const wdt::Wdt)
}

/// Returns a reference to the SPI Flash peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn spi_flash() -> &'static spi::Spi {
    // SAFETY: Casting memory-mapped SPI flash base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(SPI_FLASH_BASE as *const spi::Spi)
}

/// Returns a reference to the SPI External peripheral
///
/// # Safety
/// REQ: PAC-005 - Caller must ensure no data races
#[inline]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn spi_external() -> &'static spi::Spi {
    // SAFETY: Casting memory-mapped SPI external base address to peripheral reference.
    // Caller ensures exclusive access per function safety contract.
    &*(SPI_EXTERNAL_BASE as *const spi::Spi)
}
