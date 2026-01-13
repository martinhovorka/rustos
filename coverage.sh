#!/bin/bash
# REQ: DEV-006 - Test coverage extraction

set -e

echo "Extracting test coverage for RustOS..."
echo ""

# Check for required tools
if ! command -v cargo-llvm-cov &> /dev/null; then
    echo "ERROR: cargo-llvm-cov not found. Install with:"
    echo "  cargo install cargo-llvm-cov"
    exit 1
fi

# Install cargo-llvm-cov if not present
if ! command -v cargo-llvm-cov &> /dev/null; then
    echo "Installing cargo-llvm-cov..."
    cargo install cargo-llvm-cov
fi

# Clean previous coverage data
echo "Cleaning previous coverage data..."
cargo llvm-cov clean --workspace

# Create artifacts directory if it doesn't exist
readonly ARTIFACTS_DIR="./artifacts/coverage"
mkdir -p "$ARTIFACTS_DIR"

# Run tests with coverage for host-side tests
# REQ: TEST-001 - Tests must run single-threaded due to shared static state
# 
# Note: Coverage is collected only for rustos-tests crate. The kernel and HAL crates
# contain RISC-V-specific assembly code that cannot compile for x86_64 host target.
# However, rustos-tests exercises kernel/HAL code through mocked interfaces, providing
# indirect coverage verification. For full instrumented coverage of kernel internals,
# QEMU-based RISC-V testing would be required (future enhancement).
echo ""
echo "Running tests with coverage instrumentation..."
cargo llvm-cov \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    --html \
    --output-dir "$ARTIFACTS_DIR" \
    -- --test-threads=1

echo ""
echo "Coverage report generated in $ARTIFACTS_DIR/html/index.html"
echo ""

# Extract coverage summary
echo "Coverage Summary (rustos-tests crate):"
cargo llvm-cov \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    --summary-only \
    -- --test-threads=1

# Also save coverage in JSON format for CI/tooling
echo ""
echo "Saving coverage data to artifacts..."
cargo llvm-cov \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    --json \
    --output-path "$ARTIFACTS_DIR/coverage.json" \
    -- --test-threads=1

echo ""
echo "Coverage artifacts saved to: $ARTIFACTS_DIR/"
echo "  - HTML report: $ARTIFACTS_DIR/index.html"
echo "  - JSON data: $ARTIFACTS_DIR/coverage.json"
echo ""
echo "REQ: QUAL-020 - Target coverage: ≥ 80%"
