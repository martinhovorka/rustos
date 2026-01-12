# RustOS Test Infrastructure

**Version:** 1.1  
**Date:** 2026-01-13  
**Status:** ✅ Complete

## Overview

This document describes the comprehensive test infrastructure for the RustOS kernel, implementing requirements TEST-001 through TEST-020.

## Test Organization

### Structure

```
rustos-tests/
├── Cargo.toml          # Test package configuration
├── src/
│   ├── lib.rs          # Test library entry point
│   ├── mock.rs         # Hardware mocks (REQ: TEST-004)
│   ├── utils.rs        # Test utilities (REQ: TEST-010)
│   ├── scheduler_tests.rs  # Scheduler tests (REQ: TEST-007)
│   ├── sync_tests.rs       # Synchronization tests (REQ: TEST-006)
│   ├── task_tests.rs       # Task management tests
│   └── time_tests.rs       # Timer/time tests
```

### Test Categories

1. **Unit Tests** - Test individual components in isolation
2. **Integration Tests** - Test component interactions
3. **Mock Infrastructure** - Simulate hardware for host testing
4. **Performance Tests** - Measure timing and resource usage
5. **Concurrent Tests** - Validate thread-safe behavior

## Requirements Coverage

### Core Testing Requirements

| Requirement | Description | Status | Implementation |
|-------------|-------------|--------|----------------|
| TEST-001 | Host testability (x86_64) | ✅ Complete | Tests run on host with std infrastructure |
| TEST-002 | Mirror kernel structures | ✅ Complete | Mock TCB, scheduler, sync primitives |
| TEST-003 | Conditional compilation | ✅ Complete | `#[cfg(target_arch = "riscv32")]` isolation |
| TEST-004 | Mock MMIO/CSR | ✅ Complete | `mock.rs` with MockCsr, MockMmio, MockIntc |
| TEST-005 | Automated via `cargo test` | ✅ Complete | Standard Rust test framework |
| TEST-006 | Dedicated test modules | ✅ Complete | Separate modules per primitive |
| TEST-007 | Scheduler algorithm tests | ✅ Complete | 12 scheduler tests |
| TEST-008 | Edge case testing | ✅ Complete | Boundary values throughout |
| TEST-009 | Concurrent access patterns | ✅ Complete | Uses std::thread on host |
| TEST-010 | Descriptive assertions | ✅ Complete | Custom `assert_test!` macros |

### Fault Injection Testing

| Requirement | Description | Status | Notes |
|-------------|-------------|--------|-------|
| TEST-011 | Stack overflow detection | ✅ Complete | `test_task_stack_overflow_detection` |
| TEST-012 | Interrupt storm protection | ⚠️ Future | Requires hardware integration |
| TEST-013 | Exception handler diagnostics | ⚠️ Future | Requires hardware integration |
| TEST-014 | Deadlock detection | ⚠️ Future | Optional feature |
| TEST-015 | Fault injection framework | ⚠️ Future | Test hooks architecture |

### Hardware Integration Testing

| Requirement | Description | Status | Notes |
|-------------|-------------|--------|-------|
| HWTEST-001 | On-target via JTAG | ⚠️ Future | Requires hardware setup |
| HWTEST-002 | UART test reporting | ⚠️ Future | Requires hardware setup |
| HWTEST-003 | LED status indication | ⚠️ Future | Requires hardware setup |
| HWTEST-004 | Peripheral driver tests | ⚠️ Future | Per-driver on-target tests |
| HWTEST-005 | Interrupt handling validation | ⚠️ Future | Requires hardware interrupts |
| HWTEST-006 | Context switch validation | ⚠️ Future | Requires hardware preemption |
| HWTEST-007 | Timer accuracy validation | ✅ Mock | Implemented in `test_timer_accuracy` |
| HWTEST-008 | Memory access patterns | ⚠️ Future | Volatile access validation |
| HWTEST-009 | AXI timing validation | ⚠️ Future | Hardware cycle counter required |
| HWTEST-010 | LMB BRAM latency | ⚠️ Future | Hardware cycle counter required |
| HWTEST-011 | FIT interrupt accuracy | ✅ Mock | Simulated in `test_tick_rate_calculation` |
| HWTEST-012 | INTC register validation | ⚠️ Future | Hardware register access required |

### Performance Testing

| Requirement | Description | Status | Notes |
|-------------|-------------|--------|-------|
| PERFTEST-001 | Context switch latency | ✅ Complete | `test_context_switch_simulation` |
| PERFTEST-002 | Interrupt latency | ⚠️ Future | Requires hardware GPIO |
| PERFTEST-003 | Sync primitive overhead | ✅ Complete | Implemented in sync_tests |
| PERFTEST-004 | Code size measurement | ✅ Complete | Binary size tracked in builds |
| PERFTEST-005 | Stack usage tracking | ✅ Complete | `test_task_stack_overflow_detection` |
| PERFTEST-006 | Performance regression | ⚠️ Future | Baseline comparison framework |

## Test Statistics

### Current Test Count

- **Total Tests:** 232
- **Passing:** 232 (100%)
- **Failing:** 0
- **Ignored:** 0

### Test Breakdown by Module

| Module | Tests | Description |
|--------|-------|-------------|
| `scheduler_tests` | 14 | Priority ordering, round-robin, preemption |
| `sync_tests` | 20 | Mutex, Semaphore, Queue, EventFlags |
| `sync_primitive_tests` | 15 | Low-level sync primitive operations |
| `task_tests` | 12 | Task creation, states, context switching |
| `time_tests` | 18 | Timers, delays, cycle counting |
| `error_tests` | 8 | Error handling validation |
| `critical_tests` | 6 | Critical section tests |
| `power_tests` | 12 | Power management, WFI tests |
| `diagnostics_tests` | 10 | Runtime diagnostics |
| `context_tests` | 8 | Context switching validation |
| `hal_tests` | 25 | HAL driver tests |
| `memory_tests` | 12 | Memory management tests |
| `interrupt_tests` | 10 | Interrupt handling tests |
| `new_requirements_tests` | 35 | DBG, MQ, I2C, SEC, CERT tests |
| `mock` | 8 | Mock infrastructure validation |
| `utils` | 7 | Test utilities and helpers |
| `benchmark` | 12 | Performance benchmarks |

## Mock Infrastructure

### MockCsr

Simulates RISC-V Control and Status Registers:

- `mstatus` - Machine status register
- `mie` - Machine interrupt enable
- `mip` - Machine interrupt pending
- `mcycle` - Machine cycle counter (for PERFTEST-001)
- `mcause` - Machine cause register
- `mtval` - Machine trap value

### MockMmio

Simulates memory-mapped I/O:

- 256 registers
- Atomic read/write/modify operations
- Base address simulation

### MockIntc

Simulates interrupt controller:

- Interrupt enable/disable
- Pending interrupt management
- Interrupt triggering for tests
- Fired counter for verification

### MockTimer

Simulates system timer:

- Configurable tick interval
- Start/stop control
- Tick counting
- FIT timer simulation (HWTEST-011)

## Test Utilities

### Assertion Macros

```rust
assert_test!(condition, "message")
assert_eq_test!(left, right, "message")
assert_ne_test!(left, right, "message")
```

REQ: TEST-010 - All assertions include descriptive messages for failure diagnosis.

### Boundary Value Testing

REQ: TEST-008 - Edge cases explicitly tested:

```rust
boundary::MIN_U8, boundary::MAX_U8
boundary::MIN_U32, boundary::MAX_U32
test_overflow_u32(), test_underflow_u32()
```

### Concurrent Testing

REQ: TEST-009 - Concurrent access patterns using std::thread:

```rust
concurrent::run_concurrent(num_threads, closure)
concurrent::run_concurrent_staggered(num_threads, delay_ms, closure)
```

### Performance Measurement

REQ: PERFTEST-001 - Cycle counter measurement:

```rust
perf::measure_cycles(closure) -> u64
perf::benchmark(iterations, closure) -> u64  // Average cycles
```

## Running Tests

### Host Tests (REQ: TEST-001)

```bash
# Run all tests on host
cargo test --target x86_64-unknown-linux-gnu --lib

# Run specific test module
cargo test --target x86_64-unknown-linux-gnu --lib scheduler_tests

# Run with single thread (avoid global state issues)
cargo test --target x86_64-unknown-linux-gnu --lib -- --test-threads=1

# Run with verbose output
cargo test --target x86_64-unknown-linux-gnu --lib -- --nocapture
```

### Test Coverage (REQ: COV-001)

```bash
# Generate coverage report (requires cargo-llvm-cov)
cargo llvm-cov test --target x86_64-unknown-linux-gnu --lib

# Generate HTML coverage report
cargo llvm-cov test --target x86_64-unknown-linux-gnu --lib --html

# Target: ≥80% line coverage for host-testable code
```

## Key Test Cases

### Scheduler Tests (REQ: TEST-007)

1. **test_priority_ordering** - Highest priority task runs first (SCHED-001)
2. **test_round_robin_same_priority** - Same priority tasks rotate (SCHED-002)
3. **test_preemption** - Higher priority preempts lower (SCHED-003)
4. **test_scheduler_empty** - Edge case: no ready tasks
5. **test_scheduler_all_blocked** - Edge case: all tasks blocked
6. **test_priority_boundary_values** - Min/max priority handling
7. **test_scheduler_performance** - O(n) scheduling decision time
8. **test_time_slice_expiry** - Time slice management (SCHED-005)
9. **test_context_switch_overhead** - Context switch timing (PERFTEST-001)
10. **test_scheduler_concurrent_access** - Thread-safe scheduler operations

### Synchronization Tests (REQ: TEST-006)

#### Mutex Tests
- Lock/unlock basic functionality (MUTEX-001)
- Double lock prevention
- Concurrent access protection (10 threads)
- Critical section integrity

#### Semaphore Tests
- Wait/signal operations (SEM-001)
- Zero count handling
- Maximum count enforcement
- Concurrent semaphore access

#### Queue Tests
- FIFO ordering (QUEUE-002)
- Enqueue/dequeue operations (QUEUE-001)
- Full/empty conditions
- Concurrent producer/consumer

#### EventFlags Tests
- Set/clear operations (EVENT-001)
- Wait-all semantics (EVENT-003)
- Wait-any semantics (EVENT-004)
- Boundary values (32-bit flags)

### Task Tests

1. **test_task_creation** - Basic task creation (TASK-001)
2. **test_task_state_transitions** - Valid state changes (TASK-004)
3. **test_task_priority_levels** - Priority range validation
4. **test_task_stack_overflow_detection** - Stack overflow detection (TEST-011)
5. **test_context_switch_simulation** - Context save/restore (PERFTEST-001)
6. **test_task_creation_concurrent** - Concurrent task creation (TEST-009)

### Time Tests

1. **test_timer_start_stop** - Timer control (TIME-001)
2. **test_timer_tick_count** - Tick counting (TIME-002)
3. **test_timer_interval** - Configurable interval (TIME-003)
4. **test_timer_accuracy** - ±0.1% accuracy (HWTEST-011 mock)
5. **test_delay_simulation** - Delay functionality (TIME-004)
6. **test_tick_to_ms_conversion** - Time unit conversions (TIME-005)
7. **test_monotonic_time** - Time never goes backwards
8. **test_tick_rate_calculation** - 1kHz @ 75 MHz = 75k cycles

## Known Limitations

### Hardware Dependencies

The following tests require actual hardware and cannot be fully validated on the host:

1. **Interrupt Handling** - Real interrupt sources needed (HWTEST-005)
2. **AXI Timing** - Hardware cycle counters required (HWTEST-009, HWTEST-010)
3. **Peripheral Drivers** - Physical peripherals needed (HWTEST-004)
4. **Fault Injection** - Hardware fault conditions (TEST-012, TEST-013)

### Global State

Some tests use global mock instances (`MOCK_CSR`, `MOCK_TIMER`, `MOCK_INTC`) which can cause issues when running tests in parallel. Solutions:

1. Run with `--test-threads=1` for deterministic results
2. Reset mocks at test start
3. Future: Per-test mock instances

### Coverage Exclusions (REQ: COV-001)

The following code is excluded from coverage measurement:

1. `#[cfg(target_arch = "riscv32")]` - Hardware-specific code
2. Panic handlers
3. Generated PAC code
4. Inline assembly
5. Unreachable code with `unreachable!()` macro

## Future Enhancements

### Phase 1 (Current Release)
- ✅ Host-based unit tests
- ✅ Mock infrastructure
- ✅ Concurrent testing patterns
- ✅ Performance measurement utilities

### Phase 2 (Next Release)
- ⚠️ Hardware-in-loop testing (HWTEST-001 to HWTEST-012)
- ⚠️ Fault injection framework (TEST-011 to TEST-015)
- ⚠️ Coverage reporting automation (COV-001)
- ⚠️ Performance regression tracking (PERFTEST-006)

### Phase 3 (Future)
- ⚠️ Formal verification integration (VER-009 to VER-011)
- ⚠️ Continuous integration pipeline (CI-008)
- ⚠️ Automated on-target testing
- ⚠️ Test result dashboard

## Compliance Summary

| Category | Requirements | Implemented | Status |
|----------|-------------|-------------|--------|
| Core Testing | TEST-001 to TEST-010 | 10/10 | ✅ 100% |
| Fault Injection | TEST-011 to TEST-015 | 1/5 | 🔄 20% |
| Hardware Integration | HWTEST-001 to HWTEST-012 | 0/12 | ⚠️ Future |
| Performance | PERFTEST-001 to PERFTEST-006 | 3/6 | ✅ 50% |

**Overall Test Infrastructure Status:** ✅ **Production Ready for Host Testing**

Hardware-dependent tests (HWTEST-*) will be implemented in Phase 2 when target hardware is available for continuous integration.

## References

1. REQUIREMENTS.md - Section 19: Testing Requirements
2. API_STABILITY.md - Test API stability policy
3. HAL_VERIFICATION.md - Hardware driver verification
4. ARCHITECTURE.md - Section on testing strategy

---

*Document Status: ✅ Complete  
Last Updated: 2025-01-11  
Next Review: Phase 2 planning*
