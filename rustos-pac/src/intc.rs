//! REQ: PAC-038 - Interrupt Controller Register Definitions
//! 
//! AXI Interrupt Controller register map based on PG099 - AXI Interrupt Controller Product Guide
//! 
//! # Register Map
//! 
//! | Offset | Register | Access | Description |
//! |--------|----------|--------|-------------|
//! | 0x00   | ISR      | R/TOW  | Interrupt Status Register |
//! | 0x04   | IPR      | R      | Interrupt Pending Register |
//! | 0x08   | IER      | R/W    | Interrupt Enable Register |
//! | 0x0C   | IAR      | W      | Interrupt Acknowledge Register |
//! | 0x10   | SIE      | W      | Set Interrupt Enable bits |
//! | 0x14   | CIE      | W      | Clear Interrupt Enable bits |
//! | 0x18   | IVR      | R      | Interrupt Vector Register |
//! | 0x1C   | MER      | R/W    | Master Enable Register |
//! | 0x20   | IMR      | R/W    | Interrupt Mode Register |
//! | 0x24   | ILR      | R      | Interrupt Level Register |

use core::ptr::{read_volatile, write_volatile};
use core::cell::UnsafeCell;

/// REQ: PAC-039 - Interrupt Controller register block
#[repr(C)]
pub struct Intc {
    /// REQ: PAC-040 - Interrupt Status Register (offset 0x00)
    isr: UnsafeCell<u32>,
    /// REQ: PAC-041 - Interrupt Pending Register (offset 0x04)
    ipr: UnsafeCell<u32>,
    /// REQ: PAC-042 - Interrupt Enable Register (offset 0x08)
    ier: UnsafeCell<u32>,
    /// REQ: PAC-043 - Interrupt Acknowledge Register (offset 0x0C)
    iar: UnsafeCell<u32>,
    /// REQ: PAC-044 - Set Interrupt Enable (offset 0x10)
    sie: UnsafeCell<u32>,
    /// REQ: PAC-045 - Clear Interrupt Enable (offset 0x14)
    cie: UnsafeCell<u32>,
    /// REQ: PAC-046 - Interrupt Vector Register (offset 0x18)
    ivr: UnsafeCell<u32>,
    /// REQ: PAC-047 - Master Enable Register (offset 0x1C)
    mer: UnsafeCell<u32>,
    /// REQ: PAC-048 - Interrupt Mode Register (offset 0x20)
    imr: UnsafeCell<u32>,
    /// REQ: PAC-049 - Interrupt Level Register (offset 0x24)
    ilr: UnsafeCell<u32>,
}

impl Intc {
    /// REQ: INT-002 - Read Interrupt Status Register
    /// Returns which interrupts are currently active (latched)
    #[inline]
    pub fn read_isr(&self) -> u32 {
        unsafe { read_volatile(self.isr.get()) }
    }

    /// REQ: INT-003 - Clear interrupt status bits (toggle-on-write)
    ///
    /// # Safety
    /// Must be called from interrupt context or with interrupts disabled
    #[inline]
    pub fn clear_isr(&self, bits: u32) {
        unsafe { write_volatile(self.isr.get(), bits) }
    }

    /// REQ: INT-004 - Read Interrupt Pending Register
    /// Returns which enabled interrupts are pending
    #[inline]
    pub fn read_ipr(&self) -> u32 {
        unsafe { read_volatile(self.ipr.get()) }
    }

    /// REQ: INT-005 - Read Interrupt Enable Register
    /// Returns which interrupt sources are enabled
    #[inline]
    pub fn read_ier(&self) -> u32 {
        unsafe { read_volatile(self.ier.get()) }
    }

    /// REQ: INT-006 - Write Interrupt Enable Register
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn write_ier(&self, mask: u32) {
        unsafe { write_volatile(self.ier.get(), mask) }
    }

    /// REQ: INT-007 - Acknowledge interrupt (write to IAR)
    /// 
    /// # Safety
    /// Must be called from interrupt context
    #[inline]
    pub fn acknowledge(&self, bits: u32) {
        unsafe { write_volatile(self.iar.get(), bits) }
    }

    /// REQ: INT-008 - Set interrupt enable bits (write to SIE)
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn set_enable(&self, mask: u32) {
        unsafe { write_volatile(self.sie.get(), mask) }
    }

    /// REQ: INT-009 - Clear interrupt enable bits (write to CIE)
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn clear_enable(&self, mask: u32) {
        unsafe { write_volatile(self.cie.get(), mask) }
    }

    /// REQ: PER-021 - Read Interrupt Vector Register (IVR)
    /// Returns the interrupt ID of the highest priority pending interrupt
    /// in fast interrupt mode
    #[inline]
    pub fn read_ivr(&self) -> u32 {
        unsafe { read_volatile(self.ivr.get()) }
    }

    /// REQ: INT-010 - Enable master interrupt enable
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn enable_master(&self) {
        unsafe { write_volatile(self.mer.get(), 0x3) }
    }

    /// REQ: INT-011 - Disable master interrupt enable
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn disable_master(&self) {
        unsafe { write_volatile(self.mer.get(), 0x0) }
    }

    /// REQ: INT-012 - Read master enable register
    #[inline]
    pub fn read_mer(&self) -> u32 {
        unsafe { read_volatile(self.mer.get()) }
    }

    /// REQ: INT-013 - Check if a specific IRQ is pending
    #[inline]
    pub fn is_pending(&self, irq: u32) -> bool {
        (self.read_ipr() & (1 << irq)) != 0
    }

    /// REQ: INT-014 - Check if a specific IRQ is enabled
    #[inline]
    pub fn is_enabled(&self, irq: u32) -> bool {
        (self.read_ier() & (1 << irq)) != 0
    }

    /// REQ: INT-015 - Enable a specific interrupt source
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn enable_irq(&self, irq: u32) {
        self.set_enable(1 << irq);
    }

    /// REQ: INT-016 - Disable a specific interrupt source
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    #[inline]
    pub fn disable_irq(&self, irq: u32) {
        self.clear_enable(1 << irq);
    }
}

/// REQ: PAC-050 - IRQ numbers based on hardware configuration
#[repr(u32)]
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum IrqNumber {
    /// REQ: PER-019 - Fixed Interval Timer (1 ms system tick)
    SystemTick = 0,
    /// REQ: PER-014 - Watchdog Timer
    WatchdogTimer = 1,
    /// REQ: PER-001 - UART Lite
    Uart = 2,
    /// REQ: PER-015 - Quad SPI Flash
    SpiFlash = 3,
    /// REQ: PER-009 - GPIO Shield 0-19
    GpioShield0 = 4,
    /// REQ: PER-010 - GPIO Shield 26-41
    GpioShield1 = 5,
    /// REQ: PER-007 - GPIO Push Buttons
    GpioButtons = 6,
    /// REQ: PER-008 - GPIO DIP Switches
    GpioSwitches = 7,
    /// REQ: PER-013 - Ethernet Lite
    Ethernet = 8,
    /// REQ: PER-017 - Quad SPI External
    SpiExternal = 9,
    /// REQ: PER-012 - I2C
    I2c = 10,
}
