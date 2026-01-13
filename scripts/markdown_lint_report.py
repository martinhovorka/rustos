#!/usr/bin/env python3
"""Simple markdown linter for common rules we can auto-fix:
- Trailing whitespace (MD009)
- Files must end with a single newline (MD041-ish)
- No multiple consecutive blank lines (>1) (MD012)
- ATX headings must have a space after '#' (MD018)
- No trailing spaces on lines

This script reports issues per file and can optionally apply fixes.
"""
import sys
from pathlib import Path
import argparse

R = Path(__file__).resolve().parent.parent

DEFAULT_FILES = [
    "requirements/REQUIREMENTS.md",
    "IMPLEMENTATION_STATUS.md",
    "rustos-kernel/README.md",
    "bsp/README.md",
    "hardware/README.md",
    "TEST_COVERAGE_REPORT.md",
    "README.md",
    "docs/VERIFICATION_REPORT.md",
    "docs/EXAMPLES.md",
    "docs/TRACEABILITY_MATRIX.md",
    "docs/ARCHITECTURE.md",
    "docs/API_STABILITY.md",
    "docs/SYNC_PRIMITIVES.md",
    "docs/ROADMAP.md",
    "docs/PERFORMANCE_BENCHMARKS.md",
    "docs/CERTIFICATION.md",
    "docs/TEST_INFRASTRUCTURE.md",
    "docs/GETTING_STARTED.md",
    "docs/HAL_VERIFICATION.md",
    "docs/TASK_PROGRAMMING.md",
    "QA_README.md",
    "CHANGELOG.md",
    "review/CONSOLIDATED_FINAL_REVIEW.md",
    "review/SEVEN_PERSPECTIVE_RELEASE_REVIEW_2026-01-13.md",
    "review/requirements/REVIEW.md",
    "review/CONSOLIDATED_STATUS_REPORTS.md",
    "review/DOCUMENTATION_REVIEW_REPORT.md",
    "review/COMPREHENSIVE_FINAL_RELEASE_REVIEW.md",
    "review/RELEASE_READINESS_SUMMARY.md",
    "review/EXECUTIVE_SUMMARY.md",
    "review/FINAL_RELEASE_REVIEW_REPORT.md",
    ".github/copilot-instructions.md",
]

RULES = [
    "trailing_whitespace",
    "final_newline",
    "multiple_blank_lines",
    "space_after_atx",
]


def check_file(p: Path):
    issues = []
    text = p.read_text(encoding="utf-8")
    lines = text.splitlines()

    # Trailing whitespace (skip fenced code blocks)
    in_fence = False
    for i, ln in enumerate(lines, start=1):
        if ln.strip().startswith('```'):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        if ln.endswith(" ") or ln.endswith("\t"):
            issues.append(("trailing_whitespace", i, ln))

    # Multiple blank lines (skip fences)
    blank_run = 0
    in_fence = False
    for i, ln in enumerate(lines, start=1):
        if ln.strip().startswith('```'):
            in_fence = not in_fence
            continue
        if in_fence:
            blank_run = 0
            continue
        if ln.strip() == "":
            blank_run += 1
            if blank_run > 1:
                issues.append(("multiple_blank_lines", i, ""))
        else:
            blank_run = 0

    # Space after ATX headings (skip fenced code blocks)
    import re
    in_fence = False
    for i, ln in enumerate(lines, start=1):
        if ln.strip().startswith('```'):
            in_fence = not in_fence
            continue
        if in_fence:
            continue
        m = re.match(r'^(#{1,6})([^\s#-]|$)', ln)
        if m:
            issues.append(("space_after_atx", i, ln))

    # Final newline
    if not text.endswith("\n"):
        issues.append(("final_newline", len(lines), "EOF not newline"))

    return issues


def fix_file(p: Path):
    text = p.read_text(encoding="utf-8")
    changed = False
    lines = text.splitlines()
    new_lines = []

    prev_blank = False
    in_fence = False
    for ln in lines:
        # Toggle fenced code block state
        if ln.strip().startswith('```'):
            in_fence = not in_fence
            new_lines.append(ln)
            continue
        if in_fence:
            # don't modify content inside code fences
            new_lines.append(ln)
            continue
        # Remove trailing whitespace
        if ln.endswith(" ") or ln.endswith("\t"):
            ln = ln.rstrip(" \t")
            changed = True
        # Collapse multiple blank lines
        if ln.strip() == "":
            if prev_blank:
                # skip this blank line
                changed = True
                continue
            prev_blank = True
            new_lines.append(ln)
        else:
            prev_blank = False
            # Ensure space after ATX heading
            if ln.startswith("#"):
                import re
                ln = re.sub(r'^(#{1,6})([^\s#-])', r'\1 \2', ln)
                # also collapse many spaces after hashes to single space
                ln = re.sub(r'^(#{1,6})\s+', lambda m: m.group(1) + ' ', ln)
            new_lines.append(ln)

    # Ensure single final newline
    if len(new_lines) == 0 or new_lines[-1] != "":
        # append a blank line at end
        new_lines.append("")
        changed = True

    new_text = "\n".join(new_lines)
    if changed:
        p.write_text(new_text + "\n", encoding="utf-8")
    return changed


def find_all_md_files(base: Path):
    """Find all .md files in the repo, excluding common ignore folders."""
    excludes = {".git", "target", "hardware/artifacts", "node_modules"}
    out = []
    for p in base.rglob('*.md'):
        if any(str(p).startswith(str(base / e)) for e in excludes):
            continue
        out.append(p)
    return sorted(out)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true", help="Apply fixes")
    parser.add_argument("--all", action="store_true", help="Scan all .md files in the repo")
    args = parser.parse_args()

    base = Path.cwd()
    if args.all:
        files = find_all_md_files(base)
    else:
        files = [base / f for f in DEFAULT_FILES]
        files = [f for f in files if f.exists()]

    total_issues = 0
    total_files = 0
    modified = []
    for f in files:
        issues = check_file(f)
        if issues:
            print(f"{f}: {len(issues)} issue(s)")
            for rule, ln, content in issues[:5]:
                print(f"  - {rule} at line {ln}")
            total_issues += len(issues)
            total_files += 1
            if args.apply:
                if fix_file(f):
                    modified.append(str(f.relative_to(base)))

    print(f"Scan complete: {total_issues} issue(s) across {total_files} files")
    if args.apply:
        if modified:
            print("Modified files:")
            for m in modified:
                print(" - " + m)
        else:
            print("No files modified.")

if __name__ == '__main__':
    main()
