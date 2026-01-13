# RustOS Quality Assurance Infrastructure

## Overview

The RustOS project uses a comprehensive, unified quality assurance system that covers all aspects of code quality, security, safety, and maintainability. All checks are consolidated into a single script: **`qa.sh`**.

## Quick Start

```bash
# Run all quality checks
./qa.sh

# Run with auto-fix where possible
./qa.sh --fix

# Run with detailed output
./qa.sh --verbose

# Generate markdown report
./qa.sh --report

# Run specific section only
./qa.sh --section 4  # Run only linting checks

# Combine options
./qa.sh --fix --verbose --report
```

## Check Sections

The QA script is organized into **13 comprehensive sections**:

| Section | Category | Requirements Covered |
|---------|----------|---------------------|
| 1 | **Code Formatting & Style** | QUAL-006 (rustfmt), naming conventions (CamelCase, snake_case), line length |
| 2 | **Build Verification** | BUILD-003 (RISC-V), TEST-001 (test suite build) |
| 3 | **Test Execution** | TEST-001, QUAL-020/021, COV-001 (≥80%), COV-006 (≥150 tests), COV-007/008 |
| 4 | **Code Linting** | QUAL-005 (clippy), pedantic lints, dead code, import organization |
| 5 | **Unsafe Code & Safety** | SAFE-002/007/008 (≤5%), VER-009 (Miri) |
| 6 | **Security Analysis** | TEST-012, SEC-002 (input validation), SEC-004 (outdated deps), secrets, build config |
| 7 | **Documentation** | QUAL-001 (doc comments), TODO/FIXME tracking |
| 8 | **Code Complexity** | QUAL-009 (complexity ≤15), QUAL-010 (length ≤100), RUST-006 (no recursion) |
| 9 | **Dependencies** | CI-006 (CHANGELOG), CI-008 (MSRV 1.82.0), unused deps, yanked crates |
| 10 | **Requirements Traceability** | VER-012 (REQ: tags), VER-014/015 (test naming convention) |
| 11 | **Binary Size Analysis** | CI-005, MEM-001 (≤64 KB target) |
| 12 | **Performance Benchmarks** | Context switch timing, scheduler metrics |
| 13 | **RTOS-Specific Checks** | QUAL-002/003/004 (thread safety, critical sections, atomics), ISR blocking, priority inheritance, stack checks |

## Requirements Coverage

The unified QA script satisfies the following requirements from [requirements/REQUIREMENTS.md](requirements/REQUIREMENTS.md):

### Quality Standards (QUAL-*)
- **QUAL-001**: Public API documentation comments
- **QUAL-002**: Thread-safety via Send/Sync traits
- **QUAL-003**: Critical section protection for shared state
- **QUAL-004**: Atomic operations for synchronization primitives
- **QUAL-005**: No clippy warnings
- **QUAL-006**: Consistent code formatting (rustfmt)
- **QUAL-007**: Unit tests per module
- **QUAL-009**: Cyclomatic complexity ≤ 15 per function
- **QUAL-010**: Function length ≤ 100 lines
- **QUAL-020**: Unit test coverage ≥ 80%
- **QUAL-021**: Integration tests for scheduler

### CI/CD Automation (CI-*)
- **CI-001**: GitHub Actions CI configuration
- **CI-002**: Automated builds
- **CI-003**: Automated test execution
- **CI-004**: Automated linting (clippy, rustfmt)
- **CI-005**: Binary size tracking
- **CI-006**: CHANGELOG validation for releases
- **CI-007**: Security vulnerability scanning
- **CI-008**: MSRV enforcement (Rust 1.82.0)
- **CI-009**: Test execution enforcement

### Testing & Coverage (TEST-*, COV-*)
- **TEST-001**: Unit test suite
- **TEST-010**: Code quality maintenance
- **TEST-012**: Security audit automation
- **TEST-013**: Automated linting
- **COV-001**: Code coverage ≥80%
- **COV-006**: Minimum ≥150 tests
- **COV-007**: Sync primitive tests ≥10 each
- **COV-008**: Scheduler tests ≥20

### Verification & Traceability (VER-*)
- **VER-008**: Static analysis with clippy
- **VER-009**: Miri validation for unsafe code
- **VER-012**: Test traceability via REQ: tags
- **VER-014**: Test naming convention verification
- **VER-015**: Automated traceability extraction

### Safety & Security (SAFE-*, SEC-*, MEM-*)
- **SAFE-001**: Written in safe Rust where possible
- **SAFE-002**: Unsafe code minimization
- **SAFE-007**: SAFETY comments for all unsafe code
- **SAFE-008**: Unsafe code percentage ≤5%
- **SEC-002**: Input validation on external data
- **SEC-004**: Dependency audit for vulnerabilities
- **MEM-001**: Memory footprint ≤ 64 KB

### Coding Standards (RUST-*)
- **RUST-006**: No recursion in safety-critical paths

## Output and Logging

All QA runs produce detailed logs in the `logs/qa/` directory:

```
logs/qa/
├── qa_report_20250117_143022.md    # Markdown report (--report flag)
├── fmt_20250117_143022.log          # Formatting check output
├── build_riscv_20250117_143022.log  # RISC-V build logs
├── test_20250117_143022.log         # Test execution logs
├── coverage_20250117_143022.log     # Code coverage report
├── clippy_*_20250117_143022.log     # Per-crate clippy output
├── geiger_20250117_143022.log       # Unsafe code analysis
├── audit_20250117_143022.log        # Dependency vulnerabilities
├── doc_20250117_143022.log          # Documentation build
├── udeps_20250117_143022.log        # Unused dependencies
└── bench_20250117_143022.log        # Performance benchmarks
```

## CI/CD Integration

The QA script is fully integrated into the GitHub Actions workflow (`.github/workflows/ci.yml`):

| Job | Command | Purpose |
|-----|---------|---------|
| `lint` | `./qa.sh --section 4` | Code linting only |
| `safety` | `./qa.sh --section 5 --report` | Unsafe code analysis |
| `security` | `./qa.sh --section 6 --report` | Security audit |
| `quality-gate` | `./qa.sh --report` | Comprehensive QA (all sections) |

All jobs upload logs as GitHub Actions artifacts with 30-day retention.

## Detailed Check Descriptions

### 1. Code Formatting & Style

- **Format check**: Validates all code conforms to rustfmt standards
- **Naming conventions**: Ensures snake_case for functions, types
- **Line length**: Detects lines exceeding 100 characters

**Fix mode**: Runs `cargo fmt --all` to auto-format

### 2. Build Verification

- **RISC-V build**: Compiles for `riscv32imac-unknown-none-elf` target
- **Test suite build**: Compiles `rustos-tests` for x86_64 host
- **Error/warning counting**: Tracks build diagnostics

### 3. Test Execution

- **Test runner**: Executes all tests with `--test-threads=1` (required for shared state)
- **Test metrics**: Counts passed/failed tests
- **Code coverage**: Uses `cargo-llvm-cov` to measure ≥80% target (REQ: COV-001)

### 4. Code Linting

- **Clippy (per-crate)**: Runs clippy with `-D warnings` for each workspace crate
- **Import organization**: Detects glob imports (`use foo::*`)
- **Dead code**: Identifies unused functions, variables
- **Pedantic lints**: Enforces strict Rust idioms (advisory, non-blocking)

### 5. Unsafe Code & Safety

- **cargo-geiger**: Counts unsafe functions, expressions, trait impls
- **SAFETY comments**: Verifies all unsafe blocks have `// SAFETY:` comments (REQ: SAFE-007)
- **Safety coverage**: Calculates documentation ratio (target ≥80%)
- **Per-crate breakdown**: Shows unsafe code distribution across crates

### 6. Security Analysis

- **Vulnerability scan**: `cargo-audit` against RustSec database
- **Forbidden patterns**: Searches for `.unwrap()`, `.expect()`, `panic!`, `todo!`, `unimplemented!`
- **No-std verification**: Ensures no `std::` usage in production code
- **Heap allocation**: Detects `Box`, `alloc::vec::Vec`, `alloc::string::String`
- **Memory safety**: Detects `transmute`, `mem::forget`, `MaybeUninit`, `static mut`
- **Raw pointers**: Counts raw pointer declarations
- **Supply chain**: Checks for yanked dependencies
- **Secrets**: Scans for hardcoded API keys, passwords, private keys
- **Build config**: Checks debug-assertions, overflow-checks, panic=abort, LTO
- **Security clippy**: Runs security-focused clippy lints

### 7. Documentation

- **Doc build**: Ensures `cargo doc` succeeds with no errors
- **Coverage by crate**: Measures doc comment ratio per crate
- **TODO tracking**: Counts TODO/FIXME/XXX/HACK comments

### 8. Code Complexity & Quality

- **Function length**: Identifies functions >100 lines (REQ: QUAL-010)
- **Deep nesting**: Detects excessive indentation (≥4 levels)
- **Cyclomatic complexity**: Warns on overly complex control flow
- **Recursion detection**: Identifies recursive functions (REQ: RUST-006)

### 9. Dependencies

- **MSRV check**: Verifies Rust version meets minimum 1.82.0 (REQ: CI-008)
- **Lock file age**: Alerts if `Cargo.lock` is >90 days old
- **Unused dependencies**: `cargo-udeps` finds declared but unused crates
- **Yanked crates**: Verifies no dependencies have been yanked
- **Dependency count**: Analyzes total package count

### 10. Requirements Traceability

- **REQ: tag coverage**: Counts traceability comments per crate
- **Requirements ratio**: Measures tags vs functions (target ≥50%)
- **Security requirement focus**: Highlights SAFE/SEC/MEM tags (REQ: VER-012)

### 11. Binary Size Analysis

- **ELF size**: Measures final binary size in KB
- **Memory constraint**: Validates ≤64 KB target (REQ: MEM-001)
- **Size breakdown**: Uses `rust-size` or `riscv64-elf-size` when available

### 12. Performance Benchmarks

- **Scheduler timing**: Context switch latency (target ≤5 µs)
- **Interrupt latency**: Response time (target ≤1 µs)
- **Benchmark suite**: Runs `rustos-tests/src/bin/bench.rs` if available

### 13. RTOS-Specific Checks

- **ISR blocking**: Detects blocking operations in interrupt handlers
- **Priority inheritance**: Verifies feature availability in kernel
- **Stack protection**: Checks stack-check feature configuration
- **Watchdog timer**: Verifies WDT integration
- **Critical sections**: Analyzes critical section usage patterns
- **Atomic operations**: Verifies proper use of atomics for thread safety
- **Task stacks**: Analyzes stack declarations

## Tool Installation

The QA script requires several cargo tools:

```bash
# Stable toolchain tools
cargo install cargo-audit        # Security vulnerability scanner
cargo install cargo-geiger       # Unsafe code counter
cargo install cargo-llvm-cov     # Code coverage

# Nightly toolchain tools
cargo +nightly install cargo-udeps --locked  # Unused dependency detector
```

Optional tools:
```bash
cargo install rust-size          # Binary size analyzer
```

## Exit Codes

- **0**: All checks passed (warnings allowed)
- **1**: One or more checks failed (errors found)

## Advanced Usage

### Running Specific Checks

```bash
# Only check formatting
./qa.sh --section 1

# Only run security analysis
./qa.sh --section 6 --verbose

# Only check requirements traceability
./qa.sh --section 10
```

### Automation Examples

```bash
# Pre-commit hook (fast checks)
./qa.sh --section 1 --section 4 --fix

# Pre-push hook (tests + lints)
./qa.sh --section 2 --section 3 --section 4

# Nightly full audit
./qa.sh --report --verbose > qa_nightly.log 2>&1
```

### CI/CD Optimization

GitHub Actions caches cargo artifacts between runs. For fastest CI:

1. **Build job**: Compiles once, uploads binary artifact
2. **Parallel jobs**: lint, safety, security run concurrently
3. **Quality gate**: Final comprehensive check with all tools

## Migrating from Old Scripts

If you were previously using separate QA scripts:

| Old Script | Equivalent qa.sh Command |
|------------|--------------------------|
| `qa_maintenance.sh` | `./qa.sh` (all sections) |
| `qa_safety.sh` | `./qa.sh --section 5` |
| `qa_security.sh` | `./qa.sh --section 6` |
| `qa_lint.sh` | `./qa.sh --section 4` |

**Old scripts can be removed** - `qa.sh` replaces all functionality.

## Troubleshooting

### "cargo-geiger not found"
```bash
cargo install cargo-geiger
```

### "cargo-llvm-cov not found"
```bash
rustup component add llvm-tools-preview
cargo install cargo-llvm-cov
```

### "cargo-udeps not found"
```bash
rustup install nightly
cargo +nightly install cargo-udeps --locked
```

### Tests failing with "already borrowed"
Ensure using `--test-threads=1`:
```bash
cargo test -- --test-threads=1
```

### Binary size exceeds limit
Check with detailed breakdown:
```bash
riscv64-unknown-elf-size --format=SysV target/riscv32imac-unknown-none-elf/release/rustos-app
```

## Contributing

When adding new checks:

1. Add to appropriate section in `qa.sh`
2. Document REQ: tag from `requirements/REQUIREMENTS.md`
3. Ensure consistent output formatting (`print_pass`, `print_warn`, `print_fail`)
4. Add to this README's section table
5. Update `.github/workflows/ci.yml` if needed

## See Also

- [requirements/REQUIREMENTS.md](requirements/REQUIREMENTS.md) - Full requirements specification
- [docs/TEST_INFRASTRUCTURE.md](docs/TEST_INFRASTRUCTURE.md) - Testing strategy
- [docs/CERTIFICATION.md](docs/CERTIFICATION.md) - Safety certification goals
- [IMPLEMENTATION_STATUS.md](IMPLEMENTATION_STATUS.md) - Feature implementation status

---

**For questions or issues**: See project README or open a GitHub issue.
