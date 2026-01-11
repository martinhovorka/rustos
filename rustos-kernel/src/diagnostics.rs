//! Runtime Diagnostics
//!
//! REQ: DIAG-001 - Task statistics collection
//! REQ: DIAG-002 - CPU usage tracking
//! REQ: DIAG-003 - Stack usage monitoring
//! REQ: DIAG-004 - Interrupt statistics
//! REQ: DIAG-005 - Memory usage reporting
//! REQ: DIAG-006 - Diagnostic data export

#![allow(unused)]

use core::sync::atomic::{AtomicU32, Ordering};
use crate::task::TaskId;

/// REQ: DIAG-001 - Per-task statistics
#[derive(Debug, Clone, Copy)]
pub struct TaskStats {
    /// Task ID
    pub task_id: TaskId,
    /// Total CPU time in ticks
    pub cpu_time: u32,
    /// Number of times scheduled
    pub schedule_count: u32,
    /// Current stack usage in bytes
    pub stack_used: usize,
    /// Peak stack usage in bytes
    pub stack_peak: usize,
    /// Stack size in bytes
    pub stack_size: usize,
    /// Number of preemptions
    pub preempt_count: u32,
    /// Last execution time in ticks
    pub last_run_time: u32,
}

/// REQ: DIAG-002 - System-wide CPU statistics
#[derive(Debug, Clone, Copy)]
pub struct CpuStats {
    /// Total system uptime in ticks
    pub uptime_ticks: u64,
    /// Total idle time in ticks
    pub idle_ticks: u64,
    /// CPU utilization percentage (0-100)
    pub utilization: u8,
    /// Number of context switches
    pub context_switches: u32,
    /// Number of interrupts serviced
    pub interrupt_count: u32,
}

/// REQ: DIAG-004 - Interrupt statistics
#[derive(Debug, Clone, Copy)]
pub struct InterruptStats {
    /// Interrupt number
    pub irq_number: u8,
    /// Total count
    pub count: u32,
    /// Total service time in ticks
    pub service_time: u32,
    /// Maximum service time in ticks
    pub max_service_time: u32,
    /// Average service time in ticks
    pub avg_service_time: u32,
}

/// REQ: DIAG-005 - Memory statistics
#[derive(Debug, Clone, Copy)]
pub struct MemoryStats {
    /// Total RAM size
    pub total_ram: usize,
    /// Used RAM (stack allocations)
    pub used_ram: usize,
    /// Free RAM
    pub free_ram: usize,
    /// Largest free block
    pub largest_free_block: usize,
}

/// Global diagnostics data structure
pub struct Diagnostics {
    /// Per-task statistics
    task_stats: [TaskStats; 16],
    /// Number of tracked tasks
    task_count: usize,
    /// CPU statistics
    cpu_stats: CpuStats,
    /// Interrupt statistics
    interrupt_stats: [InterruptStats; 16],
    /// Memory statistics
    memory_stats: MemoryStats,
    /// Context switch counter (atomic for ISR access)
    context_switch_count: AtomicU32,
    /// Interrupt counter (atomic for ISR access)
    interrupt_count: AtomicU32,
}

impl Diagnostics {
    /// Create new diagnostics instance
    pub const fn new() -> Self {
        const EMPTY_TASK_STATS: TaskStats = TaskStats {
            task_id: TaskId(0),
            cpu_time: 0,
            schedule_count: 0,
            stack_used: 0,
            stack_peak: 0,
            stack_size: 0,
            preempt_count: 0,
            last_run_time: 0,
        };

        const EMPTY_IRQ_STATS: InterruptStats = InterruptStats {
            irq_number: 0,
            count: 0,
            service_time: 0,
            max_service_time: 0,
            avg_service_time: 0,
        };

        Self {
            task_stats: [EMPTY_TASK_STATS; 16],
            task_count: 0,
            cpu_stats: CpuStats {
                uptime_ticks: 0,
                idle_ticks: 0,
                utilization: 0,
                context_switches: 0,
                interrupt_count: 0,
            },
            interrupt_stats: [EMPTY_IRQ_STATS; 16],
            memory_stats: MemoryStats {
                total_ram: 0,
                used_ram: 0,
                free_ram: 0,
                largest_free_block: 0,
            },
            context_switch_count: AtomicU32::new(0),
            interrupt_count: AtomicU32::new(0),
        }
    }

    /// REQ: DIAG-001 - Update task statistics
    pub fn update_task_stats(&mut self, task_id: TaskId, stack_used: usize, stack_size: usize) {
        for stats in self.task_stats.iter_mut().take(self.task_count) {
            if stats.task_id == task_id {
                stats.stack_used = stack_used;
                if stack_used > stats.stack_peak {
                    stats.stack_peak = stack_used;
                }
                stats.stack_size = stack_size;
                stats.schedule_count += 1;
                return;
            }
        }

        // Add new task if not found
        if self.task_count < self.task_stats.len() {
            self.task_stats[self.task_count] = TaskStats {
                task_id,
                cpu_time: 0,
                schedule_count: 1,
                stack_used,
                stack_peak: stack_used,
                stack_size,
                preempt_count: 0,
                last_run_time: 0,
            };
            self.task_count += 1;
        }
    }

    /// REQ: DIAG-001 - Get task statistics
    pub fn get_task_stats(&self, task_id: TaskId) -> Option<TaskStats> {
        self.task_stats
            .iter()
            .take(self.task_count)
            .find(|s| s.task_id == task_id)
            .copied()
    }

    /// REQ: DIAG-001 - Get all task statistics
    pub fn get_all_task_stats(&self) -> &[TaskStats] {
        &self.task_stats[..self.task_count]
    }

    /// REQ: DIAG-002 - Record context switch
    pub fn record_context_switch(&mut self) {
        self.context_switch_count.fetch_add(1, Ordering::Relaxed);
    }

    /// REQ: DIAG-004 - Record interrupt
    pub fn record_interrupt(&mut self, irq: u8, service_time: u32) {
        self.interrupt_count.fetch_add(1, Ordering::Relaxed);

        for stats in self.interrupt_stats.iter_mut() {
            if stats.irq_number == irq {
                stats.count += 1;
                stats.service_time += service_time;
                if service_time > stats.max_service_time {
                    stats.max_service_time = service_time;
                }
                stats.avg_service_time = stats.service_time / stats.count;
                return;
            }
        }
    }

    /// REQ: DIAG-002 - Update CPU statistics
    pub fn update_cpu_stats(&mut self, uptime_ticks: u64, idle_ticks: u64) {
        self.cpu_stats.uptime_ticks = uptime_ticks;
        self.cpu_stats.idle_ticks = idle_ticks;
        self.cpu_stats.context_switches = self.context_switch_count.load(Ordering::Relaxed);
        self.cpu_stats.interrupt_count = self.interrupt_count.load(Ordering::Relaxed);

        // Calculate utilization percentage
        if uptime_ticks > 0 {
            let busy_ticks = uptime_ticks.saturating_sub(idle_ticks);
            self.cpu_stats.utilization = ((busy_ticks * 100) / uptime_ticks) as u8;
        }
    }

    /// REQ: DIAG-002 - Get CPU statistics
    pub fn get_cpu_stats(&self) -> CpuStats {
        self.cpu_stats
    }

    /// REQ: DIAG-005 - Update memory statistics
    pub fn update_memory_stats(&mut self, total: usize, used: usize) {
        self.memory_stats.total_ram = total;
        self.memory_stats.used_ram = used;
        self.memory_stats.free_ram = total.saturating_sub(used);
    }

    /// REQ: DIAG-005 - Get memory statistics
    pub fn get_memory_stats(&self) -> MemoryStats {
        self.memory_stats
    }

    /// REQ: DIAG-006 - Reset all statistics
    pub fn reset(&mut self) {
        self.task_count = 0;
        self.cpu_stats = CpuStats {
            uptime_ticks: 0,
            idle_ticks: 0,
            utilization: 0,
            context_switches: 0,
            interrupt_count: 0,
        };
        self.context_switch_count = AtomicU32::new(0);
        self.interrupt_count = AtomicU32::new(0);
    }
}

/// Global diagnostics instance
static mut DIAGNOSTICS: Diagnostics = Diagnostics::new();

/// REQ: DIAG-006 - Get global diagnostics instance
///
/// # Safety
/// Must be called from a single thread or with proper synchronization
pub unsafe fn get_diagnostics() -> &'static mut Diagnostics {
    unsafe { &mut *core::ptr::addr_of_mut!(DIAGNOSTICS) }
}

/// REQ: DIAG-003 - Calculate stack usage for a task
///
/// # Safety
/// Stack pointer must be valid for the given task
pub unsafe fn calculate_stack_usage(stack_bottom: *const u8, stack_top: *const u8, sp: *const u8) -> usize {
    let stack_size = stack_bottom as usize - stack_top as usize;
    let used = stack_bottom as usize - sp as usize;
    used.min(stack_size)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_diagnostics_init() {
        let diag = Diagnostics::new();
        assert_eq!(diag.task_count, 0);
    }

    #[test]
    fn test_context_switch_counter() {
        let mut diag = Diagnostics::new();
        diag.record_context_switch();
        assert_eq!(diag.context_switch_count.load(Ordering::Relaxed), 1);
    }

    #[test]
    fn test_cpu_utilization() {
        let mut diag = Diagnostics::new();
        diag.update_cpu_stats(1000, 100);
        assert_eq!(diag.cpu_stats.utilization, 90); // 90% busy
    }
}
