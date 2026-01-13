//! REQ: BOARD-001 - Board Support Package for Digilent Arty A7-35
//!
//! Provides board-specific initialization and trap handling.

#![no_std]
#![no_main]

pub mod startup;
pub mod trap;

/// REQ: BOARD-002 - Board initialization
/// 
/// # Safety
/// Must be called once during system startup
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn init() {
    // SAFETY: This function must only be called once from _start during system reset.
    // It initializes hardware and kernel state that must not be re-initialized.
    // REQ: INIT-006 - Setup trap vector
    trap::init_trap_handler();
    
    // REQ: HAL-001 - Initialize HAL drivers
    rustos_hal::uart::init_console();
    
    // REQ: INT-002 - Initialize interrupt controller
    let intc = rustos_hal::intc::init();
    
    // Register system tick handler (IRQ 0)
    intc.register_handler(0, system_tick_handler).unwrap();
    intc.enable_irq(0);
    
    // Enable master interrupts
    intc.enable_master();
    
    // REQ: KERN-003 - Initialize kernel
    rustos_kernel::init();
}

/// REQ: TIME-001, SCHED-004 - System tick interrupt handler
fn system_tick_handler() {
    // SAFETY: Called from interrupt context with interrupts disabled.
    // tick() and yield_from_isr() are ISR-safe and maintain interrupt state.
    unsafe {
        // REQ: TIME-002 - Increment tick counter
        rustos_kernel::time::tick();
        
        // REQ: SCHED-004 - Perform task scheduling
        rustos_kernel::scheduler::yield_from_isr();
    }
}
