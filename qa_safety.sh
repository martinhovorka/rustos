#!/bin/bash
# REQ: DEV-007 - Unsafe code usage analysis

set -e

echo "Analyzing unsafe code usage in RustOS..."
echo ""

# Check for required tools and install if needed
if ! command -v cargo-geiger &> /dev/null; then
    echo "Installing cargo-geiger..."
    cargo install cargo-geiger
else
    echo "✓ cargo-geiger found"
fi

echo "Running cargo-geiger to analyze unsafe code..."
echo ""

# Run geiger analysis on each crate
for crate in rustos-pac rustos-kernel rustos-board rustos-app rustos-tests; do
    if [ -d "$crate" ]; then
        echo ""
        echo "Analyzing $crate..."
        echo "----------------------------------------"
        (cd "$crate" && cargo geiger --all-targets --all-features --output-format GitHubMarkdown 2>&1 | grep -v "^\{" | grep -v "artifact" || true)
    fi
done

echo ""
echo "Note: rustos-hal skipped due to optional feature compilation issues"
echo "      (peripheral drivers are feature-gated and not all enabled)"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Safety Requirements:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "REQ: SAFE-001 - Written in safe Rust where possible"
echo "REQ: SAFE-002 - Minimal unsafe code (only for hardware access, inline asm)"
echo "REQ: SAFE-003 - Unsafe code clearly documented with safety invariants"
echo "REQ: SAFE-007 - All unsafe blocks shall have // SAFETY: comments"
echo "REQ: SAFE-008 - Unsafe code percentage shall be ≤ 5% of total codebase"
echo "REQ: PERF-036 - Unsafe code percentage measured using cargo-geiger"
echo ""

# Additional analysis: Find unsafe blocks without SAFETY comments
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Checking for unsafe blocks without SAFETY comments (REQ: SAFE-007)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create report file
REPORT_FILE="safety_audit_$(date +%Y%m%d_%H%M%S).txt"
echo "RustOS Safety Audit Report" > "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"
echo "========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Search for unsafe blocks in source files
MISSING_SAFETY=0
TOTAL_UNSAFE=0
declare -A CRATE_STATS

for crate in rustos-pac rustos-hal rustos-kernel rustos-board rustos-app; do
    if [ -d "$crate/src" ]; then
        echo "Checking $crate..."
        CRATE_MISSING=0
        CRATE_TOTAL=0
        
        # Find Rust source files with unsafe blocks
        FILES=$(find "$crate/src" -name "*.rs" -type f)
        
        for file in $FILES; do
            # Look for unsafe blocks
            if grep -q "unsafe" "$file"; then
                # Check if there's a SAFETY comment nearby (within 3 lines before)
                # This is a heuristic - not perfect but catches most cases
                UNSAFE_LINES=$(grep -n "unsafe" "$file" | cut -d: -f1)
                
                for line_num in $UNSAFE_LINES; do
                    TOTAL_UNSAFE=$((TOTAL_UNSAFE + 1))
                    CRATE_TOTAL=$((CRATE_TOTAL + 1))
                    
                    # Check 3 lines before for SAFETY comment
                    START=$((line_num - 3))
                    [ $START -lt 1 ] && START=1
                    
                    CONTEXT=$(sed -n "${START},${line_num}p" "$file")
                    
                    if ! echo "$CONTEXT" | grep -q "SAFETY:"; then
                        echo "  ⚠ $file:$line_num - unsafe without SAFETY comment"
                        echo "$file:$line_num" >> "$REPORT_FILE"
                        MISSING_SAFETY=$((MISSING_SAFETY + 1))
                        CRATE_MISSING=$((CRATE_MISSING + 1))
                    fi
                done
            fi
        done
        
        CRATE_STATS[$crate]="$CRATE_MISSING/$CRATE_TOTAL"
        
        if [ $CRATE_TOTAL -gt 0 ]; then
            COMPLIANCE=$((100 - (CRATE_MISSING * 100 / CRATE_TOTAL)))
            echo "  → $crate: $CRATE_MISSING missing / $CRATE_TOTAL total ($COMPLIANCE% compliant)"
        fi
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Summary:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $MISSING_SAFETY -eq 0 ]; then
    echo "✅ PASS - All unsafe blocks have SAFETY comments"
    echo "Status: PASS" >> "$REPORT_FILE"
else
    OVERALL_COMPLIANCE=$((100 - (MISSING_SAFETY * 100 / TOTAL_UNSAFE)))
    echo "❌ FAIL - Found $MISSING_SAFETY unsafe block(s) without SAFETY comments"
    echo "         Total unsafe blocks analyzed: $TOTAL_UNSAFE"
    echo "         Compliance rate: $OVERALL_COMPLIANCE%"
    echo ""
    echo "REQ: SAFE-007 VIOLATION - All unsafe blocks shall have // SAFETY: comments"
    echo ""
    echo "Status: FAIL" >> "$REPORT_FILE"
    echo "Missing SAFETY comments: $MISSING_SAFETY / $TOTAL_UNSAFE" >> "$REPORT_FILE"
    echo "Compliance rate: $OVERALL_COMPLIANCE%" >> "$REPORT_FILE"
fi

echo ""
echo "Per-crate breakdown:"
for crate in rustos-pac rustos-hal rustos-kernel rustos-board rustos-app; do
    if [ -n "${CRATE_STATS[$crate]}" ]; then
        echo "  $crate: ${CRATE_STATS[$crate]}"
    fi
done

echo ""
echo "Report saved to: $REPORT_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Action Items:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

if [ $MISSING_SAFETY -gt 0 ]; then
    echo "1. Review all flagged locations in the report file"
    echo "2. Add // SAFETY: comments documenting why each unsafe block is safe"
    echo "3. Ensure SAFETY comments explain invariants and assumptions"
    echo "4. Re-run this script to verify compliance"
    echo ""
    echo "Example SAFETY comment format:"
    echo "  // SAFETY: Pointer is valid because [explain why]"
    echo "  // Invariants: [list any invariants]"
    echo "  unsafe { ... }"
fi

echo ""
