//! Kernel Error Handling
//!
//! REQ: ERR-001 - Define formal error codes for all kernel operations
//! REQ: ERR-002 - Error propagation using Result type
//! REQ: ERR-003 - Error recovery mechanisms
//! REQ: ERR-004 - Error logging integration
//! REQ: ERR-010 - Error context preservation
//! REQ: ERR-011 - No panics on recoverable errors
//! REQ: ERR-012 - Error documentation
//! REQ: ERR-013 - Result type consistency
//! REQ: ERR-014 - Error handler registration
//!
//! # Timeout Semantics (REQ: ERR-002)
//!
//! All synchronization primitives follow consistent timeout semantics:
//! - `timeout_ticks = 0`: Non-blocking poll (try once, return immediately)
//! - `timeout_ticks = n`: Block for up to n system ticks
//! - `timeout_ticks = None`: Block indefinitely (wait forever)
//!
//! Example:
//! ```no_run
//! # use rustos_kernel::sync::Semaphore;
//! # let sem = Semaphore::new(1);
//! // Non-blocking poll
//! if let Ok(_guard) = sem.acquire_timeout(0) {
//!     // Resource acquired
//! } else {
//!     // Would block, handle accordingly
//! }
//! ```

#![allow(unused)]

use core::fmt;

/// REQ: ERR-002 - Non-blocking timeout value (poll semantics)
pub const TIMEOUT_POLL: u32 = 0;

/// REQ: ERR-002 - Default blocking timeout (100ms)
pub const TIMEOUT_DEFAULT: u32 = 100;

/// REQ: ERR-001 - Formal error codes for all kernel operations
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u32)]
pub enum KernelError {
    // Task Management Errors (0x1000-0x1FFF)
    /// Task creation failed - no available task slots
    TaskLimitReached = 0x1001,
    /// Invalid task priority
    InvalidPriority = 0x1002,
    /// Invalid task ID
    InvalidTaskId = 0x1003,
    /// Task already terminated
    TaskTerminated = 0x1004,
    /// Task not found
    TaskNotFound = 0x1005,
    /// Insufficient stack space
    InsufficientStack = 0x1006,
    /// Stack overflow detected
    StackOverflow = 0x1007,

    // Scheduler Errors (0x2000-0x2FFF)
    /// Scheduler not initialized
    SchedulerNotInitialized = 0x2001,
    /// Scheduler already running
    SchedulerAlreadyRunning = 0x2002,
    /// No tasks ready to run
    NoTasksReady = 0x2003,
    /// Context switch failed
    ContextSwitchFailed = 0x2004,

    // Synchronization Errors (0x3000-0x3FFF)
    /// Mutex lock failed - would block
    WouldBlock = 0x3001,
    /// Mutex unlock failed - not owner
    NotOwner = 0x3002,
    /// Mutex is poisoned (owning task panicked)
    Poisoned = 0x3003,
    /// Semaphore count overflow
    SemaphoreOverflow = 0x3004,
    /// Message queue is full
    QueueFull = 0x3005,
    /// Message queue is empty
    QueueEmpty = 0x3006,
    /// Deadlock detected
    Deadlock = 0x3007,
    /// Timeout elapsed
    Timeout = 0x3008,

    // Memory Errors (0x4000-0x4FFF)
    /// Out of memory
    OutOfMemory = 0x4001,
    /// Invalid memory alignment
    InvalidAlignment = 0x4002,
    /// Null pointer dereference
    NullPointer = 0x4003,
    /// Memory region out of bounds
    OutOfBounds = 0x4004,
    /// Memory corruption detected
    MemoryCorruption = 0x4005,

    // Hardware/Driver Errors (0x5000-0x5FFF)
    /// Hardware not initialized
    NotInitialized = 0x5001,
    /// Hardware busy
    Busy = 0x5002,
    /// Hardware communication error
    CommunicationError = 0x5003,
    /// Invalid hardware configuration
    InvalidConfiguration = 0x5004,
    /// Hardware timeout
    HardwareTimeout = 0x5005,
    /// DMA error
    DmaError = 0x5006,
    /// Parity error
    ParityError = 0x5007,
    /// Framing error
    FramingError = 0x5008,
    /// Overrun error
    Overrun = 0x5009,
    /// Underrun error
    Underrun = 0x500A,

    // Interrupt Errors (0x6000-0x6FFF)
    /// Invalid interrupt number
    InvalidInterrupt = 0x6001,
    /// Interrupt already enabled
    InterruptAlreadyEnabled = 0x6002,
    /// Interrupt storm detected
    InterruptStorm = 0x6003,
    /// Nested interrupt overflow
    NestedInterruptOverflow = 0x6004,

    // System Errors (0x7000-0x7FFF)
    /// Invalid parameter
    InvalidParameter = 0x7001,
    /// Operation not supported
    NotSupported = 0x7002,
    /// Permission denied
    PermissionDenied = 0x7003,
    /// Resource unavailable
    ResourceUnavailable = 0x7004,
    /// System not ready
    NotReady = 0x7005,

    // Time Errors (0x8000-0x8FFF)
    /// Time overflow (tick counter wrapped)
    TimeOverflow = 0x8001,
    /// Invalid time value
    InvalidTime = 0x8002,
    /// Timer expired
    TimerExpired = 0x8003,

    // Unknown/Other
    /// Unknown error
    Unknown = 0xFFFF,
}

impl KernelError {
    /// REQ: ERR-010 - Get error code as u32
    pub const fn code(&self) -> u32 {
        *self as u32
    }

    /// REQ: ERR-012 - Get human-readable error description
    pub const fn description(&self) -> &'static str {
        match self {
            Self::TaskLimitReached => "Maximum number of tasks reached",
            Self::InvalidPriority => "Invalid task priority value",
            Self::InvalidTaskId => "Invalid task identifier",
            Self::TaskTerminated => "Task has been terminated",
            Self::TaskNotFound => "Task not found",
            Self::InsufficientStack => "Insufficient stack space",
            Self::StackOverflow => "Stack overflow detected",

            Self::SchedulerNotInitialized => "Scheduler not initialized",
            Self::SchedulerAlreadyRunning => "Scheduler is already running",
            Self::NoTasksReady => "No tasks ready to run",
            Self::ContextSwitchFailed => "Context switch operation failed",

            Self::WouldBlock => "Operation would block",
            Self::NotOwner => "Caller is not the mutex owner",
            Self::Poisoned => "Mutex is poisoned",
            Self::SemaphoreOverflow => "Semaphore count overflow",
            Self::QueueFull => "Message queue is full",
            Self::QueueEmpty => "Message queue is empty",
            Self::Deadlock => "Deadlock detected",
            Self::Timeout => "Operation timed out",

            Self::OutOfMemory => "Out of memory",
            Self::InvalidAlignment => "Invalid memory alignment",
            Self::NullPointer => "Null pointer dereference",
            Self::OutOfBounds => "Memory access out of bounds",
            Self::MemoryCorruption => "Memory corruption detected",

            Self::NotInitialized => "Hardware not initialized",
            Self::Busy => "Hardware busy",
            Self::CommunicationError => "Communication error",
            Self::InvalidConfiguration => "Invalid configuration",
            Self::HardwareTimeout => "Hardware timeout",
            Self::DmaError => "DMA error",
            Self::ParityError => "Parity error",
            Self::FramingError => "Framing error",
            Self::Overrun => "Data overrun",
            Self::Underrun => "Data underrun",

            Self::InvalidInterrupt => "Invalid interrupt number",
            Self::InterruptAlreadyEnabled => "Interrupt already enabled",
            Self::InterruptStorm => "Interrupt storm detected",
            Self::NestedInterruptOverflow => "Too many nested interrupts",

            Self::InvalidParameter => "Invalid parameter",
            Self::NotSupported => "Operation not supported",
            Self::PermissionDenied => "Permission denied",
            Self::ResourceUnavailable => "Resource unavailable",
            Self::NotReady => "System not ready",

            Self::TimeOverflow => "Time counter overflow",
            Self::InvalidTime => "Invalid time value",
            Self::TimerExpired => "Timer expired",

            Self::Unknown => "Unknown error",
        }
    }

    /// REQ: ERR-003 - Check if error is recoverable
    pub const fn is_recoverable(&self) -> bool {
        match self {
            // Unrecoverable errors
            Self::StackOverflow
            | Self::MemoryCorruption
            | Self::NullPointer
            | Self::ContextSwitchFailed
            | Self::InterruptStorm => false,

            // Recoverable errors
            _ => true,
        }
    }

    /// REQ: ERR-010 - Check if error requires immediate action
    pub const fn is_critical(&self) -> bool {
        matches!(
            self,
            Self::StackOverflow
                | Self::MemoryCorruption
                | Self::ContextSwitchFailed
                | Self::InterruptStorm
                | Self::Deadlock
        )
    }
}

impl fmt::Display for KernelError {
    /// REQ: ERR-012 - Implement Display for error messages
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "[0x{:04X}] {}", self.code(), self.description())
    }
}

/// REQ: ERR-002, ERR-013 - Standard Result type for kernel operations
pub type Result<T> = core::result::Result<T, KernelError>;

/// REQ: ERR-014 - Error handler callback type
pub type ErrorHandler = fn(error: KernelError, context: &'static str);

/// Global error handler (optional)
static mut ERROR_HANDLER: Option<ErrorHandler> = None;

/// REQ: ERR-014 - Register global error handler
///
/// # Safety
/// Must be called only once during initialization, before scheduler starts
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn register_error_handler(handler: ErrorHandler) {
    ERROR_HANDLER = Some(handler);
}

/// REQ: ERR-004 - Report error to registered handler
pub fn report_error(error: KernelError, context: &'static str) {
    // SAFETY: ERROR_HANDLER is only written during init, read-only after scheduler starts.
    // Safe for concurrent read access.
    if let Some(handler) = unsafe { ERROR_HANDLER } {
        handler(error, context);
    }
    // If no handler registered, error is silently dropped
    // (will be logged if logging is enabled)
}

/// REQ: ERR-003 - Convert panic into error (for recoverable panics)
#[macro_export]
macro_rules! try_or_error {
    ($expr:expr, $err:expr, $ctx:expr) => {
        match $expr {
            Ok(val) => val,
            Err(_) => {
                $crate::error::report_error($err, $ctx);
                return Err($err);
            }
        }
    };
}

/// REQ: ERR-011 - Ensure Result is used instead of panic for recoverable errors
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_error_codes_unique() {
        let errors = [
            KernelError::TaskLimitReached,
            KernelError::InvalidPriority,
            KernelError::WouldBlock,
            KernelError::OutOfMemory,
        ];

        for (i, err1) in errors.iter().enumerate() {
            for err2 in errors.iter().skip(i + 1) {
                assert_ne!(err1.code(), err2.code(), "Error codes must be unique");
            }
        }
    }

    #[test]
    fn test_error_description() {
        let err = KernelError::TaskLimitReached;
        assert!(!err.description().is_empty());
    }

    #[test]
    fn test_recoverable_classification() {
        assert!(KernelError::WouldBlock.is_recoverable());
        assert!(!KernelError::StackOverflow.is_recoverable());
    }

    #[test]
    fn test_critical_classification() {
        assert!(KernelError::StackOverflow.is_critical());
        assert!(!KernelError::WouldBlock.is_critical());
    }
}
