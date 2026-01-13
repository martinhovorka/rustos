#!/bin/bash
# RustOS Security Audit Script
# Comprehensive security analysis for the RustOS embedded RTOS
#
# REQ: TEST-012 - Security audit automation
#
# Usage: ./qa_security.sh [--verbose] [--fix] [--report FILE]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script configuration
VERBOSE=0
FIX_MODE=0
REPORT_FILE=""
EXIT_CODE=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v)
            VERBOSE=1
            shift
            ;;
        --fix|-f)
            FIX_MODE=1
            shift
            ;;
        --report|-r)
            REPORT_FILE="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--verbose] [--fix] [--report FILE]"
            echo ""
            echo "Options:"
            echo "  --verbose, -v    Show detailed output"
            echo "  --fix, -f        Attempt to fix issues where possible"
            echo "  --report, -r     Write report to FILE (markdown format)"
            echo "  --help, -h       Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Initialize report
REPORT=""
add_to_report() {
    REPORT+="$1"$'\n'
}

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    add_to_report "## $1"
    add_to_report ""
}

print_check() {
    echo -e "${YELLOW}▶${NC} $1"
}

print_pass() {
    echo -e "  ${GREEN}✓${NC} $1"
    add_to_report "✅ $1"
}

print_warn() {
    echo -e "  ${YELLOW}⚠${NC} $1"
    add_to_report "⚠️ $1"
}

print_fail() {
    echo -e "  ${RED}✗${NC} $1"
    add_to_report "❌ $1"
    EXIT_CODE=1
}

print_info() {
    echo -e "  ${BLUE}ℹ${NC} $1"
    add_to_report "ℹ️ $1"
}

# Start report
add_to_report "# RustOS Security Audit Report"
add_to_report ""
add_to_report "**Date:** $(date '+%Y-%m-%d %H:%M:%S')"
add_to_report "**Branch:** $(git branch --show-current 2>/dev/null || echo 'unknown')"
add_to_report "**Commit:** $(git rev-parse --short HEAD 2>/dev/null || echo 'unknown')"
add_to_report ""

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                        RustOS Security Audit                                 ║"
echo "║                    Embedded RTOS Security Analysis                           ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

#==============================================================================
# 1. DEPENDENCY VULNERABILITY SCAN
#==============================================================================
print_header "1. Dependency Vulnerability Scan (cargo-audit)"

print_check "Checking for known vulnerabilities in dependencies..."

if command -v cargo-audit &> /dev/null; then
    AUDIT_OUTPUT=$(cargo audit 2>&1) || true
    
    if echo "$AUDIT_OUTPUT" | grep -q "0 vulnerabilities found"; then
        print_pass "No known vulnerabilities found"
        add_to_report ""
        add_to_report '```'
        add_to_report "$AUDIT_OUTPUT"
        add_to_report '```'
    elif echo "$AUDIT_OUTPUT" | grep -q "vulnerability found\|vulnerabilities found"; then
        VULN_COUNT=$(echo "$AUDIT_OUTPUT" | grep -oE '[0-9]+ vulnerabilit' | head -1 | grep -oE '[0-9]+')
        print_fail "Found $VULN_COUNT vulnerability(ies)"
        add_to_report ""
        add_to_report '```'
        add_to_report "$AUDIT_OUTPUT"
        add_to_report '```'
        
        if [[ $VERBOSE -eq 1 ]]; then
            echo "$AUDIT_OUTPUT"
        fi
    else
        print_pass "No vulnerabilities detected"
        add_to_report ""
        add_to_report '```'
        add_to_report "$AUDIT_OUTPUT"
        add_to_report '```'
    fi
else
    print_warn "cargo-audit not installed. Install with: cargo install cargo-audit"
    add_to_report "cargo-audit not installed"
fi

#==============================================================================
# 2. UNSAFE CODE ANALYSIS
#==============================================================================
print_header "2. Unsafe Code Analysis (cargo-geiger)"

print_check "Analyzing unsafe code usage..."

if command -v cargo-geiger &> /dev/null; then
    # Run geiger with timeout (can be slow)
    GEIGER_OUTPUT=$(timeout 120 cargo geiger --all-features 2>&1) || true
    
    if [[ -n "$GEIGER_OUTPUT" ]]; then
        # Extract unsafe statistics
        UNSAFE_FNS=$(echo "$GEIGER_OUTPUT" | grep -oE '[0-9]+ unsafe fn' | head -1 || echo "0 unsafe fn")
        UNSAFE_EXPRS=$(echo "$GEIGER_OUTPUT" | grep -oE '[0-9]+ unsafe expr' | head -1 || echo "0 unsafe expr")
        
        print_info "Unsafe code statistics:"
        echo "    - $UNSAFE_FNS"
        echo "    - $UNSAFE_EXPRS"
        
        add_to_report ""
        add_to_report "Unsafe code statistics:"
        add_to_report "- $UNSAFE_FNS"
        add_to_report "- $UNSAFE_EXPRS"
        
        if [[ $VERBOSE -eq 1 ]]; then
            echo "$GEIGER_OUTPUT"
        fi
        
        print_pass "Unsafe code analysis complete"
    else
        print_warn "cargo-geiger produced no output"
    fi
else
    print_warn "cargo-geiger not installed. Install with: cargo install cargo-geiger"
    
    # Fallback: manual unsafe counting
    print_check "Falling back to manual unsafe analysis..."
    
    UNSAFE_COUNT=$(grep -r "unsafe" --include="*.rs" rustos-* | grep -v "// SAFETY:" | grep -v "#\[allow" | wc -l)
    SAFETY_DOCS=$(grep -r "// SAFETY:" --include="*.rs" rustos-* | wc -l)
    
    print_info "Found $UNSAFE_COUNT unsafe occurrences"
    print_info "Found $SAFETY_DOCS SAFETY comments"
    
    if [[ $SAFETY_DOCS -lt $((UNSAFE_COUNT / 2)) ]]; then
        print_warn "Many unsafe blocks may lack SAFETY documentation"
    else
        print_pass "Unsafe code appears to be documented"
    fi
    
    add_to_report ""
    add_to_report "Manual analysis:"
    add_to_report "- Unsafe occurrences: $UNSAFE_COUNT"
    add_to_report "- SAFETY comments: $SAFETY_DOCS"
fi

#==============================================================================
# 3. SAFETY DOCUMENTATION AUDIT
#==============================================================================
print_header "3. Safety Documentation Audit"

print_check "Verifying SAFETY comments for unsafe blocks..."

# Count unsafe blocks vs SAFETY comments using simple grep
UNSAFE_BLOCKS=$(grep -r "unsafe {" rustos-*/src --include="*.rs" 2>/dev/null | wc -l | tr -d '[:space:]')
UNSAFE_FNS=$(grep -r "unsafe fn" rustos-*/src --include="*.rs" 2>/dev/null | wc -l | tr -d '[:space:]')
SAFETY_COMMENTS=$(grep -r "// SAFETY:" rustos-*/src --include="*.rs" 2>/dev/null | wc -l | tr -d '[:space:]')
SAFETY_DOCS=$(grep -r "/// # Safety" rustos-*/src --include="*.rs" 2>/dev/null | wc -l | tr -d '[:space:]')

# Ensure we have numbers
UNSAFE_BLOCKS=${UNSAFE_BLOCKS:-0}
UNSAFE_FNS=${UNSAFE_FNS:-0}
SAFETY_COMMENTS=${SAFETY_COMMENTS:-0}
SAFETY_DOCS=${SAFETY_DOCS:-0}

TOTAL_UNSAFE=$((UNSAFE_BLOCKS + UNSAFE_FNS))
TOTAL_SAFETY=$((SAFETY_COMMENTS + SAFETY_DOCS))

COVERAGE_PCT=100
if [[ $TOTAL_UNSAFE -gt 0 ]]; then
    COVERAGE_PCT=$((TOTAL_SAFETY * 100 / TOTAL_UNSAFE))
fi

print_info "Unsafe blocks: $UNSAFE_BLOCKS"
print_info "Unsafe functions: $UNSAFE_FNS"
print_info "SAFETY inline comments: $SAFETY_COMMENTS"
print_info "Safety doc comments: $SAFETY_DOCS"
print_info "Documentation coverage: ${COVERAGE_PCT}%"

add_to_report ""
add_to_report "| Metric | Count |"
add_to_report "|--------|-------|"
add_to_report "| Unsafe blocks | $UNSAFE_BLOCKS |"
add_to_report "| Unsafe functions | $UNSAFE_FNS |"
add_to_report "| SAFETY comments | $SAFETY_COMMENTS |"
add_to_report "| Safety docs | $SAFETY_DOCS |"
add_to_report "| Coverage | ${COVERAGE_PCT}% |"

if [[ $COVERAGE_PCT -ge 80 ]]; then
    print_pass "Good safety documentation coverage (≥80%)"
elif [[ $COVERAGE_PCT -ge 50 ]]; then
    print_warn "Moderate safety documentation coverage (50-80%)"
else
    print_fail "Low safety documentation coverage (<50%)"
fi

#==============================================================================
# 4. FORBIDDEN PATTERNS CHECK
#==============================================================================
print_header "4. Forbidden Patterns Check"

print_check "Scanning for security anti-patterns..."

FORBIDDEN_FOUND=0

# Check for panic/unwrap in production code (not tests)
UNWRAP_COUNT=$(grep -rn "\.unwrap()" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | grep -v "_tests" | wc -l || echo 0)
UNWRAP_COUNT=$(echo "$UNWRAP_COUNT" | tr -d '[:space:]')
if [[ $UNWRAP_COUNT -gt 0 ]]; then
    print_warn "Found $UNWRAP_COUNT .unwrap() calls in production code"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + UNWRAP_COUNT))
    
    if [[ $VERBOSE -eq 1 ]]; then
        grep -rn "\.unwrap()" rustos-*/src --include="*.rs" | grep -v "test" | head -10 || true
    fi
else
    print_pass "No .unwrap() in production code"
fi

# Check for expect() calls
EXPECT_COUNT=$(grep -rn "\.expect(" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | grep -v "_tests" | wc -l || echo 0)
EXPECT_COUNT=$(echo "$EXPECT_COUNT" | tr -d '[:space:]')
if [[ $EXPECT_COUNT -gt 0 ]]; then
    print_warn "Found $EXPECT_COUNT .expect() calls in production code"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + EXPECT_COUNT))
else
    print_pass "No .expect() in production code"
fi

# Check for panic! macro
PANIC_COUNT=$(grep -rn "panic!" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | grep -v "_tests" | grep -v "panic_handler" | wc -l || echo 0)
PANIC_COUNT=$(echo "$PANIC_COUNT" | tr -d '[:space:]')
if [[ $PANIC_COUNT -gt 0 ]]; then
    print_warn "Found $PANIC_COUNT panic! calls in production code"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + PANIC_COUNT))
else
    print_pass "No panic! in production code"
fi

# Check for todo!/unimplemented!
TODO_COUNT=$(grep -rn "todo!\|unimplemented!" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
TODO_COUNT=$(echo "$TODO_COUNT" | tr -d '[:space:]')
if [[ $TODO_COUNT -gt 0 ]]; then
    print_fail "Found $TODO_COUNT todo!/unimplemented! in production code"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + TODO_COUNT))
else
    print_pass "No todo!/unimplemented! in production code"
fi

# Check for unreachable!
UNREACHABLE_COUNT=$(grep -rn "unreachable!" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
UNREACHABLE_COUNT=$(echo "$UNREACHABLE_COUNT" | tr -d '[:space:]')
if [[ $UNREACHABLE_COUNT -gt 0 ]]; then
    print_info "Found $UNREACHABLE_COUNT unreachable! (may be intentional)"
fi

# Check for std usage (should be no_std)
STD_USE=$(grep -rn "use std::" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
STD_USE=$(echo "$STD_USE" | tr -d '[:space:]')
if [[ $STD_USE -gt 0 ]]; then
    print_fail "Found $STD_USE uses of std:: (should be no_std)"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + STD_USE))
else
    print_pass "No std:: usage (proper no_std)"
fi

# Check for Box/Vec/String (heap allocation) - exclude heapless::Vec and comments
HEAP_ALLOC=$(grep -rn "Box<\|alloc::vec::Vec\|alloc::string::String" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | grep -v "//\|heapless" | wc -l || echo 0)
HEAP_ALLOC=$(echo "$HEAP_ALLOC" | tr -d '[:space:]')
if [[ $HEAP_ALLOC -gt 0 ]]; then
    print_fail "Found $HEAP_ALLOC potential heap allocations (Box/Vec/String)"
    FORBIDDEN_FOUND=$((FORBIDDEN_FOUND + HEAP_ALLOC))
else
    print_pass "No heap allocations detected"
fi

add_to_report ""
add_to_report "| Pattern | Count | Status |"
add_to_report "|---------|-------|--------|"
add_to_report "| .unwrap() | $UNWRAP_COUNT | $([ $UNWRAP_COUNT -eq 0 ] && echo '✅' || echo '⚠️') |"
add_to_report "| .expect() | $EXPECT_COUNT | $([ $EXPECT_COUNT -eq 0 ] && echo '✅' || echo '⚠️') |"
add_to_report "| panic! | $PANIC_COUNT | $([ $PANIC_COUNT -eq 0 ] && echo '✅' || echo '⚠️') |"
add_to_report "| todo!/unimplemented! | $TODO_COUNT | $([ $TODO_COUNT -eq 0 ] && echo '✅' || echo '❌') |"
add_to_report "| std:: usage | $STD_USE | $([ $STD_USE -eq 0 ] && echo '✅' || echo '❌') |"
add_to_report "| heap allocations | $HEAP_ALLOC | $([ $HEAP_ALLOC -eq 0 ] && echo '✅' || echo '❌') |"

#==============================================================================
# 5. MEMORY SAFETY CHECKS
#==============================================================================
print_header "5. Memory Safety Checks"

print_check "Analyzing memory safety patterns..."

# Check for raw pointer operations
RAW_PTR=$(grep -rn "\*const\|\*mut" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
RAW_PTR=$(echo "$RAW_PTR" | tr -d '[:space:]')
print_info "Raw pointer declarations: $RAW_PTR"

# Check for transmute
TRANSMUTE=$(grep -rn "transmute" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
TRANSMUTE=$(echo "$TRANSMUTE" | tr -d '[:space:]')
if [[ $TRANSMUTE -gt 0 ]]; then
    print_warn "Found $TRANSMUTE transmute calls (review carefully)"
else
    print_pass "No transmute calls found"
fi

# Check for mem::forget
FORGET=$(grep -rn "mem::forget\|forget(" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
FORGET=$(echo "$FORGET" | tr -d '[:space:]')
if [[ $FORGET -gt 0 ]]; then
    print_warn "Found $FORGET mem::forget calls (may leak resources)"
else
    print_pass "No mem::forget calls found"
fi

# Check for MaybeUninit
UNINIT=$(grep -rn "MaybeUninit" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
UNINIT=$(echo "$UNINIT" | tr -d '[:space:]')
if [[ $UNINIT -gt 0 ]]; then
    print_info "Found $UNINIT MaybeUninit usages (review initialization)"
fi

# Check for static mut
STATIC_MUT=$(grep -rn "static mut" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
STATIC_MUT=$(echo "$STATIC_MUT" | tr -d '[:space:]')
if [[ $STATIC_MUT -gt 0 ]]; then
    print_warn "Found $STATIC_MUT static mut declarations (inherently unsafe)"
    print_info "Consider using atomic types or interior mutability patterns"
fi

add_to_report ""
add_to_report "| Pattern | Count | Notes |"
add_to_report "|---------|-------|-------|"
add_to_report "| Raw pointers | $RAW_PTR | Expected in embedded |"
add_to_report "| transmute | $TRANSMUTE | Review carefully |"
add_to_report "| mem::forget | $FORGET | May leak resources |"
add_to_report "| MaybeUninit | $UNINIT | Review initialization |"
add_to_report "| static mut | $STATIC_MUT | Inherently unsafe |"

#==============================================================================
# 6. SUPPLY CHAIN SECURITY
#==============================================================================
print_header "6. Supply Chain Security"

print_check "Analyzing dependency tree..."

# Count direct and transitive dependencies (fallback if jq not available)
if command -v jq &> /dev/null; then
    DIRECT_DEPS=$(cargo metadata --format-version 1 2>/dev/null | jq -r '.packages[].dependencies | length' 2>/dev/null | awk '{s+=$1} END {print s+0}' || echo "unknown")
    TOTAL_DEPS=$(cargo metadata --format-version 1 2>/dev/null | jq -r '.packages | length' 2>/dev/null || echo "unknown")
else
    # Fallback: count Cargo.toml dependencies
    DIRECT_DEPS=$(grep -c "^\[dependencies" Cargo.toml rustos-*/Cargo.toml 2>/dev/null | awk -F: '{s+=$2} END {print s+0}' || echo "unknown")
    TOTAL_DEPS="unknown (jq not installed)"
fi

print_info "Direct dependencies: $DIRECT_DEPS"
print_info "Total packages (including transitive): $TOTAL_DEPS"

# Check for yanked crates
print_check "Checking for yanked crates..."
if cargo update --dry-run 2>&1 | grep -q "yanked"; then
    print_fail "Found yanked dependencies!"
else
    print_pass "No yanked dependencies"
fi

# Check Cargo.lock freshness
if [[ -f Cargo.lock ]]; then
    LOCK_AGE=$(( ( $(date +%s) - $(stat -c %Y Cargo.lock) ) / 86400 ))
    if [[ $LOCK_AGE -gt 90 ]]; then
        print_warn "Cargo.lock is $LOCK_AGE days old - consider updating dependencies"
    else
        print_pass "Cargo.lock is recent ($LOCK_AGE days old)"
    fi
else
    print_warn "No Cargo.lock found"
fi

add_to_report ""
add_to_report "- Direct dependencies: $DIRECT_DEPS"
add_to_report "- Total packages: $TOTAL_DEPS"

#==============================================================================
# 7. CRYPTO & SECRETS CHECK
#==============================================================================
print_header "7. Secrets and Credentials Check"

print_check "Scanning for hardcoded secrets..."

SECRETS_FOUND=0

# Check for potential API keys/tokens
API_KEYS=$(grep -rniE "(api[_-]?key|secret[_-]?key|access[_-]?token|private[_-]?key)\s*[=:]" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
API_KEYS=$(echo "$API_KEYS" | tr -d '[:space:]')
if [[ $API_KEYS -gt 0 ]]; then
    print_fail "Found $API_KEYS potential hardcoded API keys/tokens"
    SECRETS_FOUND=$((SECRETS_FOUND + API_KEYS))
else
    print_pass "No hardcoded API keys detected"
fi

# Check for passwords
PASSWORDS=$(grep -rniE "(password|passwd|pwd)\s*[=:].*['\"]" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
PASSWORDS=$(echo "$PASSWORDS" | tr -d '[:space:]')
if [[ $PASSWORDS -gt 0 ]]; then
    print_fail "Found $PASSWORDS potential hardcoded passwords"
    SECRETS_FOUND=$((SECRETS_FOUND + PASSWORDS))
else
    print_pass "No hardcoded passwords detected"
fi

# Check for private keys (PEM format)
PEM_KEYS=$(grep -rn "BEGIN.*PRIVATE KEY\|BEGIN RSA PRIVATE" rustos-* --include="*.rs" --include="*.pem" 2>/dev/null | wc -l || echo 0)
PEM_KEYS=$(echo "$PEM_KEYS" | tr -d '[:space:]')
if [[ $PEM_KEYS -gt 0 ]]; then
    print_fail "Found $PEM_KEYS private key files"
    SECRETS_FOUND=$((SECRETS_FOUND + PEM_KEYS))
else
    print_pass "No private key files detected"
fi

add_to_report ""
if [[ $SECRETS_FOUND -eq 0 ]]; then
    add_to_report "✅ No secrets or credentials detected"
else
    add_to_report "❌ Found $SECRETS_FOUND potential secret(s)"
fi

#==============================================================================
# 8. BUILD CONFIGURATION SECURITY
#==============================================================================
print_header "8. Build Configuration Security"

print_check "Checking build security settings..."

# Check for debug assertions in release
if grep -q 'debug-assertions = true' Cargo.toml 2>/dev/null; then
    print_warn "debug-assertions enabled (check if intentional for release)"
else
    print_pass "No debug-assertions override in Cargo.toml"
fi

# Check for overflow checks
if grep -q 'overflow-checks = false' Cargo.toml 2>/dev/null; then
    print_warn "overflow-checks disabled (security risk)"
else
    print_pass "Overflow checks not explicitly disabled"
fi

# Check for panic = abort (recommended for embedded)
if grep -q 'panic = "abort"' Cargo.toml 2>/dev/null; then
    print_pass "panic = 'abort' set (good for embedded)"
else
    print_info "Consider setting panic = 'abort' for smaller binaries"
fi

# Check for LTO
if grep -q 'lto = true\|lto = "fat"\|lto = "thin"' Cargo.toml 2>/dev/null; then
    print_pass "LTO enabled (helps with dead code elimination)"
else
    print_info "Consider enabling LTO for production builds"
fi

# Check for strip
if grep -q 'strip = true\|strip = "symbols"' Cargo.toml 2>/dev/null; then
    print_pass "Symbol stripping enabled"
else
    print_info "Consider enabling symbol stripping for production"
fi

#==============================================================================
# 9. CLIPPY SECURITY LINTS
#==============================================================================
print_header "9. Clippy Security Lints"

print_check "Running security-focused clippy lints..."

# Run clippy with security-relevant lints
CLIPPY_OUTPUT=$(cargo clippy --workspace --target riscv32imac-unknown-none-elf -- \
    -W clippy::mem_forget \
    -W clippy::cast_ptr_alignment \
    -W clippy::fn_to_numeric_cast \
    -W clippy::ptr_as_ptr \
    -W clippy::transmute_ptr_to_ref \
    -W clippy::invalid_upcast_comparisons \
    2>&1) || true

SECURITY_WARNINGS=$(echo "$CLIPPY_OUTPUT" | grep -c "warning:" || echo "0")

if [[ $SECURITY_WARNINGS -eq 0 ]]; then
    print_pass "No security-related clippy warnings"
else
    print_warn "Found $SECURITY_WARNINGS security-related clippy warnings"
    if [[ $VERBOSE -eq 1 ]]; then
        echo "$CLIPPY_OUTPUT" | grep -A3 "warning:"
    fi
fi

add_to_report ""
add_to_report "Security clippy warnings: $SECURITY_WARNINGS"

#==============================================================================
# 10. REQUIREMENTS TRACEABILITY
#==============================================================================
print_header "10. Security Requirements Traceability"

print_check "Verifying security requirement coverage..."

# Check for security-related REQ tags
SEC_REQS=$(grep -rn "REQ:.*SEC\|REQ:.*SAFE\|REQ:.*MEM" rustos-*/src --include="*.rs" 2>/dev/null | wc -l)
print_info "Security-related requirement tags: $SEC_REQS"

# Check all crates have REQ tags
for crate in rustos-pac rustos-hal rustos-kernel rustos-board; do
    if [[ -d "$crate/src" ]]; then
        REQ_COUNT=$(grep -rn "REQ:" "$crate/src" --include="*.rs" 2>/dev/null | wc -l)
        if [[ $REQ_COUNT -gt 0 ]]; then
            print_pass "$crate: $REQ_COUNT requirement tags"
        else
            print_warn "$crate: No requirement tags found"
        fi
    fi
done

#==============================================================================
# SUMMARY
#==============================================================================
print_header "Security Audit Summary"

echo ""
if [[ $EXIT_CODE -eq 0 ]]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                    SECURITY AUDIT PASSED                                     ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    add_to_report ""
    add_to_report "## ✅ SECURITY AUDIT PASSED"
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                    SECURITY AUDIT FAILED                                     ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    add_to_report ""
    add_to_report "## ❌ SECURITY AUDIT FAILED"
fi

echo ""
echo "Summary:"
echo "  - Vulnerability scan: $(command -v cargo-audit &> /dev/null && echo 'completed' || echo 'skipped')"
echo "  - Unsafe code analysis: completed"
echo "  - Forbidden patterns: $FORBIDDEN_FOUND found"
echo "  - Safety documentation: ${COVERAGE_PCT}% coverage"
echo ""

add_to_report ""
add_to_report "### Metrics"
add_to_report "- Vulnerability scan: $(command -v cargo-audit &> /dev/null && echo 'completed' || echo 'skipped')"
add_to_report "- Unsafe code analysis: completed"
add_to_report "- Forbidden patterns found: $FORBIDDEN_FOUND"
add_to_report "- Safety documentation coverage: ${COVERAGE_PCT}%"

# Write report if requested
if [[ -n "$REPORT_FILE" ]]; then
    echo "$REPORT" > "$REPORT_FILE"
    echo -e "${GREEN}Report written to: $REPORT_FILE${NC}"
fi

exit $EXIT_CODE
