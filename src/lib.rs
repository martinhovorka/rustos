//! # RustOS
//!
//! A preemptive, priority-based real-time operating system written in Rust
//! for RISC-V embedded systems.
//!
//! ## Features
//!
//! - Preemptive multitasking with priority-based scheduling
//! - Synchronization primitives (Mutex, Semaphore, Message Queue, Event Flags)
//! - Static memory allocation
//! - Hardware Abstraction Layer (UART, Timer, GPIO, SPI, I2C, Ethernet, Interrupt Controller, Watchdog)
//! - Designed for MicroBlaze V (rv32imafcb_zicsr_zifencei_zbc) soft-core processor
//! - Optimized for Digilent Arty A7-35 FPGA board

#![no_std]
#![feature(asm_experimental_arch)]

pub mod hal;
pub mod kernel;
pub mod sync;
pub mod time;

pub use kernel::scheduler;
pub use kernel::task;

/// Initialize the RustOS kernel
pub fn init() {
    kernel::init();
}

/// Start the RustOS scheduler
pub fn start() -> ! {
    kernel::start()
}
