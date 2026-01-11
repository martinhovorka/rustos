//! Logging Infrastructure
//!
//! REQ: LOG-001 - Logging system with severity levels
//! REQ: LOG-002 - Log macros (error!, warn!, info!, debug!, trace!)
//! REQ: LOG-003 - Runtime log level filtering
//! REQ: LOG-004 - Integration with UART console
//! REQ: LOG-007 - Timestamp inclusion in log messages
//! REQ: LOG-008 - Module-level log filtering

#![allow(unused)]

use core::fmt::{self, Write};
use core::sync::atomic::{AtomicU8, Ordering};

/// REQ: LOG-001 - Log severity levels
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
#[repr(u8)]
pub enum LogLevel {
    /// Critical errors that require immediate attention
    Error = 1,
    /// Warning conditions that should be addressed
    Warn = 2,
    /// Informational messages for general operations
    Info = 3,
    /// Debug information for development
    Debug = 4,
    /// Detailed trace information for deep debugging
    Trace = 5,
}

impl LogLevel {
    /// Get string representation of log level
    pub const fn as_str(&self) -> &'static str {
        match self {
            Self::Error => "ERROR",
            Self::Warn => "WARN ",
            Self::Info => "INFO ",
            Self::Debug => "DEBUG",
            Self::Trace => "TRACE",
        }
    }

    /// Get ANSI color code for log level (if supported)
    pub const fn color_code(&self) -> &'static str {
        match self {
            Self::Error => "\x1b[31m", // Red
            Self::Warn => "\x1b[33m",  // Yellow
            Self::Info => "\x1b[32m",  // Green
            Self::Debug => "\x1b[36m", // Cyan
            Self::Trace => "\x1b[90m", // Gray
        }
    }
}

impl fmt::Display for LogLevel {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.as_str())
    }
}

/// REQ: LOG-003 - Global log level filter (atomic for thread-safety)
static LOG_LEVEL: AtomicU8 = AtomicU8::new(LogLevel::Info as u8);

/// REQ: LOG-008 - Module-specific log level configuration
static mut MODULE_FILTERS: [(&str, LogLevel); 16] = [("", LogLevel::Info); 16];
static mut MODULE_FILTER_COUNT: usize = 0;

/// REQ: LOG-003 - Set global log level at runtime
pub fn set_log_level(level: LogLevel) {
    LOG_LEVEL.store(level as u8, Ordering::Relaxed);
}

/// REQ: LOG-003 - Get current global log level
pub fn get_log_level() -> LogLevel {
    let level = LOG_LEVEL.load(Ordering::Relaxed);
    match level {
        1 => LogLevel::Error,
        2 => LogLevel::Warn,
        3 => LogLevel::Info,
        4 => LogLevel::Debug,
        5 => LogLevel::Trace,
        _ => LogLevel::Info,
    }
}

/// REQ: LOG-008 - Set log level for specific module
///
/// # Safety
/// Must be called during initialization before scheduler starts
pub unsafe fn set_module_log_level(module: &'static str, level: LogLevel) {
    if MODULE_FILTER_COUNT < unsafe { core::ptr::addr_of!(MODULE_FILTERS).as_ref().unwrap().len() } {
        MODULE_FILTERS[MODULE_FILTER_COUNT] = (module, level);
        MODULE_FILTER_COUNT += 1;
    }
}

/// REQ: LOG-008 - Check if module should log at given level
fn should_log_module(module: &str, level: LogLevel) -> bool {
    // Safety: MODULE_FILTERS is only written during init, read-only after
    unsafe {
        for i in 0..MODULE_FILTER_COUNT {
            let (filter_module, filter_level) = &MODULE_FILTERS[i];
            if module.starts_with(filter_module) {
                return level <= *filter_level;
            }
        }
    }
    // Fall back to global level
    level <= get_log_level()
}

/// REQ: LOG-004 - Logger output trait
pub trait Logger: Send {
    /// Write a log message
    fn log(&mut self, record: &LogRecord);
    
    /// Flush buffered output
    fn flush(&mut self);
}

/// REQ: LOG-007 - Log record with metadata
pub struct LogRecord<'a> {
    /// Log severity level
    pub level: LogLevel,
    /// Module path
    pub module: &'a str,
    /// File name
    pub file: &'a str,
    /// Line number
    pub line: u32,
    /// Timestamp in ticks (if available)
    pub timestamp: Option<u32>,
    /// Log message
    pub message: fmt::Arguments<'a>,
}

/// Global logger instance (set via set_logger)
static mut LOGGER: Option<&'static mut dyn Logger> = None;

/// REQ: LOG-004 - Set global logger
///
/// # Safety
/// Must be called exactly once during initialization
pub unsafe fn set_logger(logger: &'static mut dyn Logger) {
    LOGGER = Some(logger);
}

/// REQ: LOG-002, LOG-007 - Log a message with full metadata
#[doc(hidden)]
pub fn __log_impl(
    level: LogLevel,
    module: &str,
    file: &str,
    line: u32,
    args: fmt::Arguments,
) {
    // REQ: LOG-003 - Filter by level
    if !should_log_module(module, level) {
        return;
    }

    // REQ: LOG-007 - Get timestamp if available
    let timestamp = crate::time::get_ticks();

    let record = LogRecord {
        level,
        module,
        file,
        line,
        timestamp: Some(timestamp),
        message: args,
    };

    // Safety: LOGGER is only written during init, read-only after
    if let Some(logger) = unsafe { core::ptr::addr_of_mut!(LOGGER).as_mut().and_then(|l| l.as_mut()) } {
        logger.log(&record);
    }
}

/// REQ: LOG-002 - Error level log macro
#[macro_export]
macro_rules! error {
    ($($arg:tt)*) => {
        $crate::log::__log_impl(
            $crate::log::LogLevel::Error,
            module_path!(),
            file!(),
            line!(),
            format_args!($($arg)*),
        )
    };
}

/// REQ: LOG-002 - Warning level log macro
#[macro_export]
macro_rules! warn {
    ($($arg:tt)*) => {
        $crate::log::__log_impl(
            $crate::log::LogLevel::Warn,
            module_path!(),
            file!(),
            line!(),
            format_args!($($arg)*),
        )
    };
}

/// REQ: LOG-002 - Info level log macro
#[macro_export]
macro_rules! info {
    ($($arg:tt)*) => {
        $crate::log::__log_impl(
            $crate::log::LogLevel::Info,
            module_path!(),
            file!(),
            line!(),
            format_args!($($arg)*),
        )
    };
}

/// REQ: LOG-002 - Debug level log macro
#[macro_export]
macro_rules! debug {
    ($($arg:tt)*) => {
        $crate::log::__log_impl(
            $crate::log::LogLevel::Debug,
            module_path!(),
            file!(),
            line!(),
            format_args!($($arg)*),
        )
    };
}

/// REQ: LOG-002 - Trace level log macro
#[macro_export]
macro_rules! trace {
    ($($arg:tt)*) => {
        $crate::log::__log_impl(
            $crate::log::LogLevel::Trace,
            module_path!(),
            file!(),
            line!(),
            format_args!($($arg)*),
        )
    };
}

/// REQ: LOG-004, LOG-007 - Simple console logger implementation
pub struct ConsoleLogger<W: Write> {
    writer: W,
    use_colors: bool,
}

impl<W: Write> ConsoleLogger<W> {
    /// Create a new console logger
    pub fn new(writer: W, use_colors: bool) -> Self {
        Self { writer, use_colors }
    }
}

impl<W: Write + Send> Logger for ConsoleLogger<W> {
    fn log(&mut self, record: &LogRecord) {
        // REQ: LOG-007 - Format with timestamp
        if let Some(timestamp) = record.timestamp {
            let _ = write!(self.writer, "[{:>6}ms] ", timestamp);
        }

        // Color coding if enabled
        if self.use_colors {
            let _ = write!(self.writer, "{}", record.level.color_code());
        }

        // REQ: LOG-007 - Format: [TIME] LEVEL [module:file:line] message
        let _ = write!(
            self.writer,
            "{} [{}:{}:{}] ",
            record.level,
            record.module,
            record.file,
            record.line
        );

        // Reset color
        if self.use_colors {
            let _ = write!(self.writer, "\x1b[0m");
        }

        let _ = self.writer.write_fmt(record.message);
        let _ = self.writer.write_str("\r\n");
    }

    fn flush(&mut self) {
        // For UART, we typically don't buffer, but this allows for future optimization
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_log_level_ordering() {
        assert!(LogLevel::Error < LogLevel::Warn);
        assert!(LogLevel::Warn < LogLevel::Info);
        assert!(LogLevel::Info < LogLevel::Debug);
        assert!(LogLevel::Debug < LogLevel::Trace);
    }

    #[test]
    fn test_log_level_filtering() {
        set_log_level(LogLevel::Warn);
        assert_eq!(get_log_level(), LogLevel::Warn);
    }
}
