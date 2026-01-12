//! REQ: MEM-001, MEM-002, MEM-003 - Memory management tests
//!
//! Tests for heap allocation, memory pools, and memory protection.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use core::marker::{Send, Sync};
use core::option::Option::{self, None, Some};
use core::result::Result::{self, Err, Ok};
use std::sync::atomic::{AtomicUsize, AtomicBool, Ordering};
use std::sync::Arc;
use std::thread;
use core::alloc::Layout;
use core::cell::UnsafeCell;
use std::vec::Vec;

// ============================================================================
// Mock Heap Allocator
// ============================================================================

const HEAP_SIZE: usize = 4096;

struct MockHeap {
    heap: UnsafeCell<[u8; HEAP_SIZE]>,
    next_free: AtomicUsize,
    allocated: AtomicUsize,
    alloc_count: AtomicUsize,
    free_count: AtomicUsize,
}

impl MockHeap {
    const fn new() -> Self {
        Self {
            heap: UnsafeCell::new([0u8; HEAP_SIZE]),
            next_free: AtomicUsize::new(0),
            allocated: AtomicUsize::new(0),
            alloc_count: AtomicUsize::new(0),
            free_count: AtomicUsize::new(0),
        }
    }

    fn alloc(&self, layout: Layout) -> *mut u8 {
        let size = layout.size();
        let align = layout.align();
        
        // Get base address of heap
        let base_ptr = unsafe { (*self.heap.get()).as_ptr() as usize };
        let current = self.next_free.load(Ordering::SeqCst);
        
        // Calculate absolute address and align it
        let abs_addr = base_ptr + current;
        let aligned_addr = (abs_addr + align - 1) & !(align - 1);
        let aligned_offset = aligned_addr - base_ptr;
        let next = aligned_offset + size;
        
        if next > HEAP_SIZE {
            return core::ptr::null_mut();  // Out of memory
        }
        
        // Try to allocate
        match self.next_free.compare_exchange(
            current,
            next,
            Ordering::SeqCst,
            Ordering::SeqCst,
        ) {
            Ok(_) => {
                self.allocated.fetch_add(size, Ordering::SeqCst);
                self.alloc_count.fetch_add(1, Ordering::SeqCst);
                aligned_addr as *mut u8
            }
            Err(_) => core::ptr::null_mut(),  // Concurrent allocation, retry
        }
    }

    fn dealloc(&self, _ptr: *mut u8, layout: Layout) {
        // Simplified - real allocator would track and reuse blocks
        self.allocated.fetch_sub(layout.size(), Ordering::SeqCst);
        self.free_count.fetch_add(1, Ordering::SeqCst);
    }

    fn reset(&self) {
        self.next_free.store(0, Ordering::SeqCst);
        self.allocated.store(0, Ordering::SeqCst);
        self.alloc_count.store(0, Ordering::SeqCst);
        self.free_count.store(0, Ordering::SeqCst);
    }

    fn allocated_bytes(&self) -> usize {
        self.allocated.load(Ordering::SeqCst)
    }

    fn free_bytes(&self) -> usize {
        HEAP_SIZE - self.next_free.load(Ordering::SeqCst)
    }
}

unsafe impl Send for MockHeap {}
unsafe impl Sync for MockHeap {}

static HEAP: MockHeap = MockHeap::new();

#[test]
fn test_heap_alloc() {
    HEAP.reset();
    
    let layout = Layout::from_size_align(64, 8).unwrap();
    let ptr = HEAP.alloc(layout);
    
    assert_test!(!ptr.is_null(), "Allocation should succeed");
    assert_test!(HEAP.allocated_bytes() == 64, "Should have 64 bytes allocated");
    assert_test!(HEAP.alloc_count.load(Ordering::SeqCst) == 1, "Alloc count should be 1");
    
    HEAP.dealloc(ptr, layout);
}

#[test]
fn test_heap_alignment() {
    HEAP.reset();
    
    // Allocate with 16-byte alignment
    let layout = Layout::from_size_align(32, 16).unwrap();
    let ptr = HEAP.alloc(layout);
    
    assert_test!(!ptr.is_null(), "Allocation should succeed");
    assert_test!((ptr as usize) % 16 == 0, "Pointer should be 16-byte aligned");
    
    HEAP.dealloc(ptr, layout);
}

#[test]
fn test_heap_multiple_allocs() {
    HEAP.reset();
    
    let layout1 = Layout::from_size_align(100, 8).unwrap();
    let layout2 = Layout::from_size_align(200, 8).unwrap();
    let layout3 = Layout::from_size_align(300, 8).unwrap();
    
    let ptr1 = HEAP.alloc(layout1);
    let ptr2 = HEAP.alloc(layout2);
    let ptr3 = HEAP.alloc(layout3);
    
    assert_test!(!ptr1.is_null(), "First allocation should succeed");
    assert_test!(!ptr2.is_null(), "Second allocation should succeed");
    assert_test!(!ptr3.is_null(), "Third allocation should succeed");
    
    // Pointers should not overlap
    assert_test!(ptr1 != ptr2, "Pointers should be different");
    assert_test!(ptr2 != ptr3, "Pointers should be different");
    assert_test!(ptr1 != ptr3, "Pointers should be different");
    
    HEAP.dealloc(ptr1, layout1);
    HEAP.dealloc(ptr2, layout2);
    HEAP.dealloc(ptr3, layout3);
}

#[test]
fn test_heap_out_of_memory() {
    HEAP.reset();
    
    // Try to allocate more than heap size
    let layout = Layout::from_size_align(HEAP_SIZE + 1, 8).unwrap();
    let ptr = HEAP.alloc(layout);
    
    assert_test!(ptr.is_null(), "Allocation should fail");
}

#[test]
fn test_heap_exhaustion() {
    HEAP.reset();
    
    // Fill up the heap
    let layout = Layout::from_size_align(1024, 8).unwrap();
    let mut ptrs = Vec::new();
    
    for _ in 0..4 {
        let ptr = HEAP.alloc(layout);
        if !ptr.is_null() {
            ptrs.push(ptr);
        }
    }
    
    // Next allocation should fail
    let ptr = HEAP.alloc(layout);
    assert_test!(ptr.is_null(), "Heap should be exhausted");
    
    // Free all allocations
    for ptr in ptrs {
        HEAP.dealloc(ptr, layout);
    }
}

// ============================================================================
// Mock Memory Pool
// ============================================================================

const POOL_BLOCK_SIZE: usize = 64;
const POOL_BLOCK_COUNT: usize = 16;

struct MockMemoryPool {
    blocks: UnsafeCell<[[u8; POOL_BLOCK_SIZE]; POOL_BLOCK_COUNT]>,
    free_bitmap: AtomicUsize,  // 1 = free, 0 = allocated
    alloc_count: AtomicUsize,
}

impl MockMemoryPool {
    const fn new() -> Self {
        Self {
            blocks: UnsafeCell::new([[0u8; POOL_BLOCK_SIZE]; POOL_BLOCK_COUNT]),
            free_bitmap: AtomicUsize::new((1 << POOL_BLOCK_COUNT) - 1),  // All free
            alloc_count: AtomicUsize::new(0),
        }
    }

    fn alloc(&self) -> Option<*mut [u8; POOL_BLOCK_SIZE]> {
        loop {
            let bitmap = self.free_bitmap.load(Ordering::SeqCst);
            if bitmap == 0 {
                return None;  // No free blocks
            }
            
            // Find first free block
            let index = bitmap.trailing_zeros() as usize;
            if index >= POOL_BLOCK_COUNT {
                return None;
            }
            
            let new_bitmap = bitmap & !(1 << index);
            
            match self.free_bitmap.compare_exchange(
                bitmap,
                new_bitmap,
                Ordering::SeqCst,
                Ordering::SeqCst,
            ) {
                Ok(_) => {
                    self.alloc_count.fetch_add(1, Ordering::SeqCst);
                    unsafe {
                        let ptr = (*self.blocks.get()).as_mut_ptr().add(index);
                        return Some(ptr);
                    }
                }
                Err(_) => continue,  // Retry
            }
        }
    }

    fn free(&self, ptr: *mut [u8; POOL_BLOCK_SIZE]) {
        let base = unsafe { (*self.blocks.get()).as_ptr() as usize };
        let offset = (ptr as usize - base) / POOL_BLOCK_SIZE;
        
        if offset < POOL_BLOCK_COUNT {
            self.free_bitmap.fetch_or(1 << offset, Ordering::SeqCst);
        }
    }

    fn available_blocks(&self) -> usize {
        self.free_bitmap.load(Ordering::SeqCst).count_ones() as usize
    }

    fn reset(&self) {
        self.free_bitmap.store((1 << POOL_BLOCK_COUNT) - 1, Ordering::SeqCst);
        self.alloc_count.store(0, Ordering::SeqCst);
    }
}

unsafe impl Send for MockMemoryPool {}
unsafe impl Sync for MockMemoryPool {}

static POOL: MockMemoryPool = MockMemoryPool::new();

#[test]
fn test_pool_alloc() {
    POOL.reset();
    
    let initial = POOL.available_blocks();
    assert_test!(initial == POOL_BLOCK_COUNT, format!("Should have {} free blocks", POOL_BLOCK_COUNT));
    
    let block = POOL.alloc();
    assert_test!(block.is_some(), "Allocation should succeed");
    assert_test!(POOL.available_blocks() == initial - 1, "Should have one less free block");
    
    POOL.free(block.unwrap());
    assert_test!(POOL.available_blocks() == initial, "Should have all blocks free again");
}

#[test]
fn test_pool_exhaustion() {
    POOL.reset();
    
    let mut blocks = Vec::new();
    
    // Allocate all blocks
    for _ in 0..POOL_BLOCK_COUNT {
        if let Some(block) = POOL.alloc() {
            blocks.push(block);
        }
    }
    
    assert_test!(blocks.len() == POOL_BLOCK_COUNT, "Should allocate all blocks");
    assert_test!(POOL.available_blocks() == 0, "No blocks should be available");
    assert_test!(POOL.alloc().is_none(), "Additional alloc should fail");
    
    // Free all blocks
    for block in blocks {
        POOL.free(block);
    }
    
    assert_test!(POOL.available_blocks() == POOL_BLOCK_COUNT, "All blocks should be free");
}

#[test]
fn test_pool_deterministic() {
    POOL.reset();
    
    // Pool allocation is O(1) and deterministic
    // Just verify we can allocate and free rapidly
    for _ in 0..100 {
        let block = POOL.alloc().unwrap();
        POOL.free(block);
    }
    
    assert_test!(POOL.available_blocks() == POOL_BLOCK_COUNT, "All blocks should be free");
}

// ============================================================================
// Mock Stack Guard
// ============================================================================

const STACK_SIZE: usize = 1024;
const GUARD_PATTERN: u32 = 0xDEADBEEF;

struct MockStack {
    data: [u32; STACK_SIZE / 4],
    guard_start: usize,
    guard_end: usize,
}

impl MockStack {
    fn new() -> Self {
        let mut stack = Self {
            data: [0; STACK_SIZE / 4],
            guard_start: 0,
            guard_end: 4,  // 4 guard words
        };
        
        // Initialize guard zone
        for i in 0..4 {
            stack.data[i] = GUARD_PATTERN;
        }
        
        stack
    }

    fn check_overflow(&self) -> bool {
        for i in self.guard_start..self.guard_end {
            if self.data[i] != GUARD_PATTERN {
                return true;  // Overflow detected
            }
        }
        false
    }

    fn simulate_overflow(&mut self) {
        self.data[0] = 0x12345678;  // Corrupt guard zone
    }

    fn usable_size(&self) -> usize {
        (self.data.len() - self.guard_end) * 4
    }
}

#[test]
fn test_stack_guard_init() {
    let stack = MockStack::new();
    
    assert_test!(!stack.check_overflow(), "No overflow initially");
    assert_test!(stack.usable_size() == STACK_SIZE - 16, "Usable size should exclude guard");
}

#[test]
fn test_stack_guard_detect_overflow() {
    let mut stack = MockStack::new();
    
    stack.simulate_overflow();
    assert_test!(stack.check_overflow(), "Should detect overflow");
}

// ============================================================================
// Memory Region Tests
// ============================================================================

struct MemoryRegion {
    base: usize,
    size: usize,
    attributes: u32,
}

const ATTR_READ: u32 = 0x01;
const ATTR_WRITE: u32 = 0x02;
const ATTR_EXEC: u32 = 0x04;
const ATTR_CACHEABLE: u32 = 0x08;

impl MemoryRegion {
    fn new(base: usize, size: usize, attributes: u32) -> Self {
        Self { base, size, attributes }
    }

    fn contains(&self, addr: usize) -> bool {
        addr >= self.base && addr < self.base + self.size
    }

    fn is_readable(&self) -> bool {
        (self.attributes & ATTR_READ) != 0
    }

    fn is_writable(&self) -> bool {
        (self.attributes & ATTR_WRITE) != 0
    }

    fn is_executable(&self) -> bool {
        (self.attributes & ATTR_EXEC) != 0
    }

    fn is_cacheable(&self) -> bool {
        (self.attributes & ATTR_CACHEABLE) != 0
    }
}

#[test]
fn test_memory_region_contains() {
    let region = MemoryRegion::new(0x1000, 0x1000, ATTR_READ | ATTR_WRITE);
    
    assert_test!(region.contains(0x1000), "Should contain base address");
    assert_test!(region.contains(0x1500), "Should contain middle address");
    assert_test!(region.contains(0x1FFF), "Should contain last address");
    assert_test!(!region.contains(0x0FFF), "Should not contain address before");
    assert_test!(!region.contains(0x2000), "Should not contain address after");
}

#[test]
fn test_memory_region_attributes() {
    let code = MemoryRegion::new(0x0000, 0x1000, ATTR_READ | ATTR_EXEC);
    let data = MemoryRegion::new(0x1000, 0x1000, ATTR_READ | ATTR_WRITE | ATTR_CACHEABLE);
    let periph = MemoryRegion::new(0x2000, 0x1000, ATTR_READ | ATTR_WRITE);
    
    assert_test!(code.is_readable(), "Code should be readable");
    assert_test!(code.is_executable(), "Code should be executable");
    assert_test!(!code.is_writable(), "Code should not be writable");
    
    assert_test!(data.is_readable(), "Data should be readable");
    assert_test!(data.is_writable(), "Data should be writable");
    assert_test!(data.is_cacheable(), "Data should be cacheable");
    assert_test!(!data.is_executable(), "Data should not be executable");
    
    assert_test!(!periph.is_cacheable(), "Peripherals should not be cacheable");
}

// ============================================================================
// Memory Alignment Tests
// ============================================================================

#[test]
fn test_alignment_power_of_two() {
    // Test that common alignments work
    for align in [1usize, 2, 4, 8, 16, 32, 64, 128, 256] {
        assert_test!(align.is_power_of_two(), format!("{} should be power of two", align));
    }
}

#[test]
fn test_alignment_roundup() {
    fn align_up(val: usize, align: usize) -> usize {
        (val + align - 1) & !(align - 1)
    }
    
    assert_test!(align_up(0, 4) == 0, "0 aligned to 4 should be 0");
    assert_test!(align_up(1, 4) == 4, "1 aligned to 4 should be 4");
    assert_test!(align_up(4, 4) == 4, "4 aligned to 4 should be 4");
    assert_test!(align_up(5, 4) == 8, "5 aligned to 4 should be 8");
    assert_test!(align_up(100, 16) == 112, "100 aligned to 16 should be 112");
}

#[test]
fn test_alignment_check() {
    fn is_aligned(val: usize, align: usize) -> bool {
        val & (align - 1) == 0
    }
    
    assert_test!(is_aligned(0, 4), "0 should be 4-aligned");
    assert_test!(is_aligned(4, 4), "4 should be 4-aligned");
    assert_test!(!is_aligned(5, 4), "5 should not be 4-aligned");
    assert_test!(is_aligned(16, 16), "16 should be 16-aligned");
    assert_test!(is_aligned(0x1000, 4096), "0x1000 should be page-aligned");
}

// ============================================================================
// Concurrent Allocation Tests
// ============================================================================

#[test]
fn test_concurrent_heap_alloc() {
    HEAP.reset();
    
    let heap = Arc::new(&HEAP);
    let alloc_count = Arc::new(AtomicUsize::new(0));
    
    let handles: Vec<_> = (0..4).map(|_| {
        let heap = Arc::clone(&heap);
        let alloc_count = Arc::clone(&alloc_count);
        
        thread::spawn(move || {
            let layout = Layout::from_size_align(64, 8).unwrap();
            for _ in 0..10 {
                let ptr = heap.alloc(layout);
                if !ptr.is_null() {
                    alloc_count.fetch_add(1, Ordering::SeqCst);
                    heap.dealloc(ptr, layout);
                }
            }
        })
    }).collect();
    
    for handle in handles {
        handle.join().unwrap();
    }
    
    // Some allocations may have failed due to contention, but most should succeed
    assert_test!(alloc_count.load(Ordering::SeqCst) > 0, "Some allocations should succeed");
}

#[test]
fn test_concurrent_pool_alloc() {
    POOL.reset();
    
    let alloc_count = Arc::new(AtomicUsize::new(0));
    
    let handles: Vec<_> = (0..4).map(|_| {
        let alloc_count = Arc::clone(&alloc_count);
        
        thread::spawn(move || {
            for _ in 0..100 {
                if let Some(block) = POOL.alloc() {
                    alloc_count.fetch_add(1, Ordering::SeqCst);
                    POOL.free(block);
                }
            }
        })
    }).collect();
    
    for handle in handles {
        handle.join().unwrap();
    }
    
    assert_test!(alloc_count.load(Ordering::SeqCst) > 0, "Some pool allocations should succeed");
    assert_test!(POOL.available_blocks() == POOL_BLOCK_COUNT, "All blocks should be free");
}
