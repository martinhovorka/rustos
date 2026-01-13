#!/bin/bash
# REQ: TEST-010 - Code quality maintenance script
# Performs comprehensive build, test, and quality checks

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create logs directory
LOGS_DIR="logs/qa_maintenance"
mkdir -p "$LOGS_DIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}RustOS Code Maintenance Check${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

TOTAL_ISSUES=0

# Function to print section header
print_header() {
    echo ""
    echo -e "${BLUE}>>> $1${NC}"
    echo ""
}

# Function to check result
check_result() {
    local log_file=$1
    local check_name=$2
    local error_count=$(grep "error:" "$log_file" 2>/dev/null | wc -l)
    local warning_count=$(grep "warning:" "$log_file" 2>/dev/null | wc -l)
    local compile_error=$(grep "error: could not compile" "$log_file" 2>/dev/null | wc -l)
    
    # Trim whitespace
    error_count=$(echo "$error_count" | xargs)
    warning_count=$(echo "$warning_count" | xargs)
    compile_error=$(echo "$compile_error" | xargs)
    
    # If compilation failed, that's critical
    if [ "$compile_error" -gt 0 ]; then
        echo -e "${RED}✗ $check_name: COMPILATION FAILED${NC}"
        echo "  See: $log_file"
        TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
        return 1
    elif [ "$error_count" -gt 0 ]; then
        echo -e "${RED}✗ $check_name: $error_count errors, $warning_count warnings${NC}"
        TOTAL_ISSUES=$((TOTAL_ISSUES + error_count))
        return 1
    elif [ "$warning_count" -gt 0 ]; then
        echo -e "${YELLOW}⚠ $check_name: $warning_count warnings${NC}"
        TOTAL_ISSUES=$((TOTAL_ISSUES + warning_count))
        return 0
    else
        echo -e "${GREEN}✓ $check_name: passed${NC}"
        return 0
    fi
}

# 1. Format Check
print_header "1. Checking Code Formatting"
LOG_FILE="$LOGS_DIR/fmt_${TIMESTAMP}.log"
if cargo fmt --all -- --check > "$LOG_FILE" 2>&1; then
    echo -e "${GREEN}✓ Code formatting: passed${NC}"
else
    echo -e "${YELLOW}⚠ Code formatting: needs formatting${NC}"
    echo "  Run 'cargo fmt --all' to fix"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
fi

# 2. Build Check (RISC-V target)
print_header "2. Building for RISC-V Target"
LOG_FILE="$LOGS_DIR/build_riscv_${TIMESTAMP}.log"
if cargo build --release --workspace --target riscv32imac-unknown-none-elf > "$LOG_FILE" 2>&1; then
    check_result "$LOG_FILE" "RISC-V build"
else
    echo -e "${RED}✗ RISC-V build: FAILED${NC}"
    echo "  See: $LOG_FILE"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
fi

# 3. Build Check (Host target for tests)
print_header "3. Building Test Suite"
LOG_FILE="$LOGS_DIR/build_tests_${TIMESTAMP}.log"
if cargo build -p rustos-tests --target x86_64-unknown-linux-gnu > "$LOG_FILE" 2>&1; then
    check_result "$LOG_FILE" "Test suite build"
else
    echo -e "${RED}✗ Test suite build: FAILED${NC}"
    echo "  See: $LOG_FILE"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
fi

# 4. Test Execution
print_header "4. Running Test Suite"
LOG_FILE="$LOGS_DIR/test_${TIMESTAMP}.log"
if cargo test -p rustos-tests --target x86_64-unknown-linux-gnu -- --test-threads=1 > "$LOG_FILE" 2>&1; then
    TEST_PASSED=$(grep "test result:" "$LOG_FILE" | head -1 | grep -oP '\d+(?= passed)' || echo 0)
    TEST_FAILED=$(grep "test result:" "$LOG_FILE" | head -1 | grep -oP '\d+(?= failed)' || echo 0)
    echo -e "${GREEN}✓ Tests: $TEST_PASSED passed${NC}"
    if [ "$TEST_FAILED" != "0" ]; then
        echo -e "${RED}✗ Tests: $TEST_FAILED failed${NC}"
        TOTAL_ISSUES=$((TOTAL_ISSUES + TEST_FAILED))
    fi
else
    echo -e "${RED}✗ Test execution: FAILED${NC}"
    echo "  See: $LOG_FILE"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
fi

# 5. Clippy Analysis (PAC)
print_header "5. Clippy Analysis - rustos-pac"
LOG_FILE="$LOGS_DIR/clippy_pac_${TIMESTAMP}.log"
cargo clippy -p rustos-pac > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (PAC)"

# 6. Clippy Analysis (HAL)
print_header "6. Clippy Analysis - rustos-hal"
LOG_FILE="$LOGS_DIR/clippy_hal_${TIMESTAMP}.log"
cargo clippy -p rustos-hal --features uart,gpio,timer > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (HAL)"

# 7. Clippy Analysis (Kernel)
print_header "7. Clippy Analysis - rustos-kernel"
LOG_FILE="$LOGS_DIR/clippy_kernel_${TIMESTAMP}.log"
cargo clippy -p rustos-kernel > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (Kernel)"

# 8. Clippy Analysis (Board)
print_header "8. Clippy Analysis - rustos-board"
LOG_FILE="$LOGS_DIR/clippy_board_${TIMESTAMP}.log"
cargo clippy -p rustos-board > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (Board)"

# 9. Clippy Analysis (App)
print_header "9. Clippy Analysis - rustos-app"
LOG_FILE="$LOGS_DIR/clippy_app_${TIMESTAMP}.log"
cargo clippy -p rustos-app > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (App)"

# 10. Clippy Analysis (Tests)
print_header "10. Clippy Analysis - rustos-tests"
LOG_FILE="$LOGS_DIR/clippy_tests_${TIMESTAMP}.log"
cargo clippy -p rustos-tests --target x86_64-unknown-linux-gnu > "$LOG_FILE" 2>&1 || true
check_result "$LOG_FILE" "Clippy (Tests)"

# 11. Safety Comments Check
print_header "11. Checking SAFETY Comments"
LOG_FILE="$LOGS_DIR/safety_${TIMESTAMP}.log"
if [ -f "./qa_safety.sh" ]; then
    ./qa_safety.sh > "$LOG_FILE" 2>&1 || true
    UNSAFE_COUNT=$(grep "Missing SAFETY comment" "$LOG_FILE" 2>/dev/null | wc -l)
    UNSAFE_COUNT=$(echo "$UNSAFE_COUNT" | xargs)
    if [ "$UNSAFE_COUNT" -gt 0 ]; then
        echo -e "${RED}✗ SAFETY comments: $UNSAFE_COUNT missing${NC}"
        TOTAL_ISSUES=$((TOTAL_ISSUES + UNSAFE_COUNT))
    else
        echo -e "${GREEN}✓ SAFETY comments: all present${NC}"
    fi
else
    echo -e "${YELLOW}⚠ qa_safety.sh not found, skipping${NC}"
fi

# 12. Documentation Check
print_header "12. Checking Documentation"
LOG_FILE="$LOGS_DIR/doc_${TIMESTAMP}.log"
if cargo doc --workspace --no-deps --document-private-items > "$LOG_FILE" 2>&1; then
    check_result "$LOG_FILE" "Documentation"
else
    echo -e "${RED}✗ Documentation: FAILED${NC}"
    echo "  See: $LOG_FILE"
    TOTAL_ISSUES=$((TOTAL_ISSUES + 1))
fi

# 13. Dependency Audit (if cargo-audit is installed)
print_header "13. Security Audit"
if command -v cargo-audit &> /dev/null; then
    LOG_FILE="$LOGS_DIR/audit_${TIMESTAMP}.log"
    if cargo audit > "$LOG_FILE" 2>&1; then
        echo -e "${GREEN}✓ Security audit: no vulnerabilities${NC}"
    else
        VULN_COUNT=$(grep -c "error:" "$LOG_FILE" 2>/dev/null || echo 0)
        echo -e "${YELLOW}⚠ Security audit: $VULN_COUNT issues found${NC}"
        echo "  See: $LOG_FILE"
    fi
else
    echo -e "${YELLOW}⚠ cargo-audit not installed, skipping${NC}"
    echo "  Install with: cargo install cargo-audit"
fi

# 14. Unused Dependencies Check (if cargo-udeps is installed)
print_header "14. Unused Dependencies"
if command -v cargo-udeps &> /dev/null; then
    LOG_FILE="$LOGS_DIR/udeps_${TIMESTAMP}.log"
    # Only check rustos-tests on host target (other crates need RISC-V nightly target)
    # Use timeout to prevent hanging
    timeout 60 cargo +nightly udeps -p rustos-tests --target x86_64-unknown-linux-gnu &> "$LOG_FILE" || true
    if grep -q "All deps seem to have been used" "$LOG_FILE"; then
        echo -e "${GREEN}✓ Dependencies: no unused dependencies in tests${NC}"
    elif grep -q "unused dependencies" "$LOG_FILE"; then
        echo -e "${YELLOW}⚠ Potentially unused dependencies found:${NC}"
        grep -A 5 "unused dependencies:" "$LOG_FILE" | head -6
        echo "  Note: May be false positives (used by other targets)"
    else
        echo -e "${YELLOW}⚠ cargo-udeps check inconclusive${NC}"
        echo "  See: $LOG_FILE"
    fi
else
    echo -e "${YELLOW}⚠ cargo-udeps not installed, skipping${NC}"
    echo "  Install with: cargo install cargo-udeps --locked"
fi

# 15. Binary Size Check
print_header "15. Binary Size Analysis"
BINARY_PATH="target/riscv32imac-unknown-none-elf/release/rustos-app"
if [ -f "$BINARY_PATH" ]; then
    SIZE=$(stat -c%s "$BINARY_PATH" 2>/dev/null || stat -f%z "$BINARY_PATH" 2>/dev/null)
    SIZE_KB=$((SIZE / 1024))
    if [ "$SIZE_KB" -lt 64 ]; then
        echo -e "${GREEN}✓ Binary size: ${SIZE_KB} KB (target: ≤64 KB)${NC}"
    else
        echo -e "${YELLOW}⚠ Binary size: ${SIZE_KB} KB (exceeds 64 KB target)${NC}"
    fi
    
    # Detailed size breakdown
    echo ""
    echo "  Size breakdown:"
    riscv64-unknown-elf-size "$BINARY_PATH" 2>/dev/null || echo "  (riscv64-unknown-elf-size not available)"
else
    echo -e "${YELLOW}⚠ Binary not found at $BINARY_PATH${NC}"
fi

# Summary
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Summary${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

if [ "$TOTAL_ISSUES" -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed! Code quality is excellent.${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠ Found $TOTAL_ISSUES issues that need attention.${NC}"
    echo ""
    echo "Logs saved to: $LOGS_DIR"
    echo ""
    echo "Quick fixes:"
    echo "  - Format code:    cargo fmt --all"
    echo "  - Fix clippy:     cargo clippy --fix --allow-dirty --allow-staged"
    echo "  - Update deps:    cargo update"
    exit 1
fi
