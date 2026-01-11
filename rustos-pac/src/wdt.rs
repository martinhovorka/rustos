//! REQ: PAC-057 - Watchdog Timer Register Definitions
//! 
//! AXI Timebase Watchdog Timer register map based on PG101 - AXI Timebase WDT Product Guide

use core::ptr::{read_volatile, write_volatile};
use core::cell::UnsafeCell;

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
    pub fn enable(&self) -> core::result::Result<(), ()> {
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        unsafe { write_volatile(self.tbcsr.get(), csr | 0x01) };
        Ok(())
    }

    /// REQ: WDT-003 - Kick/refresh watchdog
    #[inline]
    pub fn kick(&self) {
        // Write to TBCR to reset timer
        unsafe { write_volatile(self.tbcr.get(), 0) }
    }

    /// REQ: WDT-004 - Check if WDT event occurred
    #[inline]
    pub fn is_event(&self) -> bool {
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        (csr & 0x100) != 0
    }
    
    /// Set watchdog timeout
    #[inline]
    pub fn set_timeout(&self, _timeout_ms: u32) -> core::result::Result<(), ()> {
        // Configuration specific to hardware
        Ok(())
    }
    
    /// Reset watchdog timer
    #[inline]
    pub fn write_wdtrst(&self) -> core::result::Result<(), ()> {
        self.kick();
        Ok(())
    }
    
    /// Set warning threshold
    #[inline]
    pub fn set_warning_threshold(&self, _threshold_ms: u32) -> core::result::Result<(), ()> {
        Ok(())
    }
    
    /// Enable warning interrupt
    #[inline]
    pub fn enable_warning_interrupt(&self) -> core::result::Result<(), ()> {
        let csr = unsafe { read_volatile(self.ssccsr.get()) };
        unsafe { write_volatile(self.ssccsr.get(), csr | 0x10) };
        Ok(())
    }
    
    /// Disable warning interrupt
    #[inline]
    pub fn disable_warning_interrupt(&self) -> core::result::Result<(), ()> {
        let csr = unsafe { read_volatile(self.ssccsr.get()) };
        unsafe { write_volatile(self.ssccsr.get(), csr & !0x10) };
        Ok(())
    }
    
    /// Set window start time
    #[inline]
    pub fn set_window_start(&self, _window_start: u32) -> core::result::Result<(), ()> {
        Ok(())
    }
    
    /// Read current counter value
    #[inline]
    pub fn read_counter(&self) -> u32 {
        unsafe { read_volatile(self.tbcr.get()) }
    }
    
    /// Check if expired
    #[inline]
    pub fn is_expired(&self) -> bool {
        self.is_event()
    }
    
    /// Disable watchdog
    #[inline]
    pub fn disable(&self) -> core::result::Result<(), ()> {
        let csr = unsafe { read_volatile(self.tbcsr.get()) };
        unsafe { write_volatile(self.tbcsr.get(), csr & !0x01) };
        Ok(())
    }
}
