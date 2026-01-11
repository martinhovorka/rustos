//! REQ: INIT-001 - Startup and Initialization
//! 
//! Reset vector and early initialization code.

/// REQ: INIT-002, INIT-003, INIT-004, INIT-005 - Startup assembly
/// 
/// Entry point from reset vector. Initializes .bss, .data, sp, and gp.
/// 
/// # Safety
/// Must be called only once at system reset
#[link_section = ".init"]
#[export_name = "_start"]
#[unsafe(naked)]
pub unsafe extern "C" fn _start() -> ! {
    core::arch::naked_asm!(
        // REQ: INIT-017 - Initialize registers
        // (1) Initialize stack pointer
        "la sp, _stack_start",
        
        // (2) Initialize global pointer per RISC-V psABI
        ".option push",
        ".option norelax",
        "la gp, __global_pointer$",
        ".option pop",
        
        // (3) Initialize thread pointer to 0
        "li tp, 0",
        
        // (4) Clear argument registers
        "li a0, 0",
        "li a1, 0",
        "li a2, 0",
        "li a3, 0",
        "li a4, 0",
        "li a5, 0",
        "li a6, 0",
        "li a7, 0",
        
        // REQ: INIT-002 - Initialize .bss section to zero
        "la t0, _sbss",        // Start of .bss
        "la t1, _ebss",        // End of .bss
        "1:",
        "bgeu t0, t1, 2f",     // If t0 >= t1, goto 2f
        "sw zero, 0(t0)",      // Store zero
        "addi t0, t0, 4",      // Increment by word
        "j 1b",                // Loop
        "2:",
        
        // REQ: INIT-003 - Initialize .data section
        // For BRAM boot, .data is already in place (LMA == VMA)
        // For flash boot, would need to copy from LMA to VMA here
        
        // Call Rust entry point
        "call rust_entry",
        
        // Should never return, but loop just in case
        "3:",
        "wfi",
        "j 3b",
    )
}

/// REQ: INIT-012, INIT-013 - Rust entry point
/// 
/// # Safety
/// Called from _start assembly. Must not return.
#[no_mangle]
unsafe extern "C" fn rust_entry() -> ! {
    // REQ: BOARD-002 - Initialize board
    crate::init();
    
    // REQ: SCHED-010 - Start scheduler
    rustos_kernel::start()
}
