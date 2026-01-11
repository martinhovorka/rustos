//! Synchronization primitives
//!
//! Provides Mutex, Semaphore, Message Queue, and Event Flags

pub mod mutex;
pub mod semaphore;
pub mod message_queue;
pub mod event_flags;

pub use mutex::Mutex;
pub use semaphore::{Semaphore, BinarySemaphore};
pub use message_queue::MessageQueue;
pub use event_flags::EventFlags;
