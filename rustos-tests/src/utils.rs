//! REQ: TEST-010 - Test utilities with descriptive assertions
//!
//! Common test patterns and helper functions for RustOS tests.

use core::sync::atomic::{AtomicU32, Ordering};

/// Test assertion with descriptive message
///
/// REQ: TEST-010 - Test assertions shall use descriptive messages for failure diagnosis
#[macro_export]
macro_rules! assert_test {
    ($cond:expr, $msg:expr) => {
        assert!($cond, "Test failed: {}", $msg);
    };
    ($cond:expr, $fmt:expr, $($arg:tt)*) => {
        assert!($cond, "Test failed: {}", format_args!($fmt, $($arg)*));
    };
}

/// Test assertion for equality with descriptive message
#[macro_export]
macro_rules! assert_eq_test {
    ($left:expr, $right:expr, $msg:expr) => {
        assert_eq!(
            $left, $right,
            "Test failed: {} - Expected: {:?}, Got: {:?}",
            $msg, $right, $left
        );
    };
}

/// Test assertion for inequality with descriptive message
#[macro_export]
macro_rules! assert_ne_test {
    ($left:expr, $right:expr, $msg:expr) => {
        assert_ne!(
            $left, $right,
            "Test failed: {} - Values should not be equal: {:?}",
            $msg, $left
        );
    };
}

/// Counter for unique test IDs
static TEST_ID_COUNTER: AtomicU32 = AtomicU32::new(0);

/// Generate a unique test ID
pub fn gen_test_id() -> u32 {
    TEST_ID_COUNTER.fetch_add(1, Ordering::Relaxed)
}

/// Reset test ID counter (for test isolation)
pub fn reset_test_ids() {
    TEST_ID_COUNTER.store(0, Ordering::Relaxed);
}

/// REQ: TEST-008 - Test edge cases (boundary values, overflow, underflow)
pub mod boundary {
    /// Test minimum value
    pub const MIN_U8: u8 = 0;
    /// Test maximum value for u8
    pub const MAX_U8: u8 = 255;
    /// Test minimum value for u16
    pub const MIN_U16: u16 = 0;
    /// Test maximum value for u16
    pub const MAX_U16: u16 = 65535;
    /// Test minimum value for u32
    pub const MIN_U32: u32 = 0;
    /// Test maximum value for u32
    pub const MAX_U32: u32 = u32::MAX;
    /// Test minimum value for usize
    pub const MIN_USIZE: usize = 0;
    /// Test maximum value for usize (platform-dependent)
    pub const MAX_USIZE: usize = usize::MAX;

    /// Test value near minimum
    pub const NEAR_MIN: u32 = 1;
    /// Test value near maximum
    pub const NEAR_MAX: u32 = u32::MAX - 1;

    /// Test overflow behavior
    pub fn test_overflow_u32(value: u32, delta: u32) -> (u32, bool) {
        value.overflowing_add(delta)
    }

    /// Test underflow behavior
    pub fn test_underflow_u32(value: u32, delta: u32) -> (u32, bool) {
        value.overflowing_sub(delta)
    }
}

/// REQ: TEST-009 - Concurrent access patterns (using std::thread on host)
#[cfg(test)]
pub mod concurrent {
    use std::sync::Arc;
    use std::thread;
    use std::time::Duration;

    /// Run a test function concurrently in multiple threads
    pub fn run_concurrent<F>(num_threads: usize, f: F)
    where
        F: Fn(usize) + Send + Sync + 'static,
    {
        let f = Arc::new(f);
        let mut handles = vec![];

        for i in 0..num_threads {
            let f = Arc::clone(&f);
            let handle = thread::spawn(move || {
                f(i);
            });
            handles.push(handle);
        }

        for handle in handles {
            handle.join().expect("Thread panicked");
        }
    }

    /// Run a test function concurrently with a delay between thread starts
    pub fn run_concurrent_staggered<F>(num_threads: usize, delay_ms: u64, f: F)
    where
        F: Fn(usize) + Send + Sync + 'static,
    {
        let f = Arc::new(f);
        let mut handles = vec![];

        for i in 0..num_threads {
            let f = Arc::clone(&f);
            thread::sleep(Duration::from_millis(delay_ms));
            let handle = thread::spawn(move || {
                f(i);
            });
            handles.push(handle);
        }

        for handle in handles {
            handle.join().expect("Thread panicked");
        }
    }
}

/// Performance measurement utilities
pub mod perf {
    use crate::mock::MOCK_CSR;
    use core::ops::{Fn, FnOnce};

    /// Measure cycles for a code block
    ///
    /// REQ: PERFTEST-001 - Measure using cycle counter (CSR mcycle)
    pub fn measure_cycles<F>(f: F) -> u64
    where
        F: FnOnce(),
    {
        let start = MOCK_CSR.read_mcycle();
        f();
        let end = MOCK_CSR.read_mcycle();
        end - start
    }

    /// Benchmark a function multiple times and return average cycles
    pub fn benchmark<F>(iterations: u32, f: F) -> u64
    where
        F: Fn(),
    {
        let mut total_cycles = 0u64;
        for _ in 0..iterations {
            total_cycles += measure_cycles(&f);
        }
        total_cycles / iterations as u64
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_unique_ids() {
        reset_test_ids();
        assert_eq!(gen_test_id(), 0);
        assert_eq!(gen_test_id(), 1);
        assert_eq!(gen_test_id(), 2);
    }

    #[test]
    fn test_boundary_values() {
        use boundary::*;

        assert_eq!(MIN_U8, 0);
        assert_eq!(MAX_U8, 255);
        assert_eq!(MIN_U32, 0);
        assert_eq!(MAX_U32, 4294967295);
    }

    #[test]
    fn test_overflow() {
        use boundary::*;

        let (result, overflow) = test_overflow_u32(MAX_U32, 1);
        assert_eq!(result, 0);
        assert!(overflow);

        let (result, overflow) = test_overflow_u32(100, 50);
        assert_eq!(result, 150);
        assert!(!overflow);
    }

    #[test]
    fn test_underflow() {
        use boundary::*;

        let (result, underflow) = test_underflow_u32(0, 1);
        assert_eq!(result, MAX_U32);
        assert!(underflow);

        let (result, underflow) = test_underflow_u32(100, 50);
        assert_eq!(result, 50);
        assert!(!underflow);
    }

    #[test]
    fn test_concurrent_execution() {
        use concurrent::*;
        use std::sync::atomic::{AtomicU32, Ordering};
        use std::sync::Arc;

        let counter = Arc::new(AtomicU32::new(0));
        let counter_clone = Arc::clone(&counter);

        run_concurrent(10, move |_| {
            counter_clone.fetch_add(1, Ordering::Relaxed);
        });

        assert_eq!(counter.load(Ordering::Relaxed), 10);
    }

    #[test]
    fn test_cycle_measurement() {
        use perf::*;

        // Simulate some cycles
        let cycles = measure_cycles(|| {
            crate::mock::MOCK_CSR.tick_cycles(100);
        });

        assert!(cycles >= 100);
    }

    #[test]
    fn test_descriptive_assertions() {
        assert_test!(true, "This should pass");
        assert_eq_test!(1, 1, "Values should be equal");
        assert_ne_test!(1, 2, "Values should be different");
    }
}
