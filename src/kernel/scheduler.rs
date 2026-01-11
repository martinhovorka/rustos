//! Priority-based preemptive scheduler
//!
//! Implements a priority-based round-robin scheduler with preemption

use super::task::{TaskControlBlock, TaskState, MAX_PRIORITY};
use core::ptr;
use core::sync::atomic::{AtomicPtr, AtomicBool, Ordering};

/// Maximum number of tasks
pub const MAX_TASKS: usize = 16;

/// Ready queue for each priority level
static mut READY_QUEUES: [*mut TaskControlBlock; MAX_PRIORITY as usize] = 
    [ptr::null_mut(); MAX_PRIORITY as usize];

/// Currently running task
static CURRENT_TASK: AtomicPtr<TaskControlBlock> = AtomicPtr::new(ptr::null_mut());

/// Scheduler state
static SCHEDULER_RUNNING: AtomicBool = AtomicBool::new(false);

/// Initialize the scheduler
pub fn init() {
    // Initialize ready queues
    unsafe {
        for queue in READY_QUEUES.iter_mut() {
            *queue = ptr::null_mut();
        }
    }
    
    CURRENT_TASK.store(ptr::null_mut(), Ordering::Release);
    SCHEDULER_RUNNING.store(false, Ordering::Release);
}

/// Add a task to the ready queue
pub fn add_task(task: &mut TaskControlBlock) {
    critical_section::with(|_| {
        task.state = TaskState::Ready;
        let priority = task.priority as usize;
        
        unsafe {
            let queue = &mut READY_QUEUES[priority];
            
            if queue.is_null() {
                *queue = task as *mut TaskControlBlock;
                task.next = ptr::null_mut();
            } else {
                // Add to end of queue
                let mut current = *queue;
                while !(*current).next.is_null() {
                    current = (*current).next;
                }
                (*current).next = task as *mut TaskControlBlock;
                task.next = ptr::null_mut();
            }
        }
    });
}

/// Get the next task to run
fn get_next_task() -> *mut TaskControlBlock {
    // Find highest priority non-empty queue
    for priority in (0..MAX_PRIORITY as usize).rev() {
        unsafe {
            let queue = &mut READY_QUEUES[priority];
            if !queue.is_null() {
                let task = *queue;
                *queue = (*task).next;
                (*task).next = ptr::null_mut();
                return task;
            }
        }
    }
    
    ptr::null_mut()
}

/// Perform a context switch
pub fn schedule() {
    critical_section::with(|_| {
        let current = CURRENT_TASK.load(Ordering::Acquire);
        
        // If there's a current task and it's still ready, put it back in queue
        if !current.is_null() {
            unsafe {
                if (*current).state == TaskState::Running {
                    (*current).state = TaskState::Ready;
                    add_task(&mut *current);
                }
            }
        }
        
        // Get next task
        let next = get_next_task();
        
        if !next.is_null() {
            unsafe {
                (*next).state = TaskState::Running;
            }
            CURRENT_TASK.store(next, Ordering::Release);
            
            // Context switch happens here in actual implementation
            // For now, this is a placeholder
        }
    });
}

/// Start the scheduler
pub fn start() -> ! {
    SCHEDULER_RUNNING.store(true, Ordering::Release);
    
    // Get the first task
    let first_task = get_next_task();
    
    if first_task.is_null() {
        panic!("No tasks to run");
    }
    
    unsafe {
        (*first_task).state = TaskState::Running;
    }
    CURRENT_TASK.store(first_task, Ordering::Release);
    
    // Start first task - in real implementation, this would jump to task
    loop {
        schedule();
    }
}

/// Get the current running task
pub fn current_task() -> *mut TaskControlBlock {
    CURRENT_TASK.load(Ordering::Acquire)
}

/// Yield the CPU to another task
pub fn yield_task() {
    schedule();
}
