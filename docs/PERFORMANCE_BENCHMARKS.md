# Performance Benchmarks

REQ: PERFTEST-001 to PERFTEST-006

## Overview

This document describes the performance benchmarking infrastructure for RustOS kernel.
Benchmarks measure critical kernel operations and track performance regressions over time.

## Running Benchmarks

### Quick Start

```bash
# Run all benchmarks on host
cd rustos-tests
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench
```

### Requirements

- **Target**: x86_64-unknown-linux-gnu (host system with std)
- **Feature**: `bench` must be enabled
- **Mock CSR**: Uses simulated cycle counter for measurements

### Command Options

```bash
# Run with default iterations (1000)
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench

# Future: Run with custom iterations
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --iterations 5000

# Future: Run regression tests against baseline
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --regression baseline.json
```

## Benchmark Categories

### PERFTEST-001: Context Switch Latency

**Requirement**: Measure time to switch between two tasks

**Implementation**:
- Creates two mock tasks with different priorities
- Measures mcycle CSR before and after context switch
- Performs 1000 iterations for statistical accuracy

**Metrics**:
- Average cycles: ~50 cycles (mock implementation)
- Min/Max: Captures best and worst case
- Standard deviation: Measures consistency

**Code Reference**: `benchmark::context_switch::benchmark()`

### PERFTEST-002: Interrupt Latency

**Requirement**: Measure time from GPIO edge to ISR entry

**Implementation**:
- Simulates GPIO interrupt trigger
- Measures mcycle from interrupt signal to handler entry
- Includes interrupt controller processing time

**Metrics**:
- Average cycles: ~25 cycles (mock implementation)
- Critical for real-time response guarantees
- Should be < 100 cycles on actual hardware

**Code Reference**: `benchmark::interrupt_latency::benchmark()`

### PERFTEST-003: Synchronization Primitive Overhead

**Requirement**: Measure overhead of sync primitives

**Primitives Tested**:
1. **Mutex**: Lock and unlock operations
   - Average: ~10 cycles
   - Critical path for resource protection

2. **Semaphore**: Wait and signal operations
   - Average: ~8 cycles
   - Used for task synchronization

3. **Message Queue**: Enqueue and dequeue operations
   - Average: ~20 cycles
   - Includes memory copy overhead

**Code Reference**: `benchmark::sync_overhead` module

### PERFTEST-004: Code Size Measurement

**Requirement**: Track binary size metrics

**Metrics Collected**:
- `.text` section: Executable code size
- `.rodata` section: Read-only data
- `.data` section: Initialized data
- `.bss` section: Uninitialized data
- Total binary size

**Example Output**:
```
Code Size Metrics (REQ: PERFTEST-004)
----------------------------------------------------------------------------------------------------
rustos-app           | .text:   6144 | .rodata:    512 | .data:    128 | .bss:    256 | Total:    7040
```

**Usage**: Detect code bloat and optimize for embedded targets

**Code Reference**: `benchmark::code_size` module

### PERFTEST-005: Stack Usage Tracking

**Requirement**: Measure stack high-water marks

**Implementation**:
- Tracks maximum stack usage per task
- Calculates usage percentage
- Identifies stack overflow risks

**Metrics**:
```
idle_task    | Size: 512  | Used: 128 | High-water: 128 | Usage: 25%
main_task    | Size: 2048 | Used: 672 | High-water: 672 | Usage: 32%
worker_task  | Size: 1024 | Used: 384 | High-water: 384 | Usage: 37%
```

**Critical Thresholds**:
- ⚠️  Warning: > 75% usage
- 🚨 Critical: > 90% usage

**Code Reference**: `benchmark::stack_usage` module

### PERFTEST-006: Performance Regression Testing

**Requirement**: Detect performance regressions

**Implementation**:
1. **Baseline Capture**: Save current metrics as baseline
2. **Comparison**: Compare new runs against baseline
3. **Threshold**: Default 10% tolerance
4. **Reporting**: Pass/fail with delta percentage

**Example Output**:
```
Regression Testing (REQ: PERFTEST-006)
----------------------------------------------------------------------------------------------------
✅ PASS | Context Switch        | Baseline:  50 | Current:  50 | Delta: +0 (+0.00%)
✅ PASS | Interrupt Latency     | Baseline:  25 | Current:  25 | Delta: +0 (+0.00%)
⚠️  FAIL | Mutex Lock/Unlock     | Baseline:  10 | Current:  12 | Delta: +2 (+20.00%)
```

**Code Reference**: `benchmark::regression` module

## Architecture

### Measurement Infrastructure

```rust
// Core measurement primitive (REQ: PERFTEST-001)
pub fn measure_cycles<F>(f: F) -> u64
where
    F: FnOnce(),
{
    let start = MOCK_CSR.read_mcycle();
    f();
    let end = MOCK_CSR.read_mcycle();
    end - start
}
```

### Statistical Analysis

```rust
pub struct BenchmarkResult {
    pub name: &'static str,
    pub iterations: u32,
    pub avg_cycles: u64,
    pub min_cycles: u64,
    pub max_cycles: u64,
    pub std_dev: u64,
}
```

### Mock vs. Real Hardware

**Mock Implementation** (x86_64-unknown-linux-gnu):
- Uses `AtomicU64` for cycle counter
- Simulated context switches with deterministic timing
- Perfect for CI/CD regression testing
- No hardware dependencies

**Real Hardware** (riscv32imac-unknown-none-elf):
- Uses actual `mcycle` CSR
- Real interrupt latency measurements
- True context switch overhead
- Reflects actual system performance

## Interpreting Results

### Baseline Expectations

| Metric                | Target (RISC-V) | Mock (x86_64) |
|-----------------------|-----------------|---------------|
| Context Switch        | < 200 cycles    | 50 cycles     |
| Interrupt Latency     | < 100 cycles    | 25 cycles     |
| Mutex Lock/Unlock     | < 50 cycles     | 10 cycles     |
| Semaphore Wait/Signal | < 40 cycles     | 8 cycles      |
| Queue Enqueue/Dequeue | < 100 cycles    | 20 cycles     |

### Performance Optimization

1. **Context Switch**:
   - Minimize register saves/restores
   - Optimize task struct layout for cache
   - Use hardware thread switching if available

2. **Interrupt Latency**:
   - Reduce interrupt handler prologues
   - Minimize critical section nesting
   - Use hardware interrupt prioritization

3. **Sync Primitives**:
   - Use lock-free algorithms where possible
   - Minimize atomic operations
   - Batch operations to reduce overhead

## CI/CD Integration

### Automated Regression Testing

```yaml
# .github/workflows/benchmark.yml
name: Performance Benchmarks

on: [push, pull_request]

jobs:
  benchmark:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run benchmarks
        run: |
          cd rustos-tests
          cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench

      - name: Check regression
        run: |
          # Compare with baseline from main branch
          cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --regression baseline.json
```

### Baseline Management

```bash
# Capture baseline for current main branch
git checkout main
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench > baseline.txt

# On feature branch, compare against baseline
git checkout feature-branch
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --regression ../baseline.json
```

## Module Organization

```
rustos-tests/
├── src/
│   ├── benchmark.rs          # Main benchmark module
│   │   ├── context_switch    # PERFTEST-001
│   │   ├── interrupt_latency # PERFTEST-002
│   │   ├── sync_overhead     # PERFTEST-003
│   │   ├── code_size         # PERFTEST-004
│   │   ├── stack_usage       # PERFTEST-005
│   │   └── regression        # PERFTEST-006
│   └── bin/
│       └── bench.rs          # Standalone benchmark runner
└── Cargo.toml               # With 'bench' feature
```

## Testing

All benchmark infrastructure has unit tests:

```bash
# Run benchmark module tests
cargo test --target x86_64-unknown-linux-gnu --features bench benchmark::

# Expected output:
# test benchmark::tests::test_benchmark_result_statistics ... ok
# test benchmark::tests::test_code_size_metrics ... ok
# test benchmark::tests::test_context_switch_benchmark ... ok
# test benchmark::tests::test_interrupt_latency_benchmark ... ok
# test benchmark::tests::test_regression_testing ... ok
# test benchmark::tests::test_stack_usage_metrics ... ok
# test benchmark::tests::test_sync_overhead_benchmarks ... ok
#
# test result: ok. 7 passed; 0 failed
```

## Future Enhancements

### PERFTEST-007: Memory Allocator Performance
- Allocation/deallocation latency
- Fragmentation analysis
- Peak memory usage tracking

### PERFTEST-008: Scheduler Overhead
- Task selection latency
- Priority queue operations
- Tick processing time

### PERFTEST-009: DMA Transfer Performance
- Setup overhead
- Transfer throughput
- Completion notification latency

### PERFTEST-010: Power State Transitions
- Enter/exit sleep mode latency
- Peripheral enable/disable time
- Wake-up latency

## References

- [benchmark.rs](rustos-tests/src/benchmark.rs) - Complete implementation
- [bench.rs](rustos-tests/src/bin/bench.rs) - Standalone runner
- [REQUIREMENTS.md](requirements/REQUIREMENTS.md) - Full PERFTEST requirements
- [TEST_INFRASTRUCTURE.md](TEST_INFRASTRUCTURE.md) - Test system architecture

## Troubleshooting

### Build Errors

**Problem**: `error[E0463]: can't find crate for 'std'`

**Solution**: Ensure you're building for x86_64-unknown-linux-gnu:
```bash
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench
```

**Problem**: `error: target `bench` in package `rustos-tests` requires the features: `bench``

**Solution**: Add `--features bench` flag:
```bash
cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench
```

### Unexpected Results

**Problem**: Benchmarks show 0 cycles for all operations

**Solution**: Verify MOCK_CSR is properly initialized:
```rust
MOCK_CSR.mcycle.store(0, Ordering::Relaxed);
```

**Problem**: Standard deviation is unexpectedly high

**Solution**: Check for:
- Background system load
- CPU frequency scaling
- Thermal throttling
- Other processes competing for CPU

## License

MIT OR Apache-2.0

