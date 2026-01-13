# RustOS Kernel

A preemptive, priority-based real-time operating system kernel for RISC-V RV32IMAC.

## Overview

RustOS provides a lightweight, deterministic RTOS kernel optimized for embedded systems. The kernel uses static memory allocation and provides guaranteed O(1) scheduling performance.

## Features

- **Preemptive Multitasking**: Round-robin scheduling within same priority
- **Priority Scheduling**: 256 priority levels (0 = highest, 255 = lowest)
- **Task Management**: Up to 16 concurrent tasks
- **Static Memory**: No dynamic allocation, fully deterministic
- **Memory Safety**: Leverages Rust's type system with minimal unsafe code
- **Synchronization Primitives**:
  - Mutexes for mutual exclusion
  - Counting semaphores
  - Message queues (FIFO)
  - Priority queues (priority-ordered)
  - Event flags
- **Software Timers**: One-shot and periodic timers with callbacks
- **Power Management**: WFI idle support for power savings
- **Runtime Diagnostics**: Query APIs for system monitoring

## Quick Start

```rust
# ![no_std]
# ![no_main]

use rustos_kernel::{init, scheduler};
use rustos_kernel::task::{Task, TaskId, TaskPriority};

static mut TASK1_STACK: [u8; 2048] = [0; 2048];

extern "C" fn task1_entry() -> ! {
    loop {
        // Task work
    }
}

# [no_mangle]
extern "C" fn main() -> ! {
    unsafe {
        // Initialize kernel
        init();

        // Create task
        let task1 = Task::new(
            TaskId(1),
            "task1",
            TaskPriority::NORMAL,
            task1_entry,
            &mut TASK1_STACK
        );

        // Add to scheduler
        scheduler::get().add_task(&mut task1).unwrap();

        // Start scheduler (does not return)
        scheduler::start();
    }
}
```

## Feature Flags

- `statistics`: Enable context switch counting and performance metrics
- `diagnostics`: Enable runtime diagnostic query APIs
- `timers`: Enable callback-based software timers
- `wfi-idle`: Use WFI instruction in idle task for power savings
- `panic-led`: Blink LED on panic
- `panic-reset`: Watchdog reset on panic

## Architecture

The kernel is structured into the following modules:

- **task**: Task control blocks and task management
- **scheduler**: O(1) priority-based preemptive scheduler
- **sync**: Synchronization primitives (mutex, semaphore, queue, events)
- **time**: System tick, timers, and delay functions
- **context**: Low-level context switching for RISC-V
- **critical**: Critical section management
- **power**: Power management and idle strategies
- **error**: Formal error codes and error handling
- **diagnostics**: Runtime diagnostics and monitoring APIs

## Requirements

- Rust 1.82.0 or later
- RISC-V RV32IMAC target: `riscv32imac-unknown-none-elf`
- No standard library (`no_std`)
- No dynamic allocation

## Safety

The kernel minimizes unsafe code to critical sections: context switching, interrupt handling, and raw pointer access for task stacks. All public APIs are safe to use.

## License

Licensed under either of Apache License, Version 2.0 or MIT license at your option. See the [LICENSE-APACHE](../LICENSE-APACHE) and [LICENSE-MIT](../LICENSE-MIT) files for details.

## Requirements Traceability

This kernel implements 800+ requirements from the RustOS specification v2.8.3. See individual modules and functions for requirement tags (e.g., REQ: SCHED-001).
