//! REQ: MQ-001 - Message Queue Implementation
//! 
//! Fixed-size message queue for inter-task communication.

use crate::critical::CriticalSection;
use heapless::Deque;

/// REQ: MQ-001 - Message queue with static storage
pub struct MessageQueue<T, const N: usize> {
    /// Internal queue storage
    queue: core::cell::UnsafeCell<Deque<T, N>>,
}

unsafe impl<T: Send, const N: usize> Send for MessageQueue<T, N> {}
unsafe impl<T: Send, const N: usize> Sync for MessageQueue<T, N> {}

impl<T, const N: usize> MessageQueue<T, N> {
    /// REQ: MQ-002 - Create a new message queue
    pub const fn new() -> Self {
        Self {
            queue: core::cell::UnsafeCell::new(Deque::new()),
        }
    }

    /// REQ: MQ-003 - Send message (non-blocking)
    pub fn try_send(&self, msg: T) -> Result<(), T> {
        let _cs = CriticalSection::new();
        
        unsafe {
            (*self.queue.get())
                .push_back(msg)
                .map_err(|e| e)
        }
    }

    /// REQ: MQ-004 - Receive message (non-blocking)
    pub fn try_receive(&self) -> Option<T> {
        let _cs = CriticalSection::new();
        
        unsafe {
            (*self.queue.get()).pop_front()
        }
    }

    /// Check if queue is full
    pub fn is_full(&self) -> bool {
        let _cs = CriticalSection::new();
        unsafe { (*self.queue.get()).is_full() }
    }

    /// Check if queue is empty
    pub fn is_empty(&self) -> bool {
        let _cs = CriticalSection::new();
        unsafe { (*self.queue.get()).is_empty() }
    }

    /// Get current queue length
    pub fn len(&self) -> usize {
        let _cs = CriticalSection::new();
        unsafe { (*self.queue.get()).len() }
    }
}
