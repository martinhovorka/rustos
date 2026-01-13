//! Kernel Configuration
//!
//! REQ: CFG-001 - Compile-time configuration via Cargo features
//! REQ: CFG-002 - Runtime configuration API
//! REQ: CFG-003 - Configuration validation
//! REQ: CFG-004 - System tick rate configuration
//! REQ: CFG-005 - Maximum task count configuration
//! REQ: CFG-006 - Stack size configuration
//! REQ: CFG-007 - Queue size configuration
//! REQ: CFG-008 - Timeout configuration
//! REQ: CFG-009 - Debug feature configuration
//! REQ: CFG-012 - Configuration documentation

#![allow(unused)]

/// REQ: CFG-004 - System tick rate in Hz
/// Default: 1000 Hz (1 ms tick period)
pub const TICK_RATE_HZ: u32 = cfg_or!(tick_rate, 1000);

/// REQ: CFG-005 - Maximum number of tasks
/// Default: 16 tasks
pub const MAX_TASKS: usize = cfg_or!(max_tasks, 16);

/// REQ: CFG-006 - Default task stack size in bytes
/// Default: 2048 bytes (2 KB)
pub const DEFAULT_STACK_SIZE: usize = cfg_or!(default_stack_size, 2048);

/// REQ: CFG-006 - Minimum task stack size in bytes
/// Absolute minimum to prevent stack overflow
pub const MIN_STACK_SIZE: usize = 512;

/// REQ: CFG-006 - Maximum task stack size in bytes
/// Prevents excessive memory usage
pub const MAX_STACK_SIZE: usize = 16384; // 16 KB

/// REQ: CFG-007 - Default message queue capacity
pub const DEFAULT_QUEUE_SIZE: usize = cfg_or!(default_queue_size, 16);

/// REQ: CFG-007 - Maximum message queue capacity
pub const MAX_QUEUE_SIZE: usize = 256;

/// REQ: CFG-008 - Default timeout in milliseconds
pub const DEFAULT_TIMEOUT_MS: u32 = 1000;

/// REQ: CFG-008 - Maximum timeout in milliseconds
pub const MAX_TIMEOUT_MS: u32 = 0xFFFF_FFFF;

/// REQ: CFG-001 - Enable stack overflow detection
#[cfg(feature = "stack-check")]
pub const STACK_CHECK_ENABLED: bool = true;
#[cfg(not(feature = "stack-check"))]
/// REQ: CFG-001 - Stack checking disabled
pub const STACK_CHECK_ENABLED: bool = false;

/// REQ: CFG-009 - Enable debug assertions
#[cfg(feature = "debug-assertions")]
pub const DEBUG_ASSERTIONS: bool = true;
#[cfg(not(feature = "debug-assertions"))]
/// Enable debug assertions in kernel code
pub const DEBUG_ASSERTIONS: bool = false;

/// REQ: CFG-009 - Enable performance counters
#[cfg(feature = "perf-counters")]
pub const PERF_COUNTERS_ENABLED: bool = true;
#[cfg(not(feature = "perf-counters"))]
/// REQ: CFG-001 - Performance counters disabled
pub const PERF_COUNTERS_ENABLED: bool = false;

/// REQ: CFG-001 - Enable tickless idle mode
#[cfg(feature = "tickless")]
/// **Future Feature**: When enabled, the scheduler will skip timer ticks when no
/// tasks are ready to run, reducing power consumption. Not implemented in v1.0.
pub const TICKLESS_ENABLED: bool = true;
#[cfg(not(feature = "tickless"))]
/// Enable tickless idle mode
pub const TICKLESS_ENABLED: bool = false;

/// REQ: CFG-001 - Enable priority inheritance
#[cfg(feature = "priority-inheritance")]
/// When enabled, mutexes use a priority inheritance protocol to reduce priority inversion.
/// Note: Current mutex locking is spin-based; full blocking/unblocking is planned.
pub const PRIORITY_INHERITANCE: bool = true;
#[cfg(not(feature = "priority-inheritance"))]
/// Enable priority inheritance for mutexes
pub const PRIORITY_INHERITANCE: bool = false;

/// REQ: CFG-009 - Enable runtime diagnostics
#[cfg(feature = "diagnostics")]
pub const DIAGNOSTICS_ENABLED: bool = true;
#[cfg(not(feature = "diagnostics"))]
/// Enable diagnostic counters and metrics
pub const DIAGNOSTICS_ENABLED: bool = false;

/// REQ: CFG-002 - Runtime configuration structure
#[derive(Debug, Clone, Copy)]
pub struct KernelConfig {
    /// System tick rate in Hz
    pub tick_rate: u32,
    /// Maximum number of tasks
    pub max_tasks: usize,
    /// Default stack size
    pub default_stack_size: usize,
    /// Enable stack checking
    pub stack_check: bool,
    /// Enable performance counters
    pub perf_counters: bool,
    /// Enable diagnostics
    pub diagnostics: bool,
}

impl Default for KernelConfig {
    fn default() -> Self {
        Self {
            tick_rate: TICK_RATE_HZ,
            max_tasks: MAX_TASKS,
            default_stack_size: DEFAULT_STACK_SIZE,
            stack_check: STACK_CHECK_ENABLED,
            perf_counters: PERF_COUNTERS_ENABLED,
            diagnostics: DIAGNOSTICS_ENABLED,
        }
    }
}

impl KernelConfig {
    /// REQ: CFG-003 - Validate configuration
    pub const fn validate(&self) -> Result<(), &'static str> {
        if self.tick_rate == 0 {
            return Err("Tick rate must be non-zero");
        }
        if self.tick_rate > 10000 {
            return Err("Tick rate too high (max 10000 Hz)");
        }
        if self.max_tasks == 0 {
            return Err("Must have at least one task");
        }
        if self.max_tasks > 256 {
            return Err("Too many tasks (max 256)");
        }
        if self.default_stack_size < MIN_STACK_SIZE {
            return Err("Stack size too small");
        }
        if self.default_stack_size > MAX_STACK_SIZE {
            return Err("Stack size too large");
        }
        if self.default_stack_size % 16 != 0 {
            return Err("Stack size must be 16-byte aligned");
        }
        Ok(())
    }
}

/// REQ: CFG-002 - Get current kernel configuration
static mut KERNEL_CONFIG: KernelConfig = KernelConfig {
    tick_rate: TICK_RATE_HZ,
    max_tasks: MAX_TASKS,
    default_stack_size: DEFAULT_STACK_SIZE,
    stack_check: STACK_CHECK_ENABLED,
    perf_counters: PERF_COUNTERS_ENABLED,
    diagnostics: DIAGNOSTICS_ENABLED,
};

/// REQ: CFG-002 - Get current kernel configuration
pub fn get_config() -> KernelConfig {
    // SAFETY: KERNEL_CONFIG is only written during init via set_config(), read-only after.
    // Safe for concurrent read access.
    unsafe { KERNEL_CONFIG }
}

/// REQ: CFG-002 - Set kernel configuration
///
/// # Safety
/// Must be called during initialization before scheduler starts
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn set_config(config: KernelConfig) -> Result<(), &'static str> {
    config.validate()?;
    KERNEL_CONFIG = config;
    Ok(())
}

/// Helper macro to get config value with default
macro_rules! cfg_or {
    ($name:ident, $default:expr) => {
        $default
    };
}

// Re-export for use in other modules
pub(crate) use cfg_or;

/// REQ: CFG-012 - Configuration documentation and limits
pub mod limits {
    use super::*;

    /// Minimum supported tick rate
    pub const MIN_TICK_RATE: u32 = 10; // 10 Hz

    /// Maximum supported tick rate
    pub const MAX_TICK_RATE: u32 = 10000; // 10 kHz

    /// Minimum tasks
    pub const MIN_TASKS: usize = 1;

    /// Maximum tasks
    pub const MAX_TASKS_LIMIT: usize = 256;

    /// Minimum stack size
    pub const MIN_STACK: usize = MIN_STACK_SIZE;

    /// Maximum stack size
    pub const MAX_STACK: usize = MAX_STACK_SIZE;

    /// Stack alignment requirement
    pub const STACK_ALIGNMENT: usize = 16;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_default_config_valid() {
        let config = KernelConfig::default();
        assert!(config.validate().is_ok());
    }

    #[test]
    fn test_invalid_tick_rate() {
        let mut config = KernelConfig::default();
        config.tick_rate = 0;
        assert!(config.validate().is_err());
    }

    #[test]
    fn test_invalid_stack_size() {
        let mut config = KernelConfig::default();
        config.default_stack_size = 100; // Too small
        assert!(config.validate().is_err());
    }

    #[test]
    fn test_stack_alignment() {
        let mut config = KernelConfig::default();
        config.default_stack_size = 2001; // Not 16-byte aligned
        assert!(config.validate().is_err());
    }
}
