//! REQ: TASK-001 - Task Management
//! 
//! Provides task control block (TCB) and task management functionality.

use bitflags::bitflags;

/// REQ: SCHED-005 - Maximum number of tasks
pub const MAX_TASKS: usize = 16;

/// REQ: TASK-004 - Default task stack size (2 KB)
pub const DEFAULT_STACK_SIZE: usize = 2048;

/// REQ: TASK-001 - Task Control Block
#[repr(C)]
pub struct Task {
    /// Task ID
    id: TaskId,
    /// Task name (for debugging)
    name: &'static str,
    /// REQ: SCHED-002 - Task priority (0 = highest, 255 = lowest)
    priority: TaskPriority,
    /// REQ: TASK-002 - Task state
    state: TaskState,
    /// Stack pointer (saved context location)
    sp: *mut usize,
    /// Stack base address
    stack_base: *mut u8,
    /// Stack size in bytes
    stack_size: usize,
    /// REQ: TASK-005 - Stack canary for overflow detection
    stack_canary: u32,
    /// REQ: TASK-011 - Runtime statistics
    #[cfg(feature = "statistics")]
    stats: TaskStats,
}

/// REQ: TASK-001 - Task identifier
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
#[repr(transparent)]
pub struct TaskId(pub u8);

/// REQ: SCHED-002 - Task priority (0 = highest, 255 = lowest)
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
#[repr(transparent)]
pub struct TaskPriority(pub u8);

impl TaskPriority {
    /// REQ: SCHED-002 - Highest priority
    pub const HIGHEST: Self = Self(0);
    /// REQ: SCHED-002 - Lowest priority (for idle task)
    pub const LOWEST: Self = Self(255);
    /// REQ: SCHED-002 - Normal priority
    pub const NORMAL: Self = Self(128);
}

bitflags! {
    /// REQ: TASK-002 - Task states
    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
    pub struct TaskState: u8 {
        /// Task is ready to run
        const READY = 1 << 0;
        /// Task is currently running
        const RUNNING = 1 << 1;
        /// Task is blocked waiting for resource
        const BLOCKED = 1 << 2;
        /// Task is suspended
        const SUSPENDED = 1 << 3;
        /// REQ: TASK-015 - Task is terminated
        const TERMINATED = 1 << 4;
    }
}

/// REQ: TASK-011 - Task statistics
#[cfg(feature = "statistics")]
#[derive(Debug, Clone, Copy)]
pub struct TaskStats {
    /// Total CPU cycles consumed
    pub cpu_cycles: u64,
    /// Number of times scheduled
    pub schedule_count: u32,
    /// Maximum stack usage (high watermark)
    pub max_stack_usage: usize,
}

impl Task {
    /// REQ: TASK-003 - Create a new task
    /// 
    /// # Arguments
    /// * `id` - Unique task identifier
    /// * `name` - Task name for debugging
    /// * `priority` - Task priority
    /// * `entry` - Task entry point function
    /// * `stack` - Stack memory slice
    /// 
    /// # Safety
    /// - Stack must be valid for the lifetime of the task
    /// - Entry function must never return (fn() -> !)
    pub unsafe fn new(
        id: TaskId,
        name: &'static str,
        priority: TaskPriority,
        entry: extern "C" fn() -> !,
        stack: &'static mut [u8],
    ) -> Self {
        let stack_size = stack.len();
        let stack_base = stack.as_mut_ptr();
        
        // REQ: TASK-005 - Initialize stack canary
        const STACK_CANARY: u32 = 0xDEADBEEF;
        
        // REQ: CTX-008 - Setup initial stack frame
        let sp = Self::init_stack(stack, entry);
        
        Task {
            id,
            name,
            priority,
            state: TaskState::READY,
            sp,
            stack_base,
            stack_size,
            stack_canary: STACK_CANARY,
            #[cfg(feature = "statistics")]
            stats: TaskStats {
                cpu_cycles: 0,
                schedule_count: 0,
                max_stack_usage: 0,
            },
        }
    }

    /// REQ: CTX-008 - Initialize task stack with context frame
    /// 
    /// Sets up the initial stack frame so the task can be context-switched to.
    unsafe fn init_stack(stack: &mut [u8], entry: extern "C" fn() -> !) -> *mut usize {
        let stack_top = stack.as_mut_ptr().add(stack.len()) as *mut usize;
        
        // REQ: CTX-007 - Align stack pointer to 16 bytes
        let sp = (stack_top as usize & !0xF) as *mut usize;
        
        // REQ: CTX-013 - Context frame size is 144 bytes (36 words)
        let sp = sp.sub(36);
        
        // REQ: CTX-011 - Initialize context frame
        // Registers x1, x3-x31 (30 registers total) + CSRs
        
        // Clear all GPRs
        for i in 0..30 {
            sp.add(i).write(0);
        }
        
        // REQ: CTX-003 - Set mepc to task entry point
        sp.add(30).write(entry as usize);  // mepc
        
        // REQ: CTX-004 - Set initial mstatus (MIE=0, MPIE=1)
        sp.add(31).write(0x1880);  // mstatus: MPP=11 (M-mode), MPIE=1
        
        // mcause = 0
        sp.add(32).write(0);
        
        // mtval = 0
        sp.add(33).write(0);
        
        sp
    }

    /// Get task ID
    #[inline]
    pub fn id(&self) -> TaskId {
        self.id
    }

    /// Get task name
    #[inline]
    pub fn name(&self) -> &'static str {
        self.name
    }

    /// Get task priority
    #[inline]
    pub fn priority(&self) -> TaskPriority {
        self.priority
    }

    /// Get task state
    #[inline]
    pub fn state(&self) -> TaskState {
        self.state
    }

    /// REQ: TASK-007 - Set task state
    #[inline]
    pub(crate) fn set_state(&mut self, state: TaskState) {
        self.state = state;
    }

    /// Get stack pointer
    #[inline]
    pub(crate) fn sp(&self) -> *mut usize {
        self.sp
    }

    /// Set stack pointer (used by context switch)
    #[inline]
    #[allow(dead_code)]
    pub(crate) fn set_sp(&mut self, sp: *mut usize) {
        self.sp = sp;
    }

    /// REQ: TASK-005 - Check stack overflow via canary
    pub fn check_stack_overflow(&self) -> bool {
        unsafe {
            let canary_ptr = self.stack_base as *const u32;
            *canary_ptr == self.stack_canary
        }
    }

    /// REQ: TASK-006 - Calculate stack usage
    pub fn stack_usage(&self) -> usize {
        let current_sp = self.sp as usize;
        let stack_top = unsafe { self.stack_base.add(self.stack_size) } as usize;
        stack_top.saturating_sub(current_sp)
    }
}

// REQ: SAFE-002 - Task is Send but not Sync (can be moved between threads, not shared)
unsafe impl Send for Task {}

/// REQ: TASK-003 - Task builder for easier task creation
pub struct TaskBuilder {
    id: TaskId,
    name: &'static str,
    priority: TaskPriority,
}

impl TaskBuilder {
    /// Create a new task builder
    pub const fn new(id: TaskId, name: &'static str) -> Self {
        Self {
            id,
            name,
            priority: TaskPriority::NORMAL,
        }
    }

    /// Set task priority
    pub const fn priority(mut self, priority: TaskPriority) -> Self {
        self.priority = priority;
        self
    }

    /// REQ: TASK-003 - Build the task with the given entry point and stack
    /// 
    /// # Safety
    /// - Stack must be valid for the lifetime of the task
    /// - Entry function must never return
    pub unsafe fn build(
        self,
        entry: extern "C" fn() -> !,
        stack: &'static mut [u8],
    ) -> Task {
        Task::new(self.id, self.name, self.priority, entry, stack)
    }
}
