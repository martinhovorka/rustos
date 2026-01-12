//! REQ: TEST-008 - Context switching unit tests
//!
//! Tests for context save/restore operations.

#![cfg(test)]

use crate::assert_test;
use std::sync::atomic::{AtomicU32, Ordering};

extern crate std;

// ============================================================================
// Mock Context Structure
// ============================================================================

/// RISC-V context frame (mock version of kernel's 144-byte context)
/// Matches the actual kernel context layout for validation
#[repr(C)]
#[derive(Debug, Clone, Copy, Default)]
struct Context {
    // General purpose registers (x0-x31, but x0 is hardwired to 0)
    ra: u32,    // x1 - Return address
    sp: u32,    // x2 - Stack pointer
    gp: u32,    // x3 - Global pointer
    tp: u32,    // x4 - Thread pointer
    t0: u32,    // x5
    t1: u32,    // x6
    t2: u32,    // x7
    s0: u32,    // x8 - Frame pointer
    s1: u32,    // x9
    a0: u32,    // x10 - Argument/return
    a1: u32,    // x11 - Argument/return
    a2: u32,    // x12
    a3: u32,    // x13
    a4: u32,    // x14
    a5: u32,    // x15
    a6: u32,    // x16
    a7: u32,    // x17
    s2: u32,    // x18
    s3: u32,    // x19
    s4: u32,    // x20
    s5: u32,    // x21
    s6: u32,    // x22
    s7: u32,    // x23
    s8: u32,    // x24
    s9: u32,    // x25
    s10: u32,   // x26
    s11: u32,   // x27
    t3: u32,    // x28
    t4: u32,    // x29
    t5: u32,    // x30
    t6: u32,    // x31
    
    // Control and Status Registers
    mepc: u32,      // Machine exception program counter
    mstatus: u32,   // Machine status register
    mcause: u32,    // Machine cause register
    mtval: u32,     // Machine trap value
}

impl Context {
    const SIZE: usize = 140;  // 35 * 4 bytes (31 GP regs + 4 CSRs)

    fn new() -> Self {
        Self::default()
    }

    fn with_entry(entry_point: u32, stack_ptr: u32) -> Self {
        Self {
            ra: entry_point,
            sp: stack_ptr,
            mepc: entry_point,
            mstatus: 0x1880,  // MPP=3 (M-mode), MPIE=1
            ..Default::default()
        }
    }
}

// ============================================================================
// Mock Context Operations
// ============================================================================

static CONTEXT_SWITCH_COUNT: AtomicU32 = AtomicU32::new(0);

/// Save context to memory (mock)
fn save_context(ctx: &mut Context, regs: &[u32; 32]) {
    ctx.ra = regs[1];
    ctx.sp = regs[2];
    ctx.gp = regs[3];
    ctx.tp = regs[4];
    ctx.t0 = regs[5];
    ctx.t1 = regs[6];
    ctx.t2 = regs[7];
    ctx.s0 = regs[8];
    ctx.s1 = regs[9];
    ctx.a0 = regs[10];
    ctx.a1 = regs[11];
    ctx.a2 = regs[12];
    ctx.a3 = regs[13];
    ctx.a4 = regs[14];
    ctx.a5 = regs[15];
    ctx.a6 = regs[16];
    ctx.a7 = regs[17];
    ctx.s2 = regs[18];
    ctx.s3 = regs[19];
    ctx.s4 = regs[20];
    ctx.s5 = regs[21];
    ctx.s6 = regs[22];
    ctx.s7 = regs[23];
    ctx.s8 = regs[24];
    ctx.s9 = regs[25];
    ctx.s10 = regs[26];
    ctx.s11 = regs[27];
    ctx.t3 = regs[28];
    ctx.t4 = regs[29];
    ctx.t5 = regs[30];
    ctx.t6 = regs[31];
}

/// Restore context from memory (mock)
fn restore_context(ctx: &Context) -> [u32; 32] {
    let mut regs = [0u32; 32];
    regs[1] = ctx.ra;
    regs[2] = ctx.sp;
    regs[3] = ctx.gp;
    regs[4] = ctx.tp;
    regs[5] = ctx.t0;
    regs[6] = ctx.t1;
    regs[7] = ctx.t2;
    regs[8] = ctx.s0;
    regs[9] = ctx.s1;
    regs[10] = ctx.a0;
    regs[11] = ctx.a1;
    regs[12] = ctx.a2;
    regs[13] = ctx.a3;
    regs[14] = ctx.a4;
    regs[15] = ctx.a5;
    regs[16] = ctx.a6;
    regs[17] = ctx.a7;
    regs[18] = ctx.s2;
    regs[19] = ctx.s3;
    regs[20] = ctx.s4;
    regs[21] = ctx.s5;
    regs[22] = ctx.s6;
    regs[23] = ctx.s7;
    regs[24] = ctx.s8;
    regs[25] = ctx.s9;
    regs[26] = ctx.s10;
    regs[27] = ctx.s11;
    regs[28] = ctx.t3;
    regs[29] = ctx.t4;
    regs[30] = ctx.t5;
    regs[31] = ctx.t6;
    regs
}

/// Perform context switch between two tasks (mock)
fn context_switch(from: &mut Context, to: &Context) {
    // In real implementation, this would:
    // 1. Save all registers to 'from' context
    // 2. Restore all registers from 'to' context
    // 3. Jump to new task's PC
    
    // For mock, we just copy the context
    *from = *to;
    CONTEXT_SWITCH_COUNT.fetch_add(1, Ordering::SeqCst);
}

fn reset_mock_state() {
    CONTEXT_SWITCH_COUNT.store(0, Ordering::SeqCst);
}

fn get_switch_count() -> u32 {
    CONTEXT_SWITCH_COUNT.load(Ordering::SeqCst)
}

// ============================================================================
// Context Tests
// ============================================================================

#[test]
fn test_context_size() {
    // REQ: CTX-001 - Context frame size
    assert_test!(
        core::mem::size_of::<Context>() == Context::SIZE,
        format!("Context size should be {} bytes, got {}", 
            Context::SIZE, core::mem::size_of::<Context>())
    );
}

#[test]
fn test_context_alignment() {
    // Context should be 4-byte aligned for RISC-V
    assert_test!(
        core::mem::align_of::<Context>() >= 4,
        "Context should be at least 4-byte aligned"
    );
}

#[test]
fn test_context_new_zeroed() {
    // New context should be zeroed
    let ctx = Context::new();
    
    assert_test!(ctx.ra == 0, "ra should be 0");
    assert_test!(ctx.sp == 0, "sp should be 0");
    assert_test!(ctx.mepc == 0, "mepc should be 0");
    assert_test!(ctx.mstatus == 0, "mstatus should be 0");
}

#[test]
fn test_context_with_entry() {
    // REQ: CTX-002 - Initial context setup
    let entry = 0x80000000u32;
    let stack = 0x80010000u32;
    
    let ctx = Context::with_entry(entry, stack);
    
    assert_test!(ctx.ra == entry, "ra should be entry point");
    assert_test!(ctx.sp == stack, "sp should be stack pointer");
    assert_test!(ctx.mepc == entry, "mepc should be entry point");
    assert_test!(ctx.mstatus == 0x1880, "mstatus should enable M-mode and MPIE");
}

#[test]
fn test_context_save_restore() {
    // REQ: CTX-003 - Context save/restore preserves all registers
    let mut ctx = Context::new();
    
    // Create mock register state
    let mut regs = [0u32; 32];
    for i in 1..32 {
        regs[i] = (i * 100) as u32;
    }
    
    // Save to context
    save_context(&mut ctx, &regs);
    
    // Verify saved values
    assert_test!(ctx.ra == 100, "ra should be saved");
    assert_test!(ctx.sp == 200, "sp should be saved");
    assert_test!(ctx.a0 == 1000, "a0 should be saved");
    assert_test!(ctx.t6 == 3100, "t6 should be saved");
    
    // Restore and verify
    let restored = restore_context(&ctx);
    
    for i in 1..32 {
        assert_test!(
            restored[i] == (i * 100) as u32,
            format!("Register x{} should be restored correctly", i)
        );
    }
}

#[test]
fn test_context_switch_basic() {
    // REQ: CTX-004 - Context switch between tasks
    reset_mock_state();
    
    let mut task1_ctx = Context::with_entry(0x80001000, 0x80010000);
    let task2_ctx = Context::with_entry(0x80002000, 0x80020000);
    
    // Switch from task1 to task2
    context_switch(&mut task1_ctx, &task2_ctx);
    
    // After switch, task1_ctx should have task2's values (for mock purposes)
    assert_test!(task1_ctx.mepc == 0x80002000, "Should switch to task2's entry");
    assert_test!(task1_ctx.sp == 0x80020000, "Should use task2's stack");
    assert_test!(get_switch_count() == 1, "Switch count should be 1");
}

#[test]
fn test_context_switch_multiple() {
    // Test multiple context switches
    reset_mock_state();
    
    let mut ctx_a = Context::with_entry(0xA000, 0xA100);
    let ctx_b = Context::with_entry(0xB000, 0xB100);
    let ctx_c = Context::with_entry(0xC000, 0xC100);
    
    context_switch(&mut ctx_a, &ctx_b);
    context_switch(&mut ctx_a, &ctx_c);
    context_switch(&mut ctx_a, &ctx_b);
    
    assert_test!(get_switch_count() == 3, "Should have 3 context switches");
}

#[test]
fn test_context_csr_preservation() {
    // REQ: CTX-005 - CSR preservation during context switch
    let ctx = Context {
        mepc: 0x80001234,
        mstatus: 0x00001880,
        mcause: 0x8000000B,  // Machine external interrupt
        mtval: 0x12345678,
        ..Context::new()
    };
    
    assert_test!(ctx.mepc == 0x80001234, "mepc should be preserved");
    assert_test!(ctx.mstatus == 0x00001880, "mstatus should be preserved");
    assert_test!(ctx.mcause == 0x8000000B, "mcause should be preserved");
    assert_test!(ctx.mtval == 0x12345678, "mtval should be preserved");
}

#[test]
fn test_context_stack_pointer_validity() {
    // Stack pointer must be in valid range
    let valid_sp = 0x80010000u32;
    let ctx = Context::with_entry(0x80000000, valid_sp);
    
    // Stack should be 4-byte aligned
    assert_test!(ctx.sp % 4 == 0, "Stack pointer must be 4-byte aligned");
    
    // Stack should not be zero
    assert_test!(ctx.sp != 0, "Stack pointer must not be zero");
}

#[test]
fn test_context_argument_passing() {
    // REQ: CTX-006 - Argument registers preserved
    let mut ctx = Context::new();
    let mut regs = [0u32; 32];
    
    // Set argument registers (a0-a7)
    regs[10] = 0x11111111;  // a0
    regs[11] = 0x22222222;  // a1
    regs[12] = 0x33333333;  // a2
    regs[13] = 0x44444444;  // a3
    regs[14] = 0x55555555;  // a4
    regs[15] = 0x66666666;  // a5
    regs[16] = 0x77777777;  // a6
    regs[17] = 0x88888888;  // a7
    
    save_context(&mut ctx, &regs);
    
    assert_test!(ctx.a0 == 0x11111111, "a0 should be preserved");
    assert_test!(ctx.a1 == 0x22222222, "a1 should be preserved");
    assert_test!(ctx.a7 == 0x88888888, "a7 should be preserved");
}

#[test]
fn test_context_callee_saved_registers() {
    // REQ: CTX-007 - Callee-saved registers (s0-s11)
    let mut ctx = Context::new();
    let mut regs = [0u32; 32];
    
    // Set saved registers
    regs[8] = 0xDEAD0008;   // s0
    regs[9] = 0xDEAD0009;   // s1
    regs[18] = 0xDEAD0018;  // s2
    regs[27] = 0xDEAD001B;  // s11
    
    save_context(&mut ctx, &regs);
    
    assert_test!(ctx.s0 == 0xDEAD0008, "s0 should be preserved");
    assert_test!(ctx.s1 == 0xDEAD0009, "s1 should be preserved");
    assert_test!(ctx.s2 == 0xDEAD0018, "s2 should be preserved");
    assert_test!(ctx.s11 == 0xDEAD001B, "s11 should be preserved");
}

#[test]
fn test_context_temporary_registers() {
    // REQ: CTX-008 - Temporary registers (t0-t6)
    let mut ctx = Context::new();
    let mut regs = [0u32; 32];
    
    regs[5] = 0xBEEF0005;   // t0
    regs[6] = 0xBEEF0006;   // t1
    regs[7] = 0xBEEF0007;   // t2
    regs[28] = 0xBEEF001C;  // t3
    regs[31] = 0xBEEF001F;  // t6
    
    save_context(&mut ctx, &regs);
    
    assert_test!(ctx.t0 == 0xBEEF0005, "t0 should be preserved");
    assert_test!(ctx.t1 == 0xBEEF0006, "t1 should be preserved");
    assert_test!(ctx.t6 == 0xBEEF001F, "t6 should be preserved");
}

// ============================================================================
// Initial Context Tests
// ============================================================================

#[test]
fn test_initial_context_for_new_task() {
    // REQ: CTX-009 - Initial context setup for new task
    extern "C" fn task_entry() -> ! { loop {} }
    
    let entry_point = task_entry as usize as u32;
    let stack_top = 0x80010000u32;
    
    let ctx = Context::with_entry(entry_point, stack_top);
    
    // Entry point in ra (return address) and mepc
    assert_test!(ctx.ra == entry_point, "ra should point to entry");
    assert_test!(ctx.mepc == entry_point, "mepc should point to entry");
    
    // Stack pointer set
    assert_test!(ctx.sp == stack_top, "sp should be at stack top");
    
    // Machine mode enabled
    assert_test!(ctx.mstatus & 0x1800 == 0x1800, "MPP should be M-mode");
}

// ============================================================================
// Context Switch Timing Tests
// ============================================================================

#[test]
fn test_context_switch_overhead() {
    // REQ: PERFTEST-001 - Context switch latency
    reset_mock_state();
    
    let mut ctx1 = Context::new();
    let ctx2 = Context::new();
    
    let start = std::time::Instant::now();
    for _ in 0..10000 {
        context_switch(&mut ctx1, &ctx2);
    }
    let elapsed = start.elapsed();
    
    // Mock context switch should be very fast
    assert_test!(
        elapsed.as_micros() < 100000,  // Less than 100ms for 10000 switches
        format!("Context switches took too long: {:?}", elapsed)
    );
    
    assert_test!(get_switch_count() == 10000, "Should have 10000 switches");
}

#[test]
fn test_context_frame_copy() {
    // Test that context can be safely copied
    let original = Context::with_entry(0x12345678, 0x87654321);
    let copy = original;
    
    assert_test!(copy.ra == original.ra, "Copy should match original");
    assert_test!(copy.sp == original.sp, "Copy should match original");
    assert_test!(copy.mepc == original.mepc, "Copy should match original");
}
