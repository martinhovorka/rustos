//! REQ: BUILD-010 - Build script for rustos-board

use std::env;
use std::fs;
use std::path::PathBuf;

fn main() {
    // REQ: BUILD-011 - Link memory.x linker script
    let out_dir = PathBuf::from(env::var("OUT_DIR").unwrap());
    
    // Copy memory.x to output directory
    fs::copy("memory.x", out_dir.join("memory.x")).unwrap();
    
    // Tell cargo to link memory.x
    println!("cargo:rustc-link-search={}", out_dir.display());
    println!("cargo:rerun-if-changed=memory.x");
    println!("cargo:rerun-if-changed=build.rs");
}
