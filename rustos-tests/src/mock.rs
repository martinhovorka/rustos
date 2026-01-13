//! REQ: TEST-004 - Mock implementations for MMIO registers and CSR access
//!
//! This module provides mock implementations of hardware-specific functionality
//! to enable testing on host systems (x86_64-unknown-linux-gnu).

use core::ops::FnOnce;
use core::sync::atomic::{AtomicBool, AtomicU32, Ordering};

// For host testing, use portable Atomic types (64-bit support available on x86_64)
#[cfg(target_pointer_width = "64")]
use core::sync::atomic::AtomicU64;

/// Mock CSR (Control and Status Register) interface
pub struct MockCsr {
    /// Machine status register (mstatus)
    pub mstatus: AtomicU32,
    /// Machine interrupt enable (mie)
    pub mie: AtomicU32,
    /// Machine interrupt pending (mip)
    pub mip: AtomicU32,
    /// Machine cycle counter (mcycle) - per PERFTEST-001
    /// On 32-bit targets, use two AtomicU32 for high/low parts
    #[cfg(target_pointer_width = "64")]
    pub mcycle: AtomicU64,
    #[cfg(not(target_pointer_width = "64"))]
    pub mcycle_lo: AtomicU32,
    #[cfg(not(target_pointer_width = "64"))]
    pub mcycle_hi: AtomicU32,
    /// Machine cause register (mcause)
    pub mcause: AtomicU32,
    /// Machine trap value (mtval)
    pub mtval: AtomicU32,
}

impl Default for MockCsr {
    fn default() -> Self {
        Self::new()
    }
}

impl MockCsr {
    /// Create a new mock CSR interface
    pub const fn new() -> Self {
        Self {
            mstatus: AtomicU32::new(0),
            mie: AtomicU32::new(0),
            mip: AtomicU32::new(0),
            #[cfg(target_pointer_width = "64")]
            mcycle: AtomicU64::new(0),
            #[cfg(not(target_pointer_width = "64"))]
            mcycle_lo: AtomicU32::new(0),
            #[cfg(not(target_pointer_width = "64"))]
            mcycle_hi: AtomicU32::new(0),
            mcause: AtomicU32::new(0),
            mtval: AtomicU32::new(0),
        }
    }

    /// Read machine status register
    pub fn read_mstatus(&self) -> u32 {
        self.mstatus.load(Ordering::Relaxed)
    }

    /// Write machine status register
    pub fn write_mstatus(&self, value: u32) {
        self.mstatus.store(value, Ordering::Relaxed);
    }

    /// Enable machine interrupts (set MIE bit in mstatus)
    pub fn enable_interrupts(&self) {
        let mut mstatus = self.read_mstatus();
        mstatus |= 0x8; // MIE bit
        self.write_mstatus(mstatus);
    }

    /// Disable machine interrupts (clear MIE bit in mstatus)
    pub fn disable_interrupts(&self) {
        let mut mstatus = self.read_mstatus();
        mstatus &= !0x8; // Clear MIE bit
        self.write_mstatus(mstatus);
    }

    /// Check if interrupts are enabled
    pub fn interrupts_enabled(&self) -> bool {
        (self.read_mstatus() & 0x8) != 0
    }

    /// Read machine cycle counter
    #[cfg(target_pointer_width = "64")]
    pub fn read_mcycle(&self) -> u64 {
        self.mcycle.load(Ordering::Relaxed)
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn read_mcycle(&self) -> u64 {
        let lo = self.mcycle_lo.load(Ordering::Relaxed);
        let hi = self.mcycle_hi.load(Ordering::Relaxed);
        ((hi as u64) << 32) | (lo as u64)
    }

    /// Increment cycle counter (for simulation)
    #[cfg(target_pointer_width = "64")]
    pub fn tick_cycles(&self, cycles: u64) {
        self.mcycle.fetch_add(cycles, Ordering::Relaxed);
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn tick_cycles(&self, cycles: u64) {
        let current = self.read_mcycle();
        let new_value = current.wrapping_add(cycles);
        self.mcycle_lo
            .store((new_value & 0xFFFFFFFF) as u32, Ordering::Relaxed);
        self.mcycle_hi
            .store((new_value >> 32) as u32, Ordering::Relaxed);
    }

    /// Read machine cause register
    pub fn read_mcause(&self) -> u32 {
        self.mcause.load(Ordering::Relaxed)
    }

    /// Write machine cause register
    pub fn write_mcause(&self, value: u32) {
        self.mcause.store(value, Ordering::Relaxed);
    }

    /// Read machine trap value register
    pub fn read_mtval(&self) -> u32 {
        self.mtval.load(Ordering::Relaxed)
    }

    /// Write machine trap value register
    pub fn write_mtval(&self, value: u32) {
        self.mtval.store(value, Ordering::Relaxed);
    }
}

/// Global mock CSR instance for testing
pub static MOCK_CSR: MockCsr = MockCsr::new();

/// Mock MMIO register interface
pub struct MockMmio {
    /// Base address (for simulation only)
    pub base_addr: u32,
    /// Register values (indexed by offset)
    pub registers: [AtomicU32; 256],
}

impl MockMmio {
    /// Create a new mock MMIO interface
    #[allow(clippy::declare_interior_mutable_const)]
    pub const fn new(base_addr: u32) -> Self {
        // Create array of 256 atomic registers initialized to 0
        const ATOMIC_ZERO: AtomicU32 = AtomicU32::new(0);
        Self {
            base_addr,
            registers: [ATOMIC_ZERO; 256],
        }
    }

    /// Read from a register at the given offset
    pub fn read(&self, offset: usize) -> u32 {
        if offset < 256 {
            self.registers[offset].load(Ordering::Relaxed)
        } else {
            0
        }
    }

    /// Write to a register at the given offset
    pub fn write(&self, offset: usize, value: u32) {
        if offset < 256 {
            self.registers[offset].store(value, Ordering::Relaxed);
        }
    }

    /// Read-modify-write a register at the given offset
    pub fn modify<F>(&self, offset: usize, f: F)
    where
        F: FnOnce(u32) -> u32,
    {
        if offset < 256 {
            let old = self.registers[offset].load(Ordering::Relaxed);
            let new = f(old);
            self.registers[offset].store(new, Ordering::Relaxed);
        }
    }
}

/// Mock interrupt controller
pub struct MockIntc {
    /// Interrupt enable bits
    pub enabled: AtomicU32,
    /// Pending interrupts
    pub pending: AtomicU32,
    /// Interrupt fired counter (for testing)
    pub fired_count: AtomicU32,
}

impl Default for MockIntc {
    fn default() -> Self {
        Self::new()
    }
}

impl MockIntc {
    /// Create a new mock interrupt controller
    pub const fn new() -> Self {
        Self {
            enabled: AtomicU32::new(0),
            pending: AtomicU32::new(0),
            fired_count: AtomicU32::new(0),
        }
    }

    /// Enable an interrupt
    pub fn enable(&self, irq: u32) {
        self.enabled.fetch_or(1 << irq, Ordering::Relaxed);
    }

    /// Disable an interrupt
    pub fn disable(&self, irq: u32) {
        self.enabled.fetch_and(!(1 << irq), Ordering::Relaxed);
    }

    /// Trigger an interrupt (for testing)
    pub fn trigger(&self, irq: u32) {
        self.pending.fetch_or(1 << irq, Ordering::Relaxed);
        self.fired_count.fetch_add(1, Ordering::Relaxed);
    }

    /// Clear a pending interrupt
    pub fn clear(&self, irq: u32) {
        self.pending.fetch_and(!(1 << irq), Ordering::Relaxed);
    }

    /// Check if an interrupt is pending
    pub fn is_pending(&self, irq: u32) -> bool {
        (self.pending.load(Ordering::Relaxed) & (1 << irq)) != 0
    }

    /// Check if an interrupt is enabled
    pub fn is_enabled(&self, irq: u32) -> bool {
        (self.enabled.load(Ordering::Relaxed) & (1 << irq)) != 0
    }

    /// Get total interrupt count
    pub fn get_fired_count(&self) -> u32 {
        self.fired_count.load(Ordering::Relaxed)
    }

    /// Reset the mock (for test cleanup)
    pub fn reset(&self) {
        self.enabled.store(0, Ordering::Relaxed);
        self.pending.store(0, Ordering::Relaxed);
        self.fired_count.store(0, Ordering::Relaxed);
    }
}

/// Global mock interrupt controller instance
pub static MOCK_INTC: MockIntc = MockIntc::new();

/// Mock timer for time-based tests
pub struct MockTimer {
    /// Current tick count
    #[cfg(target_pointer_width = "64")]
    pub ticks: AtomicU64,
    #[cfg(not(target_pointer_width = "64"))]
    pub ticks_lo: AtomicU32,
    #[cfg(not(target_pointer_width = "64"))]
    pub ticks_hi: AtomicU32,
    /// Tick interval in cycles
    #[cfg(target_pointer_width = "64")]
    pub interval: AtomicU64,
    #[cfg(not(target_pointer_width = "64"))]
    pub interval_lo: AtomicU32,
    #[cfg(not(target_pointer_width = "64"))]
    pub interval_hi: AtomicU32,
    /// Timer enabled flag
    pub enabled: AtomicBool,
}

impl Default for MockTimer {
    fn default() -> Self {
        Self::new()
    }
}

impl MockTimer {
    /// Create a new mock timer
    pub const fn new() -> Self {
        Self {
            #[cfg(target_pointer_width = "64")]
            ticks: AtomicU64::new(0),
            #[cfg(not(target_pointer_width = "64"))]
            ticks_lo: AtomicU32::new(0),
            #[cfg(not(target_pointer_width = "64"))]
            ticks_hi: AtomicU32::new(0),
            #[cfg(target_pointer_width = "64")]
            interval: AtomicU64::new(1000), // Default: 1ms at 1kHz tick rate
            #[cfg(not(target_pointer_width = "64"))]
            interval_lo: AtomicU32::new(1000),
            #[cfg(not(target_pointer_width = "64"))]
            interval_hi: AtomicU32::new(0),
            enabled: AtomicBool::new(false),
        }
    }

    /// Start the timer
    pub fn start(&self) {
        self.enabled.store(true, Ordering::Relaxed);
    }

    /// Stop the timer
    pub fn stop(&self) {
        self.enabled.store(false, Ordering::Relaxed);
    }

    /// Check if timer is running
    pub fn is_running(&self) -> bool {
        self.enabled.load(Ordering::Relaxed)
    }

    /// Increment tick count
    #[cfg(target_pointer_width = "64")]
    pub fn tick(&self) {
        self.ticks.fetch_add(1, Ordering::Relaxed);
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn tick(&self) {
        let current = self.get_ticks();
        let new_value = current.wrapping_add(1);
        self.ticks_lo
            .store((new_value & 0xFFFFFFFF) as u32, Ordering::Relaxed);
        self.ticks_hi
            .store((new_value >> 32) as u32, Ordering::Relaxed);
    }

    /// Get current tick count
    #[cfg(target_pointer_width = "64")]
    pub fn get_ticks(&self) -> u64 {
        self.ticks.load(Ordering::Relaxed)
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn get_ticks(&self) -> u64 {
        let lo = self.ticks_lo.load(Ordering::Relaxed);
        let hi = self.ticks_hi.load(Ordering::Relaxed);
        ((hi as u64) << 32) | (lo as u64)
    }

    /// Set tick interval
    #[cfg(target_pointer_width = "64")]
    pub fn set_interval(&self, cycles: u64) {
        self.interval.store(cycles, Ordering::Relaxed);
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn set_interval(&self, cycles: u64) {
        self.interval_lo
            .store((cycles & 0xFFFFFFFF) as u32, Ordering::Relaxed);
        self.interval_hi
            .store((cycles >> 32) as u32, Ordering::Relaxed);
    }

    /// Get tick interval
    #[cfg(target_pointer_width = "64")]
    pub fn get_interval(&self) -> u64 {
        self.interval.load(Ordering::Relaxed)
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn get_interval(&self) -> u64 {
        let lo = self.interval_lo.load(Ordering::Relaxed);
        let hi = self.interval_hi.load(Ordering::Relaxed);
        ((hi as u64) << 32) | (lo as u64)
    }

    /// Reset the timer (for test cleanup)
    #[cfg(target_pointer_width = "64")]
    pub fn reset(&self) {
        self.ticks.store(0, Ordering::Relaxed);
        self.interval.store(1000, Ordering::Relaxed); // Reset to default
        self.enabled.store(false, Ordering::Relaxed);
    }

    #[cfg(not(target_pointer_width = "64"))]
    pub fn reset(&self) {
        self.ticks_lo.store(0, Ordering::Relaxed);
        self.ticks_hi.store(0, Ordering::Relaxed);
        self.interval_lo.store(1000, Ordering::Relaxed); // Reset to default
        self.interval_hi.store(0, Ordering::Relaxed);
        self.enabled.store(false, Ordering::Relaxed);
    }
}

/// Global mock timer instance
pub static MOCK_TIMER: MockTimer = MockTimer::new();

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mock_csr_default() {
        // Test the Default trait implementation for MockCsr
        let csr: MockCsr = Default::default();
        assert_eq!(csr.read_mstatus(), 0);
        assert!(!csr.interrupts_enabled());
        assert_eq!(csr.read_mcycle(), 0);
    }

    #[test]
    fn test_mock_csr_interrupts() {
        let csr = MockCsr::new();

        // Initially disabled
        assert!(!csr.interrupts_enabled());

        // Enable interrupts
        csr.enable_interrupts();
        assert!(csr.interrupts_enabled());

        // Disable interrupts
        csr.disable_interrupts();
        assert!(!csr.interrupts_enabled());
    }

    #[test]
    fn test_mock_csr_cycle_counter() {
        let csr = MockCsr::new();

        assert_eq!(csr.read_mcycle(), 0);

        csr.tick_cycles(100);
        assert_eq!(csr.read_mcycle(), 100);

        csr.tick_cycles(50);
        assert_eq!(csr.read_mcycle(), 150);
    }

    #[test]
    fn test_mock_csr_mcause_mtval() {
        // Test the machine cause and trap value registers
        let csr = MockCsr::new();

        // Initially zero
        assert_eq!(csr.read_mcause(), 0);
        assert_eq!(csr.read_mtval(), 0);

        // Write mcause (e.g., interrupt cause = 0x8000_0007 for machine timer interrupt)
        csr.write_mcause(0x8000_0007);
        assert_eq!(csr.read_mcause(), 0x8000_0007);

        // Write mtval (e.g., faulting address for memory exceptions)
        csr.write_mtval(0x1234_5678);
        assert_eq!(csr.read_mtval(), 0x1234_5678);

        // Overwrite with different values
        csr.write_mcause(0x0000_0002); // Illegal instruction exception
        csr.write_mtval(0xDEAD_BEEF);
        assert_eq!(csr.read_mcause(), 0x0000_0002);
        assert_eq!(csr.read_mtval(), 0xDEAD_BEEF);
    }

    #[test]
    fn test_mock_mmio() {
        let mmio = MockMmio::new(0x4000_0000);

        // Write and read
        mmio.write(0, 0x1234);
        assert_eq!(mmio.read(0), 0x1234);

        // Modify
        mmio.modify(0, |v| v | 0x8000);
        assert_eq!(mmio.read(0), 0x9234);
    }

    #[test]
    fn test_mock_mmio_out_of_bounds() {
        // Test MMIO out-of-bounds access behavior
        let mmio = MockMmio::new(0x4000_0000);

        // Out-of-bounds read should return 0
        assert_eq!(mmio.read(256), 0);
        assert_eq!(mmio.read(1000), 0);
        assert_eq!(mmio.read(usize::MAX), 0);

        // Out-of-bounds write should be silently ignored
        mmio.write(256, 0xDEAD_BEEF);
        mmio.write(1000, 0x1234_5678);
        // No panic, value is not stored

        // Out-of-bounds modify should be silently ignored
        mmio.modify(256, |v| v | 0x1234);
        mmio.modify(1000, |v| v.wrapping_add(1));
        // No panic, value is not modified

        // Verify boundary case: offset 255 is valid (last index)
        mmio.write(255, 0xCAFE_BABE);
        assert_eq!(mmio.read(255), 0xCAFE_BABE);
        mmio.modify(255, |v| v & 0xFFFF_0000);
        assert_eq!(mmio.read(255), 0xCAFE_0000);
    }

    #[test]
    fn test_mock_intc() {
        let intc = MockIntc::new();

        // Enable IRQ 5
        intc.enable(5);
        assert!(intc.is_enabled(5));

        // Trigger IRQ 5
        intc.trigger(5);
        assert!(intc.is_pending(5));
        assert_eq!(intc.get_fired_count(), 1);

        // Clear IRQ 5
        intc.clear(5);
        assert!(!intc.is_pending(5));

        // Reset
        intc.reset();
        assert!(!intc.is_enabled(5));
        assert_eq!(intc.get_fired_count(), 0);
    }

    #[test]
    fn test_mock_intc_disable() {
        // Test the disable function for MockIntc
        let intc = MockIntc::new();

        // Enable multiple IRQs
        intc.enable(0);
        intc.enable(3);
        intc.enable(7);
        intc.enable(31);

        assert!(intc.is_enabled(0));
        assert!(intc.is_enabled(3));
        assert!(intc.is_enabled(7));
        assert!(intc.is_enabled(31));

        // Disable some IRQs
        intc.disable(3);
        assert!(intc.is_enabled(0));
        assert!(!intc.is_enabled(3));  // Should be disabled now
        assert!(intc.is_enabled(7));
        assert!(intc.is_enabled(31));

        // Disable another
        intc.disable(7);
        assert!(intc.is_enabled(0));
        assert!(!intc.is_enabled(3));
        assert!(!intc.is_enabled(7));  // Should be disabled now
        assert!(intc.is_enabled(31));

        // Disable an already-disabled IRQ (should be no-op)
        intc.disable(3);
        assert!(!intc.is_enabled(3));

        // Disable all remaining
        intc.disable(0);
        intc.disable(31);
        assert!(!intc.is_enabled(0));
        assert!(!intc.is_enabled(31));
    }

    #[test]
    fn test_mock_intc_default() {
        // Test the Default trait implementation for MockIntc
        let intc: MockIntc = Default::default();
        assert_eq!(intc.get_fired_count(), 0);
        assert!(!intc.is_enabled(0));
        assert!(!intc.is_pending(0));
    }

    #[test]
    fn test_mock_timer() {
        let timer = MockTimer::new();

        // Initially stopped
        assert!(!timer.is_running());
        assert_eq!(timer.get_ticks(), 0);

        // Start and tick
        timer.start();
        assert!(timer.is_running());

        timer.tick();
        timer.tick();
        assert_eq!(timer.get_ticks(), 2);

        // Stop
        timer.stop();
        assert!(!timer.is_running());

        // Reset
        timer.reset();
        assert_eq!(timer.get_ticks(), 0);
    }

    #[test]
    fn test_mock_timer_default() {
        // Test the Default trait implementation for MockTimer
        let timer: MockTimer = Default::default();
        assert!(!timer.is_running());
        assert_eq!(timer.get_ticks(), 0);
        assert_eq!(timer.get_interval(), 1000); // Default interval
    }

    #[test]
    fn test_mock_timer_interval() {
        // Test timer interval get/set
        let timer = MockTimer::new();

        // Default interval
        assert_eq!(timer.get_interval(), 1000);

        // Set custom interval
        timer.set_interval(500);
        assert_eq!(timer.get_interval(), 500);

        // Set large interval (test 64-bit value handling)
        timer.set_interval(0xFFFF_FFFF_FFFF_FFFF);
        assert_eq!(timer.get_interval(), 0xFFFF_FFFF_FFFF_FFFF);

        // Reset should restore default interval
        timer.reset();
        assert_eq!(timer.get_interval(), 1000);
    }

    #[test]
    fn test_mock_timer_multiple_ticks() {
        // Test multiple ticks and potential overflow behavior
        let timer = MockTimer::new();

        // Tick many times
        for _ in 0..1000 {
            timer.tick();
        }
        assert_eq!(timer.get_ticks(), 1000);

        // Test tick count near u64::MAX (wrapping behavior)
        timer.reset();
        // Note: Can't test actual overflow without billions of ticks,
        // but we can verify the tick mechanism works correctly
        timer.tick();
        assert_eq!(timer.get_ticks(), 1);
    }
}
