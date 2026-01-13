//! REQ: KERN-001 - RustOS Kernel
//!
//! A preemptive, priority-based real-time operating system kernel for RISC-V RV32IMAC.
//!
//! # Overview
//!
//! RustOS provides a lightweight, deterministic RTOS kernel optimized for embedded systems.
//! The kernel uses static memory allocation and provides guaranteed O(1) scheduling performance.
//!
//! # Core Features
//!
//! - **Preemptive Multitasking** (REQ: SCHED-001): Round-robin scheduling within same priority
//! - **Priority Scheduling** (REQ: SCHED-002): 256 priority levels (0 = highest, 255 = lowest)
//! - **Task Management** (REQ: SCHED-005): Up to 16 concurrent tasks
//! - **Static Memory** (REQ: MEM-001): No dynamic allocation, fully deterministic
// SAFETY: Documentation describing memory safety approach
//! - **Memory Safety** (REQ: SAFE-001): Leverages Rust's type system with minimal unsafe code
//! - **Synchronization**: Mutexes, semaphores, message queues, event flags
//! - **Software Timers** (REQ: TIME-005): One-shot and periodic timers with callbacks
//! - **Power Management** (REQ: PWR-001): WFI idle support for power savings
//!
//! # Quick Start
//!
//! ```no_run
//! #![no_std]
//! #![no_main]
//!
//! use rustos_kernel::{init, scheduler};
//! use rustos_kernel::task::{Task, TaskPriority};
//!
//! #[no_mangle]
//! extern "C" fn main() -> ! {
//!     // SAFETY: Called once during system initialization with interrupts disabled
//!     unsafe {
//!         // Initialize kernel
//!         init();
//!         
//!         // Create tasks (see task module for details)
//!         // ...
//!         
//!         // Start scheduler (does not return)
//!         scheduler::start();
//!     }
//! }
//! ```
//!
//! # Architecture
//!
//! The kernel is structured into the following modules:
//!
//! - [`task`]: Task control blocks and task management
//! - [`scheduler`]: O(1) priority-based preemptive scheduler
//! - [`sync`]: Synchronization primitives (mutex, semaphore, queue, events)
//! - [`time`]: System tick, timers, and delay functions
//! - [`context`]: Low-level context switching for RISC-V
//! - [`critical`]: Critical section management
//! - [`power`]: Power management and idle strategies
//! - [`mod@error`]: Formal error codes and error handling
//! - [`diagnostics`]: Runtime diagnostics and monitoring APIs
//!
//! # Safety
//!
// SAFETY: Documentation section describing kernel safety approach
//! The kernel minimizes unsafe code to critical sections: context switching, interrupt
//! handling, and raw pointer access for task stacks. All public APIs are safe to use.
//!
//! # Feature Flags
//!
//! - `statistics`: Enable context switch counting and performance metrics
//! - `diagnostics`: Enable runtime diagnostic query APIs
//! - `timers`: Enable callback-based software timers
//! - `wfi-idle`: Use WFI instruction in idle task for power savings
//! - `panic-led`: Blink LED on panic
//! - `panic-reset`: Watchdog reset on panic
//!
//! # Requirements Traceability
//!
//! This kernel implements 800+ requirements from the RustOS specification v2.8.3.
//! See individual modules and functions for requirement tags (e.g., REQ: SCHED-001).

#![no_std]
#![deny(missing_docs)]
#![deny(warnings)]

pub mod config; // REQ: CFG-001 - Configuration system
pub mod context;
pub mod critical;
pub mod debug; // REQ: DBG-017, DBG-018, DBG-019 - Debug infrastructure
pub mod diagnostics; // REQ: DIAG-001 - Runtime diagnostics
pub mod error; // REQ: ERR-001 - Formal error handling
pub mod log; // REQ: LOG-001 - Logging infrastructure
pub mod panic; // REQ: PAN-001 - Panic handler
pub mod power; // REQ: PWR-001 - Power management
pub mod scheduler;
pub mod security;
pub mod stability; // REQ: API-013 - API stability markers
pub mod sync;
pub mod task;
pub mod time; // REQ: SEC-010 - Secure boot validation

pub use config::KernelConfig;
pub use debug::{GdbStub, Profiler, Semihosting};
pub use error::{KernelError, Result};
pub use scheduler::Scheduler;
pub use security::{ImageHeader, SecureBoot};
pub use sync::{EventFlags, MessageQueue, Mutex, Semaphore};
pub use task::{Task, TaskId, TaskPriority, TaskState};

/// REQ: KERN-003 - Kernel initialization
///
/// Initializes all kernel subsystems and data structures.
/// Must be called once at system startup before any kernel services are used.
///
/// # Safety
///
/// REQ: API-016 - Safety requirements:
///
/// - **Must be called exactly once** during system initialization
/// - **Must be called with interrupts disabled** (mstatus.MIE = 0)
/// - **Must be called from main thread** before creating any tasks
/// - **No other kernel functions** may be called before init() completes
///
/// Violating these requirements results in undefined behavior, including:
/// - Race conditions on global data structures
/// - Incorrect scheduler state
/// - Timer counter inconsistencies
///
/// # Example
///
/// ```no_run
/// # use rustos_kernel::{init, start};
/// #[no_mangle]
/// extern "C" fn main() -> ! {
///     // Disable interrupts (typically done by bootloader)
///     // SAFETY: Called once at system startup with interrupts disabled
///     unsafe {
///         core::arch::asm!("csrci mstatus, 0x8");
///         
///         // Initialize kernel (call exactly once)
///         init();
///         
///         // Add tasks here...
///         
///         // Start scheduler (never returns)
///         start();
///     }
/// }
/// ```
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn init() {
    // REQ: INIT-013 - Initialize all kernel data structures before enabling interrupts
    scheduler::init();
    time::init();
}

/// REQ: SCHED-010 - Start the scheduler
///
/// Begins executing tasks. This function never returns.
/// Transfers control to the highest-priority ready task.
///
/// # Safety
///
/// REQ: API-016 - Safety requirements:
///
/// - **Must be called after init()** - kernel must be initialized first
/// - **Must be called with interrupts disabled** - scheduler enables them
/// - **At least one task must be created** - or system will hang
/// - **Must not be called twice** - no recovery from scheduler start
///
/// Violating these requirements results in undefined behavior, including:
/// - Jumping to invalid task context
/// - System hang if no tasks are ready
/// - Stack corruption if called twice
///
/// # Example
///
/// ```no_run
/// # use rustos_kernel::{init, scheduler, task::*, start};
/// // SAFETY: Called after init() with at least one task created
/// unsafe {
///     init();
///     
///     // Create and add at least one task
///     // let task = Task::new(...);
///     // scheduler::get().add_task(&mut task).unwrap();
///     
///     // Start scheduler (never returns)
///     start();
/// }
/// ```
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn start() -> ! {
    scheduler::start()
}
