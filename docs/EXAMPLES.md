# RustOS Example Applications

**REQ: DOC-013 - Example Applications Documentation**

This document provides complete, working example applications demonstrating common patterns and use cases for RustOS.

## Table of Contents

1. [LED Blinker](#example-1-led-blinker)
2. [Producer-Consumer](#example-2-producer-consumer)
3. [Event-Driven Architecture](#example-3-event-driven-architecture)
4. [Real-Time Data Acquisition](#example-4-real-time-data-acquisition)
5. [State Machine Controller](#example-5-state-machine-controller)
6. [Watchdog Supervisor](#example-6-watchdog-supervisor)
7. [Serial Command Interface](#example-7-serial-command-interface)
8. [SPI Flash Logger](#example-8-spi-flash-logger)

---

## Example 1: LED Blinker

**Demonstrates**: Basic task creation, GPIO control, delays

The classic "Hello World" of embedded systems.

```rust
//! LED Blinker - Basic task demonstration
//!
//! Blinks an LED at 1 Hz using a dedicated task.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    time::delay_ms,
};
use rustos_hal::gpio::Gpio;
use rustos_pac::GPIO0_BASE;

// Task storage
static mut BLINK_STACK: [usize; 256] = [0; 256];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut BLINK_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

// GPIO for LED
static mut GPIO: Option<Gpio> = None;

const LED_PIN: u8 = 0;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    // Initialize hardware
    rustos_board::init();
    
    // Configure GPIO
    GPIO = Some(Gpio::new(GPIO0_BASE));
    GPIO.as_ref().unwrap().set_direction(LED_PIN, true); // Output
    
    // Create tasks
    BLINK_TASK = Some(TaskBuilder::new(TaskId(1), "blinker")
        .priority(TaskPriority(100))
        .build(blink_task, &mut BLINK_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    // Register tasks
    let sched = scheduler::get();
    sched.add_task(BLINK_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    // Start scheduler
    scheduler::start()
}

/// Blink LED at 1 Hz
fn blink_task() -> ! {
    let gpio = unsafe { GPIO.as_ref().unwrap() };
    let mut led_state = false;
    
    loop {
        led_state = !led_state;
        gpio.write(LED_PIN, led_state);
        delay_ms(500); // 500ms on, 500ms off = 1 Hz
    }
}

/// Idle task - low power wait
fn idle_task() -> ! {
    loop {
        unsafe { core::arch::asm!("wfi"); }
    }
}

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 2: Producer-Consumer

**Demonstrates**: Queues, semaphores, inter-task communication

Classic pattern for decoupling data production from consumption.

```rust
//! Producer-Consumer Pattern
//!
//! One task generates data, another processes it.
//! Demonstrates Queue and Semaphore usage.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::{Queue, Semaphore},
    time::{delay_ms, get_ticks},
};

// Configuration
const BUFFER_SIZE: usize = 16;

// Shared data structures
static DATA_QUEUE: Queue<SensorData, BUFFER_SIZE> = Queue::new();
static ITEMS_AVAILABLE: Semaphore = Semaphore::new(0);
static SPACE_AVAILABLE: Semaphore = Semaphore::new(BUFFER_SIZE as u32);

// Data type
#[derive(Clone, Copy, Default)]
struct SensorData {
    timestamp: u32,
    value: u16,
    sensor_id: u8,
}

// Task storage
static mut PRODUCER_STACK: [usize; 512] = [0; 512];
static mut CONSUMER_STACK: [usize; 512] = [0; 512];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut PRODUCER_TASK: Option<Task> = None;
static mut CONSUMER_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Create tasks
    PRODUCER_TASK = Some(TaskBuilder::new(TaskId(1), "producer")
        .priority(TaskPriority(50))
        .build(producer_task, &mut PRODUCER_STACK));
        
    CONSUMER_TASK = Some(TaskBuilder::new(TaskId(2), "consumer")
        .priority(TaskPriority(60))
        .build(consumer_task, &mut CONSUMER_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(PRODUCER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(CONSUMER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Producer: Generate sensor data at 10 Hz
fn producer_task() -> ! {
    let mut counter: u16 = 0;
    
    loop {
        // Wait for space in buffer
        SPACE_AVAILABLE.wait();
        
        // Generate data
        let data = SensorData {
            timestamp: get_ticks(),
            value: read_sensor(0), // Simulated sensor read
            sensor_id: 0,
        };
        
        // Send to queue
        DATA_QUEUE.send(data).ok();
        
        // Signal data available
        ITEMS_AVAILABLE.signal();
        
        counter = counter.wrapping_add(1);
        delay_ms(100); // 10 Hz sampling
    }
}

/// Consumer: Process sensor data
fn consumer_task() -> ! {
    let mut total: u32 = 0;
    let mut count: u32 = 0;
    
    loop {
        // Wait for data
        ITEMS_AVAILABLE.wait();
        
        // Get from queue
        if let Some(data) = DATA_QUEUE.receive() {
            // Free space in buffer
            SPACE_AVAILABLE.signal();
            
            // Process data
            total += data.value as u32;
            count += 1;
            
            // Calculate running average
            let average = total / count;
            
            // Log or display (every 10 samples)
            if count % 10 == 0 {
                log_average(average);
            }
        }
    }
}

fn idle_task() -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}

// Simulated sensor read
fn read_sensor(_id: u8) -> u16 {
    // In real application, read actual hardware
    (get_ticks() & 0xFFF) as u16
}

fn log_average(_avg: u32) {
    // In real application, write to UART or storage
}

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 3: Event-Driven Architecture

**Demonstrates**: EventFlags, multiple event sources, ISR integration

Efficient handling of multiple asynchronous events.

```rust
//! Event-Driven Architecture
//!
//! Central event handler responds to multiple sources:
//! - Timer ticks
//! - Button presses
//! - UART receive
//! - Sensor alerts

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::EventFlags,
    time::delay_ms,
};

// Event flag bits
const EVENT_TIMER_TICK: u32 = 1 << 0;
const EVENT_BUTTON_PRESS: u32 = 1 << 1;
const EVENT_UART_RX: u32 = 1 << 2;
const EVENT_SENSOR_ALERT: u32 = 1 << 3;
const EVENT_ERROR: u32 = 1 << 31;

const ALL_EVENTS: u32 = EVENT_TIMER_TICK | EVENT_BUTTON_PRESS | 
                        EVENT_UART_RX | EVENT_SENSOR_ALERT | EVENT_ERROR;

// Global event flags
static EVENTS: EventFlags = EventFlags::new();

// Task storage
static mut EVENT_HANDLER_STACK: [usize; 512] = [0; 512];
static mut SENSOR_MONITOR_STACK: [usize; 256] = [0; 256];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut EVENT_HANDLER_TASK: Option<Task> = None;
static mut SENSOR_MONITOR_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Install ISR handlers (platform-specific)
    install_timer_isr(timer_isr);
    install_button_isr(button_isr);
    install_uart_isr(uart_isr);
    
    // Create tasks
    EVENT_HANDLER_TASK = Some(TaskBuilder::new(TaskId(1), "event_handler")
        .priority(TaskPriority(20))  // High priority for responsiveness
        .build(event_handler_task, &mut EVENT_HANDLER_STACK));
        
    SENSOR_MONITOR_TASK = Some(TaskBuilder::new(TaskId(2), "sensor_monitor")
        .priority(TaskPriority(50))
        .build(sensor_monitor_task, &mut SENSOR_MONITOR_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(EVENT_HANDLER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(SENSOR_MONITOR_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Central event handler task
fn event_handler_task() -> ! {
    loop {
        // Wait for any event
        let events = EVENTS.wait_any(ALL_EVENTS);
        
        // Handle each event
        if events & EVENT_TIMER_TICK != 0 {
            EVENTS.clear(EVENT_TIMER_TICK);
            handle_timer_tick();
        }
        
        if events & EVENT_BUTTON_PRESS != 0 {
            EVENTS.clear(EVENT_BUTTON_PRESS);
            handle_button_press();
        }
        
        if events & EVENT_UART_RX != 0 {
            EVENTS.clear(EVENT_UART_RX);
            handle_uart_receive();
        }
        
        if events & EVENT_SENSOR_ALERT != 0 {
            EVENTS.clear(EVENT_SENSOR_ALERT);
            handle_sensor_alert();
        }
        
        if events & EVENT_ERROR != 0 {
            EVENTS.clear(EVENT_ERROR);
            handle_error();
        }
    }
}

/// Sensor monitoring task - generates alerts
fn sensor_monitor_task() -> ! {
    const THRESHOLD: u16 = 1000;
    
    loop {
        let value = read_sensor();
        
        if value > THRESHOLD {
            // Signal alert to event handler
            EVENTS.set(EVENT_SENSOR_ALERT);
        }
        
        delay_ms(50); // 20 Hz monitoring
    }
}

// ISR handlers - keep short, just set events
fn timer_isr() {
    EVENTS.set(EVENT_TIMER_TICK);
}

fn button_isr() {
    EVENTS.set(EVENT_BUTTON_PRESS);
}

fn uart_isr() {
    // Read UART data to buffer (quick)
    // ...
    EVENTS.set(EVENT_UART_RX);
}

// Event handlers - can take longer
fn handle_timer_tick() {
    // Update system time, check timeouts, etc.
}

fn handle_button_press() {
    // Debounce and process button action
}

fn handle_uart_receive() {
    // Process received data
}

fn handle_sensor_alert() {
    // Log alert, activate alarm, etc.
}

fn handle_error() {
    // Error recovery
}

fn read_sensor() -> u16 { 0 }
fn idle_task() -> ! { loop { unsafe { core::arch::asm!("wfi"); } } }
fn install_timer_isr(_: fn()) {}
fn install_button_isr(_: fn()) {}
fn install_uart_isr(_: fn()) {}

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    EVENTS.set(EVENT_ERROR);
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 4: Real-Time Data Acquisition

**Demonstrates**: Periodic sampling, precise timing, data buffering

High-frequency data acquisition with guaranteed timing.

```rust
//! Real-Time Data Acquisition System
//!
//! Samples ADC at precise 1 kHz rate, buffers data,
//! and transfers to storage task when buffer is full.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::{Queue, Semaphore, Mutex},
    time::{get_ticks, delay_ticks},
};
use portable_atomic::{AtomicU32, Ordering};

// Configuration
const SAMPLE_RATE_HZ: u32 = 1000;
const BUFFER_SAMPLES: usize = 256;
const NUM_BUFFERS: usize = 4;

// Sample data
#[derive(Clone, Copy, Default)]
struct Sample {
    timestamp: u32,
    channel0: u16,
    channel1: u16,
}

// Buffer type
type SampleBuffer = [Sample; BUFFER_SAMPLES];

// Double buffering: one being filled, one being processed
static BUFFER_POOL: Queue<usize, NUM_BUFFERS> = Queue::new();
static FULL_BUFFERS: Queue<usize, NUM_BUFFERS> = Queue::new();
static mut BUFFERS: [SampleBuffer; NUM_BUFFERS] = [[Sample { timestamp: 0, channel0: 0, channel1: 0 }; BUFFER_SAMPLES]; NUM_BUFFERS];

// Statistics
static SAMPLES_ACQUIRED: AtomicU32 = AtomicU32::new(0);
static SAMPLES_SAVED: AtomicU32 = AtomicU32::new(0);
static OVERRUNS: AtomicU32 = AtomicU32::new(0);

// Task storage
static mut SAMPLER_STACK: [usize; 512] = [0; 512];
static mut STORAGE_STACK: [usize; 1024] = [0; 1024];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut SAMPLER_TASK: Option<Task> = None;
static mut STORAGE_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Initialize buffer pool
    for i in 0..NUM_BUFFERS {
        BUFFER_POOL.send(i).ok();
    }
    
    // Create tasks
    SAMPLER_TASK = Some(TaskBuilder::new(TaskId(1), "sampler")
        .priority(TaskPriority(10))  // Highest priority for timing
        .build(sampler_task, &mut SAMPLER_STACK));
        
    STORAGE_TASK = Some(TaskBuilder::new(TaskId(2), "storage")
        .priority(TaskPriority(100))  // Lower priority
        .build(storage_task, &mut STORAGE_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(SAMPLER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(STORAGE_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// High-priority sampler task - must meet timing!
fn sampler_task() -> ! {
    let period_ticks = 1; // 1 tick = 1ms at 1kHz tick rate
    let mut next_sample_time = get_ticks();
    let mut sample_idx = 0usize;
    let mut current_buffer_idx: Option<usize> = None;
    
    loop {
        // Get buffer if we don't have one
        if current_buffer_idx.is_none() {
            current_buffer_idx = BUFFER_POOL.receive();
            if current_buffer_idx.is_none() {
                // Buffer overrun!
                OVERRUNS.fetch_add(1, Ordering::Relaxed);
                // Skip this sample
                next_sample_time = next_sample_time.wrapping_add(period_ticks);
                continue;
            }
            sample_idx = 0;
        }
        
        // Wait for precise sample time
        let now = get_ticks();
        if now < next_sample_time {
            let wait = next_sample_time - now;
            if wait < period_ticks * 2 {
                delay_ticks(wait);
            }
        }
        
        // Take sample
        let sample = Sample {
            timestamp: get_ticks(),
            channel0: read_adc(0),
            channel1: read_adc(1),
        };
        
        // Store in buffer
        if let Some(buf_idx) = current_buffer_idx {
            unsafe {
                BUFFERS[buf_idx][sample_idx] = sample;
            }
            sample_idx += 1;
            SAMPLES_ACQUIRED.fetch_add(1, Ordering::Relaxed);
            
            // Buffer full?
            if sample_idx >= BUFFER_SAMPLES {
                // Send to storage
                FULL_BUFFERS.send(buf_idx).ok();
                current_buffer_idx = None;
            }
        }
        
        // Calculate next sample time (avoids drift)
        next_sample_time = next_sample_time.wrapping_add(period_ticks);
    }
}

/// Storage task - writes buffers to flash/SD
fn storage_task() -> ! {
    loop {
        // Wait for full buffer
        if let Some(buf_idx) = FULL_BUFFERS.receive() {
            // Write to storage (may take time)
            let buffer = unsafe { &BUFFERS[buf_idx] };
            write_to_storage(buffer);
            
            SAMPLES_SAVED.fetch_add(BUFFER_SAMPLES as u32, Ordering::Relaxed);
            
            // Return buffer to pool
            BUFFER_POOL.send(buf_idx).ok();
        } else {
            // No buffer ready, yield
            scheduler::yield_now();
        }
    }
}

fn read_adc(_channel: u8) -> u16 {
    // Read actual ADC hardware
    0
}

fn write_to_storage(_buffer: &SampleBuffer) {
    // Write to SPI flash or SD card
}

fn idle_task() -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 5: State Machine Controller

**Demonstrates**: State machine pattern, clean state transitions

Implementing a motor controller with explicit state management.

```rust
//! State Machine Motor Controller
//!
//! Controls a motor through states: Idle, Starting, Running, Stopping, Fault

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::{Queue, EventFlags},
    time::{delay_ms, get_ticks},
};

// Commands
#[derive(Clone, Copy)]
enum Command {
    Start,
    Stop,
    SetSpeed(u16),
    EmergencyStop,
    Reset,
}

// Motor states
#[derive(Clone, Copy, PartialEq)]
enum MotorState {
    Idle,
    Starting,
    Running { speed: u16 },
    Stopping,
    Fault { code: u8 },
}

// Events
const EVT_COMMAND: u32 = 1 << 0;
const EVT_MOTOR_READY: u32 = 1 << 1;
const EVT_MOTOR_STOPPED: u32 = 1 << 2;
const EVT_FAULT: u32 = 1 << 3;

static COMMANDS: Queue<Command, 8> = Queue::new();
static EVENTS: EventFlags = EventFlags::new();

// Task storage
static mut CONTROLLER_STACK: [usize; 512] = [0; 512];
static mut UI_STACK: [usize; 256] = [0; 256];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut CONTROLLER_TASK: Option<Task> = None;
static mut UI_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    CONTROLLER_TASK = Some(TaskBuilder::new(TaskId(1), "motor_ctrl")
        .priority(TaskPriority(30))
        .build(motor_controller_task, &mut CONTROLLER_STACK));
        
    UI_TASK = Some(TaskBuilder::new(TaskId(2), "ui")
        .priority(TaskPriority(100))
        .build(ui_task, &mut UI_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(CONTROLLER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(UI_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Motor controller state machine
fn motor_controller_task() -> ! {
    let mut state = MotorState::Idle;
    let mut state_entry_time = get_ticks();
    
    loop {
        // Process events and commands
        let events = EVENTS.get();
        let command = COMMANDS.receive();
        
        // State machine
        let next_state = match state {
            MotorState::Idle => {
                handle_idle_state(command, events)
            }
            MotorState::Starting => {
                handle_starting_state(command, events, state_entry_time)
            }
            MotorState::Running { speed } => {
                handle_running_state(command, events, speed)
            }
            MotorState::Stopping => {
                handle_stopping_state(command, events, state_entry_time)
            }
            MotorState::Fault { code } => {
                handle_fault_state(command, events, code)
            }
        };
        
        // State transition?
        if next_state != state {
            // Exit current state
            exit_state(&state);
            
            // Enter new state
            state = next_state;
            state_entry_time = get_ticks();
            enter_state(&state);
        }
        
        // Clear processed events
        if events != 0 {
            EVENTS.clear(events);
        }
        
        delay_ms(10); // 100 Hz control loop
    }
}

fn handle_idle_state(cmd: Option<Command>, _events: u32) -> MotorState {
    match cmd {
        Some(Command::Start) => MotorState::Starting,
        _ => MotorState::Idle,
    }
}

fn handle_starting_state(cmd: Option<Command>, events: u32, entry_time: u32) -> MotorState {
    // Emergency stop always takes priority
    if matches!(cmd, Some(Command::EmergencyStop)) {
        return MotorState::Fault { code: 1 };
    }
    
    // Check for motor ready signal
    if events & EVT_MOTOR_READY != 0 {
        return MotorState::Running { speed: 0 };
    }
    
    // Timeout check
    if get_ticks().wrapping_sub(entry_time) > 5000 {
        return MotorState::Fault { code: 2 }; // Startup timeout
    }
    
    MotorState::Starting
}

fn handle_running_state(cmd: Option<Command>, events: u32, speed: u16) -> MotorState {
    // Fault detection
    if events & EVT_FAULT != 0 {
        return MotorState::Fault { code: 3 };
    }
    
    match cmd {
        Some(Command::Stop) => MotorState::Stopping,
        Some(Command::EmergencyStop) => MotorState::Fault { code: 1 },
        Some(Command::SetSpeed(new_speed)) => {
            set_motor_speed(new_speed);
            MotorState::Running { speed: new_speed }
        }
        _ => MotorState::Running { speed },
    }
}

fn handle_stopping_state(cmd: Option<Command>, events: u32, entry_time: u32) -> MotorState {
    if matches!(cmd, Some(Command::EmergencyStop)) {
        return MotorState::Fault { code: 1 };
    }
    
    if events & EVT_MOTOR_STOPPED != 0 {
        return MotorState::Idle;
    }
    
    // Stop timeout
    if get_ticks().wrapping_sub(entry_time) > 3000 {
        return MotorState::Fault { code: 4 };
    }
    
    MotorState::Stopping
}

fn handle_fault_state(cmd: Option<Command>, _events: u32, code: u8) -> MotorState {
    if matches!(cmd, Some(Command::Reset)) {
        clear_fault();
        return MotorState::Idle;
    }
    MotorState::Fault { code }
}

fn enter_state(state: &MotorState) {
    match state {
        MotorState::Idle => {
            set_status_led(false);
        }
        MotorState::Starting => {
            start_motor_sequence();
            set_status_led(true);
        }
        MotorState::Running { .. } => {
            // Motor already running
        }
        MotorState::Stopping => {
            stop_motor_sequence();
        }
        MotorState::Fault { code } => {
            emergency_stop_motor();
            log_fault(*code);
            blink_fault_led(*code);
        }
    }
}

fn exit_state(state: &MotorState) {
    match state {
        MotorState::Fault { .. } => {
            clear_fault_led();
        }
        _ => {}
    }
}

/// UI task - handles buttons and display
fn ui_task() -> ! {
    loop {
        if button_pressed(0) {
            COMMANDS.send(Command::Start).ok();
        }
        if button_pressed(1) {
            COMMANDS.send(Command::Stop).ok();
        }
        if button_pressed(2) {
            COMMANDS.send(Command::EmergencyStop).ok();
        }
        
        delay_ms(50);
    }
}

// Hardware abstraction stubs
fn set_motor_speed(_speed: u16) {}
fn start_motor_sequence() {}
fn stop_motor_sequence() {}
fn emergency_stop_motor() {}
fn clear_fault() {}
fn log_fault(_code: u8) {}
fn set_status_led(_on: bool) {}
fn blink_fault_led(_code: u8) {}
fn clear_fault_led() {}
fn button_pressed(_n: u8) -> bool { false }
fn idle_task() -> ! { loop { unsafe { core::arch::asm!("wfi"); } } }

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 6: Watchdog Supervisor

**Demonstrates**: Watchdog timer, task health monitoring, fault recovery

System supervisor that monitors all tasks and handles failures.

```rust
//! Watchdog Supervisor Pattern
//!
//! Monitors task health via heartbeats, kicks hardware watchdog,
//! and handles task failures.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    time::{delay_ms, get_ticks},
};
use rustos_hal::wdt::Wdt;
use rustos_pac::WDT_BASE;
use portable_atomic::{AtomicU32, Ordering};

// Number of monitored tasks
const NUM_TASKS: usize = 3;

// Heartbeat timeout (ms)
const HEARTBEAT_TIMEOUT_MS: u32 = 2000;

// Hardware watchdog timeout (ms)
const WDT_TIMEOUT_MS: u32 = 5000;

// Task heartbeats (updated by each task)
static HEARTBEATS: [AtomicU32; NUM_TASKS] = [
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
];

// Task health status
static TASK_HEALTHY: [AtomicU32; NUM_TASKS] = [
    AtomicU32::new(1),
    AtomicU32::new(1),
    AtomicU32::new(1),
];

// Task storage
static mut SUPERVISOR_STACK: [usize; 512] = [0; 512];
static mut TASK1_STACK: [usize; 256] = [0; 256];
static mut TASK2_STACK: [usize; 256] = [0; 256];
static mut TASK3_STACK: [usize; 256] = [0; 256];
static mut IDLE_STACK: [usize; 128] = [0; 128];

static mut SUPERVISOR_TASK: Option<Task> = None;
static mut TASK1: Option<Task> = None;
static mut TASK2: Option<Task> = None;
static mut TASK3: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

// Hardware watchdog
static mut WDT: Option<Wdt> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Initialize watchdog
    WDT = Some(Wdt::new(WDT_BASE));
    WDT.as_ref().unwrap().start(WDT_TIMEOUT_MS);
    
    // Create tasks
    SUPERVISOR_TASK = Some(TaskBuilder::new(TaskId(1), "supervisor")
        .priority(TaskPriority(5))  // Highest priority
        .build(supervisor_task, &mut SUPERVISOR_STACK));
        
    TASK1 = Some(TaskBuilder::new(TaskId(2), "task1")
        .priority(TaskPriority(50))
        .build(|| worker_task(0), &mut TASK1_STACK));
        
    TASK2 = Some(TaskBuilder::new(TaskId(3), "task2")
        .priority(TaskPriority(50))
        .build(|| worker_task(1), &mut TASK2_STACK));
        
    TASK3 = Some(TaskBuilder::new(TaskId(4), "task3")
        .priority(TaskPriority(50))
        .build(|| worker_task(2), &mut TASK3_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(SUPERVISOR_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(TASK1.as_mut().unwrap()).unwrap();
    sched.add_task(TASK2.as_mut().unwrap()).unwrap();
    sched.add_task(TASK3.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Supervisor task - monitors health and kicks watchdog
fn supervisor_task() -> ! {
    loop {
        let now = get_ticks();
        let mut all_healthy = true;
        
        // Check each task's heartbeat
        for i in 0..NUM_TASKS {
            let last_heartbeat = HEARTBEATS[i].load(Ordering::Acquire);
            let elapsed = now.wrapping_sub(last_heartbeat);
            
            if elapsed > HEARTBEAT_TIMEOUT_MS {
                // Task missed heartbeat!
                TASK_HEALTHY[i].store(0, Ordering::Release);
                all_healthy = false;
                
                // Attempt recovery
                handle_task_failure(i);
            } else {
                TASK_HEALTHY[i].store(1, Ordering::Release);
            }
        }
        
        // Only kick watchdog if all tasks healthy
        if all_healthy {
            unsafe {
                if let Some(ref wdt) = WDT {
                    wdt.kick();
                }
            }
        }
        
        delay_ms(500); // Check every 500ms
    }
}

/// Worker task template
fn worker_task(id: usize) -> ! {
    loop {
        // Do task-specific work
        do_work(id);
        
        // Update heartbeat
        HEARTBEATS[id].store(get_ticks(), Ordering::Release);
        
        delay_ms(100);
    }
}

fn handle_task_failure(task_id: usize) {
    // Log the failure
    log_error(task_id);
    
    // Attempt to restart task (platform-specific)
    // In a real system, might:
    // - Reset task state
    // - Clear queues
    // - Reinitialize peripherals
    
    // For now, just log
    // If multiple failures occur, watchdog will reset system
}

fn do_work(_task_id: usize) {
    // Task-specific work
}

fn log_error(_task_id: usize) {
    // Log to UART or storage
}

fn idle_task() -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    // Don't kick watchdog - let system reset
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 7: Serial Command Interface

**Demonstrates**: UART communication, command parsing, interactive shell

Simple command-line interface over UART.

```rust
//! Serial Command Interface
//!
//! Interactive shell over UART for debugging and control.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::Mutex,
    time::delay_ms,
};
use rustos_hal::uart::Uart;
use rustos_pac::UART0_BASE;

// Command buffer
const CMD_BUFFER_SIZE: usize = 64;

// Protected UART
static UART: Mutex<Option<Uart>> = Mutex::new(None);

// Task storage
static mut SHELL_STACK: [usize; 1024] = [0; 1024];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut SHELL_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Initialize UART
    {
        let mut uart_guard = UART.lock();
        *uart_guard = Some(Uart::new(UART0_BASE));
    }
    
    SHELL_TASK = Some(TaskBuilder::new(TaskId(1), "shell")
        .priority(TaskPriority(100))
        .build(shell_task, &mut SHELL_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(SHELL_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Interactive shell task
fn shell_task() -> ! {
    let mut cmd_buffer = [0u8; CMD_BUFFER_SIZE];
    let mut cmd_len = 0usize;
    
    print_banner();
    print_prompt();
    
    loop {
        // Check for input
        if let Some(ch) = read_char() {
            match ch {
                // Enter - execute command
                b'\r' | b'\n' => {
                    print_str("\r\n");
                    if cmd_len > 0 {
                        execute_command(&cmd_buffer[..cmd_len]);
                        cmd_len = 0;
                    }
                    print_prompt();
                }
                // Backspace
                b'\x08' | b'\x7F' => {
                    if cmd_len > 0 {
                        cmd_len -= 1;
                        print_str("\x08 \x08"); // Erase character
                    }
                }
                // Regular character
                _ => {
                    if cmd_len < CMD_BUFFER_SIZE - 1 {
                        cmd_buffer[cmd_len] = ch;
                        cmd_len += 1;
                        print_char(ch);
                    }
                }
            }
        }
        
        delay_ms(10);
    }
}

fn execute_command(cmd: &[u8]) {
    // Parse command
    let cmd_str = core::str::from_utf8(cmd).unwrap_or("");
    let parts: heapless::Vec<&str, 4> = cmd_str.split_whitespace().collect();
    
    if parts.is_empty() {
        return;
    }
    
    match parts[0] {
        "help" | "?" => cmd_help(),
        "status" => cmd_status(),
        "tasks" => cmd_tasks(),
        "mem" => cmd_memory(),
        "gpio" => {
            if parts.len() >= 3 {
                cmd_gpio(parts[1], parts[2]);
            } else {
                print_str("Usage: gpio <pin> <0|1>\r\n");
            }
        }
        "reset" => cmd_reset(),
        "version" => cmd_version(),
        _ => {
            print_str("Unknown command: ");
            print_str(cmd_str);
            print_str("\r\nType 'help' for available commands.\r\n");
        }
    }
}

fn cmd_help() {
    print_str("Available commands:\r\n");
    print_str("  help     - Show this help\r\n");
    print_str("  status   - Show system status\r\n");
    print_str("  tasks    - List running tasks\r\n");
    print_str("  mem      - Show memory usage\r\n");
    print_str("  gpio N V - Set GPIO pin N to value V\r\n");
    print_str("  reset    - Reset system\r\n");
    print_str("  version  - Show version info\r\n");
}

fn cmd_status() {
    print_str("System Status:\r\n");
    print_str("  Uptime: ");
    print_u32(rustos_kernel::time::get_uptime_ms() / 1000);
    print_str(" seconds\r\n");
    
    #[cfg(feature = "statistics")]
    {
        print_str("  Context switches: ");
        print_u32(scheduler::get_context_switch_count());
        print_str("\r\n");
    }
}

fn cmd_tasks() {
    print_str("Task List:\r\n");
    print_str("  ID  Name         Priority  State\r\n");
    print_str("  --  -----------  --------  -----\r\n");
    // In real implementation, iterate through tasks
    print_str("  1   shell        100       RUNNING\r\n");
    print_str("  0   idle         255       READY\r\n");
}

fn cmd_memory() {
    print_str("Memory Usage:\r\n");
    print_str("  Total:     128 KB\r\n");
    print_str("  Used:      ~58 KB\r\n");
    print_str("  Available: ~70 KB\r\n");
}

fn cmd_gpio(pin_str: &str, val_str: &str) {
    if let (Ok(pin), Ok(val)) = (pin_str.parse::<u8>(), val_str.parse::<u8>()) {
        // Set GPIO (would call actual driver)
        print_str("Set GPIO ");
        print_u32(pin as u32);
        print_str(" = ");
        print_u32(val as u32);
        print_str("\r\n");
    } else {
        print_str("Invalid arguments\r\n");
    }
}

fn cmd_reset() {
    print_str("Resetting...\r\n");
    delay_ms(100);
    // Trigger reset (platform-specific)
    // rustos_hal::system::reset();
}

fn cmd_version() {
    print_str("RustOS v1.0.0\r\n");
    print_str("Built: ");
    print_str(env!("CARGO_PKG_VERSION"));
    print_str("\r\n");
}

fn print_banner() {
    print_str("\r\n");
    print_str("╔═══════════════════════════════════╗\r\n");
    print_str("║         RustOS Shell v1.0         ║\r\n");
    print_str("║   Type 'help' for commands        ║\r\n");
    print_str("╚═══════════════════════════════════╝\r\n");
    print_str("\r\n");
}

fn print_prompt() {
    print_str("rustos> ");
}

fn read_char() -> Option<u8> {
    let guard = UART.lock();
    if let Some(ref uart) = *guard {
        uart.try_read()
    } else {
        None
    }
}

fn print_str(s: &str) {
    let guard = UART.lock();
    if let Some(ref uart) = *guard {
        uart.write_str(s);
    }
}

fn print_char(ch: u8) {
    let guard = UART.lock();
    if let Some(ref uart) = *guard {
        uart.write(ch);
    }
}

fn print_u32(val: u32) {
    let guard = UART.lock();
    if let Some(ref uart) = *guard {
        uart.write_u32(val);
    }
}

fn idle_task() -> ! { loop { unsafe { core::arch::asm!("wfi"); } } }

#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    print_str("\r\n!!! PANIC !!!\r\n");
    if let Some(msg) = info.message() {
        // Print panic message if possible
    }
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Example 8: SPI Flash Logger

**Demonstrates**: SPI driver, flash memory, data logging

Log sensor data to SPI flash for later retrieval.

```rust
//! SPI Flash Data Logger
//!
//! Periodically logs sensor readings to SPI flash memory.

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    sync::Mutex,
    time::{delay_ms, get_ticks},
};
use rustos_hal::spi::Spi;
use rustos_pac::SPI0_BASE;

// Flash commands
const FLASH_WRITE_ENABLE: u8 = 0x06;
const FLASH_PAGE_PROGRAM: u8 = 0x02;
const FLASH_READ_DATA: u8 = 0x03;
const FLASH_READ_STATUS: u8 = 0x05;
const FLASH_SECTOR_ERASE: u8 = 0x20;

// Configuration
const FLASH_PAGE_SIZE: usize = 256;
const LOG_ENTRY_SIZE: usize = 8;
const ENTRIES_PER_PAGE: usize = FLASH_PAGE_SIZE / LOG_ENTRY_SIZE;

// Log entry structure
#[derive(Clone, Copy)]
#[repr(C, packed)]
struct LogEntry {
    timestamp: u32,
    sensor_value: u16,
    status: u8,
    checksum: u8,
}

// Protected SPI
static SPI: Mutex<Option<Spi>> = Mutex::new(None);

// Current write position
static mut WRITE_ADDRESS: u32 = 0;
static mut ENTRY_COUNT: u32 = 0;

// Task storage
static mut LOGGER_STACK: [usize; 512] = [0; 512];
static mut READER_STACK: [usize; 512] = [0; 512];
static mut IDLE_STACK: [usize; 128] = [0; 128];
static mut LOGGER_TASK: Option<Task> = None;
static mut READER_TASK: Option<Task> = None;
static mut IDLE_TASK: Option<Task> = None;

#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    rustos_board::init();
    
    // Initialize SPI
    {
        let mut spi_guard = SPI.lock();
        *spi_guard = Some(Spi::new(SPI0_BASE));
        if let Some(ref spi) = *spi_guard {
            spi.configure(1_000_000, 0, 0); // 1 MHz, mode 0
        }
    }
    
    LOGGER_TASK = Some(TaskBuilder::new(TaskId(1), "logger")
        .priority(TaskPriority(50))
        .build(logger_task, &mut LOGGER_STACK));
        
    READER_TASK = Some(TaskBuilder::new(TaskId(2), "reader")
        .priority(TaskPriority(100))
        .build(reader_task, &mut READER_STACK));
        
    IDLE_TASK = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    let sched = scheduler::get();
    sched.add_task(LOGGER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(READER_TASK.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE_TASK.as_mut().unwrap()).unwrap();
    
    scheduler::start()
}

/// Logger task - writes sensor data to flash
fn logger_task() -> ! {
    let mut page_buffer = [0u8; FLASH_PAGE_SIZE];
    let mut buffer_idx = 0usize;
    
    loop {
        // Read sensor
        let entry = LogEntry {
            timestamp: get_ticks(),
            sensor_value: read_sensor(),
            status: 0,
            checksum: 0, // Calculate checksum
        };
        
        // Copy to page buffer
        let entry_bytes = unsafe {
            core::slice::from_raw_parts(
                &entry as *const LogEntry as *const u8,
                LOG_ENTRY_SIZE
            )
        };
        page_buffer[buffer_idx..buffer_idx + LOG_ENTRY_SIZE]
            .copy_from_slice(entry_bytes);
        buffer_idx += LOG_ENTRY_SIZE;
        
        // Page full?
        if buffer_idx >= FLASH_PAGE_SIZE {
            // Write page to flash
            write_flash_page(unsafe { WRITE_ADDRESS }, &page_buffer);
            
            // Update position
            unsafe {
                WRITE_ADDRESS += FLASH_PAGE_SIZE as u32;
                ENTRY_COUNT += ENTRIES_PER_PAGE as u32;
            }
            
            buffer_idx = 0;
        }
        
        delay_ms(1000); // Log every second
    }
}

/// Reader task - dumps log on request
fn reader_task() -> ! {
    loop {
        // Check for read request (e.g., button press)
        if read_request_pending() {
            dump_log();
        }
        delay_ms(100);
    }
}

fn write_flash_page(address: u32, data: &[u8]) {
    let mut guard = SPI.lock();
    if let Some(ref spi) = *guard {
        // Write enable
        spi.select();
        spi.transfer(&[FLASH_WRITE_ENABLE]).ok();
        spi.deselect();
        
        // Page program command
        spi.select();
        let cmd = [
            FLASH_PAGE_PROGRAM,
            (address >> 16) as u8,
            (address >> 8) as u8,
            address as u8,
        ];
        spi.transfer(&cmd).ok();
        spi.transfer(data).ok();
        spi.deselect();
        
        // Wait for write complete
        wait_flash_ready(spi);
    }
}

fn read_flash(address: u32, buffer: &mut [u8]) {
    let guard = SPI.lock();
    if let Some(ref spi) = *guard {
        spi.select();
        let cmd = [
            FLASH_READ_DATA,
            (address >> 16) as u8,
            (address >> 8) as u8,
            address as u8,
        ];
        spi.transfer(&cmd).ok();
        spi.receive(buffer).ok();
        spi.deselect();
    }
}

fn wait_flash_ready(spi: &Spi) {
    loop {
        spi.select();
        let mut status = [0u8; 2];
        status[0] = FLASH_READ_STATUS;
        spi.transfer(&mut status).ok();
        spi.deselect();
        
        if status[1] & 0x01 == 0 {
            break; // Not busy
        }
        delay_ms(1);
    }
}

fn dump_log() {
    let entry_count = unsafe { ENTRY_COUNT };
    let mut buffer = [0u8; LOG_ENTRY_SIZE];
    
    for i in 0..entry_count {
        let address = i * LOG_ENTRY_SIZE as u32;
        read_flash(address, &mut buffer);
        
        // Print entry (via UART)
        // parse_and_print_entry(&buffer);
    }
}

fn read_sensor() -> u16 {
    // Read actual sensor
    (get_ticks() & 0xFFF) as u16
}

fn read_request_pending() -> bool {
    // Check button or UART command
    false
}

fn idle_task() -> ! { loop { unsafe { core::arch::asm!("wfi"); } } }

#[panic_handler]
fn panic(_: &core::panic::PanicInfo) -> ! {
    loop { unsafe { core::arch::asm!("wfi"); } }
}
```

---

## Summary

| Example | Key Concepts | Complexity |
|---------|--------------|------------|
| LED Blinker | Tasks, GPIO, delays | ⭐ |
| Producer-Consumer | Queues, semaphores | ⭐⭐ |
| Event-Driven | EventFlags, ISRs | ⭐⭐ |
| Data Acquisition | Precise timing, buffering | ⭐⭐⭐ |
| State Machine | Clean state management | ⭐⭐⭐ |
| Watchdog Supervisor | Health monitoring | ⭐⭐⭐ |
| Serial Shell | UART, command parsing | ⭐⭐⭐ |
| SPI Flash Logger | SPI driver, flash storage | ⭐⭐⭐⭐ |

For more details, see:
- [Getting Started Guide](GETTING_STARTED.md)
- [Task Programming Guide](TASK_PROGRAMMING.md)
- [Sync Primitives Guide](SYNC_PRIMITIVES.md)
