#!/bin/bash
# REQ: DEV-002 - Clean build artifacts

set -e

echo "Cleaning RustOS build artifacts..."

# Clean Cargo build artifacts
echo "Removing target directory..."
cargo clean

# Remove generated artifacts
echo "Removing additional artifacts..."
rm -f rustos-app.elf
rm -f rustos-app.bin
rm -f *.profraw
rm -f *.profdata
rm -rf coverage/

echo ""
echo "Clean complete!"
