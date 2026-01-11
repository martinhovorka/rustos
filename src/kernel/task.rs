//! Task Control Block and task management
//!
//! Provides structures and functions for task creation and management

use core::ptr;

/// Task priority levels (0 = lowest, 31 = highest)
pub type Priority = u8;

/// Maximum number of priority levels
pub const MAX_PRIORITY: Priority = 32;

/// Task state
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum TaskState {
    /// Task is ready to run
    Ready,
    /// Task is currently running
    Running,
    /// Task is blocked waiting for a resource
    Blocked,
    /// Task is suspended
    Suspended,
}

/// Task Control Block (TCB)
#[repr(C)]
pub struct TaskControlBlock {
    /// Stack pointer
    pub sp: usize,
    /// Task priority
    pub priority: Priority,
    /// Task state
    pub state: TaskState,
    /// Task entry point
    pub entry: fn(),
    /// Pointer to stack base
    pub stack_base: *mut u8,
    /// Stack size in bytes
    pub stack_size: usize,
    /// Next task in the list
    pub next: *mut TaskControlBlock,
}

impl TaskControlBlock {
    /// Create a new task control block
    pub const fn new(
        priority: Priority,
        entry: fn(),
        stack_base: *mut u8,
        stack_size: usize,
    ) -> Self {
        Self {
            sp: 0,
            priority,
            state: TaskState::Ready,
            entry,
            stack_base,
            stack_size,
            next: ptr::null_mut(),
        }
    }

    /// Initialize task stack
    pub fn init_stack(&mut self) {
        // Stack grows downward, so start at the top
        let stack_top = unsafe { self.stack_base.add(self.stack_size) } as usize;
        
        // Align to 16 bytes for RISC-V
        let stack_top = stack_top & !0xF;
        
        // Set up initial stack frame for context switch
        self.sp = stack_top;
    }
}

unsafe impl Send for TaskControlBlock {}
