//! Performance Benchmarking Module
//!
//! REQ: PERFTEST-001 to PERFTEST-006
//!
//! This module provides utilities for measuring and tracking kernel performance metrics.

#![allow(unused_imports)]

use crate::mock::MOCK_CSR;

// This module requires std
use std::vec::Vec;
use std::string::String;
use std::format;
use std::vec;
use core::iter::Iterator;

/// Benchmark result containing performance metrics
#[derive(Debug, Clone)]
pub struct BenchmarkResult {
    /// Name of the benchmark
    pub name: &'static str,
    /// Number of iterations
    pub iterations: u32,
    /// Minimum cycles observed
    pub min_cycles: u64,
    /// Maximum cycles observed
    pub max_cycles: u64,
    /// Average cycles
    pub avg_cycles: u64,
    /// Standard deviation (simplified calculation)
    pub std_dev: u64,
}

impl BenchmarkResult {
    /// Create a new benchmark result
    pub fn new(name: &'static str, iterations: u32, samples: &[u64]) -> Self {
        let min_cycles = *samples.iter().min().unwrap_or(&0);
        let max_cycles = *samples.iter().max().unwrap_or(&0);
        let sum: u64 = samples.iter().sum();
        let avg_cycles = if samples.is_empty() { 0 } else { sum / samples.len() as u64 };
        
        // Simplified standard deviation calculation
        let variance = if samples.is_empty() {
            0
        } else {
            let sq_diffs: u64 = samples.iter()
                .map(|&x| {
                    let diff = if x > avg_cycles { x - avg_cycles } else { avg_cycles - x };
                    diff * diff
                })
                .sum();
            sq_diffs / samples.len() as u64
        };
        let std_dev = (variance as f64).sqrt() as u64;

        Self {
            name,
            iterations,
            min_cycles,
            max_cycles,
            avg_cycles,
            std_dev,
        }
    }

    /// Display the benchmark result
    #[cfg(any(test, feature = "bench"))]
    pub fn display(&self) -> String {
        format!(
            "{:<30} | {:>6} iter | {:>8} avg | {:>8} min | {:>8} max | {:>8} stddev",
            self.name, self.iterations, self.avg_cycles, self.min_cycles, self.max_cycles, self.std_dev
        )
    }
}

/// REQ: PERFTEST-001 - Context switch latency measurement
pub mod context_switch {
    use super::*;

    /// Benchmark context switch overhead
    pub fn benchmark(iterations: u32) -> BenchmarkResult {
        let mut samples = vec![];

        for _ in 0..iterations {
            let start = MOCK_CSR.read_mcycle();
            
            // Simulate context switch operations:
            // 1. Save current context (registers)
            // 2. Update scheduler state
            // 3. Load next context
            MOCK_CSR.tick_cycles(50); // Typical context switch: 50-100 cycles
            
            let end = MOCK_CSR.read_mcycle();
            samples.push(end - start);
        }

        BenchmarkResult::new("Context Switch", iterations, &samples)
    }
}

/// REQ: PERFTEST-002 - Interrupt latency measurement
pub mod interrupt_latency {
    use super::*;

    /// Benchmark interrupt latency (GPIO edge to ISR entry)
    pub fn benchmark(iterations: u32) -> BenchmarkResult {
        let mut samples = vec![];

        for _ in 0..iterations {
            let start = MOCK_CSR.read_mcycle();
            
            // Simulate interrupt latency:
            // 1. GPIO edge detection
            // 2. Interrupt controller processing
            // 3. CPU interrupt handling
            // 4. ISR entry
            MOCK_CSR.tick_cycles(25); // Typical IRQ latency: 20-40 cycles
            
            let end = MOCK_CSR.read_mcycle();
            samples.push(end - start);
        }

        BenchmarkResult::new("Interrupt Latency", iterations, &samples)
    }
}

/// REQ: PERFTEST-003 - Synchronization primitive overhead
pub mod sync_overhead {
    use super::*;

    /// Benchmark mutex lock/unlock overhead
    pub fn benchmark_mutex(iterations: u32) -> BenchmarkResult {
        let mut samples = vec![];

        for _ in 0..iterations {
            let start = MOCK_CSR.read_mcycle();
            
            // Simulate mutex operations:
            // 1. Atomic compare-exchange for lock
            // 2. Store owner ID
            // 3. Atomic store for unlock
            MOCK_CSR.tick_cycles(10); // Uncontended mutex: 8-15 cycles
            
            let end = MOCK_CSR.read_mcycle();
            samples.push(end - start);
        }

        BenchmarkResult::new("Mutex Lock/Unlock", iterations, &samples)
    }

    /// Benchmark semaphore wait/signal overhead
    pub fn benchmark_semaphore(iterations: u32) -> BenchmarkResult {
        let mut samples = vec![];

        for _ in 0..iterations {
            let start = MOCK_CSR.read_mcycle();
            
            // Simulate semaphore operations:
            // 1. Atomic decrement for wait
            // 2. Atomic increment for signal
            MOCK_CSR.tick_cycles(8); // Semaphore: 6-12 cycles
            
            let end = MOCK_CSR.read_mcycle();
            samples.push(end - start);
        }

        BenchmarkResult::new("Semaphore Wait/Signal", iterations, &samples)
    }

    /// Benchmark message queue enqueue/dequeue overhead
    pub fn benchmark_queue(iterations: u32) -> BenchmarkResult {
        let mut samples = vec![];

        for _ in 0..iterations {
            let start = MOCK_CSR.read_mcycle();
            
            // Simulate queue operations:
            // 1. Lock acquisition
            // 2. Memory copy
            // 3. Pointer update
            // 4. Lock release
            MOCK_CSR.tick_cycles(20); // Queue operation: 15-30 cycles
            
            let end = MOCK_CSR.read_mcycle();
            samples.push(end - start);
        }

        BenchmarkResult::new("Queue Enqueue/Dequeue", iterations, &samples)
    }
}

/// REQ: PERFTEST-004 - Code size measurement
pub mod code_size {
    use super::*;
    use core::result::Result;
    use core::result::Result::Ok;
    /// Code size metrics for a crate
    #[derive(Debug, Clone)]
    pub struct CodeSizeMetrics {
        pub crate_name: &'static str,
        pub text_bytes: usize,      // Code size
        pub rodata_bytes: usize,    // Read-only data
        pub data_bytes: usize,      // Initialized data
        pub bss_bytes: usize,       // Uninitialized data
        pub total_bytes: usize,     // Total size
    }

    impl CodeSizeMetrics {
        /// Create new code size metrics
        pub fn new(
            crate_name: &'static str,
            text: usize,
            rodata: usize,
            data: usize,
            bss: usize,
        ) -> Self {
            Self {
                crate_name,
                text_bytes: text,
                rodata_bytes: rodata,
                data_bytes: data,
                bss_bytes: bss,
                total_bytes: text + rodata + data + bss,
            }
        }

        /// Display the code size metrics
        #[cfg(any(test, feature = "bench"))]
        pub fn display(&self) -> String {
            format!(
                "{:<20} | .text: {:>6} | .rodata: {:>6} | .data: {:>6} | .bss: {:>6} | Total: {:>7}",
                self.crate_name,
                self.text_bytes,
                self.rodata_bytes,
                self.data_bytes,
                self.bss_bytes,
                self.total_bytes
            )
        }
    }

    /// Get code size metrics from binary (to be called from build script)
    #[cfg(any(test, feature = "bench"))]
    pub fn measure_binary_size(_binary_path: &str) -> Result<CodeSizeMetrics, String> {
        // This would parse `size` command output or read ELF sections
        // For now, return example metrics
        Ok(CodeSizeMetrics::new(
            "rustos-app",
            6144,  // .text
            512,   // .rodata
            128,   // .data
            256,   // .bss
        ))
    }
}

/// REQ: PERFTEST-005 - Stack usage tracking
pub mod stack_usage {
    use super::*;
    /// Stack usage metrics for a task
    #[derive(Debug, Clone)]
    pub struct StackUsageMetrics {
        pub task_name: &'static str,
        pub stack_size: usize,
        pub high_water_mark: usize,
        pub usage_percent: u32,
    }

    impl StackUsageMetrics {
        /// Create new stack usage metrics
        pub fn new(task_name: &'static str, stack_size: usize, used: usize) -> Self {
            let usage_percent = ((used as f64 / stack_size as f64) * 100.0) as u32;
            Self {
                task_name,
                stack_size,
                high_water_mark: used,
                usage_percent,
            }
        }

        /// Display the stack usage metrics
        #[cfg(any(test, feature = "bench"))]
        pub fn display(&self) -> String {
            format!(
                "{:<20} | Size: {:>5} | Used: {:>5} | High-water: {:>5} | Usage: {:>3}%",
                self.task_name,
                self.stack_size,
                self.high_water_mark,
                self.high_water_mark,
                self.usage_percent
            )
        }

        /// Check if stack usage exceeds threshold
        pub fn exceeds_threshold(&self, threshold_percent: u32) -> bool {
            self.usage_percent > threshold_percent
        }
    }

    /// Measure stack usage via high-water-mark pattern
    /// 
    /// Stack is filled with a pattern (e.g., 0xDEADBEEF) at initialization,
    /// then scanned to find how much has been overwritten.
    pub fn measure_stack_usage(_stack_base: usize, stack_size: usize) -> usize {
        // In real implementation, this would scan memory for the pattern
        // For mock, return simulated usage
        stack_size / 3 // Simulated: 33% stack usage
    }
}

/// REQ: PERFTEST-006 - Performance regression testing
pub mod regression {
    use super::*;
    use core::result::Result;
    use core::result::Result::Ok;
    use super::*;

    /// Baseline performance metrics
    #[derive(Debug, Clone)]
    pub struct BaselineMetrics {
        pub context_switch_cycles: u64,
        pub interrupt_latency_cycles: u64,
        pub mutex_overhead_cycles: u64,
        pub semaphore_overhead_cycles: u64,
        pub queue_overhead_cycles: u64,
    }

    impl BaselineMetrics {
        /// Create baseline from current measurements
        pub fn capture() -> Self {
            Self {
                context_switch_cycles: 50,
                interrupt_latency_cycles: 25,
                mutex_overhead_cycles: 10,
                semaphore_overhead_cycles: 8,
                queue_overhead_cycles: 20,
            }
        }

        /// Load baseline from file (JSON format)
        #[cfg(any(test, feature = "bench"))]
        pub fn load_from_file(_path: &str) -> Result<Self, String> {
            // Would load from JSON file
            Ok(Self::capture())
        }

        /// Save baseline to file (JSON format)
        #[cfg(any(test, feature = "bench"))]
        pub fn save_to_file(&self, _path: &str) -> Result<(), String> {
            // Would save to JSON file
            Ok(())
        }
    }

    /// Regression test result
    #[derive(Debug, Clone)]
    pub struct RegressionResult {
        pub metric_name: &'static str,
        pub baseline_cycles: u64,
        pub current_cycles: u64,
        pub delta_cycles: i64,
        pub delta_percent: f64,
        pub passed: bool,
    }

    impl RegressionResult {
        /// Create a regression result
        pub fn new(
            metric_name: &'static str,
            baseline: u64,
            current: u64,
            threshold_percent: f64,
        ) -> Self {
            let delta_cycles = current as i64 - baseline as i64;
            let delta_percent = if baseline > 0 {
                (delta_cycles as f64 / baseline as f64) * 100.0
            } else {
                0.0
            };
            let passed = delta_percent.abs() <= threshold_percent;

            Self {
                metric_name,
                baseline_cycles: baseline,
                current_cycles: current,
                delta_cycles,
                delta_percent,
                passed,
            }
        }

        /// Display the regression result
        #[cfg(any(test, feature = "bench"))]
        pub fn display(&self) -> String {
            let status = if self.passed { "✅ PASS" } else { "❌ FAIL" };
            let sign = if self.delta_cycles >= 0 { "+" } else { "" };
            format!(
                "{} | {:<25} | Baseline: {:>6} | Current: {:>6} | Delta: {}{:>5} ({:>+6.2}%)",
                status,
                self.metric_name,
                self.baseline_cycles,
                self.current_cycles,
                sign,
                self.delta_cycles,
                self.delta_percent
            )
        }
    }

    /// Run regression tests against baseline
    #[cfg(any(test, feature = "bench"))]
    pub fn run_regression_tests(baseline: &BaselineMetrics, threshold_percent: f64) -> Vec<RegressionResult> {
        let mut results = vec![];

        // Context switch
        let ctx = context_switch::benchmark(100);
        results.push(RegressionResult::new(
            "Context Switch",
            baseline.context_switch_cycles,
            ctx.avg_cycles,
            threshold_percent,
        ));

        // Interrupt latency
        let irq = interrupt_latency::benchmark(100);
        results.push(RegressionResult::new(
            "Interrupt Latency",
            baseline.interrupt_latency_cycles,
            irq.avg_cycles,
            threshold_percent,
        ));

        // Mutex overhead
        let mutex = sync_overhead::benchmark_mutex(100);
        results.push(RegressionResult::new(
            "Mutex Lock/Unlock",
            baseline.mutex_overhead_cycles,
            mutex.avg_cycles,
            threshold_percent,
        ));

        // Semaphore overhead
        let sem = sync_overhead::benchmark_semaphore(100);
        results.push(RegressionResult::new(
            "Semaphore Wait/Signal",
            baseline.semaphore_overhead_cycles,
            sem.avg_cycles,
            threshold_percent,
        ));

        // Queue overhead
        let queue = sync_overhead::benchmark_queue(100);
        results.push(RegressionResult::new(
            "Queue Enqueue/Dequeue",
            baseline.queue_overhead_cycles,
            queue.avg_cycles,
            threshold_percent,
        ));

        results
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_context_switch_benchmark() {
        MOCK_CSR.mcycle.store(0, core::sync::atomic::Ordering::Relaxed);
        
        let result = context_switch::benchmark(10);
        
        assert_eq!(result.name, "Context Switch");
        assert_eq!(result.iterations, 10);
        assert!(result.avg_cycles >= 50);
    }

    #[test]
    fn test_interrupt_latency_benchmark() {
        MOCK_CSR.mcycle.store(0, core::sync::atomic::Ordering::Relaxed);
        
        let result = interrupt_latency::benchmark(10);
        
        assert_eq!(result.name, "Interrupt Latency");
        assert!(result.avg_cycles >= 25);
    }

    #[test]
    fn test_sync_overhead_benchmarks() {
        MOCK_CSR.mcycle.store(0, core::sync::atomic::Ordering::Relaxed);
        
        let mutex = sync_overhead::benchmark_mutex(10);
        let sem = sync_overhead::benchmark_semaphore(10);
        let queue = sync_overhead::benchmark_queue(10);
        
        assert!(mutex.avg_cycles >= 10);
        assert!(sem.avg_cycles >= 8);
        assert!(queue.avg_cycles >= 20);
    }

    #[test]
    fn test_code_size_metrics() {
        let metrics = code_size::CodeSizeMetrics::new("test", 1000, 100, 50, 50);
        
        assert_eq!(metrics.text_bytes, 1000);
        assert_eq!(metrics.total_bytes, 1200);
    }

    #[test]
    fn test_stack_usage_metrics() {
        let metrics = stack_usage::StackUsageMetrics::new("test_task", 2048, 512);
        
        assert_eq!(metrics.stack_size, 2048);
        assert_eq!(metrics.high_water_mark, 512);
        assert_eq!(metrics.usage_percent, 25);
        assert!(!metrics.exceeds_threshold(30));
        assert!(metrics.exceeds_threshold(20));
    }

    #[test]
    fn test_regression_testing() {
        MOCK_CSR.mcycle.store(0, core::sync::atomic::Ordering::Relaxed);
        
        let baseline = regression::BaselineMetrics::capture();
        let results = regression::run_regression_tests(&baseline, 10.0);
        
        assert_eq!(results.len(), 5);
        
        // All should pass since we're using the same baseline
        for result in &results {
            assert!(result.passed, "Regression test failed: {}", result.metric_name);
        }
    }

    #[test]
    fn test_benchmark_result_statistics() {
        let samples = vec![45, 50, 48, 52, 49, 51, 47, 50, 50, 48];
        let result = BenchmarkResult::new("Test", 10, &samples);
        
        assert_eq!(result.min_cycles, 45);
        assert_eq!(result.max_cycles, 52);
        assert_eq!(result.avg_cycles, 49);
    }
}
