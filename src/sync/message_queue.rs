//! Message Queue implementation
//!
//! Provides a fixed-size message queue for inter-task communication

use core::cell::UnsafeCell;
use core::mem::MaybeUninit;
use core::sync::atomic::{AtomicUsize, Ordering};

/// A fixed-size message queue
pub struct MessageQueue<T, const N: usize> {
    buffer: UnsafeCell<[MaybeUninit<T>; N]>,
    head: AtomicUsize,
    tail: AtomicUsize,
    count: AtomicUsize,
}

unsafe impl<T: Send, const N: usize> Send for MessageQueue<T, N> {}
unsafe impl<T: Send, const N: usize> Sync for MessageQueue<T, N> {}

impl<T, const N: usize> MessageQueue<T, N> {
    /// Create a new message queue
    pub const fn new() -> Self {
        // Helper to create array of MaybeUninit
        const fn make_array<T, const N: usize>() -> [MaybeUninit<T>; N] {
            // SAFETY: MaybeUninit<T> does not require initialization
            unsafe { MaybeUninit::<[MaybeUninit<T>; N]>::uninit().assume_init() }
        }
        
        Self {
            buffer: UnsafeCell::new(make_array()),
            head: AtomicUsize::new(0),
            tail: AtomicUsize::new(0),
            count: AtomicUsize::new(0),
        }
    }

    /// Send a message to the queue
    pub fn send(&self, message: T) -> Result<(), T> {
        critical_section::with(|_| {
            let count = self.count.load(Ordering::Acquire);
            if count >= N {
                return Err(message);
            }

            let tail = self.tail.load(Ordering::Acquire);
            unsafe {
                let buffer = &mut *self.buffer.get();
                buffer[tail].write(message);
            }

            let new_tail = (tail + 1) % N;
            self.tail.store(new_tail, Ordering::Release);
            self.count.fetch_add(1, Ordering::Release);

            Ok(())
        })
    }

    /// Receive a message from the queue
    pub fn receive(&self) -> Option<T> {
        critical_section::with(|_| {
            let count = self.count.load(Ordering::Acquire);
            if count == 0 {
                return None;
            }

            let head = self.head.load(Ordering::Acquire);
            let message = unsafe {
                let buffer = &mut *self.buffer.get();
                buffer[head].assume_init_read()
            };

            let new_head = (head + 1) % N;
            self.head.store(new_head, Ordering::Release);
            self.count.fetch_sub(1, Ordering::Release);

            Some(message)
        })
    }

    /// Try to send a message (non-blocking)
    pub fn try_send(&self, message: T) -> Result<(), T> {
        self.send(message)
    }

    /// Try to receive a message (non-blocking)
    pub fn try_receive(&self) -> Option<T> {
        self.receive()
    }

    /// Get the number of messages in the queue
    pub fn len(&self) -> usize {
        self.count.load(Ordering::Acquire)
    }

    /// Check if the queue is empty
    pub fn is_empty(&self) -> bool {
        self.len() == 0
    }

    /// Check if the queue is full
    pub fn is_full(&self) -> bool {
        self.len() >= N
    }

    /// Get the capacity of the queue
    pub const fn capacity(&self) -> usize {
        N
    }
}

impl<T, const N: usize> Drop for MessageQueue<T, N> {
    fn drop(&mut self) {
        // Drop all messages still in the queue
        // Limit iterations to prevent infinite loop
        let mut iterations = 0;
        while iterations < N {
            if self.receive().is_none() {
                break;
            }
            iterations += 1;
        }
    }
}
