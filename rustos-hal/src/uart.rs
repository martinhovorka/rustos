//! REQ: UART-001 - UART Driver
//!
//! High-level UART driver with buffering and formatting support.

use crate::{HalError, Result};
use core::cell::RefCell;
use core::fmt;
use critical_section::Mutex;
use heapless::Deque;
use rustos_pac::{uart, UART_BASE};

/// REQ: UART-013 - TX buffer size (64 bytes)
const TX_BUFFER_SIZE: usize = 64;
/// REQ: UART-014 - RX buffer size (64 bytes)
const RX_BUFFER_SIZE: usize = 64;

/// REQ: UART-001 - UART driver with buffering
pub struct Uart {
    /// Peripheral access
    periph: &'static uart::Uart,
    /// REQ: UART-013 - Transmit buffer
    tx_buffer: Mutex<RefCell<Deque<u8, TX_BUFFER_SIZE>>>,
    /// REQ: UART-014 - Receive buffer
    rx_buffer: Mutex<RefCell<Deque<u8, RX_BUFFER_SIZE>>>,
}

impl Uart {
    /// REQ: UART-001 - Initialize UART driver
    ///
    /// # Safety
    /// Must be called only once for each UART instance
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn new() -> Self {
        // SAFETY: Casting UART base address to peripheral reference.
        // Caller ensures this is called only once per UART instance (singleton pattern).
        let periph = &*(UART_BASE as *const uart::Uart);

        // REQ: UART-002 - Reset FIFOs
        periph.write_control(uart::UartControl::RST_TX | uart::UartControl::RST_RX);

        // REQ: UART-011 - Enable interrupts
        periph.write_control(uart::UartControl::ENABLE_INTR);

        Self {
            periph,
            tx_buffer: Mutex::new(RefCell::new(Deque::new())),
            rx_buffer: Mutex::new(RefCell::new(Deque::new())),
        }
    }

    /// REQ: UART-003 - Write single byte (non-blocking)
    pub fn try_write_byte(&self, byte: u8) -> Result<()> {
        critical_section::with(|cs| {
            let mut tx_buf = self.tx_buffer.borrow_ref_mut(cs);

            // Try to send directly if TX FIFO has space
            if !self.periph.is_tx_full() {
                self.periph.write_tx(byte);
                Ok(())
            } else if !tx_buf.is_full() {
                // Buffer it
                tx_buf.push_back(byte).map_err(|_| HalError::BufferFull)
            } else {
                Err(HalError::BufferFull)
            }
        })
    }

    /// REQ: UART-004 - Write multiple bytes
    pub fn write(&self, data: &[u8]) -> Result<usize> {
        let mut count = 0;
        for &byte in data {
            self.try_write_byte(byte)?;
            count += 1;
        }
        Ok(count)
    }

    /// REQ: UART-005 - Read single byte (non-blocking)
    pub fn try_read_byte(&self) -> Result<u8> {
        critical_section::with(|cs| {
            let mut rx_buf = self.rx_buffer.borrow_ref_mut(cs);

            // Check buffered data first
            if let Some(byte) = rx_buf.pop_front() {
                return Ok(byte);
            }

            // Check hardware FIFO
            if self.periph.is_rx_valid() {
                Ok(self.periph.read_rx())
            } else {
                Err(HalError::WouldBlock)
            }
        })
    }

    /// REQ: UART-006 - Read multiple bytes
    pub fn read(&self, buffer: &mut [u8]) -> Result<usize> {
        let mut count = 0;
        for byte in buffer.iter_mut() {
            match self.try_read_byte() {
                Ok(b) => {
                    *byte = b;
                    count += 1;
                }
                Err(HalError::WouldBlock) => break,
                Err(e) => return Err(e),
            }
        }
        if count > 0 {
            Ok(count)
        } else {
            Err(HalError::WouldBlock)
        }
    }

    /// REQ: UART-012 - Handle TX interrupt (flush buffer to FIFO)
    ///
    /// # Safety
    /// Must be called from UART ISR
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn handle_tx_interrupt(&self) {
        critical_section::with(|cs| {
            let mut tx_buf = self.tx_buffer.borrow_ref_mut(cs);

            // Transfer buffered bytes to HW FIFO
            while !self.periph.is_tx_full() {
                if let Some(byte) = tx_buf.pop_front() {
                    self.periph.write_tx(byte);
                } else {
                    break;
                }
            }
        });
    }

    /// REQ: UART-012 - Handle RX interrupt (read FIFO to buffer)
    ///
    /// # Safety
    /// Must be called from UART ISR
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn handle_rx_interrupt(&self) {
        critical_section::with(|cs| {
            let mut rx_buf = self.rx_buffer.borrow_ref_mut(cs);

            // Transfer bytes from HW FIFO to buffer
            while self.periph.is_rx_valid() && !rx_buf.is_full() {
                let byte = self.periph.read_rx();
                let _ = rx_buf.push_back(byte);
            }
        });
    }

    /// Check if TX is ready
    pub fn is_tx_ready(&self) -> bool {
        !self.periph.is_tx_full()
    }

    /// Check if RX has data available
    pub fn is_rx_available(&self) -> bool {
        critical_section::with(|cs| {
            !self.rx_buffer.borrow_ref(cs).is_empty() || self.periph.is_rx_valid()
        })
    }
}

/// REQ: UART-007 - Implement Write trait for print! support
impl fmt::Write for Uart {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        self.write(s.as_bytes()).map_err(|_| fmt::Error)?;
        Ok(())
    }
}

// Global UART instance for print! macros
static mut CONSOLE: Option<Uart> = None;

/// REQ: UART-008 - Initialize console UART
///
/// # Safety
/// Must be called only once during system initialization
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn init_console() {
    CONSOLE = Some(Uart::new());
}

/// REQ: UART-009 - Get console UART reference
pub fn console() -> Option<&'static Uart> {
    // SAFETY: Reading static CONSOLE initialized by init_console().
    // Returns immutable reference, safe for concurrent read access.
    unsafe { (*core::ptr::addr_of!(CONSOLE)).as_ref() }
}

/// REQ: UART-009 - Get mutable console UART reference
///
/// # Safety
/// Must only be used for the global console singleton. Callers must ensure this is not used
/// concurrently from multiple contexts unless they also provide external serialization.
/// In panic context (interrupts disabled), this is safe to use for diagnostic output.
// SAFETY: Function signature - caller must enforce singleton & exclusivity contract.
pub unsafe fn console_mut() -> Option<&'static mut Uart> {
    // SAFETY: Accessing a `static mut` singleton. Caller ensures no concurrent mutable borrows.
    unsafe { (*core::ptr::addr_of_mut!(CONSOLE)).as_mut() }
}

/// REQ: UART-010 - Print to console
#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => {
        $crate::critical_section::with(|_| {
            if let Some(uart) = unsafe { $crate::uart::console_mut() } {
                use core::fmt::Write;
                let _ = write!(uart, $($arg)*);
            }
        });
    };
}

/// REQ: UART-010 - Print line to console
#[macro_export]
macro_rules! println {
    () => { $crate::print!("\r\n") };
    ($($arg:tt)*) => {
        $crate::print!("{}\r\n", format_args!($($arg)*))
    };
}
