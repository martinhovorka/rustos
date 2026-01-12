//! REQ: MTX-001, SEM-001, MQ-001, EVT-001 - Synchronization Primitives
//! 
//! Provides mutex, semaphore, message queue, and event flags for task synchronization.
//!
//! # Overview
//!
//! All synchronization primitives are designed for embedded systems with static allocation
//! and deterministic behavior. No dynamic memory allocation is used.
//!
//! # Primitives
//!
//! - **[`Mutex`]**: Mutual exclusion lock for protecting shared resources
//! - **[`Semaphore`]**: Counting semaphore for resource management
//! - **[`MessageQueue`]**: Fixed-size FIFO message queue for inter-task communication
//! - **[`EventFlags`]**: Bit flags for event signaling and synchronization
//!
//! # Example: Mutex
//!
//! ```no_run
//! use rustos_kernel::sync::Mutex;
//!
//! static COUNTER: Mutex<u32> = Mutex::new(0);
//!
//! fn increment_task() {
//!     if let Some(mut guard) = COUNTER.try_lock() {
//!         *guard += 1;
//!         // Lock automatically released when guard drops
//!     }
//! }
//! ```
//!
//! # Example: Semaphore
//!
//! ```no_run
//! use rustos_kernel::sync::Semaphore;
//!
//! static RESOURCES: Semaphore = Semaphore::new(3); // 3 available resources
//!
//! fn use_resource() {
//!     // Acquire resource (blocks if count is 0)
//!     RESOURCES.acquire();
//!     // ... use resource ...
//!     RESOURCES.release();
//! }
//! ```
//!
//! # Example: Message Queue
//!
//! ```no_run
//! use rustos_kernel::sync::MessageQueue;
//!
//! static QUEUE: MessageQueue<u32, 8> = MessageQueue::new();
//!
//! fn producer() {
//!     QUEUE.send(42).ok();
//! }
//!
//! fn consumer() {
//!     if let Ok(value) = QUEUE.receive() {
//!         // Process value
//!     }
//! }
//! ```

pub mod mutex;
pub mod semaphore;
pub mod message_queue;
pub mod event_flags;

pub use mutex::Mutex;
pub use semaphore::Semaphore;
pub use message_queue::MessageQueue;
pub use event_flags::EventFlags;

#[cfg(feature = "diagnostics")]
use crate::task::TaskId;

/// REQ: DIAG-002 - Mutex identifier for diagnostics
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(transparent)]
pub struct MutexId(pub u8);

/// REQ: DIAG-002 - Get mutex owner (for diagnostics)
/// 
/// Returns None if mutex ID is invalid or mutex is not locked.
/// Safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_mutex_owner(_mutex_id: MutexId) -> Option<TaskId> {
    // TODO: Implement mutex tracking registry
    // For now, return None - mutexes are created inline, not registered
    None
}

/// REQ: DIAG-003 - Get queue message count (for diagnostics)
/// 
/// Returns None if queue ID is invalid.
/// Safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_queue_count(_queue_id: u8) -> Option<usize> {
    // TODO: Implement queue tracking registry
    // For now, return None - queues are created inline, not registered
    None
}

