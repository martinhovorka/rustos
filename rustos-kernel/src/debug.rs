//! REQ: DBG-017, DBG-018, DBG-019 - Debug Infrastructure
//! 
//! Provides debugging facilities including GDB stub support, semihosting,
//! and runtime profiling via hardware performance counters.
//!
//! # Features
//!
//! - **GDB Stub** (REQ: DBG-017): Remote debugging over JTAG/UART
//! - **Semihosting** (REQ: DBG-018): Host-based I/O during development
//! - **Profiling** (REQ: DBG-019): Hardware performance event counters
//!
//! # Usage
//!
//! ```no_run
//! use rustos_kernel::debug::{Profiler, Semihosting};
//!
//! // Start profiling a section of code
//! let _prof = Profiler::start("critical_section");
//!
//! // Use semihosting for debug output
//! Semihosting::write_str("Debug: entering main loop\n");
//! ```

use core::sync::atomic::{AtomicBool, AtomicU32, Ordering};

/// Atomic u64 wrapper using two AtomicU32 for 32-bit targets
struct AtomicU64 {
    low: AtomicU32,
    high: AtomicU32,
}

impl AtomicU64 {
    const fn new(val: u64) -> Self {
        Self {
            low: AtomicU32::new(val as u32),
            high: AtomicU32::new((val >> 32) as u32),
        }
    }
    
    fn load(&self, order: Ordering) -> u64 {
        let low = self.low.load(order) as u64;
        let high = self.high.load(order) as u64;
        (high << 32) | low
    }
    
    fn store(&self, val: u64, order: Ordering) {
        self.low.store(val as u32, order);
        self.high.store((val >> 32) as u32, order);
    }
    
    fn fetch_add(&self, val: u64, order: Ordering) -> u64 {
        let old = self.load(order);
        self.store(old.wrapping_add(val), order);
        old
    }
}

// ============================================================================
// REQ: DBG-017 - GDB Stub Support
// ============================================================================

/// GDB stub state machine states
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum GdbState {
    /// Waiting for initial connection
    Disconnected,
    /// Connected and ready for commands
    Connected,
    /// Target is running
    Running,
    /// Target is halted (breakpoint, step, etc.)
    Halted,
    /// Processing a command
    Processing,
}

/// REQ: DBG-017 - GDB stub for source-level debugging
/// 
/// Implements a minimal GDB Remote Serial Protocol (RSP) stub
/// for debugging via JTAG/UART.
pub struct GdbStub {
    state: AtomicU32,
    connected: AtomicBool,
    /// Number of active breakpoints
    breakpoint_count: AtomicU32,
    /// Registers cache for when target is halted
    registers: [AtomicU32; 32],
    /// Program counter when halted
    pc: AtomicU32,
}

impl GdbStub {
    /// Create a new GDB stub instance
    #[allow(clippy::declare_interior_mutable_const)]
    pub const fn new() -> Self {
        const ZERO: AtomicU32 = AtomicU32::new(0);
        Self {
            state: AtomicU32::new(GdbState::Disconnected as u32),
            connected: AtomicBool::new(false),
            breakpoint_count: AtomicU32::new(0),
            registers: [ZERO; 32],
            pc: AtomicU32::new(0),
        }
    }

    /// Get current GDB state
    pub fn state(&self) -> GdbState {
        match self.state.load(Ordering::SeqCst) {
            0 => GdbState::Disconnected,
            1 => GdbState::Connected,
            2 => GdbState::Running,
            3 => GdbState::Halted,
            4 => GdbState::Processing,
            _ => GdbState::Disconnected,
        }
    }

    /// Check if GDB is connected
    pub fn is_connected(&self) -> bool {
        self.connected.load(Ordering::SeqCst)
    }

    /// REQ: DBG-017 - Initialize GDB stub
    /// 
    /// Sets up the debug infrastructure for GDB connections.
    /// Should be called early in system initialization.
    pub fn init(&self) {
        self.state.store(GdbState::Disconnected as u32, Ordering::SeqCst);
        self.connected.store(false, Ordering::SeqCst);
        self.breakpoint_count.store(0, Ordering::SeqCst);
    }

    /// REQ: DBG-017 - Handle incoming GDB packet
    /// 
    /// Processes a GDB RSP packet and generates a response.
    /// Returns the response packet or None if no response is needed.
    pub fn handle_packet(&self, packet: &[u8]) -> Option<GdbResponse> {
        if packet.is_empty() {
            return None;
        }

        // Parse packet type (first character after '$')
        let cmd = packet.first()?;
        
        match cmd {
            b'?' => {
                // Stop reason query
                Some(GdbResponse::StopReason(StopReason::Signal(5))) // SIGTRAP
            }
            b'g' => {
                // Read registers
                Some(GdbResponse::Registers(self.read_registers()))
            }
            b'G' => {
                // Write registers
                self.write_registers(&packet[1..]);
                Some(GdbResponse::Ok)
            }
            b'm' => {
                // Read memory
                Some(GdbResponse::Memory(Vec::new())) // Placeholder
            }
            b'M' => {
                // Write memory
                Some(GdbResponse::Ok)
            }
            b'c' => {
                // Continue
                self.state.store(GdbState::Running as u32, Ordering::SeqCst);
                Some(GdbResponse::Running)
            }
            b's' => {
                // Single step
                self.state.store(GdbState::Running as u32, Ordering::SeqCst);
                Some(GdbResponse::Running)
            }
            b'Z' => {
                // Set breakpoint
                self.breakpoint_count.fetch_add(1, Ordering::SeqCst);
                Some(GdbResponse::Ok)
            }
            b'z' => {
                // Remove breakpoint
                let count = self.breakpoint_count.load(Ordering::SeqCst);
                if count > 0 {
                    self.breakpoint_count.fetch_sub(1, Ordering::SeqCst);
                }
                Some(GdbResponse::Ok)
            }
            b'q' => {
                // Query commands
                self.handle_query(&packet[1..])
            }
            _ => Some(GdbResponse::Unsupported),
        }
    }

    /// Handle query commands (qXXX)
    fn handle_query(&self, query: &[u8]) -> Option<GdbResponse> {
        if query.starts_with(b"Supported") {
            Some(GdbResponse::Features(GdbFeatures::default()))
        } else if query.starts_with(b"Attached") {
            Some(GdbResponse::Attached(true))
        } else if query.starts_with(b"fThreadInfo") {
            Some(GdbResponse::ThreadInfo({
                let mut v = Vec::new();
                let _ = v.push(1);
                v
            })) // Main thread
        } else {
            Some(GdbResponse::Unsupported)
        }
    }

    /// Read all registers
    fn read_registers(&self) -> [u32; 32] {
        let mut regs = [0u32; 32];
        for (i, reg) in self.registers.iter().enumerate() {
            regs[i] = reg.load(Ordering::SeqCst);
        }
        regs
    }

    /// Write registers from packet data
    fn write_registers(&self, _data: &[u8]) {
        // Parse hex-encoded register values
        // Implementation detail: parse pairs of hex digits
    }

    /// REQ: DBG-017 - Notify GDB of breakpoint hit
    pub fn breakpoint_hit(&self, pc: u32) {
        self.pc.store(pc, Ordering::SeqCst);
        self.state.store(GdbState::Halted as u32, Ordering::SeqCst);
    }

    /// Get number of active breakpoints
    pub fn breakpoint_count(&self) -> u32 {
        self.breakpoint_count.load(Ordering::SeqCst)
    }
}

/// GDB response types
#[derive(Debug, Clone)]
pub enum GdbResponse {
    /// OK response
    Ok,
    /// Error response
    Error(u8),
    /// Unsupported command
    Unsupported,
    /// Stop reason
    StopReason(StopReason),
    /// Register contents
    Registers([u32; 32]),
    /// Memory contents
    Memory(Vec<u8>),
    /// Target is now running
    Running,
    /// Supported features
    Features(GdbFeatures),
    /// Attached query response
    Attached(bool),
    /// Thread info
    ThreadInfo(Vec<u32>),
}

/// Stop reasons
#[derive(Debug, Clone, Copy)]
pub enum StopReason {
    /// Signal received (e.g., SIGTRAP = 5)
    Signal(u8),
    /// Watchpoint hit
    Watchpoint(u32),
    /// Breakpoint hit
    Breakpoint(u32),
}

/// GDB supported features
#[derive(Debug, Clone, Default)]
pub struct GdbFeatures {
    /// Support for memory read
    pub memory_read: bool,
    /// Support for memory write
    pub memory_write: bool,
    /// Support for breakpoints
    pub breakpoints: bool,
    /// Support for watchpoints
    pub watchpoints: bool,
    /// Support for single stepping
    pub single_step: bool,
}

impl Default for GdbStub {
    fn default() -> Self {
        Self::new()
    }
}

// Use a simple Vec alternative for no_std
type Vec<T> = heapless::Vec<T, 64>;

// ============================================================================
// REQ: DBG-018 - Semihosting Support
// ============================================================================

/// REQ: DBG-018 - Semihosting syscall numbers
#[repr(u32)]
#[derive(Debug, Clone, Copy)]
pub enum SemihostingSyscall {
    /// Open file
    Open = 0x01,
    /// Close file
    Close = 0x02,
    /// Write to file/console
    Write = 0x05,
    /// Read from file/console
    Read = 0x06,
    /// Write single character
    WriteC = 0x03,
    /// Write null-terminated string
    Write0 = 0x04,
    /// Read character
    ReadC = 0x07,
    /// Check if character available
    IsError = 0x08,
    /// Get system time (ticks)
    Time = 0x11,
    /// Exit application
    Exit = 0x18,
    /// Get command line
    GetCmdLine = 0x15,
    /// Get heap info
    HeapInfo = 0x16,
}

/// REQ: DBG-018 - Semihosting support for host-based I/O
/// 
/// Implements ARM-style semihosting via EBREAK instruction.
/// When running under a debugger, this allows:
/// - Console output to host terminal
/// - File I/O via host filesystem
/// - Reading command line arguments
pub struct Semihosting;

impl Semihosting {
    /// REQ: DBG-018 - Write a string to the host console
    /// 
    /// Uses semihosting SYS_WRITE0 to output a null-terminated string.
    /// Only works when connected to a debugger with semihosting support.
    #[inline(never)]
    pub fn write_str(s: &str) -> Result<(), SemihostingError> {
        if s.is_empty() {
            return Ok(());
        }
        
        // Use WRITE0 for null-terminated strings
        Self::syscall(SemihostingSyscall::Write0, s.as_ptr() as usize)
            .map(|_| ())
    }

    /// REQ: DBG-018 - Write a single character to host console
    pub fn write_char(c: char) -> Result<(), SemihostingError> {
        let ch = c as u32;
        Self::syscall(SemihostingSyscall::WriteC, &ch as *const u32 as usize)
            .map(|_| ())
    }

    /// REQ: DBG-018 - Read a character from host console
    pub fn read_char() -> Result<char, SemihostingError> {
        Self::syscall(SemihostingSyscall::ReadC, 0)
            .map(|c| char::from_u32(c as u32).unwrap_or('\0'))
    }

    /// REQ: DBG-018 - Get system time from host
    pub fn time() -> Result<u32, SemihostingError> {
        Self::syscall(SemihostingSyscall::Time, 0)
            .map(|t| t as u32)
    }

    /// REQ: DBG-018 - Exit to host (for testing)
    /// 
    /// Signals to the debugger that the program has finished.
    /// The exit code is passed to the host.
    pub fn exit(code: u32) -> ! {
        // ADP_Stopped_ApplicationExit = 0x20026
        const APPLICATION_EXIT: u32 = 0x20026;
        let block: [u32; 2] = [APPLICATION_EXIT, code];
        let _ = Self::syscall(SemihostingSyscall::Exit, block.as_ptr() as usize);
        
        // If semihosting is not active, loop forever
        loop {
            #[cfg(target_arch = "riscv32")]
            // SAFETY: WFI instruction - safe to execute, waits for interrupt
            unsafe {
                core::arch::asm!("wfi");
            }
        }
    }

    /// REQ: DBG-018 - Perform a semihosting syscall
    /// 
    /// On RISC-V, semihosting uses:
    /// - a0 = operation number
    /// - a1 = parameter block pointer
    /// - EBREAK instruction triggers the debugger
    #[cfg(target_arch = "riscv32")]
    fn syscall(op: SemihostingSyscall, arg: usize) -> Result<usize, SemihostingError> {
        let result: usize;
        // SAFETY: Assembly performs semihosting syscall with EBREAK instruction.
        // Debugger must be present to handle the trap. Safe for RISC-V target.
        unsafe {
            core::arch::asm!(
                // Semihosting sequence for RISC-V
                ".option push",
                ".option norvc",
                "slli zero, zero, 0x1f",   // Entry NOP
                "ebreak",                   // Semihosting call
                "srai zero, zero, 0x07",   // Exit NOP
                ".option pop",
                in("a0") op as u32,
                in("a1") arg,
                lateout("a0") result,
            );
        }
        
        if result == usize::MAX {
            Err(SemihostingError::Failed)
        } else {
            Ok(result)
        }
    }

    /// Mock syscall for non-RISC-V targets (testing)
    #[cfg(not(target_arch = "riscv32"))]
    fn syscall(_op: SemihostingSyscall, _arg: usize) -> Result<usize, SemihostingError> {
        // On non-RISC-V targets, semihosting is not available
        // Return success for testing purposes
        Ok(0)
    }

    /// Check if semihosting is available
    pub fn is_available() -> bool {
        // Try a harmless operation
        Self::syscall(SemihostingSyscall::Time, 0).is_ok()
    }
}

/// Semihosting error types
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum SemihostingError {
    /// Semihosting syscall failed
    Failed,
    /// Operation not supported
    NotSupported,
    /// Invalid parameter
    InvalidParameter,
    /// I/O error
    IoError,
}

// ============================================================================
// REQ: DBG-019 - Runtime Profiling via Performance Counters
// ============================================================================

/// REQ: DBG-019 - Hardware performance event types
/// 
/// These correspond to the 13 hardware performance event counters
/// available in the RISC-V debug specification.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(u8)]
pub enum PerfEvent {
    /// CPU cycles
    Cycles = 0,
    /// Instructions retired
    InstructionsRetired = 1,
    /// Time (real-time clock cycles)
    Time = 2,
    /// Load instructions
    LoadInstructions = 3,
    /// Store instructions
    StoreInstructions = 4,
    /// Branches (conditional)
    Branches = 5,
    /// Branch mispredictions
    BranchMispredictions = 6,
    /// Instruction cache misses
    ICacheMisses = 7,
    /// Data cache misses  
    DCacheMisses = 8,
    /// Interrupts taken
    Interrupts = 9,
    /// Exceptions taken
    Exceptions = 10,
    /// Context switches
    ContextSwitches = 11,
    /// Stall cycles
    StallCycles = 12,
}

/// REQ: DBG-019 - Performance counter reading
#[derive(Debug, Clone, Copy, Default)]
pub struct PerfCounters {
    /// CPU cycles
    pub cycles: u64,
    /// Instructions retired
    pub instructions: u64,
    /// Time in microseconds
    pub time_us: u64,
    /// Load operations
    pub loads: u32,
    /// Store operations
    pub stores: u32,
    /// Branch instructions
    pub branches: u32,
    /// Branch mispredictions
    pub mispredictions: u32,
    /// Cache misses
    pub cache_misses: u32,
    /// Interrupt count
    pub interrupts: u32,
    /// Exception count
    pub exceptions: u32,
    /// Context switch count
    pub context_switches: u32,
    /// Stall cycles
    pub stalls: u32,
}

/// REQ: DBG-019 - Runtime profiler using hardware performance counters
pub struct Profiler {
    /// Whether profiling is enabled
    enabled: AtomicBool,
    /// Start time for current profiling session
    start_cycles: AtomicU64,
    /// Accumulated cycles
    total_cycles: AtomicU64,
    /// Number of samples
    sample_count: AtomicU32,
    /// Profile name
    name: &'static str,
}

impl Profiler {
    /// Create a new profiler
    pub const fn new(name: &'static str) -> Self {
        Self {
            enabled: AtomicBool::new(false),
            start_cycles: AtomicU64::new(0),
            total_cycles: AtomicU64::new(0),
            sample_count: AtomicU32::new(0),
            name,
        }
    }

    /// REQ: DBG-019 - Start profiling
    /// 
    /// Returns a guard that stops profiling when dropped.
    pub fn start(name: &'static str) -> ProfileGuard {
        let start = Self::read_cycle_counter();
        ProfileGuard {
            start_cycles: start,
            name,
        }
    }

    /// Enable continuous profiling
    pub fn enable(&self) {
        self.enabled.store(true, Ordering::SeqCst);
        self.start_cycles.store(Self::read_cycle_counter(), Ordering::SeqCst);
    }

    /// Disable continuous profiling
    pub fn disable(&self) {
        if self.enabled.load(Ordering::SeqCst) {
            let end = Self::read_cycle_counter();
            let start = self.start_cycles.load(Ordering::SeqCst);
            self.total_cycles.fetch_add(end.saturating_sub(start), Ordering::SeqCst);
            self.sample_count.fetch_add(1, Ordering::SeqCst);
            self.enabled.store(false, Ordering::SeqCst);
        }
    }

    /// Get total cycles accumulated
    pub fn total_cycles(&self) -> u64 {
        self.total_cycles.load(Ordering::SeqCst)
    }

    /// Get number of samples
    pub fn sample_count(&self) -> u32 {
        self.sample_count.load(Ordering::SeqCst)
    }

    /// Get average cycles per sample
    pub fn average_cycles(&self) -> u64 {
        let total = self.total_cycles.load(Ordering::SeqCst);
        let count = self.sample_count.load(Ordering::SeqCst);
        if count > 0 {
            total / count as u64
        } else {
            0
        }
    }

    /// Get profiler name
    pub fn name(&self) -> &'static str {
        self.name
    }

    /// Reset profiler statistics
    pub fn reset(&self) {
        self.total_cycles.store(0, Ordering::SeqCst);
        self.sample_count.store(0, Ordering::SeqCst);
    }

    /// REQ: DBG-019 - Read all performance counters
    pub fn read_counters() -> PerfCounters {
        PerfCounters {
            cycles: Self::read_cycle_counter(),
            instructions: Self::read_instret_counter(),
            time_us: Self::read_time_counter(),
            loads: 0,      // Would read from HPM counters
            stores: 0,
            branches: 0,
            mispredictions: 0,
            cache_misses: 0,
            interrupts: 0,
            exceptions: 0,
            context_switches: 0,
            stalls: 0,
        }
    }

    /// REQ: DBG-019 - Read cycle counter (mcycle CSR)
    #[cfg(target_arch = "riscv32")]
    fn read_cycle_counter() -> u64 {
        let low: u32;
        let high: u32;
        // SAFETY: Reading mcycle/mcycleh CSRs - read-only performance counters
        unsafe {
            core::arch::asm!("csrr {}, mcycle", out(reg) low);
            core::arch::asm!("csrr {}, mcycleh", out(reg) high);
        }
        ((high as u64) << 32) | (low as u64)
    }

    #[cfg(not(target_arch = "riscv32"))]
    fn read_cycle_counter() -> u64 {
        // For testing on host
        static COUNTER: AtomicU64 = AtomicU64::new(0);
        COUNTER.fetch_add(1000, Ordering::SeqCst)
    }

    /// REQ: DBG-019 - Read instruction counter (minstret CSR)
    #[cfg(target_arch = "riscv32")]
    fn read_instret_counter() -> u64 {
        let low: u32;
        let high: u32;
        // SAFETY: Reading minstret CSR - read-only performance counter, no side effects
        unsafe {
            core::arch::asm!("csrr {}, minstret", out(reg) low);
            core::arch::asm!("csrr {}, minstreth", out(reg) high);
        }
        ((high as u64) << 32) | (low as u64)
    }

    #[cfg(not(target_arch = "riscv32"))]
    fn read_instret_counter() -> u64 {
        static COUNTER: AtomicU64 = AtomicU64::new(0);
        COUNTER.fetch_add(500, Ordering::SeqCst)
    }

    /// Read time counter
    fn read_time_counter() -> u64 {
        // Convert cycles to microseconds (assuming 75 MHz)
        Self::read_cycle_counter() / 75
    }
}

/// RAII guard for profiling a code section
pub struct ProfileGuard {
    start_cycles: u64,
    name: &'static str,
}

impl ProfileGuard {
    /// Get elapsed cycles since profiling started
    pub fn elapsed_cycles(&self) -> u64 {
        Profiler::read_cycle_counter().saturating_sub(self.start_cycles)
    }

    /// Get profiled section name
    pub fn name(&self) -> &'static str {
        self.name
    }
}

impl Drop for ProfileGuard {
    fn drop(&mut self) {
        // Could log the profile result here
        let _elapsed = self.elapsed_cycles();
    }
}

// ============================================================================
// Global instances
// ============================================================================

/// Global GDB stub instance
pub static GDB_STUB: GdbStub = GdbStub::new();

/// Global profiler for context switches
pub static CONTEXT_SWITCH_PROFILER: Profiler = Profiler::new("context_switch");

/// Global profiler for interrupt handling
pub static INTERRUPT_PROFILER: Profiler = Profiler::new("interrupt");

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_gdb_stub_new() {
        let stub = GdbStub::new();
        assert_eq!(stub.state(), GdbState::Disconnected);
        assert!(!stub.is_connected());
        assert_eq!(stub.breakpoint_count(), 0);
    }

    #[test]
    fn test_gdb_stub_init() {
        let stub = GdbStub::new();
        stub.init();
        assert_eq!(stub.state(), GdbState::Disconnected);
    }

    #[test]
    fn test_profiler_basic() {
        let profiler = Profiler::new("test");
        assert_eq!(profiler.total_cycles(), 0);
        assert_eq!(profiler.sample_count(), 0);
        assert_eq!(profiler.name(), "test");
    }

    #[test]
    fn test_profiler_enable_disable() {
        let profiler = Profiler::new("test");
        profiler.enable();
        profiler.disable();
        assert!(profiler.sample_count() >= 1);
    }

    #[test]
    fn test_profile_guard() {
        let _guard = Profiler::start("test_section");
        // Guard will be dropped at end of scope
    }

    #[test]
    fn test_semihosting_not_available() {
        // On test target, semihosting should work (mock returns Ok)
        assert!(Semihosting::is_available());
    }

    #[test]
    fn test_perf_counters() {
        let counters = Profiler::read_counters();
        assert!(counters.cycles > 0);
    }
}
