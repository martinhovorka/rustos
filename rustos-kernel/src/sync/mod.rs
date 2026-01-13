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

pub mod event_flags;
pub mod message_queue;
pub mod mutex;
pub mod priority_queue;
pub mod semaphore; // REQ: MQ-009 - Priority-based message queue

pub use event_flags::EventFlags;
pub use message_queue::MessageQueue;
pub use mutex::Mutex;
pub use priority_queue::PriorityQueue;
pub use semaphore::Semaphore;

#[cfg(feature = "diagnostics")]
use crate::task::TaskId;

#[cfg(feature = "diagnostics")]
use crate::critical::CriticalSection;

#[cfg(feature = "diagnostics")]
use core::cell::UnsafeCell;

/// REQ: DIAG-002 - Mutex identifier for diagnostics
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
#[repr(transparent)]
pub struct MutexId(pub u8);

/// REQ: DIAG-002 - Get mutex owner (for diagnostics)
///
/// Returns None if mutex ID is invalid or mutex is not locked.
/// Safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_mutex_owner(mutex_id: MutexId) -> Option<TaskId> {
    let _cs = CriticalSection::new();

    // SAFETY: Registry access is serialized by CriticalSection. The registry uses interior
    // mutability via UnsafeCell.
    unsafe {
        let idx = mutex_id.0 as usize;
        if idx >= MAX_DIAG_MUTEXES {
            return None;
        }

        let registry = &*MUTEX_REGISTRY.0.get();
        let entry = registry[idx]?;

        // SAFETY: The entry was created by register_mutex(), which guarantees ctx and owner_fn
        // are valid for the lifetime of the program.
        (entry.owner_fn)(entry.ctx)
    }
}

/// REQ: DIAG-003 - Get queue message count (for diagnostics)
///
/// Returns None if queue ID is invalid.
/// Safe to call from ISR context.
#[cfg(feature = "diagnostics")]
pub fn get_queue_count(queue_id: u8) -> Option<usize> {
    let _cs = CriticalSection::new();

    // SAFETY: Registry access is serialized by CriticalSection. The registry uses interior
    // mutability via UnsafeCell.
    unsafe {
        let idx = queue_id as usize;
        if idx >= MAX_DIAG_QUEUES {
            return None;
        }

        let registry = &*QUEUE_REGISTRY.0.get();
        let entry = registry[idx]?;

        // SAFETY: The entry was created by register_queue(), which guarantees ctx and len_fn
        // are valid for the lifetime of the program.
        Some((entry.len_fn)(entry.ctx))
    }
}

/// REQ: DIAG-002 - Register a mutex for diagnostics queries
///
/// Returns a stable `MutexId` that can be used with `get_mutex_owner()`.
///
/// Notes:
/// - Registration is optional; unregistered mutexes cannot be queried by ID.
/// - Safe to call from ISR context; uses a critical section.
#[cfg(feature = "diagnostics")]
pub fn register_mutex<T>(mutex: &'static Mutex<T>) -> Option<MutexId> {
    let _cs = CriticalSection::new();

    // SAFETY: Access to the diagnostics registry is protected by CriticalSection.
    unsafe {
        let registry = &mut *MUTEX_REGISTRY.0.get();
        for (idx, slot) in registry.iter_mut().enumerate() {
            if slot.is_none() {
                *slot = Some(MutexRegistryEntry {
                    ctx: mutex as *const Mutex<T> as *const (),
                    owner_fn: mutex_owner::<T>,
                });
                return Some(MutexId(idx as u8));
            }
        }
    }

    None
}

/// REQ: DIAG-003 - Register a message queue for diagnostics queries
///
/// Returns a stable queue ID that can be used with `get_queue_count()`.
///
/// Notes:
/// - Registration is optional; unregistered queues cannot be queried by ID.
/// - Safe to call from ISR context; uses a critical section.
#[cfg(feature = "diagnostics")]
pub fn register_queue<T, const N: usize>(queue: &'static MessageQueue<T, N>) -> Option<u8> {
    let _cs = CriticalSection::new();

    // SAFETY: Access to the diagnostics registry is protected by CriticalSection.
    unsafe {
        let registry = &mut *QUEUE_REGISTRY.0.get();
        for (idx, slot) in registry.iter_mut().enumerate() {
            if slot.is_none() {
                *slot = Some(QueueRegistryEntry {
                    ctx: queue as *const MessageQueue<T, N> as *const (),
                    len_fn: queue_len::<T, N>,
                });
                return Some(idx as u8);
            }
        }
    }

    None
}

/// REQ: DIAG-002 - Maximum number of mutexes tracked for diagnostics
#[cfg(feature = "diagnostics")]
const MAX_DIAG_MUTEXES: usize = 32;

/// REQ: DIAG-003 - Maximum number of queues tracked for diagnostics
#[cfg(feature = "diagnostics")]
const MAX_DIAG_QUEUES: usize = 32;

/// REQ: DIAG-002 - Diagnostics registry entry for mutex owner queries
#[cfg(feature = "diagnostics")]
#[derive(Clone, Copy)]
struct MutexRegistryEntry {
    ctx: *const (),
    owner_fn: unsafe fn(*const ()) -> Option<TaskId>,
}

/// REQ: DIAG-003 - Diagnostics registry entry for queue depth queries
#[cfg(feature = "diagnostics")]
#[derive(Clone, Copy)]
struct QueueRegistryEntry {
    ctx: *const (),
    len_fn: unsafe fn(*const ()) -> usize,
}

/// REQ: DIAG-002, DIAG-006 - UnsafeCell-backed registry for ISR-safe diagnostics
///
/// SAFETY: Provides interior mutability for static registries. All accesses must be serialized
/// via `CriticalSection`, making it safe to share across contexts.
#[cfg(feature = "diagnostics")]
struct SyncRegistry<T>(UnsafeCell<T>);

// SAFETY: Access to the inner value is serialized via CriticalSection.
#[cfg(feature = "diagnostics")]
unsafe impl<T> Sync for SyncRegistry<T> {}

/// REQ: DIAG-002 - Mutex registry storage (feature-gated)
#[cfg(feature = "diagnostics")]
static MUTEX_REGISTRY: SyncRegistry<[Option<MutexRegistryEntry>; MAX_DIAG_MUTEXES]> =
    SyncRegistry(UnsafeCell::new([None; MAX_DIAG_MUTEXES]));

/// REQ: DIAG-003 - Queue registry storage (feature-gated)
#[cfg(feature = "diagnostics")]
static QUEUE_REGISTRY: SyncRegistry<[Option<QueueRegistryEntry>; MAX_DIAG_QUEUES]> =
    SyncRegistry(UnsafeCell::new([None; MAX_DIAG_QUEUES]));

/// REQ: DIAG-002 - Registry owner accessor
///
/// SAFETY: `ctx` must point to a valid `Mutex<T>` registered via `register_mutex()`.
#[cfg(feature = "diagnostics")]
unsafe fn mutex_owner<T>(ctx: *const ()) -> Option<TaskId> {
    let mutex = &*(ctx as *const Mutex<T>);
    mutex.owner()
}

/// REQ: DIAG-003 - Registry length accessor
///
/// SAFETY: `ctx` must point to a valid `MessageQueue<T, N>` registered via `register_queue()`.
#[cfg(feature = "diagnostics")]
unsafe fn queue_len<T, const N: usize>(ctx: *const ()) -> usize {
    let queue = &*(ctx as *const MessageQueue<T, N>);
    queue.len()
}
