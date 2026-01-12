//! API Stability Markers
//!
//! REQ: API-013 - API stability attributes
//! REQ: API-014 - Deprecation markers
//! REQ: API-015 - Unstable API gates
//!
//! # Stability Policy
//!
//! RustOS follows semantic versioning (semver). APIs are categorized as:
//!
//! - **Stable**: Public APIs that follow semver guarantees
//! - **Unstable**: Feature-gated experimental APIs
//! - **Deprecated**: Marked for removal in future versions
//!
//! ## Current Version: 0.1.0 (Pre-1.0)
//!
//! As a pre-1.0 crate, breaking changes may occur between minor versions.
//! After 1.0 release, the following guarantees will apply:
//!
//! - Major version bumps (1.x -> 2.x): Breaking changes allowed
//! - Minor version bumps (1.0 -> 1.1): New features, no breaking changes
//! - Patch version bumps (1.0.0 -> 1.0.1): Bug fixes only
//!
//! ## Stable APIs
//!
//! The following modules contain stable public APIs:
//!
//! - `task`: Task management (Task, TaskId, TaskPriority, TaskState)
//! - `scheduler`: Scheduler control (Scheduler::get(), enable, disable, start)
//! - `sync`: Synchronization primitives (Mutex, Semaphore, MessageQueue, EventFlags)
//! - `time`: Time management (get_ticks, delay_ms, Timer)
//! - `error`: Error types (KernelError, Result)
//!
//! ## Unstable APIs (Feature-Gated)
//!
//! The following features provide unstable/experimental functionality:
//!
//! - `statistics`: Performance counters and context switch tracking
//! - `diagnostics`: Runtime diagnostic query APIs
//! - `timers`: Software timer callbacks
//! - `tickless`: Future tickless idle mode
//! - `priority-inheritance`: Future priority inheritance protocol
//!
//! ## Deprecated APIs
//!
//! Currently no APIs are deprecated. When deprecation occurs, migration
//! guidance will be provided in the documentation.
//!
//! ## Safety Documentation
//!
//! REQ: API-016 - All unsafe functions document their safety requirements.
//! See individual function documentation for safety contracts.

/// Stability level for public APIs (documentation only)
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Stability {
    /// Stable API following semver guarantees (post-1.0)
    Stable,
    /// Unstable/experimental API (may change)
    Unstable,
    /// Deprecated API (will be removed)
    Deprecated,
}

/// Version when API was stabilized
pub const STABLE_SINCE: &str = "0.1.0";

/// Current RustOS version
pub const VERSION: &str = env!("CARGO_PKG_VERSION");
