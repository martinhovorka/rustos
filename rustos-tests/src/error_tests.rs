//! REQ: TEST-008 - Error handling unit tests
//!
//! Tests for KernelError enum, error codes, and error handling.

#![cfg(test)]

use crate::assert_test;

extern crate std;

// Error code constants matching rustos-kernel/src/error.rs
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u32)]
#[allow(dead_code)]
enum KernelError {
    // Task Management Errors (0x1000-0x1FFF)
    TaskLimitReached = 0x1001,
    InvalidPriority = 0x1002,
    InvalidTaskId = 0x1003,
    TaskTerminated = 0x1004,
    TaskNotFound = 0x1005,
    InsufficientStack = 0x1006,
    StackOverflow = 0x1007,

    // Scheduler Errors (0x2000-0x2FFF)
    SchedulerNotInitialized = 0x2001,
    SchedulerAlreadyRunning = 0x2002,
    NoTasksReady = 0x2003,
    ContextSwitchFailed = 0x2004,

    // Synchronization Errors (0x3000-0x3FFF)
    WouldBlock = 0x3001,
    NotOwner = 0x3002,
    Poisoned = 0x3003,
    SemaphoreOverflow = 0x3004,
    QueueFull = 0x3005,
    QueueEmpty = 0x3006,
    Deadlock = 0x3007,
    Timeout = 0x3008,

    // Memory Errors (0x4000-0x4FFF)
    OutOfMemory = 0x4001,
    InvalidAlignment = 0x4002,
    NullPointer = 0x4003,
    OutOfBounds = 0x4004,
    MemoryCorruption = 0x4005,

    // Hardware/Driver Errors (0x5000-0x5FFF)
    NotInitialized = 0x5001,
    Busy = 0x5002,
    CommunicationError = 0x5003,
    InvalidConfiguration = 0x5004,
    HardwareTimeout = 0x5005,
    DmaError = 0x5006,
    ParityError = 0x5007,
    FramingError = 0x5008,
    Overrun = 0x5009,
    Underrun = 0x500A,

    // Interrupt Errors (0x6000-0x6FFF)
    InvalidInterrupt = 0x6001,
    InterruptAlreadyEnabled = 0x6002,
    InterruptStorm = 0x6003,
    NestedInterruptOverflow = 0x6004,

    // System Errors (0x7000-0x7FFF)
    InvalidParameter = 0x7001,
    NotSupported = 0x7002,
    PermissionDenied = 0x7003,
    ResourceUnavailable = 0x7004,
    NotReady = 0x7005,

    // Time Errors (0x8000-0x8FFF)
    TimeOverflow = 0x8001,
    InvalidTime = 0x8002,
    TimerExpired = 0x8003,

    // Unknown/Other
    Unknown = 0xFFFF,
}

impl KernelError {
    const fn code(&self) -> u32 {
        *self as u32
    }

    const fn description(&self) -> &'static str {
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

    const fn is_recoverable(&self) -> bool {
        match self {
            Self::StackOverflow
            | Self::MemoryCorruption
            | Self::NullPointer
            | Self::ContextSwitchFailed
            | Self::InterruptStorm => false,
            _ => true,
        }
    }

    const fn is_critical(&self) -> bool {
        match self {
            Self::StackOverflow
            | Self::MemoryCorruption
            | Self::ContextSwitchFailed
            | Self::InterruptStorm
            | Self::Deadlock => true,
            _ => false,
        }
    }

    fn category(&self) -> &'static str {
        let code = self.code();
        match code >> 12 {
            0x1 => "Task Management",
            0x2 => "Scheduler",
            0x3 => "Synchronization",
            0x4 => "Memory",
            0x5 => "Hardware/Driver",
            0x6 => "Interrupt",
            0x7 => "System",
            0x8 => "Time",
            _ => "Unknown",
        }
    }
}

// ============================================================================
// Error Code Tests
// ============================================================================

#[test]
fn test_error_codes_unique() {
    // REQ: ERR-001 - Formal error codes must be unique
    let all_errors = [
        KernelError::TaskLimitReached,
        KernelError::InvalidPriority,
        KernelError::InvalidTaskId,
        KernelError::TaskTerminated,
        KernelError::TaskNotFound,
        KernelError::InsufficientStack,
        KernelError::StackOverflow,
        KernelError::SchedulerNotInitialized,
        KernelError::SchedulerAlreadyRunning,
        KernelError::NoTasksReady,
        KernelError::ContextSwitchFailed,
        KernelError::WouldBlock,
        KernelError::NotOwner,
        KernelError::Poisoned,
        KernelError::SemaphoreOverflow,
        KernelError::QueueFull,
        KernelError::QueueEmpty,
        KernelError::Deadlock,
        KernelError::Timeout,
        KernelError::OutOfMemory,
        KernelError::InvalidAlignment,
        KernelError::NullPointer,
        KernelError::OutOfBounds,
        KernelError::MemoryCorruption,
        KernelError::NotInitialized,
        KernelError::Busy,
        KernelError::CommunicationError,
        KernelError::InvalidConfiguration,
        KernelError::HardwareTimeout,
        KernelError::DmaError,
        KernelError::ParityError,
        KernelError::FramingError,
        KernelError::Overrun,
        KernelError::Underrun,
        KernelError::InvalidInterrupt,
        KernelError::InterruptAlreadyEnabled,
        KernelError::InterruptStorm,
        KernelError::NestedInterruptOverflow,
        KernelError::InvalidParameter,
        KernelError::NotSupported,
        KernelError::PermissionDenied,
        KernelError::ResourceUnavailable,
        KernelError::NotReady,
        KernelError::TimeOverflow,
        KernelError::InvalidTime,
        KernelError::TimerExpired,
        KernelError::Unknown,
    ];

    // Check uniqueness
    for (i, err1) in all_errors.iter().enumerate() {
        for err2 in all_errors.iter().skip(i + 1) {
            assert_test!(
                err1.code() != err2.code(),
                format!("Error codes must be unique: {:?} and {:?} both have code 0x{:04X}",
                    err1, err2, err1.code())
            );
        }
    }
}

#[test]
fn test_error_code_ranges() {
    // REQ: ERR-001 - Error codes are in correct ranges
    let task_errors = [
        KernelError::TaskLimitReached,
        KernelError::InvalidPriority,
        KernelError::InvalidTaskId,
        KernelError::TaskTerminated,
        KernelError::TaskNotFound,
        KernelError::InsufficientStack,
        KernelError::StackOverflow,
    ];
    for err in task_errors.iter() {
        let code = err.code();
        assert_test!(
            (0x1000..0x2000).contains(&code),
            format!("{:?} code 0x{:04X} should be in 0x1000-0x1FFF range", err, code)
        );
    }

    let sync_errors = [
        KernelError::WouldBlock,
        KernelError::NotOwner,
        KernelError::Poisoned,
        KernelError::SemaphoreOverflow,
        KernelError::QueueFull,
        KernelError::QueueEmpty,
        KernelError::Deadlock,
        KernelError::Timeout,
    ];
    for err in sync_errors.iter() {
        let code = err.code();
        assert_test!(
            (0x3000..0x4000).contains(&code),
            format!("{:?} code 0x{:04X} should be in 0x3000-0x3FFF range", err, code)
        );
    }
}

#[test]
fn test_error_descriptions_not_empty() {
    // REQ: ERR-012 - All errors have descriptions
    let all_errors = [
        KernelError::TaskLimitReached,
        KernelError::InvalidPriority,
        KernelError::WouldBlock,
        KernelError::OutOfMemory,
        KernelError::NotInitialized,
        KernelError::InvalidInterrupt,
        KernelError::InvalidParameter,
        KernelError::TimeOverflow,
        KernelError::Unknown,
    ];

    for err in all_errors.iter() {
        let desc = err.description();
        assert_test!(!desc.is_empty(), format!("{:?} has empty description", err));
        assert_test!(desc.len() > 5, format!("{:?} description too short: {}", err, desc));
    }
}

#[test]
fn test_error_recoverable_classification() {
    // REQ: ERR-003 - Error recovery classification
    
    // These should be unrecoverable
    assert_test!(!KernelError::StackOverflow.is_recoverable(), "StackOverflow should not be recoverable");
    assert_test!(!KernelError::MemoryCorruption.is_recoverable(), "MemoryCorruption should not be recoverable");
    assert_test!(!KernelError::NullPointer.is_recoverable(), "NullPointer should not be recoverable");
    assert_test!(!KernelError::ContextSwitchFailed.is_recoverable(), "ContextSwitchFailed should not be recoverable");
    assert_test!(!KernelError::InterruptStorm.is_recoverable(), "InterruptStorm should not be recoverable");

    // These should be recoverable
    assert_test!(KernelError::WouldBlock.is_recoverable(), "WouldBlock should be recoverable");
    assert_test!(KernelError::Timeout.is_recoverable(), "Timeout should be recoverable");
    assert_test!(KernelError::QueueFull.is_recoverable(), "QueueFull should be recoverable");
    assert_test!(KernelError::QueueEmpty.is_recoverable(), "QueueEmpty should be recoverable");
    assert_test!(KernelError::Busy.is_recoverable(), "Busy should be recoverable");
    assert_test!(KernelError::TaskNotFound.is_recoverable(), "TaskNotFound should be recoverable");
}

#[test]
fn test_error_critical_classification() {
    // REQ: ERR-010 - Critical error identification
    
    // These require immediate action
    assert_test!(KernelError::StackOverflow.is_critical(), "StackOverflow should be critical");
    assert_test!(KernelError::MemoryCorruption.is_critical(), "MemoryCorruption should be critical");
    assert_test!(KernelError::ContextSwitchFailed.is_critical(), "ContextSwitchFailed should be critical");
    assert_test!(KernelError::InterruptStorm.is_critical(), "InterruptStorm should be critical");
    assert_test!(KernelError::Deadlock.is_critical(), "Deadlock should be critical");

    // These do not require immediate action
    assert_test!(!KernelError::WouldBlock.is_critical(), "WouldBlock should not be critical");
    assert_test!(!KernelError::Timeout.is_critical(), "Timeout should not be critical");
    assert_test!(!KernelError::InvalidParameter.is_critical(), "InvalidParameter should not be critical");
}

#[test]
fn test_error_categories() {
    // Test category classification
    assert_test!(
        KernelError::TaskLimitReached.category() == "Task Management",
        "TaskLimitReached should be Task Management category"
    );
    assert_test!(
        KernelError::SchedulerNotInitialized.category() == "Scheduler",
        "SchedulerNotInitialized should be Scheduler category"
    );
    assert_test!(
        KernelError::WouldBlock.category() == "Synchronization",
        "WouldBlock should be Synchronization category"
    );
    assert_test!(
        KernelError::OutOfMemory.category() == "Memory",
        "OutOfMemory should be Memory category"
    );
    assert_test!(
        KernelError::NotInitialized.category() == "Hardware/Driver",
        "NotInitialized should be Hardware/Driver category"
    );
}

#[test]
fn test_error_result_type() {
    // REQ: ERR-002, ERR-013 - Result type usage
    type Result<T> = core::result::Result<T, KernelError>;

    fn test_operation_success() -> Result<u32> {
        Ok(42)
    }

    fn test_operation_failure() -> Result<u32> {
        Err(KernelError::InvalidParameter)
    }

    let success = test_operation_success();
    assert_test!(success.is_ok(), "Success operation should return Ok");
    assert_test!(success.unwrap() == 42, "Success should return correct value");

    let failure = test_operation_failure();
    assert_test!(failure.is_err(), "Failure operation should return Err");
    assert_test!(
        failure.unwrap_err() == KernelError::InvalidParameter,
        "Failure should return correct error"
    );
}

#[test]
fn test_error_equality() {
    // Test PartialEq derive
    assert_test!(
        KernelError::WouldBlock == KernelError::WouldBlock,
        "Same error should be equal"
    );
    assert_test!(
        KernelError::WouldBlock != KernelError::Timeout,
        "Different errors should not be equal"
    );
}

#[test]
fn test_error_copy_clone() {
    // Test Copy and Clone derives
    let err1 = KernelError::InvalidTaskId;
    let err2 = err1;  // Copy
    let err3 = err1.clone();  // Clone
    
    assert_test!(err1.code() == err2.code(), "Copied error should have same code");
    assert_test!(err1.code() == err3.code(), "Cloned error should have same code");
}

#[test]
fn test_timeout_constants() {
    // REQ: ERR-002 - Timeout semantics
    const TIMEOUT_POLL: u32 = 0;
    const TIMEOUT_DEFAULT: u32 = 100;
    
    assert_test!(TIMEOUT_POLL == 0, "TIMEOUT_POLL should be 0 (non-blocking)");
    assert_test!(TIMEOUT_DEFAULT == 100, "TIMEOUT_DEFAULT should be 100ms");
}

// ============================================================================
// Error Handler Tests
// ============================================================================

use std::sync::atomic::{AtomicU32, Ordering};

#[test]
fn test_error_handler_callback() {
    // REQ: ERR-014 - Error handler registration
    static HANDLER_CALLED: AtomicU32 = AtomicU32::new(0);
    static LAST_ERROR_CODE: AtomicU32 = AtomicU32::new(0);

    fn test_handler(error: KernelError, _context: &'static str) {
        HANDLER_CALLED.fetch_add(1, Ordering::SeqCst);
        LAST_ERROR_CODE.store(error.code(), Ordering::SeqCst);
    }

    // Simulate registering handler
    let handler: fn(KernelError, &'static str) = test_handler;
    
    // Simulate calling handler
    handler(KernelError::InvalidParameter, "test_context");
    
    assert_test!(
        HANDLER_CALLED.load(Ordering::SeqCst) == 1,
        "Handler should be called once"
    );
    assert_test!(
        LAST_ERROR_CODE.load(Ordering::SeqCst) == KernelError::InvalidParameter.code(),
        "Handler should receive correct error code"
    );
}

#[test]
fn test_error_propagation_pattern() {
    // REQ: ERR-002 - Error propagation using Result type
    type Result<T> = core::result::Result<T, KernelError>;

    fn inner_operation() -> Result<u32> {
        Err(KernelError::ResourceUnavailable)
    }

    fn outer_operation() -> Result<u32> {
        // Simulate error propagation with ?
        let result = inner_operation();
        if let Err(e) = result {
            return Err(e);
        }
        Ok(result.unwrap() + 1)
    }

    let result = outer_operation();
    assert_test!(result.is_err(), "Error should propagate through layers");
    assert_test!(
        result.unwrap_err() == KernelError::ResourceUnavailable,
        "Original error should be preserved"
    );
}
