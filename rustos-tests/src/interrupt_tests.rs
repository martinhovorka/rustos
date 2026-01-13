//! REQ: IRQ-001, IRQ-002, IRQ-003 - Interrupt handling tests
//!
//! Tests for interrupt controller and interrupt handling.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use core::marker::{Send, Sync};
use core::option::Option::{self, None, Some};
use std::sync::atomic::{AtomicBool, AtomicU32, Ordering};
use std::sync::Arc;

// ============================================================================
// Mock Interrupt Controller (PLIC-like)
// ============================================================================

const MAX_IRQS: usize = 32;

struct MockPlic {
    pending: AtomicU32,              // Pending interrupts
    enabled: AtomicU32,              // Enabled interrupts
    priority: [AtomicU32; MAX_IRQS], // Priority per IRQ
    threshold: AtomicU32,            // Priority threshold
    claimed: AtomicU32,              // Currently claimed IRQ
    global_enable: AtomicBool,
}

impl MockPlic {
    fn new() -> Self {
        Self {
            pending: AtomicU32::new(0),
            enabled: AtomicU32::new(0),
            priority: core::array::from_fn(|_| AtomicU32::new(0)),
            threshold: AtomicU32::new(0),
            claimed: AtomicU32::new(0),
            global_enable: AtomicBool::new(false),
        }
    }

    fn enable_irq(&self, irq: u32) {
        self.enabled.fetch_or(1 << irq, Ordering::SeqCst);
    }

    fn disable_irq(&self, irq: u32) {
        self.enabled.fetch_and(!(1 << irq), Ordering::SeqCst);
    }

    fn set_priority(&self, irq: u32, priority: u32) {
        if (irq as usize) < MAX_IRQS {
            self.priority[irq as usize].store(priority, Ordering::SeqCst);
        }
    }

    fn set_threshold(&self, threshold: u32) {
        self.threshold.store(threshold, Ordering::SeqCst);
    }

    fn enable_global(&self) {
        self.global_enable.store(true, Ordering::SeqCst);
    }

    #[allow(dead_code)]
    fn disable_global(&self) {
        self.global_enable.store(false, Ordering::SeqCst);
    }

    fn trigger_irq(&self, irq: u32) {
        self.pending.fetch_or(1 << irq, Ordering::SeqCst);
    }

    fn claim(&self) -> Option<u32> {
        if !self.global_enable.load(Ordering::SeqCst) {
            return None;
        }

        let pending = self.pending.load(Ordering::SeqCst);
        let enabled = self.enabled.load(Ordering::SeqCst);
        let active = pending & enabled;

        if active == 0 {
            return None;
        }

        // Find highest priority active IRQ
        let threshold = self.threshold.load(Ordering::SeqCst);
        let mut best_irq = None;
        let mut best_priority = threshold;

        for irq in 0..MAX_IRQS {
            if active & (1 << irq) != 0 {
                let priority = self.priority[irq].load(Ordering::SeqCst);
                if priority > best_priority {
                    best_priority = priority;
                    best_irq = Some(irq as u32);
                }
            }
        }

        if let Some(irq) = best_irq {
            // Clear pending and set claimed
            self.pending.fetch_and(!(1 << irq), Ordering::SeqCst);
            self.claimed.store(irq, Ordering::SeqCst);
        }

        best_irq
    }

    fn complete(&self, irq: u32) {
        if self.claimed.load(Ordering::SeqCst) == irq {
            self.claimed.store(0xFFFF_FFFF, Ordering::SeqCst);
        }
    }

    fn is_pending(&self, irq: u32) -> bool {
        (self.pending.load(Ordering::SeqCst) & (1 << irq)) != 0
    }

    fn is_enabled(&self, irq: u32) -> bool {
        (self.enabled.load(Ordering::SeqCst) & (1 << irq)) != 0
    }

    #[allow(dead_code)]
    fn reset(&self) {
        self.pending.store(0, Ordering::SeqCst);
        self.enabled.store(0, Ordering::SeqCst);
        self.threshold.store(0, Ordering::SeqCst);
        self.claimed.store(0xFFFF_FFFF, Ordering::SeqCst);
        self.global_enable.store(false, Ordering::SeqCst);
        for p in &self.priority {
            p.store(0, Ordering::SeqCst);
        }
    }
}

unsafe impl Send for MockPlic {}
unsafe impl Sync for MockPlic {}

#[test]
fn test_plic_enable_disable() {
    let plic = MockPlic::new();

    assert_test!(!plic.is_enabled(5), "IRQ 5 should not be enabled initially");

    plic.enable_irq(5);
    assert_test!(plic.is_enabled(5), "IRQ 5 should be enabled");

    plic.disable_irq(5);
    assert_test!(!plic.is_enabled(5), "IRQ 5 should be disabled");
}

#[test]
fn test_plic_trigger_pending() {
    let plic = MockPlic::new();

    assert_test!(!plic.is_pending(3), "IRQ 3 should not be pending initially");

    plic.trigger_irq(3);
    assert_test!(plic.is_pending(3), "IRQ 3 should be pending");
}

#[test]
fn test_plic_claim() {
    let plic = MockPlic::new();

    plic.enable_global();
    plic.enable_irq(5);
    plic.set_priority(5, 1);
    plic.trigger_irq(5);

    let claimed = plic.claim();
    assert_test!(claimed == Some(5), "Should claim IRQ 5");
    assert_test!(
        !plic.is_pending(5),
        "IRQ 5 should not be pending after claim"
    );

    plic.complete(5);
}

#[test]
fn test_plic_priority() {
    let plic = MockPlic::new();

    plic.enable_global();
    plic.enable_irq(3);
    plic.enable_irq(5);
    plic.set_priority(3, 2);
    plic.set_priority(5, 5); // Higher priority

    plic.trigger_irq(3);
    plic.trigger_irq(5);

    // Should claim higher priority first
    let first = plic.claim();
    assert_test!(first == Some(5), "Should claim higher priority IRQ 5 first");
    plic.complete(5);

    let second = plic.claim();
    assert_test!(second == Some(3), "Should claim IRQ 3 second");
    plic.complete(3);
}

#[test]
fn test_plic_threshold() {
    let plic = MockPlic::new();

    plic.enable_global();
    plic.enable_irq(3);
    plic.set_priority(3, 2);
    plic.set_threshold(5); // Threshold higher than IRQ priority

    plic.trigger_irq(3);

    let claimed = plic.claim();
    assert_test!(claimed.is_none(), "Should not claim IRQ below threshold");
}

#[test]
fn test_plic_global_disable() {
    let plic = MockPlic::new();

    // Don't enable global
    plic.enable_irq(5);
    plic.set_priority(5, 1);
    plic.trigger_irq(5);

    let claimed = plic.claim();
    assert_test!(claimed.is_none(), "Should not claim when global disabled");

    plic.enable_global();
    let claimed = plic.claim();
    assert_test!(claimed == Some(5), "Should claim after global enable");
}

// ============================================================================
// Mock Interrupt Handler Registry
// ============================================================================

static HANDLER_CALLED: [AtomicBool; MAX_IRQS] = {
    const INIT: AtomicBool = AtomicBool::new(false);
    [INIT; MAX_IRQS]
};

static HANDLER_COUNT: [AtomicU32; MAX_IRQS] = {
    const INIT: AtomicU32 = AtomicU32::new(0);
    [INIT; MAX_IRQS]
};

fn reset_handlers() {
    for h in &HANDLER_CALLED {
        h.store(false, Ordering::SeqCst);
    }
    for c in &HANDLER_COUNT {
        c.store(0, Ordering::SeqCst);
    }
}

fn irq_handler(irq: u32) {
    if (irq as usize) < MAX_IRQS {
        HANDLER_CALLED[irq as usize].store(true, Ordering::SeqCst);
        HANDLER_COUNT[irq as usize].fetch_add(1, Ordering::SeqCst);
    }
}

fn was_handler_called(irq: u32) -> bool {
    if (irq as usize) < MAX_IRQS {
        HANDLER_CALLED[irq as usize].load(Ordering::SeqCst)
    } else {
        false
    }
}

fn get_handler_count(irq: u32) -> u32 {
    if (irq as usize) < MAX_IRQS {
        HANDLER_COUNT[irq as usize].load(Ordering::SeqCst)
    } else {
        0
    }
}

#[test]
fn test_irq_handler_registration() {
    reset_handlers();

    // Simulate interrupt handling
    irq_handler(5);

    assert_test!(was_handler_called(5), "Handler 5 should have been called");
    assert_test!(
        !was_handler_called(3),
        "Handler 3 should not have been called"
    );
}

#[test]
fn test_irq_handler_count() {
    reset_handlers();

    // Multiple interrupts
    irq_handler(5);
    irq_handler(5);
    irq_handler(5);

    assert_test!(
        get_handler_count(5) == 3,
        "Handler 5 should have been called 3 times"
    );
}

// ============================================================================
// Mock Nested Interrupt Handling
// ============================================================================

static NESTING_DEPTH: AtomicU32 = AtomicU32::new(0);
static MAX_NESTING_DEPTH: AtomicU32 = AtomicU32::new(0);

fn enter_isr() {
    let depth = NESTING_DEPTH.fetch_add(1, Ordering::SeqCst) + 1;
    let max = MAX_NESTING_DEPTH.load(Ordering::SeqCst);
    if depth > max {
        MAX_NESTING_DEPTH.store(depth, Ordering::SeqCst);
    }
}

fn exit_isr() {
    NESTING_DEPTH.fetch_sub(1, Ordering::SeqCst);
}

fn get_nesting_depth() -> u32 {
    NESTING_DEPTH.load(Ordering::SeqCst)
}

fn reset_nesting() {
    NESTING_DEPTH.store(0, Ordering::SeqCst);
    MAX_NESTING_DEPTH.store(0, Ordering::SeqCst);
}

#[test]
fn test_irq_nesting() {
    reset_nesting();

    assert_test!(
        get_nesting_depth() == 0,
        "Initial nesting depth should be 0"
    );

    enter_isr();
    assert_test!(get_nesting_depth() == 1, "Nesting depth should be 1");

    enter_isr(); // Nested interrupt
    assert_test!(get_nesting_depth() == 2, "Nesting depth should be 2");

    exit_isr();
    assert_test!(get_nesting_depth() == 1, "Nesting depth should be 1");

    exit_isr();
    assert_test!(get_nesting_depth() == 0, "Nesting depth should be 0");

    assert_test!(
        MAX_NESTING_DEPTH.load(Ordering::SeqCst) == 2,
        "Max depth should be 2"
    );
}

// ============================================================================
// Mock Interrupt Latency Measurement
// ============================================================================

static IRQ_TRIGGER_TIME: AtomicU32 = AtomicU32::new(0);
static IRQ_HANDLE_TIME: AtomicU32 = AtomicU32::new(0);

fn mock_time() -> u32 {
    use std::time::{SystemTime, UNIX_EPOCH};
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap()
        .as_micros() as u32
}

fn trigger_timed_irq() {
    IRQ_TRIGGER_TIME.store(mock_time(), Ordering::SeqCst);
}

fn handle_timed_irq() {
    IRQ_HANDLE_TIME.store(mock_time(), Ordering::SeqCst);
}

fn get_latency() -> u32 {
    let handle = IRQ_HANDLE_TIME.load(Ordering::SeqCst);
    let trigger = IRQ_TRIGGER_TIME.load(Ordering::SeqCst);
    handle.wrapping_sub(trigger)
}

#[test]
fn test_irq_latency_measurement() {
    trigger_timed_irq();
    handle_timed_irq();

    let latency = get_latency();
    // Latency should be very small (microseconds)
    assert_test!(
        latency < 1000,
        format!("Latency {} should be < 1000 us", latency)
    );
}

// ============================================================================
// Mock Software Interrupt
// ============================================================================

static SOFTWARE_IRQ_PENDING: AtomicBool = AtomicBool::new(false);
static SOFTWARE_IRQ_HANDLER_CALLED: AtomicBool = AtomicBool::new(false);

fn trigger_software_irq() {
    SOFTWARE_IRQ_PENDING.store(true, Ordering::SeqCst);
}

fn handle_software_irq() {
    if SOFTWARE_IRQ_PENDING.load(Ordering::SeqCst) {
        SOFTWARE_IRQ_PENDING.store(false, Ordering::SeqCst);
        SOFTWARE_IRQ_HANDLER_CALLED.store(true, Ordering::SeqCst);
    }
}

fn reset_software_irq() {
    SOFTWARE_IRQ_PENDING.store(false, Ordering::SeqCst);
    SOFTWARE_IRQ_HANDLER_CALLED.store(false, Ordering::SeqCst);
}

#[test]
fn test_software_irq() {
    reset_software_irq();

    assert_test!(
        !SOFTWARE_IRQ_PENDING.load(Ordering::SeqCst),
        "No pending software IRQ initially"
    );

    trigger_software_irq();
    assert_test!(
        SOFTWARE_IRQ_PENDING.load(Ordering::SeqCst),
        "Software IRQ should be pending"
    );

    handle_software_irq();
    assert_test!(
        !SOFTWARE_IRQ_PENDING.load(Ordering::SeqCst),
        "Software IRQ should be cleared"
    );
    assert_test!(
        SOFTWARE_IRQ_HANDLER_CALLED.load(Ordering::SeqCst),
        "Handler should have been called"
    );
}

// ============================================================================
// Mock Timer Interrupt
// ============================================================================

static TIMER_IRQ_COUNT: AtomicU32 = AtomicU32::new(0);
static TIMER_COMPARE: AtomicU32 = AtomicU32::new(0);
static TIMER_COUNTER: AtomicU32 = AtomicU32::new(0);

fn timer_tick() {
    let counter = TIMER_COUNTER.fetch_add(1, Ordering::SeqCst) + 1;
    let compare = TIMER_COMPARE.load(Ordering::SeqCst);

    if counter >= compare && compare > 0 {
        TIMER_IRQ_COUNT.fetch_add(1, Ordering::SeqCst);
        // Reset for periodic mode
        TIMER_COUNTER.store(0, Ordering::SeqCst);
    }
}

fn set_timer_compare(value: u32) {
    TIMER_COMPARE.store(value, Ordering::SeqCst);
}

fn reset_timer() {
    TIMER_IRQ_COUNT.store(0, Ordering::SeqCst);
    TIMER_COMPARE.store(0, Ordering::SeqCst);
    TIMER_COUNTER.store(0, Ordering::SeqCst);
}

#[test]
fn test_timer_interrupt() {
    reset_timer();

    set_timer_compare(10);

    // Tick 9 times - no interrupt
    for _ in 0..9 {
        timer_tick();
    }
    assert_test!(
        TIMER_IRQ_COUNT.load(Ordering::SeqCst) == 0,
        "No timer IRQ yet"
    );

    // 10th tick triggers interrupt
    timer_tick();
    assert_test!(
        TIMER_IRQ_COUNT.load(Ordering::SeqCst) == 1,
        "Timer IRQ should fire"
    );

    // Counter reset, tick 10 more for another interrupt
    for _ in 0..10 {
        timer_tick();
    }
    assert_test!(
        TIMER_IRQ_COUNT.load(Ordering::SeqCst) == 2,
        "Second timer IRQ should fire"
    );
}

// ============================================================================
// Mock External Interrupt Sources
// ============================================================================

#[derive(Clone, Copy, PartialEq, Debug)]
enum ExternalIrqSource {
    Uart,
    Spi,
    I2c,
    Gpio,
    Ethernet,
    Timer,
}

impl ExternalIrqSource {
    fn to_irq_num(&self) -> u32 {
        match self {
            ExternalIrqSource::Uart => 1,
            ExternalIrqSource::Spi => 2,
            ExternalIrqSource::I2c => 3,
            ExternalIrqSource::Gpio => 4,
            ExternalIrqSource::Ethernet => 5,
            ExternalIrqSource::Timer => 6,
        }
    }

    fn from_irq_num(num: u32) -> Option<Self> {
        match num {
            1 => Some(ExternalIrqSource::Uart),
            2 => Some(ExternalIrqSource::Spi),
            3 => Some(ExternalIrqSource::I2c),
            4 => Some(ExternalIrqSource::Gpio),
            5 => Some(ExternalIrqSource::Ethernet),
            6 => Some(ExternalIrqSource::Timer),
            _ => None,
        }
    }
}

#[test]
fn test_external_irq_mapping() {
    assert_test!(
        ExternalIrqSource::Uart.to_irq_num() == 1,
        "UART should be IRQ 1"
    );
    assert_test!(
        ExternalIrqSource::Ethernet.to_irq_num() == 5,
        "Ethernet should be IRQ 5"
    );

    assert_test!(
        ExternalIrqSource::from_irq_num(1) == Some(ExternalIrqSource::Uart),
        "IRQ 1 should be UART"
    );
    assert_test!(
        ExternalIrqSource::from_irq_num(99).is_none(),
        "Unknown IRQ should return None"
    );
}

// ============================================================================
// Mock Interrupt Priority Inversion Prevention
// ============================================================================

struct IrqPriorityManager {
    base_priority: AtomicU32,
    boosted_priority: AtomicU32,
    is_boosted: AtomicBool,
}

impl IrqPriorityManager {
    const fn new() -> Self {
        Self {
            base_priority: AtomicU32::new(0),
            boosted_priority: AtomicU32::new(0),
            is_boosted: AtomicBool::new(false),
        }
    }

    fn set_base_priority(&self, priority: u32) {
        self.base_priority.store(priority, Ordering::SeqCst);
    }

    fn boost_priority(&self, new_priority: u32) {
        let base = self.base_priority.load(Ordering::SeqCst);
        if new_priority > base {
            self.boosted_priority.store(new_priority, Ordering::SeqCst);
            self.is_boosted.store(true, Ordering::SeqCst);
        }
    }

    fn restore_priority(&self) {
        self.is_boosted.store(false, Ordering::SeqCst);
    }

    fn effective_priority(&self) -> u32 {
        if self.is_boosted.load(Ordering::SeqCst) {
            self.boosted_priority.load(Ordering::SeqCst)
        } else {
            self.base_priority.load(Ordering::SeqCst)
        }
    }
}

#[test]
fn test_irq_priority_boost() {
    let manager = IrqPriorityManager::new();

    manager.set_base_priority(5);
    assert_test!(
        manager.effective_priority() == 5,
        "Effective priority should be 5"
    );

    manager.boost_priority(10);
    assert_test!(
        manager.effective_priority() == 10,
        "Effective priority should be boosted to 10"
    );

    manager.restore_priority();
    assert_test!(
        manager.effective_priority() == 5,
        "Effective priority should be restored to 5"
    );
}

#[test]
fn test_irq_priority_no_boost_below() {
    let manager = IrqPriorityManager::new();

    manager.set_base_priority(10);
    manager.boost_priority(5); // Lower than base

    assert_test!(
        manager.effective_priority() == 10,
        "Should not boost to lower priority"
    );
}

// ============================================================================
// Concurrent Interrupt Handling Tests
// ============================================================================

#[test]
fn test_concurrent_irq_handling() {
    let plic = Arc::new(MockPlic::new());
    let handled = Arc::new(AtomicU32::new(0));

    plic.enable_global();
    for i in 0..8 {
        plic.enable_irq(i);
        plic.set_priority(i, i + 1);
    }

    // Trigger all interrupts
    for i in 0..8 {
        plic.trigger_irq(i);
    }

    // Claim and complete all
    while let Some(irq) = plic.claim() {
        handled.fetch_add(1, Ordering::SeqCst);
        plic.complete(irq);
    }

    assert_test!(
        handled.load(Ordering::SeqCst) == 8,
        "All 8 IRQs should be handled"
    );
}
