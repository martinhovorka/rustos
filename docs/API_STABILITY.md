# RustOS API Stability Guide

## Overview

This document describes the API stability policy for RustOS, following semantic versioning (semver) principles.

**Current Version:** 0.1.0 (Pre-1.0 Development)

## Stability Categories

### Stable APIs

**Definition**: Public APIs that follow semver guarantees. After 1.0 release, breaking changes require a major version bump.

**Current Stable Modules** (as of 0.1.0):

#### Core Kernel APIs
- **`task`**: Task management
  - `Task`, `TaskId`, `TaskPriority`, `TaskState`
  - `Task::new()`, `TaskBuilder`
  - All public task methods

- **`scheduler`**: Scheduler control
  - `Scheduler::get()`, `enable()`, `disable()`
  - `add_task()`, `schedule()`
  - `start()` (entry point)

- **`sync`**: Synchronization primitives
  - `Mutex`, `Semaphore`, `MessageQueue`, `PriorityQueue`, `EventFlags`
  - All public synchronization methods
  - RAII guards

- **`time`**: Time management
  - `get_ticks()`, `get_uptime_ms()`
  - `delay_ms()`, `delay_ticks()`
  - `Timer` (basic one-shot mode)
  - `ticks_to_ms()`, `ms_to_ticks()`

- **`error`**: Error handling
  - `KernelError` enum
  - `Result<T>` type alias
  - Error code constants

- **`critical`**: Critical sections
  - `CriticalSection::new()`
  - Critical section RAII guard

#### Initialization APIs
- **`init()`**: Kernel initialization
- **`start()`**: Scheduler start

### Unstable APIs (Feature-Gated)

**Definition**: Experimental or incomplete features. May change without warning. Require explicit opt-in via feature flags.

| Feature Flag | Module/API | Status | Notes |
|--------------|-----------|--------|-------|
| `statistics` | Context switch counting | Stable | Performance tracking |
| `diagnostics` | Runtime query APIs | Stable | Task stats, CPU usage |
| `timers` | Software timer callbacks | Stable | One-shot and periodic |
| `wfi-idle` | WFI power management | Stable | Hardware-dependent |
| `panic-led` | LED blink on panic | Stable | Board-specific |
| `panic-reset` | Watchdog reset on panic | Stable | Board-specific |
| `tickless` | Tickless idle mode | Stable | Dynamic tick suppression |
| `priority-inheritance` | Priority inheritance | Stable | Mutex priority boosting |

**Usage Example:**
```toml
[dependencies]
rustos-kernel = { version = "0.1", features = ["diagnostics", "statistics"] }
```

### Deprecated APIs

**Definition**: APIs marked for removal. Include migration guidance and removal timeline.

**Current Status:** No APIs are currently deprecated.

**Deprecation Policy (Post-1.0):**
- Deprecated APIs will be marked with `#[deprecated]` attribute
- Removal occurs in next major version (e.g., deprecated in 1.x, removed in 2.0)
- Migration guide provided in deprecation message
- Compile-time warnings issued

**Example (future):**
```rust
# [deprecated(since = "1.5.0", note = "Use `new_api()` instead. See migration guide.")]
pub fn old_api() { }
```

## Semantic Versioning Policy

### Pre-1.0 (Current: 0.x.x)
- **Breaking changes** may occur in minor versions (0.1 → 0.2)
- **New features** added in minor versions
- **Bug fixes** in patch versions
- Unstable APIs may change without notice

### Post-1.0 (Future: 1.x.x)
- **Major version** (1.x → 2.x): Breaking changes allowed
  - API signature changes
  - Behavior changes
  - Deprecation removals

- **Minor version** (1.0 → 1.1): New features, no breaking changes
  - New APIs added
  - New feature flags
  - Deprecation warnings

- **Patch version** (1.0.0 → 1.0.1): Bug fixes only
  - No API changes
  - No behavior changes (except bug fixes)
  - No new features

## API Documentation Requirements

### REQ: API-016 - Safety Documentation

All `unsafe` functions **must** document:

1. **Safety preconditions** - What must be true before calling
2. **Consequences of violation** - What happens if preconditions fail
3. **Example usage** - Correct usage pattern

**Example:**
```rust
/// # Safety
///
/// - Must be called exactly once during initialization
/// - Must be called with interrupts disabled
/// - No other kernel functions may be called before init()
///
/// Violating these results in undefined behavior:
/// - Race conditions on global data
/// - Incorrect scheduler state
pub unsafe fn init() { }
```

### Public API Documentation

All public APIs **must** include:

1. **Purpose** - What the function does
2. **Parameters** - Description of each parameter
3. **Return value** - What is returned and when
4. **Errors** - What errors can occur and why
5. **Examples** - Working code example
6. **Panics** - Conditions that cause panics (if any)

## Feature Flag Stability

### Feature Flag Policy

- **Additive only** - New features added, old features retained
- **Default features** - Minimal set (no optional features by default)
- **Breaking changes** - Require major version bump
- **Feature removal** - Must be deprecated first (1 major version)

### Current Feature Flags

| Flag | Default | Stability | Description |
|------|---------|-----------|-------------|
| None | ✅ | Stable | Core kernel only |
| `statistics` | ❌ | Unstable | Performance metrics |
| `diagnostics` | ❌ | Unstable | Runtime queries |
| `timers` | ❌ | Unstable | Timer callbacks |
| `wfi-idle` | ❌ | Unstable | Power management |
| `panic-led` | ❌ | Unstable | Panic LED blink |
| `panic-reset` | ❌ | Unstable | Panic watchdog reset |

## Migration Guides

### Upgrading Between Versions

#### 0.1.0 → 0.2.0 (Future)
*No migration required yet - first release*

#### Pre-1.0 → 1.0.0 (Future)
- All unstable APIs will be reviewed
- Stable APIs finalized
- Migration guide will be provided

## API Review Process

### Before 1.0 Release
1. Community feedback on unstable APIs
2. Real-world usage validation
3. Performance benchmarking
4. API consistency review
5. Documentation completeness check

### After 1.0 Release
- New APIs start as unstable (feature-gated)
- Stabilization requires:
  - Community review
  - Production usage
  - Documentation
  - Tests
- Stabilization decision in minor version release

## Stability Guarantees

### What We Guarantee (Post-1.0)

✅ **Stable APIs:**
- Function signatures won't change
- Behavior remains consistent
- Compile-time compatibility maintained

✅ **Error Types:**
- Error variants may be added (non-exhaustive)
- Existing variants won't be removed

✅ **Trait Implementations:**
- New trait impls may be added
- Existing impls won't be removed

### What We Don't Guarantee

❌ **Performance:**
- Implementation may be optimized
- Performance characteristics may change

❌ **Internal Implementation:**
- Internal data structures may change
- Private APIs may change

❌ **Unstable Features:**
- Feature-gated APIs may change
- No backwards compatibility

## Contact and Feedback

- **Issues**: GitHub issue tracker
- **Discussions**: GitHub discussions
- **API Proposals**: RFC process (post-1.0)

## Version History

| Version | Date | Status | Notes |
|---------|------|--------|-------|
| 0.1.0 | 2026-01-12 | Current | Initial release |

---

**REQ: API-013** - Stability attributes
**REQ: API-014** - Deprecation markers
**REQ: API-015** - Unstable API gates
**REQ: API-016** - Safety documentation

