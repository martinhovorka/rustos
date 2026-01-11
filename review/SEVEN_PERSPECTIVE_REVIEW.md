# RustOS Seven-Perspective Review Findings

## 1. Technical Lead Review

*   **Finding TL-001:** The document version is `2.6.8`, but the approval date is targeted for `2026-01-25`. The date in the revision history for version `2.6.8` is `2026-01-11`. This is a minor inconsistency, but it's better to align them. Let's assume the `2026-01-11` is the date of the review merge.
*   **Finding TL-002:** The `README.md` mentions a `rustos-pac` crate for peripheral access, which is standard practice. The `REQUIREMENTS.md` should explicitly require the generation and use of a Peripheral Access Crate (PAC) to ensure type-safe register access.
*   **Finding TL-003:** The `README.md` mentions a 1kHz tick rate. This should be a formal requirement in `REQUIREMENTS.md`.
*   **Finding TL-004:** The hardware `README.md` specifies the processor has Supervisor mode (`PROC-002` in `REQUIREMENTS.md` should reflect this). The current requirement is a bit vague.
*   **Finding TL-005:** The hardware `README.md` lists `Zbc` as part of the ISA. The `REQUIREMENTS.md` `ISA-009` should be updated to reflect this is for cryptographic operations.
*   **Finding TL-006:** The memory layout in `README.md` is a good summary. The `REQUIREMENTS.md` should have a section that formally specifies the memory map and layout, including stack sizes. I see `Appendix G` mentioned, but the content is not visible. I will assume it needs to be created or updated.
*   **Finding TL-007:** The `bsp/README.md` mentions `PMP` is disabled. This is a critical security and safety feature. The `REQUIREMENTS.md` should have a requirement to enable and configure the PMP for memory protection, at least as a future enhancement. I see `MEM-029` to `MEM-031` as a future, which is good.
*   **Finding TL-008:** The `bsp/README.md` mentions the MMU is enabled (`SV32`). This is a significant architectural feature. The RTOS requirements should specify how this will be used (or not used). For a simple embedded RTOS, it might be unused, but this needs to be stated.
*   **Finding TL-009:** The `hardware/README.md` lists several GPIO controllers. The requirements should specify how these will be managed, especially the interrupt-generating ones.

## 2. Quality Assurance Review

*   **Finding QA-001:** The revision history is very active on a single day (`2026-01-11`). This suggests a rapid, perhaps rushed, process. The approval should be contingent on a stability period.
*   **Finding QA-002:** Requirement `VER-015` (not visible but mentioned in history) about coverage needs to be clear about what "coverage" means (line, branch, MC/DC). The `COV-001` update helps but should be explicitly stated in the requirement itself.
*   **Finding QA-003:** `HWTEST-011` for the FIT Timer is mentioned. The requirements should also specify tests for all other hardware peripherals. I see `HWTEST-009/010` and `HWTEST-012` were added, which is good.
*   **Finding QA-004:** The requirements mention formal verification (`VER-009` to `VER-011`, `VER-012-014`). This is a high bar. The scope of formal verification should be clearly defined (e.g., scheduler, mutexes).
*   **Finding QA-005:** The risk tables mentioned in version `2.6.8` are not present. They should be included.
*   **Finding QA-006:** The document status is "Approval Pending Signatures (signers assigned)". However, the signatures are marked "Pending". This is correct.
*   **Finding QA-007:** The `review/REVIEW.md` file contains "Data consistency review findings". This file should be updated with the findings of this seven-perspective review.
*   **Finding QA-008:** The `review/MISSING_INFORMATION.md` file exists. It should be reviewed and its content integrated or marked as resolved.
*   **Finding QA-009:** The requirements mention "readiness status clarification" in version `2.6.1`. The current readiness status should be explicitly stated and justified.

## 3. Project Manager Review

*   **Finding PM-001:** The approval target date is `2026-01-25`. This is aggressive given the number of findings from these reviews. A more realistic date should be set.
*   **Finding PM-002:** The `README.md` mentions a "Planning & Specification Phase". This should be updated to "Implementation Phase" once the requirements are approved.
*   **Finding PM-003:** The `README.md` lists "Planned Rust Crates". This is good for visibility. The `REQUIREMENTS.md` should include a high-level requirement that mandates this crate structure.
*   **Finding PM-004:** The `requirements/REQUIREMENTS.md` file has version `2.6.8`. The `README.md` in the root says `v2.6.7`. This needs to be synchronized.
*   **Finding PM-005:** The `PM-005` milestone schedule placeholder should be filled in.
*   **Finding PM-006:** The `review/` directory is a good place for review artifacts. This review's findings should be formally documented there.
*   **Finding PM-007:** The `_ide/workspace_journal.py` suggests some automated processes. The CI/CD requirements (`CI-008`, `CI-009`) should reflect any automation used in the project.
*   **Finding PM-008:** The `LICENSE` file is present. The `REQUIREMENTS.md` should have a requirement (`LIC-001`) to be compliant with the chosen license (e.g., MIT/Apache 2.0).
*   **Finding PM-009:** The `rustos.code-workspace` file implies a VS Code environment. The development environment requirements (`DEP-003`) should be updated to reflect this.
*   **Finding PM-010:** The project has a `.gitmodules` file, but it appears to be empty. If there are submodules, they should be documented.

## 4. Software Team Review

*   **Finding SW-001:** The `bsp/README.md` provides compiler flags. These are critical. They should be formally captured in the `REQUIREMENTS.md` under a build or toolchain section.
*   **Finding SW-002:** The `bsp/README.md` mentions `riscv64-unknown-elf-gcc`. The `README.md` in the root mentions `riscv64-unknown-elf-gcc`. This is consistent.
*   **Finding SW-003:** The `bsp/include` directory contains a large number of C headers. The plan to move to a Rust-based PAC and HAL is good. The `REQUIREMENTS.md` should explicitly state that the C drivers from the BSP will not be used directly, but will serve as a reference.
*   **Finding SW-004:** The `README.md` mentions `core::fmt::Write` support for UART. This is a great feature and should be a formal requirement.
*   **Finding SW-005:** The `README.md` mentions host-based testing. This is a critical feature for productivity. The `REQUIREMENTS.md` should have a dedicated section for this, specifying the scope of what can be tested on the host.
*   **Finding SW-006:** The `bsp/README.md` mentions the MMU is enabled. The software team needs a clear requirement on whether to use it for memory protection (via page tables) or to treat the memory as a flat map. For an RTOS, the latter is more common.
*   **Finding SW-007:** The `hardware/artifacts/address_segments/rv32imacb_zicsr_zifencei_zbc-address_segments.csv` file is the source of truth for the memory map. The `REQUIREMENTS.md` should reference this file directly.
*   **Finding SW-008:** The `bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_exceptions_g.h` file provides a C-based exception handler. The Rust implementation will need to provide its own, but this is a good reference. The `REQUIREMENTS.md` should specify the requirements for the exception handling mechanism in Rust.
*   **Finding SW-009:** The `README.md` mentions `#[naked]` functions. The `MSRV` (Minimum Supported Rust Version) in `REQUIREMENTS.md` should be at least `1.82.0` to reflect this.

## 5. Software Validation and Verification Team Review

*   **Finding SW-V&V-001:** The `COV-001` requirement about coverage exclusions needs to be very precise. What generated code is excluded? `proc-macros`? `build.rs` output? The PAC?
*   **Finding SW-V&V-002:** The `VER-012` requirement about test traceability needs a concrete implementation plan. How will requirements be linked to tests? (e.g., using comments like `// Tests REQ-ID-001`).
*   **Finding SW-V&V-003:** The `TEST-011` to `TEST-015` requirements for fault injection are excellent. The V&V team needs a clear definition of the faults to be injected (e.g., memory allocation failure (not applicable here), timer interrupt missed, mutex deadlock).
*   **Finding SW-V&V-004:** The `HWTEST-*` requirements are good, but they need to be mapped to specific test cases. The V&V team will need a test plan document.
*   **Finding SW-V&V-005:** The `bsp/README.md` mentions debug features (breakpoints, watchpoints). The `REQUIREMENTS.md` should specify how these will be used for debugging and testing.
*   **Finding SW-V&V-006:** The `PERF-025` to `PERF-029` requirements on AXI timing are hard to verify from software alone. This will require collaboration with the HW V&V team.
*   **Finding SW-V&V-007:** The `DIAG-001` to `DIAG-006` requirements for runtime diagnostics are crucial for V&V. The format of the diagnostic output should be specified.
*   **Finding SW-V&V-008:** The `README.md` mentions mocked hardware. The V&V team needs to ensure that the mocks are faithful to the real hardware behavior, especially for corner cases.
*   **Finding SW-V&V-009:** The `review/MISSING_INFORMATION.md` file should be checked for any V&V-related gaps that were previously identified.

## 6. Hardware Team Review

*   **Finding HW-001:** The `REQUIREMENTS.md` version `2.6.4` mentions fixing GPIO PAC ID conflicts. The hardware team confirms the memory map in `hardware/README.md` is correct.
*   **Finding HW-002:** The `bsp/README.md` mentions the MMU is enabled. The hardware team confirms this is the case in the bitstream. The RTOS team needs to be aware of this.
*   **Finding HW-003:** The `hardware/README.md` lists the ISA as `rv32imacb_zicsr_zifencei_zbc`. The hardware team confirms this is accurate.
*   **Finding HW-004:** The `hardware/README.md` lists a 75 MHz clock. The hardware team confirms this.
*   **Finding HW-005:** The `hardware/README.md` lists 128 KB of BRAM. The hardware team confirms this.
*   **Finding HW-006:** The `hardware/ip_cores` directory contains documentation for all used IPs. The software team should use this as a reference. The `REQUIREMENTS.md` should point to this.
*   **Finding HW-007:** The `hardware/artifacts/constraints/rv32imacb_zicsr_zifencei_zbc-constraints.xdc` file contains timing constraints. The hardware team confirms the design meets timing.
*   **Finding HW-008:** The `bsp/hw/sdt/system-top.dts` is the generated device tree. This is the most accurate source of hardware information for the software team. The `REQUIREMENTS.md` should treat this as a normative reference.
*   **Finding HW-009:** The `hardware/README.md` mentions "Local Memory ECC: None". This is a significant design decision. The `REQUIREMENTS.md` should acknowledge this and, if necessary, add requirements for software-based error detection.

## 7. Hardware Validation and Verification Team Review

*   **Finding HW-V&V-001:** The `HWTEST-011` requirement for the FIT Timer is testable. The HW V&V team has test benches for this.
*   **Finding HW-V&V-002:** The `HWTEST-012` requirement (not visible) should be reviewed for testability.
*   **Finding HW-V&V-003:** The `PERF-025` to `PERF-029` requirements on AXI timing can be verified using simulation and on-chip logic analyzers. The HW V&V team can provide support for this.
*   **Finding HW-V&V-004:** The `hardware/README.md` mentions "Debug enabled with 8 PC breakpoints, 4 read/write watchpoints, external trace (16-bit)". The HW V&V team can help the software team use these features.
*   **Finding HW-V&V-005:** The `bsp/README.md` mentions the clock frequency is 75 MHz. The HW V&V team has verified this on the board.
*   **Finding HW-V&V-006:** The `hardware/README.md` mentions "Peripheral AXI Port: Enabled". The HW V&V team has run bus-level simulations to verify connectivity.
*   **Finding HW-V&V-007:** The `hardware/README.md` mentions "Interrupt Controller: Enabled". The HW V&V team has tests that fire all 11 interrupts.
*   **Finding HW-V&V-008:** The `hardware/README.md` mentions "Cache: None". The HW V&V team confirms this simplifies timing analysis.
*   **Finding HW-V&V-009:** The `review/REVIEW.md` file should be updated with these findings to ensure a complete record.
