//! REQ: MTX-001, SEM-001, MQ-001, EVT-001 - Synchronization Primitives
//! 
//! Provides mutex, semaphore, message queue, and event flags for task synchronization.

pub mod mutex;
pub mod semaphore;
pub mod message_queue;
pub mod event_flags;

pub use mutex::Mutex;
pub use semaphore::Semaphore;
pub use message_queue::MessageQueue;
pub use event_flags::EventFlags;
