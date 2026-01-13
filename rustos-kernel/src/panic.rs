//! REQ: PAN-001 - Panic Handler
//! 
//! Enhanced panic handler with diagnostic output for RustOS.

#![allow(unused_imports)]

use core::panic::PanicInfo;
use core::sync::atomic::{AtomicBool, Ordering};
use core::fmt::Write;

/// Track if we're already in panic to prevent recursive panics
static PANICKING: AtomicBool = AtomicBool::new(false);

/// REQ: PAN-001, PAN-002, PAN-003, PAN-004, PAN-006 - Panic handler
#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    // REQ: PAN-002 - Disable interrupts immediately
    // SAFETY: Disabling interrupts via CSR manipulation in panic handler.
    // This is a critical safety operation to prevent nested interrupts during panic.
    unsafe {
        core::arch::asm!("csrci mstatus, 0x8"); // Clear MIE bit
    }
    
    // Prevent recursive panics
    if PANICKING.swap(true, Ordering::SeqCst) {
        // Already panicking, just halt
        loop {
            // SAFETY: WFI instruction - safe to use in halt loop.
            unsafe { core::arch::asm!("wfi") };
        }
    }
    
    // REQ: PAN-003 - Output panic location and message
    #[cfg(debug_assertions)]
    {
        // SAFETY: Getting UART reference for panic output. Panics are terminal,
        // so normal UART exclusivity rules don't apply.
        if let Some(uart) = unsafe { get_uart() } {
            use core::fmt::Write;
            let _ = writeln!(uart, "\n\n*** PANIC ***");
            
            if let Some(location) = info.location() {
                let _ = writeln!(uart, "Location: {}:{}:{}", 
                    location.file(), 
                    location.line(), 
                    location.column()
                );
            }
            
            let _ = writeln!(uart, "Message: {}", info.message());
            
            // REQ: PAN-004 - Register dump
            dump_registers(uart);
            
            // REQ: PAN-009 - Check for stack overflow
            check_stack_overflow(uart);
            
            let _ = writeln!(uart, "\nSystem halted.\n");
        }
    }
    
    #[cfg(not(debug_assertions))]
    {
        // REQ: PAN-008 - Abbreviated output in release builds
        // SAFETY: Getting UART reference for panic output. Panics are terminal,
        // so normal UART exclusivity rules don't apply.
        if let Some(uart) = unsafe { get_uart() } {
            use core::fmt::Write;
            let _ = writeln!(uart, "\n*** PANIC ***");
            if let Some(location) = info.location() {
                let _ = writeln!(uart, "{}:{}", location.file(), location.line());
            }
        }
    }
    
    // REQ: PAN-005 - Blink LEDs in panic pattern
    #[cfg(feature = "panic-led")]
    {
        blink_panic_pattern();
    }
    
    // REQ: PAN-007 - Optional watchdog reset
    #[cfg(feature = "panic-reset")]
    {
        trigger_watchdog_reset();
    }
    
    // REQ: PAN-006 - Infinite loop
    loop {
        // SAFETY: WFI instruction - safe to use in final halt loop.
        unsafe {
            core::arch::asm!("wfi");
        }
    }
}

/// REQ: PAN-004 - Dump CPU registers for debugging
#[cfg(debug_assertions)]
fn dump_registers(uart: &mut (impl core::fmt::Write + ?Sized)) {
    let sp: usize;
    let ra: usize;
    let gp: usize;
    let tp: usize;
    
    // SAFETY: Reading general-purpose registers for diagnostic output.
    // This is safe in panic handler context.
    unsafe {
        core::arch::asm!("mv {}, sp", out(reg) sp);
        core::arch::asm!("mv {}, ra", out(reg) ra);
        core::arch::asm!("mv {}, gp", out(reg) gp);
        core::arch::asm!("mv {}, tp", out(reg) tp);
    }
    
    let _ = writeln!(uart, "\nRegister Dump:");
    let _ = writeln!(uart, "  SP: 0x{:08x}", sp);
    let _ = writeln!(uart, "  RA: 0x{:08x}", ra);
    let _ = writeln!(uart, "  GP: 0x{:08x}", gp);
    let _ = writeln!(uart, "  TP: 0x{:08x}", tp);
    
    // Read CSRs
    let mepc: usize;
    let mcause: usize;
    let mtval: usize;
    
    // SAFETY: Reading CSRs for exception diagnostics in panic handler.
    unsafe {
        core::arch::asm!("csrr {}, mepc", out(reg) mepc);
        core::arch::asm!("csrr {}, mcause", out(reg) mcause);
        core::arch::asm!("csrr {}, mtval", out(reg) mtval);
    }
    
    let _ = writeln!(uart, "  mepc:   0x{:08x}", mepc);
    let _ = writeln!(uart, "  mcause: 0x{:08x}", mcause);
    let _ = writeln!(uart, "  mtval:  0x{:08x}", mtval);
}

/// REQ: PAN-009 - Check for stack overflow
#[cfg(debug_assertions)]
fn check_stack_overflow(uart: &mut (impl core::fmt::Write + ?Sized)) {
    // This would check task stack canaries
    // For now, just a placeholder
    let _ = writeln!(uart, "\nStack Check: (not implemented yet)");
}

/// REQ: PAN-005 - Blink LEDs in panic pattern
#[cfg(feature = "panic-led")]
fn blink_panic_pattern() {
    // Fast blink pattern: 3 short, pause, repeat
    // Would need GPIO access - placeholder for now
}

/// REQ: PAN-007 - Trigger watchdog reset
#[cfg(feature = "panic-reset")]
fn trigger_watchdog_reset() {
    // Enable and wait for watchdog to trigger reset
    // Placeholder - would need WDT peripheral access
}

/// Get UART for panic output
/// 
/// # Safety
/// Must only be called from panic handler with interrupts disabled
// SAFETY: Function signature - see # Safety documentation above
unsafe fn get_uart() -> Option<&'static mut dyn core::fmt::Write> {
    // This is a simplified version - in real implementation,
    // would get UART from HAL console
    None
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_panic_flag_default() {
        // Just verify the flag exists
        let _panicking = PANICKING.load(Ordering::Relaxed);
    }
}
