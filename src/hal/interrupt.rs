//! Interrupt controller for RustOS
//!
//! Provides interrupt management for RISC-V

/// Interrupt controller base address
const INTC_BASE: usize = 0x6006_0000;

/// Interrupt controller registers
#[repr(C)]
struct IntcRegisters {
    enable: u32,        // Interrupt enable register
    pending: u32,       // Interrupt pending register
    priority: [u32; 32], // Priority registers for each interrupt
    threshold: u32,     // Priority threshold
}

/// Interrupt ID
pub type InterruptId = u8;

/// Interrupt controller
pub struct InterruptController {
    registers: *mut IntcRegisters,
}

impl InterruptController {
    /// Create a new interrupt controller instance
    ///
    /// # Safety
    /// This function is unsafe because it creates a raw pointer to hardware registers
    pub const unsafe fn new(base_addr: usize) -> Self {
        Self {
            registers: base_addr as *mut IntcRegisters,
        }
    }

    /// Initialize the interrupt controller
    pub fn init(&mut self) {
        unsafe {
            // Disable all interrupts initially
            (*self.registers).enable = 0;

            // Clear all pending interrupts
            (*self.registers).pending = 0xFFFFFFFF;

            // Set default priorities
            for i in 0..32 {
                (*self.registers).priority[i] = 0;
            }

            // Set threshold to minimum (allow all interrupts)
            (*self.registers).threshold = 0;
        }
    }

    /// Enable an interrupt
    pub fn enable_interrupt(&mut self, id: InterruptId) {
        unsafe {
            (*self.registers).enable |= 1 << id;
        }
    }

    /// Disable an interrupt
    pub fn disable_interrupt(&mut self, id: InterruptId) {
        unsafe {
            (*self.registers).enable &= !(1 << id);
        }
    }

    /// Set interrupt priority
    pub fn set_priority(&mut self, id: InterruptId, priority: u8) {
        unsafe {
            if (id as usize) < 32 {
                (*self.registers).priority[id as usize] = priority as u32;
            }
        }
    }

    /// Get pending interrupts
    pub fn get_pending(&self) -> u32 {
        unsafe { (*self.registers).pending }
    }

    /// Clear pending interrupt
    pub fn clear_pending(&mut self, id: InterruptId) {
        unsafe {
            (*self.registers).pending = 1 << id;
        }
    }

    /// Set priority threshold
    pub fn set_threshold(&mut self, threshold: u8) {
        unsafe {
            (*self.registers).threshold = threshold as u32;
        }
    }

    /// Get highest priority pending interrupt
    pub fn get_active_interrupt(&self) -> Option<InterruptId> {
        let pending = self.get_pending();
        if pending == 0 {
            return None;
        }

        // Find highest priority pending interrupt
        for id in 0..32 {
            if (pending & (1 << id)) != 0 {
                return Some(id);
            }
        }

        None
    }
}

unsafe impl Send for InterruptController {}

/// Global interrupt controller instance
pub static mut INTC: InterruptController = unsafe { InterruptController::new(INTC_BASE) };

/// Interrupt IDs for common peripherals
pub mod interrupts {
    use super::InterruptId;

    pub const TIMER: InterruptId = 0;
    pub const UART0: InterruptId = 1;
    pub const GPIO: InterruptId = 2;
    pub const SPI: InterruptId = 3;
    pub const I2C: InterruptId = 4;
    pub const ETHERNET: InterruptId = 5;
}

/// Initialize interrupt controller
pub fn init_intc() {
    unsafe {
        INTC.init();
    }
}

/// Enable global interrupts (RISC-V mstatus.MIE)
pub fn enable_global_interrupts() {
    unsafe {
        riscv::interrupt::enable();
    }
}

/// Disable global interrupts
pub fn disable_global_interrupts() {
    riscv::interrupt::disable();
}
