//! SPI driver for RustOS
//!
//! Provides Serial Peripheral Interface communication

/// SPI peripheral base address
const SPI_BASE: usize = 0x6003_0000;

/// SPI registers
#[repr(C)]
struct SpiRegisters {
    control: u32,       // Control register
    status: u32,        // Status register
    data: u32,          // Data register
    divisor: u32,       // Clock divisor
    slave_select: u32,  // Slave select register
}

/// SPI clock polarity
#[derive(Debug, Clone, Copy)]
pub enum ClockPolarity {
    IdleLow,
    IdleHigh,
}

/// SPI clock phase
#[derive(Debug, Clone, Copy)]
pub enum ClockPhase {
    CaptureFirst,
    CaptureSecond,
}

/// SPI device
pub struct Spi {
    registers: *mut SpiRegisters,
}

impl Spi {
    /// Create a new SPI instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut SpiRegisters,
        }
    }

    /// Initialize SPI
    pub fn init(&mut self, clock_hz: u32, polarity: ClockPolarity, phase: ClockPhase) {
        unsafe {
            // Set clock divisor (assuming 100MHz system clock)
            let divisor = 100_000_000 / clock_hz;
            (*self.registers).divisor = divisor;

            // Set polarity and phase
            let mut control = 0u32;
            if matches!(polarity, ClockPolarity::IdleHigh) {
                control |= 0x01;
            }
            if matches!(phase, ClockPhase::CaptureSecond) {
                control |= 0x02;
            }

            // Enable SPI
            control |= 0x80;
            (*self.registers).control = control;
        }
    }

    /// Transfer data (full duplex)
    pub fn transfer(&mut self, tx_data: &[u8], rx_data: &mut [u8]) {
        let len = core::cmp::min(tx_data.len(), rx_data.len());

        for i in 0..len {
            // Write data
            unsafe {
                (*self.registers).data = tx_data[i] as u32;
            }

            // Wait for transfer complete
            self.wait_ready();

            // Read data
            unsafe {
                rx_data[i] = ((*self.registers).data & 0xFF) as u8;
            }
        }
    }

    /// Write data only
    pub fn write(&mut self, data: &[u8]) {
        for &byte in data {
            unsafe {
                (*self.registers).data = byte as u32;
            }
            self.wait_ready();
        }
    }

    /// Read data only
    pub fn read(&mut self, buffer: &mut [u8]) {
        for byte in buffer.iter_mut() {
            unsafe {
                (*self.registers).data = 0xFF; // Send dummy byte
            }
            self.wait_ready();
            unsafe {
                *byte = ((*self.registers).data & 0xFF) as u8;
            }
        }
    }

    /// Set slave select
    pub fn set_slave_select(&mut self, slave: u8, active: bool) {
        unsafe {
            let mut ss = (*self.registers).slave_select;
            if active {
                ss &= !(1 << slave);
            } else {
                ss |= 1 << slave;
            }
            (*self.registers).slave_select = ss;
        }
    }

    /// Wait for SPI ready
    fn wait_ready(&self) {
        unsafe {
            while ((*self.registers).status & 0x01) != 0 {
                core::hint::spin_loop();
            }
        }
    }
}

unsafe impl Send for Spi {}

/// Global SPI instance
pub static mut SPI: Spi = unsafe { Spi::new(SPI_BASE) };

/// Initialize SPI with default settings
pub fn init_spi() {
    unsafe {
        SPI.init(1_000_000, ClockPolarity::IdleLow, ClockPhase::CaptureFirst);
    }
}
