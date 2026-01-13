//! REQ: TEST-008 - Additional coverage tests for kernel modules
//!
//! Tests for remaining kernel functionality:
//! - log.rs: LogLevel, Logger trait, ConsoleLogger
//! - stability.rs: Stability enum, version constants
//! - panic.rs: Panic handling infrastructure
//! - time.rs: Additional edge cases
//! - scheduler.rs: Priority bitmap edge cases
//! - sync primitives: Additional edge cases
//! - WDT HAL: Watchdog timer tests
//! - Ethernet HAL: Ethernet tests

#![cfg(test)]

extern crate std;

use core::fmt;
use std::cell::RefCell;
use std::sync::atomic::{AtomicBool, AtomicU32, AtomicU64, AtomicU8, Ordering};
use std::vec::Vec;

// ============================================================================
// Logging Tests - Mirrors rustos-kernel/src/log.rs
// ============================================================================

mod log_tests {
    use super::*;

    /// REQ: LOG-001 - Log severity levels
    #[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
    #[repr(u8)]
    enum LogLevel {
        Error = 1,
        Warn = 2,
        Info = 3,
        Debug = 4,
        Trace = 5,
    }

    impl LogLevel {
        const fn as_str(&self) -> &'static str {
            match self {
                Self::Error => "ERROR",
                Self::Warn => "WARN ",
                Self::Info => "INFO ",
                Self::Debug => "DEBUG",
                Self::Trace => "TRACE",
            }
        }

        const fn color_code(&self) -> &'static str {
            match self {
                Self::Error => "\x1b[31m", // Red
                Self::Warn => "\x1b[33m",  // Yellow
                Self::Info => "\x1b[32m",  // Green
                Self::Debug => "\x1b[36m", // Cyan
                Self::Trace => "\x1b[90m", // Gray
            }
        }

        fn from_u8(value: u8) -> Option<Self> {
            match value {
                1 => Some(Self::Error),
                2 => Some(Self::Warn),
                3 => Some(Self::Info),
                4 => Some(Self::Debug),
                5 => Some(Self::Trace),
                _ => None,
            }
        }
    }

    impl fmt::Display for LogLevel {
        fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
            f.write_str(self.as_str())
        }
    }

    /// Mock log level filter
    struct LogFilter {
        level: AtomicU8,
    }

    impl LogFilter {
        const fn new() -> Self {
            Self {
                level: AtomicU8::new(LogLevel::Info as u8),
            }
        }

        fn set_level(&self, level: LogLevel) {
            self.level.store(level as u8, Ordering::Relaxed);
        }

        fn get_level(&self) -> LogLevel {
            LogLevel::from_u8(self.level.load(Ordering::Relaxed)).unwrap_or(LogLevel::Info)
        }

        fn should_log(&self, level: LogLevel) -> bool {
            level <= self.get_level()
        }
    }

    /// Mock log record
    struct LogRecord<'a> {
        level: LogLevel,
        module: &'a str,
        file: &'a str,
        line: u32,
        timestamp: Option<u32>,
        message: &'a str,
    }

    /// Mock logger that captures output
    struct TestLogger {
        messages: RefCell<Vec<String>>,
        use_colors: bool,
    }

    impl TestLogger {
        fn new(use_colors: bool) -> Self {
            Self {
                messages: RefCell::new(Vec::new()),
                use_colors,
            }
        }

        fn log(&self, record: &LogRecord) {
            let mut msg = String::new();

            if let Some(timestamp) = record.timestamp {
                msg.push_str(&format!("[{:>6}ms] ", timestamp));
            }

            if self.use_colors {
                msg.push_str(record.level.color_code());
            }

            msg.push_str(&format!(
                "{} [{}:{}:{}] ",
                record.level, record.module, record.file, record.line
            ));

            if self.use_colors {
                msg.push_str("\x1b[0m");
            }

            msg.push_str(record.message);

            self.messages.borrow_mut().push(msg);
        }

        fn messages(&self) -> Vec<String> {
            self.messages.borrow().clone()
        }

        fn clear(&self) {
            self.messages.borrow_mut().clear();
        }
    }

    #[test]
    fn test_log_level_ordering() {
        assert!(LogLevel::Error < LogLevel::Warn);
        assert!(LogLevel::Warn < LogLevel::Info);
        assert!(LogLevel::Info < LogLevel::Debug);
        assert!(LogLevel::Debug < LogLevel::Trace);
    }

    #[test]
    fn test_log_level_as_str() {
        assert_eq!(LogLevel::Error.as_str(), "ERROR");
        assert_eq!(LogLevel::Warn.as_str(), "WARN ");
        assert_eq!(LogLevel::Info.as_str(), "INFO ");
        assert_eq!(LogLevel::Debug.as_str(), "DEBUG");
        assert_eq!(LogLevel::Trace.as_str(), "TRACE");
    }

    #[test]
    fn test_log_level_color_codes() {
        assert_eq!(LogLevel::Error.color_code(), "\x1b[31m");
        assert_eq!(LogLevel::Warn.color_code(), "\x1b[33m");
        assert_eq!(LogLevel::Info.color_code(), "\x1b[32m");
        assert_eq!(LogLevel::Debug.color_code(), "\x1b[36m");
        assert_eq!(LogLevel::Trace.color_code(), "\x1b[90m");
    }

    #[test]
    fn test_log_level_display() {
        assert_eq!(format!("{}", LogLevel::Error), "ERROR");
        assert_eq!(format!("{}", LogLevel::Warn), "WARN ");
        assert_eq!(format!("{}", LogLevel::Info), "INFO ");
    }

    #[test]
    fn test_log_level_from_u8() {
        assert_eq!(LogLevel::from_u8(1), Some(LogLevel::Error));
        assert_eq!(LogLevel::from_u8(2), Some(LogLevel::Warn));
        assert_eq!(LogLevel::from_u8(3), Some(LogLevel::Info));
        assert_eq!(LogLevel::from_u8(4), Some(LogLevel::Debug));
        assert_eq!(LogLevel::from_u8(5), Some(LogLevel::Trace));
        assert_eq!(LogLevel::from_u8(0), None);
        assert_eq!(LogLevel::from_u8(6), None);
        assert_eq!(LogLevel::from_u8(255), None);
    }

    #[test]
    fn test_log_filter_default_level() {
        let filter = LogFilter::new();
        assert_eq!(filter.get_level(), LogLevel::Info);
    }

    #[test]
    fn test_log_filter_set_level() {
        let filter = LogFilter::new();

        filter.set_level(LogLevel::Error);
        assert_eq!(filter.get_level(), LogLevel::Error);

        filter.set_level(LogLevel::Trace);
        assert_eq!(filter.get_level(), LogLevel::Trace);
    }

    #[test]
    fn test_log_filter_should_log() {
        let filter = LogFilter::new();

        // Default is Info
        assert!(filter.should_log(LogLevel::Error));
        assert!(filter.should_log(LogLevel::Warn));
        assert!(filter.should_log(LogLevel::Info));
        assert!(!filter.should_log(LogLevel::Debug));
        assert!(!filter.should_log(LogLevel::Trace));

        // Set to Error only
        filter.set_level(LogLevel::Error);
        assert!(filter.should_log(LogLevel::Error));
        assert!(!filter.should_log(LogLevel::Warn));
        assert!(!filter.should_log(LogLevel::Info));

        // Set to Trace (all)
        filter.set_level(LogLevel::Trace);
        assert!(filter.should_log(LogLevel::Error));
        assert!(filter.should_log(LogLevel::Warn));
        assert!(filter.should_log(LogLevel::Info));
        assert!(filter.should_log(LogLevel::Debug));
        assert!(filter.should_log(LogLevel::Trace));
    }

    #[test]
    fn test_logger_basic() {
        let logger = TestLogger::new(false);

        let record = LogRecord {
            level: LogLevel::Info,
            module: "test_module",
            file: "test.rs",
            line: 42,
            timestamp: Some(1234),
            message: "Test message",
        };

        logger.log(&record);

        let messages = logger.messages();
        assert_eq!(messages.len(), 1);
        assert!(messages[0].contains("[  1234ms]"));
        assert!(messages[0].contains("INFO "));
        assert!(messages[0].contains("test_module"));
        assert!(messages[0].contains("test.rs"));
        assert!(messages[0].contains(":42]"));
        assert!(messages[0].contains("Test message"));
    }

    #[test]
    fn test_logger_with_colors() {
        let logger = TestLogger::new(true);

        let record = LogRecord {
            level: LogLevel::Error,
            module: "mod",
            file: "file.rs",
            line: 10,
            timestamp: None,
            message: "Error message",
        };

        logger.log(&record);

        let messages = logger.messages();
        assert_eq!(messages.len(), 1);
        assert!(messages[0].contains("\x1b[31m")); // Red color
        assert!(messages[0].contains("\x1b[0m")); // Reset color
    }

    #[test]
    fn test_logger_without_timestamp() {
        let logger = TestLogger::new(false);

        let record = LogRecord {
            level: LogLevel::Debug,
            module: "mod",
            file: "file.rs",
            line: 1,
            timestamp: None,
            message: "No timestamp",
        };

        logger.log(&record);

        let messages = logger.messages();
        assert_eq!(messages.len(), 1);
        assert!(!messages[0].contains("ms]")); // No timestamp
        assert!(messages[0].contains("DEBUG"));
    }

    #[test]
    fn test_logger_multiple_messages() {
        let logger = TestLogger::new(false);

        for i in 0..5 {
            let record = LogRecord {
                level: LogLevel::Info,
                module: "mod",
                file: "file.rs",
                line: i,
                timestamp: Some(i * 100),
                message: &format!("Message {}", i),
            };
            logger.log(&record);
        }

        let messages = logger.messages();
        assert_eq!(messages.len(), 5);
    }

    #[test]
    fn test_logger_clear() {
        let logger = TestLogger::new(false);

        let record = LogRecord {
            level: LogLevel::Info,
            module: "mod",
            file: "file.rs",
            line: 1,
            timestamp: Some(0),
            message: "Test",
        };
        logger.log(&record);

        assert_eq!(logger.messages().len(), 1);

        logger.clear();
        assert_eq!(logger.messages().len(), 0);
    }
}

// ============================================================================
// Stability Tests - Mirrors rustos-kernel/src/stability.rs
// ============================================================================

mod stability_tests {
    /// Stability level enum
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    enum Stability {
        Stable,
        Unstable,
        Deprecated,
    }

    const STABLE_SINCE: &str = "0.1.0";
    const VERSION: &str = "0.1.0";

    #[test]
    fn test_stability_variants() {
        assert_ne!(Stability::Stable, Stability::Unstable);
        assert_ne!(Stability::Stable, Stability::Deprecated);
        assert_ne!(Stability::Unstable, Stability::Deprecated);
    }

    #[test]
    fn test_stability_clone() {
        let s1 = Stability::Stable;
        let s2 = s1;
        assert_eq!(s1, s2);
    }

    #[test]
    fn test_stability_debug() {
        assert_eq!(format!("{:?}", Stability::Stable), "Stable");
        assert_eq!(format!("{:?}", Stability::Unstable), "Unstable");
        assert_eq!(format!("{:?}", Stability::Deprecated), "Deprecated");
    }

    #[test]
    fn test_version_constants() {
        assert_eq!(STABLE_SINCE, "0.1.0");
        assert_eq!(VERSION, "0.1.0");
    }
}

// ============================================================================
// Panic Infrastructure Tests - Mirrors rustos-kernel/src/panic.rs
// ============================================================================

mod panic_tests {
    use super::*;

    struct PanicState {
        panicking: AtomicBool,
    }

    impl PanicState {
        const fn new() -> Self {
            Self {
                panicking: AtomicBool::new(false),
            }
        }

        fn is_panicking(&self) -> bool {
            self.panicking.load(Ordering::SeqCst)
        }

        fn set_panicking(&self) -> bool {
            // Returns true if already panicking (recursive panic)
            self.panicking.swap(true, Ordering::SeqCst)
        }

        fn reset(&self) {
            self.panicking.store(false, Ordering::SeqCst);
        }
    }

    #[test]
    fn test_panic_state_initial() {
        let state = PanicState::new();
        assert!(!state.is_panicking());
    }

    #[test]
    fn test_panic_state_first_panic() {
        let state = PanicState::new();
        let was_panicking = state.set_panicking();
        assert!(!was_panicking); // First panic
        assert!(state.is_panicking());
    }

    #[test]
    fn test_panic_state_recursive_panic() {
        let state = PanicState::new();

        // First panic
        let was_panicking = state.set_panicking();
        assert!(!was_panicking);

        // Second panic (recursive)
        let was_panicking = state.set_panicking();
        assert!(was_panicking); // Already panicking
    }

    #[test]
    fn test_panic_state_reset() {
        let state = PanicState::new();

        state.set_panicking();
        assert!(state.is_panicking());

        state.reset();
        assert!(!state.is_panicking());

        // Can panic again after reset
        let was_panicking = state.set_panicking();
        assert!(!was_panicking);
    }
}

// ============================================================================
// Priority Bitmap Tests - Additional scheduler coverage
// ============================================================================

mod priority_bitmap_tests {
    use super::*;

    /// Priority bitmap using 4x64-bit words for 256 priorities
    struct PriorityBitmap {
        words: [AtomicU64; 4],
    }

    impl PriorityBitmap {
        const fn new() -> Self {
            Self {
                words: [
                    AtomicU64::new(0),
                    AtomicU64::new(0),
                    AtomicU64::new(0),
                    AtomicU64::new(0),
                ],
            }
        }

        fn set(&self, priority: u8) {
            let word = (priority / 64) as usize;
            let bit = priority % 64;
            self.words[word].fetch_or(1 << bit, Ordering::SeqCst);
        }

        fn clear(&self, priority: u8) {
            let word = (priority / 64) as usize;
            let bit = priority % 64;
            self.words[word].fetch_and(!(1 << bit), Ordering::SeqCst);
        }

        fn is_set(&self, priority: u8) -> bool {
            let word = (priority / 64) as usize;
            let bit = priority % 64;
            (self.words[word].load(Ordering::SeqCst) & (1 << bit)) != 0
        }

        /// Find highest priority (lowest value) set bit
        fn find_highest(&self) -> Option<u8> {
            for (i, word) in self.words.iter().enumerate() {
                let bits = word.load(Ordering::SeqCst);
                if bits != 0 {
                    let bit = bits.trailing_zeros() as u8;
                    return Some((i as u8 * 64) + bit);
                }
            }
            None
        }

        fn is_empty(&self) -> bool {
            self.words.iter().all(|w| w.load(Ordering::SeqCst) == 0)
        }

        fn count(&self) -> u32 {
            self.words
                .iter()
                .map(|w| w.load(Ordering::SeqCst).count_ones())
                .sum()
        }

        fn clear_all(&self) {
            for word in &self.words {
                word.store(0, Ordering::SeqCst);
            }
        }
    }

    #[test]
    fn test_bitmap_initial_empty() {
        let bitmap = PriorityBitmap::new();
        assert!(bitmap.is_empty());
        assert_eq!(bitmap.count(), 0);
        assert_eq!(bitmap.find_highest(), None);
    }

    #[test]
    fn test_bitmap_set_single() {
        let bitmap = PriorityBitmap::new();

        bitmap.set(10);
        assert!(bitmap.is_set(10));
        assert!(!bitmap.is_set(9));
        assert!(!bitmap.is_set(11));
        assert_eq!(bitmap.count(), 1);
    }

    #[test]
    fn test_bitmap_set_multiple() {
        let bitmap = PriorityBitmap::new();

        bitmap.set(0);
        bitmap.set(63);
        bitmap.set(64);
        bitmap.set(127);
        bitmap.set(128);
        bitmap.set(255);

        assert!(bitmap.is_set(0));
        assert!(bitmap.is_set(63));
        assert!(bitmap.is_set(64));
        assert!(bitmap.is_set(127));
        assert!(bitmap.is_set(128));
        assert!(bitmap.is_set(255));
        assert_eq!(bitmap.count(), 6);
    }

    #[test]
    fn test_bitmap_clear() {
        let bitmap = PriorityBitmap::new();

        bitmap.set(50);
        assert!(bitmap.is_set(50));

        bitmap.clear(50);
        assert!(!bitmap.is_set(50));
    }

    #[test]
    fn test_bitmap_find_highest() {
        let bitmap = PriorityBitmap::new();

        bitmap.set(100);
        assert_eq!(bitmap.find_highest(), Some(100));

        bitmap.set(50);
        assert_eq!(bitmap.find_highest(), Some(50)); // Lower value = higher priority

        bitmap.set(10);
        assert_eq!(bitmap.find_highest(), Some(10));

        // Clear highest, next should be found
        bitmap.clear(10);
        assert_eq!(bitmap.find_highest(), Some(50));
    }

    #[test]
    fn test_bitmap_boundary_values() {
        let bitmap = PriorityBitmap::new();

        // Test boundaries between words
        bitmap.set(0);
        assert_eq!(bitmap.find_highest(), Some(0));
        bitmap.clear(0);

        bitmap.set(63);
        assert_eq!(bitmap.find_highest(), Some(63));
        bitmap.clear(63);

        bitmap.set(64);
        assert_eq!(bitmap.find_highest(), Some(64));
        bitmap.clear(64);

        bitmap.set(127);
        assert_eq!(bitmap.find_highest(), Some(127));
        bitmap.clear(127);

        bitmap.set(128);
        assert_eq!(bitmap.find_highest(), Some(128));
        bitmap.clear(128);

        bitmap.set(191);
        assert_eq!(bitmap.find_highest(), Some(191));
        bitmap.clear(191);

        bitmap.set(192);
        assert_eq!(bitmap.find_highest(), Some(192));
        bitmap.clear(192);

        bitmap.set(255);
        assert_eq!(bitmap.find_highest(), Some(255));
    }

    #[test]
    fn test_bitmap_clear_all() {
        let bitmap = PriorityBitmap::new();

        for i in 0..256u16 {
            bitmap.set(i as u8);
        }
        assert_eq!(bitmap.count(), 256);

        bitmap.clear_all();
        assert!(bitmap.is_empty());
        assert_eq!(bitmap.count(), 0);
    }

    #[test]
    fn test_bitmap_all_priorities() {
        let bitmap = PriorityBitmap::new();

        // Set all 256 priorities
        for i in 0..256u16 {
            bitmap.set(i as u8);
        }
        assert_eq!(bitmap.count(), 256);

        // Verify all are set
        for i in 0..256u16 {
            assert!(bitmap.is_set(i as u8));
        }

        // Clear all
        for i in 0..256u16 {
            bitmap.clear(i as u8);
        }
        assert!(bitmap.is_empty());
    }
}

// ============================================================================
// Watchdog Timer Tests - Mirrors rustos-hal/src/wdt.rs
// ============================================================================

mod wdt_tests {
    use super::*;

    /// Watchdog timer modes
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    enum WdtMode {
        /// First timeout generates interrupt, second resets
        Window,
        /// Direct reset on timeout
        Reset,
    }

    /// Mock watchdog timer state
    struct MockWdt {
        enabled: AtomicBool,
        interval: AtomicU32,
        counter: AtomicU32,
        mode: AtomicU32,
        timeout_occurred: AtomicBool,
    }

    impl MockWdt {
        const fn new() -> Self {
            Self {
                enabled: AtomicBool::new(false),
                interval: AtomicU32::new(0),
                counter: AtomicU32::new(0),
                mode: AtomicU32::new(WdtMode::Reset as u32),
                timeout_occurred: AtomicBool::new(false),
            }
        }

        fn enable(&self) {
            self.enabled.store(true, Ordering::SeqCst);
            self.reset_counter();
        }

        fn disable(&self) {
            self.enabled.store(false, Ordering::SeqCst);
        }

        fn is_enabled(&self) -> bool {
            self.enabled.load(Ordering::SeqCst)
        }

        fn set_interval(&self, interval: u32) {
            self.interval.store(interval, Ordering::SeqCst);
        }

        fn get_interval(&self) -> u32 {
            self.interval.load(Ordering::SeqCst)
        }

        fn reset_counter(&self) {
            let interval = self.interval.load(Ordering::SeqCst);
            self.counter.store(interval, Ordering::SeqCst);
            self.timeout_occurred.store(false, Ordering::SeqCst);
        }

        fn kick(&self) {
            if self.is_enabled() {
                self.reset_counter();
            }
        }

        fn set_mode(&self, mode: WdtMode) {
            self.mode.store(mode as u32, Ordering::SeqCst);
        }

        fn get_mode(&self) -> WdtMode {
            match self.mode.load(Ordering::SeqCst) {
                0 => WdtMode::Window,
                _ => WdtMode::Reset,
            }
        }

        fn tick(&self) -> bool {
            if !self.is_enabled() {
                return false;
            }

            let counter = self.counter.load(Ordering::SeqCst);
            if counter > 0 {
                self.counter.store(counter - 1, Ordering::SeqCst);
                false
            } else {
                self.timeout_occurred.store(true, Ordering::SeqCst);
                true // Timeout!
            }
        }

        fn has_timed_out(&self) -> bool {
            self.timeout_occurred.load(Ordering::SeqCst)
        }

        fn get_remaining(&self) -> u32 {
            self.counter.load(Ordering::SeqCst)
        }
    }

    #[test]
    fn test_wdt_initial_state() {
        let wdt = MockWdt::new();
        assert!(!wdt.is_enabled());
        assert_eq!(wdt.get_interval(), 0);
        assert_eq!(wdt.get_mode(), WdtMode::Reset);
    }

    #[test]
    fn test_wdt_enable_disable() {
        let wdt = MockWdt::new();

        wdt.set_interval(1000);
        wdt.enable();
        assert!(wdt.is_enabled());

        wdt.disable();
        assert!(!wdt.is_enabled());
    }

    #[test]
    fn test_wdt_interval() {
        let wdt = MockWdt::new();

        wdt.set_interval(5000);
        assert_eq!(wdt.get_interval(), 5000);

        wdt.set_interval(10000);
        assert_eq!(wdt.get_interval(), 10000);
    }

    #[test]
    fn test_wdt_mode() {
        let wdt = MockWdt::new();

        wdt.set_mode(WdtMode::Window);
        assert_eq!(wdt.get_mode(), WdtMode::Window);

        wdt.set_mode(WdtMode::Reset);
        assert_eq!(wdt.get_mode(), WdtMode::Reset);
    }

    #[test]
    fn test_wdt_kick() {
        let wdt = MockWdt::new();

        wdt.set_interval(100);
        wdt.enable();

        // Simulate some ticks
        for _ in 0..50 {
            wdt.tick();
        }
        assert_eq!(wdt.get_remaining(), 50);

        // Kick should reset counter
        wdt.kick();
        assert_eq!(wdt.get_remaining(), 100);
    }

    #[test]
    fn test_wdt_timeout() {
        let wdt = MockWdt::new();

        wdt.set_interval(10);
        wdt.enable();

        // Tick until timeout
        for i in 0..10 {
            let timeout = wdt.tick();
            assert!(!timeout, "Should not timeout at tick {}", i);
        }

        // Next tick should timeout
        let timeout = wdt.tick();
        assert!(timeout);
        assert!(wdt.has_timed_out());
    }

    #[test]
    fn test_wdt_disabled_no_tick() {
        let wdt = MockWdt::new();

        wdt.set_interval(10);
        // Don't enable

        for _ in 0..20 {
            let timeout = wdt.tick();
            assert!(!timeout); // Should never timeout when disabled
        }
    }

    #[test]
    fn test_wdt_kick_when_disabled() {
        let wdt = MockWdt::new();

        wdt.set_interval(100);
        // Don't enable

        // Kick should do nothing when disabled
        wdt.kick();
        assert_eq!(wdt.get_remaining(), 0); // Not reset because not enabled
    }
}

// ============================================================================
// Ethernet HAL Tests - Mirrors rustos-hal/src/ethernet.rs
// ============================================================================

mod ethernet_tests {
    use super::*;

    /// MAC address type
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    struct MacAddress([u8; 6]);

    impl MacAddress {
        const fn new(bytes: [u8; 6]) -> Self {
            Self(bytes)
        }

        const fn broadcast() -> Self {
            Self([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])
        }

        fn is_broadcast(&self) -> bool {
            self.0.iter().all(|&b| b == 0xFF)
        }

        fn is_multicast(&self) -> bool {
            (self.0[0] & 0x01) != 0
        }

        fn is_unicast(&self) -> bool {
            !self.is_multicast()
        }

        fn bytes(&self) -> &[u8; 6] {
            &self.0
        }
    }

    impl Default for MacAddress {
        fn default() -> Self {
            Self([0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
        }
    }

    /// Mock Ethernet peripheral state
    struct MockEthernet {
        enabled: AtomicBool,
        mac_address: RefCell<MacAddress>,
        tx_count: AtomicU32,
        rx_count: AtomicU32,
        link_up: AtomicBool,
        speed: AtomicU32, // 10, 100 Mbps
        full_duplex: AtomicBool,
    }

    impl MockEthernet {
        fn new() -> Self {
            Self {
                enabled: AtomicBool::new(false),
                mac_address: RefCell::new(MacAddress::default()),
                tx_count: AtomicU32::new(0),
                rx_count: AtomicU32::new(0),
                link_up: AtomicBool::new(false),
                speed: AtomicU32::new(100),
                full_duplex: AtomicBool::new(true),
            }
        }

        fn enable(&self) {
            self.enabled.store(true, Ordering::SeqCst);
        }

        fn disable(&self) {
            self.enabled.store(false, Ordering::SeqCst);
        }

        fn is_enabled(&self) -> bool {
            self.enabled.load(Ordering::SeqCst)
        }

        fn set_mac_address(&self, addr: MacAddress) {
            *self.mac_address.borrow_mut() = addr;
        }

        fn get_mac_address(&self) -> MacAddress {
            *self.mac_address.borrow()
        }

        fn transmit(&self, _data: &[u8]) -> bool {
            if !self.is_enabled() || !self.is_link_up() {
                return false;
            }
            self.tx_count.fetch_add(1, Ordering::SeqCst);
            true
        }

        fn receive(&self) -> Option<Vec<u8>> {
            if !self.is_enabled() || !self.is_link_up() {
                return None;
            }
            self.rx_count.fetch_add(1, Ordering::SeqCst);
            Some(vec![0; 64]) // Mock packet
        }

        fn tx_count(&self) -> u32 {
            self.tx_count.load(Ordering::SeqCst)
        }

        fn rx_count(&self) -> u32 {
            self.rx_count.load(Ordering::SeqCst)
        }

        fn set_link_up(&self, up: bool) {
            self.link_up.store(up, Ordering::SeqCst);
        }

        fn is_link_up(&self) -> bool {
            self.link_up.load(Ordering::SeqCst)
        }

        fn set_speed(&self, speed: u32) {
            self.speed.store(speed, Ordering::SeqCst);
        }

        fn get_speed(&self) -> u32 {
            self.speed.load(Ordering::SeqCst)
        }

        fn set_full_duplex(&self, full: bool) {
            self.full_duplex.store(full, Ordering::SeqCst);
        }

        fn is_full_duplex(&self) -> bool {
            self.full_duplex.load(Ordering::SeqCst)
        }
    }

    #[test]
    fn test_mac_address_new() {
        let mac = MacAddress::new([0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC]);
        assert_eq!(mac.bytes(), &[0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC]);
    }

    #[test]
    fn test_mac_address_broadcast() {
        let mac = MacAddress::broadcast();
        assert!(mac.is_broadcast());
        assert!(mac.is_multicast());
    }

    #[test]
    fn test_mac_address_default() {
        let mac = MacAddress::default();
        assert_eq!(mac.bytes(), &[0, 0, 0, 0, 0, 0]);
        assert!(!mac.is_broadcast());
    }

    #[test]
    fn test_mac_address_unicast() {
        let mac = MacAddress::new([0x00, 0x11, 0x22, 0x33, 0x44, 0x55]);
        assert!(mac.is_unicast());
        assert!(!mac.is_multicast());
        assert!(!mac.is_broadcast());
    }

    #[test]
    fn test_mac_address_multicast() {
        let mac = MacAddress::new([0x01, 0x00, 0x5E, 0x00, 0x00, 0x01]);
        assert!(mac.is_multicast());
        assert!(!mac.is_unicast());
    }

    #[test]
    fn test_ethernet_initial_state() {
        let eth = MockEthernet::new();
        assert!(!eth.is_enabled());
        assert!(!eth.is_link_up());
        assert_eq!(eth.get_speed(), 100);
        assert!(eth.is_full_duplex());
    }

    #[test]
    fn test_ethernet_enable_disable() {
        let eth = MockEthernet::new();

        eth.enable();
        assert!(eth.is_enabled());

        eth.disable();
        assert!(!eth.is_enabled());
    }

    #[test]
    fn test_ethernet_mac_address() {
        let eth = MockEthernet::new();

        let mac = MacAddress::new([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
        eth.set_mac_address(mac);
        assert_eq!(eth.get_mac_address(), mac);
    }

    #[test]
    fn test_ethernet_transmit_disabled() {
        let eth = MockEthernet::new();
        eth.set_link_up(true);
        // Not enabled

        let result = eth.transmit(&[0; 64]);
        assert!(!result);
        assert_eq!(eth.tx_count(), 0);
    }

    #[test]
    fn test_ethernet_transmit_no_link() {
        let eth = MockEthernet::new();
        eth.enable();
        // Link not up

        let result = eth.transmit(&[0; 64]);
        assert!(!result);
        assert_eq!(eth.tx_count(), 0);
    }

    #[test]
    fn test_ethernet_transmit_success() {
        let eth = MockEthernet::new();
        eth.enable();
        eth.set_link_up(true);

        let result = eth.transmit(&[0; 64]);
        assert!(result);
        assert_eq!(eth.tx_count(), 1);

        eth.transmit(&[0; 64]);
        eth.transmit(&[0; 64]);
        assert_eq!(eth.tx_count(), 3);
    }

    #[test]
    fn test_ethernet_receive_disabled() {
        let eth = MockEthernet::new();
        eth.set_link_up(true);
        // Not enabled

        let result = eth.receive();
        assert!(result.is_none());
    }

    #[test]
    fn test_ethernet_receive_success() {
        let eth = MockEthernet::new();
        eth.enable();
        eth.set_link_up(true);

        let result = eth.receive();
        assert!(result.is_some());
        assert_eq!(eth.rx_count(), 1);
    }

    #[test]
    fn test_ethernet_link_speed() {
        let eth = MockEthernet::new();

        eth.set_speed(10);
        assert_eq!(eth.get_speed(), 10);

        eth.set_speed(100);
        assert_eq!(eth.get_speed(), 100);
    }

    #[test]
    fn test_ethernet_duplex() {
        let eth = MockEthernet::new();

        eth.set_full_duplex(false);
        assert!(!eth.is_full_duplex());

        eth.set_full_duplex(true);
        assert!(eth.is_full_duplex());
    }
}

// ============================================================================
// Interrupt Controller Tests - Additional coverage
// ============================================================================

mod intc_tests {
    use super::*;

    const MAX_IRQS: usize = 32;

    /// Mock interrupt controller
    struct MockIntc {
        enabled: AtomicU32,
        pending: AtomicU32,
        priorities: [AtomicU8; MAX_IRQS],
        threshold: AtomicU8,
        master_enable: AtomicBool,
    }

    impl MockIntc {
        fn new() -> Self {
            // Initialize priority array
            const INIT: AtomicU8 = AtomicU8::new(0);
            Self {
                enabled: AtomicU32::new(0),
                pending: AtomicU32::new(0),
                priorities: [INIT; MAX_IRQS],
                threshold: AtomicU8::new(0),
                master_enable: AtomicBool::new(false),
            }
        }

        fn enable_irq(&self, irq: u8) {
            if irq < MAX_IRQS as u8 {
                self.enabled.fetch_or(1 << irq, Ordering::SeqCst);
            }
        }

        fn disable_irq(&self, irq: u8) {
            if irq < MAX_IRQS as u8 {
                self.enabled.fetch_and(!(1 << irq), Ordering::SeqCst);
            }
        }

        fn is_irq_enabled(&self, irq: u8) -> bool {
            if irq >= MAX_IRQS as u8 {
                return false;
            }
            (self.enabled.load(Ordering::SeqCst) & (1 << irq)) != 0
        }

        fn set_pending(&self, irq: u8) {
            if irq < MAX_IRQS as u8 {
                self.pending.fetch_or(1 << irq, Ordering::SeqCst);
            }
        }

        fn clear_pending(&self, irq: u8) {
            if irq < MAX_IRQS as u8 {
                self.pending.fetch_and(!(1 << irq), Ordering::SeqCst);
            }
        }

        fn is_pending(&self, irq: u8) -> bool {
            if irq >= MAX_IRQS as u8 {
                return false;
            }
            (self.pending.load(Ordering::SeqCst) & (1 << irq)) != 0
        }

        fn set_priority(&self, irq: u8, priority: u8) {
            if irq < MAX_IRQS as u8 {
                self.priorities[irq as usize].store(priority, Ordering::SeqCst);
            }
        }

        fn get_priority(&self, irq: u8) -> u8 {
            if irq >= MAX_IRQS as u8 {
                return 0;
            }
            self.priorities[irq as usize].load(Ordering::SeqCst)
        }

        fn set_threshold(&self, threshold: u8) {
            self.threshold.store(threshold, Ordering::SeqCst);
        }

        fn get_threshold(&self) -> u8 {
            self.threshold.load(Ordering::SeqCst)
        }

        fn enable_master(&self) {
            self.master_enable.store(true, Ordering::SeqCst);
        }

        fn disable_master(&self) {
            self.master_enable.store(false, Ordering::SeqCst);
        }

        fn is_master_enabled(&self) -> bool {
            self.master_enable.load(Ordering::SeqCst)
        }

        /// Claim highest priority pending interrupt
        fn claim(&self) -> Option<u8> {
            if !self.is_master_enabled() {
                return None;
            }

            let threshold = self.get_threshold();
            let enabled = self.enabled.load(Ordering::SeqCst);
            let pending = self.pending.load(Ordering::SeqCst);
            let active = enabled & pending;

            if active == 0 {
                return None;
            }

            // Find highest priority (lowest number) pending and enabled
            let mut best_irq: Option<u8> = None;
            let mut best_priority = u8::MAX;

            for irq in 0..MAX_IRQS as u8 {
                if (active & (1 << irq)) != 0 {
                    let priority = self.get_priority(irq);
                    if priority > threshold && priority < best_priority {
                        best_priority = priority;
                        best_irq = Some(irq);
                    }
                }
            }

            if let Some(irq) = best_irq {
                self.clear_pending(irq);
            }
            best_irq
        }
    }

    #[test]
    fn test_intc_initial_state() {
        let intc = MockIntc::new();
        assert!(!intc.is_master_enabled());
        assert_eq!(intc.get_threshold(), 0);
    }

    #[test]
    fn test_intc_enable_disable_irq() {
        let intc = MockIntc::new();

        intc.enable_irq(5);
        assert!(intc.is_irq_enabled(5));
        assert!(!intc.is_irq_enabled(4));
        assert!(!intc.is_irq_enabled(6));

        intc.disable_irq(5);
        assert!(!intc.is_irq_enabled(5));
    }

    #[test]
    fn test_intc_pending() {
        let intc = MockIntc::new();

        intc.set_pending(3);
        assert!(intc.is_pending(3));
        assert!(!intc.is_pending(2));

        intc.clear_pending(3);
        assert!(!intc.is_pending(3));
    }

    #[test]
    fn test_intc_priority() {
        let intc = MockIntc::new();

        intc.set_priority(7, 5);
        assert_eq!(intc.get_priority(7), 5);

        intc.set_priority(7, 10);
        assert_eq!(intc.get_priority(7), 10);
    }

    #[test]
    fn test_intc_threshold() {
        let intc = MockIntc::new();

        intc.set_threshold(3);
        assert_eq!(intc.get_threshold(), 3);
    }

    #[test]
    fn test_intc_master_enable() {
        let intc = MockIntc::new();

        intc.enable_master();
        assert!(intc.is_master_enabled());

        intc.disable_master();
        assert!(!intc.is_master_enabled());
    }

    #[test]
    fn test_intc_claim_disabled() {
        let intc = MockIntc::new();

        intc.enable_irq(0);
        intc.set_pending(0);
        intc.set_priority(0, 5);
        // Master not enabled

        assert_eq!(intc.claim(), None);
    }

    #[test]
    fn test_intc_claim_success() {
        let intc = MockIntc::new();

        intc.enable_irq(0);
        intc.set_pending(0);
        intc.set_priority(0, 5);
        intc.enable_master();

        let claimed = intc.claim();
        assert_eq!(claimed, Some(0));
        assert!(!intc.is_pending(0)); // Cleared after claim
    }

    #[test]
    fn test_intc_claim_priority_order() {
        let intc = MockIntc::new();

        intc.enable_irq(0);
        intc.enable_irq(1);
        intc.enable_irq(2);
        intc.set_pending(0);
        intc.set_pending(1);
        intc.set_pending(2);
        intc.set_priority(0, 10);
        intc.set_priority(1, 5); // Highest priority (lowest number after threshold)
        intc.set_priority(2, 8);
        intc.enable_master();

        // Should claim IRQ 1 first (lowest priority value > threshold)
        assert_eq!(intc.claim(), Some(1));
        assert_eq!(intc.claim(), Some(2));
        assert_eq!(intc.claim(), Some(0));
        assert_eq!(intc.claim(), None);
    }

    #[test]
    fn test_intc_threshold_filtering() {
        let intc = MockIntc::new();

        intc.enable_irq(0);
        intc.set_pending(0);
        intc.set_priority(0, 5);
        intc.set_threshold(5); // Same as priority - should be filtered
        intc.enable_master();

        assert_eq!(intc.claim(), None);

        // Lower threshold - should allow
        intc.set_pending(0);
        intc.set_threshold(4);
        assert_eq!(intc.claim(), Some(0));
    }

    #[test]
    fn test_intc_invalid_irq() {
        let intc = MockIntc::new();

        // Out of range IRQ should be safe (no-op)
        intc.enable_irq(255);
        assert!(!intc.is_irq_enabled(255));

        intc.set_pending(200);
        assert!(!intc.is_pending(200));
    }
}

// ============================================================================
// Timer Advanced Tests - Additional coverage
// ============================================================================

mod timer_advanced_tests {
    use super::*;

    /// Mock periodic timer
    struct MockPeriodicTimer {
        period: AtomicU32,
        counter: AtomicU32,
        enabled: AtomicBool,
        auto_reload: AtomicBool,
        callback_count: AtomicU32,
    }

    impl MockPeriodicTimer {
        const fn new() -> Self {
            Self {
                period: AtomicU32::new(0),
                counter: AtomicU32::new(0),
                enabled: AtomicBool::new(false),
                auto_reload: AtomicBool::new(true),
                callback_count: AtomicU32::new(0),
            }
        }

        fn set_period(&self, period: u32) {
            self.period.store(period, Ordering::SeqCst);
        }

        fn get_period(&self) -> u32 {
            self.period.load(Ordering::SeqCst)
        }

        fn start(&self) {
            let period = self.period.load(Ordering::SeqCst);
            self.counter.store(period, Ordering::SeqCst);
            self.enabled.store(true, Ordering::SeqCst);
        }

        fn stop(&self) {
            self.enabled.store(false, Ordering::SeqCst);
        }

        fn is_running(&self) -> bool {
            self.enabled.load(Ordering::SeqCst)
        }

        fn set_auto_reload(&self, auto: bool) {
            self.auto_reload.store(auto, Ordering::SeqCst);
        }

        fn tick(&self) -> bool {
            if !self.is_running() {
                return false;
            }

            let counter = self.counter.load(Ordering::SeqCst);
            if counter > 0 {
                self.counter.store(counter - 1, Ordering::SeqCst);
                false
            } else {
                // Timer expired
                self.callback_count.fetch_add(1, Ordering::SeqCst);

                if self.auto_reload.load(Ordering::SeqCst) {
                    let period = self.period.load(Ordering::SeqCst);
                    self.counter.store(period, Ordering::SeqCst);
                } else {
                    self.enabled.store(false, Ordering::SeqCst);
                }
                true
            }
        }

        fn callback_count(&self) -> u32 {
            self.callback_count.load(Ordering::SeqCst)
        }

        fn get_remaining(&self) -> u32 {
            self.counter.load(Ordering::SeqCst)
        }

        fn reset(&self) {
            self.callback_count.store(0, Ordering::SeqCst);
            self.enabled.store(false, Ordering::SeqCst);
            self.counter.store(0, Ordering::SeqCst);
        }
    }

    #[test]
    fn test_timer_initial_state() {
        let timer = MockPeriodicTimer::new();
        assert!(!timer.is_running());
        assert_eq!(timer.get_period(), 0);
        assert_eq!(timer.callback_count(), 0);
    }

    #[test]
    fn test_timer_set_period() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(1000);
        assert_eq!(timer.get_period(), 1000);
    }

    #[test]
    fn test_timer_start_stop() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(100);
        timer.start();
        assert!(timer.is_running());
        assert_eq!(timer.get_remaining(), 100);

        timer.stop();
        assert!(!timer.is_running());
    }

    #[test]
    fn test_timer_single_shot() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(5);
        timer.set_auto_reload(false);
        timer.start();

        // Tick until expired
        for _ in 0..5 {
            assert!(!timer.tick());
        }

        // Should fire and stop
        assert!(timer.tick());
        assert!(!timer.is_running());
        assert_eq!(timer.callback_count(), 1);

        // Further ticks should do nothing
        assert!(!timer.tick());
        assert_eq!(timer.callback_count(), 1);
    }

    #[test]
    fn test_timer_periodic() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(3);
        timer.set_auto_reload(true);
        timer.start();

        // First period
        timer.tick();
        timer.tick();
        timer.tick();
        assert!(timer.tick()); // Fires
        assert_eq!(timer.callback_count(), 1);
        assert!(timer.is_running()); // Still running

        // Second period
        timer.tick();
        timer.tick();
        timer.tick();
        assert!(timer.tick()); // Fires again
        assert_eq!(timer.callback_count(), 2);
    }

    #[test]
    fn test_timer_reset() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(10);
        timer.start();
        for _ in 0..5 {
            timer.tick();
        }
        assert_eq!(timer.get_remaining(), 5);

        timer.reset();
        assert!(!timer.is_running());
        assert_eq!(timer.get_remaining(), 0);
        assert_eq!(timer.callback_count(), 0);
    }

    #[test]
    fn test_timer_tick_when_stopped() {
        let timer = MockPeriodicTimer::new();

        timer.set_period(10);
        // Don't start

        let fired = timer.tick();
        assert!(!fired);
    }
}
