# RustOS Getting Started Guide

**REQ: DOC-010 - Getting Started Documentation**

Welcome to RustOS! This guide will help you set up your development environment, build your first application, and deploy it to the Digilent Arty A7-35 FPGA board.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Project Structure](#project-structure)
4. [Building Your First Application](#building-your-first-application)
5. [Deploying to Hardware](#deploying-to-hardware)
6. [Debugging](#debugging)
7. [Common Issues](#common-issues)

---

## Prerequisites

### Hardware Requirements

- **Digilent Arty A7-35 FPGA Board** with RISC-V soft-core
- USB cable (Micro-B) for JTAG and UART
- Host computer (Linux recommended)

### Software Requirements

- **Rust toolchain** (1.82.0 or later)
- **RISC-V GCC toolchain** (for linking)
- **Xilinx Vivado** (for FPGA programming)
- **OpenOCD** (for debugging)

---

## Installation

### 1. Install Rust

```bash
# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add RISC-V target
rustup target add riscv32imac-unknown-none-elf

# Verify installation
rustc --version
cargo --version
```

### 2. Install RISC-V Toolchain

```bash
# Ubuntu/Debian
sudo apt-get install gcc-riscv64-unknown-elf

# Or download from SiFive:
# https://github.com/sifive/freedom-tools/releases
```

### 3. Clone RustOS

```bash
git clone https://github.com/your-repo/rustos.git
cd rustos
```

### 4. Verify Build

```bash
# Build all packages
cargo build --all

# Run tests (on host)
cargo test --lib -p rustos-tests --target x86_64-unknown-linux-gnu
```

---

## Project Structure

```
rustos/
├── rustos-kernel/      # RTOS kernel (scheduler, tasks, sync)
├── rustos-hal/         # Hardware Abstraction Layer (drivers)
├── rustos-pac/         # Peripheral Access Crate (registers)
├── rustos-board/       # Board Support Package (Arty A7-35)
├── rustos-app/         # Example application
├── rustos-tests/       # Test suite
├── docs/               # Documentation
└── hardware/           # FPGA project files
```

### Key Modules

| Module | Description |
|--------|-------------|
| `rustos_kernel::task` | Task management, priorities, states |
| `rustos_kernel::scheduler` | O(1) priority-based preemptive scheduler |
| `rustos_kernel::sync` | Mutex, Semaphore, Queue, Events |
| `rustos_kernel::time` | System tick, timers, delays |
| `rustos_hal::uart` | UART serial communication |
| `rustos_hal::gpio` | GPIO input/output with interrupts |
| `rustos_hal::timer` | Hardware timer (1 kHz tick) |
| `rustos_hal::spi` | SPI master interface |
| `rustos_hal::i2c` | I2C/IIC interface |
| `rustos_hal::wdt` | Watchdog timer |

---

## Building Your First Application

### Step 1: Create a New Application

Create your application in `rustos-app/src/main.rs`:

```rust
//! My First RustOS Application

#![no_std]
#![no_main]

use rustos_kernel::{
    task::{Task, TaskBuilder, TaskId, TaskPriority},
    scheduler,
    time::delay_ms,
};
use rustos_hal::uart::Uart;

// Task stacks (must be static)
static mut TASK1_STACK: [usize; 512] = [0; 512];
static mut TASK2_STACK: [usize; 512] = [0; 512];
static mut IDLE_STACK: [usize; 256] = [0; 256];

// Task storage
static mut TASK1: Option<Task> = None;
static mut TASK2: Option<Task> = None;
static mut IDLE: Option<Task> = None;

/// Application entry point
#[no_mangle]
pub unsafe extern "C" fn main() -> ! {
    // Initialize hardware
    rustos_board::init();
    
    // Create tasks
    TASK1 = Some(TaskBuilder::new(TaskId(1), "blinker")
        .priority(TaskPriority(10))
        .build(blinker_task, &mut TASK1_STACK));
        
    TASK2 = Some(TaskBuilder::new(TaskId(2), "counter")
        .priority(TaskPriority(20))
        .build(counter_task, &mut TASK2_STACK));
        
    IDLE = Some(TaskBuilder::new(TaskId(0), "idle")
        .priority(TaskPriority::LOWEST)
        .build(idle_task, &mut IDLE_STACK));
    
    // Add tasks to scheduler
    let sched = scheduler::get();
    sched.add_task(TASK1.as_mut().unwrap()).unwrap();
    sched.add_task(TASK2.as_mut().unwrap()).unwrap();
    sched.add_task(IDLE.as_mut().unwrap()).unwrap();
    
    // Start scheduler (never returns)
    scheduler::start()
}

/// Blinker task - toggles LED
fn blinker_task() -> ! {
    let mut led_on = false;
    loop {
        // Toggle LED
        led_on = !led_on;
        rustos_hal::gpio::set_output(0, led_on);
        
        // Wait 500ms
        delay_ms(500);
    }
}

/// Counter task - prints count to UART
fn counter_task() -> ! {
    let uart = Uart::new(rustos_pac::UART0_BASE);
    let mut count = 0u32;
    
    loop {
        // Print count
        uart.write_str("Count: ");
        uart.write_u32(count);
        uart.write_str("\r\n");
        
        count = count.wrapping_add(1);
        
        // Wait 1 second
        delay_ms(1000);
    }
}

/// Idle task - runs when no other task is ready
fn idle_task() -> ! {
    loop {
        // Wait for interrupt (low power)
        unsafe { core::arch::asm!("wfi"); }
    }
}

/// Panic handler
#[panic_handler]
fn panic(info: &core::panic::PanicInfo) -> ! {
    // Optional: Print panic message via UART
    loop {
        unsafe { core::arch::asm!("wfi"); }
    }
}
```

### Step 2: Build the Application

```bash
# Build for RISC-V target
cargo build --release -p rustos-app

# The ELF binary will be at:
# target/riscv32imac-unknown-none-elf/release/rustos-app
```

### Step 3: Generate Binary

```bash
# Convert ELF to binary
riscv64-unknown-elf-objcopy -O binary \
    target/riscv32imac-unknown-none-elf/release/rustos-app \
    rustos-app.bin

# Check binary size (must be < 128KB)
ls -la rustos-app.bin
```

---

## Deploying to Hardware

### Using Vivado

1. Open Vivado and load the hardware project:
   ```
   hardware/rv32imacb_zicsr_zifencei_zbc/rv32imacb_zicsr_zifencei_zbc.xpr
   ```

2. Program the FPGA with the bitstream

3. Use the Hardware Manager to download the application

### Using OpenOCD

```bash
# Start OpenOCD
openocd -f interface/ftdi/digilent-hs1.cfg \
        -f target/riscv.cfg

# In another terminal, connect with GDB
riscv64-unknown-elf-gdb target/riscv32imac-unknown-none-elf/release/rustos-app

# In GDB:
(gdb) target remote localhost:3333
(gdb) load
(gdb) continue
```

### Serial Console

Connect to the UART for debug output:

```bash
# Linux
screen /dev/ttyUSB1 115200

# Or use minicom
minicom -D /dev/ttyUSB1 -b 115200
```

---

## Debugging

### GDB Commands

```gdb
# Set breakpoint
(gdb) break blinker_task

# Step through code
(gdb) step
(gdb) next

# Print variables
(gdb) print count

# View registers
(gdb) info registers

# View memory
(gdb) x/16xw 0x80000000

# Backtrace
(gdb) backtrace
```

### Debug Features

Enable debug features in `Cargo.toml`:

```toml
[features]
default = ["diagnostics", "statistics"]
```

Use diagnostic functions:

```rust
use rustos_kernel::scheduler;

// Get context switch count
#[cfg(feature = "statistics")]
let switches = scheduler::get_context_switch_count();

// Get task state
#[cfg(feature = "diagnostics")]
let state = scheduler::get_task_state(TaskId(1));
```

### UART Debug Output

```rust
use rustos_hal::uart::Uart;

fn debug_print(msg: &str) {
    let uart = Uart::new(rustos_pac::UART0_BASE);
    uart.write_str(msg);
    uart.write_str("\r\n");
}
```

---

## Common Issues

### Build Errors

**Error: "can't find crate for `std`"**
- Ensure `#![no_std]` is at the top of main.rs
- Check target is `riscv32imac-unknown-none-elf`

**Error: "undefined reference to `_start`"**
- Verify linker script is in place (`linker.ld`)
- Check `.cargo/config.toml` has correct linker settings

### Runtime Issues

**System hangs after start**
- Check interrupt handlers are installed
- Verify timer is configured correctly
- Ensure at least one task is ready

**Stack overflow**
- Increase task stack size
- Enable stack checking: `features = ["stack-check"]`

**Tasks not switching**
- Verify timer interrupt is enabled
- Check task priorities
- Ensure `scheduler::start()` was called

### Hardware Issues

**UART not working**
- Check baud rate (115200 default)
- Verify TX/RX pin connections
- Ensure UART clock is enabled

**LED not blinking**
- Check GPIO pin number
- Verify GPIO direction is output
- Check LED polarity (active high/low)

---

## Next Steps

- Read the [Task Programming Guide](TASK_PROGRAMMING.md) for advanced patterns
- Explore [Synchronization Primitives](SYNC_PRIMITIVES.md) for inter-task communication
- Review [Example Applications](EXAMPLES.md) for real-world usage

---

## Support

- GitHub Issues: Report bugs and request features
- Documentation: See `/docs` directory
- Source Code: All code is documented with `cargo doc`

Happy hacking with RustOS! 🦀
