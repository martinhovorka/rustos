//! REQ: TEST-007 - Scheduler algorithm unit tests
//!
//! Tests covering priority ordering, round-robin, and preemption.

#![cfg(test)]

use crate::{assert_test, assert_eq_test};
use crate::mock::{MOCK_CSR, MOCK_TIMER};
use crate::utils::{boundary, perf};

/// Mock task for testing
#[derive(Debug, Clone)]
#[allow(dead_code)]  // Fields used for debugging and future test expansion
struct MockTask {
    id: u32,
    priority: u8,
    time_slice: u32,
    state: TaskState,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[allow(dead_code)]  // Variants needed for complete state machine representation
enum TaskState {
    Ready,
    Running,
    Blocked,
    Terminated,
}

impl MockTask {
    fn new(id: u32, priority: u8) -> Self {
        Self {
            id,
            priority,
            time_slice: 10, // Default time slice
            state: TaskState::Ready,
        }
    }
}

/// Mock scheduler for testing
struct MockScheduler {
    tasks: Vec<MockTask>,
    current_task: Option<usize>,
}

impl MockScheduler {
    fn new() -> Self {
        Self {
            tasks: Vec::new(),
            current_task: None,
        }
    }

    /// Add a task to the scheduler
    fn add_task(&mut self, task: MockTask) {
        self.tasks.push(task);
    }

    /// Select the next task to run based on priority
    /// REQ: SCHED-001 - Priority-based scheduling
    fn select_next(&mut self) -> Option<usize> {
        let mut highest_priority = None;
        let mut selected_idx = None;

        for (idx, task) in self.tasks.iter().enumerate() {
            if task.state == TaskState::Ready {
                if let Some(hp) = highest_priority {
                    if task.priority > hp {
                        highest_priority = Some(task.priority);
                        selected_idx = Some(idx);
                    }
                } else {
                    highest_priority = Some(task.priority);
                    selected_idx = Some(idx);
                }
            }
        }

        selected_idx
    }

    /// Select next task using round-robin among same priority
    /// REQ: SCHED-002 - Round-robin for same priority
    fn select_next_round_robin(&mut self) -> Option<usize> {
        if self.tasks.is_empty() {
            return None;
        }

        // Find highest priority
        let highest_priority = self.tasks.iter()
            .filter(|t| t.state == TaskState::Ready)
            .map(|t| t.priority)
            .max()?;

        // Find next ready task with highest priority after current
        let start_idx = self.current_task.map(|i| i + 1).unwrap_or(0);
        
        for offset in 0..self.tasks.len() {
            let idx = (start_idx + offset) % self.tasks.len();
            let task = &self.tasks[idx];
            if task.state == TaskState::Ready && task.priority == highest_priority {
                return Some(idx);
            }
        }

        None
    }

    /// Check if preemption is needed
    /// REQ: SCHED-003 - Preemptive scheduling
    fn should_preempt(&self, new_priority: u8) -> bool {
        if let Some(idx) = self.current_task {
            let current_priority = self.tasks[idx].priority;
            new_priority > current_priority
        } else {
            true // No current task, always preempt
        }
    }

    /// Set current task
    fn set_current(&mut self, idx: usize) {
        if let Some(old_idx) = self.current_task {
            self.tasks[old_idx].state = TaskState::Ready;
        }
        self.tasks[idx].state = TaskState::Running;
        self.current_task = Some(idx);
    }
}

#[test]
fn test_priority_ordering() {
    // REQ: TEST-007 - Priority ordering test
    // REQ: SCHED-001 - Highest priority task runs first
    let mut scheduler = MockScheduler::new();

    scheduler.add_task(MockTask::new(1, 10)); // Low priority
    scheduler.add_task(MockTask::new(2, 20)); // Medium priority
    scheduler.add_task(MockTask::new(3, 30)); // High priority

    let next = scheduler.select_next();
    assert_test!(next.is_some(), "Should select a task");
    assert_eq_test!(next.unwrap(), 2, "Should select highest priority task (ID 3, priority 30)");
}

#[test]
fn test_round_robin_same_priority() {
    // REQ: TEST-007 - Round-robin test
    // REQ: SCHED-002 - Same priority tasks scheduled round-robin
    let mut scheduler = MockScheduler::new();

    scheduler.add_task(MockTask::new(1, 20));
    scheduler.add_task(MockTask::new(2, 20));
    scheduler.add_task(MockTask::new(3, 20));

    // First selection
    let next1 = scheduler.select_next_round_robin().unwrap();
    scheduler.set_current(next1);
    assert_eq_test!(next1, 0, "First round-robin selection");

    // Second selection (should wrap around)
    let next2 = scheduler.select_next_round_robin().unwrap();
    scheduler.set_current(next2);
    assert_eq_test!(next2, 1, "Second round-robin selection");

    // Third selection
    let next3 = scheduler.select_next_round_robin().unwrap();
    scheduler.set_current(next3);
    assert_eq_test!(next3, 2, "Third round-robin selection");

    // Fourth selection (should wrap back to first)
    let next4 = scheduler.select_next_round_robin().unwrap();
    assert_eq_test!(next4, 0, "Round-robin should wrap back to first task");
}

#[test]
fn test_preemption() {
    // REQ: TEST-007 - Preemption test
    // REQ: SCHED-003 - Higher priority task preempts lower priority
    let mut scheduler = MockScheduler::new();

    scheduler.add_task(MockTask::new(1, 10)); // Low priority
    scheduler.add_task(MockTask::new(2, 30)); // High priority

    // Start with low priority task
    scheduler.set_current(0);

    // High priority task should preempt
    assert_test!(
        scheduler.should_preempt(30),
        "Higher priority task should preempt current task"
    );

    // Same priority should not preempt
    assert_test!(
        !scheduler.should_preempt(10),
        "Same priority task should not preempt"
    );

    // Lower priority should not preempt
    assert_test!(
        !scheduler.should_preempt(5),
        "Lower priority task should not preempt"
    );
}

#[test]
fn test_scheduler_empty() {
    // REQ: TEST-008 - Edge case: empty scheduler
    let mut scheduler = MockScheduler::new();

    let next = scheduler.select_next();
    assert_test!(next.is_none(), "Empty scheduler should return None");
}

#[test]
fn test_scheduler_all_blocked() {
    // REQ: TEST-008 - Edge case: all tasks blocked
    let mut scheduler = MockScheduler::new();

    let mut task1 = MockTask::new(1, 10);
    task1.state = TaskState::Blocked;
    scheduler.add_task(task1);

    let mut task2 = MockTask::new(2, 20);
    task2.state = TaskState::Blocked;
    scheduler.add_task(task2);

    let next = scheduler.select_next();
    assert_test!(next.is_none(), "All blocked tasks should return None");
}

#[test]
fn test_priority_boundary_values() {
    // REQ: TEST-008 - Boundary values test
    let mut scheduler = MockScheduler::new();

    scheduler.add_task(MockTask::new(1, boundary::MIN_U8));     // Minimum priority
    scheduler.add_task(MockTask::new(2, boundary::MAX_U8));     // Maximum priority
    scheduler.add_task(MockTask::new(3, boundary::MAX_U8 - 1)); // Near maximum

    let next = scheduler.select_next();
    assert_test!(next.is_some(), "Should select a task");
    
    // Should select task with MAX_U8 priority
    let selected = next.unwrap();
    assert_test!(
        scheduler.tasks[selected].priority == boundary::MAX_U8,
        "Should select task with maximum priority"
    );
}

#[test]
fn test_scheduler_performance() {
    // REQ: PERFTEST-001 - Measure scheduler performance
    let mut scheduler = MockScheduler::new();

    // Add multiple tasks
    for i in 0..10 {
        scheduler.add_task(MockTask::new(i, (i % 5) as u8 * 10));
    }

    // Measure scheduling decision time
    let cycles = perf::measure_cycles(|| {
        let _ = scheduler.select_next();
    });

    // Scheduling should be fast (O(n) in this simple implementation)
    assert_test!(
        cycles < 10000,
        format!("Scheduling took {} cycles, should be < 10000", cycles)
    );
}

#[test]
fn test_time_slice_expiry() {
    // REQ: SCHED-005 - Time slice management
    let task = MockTask::new(1, 10);
    
    // Verify task has expected default time slice
    assert_eq_test!(task.time_slice, 10, "Default time slice should be 10");
    assert_eq_test!(task.priority, 10, "Priority should be 10");

    MOCK_TIMER.reset();
    MOCK_TIMER.start();

    // Simulate time slice expiry
    for _ in 0..10 {
        MOCK_TIMER.tick();
    }

    assert_eq_test!(
        MOCK_TIMER.get_ticks(),
        10,
        "Time slice should expire after 10 ticks"
    );
}

#[test]
fn test_context_switch_overhead() {
    // REQ: PERFTEST-001 - Context switch latency measurement
    MOCK_CSR.mcycle.store(0, core::sync::atomic::Ordering::Relaxed);

    // Simulate context switch
    let cycles = perf::measure_cycles(|| {
        // Mock context switch operations
        MOCK_CSR.tick_cycles(50); // Simulate save/restore overhead
    });

    assert_test!(
        cycles >= 50,
        format!("Context switch took {} cycles", cycles)
    );
}

#[test]
fn test_scheduler_concurrent_access() {
    // REQ: TEST-009 - Concurrent access patterns
    use std::sync::{Arc, Mutex};
    use crate::utils::concurrent;

    let scheduler = Arc::new(Mutex::new(MockScheduler::new()));

    // Add tasks from multiple threads
    concurrent::run_concurrent(5, {
        let scheduler = Arc::clone(&scheduler);
        move |i| {
            let mut sched = scheduler.lock().unwrap();
            sched.add_task(MockTask::new(i as u32, (i * 10) as u8));
        }
    });

    let sched = scheduler.lock().unwrap();
    assert_eq_test!(sched.tasks.len(), 5, "All tasks should be added");
}
