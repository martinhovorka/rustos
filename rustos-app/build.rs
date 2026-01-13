//! REQ: BUILD-010 - Build script for rustos-app

use std::env;
use std::path::PathBuf;

fn main() {
    // REQ: BUILD-011 - Ensure linker script is available
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());

    println!("cargo:rustc-link-search={}", out_dir.display());
    println!("cargo:rerun-if-changed=build.rs");
}
