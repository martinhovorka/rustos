# Changelog

All notable changes to RustOS will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-13

### Overview

Initial production release of RustOS - a preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.

**Release Readiness:**
- ✅ 800/800 requirements implemented (100%)
- ✅ 387/387 tests passing (100%)
- ✅ 99.47% code coverage (exceeds 80% target)
- ✅ 0 clippy warnings
- ✅ Performance targets met (context switch: 3.2 µs, interrupt: 0.7 µs)
- ✅ Seven-perspective release review approved

### Added

#### Kernel Core
- Preemptive, priority-based scheduler with O(1) task selection (256 priority levels)
- Task management supporting up to 16 concurrent tasks
- Context switching with 144-byte context frame (34 registers)
- Critical section support with interrupt nesting
- 1 kHz system tick timer
- Idle task with configurable WFI (Wait For Interrupt)

#### Synchronization Primitives
- Mutex with RAII guards and optional priority inheritance
- Binary and counting semaphores
- FIFO message queue with fixed capacity
- Priority-based message queue
- Event flags with AND/OR wait conditions

#### Time Management
- System tick counter with 1 kHz resolution
- Millisecond/tick conversion utilities
- Delay functions (blocking and yielding)
- Software timers with callback support (optional feature)

#### Hardware Abstraction Layer (HAL)
- UART driver with TX/RX buffering (64 bytes each), interrupt support
- GPIO driver with edge/level interrupts, pin/port operations
- Timer driver (wraps kernel time module)
- SPI driver (master mode, all 4 SPI modes, FIFO support)
- I2C driver (7-bit/10-bit addressing, bus recovery, timing validation)
- Ethernet driver (MAC layer, ARP, ICMP echo response)
- Watchdog Timer (WDT) driver (standard/window mode, early warning)
- Interrupt Controller (INTC) driver (IRQ management, handler registration)

#### Debug & Diagnostics
- GDB stub for hardware debugging
- Semihosting support for debug output
- Runtime profiler using performance counters
- Diagnostics API for task/CPU/memory statistics (optional feature)
- Stack overflow detection with canary values

#### Security
- Secure boot validation
- Anti-rollback protection
- Watchdog integration for system integrity

#### Documentation
- Comprehensive requirements specification (REQUIREMENTS.md v2.8.3, 800 requirements)
- Architecture documentation (ARCHITECTURE.md)
- Certification preparation guide (CERTIFICATION.md)
- API stability policy (API_STABILITY.md)
- Task programming guide (TASK_PROGRAMMING.md)
- Synchronization primitives guide (SYNC_PRIMITIVES.md)
- Performance benchmarks (PERFORMANCE_BENCHMARKS.md)
- HAL verification report (HAL_VERIFICATION.md)
- Traceability matrix (TRACEABILITY_MATRIX.md)
- Test coverage report (TEST_COVERAGE_REPORT.md)
- Implementation status (IMPLEMENTATION_STATUS.md)
- Getting started guide (GETTING_STARTED.md)
- Examples (EXAMPLES.md)

#### Testing & Verification
- 387 comprehensive tests (unit, integration, acceptance)
- 99.47% code coverage via cargo-llvm-cov
- Requirements traceability with REQ tags throughout codebase
- Benchmark suite for performance validation
- Host-based test infrastructure using x86_64 target

#### Build & Configuration
- Workspace structure with 6 crates (PAC→HAL→Kernel→Board→App→Tests)
- Feature flags for optional functionality (statistics, diagnostics, timers, etc.)
- MSRV: Rust 1.82.0 (required for stable `#[naked]` functions)
- RISC-V RV32IMAC target support
- Optimized release builds (≤64 KB memory footprint, 58 KB achieved)

### Target Hardware

- **Board:** Digilent Arty A7-35
- **FPGA:** Xilinx Artix-7 XC7A35TICSG324-1L
- **Processor:** MicroBlaze V (RISC-V soft-core)
- **ISA:** rv32imacb_zicsr_zifencei_zbc
- **ABI:** ilp32 (32-bit integers, pointers, longs)
- **Clock:** 75 MHz
- **Memory:** 128 KB BRAM (64K instruction + 64K data via LMB)
- **Interrupts:** 11 sources via AXI Interrupt Controller

### Performance Metrics

| Metric | Target | Achieved | Status |
|--------|--------|----------|--------|
| Context switch latency | ≤ 5 µs | 3.2 µs | ✅ PASS |
| Interrupt latency | ≤ 1 µs | 0.7 µs | ✅ PASS |
| Memory footprint | ≤ 64 KB | 58 KB | ✅ PASS |

### Safety & Quality

- MISRA-like coding standards for Rust (RUST-001 to RUST-010)
- No heap allocation (`no_std`, `no_alloc` throughout)
- All unsafe blocks documented with SAFETY comments
- Result-based error handling (formal error codes)
- Stack overflow detection with runtime checking
- Comprehensive panic handler with register dump, LED signaling, watchdog reset
- Zero clippy warnings across all crates
- 100% documentation coverage for public APIs (`#![deny(missing_docs)]`)

### Known Limitations

1. **No floating-point operations** - Integer-only kernel by design
2. **Maximum 16 tasks** - Configuration limit (CFG-005)
3. **No dynamic memory allocation** - Static allocation only (by design)
4. **Single-core only** - No SMP support in v1.0
5. **Test coverage gaps:**
   - 32-bit specific code paths (tests run on 64-bit host)
   - Extremely rare error conditions
   - Theoretically unreachable safety code

### Future Considerations

The following features are documented but not implemented in v1.0:

- Memory protection unit (MPU) support
- Formal verification using tools like KLEE/Miri
- Extended certification artifacts for IEC 61508/ISO 26262/DO-178C
- Peripheral power gating for advanced power management
- Network stack expansion beyond basic MAC/ICMP

## Release Notes

**Approved by:**
- Technical Lead: Martin Hovorka (2026-01-13)
- Quality Assurance: Martin Hovorka (2026-01-13)
- Project Manager: Martin Hovorka (2026-01-13)
- Software Team: Martin Hovorka (2026-01-13)
- Software V&V Team: Martin Hovorka (2026-01-13)
- Hardware Team: Martin Hovorka (2026-01-13)
- Hardware V&V Team: Martin Hovorka (2026-01-13)

**Release Tag:** v1.0.0

---

## [Unreleased]

No changes yet.

---

## Version History

[1.0.0]: https://github.com/martinhovorka/rustos/releases/tag/v1.0.0
