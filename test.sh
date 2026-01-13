#!/bin/bash
# REQ: DEV-008 - Test execution script

set -e

echo "Running RustOS test suite..."
echo ""

# REQ: TEST-001 - Tests must run single-threaded due to shared static state
# REQ: PROJ-007 - Host-based test suite in rustos-tests
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Running host-side tests (x86_64)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Run with single thread due to shared static state
cargo test \
    -p rustos-tests \
    --target x86_64-unknown-linux-gnu \
    -- --test-threads=1 --nocapture

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Running benchmarks (if available)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if benchmark binary exists
if [ -f "rustos-tests/src/bin/bench.rs" ]; then
    cargo run \
        -p rustos-tests \
        --target x86_64-unknown-linux-gnu \
        --bin bench \
        --features bench
else
    echo "No benchmark binary found (expected at rustos-tests/src/bin/bench.rs)"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test execution complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Test Requirements:"
echo "  REQ: QUAL-020 - Unit test coverage ≥ 80%"
echo "  REQ: QUAL-021 - All public APIs shall have test coverage"
echo "  REQ: QUAL-022 - Integration tests for kernel primitives"
echo ""
echo "Run './coverage.sh' to generate coverage report"
