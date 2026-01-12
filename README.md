# RustOS

A preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.

> **Project Status:** ✅ Implementation Complete (98.6%)  
> All Must and Should requirements implemented. 197 tests passing. Production ready.

## Overview

RustOS is a lightweight RTOS designed for the MicroBlaze V (RISC-V) soft-core processor running on the Digilent Arty A7-35 FPGA development board. It provides:

- **Preemptive multitasking** with priority-based scheduling (256 priority levels)
- **Synchronization primitives**: Mutex, Semaphore, Message Queue, Event Flags
- **Static memory allocation** — no heap, no fragmentation
- **Hardware Abstraction Layer (HAL)** for UART, Timer, GPIO, SPI, I2C, Ethernet, WDT
- **Comprehensive test suite** with 197 tests (80%+ coverage)

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

## Quick Start

### Prerequisites

- **Rust** 1.82.0 or later (for stable `#[naked]` functions)
- **RISC-V GCC**: `riscv64-unknown-elf-gcc` for linking
- **Xilinx Vivado 2025.2**: For FPGA bitstream programming

### Building

```bash
# Install RISC-V target
rustup target add riscv32imac-unknown-none-elf

# Build all crates
cargo build --release --workspace

# Or use the build script
./build.sh

# Output: target/riscv32imac-unknown-none-elf/release/rustos-app
```

### Testing

```bash
# Run host-based tests (use --test-threads=1 for shared state tests)
cargo test --package rustos-tests --target x86_64-unknown-linux-gnu -- --test-threads=1
```

## Project Structure

```text
rustos/
├── rustos-pac/          # Peripheral Access Crate (type-safe register access)
├── rustos-hal/          # Hardware Abstraction Layer (device drivers)
├── rustos-kernel/       # RTOS Kernel (scheduler, tasks, sync primitives)
├── rustos-board/        # Board Support Package (startup, trap handling)
├── rustos-app/          # Example Application
├── rustos-tests/        # Test Suite (197 tests)
├── docs/                # User documentation
├── requirements/        # Requirements specification (v2.8.3, 800 requirements)
├── bsp/                 # Vitis BSP and hardware platform
└── hardware/            # Vivado FPGA design
```

## Implementation Status

| Priority | Implemented | Total | Percentage |
|----------|-------------|-------|------------|
| **Must** | 319 | 319 | **100%** ✅ |
| **Should** | 378 | 378 | **100%** ✅ |
| **Could** | 61 | 72 | 85% |
| **Info** | 31 | 31 | 100% |
| **TOTAL** | **789** | **800** | **98.6%** ✅ |

### Completed Features

- ✅ **Kernel Core** — O(1) preemptive scheduler, 256 priority levels, 16 tasks max
- ✅ **Context Switching** — 3.2 µs latency (target: ≤5 µs)
- ✅ **Synchronization** — Mutex, Semaphore, MessageQueue, EventFlags
- ✅ **Time Management** — 1 kHz tick, delays, software timers
- ✅ **HAL Drivers** — UART, GPIO, Timer, SPI, I2C, Ethernet, WDT, INTC
- ✅ **Tickless Idle** — Feature-gated low-power mode
- ✅ **Priority Inheritance** — Feature-gated mutex protocol
- ✅ **Test Suite** — 197 tests passing (80%+ line coverage)

### Performance

| Metric | Target | Achieved |
|--------|--------|----------|
| Context switch | ≤ 5 µs | 3.2 µs ✅ |
| Interrupt latency | ≤ 1 µs | 0.7 µs ✅ |
| Memory footprint | ≤ 64 KB | 58 KB ✅ |
| Test coverage | ≥ 80% | 80% ✅ |

## Memory Layout

The system runs entirely from the 128 KB on-chip BRAM:

- **`.text`**: Program code, reset/trap vectors
- **`.rodata`**: Constants
- **`.data`**: Initialized static data
- **`.bss`**: Uninitialized static data (zeroed at startup)
- **Stack**: 4 KB main stack for interrupts and traps
- **Task Stacks**: 16 stacks of 2 KB each, statically allocated

## Memory Map

| Address Range             | Size   | Description                     |
|---------------------------|--------|---------------------------------|
| 0x0000_0000 - 0x0001_FFFF | 128 KB | Local BRAM (code + data)        |
| 0x4060_0000 - 0x4060_FFFF | 64 KB  | AXI UART Lite                   |
| 0x4080_0000 - 0x4080_FFFF | 64 KB  | AXI IIC (I2C)                   |
| 0x40E0_0000 - 0x40E0_FFFF | 64 KB  | AXI Ethernet Lite               |
| 0x4120_0000 - 0x4120_FFFF | 64 KB  | AXI Interrupt Controller        |
| 0x41A0_0000 - 0x41A0_FFFF | 64 KB  | AXI Timebase Watchdog Timer     |
| 0x44A0_0000 - 0x44A0_FFFF | 64 KB  | AXI Quad SPI Flash              |

## Documentation

### User Guides

- [Getting Started](docs/GETTING_STARTED.md) — Installation and first application
- [Task Programming](docs/TASK_PROGRAMMING.md) — Creating and managing tasks
- [Synchronization Primitives](docs/SYNC_PRIMITIVES.md) — Mutex, Semaphore, Queue, Events
- [Examples](docs/EXAMPLES.md) — 8 complete example applications
- [Roadmap](docs/ROADMAP.md) — v1.1 and v2.0 planned features

### Technical Documentation

- [Architecture](docs/ARCHITECTURE.md) — System design and internals
- [API Stability](docs/API_STABILITY.md) — Versioning and stability policy
- [Traceability Matrix](docs/TRACEABILITY_MATRIX.md) — Requirements to implementation mapping
- [Verification Report](docs/VERIFICATION_REPORT.md) — Comprehensive testing status
- [HAL Verification](docs/HAL_VERIFICATION.md) — Driver verification report
- [Performance Benchmarks](docs/PERFORMANCE_BENCHMARKS.md) — Timing measurements
- [Test Infrastructure](docs/TEST_INFRASTRUCTURE.md) — Test framework documentation

### Reference

- [Requirements Specification](requirements/REQUIREMENTS.md) — v2.8.3, 800 requirements
- [Implementation Status](IMPLEMENTATION_STATUS.md) — Detailed status tracking
- [Hardware Design](hardware/README.md) — Vivado project and peripherals
- [Board Support Package](bsp/README.md) — Vitis BSP configuration

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

## FPGA Deployment

1. **Program the FPGA** with the bitstream:
   ```bash
   # Bitstream: hardware/artifacts/bitstream/rv32imacb_zicsr_zifencei_zbc-bitstream.bit
   ```

2. **Download the ELF** to the processor via JTAG

3. **Connect serial console** at 115200 baud (8-N-1)

## External References

- [MicroBlaze V Processor Reference Guide (UG1629)](https://www.xilinx.com/support/documentation/user_guides/ug1629.html)
- [Arty A7 Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
- [RISC-V ISA Specifications](https://riscv.org/technical/specifications/)

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
