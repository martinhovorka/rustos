//! REQ: KERN-001 - RustOS Kernel
//! 
//! A preemptive, priority-based real-time operating system kernel for RISC-V.
//!
//! # Features
//! 
//! - REQ: SCHED-001 - Preemptive multitasking
//! - REQ: SCHED-002 - 256 priority levels (0 = highest, 255 = lowest)
//! - REQ: SCHED-005 - Up to 16 concurrent tasks
//! - REQ: MEM-001 - Static memory allocation (no heap)
//! - REQ: SAFE-001 - Memory-safe design with minimal unsafe code

#![no_std]
#![deny(missing_docs)]
#![deny(warnings)]

pub mod task;
pub mod scheduler;
pub mod context;
pub mod sync;
pub mod time;
pub mod critical;
pub mod power;      // REQ: PWR-001 - Power management
pub mod panic;      // REQ: PAN-001 - Panic handler
pub mod error;      // REQ: ERR-001 - Formal error handling
pub mod log;        // REQ: LOG-001 - Logging infrastructure
pub mod config;     // REQ: CFG-001 - Configuration system
pub mod diagnostics; // REQ: DIAG-001 - Runtime diagnostics

pub use task::{Task, TaskId, TaskPriority, TaskState};
pub use scheduler::Scheduler;
pub use sync::{Mutex, Semaphore, MessageQueue, EventFlags};
pub use error::{KernelError, Result};
pub use config::KernelConfig;

/// REQ: KERN-003 - Kernel initialization
/// 
/// Must be called once at system startup before any kernel services are used.
///
/// # Safety
/// Must be called exactly once from main thread with interrupts disabled
pub unsafe fn init() {
    // REQ: INIT-013 - Initialize all kernel data structures before enabling interrupts
    scheduler::init();
    time::init();
}

/// REQ: SCHED-010 - Start the scheduler
/// 
/// Begins executing tasks. This function does not return.
///
/// # Safety
/// - Must be called after init()
/// - Must be called with interrupts disabled
/// - Transfers control to highest-priority ready task
pub unsafe fn start() -> ! {
    scheduler::start()
}
