//! REQ: TRAP-001 - Trap and Interrupt Handling
//! 
//! RISC-V trap handler for exceptions and interrupts.

use core::arch::asm;

/// REQ: INIT-006, INIT-016 - Initialize trap handler
/// 
/// Sets up mtvec to point to our trap handler in direct mode.
///
/// # Safety
/// Must be called during initialization before enabling interrupts. Only call once.
// SAFETY: Function signature - privileged operation, see inline SAFETY comments
pub unsafe fn init_trap_handler() {
    // SAFETY: Writing to mtvec CSR is privileged operation.
    // trap_handler address is valid and properly aligned.
    extern "C" {
        fn _trap_handler();
    }
    
    let trap_addr = _trap_handler as usize;
    
    // REQ: INIT-016 - Set mtvec to direct mode (MODE=0)
    // SAFETY: Writing mtvec with valid handler address in machine mode.
    // Handler is properly aligned (.trap section ensures alignment).
    asm!(
        "csrw mtvec, {addr}",
        addr = in(reg) trap_addr,
        options(nostack)
    );
}

/// REQ: TRAP-002, ISR-001 - Main trap handler
/// 
/// Handles all exceptions and interrupts.
/// 
/// # Safety
/// Must preserve all registers and return via mret
#[link_section = ".trap"]
#[export_name = "_trap_handler"]
// SAFETY: Naked function - see # Safety documentation and inline comments
#[unsafe(naked)]
pub unsafe extern "C" fn trap_handler() -> ! {
    // SAFETY: Naked function with naked_asm - no prologue/epilogue.
    // Manually manages all registers and stack. Returns via mret.
    // Must preserve ABI and trap handler calling conventions.
    core::arch::naked_asm!(
        // Save context (simplified - full implementation in kernel context.rs)
        "addi sp, sp, -16",
        "sw ra, 0(sp)",
        "sw t0, 4(sp)",
        "sw t1, 8(sp)",
        "sw t2, 12(sp)",
        
        // Read mcause to determine trap type
        "csrr t0, mcause",
        
        // Check if interrupt (MSB set)
        "bltz t0, 1f",
        
        // Exception handling
        "call handle_exception",
        "j 2f",
        
        // Interrupt handling
        "1:",
        "call handle_interrupt",
        
        // Restore context
        "2:",
        "lw ra, 0(sp)",
        "lw t0, 4(sp)",
        "lw t1, 8(sp)",
        "lw t2, 12(sp)",
        "addi sp, sp, 16",
        
        // Return from trap
        "mret",
    )
}

/// REQ: EXC-002, EXC-003 - Handle exceptions
/// 
/// # Safety
/// Called from trap handler
#[no_mangle]
// SAFETY: Function signature - called from trap_handler assembly context
unsafe extern "C" fn handle_exception() {
    let mcause: usize;
    let mepc: usize;
    let mtval: usize;
    
    // SAFETY: Reading CSRs in exception handler context.
    // Values are diagnostic only, no side effects.
    asm!(
        "csrr {}, mcause",
        "csrr {}, mepc",
        "csrr {}, mtval",
        out(reg) mcause,
        out(reg) mepc,
        out(reg) mtval,
    );
    
    // REQ: PAN-001, ERR-001 - Panic on exception
    panic!("Exception: mcause={:#x}, mepc={:#x}, mtval={:#x}", mcause, mepc, mtval);
}

/// REQ: ISR-002 - Handle interrupts
/// 
/// # Safety
/// Called from trap handler
#[no_mangle]
// SAFETY: Function signature - called from trap_handler assembly context
unsafe extern "C" fn handle_interrupt() {
    // REQ: INT-008 - Dispatch to interrupt controller
    if let Some(intc) = rustos_hal::intc::get() {
        intc.handle_interrupt();
    }
}
