//! REQ: APP-001 - Example Application
//!
//! Demonstrates RustOS kernel features.

#![no_std]
#![no_main]

use core::ptr::addr_of_mut;
use rustos_board as _;
use rustos_hal::println;
use rustos_kernel::{Task, TaskId, TaskPriority};

// REQ: TASK-004 - Task stacks
static mut TASK1_STACK: [u8; 2048] = [0; 2048];
static mut TASK2_STACK: [u8; 2048] = [0; 2048];
static mut IDLE_STACK: [u8; 2048] = [0; 2048];

// Task objects
static mut TASK1: Option<Task> = None;
static mut TASK2: Option<Task> = None;
static mut IDLE: Option<Task> = None;

/// REQ: APP-002 - Main entry point
#[no_mangle]
fn main() -> ! {
    // SAFETY: This is single-threaded initialization before scheduler starts.
    // No other code can access these statics until tasks are running.
    unsafe {
        // REQ: BOARD-002 - Board already initialized by startup code

        println!("RustOS Starting...");
        println!("Kernel: rustos-kernel v0.1.0");
        println!("Board: Digilent Arty A7-35");
        println!("CPU: MicroBlaze V RISC-V @ 75 MHz");

        // REQ: TASK-003 - Create tasks
        // Use addr_of_mut! to safely get mutable pointers to static arrays
        TASK1 = Some(Task::new(
            TaskId(0),
            "task1",
            TaskPriority(10),
            task1_entry,
            &mut *addr_of_mut!(TASK1_STACK),
        ));

        TASK2 = Some(Task::new(
            TaskId(1),
            "task2",
            TaskPriority(20),
            task2_entry,
            &mut *addr_of_mut!(TASK2_STACK),
        ));

        IDLE = Some(Task::new(
            TaskId(15),
            "idle",
            TaskPriority::LOWEST,
            idle_task,
            &mut *addr_of_mut!(IDLE_STACK),
        ));

        // REQ: SCHED-005 - Add tasks to scheduler
        let scheduler = rustos_kernel::scheduler::get();

        // SAFETY: Tasks were just initialized above, so as_mut() will return Some
        // Using match to handle the Option explicitly without unwrap
        if let Some(task1) = (*addr_of_mut!(TASK1)).as_mut() {
            let _ = scheduler.add_task(task1);
        }
        if let Some(task2) = (*addr_of_mut!(TASK2)).as_mut() {
            let _ = scheduler.add_task(task2);
        }
        if let Some(idle) = (*addr_of_mut!(IDLE)).as_mut() {
            let _ = scheduler.add_task(idle);
        }

        println!("Tasks created. Starting scheduler...\n");

        // REQ: SCHED-010 - Start scheduler (never returns)
        rustos_kernel::start()
    }
}

/// REQ: APP-003 - Task 1: Blink LED
extern "C" fn task1_entry() -> ! {
    println!("[Task1] Started");

    let mut counter = 0u32;
    loop {
        println!("[Task1] Counter: {}", counter);
        counter = counter.wrapping_add(1);

        // REQ: TIME-009 - Task delay
        rustos_kernel::time::delay_ms(1000);
    }
}

/// REQ: APP-004 - Task 2: Print messages
extern "C" fn task2_entry() -> ! {
    println!("[Task2] Started");

    loop {
        println!("[Task2] Hello from task 2");

        // REQ: TIME-009 - Task delay
        rustos_kernel::time::delay_ms(2000);
    }
}

/// REQ: SCHED-006, SCHED-013 - Idle task
extern "C" fn idle_task() -> ! {
    loop {
        // REQ: PWR-001, PWR-002 - Use kernel power management
        rustos_kernel::power::wait_for_interrupt();
    }
}

// REQ: PAN-001 - Panic handler now provided by rustos-kernel
