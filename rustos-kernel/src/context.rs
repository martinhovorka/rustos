//! REQ: CTX-001 - Context Switching
//!
//! Low-level context switching for RISC-V RV32IMAC.

/// REQ: CTX-013 - Context frame size (144 bytes = 36 words)
pub const CONTEXT_FRAME_SIZE: usize = 144;

/// REQ: CTX-008, CTX-011 - Start first task
///
/// Loads context from the given stack pointer and jumps to the task.
/// This function does not return.
///
/// # Safety
/// - sp must point to a valid context frame
/// - Must be called with interrupts disabled
/// - Never returns
// SAFETY: Naked function for context switching - uses only assembly to restore context.
#[unsafe(naked)]
pub unsafe extern "C" fn start_first_task(sp: *mut usize) -> ! {
    core::arch::naked_asm!(
        // Load stack pointer from argument (a0)
        "mv sp, a0",
        // REQ: CTX-011 - Restore context frame
        // Restore general-purpose registers
        "lw x1,  0(sp)",   // ra
        "lw x3,  4(sp)",   // gp
        "lw x4,  8(sp)",   // tp
        "lw x5,  12(sp)",  // t0
        "lw x6,  16(sp)",  // t1
        "lw x7,  20(sp)",  // t2
        "lw x8,  24(sp)",  // s0/fp
        "lw x9,  28(sp)",  // s1
        "lw x10, 32(sp)",  // a0
        "lw x11, 36(sp)",  // a1
        "lw x12, 40(sp)",  // a2
        "lw x13, 44(sp)",  // a3
        "lw x14, 48(sp)",  // a4
        "lw x15, 52(sp)",  // a5
        "lw x16, 56(sp)",  // a6
        "lw x17, 60(sp)",  // a7
        "lw x18, 64(sp)",  // s2
        "lw x19, 68(sp)",  // s3
        "lw x20, 72(sp)",  // s4
        "lw x21, 76(sp)",  // s5
        "lw x22, 80(sp)",  // s6
        "lw x23, 84(sp)",  // s7
        "lw x24, 88(sp)",  // s8
        "lw x25, 92(sp)",  // s9
        "lw x26, 96(sp)",  // s10
        "lw x27, 100(sp)", // s11
        "lw x28, 104(sp)", // t3
        "lw x29, 108(sp)", // t4
        "lw x30, 112(sp)", // t5
        "lw x31, 116(sp)", // t6
        // REQ: CTX-012 - Restore CSRs
        "lw t0, 120(sp)", // mepc
        "csrw mepc, t0",
        "lw t0, 124(sp)", // mstatus
        "csrw mstatus, t0",
        // REQ: CTX-013 - Adjust stack pointer past frame
        "addi sp, sp, 144",
        // REQ: CTX-003 - Return from exception (jumps to mepc)
        "mret"
    )
}

/// REQ: CTX-001, CTX-006 - Save and restore context during task switch
///
/// # Arguments
/// - a0: pointer to current task's SP storage location
/// - a1: new task's SP value
///
/// # Safety
/// Must be called from trap handler with interrupts disabled
// SAFETY: Naked function for context switching - saves current task context, loads next task context.
#[unsafe(naked)]
pub unsafe extern "C" fn switch_context(current_sp_ptr: *mut *mut usize, new_sp: *mut usize) {
    core::arch::naked_asm!(
        // REQ: CTX-002 - Save context of current task
        // Allocate space on stack for context frame
        "addi sp, sp, -144",
        // Save general-purpose registers (x1, x3-x31)
        "sw x1,  0(sp)",   // ra
        "sw x3,  4(sp)",   // gp
        "sw x4,  8(sp)",   // tp
        "sw x5,  12(sp)",  // t0
        "sw x6,  16(sp)",  // t1
        "sw x7,  20(sp)",  // t2
        "sw x8,  24(sp)",  // s0/fp
        "sw x9,  28(sp)",  // s1
        "sw x10, 32(sp)",  // a0
        "sw x11, 36(sp)",  // a1
        "sw x12, 40(sp)",  // a2
        "sw x13, 44(sp)",  // a3
        "sw x14, 48(sp)",  // a4
        "sw x15, 52(sp)",  // a5
        "sw x16, 56(sp)",  // a6
        "sw x17, 60(sp)",  // a7
        "sw x18, 64(sp)",  // s2
        "sw x19, 68(sp)",  // s3
        "sw x20, 72(sp)",  // s4
        "sw x21, 76(sp)",  // s5
        "sw x22, 80(sp)",  // s6
        "sw x23, 84(sp)",  // s7
        "sw x24, 88(sp)",  // s8
        "sw x25, 92(sp)",  // s9
        "sw x26, 96(sp)",  // s10
        "sw x27, 100(sp)", // s11
        "sw x28, 104(sp)", // t3
        "sw x29, 108(sp)", // t4
        "sw x30, 112(sp)", // t5
        "sw x31, 116(sp)", // t6
        // REQ: CTX-004, CTX-005 - Save CSRs
        "csrr t0, mepc",
        "sw t0, 120(sp)", // mepc
        "csrr t0, mstatus",
        "sw t0, 124(sp)", // mstatus
        "csrr t0, mcause",
        "sw t0, 128(sp)", // mcause
        "csrr t0, mtval",
        "sw t0, 132(sp)", // mtval
        // Save current SP to *current_sp_ptr
        "sw sp, 0(a0)",
        // Load new task's SP
        "mv sp, a1",
        // REQ: CTX-002 - Restore context of new task
        // Restore general-purpose registers
        "lw x1,  0(sp)",   // ra
        "lw x3,  4(sp)",   // gp
        "lw x4,  8(sp)",   // tp
        "lw x5,  12(sp)",  // t0
        "lw x6,  16(sp)",  // t1
        "lw x7,  20(sp)",  // t2
        "lw x8,  24(sp)",  // s0/fp
        "lw x9,  28(sp)",  // s1
        "lw x10, 32(sp)",  // a0
        "lw x11, 36(sp)",  // a1
        "lw x12, 40(sp)",  // a2
        "lw x13, 44(sp)",  // a3
        "lw x14, 48(sp)",  // a4
        "lw x15, 52(sp)",  // a5
        "lw x16, 56(sp)",  // a6
        "lw x17, 60(sp)",  // a7
        "lw x18, 64(sp)",  // s2
        "lw x19, 68(sp)",  // s3
        "lw x20, 72(sp)",  // s4
        "lw x21, 76(sp)",  // s5
        "lw x22, 80(sp)",  // s6
        "lw x23, 84(sp)",  // s7
        "lw x24, 88(sp)",  // s8
        "lw x25, 92(sp)",  // s9
        "lw x26, 96(sp)",  // s10
        "lw x27, 100(sp)", // s11
        "lw x28, 104(sp)", // t3
        "lw x29, 108(sp)", // t4
        "lw x30, 112(sp)", // t5
        "lw x31, 116(sp)", // t6
        // Restore CSRs
        "lw t0, 120(sp)", // mepc
        "csrw mepc, t0",
        "lw t0, 124(sp)", // mstatus
        "csrw mstatus, t0",
        // Adjust stack pointer
        "addi sp, sp, 144",
        // Return
        "ret"
    )
}
