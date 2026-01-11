//! REQ: PAC-051 - SPI Register Definitions
//! 
//! AXI Quad SPI register map based on PG153 - AXI Quad SPI Product Guide

use core::ptr::{read_volatile, write_volatile};
use core::cell::UnsafeCell;

/// REQ: PAC-052 - SPI register block
#[repr(C)]
pub struct Spi {
    /// Software Reset Register (offset 0x40)
    _reserved0: [u32; 16],
    srr: UnsafeCell<u32>,
    /// SPI Control Register (offset 0x60)
    _reserved1: [u32; 7],
    cr: UnsafeCell<u32>,
    /// SPI Status Register (offset 0x64)
    sr: UnsafeCell<u32>,
    /// SPI Data Transmit Register (offset 0x68)
    dtr: UnsafeCell<u32>,
    /// SPI Data Receive Register (offset 0x6C)
    drr: UnsafeCell<u32>,
    /// SPI Slave Select Register (offset 0x70)
    ssr: UnsafeCell<u32>,
    /// TX FIFO Occupancy Register (offset 0x74)
    tx_fifo_ocr: UnsafeCell<u32>,
    /// RX FIFO Occupancy Register (offset 0x78)
    rx_fifo_ocr: UnsafeCell<u32>,
}

impl Spi {
    /// REQ: SPI-002 - Software reset
    #[inline]
    pub fn reset(&self) {
        unsafe { write_volatile(self.srr.get(), 0x0A) }
    }

    /// REQ: SPI-003 - Enable SPI controller
    #[inline]
    pub fn enable(&self) {
        let cr = unsafe { read_volatile(self.cr.get()) };
        unsafe { write_volatile(self.cr.get(), cr | 0x02) }
    }

    /// REQ: SPI-004 - Disable SPI controller
    #[inline]
    pub fn disable(&self) {
        let cr = unsafe { read_volatile(self.cr.get()) };
        unsafe { write_volatile(self.cr.get(), cr & !0x02) }
    }

    /// REQ: SPI-005 - Write data to transmit FIFO
    #[inline]
    pub fn write_data(&self, data: u8) {
        unsafe { write_volatile(self.dtr.get(), data as u32) }
    }

    /// REQ: SPI-006 - Read data from receive FIFO
    #[inline]
    pub fn read_data(&self) -> u8 {
        unsafe { read_volatile(self.drr.get()) as u8 }
    }

    /// REQ: SPI-007 - Check if TX FIFO is full
    #[inline]
    pub fn is_tx_full(&self) -> bool {
        let sr = unsafe { read_volatile(self.sr.get()) };
        (sr & 0x08) != 0
    }

    /// REQ: SPI-008 - Check if RX FIFO is empty
    #[inline]
    pub fn is_rx_empty(&self) -> bool {
        let sr = unsafe { read_volatile(self.sr.get()) };
        (sr & 0x01) != 0
    }
}
