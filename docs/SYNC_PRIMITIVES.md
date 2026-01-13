# RustOS Synchronization Primitives Guide

REQ: DOC-012 - Synchronization Primitives Documentation

This guide covers the synchronization primitives available in RustOS for safe inter-task communication and resource sharing.

## Table of Contents

1. [Overview](#overview)
2. [Mutex](#mutex)
3. [Semaphore](#semaphore)
4. [Queue](#queue)
5. [Priority Queue](#priority-queue)
6. [Event Flags](#event-flags)
7. [Choosing the Right Primitive](#choosing-the-right-primitive)
8. [Advanced Topics](#advanced-topics)

---

## Overview

### Why Synchronization?

In a multitasking system, tasks run concurrently and may need to:

- Share data safely
- Coordinate execution order
- Signal events between tasks
- Protect hardware resources

**Without synchronization**, you get:

- Race conditions
- Data corruption
- Unpredictable behavior
- Hard-to-debug crashes

### Available Primitives

| Primitive | Purpose | Use Case |
|-----------|---------|----------|
| **Mutex** | Mutual exclusion | Protect shared data |
| **Semaphore** | Resource counting | Limit concurrent access |
| **Queue** | Data transfer | Producer-consumer patterns |
| **PriorityQueue** | Priority data transfer | Urgent event handling |
| **EventFlags** | Event notification | Signal state changes |

---

## Mutex

### What is a Mutex?

A **Mutex** (Mutual Exclusion) ensures only one task can access a protected resource at a time. When a task "locks" the mutex, other tasks must wait.

### API Reference

```rust
use rustos_kernel::sync::Mutex;

// Create mutex with protected data
static DATA: Mutex<MyData> = Mutex::new(MyData::new());

// Lock and access (blocking)
let guard = DATA.lock();
// Access data through guard
guard.do_something();
// Automatically unlocked when guard is dropped

// Try to lock (non-blocking)
if let Some(guard) = DATA.try_lock() {
    // Got the lock
    guard.do_something();
} else {
    // Lock not available
}

// Check owner
if let Some(owner_id) = DATA.owner() {
    // Mutex is held by owner_id
}
```

### Example: Shared Counter

```rust
use rustos_kernel::sync::Mutex;
use portable_atomic::{AtomicU32, Ordering};

// Protected counter
static COUNTER: Mutex<u32> = Mutex::new(0);

fn increment_task() -> ! {
    loop {
        {
            let mut guard = COUNTER.lock();
            *guard += 1;
            // Lock released here when guard goes out of scope
        }
        delay_ms(100);
    }
}

fn read_task() -> ! {
    loop {
        let value = {
            let guard = COUNTER.lock();
            *guard
        };
        print_value(value);
        delay_ms(500);
    }
}
```

### Example: Protected Hardware Resource

```rust
use rustos_kernel::sync::Mutex;
use rustos_hal::uart::Uart;

// Protect UART from concurrent access
static UART: Mutex<Option<Uart>> = Mutex::new(None);

fn init_uart() {
    let mut guard = UART.lock();
    *guard = Some(Uart::new(UART0_BASE));
}

fn safe_print(msg: &str) {
    let guard = UART.lock();
    if let Some(ref uart) = *guard {
        uart.write_str(msg);
    }
}
```

### Priority Inheritance

When enabled (`priority-inheritance` feature), mutexes prevent priority inversion:

```rust
// Low priority task holds mutex
fn low_priority_task() -> ! {
    loop {
        let _guard = SHARED.lock();  // Gets lock
        do_slow_work();              // If high-priority task waits here,
                                     // this task's priority is boosted
    }
}

// High priority task needs mutex
fn high_priority_task() -> ! {
    loop {
        let _guard = SHARED.lock();  // May need to wait
        do_critical_work();
    }
}
```

### Best Practices

✅ **Do:**

- Keep critical sections short
- Always use RAII guards (no manual unlock)
- Lock in consistent order to avoid deadlock

❌ **Don't:**

- Hold locks while waiting/sleeping
- Nest many mutex locks
- Use in interrupt handlers (use try_lock instead)

---

## Semaphore

### What is a Semaphore?

A **Semaphore** is a counter that controls access to resources. Tasks can:

- **Wait**: Decrement counter (blocks if zero)
- **Signal**: Increment counter

### Types of Semaphores

| Type | Initial Count | Use Case |
|------|---------------|----------|
| Binary | 0 or 1 | Simple synchronization |
| Counting | N | Pool of N resources |

### Semaphore API Reference

```rust
use rustos_kernel::sync::Semaphore;

// Create semaphore with initial count
static SEM: Semaphore = Semaphore::new(3);  // 3 resources available

// Wait (decrement, blocks if 0)
SEM.wait();

// Signal (increment)
SEM.signal();

// Try wait (non-blocking)
if SEM.try_wait() {
    // Got a permit
} else {
    // No permits available
}

// Get current count
let available = SEM.count();
```

### Example: Resource Pool

```rust
use rustos_kernel::sync::Semaphore;

// Pool of 4 buffers
const BUFFER_COUNT: usize = 4;
static BUFFER_AVAILABLE: Semaphore = Semaphore::new(BUFFER_COUNT as u32);
static mut BUFFERS: [[u8; 256]; BUFFER_COUNT] = [[0; 256]; BUFFER_COUNT];
static BUFFER_INDEX: AtomicU32 = AtomicU32::new(0);

fn allocate_buffer() -> Option<&'static mut [u8; 256]> {
    if BUFFER_AVAILABLE.try_wait() {
        let idx = BUFFER_INDEX.fetch_add(1, Ordering::SeqCst) as usize % BUFFER_COUNT;
        unsafe { Some(&mut BUFFERS[idx]) }
    } else {
        None
    }
}

fn free_buffer() {
    BUFFER_AVAILABLE.signal();
}
```

### Example: Producer-Consumer Synchronization

```rust
use rustos_kernel::sync::{Semaphore, Queue};

const BUFFER_SIZE: usize = 16;
static ITEMS_AVAILABLE: Semaphore = Semaphore::new(0);
static SPACE_AVAILABLE: Semaphore = Semaphore::new(BUFFER_SIZE as u32);
static BUFFER: Queue<Data, BUFFER_SIZE> = Queue::new();

fn producer() -> ! {
    loop {
        let data = generate_data();

        SPACE_AVAILABLE.wait();   // Wait for space
        BUFFER.send(data).ok();   // Add to buffer
        ITEMS_AVAILABLE.signal(); // Signal item available
    }
}

fn consumer() -> ! {
    loop {
        ITEMS_AVAILABLE.wait();   // Wait for item
        let data = BUFFER.receive().unwrap();
        SPACE_AVAILABLE.signal(); // Signal space freed

        process_data(data);
    }
}
```

### Example: Binary Semaphore (Synchronization)

```rust
use rustos_kernel::sync::Semaphore;

// Binary semaphore for task synchronization
static SYNC: Semaphore = Semaphore::new(0);

fn initializer_task() -> ! {
    // Do initialization
    initialize_system();

    // Signal that initialization is complete
    SYNC.signal();

    loop {
        // Continue with normal operation
        do_work();
    }
}

fn worker_task() -> ! {
    // Wait for initialization to complete
    SYNC.wait();

    // Now safe to proceed
    loop {
        do_work();
    }
}
```

### Semaphore Best Practices

✅ **Do:**

- Balance wait/signal calls
- Use for resource counting
- Consider timeout for wait operations

❌ **Don't:**

- Signal more times than you wait
- Use for mutual exclusion (use Mutex instead)
- Forget to signal (causes deadlock)

---

## Queue

### What is a Queue?

A **Queue** is a FIFO (First-In-First-Out) data structure for passing messages between tasks. Safe for concurrent access.

### Queue API Reference

```rust
use rustos_kernel::sync::Queue;

// Create queue with capacity
static QUEUE: Queue<Message, 16> = Queue::new();  // 16 message capacity

// Send message (non-blocking)
match QUEUE.send(msg) {
    Ok(()) => { /* Success */ }
    Err(msg) => { /* Queue full, msg returned */ }
}

// Receive message (non-blocking)
match QUEUE.receive() {
    Some(msg) => { /* Got message */ }
    None => { /* Queue empty */ }
}

// Check state
let is_empty = QUEUE.is_empty();
let is_full = QUEUE.is_full();
let count = QUEUE.len();
```

### Example: Command Queue

```rust
use rustos_kernel::sync::Queue;

# [derive(Clone, Copy)]
enum Command {
    Start,
    Stop,
    SetSpeed(u32),
    SetDirection(bool),
}

static COMMAND_QUEUE: Queue<Command, 8> = Queue::new();

fn ui_task() -> ! {
    loop {
        if button_pressed(BUTTON_START) {
            COMMAND_QUEUE.send(Command::Start).ok();
        }
        if button_pressed(BUTTON_STOP) {
            COMMAND_QUEUE.send(Command::Stop).ok();
        }
        // ...
        delay_ms(50);
    }
}

fn motor_task() -> ! {
    loop {
        if let Some(cmd) = COMMAND_QUEUE.receive() {
            match cmd {
                Command::Start => motor_start(),
                Command::Stop => motor_stop(),
                Command::SetSpeed(s) => motor_set_speed(s),
                Command::SetDirection(d) => motor_set_direction(d),
            }
        }
        yield_now();
    }
}
```

### Example: Sensor Data Pipeline

```rust
use rustos_kernel::sync::Queue;

# [derive(Clone, Copy)]
struct SensorReading {
    timestamp: u32,
    temperature: i16,
    humidity: u16,
}

// Pipeline: Sensor -> Filter -> Logger
static RAW_READINGS: Queue<SensorReading, 32> = Queue::new();
static FILTERED_READINGS: Queue<SensorReading, 16> = Queue::new();

fn sensor_task() -> ! {
    loop {
        let reading = SensorReading {
            timestamp: get_ticks(),
            temperature: read_temperature(),
            humidity: read_humidity(),
        };
        RAW_READINGS.send(reading).ok();
        delay_ms(100);
    }
}

fn filter_task() -> ! {
    let mut buffer = [SensorReading::default(); 5];
    let mut idx = 0;

    loop {
        if let Some(reading) = RAW_READINGS.receive() {
            buffer[idx] = reading;
            idx = (idx + 1) % 5;

            // Apply moving average filter
            let filtered = average(&buffer);
            FILTERED_READINGS.send(filtered).ok();
        }
        yield_now();
    }
}

fn logger_task() -> ! {
    loop {
        if let Some(reading) = FILTERED_READINGS.receive() {
            log_to_flash(&reading);
        }
        yield_now();
    }
}
```

### Queue Best Practices

✅ **Do:**

- Size queue for expected burst rate
- Check return values of send
- Use small message types (or pointers)

❌ **Don't:**

- Block indefinitely waiting for messages
- Put large data directly in queue (use pointers)
- Assume messages are never lost

---

## Priority Queue

### What is a Priority Queue?

A **Priority Queue** (REQ: MQ-009) is a queue where messages are ordered by priority level, not insertion order. Higher priority messages are dequeued first, making it ideal for handling urgent events.

### API Reference

```rust
use rustos_kernel::sync::PriorityQueue;

// Create priority queue with capacity
static PQ: PriorityQueue<Message, 16> = PriorityQueue::new();

// Send message with priority (0 = highest)
PQ.push(msg, priority);

// Receive highest priority message
if let Some((msg, priority)) = PQ.pop() {
    // Process message
}

// Check state
let count = PQ.len();
let is_empty = PQ.is_empty();
let is_full = PQ.is_full();

// Peek at highest priority item without removing
if let Some((msg, priority)) = PQ.peek() {
    // Inspect without consuming
}
```

### Example: Interrupt Priority Handling

```rust
use rustos_kernel::sync::PriorityQueue;

# [derive(Clone, Copy)]
struct InterruptEvent {
    source: u8,
    data: u32,
}

// Priority queue for interrupt events (0 = highest priority)
static IRQ_QUEUE: PriorityQueue<InterruptEvent, 32> = PriorityQueue::new();

// ISR pushes events with appropriate priority
fn gpio_isr() {
    let event = InterruptEvent { source: 0, data: read_gpio() };
    IRQ_QUEUE.push(event, 10); // Low priority
}

fn uart_isr() {
    let event = InterruptEvent { source: 1, data: read_uart() };
    IRQ_QUEUE.push(event, 5);  // Medium priority
}

fn watchdog_isr() {
    let event = InterruptEvent { source: 2, data: 0 };
    IRQ_QUEUE.push(event, 0);  // Highest priority - critical!
}

// Handler task processes in priority order
fn event_handler_task() -> ! {
    loop {
        if let Some((event, _priority)) = IRQ_QUEUE.pop() {
            match event.source {
                0 => handle_gpio(event.data),
                1 => handle_uart(event.data),
                2 => handle_watchdog_warning(),
                _ => {}
            }
        }
        yield_now();
    }
}
```

### Priority Queue Best Practices

✅ **Do:**

- Use for priority-based event handling
- Keep priority values consistent (0 = highest)
- Size queue for worst-case burst

❌ **Don't:**

- Use when FIFO ordering is required (use Queue)
- Starve low-priority messages indefinitely
- Use large priority ranges unnecessarily

---

## Event Flags

### What are Event Flags?

**Event Flags** are a set of bits that tasks can set, clear, and wait on. Useful for signaling multiple conditions.

### Event Flags API Reference

```rust
use rustos_kernel::sync::EventFlags;

// Create event flags
static EVENTS: EventFlags = EventFlags::new();

// Set flags
EVENTS.set(FLAG_A | FLAG_B);

// Clear flags
EVENTS.clear(FLAG_A);

// Wait for any flag (returns matched flags)
let flags = EVENTS.wait_any(FLAG_A | FLAG_B);

// Wait for all flags
let flags = EVENTS.wait_all(FLAG_A | FLAG_B);

// Get current flags (non-blocking)
let current = EVENTS.get();
```

### Example: System Status

```rust
use rustos_kernel::sync::EventFlags;

// Status bits
const SENSOR_READY: u32 = 1 << 0;
const NETWORK_UP: u32 = 1 << 1;
const STORAGE_OK: u32 = 1 << 2;
const ERROR_FLAG: u32 = 1 << 31;

static STATUS: EventFlags = EventFlags::new();

fn sensor_task() -> ! {
    if init_sensor().is_ok() {
        STATUS.set(SENSOR_READY);
    } else {
        STATUS.set(ERROR_FLAG);
    }
    loop {
        // ...
    }
}

fn network_task() -> ! {
    if init_network().is_ok() {
        STATUS.set(NETWORK_UP);
    } else {
        STATUS.set(ERROR_FLAG);
    }
    loop {
        // ...
    }
}

fn main_task() -> ! {
    // Wait for all subsystems to be ready
    let all_ready = SENSOR_READY | NETWORK_UP | STORAGE_OK;

    loop {
        let status = STATUS.wait_any(all_ready | ERROR_FLAG);

        if status & ERROR_FLAG != 0 {
            handle_error();
            STATUS.clear(ERROR_FLAG);
        }

        if (status & all_ready) == all_ready {
            // All systems ready
            start_application();
            break;
        }
    }

    loop { /* Normal operation */ }
}
```

### Example: Multiple Event Sources

```rust
use rustos_kernel::sync::EventFlags;

// Event bits for different sources
const UART_RX: u32 = 1 << 0;
const TIMER_TICK: u32 = 1 << 1;
const BUTTON_PRESS: u32 = 1 << 2;
const DMA_COMPLETE: u32 = 1 << 3;

static EVENTS: EventFlags = EventFlags::new();

// ISR handlers set events
fn uart_isr() {
    // Process UART data...
    EVENTS.set(UART_RX);
}

fn timer_isr() {
    // Process timer...
    EVENTS.set(TIMER_TICK);
}

// Main task waits for any event
fn event_handler_task() -> ! {
    loop {
        let events = EVENTS.wait_any(UART_RX | TIMER_TICK | BUTTON_PRESS | DMA_COMPLETE);

        if events & UART_RX != 0 {
            process_uart_data();
            EVENTS.clear(UART_RX);
        }

        if events & TIMER_TICK != 0 {
            process_timer();
            EVENTS.clear(TIMER_TICK);
        }

        if events & BUTTON_PRESS != 0 {
            process_button();
            EVENTS.clear(BUTTON_PRESS);
        }

        if events & DMA_COMPLETE != 0 {
            process_dma();
            EVENTS.clear(DMA_COMPLETE);
        }
    }
}
```

### Event Flags Best Practices

✅ **Do:**

- Use descriptive bit names
- Clear flags after handling
- Document flag meanings

❌ **Don't:**

- Use more than 32 flags per EventFlags
- Forget to clear flags
- Use for data transfer (use Queue)

---

## Choosing the Right Primitive

### Decision Guide

```text
Need to protect shared data?
    └─► YES → Use Mutex

Need to count resources?
    └─► YES → Use Semaphore

Need to transfer data between tasks?
    └─► Is priority ordering needed?
        └─► YES → Use PriorityQueue
        └─► NO  → Use Queue (FIFO)

Need to signal events/conditions?
    └─► YES → Use EventFlags
```

### Comparison Table

| Scenario | Best Choice | Why |
|----------|-------------|-----|
| Protect shared variable | Mutex | Exclusive access with RAII |
| Limit concurrent users | Semaphore | Counting permits |
| Send commands | Queue | Ordered message delivery |
| Priority-based events | PriorityQueue | Urgent messages first |
| Signal completion | EventFlags | Multiple boolean conditions |
| Wait for multiple conditions | EventFlags | Efficient bit testing |
| Producer-consumer | Queue + Semaphores | Data + synchronization |
| Resource pool | Semaphore | Count available items |

### Anti-Patterns

❌ **Using Mutex for signaling**

```rust
// Bad: Mutex for synchronization
static DONE: Mutex<bool> = Mutex::new(false);
// Better: Use Semaphore or EventFlags
static DONE: Semaphore = Semaphore::new(0);
```

❌ **Using Queue for single values**

```rust
// Bad: Queue for one value
static VALUE: Queue<u32, 1> = Queue::new();
// Better: Use Mutex
static VALUE: Mutex<u32> = Mutex::new(0);
```

❌ **Using Semaphore for exclusive access**

```rust
// Bad: Binary semaphore for mutual exclusion
static SEM: Semaphore = Semaphore::new(1);
// Better: Use Mutex (has ownership tracking)
static LOCK: Mutex<()> = Mutex::new(());
```

---

## Advanced Topics

### Deadlock Prevention

**Lock Ordering**: Always acquire multiple locks in the same order.

```rust
// Define global lock order
// 1. UART_LOCK
// 2. SENSOR_LOCK
// 3. LOG_LOCK

fn task_a() {
    let _u = UART_LOCK.lock();
    let _s = SENSOR_LOCK.lock();
    // ...
}

fn task_b() {
    let _u = UART_LOCK.lock();   // Same order!
    let _s = SENSOR_LOCK.lock();
    // ...
}
```

### Timeout Handling

```rust
fn wait_with_timeout<T>(queue: &Queue<T, N>, timeout_ms: u32) -> Option<T> {
    let start = get_ticks();

    loop {
        if let Some(item) = queue.receive() {
            return Some(item);
        }

        if elapsed_since(start) >= timeout_ms {
            return None;  // Timeout
        }

        yield_now();
    }
}
```

### ISR-Safe Operations

Only use non-blocking operations in ISRs:

```rust
fn isr_handler() {
    // ✅ Safe: Non-blocking
    if let Some(guard) = MUTEX.try_lock() {
        // Quick operation
    }

    // ✅ Safe: Non-blocking
    QUEUE.send(data).ok();

    // ✅ Safe: Non-blocking
    EVENTS.set(FLAG);

    // ❌ Unsafe: May block!
    // let guard = MUTEX.lock();
    // SEMAPHORE.wait();
}
```

### Performance Tips

1. **Minimize lock duration**

   ```rust
   // Copy out quickly
   let data = { MUTEX.lock().clone() };
   // Process outside lock
   expensive_process(&data);
   ```

2. **Use fine-grained locking**

   ```rust
   // Instead of one big lock
   static SENSORS: Mutex<AllSensors> = ...;

   // Use separate locks
   static TEMP_SENSOR: Mutex<TempSensor> = ...;
   static HUMIDITY_SENSOR: Mutex<HumiditySensor> = ...;
   ```

3. **Consider lock-free alternatives**

   ```rust
   // For simple counters, use atomics
   use portable_atomic::AtomicU32;
   static COUNTER: AtomicU32 = AtomicU32::new(0);
   ```

---

## Summary

| Primitive | Thread-Safe | Blocking | Best For |
|-----------|-------------|----------|----------|
| Mutex | Yes | Yes | Protecting shared data |
| Semaphore | Yes | Yes | Resource counting |
| Queue | Yes | No* | Message passing |
| EventFlags | Yes | Yes | Event notification |

*Queue uses non-blocking send/receive; wrap with semaphores for blocking behavior.

For practical examples, see [Example Applications](EXAMPLES.md).
For task patterns, see [Task Programming Guide](TASK_PROGRAMMING.md).
