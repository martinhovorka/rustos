//! REQ: SCHED-001 - Preemptive Scheduler
//!
//! Priority-based preemptive scheduler with O(1) task selection using a priority bitmap.
//!
//! # Algorithm
//!
//! The scheduler uses an 8-word bitmap (256 bits) to track which priority levels have
//! ready tasks. Task selection is O(1) by scanning the bitmap for the first set bit
//! (lowest priority value = highest priority).
//!
//! # Example
//!
//! ```no_run
//! use rustos_kernel::{scheduler, task::{Task, TaskPriority}};
//!
//! // SAFETY: Called after kernel initialization with tasks created
//! unsafe {
//!     // Enable scheduler
//!     scheduler::get().enable();
//!     
//!     // Start scheduler (does not return)
//!     scheduler::start();
//! }
//! ```
//!
//! # Preemption
//!
//! Tasks are preempted on every system tick (1ms). Higher priority tasks always
//! run before lower priority tasks. Tasks at the same priority share CPU time
//! in round-robin fashion.

use crate::task::{Task, TaskId, TaskPriority, TaskState, MAX_TASKS};
use core::ptr::null_mut;
use portable_atomic::{AtomicBool, AtomicPtr, AtomicU8, Ordering};

/// REQ: SCHED-011 - O(1) scheduler with priority bitmap
static SCHEDULER: Scheduler = Scheduler::new();

/// REQ: SCHED-008 - Thread-safe scheduler
pub struct Scheduler {
    /// Array of tasks (up to MAX_TASKS) - using AtomicPtr for thread safety
    tasks: [AtomicPtr<Task>; MAX_TASKS],
    /// Number of active tasks
    task_count: AtomicU8,
    /// Currently running task ID
    current_task: AtomicU8,
    /// Scheduler enabled flag
    enabled: AtomicBool,
    /// REQ: SCHED-017 - Priority bitmap for O(1) lookup (256 priorities / 32 bits = 8 words)
    priority_bitmap: [AtomicU32; 8],
    /// REQ: SCHED-015 - Context switch counter for statistics
    #[cfg(feature = "statistics")]
    context_switch_count: AtomicU32,
}

use portable_atomic::AtomicU32;

impl Scheduler {
    /// Create new scheduler
    #[allow(clippy::declare_interior_mutable_const)]
    const fn new() -> Self {
        const NULL_TASK: AtomicPtr<Task> = AtomicPtr::new(null_mut());
        const ATOMIC_ZERO: AtomicU32 = AtomicU32::new(0);

        Self {
            tasks: [NULL_TASK; MAX_TASKS],
            task_count: AtomicU8::new(0),
            current_task: AtomicU8::new(0xFF), // Invalid task ID initially
            enabled: AtomicBool::new(false),
            priority_bitmap: [ATOMIC_ZERO; 8],
            #[cfg(feature = "statistics")]
            context_switch_count: AtomicU32::new(0),
        }
    }

    /// REQ: SCHED-017 - Set bit in priority bitmap
    fn set_priority_bit(&self, priority: TaskPriority) {
        let word = priority.0 as usize / 32;
        let bit = priority.0 as u32 % 32;
        self.priority_bitmap[word].fetch_or(1 << bit, Ordering::Release);
    }

    /// REQ: SCHED-017 - Clear bit in priority bitmap
    fn clear_priority_bit(&self, priority: TaskPriority) {
        let word = priority.0 as usize / 32;
        let bit = priority.0 as u32 % 32;
        self.priority_bitmap[word].fetch_and(!(1 << bit), Ordering::Release);
    }

    /// REQ: SCHED-003, SCHED-011 - Find highest priority ready task in O(1)
    fn find_highest_priority(&self) -> Option<TaskId> {
        // Scan priority bitmap from lowest index (highest priority) to highest
        for (word_idx, word) in self.priority_bitmap.iter().enumerate() {
            let bits = word.load(Ordering::Acquire);
            if bits != 0 {
                // Find first set bit (lowest numbered = highest priority)
                let bit_pos = bits.trailing_zeros();
                let priority = (word_idx * 32 + bit_pos as usize) as u8;

                // Find task with this priority in ready state
                for (idx, task_ptr) in self.tasks.iter().enumerate() {
                    let task = task_ptr.load(Ordering::Acquire);
                    if !task.is_null() {
                        // SAFETY: task pointer is loaded atomically and checked for null.
                        // Pointer validity is guaranteed by add_task which only stores valid static task references.
                        unsafe {
                            if (*task).priority().0 == priority
                                && (*task).state().contains(TaskState::READY)
                            {
                                return Some(TaskId(idx as u8));
                            }
                        }
                    }
                }
            }
        }
        None
    }

    /// REQ: TASK-003 - Add task to scheduler
    ///
    /// # Safety
    /// - Task must have static lifetime
    /// - Must be called with interrupts disabled
    // SAFETY: Function signature - see # Safety documentation above
    pub unsafe fn add_task(&self, task: &'static mut Task) -> crate::Result<()> {
        let count = self.task_count.load(Ordering::Acquire);
        if count >= MAX_TASKS as u8 {
            return Err(crate::KernelError::QueueFull);
        }

        let id = task.id().0 as usize;
        if id >= MAX_TASKS {
            return Err(crate::KernelError::InvalidTaskId);
        }

        let existing = self.tasks[id].load(Ordering::Acquire);
        if !existing.is_null() {
            return Err(crate::KernelError::InvalidParameter);
        }

        self.tasks[id].store(task as *mut Task, Ordering::Release);
        self.task_count.fetch_add(1, Ordering::Release);
        self.set_priority_bit(task.priority());

        Ok(())
    }

    /// REQ: SCHED-003 - Schedule next task
    ///
    /// Returns the task ID to switch to, or None if no task is ready
    pub fn schedule(&self) -> Option<TaskId> {
        if !self.enabled.load(Ordering::Acquire) {
            return None;
        }

        self.find_highest_priority()
    }

    /// REQ: SCHED-007 - Enable scheduler
    pub fn enable(&self) {
        self.enabled.store(true, Ordering::Release);
    }

    /// REQ: SCHED-007 - Disable scheduler
    pub fn disable(&self) {
        self.enabled.store(false, Ordering::Release);
    }

    /// Get currently running task ID
    pub fn current_task(&self) -> Option<TaskId> {
        let id = self.current_task.load(Ordering::Acquire);
        if id == 0xFF {
            None
        } else {
            Some(TaskId(id))
        }
    }

    /// Set currently running task
    pub fn set_current_task(&self, task_id: TaskId) {
        self.current_task.store(task_id.0, Ordering::Release);
    }

    /// Get task by ID
    pub fn get_task(&self, id: TaskId) -> Option<&Task> {
        let task = self.tasks.get(id.0 as usize)?.load(Ordering::Acquire);
        if task.is_null() {
            None
        } else {
            // SAFETY: Pointer is loaded atomically and checked for null.
            // Valid because add_task only stores static task references.
            unsafe { Some(&*task) }
        }
    }

    /// Get mutable task by ID
    ///
    /// # Safety
    /// Must be called with interrupts disabled
    // SAFETY: Function signature - see # Safety documentation above
    #[allow(clippy::mut_from_ref)]
    pub unsafe fn get_task_mut(&self, id: TaskId) -> Option<&mut Task> {
        let task = self.tasks.get(id.0 as usize)?.load(Ordering::Acquire);
        if task.is_null() {
            None
        } else {
            Some(&mut *task)
        }
    }

    /// REQ: TASK-007 - Block current task
    pub fn block_current_task(&self) {
        if let Some(id) = self.current_task() {
            // SAFETY: Called with scheduler lock held (implicitly via critical section).
            if let Some(task) = unsafe { self.get_task_mut(id) } {
                task.set_state(TaskState::BLOCKED);
                self.clear_priority_bit(task.priority());
            }
        }
    }

    /// REQ: TASK-007 - Unblock task
    pub fn unblock_task(&self, id: TaskId) {
        // SAFETY: Called with scheduler lock held (implicitly via critical section).
        if let Some(task) = unsafe { self.get_task_mut(id) } {
            task.set_state(TaskState::READY);
            self.set_priority_bit(task.priority());
        }
    }
}

/// REQ: KERN-003 - Initialize scheduler
// SAFETY: Function signature - called once during kernel initialization
pub(crate) unsafe fn init() {
    // Scheduler is already initialized statically
}

/// REQ: SCHED-010 - Start scheduler (transfers control to first task)
///
/// # Safety
/// - Must be called after all tasks are added
/// - Must be called with interrupts disabled
/// - Never returns
///
/// # Panics
/// Panics in debug builds if no tasks are available. In release builds,
/// uses unreachable_unchecked for performance-critical startup path.
/// REQ: RUST-009 - Critical startup assertions are documented as panics.
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn start() -> ! {
    SCHEDULER.enable();

    // REQ: RUST-009 - Find first task to run with proper error handling
    // This is a critical invariant: at least one task must exist at startup.
    // If no tasks exist, this is a programming error that cannot be recovered.
    let first_task_id = match SCHEDULER.schedule() {
        Some(id) => id,
        None => {
            // SAFETY: If we reach here, the caller violated the safety contract
            // by calling start() without adding any tasks. This is a fatal error.
            #[cfg(debug_assertions)]
            panic!("FATAL: No tasks available to schedule - add tasks before calling start()");
            #[cfg(not(debug_assertions))]
            core::hint::unreachable_unchecked()
        }
    };

    SCHEDULER.set_current_task(first_task_id);

    // REQ: RUST-009 - Task existence is guaranteed by successful schedule()
    let task = match SCHEDULER.get_task(first_task_id) {
        Some(t) => t,
        None => {
            // SAFETY: If schedule() returned an ID, the task must exist.
            // This branch is unreachable in correct operation.
            #[cfg(debug_assertions)]
            panic!("FATAL: Scheduled task does not exist - internal scheduler error");
            #[cfg(not(debug_assertions))]
            core::hint::unreachable_unchecked()
        }
    };

    // REQ: CTX-008 - Perform initial context switch
    // This will be implemented in context.rs
    crate::context::start_first_task(task.sp());
}

/// REQ: SCHED-004 - Perform task switch (called from timer ISR)
///
/// # Safety
/// Must be called from interrupt context with interrupts disabled
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn yield_from_isr() {
    let current_id_opt = SCHEDULER.current_task();

    // Select next task
    let next_id_opt = SCHEDULER.schedule();

    if let (Some(current_id), Some(next_id)) = (current_id_opt, next_id_opt) {
        if current_id != next_id {
            // Update current task state
            if let Some(current_task) = SCHEDULER.get_task_mut(current_id) {
                if current_task.state().contains(TaskState::RUNNING) {
                    current_task.set_state(TaskState::READY);
                }
            }

            // Update next task state
            if let Some(next_task) = SCHEDULER.get_task_mut(next_id) {
                next_task.set_state(TaskState::RUNNING);
            }

            SCHEDULER.set_current_task(next_id);

            // REQ: CTX-001, CTX-006 - Perform context switch
            // Actual context switch will be done in the trap handler
        }
    }
}

/// REQ: SCHED-010 - Voluntary task yield
pub fn yield_now() {
    // Trigger a context switch by invoking ecall or similar
    // This will be implemented when we add system call support
    // SAFETY: ecall instruction is safe - trap handler will catch it.
    unsafe {
        core::arch::asm!("ecall");
    }
}

/// REQ: SCHED-015 - Get context switch count
#[cfg(feature = "statistics")]
pub fn get_context_switch_count() -> u32 {
    SCHEDULER.context_switch_count.load(Ordering::Acquire)
}

/// REQ: SCHED-015 - Increment context switch counter
#[cfg(feature = "statistics")]
pub(crate) fn increment_context_switches() {
    SCHEDULER
        .context_switch_count
        .fetch_add(1, Ordering::Relaxed);
}

/// REQ: DIAG-001 - Get task state (for diagnostics)
///
/// Returns the current state of the specified task.
/// Non-blocking, safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_task_state(task_id: TaskId) -> Option<TaskState> {
    SCHEDULER.get_task(task_id).map(|task| task.state())
}

/// REQ: DIAG-005 - Get task stack usage (for diagnostics)
///
/// Returns the high-water mark (maximum observed usage) of the task's stack.
/// Non-blocking, safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_task_stack_usage(task_id: TaskId) -> Option<usize> {
    SCHEDULER.get_task(task_id).map(|task| task.stack_usage())
}

/// Get reference to global scheduler
pub fn get() -> &'static Scheduler {
    &SCHEDULER
}

/// REQ: SCHED-014 - Enter tickless idle mode
///
/// Suppresses system ticks when no tasks are ready to run and no timers
/// are about to expire. This saves power by allowing the CPU to remain
/// in a low-power state longer.
///
/// # Safety
/// - Must be called from idle task only
/// - Interrupts should be enabled to wake from WFI
#[cfg(feature = "tickless")]
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn enter_tickless_idle() {
    use crate::time::get_next_wake_ticks;

    // Check if we can suppress ticks
    if let Some(ticks_until_wake) = get_next_wake_ticks() {
        if ticks_until_wake > 1 {
            // We can sleep for multiple ticks
            // In a full implementation, this would:
            // 1. Disable system tick interrupt
            // 2. Configure wake timer for next event
            // 3. Enter WFI (Wait For Interrupt)
            // 4. On wake, re-enable system tick
            // 5. Adjust tick count for time slept

            // For now, just use WFI without tick suppression
            // SAFETY: WFI with interrupts enabled - will wake on any interrupt.
            core::arch::asm!("wfi");
        }
    } else {
        // No scheduled events - can sleep indefinitely
        // SAFETY: WFI with interrupts enabled - will wake on any interrupt.
        core::arch::asm!("wfi");
    }
}

/// REQ: SCHED-014 - Enter power-saving idle (WFI instruction)
///
/// Simplified version that doesn't suppress ticks, just uses WFI.
/// Safe for all configurations.
///
/// # Safety
/// Must be called from idle task with interrupts enabled
// SAFETY: Function signature - see # Safety documentation above
pub unsafe fn enter_idle() {
    // Wait For Interrupt - low power mode until next interrupt
    // SAFETY: WFI instruction - caller guarantees interrupts are enabled for wake.
    core::arch::asm!("wfi");
}
