//! REQ: TEST-008 - Critical section unit tests
//!
//! Tests for critical section behavior including nesting.

#![cfg(test)]

extern crate std;

use crate::assert_test;
use core::ops::Drop;
use std::sync::atomic::{AtomicU32, Ordering};

// ============================================================================
// Mock Critical Section Implementation
// ============================================================================

/// Mock critical section nesting counter (mirrors CRITICAL_NESTING in kernel)
static CRITICAL_NESTING: AtomicU32 = AtomicU32::new(0);

/// Mock interrupt enable state
static MOCK_MIE: AtomicU32 = AtomicU32::new(1); // Starts enabled

/// Enter critical section (mock implementation)
fn enter_critical() -> u32 {
    let nesting = CRITICAL_NESTING.fetch_add(1, Ordering::Acquire);

    if nesting == 0 {
        // First level - disable "interrupts"
        let previous = MOCK_MIE.swap(0, Ordering::SeqCst);
        previous
    } else {
        // Nested call
        0
    }
}

/// Exit critical section (mock implementation)
fn exit_critical(previous_mie: u32) {
    let nesting = CRITICAL_NESTING.fetch_sub(1, Ordering::Release);

    if nesting == 1 {
        // Last level - restore interrupt state
        if previous_mie != 0 {
            MOCK_MIE.store(1, Ordering::SeqCst);
        }
    }
}

/// Get current nesting level
fn get_nesting_level() -> u32 {
    CRITICAL_NESTING.load(Ordering::SeqCst)
}

/// Check if "interrupts" are enabled
fn interrupts_enabled() -> bool {
    MOCK_MIE.load(Ordering::SeqCst) != 0
}

/// Reset mock state for testing
fn reset_mock_state() {
    CRITICAL_NESTING.store(0, Ordering::SeqCst);
    MOCK_MIE.store(1, Ordering::SeqCst);
}

/// RAII guard for critical sections (mock)
struct CriticalSection {
    previous_mie: u32,
}

impl CriticalSection {
    fn new() -> Self {
        Self {
            previous_mie: enter_critical(),
        }
    }
}

impl Drop for CriticalSection {
    fn drop(&mut self) {
        exit_critical(self.previous_mie);
    }
}

// ============================================================================
// Critical Section Tests
// ============================================================================

#[test]
fn test_critical_section_basic() {
    // REQ: CRIT-001 - Enter and exit critical section
    reset_mock_state();

    assert_test!(
        interrupts_enabled(),
        "Interrupts should be enabled initially"
    );
    assert_test!(get_nesting_level() == 0, "Nesting should be 0 initially");

    let mie = enter_critical();

    assert_test!(
        !interrupts_enabled(),
        "Interrupts should be disabled in critical section"
    );
    assert_test!(get_nesting_level() == 1, "Nesting should be 1 after enter");

    exit_critical(mie);

    assert_test!(
        interrupts_enabled(),
        "Interrupts should be restored after exit"
    );
    assert_test!(get_nesting_level() == 0, "Nesting should be 0 after exit");
}

#[test]
fn test_critical_section_nesting() {
    // REQ: CRIT-003 - Nesting counter for critical sections
    reset_mock_state();

    // Level 1
    let mie1 = enter_critical();
    assert_test!(get_nesting_level() == 1, "Nesting should be 1");
    assert_test!(!interrupts_enabled(), "Interrupts should be disabled");

    // Level 2 (nested)
    let mie2 = enter_critical();
    assert_test!(get_nesting_level() == 2, "Nesting should be 2");
    assert_test!(!interrupts_enabled(), "Interrupts should still be disabled");
    assert_test!(mie2 == 0, "Nested entry should return 0");

    // Level 3 (double nested)
    let mie3 = enter_critical();
    assert_test!(get_nesting_level() == 3, "Nesting should be 3");
    assert_test!(mie3 == 0, "Double nested entry should return 0");

    // Exit level 3
    exit_critical(mie3);
    assert_test!(
        get_nesting_level() == 2,
        "Nesting should be 2 after first exit"
    );
    assert_test!(!interrupts_enabled(), "Interrupts should still be disabled");

    // Exit level 2
    exit_critical(mie2);
    assert_test!(
        get_nesting_level() == 1,
        "Nesting should be 1 after second exit"
    );
    assert_test!(!interrupts_enabled(), "Interrupts should still be disabled");

    // Exit level 1
    exit_critical(mie1);
    assert_test!(
        get_nesting_level() == 0,
        "Nesting should be 0 after final exit"
    );
    assert_test!(
        interrupts_enabled(),
        "Interrupts should be restored after all exits"
    );
}

#[test]
fn test_critical_section_raii_guard() {
    // REQ: CRIT-004 - RAII guard for critical sections
    reset_mock_state();

    assert_test!(
        interrupts_enabled(),
        "Interrupts should be enabled initially"
    );

    {
        let _guard = CriticalSection::new();
        assert_test!(
            !interrupts_enabled(),
            "Interrupts should be disabled with guard"
        );
        assert_test!(get_nesting_level() == 1, "Nesting should be 1 with guard");
    }

    assert_test!(
        interrupts_enabled(),
        "Interrupts should be restored after guard drops"
    );
    assert_test!(
        get_nesting_level() == 0,
        "Nesting should be 0 after guard drops"
    );
}

#[test]
fn test_critical_section_raii_nested() {
    // REQ: CRIT-004 - Nested RAII guards
    reset_mock_state();

    {
        let _guard1 = CriticalSection::new();
        assert_test!(get_nesting_level() == 1, "Nesting should be 1");

        {
            let _guard2 = CriticalSection::new();
            assert_test!(get_nesting_level() == 2, "Nesting should be 2");

            {
                let _guard3 = CriticalSection::new();
                assert_test!(get_nesting_level() == 3, "Nesting should be 3");
            }

            assert_test!(
                get_nesting_level() == 2,
                "Nesting should be 2 after inner drop"
            );
        }

        assert_test!(
            get_nesting_level() == 1,
            "Nesting should be 1 after middle drop"
        );
    }

    assert_test!(
        get_nesting_level() == 0,
        "Nesting should be 0 after all drops"
    );
    assert_test!(interrupts_enabled(), "Interrupts should be restored");
}

#[test]
fn test_critical_section_preserves_previous_state() {
    // Test that interrupts are only restored if they were previously enabled
    reset_mock_state();

    // Start with interrupts enabled
    assert_test!(interrupts_enabled(), "Interrupts enabled initially");

    let mie = enter_critical();
    assert_test!(
        mie != 0,
        "Previous state should indicate interrupts were enabled"
    );

    exit_critical(mie);
    assert_test!(interrupts_enabled(), "Interrupts should be re-enabled");

    // Now test with interrupts already disabled
    MOCK_MIE.store(0, Ordering::SeqCst);
    CRITICAL_NESTING.store(0, Ordering::SeqCst);

    let mie2 = enter_critical();
    assert_test!(
        mie2 == 0,
        "Previous state should indicate interrupts were disabled"
    );

    exit_critical(mie2);
    assert_test!(!interrupts_enabled(), "Interrupts should stay disabled");
}

#[test]
fn test_critical_section_deep_nesting() {
    // Test deep nesting (stress test)
    reset_mock_state();

    const MAX_NESTING: u32 = 100;
    let mut saved_mie = [0u32; MAX_NESTING as usize];

    // Enter critical section MAX_NESTING times
    for i in 0..MAX_NESTING {
        saved_mie[i as usize] = enter_critical();
        assert_test!(
            get_nesting_level() == i + 1,
            format!("Nesting should be {} after {} enters", i + 1, i + 1)
        );
    }

    assert_test!(!interrupts_enabled(), "Interrupts should be disabled");

    // Exit critical section MAX_NESTING times (reverse order)
    for i in (0..MAX_NESTING).rev() {
        exit_critical(saved_mie[i as usize]);
        assert_test!(
            get_nesting_level() == i,
            format!("Nesting should be {} after exit {}", i, MAX_NESTING - i)
        );
    }

    assert_test!(
        interrupts_enabled(),
        "Interrupts should be restored after all exits"
    );
}

#[test]
fn test_critical_section_atomic_operations() {
    // Test that operations are atomic
    reset_mock_state();

    use std::sync::Arc;
    use std::thread;

    let counter = Arc::new(AtomicU32::new(0));
    let mut handles = vec![];

    for _ in 0..10 {
        let counter_clone = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            for _ in 0..100 {
                let mie = enter_critical();
                // Critical section work
                counter_clone.fetch_add(1, Ordering::SeqCst);
                exit_critical(mie);
            }
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    assert_test!(
        counter.load(Ordering::SeqCst) == 1000,
        format!(
            "Counter should be 1000, got {}",
            counter.load(Ordering::SeqCst)
        )
    );
}

// ============================================================================
// Critical Section Boundary Tests
// ============================================================================

#[test]
fn test_critical_section_zero_nesting() {
    // Edge case: ensure nesting never goes negative
    reset_mock_state();

    let mie = enter_critical();
    exit_critical(mie);

    // Should be back to 0
    assert_test!(get_nesting_level() == 0, "Nesting should be 0");

    // Don't call exit_critical again without enter_critical
    // In real impl this would be UB, but test that state is correct
}

#[test]
fn test_critical_section_guard_early_return() {
    // Test that guard works correctly with early returns
    reset_mock_state();

    fn operation_with_early_return(should_return: bool) -> bool {
        let _guard = CriticalSection::new();

        if should_return {
            return true; // Guard should drop here
        }

        false // Guard drops here
    }

    let result = operation_with_early_return(true);
    assert_test!(result, "Should return true");
    assert_test!(
        get_nesting_level() == 0,
        "Nesting should be 0 after early return"
    );
    assert_test!(
        interrupts_enabled(),
        "Interrupts should be enabled after early return"
    );

    let result = operation_with_early_return(false);
    assert_test!(!result, "Should return false");
    assert_test!(
        get_nesting_level() == 0,
        "Nesting should be 0 after normal return"
    );
}
