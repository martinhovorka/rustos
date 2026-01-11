# RustOS

A preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.

> **Project Status:** Planning & Specification Phase  
> The hardware design and BSP are complete. The RTOS requirements have been specified. Rust implementation is pending.

## Overview

RustOS is a planned lightweight RTOS designed for the MicroBlaze V (RISC-V) soft-core processor running on the Digilent Arty A7-35 FPGA development board. When implemented, it will provide:

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

## Planned Features

### Kernel (Specified)

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

### Hardware Abstraction Layer (Planned)

Will provide high-level, safe drivers for on-chip peripherals.

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

### Host-Based Testing (Planned)

The kernel and HAL will be designed for dual-target testing. The test suite will run on a host machine (`x86_64-unknown-linux-gnu`) without requiring target hardware, enabling rapid development and CI/CD validation through:

- Conditional compilation (`#[cfg(target_arch = "riscv32")]`) to isolate hardware-specific code.
- Mocked hardware implementations in the `rustos-tests` crate.

## Memory Layout (Planned)

The system will run entirely from the 128 KB on-chip BRAM.

- **`.text`**: Program code, reset/trap vectors.
- **`.rodata`**: Constants.
- **`.data`**: Initialized static data.
- **`.bss`**: Uninitialized static data (zeroed at startup).
- **Stack**: 4 KB main stack for interrupts and traps.
- **Task Stacks**: 16 stacks of 2 KB each, statically allocated.
- **Heap**: none (static allocation only, per requirements MEM-001).

Estimated static memory footprint: approximately **60 KB**, well within the 128 KB limit.

## Current Project Structure

```text
rustos/
├── bsp/                     # Vitis-generated Board Support Package for Arty A7-35
│   ├── export/              # Pre-built BSP platform package
│   ├── hw/                  # Hardware specification and device tree files
│   └── mbv_microblaze_v/    # BSP domain with drivers and libraries
├── hardware/                # Vivado FPGA design and hardware artifacts
│   ├── artifacts/           # Exported bitstream, constraints, netlists, etc.
│   ├── ip_cores/            # IP core documentation
│   └── rv32imacb.../        # Complete Vivado 2025.2 project
├── requirements/            # Requirements specification (v2.6.7, 790 requirements)
│   └── REQUIREMENTS.md      # Comprehensive SRS document
├── review/                  # Validation and review documentation
│   ├── REVIEW.md            # Data consistency review findings
│   └── MISSING_INFORMATION.md # Requirements gap analysis
└── _ide/                    # IDE configuration and workspace journal
```

### Planned Rust Crates (Not Yet Implemented)

```text
rustos/
├── rustos-app/              # Custom application using RustOS
├── rustos-board/            # Board Support Package (Rust)
├── rustos-hal/              # Hardware Abstraction Layer drivers
├── rustos-kernel/           # RTOS kernel source code
├── rustos-pac/              # Peripheral Access Crate (auto-generated)
├── rustos-tests/            # Host-based test suite for kernel and HAL
```

## Prerequisites

### Software

- **Rust** 1.82.0 or later (for stable `#[naked]` functions)
- **RISC-V GCC**: `riscv64-unknown-elf-gcc` for linking
- **Xilinx Vivado 2025.2**: For FPGA bitstream programming
- **Xilinx Vitis 2025.2**: For BSP generation and debugging

### Hardware

- Digilent Arty A7-35 development board
- USB cable for JTAG programming and UART console

## Getting Started

### Current Status

The following components are **complete**:

1. **Hardware Design** - Vivado 2025.2 project with MicroBlaze V RISC-V processor
2. **Board Support Package** - Vitis-generated BSP with drivers and libraries
3. **Requirements Specification** - Comprehensive SRS document (v2.6.7, 790 requirements)
4. **Review Documentation** - Data consistency and gap analysis complete

### Next Steps (Implementation Phase)

1. Create Rust workspace with Cargo.toml
2. Implement `rustos-pac` (Peripheral Access Crate) from device tree
3. Implement `rustos-hal` (Hardware Abstraction Layer)
4. Implement `rustos-kernel` (RTOS core)
5. Implement `rustos-board` (board-specific configuration)
6. Implement `rustos-app` (example application)
7. Create `rustos-tests` (host-based test suite)

### Building (Future)

Once implemented:

```bash
# Install Rust target
rustup target add riscv32imac-unknown-none-elf
rustup component add rust-src

# Build the project (from workspace root)
./build.sh

# Output: target/riscv32imac-unknown-none-elf/release/rustos-app.elf
```

## Testing (Future)

Once implemented, the kernel will be a `#![no_std]` crate targeting embedded RISC-V. A separate test crate (`rustos-tests`) will re-implement core kernel algorithms and data structures for validation on the host machine.

```bash
# Run all tests
cargo test --package rustos-tests --target x86_64-unknown-linux-gnu
```

## FPGA Deployment

1. **Program the FPGA** with the bitstream:

   ```bash
   # Bitstream location:
   # hardware/artifacts/bitstream/rv32imacb_zicsr_zifencei_zbc-bitstream.bit
   # Use Vivado Hardware Manager or xsct
   ```

2. **Download the ELF** to the processor via JTAG (once firmware is built)

3. **Connect serial console** at 115200 baud (8-N-1)

## Memory Map

| Address Range             | Size   | Description                     |
|---------------------------|--------|---------------------------------|
| 0x0000_0000 - 0x0001_FFFF | 128 KB | Local BRAM (code + data)        |
| 0x4000_0000 - 0x4000_FFFF | 64 KB  | GPIO Shield Pins 0-19           |
| 0x4001_0000 - 0x4001_FFFF | 64 KB  | GPIO Shield Pins 26-41          |
| 0x4002_0000 - 0x4002_FFFF | 64 KB  | GPIO Push Buttons               |
| 0x4003_0000 - 0x4003_FFFF | 64 KB  | GPIO DIP Switches               |
| 0x4004_0000 - 0x4004_FFFF | 64 KB  | GPIO LEDs (4-bit)               |
| 0x4005_0000 - 0x4005_FFFF | 64 KB  | GPIO RGB LEDs                   |
| 0x4006_0000 - 0x4006_FFFF | 64 KB  | GPIO I2C Pullups                |
| 0x4060_0000 - 0x4060_FFFF | 64 KB  | AXI UART Lite                   |
| 0x4080_0000 - 0x4080_FFFF | 64 KB  | AXI IIC (I2C)                   |
| 0x40E0_0000 - 0x40E0_FFFF | 64 KB  | AXI Ethernet Lite               |
| 0x4120_0000 - 0x4120_FFFF | 64 KB  | AXI Interrupt Controller        |
| 0x41A0_0000 - 0x41A0_FFFF | 64 KB  | AXI Timebase Watchdog Timer     |
| 0x44A0_0000 - 0x44A0_FFFF | 64 KB  | AXI Quad SPI Flash              |
| 0x44A1_0000 - 0x44A1_FFFF | 64 KB  | AXI Quad SPI (External)         |

See [requirements/REQUIREMENTS.md](requirements/REQUIREMENTS.md) for the complete memory map and [hardware/README.md](hardware/README.md) for detailed hardware documentation.

## Documentation

- [Requirements Specification](requirements/REQUIREMENTS.md) — Comprehensive requirements document (v2.6.7, 790 requirements)
- [Project Review](review/REVIEW.md) — Data consistency validation findings
- [Missing Information Review](review/MISSING_INFORMATION.md) — Requirements gap analysis (95/100 readiness score)
- [Hardware Design](hardware/README.md) — Vivado project details and memory map
- [Board Support Package](bsp/README.md) — Vitis BSP configuration and driver reference

### External References

- [MicroBlaze V Processor Reference Guide (UG1629)](https://www.xilinx.com/support/documentation/user_guides/ug1629.html)
- [MicroBlaze V Embedded Design User Guide (UG1711)](https://www.xilinx.com/support/documentation/user_guides/ug1711.html)
- [Arty A7 Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
- [RISC-V ISA Specifications](https://riscv.org/technical/specifications/)

## Architecture (Planned)

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

## Interrupt Mapping

| IRQ # | Peripheral         | Sensitivity |
|-------|--------------------|-------------|
| 0     | FIT Timer 1ms      | Edge        |
| 1     | Watchdog Timer     | Level       |
| 2     | UART Lite          | Edge        |
| 3     | SPI Flash          | Edge        |
| 4     | GPIO Shield 0-19   | Level       |
| 5     | GPIO Shield 26-41  | Level       |
| 6     | GPIO Push Buttons  | Level       |
| 7     | GPIO DIP Switches  | Level       |
| 8     | Ethernet Lite      | Edge        |
| 9     | SPI External       | Edge        |
| 10    | I2C (IIC)          | Level       |

## Known Limitations

- **Implementation Status**: Rust RTOS implementation not yet started
- **Single Board Support**: Designed specifically for Arty A7-35
- **No Priority Inheritance**: Planned for v2.0 roadmap
- **No Tick-less Scheduling**: Planned for v2.0 roadmap

## License

This project is licensed under the GNU General Public License v3.0. See the [LICENSE](LICENSE) file for details.
