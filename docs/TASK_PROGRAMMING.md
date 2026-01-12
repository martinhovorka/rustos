# RustOS Task Programming Guide

**REQ: DOC-011 - Task Programming Documentation**

This guide covers task creation, management patterns, best practices, and common pitfalls when programming with RustOS tasks.

## Table of Contents

1. [Task Fundamentals](#task-fundamentals)
2. [Creating Tasks](#creating-tasks)
3. [Task Priorities](#task-priorities)
4. [Task States](#task-states)
5. [Task Communication](#task-communication)
6. [Design Patterns](#design-patterns)
7. [Best Practices](#best-practices)
8. [Common Pitfalls](#common-pitfalls)
9. [Performance Considerations](#performance-considerations)

---

## Task Fundamentals

### What is a Task?

In RustOS, a **task** is an independent execution context with:
- Its own stack
- A priority level (0-255, lower = higher priority)
- A state (Ready, Running, Blocked, Suspended, Terminated)
- A unique identifier (TaskId)

Tasks share:
- Code memory (read-only)
- Global/static data
- Peripheral access

### Task Execution Model

RustOS uses **preemptive priority-based scheduling**:

1. The highest-priority ready task always runs
2. Equal-priority tasks use round-robin scheduling
3. Lower-priority tasks are preempted when higher-priority tasks become ready
4. The scheduler runs at every timer tick (1 kHz default)

```
Priority 0 (Highest)  ────────────►  First to run
Priority 1            ────────────►  
Priority 2            ────────────►  
    ...                              
Priority 254          ────────────►  
Priority 255 (Lowest) ────────────►  Idle task (runs when nothing else ready)
```

---

## Creating Tasks

### Basic Task Creation

```rust
use rustos_kernel::task::{Task, TaskBuilder, TaskId, TaskPriority};

// Task stack (must be static)
static mut MY_STACK: [usize; 512] = [0; 512];
static mut MY_TASK: Option<Task> = None;

// Task function (never returns)
fn my_task_fn() -> ! {
    loop {
        // Task logic here
        do_work();
    }
}

// Create the task
unsafe {
    MY_TASK = Some(TaskBuilder::new(TaskId(1), "my_task")
        .priority(TaskPriority(10))
        .build(my_task_fn, &mut MY_STACK));
}
```

### Stack Sizing

Calculate stack size based on:
- Local variables
- Function call depth
- Interrupt handler overhead

```rust
// Minimum: 256 words for simple tasks
static mut SIMPLE_STACK: [usize; 256] = [0; 256];

// Standard: 512 words for typical tasks
static mut STANDARD_STACK: [usize; 512] = [0; 512];

// Large: 1024+ words for deep call stacks or large locals
static mut LARGE_STACK: [usize; 1024] = [0; 1024];
```

### Stack Canary (Overflow Detection)

Enable stack overflow detection:

```rust
// In Cargo.toml
[features]
default = ["stack-check"]

// Check at runtime
if !task.check_stack_overflow() {
    // Stack overflow detected!
    panic!("Stack overflow in task");
}
```

---

## Task Priorities

### Priority Levels

| Level | Value | Use Case |
|-------|-------|----------|
| Highest | 0-31 | Critical real-time tasks, interrupts |
| High | 32-63 | Time-sensitive operations |
| Normal | 64-191 | Regular application tasks |
| Low | 192-254 | Background tasks, housekeeping |
| Idle | 255 | Only runs when nothing else ready |

### Priority Assignment Guidelines

```rust
use rustos_kernel::task::TaskPriority;

// Critical: Emergency handlers, watchdog feeders
const CRITICAL_PRIORITY: TaskPriority = TaskPriority(5);

// High: Sensor reading, motor control
const HIGH_PRIORITY: TaskPriority = TaskPriority(40);

// Normal: User interface, logging
const NORMAL_PRIORITY: TaskPriority = TaskPriority::NORMAL; // 128

// Low: File I/O, statistics collection
const LOW_PRIORITY: TaskPriority = TaskPriority(200);

// Idle: Power management
const IDLE_PRIORITY: TaskPriority = TaskPriority::LOWEST; // 255
```

### Priority Inversion

**Problem**: A low-priority task holds a resource needed by a high-priority task.

**Solution**: Enable priority inheritance (feature-gated):

```toml
# Cargo.toml
[features]
default = ["priority-inheritance"]
```

With priority inheritance, when a high-priority task blocks on a mutex held by
a low-priority task, the low-priority task temporarily inherits the higher
priority until it releases the mutex.

---

## Task States

### State Diagram

```
                    ┌─────────────┐
                    │   READY     │◄────────┐
                    └──────┬──────┘         │
                           │ schedule       │ unblock
                    ┌──────▼──────┐         │
        ┌──────────►│   RUNNING   │─────────┤
        │           └──────┬──────┘         │
        │ preempt          │ block          │
        │                  ▼                │
        │           ┌─────────────┐         │
        └───────────│   BLOCKED   │─────────┘
                    └─────────────┘
```

### State Transitions

```rust
use rustos_kernel::task::TaskState;

// Check task state
let state = task.state();

if state.contains(TaskState::READY) {
    // Task is ready to run
}

if state.contains(TaskState::BLOCKED) {
    // Task is waiting for a resource
}

if state.contains(TaskState::RUNNING) {
    // Task is currently executing
}
```

### Blocking vs. Yielding

```rust
// Yield: Give up CPU but remain ready
rustos_kernel::scheduler::yield_now();

// Block: Wait for specific condition (mutex, semaphore, etc.)
let guard = mutex.lock(); // Blocks until available
```

---

## Task Communication

### Shared Data (with Mutex)

```rust
use rustos_kernel::sync::Mutex;

// Shared counter protected by mutex
static COUNTER: Mutex<u32> = Mutex::new(0);

fn increment_counter() {
    let mut guard = COUNTER.lock();
    *guard += 1;
    // Automatically unlocked when guard is dropped
}
```

### Message Passing (with Queue)

```rust
use rustos_kernel::sync::Queue;

// Message queue (producer-consumer pattern)
static MESSAGES: Queue<Message, 16> = Queue::new();

fn producer_task() -> ! {
    loop {
        let msg = create_message();
        MESSAGES.send(msg).ok();
        delay_ms(100);
    }
}

fn consumer_task() -> ! {
    loop {
        if let Some(msg) = MESSAGES.receive() {
            process_message(msg);
        }
        yield_now();
    }
}
```

### Event Notification (with Events)

```rust
use rustos_kernel::sync::EventFlags;

static EVENTS: EventFlags = EventFlags::new();

const DATA_READY: u32 = 1 << 0;
const ERROR_FLAG: u32 = 1 << 1;

fn sensor_task() -> ! {
    loop {
        let data = read_sensor();
        if data.is_valid() {
            EVENTS.set(DATA_READY);
        } else {
            EVENTS.set(ERROR_FLAG);
        }
        delay_ms(10);
    }
}

fn processing_task() -> ! {
    loop {
        let flags = EVENTS.wait_any(DATA_READY | ERROR_FLAG);
        if flags & DATA_READY != 0 {
            process_data();
        }
        if flags & ERROR_FLAG != 0 {
            handle_error();
        }
    }
}
```

---

## Design Patterns

### 1. Producer-Consumer

```rust
// Producer creates data, consumer processes it
static BUFFER: Queue<Data, 32> = Queue::new();
static DATA_AVAILABLE: Semaphore = Semaphore::new(0);
static SPACE_AVAILABLE: Semaphore = Semaphore::new(32);

fn producer() -> ! {
    loop {
        SPACE_AVAILABLE.wait();  // Wait for space
        let data = produce_data();
        BUFFER.send(data).ok();
        DATA_AVAILABLE.signal(); // Signal data ready
    }
}

fn consumer() -> ! {
    loop {
        DATA_AVAILABLE.wait();   // Wait for data
        let data = BUFFER.receive().unwrap();
        SPACE_AVAILABLE.signal(); // Signal space freed
        consume_data(data);
    }
}
```

### 2. State Machine Task

```rust
enum State {
    Idle,
    Processing,
    WaitingForAck,
    Error,
}

fn state_machine_task() -> ! {
    let mut state = State::Idle;
    
    loop {
        state = match state {
            State::Idle => {
                if has_work() {
                    State::Processing
                } else {
                    delay_ms(10);
                    State::Idle
                }
            }
            State::Processing => {
                do_processing();
                send_request();
                State::WaitingForAck
            }
            State::WaitingForAck => {
                if timeout_expired() {
                    State::Error
                } else if ack_received() {
                    State::Idle
                } else {
                    yield_now();
                    State::WaitingForAck
                }
            }
            State::Error => {
                handle_error();
                State::Idle
            }
        };
    }
}
```

### 3. Watchdog Pattern

```rust
// Watchdog supervisor task
fn watchdog_task() -> ! {
    let wdt = Wdt::new(rustos_pac::WDT_BASE);
    wdt.enable(5000); // 5 second timeout
    
    loop {
        // Check all tasks are healthy
        if all_tasks_healthy() {
            wdt.kick(); // Reset watchdog
        }
        delay_ms(1000);
    }
}

// Application tasks signal health
static TASK_HEARTBEATS: [AtomicU32; 4] = [
    AtomicU32::new(0), AtomicU32::new(0),
    AtomicU32::new(0), AtomicU32::new(0),
];

fn application_task(id: usize) -> ! {
    loop {
        do_work();
        TASK_HEARTBEATS[id].store(get_ticks(), Ordering::Release);
    }
}
```

### 4. Periodic Task

```rust
fn periodic_task() -> ! {
    let period_ms = 100;
    let mut next_wake = get_ticks();
    
    loop {
        // Do periodic work
        sample_sensor();
        
        // Calculate next wake time (avoids drift)
        next_wake = next_wake.wrapping_add(period_ms);
        
        // Sleep until next period
        let now = get_ticks();
        let delay = next_wake.wrapping_sub(now);
        if delay < period_ms { // Not overdue
            delay_ticks(delay);
        }
    }
}
```

---

## Best Practices

### 1. Keep Tasks Small and Focused

```rust
// ❌ Bad: Monolithic task
fn mega_task() -> ! {
    loop {
        read_sensors();
        process_data();
        update_display();
        log_to_flash();
        check_network();
    }
}

// ✅ Good: Separate responsibilities
fn sensor_task() -> ! { /* ... */ }
fn processing_task() -> ! { /* ... */ }
fn display_task() -> ! { /* ... */ }
fn logging_task() -> ! { /* ... */ }
fn network_task() -> ! { /* ... */ }
```

### 2. Minimize Critical Sections

```rust
// ❌ Bad: Long critical section
{
    let guard = mutex.lock();
    expensive_computation(&*guard);  // Holds lock too long!
    *guard = result;
}

// ✅ Good: Short critical section
let data = {
    let guard = mutex.lock();
    guard.clone()  // Copy out quickly
};
let result = expensive_computation(&data);
{
    let mut guard = mutex.lock();
    *guard = result;
}
```

### 3. Use Appropriate Synchronization

```rust
// For exclusive access: Mutex
static UART: Mutex<Uart> = Mutex::new(/* ... */);

// For counting resources: Semaphore
static BUFFER_SLOTS: Semaphore = Semaphore::new(10);

// For data transfer: Queue
static MESSAGES: Queue<Msg, 8> = Queue::new();

// For event notification: EventFlags
static EVENTS: EventFlags = EventFlags::new();
```

### 4. Handle Timeouts

```rust
// Always use timeouts for blocking operations
fn safe_receive() -> Option<Message> {
    let start = get_ticks();
    let timeout_ms = 1000;
    
    loop {
        if let Some(msg) = QUEUE.try_receive() {
            return Some(msg);
        }
        
        if elapsed_since(start) > timeout_ms {
            return None; // Timeout
        }
        
        yield_now();
    }
}
```

---

## Common Pitfalls

### 1. Stack Overflow

```rust
// ❌ Problem: Large local array
fn bad_task() -> ! {
    let buffer: [u8; 8192] = [0; 8192];  // May overflow stack!
    // ...
}

// ✅ Solution: Use static or heap allocation
static mut BUFFER: [u8; 8192] = [0; 8192];
fn good_task() -> ! {
    let buffer = unsafe { &mut BUFFER };
    // ...
}
```

### 2. Priority Inversion

```rust
// ❌ Problem: Low-priority task holds lock needed by high-priority task
// Enable priority-inheritance feature to fix

// ✅ Solution: Use feature flag
// Cargo.toml: features = ["priority-inheritance"]
```

### 3. Deadlock

```rust
// ❌ Problem: Tasks lock mutexes in different order
// Task A: lock(M1) -> lock(M2)
// Task B: lock(M2) -> lock(M1)

// ✅ Solution: Always lock in same order
fn task_a() -> ! {
    let _g1 = MUTEX1.lock();
    let _g2 = MUTEX2.lock();
    // ...
}

fn task_b() -> ! {
    let _g1 = MUTEX1.lock();  // Same order!
    let _g2 = MUTEX2.lock();
    // ...
}
```

### 4. Starvation

```rust
// ❌ Problem: High-priority task never yields
fn greedy_task() -> ! {
    loop {
        while has_work() {
            do_work();  // Never yields!
        }
    }
}

// ✅ Solution: Yield periodically
fn fair_task() -> ! {
    loop {
        for _ in 0..10 {
            if has_work() {
                do_work();
            }
        }
        yield_now();  // Give others a chance
    }
}
```

### 5. Race Conditions

```rust
// ❌ Problem: Unsynchronized shared data
static mut COUNTER: u32 = 0;
fn bad_increment() {
    unsafe { COUNTER += 1; }  // Race condition!
}

// ✅ Solution: Use atomic or mutex
use portable_atomic::{AtomicU32, Ordering};
static COUNTER: AtomicU32 = AtomicU32::new(0);
fn good_increment() {
    COUNTER.fetch_add(1, Ordering::SeqCst);
}
```

---

## Performance Considerations

### Context Switch Overhead

- RustOS context switch: ~3.2 µs (75 MHz)
- Save/restore 32 registers + CSRs
- Keep ISRs short to minimize latency

### Memory Usage

| Component | Size |
|-----------|------|
| Task Control Block | 64 bytes |
| Minimum stack | 1 KB |
| Typical stack | 2-4 KB |
| Kernel overhead | ~8 KB |

### Scheduling Overhead

- O(1) priority lookup using bitmap
- Timer tick overhead: ~1 µs
- Tick rate: 1 kHz (1 ms period)

### Tips for Real-Time Performance

1. Use highest priority for time-critical tasks
2. Minimize blocking time in critical sections
3. Use polling for very short waits (< 100 µs)
4. Use events/semaphores for longer waits
5. Monitor stack usage with diagnostics feature

---

## Summary

| Concept | Key Point |
|---------|-----------|
| Tasks | Independent execution contexts |
| Priorities | 0 = highest, 255 = lowest (idle) |
| States | Ready, Running, Blocked, Suspended |
| Sync | Mutex, Semaphore, Queue, Events |
| Best Practice | Small tasks, short critical sections |
| Pitfalls | Stack overflow, deadlock, starvation |

For more examples, see [Example Applications](EXAMPLES.md).
For synchronization details, see [Sync Primitives Guide](SYNC_PRIMITIVES.md).
