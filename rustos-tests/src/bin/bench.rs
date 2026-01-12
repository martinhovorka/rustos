//! Performance Benchmark Runner
//!
//! This binary runs comprehensive performance benchmarks for RustOS kernel.
//! 
//! Usage:
//!   cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench
//!   cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --iterations 1000
//!   cargo run --target x86_64-unknown-linux-gnu --bin bench --features bench -- --regression baseline.json

use rustos_tests::benchmark::*;
use rustos_tests::mock::MOCK_CSR;
use core::sync::atomic::Ordering;

fn main() {
    println!("{}", "=".repeat(100));
    println!("RustOS Kernel Performance Benchmarks");
    println!("REQ: PERFTEST-001 to PERFTEST-006");
    println!("{}", "=".repeat(100));
    println!();

    // Reset cycle counter
    MOCK_CSR.mcycle.store(0, Ordering::Relaxed);

    let iterations = 1000;

    // Header
    println!("{:<30} | {:>6} | {:>8} | {:>8} | {:>8} | {:>8}", 
             "Benchmark", "Iter", "Avg", "Min", "Max", "StdDev");
    println!("{}", "-".repeat(100));

    // REQ: PERFTEST-001 - Context switch latency
    let ctx_switch = context_switch::benchmark(iterations);
    println!("{}", ctx_switch.display());

    // REQ: PERFTEST-002 - Interrupt latency
    let irq_latency = interrupt_latency::benchmark(iterations);
    println!("{}", irq_latency.display());

    println!();

    // REQ: PERFTEST-003 - Synchronization primitive overhead
    let mutex_bench = sync_overhead::benchmark_mutex(iterations);
    println!("{}", mutex_bench.display());

    let sem_bench = sync_overhead::benchmark_semaphore(iterations);
    println!("{}", sem_bench.display());

    let queue_bench = sync_overhead::benchmark_queue(iterations);
    println!("{}", queue_bench.display());

    println!();
    println!("{}", "=".repeat(100));
    println!();

    // REQ: PERFTEST-004 - Code size measurement
    println!("Code Size Metrics (REQ: PERFTEST-004)");
    println!("{}", "-".repeat(100));
    
    if let Ok(metrics) = code_size::measure_binary_size("target/riscv32imac-unknown-none-elf/release/rustos-app") {
        println!("{}", metrics.display());
    }

    println!();
    println!("{}", "=".repeat(100));
    println!();

    // REQ: PERFTEST-005 - Stack usage tracking
    println!("Stack Usage Metrics (REQ: PERFTEST-005)");
    println!("{}", "-".repeat(100));

    let idle_task = stack_usage::StackUsageMetrics::new("idle_task", 512, 128);
    println!("{}", idle_task.display());

    let main_task = stack_usage::StackUsageMetrics::new("main_task", 2048, 672);
    println!("{}", main_task.display());

    let worker_task = stack_usage::StackUsageMetrics::new("worker_task", 1024, 384);
    println!("{}", worker_task.display());

    println!();
    println!("{}", "=".repeat(100));
    println!();

    // REQ: PERFTEST-006 - Performance regression testing
    println!("Regression Testing (REQ: PERFTEST-006)");
    println!("{}", "-".repeat(100));

    let baseline = regression::BaselineMetrics::capture();
    let regression_results = regression::run_regression_tests(&baseline, 10.0);

    for result in &regression_results {
        println!("{}", result.display());
    }

    println!();
    println!("{}", "=".repeat(100));
    println!();

    // Summary
    let all_passed = regression_results.iter().all(|r| r.passed);
    if all_passed {
        println!("✅ All performance benchmarks completed successfully!");
        println!("✅ No performance regressions detected (within 10% threshold)");
    } else {
        println!("⚠️  Performance regressions detected!");
        let failed_count = regression_results.iter().filter(|r| !r.passed).count();
        println!("   {} of {} metrics exceeded regression threshold", failed_count, regression_results.len());
    }

    println!();
    println!("Benchmark run completed");
    println!("{}", "=".repeat(100));
}
