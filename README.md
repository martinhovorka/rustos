# RustOS

A preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.

## Overview

RustOS is a lightweight RTOS designed for the MicroBlaze V (RISC-V) soft-core processor running on the Digilent Arty A7-35 FPGA development board. It provides:

- **Preemptive multitasking** with priority-based scheduling (256 priority levels)
- **Synchronization primitives**: Mutex, Semaphore, Message Queue, Event Flags
- **Static memory allocation** — no heap, no fragmentation
- **Hardware Abstraction Layer (HAL)** for UART, Timer, GPIO, SPI, I2C, and more

## Target Hardware

| Property           | Value                                            |
|--------------------|--------------------------------------------------|
| Board              | Digilent Arty A7-35                              |
| FPGA               | Xilinx Artix-7 XC7A35TICSG324-1L                 |
| Processor          | MicroBlaze V (RISC-V soft-core)                  |
| ISA                | `rv32imacb_zicsr_zifencei_zbc`                   |
| ABI                | `ilp32` (32-bit integers, pointers, longs)       |
| Clock Frequency    | 75 MHz                                           |
| Local Memory       | 128 KB BRAM (64K instruction + 64K data via LMB) |
| Interrupt Sources  | 11 via AXI Interrupt Controller                  |

## Features

### Kernel

- **Preemptive Scheduler**: Priority-based (256 levels) with round-robin for equal-priority tasks.
- **Static Task Management**: Up to 16 concurrent tasks with statically allocated stacks.
- **Synchronization Primitives**:
  - **Mutex**: Safe mutual exclusion with RAII guards, protected by critical sections.
  - **Semaphore**: Counting semaphores for resource management.
  - **Message Queue**: Bounded, FIFO queues for thread-safe inter-task communication.
  - **Event Flags**: 32-bit event groups for complex synchronization patterns.
- **Time Management**: Tick-based delays and timeouts (default 1 kHz tick).
- **Interrupt Safety**: All kernel objects are thread-safe and can be used in ISRs (where applicable).
- **Minimal Footprint**: Designed for resource-constrained systems with no dynamic memory allocation (no `heap`).

### Hardware Abstraction Layer (HAL)

Provides high-level, safe drivers for on-chip peripherals.

| Driver     | Description                                                                 |
|------------|-----------------------------------------------------------------------------|
| `intc`     | AXI Interrupt Controller (IRQ registration, enable/disable)                 |
| `timer`    | System tick timer (1 kHz) and 64-bit uptime counter                         |
| `uart`     | AXI UART Lite driver with `core::fmt::Write` support (`print!`, `println!`) |
| `gpio`     | AXI GPIO for LEDs, buttons, and general-purpose I/O                         |
| `spi`      | AXI Quad SPI for flash memory and peripheral communication                  |
| `i2c`      | AXI IIC for two-wire interface peripherals                                  |
| `ethernet` | AXI Ethernet Lite for basic networking                                      |
| `wdt`      | AXI Timebase Watchdog Timer                                                 |

### Host-Based Testing

The kernel and HAL are designed for dual-target testing. The full test suite can be run on a host machine (`x86_64-unknown-linux-gnu`) without requiring target hardware, enabling rapid development and CI/CD validation. This is achieved through:

- Conditional compilation (`#[cfg(target_arch = "riscv32")]`) to isolate hardware-specific code.
- Mocked hardware implementations in the `rustos-tests` crate.

## Memory Layout

The system runs entirely from the 128 KB on-chip BRAM.

- **`.text`**: Program code, reset/trap vectors.
- **`.rodata`**: Constants.
- **`.data`**: Initialized static data.
- **`.bss`**: Uninitialized static data (zeroed at startup).
- **Stack**: 4 KB main stack for interrupts and traps.
- **Task Stacks**: 16 stacks of 2 KB each, statically allocated.
- **Heap**: none (static allocation only, per requirements MEM-001).

Total static memory footprint is approximately **60 KB**, well within the 128 KB limit.

## Project Structure

```text
rustos/
├── bsp/                     # Vitis-generated Board Support Package for Arty A7-35 
├── hardware/                # Vivado FPGA design and hardware artifacts
├── requirements/            # Requirements specification and documentation
├── rustos-app/              # Custom application using RustOS
├── rustos-board/            # Board Support Package
├── rustos-hal/              # Hardware Abstraction Layer drivers
├── rustos-kernel/           # RTOS kernel source code
├── rustos-pac/              # Peripheral Access Crate (auto-generated)
├── rustos-tests/            # Host-based test suite for kernel and HAL
```

## Prerequisites

### Software

- **Rust** 1.82.0 or later (for stable `#[naked]` functions)

### QA quick checks

- `./qa_safety.sh` enforces that `unsafe` blocks inside scheduler critical sections are justified with a nearby `SAFETY:` comment.
- `./build.sh` runs `./qa_safety.sh` automatically (and then builds the embedded release ELF).
- **RISC-V GCC**: `riscv64-unknown-elf-gcc` for linking
- **Xilinx Vivado 2025.2**: For FPGA bitstream programming
- **Xilinx Vitis 2025.2**: For debugging (optional)

### Hardware

- Digilent Arty A7-35 development board
- USB cable for JTAG programming and UART console

## Building

```bash
# Install Rust target
rustup target add riscv32imac-unknown-none-elf
rustup component add rust-src

# Build the project (from workspace root)
./build.sh

# Explicitly select boot mode (INIT-009)
# Default: bram-jtag
RUSTOS_BOOT_MODE=bram-jtag ./build.sh
RUSTOS_BOOT_MODE=qspi-flash ./build.sh

# Output: target/riscv32imac-unknown-none-elf/release/rustos-app.elf
```

### Cleaning

```bash
./clean.sh
```

### Coverage (host-side, measured)

This repository includes extensive host-side tests in `rustos-tests`. To generate a measured coverage report, use:

```bash
./coverage.sh
```

Notes:

- On stable Rust, the script generates line coverage.
- Branch coverage currently requires a nightly toolchain.

## Running Tests

The kernel is a `#![no_std]` crate targeting embedded RISC-V, so standard Rust tests cannot run directly in the kernel. Instead, a separate test crate (`rustos-tests`) re-implements core kernel algorithms and data structures for validation on the host machine.

```bash
# Run all tests (196 tests covering kernel logic)
cargo test --package rustos-tests --target x86_64-unknown-linux-gnu

# Run specific test module
cargo test --package rustos-tests --target x86_64-unknown-linux-gnu semaphore_tests
cargo test --package rustos-tests --target x86_64-unknown-linux-gnu queue_tests
```

### Test Coverage

| Module                             | Tests | Description                                        |
| ---------------------------------- | ----- | -------------------------------------------------- |
| `TODO`                             | TODO  | TODO                                               |

Total: **TBD tests**

### Notes

- Tests run on the **host machine** (Linux x86_64), not the embedded target
- The test crate mirrors kernel data structures to validate algorithms independently
- Test coverage targets all code paths and branch conditions
- Integration tests requiring actual hardware or QEMU are not yet implemented

Implementation note:

- `rustos-tests` is a workspace member, so it is structured to compile on the embedded target as an empty `no_std` crate.
    The host-mirrored logic and its unit tests are gated behind `cfg(not(target_os = "none"))`.

## Deployment

1. **Program the FPGA** with the bitstream:

   ```bash
   cd hardware/hw/artifacts/bitstream/
   # Use Vivado Hardware Manager or xsct
   ```

2. **Download the ELF** to the processor via JTAG

3. **Connect serial console** at 115200 baud (8-N-1)

## Memory Map

| Address Range             | Size   | Description                     |
|---------------------------|--------|---------------------------------|
| 0x0000_0000 - 0x0001_FFFF | 128 KB | Local BRAM (code + data)        |
| 0x4004_0000 - 0x4004_FFFF | 64 KB  | GPIO LEDs (4-bit)               |
| 0x4060_0000 - 0x4060_FFFF | 64 KB  | AXI UART Lite                   |
| 0x4120_0000 - 0x4120_FFFF | 64 KB  | AXI Interrupt Controller        |
| 0x41A0_0000 - 0x41A0_FFFF | 64 KB  | AXI Timebase Watchdog Timer     |
| 0x44A0_0000 - 0x44A0_FFFF | 64 KB  | AXI Quad SPI Flash              |

See [requirements/REQUIREMENTS.md](requirements/REQUIREMENTS.md#16-memory-map) for the complete memory map.

## Documentation

- [Requirements Specification](requirements/REQUIREMENTS.md) — Comprehensive requirements document
- [Project Review](review/REVIEW.md) — Validation findings and open problems
- [Hardware Design](hardware/README.md) — Vivado project details
- [Board Support Package](bsp/README.md) — Vitis project (generated BSP) configuration

### External References

- [MicroBlaze V Processor Reference Guide (UG1629)](https://www.xilinx.com/support/documentation/user_guides/ug1629.html)
- [MicroBlaze V Embedded Design User Guide (UG1711)](https://www.xilinx.com/support/documentation/user_guides/ug1711.html)
- [Arty A7 Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
- [RISC-V ISA Specifications](https://riscv.org/technical/specifications/)

## Architecture

```text
┌─────────────────────────────────────────┐
│         Application Layer               │
│    (User tasks, business logic)         │
├─────────────────────────────────────────┤
│         Synchronization Layer           │
│  (Mutex, Semaphore, MessageQueue)       │
├─────────────────────────────────────────┤
│         Kernel Core                     │
│  (Scheduler, Task Manager, Context)     │
├─────────────────────────────────────────┤
│    Hardware Abstraction Layer (HAL)     │
│  (UART, Timer, GPIO, SPI, I2C, WDT)     │
├─────────────────────────────────────────┤
│  Peripheral Access Crate (PAC)          │
│  (Register-level hardware access)       │
├─────────────────────────────────────────┤
│  Board Support Package (BSP)            │
│  (Startup, Trap Handling, Init)         │
├─────────────────────────────────────────┤
│      MicroBlaze V RISC-V Hardware       │
│  (rv32imacb_zicsr_zifencei_zbc @ 75MHz) │
└─────────────────────────────────────────┘
```

## Known Limitations

- TODO: List known issues, missing features, or limitations here.

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
