//! Kernel core module
//!
//! Provides task management, scheduling, and context switching

pub mod scheduler;
pub mod task;
mod context;

use core::sync::atomic::{AtomicBool, Ordering};

static KERNEL_INITIALIZED: AtomicBool = AtomicBool::new(false);

/// Initialize the kernel
pub fn init() {
    if KERNEL_INITIALIZED.load(Ordering::Acquire) {
        return;
    }
    
    scheduler::init();
    KERNEL_INITIALIZED.store(true, Ordering::Release);
}

/// Start the kernel scheduler
pub fn start() -> ! {
    if !KERNEL_INITIALIZED.load(Ordering::Acquire) {
        panic!("Kernel not initialized");
    }
    
    scheduler::start()
}
