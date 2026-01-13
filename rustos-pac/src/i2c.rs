//! REQ: PAC-053 - I2C Register Definitions
//!
//! AXI IIC register map based on PG046 - AXI IIC Bus Interface Product Guide

use core::cell::UnsafeCell;
use core::ptr::{read_volatile, write_volatile};

/// REQ: PAC-054 - I2C register block
#[repr(C)]
pub struct I2c {
    /// Global Interrupt Enable Register (offset 0x1C)
    _reserved0: [u32; 7],
    gier: UnsafeCell<u32>,
    /// Interrupt Status Register (offset 0x20)
    isr: UnsafeCell<u32>,
    /// Interrupt Enable Register (offset 0x28)
    _reserved1: UnsafeCell<u32>,
    ier: u32,
    /// Soft Reset Register (offset 0x40)
    _reserved2: [u32; 5],
    softr: UnsafeCell<u32>,
    /// Control Register (offset 0x100)
    _reserved3: [u32; 47],
    cr: UnsafeCell<u32>,
    /// Status Register (offset 0x104)
    sr: UnsafeCell<u32>,
    /// TX FIFO (offset 0x108)
    tx_fifo: UnsafeCell<u32>,
    /// RX FIFO (offset 0x10C)
    rx_fifo: UnsafeCell<u32>,
    /// Address Register (offset 0x110)
    adr: UnsafeCell<u32>,
    /// TX FIFO Occupancy (offset 0x114)
    tx_fifo_ocr: UnsafeCell<u32>,
    /// RX FIFO Occupancy (offset 0x118)
    rx_fifo_ocr: UnsafeCell<u32>,
}

impl I2c {
    /// REQ: I2C-002 - Software reset
    #[inline]
    pub fn reset(&self) {
        // SAFETY: Writing to memory-mapped I2C soft reset register.
        unsafe { write_volatile(self.softr.get(), 0x0A) }
    }

    /// REQ: I2C-003 - Enable I2C controller
    #[inline]
    pub fn enable(&self) {
        // SAFETY: Reading from memory-mapped I2C control register.
        let cr = unsafe { read_volatile(self.cr.get()) };
        // SAFETY: Writing to memory-mapped I2C control register to enable.
        unsafe { write_volatile(self.cr.get(), cr | 0x01) }
    }

    /// REQ: I2C-004 - Check if bus is busy
    #[inline]
    pub fn is_busy(&self) -> bool {
        // SAFETY: Reading from memory-mapped I2C status register.
        let sr = unsafe { read_volatile(self.sr.get()) };
        (sr & 0x04) != 0
    }

    /// REQ: I2C-005 - Check if TX FIFO is empty
    #[inline]
    pub fn is_tx_empty(&self) -> bool {
        // SAFETY: Reading from memory-mapped I2C status register.
        let sr = unsafe { read_volatile(self.sr.get()) };
        (sr & 0x80) != 0
    }

    /// Read status register
    #[inline]
    pub fn read_status(&self) -> u32 {
        // SAFETY: Reading from memory-mapped I2C status register.
        unsafe { read_volatile(self.sr.get()) }
    }

    /// Write to TX FIFO
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn write_tx_fifo(&self, value: u32) -> core::result::Result<(), ()> {
        // Check if TX FIFO is full
        // SAFETY: Reading from memory-mapped I2C TX FIFO occupancy register.
        let ocr = unsafe { read_volatile(self.tx_fifo_ocr.get()) };
        if ocr >= 16 {
            return Err(());
        }
        // SAFETY: Writing to memory-mapped I2C TX FIFO register.
        unsafe { write_volatile(self.tx_fifo.get(), value) };
        Ok(())
    }

    /// Read from RX FIFO
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn read_rx_fifo(&self) -> core::result::Result<u32, ()> {
        // Check if RX FIFO is empty
        // SAFETY: Reading from memory-mapped I2C RX FIFO occupancy register.
        let ocr = unsafe { read_volatile(self.rx_fifo_ocr.get()) };
        if ocr == 0 {
            return Err(());
        }
        // SAFETY: Reading from memory-mapped I2C RX FIFO register.
        Ok(unsafe { read_volatile(self.rx_fifo.get()) })
    }

    /// Software reset
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn soft_reset(&self) -> core::result::Result<(), ()> {
        self.reset();
        Ok(())
    }

    /// Set clock divisor
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn set_clock_divisor(&self, _divisor: u32) -> core::result::Result<(), ()> {
        // Configuration would be done through control register
        Ok(())
    }
}
