//! UART driver for RustOS
//!
//! Provides serial communication interface

use core::fmt;

/// UART peripheral base addresses (example for Arty A7-35)
const UART0_BASE: usize = 0x6000_0000;

/// UART registers
#[repr(C)]
struct UartRegisters {
    data: u32,      // Data register
    status: u32,    // Status register
    control: u32,   // Control register
    baud: u32,      // Baud rate divisor
}

/// UART device
pub struct Uart {
    registers: *mut UartRegisters,
}

impl Uart {
    /// Create a new UART instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut UartRegisters,
        }
    }

    /// Initialize UART with given baud rate
    pub fn init(&mut self, baud_rate: u32) {
        unsafe {
            // Set baud rate divisor (assuming 100MHz clock)
            let divisor = 100_000_000 / baud_rate;
            (*self.registers).baud = divisor;

            // Enable TX and RX
            (*self.registers).control = 0x03;
        }
    }

    /// Write a byte to UART
    pub fn write_byte(&mut self, byte: u8) {
        unsafe {
            // Wait for TX ready
            while ((*self.registers).status & 0x01) == 0 {}

            // Write byte
            (*self.registers).data = byte as u32;
        }
    }

    /// Read a byte from UART (non-blocking)
    pub fn read_byte(&mut self) -> Option<u8> {
        unsafe {
            // Check if data available
            if ((*self.registers).status & 0x02) != 0 {
                Some(((*self.registers).data & 0xFF) as u8)
            } else {
                None
            }
        }
    }

    /// Write a string to UART
    pub fn write_str(&mut self, s: &str) {
        for byte in s.bytes() {
            self.write_byte(byte);
        }
    }
}

unsafe impl Send for Uart {}

/// Global UART0 instance
pub static mut UART0: Uart = unsafe { Uart::new(UART0_BASE) };

/// Implementation of fmt::Write for UART
impl fmt::Write for Uart {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        self.write_str(s);
        Ok(())
    }
}

/// Initialize UART0 with default baud rate
pub fn init_uart0() {
    unsafe {
        UART0.init(115200);
    }
}
