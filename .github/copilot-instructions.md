# RustOS Copilot Instructions

## Project Overview

RustOS is a preemptive, priority-based RTOS written in Rust for RISC-V RV32IMAC embedded systems. It targets the MicroBlaze V soft-core processor on the Digilent Arty A7-35 FPGA at 75 MHz with 128 KB BRAM.

**Key constraints:** No heap allocation, `no_std` throughout, all data structures are static or stack-allocated.

**Status:** 800 requirements implemented, 232 tests passing, production ready.

## Crate Architecture (Dependency Order)

```
rustos-pac  → rustos-hal  → rustos-kernel → rustos-board → rustos-app
(registers)   (drivers)     (scheduler)     (startup)      (user code)
```

| Crate | Purpose | Key Files |
|-------|---------|-----------|
| `rustos-pac` | Type-safe memory-mapped registers | `src/{uart,gpio,intc,spi,i2c,ethernet,wdt}.rs` |
| `rustos-hal` | Device drivers (feature-gated) | `src/` mirrors PAC structure |
| `rustos-kernel` | Scheduler, tasks, sync primitives | `src/scheduler.rs`, `src/sync/`, `src/task.rs` |
| `rustos-board` | Startup, trap handling, board init | `src/startup.rs`, `src/trap.rs` |
| `rustos-app` | Example application | `src/main.rs` |
| `rustos-tests` | Host-side test suite | `src/*_tests.rs` |

## Requirements Traceability

**Every function, struct, and module must have a `REQ:` comment** linking to the requirements specification. This is mandatory for the project's safety certification goals (IEC 61508, ISO 26262, DO-178C).

```rust
/// REQ: SCHED-003 - Find highest priority ready task
fn find_highest_priority(&self) -> Option<TaskId> { ... }
```

Requirements are defined in [requirements/REQUIREMENTS.md](requirements/REQUIREMENTS.md) with format `REQ: {CATEGORY}-{NUMBER}`.

**Requirement categories:** SCHED (scheduler), TASK (tasks), MTX/SEM/MQ/EVT (sync), TIME (timers), HAL/UART/GPIO/SPI/I2C/ETH/WDT (hardware), MEM (memory), ERR (errors), CFG (config), TEST (testing).

## Build & Test Commands

```bash
# Build for RISC-V target (default via .cargo/config.toml)
cargo build --release --workspace

# Run host-side tests (MUST use single thread due to shared static state)
cargo test -p rustos-tests --target x86_64-unknown-linux-gnu -- --test-threads=1

# Run benchmarks
cargo run -p rustos-tests --target x86_64-unknown-linux-gnu --bin bench --features bench

# Format and lint
cargo fmt --all && cargo clippy --workspace -- -D warnings
```

**MSRV:** Rust 1.82.0 (required for stable `#[naked]` functions)

## Code Patterns

### Atomic Operations (No std::sync)
Use `portable-atomic` crate for all atomics:
```rust
use portable_atomic::{AtomicU32, AtomicBool, Ordering};
```

### Critical Sections
Always use the kernel's RAII critical section wrapper, never raw interrupt disable:
```rust
use crate::critical::CriticalSection;
let _cs = CriticalSection::new();  // Disables interrupts, restores on drop
// Supports nesting - tracks depth via CRITICAL_NESTING counter
```

### Error Handling
Use `KernelError` from `rustos_kernel::error` - never panic on recoverable errors:
```rust
pub fn operation() -> Result<(), KernelError> {
    if invalid { return Err(KernelError::InvalidPriority); }
    Ok(())
}
```

**Timeout semantics:** `0` = non-blocking poll, `n` = block up to n ticks, `None` = block forever.
```

### Static Allocation
All collections use `heapless` crate. No `Box`, `Vec`, `String`, or `alloc`:
```rust
use heapless::Vec;
let mut buffer: Vec<u8, 64> = Vec::new();  // Fixed capacity
```

### HAL Driver Pattern
Drivers are feature-gated and use unsafe constructors for singleton access:
```rust
#[cfg(feature = "uart")]
pub mod uart;

pub unsafe fn uart() -> &'static uart::Uart {
    &*(UART_BASE as *const uart::Uart)
}
```

## Synchronization Primitives

Located in `rustos-kernel/src/sync/`:
- `Mutex<T>` - RAII guards, optional priority inheritance (`priority-inheritance` feature)
- `Semaphore` - Counting (0..max), binary via `Semaphore::binary()`
- `MessageQueue<T, N>` - Fixed-capacity FIFO
- `PriorityQueue<T, N>` - Priority-ordered messages
- `EventFlags` - 32-bit flags with AND/OR wait conditions

## Feature Flags (rustos-kernel)

| Feature | Purpose |
|---------|---------|
| `statistics` | Context switch counting, performance metrics |
| `diagnostics` | Runtime diagnostic query APIs |
| `timers` | Callback-based software timers |
| `wfi-idle` | Use WFI instruction in idle task |
| `priority-inheritance` | Mutex priority inheritance protocol |
| `stack-check` | Stack overflow detection via canary |
| `tickless` | Dynamic tick suppression for power savings |
| `panic-led` | Blink LED on panic |
| `panic-reset` | Watchdog reset on panic |

## Task Programming

### Task Creation Pattern
```rust
// Task stacks MUST be static
static mut TASK_STACK: [u8; 2048] = [0; 2048];
static mut MY_TASK: Option<Task> = None;

unsafe {
    MY_TASK = Some(Task::new(
        TaskId(1),
        "my_task",
        TaskPriority(10),  // 0=highest, 255=lowest
        task_entry_fn,
        &mut *addr_of_mut!(TASK_STACK)
    ));
    scheduler::get().add_task(MY_TASK.as_mut().unwrap()).unwrap();
}
```

### Priority Guidelines
| Level | Range | Use Case |
|-------|-------|----------|
| Critical | 0-31 | Interrupts, emergency handlers |
| High | 32-63 | Time-sensitive (sensors, motors) |
| Normal | 64-191 | Regular application tasks |
| Low | 192-254 | Background, housekeeping |
| Idle | 255 | `TaskPriority::LOWEST` - only when nothing else ready |

## Testing Guidelines

Tests in `rustos-tests/` run on x86_64, not RISC-V. Hardware-specific code uses conditional compilation:
```rust
#[cfg(target_arch = "riscv32")]
fn hardware_specific() { ... }

#[cfg(not(target_arch = "riscv32"))]
fn hardware_specific() { /* mock implementation */ }
```

Test modules use shared static state via `mock.rs` - always run with `--test-threads=1`.

**Test count:** 232 tests, 80%+ line coverage.

## Memory Map (Key Addresses)

```
0x0000_0000  Local BRAM (128 KB code + data)
0x4060_0000  AXI UART Lite
0x4120_0000  AXI Interrupt Controller  
0x41A0_0000  AXI Watchdog Timer
```

Full map in [rustos-pac/src/lib.rs](rustos-pac/src/lib.rs#L9-L25).

## Context Switching

The scheduler uses a 256-bit priority bitmap for O(1) task selection. Context frame layout (34 registers) is in [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md). The `#[naked]` attribute is used for assembly-only context switch routines.

## HAL Feature Flags

Enable only needed drivers to minimize binary size in `rustos-hal/Cargo.toml`:

| Feature | Peripheral | Default |
|---------|------------|---------|
| `uart` | AXI UART Lite | ✅ |
| `gpio` | GPIO (LEDs, buttons, switches) | ✅ |
| `timer` | System timer (1 kHz tick) | ✅ |
| `spi` | AXI Quad SPI | ❌ |
| `i2c` | AXI IIC | ❌ |
| `ethernet` | AXI Ethernet Lite | ❌ |
| `wdt` | Watchdog Timer | ❌ |
| `intc` | Interrupt Controller | ❌ |

## Interrupt Handling

Register handlers via the interrupt controller in `rustos-hal/src/intc.rs`:

```rust
use rustos_hal::intc;

unsafe {
    let intc = intc::init();
    
    // Register handler for IRQ 0 (system tick)
    intc.register_handler(0, || {
        rustos_kernel::time::tick();
        rustos_kernel::scheduler::yield_from_isr();
    }).unwrap();
    
    intc.enable_irq(0);
    intc.enable_master();
}
```

**IRQ assignments:** 0=Timer, 1=UART, 2=GPIO, 3=SPI, 4=I2C, 5=Ethernet, 6=WDT (see [rustos-pac/src/intc.rs](rustos-pac/src/intc.rs))

## Debugging (GDB + OpenOCD)

The kernel includes a GDB stub (`rustos-kernel/src/debug.rs`) supporting breakpoints, register inspection, and semihosting.

```bash
# Terminal 1: Start OpenOCD
openocd -f interface/ftdi/digilent-hs1.cfg -f target/riscv.cfg

# Terminal 2: Connect GDB
riscv64-unknown-elf-gdb target/riscv32imac-unknown-none-elf/release/rustos-app
(gdb) target remote localhost:3333
(gdb) load
(gdb) break main
(gdb) continue
```

**Semihosting** (debug output to host):
```rust
use rustos_kernel::debug::Semihosting;
Semihosting::write_str("Debug: checkpoint reached\n");
```

**Profiling** (measure execution time):
```rust
use rustos_kernel::debug::Profiler;
let _prof = Profiler::start("critical_section");
// ... profiled code ...
// Automatically reports elapsed cycles when dropped
```

## Hardware Deployment

### 1. Program FPGA Bitstream (Vivado)

```bash
# Open Vivado project
vivado hardware/rv32imacb_zicsr_zifencei_zbc/rv32imacb_zicsr_zifencei_zbc.xpr

# Or program via command line
vivado -mode batch -source program_fpga.tcl
```

Bitstream location: `hardware/artifacts/bitstream/`

### 2. Load Application

```bash
# Convert ELF to binary
riscv64-unknown-elf-objcopy -O binary \
    target/riscv32imac-unknown-none-elf/release/rustos-app \
    rustos-app.bin

# Load via OpenOCD + GDB (see Debugging section)
# Or use Xilinx XSCT:
xsct -eval "connect; targets -set -filter {name =~ \"MicroBlaze*\"}; dow rustos-app.elf; con"
```

### 3. Serial Console

```bash
# Connect to UART (115200 baud)
screen /dev/ttyUSB1 115200
# Or: minicom -D /dev/ttyUSB1 -b 115200
```

## Adding New Functionality

1. Add requirement tag from spec or create new one in `requirements/REQUIREMENTS.md`
2. Implement with `/// REQ: XXX-NNN` doc comment
3. Add tests to `rustos-tests/src/` with matching `REQ:` comments
4. Update [IMPLEMENTATION_STATUS.md](IMPLEMENTATION_STATUS.md) if completing a major feature

## Safety-Critical Coding Rules

This project follows MISRA-like coding standards for certification readiness:

| Rule | Description |
|------|-------------|
| RUST-001 | No `unsafe` without documented safety justification |
| RUST-002 | All public APIs must have documentation (`#![deny(missing_docs)]`) |
| RUST-003 | No dynamic allocation (`alloc` crate forbidden) |
| RUST-004 | No panics in release mode - use `Result` for recoverable errors |
| RUST-005 | Handle numeric overflow explicitly (saturating/wrapping ops) |
| RUST-006 | No recursion in safety-critical paths |
| RUST-007 | All loops must have explicit bounds |
| RUST-009 | No `.unwrap()` in production code |

## Performance Targets

| Metric | Target | Achieved |
|--------|--------|----------|
| Context switch | ≤ 5 µs | 3.2 µs ✅ |
| Interrupt latency | ≤ 1 µs | 0.7 µs ✅ |
| Memory footprint | ≤ 64 KB | 58 KB ✅ |

## Key Documentation

- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - System internals, context frame layout
- [docs/TASK_PROGRAMMING.md](docs/TASK_PROGRAMMING.md) - Task creation, priorities, patterns
- [docs/SYNC_PRIMITIVES.md](docs/SYNC_PRIMITIVES.md) - Mutex, Semaphore, Queue, Events usage
- [docs/CERTIFICATION.md](docs/CERTIFICATION.md) - Safety case, coding standards
- [docs/GETTING_STARTED.md](docs/GETTING_STARTED.md) - Installation, first application
