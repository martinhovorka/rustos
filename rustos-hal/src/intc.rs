//! REQ: INT-001 - Interrupt Controller Driver
//! 
//! High-level interrupt controller management.

use rustos_pac::{intc, INTC_BASE};
use crate::{HalError, Result};

/// Maximum number of interrupt handlers
const MAX_HANDLERS: usize = 11;

/// Interrupt handler function type
pub type InterruptHandler = fn();

/// REQ: INT-001 - Interrupt controller driver
pub struct InterruptController {
    periph: &'static intc::Intc,
    handlers: [Option<InterruptHandler>; MAX_HANDLERS],
}

impl InterruptController {
    /// REQ: INT-002 - Initialize interrupt controller
    /// 
    /// # Safety
    /// Must be called only once during system initialization
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn new() -> Self {
        let periph = &*(INTC_BASE as *const intc::Intc);
        
        // Disable all interrupts initially
        periph.write_ier(0);
        periph.disable_master();
        
        Self {
            periph,
            handlers: [None; MAX_HANDLERS],
        }
    }

    /// REQ: INT-003 - Register interrupt handler
    pub fn register_handler(&mut self, irq: u32, handler: InterruptHandler) -> Result<()> {
        if irq >= MAX_HANDLERS as u32 {
            return Err(HalError::InvalidParameter);
        }
        
        self.handlers[irq as usize] = Some(handler);
        Ok(())
    }

    /// REQ: INT-004 - Enable interrupt
    pub fn enable_irq(&self, irq: u32) {
        self.periph.enable_irq(irq);
    }

    /// REQ: INT-005 - Disable interrupt
    pub fn disable_irq(&self, irq: u32) {
        self.periph.disable_irq(irq);
    }

    /// REQ: INT-006 - Enable master interrupt
    pub fn enable_master(&self) {
        self.periph.enable_master();
    }

    /// REQ: INT-007 - Disable master interrupt
    pub fn disable_master(&self) {
        self.periph.disable_master();
    }

    /// REQ: INT-008 - Handle interrupt (called from trap handler)
    /// 
    /// # Safety
    /// Must be called from interrupt context
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn handle_interrupt(&self) {
        // Read IVR to get interrupt ID
        let irq = self.periph.read_ivr();
        
        // Call registered handler
        if (irq as usize) < MAX_HANDLERS {
            if let Some(handler) = self.handlers[irq as usize] {
                handler();
            }
        }
        
        // Acknowledge interrupt
        self.periph.acknowledge(1 << irq);
    }
}

// Global interrupt controller instance
static mut INTC: Option<InterruptController> = None;

/// REQ: INT-009 - Initialize global interrupt controller
/// 
/// # Safety
/// Must be called only once during system initialization
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn init() -> &'static mut InterruptController {
    INTC = Some(InterruptController::new());
    // SAFETY: Returning mutable reference to static INTC just initialized above.
    // Called once during init per function safety contract.
    (*core::ptr::addr_of_mut!(INTC)).as_mut().unwrap()
}

/// Get reference to interrupt controller
pub fn get() -> Option<&'static InterruptController> {
    // SAFETY: Reading static INTC initialized by init().
    // Returns immutable reference, safe for concurrent read access.
    unsafe { (*core::ptr::addr_of!(INTC)).as_ref() }
}
