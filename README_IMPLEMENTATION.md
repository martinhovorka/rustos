# RustOS Project

A preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.

## Status

**Implementation:** ✅ In Progress  
**Requirements:** 800+ requirements from REQUIREMENTS.md v2.8.3  
**Traceability:** Full requirement identifiers in source code comments

## Quick Start

### Prerequisites

- Rust 1.82.0 or later (for stable `#[naked]` functions)
- RISC-V GCC toolchain: `riscv64-unknown-elf-gcc`
- Xilinx Vivado 2025.2 (for FPGA programming)
- Xilinx Vitis 2025.2 (for debugging)

### Building

```bash
# Install RISC-V target
rustup target add riscv32imac-unknown-none-elf

# Build all crates
cargo build --release --workspace

# Build application
cd rustos-app
cargo build --release
```

Or use the build script:

```bash
chmod +x build.sh
./build.sh
```

### Testing

```bash
# Run host-based tests
cargo test --package rustos-tests
```

## Project Structure

```
rustos/
├── rustos-pac/          # Peripheral Access Crate (PAC-001 to PAC-083)
├── rustos-hal/          # Hardware Abstraction Layer (HAL-001 to ETH-009)
├── rustos-kernel/       # RTOS Kernel (KERN-001 to SCHED-017)
├── rustos-board/        # Board Support Package (BOARD-001 to BOOT-012)
├── rustos-app/          # Example Application (APP-001 to APP-020)
├── rustos-tests/        # Test Suite (TEST-001 to HWTEST-012)
├── bsp/                 # Vitis BSP and hardware platform
├── hardware/            # Vivado FPGA design
└── requirements/        # Requirements specification (v2.8.3)
```

## Implementation Status

### ✅ Completed

- **Workspace Structure** (PROJ-001 to PROJ-009)
- **PAC** - Peripheral Access Crate with all register definitions
  - UART, GPIO, INTC, SPI, I2C, Ethernet, WDT registers
- **Kernel Core** - Task management, scheduler, context switching
  - 256 priority levels, up to 16 tasks
  - O(1) priority-based scheduling
  - Preemptive multitasking with timer tick
- **Synchronization** - Mutex, Semaphore, MessageQueue, EventFlags
- **Time Management** - System tick, delays, timers
- **Critical Sections** - Interrupt-safe mutual exclusion
- **HAL** - UART, GPIO, Timer, Interrupt Controller drivers
- **Board BSP** - Startup code, trap handling, initialization
- **Build System** - Linker scripts, build scripts, CI/CD

### 🚧 In Progress

- Extended HAL drivers (SPI, I2C, Ethernet, WDT)
- Test suite with hardware mocking
- Documentation and examples

### 📋 Planned

- Advanced scheduler features (tick-less idle, priority inheritance)
- Comprehensive test coverage (COV-001: target 80%+)
- Benchmarking and performance validation
- Example applications demonstrating all features

## Requirement Traceability

All source code includes requirement identifiers in comments, enabling full traceability from requirements to implementation. Example:

```rust
/// REQ: SCHED-002 - Priority-based scheduling with 256 levels
pub struct TaskPriority(pub u8);
```

Requirements are defined in `requirements/REQUIREMENTS.md` (v2.8.3, 800+ requirements).

## License

Dual licensed under MIT OR Apache-2.0 (per DEP-002).

## Contributing

This is an implementation of a formally specified RTOS. All changes must maintain traceability to requirements.

1. Reference requirement IDs in all code
2. Update tests to verify requirements
3. Run `cargo test` and `cargo clippy`
4. Ensure code coverage meets 80% target

## Documentation

- **Requirements:** `requirements/REQUIREMENTS.md`
- **Hardware:** `hardware/README.md`
- **BSP:** `bsp/README.md`
- **API Docs:** Run `cargo doc --open`
