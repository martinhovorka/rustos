#!/usr/bin/env python3
"""
Fix all PAC register files to use UnsafeCell for interior mutability.
This script converts register struct fields from `u32` to `UnsafeCell<u32>` 
and updates all write methods to use `.get()` pattern.
"""

import re
import sys
from pathlib import Path

def fix_pac_file(filepath):
    """Fix a single PAC file"""
    print(f"Processing {filepath}...")
    
    with open(filepath, 'r') as f:
        content = f.read()
    
    original = content
    
    # Add UnsafeCell import if not present
    if 'use core::cell::UnsafeCell;' not in content:
        # Find the imports section and add UnsafeCell
        content = re.sub(
            r'(use core::ptr::{[^}]+};)',
            r'\1\nuse core::cell::UnsafeCell;',
            content
        )
    
    # Fix struct field definitions: change `field: u32,` to `field: UnsafeCell<u32>,`
    # Match field declarations in struct definitions
    content = re.sub(
        r'(\s+)([\w_]+):\s*u32,(\s*(?://.*)?)',
        r'\1\2: UnsafeCell<u32>,\3',
        content
    )
    
    # Fix write_volatile calls: change `&self.field as *const u32 as *mut u32` to `self.field.get()`
    content = re.sub(
        r'write_volatile\(&self\.([\w_]+)\s+as\s+\*const\s+u32\s+as\s+\*mut\s+u32,',
        r'write_volatile(self.\1.get(),',
        content
    )
    
    # Fix read_volatile calls: change `&self.field as *const u32` to `self.field.get()`
    content = re.sub(
        r'read_volatile\(&self\.([\w_]+)\s+as\s+\*const\s+u32\)',
        r'read_volatile(self.\1.get())',
        content
    )
    
    if content != original:
        with open(filepath, 'w') as f:
            f.write(content)
        print(f"  ✓ Fixed {filepath}")
        return True
    else:
        print(f"  - No changes needed for {filepath}")
        return False

def main():
    pac_dir = Path(__file__).parent / 'rustos-pac' / 'src'
    
    files_to_fix = ['intc.rs', 'spi.rs', 'i2c.rs', 'ethernet.rs', 'wdt.rs']
    
    fixed_count = 0
    for filename in files_to_fix:
        filepath = pac_dir / filename
        if filepath.exists():
            if fix_pac_file(filepath):
                fixed_count += 1
        else:
            print(f"Warning: {filepath} not found")
    
    print(f"\nFixed {fixed_count} files")
    return 0

if __name__ == '__main__':
    sys.exit(main())
