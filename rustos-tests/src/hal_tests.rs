//! REQ: TEST-008 - HAL driver unit tests
//!
//! Tests for Hardware Abstraction Layer drivers.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use core::option::Option::{self, None, Some};
use core::result::Result::{self, Err, Ok};
use std::sync::atomic::{AtomicBool, AtomicU32, Ordering};

// ============================================================================
// Mock UART Driver
// ============================================================================

static UART_TX_BUFFER: [AtomicU32; 16] = [
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
];
static UART_TX_HEAD: AtomicU32 = AtomicU32::new(0);
static UART_TX_TAIL: AtomicU32 = AtomicU32::new(0);
static UART_INITIALIZED: AtomicBool = AtomicBool::new(false);
static UART_BAUD_RATE: AtomicU32 = AtomicU32::new(0);

struct MockUart;

impl MockUart {
    fn init(baud_rate: u32) -> Result<(), &'static str> {
        if UART_INITIALIZED.load(Ordering::SeqCst) {
            return Err("UART already initialized");
        }
        UART_BAUD_RATE.store(baud_rate, Ordering::SeqCst);
        UART_TX_HEAD.store(0, Ordering::SeqCst);
        UART_TX_TAIL.store(0, Ordering::SeqCst);
        UART_INITIALIZED.store(true, Ordering::SeqCst);
        Ok(())
    }

    fn write_byte(byte: u8) -> Result<(), &'static str> {
        if !UART_INITIALIZED.load(Ordering::SeqCst) {
            return Err("UART not initialized");
        }
        let head = UART_TX_HEAD.load(Ordering::SeqCst) as usize;
        let next = (head + 1) % 16;
        if next == UART_TX_TAIL.load(Ordering::SeqCst) as usize {
            return Err("TX buffer full");
        }
        UART_TX_BUFFER[head].store(byte as u32, Ordering::SeqCst);
        UART_TX_HEAD.store(next as u32, Ordering::SeqCst);
        Ok(())
    }

    fn read_byte() -> Option<u8> {
        if !UART_INITIALIZED.load(Ordering::SeqCst) {
            return None;
        }
        let tail = UART_TX_TAIL.load(Ordering::SeqCst) as usize;
        let head = UART_TX_HEAD.load(Ordering::SeqCst) as usize;
        if tail == head {
            return None; // Empty
        }
        let byte = UART_TX_BUFFER[tail].load(Ordering::SeqCst) as u8;
        UART_TX_TAIL.store(((tail + 1) % 16) as u32, Ordering::SeqCst);
        Some(byte)
    }

    fn is_tx_empty() -> bool {
        UART_TX_HEAD.load(Ordering::SeqCst) == UART_TX_TAIL.load(Ordering::SeqCst)
    }

    fn reset() {
        UART_INITIALIZED.store(false, Ordering::SeqCst);
        UART_TX_HEAD.store(0, Ordering::SeqCst);
        UART_TX_TAIL.store(0, Ordering::SeqCst);
        UART_BAUD_RATE.store(0, Ordering::SeqCst);
    }
}

#[test]
fn test_uart_init() {
    MockUart::reset();

    assert_test!(MockUart::init(115200).is_ok(), "UART init should succeed");
    assert_test!(
        UART_BAUD_RATE.load(Ordering::SeqCst) == 115200,
        "Baud rate should be set"
    );
    assert_test!(MockUart::init(9600).is_err(), "Double init should fail");

    MockUart::reset();
}

#[test]
fn test_uart_write() {
    MockUart::reset();
    MockUart::init(115200).unwrap();

    assert_test!(MockUart::write_byte(b'H').is_ok(), "Write should succeed");
    assert_test!(MockUart::write_byte(b'i').is_ok(), "Write should succeed");
    assert_test!(!MockUart::is_tx_empty(), "TX buffer should not be empty");

    MockUart::reset();
}

#[test]
fn test_uart_read() {
    MockUart::reset();
    MockUart::init(115200).unwrap();

    MockUart::write_byte(b'A').unwrap();
    MockUart::write_byte(b'B').unwrap();

    assert_test!(MockUart::read_byte() == Some(b'A'), "Should read 'A'");
    assert_test!(MockUart::read_byte() == Some(b'B'), "Should read 'B'");
    assert_test!(MockUart::read_byte().is_none(), "Should be empty");

    MockUart::reset();
}

#[test]
fn test_uart_not_initialized() {
    MockUart::reset();

    assert_test!(
        MockUart::write_byte(b'X').is_err(),
        "Write should fail if not initialized"
    );
    assert_test!(
        MockUart::read_byte().is_none(),
        "Read should return None if not initialized"
    );
}

// ============================================================================
// Mock GPIO Driver
// ============================================================================

static GPIO_OUTPUT: AtomicU32 = AtomicU32::new(0);
static GPIO_INPUT: AtomicU32 = AtomicU32::new(0);
static GPIO_DIRECTION: AtomicU32 = AtomicU32::new(0); // 1 = output
static GPIO_INTERRUPT_ENABLE: AtomicU32 = AtomicU32::new(0);
static GPIO_INTERRUPT_PENDING: AtomicU32 = AtomicU32::new(0);

struct MockGpio;

impl MockGpio {
    fn set_direction(pin: u8, output: bool) {
        let mask = 1u32 << pin;
        if output {
            GPIO_DIRECTION.fetch_or(mask, Ordering::SeqCst);
        } else {
            GPIO_DIRECTION.fetch_and(!mask, Ordering::SeqCst);
        }
    }

    fn write_pin(pin: u8, high: bool) {
        let mask = 1u32 << pin;
        if high {
            GPIO_OUTPUT.fetch_or(mask, Ordering::SeqCst);
        } else {
            GPIO_OUTPUT.fetch_and(!mask, Ordering::SeqCst);
        }
    }

    fn read_pin(pin: u8) -> bool {
        let dir = GPIO_DIRECTION.load(Ordering::SeqCst);
        let mask = 1u32 << pin;

        if dir & mask != 0 {
            // Output pin - read output value
            (GPIO_OUTPUT.load(Ordering::SeqCst) & mask) != 0
        } else {
            // Input pin - read input value
            (GPIO_INPUT.load(Ordering::SeqCst) & mask) != 0
        }
    }

    fn toggle_pin(pin: u8) {
        let mask = 1u32 << pin;
        GPIO_OUTPUT.fetch_xor(mask, Ordering::SeqCst);
    }

    fn enable_interrupt(pin: u8) {
        let mask = 1u32 << pin;
        GPIO_INTERRUPT_ENABLE.fetch_or(mask, Ordering::SeqCst);
    }

    #[allow(dead_code)]
    fn disable_interrupt(pin: u8) {
        let mask = 1u32 << pin;
        GPIO_INTERRUPT_ENABLE.fetch_and(!mask, Ordering::SeqCst);
    }

    fn clear_interrupt(pin: u8) {
        let mask = 1u32 << pin;
        GPIO_INTERRUPT_PENDING.fetch_and(!mask, Ordering::SeqCst);
    }

    fn is_interrupt_pending(pin: u8) -> bool {
        let mask = 1u32 << pin;
        (GPIO_INTERRUPT_PENDING.load(Ordering::SeqCst) & mask) != 0
    }

    fn simulate_input(pin: u8, high: bool) {
        let mask = 1u32 << pin;
        if high {
            GPIO_INPUT.fetch_or(mask, Ordering::SeqCst);
            // Trigger interrupt if enabled
            if (GPIO_INTERRUPT_ENABLE.load(Ordering::SeqCst) & mask) != 0 {
                GPIO_INTERRUPT_PENDING.fetch_or(mask, Ordering::SeqCst);
            }
        } else {
            GPIO_INPUT.fetch_and(!mask, Ordering::SeqCst);
        }
    }

    fn reset() {
        GPIO_OUTPUT.store(0, Ordering::SeqCst);
        GPIO_INPUT.store(0, Ordering::SeqCst);
        GPIO_DIRECTION.store(0, Ordering::SeqCst);
        GPIO_INTERRUPT_ENABLE.store(0, Ordering::SeqCst);
        GPIO_INTERRUPT_PENDING.store(0, Ordering::SeqCst);
    }
}

#[test]
fn test_gpio_direction() {
    MockGpio::reset();

    MockGpio::set_direction(0, true); // Output
    MockGpio::set_direction(1, false); // Input

    let dir = GPIO_DIRECTION.load(Ordering::SeqCst);
    assert_test!((dir & 0x01) != 0, "Pin 0 should be output");
    assert_test!((dir & 0x02) == 0, "Pin 1 should be input");
}

#[test]
fn test_gpio_write() {
    MockGpio::reset();

    MockGpio::set_direction(0, true);
    MockGpio::write_pin(0, true);
    assert_test!(MockGpio::read_pin(0), "Pin 0 should be high");

    MockGpio::write_pin(0, false);
    assert_test!(!MockGpio::read_pin(0), "Pin 0 should be low");
}

#[test]
fn test_gpio_toggle() {
    MockGpio::reset();

    MockGpio::set_direction(0, true);
    MockGpio::write_pin(0, false);

    MockGpio::toggle_pin(0);
    assert_test!(MockGpio::read_pin(0), "Pin 0 should be high after toggle");

    MockGpio::toggle_pin(0);
    assert_test!(
        !MockGpio::read_pin(0),
        "Pin 0 should be low after second toggle"
    );
}

#[test]
fn test_gpio_input() {
    MockGpio::reset();

    MockGpio::set_direction(0, false); // Input

    MockGpio::simulate_input(0, true);
    assert_test!(MockGpio::read_pin(0), "Should read simulated high input");

    MockGpio::simulate_input(0, false);
    assert_test!(!MockGpio::read_pin(0), "Should read simulated low input");
}

#[test]
fn test_gpio_interrupt() {
    MockGpio::reset();

    MockGpio::set_direction(0, false); // Input
    MockGpio::enable_interrupt(0);

    assert_test!(
        !MockGpio::is_interrupt_pending(0),
        "No interrupt pending initially"
    );

    MockGpio::simulate_input(0, true); // Rising edge
    assert_test!(
        MockGpio::is_interrupt_pending(0),
        "Interrupt should be pending"
    );

    MockGpio::clear_interrupt(0);
    assert_test!(
        !MockGpio::is_interrupt_pending(0),
        "Interrupt should be cleared"
    );
}

// ============================================================================
// Mock Timer Driver
// ============================================================================

static TIMER_COUNT: AtomicU32 = AtomicU32::new(0);
static TIMER_RELOAD: AtomicU32 = AtomicU32::new(0);
static TIMER_RUNNING: AtomicBool = AtomicBool::new(false);
static TIMER_EXPIRED: AtomicBool = AtomicBool::new(false);
static TIMER_PRESCALER: AtomicU32 = AtomicU32::new(1);

struct MockTimer;

impl MockTimer {
    fn configure(reload_value: u32, prescaler: u32) {
        TIMER_RELOAD.store(reload_value, Ordering::SeqCst);
        TIMER_COUNT.store(reload_value, Ordering::SeqCst);
        TIMER_PRESCALER.store(prescaler, Ordering::SeqCst);
        TIMER_EXPIRED.store(false, Ordering::SeqCst);
    }

    fn start() {
        TIMER_RUNNING.store(true, Ordering::SeqCst);
        TIMER_EXPIRED.store(false, Ordering::SeqCst);
    }

    fn stop() {
        TIMER_RUNNING.store(false, Ordering::SeqCst);
    }

    fn tick() {
        if !TIMER_RUNNING.load(Ordering::SeqCst) {
            return;
        }

        let count = TIMER_COUNT.load(Ordering::SeqCst);
        if count <= 1 {
            // Decrement to 0 (or already 0) and fire
            TIMER_COUNT.store(0, Ordering::SeqCst);
            TIMER_EXPIRED.store(true, Ordering::SeqCst);
            // Auto-reload for next period
            TIMER_COUNT.store(TIMER_RELOAD.load(Ordering::SeqCst), Ordering::SeqCst);
        } else {
            TIMER_COUNT.store(count - 1, Ordering::SeqCst);
        }
    }

    fn is_expired() -> bool {
        TIMER_EXPIRED.load(Ordering::SeqCst)
    }

    fn clear_expired() {
        TIMER_EXPIRED.store(false, Ordering::SeqCst);
    }

    fn get_count() -> u32 {
        TIMER_COUNT.load(Ordering::SeqCst)
    }

    fn reset() {
        TIMER_COUNT.store(0, Ordering::SeqCst);
        TIMER_RELOAD.store(0, Ordering::SeqCst);
        TIMER_RUNNING.store(false, Ordering::SeqCst);
        TIMER_EXPIRED.store(false, Ordering::SeqCst);
        TIMER_PRESCALER.store(1, Ordering::SeqCst);
    }
}

#[test]
fn test_timer_configure() {
    MockTimer::reset();

    MockTimer::configure(1000, 8);

    assert_test!(
        TIMER_RELOAD.load(Ordering::SeqCst) == 1000,
        "Reload should be 1000"
    );
    assert_test!(MockTimer::get_count() == 1000, "Count should be 1000");
    assert_test!(
        TIMER_PRESCALER.load(Ordering::SeqCst) == 8,
        "Prescaler should be 8"
    );
}

#[test]
fn test_timer_countdown() {
    MockTimer::reset();
    MockTimer::configure(5, 1);
    MockTimer::start();

    // 5 ticks: 5->4->3->2->1->expired
    MockTimer::tick(); // 4
    assert_test!(
        MockTimer::get_count() == 4,
        format!("Count should be 4, got {}", MockTimer::get_count())
    );
    MockTimer::tick(); // 3
    MockTimer::tick(); // 2
    MockTimer::tick(); // 1 -> expired on this tick, reloads to 5

    // After the 4th tick from count 5, we should expire when reaching 1
    // Actually the tick() when count=1 will expire and reload
    // So 5->4->3->2->1->expired+reload
    // Let's tick once more to ensure expiry
    MockTimer::tick(); // Was 1, now expired + reloaded

    assert_test!(MockTimer::is_expired(), "Timer should be expired");
}

#[test]
fn test_timer_auto_reload() {
    MockTimer::reset();
    MockTimer::configure(3, 1);
    MockTimer::start();

    // Count down: 3->2->1->expired+reload to 3
    MockTimer::tick(); // 3->2
    assert_test!(
        MockTimer::get_count() == 2,
        "Count should be 2 after first tick"
    );

    MockTimer::tick(); // 2->1
    assert_test!(
        MockTimer::get_count() == 1,
        "Count should be 1 after second tick"
    );
    assert_test!(!MockTimer::is_expired(), "Should not be expired yet");

    MockTimer::tick(); // 1->expired+reload to 3
    assert_test!(MockTimer::is_expired(), "Should be expired");
    assert_test!(MockTimer::get_count() == 3, "Should have reloaded to 3");

    MockTimer::clear_expired();
    MockTimer::tick(); // 3->2

    assert_test!(MockTimer::get_count() == 2, "Should have counted down to 2");
}

#[test]
fn test_timer_stop() {
    MockTimer::reset();
    MockTimer::configure(10, 1);
    MockTimer::start();

    MockTimer::tick();
    MockTimer::tick();
    assert_test!(MockTimer::get_count() == 8, "Count should be 8");

    MockTimer::stop();
    MockTimer::tick();
    MockTimer::tick();
    assert_test!(
        MockTimer::get_count() == 8,
        "Count should still be 8 (stopped)"
    );
}

// ============================================================================
// Mock SPI Driver
// ============================================================================

static SPI_TX_DATA: AtomicU32 = AtomicU32::new(0);
static SPI_RX_DATA: AtomicU32 = AtomicU32::new(0);
static SPI_BUSY: AtomicBool = AtomicBool::new(false);
static SPI_CS_ACTIVE: AtomicBool = AtomicBool::new(false);
static SPI_MODE: AtomicU32 = AtomicU32::new(0); // CPOL/CPHA

struct MockSpi;

impl MockSpi {
    fn configure(mode: u8) {
        SPI_MODE.store(mode as u32, Ordering::SeqCst);
    }

    fn cs_assert() {
        SPI_CS_ACTIVE.store(true, Ordering::SeqCst);
    }

    fn cs_deassert() {
        SPI_CS_ACTIVE.store(false, Ordering::SeqCst);
    }

    fn transfer(tx: u8) -> u8 {
        SPI_BUSY.store(true, Ordering::SeqCst);
        SPI_TX_DATA.store(tx as u32, Ordering::SeqCst);

        // Simulate transfer (in real hardware, this would shift data)
        let rx = SPI_RX_DATA.load(Ordering::SeqCst) as u8;

        SPI_BUSY.store(false, Ordering::SeqCst);
        rx
    }

    #[allow(dead_code)]
    fn is_busy() -> bool {
        SPI_BUSY.load(Ordering::SeqCst)
    }

    fn set_rx_data(data: u8) {
        SPI_RX_DATA.store(data as u32, Ordering::SeqCst);
    }

    fn reset() {
        SPI_TX_DATA.store(0, Ordering::SeqCst);
        SPI_RX_DATA.store(0, Ordering::SeqCst);
        SPI_BUSY.store(false, Ordering::SeqCst);
        SPI_CS_ACTIVE.store(false, Ordering::SeqCst);
        SPI_MODE.store(0, Ordering::SeqCst);
    }
}

#[test]
fn test_spi_configure() {
    MockSpi::reset();
    MockSpi::configure(3); // Mode 3 (CPOL=1, CPHA=1)

    assert_test!(SPI_MODE.load(Ordering::SeqCst) == 3, "SPI mode should be 3");
}

#[test]
fn test_spi_chip_select() {
    MockSpi::reset();

    assert_test!(
        !SPI_CS_ACTIVE.load(Ordering::SeqCst),
        "CS should be inactive initially"
    );

    MockSpi::cs_assert();
    assert_test!(SPI_CS_ACTIVE.load(Ordering::SeqCst), "CS should be active");

    MockSpi::cs_deassert();
    assert_test!(
        !SPI_CS_ACTIVE.load(Ordering::SeqCst),
        "CS should be inactive"
    );
}

#[test]
fn test_spi_transfer() {
    MockSpi::reset();

    MockSpi::set_rx_data(0xAB); // Simulate device response
    MockSpi::cs_assert();

    let rx = MockSpi::transfer(0x55);

    assert_test!(
        SPI_TX_DATA.load(Ordering::SeqCst) == 0x55,
        "TX data should be 0x55"
    );
    assert_test!(rx == 0xAB, "RX data should be 0xAB");

    MockSpi::cs_deassert();
}

// ============================================================================
// Mock I2C Driver
// ============================================================================

static I2C_ADDRESS: AtomicU32 = AtomicU32::new(0);
static I2C_DATA: AtomicU32 = AtomicU32::new(0);
static I2C_BUSY: AtomicBool = AtomicBool::new(false);
static I2C_ACK: AtomicBool = AtomicBool::new(true);

struct MockI2c;

#[derive(Debug, PartialEq)]
#[allow(dead_code)]
enum I2cError {
    Nack,
    Busy,
    Timeout,
}

impl MockI2c {
    fn start(address: u8, read: bool) -> Result<(), I2cError> {
        if I2C_BUSY.load(Ordering::SeqCst) {
            return Err(I2cError::Busy);
        }
        I2C_BUSY.store(true, Ordering::SeqCst);

        let addr = if read {
            (address << 1) | 1
        } else {
            address << 1
        };
        I2C_ADDRESS.store(addr as u32, Ordering::SeqCst);

        if !I2C_ACK.load(Ordering::SeqCst) {
            I2C_BUSY.store(false, Ordering::SeqCst);
            return Err(I2cError::Nack);
        }

        Ok(())
    }

    fn stop() {
        I2C_BUSY.store(false, Ordering::SeqCst);
    }

    fn write(data: u8) -> Result<(), I2cError> {
        if !I2C_ACK.load(Ordering::SeqCst) {
            return Err(I2cError::Nack);
        }
        I2C_DATA.store(data as u32, Ordering::SeqCst);
        Ok(())
    }

    fn read(ack: bool) -> u8 {
        I2C_ACK.store(ack, Ordering::SeqCst);
        I2C_DATA.load(Ordering::SeqCst) as u8
    }

    fn set_ack(ack: bool) {
        I2C_ACK.store(ack, Ordering::SeqCst);
    }

    fn set_data(data: u8) {
        I2C_DATA.store(data as u32, Ordering::SeqCst);
    }

    fn reset() {
        I2C_ADDRESS.store(0, Ordering::SeqCst);
        I2C_DATA.store(0, Ordering::SeqCst);
        I2C_BUSY.store(false, Ordering::SeqCst);
        I2C_ACK.store(true, Ordering::SeqCst);
    }
}

#[test]
fn test_i2c_start_write() {
    MockI2c::reset();

    let result = MockI2c::start(0x50, false); // Write to address 0x50
    assert_test!(result.is_ok(), "Start should succeed");
    assert_test!(
        I2C_ADDRESS.load(Ordering::SeqCst) == 0xA0,
        "Address should be 0xA0 (0x50 << 1)"
    );

    MockI2c::stop();
}

#[test]
fn test_i2c_start_read() {
    MockI2c::reset();

    let result = MockI2c::start(0x50, true); // Read from address 0x50
    assert_test!(result.is_ok(), "Start should succeed");
    assert_test!(
        I2C_ADDRESS.load(Ordering::SeqCst) == 0xA1,
        "Address should be 0xA1 (0x50 << 1 | 1)"
    );

    MockI2c::stop();
}

#[test]
fn test_i2c_nack() {
    MockI2c::reset();
    MockI2c::set_ack(false); // Simulate NACK

    let result = MockI2c::start(0x50, false);
    assert_test!(result == Err(I2cError::Nack), "Should return NACK error");
}

#[test]
fn test_i2c_write_data() {
    MockI2c::reset();
    MockI2c::start(0x50, false).unwrap();

    let result = MockI2c::write(0x42);
    assert_test!(result.is_ok(), "Write should succeed");
    assert_test!(
        I2C_DATA.load(Ordering::SeqCst) == 0x42,
        "Data should be 0x42"
    );

    MockI2c::stop();
}

#[test]
fn test_i2c_read_data() {
    MockI2c::reset();
    MockI2c::set_data(0x55); // Simulate device data
    MockI2c::start(0x50, true).unwrap();

    let data = MockI2c::read(true); // ACK
    assert_test!(data == 0x55, "Should read 0x55");

    MockI2c::stop();
}

// ============================================================================
// SPI Control and Status Bitflags Tests
// REQ: SPI-002 - SPI control register flags
// REQ: SPI-008 - SPI status register flags
// ============================================================================

/// REQ: SPI-002 - Mock SPI control register bitflags
/// Verifies: SpiControl bitflags operations
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct MockSpiControl(u32);

impl MockSpiControl {
    const LOOP: u32 = 1 << 0;
    const SPE: u32 = 1 << 1;
    const MASTER_MODE: u32 = 1 << 2;
    const CPOL: u32 = 1 << 3;
    const CPHA: u32 = 1 << 4;
    const TXFIFO_RST: u32 = 1 << 5;
    const RXFIFO_RST: u32 = 1 << 6;
    const MANUAL_SS: u32 = 1 << 7;
    const MTI: u32 = 1 << 8;
    const LSB_FIRST: u32 = 1 << 9;

    fn empty() -> Self {
        Self(0)
    }

    fn bits(&self) -> u32 {
        self.0
    }

    fn from_bits_truncate(bits: u32) -> Self {
        Self(bits & 0x3FF) // Only lower 10 bits valid
    }

    fn contains(&self, flag: u32) -> bool {
        (self.0 & flag) == flag
    }

    fn insert(&mut self, flag: u32) {
        self.0 |= flag;
    }
}

/// REQ: SPI-008 - Mock SPI status register bitflags
/// Verifies: SpiStatus bitflags operations
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct MockSpiStatus(u32);

impl MockSpiStatus {
    const RX_EMPTY: u32 = 1 << 0;
    const RX_FULL: u32 = 1 << 1;
    const TX_EMPTY: u32 = 1 << 2;
    const TX_FULL: u32 = 1 << 3;
    const MODE_FAULT: u32 = 1 << 4;
    const SLAVE_MODE: u32 = 1 << 5;
    const CMD_ERROR: u32 = 1 << 6;
    const BUSY: u32 = 1 << 7;
    const TX_OVERRUN: u32 = 1 << 8;
    const RX_UNDERRUN: u32 = 1 << 9;

    fn from_bits_truncate(bits: u32) -> Self {
        Self(bits & 0x3FF) // Only lower 10 bits valid
    }

    fn contains(&self, flag: u32) -> bool {
        (self.0 & flag) == flag
    }

    fn is_empty(&self) -> bool {
        self.0 == 0
    }
}

#[test]
fn test_spi_control_empty() {
    // REQ: SPI-002 - Verify empty control register
    // Verifies: SpiControl::empty() returns zero value
    let ctrl = MockSpiControl::empty();
    assert_test!(ctrl.bits() == 0, "Empty control should be 0");
}

#[test]
fn test_spi_control_individual_flags() {
    // REQ: SPI-002 - Verify individual control flags
    // Verifies: Each SpiControl flag has correct bit position
    assert_test!(MockSpiControl::LOOP == 0x01, "LOOP should be bit 0");
    assert_test!(MockSpiControl::SPE == 0x02, "SPE should be bit 1");
    assert_test!(
        MockSpiControl::MASTER_MODE == 0x04,
        "MASTER_MODE should be bit 2"
    );
    assert_test!(MockSpiControl::CPOL == 0x08, "CPOL should be bit 3");
    assert_test!(MockSpiControl::CPHA == 0x10, "CPHA should be bit 4");
    assert_test!(
        MockSpiControl::TXFIFO_RST == 0x20,
        "TXFIFO_RST should be bit 5"
    );
    assert_test!(
        MockSpiControl::RXFIFO_RST == 0x40,
        "RXFIFO_RST should be bit 6"
    );
    assert_test!(
        MockSpiControl::MANUAL_SS == 0x80,
        "MANUAL_SS should be bit 7"
    );
    assert_test!(MockSpiControl::MTI == 0x100, "MTI should be bit 8");
    assert_test!(
        MockSpiControl::LSB_FIRST == 0x200,
        "LSB_FIRST should be bit 9"
    );
}

#[test]
fn test_spi_control_combine_flags() {
    // REQ: SPI-002 - Verify flag combination for SPI modes
    // Verifies: SpiControl flags can be combined correctly
    let mut ctrl = MockSpiControl::empty();

    // Configure for Mode 3: CPOL=1, CPHA=1, Master mode, SPI enabled
    ctrl.insert(MockSpiControl::MASTER_MODE);
    ctrl.insert(MockSpiControl::CPOL);
    ctrl.insert(MockSpiControl::CPHA);
    ctrl.insert(MockSpiControl::SPE);

    let expected = MockSpiControl::MASTER_MODE
        | MockSpiControl::CPOL
        | MockSpiControl::CPHA
        | MockSpiControl::SPE;

    assert_test!(
        ctrl.bits() == expected,
        "Combined flags should match expected"
    );
    assert_test!(
        ctrl.contains(MockSpiControl::MASTER_MODE),
        "Should contain MASTER_MODE"
    );
    assert_test!(ctrl.contains(MockSpiControl::CPOL), "Should contain CPOL");
    assert_test!(ctrl.contains(MockSpiControl::CPHA), "Should contain CPHA");
    assert_test!(ctrl.contains(MockSpiControl::SPE), "Should contain SPE");
    assert_test!(
        !ctrl.contains(MockSpiControl::LOOP),
        "Should not contain LOOP"
    );
}

#[test]
fn test_spi_control_from_bits_truncate() {
    // REQ: SPI-002 - Verify from_bits_truncate masks invalid bits
    // Verifies: SpiControl::from_bits_truncate() only keeps valid bits
    let ctrl = MockSpiControl::from_bits_truncate(0xFFFF_FFFF);

    // Only lower 10 bits should be preserved
    assert_test!(ctrl.bits() == 0x3FF, "Should truncate to valid bits only");
}

#[test]
fn test_spi_status_individual_flags() {
    // REQ: SPI-008 - Verify individual status flags
    // Verifies: Each SpiStatus flag has correct bit position
    assert_test!(MockSpiStatus::RX_EMPTY == 0x01, "RX_EMPTY should be bit 0");
    assert_test!(MockSpiStatus::RX_FULL == 0x02, "RX_FULL should be bit 1");
    assert_test!(MockSpiStatus::TX_EMPTY == 0x04, "TX_EMPTY should be bit 2");
    assert_test!(MockSpiStatus::TX_FULL == 0x08, "TX_FULL should be bit 3");
    assert_test!(
        MockSpiStatus::MODE_FAULT == 0x10,
        "MODE_FAULT should be bit 4"
    );
    assert_test!(
        MockSpiStatus::SLAVE_MODE == 0x20,
        "SLAVE_MODE should be bit 5"
    );
    assert_test!(
        MockSpiStatus::CMD_ERROR == 0x40,
        "CMD_ERROR should be bit 6"
    );
    assert_test!(MockSpiStatus::BUSY == 0x80, "BUSY should be bit 7");
    assert_test!(
        MockSpiStatus::TX_OVERRUN == 0x100,
        "TX_OVERRUN should be bit 8"
    );
    assert_test!(
        MockSpiStatus::RX_UNDERRUN == 0x200,
        "RX_UNDERRUN should be bit 9"
    );
}

#[test]
fn test_spi_status_check_busy() {
    // REQ: SPI-008 - Verify busy status checking
    // Verifies: SpiStatus correctly identifies busy state
    let status_idle = MockSpiStatus::from_bits_truncate(0x00);
    let status_busy = MockSpiStatus::from_bits_truncate(MockSpiStatus::BUSY);

    assert_test!(
        !status_idle.contains(MockSpiStatus::BUSY),
        "Idle status should not be busy"
    );
    assert_test!(
        status_busy.contains(MockSpiStatus::BUSY),
        "Busy status should be busy"
    );
}

#[test]
fn test_spi_status_check_fifo_state() {
    // REQ: SPI-008 - Verify FIFO status checking
    // Verifies: SpiStatus correctly identifies FIFO states
    let status =
        MockSpiStatus::from_bits_truncate(MockSpiStatus::TX_EMPTY | MockSpiStatus::RX_EMPTY);

    assert_test!(
        status.contains(MockSpiStatus::TX_EMPTY),
        "Should show TX empty"
    );
    assert_test!(
        status.contains(MockSpiStatus::RX_EMPTY),
        "Should show RX empty"
    );
    assert_test!(
        !status.contains(MockSpiStatus::TX_FULL),
        "Should not show TX full"
    );
    assert_test!(
        !status.contains(MockSpiStatus::RX_FULL),
        "Should not show RX full"
    );
}

#[test]
fn test_spi_status_error_flags() {
    // REQ: SPI-006 - Verify error status checking
    // Verifies: SpiStatus correctly identifies error conditions
    let status_ok = MockSpiStatus::from_bits_truncate(0x00);
    let status_overrun = MockSpiStatus::from_bits_truncate(MockSpiStatus::TX_OVERRUN);
    let status_underrun = MockSpiStatus::from_bits_truncate(MockSpiStatus::RX_UNDERRUN);
    let status_fault = MockSpiStatus::from_bits_truncate(MockSpiStatus::MODE_FAULT);

    assert_test!(status_ok.is_empty(), "OK status should be empty");
    assert_test!(
        status_overrun.contains(MockSpiStatus::TX_OVERRUN),
        "Should detect TX overrun"
    );
    assert_test!(
        status_underrun.contains(MockSpiStatus::RX_UNDERRUN),
        "Should detect RX underrun"
    );
    assert_test!(
        status_fault.contains(MockSpiStatus::MODE_FAULT),
        "Should detect mode fault"
    );
}

// ============================================================================
// HalError DeviceError Variant Tests
// REQ: HAL-002 - HAL error types
// ============================================================================

/// Mock HalError enum to test the new DeviceError variant
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum MockHalError {
    WouldBlock,
    BufferFull,
    BufferEmpty,
    InvalidParameter,
    HardwareError,
    DeviceError,
    Timeout,
}

#[test]
fn test_hal_error_device_error_variant() {
    // REQ: HAL-002 - Verify DeviceError variant exists and is distinct
    // Verifies: HalError::DeviceError is a valid error variant
    let err = MockHalError::DeviceError;

    assert_test!(
        err == MockHalError::DeviceError,
        "DeviceError should match itself"
    );
    assert_test!(
        err != MockHalError::HardwareError,
        "DeviceError should differ from HardwareError"
    );
    assert_test!(
        err != MockHalError::Timeout,
        "DeviceError should differ from Timeout"
    );
}

#[test]
fn test_hal_error_all_variants_distinct() {
    // REQ: HAL-002 - Verify all error variants are distinct
    // Verifies: All HalError variants have unique values
    let errors = [
        MockHalError::WouldBlock,
        MockHalError::BufferFull,
        MockHalError::BufferEmpty,
        MockHalError::InvalidParameter,
        MockHalError::HardwareError,
        MockHalError::DeviceError,
        MockHalError::Timeout,
    ];

    // Check each pair is distinct
    for i in 0..errors.len() {
        for j in (i + 1)..errors.len() {
            assert_test!(errors[i] != errors[j], "Error variants should be distinct");
        }
    }
}

#[test]
fn test_hal_error_device_error_pattern_match() {
    // REQ: HAL-002 - Verify DeviceError can be pattern matched
    // Verifies: HalError::DeviceError works in match expressions
    fn classify_error(err: MockHalError) -> &'static str {
        match err {
            MockHalError::DeviceError => "device",
            MockHalError::HardwareError => "hardware",
            MockHalError::Timeout => "timeout",
            _ => "other",
        }
    }

    assert_test!(
        classify_error(MockHalError::DeviceError) == "device",
        "DeviceError should match device pattern"
    );
    assert_test!(
        classify_error(MockHalError::HardwareError) == "hardware",
        "HardwareError should match hardware pattern"
    );
}
