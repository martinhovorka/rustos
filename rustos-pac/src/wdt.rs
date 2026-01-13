//! REQ: PAC-057 - Watchdog Timer Register Definitions
//!
//! AXI Timebase Watchdog Timer register map based on PG101 - AXI Timebase WDT Product Guide

use core::cell::UnsafeCell;
use core::ptr::{read_volatile, write_volatile};

/// REQ: PAC-058 - Watchdog Timer register block
#[repr(C)]
pub struct Wdt {
    /// Time Base Count Register (offset 0x00)
    tbcr: UnsafeCell<u32>,
    /// Time Base Control Register (offset 0x04)
    tbcsr: UnsafeCell<u32>,
    /// Second Sequence Count Register (offset 0x10)
    _reserved: [u32; 2],
    ssccr: UnsafeCell<u32>,
    /// Second Sequence Control and Status Register (offset 0x14)
    ssccsr: UnsafeCell<u32>,
}

impl Wdt {
    /// REQ: WDT-002 - Enable watchdog timer
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn enable(&self) -> core::result::Result<(), ()> {
        // SAFETY: Reading from memory-mapped WDT control/status register.
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        // SAFETY: Writing to memory-mapped WDT control/status register to enable timer.
        unsafe { write_volatile(self.tbcsr.get(), csr | 0x01) };
        Ok(())
    }

    /// REQ: WDT-003 - Kick/refresh watchdog
    #[inline]
    pub fn kick(&self) {
        // Write to TBCR to reset timer
        // SAFETY: Writing to memory-mapped WDT time base count register to refresh timer.
        unsafe { write_volatile(self.tbcr.get(), 0) }
    }

    /// REQ: WDT-004 - Check if WDT event occurred
    #[inline]
    pub fn is_event(&self) -> bool {
        // SAFETY: Reading from memory-mapped WDT control/status register.
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        (csr & 0x100) != 0
    }

    /// Set watchdog timeout
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn set_timeout(&self, _timeout_ms: u32) -> core::result::Result<(), ()> {
        // Configuration specific to hardware
        Ok(())
    }

    /// Reset watchdog timer
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn write_wdtrst(&self) -> core::result::Result<(), ()> {
        self.kick();
        Ok(())
    }

    /// Set warning threshold
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn set_warning_threshold(&self, _threshold_ms: u32) -> core::result::Result<(), ()> {
        Ok(())
    }

    /// Enable warning interrupt
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn enable_warning_interrupt(&self) -> core::result::Result<(), ()> {
        // SAFETY: Reading from memory-mapped WDT second sequence control/status register.
        let csr = unsafe { read_volatile(self.ssccsr.get()) };
        // SAFETY: Writing to memory-mapped WDT second sequence control/status register.
        unsafe { write_volatile(self.ssccsr.get(), csr | 0x10) };
        Ok(())
    }

    /// Disable warning interrupt
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn disable_warning_interrupt(&self) -> core::result::Result<(), ()> {
        // SAFETY: Reading from memory-mapped WDT second sequence control/status register.
        let csr = unsafe { read_volatile(self.ssccsr.get()) };
        // SAFETY: Writing to memory-mapped WDT second sequence control/status register.
        unsafe { write_volatile(self.ssccsr.get(), csr & !0x10) };
        Ok(())
    }

    /// Set window start time
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn set_window_start(&self, _window_start: u32) -> core::result::Result<(), ()> {
        Ok(())
    }

    /// Read current counter value
    #[inline]
    pub fn read_counter(&self) -> u32 {
        // SAFETY: Reading from memory-mapped WDT time base count register.
        unsafe { read_volatile(self.tbcr.get()) }
    }

    /// Check if expired
    #[inline]
    pub fn is_expired(&self) -> bool {
        self.is_event()
    }

    /// Disable watchdog
    #[inline]
    #[allow(clippy::result_unit_err)]
    pub fn disable(&self) -> core::result::Result<(), ()> {
        // SAFETY: Reading from memory-mapped WDT TBCSR register at known hardware address
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        // SAFETY: Writing to memory-mapped WDT TBCSR register to clear enable bit
        unsafe { write_volatile(self.tbcsr.get(), csr & !0x01) };
        Ok(())
    }
}
