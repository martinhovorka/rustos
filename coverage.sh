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

cargo install cargo-llvm-cov

# Clean previous coverage data
echo "Cleaning previous coverage data..."
cargo llvm-cov clean --workspace

# Run tests with coverage for host-side tests
# REQ: TEST-001 - Tests must run single-threaded due to shared static state
echo ""
echo "Running tests with coverage instrumentation..."
cargo llvm-cov \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    --html \
    --open \
    -- --test-threads=1

echo ""
echo "Coverage report generated in target/llvm-cov/html/index.html"
echo ""

# Extract coverage summary
echo "Coverage Summary:"
cargo llvm-cov \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    --summary-only \
    -- --test-threads=1

echo ""
echo "REQ: QUAL-020 - Target coverage: ≥ 80%"
