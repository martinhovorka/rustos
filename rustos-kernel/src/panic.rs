//! REQ: PAN-001 - Panic Handler
//!
//! Enhanced panic handler with diagnostic output for RustOS.

#![allow(unused_imports)]

use core::panic::PanicInfo;
use portable_atomic::{AtomicBool, AtomicUsize, Ordering};

/// Track if we're already in panic to prevent recursive panics
static PANICKING: AtomicBool = AtomicBool::new(false);

/// REQ: PAN-003 - Panic output writer getter type
pub type PanicUartGetter = unsafe fn() -> &'static mut dyn core::fmt::Write;

/// REQ: PAN-005 - Panic LED hook type
pub type PanicLedHook = unsafe fn();

/// REQ: PAN-007 - Panic reset hook type
pub type PanicResetHook = unsafe fn();

/// REQ: PAN-003 - Registered panic UART getter
static PANIC_UART_GETTER: AtomicUsize = AtomicUsize::new(0);

/// REQ: PAN-005 - Registered panic LED hook
static PANIC_LED_HOOK: AtomicUsize = AtomicUsize::new(0);

/// REQ: PAN-007 - Registered panic reset hook
static PANIC_RESET_HOOK: AtomicUsize = AtomicUsize::new(0);

/// REQ: PAN-003 - Register UART getter for panic output
///
/// # Safety
/// The provided function must always return a valid `&'static mut` writer while the system is
/// in panic handling (interrupts disabled). It must not allocate or block.
// SAFETY: Function signature - requires caller to guarantee lifetime/validity of returned writer.
pub unsafe fn set_panic_uart_getter(getter: PanicUartGetter) {
    PANIC_UART_GETTER.store(getter as usize, Ordering::Release);
}

/// REQ: PAN-005 - Register LED blink hook for panic indication
///
/// # Safety
/// The hook must be safe to call with interrupts disabled, must not allocate, and must be
/// idempotent (may be called multiple times).
// SAFETY: Function signature - caller provides platform-specific hook.
pub unsafe fn set_panic_led_hook(hook: PanicLedHook) {
    PANIC_LED_HOOK.store(hook as usize, Ordering::Release);
}

/// REQ: PAN-007 - Register watchdog reset hook for panic reset
///
/// # Safety
/// The hook must be safe to call with interrupts disabled and should trigger a system reset.
// SAFETY: Function signature - caller provides platform-specific hook.
pub unsafe fn set_panic_reset_hook(hook: PanicResetHook) {
    PANIC_RESET_HOOK.store(hook as usize, Ordering::Release);
}

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
                let _ = writeln!(
                    uart,
                    "Location: {}:{}:{}",
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
    use core::fmt::Write;

    // REQ: PAN-009 - Distinguish stack overflow panics via canary check
    if let Some(current_id) = crate::scheduler::get().current_task() {
        if let Some(task) = crate::scheduler::get().get_task(current_id) {
            if !task.check_stack_overflow() {
                let _ = writeln!(uart, "\nStack Check: STACK OVERFLOW DETECTED");
                return;
            }
        }
    }

    let _ = writeln!(uart, "\nStack Check: OK (or unknown task)");
}

/// REQ: PAN-005 - Blink LEDs in panic pattern
#[cfg(feature = "panic-led")]
fn blink_panic_pattern() {
    let ptr = PANIC_LED_HOOK.load(Ordering::Acquire);
    if ptr == 0 {
        return;
    }

    // SAFETY: The hook pointer is set only via set_panic_led_hook(), which guarantees it is a
    // valid function pointer for the program lifetime.
    let hook: PanicLedHook = unsafe { core::mem::transmute(ptr) };
    unsafe { hook() };
}

/// REQ: PAN-007 - Trigger watchdog reset
#[cfg(feature = "panic-reset")]
fn trigger_watchdog_reset() {
    let ptr = PANIC_RESET_HOOK.load(Ordering::Acquire);
    if ptr == 0 {
        return;
    }

    // SAFETY: The hook pointer is set only via set_panic_reset_hook(), which guarantees it is a
    // valid function pointer for the program lifetime.
    let hook: PanicResetHook = unsafe { core::mem::transmute(ptr) };
    unsafe { hook() };
}

/// Get UART for panic output
///
/// # Safety
/// Must only be called from panic handler with interrupts disabled
// SAFETY: Function signature - see # Safety documentation above
unsafe fn get_uart() -> Option<&'static mut dyn core::fmt::Write> {
    let ptr = PANIC_UART_GETTER.load(Ordering::Acquire);
    if ptr == 0 {
        return None;
    }

    // SAFETY: The getter pointer is set only via set_panic_uart_getter(), which guarantees it is
    // a valid function pointer for the program lifetime.
    let getter: PanicUartGetter = unsafe { core::mem::transmute(ptr) };
    Some(unsafe { getter() })
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
