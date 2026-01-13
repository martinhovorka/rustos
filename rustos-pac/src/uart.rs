//! REQ: PAC-007 - UART Register Definitions
//! 
//! AXI UART Lite register map based on PG142 - AXI UART Lite Product Guide
//! 
//! # Register Map
//! 
//! | Offset | Register | Access | Description |
//! |--------|----------|--------|-------------|
//! | 0x00   | RX_FIFO  | R      | Receive FIFO |
//! | 0x04   | TX_FIFO  | W      | Transmit FIFO |
//! | 0x08   | STAT_REG | R      | Status Register |
//! | 0x0C   | CTRL_REG | R/W    | Control Register |

use core::ptr::{read_volatile, write_volatile};
use core::cell::UnsafeCell;

/// REQ: PAC-008 - UART register block  
#[repr(C)]
pub struct Uart {
    /// REQ: PAC-009 - RX FIFO register (offset 0x00)
    rx_fifo: UnsafeCell<u32>,
    /// REQ: PAC-010 - TX FIFO register (offset 0x04)
    tx_fifo: UnsafeCell<u32>,
    /// REQ: PAC-011 - Status register (offset 0x08)
    stat_reg: UnsafeCell<u32>,
    /// REQ: PAC-012 - Control register (offset 0x0C)
    ctrl_reg: UnsafeCell<u32>,
}

impl Uart {
    /// REQ: UART-002 - Read byte from RX FIFO
    ///
    /// # Safety
    /// Must be called with interrupts disabled if used from multiple contexts
    #[inline]
    pub fn read_rx(&self) -> u8 {
        // SAFETY: Reading from memory-mapped UART RX FIFO register.
        // Address is valid for the hardware platform (0x4060_0000 base).
        unsafe { read_volatile(self.rx_fifo.get()) as u8 }
    }

    /// REQ: UART-003 - Write byte to TX FIFO
    ///
    /// # Safety
    /// Must be called with interrupts disabled if used from multiple contexts
    #[inline]
    pub fn write_tx(&self, data: u8) {
        // SAFETY: Writing to memory-mapped UART TX FIFO register.
        // Address is valid for the hardware platform (0x4060_0004 base+offset).
        unsafe { write_volatile(self.tx_fifo.get(), data as u32) }
    }

    /// REQ: UART-004 - Read status register
    #[inline]
    pub fn read_status(&self) -> UartStatus {
        // SAFETY: Reading from memory-mapped UART status register.
        let status = unsafe { read_volatile(self.stat_reg.get()) };
        UartStatus::from_bits_truncate(status)
    }

    /// REQ: UART-005 - Read control register
    #[inline]
    pub fn read_control(&self) -> UartControl {
        // SAFETY: Reading from memory-mapped UART control register.
        let control = unsafe { read_volatile(self.ctrl_reg.get()) };
        UartControl::from_bits_truncate(control)
    }

    /// REQ: UART-006 - Write control register
    ///
    /// # Safety
    /// Must be called with interrupts disabled if used from multiple contexts
    #[inline]
    pub fn write_control(&self, control: UartControl) {
        // SAFETY: Writing to memory-mapped UART control register.
        unsafe { write_volatile(self.ctrl_reg.get(), control.bits()) }
    }

    /// REQ: UART-007 - Check if RX FIFO is valid (has data)
    #[inline]
    pub fn is_rx_valid(&self) -> bool {
        self.read_status().contains(UartStatus::RX_FIFO_VALID_DATA)
    }

    /// REQ: UART-008 - Check if TX FIFO is full
    #[inline]
    pub fn is_tx_full(&self) -> bool {
        self.read_status().contains(UartStatus::TX_FIFO_FULL)
    }

    /// REQ: UART-009 - Check if RX FIFO is empty
    #[inline]
    pub fn is_rx_empty(&self) -> bool {
        self.read_status().contains(UartStatus::RX_FIFO_EMPTY)
    }

    /// REQ: UART-010 - Check if TX FIFO is empty
    #[inline]
    pub fn is_tx_empty(&self) -> bool {
        self.read_status().contains(UartStatus::TX_FIFO_EMPTY)
    }
}

bitflags::bitflags! {
    /// REQ: PAC-013 - UART Status Register bits
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub struct UartStatus: u32 {
        /// REQ: PAC-014 - RX FIFO Valid Data (bit 0)
        const RX_FIFO_VALID_DATA = 1 << 0;
        /// REQ: PAC-015 - RX FIFO Full (bit 1)
        const RX_FIFO_FULL = 1 << 1;
        /// REQ: PAC-016 - TX FIFO Empty (bit 2)
        const TX_FIFO_EMPTY = 1 << 2;
        /// REQ: PAC-017 - TX FIFO Full (bit 3)
        const TX_FIFO_FULL = 1 << 3;
        /// REQ: PAC-018 - Interrupt Enabled (bit 4)
        const INTR_ENABLED = 1 << 4;
        /// REQ: PAC-019 - Overrun Error (bit 5)
        const OVERRUN_ERROR = 1 << 5;
        /// REQ: PAC-020 - Frame Error (bit 6)
        const FRAME_ERROR = 1 << 6;
        /// REQ: PAC-021 - Parity Error (bit 7)
        const PARITY_ERROR = 1 << 7;
        /// REQ: PAC-022 - RX FIFO Empty (bit 8) - undocumented but present
        const RX_FIFO_EMPTY = 1 << 8;
    }
}

bitflags::bitflags! {
    /// REQ: PAC-023 - UART Control Register bits
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub struct UartControl: u32 {
        /// REQ: PAC-024 - Reset TX FIFO (bit 0)
        const RST_TX = 1 << 0;
        /// REQ: PAC-025 - Reset RX FIFO (bit 1)
        const RST_RX = 1 << 1;
        /// REQ: PAC-026 - Enable Interrupts (bit 4)
        const ENABLE_INTR = 1 << 4;
    }
}
