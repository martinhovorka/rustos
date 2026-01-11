//! Basic example demonstrating RustOS features
//!
//! This example shows:
//! - Task creation and management
//! - UART communication
//! - GPIO control
//! - Synchronization primitives

#![no_std]
#![no_main]

use core::panic::PanicInfo;
use rustos::hal::{gpio, uart, timer, interrupt};
use rustos::kernel::{scheduler, task};
use rustos::sync::Mutex;

// Shared counter protected by mutex
static COUNTER: Mutex<u32> = Mutex::new(0);

// Task stacks (must be static for task lifetime)
static mut TASK1_STACK: [u8; 1024] = [0; 1024];
static mut TASK2_STACK: [u8; 1024] = [0; 1024];
static mut TASK3_STACK: [u8; 1024] = [0; 1024];

// Task 1: Blink LED on GPIO pin 0
fn task1() {
    loop {
        unsafe {
            gpio::GPIO.toggle_pin(0);
        }
        rustos::time::delay_ms(500);
    }
}

// Task 2: Send UART messages
fn task2() {
    let mut count = 0u32;
    loop {
        // Update shared counter
        {
            let mut counter = COUNTER.lock();
            *counter += 1;
            count = *counter;
        }

        // Send message
        unsafe {
            use core::fmt::Write;
            let _ = write!(uart::UART0, "Task 2: Counter = {}\r\n", count);
        }

        rustos::time::delay_ms(1000);
    }
}

// Task 3: Monitor and report
fn task3() {
    loop {
        let counter_value = {
            let counter = COUNTER.lock();
            *counter
        };

        unsafe {
            use core::fmt::Write;
            let _ = write!(uart::UART0, "Task 3: Monitoring, counter = {}\r\n", counter_value);
        }

        rustos::time::delay_ms(2000);
    }
}

#[no_mangle]
pub extern "C" fn _start() -> ! {
    // Initialize RustOS kernel
    rustos::init();

    // Initialize hardware
    uart::init_uart0();
    gpio::init_gpio();
    timer::init_system_timer();
    interrupt::init_intc();

    unsafe {
        use core::fmt::Write;
        let _ = writeln!(uart::UART0, "\r\n=== RustOS Starting ===\r\n");

        // Configure GPIO pin 0 as output for LED
        gpio::GPIO.set_direction(0, gpio::Direction::Output);

        // Create task control blocks
        let mut task1_tcb = task::TaskControlBlock::new(
            10,
            task1,
            TASK1_STACK.as_mut_ptr(),
            TASK1_STACK.len(),
        );

        let mut task2_tcb = task::TaskControlBlock::new(
            8,
            task2,
            TASK2_STACK.as_mut_ptr(),
            TASK2_STACK.len(),
        );

        let mut task3_tcb = task::TaskControlBlock::new(
            6,
            task3,
            TASK3_STACK.as_mut_ptr(),
            TASK3_STACK.len(),
        );

        // Initialize task stacks
        task1_tcb.init_stack();
        task2_tcb.init_stack();
        task3_tcb.init_stack();

        // Add tasks to scheduler
        scheduler::add_task(&mut task1_tcb);
        scheduler::add_task(&mut task2_tcb);
        scheduler::add_task(&mut task3_tcb);

        let _ = writeln!(uart::UART0, "Tasks created and added to scheduler\r\n");

        // Enable global interrupts
        interrupt::enable_global_interrupts();

        let _ = writeln!(uart::UART0, "Starting scheduler...\r\n");
    }

    // Start the scheduler (never returns)
    rustos::start()
}

#[panic_handler]
fn panic(info: &PanicInfo) -> ! {
    unsafe {
        use core::fmt::Write;
        let _ = writeln!(uart::UART0, "\r\n!!! PANIC !!!\r\n{}\r\n", info);
    }

    loop {
        core::hint::spin_loop();
    }
}
