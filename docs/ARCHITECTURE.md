# RustOS Architecture Guide

## Overview

RustOS is a preemptive, priority-based real-time operating system kernel designed for RISC-V RV32IMAC embedded systems. This document describes the internal architecture and design decisions.

## System Architecture

```text
┌─────────────────────────────────────────────────────────┐
│                   Application Tasks                     │
│        (user-defined task functions)                    │
└─────────────────────────────────────────────────────────┘
                          │
┌─────────────────────────▼─────────────────────────────┐
│              RustOS Kernel API                        │
│  ┌─────────┬──────────┬────────┬──────────────────┐   │
│  │  Task   │  Sync    │  Time  │  Diagnostics     │   │
│  │  Mgmt   │  Prims   │  Mgmt  │                  │   │
│  └─────────┴──────────┴────────┴──────────────────┘   │
└───────────────────────────────────────────────────────┘
                          │
┌─────────────────────────▼─────────────────────────────┐
│               Core Kernel Services                    │
│  ┌────────────┬───────────┬───────────┬─────────┐     │
│  │ Scheduler  │  Context  │  Critical │  Power  │     │
│  │  (O(1))    │   Switch  │  Section  │  Mgmt   │     │
│  └────────────┴───────────┴───────────┴─────────┘     │
└───────────────────────────────────────────────────────┘
                          │
┌─────────────────────────▼─────────────────────────────┐
│                Hardware Abstraction                  │
│  ┌──────────┬──────────┬──────────┬─────────────┐    │
│  │  Timer   │  UART    │  GPIO    │   Others    │    │
│  │ (1kHz)   │          │          │             │    │
│  └──────────┴──────────┴──────────┴─────────────┘    │
└───────────────────────────────────────────────────────┘
                          │
┌─────────────────────────▼─────────────────────────────┐
│              RISC-V RV32IMAC Hardware                 │
│   (75 MHz, 128KB BRAM, MicroBlaze V)                  │
└───────────────────────────────────────────────────────┘
```

## Core Components

### 1. Scheduler (`scheduler.rs`)

**Design**: Priority-based preemptive scheduler with O(1) task selection.

**Algorithm**:

- Uses 8-word (256-bit) priority bitmap for O(1) ready task lookup
- Each bit represents one priority level (0 = highest, 255 = lowest)
- Task selection: find first set bit in bitmap (lowest index = highest priority)
- Round-robin scheduling within same priority level

**Data Structures**:

```rust
struct Scheduler {
    tasks: [AtomicPtr<Task>; 16],         // Task pointers
    priority_bitmap: [AtomicU32; 8],      // 256-bit priority bitmap
    current_task: AtomicU8,                // Current task ID
    task_count: AtomicU8,                  // Number of tasks
    enabled: AtomicBool,                   // Scheduler enabled flag
    context_switch_count: AtomicU32,       // Statistics (optional)
}
```

**Preemption**:

- System tick interrupt (1ms) triggers task preemption
- Higher priority tasks always preempt lower priority tasks
- Same priority tasks share CPU time in round-robin fashion

### 2. Task Management (`task.rs`)

**Task Control Block (TCB)**:

```rust
struct Task {
    id: TaskId,                    // Unique identifier
    name: &'static str,            // Debug name
    priority: TaskPriority,        // Priority level (0-255)
    state: TaskState,              // READY/RUNNING/BLOCKED/SUSPENDED/TERMINATED
    sp: *mut usize,                // Stack pointer (saved context)
    stack_base: *mut u8,           // Stack base address
    stack_size: usize,             // Stack size in bytes
    stack_canary: u32,             // Stack overflow detection
    stats: TaskStats,              // Runtime statistics (optional)
}
```

**Task States**:

- `READY`: Task is ready to execute
- `RUNNING`: Task is currently executing
- `BLOCKED`: Task is waiting for a resource (mutex, semaphore, etc.)
- `SUSPENDED`: Task is explicitly suspended
- `TERMINATED`: Task has finished execution

**Stack Layout** (grows downward):

```text
High Address
├─────────────┤
│  Stack Top  │  (initial SP points here)
├─────────────┤
│   Context   │  (34 registers: x1-x31, mepc, mstatus, mcause, mtval)
│   Frame     │
├─────────────┤
│    Task     │
│   Stack     │
│   Space     │
├─────────────┤
│   Canary    │  (stack overflow detection)
├─────────────┤
│ Stack Base  │
Low Address
```

### 3. Context Switching (`context.rs`)

**Context Frame** (RISC-V):

```text
Offset  Register    Description
0       x1 (ra)     Return address
4       x2 (sp)     Stack pointer
8       x3 (gp)     Global pointer
12      x4 (tp)     Thread pointer
16-28   x5-x7       Temporary registers
32-60   x8-x9       Saved registers
64-92   x10-x17     Function arguments/return values
96-124  x18-x27     Saved registers
128-132 x28-x31     Temporary registers
136     mepc        Exception PC
140     mstatus     Machine status
144     mcause      Exception cause
148     mtval       Exception value
```

**Context Switch Flow**:

1. Save current task's registers to stack
2. Save SP to current task's TCB
3. Select next task via scheduler
4. Load next task's SP from TCB
5. Restore next task's registers from stack
6. Return to next task (mret)

### 4. Synchronization Primitives (`sync/`)

#### Mutex

- Binary lock for mutual exclusion
- Owner tracking for debugging
- Try-lock (non-blocking) and lock (blocking) operations
- Automatic unlock via RAII guard

#### Semaphore

- Counting semaphore (0 to max count)
- Acquire/release operations
- Timeout support
- Used for resource management

#### Message Queue

- Fixed-size FIFO queue
- Blocking send/receive
- Peek and flush operations
- Type-safe using generics

#### Event Flags

- 32-bit flag register
- Set/clear/wait operations
- OR/AND wait conditions
- Used for event signaling

### 5. Time Management (`time.rs`)

**System Tick**:

- Rate: 1000 Hz (1ms period)
- 32-bit tick counter (wraps after ~49.7 days)
- 32-bit uptime counter (milliseconds)

**Software Timers**:

- One-shot: fire once after delay
- Periodic: fire repeatedly at interval
- Callback support (optional)
- Atomic operations for ISR safety

### 6. Memory Management

**Memory Model**:

- No heap allocation (fully static)
- Task stacks allocated at compile time
- All data structures use static or stack allocation
- Fixed-size collections (heapless crate)

**Memory Layout**:

```text
0x0000_0000 ┌──────────────┐
            │   .text      │  Code section
            ├──────────────┤
            │   .rodata    │  Read-only data
            ├──────────────┤
            │   .data      │  Initialized data
            ├──────────────┤
            │   .bss       │  Uninitialized data
            ├──────────────┤
            │  Task Stacks │  (static arrays)
            ├──────────────┤
            │   Unused     │
0x0001_FFFF └──────────────┘ (128KB BRAM)
```

### 7. Interrupt Handling

**Interrupt Flow**:

1. Hardware interrupt occurs
2. CPU saves minimal context (mepc, mcause)
3. Jump to interrupt vector table
4. Save full context to stack
5. Call interrupt handler (C function)
6. Restore context from stack
7. Return from interrupt (mret)

**Timer Interrupt** (1ms tick):

1. Increment system tick counter
2. Check software timers for expiration
3. Trigger scheduler preemption
4. Context switch if higher priority task ready

### 8. Power Management (`power.rs`)

**Idle Task Strategy**:

- Default: spin loop with hint::spin_loop()
- WFI enabled: use RISC-V `wfi` instruction
- CPU enters low-power state until interrupt
- Reduces power consumption during idle periods

**Feature Flag**: `wfi-idle`

### 9. Error Handling (`error.rs`)

**Error Code Ranges**:

- 0x1000-0x1FFF: Task management errors
- 0x2000-0x2FFF: Scheduler errors
- 0x3000-0x3FFF: Synchronization errors
- 0x4000-0x4FFF: Memory errors
- 0x5000-0x5FFF: Hardware/driver errors
- 0x6000-0x6FFF: Interrupt errors
- 0x7000-0x7FFF: System errors
- 0x8000-0x8FFF: Time errors

**Error Recovery**:

- Recoverable errors: return Result<T, KernelError>
- Critical errors: trigger panic with diagnostics
- Error handler callback (optional)

### 10. Diagnostics (`diagnostics.rs`)

**Runtime Query APIs** (feature: `diagnostics`):

- `task_get_state()`: Query task state
- `task_get_stack_usage()`: Get stack high-water mark
- `irq_get_count()`: Get interrupt count
- `mutex_get_owner()`: Get mutex owner
- `queue_get_count()`: Get queue depth

All APIs are non-blocking and ISR-safe.

## Performance Characteristics

| Operation                | Time Complexity | Notes                        |
|--------------------------|----------------|-------------------------------|
| Task Selection           | O(1)           | Bitmap scan                   |
| Context Switch           | O(1)           | ~150 cycles @ 75 MHz          |
| Mutex Lock/Unlock        | O(1)           | Atomic operations             |
| Semaphore Acquire/Release| O(1)           | Atomic counter                |
| Message Queue Send/Recv  | O(1)           | Ring buffer                   |
| Timer Start/Stop         | O(1)           | Atomic operations             |

## Safety Guarantees

1. **Type Safety**: Rust's type system prevents common bugs
2. **Memory Safety**: No null pointers, no buffer overflows (with bounds checking)
3. **Thread Safety**: Atomic operations for shared data, critical sections for IRQ safety
4. **Stack Safety**: Canary-based overflow detection (optional)
5. **Resource Safety**: RAII guards for automatic cleanup

## Porting Guide

To port RustOS to a different RISC-V variant:

1. Update `context.rs` for your register set
2. Modify `linker.ld` for your memory map
3. Update timer initialization for your clock frequency
4. Adjust interrupt vector table in startup code
5. Update `Cargo.toml` target specification

## References

- RustOS Requirements Specification v2.8.3
- RISC-V ISA Specification
- RISC-V Privileged Architecture Specification
