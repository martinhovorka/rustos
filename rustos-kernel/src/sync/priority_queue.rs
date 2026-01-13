//! REQ: MQ-009 - Priority Queue Implementation
//! 
//! A priority-based message queue where messages are ordered by priority.
//! Higher priority messages (lower numeric value) are dequeued first.
//!
//! # Example
//!
//! ```no_run
//! use rustos_kernel::sync::PriorityQueue;
//!
//! static QUEUE: PriorityQueue<u32, 8> = PriorityQueue::new();
//!
//! // Send messages with different priorities
//! QUEUE.send(100, 5);  // Low priority
//! QUEUE.send(200, 1);  // High priority
//!
//! // Receives 200 first (priority 1 < 5)
//! let msg = QUEUE.receive();
//! ```

use crate::critical::CriticalSection;
use core::cell::UnsafeCell;

/// REQ: MQ-009 - Priority levels for queue messages
pub type Priority = u8;

/// Message with associated priority
#[derive(Debug, Clone, Copy)]
pub struct PriorityMessage<T> {
    /// The message payload
    pub data: T,
    /// Priority level (0 = highest, 255 = lowest)
    pub priority: Priority,
}

impl<T> PriorityMessage<T> {
    /// Create a new priority message
    pub const fn new(data: T, priority: Priority) -> Self {
        Self { data, priority }
    }
}

/// REQ: MQ-009 - Priority queue storage
struct PriorityQueueStorage<T, const N: usize> {
    /// Array of messages
    items: [Option<PriorityMessage<T>>; N],
    /// Number of items in queue
    count: usize,
}

impl<T: Copy, const N: usize> PriorityQueueStorage<T, N> {
    const fn new() -> Self {
        // Initialize all slots to None
        Self {
            items: [None; N],
            count: 0,
        }
    }

    /// Insert maintaining priority order (insertion sort style)
    fn insert(&mut self, msg: PriorityMessage<T>) -> Result<(), PriorityMessage<T>> {
        if self.count >= N {
            return Err(msg);
        }

        // Find insertion point (maintain sorted order by priority)
        let mut insert_idx = self.count;
        for i in 0..self.count {
            if let Some(ref existing) = self.items[i] {
                if msg.priority < existing.priority {
                    insert_idx = i;
                    break;
                }
            }
        }

        // Shift elements to make room
        for i in (insert_idx..self.count).rev() {
            self.items[i + 1] = self.items[i].take();
        }

        // Insert new message
        self.items[insert_idx] = Some(msg);
        self.count += 1;
        Ok(())
    }

    /// Remove highest priority message (front of queue)
    fn remove(&mut self) -> Option<PriorityMessage<T>> {
        if self.count == 0 {
            return None;
        }

        let msg = self.items[0].take();
        
        // Shift remaining elements forward
        for i in 0..self.count - 1 {
            self.items[i] = self.items[i + 1].take();
        }
        
        self.count -= 1;
        msg
    }

    /// Peek at highest priority message without removing
    fn peek(&self) -> Option<&PriorityMessage<T>> {
        self.items[0].as_ref()
    }

    fn is_empty(&self) -> bool {
        self.count == 0
    }

    fn is_full(&self) -> bool {
        self.count >= N
    }

    fn len(&self) -> usize {
        self.count
    }
}

/// REQ: MQ-009 - Priority-based message queue
/// 
/// Messages are ordered by priority, with lower numeric values having
/// higher priority. When receiving, the highest priority message is
/// returned first.
pub struct PriorityQueue<T: Copy, const N: usize> {
    /// Internal storage
    storage: UnsafeCell<PriorityQueueStorage<T, N>>,
}

// SAFETY: PriorityQueue provides exclusive access via critical sections.
// Interior mutability is protected, making it safe to share across task boundaries.
unsafe impl<T: Copy + Send, const N: usize> Send for PriorityQueue<T, N> {}
// SAFETY: All queue operations protected by CriticalSection, synchronizing access.
unsafe impl<T: Copy + Send, const N: usize> Sync for PriorityQueue<T, N> {}

impl<T: Copy, const N: usize> PriorityQueue<T, N> {
    /// Create a new priority queue
    pub const fn new() -> Self {
        Self {
            storage: UnsafeCell::new(PriorityQueueStorage::new()),
        }
    }

    /// REQ: MQ-009 - Send a message with specified priority
    /// 
    /// Messages with lower priority values are dequeued first.
    /// Returns the message if queue is full.
    pub fn send(&self, data: T, priority: Priority) -> Result<(), T> {
        let _cs = CriticalSection::new();
        
        let msg = PriorityMessage::new(data, priority);
        // SAFETY: Access protected by critical section - no concurrent modification.
        unsafe {
            (*self.storage.get())
                .insert(msg)
                .map_err(|m| m.data)
        }
    }

    /// REQ: MQ-009 - Send with default priority (middle = 128)
    pub fn send_default(&self, data: T) -> Result<(), T> {
        self.send(data, 128)
    }

    /// REQ: MQ-009 - Receive highest priority message
    /// 
    /// Returns the message with the lowest priority number (highest priority).
    pub fn receive(&self) -> Option<T> {
        let _cs = CriticalSection::new();
        
        // SAFETY: Access protected by critical section - no concurrent modification.
        unsafe {
            (*self.storage.get())
                .remove()
                .map(|m| m.data)
        }
    }

    /// REQ: MQ-009 - Receive with priority info
    /// 
    /// Returns both the message and its priority.
    pub fn receive_with_priority(&self) -> Option<(T, Priority)> {
        let _cs = CriticalSection::new();
        
        // SAFETY: Access protected by critical section - no concurrent modification.
        unsafe {
            (*self.storage.get())
                .remove()
                .map(|m| (m.data, m.priority))
        }
    }

    /// REQ: MQ-009 - Peek at highest priority message
    pub fn peek(&self) -> Option<T> {
        let _cs = CriticalSection::new();
        
        // SAFETY: Access protected by critical section.
        unsafe {
            (*self.storage.get())
                .peek()
                .map(|m| m.data)
        }
    }

    /// REQ: MQ-009 - Peek with priority info
    pub fn peek_with_priority(&self) -> Option<(T, Priority)> {
        let _cs = CriticalSection::new();
        
        // SAFETY: Access protected by critical section.
        unsafe {
            (*self.storage.get())
                .peek()
                .map(|m| (m.data, m.priority))
        }
    }

    /// Check if queue is empty
    pub fn is_empty(&self) -> bool {
        let _cs = CriticalSection::new();
        // SAFETY: Access protected by critical section.
        unsafe { (*self.storage.get()).is_empty() }
    }

    /// Check if queue is full
    pub fn is_full(&self) -> bool {
        let _cs = CriticalSection::new();
        // SAFETY: Access protected by critical section.
        unsafe { (*self.storage.get()).is_full() }
    }

    /// Get number of messages in queue
    pub fn len(&self) -> usize {
        let _cs = CriticalSection::new();
        // SAFETY: Access protected by critical section.
        unsafe { (*self.storage.get()).len() }
    }

    /// Get queue capacity
    pub const fn capacity(&self) -> usize {
        N
    }

    /// Clear all messages from queue
    pub fn clear(&self) {
        let _cs = CriticalSection::new();
        
        // SAFETY: Access protected by critical section - no concurrent modification.
        unsafe {
            let storage = &mut *self.storage.get();
            for i in 0..N {
                storage.items[i] = None;
            }
            storage.count = 0;
        }
    }
}

impl<T: Copy, const N: usize> Default for PriorityQueue<T, N> {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_priority_queue_new() {
        let queue: PriorityQueue<u32, 8> = PriorityQueue::new();
        assert!(queue.is_empty());
        assert!(!queue.is_full());
        assert_eq!(queue.len(), 0);
        assert_eq!(queue.capacity(), 8);
    }

    #[test]
    fn test_priority_queue_send_receive() {
        let queue: PriorityQueue<u32, 8> = PriorityQueue::new();
        
        assert!(queue.send(100, 5).is_ok());
        assert!(queue.send(200, 1).is_ok());
        assert!(queue.send(300, 3).is_ok());
        
        assert_eq!(queue.len(), 3);
        
        // Should receive in priority order: 200, 300, 100
        assert_eq!(queue.receive(), Some(200));
        assert_eq!(queue.receive(), Some(300));
        assert_eq!(queue.receive(), Some(100));
        assert_eq!(queue.receive(), None);
    }

    #[test]
    fn test_priority_queue_peek() {
        let queue: PriorityQueue<u32, 8> = PriorityQueue::new();
        
        queue.send(100, 5).ok();
        queue.send(200, 1).ok();
        
        // Peek should return highest priority without removing
        assert_eq!(queue.peek(), Some(200));
        assert_eq!(queue.len(), 2);
        
        // Peek with priority
        assert_eq!(queue.peek_with_priority(), Some((200, 1)));
    }

    #[test]
    fn test_priority_queue_full() {
        let queue: PriorityQueue<u32, 4> = PriorityQueue::new();
        
        assert!(queue.send(1, 1).is_ok());
        assert!(queue.send(2, 2).is_ok());
        assert!(queue.send(3, 3).is_ok());
        assert!(queue.send(4, 4).is_ok());
        
        assert!(queue.is_full());
        
        // Should fail when full
        assert!(queue.send(5, 5).is_err());
    }

    #[test]
    fn test_priority_queue_clear() {
        let queue: PriorityQueue<u32, 8> = PriorityQueue::new();
        
        queue.send(100, 1).ok();
        queue.send(200, 2).ok();
        
        queue.clear();
        
        assert!(queue.is_empty());
        assert_eq!(queue.len(), 0);
    }

    #[test]
    fn test_priority_queue_same_priority() {
        let queue: PriorityQueue<u32, 8> = PriorityQueue::new();
        
        // Same priority - should maintain FIFO order
        queue.send(100, 5).ok();
        queue.send(200, 5).ok();
        queue.send(300, 5).ok();
        
        assert_eq!(queue.receive(), Some(100));
        assert_eq!(queue.receive(), Some(200));
        assert_eq!(queue.receive(), Some(300));
    }
}
