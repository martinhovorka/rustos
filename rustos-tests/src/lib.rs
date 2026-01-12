//! # RustOS Test Infrastructure
//!
//! REQ: TEST-001 - Kernel algorithms testable on host (x86_64-unknown-linux-gnu)
//! REQ: TEST-002 - Mirror kernel data structures for host-side validation
//!
//! This crate provides comprehensive testing infrastructure for RustOS kernel components.
//! Tests run on the host system without requiring target hardware.
//!
//! ## Test Organization
//!
//! - **Unit Tests**: Test individual kernel modules (scheduler, sync, task, time)
//! - **Integration Tests**: Test component interactions
//! - **Mock Infrastructure**: Mock hardware-specific functionality for host testing
//! - **Test Utilities**: Common test patterns and helpers
//!
//! ## REQ: TEST-001 Clarification
//!
//! Test harness may use `std` for test infrastructure (e.g., std::thread for concurrency
//! testing per TEST-009), but tested kernel code remains `no_std`-compatible and is
//! conditionally compiled.
//!
//! ## REQ: TEST-003
//!
//! Hardware-specific code is isolated behind `#[cfg(target_arch = "riscv32")]` for
//! conditional compilation.

// Allow std only during tests, as per TEST-001 clarification
#![cfg_attr(not(any(test, feature = "bench")), no_std)]

// Test modules - each synchronization primitive gets dedicated test module per TEST-006
pub mod mock;
pub mod utils;

// REQ: PERFTEST-001 to PERFTEST-006 - Performance benchmarking
// Only compile benchmark module when bench feature is enabled (requires std)
#[cfg(feature = "bench")]
pub mod benchmark;

// Only compile test modules when testing
#[cfg(test)]
pub mod scheduler_tests;
#[cfg(test)]
pub mod sync_tests;
#[cfg(test)]
pub mod task_tests;
#[cfg(test)]
pub mod time_tests;

// REQ: TEST-008 - Additional kernel module tests
#[cfg(test)]
pub mod error_tests;
#[cfg(test)]
pub mod critical_tests;
#[cfg(test)]
pub mod power_tests;
#[cfg(test)]
pub mod diagnostics_tests;
#[cfg(test)]
pub mod context_tests;
