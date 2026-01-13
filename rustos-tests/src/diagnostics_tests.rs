//! REQ: TEST-008 - Diagnostics unit tests
//!
//! Tests for runtime diagnostics and query APIs.

#![cfg(test)]

use crate::assert_test;
use std::sync::atomic::{AtomicU32, AtomicU64, Ordering};

extern crate std;

// ============================================================================
// Mock Diagnostics Implementation
// ============================================================================

/// Mock interrupt counters (32 IRQs)
static IRQ_COUNTERS: [AtomicU32; 32] = [
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
    AtomicU32::new(0),
];

/// Mock context switch counter
static CONTEXT_SWITCH_COUNT: AtomicU32 = AtomicU32::new(0);

/// Mock system uptime
static UPTIME_TICKS: AtomicU64 = AtomicU64::new(0);

/// Mock idle ticks
static IDLE_TICKS: AtomicU64 = AtomicU64::new(0);

/// Record interrupt occurrence (mock)
fn record_irq(irq_num: u8) {
    if (irq_num as usize) < IRQ_COUNTERS.len() {
        IRQ_COUNTERS[irq_num as usize].fetch_add(1, Ordering::Relaxed);
    }
}

/// Get interrupt count (mock)
fn irq_get_count(irq_num: u8) -> u32 {
    if (irq_num as usize) < IRQ_COUNTERS.len() {
        IRQ_COUNTERS[irq_num as usize].load(Ordering::Relaxed)
    } else {
        0
    }
}

/// Record context switch (mock)
fn record_context_switch() {
    CONTEXT_SWITCH_COUNT.fetch_add(1, Ordering::Relaxed);
}

/// Get context switch count (mock)
fn get_context_switch_count() -> u32 {
    CONTEXT_SWITCH_COUNT.load(Ordering::Relaxed)
}

/// Update uptime (mock)
fn tick_uptime() {
    UPTIME_TICKS.fetch_add(1, Ordering::Relaxed);
}

/// Update idle time (mock)
fn tick_idle() {
    IDLE_TICKS.fetch_add(1, Ordering::Relaxed);
}

/// Get CPU utilization (mock)
fn get_cpu_utilization() -> u8 {
    let uptime = UPTIME_TICKS.load(Ordering::Relaxed);
    let idle = IDLE_TICKS.load(Ordering::Relaxed);

    if uptime == 0 {
        return 0;
    }

    let busy = uptime - idle;
    ((busy * 100) / uptime) as u8
}

/// Reset mock state
fn reset_mock_state() {
    for counter in IRQ_COUNTERS.iter() {
        counter.store(0, Ordering::SeqCst);
    }
    CONTEXT_SWITCH_COUNT.store(0, Ordering::SeqCst);
    UPTIME_TICKS.store(0, Ordering::SeqCst);
    IDLE_TICKS.store(0, Ordering::SeqCst);
}

// ============================================================================
// Task Statistics Mock
// ============================================================================

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
struct TaskId(u32);

#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
struct TaskStats {
    task_id: TaskId,
    cpu_time: u32,
    schedule_count: u32,
    stack_used: usize,
    stack_peak: usize,
    stack_size: usize,
    preempt_count: u32,
    last_run_time: u32,
}

impl TaskStats {
    fn new(task_id: TaskId, stack_size: usize) -> Self {
        Self {
            task_id,
            cpu_time: 0,
            schedule_count: 0,
            stack_used: 0,
            stack_peak: 0,
            stack_size,
            preempt_count: 0,
            last_run_time: 0,
        }
    }

    fn record_schedule(&mut self) {
        self.schedule_count += 1;
    }

    fn record_cpu_time(&mut self, ticks: u32) {
        self.cpu_time += ticks;
        self.last_run_time = ticks;
    }

    fn update_stack_usage(&mut self, used: usize) {
        self.stack_used = used;
        if used > self.stack_peak {
            self.stack_peak = used;
        }
    }

    fn record_preemption(&mut self) {
        self.preempt_count += 1;
    }
}

// ============================================================================
// CPU Statistics Mock
// ============================================================================

#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
struct CpuStats {
    uptime_ticks: u64,
    idle_ticks: u64,
    utilization: u8,
    context_switches: u32,
    interrupt_count: u32,
}

impl CpuStats {
    fn snapshot() -> Self {
        let uptime = UPTIME_TICKS.load(Ordering::Relaxed);
        let idle = IDLE_TICKS.load(Ordering::Relaxed);
        let context_switches = CONTEXT_SWITCH_COUNT.load(Ordering::Relaxed);

        let interrupt_count: u32 = IRQ_COUNTERS.iter().map(|c| c.load(Ordering::Relaxed)).sum();

        Self {
            uptime_ticks: uptime,
            idle_ticks: idle,
            utilization: get_cpu_utilization(),
            context_switches,
            interrupt_count,
        }
    }
}

// ============================================================================
// Interrupt Statistics Mock
// ============================================================================

#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
struct InterruptStats {
    irq_number: u8,
    count: u32,
    service_time: u32,
    max_service_time: u32,
    avg_service_time: u32,
}

impl InterruptStats {
    fn new(irq_number: u8) -> Self {
        Self {
            irq_number,
            count: irq_get_count(irq_number),
            service_time: 0,
            max_service_time: 0,
            avg_service_time: 0,
        }
    }
}

// ============================================================================
// Diagnostics Tests
// ============================================================================

#[test]
fn test_irq_counter_basic() {
    // REQ: DIAG-004 - Query interrupt occurrence count
    reset_mock_state();

    assert_test!(irq_get_count(7) == 0, "IRQ count should be 0 initially");

    record_irq(7);
    assert_test!(
        irq_get_count(7) == 1,
        "IRQ count should be 1 after one interrupt"
    );

    record_irq(7);
    record_irq(7);
    assert_test!(
        irq_get_count(7) == 3,
        "IRQ count should be 3 after three interrupts"
    );
}

#[test]
fn test_irq_counter_multiple_irqs() {
    // Test multiple different IRQs
    reset_mock_state();

    record_irq(0); // Timer
    record_irq(0);
    record_irq(5); // UART
    record_irq(10); // SPI
    record_irq(10);
    record_irq(10);

    assert_test!(irq_get_count(0) == 2, "Timer IRQ count should be 2");
    assert_test!(irq_get_count(5) == 1, "UART IRQ count should be 1");
    assert_test!(irq_get_count(10) == 3, "SPI IRQ count should be 3");
    assert_test!(irq_get_count(15) == 0, "Unused IRQ count should be 0");
}

#[test]
fn test_irq_counter_boundary() {
    // Test IRQ number boundaries
    reset_mock_state();

    record_irq(0); // First valid
    record_irq(31); // Last valid

    assert_test!(irq_get_count(0) == 1, "First IRQ should be counted");
    assert_test!(irq_get_count(31) == 1, "Last IRQ should be counted");

    // Out of bounds should be ignored (not crash)
    record_irq(32); // Out of bounds
    record_irq(255); // Way out of bounds
}

#[test]
fn test_context_switch_counter() {
    // Test context switch counting
    reset_mock_state();

    assert_test!(
        get_context_switch_count() == 0,
        "Context switches should be 0 initially"
    );

    record_context_switch();
    assert_test!(
        get_context_switch_count() == 1,
        "Context switch count should be 1"
    );

    for _ in 0..100 {
        record_context_switch();
    }
    assert_test!(
        get_context_switch_count() == 101,
        "Context switch count should be 101"
    );
}

#[test]
fn test_cpu_utilization() {
    // Test CPU utilization calculation
    // Note: This test uses shared static state, so we test the logic in isolation

    // Test utility calculation function directly without touching global state
    fn calc_utilization(uptime: u64, idle: u64) -> u8 {
        if uptime == 0 {
            return 0;
        }
        let busy = uptime - idle;
        ((busy * 100) / uptime) as u8
    }

    // No time passed = 0% utilization
    assert_test!(
        calc_utilization(0, 0) == 0,
        "Utilization should be 0% with no time"
    );

    // 100% busy (no idle)
    assert_test!(
        calc_utilization(100, 0) == 100,
        "Utilization should be 100% when always busy"
    );

    // 50% busy (half idle)
    assert_test!(calc_utilization(100, 50) == 50, "Utilization should be 50%");

    // 25% busy (75% idle)
    assert_test!(calc_utilization(100, 75) == 25, "Utilization should be 25%");

    // 0% busy (all idle)
    assert_test!(
        calc_utilization(100, 100) == 0,
        "Utilization should be 0% when all idle"
    );
}

#[test]
fn test_task_stats_basic() {
    // REQ: DIAG-001 - Per-task statistics
    let stats = TaskStats::new(TaskId(1), 2048);

    assert_test!(stats.task_id == TaskId(1), "Task ID should match");
    assert_test!(stats.stack_size == 2048, "Stack size should be 2048");
    assert_test!(stats.cpu_time == 0, "CPU time should be 0 initially");
    assert_test!(
        stats.schedule_count == 0,
        "Schedule count should be 0 initially"
    );
}

#[test]
fn test_task_stats_scheduling() {
    // Test schedule tracking
    let mut stats = TaskStats::new(TaskId(1), 2048);

    stats.record_schedule();
    assert_test!(stats.schedule_count == 1, "Schedule count should be 1");

    for _ in 0..10 {
        stats.record_schedule();
    }
    assert_test!(stats.schedule_count == 11, "Schedule count should be 11");
}

#[test]
fn test_task_stats_cpu_time() {
    // Test CPU time tracking
    let mut stats = TaskStats::new(TaskId(1), 2048);

    stats.record_cpu_time(100);
    assert_test!(stats.cpu_time == 100, "CPU time should be 100");
    assert_test!(stats.last_run_time == 100, "Last run time should be 100");

    stats.record_cpu_time(50);
    assert_test!(stats.cpu_time == 150, "CPU time should be 150 (cumulative)");
    assert_test!(stats.last_run_time == 50, "Last run time should be 50");
}

#[test]
fn test_task_stats_stack_usage() {
    // REQ: DIAG-005 - Query task stack usage
    let mut stats = TaskStats::new(TaskId(1), 2048);

    stats.update_stack_usage(500);
    assert_test!(stats.stack_used == 500, "Stack used should be 500");
    assert_test!(stats.stack_peak == 500, "Stack peak should be 500");

    stats.update_stack_usage(800);
    assert_test!(stats.stack_used == 800, "Stack used should be 800");
    assert_test!(stats.stack_peak == 800, "Stack peak should be 800");

    // Lower usage shouldn't lower peak
    stats.update_stack_usage(300);
    assert_test!(stats.stack_used == 300, "Stack used should be 300");
    assert_test!(stats.stack_peak == 800, "Stack peak should still be 800");
}

#[test]
fn test_task_stats_preemption() {
    // Test preemption tracking
    let mut stats = TaskStats::new(TaskId(1), 2048);

    stats.record_preemption();
    assert_test!(stats.preempt_count == 1, "Preempt count should be 1");

    for _ in 0..5 {
        stats.record_preemption();
    }
    assert_test!(stats.preempt_count == 6, "Preempt count should be 6");
}

#[test]
fn test_cpu_stats_snapshot() {
    // REQ: DIAG-002 - System-wide CPU statistics
    reset_mock_state();

    // Setup some activity
    for _ in 0..1000 {
        tick_uptime();
    }
    for _ in 0..250 {
        tick_idle();
    }
    for _ in 0..50 {
        record_context_switch();
    }
    record_irq(0);
    record_irq(5);
    record_irq(5);

    let stats = CpuStats::snapshot();

    assert_test!(stats.uptime_ticks == 1000, "Uptime should be 1000");
    assert_test!(stats.idle_ticks == 250, "Idle ticks should be 250");
    assert_test!(stats.utilization == 75, "Utilization should be 75%");
    assert_test!(
        stats.context_switches == 50,
        "Context switches should be 50"
    );
    assert_test!(stats.interrupt_count == 3, "Total interrupts should be 3");
}

#[test]
fn test_interrupt_stats() {
    // REQ: DIAG-004 - Interrupt statistics
    reset_mock_state();

    record_irq(7);
    record_irq(7);
    record_irq(7);

    let stats = InterruptStats::new(7);

    assert_test!(stats.irq_number == 7, "IRQ number should be 7");
    assert_test!(stats.count == 3, "Count should be 3");
}

#[test]
fn test_diagnostics_concurrent() {
    // REQ: DIAG-006 - Non-blocking from ISR context
    // Test that concurrent access to atomics doesn't cause issues
    // Uses local counters to avoid interference from parallel tests

    use std::sync::atomic::AtomicU32;
    use std::sync::Arc;
    use std::thread;

    // Use thread-local counters for this test
    let counters: Arc<[AtomicU32; 8]> = Arc::new([
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
        AtomicU32::new(0),
    ]);

    let mut handles = vec![];

    // Simulate concurrent ISR and diagnostic queries
    for i in 0..10 {
        let irq_num = (i % 8) as usize;
        let counters_clone = Arc::clone(&counters);
        handles.push(thread::spawn(move || {
            for _ in 0..100 {
                counters_clone[irq_num].fetch_add(1, Ordering::SeqCst);
                let _ = counters_clone[irq_num].load(Ordering::SeqCst); // Query shouldn't block
            }
        }));
    }

    for handle in handles {
        handle.join().unwrap();
    }

    // All IRQs should have been counted - each thread does 100 iterations
    let total: u32 = counters.iter().map(|c| c.load(Ordering::SeqCst)).sum();
    // 10 threads, 100 iterations each = 1000 total
    assert_test!(
        total == 1000,
        format!("Total IRQ count should be 1000, got {}", total)
    );
}

// ============================================================================
// Memory Statistics Mock
// ============================================================================

#[derive(Debug, Clone, Copy)]
#[allow(dead_code)]
struct MemoryStats {
    total_ram: usize,
    used_ram: usize,
    free_ram: usize,
    largest_free_block: usize,
}

impl MemoryStats {
    fn mock() -> Self {
        Self {
            total_ram: 128 * 1024,         // 128KB
            used_ram: 32 * 1024,           // 32KB used
            free_ram: 96 * 1024,           // 96KB free
            largest_free_block: 64 * 1024, // Largest contiguous
        }
    }
}

#[test]
fn test_memory_stats() {
    let stats = MemoryStats::mock();

    assert_test!(stats.total_ram == 128 * 1024, "Total RAM should be 128KB");
    assert_test!(
        stats.used_ram + stats.free_ram == stats.total_ram,
        "Used + Free should equal Total"
    );
    assert_test!(
        stats.largest_free_block <= stats.free_ram,
        "Largest block should be <= free RAM"
    );
}
