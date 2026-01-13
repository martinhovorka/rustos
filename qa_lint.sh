#!/bin/bash
# RustOS Linter Script
# Comprehensive code quality and style checking
#
# REQ: TEST-013 - Automated linting and code quality checks
#
# Usage: ./qa_lint.sh [--fix] [--verbose] [--crate NAME]

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script configuration
FIX_MODE=0
VERBOSE=0
TARGET_CRATE=""
EXIT_CODE=0
WARNINGS=0
ERRORS=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --fix|-f)
            FIX_MODE=1
            shift
            ;;
        --verbose|-v)
            VERBOSE=1
            shift
            ;;
        --crate|-c)
            TARGET_CRATE="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--fix] [--verbose] [--crate NAME]"
            echo ""
            echo "Options:"
            echo "  --fix, -f        Automatically fix issues where possible"
            echo "  --verbose, -v    Show detailed output"
            echo "  --crate, -c      Only lint specified crate"
            echo "  --help, -h       Show this help message"
            echo ""
            echo "Crates: rustos-pac, rustos-hal, rustos-kernel, rustos-board, rustos-app, rustos-tests"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${CYAN}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

print_check() {
    echo -e "${YELLOW}▶${NC} $1"
}

print_pass() {
    echo -e "  ${GREEN}✓${NC} $1"
}

print_warn() {
    echo -e "  ${YELLOW}⚠${NC} $1"
    WARNINGS=$((WARNINGS + 1))
}

print_fail() {
    echo -e "  ${RED}✗${NC} $1"
    ERRORS=$((ERRORS + 1))
    EXIT_CODE=1
}

print_info() {
    echo -e "  ${BLUE}ℹ${NC} $1"
}

# Determine crates to lint
if [[ -n "$TARGET_CRATE" ]]; then
    CRATES=("$TARGET_CRATE")
else
    CRATES=(rustos-pac rustos-hal rustos-kernel rustos-board rustos-app rustos-tests)
fi

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════════════════════════╗"
echo "║                          RustOS Linter                                       ║"
echo "║                    Code Quality & Style Checking                             ║"
echo "╚══════════════════════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

if [[ $FIX_MODE -eq 1 ]]; then
    echo -e "${YELLOW}Running in FIX mode - will automatically fix issues${NC}"
fi

#==============================================================================
# 1. RUST FORMAT CHECK
#==============================================================================
print_header "1. Code Formatting (rustfmt)"

print_check "Checking code formatting..."

if [[ $FIX_MODE -eq 1 ]]; then
    if cargo fmt --all 2>&1; then
        print_pass "Code formatted successfully"
    else
        print_fail "Failed to format code"
    fi
else
    FMT_OUTPUT=$(cargo fmt --all -- --check 2>&1) || FMT_RESULT=$?
    FMT_RESULT=${FMT_RESULT:-0}
    
    if [[ $FMT_RESULT -eq 0 ]]; then
        print_pass "All code is properly formatted"
    else
        UNFORMATTED=$(echo "$FMT_OUTPUT" | grep -c "Diff in" || echo "0")
        print_fail "Found $UNFORMATTED files with formatting issues"
        if [[ $VERBOSE -eq 1 ]]; then
            echo "$FMT_OUTPUT"
        fi
        print_info "Run with --fix to auto-format"
    fi
fi

#==============================================================================
# 2. CLIPPY - RISC-V TARGET
#==============================================================================
print_header "2. Clippy Lints (RISC-V Target)"

for crate in "${CRATES[@]}"; do
    # Skip tests crate for RISC-V target
    if [[ "$crate" == "rustos-tests" ]]; then
        continue
    fi
    
    if [[ ! -d "$crate" ]]; then
        print_warn "Crate $crate not found, skipping"
        continue
    fi
    
    print_check "Linting $crate..."
    
    CLIPPY_ARGS="-p $crate --target riscv32imac-unknown-none-elf"
    if [[ $FIX_MODE -eq 1 ]]; then
        CLIPPY_ARGS="$CLIPPY_ARGS --fix --allow-dirty --allow-staged"
    fi
    
    CLIPPY_OUTPUT=$(cargo clippy $CLIPPY_ARGS -- -D warnings 2>&1) || CLIPPY_RESULT=$?
    CLIPPY_RESULT=${CLIPPY_RESULT:-0}
    
    if [[ $CLIPPY_RESULT -eq 0 ]]; then
        print_pass "$crate: No warnings"
    else
        WARN_COUNT=$(echo "$CLIPPY_OUTPUT" | grep -c "warning:" || echo "0")
        ERR_COUNT=$(echo "$CLIPPY_OUTPUT" | grep -c "error\[" || echo "0")
        
        if [[ $ERR_COUNT -gt 0 ]]; then
            print_fail "$crate: $ERR_COUNT error(s)"
        elif [[ $WARN_COUNT -gt 0 ]]; then
            print_warn "$crate: $WARN_COUNT warning(s)"
        fi
        
        if [[ $VERBOSE -eq 1 ]]; then
            echo "$CLIPPY_OUTPUT" | grep -E "warning:|error\[" | head -20
        fi
    fi
done

#==============================================================================
# 3. CLIPPY - HOST TARGET (Tests)
#==============================================================================
print_header "3. Clippy Lints (Host Target - Tests)"

if [[ -z "$TARGET_CRATE" ]] || [[ "$TARGET_CRATE" == "rustos-tests" ]]; then
    print_check "Linting rustos-tests..."
    
    CLIPPY_ARGS="-p rustos-tests --target x86_64-unknown-linux-gnu"
    if [[ $FIX_MODE -eq 1 ]]; then
        CLIPPY_ARGS="$CLIPPY_ARGS --fix --allow-dirty --allow-staged"
    fi
    
    CLIPPY_OUTPUT=$(cargo clippy $CLIPPY_ARGS -- -D warnings 2>&1) || CLIPPY_RESULT=$?
    CLIPPY_RESULT=${CLIPPY_RESULT:-0}
    
    if [[ $CLIPPY_RESULT -eq 0 ]]; then
        print_pass "rustos-tests: No warnings"
    else
        WARN_COUNT=$(echo "$CLIPPY_OUTPUT" | grep -c "warning:" || echo "0")
        ERR_COUNT=$(echo "$CLIPPY_OUTPUT" | grep -c "error\[" || echo "0")
        
        if [[ $ERR_COUNT -gt 0 ]]; then
            print_fail "rustos-tests: $ERR_COUNT error(s)"
        elif [[ $WARN_COUNT -gt 0 ]]; then
            print_warn "rustos-tests: $WARN_COUNT warning(s)"
        fi
        
        if [[ $VERBOSE -eq 1 ]]; then
            echo "$CLIPPY_OUTPUT" | grep -E "warning:|error\[" | head -20
        fi
    fi
else
    print_info "Skipping tests (not in target crates)"
fi

#==============================================================================
# 4. CLIPPY PEDANTIC LINTS (Advisory)
#==============================================================================
print_header "4. Clippy Pedantic Lints (Advisory)"

print_check "Running pedantic lints (informational only)..."

PEDANTIC_OUTPUT=$(cargo clippy --workspace --target riscv32imac-unknown-none-elf -- \
    -W clippy::pedantic \
    -A clippy::missing_errors_doc \
    -A clippy::missing_panics_doc \
    -A clippy::must_use_candidate \
    -A clippy::module_name_repetitions \
    -A clippy::too_many_lines \
    -A clippy::similar_names \
    -A clippy::doc_markdown \
    2>&1) || true

PEDANTIC_WARNS=$(echo "$PEDANTIC_OUTPUT" | grep -c "warning:" || echo "0")

if [[ $PEDANTIC_WARNS -eq 0 ]]; then
    print_pass "No pedantic warnings"
else
    print_info "Found $PEDANTIC_WARNS pedantic suggestions (not blocking)"
    if [[ $VERBOSE -eq 1 ]]; then
        echo "$PEDANTIC_OUTPUT" | grep "warning:" | head -10
    fi
fi

#==============================================================================
# 5. DOCUMENTATION LINTS
#==============================================================================
print_header "5. Documentation Lints"

print_check "Checking for missing documentation..."

# Count public items without docs
for crate in "${CRATES[@]}"; do
    if [[ "$crate" == "rustos-tests" ]]; then
        continue
    fi
    
    if [[ ! -d "$crate/src" ]]; then
        continue
    fi
    
    # Check for pub fn/struct/enum without /// docs
    PUB_ITEMS=$(grep -rn "^pub fn\|^pub struct\|^pub enum\|^pub trait\|^pub type" "$crate/src" --include="*.rs" 2>/dev/null | wc -l || echo 0)
    PUB_ITEMS=$(echo "$PUB_ITEMS" | tr -d '[:space:]')
    
    DOC_ITEMS=$(grep -rn "^/// " "$crate/src" --include="*.rs" 2>/dev/null | wc -l || echo 0)
    DOC_ITEMS=$(echo "$DOC_ITEMS" | tr -d '[:space:]')
    
    if [[ $PUB_ITEMS -gt 0 ]]; then
        DOC_RATIO=$((DOC_ITEMS * 100 / PUB_ITEMS))
        if [[ $DOC_RATIO -ge 80 ]]; then
            print_pass "$crate: ${DOC_RATIO}% documentation coverage"
        elif [[ $DOC_RATIO -ge 50 ]]; then
            print_warn "$crate: ${DOC_RATIO}% documentation coverage"
        else
            print_info "$crate: ${DOC_RATIO}% documentation coverage"
        fi
    fi
done

#==============================================================================
# 6. REQUIREMENTS TRACEABILITY
#==============================================================================
print_header "6. Requirements Traceability"

print_check "Checking REQ: tags..."

for crate in "${CRATES[@]}"; do
    if [[ ! -d "$crate/src" ]]; then
        continue
    fi
    
    REQ_COUNT=$(grep -rn "REQ:" "$crate/src" --include="*.rs" 2>/dev/null | wc -l || echo 0)
    REQ_COUNT=$(echo "$REQ_COUNT" | tr -d '[:space:]')
    
    FN_COUNT=$(grep -rn "^pub fn\|^fn " "$crate/src" --include="*.rs" 2>/dev/null | wc -l || echo 0)
    FN_COUNT=$(echo "$FN_COUNT" | tr -d '[:space:]')
    
    if [[ $FN_COUNT -gt 0 ]]; then
        REQ_RATIO=$((REQ_COUNT * 100 / FN_COUNT))
        if [[ $REQ_RATIO -ge 50 ]]; then
            print_pass "$crate: $REQ_COUNT REQ tags (${REQ_RATIO}% coverage)"
        elif [[ $REQ_RATIO -ge 25 ]]; then
            print_warn "$crate: $REQ_COUNT REQ tags (${REQ_RATIO}% coverage)"
        else
            print_info "$crate: $REQ_COUNT REQ tags (${REQ_RATIO}% coverage)"
        fi
    fi
done

#==============================================================================
# 7. CODE COMPLEXITY CHECK
#==============================================================================
print_header "7. Code Complexity Check"

print_check "Analyzing function complexity..."

# Find very long functions (>100 lines)
LONG_FNS=0
for crate in "${CRATES[@]}"; do
    if [[ ! -d "$crate/src" ]]; then
        continue
    fi
    
    # Simple heuristic: count lines between fn and closing brace
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            # Count functions with many lines (rough estimate)
            FN_LINES=$(awk '/^[[:space:]]*(pub )?fn / { start=NR } /^}$/ && start { if (NR-start > 100) print FILENAME":"start; start=0 }' "$file" 2>/dev/null | wc -l || echo 0)
            LONG_FNS=$((LONG_FNS + FN_LINES))
        fi
    done < <(find "$crate/src" -name "*.rs" -type f 2>/dev/null)
done

if [[ $LONG_FNS -eq 0 ]]; then
    print_pass "No excessively long functions (>100 lines)"
else
    print_warn "Found $LONG_FNS potentially complex functions (>100 lines)"
fi

# Check for deeply nested code
DEEP_NESTING=$(grep -rn "        {" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
DEEP_NESTING=$(echo "$DEEP_NESTING" | tr -d '[:space:]')
print_info "Deep nesting occurrences (4+ levels): $DEEP_NESTING"

#==============================================================================
# 8. NAMING CONVENTIONS
#==============================================================================
print_header "8. Naming Conventions"

print_check "Checking naming conventions..."

# Check for non-snake_case function names
NON_SNAKE=$(grep -rn "fn [A-Z]" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "Self\|None\|Some\|Ok\|Err" | wc -l || echo 0)
NON_SNAKE=$(echo "$NON_SNAKE" | tr -d '[:space:]')

if [[ $NON_SNAKE -eq 0 ]]; then
    print_pass "All functions use snake_case"
else
    print_warn "Found $NON_SNAKE functions not using snake_case"
fi

# Check for non-CamelCase type names
NON_CAMEL=$(grep -rn "^struct [a-z]\|^enum [a-z]\|^trait [a-z]" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
NON_CAMEL=$(echo "$NON_CAMEL" | tr -d '[:space:]')

if [[ $NON_CAMEL -eq 0 ]]; then
    print_pass "All types use CamelCase"
else
    print_warn "Found $NON_CAMEL types not using CamelCase"
fi

# Check for SCREAMING_SNAKE_CASE constants
CONST_COUNT=$(grep -rn "^const [A-Z_]*:" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
CONST_COUNT=$(echo "$CONST_COUNT" | tr -d '[:space:]')
print_info "Constants using SCREAMING_SNAKE_CASE: $CONST_COUNT"

#==============================================================================
# 9. IMPORT ORGANIZATION
#==============================================================================
print_header "9. Import Organization"

print_check "Checking import organization..."

# Check for glob imports (use foo::*)
GLOB_IMPORTS=$(grep -rn "use.*::\*" rustos-*/src --include="*.rs" 2>/dev/null | grep -v "test" | wc -l || echo 0)
GLOB_IMPORTS=$(echo "$GLOB_IMPORTS" | tr -d '[:space:]')

if [[ $GLOB_IMPORTS -eq 0 ]]; then
    print_pass "No glob imports (use foo::*)"
else
    print_warn "Found $GLOB_IMPORTS glob imports - consider explicit imports"
    if [[ $VERBOSE -eq 1 ]]; then
        grep -rn "use.*::\*" rustos-*/src --include="*.rs" | grep -v "test" | head -5
    fi
fi

# Check for unused imports (via clippy)
print_info "Unused imports checked via clippy (section 2)"

#==============================================================================
# 10. TODO/FIXME CHECK
#==============================================================================
print_header "10. TODO/FIXME Comments"

print_check "Scanning for TODO/FIXME comments..."

TODO_COUNT=$(grep -rn "TODO\|FIXME\|XXX\|HACK" rustos-*/src --include="*.rs" 2>/dev/null | wc -l || echo 0)
TODO_COUNT=$(echo "$TODO_COUNT" | tr -d '[:space:]')

if [[ $TODO_COUNT -eq 0 ]]; then
    print_pass "No TODO/FIXME comments found"
else
    print_info "Found $TODO_COUNT TODO/FIXME/XXX/HACK comments"
    if [[ $VERBOSE -eq 1 ]]; then
        grep -rn "TODO\|FIXME\|XXX\|HACK" rustos-*/src --include="*.rs" | head -10
    fi
fi

#==============================================================================
# 11. LINE LENGTH CHECK
#==============================================================================
print_header "11. Line Length Check"

print_check "Checking for long lines (>100 chars)..."

LONG_LINES=0
for crate in "${CRATES[@]}"; do
    if [[ ! -d "$crate/src" ]]; then
        continue
    fi
    
    CRATE_LONG=$(find "$crate/src" -name "*.rs" -exec awk 'length > 100 { count++ } END { print count+0 }' {} + 2>/dev/null | awk '{s+=$1} END {print s+0}')
    LONG_LINES=$((LONG_LINES + CRATE_LONG))
done

if [[ $LONG_LINES -eq 0 ]]; then
    print_pass "No lines exceed 100 characters"
elif [[ $LONG_LINES -lt 50 ]]; then
    print_info "Found $LONG_LINES lines exceeding 100 characters"
else
    print_warn "Found $LONG_LINES lines exceeding 100 characters"
fi

#==============================================================================
# 12. DEAD CODE CHECK
#==============================================================================
print_header "12. Dead Code Analysis"

print_check "Checking for dead code..."

DEAD_CODE_OUTPUT=$(cargo clippy --workspace --target riscv32imac-unknown-none-elf -- \
    -W dead_code \
    -W unused_variables \
    -W unused_imports \
    2>&1) || true

DEAD_WARNS=$(echo "$DEAD_CODE_OUTPUT" | grep -c "warning:.*dead_code\|warning:.*unused" || echo "0")
DEAD_WARNS=$(echo "$DEAD_WARNS" | tr -d '[:space:]')

if [[ $DEAD_WARNS -eq 0 ]]; then
    print_pass "No dead code detected"
else
    print_warn "Found $DEAD_WARNS dead code/unused warnings"
    if [[ $VERBOSE -eq 1 ]]; then
        echo "$DEAD_CODE_OUTPUT" | grep "warning:.*dead_code\|warning:.*unused" | head -10
    fi
fi

#==============================================================================
# SUMMARY
#==============================================================================
print_header "Lint Summary"

echo ""
echo "Results:"
echo "  - Errors:   $ERRORS"
echo "  - Warnings: $WARNINGS"
echo ""

if [[ $EXIT_CODE -eq 0 ]]; then
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                         LINTING PASSED                                       ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
else
    echo -e "${RED}╔══════════════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}║                         LINTING FAILED                                       ║${NC}"
    echo -e "${RED}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${YELLOW}Run with --fix to automatically fix some issues${NC}"
fi

exit $EXIT_CODE
