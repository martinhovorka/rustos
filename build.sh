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
# REQ: BUILD-004 - Build application
echo "Building workspace..."
cargo build --release --all --target riscv32imac-unknown-none-elf

readonly ELF_PATH="target/riscv32imac-unknown-none-elf/release/rustos-app"
readonly ELF="./rustos-app.elf"
readonly ARTIFACTS_DIR="./artifacts"
readonly ARTIFACT_ELF="$ARTIFACTS_DIR/rustos-app.elf"

echo ""
echo "Build complete!"
echo "Output: $ELF_PATH"
echo ""

# REQ: BUILD-005 - Display binary size
echo "Binary size:"
rust-size $ELF_PATH 2>/dev/null || \
    riscv64-unknown-elf-size $ELF_PATH 2>/dev/null || \
    echo "  (size tool not available)"

echo
# Create artifacts directory if it doesn't exist
mkdir -p "$ARTIFACTS_DIR"

# Copy to artifacts directory for archival
cp -v --remove-destination "$ELF_PATH" "$ARTIFACT_ELF"

echo "Artifacts:"
sha256sum $ARTIFACT_ELF
