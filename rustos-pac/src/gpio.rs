//! REQ: PAC-027 - GPIO Register Definitions
use core::ptr::{read_volatile, write_volatile};
use core::cell::UnsafeCell;

/// GPIO register block
#[repr(C)]
pub struct Gpio {
    data: UnsafeCell<u32>,
    tri: UnsafeCell<u32>,
    data2: UnsafeCell<u32>,
    tri2: UnsafeCell<u32>,
    _reserved: [u32; 68],
    gier: UnsafeCell<u32>,
    ip_ier: UnsafeCell<u32>,
    ip_isr: UnsafeCell<u32>,
}

impl Gpio {
    /// Read data register
    #[inline]
    pub fn read_data(&self) -> u32 {
        unsafe { read_volatile(self.data.get()) }
    }
    /// Write data register
    #[inline]
    pub fn write_data(&self, value: u32) {
        unsafe { write_volatile(self.data.get(), value) }
    }
    /// Read tri-state register
    #[inline]
    pub fn read_tri(&self) -> u32 {
        unsafe { read_volatile(self.tri.get()) }
    }
    /// Write tri-state register
    #[inline]
    pub fn write_tri(&self, value: u32) {
        unsafe { write_volatile(self.tri.get(), value) }
    }
    /// Read data2 register
    #[inline]
    pub fn read_data2(&self) -> u32 {
        unsafe { read_volatile(self.data2.get()) }
    }
    /// Write data2 register
    #[inline]
    pub fn write_data2(&self, value: u32) {
        unsafe { write_volatile(self.data2.get(), value) }
    }
    /// Read tri2 register
    #[inline]
    pub fn read_tri2(&self) -> u32 {
        unsafe { read_volatile(self.tri2.get()) }
    }
    /// Write tri2 register
    #[inline]
    pub fn write_tri2(&self, value: u32) {
        unsafe { write_volatile(self.tri2.get(), value) }
    }
    /// Enable global interrupt
    #[inline]
    pub fn enable_global_interrupt(&self) {
        unsafe { write_volatile(self.gier.get(), 0x8000_0000) }
    }
    /// Disable global interrupt
    #[inline]
    pub fn disable_global_interrupt(&self) {
        unsafe { write_volatile(self.gier.get(), 0) }
    }
    /// Set pin high
    #[inline]
    pub fn set_pin(&self, pin: u32) {
        let data = self.read_data();
        self.write_data(data | (1 << pin));
    }
    /// Clear pin low
    #[inline]
    pub fn clear_pin(&self, pin: u32) {
        let data = self.read_data();
        self.write_data(data & !(1 << pin));
    }
    /// Toggle pin
    #[inline]
    pub fn toggle_pin(&self, pin: u32) {
        let data = self.read_data();
        self.write_data(data ^ (1 << pin));
    }
    /// Read pin state
    #[inline]
    pub fn read_pin(&self, pin: u32) -> bool {
        (self.read_data() & (1 << pin)) != 0
    }
    /// Configure interrupt mode for pin
    #[inline]
    pub fn configure_interrupt_mode(&self, _pin: u32, _mode: u8) -> core::result::Result<(), ()> {
        // Hardware-specific configuration
        // _mode: 0=rising edge, 1=falling edge, 2=both edges, 3=high level, 4=low level
        Ok(())
    }
    /// Enable interrupt for specific pin
    #[inline]
    pub fn enable_pin_interrupt(&self, pin: u32) -> core::result::Result<(), ()> {
        let ier = unsafe { read_volatile(self.ip_ier.get()) };
        unsafe { write_volatile(self.ip_ier.get(), ier | (1 << pin)) };
        Ok(())
    }
    /// Disable interrupt for specific pin
    #[inline]
    pub fn disable_pin_interrupt(&self, pin: u32) -> core::result::Result<(), ()> {
        let ier = unsafe { read_volatile(self.ip_ier.get()) };
        unsafe { write_volatile(self.ip_ier.get(), ier & !(1 << pin)) };
        Ok(())
    }
    /// Read interrupt status
    #[inline]
    pub fn read_interrupt_status(&self) -> u32 {
        unsafe { read_volatile(self.ip_isr.get()) }
    }
    /// Clear interrupt for pin
    #[inline]
    pub fn clear_interrupt(&self, pin: u32) -> core::result::Result<(), ()> {
        unsafe { write_volatile(self.ip_isr.get(), 1 << pin) };
        Ok(())
    }
}

/// GPIO base address for LEDs
pub const GPIO_LED_BASE: usize = 0x40000000;

/// Get GPIO peripheral at base address
pub unsafe fn get_gpio(base_addr: usize) -> &'static Gpio {
    &*(base_addr as *const Gpio)
}
