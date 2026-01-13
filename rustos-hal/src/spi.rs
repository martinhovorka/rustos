//! SPI Driver
//!
//! REQ: SPI-001 - SPI master mode support
//! REQ: SPI-002 - SPI clock configuration
//! REQ: SPI-003 - SPI data transfer operations
//! REQ: SPI-004 - SPI mode configuration (CPOL/CPHA)
//! REQ: SPI-005 - SPI chip select management
//! REQ: SPI-006 - SPI error handling and recovery
//! REQ: SPI-007 - SPI DMA support (optional)
//! REQ: SPI-008 - SPI status checking
//! REQ: SPI-009 - SPI transfer timeout

use bitflags::bitflags;
use core::ptr::{read_volatile, write_volatile};

bitflags! {
    /// REQ: SPI-002 - SPI control register flags
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub struct SpiControl: u32 {
        /// Loop mode enable
        const LOOP = 1 << 0;
        /// SPI system enable
        const SPE = 1 << 1;
        /// Master mode select
        const MASTER_MODE = 1 << 2;
        /// Clock polarity (CPOL)
        const CPOL = 1 << 3;
        /// Clock phase (CPHA)
        const CPHA = 1 << 4;
        /// TX FIFO reset
        const TXFIFO_RST = 1 << 5;
        /// RX FIFO reset
        const RXFIFO_RST = 1 << 6;
        /// Manual slave select enable
        const MANUAL_SS = 1 << 7;
        /// Master transaction inhibit
        const MTI = 1 << 8;
        /// LSB first
        const LSB_FIRST = 1 << 9;
    }
}

bitflags! {
    /// REQ: SPI-008 - SPI status register flags
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub struct SpiStatus: u32 {
        /// RX FIFO empty
        const RX_EMPTY = 1 << 0;
        /// RX FIFO full
        const RX_FULL = 1 << 1;
        /// TX FIFO empty
        const TX_EMPTY = 1 << 2;
        /// TX FIFO full
        const TX_FULL = 1 << 3;
        /// Mode fault error
        const MODE_FAULT = 1 << 4;
        /// Slave mode select
        const SLAVE_MODE = 1 << 5;
        /// Command error
        const CMD_ERROR = 1 << 6;
        /// SPI busy
        const BUSY = 1 << 7;
        /// TX FIFO overrun
        const TX_OVERRUN = 1 << 8;
        /// RX FIFO underrun
        const RX_UNDERRUN = 1 << 9;
    }
}

/// REQ: SPI-002 - SPI register offsets (AXI Quad SPI)
const CTRL_REG_OFFSET: usize = 0x60;
const STATUS_REG_OFFSET: usize = 0x64;
const DATA_TX_OFFSET: usize = 0x68;
const DATA_RX_OFFSET: usize = 0x6C;
#[allow(dead_code)]
const SLAVE_SELECT_OFFSET: usize = 0x70;

/// REQ: SPI-004 - SPI clock polarity
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ClockPolarity {
    /// Clock idle low
    IdleLow = 0,
    /// Clock idle high
    IdleHigh = 1,
}

/// REQ: SPI-004 - SPI clock phase
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ClockPhase {
    /// Sample on leading edge
    LeadingEdge = 0,
    /// Sample on trailing edge
    TrailingEdge = 1,
}

/// REQ: SPI-004 - SPI mode combining CPOL and CPHA
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SpiMode {
    /// Mode 0: CPOL=0, CPHA=0
    Mode0,
    /// Mode 1: CPOL=0, CPHA=1
    Mode1,
    /// Mode 2: CPOL=1, CPHA=0
    Mode2,
    /// Mode 3: CPOL=1, CPHA=1
    Mode3,
}

impl SpiMode {
    /// Get clock polarity for this mode
    pub const fn polarity(&self) -> ClockPolarity {
        match self {
            Self::Mode0 | Self::Mode1 => ClockPolarity::IdleLow,
            Self::Mode2 | Self::Mode3 => ClockPolarity::IdleHigh,
        }
    }

    /// Get clock phase for this mode
    pub const fn phase(&self) -> ClockPhase {
        match self {
            Self::Mode0 | Self::Mode2 => ClockPhase::LeadingEdge,
            Self::Mode1 | Self::Mode3 => ClockPhase::TrailingEdge,
        }
    }
}

/// REQ: SPI-006 - SPI error types
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SpiError {
    /// Bus is busy
    Busy,
    /// Transmit FIFO overrun
    TxOverrun,
    /// Receive FIFO underrun
    RxUnderrun,
    /// Mode fault (multi-master conflict)
    ModeFault,
    /// Slave mode error
    SlaveError,
    /// Transfer timeout
    Timeout,
    /// Invalid configuration
    InvalidConfig,
}

/// REQ: SPI-001, SPI-003 - SPI driver
pub struct SpiDriver {
    base_addr: usize,
}

impl SpiDriver {
    /// REQ: SPI-001 - Create a new SPI driver instance
    ///
    /// # Safety
    /// base_addr must be a valid SPI peripheral base address
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn new(base_addr: usize) -> Self {
        Self { base_addr }
    }

    /// REQ: SPI-001 - Initialize SPI in master mode
    pub fn init_master(&mut self, mode: SpiMode, clock_div: u8) -> Result<(), SpiError> {
        // REQ: SPI-004 - Configure SPI mode
        let mut ctrl = SpiControl::empty();

        if mode.polarity() == ClockPolarity::IdleHigh {
            ctrl |= SpiControl::CPOL;
        }
        if mode.phase() == ClockPhase::TrailingEdge {
            ctrl |= SpiControl::CPHA;
        }

        // REQ: SPI-001 - Enable master mode
        ctrl |= SpiControl::MASTER_MODE;

        // REQ: SPI-002 - Set clock divider
        ctrl |= SpiControl::from_bits_truncate((clock_div as u32) << 8);

        // Write control register
        // SAFETY: Writing to memory-mapped SPI control register at validated base_addr.
        unsafe {
            write_volatile((self.base_addr + CTRL_REG_OFFSET) as *mut u32, ctrl.bits());
        }

        // REQ: SPI-001 - Enable SPI
        ctrl |= SpiControl::SPE;
        // SAFETY: Writing to memory-mapped SPI control register to enable SPI.
        unsafe {
            write_volatile((self.base_addr + CTRL_REG_OFFSET) as *mut u32, ctrl.bits());
        }

        Ok(())
    }

    /// REQ: SPI-005 - Assert chip select (active low)
    pub fn select(&mut self, cs: u8) {
        // SAFETY: Reading/writing memory-mapped SPI control register for chip select.
        unsafe {
            let mut ctrl = read_volatile((self.base_addr + CTRL_REG_OFFSET) as *const u32);
            // Clear CS bits and set selected CS
            ctrl = (ctrl & !0xF0000) | (((1 << cs) as u32) << 16);
            write_volatile((self.base_addr + CTRL_REG_OFFSET) as *mut u32, ctrl);
        }
    }

    /// REQ: SPI-005 - Deassert chip select
    pub fn deselect(&mut self) {
        // SAFETY: Reading/writing memory-mapped SPI control register to deassert chip select.
        unsafe {
            let mut ctrl = read_volatile((self.base_addr + CTRL_REG_OFFSET) as *const u32);
            ctrl |= 0xF0000; // Deassert all CS lines
            write_volatile((self.base_addr + CTRL_REG_OFFSET) as *mut u32, ctrl);
        }
    }

    /// REQ: SPI-008 - Check if SPI is busy
    pub fn is_busy(&self) -> bool {
        // SAFETY: Reading from memory-mapped SPI status register.
        unsafe {
            let status = read_volatile((self.base_addr + STATUS_REG_OFFSET) as *const u32);
            SpiStatus::from_bits_truncate(status).contains(SpiStatus::BUSY)
        }
    }

    /// REQ: SPI-008 - Check if TX FIFO is full
    pub fn is_tx_full(&self) -> bool {
        // SAFETY: Reading from memory-mapped SPI status register.
        unsafe {
            let status = read_volatile((self.base_addr + STATUS_REG_OFFSET) as *const u32);
            SpiStatus::from_bits_truncate(status).contains(SpiStatus::TX_FULL)
        }
    }

    /// REQ: SPI-008 - Check if RX FIFO is empty
    pub fn is_rx_empty(&self) -> bool {
        // SAFETY: Reading from memory-mapped SPI status register.
        unsafe {
            let status = read_volatile((self.base_addr + STATUS_REG_OFFSET) as *const u32);
            SpiStatus::from_bits_truncate(status).contains(SpiStatus::RX_EMPTY)
        }
    }

    /// REQ: SPI-003 - Write a byte to SPI (blocking)
    pub fn write_byte(&mut self, data: u8) -> Result<(), SpiError> {
        // REQ: SPI-009 - Wait for TX FIFO with timeout
        let mut timeout = 10000;
        while self.is_tx_full() {
            timeout -= 1;
            if timeout == 0 {
                return Err(SpiError::Timeout);
            }
        }

        // SAFETY: Writing to memory-mapped SPI TX data register.
        unsafe {
            write_volatile((self.base_addr + DATA_TX_OFFSET) as *mut u32, data as u32);
        }

        Ok(())
    }

    /// REQ: SPI-003 - Read a byte from SPI (blocking)
    pub fn read_byte(&mut self) -> Result<u8, SpiError> {
        // REQ: SPI-009 - Wait for RX FIFO with timeout
        let mut timeout = 10000;
        while self.is_rx_empty() {
            timeout -= 1;
            if timeout == 0 {
                return Err(SpiError::Timeout);
            }
        }

        // SAFETY: Reading from memory-mapped SPI RX data register.
        unsafe {
            let data = read_volatile((self.base_addr + DATA_RX_OFFSET) as *const u32);
            Ok(data as u8)
        }
    }

    /// REQ: SPI-003 - Transfer a byte (write and read simultaneously)
    pub fn transfer_byte(&mut self, data: u8) -> Result<u8, SpiError> {
        self.write_byte(data)?;

        // Wait for transfer to complete
        let mut timeout = 10000;
        while self.is_busy() {
            timeout -= 1;
            if timeout == 0 {
                return Err(SpiError::Timeout);
            }
        }

        self.read_byte()
    }

    /// REQ: SPI-003 - Transfer multiple bytes
    pub fn transfer(&mut self, data: &mut [u8]) -> Result<(), SpiError> {
        for byte in data.iter_mut() {
            *byte = self.transfer_byte(*byte)?;
        }
        Ok(())
    }

    /// REQ: SPI-003 - Write multiple bytes
    pub fn write(&mut self, data: &[u8]) -> Result<(), SpiError> {
        for &byte in data {
            self.write_byte(byte)?;
        }

        // Wait for transfer to complete
        let mut timeout = 10000;
        while self.is_busy() {
            timeout -= 1;
            if timeout == 0 {
                return Err(SpiError::Timeout);
            }
        }

        Ok(())
    }

    /// REQ: SPI-003 - Read multiple bytes
    pub fn read(&mut self, buffer: &mut [u8]) -> Result<(), SpiError> {
        for byte in buffer.iter_mut() {
            // Write dummy byte to generate clock
            self.write_byte(0xFF)?;
            *byte = self.read_byte()?;
        }
        Ok(())
    }

    /// REQ: SPI-006 - Clear error flags
    pub fn clear_errors(&mut self) {
        // SAFETY: Reading from memory-mapped SPI status register to clear error flags.
        unsafe {
            // Read status to clear error flags
            let _ = read_volatile((self.base_addr + STATUS_REG_OFFSET) as *const u32);
        }
    }

    /// REQ: SPI-006 - Check for errors
    pub fn get_errors(&self) -> Option<SpiError> {
        // SAFETY: Reading from memory-mapped SPI status register to check error flags.
        unsafe {
            let status = SpiStatus::from_bits_truncate(read_volatile(
                (self.base_addr + STATUS_REG_OFFSET) as *const u32,
            ));

            if status.contains(SpiStatus::TX_OVERRUN) {
                Some(SpiError::TxOverrun)
            } else if status.contains(SpiStatus::RX_UNDERRUN) {
                Some(SpiError::RxUnderrun)
            } else if status.contains(SpiStatus::MODE_FAULT) {
                Some(SpiError::ModeFault)
            } else {
                None
            }
        }
    }

    /// REQ: SPI-001 - Disable SPI
    pub fn disable(&mut self) {
        // SAFETY: Reading/writing memory-mapped SPI control register to disable SPI.
        unsafe {
            let mut ctrl = read_volatile((self.base_addr + CTRL_REG_OFFSET) as *const u32);
            ctrl &= !SpiControl::SPE.bits();
            write_volatile((self.base_addr + CTRL_REG_OFFSET) as *mut u32, ctrl);
        }
    }
}

/// REQ: SPI-005 - RAII chip select guard
pub struct SpiTransaction<'a> {
    spi: &'a mut SpiDriver,
}

impl<'a> SpiTransaction<'a> {
    /// Create a new transaction with chip select asserted
    pub fn new(spi: &'a mut SpiDriver, cs: u8) -> Self {
        spi.select(cs);
        Self { spi }
    }

    /// Get mutable reference to SPI for transfers
    pub fn spi(&mut self) -> &mut SpiDriver {
        self.spi
    }
}

impl<'a> Drop for SpiTransaction<'a> {
    /// Automatically deassert chip select when transaction ends
    fn drop(&mut self) {
        self.spi.deselect();
    }
}

// REQ: PER-015 - SPI instance for flash memory
/// Get SPI instance for flash memory
pub fn spi_flash() -> SpiDriver {
    // SAFETY: Creating SPI instance with valid flash SPI base address
    unsafe { SpiDriver::new(rustos_pac::SPI_FLASH_BASE) }
}
