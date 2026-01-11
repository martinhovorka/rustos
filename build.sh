#!/bin/bash
# REQ: BUILD-001 - Build script for RustOS

set -e

echo "Building RustOS..."

# REQ: BUILD-002 - Check Rust version
RUST_VERSION=$(rustc --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
echo "Rust version: $RUST_VERSION"

# REQ: DEP-001 - Install RISC-V target
echo "Ensuring RISC-V target is installed..."
rustup target add riscv32imac-unknown-none-elf

# REQ: BUILD-003 - Build all crates
echo "Building workspace..."
cargo build --release --workspace

# REQ: BUILD-004 - Build application
echo "Building application..."
cd rustos-app
cargo build --release

echo ""
echo "Build complete!"
echo "Output: target/riscv32imac-unknown-none-elf/release/rustos-app"
echo ""

# REQ: BUILD-005 - Display binary size
echo "Binary size:"
rust-size target/riscv32imac-unknown-none-elf/release/rustos-app 2>/dev/null || \
    riscv64-unknown-elf-size target/riscv32imac-unknown-none-elf/release/rustos-app 2>/dev/null || \
    echo "  (size tool not available)"
