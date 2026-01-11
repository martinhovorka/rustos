# RustOS Requirements Specification

**A preemptive, priority-based real-time operating system (RTOS) written in Rust for RISC-V embedded systems.**

---

## Document Control

| Property               | Value                                      |
|------------------------|--------------------------------------------|
| Document ID            | RUSTOS-SRS-001                             |
| Version                | 2.0.0                                      |
| Status                 | Draft                                      |
| Classification         | Internal                                   |
| Author                 | RustOS Development Team                    |
| Owner                  | System Architecture Team                   |
| Effective Date         | 2026-01-11                                 |
| Review Date            | 2026-04-11                                 |
| Approval Authority     | Technical Lead                             |

### Revision History

| Version | Date       | Author      | Description                                              |
|---------|------------|-------------|----------------------------------------------------------|
| 1.0.0   | 2025-12-30 | Dev Team    | Initial requirements specification                       |
| 2.0.0   | 2026-01-11 | Dev Team    | Commercial-grade production-ready requirements update    |

### Approval Record

| Role                    | Name           | Signature | Date       |
|-------------------------|----------------|-----------|------------|
| Technical Lead          | [TBD]          |           |            |
| Quality Assurance       | [TBD]          |           |            |
| Project Manager         | [TBD]          |           |            |

### Distribution List

| Name/Role                          | Copy Type   |
|------------------------------------|-------------|
| Development Team                   | Controlled  |
| Quality Assurance Team             | Controlled  |
| Project Management                 | Controlled  |
| Customer (if applicable)           | Controlled  |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Scope and Objectives](#2-scope-and-objectives)
3. [Definitions, Acronyms, and Abbreviations](#3-definitions-acronyms-and-abbreviations)
4. [References](#4-references)
5. [Target Platform Requirements](#5-target-platform-requirements)
6. [Kernel Requirements](#6-kernel-requirements)
7. [Synchronization Requirements](#7-synchronization-requirements)
8. [Memory Management Requirements](#8-memory-management-requirements)
9. [Hardware Abstraction Layer (HAL) Requirements](#9-hardware-abstraction-layer-hal-requirements)
10. [Board Support Package (BSP) Requirements](#10-board-support-package-bsp-requirements)
11. [Peripheral Access Crate (PAC) Requirements](#11-peripheral-access-crate-pac-requirements)
12. [Application Requirements](#12-application-requirements)
13. [Build System Requirements](#13-build-system-requirements)
14. [Performance Requirements](#14-performance-requirements)
15. [Safety and Reliability Requirements](#15-safety-and-reliability-requirements)
16. [Security Requirements](#16-security-requirements)
17. [Quality Requirements](#17-quality-requirements)
18. [Deployment Requirements](#18-deployment-requirements)
19. [Verification and Validation Requirements](#19-verification-and-validation-requirements)
20. [Documentation Requirements](#20-documentation-requirements)
21. [Constraints and Limitations](#21-constraints-and-limitations)
22. [Risk Analysis](#22-risk-analysis)
23. [Traceability Matrix](#23-traceability-matrix)
24. [Appendices](#24-appendices)

---

## 1. Introduction

### 1.1 Purpose

This Software Requirements Specification (SRS) document defines the functional and non-functional requirements for RustOS, a preemptive, priority-based real-time operating system written in Rust for RISC-V embedded systems. This document serves as the authoritative source for all system requirements and provides the basis for design, implementation, testing, and acceptance.

### 1.2 Intended Audience

This document is intended for:

- **System Architects**: To understand system constraints and design boundaries
- **Software Developers**: To implement features according to specified requirements
- **Quality Assurance Engineers**: To develop verification and validation plans
- **Project Managers**: To track project scope and progress
- **Technical Writers**: To develop user and technical documentation
- **Customers/Stakeholders**: To validate system capabilities meet expectations

### 1.3 Document Conventions

#### 1.3.1 Requirement Priority Levels

| Priority | Description                                                                                   |
|----------|-----------------------------------------------------------------------------------------------|
| Must     | Mandatory requirement; system shall not ship without this feature                             |
| Should   | Important requirement; expected to be implemented unless significant obstacles exist          |
| Could    | Desirable requirement; implemented if time and resources permit                               |
| Info     | Informational only; not a requirement but provides context for other requirements             |

#### 1.3.2 Requirement Identifier Format

Requirements follow the format: `<CATEGORY>-<NUMBER>`

- `HW`: Hardware requirements
- `ISA`: Instruction Set Architecture requirements
- `PROC`: Processor configuration requirements
- `EXC`: Exception handling requirements
- `PER`: Peripheral requirements
- `DBG`: Debug requirements
- `INIT`: Initialization requirements
- `SCHED`: Scheduler requirements
- `TASK`: Task management requirements
- `CTX`: Context switching requirements
- `CRIT`: Critical section requirements
- `TIME`: Time management requirements
- `API`: API requirements
- `ISR`: Interrupt service routine requirements
- `ERR`: Error handling requirements
- `MTX`: Mutex requirements
- `SEM`: Semaphore requirements
- `MQ`: Message queue requirements
- `EVT`: Event flag requirements
- `MEM`: Memory requirements
- `ALLOC`: Allocator requirements
- `UART`: UART driver requirements
- `TMR`: Timer driver requirements
- `WDT`: Watchdog timer requirements
- `GPIO`: GPIO driver requirements
- `SPI`: SPI driver requirements
- `I2C`: I2C driver requirements
- `ETH`: Ethernet driver requirements
- `INT`: Interrupt driver requirements
- `BOOT`: Boot requirements
- `TRAP`: Trap handling requirements
- `CSR`: CSR requirements
- `PAC`: Peripheral Access Crate requirements
- `APP`: Application requirements
- `BUILD`: Build system requirements
- `DEP`: Dependency requirements
- `PROJ`: Project structure requirements
- `SAFE`: Safety requirements
- `REL`: Reliability requirements
- `SEC`: Security requirements
- `QUAL`: Quality requirements
- `DEPLOY`: Deployment requirements
- `DEV`: Development environment requirements
- `PERF`: Performance requirements
- `VER`: Verification requirements
- `DOC`: Documentation requirements

#### 1.3.3 Verification Method Codes

| Code | Method          | Description                                           |
|------|-----------------|-------------------------------------------------------|
| I    | Inspection      | Visual examination of documentation or code           |
| A    | Analysis        | Technical evaluation, modeling, or simulation         |
| D    | Demonstration   | Functional exercise showing capability                |
| T    | Test            | Execution against defined test cases with pass/fail   |

---

## 2. Scope and Objectives

### 2.1 Product Scope

RustOS is a lightweight, real-time operating system designed for resource-constrained embedded systems. The system targets the MicroBlaze V (RISC-V) soft-core processor running on the Digilent Arty A7-35 FPGA development board.

### 2.2 Product Objectives

| Objective ID | Description                                                              | Success Criteria                                     |
|--------------|--------------------------------------------------------------------------|------------------------------------------------------|
| OBJ-001      | Provide deterministic real-time task scheduling                          | Context switch latency ≤ 5 µs at 75 MHz              |
| OBJ-002      | Implement safe concurrency primitives in Rust                            | Zero data races in concurrent operations             |
| OBJ-003      | Minimize memory footprint for resource-constrained systems               | Total footprint ≤ 64 KB                              |
| OBJ-004      | Enable development without dynamic memory allocation                     | Zero heap allocations at runtime                     |
| OBJ-005      | Provide comprehensive hardware abstraction for target peripherals        | HAL coverage for all Must-priority peripherals       |
| OBJ-006      | Ensure memory safety through Rust's ownership system                     | Zero memory safety violations in unsafe-free code    |
| OBJ-007      | Support industry-standard embedded-rust ecosystem                        | Compatible with `embedded-hal` 1.0 traits            |
| OBJ-008      | Enable host-based testing for rapid development                          | ≥ 80% code coverage on testable modules              |

### 2.3 Product Boundaries

#### 2.3.1 In Scope

- Preemptive priority-based scheduler with 256 priority levels
- Static task management (up to 16 tasks)
- Synchronization primitives (mutex, semaphore, message queue, event flags)
- Hardware drivers for core peripherals (UART, Timer, GPIO, SPI, I2C)
- Board support package for Digilent Arty A7-35
- Host-based test framework

#### 2.3.2 Out of Scope

- Dynamic task creation after boot
- Memory management unit (MMU) utilization
- Network protocol stacks (TCP/IP, UDP)
- File systems
- Power management
- Multi-core support
- Virtual memory

### 2.4 Stakeholder Requirements

| Stakeholder             | Requirement                                          | Priority |
|-------------------------|------------------------------------------------------|----------|
| Embedded Developers     | Easy-to-use API with Rust idioms                     | Must     |
| System Integrators      | Clear hardware abstraction boundaries                | Must     |
| Safety Engineers        | Minimal unsafe code with documented invariants       | Must     |
| Quality Assurance       | Testable design with coverage metrics                | Should   |
| Technical Writers       | Well-documented public API                           | Should   |

---

## 3. Definitions, Acronyms, and Abbreviations

### 3.1 Definitions

| Term                    | Definition                                                                                     |
|-------------------------|------------------------------------------------------------------------------------------------|
| Context Switch          | The process of storing the state of a running task and restoring the state of another task    |
| Critical Section        | A code segment that accesses shared resources and must execute atomically                     |
| Deadlock                | A state where two or more tasks are unable to proceed because each is waiting for the other   |
| Idle Task               | A lowest-priority task that runs when no other tasks are ready                                |
| Interrupt Latency       | Time from interrupt assertion to first instruction of interrupt handler                       |
| Jitter                  | Variation in periodic timing, such as interrupt or task activation times                      |
| Preemption              | The act of interrupting a running task to allow a higher-priority task to execute             |
| Priority Inversion      | A condition where a high-priority task is blocked by a lower-priority task                    |
| Real-Time System        | A system where correctness depends on both logical results and timing                         |
| Scheduler               | The kernel component responsible for deciding which task runs next                            |
| Soft Real-Time          | Systems where occasional deadline misses are tolerable                                        |
| Task                    | An independent thread of execution with its own stack and context                             |
| Task Control Block      | Data structure containing task state, priority, and stack pointer                             |
| Tick                    | A regular timer interrupt used for time-based scheduling and delays                           |
| Watchdog Timer          | A timer that resets the system if not periodically refreshed                                  |

### 3.2 Acronyms

| Acronym | Expansion                                     |
|---------|-----------------------------------------------|
| ABI     | Application Binary Interface                  |
| AMO     | Atomic Memory Operation                       |
| API     | Application Programming Interface             |
| AXI     | Advanced eXtensible Interface                 |
| BRAM    | Block Random Access Memory                    |
| BSP     | Board Support Package                         |
| CAS     | Compare-And-Swap                              |
| CSR     | Control and Status Register                   |
| DDR     | Double Data Rate                              |
| ELF     | Executable and Linkable Format                |
| FIFO    | First In, First Out                           |
| FPGA    | Field-Programmable Gate Array                 |
| GPIO    | General Purpose Input/Output                  |
| HAL     | Hardware Abstraction Layer                    |
| I2C/IIC | Inter-Integrated Circuit                      |
| IRQ     | Interrupt Request                             |
| ISA     | Instruction Set Architecture                  |
| ISR     | Interrupt Service Routine                     |
| JTAG    | Joint Test Action Group                       |
| LMB     | Local Memory Bus                              |
| LMA     | Load Memory Address                           |
| LTO     | Link-Time Optimization                        |
| MAC     | Media Access Controller                       |
| MDM     | MicroBlaze Debug Module                       |
| MIE     | Machine Interrupt Enable                      |
| MMIO    | Memory-Mapped Input/Output                    |
| MMU     | Memory Management Unit                        |
| MPU     | Memory Protection Unit                        |
| PAC     | Peripheral Access Crate                       |
| PMP     | Physical Memory Protection                    |
| RAII    | Resource Acquisition Is Initialization        |
| RTOS    | Real-Time Operating System                    |
| SPI     | Serial Peripheral Interface                   |
| SRS     | Software Requirements Specification           |
| TCB     | Task Control Block                            |
| UART    | Universal Asynchronous Receiver/Transmitter   |
| VMA     | Virtual Memory Address                        |
| WDT     | Watchdog Timer                                |
| XIP     | Execute In Place                              |

### 3.3 Abbreviations

| Abbreviation | Meaning                    |
|--------------|----------------------------|
| ilp32        | Integer Long Pointer 32-bit|
| KB           | Kilobyte (1024 bytes)      |
| MHz          | Megahertz                  |
| ms           | Millisecond                |
| µs           | Microsecond                |
| ns           | Nanosecond                 |

---

## 4. References

### 4.1 Standards and Specifications

| Reference ID | Document                                                              | Version/Date |
|--------------|-----------------------------------------------------------------------|--------------|
| REF-001      | RISC-V Unprivileged ISA Specification                                 | 20240411     |
| REF-002      | RISC-V Privileged Architecture Specification                          | 20240411     |
| REF-003      | RISC-V psABI Specification (Calling Convention)                       | 1.0          |
| REF-004      | The Embedded Rust Book                                                | Latest       |
| REF-005      | embedded-hal Specification                                            | 1.0.0        |
| REF-006      | IEEE 1003.1 POSIX (for API guidance, not compliance target)           | 2017         |

### 4.2 Vendor Documentation

| Reference ID | Document                                                              | Source       |
|--------------|-----------------------------------------------------------------------|--------------|
| REF-010      | UG1629 - MicroBlaze V Processor Reference Guide                       | AMD/Xilinx   |
| REF-011      | UG1711 - MicroBlaze V Embedded Design User Guide                      | AMD/Xilinx   |
| REF-012      | PG099 - AXI Interrupt Controller Product Guide                        | AMD/Xilinx   |
| REF-013      | PG142 - AXI UART Lite Product Guide                                   | AMD/Xilinx   |
| REF-014      | PG144 - AXI GPIO Product Guide                                        | AMD/Xilinx   |
| REF-015      | PG153 - AXI Quad SPI Product Guide                                    | AMD/Xilinx   |
| REF-016      | PG090 - AXI Ethernet Lite MAC Product Guide                           | AMD/Xilinx   |
| REF-017      | PG046 - AXI IIC Bus Interface Product Guide                           | AMD/Xilinx   |
| REF-018      | PG101 - AXI Timebase Watchdog Timer Product Guide                     | AMD/Xilinx   |
| REF-019      | Digilent Arty A7 Reference Manual                                     | Digilent     |

### 4.3 Project Documentation

| Reference ID | Document                                      | Location                   |
|--------------|-----------------------------------------------|----------------------------|
| REF-020      | Hardware Design Documentation                 | [hardware/README.md]       |
| REF-021      | Board Support Package Documentation           | [bsp/README.md]            |
| REF-022      | Design Review Document                        | [review/REVIEW.md]         |

---

## 5. Target Platform Requirements

### 5.1 Hardware Platform

| Requirement ID | Description                                                                                                    | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------------------|----------|--------------|
| HW-001         | Target board: Digilent Arty A7-35 (Xilinx Artix-7 XC7A35TICSG324-1L FPGA)                                      | Must     | I            |
| HW-002         | Processor: Xilinx MicroBlaze V (RISC-V) soft-core                                                              | Must     | I            |
| HW-003         | System clock: 75 MHz (generated by Clocking Wizard from 100 MHz board clock)                                   | Must     | T            |
| HW-004         | Memory: 128 KB local BRAM mapped at 0x0000_0000–0x0001_FFFF (accessed via separate instruction/data LMB paths) | Must     | T            |
| HW-005         | FPGA resources available: 5,200 logic slices, 1,800 Kbits BRAM, 90 DSP slices                                  | Info     | I            |
| HW-006         | External resources: 256 MB DDR3 @ 333 MHz (667 MT/s), 16 MB Quad-SPI Flash                                     | Info     | I            |

**Rationale**: The Digilent Arty A7-35 provides a cost-effective FPGA development platform with sufficient resources for the MicroBlaze V soft-core processor and associated peripherals.

### 5.2 Instruction Set Architecture (ISA)

| Requirement ID | Description                                                                                                                                                                                                          | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| ISA-001        | Base ISA: RISC-V 32-bit (`rv32imacb_zicsr_zifencei_zbc`)                                                                                                                                                             | Must     | A            |
| ISA-002        | RV32I: Base integer instruction set                                                                                                                                                                                  | Must     | T            |
| ISA-003        | M extension: Integer multiplication/division (optimized barrel shifter implementation)                                                                                                                               | Must     | T            |
| ISA-004        | A extension: Atomic instructions (LR/SC, AMOs)                                                                                                                                                                       | Must     | T            |
| ISA-005        | C extension: Compressed 16-bit instructions                                                                                                                                                                          | Must     | T            |
| ISA-006        | B extension: Bit manipulation (Zba + Zbb + Zbc + Zbs)                                                                                                                                                                | Must     | T            |
| ISA-007        | Zicsr extension: CSR read/write/modify instructions                                                                                                                                                                  | Must     | T            |
| ISA-008        | Zifencei extension: Instruction-fetch fence (`fence.i`)                                                                                                                                                              | Must     | T            |
| ISA-009        | Zbc extension: Carry-less polynomial bit-manipulation (crypto/CRC)                                                                                                                                                   | Must     | T            |
| ISA-010        | ABI: `ilp32` (32-bit int/long/pointer)                                                                                                                                                                               | Must     | A            |
| ISA-011        | Compiler flags: `-march=rv32imacb_zicsr_zifencei_zbc -mabi=ilp32`                                                                                                                                                    | Must     | I            |
| ISA-012        | Linker flags shall be compatible with the selected toolchain and the target ISA; default to `-march=rv32imacb_zicsr_zifencei_zbc -mabi=ilp32` unless the vendor BSP requires a toolchain-specific `-march` variant   | Must     | I            |
| ISA-013        | If using the Vitis/GCC BSP toolchain, linking with `-march=rv32imacb_zicsr_zifencei_zbcf` shall be treated as an allowed vendor toolchain quirk provided the produced code executes correctly on the target          | Should   | T            |

**Rationale**: The selected ISA extensions provide optimal performance for RTOS operations, particularly the A extension for lock-free synchronization and the C extension for code density.

### 5.3 Processor Configuration

| Requirement ID | Description                                                                                                  | Priority | Verification |
|----------------|--------------------------------------------------------------------------------------------------------------|----------|--------------|
| PROC-001       | 32-bit implementation, performance-optimized                                                                 | Must     | I            |
| PROC-002       | Hardware capability: Supervisor with SV32 virtual memory support                                             | Info     | I            |
| PROC-003       | Base counters and timers: Enabled                                                                            | Must     | T            |
| PROC-004       | Branch target cache: Disabled (optimized for small code footprints)                                          | Info     | I            |
| PROC-005       | Local Memory Bus (LMB) instruction interface: Enabled                                                        | Must     | T            |
| PROC-006       | Local Memory Bus (LMB) data interface: Enabled                                                               | Must     | T            |
| PROC-007       | Peripheral AXI data interface: Enabled                                                                       | Must     | T            |
| PROC-008       | Instruction cache: Disabled (direct BRAM access)                                                             | Info     | I            |
| PROC-009       | Data cache: Disabled (direct BRAM access)                                                                    | Info     | I            |
| PROC-010       | Architecture ID: 0x0000000000000001                                                                          | Info     | T            |
| PROC-011       | Implementation ID: 0x0000000000000001                                                                        | Info     | T            |
| PROC-012       | Hardware Thread ID: 0x0000000000000000                                                                       | Info     | T            |
| PROC-013       | RustOS shall execute in machine mode (M-mode) and use M-mode CSRs/traps (mtvec/mstatus/mie/mip/mepc/mcause)  | Must     | T            |

**Rationale**: Machine mode operation simplifies the RTOS design while providing full hardware control. Cache-less operation ensures deterministic memory access timing.

### 5.4 Exception Handling (Hardware)

| Requirement ID | Description                                      | Priority | Verification |
|----------------|--------------------------------------------------|----------|--------------|
| EXC-001        | Data-side AXI bus exception: Enabled             | Must     | T            |
| EXC-002        | Illegal instruction exception: Complete handling | Must     | T            |
| EXC-003        | Misaligned access exception: Enabled             | Must     | T            |
| EXC-004        | Instruction bus exception support                | Should   | T            |

**Rationale**: Complete exception handling is essential for system reliability and debugging.

### 5.5 Peripherals

| Requirement ID | Description                                                                                                               | Priority | Verification |
|----------------|---------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| PER-001        | AXI UART Lite at address 0x4060_0000                                                                                      | Must     | T            |
| PER-002        | UART configuration: 115200 baud, 8-N-1, no parity                                                                         | Must     | T            |
| PER-003        | AXI Interrupt Controller at address 0x4120_0000 (11 interrupt sources)                                                    | Must     | T            |
| PER-004        | Fixed Interval Timer for system tick (1 ms, 75000 clocks at 75 MHz)                                                       | Must     | T            |
| PER-005        | AXI GPIO LED 4-bits at address 0x4004_0000                                                                                | Must     | T            |
| PER-006        | AXI GPIO RGB LEDs at address 0x4005_0000                                                                                  | Should   | T            |
| PER-007        | AXI GPIO Push Buttons at address 0x4002_0000 (interrupt enabled)                                                          | Should   | T            |
| PER-008        | AXI GPIO DIP Switches at address 0x4003_0000 (interrupt enabled)                                                          | Should   | T            |
| PER-009        | AXI GPIO Shield Pins 0-19 at address 0x4000_0000 (interrupt enabled)                                                      | Should   | T            |
| PER-010        | AXI GPIO Shield Pins 26-41 at address 0x4001_0000 (interrupt enabled)                                                     | Should   | T            |
| PER-011        | AXI GPIO I2C Pullups at address 0x4006_0000                                                                               | Should   | T            |
| PER-012        | AXI IIC (I2C) at address 0x4080_0000 (SCL/SDA inertial delay: 4 AXI clocks)                                               | Should   | T            |
| PER-013        | AXI Ethernet Lite at address 0x40E0_0000 (10/100 Mbps)                                                                    | Should   | T            |
| PER-014        | AXI Timebase Watchdog Timer at address 0x41A0_0000 (Window WDT enabled)                                                   | Should   | T            |
| PER-015        | AXI Quad SPI Flash at address 0x44A0_0000 (Quad mode, Spansion, FIFO depth 256)                                           | Should   | T            |
| PER-016        | AXI Quad SPI Flash configuration: XIP mode disabled; performance mode enabled                                             | Should   | I            |
| PER-017        | AXI Quad SPI (External) at address 0x44A1_0000 (Quad mode, 32-bit transfers, SPI clock = AXI/16 ≈ 4.69 MHz at 75 MHz AXI) | Should   | T            |
| PER-018        | AXI Timebase Watchdog Timer: second sequence timer width = 8; window WDT enabled                                          | Should   | I            |
| PER-019        | Fixed Interval Timer (1 ms) shall be connected to AXI INTC interrupt input bus[0]                                         | Must     | I            |

**Rationale**: Peripheral selection provides essential I/O capabilities for embedded applications while maintaining a manageable driver development scope.

### 5.6 Memory Map

| Address Range                 | Size   | Description                              | Access    |
|-------------------------------|--------|------------------------------------------|-----------|
| 0x0000_0000 - 0x0001_FFFF     | 128 KB | Local BRAM (Instruction & Data via LMB)  | R/W/X     |
| 0x4000_0000 - 0x4000_FFFF     | 64 KB  | GPIO Shield Pins 0-19                    | R/W       |
| 0x4001_0000 - 0x4001_FFFF     | 64 KB  | GPIO Shield Pins 26-41                   | R/W       |
| 0x4002_0000 - 0x4002_FFFF     | 64 KB  | GPIO Push Buttons                        | R         |
| 0x4003_0000 - 0x4003_FFFF     | 64 KB  | GPIO DIP Switches                        | R         |
| 0x4004_0000 - 0x4004_FFFF     | 64 KB  | GPIO LED 4-bits                          | R/W       |
| 0x4005_0000 - 0x4005_FFFF     | 64 KB  | GPIO RGB LEDs                            | R/W       |
| 0x4006_0000 - 0x4006_FFFF     | 64 KB  | GPIO I2C Pullups                         | R/W       |
| 0x4060_0000 - 0x4060_FFFF     | 64 KB  | AXI UART Lite                            | R/W       |
| 0x4080_0000 - 0x4080_FFFF     | 64 KB  | AXI IIC (I2C)                            | R/W       |
| 0x40E0_0000 - 0x40E0_FFFF     | 64 KB  | AXI Ethernet Lite                        | R/W       |
| 0x4120_0000 - 0x4120_FFFF     | 64 KB  | AXI Interrupt Controller                 | R/W       |
| 0x41A0_0000 - 0x41A0_FFFF     | 64 KB  | AXI Timebase Watchdog Timer              | R/W       |
| 0x44A0_0000 - 0x44A0_FFFF     | 64 KB  | AXI Quad SPI Flash                       | R/W       |
| 0x44A1_0000 - 0x44A1_FFFF     | 64 KB  | AXI Quad SPI (External)                  | R/W       |

### 5.7 Interrupt Sources

| IRQ | Source               | Description                        | Priority | Edge/Level |
|-----|----------------------|------------------------------------|----------|------------|
| 0   | Fixed Interval Timer | 1 ms system tick for scheduler     | Highest  | Edge       |
| 1   | Watchdog Timer       | Timebase watchdog timer            | High     | Edge       |
| 2   | UART Lite            | Serial communication               | Medium   | Level      |
| 3   | Quad SPI Flash       | On-board flash memory              | Medium   | Level      |
| 4   | GPIO Shield 0-19     | Shield pins interrupt              | Low      | Edge       |
| 5   | GPIO Shield 26-41    | Shield pins interrupt              | Low      | Edge       |
| 6   | GPIO Push Buttons    | Button press events                | Low      | Edge       |
| 7   | GPIO DIP Switches    | Switch change events               | Low      | Edge       |
| 8   | Ethernet Lite        | Network communication              | Medium   | Level      |
| 9   | Quad SPI External    | External SPI devices               | Medium   | Level      |
| 10  | IIC (I2C)            | I2C bus events                     | Medium   | Level      |

### 5.8 Debug Infrastructure

| Requirement ID | Description                                           | Priority | Verification |
|----------------|-------------------------------------------------------|----------|--------------|
| DBG-001        | MicroBlaze Debug Module V (MDM V) with JTAG interface | Should   | D            |
| DBG-002        | Debug Module Interface: Serial                        | Should   | D            |
| DBG-003        | 8 PC breakpoints                                      | Should   | D            |
| DBG-004        | 4 read address watchpoints                            | Should   | D            |
| DBG-005        | 4 write address watchpoints                           | Should   | D            |
| DBG-006        | External trace interface (16-bit width)               | Should   | D            |
| DBG-007        | 13 performance event counters                         | Should   | T            |
| DBG-008        | 8 latency counters                                    | Should   | T            |
| DBG-009        | Profile buffer: None (external trace used)            | Info     | I            |

**Rationale**: Debug infrastructure enables efficient development, testing, and field diagnosis.

---

## 6. Kernel Requirements

### 6.1 Startup and Initialization

| Requirement ID | Description                                                                                                                                               | Priority | Verification |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| INIT-001       | Entry point: `_start` symbol at reset vector                                                                                                              | Must     | T            |
| INIT-002       | Initialize `.bss` section to zero                                                                                                                         | Must     | T            |
| INIT-003       | Initialize `.data` according to the selected boot mode (BRAM/JTAG: no copy required; ROM/Flash: copy from LMA to VMA)                                     | Must     | T            |
| INIT-004       | Initialize stack pointer (sp/x2) to top of stack region                                                                                                   | Must     | T            |
| INIT-005       | Initialize global pointer (gp/x3) for linker relaxation                                                                                                   | Must     | T            |
| INIT-006       | Setup machine trap vector (mtvec) before enabling interrupts                                                                                              | Must     | T            |
| INIT-007       | Clear all pending interrupts before enabling                                                                                                              | Must     | T            |
| INIT-008       | Boot mode shall be explicitly defined at build time (e.g., `bram_jtag` vs `qspi_flash`) and documented in the build output                                | Must     | I            |
| INIT-009       | For `bram_jtag` boot, the binary shall be linked such that `.text/.rodata/.data` VMA is in BRAM and startup shall not assume a separate ROM image         | Must     | T            |
| INIT-010       | For `qspi_flash` boot (future), the linker script shall define a ROM/flash LMA for `.data`, and startup shall copy from `_sidata` to `_sdata.._edata`     | Should   | T            |
| INIT-011       | Startup shall include an optional self-check build mode that validates `.data` init and `.bss` zeroing (panic/print on mismatch)                          | Could    | T            |
| INIT-012       | Startup sequence shall complete within 10 ms from reset to first user task execution                                                                      | Should   | T            |
| INIT-013       | Startup shall initialize all kernel data structures before enabling interrupts                                                                            | Must     | A            |

**Rationale**: Proper initialization sequence ensures deterministic system behavior and prevents undefined states at runtime.

### 6.2 Scheduler

| Requirement ID | Description                                                                    | Priority | Verification |
|----------------|--------------------------------------------------------------------------------|----------|--------------|
| SCHED-001      | Implement preemptive multitasking                                              | Must     | T            |
| SCHED-002      | Priority-based scheduling with 256 levels (0 = highest, 255 = lowest)          | Must     | T            |
| SCHED-003      | Select highest-priority ready task on each scheduling decision                 | Must     | T            |
| SCHED-004      | Preemption on timer tick (configurable, default 1 ms via Fixed Interval Timer) | Must     | T            |
| SCHED-005      | Support maximum of 16 concurrent tasks                                         | Must     | T            |
| SCHED-006      | Idle task runs when no other tasks are ready                                   | Must     | T            |
| SCHED-007      | Scheduler enable/disable control                                               | Must     | T            |
| SCHED-008      | Thread-safe scheduler access via critical sections                             | Must     | A            |
| SCHED-009      | Round-robin scheduling for equal-priority tasks                                | Should   | T            |
| SCHED-010      | Task yield() API for voluntary preemption                                      | Should   | T            |
| SCHED-011      | Scheduler shall make scheduling decision within O(1) time complexity           | Must     | A            |
| SCHED-012      | Scheduler shall support deferred context switch from ISR context               | Must     | T            |

**Rationale**: A deterministic O(1) scheduler ensures predictable real-time behavior regardless of the number of tasks.

### 6.3 Task Management

| Requirement ID | Description                                                            | Priority | Verification |
|----------------|------------------------------------------------------------------------|----------|--------------|
| TASK-001       | Task Control Block (TCB) with ID, name, priority, state, stack pointer | Must     | I            |
| TASK-002       | Task states: Ready, Running, Blocked, Suspended, Terminated            | Must     | T            |
| TASK-003       | Static task creation at compile time                                   | Must     | T            |
| TASK-004       | Configurable per-task stack sizes                                      | Must     | I            |
| TASK-005       | Stack overflow detection capability (canary value)                     | Should   | T            |
| TASK-006       | Stack usage monitoring (high watermark)                                | Should   | T            |
| TASK-007       | Task blocking and unblocking mechanisms                                | Must     | T            |
| TASK-008       | Task entry point as `fn() -> !` (never returns)                        | Must     | A            |
| TASK-009       | Task delay/sleep functionality (tick-based)                            | Should   | T            |
| TASK-010       | Task suspend/resume API                                                | Should   | T            |
| TASK-011       | Task runtime statistics (CPU usage, execution count)                   | Could    | T            |
| TASK-012       | Task shall not be able to modify another task's TCB directly           | Must     | A            |

**Rationale**: Static task creation eliminates runtime allocation failures and ensures deterministic memory usage.

### 6.4 Context Switching

<!-- markdownlint-disable MD060 -->

| Requirement ID | Description                                                                                                                                                                                                                  | Priority | Verification |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| CTX-001        | Software context switch via timer interrupt                                                                                                                                                                                  | Must     | T            |
| CTX-002        | Save/restore general-purpose registers excluding x2 (sp): save x1 and x3-x31 in the context frame; x2 is represented by the frame SP itself                                                                                  | Must     | T            |
| CTX-003        | Save/restore program counter (via mepc CSR)                                                                                                                                                                                  | Must     | T            |
| CTX-004        | Save/restore machine status register (mstatus CSR)                                                                                                                                                                           | Must     | T            |
| CTX-005        | Save/restore machine cause register (mcause) during nested handling                                                                                                                                                          | Should   | T            |
| CTX-006        | Context switch latency: ≤ 5 µs at 75 MHz (≤ 375 cycles)                                                                                                                                                                      | Must     | T            |
| CTX-007        | 16-byte stack alignment per RISC-V ABI (context frame size padded to preserve alignment)                                                                                                                                     | Must     | A            |
| CTX-008        | Initial stack frame setup for first context switch                                                                                                                                                                           | Must     | T            |
| CTX-009        | Context switch shall be atomic (no partial context visible to other execution contexts)                                                                                                                                      | Must     | A            |

<!-- markdownlint-enable MD060 -->

**Rationale**: Fast, deterministic context switching is essential for real-time performance guarantees.

### 6.5 Critical Sections

| Requirement ID | Description                                                      | Priority | Verification |
|----------------|------------------------------------------------------------------|----------|--------------|
| CRIT-001       | Implement critical section via mstatus.MIE bit manipulation      | Must     | T            |
| CRIT-002       | Use RISC-V csrrc/csrrs for atomic interrupt disable/enable       | Must     | A            |
| CRIT-003       | Nested critical section support (save/restore previous MIE state)| Must     | T            |
| CRIT-004       | Implement `critical-section` crate acquire/release callbacks     | Must     | T            |
| CRIT-005       | Critical section duration shall not exceed 100 µs under normal operation | Should   | A            |
| CRIT-006       | Critical section entry/exit overhead shall be ≤ 20 cycles        | Should   | T            |

**Rationale**: Efficient critical sections minimize interrupt latency while ensuring data integrity.

### 6.6 Time Management

| Requirement ID | Description                                             | Priority | Verification |
|----------------|---------------------------------------------------------|----------|--------------|
| TIME-001       | System tick rate: 1000 Hz (1 ms period)                 | Must     | T            |
| TIME-002       | 32-bit tick counter (wraps after ~49.7 days)            | Must     | T            |
| TIME-003       | 64-bit uptime counter for extended precision            | Should   | T            |
| TIME-004       | Tick-to-milliseconds conversion utilities               | Must     | T            |
| TIME-005       | Software timer support (one-shot and periodic)          | Should   | T            |
| TIME-006       | Timer callback mechanism                                | Should   | T            |
| TIME-007       | Tick jitter shall be ≤ 1% under normal load             | Should   | T            |
| TIME-008       | Monotonic time guarantee (time never goes backward)     | Must     | A            |

**Rationale**: Accurate timekeeping is fundamental to real-time scheduling and application timing requirements.

### 6.7 Kernel API and Behavioral Semantics

The kernel requirements above are not implementable without explicit behavioral rules. This section defines API-level semantics and ISR restrictions.

#### 6.7.1 API Surface

| Requirement ID | Description                                                                                                                | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| API-001        | The kernel shall define a public API surface for tasks, time, and synchronization (documented and stable within a release) | Must     | I            |
| API-002        | All fallible kernel APIs shall return `Result<T, Error>` (no panics in normal error cases)                                 | Must     | A            |
| API-003        | Kernel APIs callable from interrupt context shall be explicitly separated (e.g., `*_from_isr`)                             | Must     | I            |
| API-004        | The kernel shall define maximums as compile-time constants (e.g., `MAX_TASKS`, `MAX_PRIORITIES`)                           | Must     | I            |
| API-005        | API breaking changes shall follow semantic versioning                                                                      | Should   | I            |
| API-006        | All public APIs shall have documentation with examples                                                                     | Should   | I            |

#### 6.7.2 Scheduling Rules

| Requirement ID | Description                                                                                                                           | Priority | Verification |
|----------------|---------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| API-007        | Priority ordering shall be total and consistent: lower numeric value represents higher priority (0 highest)                           | Must     | T            |
| API-008        | Ready selection shall be deterministic: pick the highest-priority ready task; ties are handled per SCHED-009 if enabled               | Must     | T            |
| API-009        | The idle task shall never block and shall not starve higher priorities                                                                | Must     | A            |
| API-010        | `yield()` shall move the current task to the end of its ready queue (only within same priority)                                       | Should   | T            |
| API-011        | `sleep(ticks)`/`delay_until()` shall wake tasks on or after the requested tick; rounding rules shall be specified (default: round up) | Should   | T            |
| API-012        | A task unblocked by an ISR shall be scheduled before the ISR returns (deferred context switch)                                        | Must     | T            |

#### 6.7.3 Interrupt Context Rules

| Requirement ID | Description                                                                                                                                                                | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| ISR-001        | ISRs shall not call blocking APIs (e.g., mutex lock, queue receive with timeout)                                                                                           | Must     | A            |
| ISR-002        | ISRs may only use `*_from_isr` APIs that are guaranteed non-blocking and bounded in time                                                                                   | Must     | A            |
| ISR-003        | ISRs shall not perform dynamic initialization or logging that can deadlock (e.g., acquiring a normal mutex)                                                                | Must     | A            |
| ISR-004        | If an ISR unblocks a higher-priority task, the system shall request a reschedule at ISR exit (deferred context switch allowed)                                             | Must     | T            |
| ISR-005        | Nested interrupts: if the platform does not support interrupt priority/nesting, the kernel shall treat interrupt handling as non-preemptible except for explicit re-enable | Should   | A            |
| ISR-006        | ISR execution time shall be bounded and documented per interrupt source                                                                                                    | Should   | A            |
| ISR-007        | ISR shall acknowledge the interrupt source before returning                                                                                                                | Must     | T            |

#### 6.7.4 Error Model

| Requirement ID | Description                                                                                                                                    | Priority | Verification |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| ERR-001        | The kernel shall define a unified `Error` enum including at least: `Timeout`, `WouldBlock`, `InvalidId`, `NotOwner`, `QueueFull`, `QueueEmpty` | Must     | I            |
| ERR-002        | Timeout semantics shall be consistent across primitives (0 ticks means poll/non-blocking; `None` means wait forever if supported)              | Should   | T            |
| ERR-003        | Error codes shall be documented with recovery guidance                                                                                         | Should   | I            |
| ERR-004        | Fatal errors shall trigger a panic with diagnostic information                                                                                 | Must     | T            |

---

## 7. Synchronization Requirements

### 7.1 Mutex

| Requirement ID | Description                                                    | Priority | Verification |
|----------------|----------------------------------------------------------------|----------|--------------|
| MTX-001        | Binary mutex with ownership tracking                           | Must     | T            |
| MTX-002        | Blocking lock operation                                        | Must     | T            |
| MTX-003        | Non-blocking try_lock operation                                | Must     | T            |
| MTX-004        | RAII-style MutexGuard for automatic unlock                     | Must     | T            |
| MTX-005        | Atomic Compare-And-Swap (CAS) implementation using A extension | Must     | A            |
| MTX-006        | Thread-safe via critical sections                              | Must     | A            |
| MTX-007        | Deadlock detection (optional warning via debug output)         | Should   | T            |
| MTX-008        | Recursive mutex support (optional)                             | Could    | T            |
| MTX-009        | Mutex lock acquisition time shall be bounded (O(n) worst case) | Must     | A            |
| MTX-010        | Mutex shall track owner task ID for debugging                  | Should   | T            |

**Rationale**: RAII-style guards prevent resource leaks and ensure proper unlock even in error paths.

### 7.2 Semaphore

| Requirement ID | Description                                                       | Priority | Verification |
|----------------|-------------------------------------------------------------------|----------|--------------|
| SEM-001        | Counting semaphore with configurable initial and max count        | Must     | T            |
| SEM-002        | wait() (P) operation: decrement, block if zero                    | Must     | T            |
| SEM-003        | signal() (V) operation: increment, wake waiters                   | Must     | T            |
| SEM-004        | Non-blocking try_wait() operation                                 | Must     | T            |
| SEM-005        | Waiting queue for blocked tasks                                   | Must     | T            |
| SEM-006        | Atomic counter operations using A extension                       | Must     | A            |
| SEM-007        | Binary semaphore variant (max count = 1)                          | Should   | T            |
| SEM-008        | Timeout-based wait operation                                      | Could    | T            |
| SEM-009        | Semaphore signal shall be callable from ISR context               | Must     | T            |
| SEM-010        | Waiting tasks shall be woken in priority order                    | Should   | T            |

**Rationale**: Priority-ordered wake prevents priority inversion scenarios in semaphore usage.

### 7.3 Message Queue

| Requirement ID | Description                                             | Priority | Verification |
|----------------|---------------------------------------------------------|----------|--------------|
| MQ-001         | FIFO bounded queue for inter-task communication         | Must     | T            |
| MQ-002         | Configurable queue capacity (generic const parameter)   | Must     | T            |
| MQ-003         | Blocking send when queue is full                        | Must     | T            |
| MQ-004         | Blocking receive when queue is empty                    | Must     | T            |
| MQ-005         | Non-blocking try_send() operation                       | Must     | T            |
| MQ-006         | Non-blocking try_receive() operation                    | Must     | T            |
| MQ-007         | Ring buffer implementation (heapless::Deque)            | Must     | I            |
| MQ-008         | Support for different message types via generics        | Should   | T            |
| MQ-009         | Priority queue variant                                  | Could    | T            |
| MQ-010         | Queue send shall be callable from ISR context (try_send)| Must     | T            |
| MQ-011         | Queue depth shall be queryable at runtime               | Should   | T            |

**Rationale**: Inter-task communication via message queues reduces shared state and coupling.

### 7.4 Event Flags

| Requirement ID | Description                      | Priority | Verification |
|----------------|----------------------------------|----------|--------------|
| EVT-001        | 32-bit event flag group          | Should   | T            |
| EVT-002        | Wait for any/all flags           | Should   | T            |
| EVT-003        | Set/clear flags atomically       | Should   | T            |
| EVT-004        | Timeout-based wait               | Could    | T            |
| EVT-005        | Event set callable from ISR      | Should   | T            |
| EVT-006        | Auto-clear option on wait        | Could    | T            |

**Rationale**: Event flags provide efficient multi-condition synchronization with minimal overhead.

---

## 8. Memory Management Requirements

### 8.1 General Memory

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| MEM-001        | Static memory allocation only (no heap)                            | Must     | A            |
| MEM-002        | All memory allocated at compile time                               | Must     | A            |
| MEM-003        | Total memory footprint: ≤ 64 KB (fits in 128 KB BRAM with headroom)| Must     | T            |
| MEM-004        | No dynamic memory management libraries (no alloc crate)            | Must     | I            |
| MEM-005        | Memory-safe abstractions for hardware access                       | Must     | A            |
| MEM-006        | Memory usage shall be deterministic and predictable                | Must     | A            |
| MEM-007        | No memory fragmentation possible (static allocation only)          | Must     | A            |

**Rationale**: Static allocation eliminates runtime allocation failures and memory fragmentation issues.

### 8.2 Memory Layout (Linker Script)

| Requirement ID | Description                                                                                                                     | Priority | Verification |
|----------------|---------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| MEM-008        | MEMORY region: BRAM at 0x0000_0000, length 128K                                                                                 | Must     | I            |
| MEM-009        | .text section at start of BRAM                                                                                                  | Must     | I            |
| MEM-010        | .rodata section after .text (read-only data, constants)                                                                         | Must     | I            |
| MEM-011        | .data section for initialized data; its load image (LMA) may be in BRAM (BRAM/JTAG boot) or in ROM/flash (flash boot)           | Must     | I            |
| MEM-012        | .bss section for zero-initialized data                                                                                          | Must     | I            |
| MEM-013        | .stack section at end of BRAM (grows downward)                                                                                  | Must     | I            |
| MEM-014        | Define `_stack_start` and `_stack_end` symbols                                                                                  | Must     | I            |
| MEM-015        | Define `_sbss`, `_ebss` symbols for BSS initialization                                                                          | Must     | I            |
| MEM-016        | Define `_sdata`, `_edata`; define `_sidata` when a separate `.data` load image exists (flash/ROM boot)                          | Must     | I            |
| MEM-017        | ENTRY(_start) directive                                                                                                         | Must     | I            |
| MEM-018        | Alignment requirements: .text (4), .data (8), .stack (16)                                                                       | Must     | I            |
| MEM-019        | Guard region between stack and data sections (optional, for overflow detection)                                                 | Should   | I            |

### 8.3 Memory Budget

| Section        | Estimated Size | Maximum Size | Description                           |
|----------------|----------------|--------------|---------------------------------------|
| .text          | ~15 KB         | 24 KB        | Code (kernel + HAL + app)             |
| .rodata        | ~2 KB          | 4 KB         | Constants, strings, lookup tables     |
| .data          | ~1 KB          | 2 KB         | Initialized global variables          |
| .bss           | ~4 KB          | 8 KB         | Zero-initialized globals, static pools|
| Task stacks    | ~32 KB         | 32 KB        | 16 tasks × 2 KB each                  |
| Main/ISR stack | ~4 KB          | 4 KB         | Startup and interrupt handling        |
| **Total**      | **~58 KB**     | **74 KB**    | Within 128 KB BRAM budget             |
| **Headroom**   | **~70 KB**     | **54 KB**    | Available for application expansion   |

### 8.4 Allocators

| Requirement ID | Description                                                  | Priority | Verification |
|----------------|--------------------------------------------------------------|----------|--------------|
| ALLOC-001      | StaticPool: Generic object pool with free list bitmap        | Must     | T            |
| ALLOC-002      | StaticPool: Constant-time O(1) allocation/deallocation       | Should   | A            |
| ALLOC-003      | StackAllocator: Fixed-size stack slot allocation             | Must     | T            |
| ALLOC-004      | StackAllocator: Default 2 KB per task stack                  | Must     | I            |
| ALLOC-005      | StackAllocator: Support 16 task stacks                       | Must     | T            |
| ALLOC-006      | No memory fragmentation (static allocation only)             | Must     | A            |
| ALLOC-007      | Critical section protection for pool allocations             | Must     | A            |
| ALLOC-008      | Pool exhaustion shall return error, not panic                | Must     | T            |

**Rationale**: O(1) allocators ensure deterministic timing for all memory operations.

---

## 9. Hardware Abstraction Layer (HAL) Requirements

### 9.1 UART Driver

| Requirement ID | Description                                              | Priority | Verification |
|----------------|----------------------------------------------------------|----------|--------------|
| UART-001       | Initialize UART with TX/RX FIFO reset                    | Must     | T            |
| UART-002       | Write string to UART (blocking)                          | Must     | T            |
| UART-003       | Write single byte                                        | Must     | T            |
| UART-004       | Read single byte (blocking)                              | Must     | T            |
| UART-005       | Check if RX data available (non-blocking poll)           | Must     | T            |
| UART-006       | Check if TX ready (non-blocking poll)                    | Must     | T            |
| UART-007       | Implement `core::fmt::Write` trait                       | Must     | T            |
| UART-008       | `print!()` and `println!()` macros                       | Must     | T            |
| UART-009       | Global UART instance with critical section protection    | Must     | A            |
| UART-010       | Interrupt-driven receive (optional)                      | Could    | T            |
| UART-011       | TX/RX timeout detection                                  | Should   | T            |
| UART-012       | Error detection (framing, overrun)                       | Should   | T            |

**Rationale**: UART is essential for debug output and provides the primary human interface during development.

### 9.2 Timer Driver

| Requirement ID | Description                                                             | Priority | Verification |
|----------------|-------------------------------------------------------------------------|----------|--------------|
| TMR-001        | Fixed Interval Timer configured for 1 ms ticks (75000 clocks at 75 MHz) | Must     | T            |
| TMR-002        | Atomic tick counter (AtomicU32)                                         | Must     | A            |
| TMR-003        | `get_ticks()`: Return current tick count                                | Must     | T            |
| TMR-004        | `tick()`: Increment counter (called from ISR)                           | Must     | T            |
| TMR-005        | `delay_ticks(n)`: Busy-wait delay                                       | Must     | T            |
| TMR-006        | `delay_ms(ms)`: Millisecond delay                                       | Must     | T            |
| TMR-007        | `elapsed_ms()`: Uptime in milliseconds                                  | Should   | T            |
| TMR-008        | Handle tick counter wraparound (u32, ~49 days at 1 ms)                  | Should   | T            |
| TMR-009        | Fixed Interval Timer has no memory-mapped registers (interrupt-only)    | Info     | I            |
| TMR-010        | Timer accuracy shall be ±0.1% of nominal tick period                    | Should   | T            |

**Rationale**: Accurate timing is fundamental to RTOS operation and application requirements.

### 9.3 Watchdog Timer Driver

| Requirement ID | Description                                               | Priority | Verification |
|----------------|-----------------------------------------------------------|----------|--------------|
| WDT-001        | AXI Timebase Watchdog Timer initialization                | Should   | T            |
| WDT-002        | Enable/disable watchdog                                   | Should   | T            |
| WDT-003        | Kick/refresh watchdog to prevent reset                    | Should   | T            |
| WDT-004        | Configure watchdog timeout period                         | Should   | T            |
| WDT-005        | Window watchdog mode support (enabled in hardware)        | Could    | T            |
| WDT-006        | Watchdog status query (time remaining)                    | Could    | T            |

**Rationale**: Watchdog provides system recovery capability for hung or crashed applications.

### 9.4 GPIO Driver

| Requirement ID | Description                                   | Priority | Verification |
|----------------|-----------------------------------------------|----------|--------------|
| GPIO-001       | Read GPIO port (32-bit data register)         | Should   | T            |
| GPIO-002       | Write GPIO port (32-bit data register)        | Should   | T            |
| GPIO-003       | Configure GPIO direction (tri-state register) | Should   | T            |
| GPIO-004       | Individual pin read/write operations          | Should   | T            |
| GPIO-005       | GPIO interrupt enable/disable                 | Should   | T            |
| GPIO-006       | GPIO interrupt status/acknowledge             | Should   | T            |
| GPIO-007       | LED driver abstraction (4-bit LEDs)           | Should   | T            |
| GPIO-008       | RGB LED driver abstraction                    | Could    | T            |
| GPIO-009       | Button/switch debouncing support              | Could    | T            |
| GPIO-010       | GPIO edge detection configuration             | Should   | T            |

**Rationale**: GPIO provides essential I/O capability for embedded applications.

### 9.5 SPI Driver

| Requirement ID | Description                                   | Priority | Verification |
|----------------|-----------------------------------------------|----------|--------------|
| SPI-001        | AXI Quad SPI controller initialization        | Should   | T            |
| SPI-002        | SPI master mode operation                     | Should   | T            |
| SPI-003        | Single/Dual/Quad mode selection               | Should   | T            |
| SPI-004        | Chip select control                           | Should   | T            |
| SPI-005        | FIFO-based transfer (256-entry FIFO)          | Should   | T            |
| SPI-006        | Blocking read/write operations                | Should   | T            |
| SPI-007        | Flash memory read/write/erase commands        | Could    | T            |
| SPI-008        | SPI clock rate configuration                  | Should   | T            |
| SPI-009        | SPI mode selection (CPOL/CPHA)                | Should   | T            |

**Rationale**: SPI enables communication with flash memory and external peripherals.

### 9.6 I2C Driver

| Requirement ID | Description                         | Priority | Verification |
|----------------|-------------------------------------|----------|--------------|
| I2C-001        | AXI IIC controller initialization   | Should   | T            |
| I2C-002        | I2C master mode operation           | Should   | T            |
| I2C-003        | 7-bit addressing support            | Should   | T            |
| I2C-004        | Read/write byte operations          | Should   | T            |
| I2C-005        | Multi-byte transfer support         | Should   | T            |
| I2C-006        | I2C pull-up control via GPIO        | Should   | T            |
| I2C-007        | 10-bit addressing support           | Could    | T            |
| I2C-008        | I2C bus error recovery              | Should   | T            |

**Rationale**: I2C enables communication with sensors, EEPROMs, and other peripherals.

### 9.7 Ethernet Driver

| Requirement ID | Description                         | Priority | Verification |
|----------------|-------------------------------------|----------|--------------|
| ETH-001        | AXI Ethernet Lite initialization    | Could    | T            |
| ETH-002        | MAC address configuration           | Could    | T            |
| ETH-003        | Frame transmit/receive              | Could    | T            |
| ETH-004        | Link status detection               | Could    | T            |
| ETH-005        | Basic ICMP ping response            | Could    | T            |
| ETH-006        | Frame buffer management             | Could    | T            |

**Rationale**: Ethernet provides network connectivity for remote monitoring and control.

### 9.8 Interrupt Driver

| Requirement ID | Description                                                                | Priority | Verification |
|----------------|----------------------------------------------------------------------------|----------|--------------|
| INT-001        | AXI Interrupt Controller driver (11 interrupt sources)                     | Must     | T            |
| INT-002        | Enable/disable individual interrupts (IER register)                        | Must     | T            |
| INT-003        | Interrupt acknowledge mechanism (IAR register)                             | Must     | T            |
| INT-004        | Read interrupt status (ISR register)                                       | Must     | T            |
| INT-005        | Master enable/disable (MER register)                                       | Must     | T            |
| INT-006        | Interrupt vector table (callback per IRQ)                                  | Should   | T            |
| INT-007        | Interrupt priority (hardware: single level, software: configurable)        | Could    | T            |
| INT-008        | Interrupt latency measurement capability                                   | Should   | T            |
| INT-009        | Interrupt statistics (count per source)                                    | Could    | T            |

**Rationale**: Centralized interrupt management ensures consistent, reliable interrupt handling.

---

## 10. Board Support Package (BSP) Requirements

### 10.1 Boot and Initialization

| Requirement ID | Description                                          | Priority | Verification |
|----------------|------------------------------------------------------|----------|--------------|
| BOOT-001       | Reset vector entry point (`_start`)                  | Must     | T            |
| BOOT-002       | Hardware initialization sequence                     | Must     | T            |
| BOOT-003       | Clock subsystem initialization verification          | Must     | T            |
| BOOT-004       | UART initialization for debug output                 | Must     | T            |
| BOOT-005       | Print boot banner with version info                  | Should   | D            |
| BOOT-006       | Trap vector setup (mtvec CSR)                        | Must     | T            |
| BOOT-007       | Interrupt controller initialization                  | Must     | T            |
| BOOT-008       | Timer initialization and start                       | Must     | T            |
| BOOT-009       | Jump to Rust `main()` or kernel entry                | Must     | T            |
| BOOT-010       | Boot sequence shall be idempotent (safe to restart)  | Should   | T            |
| BOOT-011       | Boot failure shall output diagnostic information     | Should   | D            |

**Rationale**: Proper boot sequence ensures reliable system startup and provides diagnostic information.

### 10.2 Trap and Exception Handling

| Requirement ID | Description                                                                                        | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------|----------|--------------|
| TRAP-001       | Machine mode trap handler (`_trap_handler`)                                                        | Must     | T            |
| TRAP-002       | Direct interrupt mode via mtvec (MODE=0)                                                           | Must     | A            |
| TRAP-003       | Identify interrupt vs exception via mcause MSB                                                     | Must     | T            |
| TRAP-004       | Identify specific cause via mcause exception code                                                  | Must     | T            |
| TRAP-005       | Scheduler tick interrupt (Fixed Interval Timer via AXI INTC IRQ0) shall trigger the scheduler tick | Must     | T            |
| TRAP-006       | External interrupt handler dispatches to AXI INTC                                                  | Must     | T            |
| TRAP-007       | Interrupt acknowledge after peripheral handling                                                    | Must     | T            |
| TRAP-008       | Context save/restore around interrupt handling                                                     | Must     | T            |
| TRAP-009       | Return from trap via `mret` instruction                                                            | Must     | T            |
| TRAP-010       | Illegal instruction exception handler                                                              | Should   | T            |
| TRAP-011       | Load/store access fault handlers                                                                   | Should   | T            |
| TRAP-012       | Misaligned access exception handlers                                                               | Should   | T            |
| TRAP-013       | Bus error exception handlers                                                                       | Should   | T            |
| TRAP-014       | Environment call (ecall) handler                                                                   | Could    | T            |
| TRAP-015       | Breakpoint (ebreak) handler for debugging                                                          | Could    | T            |
| TRAP-016       | Exception handlers shall log diagnostic information                                                | Should   | D            |
| TRAP-017       | Fatal exceptions shall trigger controlled system halt                                              | Must     | T            |

**Rationale**: Comprehensive exception handling improves system reliability and debuggability.

### 10.3 CSR Definitions

| Requirement ID | Description                                                           | Priority | Verification |
|----------------|-----------------------------------------------------------------------|----------|--------------|
| CSR-001        | mstatus: Machine status (interrupt enable, privilege mode)            | Must     | T            |
| CSR-002        | mie: Machine interrupt enable (MEIE, MTIE, MSIE bits)                 | Must     | T            |
| CSR-003        | mip: Machine interrupt pending                                        | Must     | T            |
| CSR-004        | mtvec: Machine trap vector base address                               | Must     | T            |
| CSR-005        | mepc: Machine exception program counter                               | Must     | T            |
| CSR-006        | mcause: Machine cause (interrupt/exception code)                      | Must     | T            |
| CSR-007        | mtval: Machine trap value (faulting address/instruction)              | Should   | T            |
| CSR-008        | mscratch: Machine scratch register (for trap handling)                | Should   | T            |
| CSR-009        | mcycle/mcycleh: Cycle counter                                         | Should   | T            |
| CSR-010        | minstret/minstreth: Instruction retired counter                       | Should   | T            |
| CSR-011        | mvendorid, marchid, mimpid: Identification CSRs                       | Info     | T            |

---

## 11. Peripheral Access Crate (PAC) Requirements

### 11.1 Register Access Primitives

| Requirement ID | Description                                                                                                                                               | Priority | Verification |
|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| PAC-001        | Memory-mapped I/O access via volatile pointers                                                                                                            | Must     | A            |
| PAC-002        | Volatile reads via `core::ptr::read_volatile()`                                                                                                           | Must     | A            |
| PAC-003        | Volatile writes via `core::ptr::write_volatile()`                                                                                                         | Must     | A            |
| PAC-004        | Type-safe register access wrappers                                                                                                                        | Should   | A            |
| PAC-005        | Bitfield manipulation helpers                                                                                                                             | Should   | T            |
| PAC-006        | Every PAC register offset and bitfield definition shall be traceable to an authoritative source (IP product guide, or vendor driver headers)              | Must     | I            |
| PAC-007        | The project shall provide a short "PAC provenance" document listing the source for each peripheral register map used                                      | Should   | I            |
| PAC-008        | PAC register offsets/bitfields shall be validated at integration time by cross-checking against the vendor-provided driver headers used in the BSP        | Should   | T            |
| PAC-009        | PAC shall provide compile-time address validation where possible                                                                                          | Should   | A            |

### 11.2 AXI UART Lite Registers (0x4060_0000)

| Requirement ID | Description                                                                                                                                    | Priority | Verification |
|----------------|------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| PAC-010        | RX_FIFO (offset 0x00): Receive data FIFO                                                                                                       | Must     | T            |
| PAC-011        | TX_FIFO (offset 0x04): Transmit data FIFO                                                                                                      | Must     | T            |
| PAC-012        | STAT_REG (offset 0x08): Status register                                                                                                        | Must     | T            |
| PAC-013        | CTRL_REG (offset 0x0C): Control register                                                                                                       | Must     | T            |
| PAC-014        | Status bits (per UART Lite register map): RX_FIFO_VALID_DATA=0x01, RX_FIFO_FULL=0x02, TX_FIFO_EMPTY=0x04, TX_FIFO_FULL=0x08, INTR_ENABLED=0x10 | Must     | I            |
| PAC-015        | Control bits (per UART Lite register map): FIFO_TX_RESET=0x01, FIFO_RX_RESET=0x02, ENABLE_INTR=0x10                                            | Must     | I            |

### 11.3 AXI Interrupt Controller Registers (0x4120_0000)

| Requirement ID | Description                                                                                                          | Priority | Verification |
|----------------|----------------------------------------------------------------------------------------------------------------------|----------|--------------|
| PAC-020        | ISR (offset 0x00): Interrupt Status Register                                                                         | Must     | T            |
| PAC-021        | IPR (offset 0x04): Interrupt Pending Register                                                                        | Must     | T            |
| PAC-022        | IER (offset 0x08): Interrupt Enable Register                                                                         | Must     | T            |
| PAC-023        | IAR (offset 0x0C): Interrupt Acknowledge Register                                                                    | Must     | T            |
| PAC-024        | SIE (offset 0x10): Set Interrupt Enable                                                                              | Should   | T            |
| PAC-025        | CIE (offset 0x14): Clear Interrupt Enable                                                                            | Should   | T            |
| PAC-026        | MER (offset 0x1C): Master Enable Register; MasterEnable=0x01 and HardwareEnable=0x02 (both set to enable interrupts) | Must     | T            |

### 11.4 AXI GPIO Registers (Base varies)

| Requirement ID | Description                                           | Priority | Verification |
|----------------|-------------------------------------------------------|----------|--------------|
| PAC-030        | GPIO_DATA (offset 0x00): Channel 1 data register      | Should   | T            |
| PAC-031        | GPIO_TRI (offset 0x04): Channel 1 tri-state register  | Should   | T            |
| PAC-032        | GPIO2_DATA (offset 0x08): Channel 2 data register     | Should   | T            |
| PAC-033        | GPIO2_TRI (offset 0x0C): Channel 2 tri-state register | Should   | T            |
| PAC-034        | GIER (offset 0x11C): Global interrupt enable          | Should   | T            |
| PAC-035        | IER (offset 0x128): IP interrupt enable               | Should   | T            |
| PAC-036        | ISR (offset 0x120): IP interrupt status               | Should   | T            |

### 11.5 AXI Quad SPI Registers (0x44A0_0000, 0x44A1_0000)

| Requirement ID | Description                                     | Priority | Verification |
|----------------|-------------------------------------------------|----------|--------------|
| PAC-040        | SRR (offset 0x40): Software Reset Register      | Should   | T            |
| PAC-041        | SPICR (offset 0x60): SPI Control Register       | Should   | T            |
| PAC-042        | SPISR (offset 0x64): SPI Status Register        | Should   | T            |
| PAC-043        | SPI_DTR (offset 0x68): Data Transmit Register   | Should   | T            |
| PAC-044        | SPI_DRR (offset 0x6C): Data Receive Register    | Should   | T            |
| PAC-045        | SPISSR (offset 0x70): Slave Select Register     | Should   | T            |

### 11.6 AXI IIC Registers (0x4080_0000)

| Requirement ID | Description                                   | Priority | Verification |
|----------------|-----------------------------------------------|----------|--------------|
| PAC-050        | GIE (offset 0x01C): Global Interrupt Enable   | Should   | T            |
| PAC-051        | ISR (offset 0x020): Interrupt Status Register | Should   | T            |
| PAC-052        | IER (offset 0x028): Interrupt Enable Register | Should   | T            |
| PAC-053        | SOFTR (offset 0x040): Soft Reset Register     | Should   | T            |
| PAC-054        | CR (offset 0x100): Control Register           | Should   | T            |
| PAC-055        | SR (offset 0x104): Status Register            | Should   | T            |
| PAC-056        | TX_FIFO (offset 0x108): Transmit FIFO         | Should   | T            |
| PAC-057        | RX_FIFO (offset 0x10C): Receive FIFO          | Should   | T            |
| PAC-058        | ADR (offset 0x110): Slave Address Register    | Should   | T            |

### 11.7 AXI Timebase WDT Registers (0x41A0_0000)

| Requirement ID | Description                                     | Priority | Verification |
|----------------|-------------------------------------------------|----------|--------------|
| PAC-060        | TWCSR0 (offset 0x00): Control/Status Register 0 | Should   | T            |
| PAC-061        | TWCSR1 (offset 0x04): Control/Status Register 1 | Should   | T            |
| PAC-062        | TBR (offset 0x08): Timebase Register            | Should   | T            |

### 11.8 AXI Ethernet Lite Registers (0x40E0_0000)

| Requirement ID | Description                                      | Priority | Verification |
|----------------|--------------------------------------------------|----------|--------------|
| PAC-070        | TX_PING (offset 0x0000-0x07FF): Transmit buffer A| Could    | T            |
| PAC-071        | MDIOADDR (offset 0x07E4): MDIO Address           | Could    | T            |
| PAC-072        | MDIOWR (offset 0x07E8): MDIO Write Data          | Could    | T            |
| PAC-073        | MDIORD (offset 0x07EC): MDIO Read Data           | Could    | T            |
| PAC-074        | MDIOCTRL (offset 0x07F0): MDIO Control           | Could    | T            |
| PAC-075        | TX_LEN (offset 0x07F4): Transmit Length          | Could    | T            |
| PAC-076        | GIE (offset 0x07F8): Global Interrupt Enable     | Could    | T            |
| PAC-077        | TX_CTRL (offset 0x07FC): Transmit Control        | Could    | T            |
| PAC-078        | RX_PING (offset 0x1000-0x17FF): Receive buffer A | Could    | T            |
| PAC-079        | RX_CTRL (offset 0x17FC): Receive Control         | Could    | T            |

---

## 12. Application Requirements

### 12.1 Demo Application

| Requirement ID | Description                                              | Priority | Verification |
|----------------|----------------------------------------------------------|----------|--------------|
| APP-001        | Multiple tasks with different priorities                 | Should   | D            |
| APP-002        | Demonstrate mutex usage for shared resource protection   | Should   | D            |
| APP-003        | Demonstrate semaphore for task synchronization           | Should   | D            |
| APP-004        | Demonstrate message queue for inter-task communication   | Should   | D            |
| APP-005        | Producer task (high priority)                            | Should   | D            |
| APP-006        | Consumer task (normal priority)                          | Should   | D            |
| APP-007        | Worker task (normal priority)                            | Should   | D            |
| APP-008        | Blinker task (low priority) - LED heartbeat              | Should   | D            |
| APP-009        | Idle task (lowest priority) - statistics/sleep           | Must     | T            |
| APP-010        | UART shell/monitor task for debugging                    | Could    | D            |
| APP-011        | Application shall demonstrate all synchronization types  | Should   | D            |
| APP-012        | Application shall run continuously without failure       | Must     | T            |

**Rationale**: Demo application validates kernel functionality and serves as a reference implementation.

---

## 13. Build System Requirements

### 13.1 Toolchain

| Requirement ID | Description                                                                                                                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|--------------|
| BUILD-001      | Rust toolchain version 1.82.0 or later                                                                                                                             | Must     | I            |
| BUILD-002      | rust-src component for core library rebuild                                                                                                                        | Must     | I            |
| BUILD-003      | Default Rust target: `riscv32imac-unknown-none-elf`; the build shall ensure generated code runs on `rv32imac` as a minimum baseline                                | Must     | T            |
| BUILD-004      | Cross-compiler: `riscv64-unknown-elf-gcc` for linking                                                                                                              | Must     | I            |
| BUILD-005      | Cargo workspace organization                                                                                                                                       | Must     | I            |
| BUILD-006      | Optional: custom target specification JSON may be used to reflect additional extensions; it shall not reduce compatibility with deployed hardware                  | Should   | T            |
| BUILD-007      | The build shall verify the produced ELF does not contain unsupported ISA instructions for the chosen target (e.g., via `objdump -d` inspection or automated check) | Must     | T            |

### 13.2 Build Configuration

| Requirement ID | Description                                             | Priority | Verification |
|----------------|---------------------------------------------------------|----------|--------------|
| BUILD-008      | Optimization: size (`opt-level = "z"`)                  | Must     | I            |
| BUILD-009      | Link-time optimization (LTO): `true` or `"thin"`        | Should   | I            |
| BUILD-010      | Single codegen unit for better optimization             | Should   | I            |
| BUILD-011      | `panic = "abort"` (no unwinding)                        | Must     | I            |
| BUILD-012      | No standard library (`#![no_std]`)                      | Must     | A            |
| BUILD-013      | No main function (`#![no_main]`)                        | Must     | A            |
| BUILD-014      | Custom linker script (`memory.x` or `link.x`)           | Must     | I            |
| BUILD-015      | Output: ELF binary (`rustos-app.elf`)                   | Must     | T            |
| BUILD-016      | Binary/hex output for programming                       | Should   | T            |
| BUILD-017      | Debug symbols preserved for debugging                   | Should   | I            |
| BUILD-018      | Reproducible builds (same source produces same binary)  | Should   | T            |
| BUILD-019      | Build shall fail on warnings in release mode            | Should   | T            |

### 13.3 Dependencies

| Requirement ID | Description                                               | Priority | Verification |
|----------------|-----------------------------------------------------------|----------|--------------|
| DEP-001        | `critical-section` = "1.1"                                | Must     | I            |
| DEP-002        | `embedded-hal` = "1.0"                                    | Must     | I            |
| DEP-003        | `riscv` = "0.11" (RISC-V runtime and CSR access)          | Must     | I            |
| DEP-004        | `heapless` = "0.8" (static collections)                   | Must     | I            |
| DEP-005        | `bitfield` or `bitflags` for register manipulation        | Should   | I            |
| DEP-006        | `volatile-register` for hardware access                   | Should   | I            |
| DEP-007        | `riscv-rt` runtime (optional, or custom startup)          | Should   | I            |
| DEP-008        | All dependencies shall be audited for security issues     | Should   | A            |
| DEP-009        | Dependencies shall be pinned to specific versions         | Must     | I            |

### 13.4 Project Structure

| Requirement ID | Description                                    | Priority | Verification |
|----------------|------------------------------------------------|----------|--------------|
| PROJ-001       | Cargo workspace with multiple crates           | Should   | I            |
| PROJ-002       | `rustos-pac`: Peripheral Access Crate          | Should   | I            |
| PROJ-003       | `rustos-hal`: Hardware Abstraction Layer       | Should   | I            |
| PROJ-004       | `rustos-kernel`: Kernel core (scheduler, sync) | Must     | I            |
| PROJ-005       | `rustos-board`: Board-specific initialization  | Should   | I            |
| PROJ-006       | `rustos-app`: Application code                 | Must     | I            |
| PROJ-007       | `rustos-tests`: Host-based test suite          | Should   | I            |
| PROJ-008       | Clear separation of concerns between crates    | Must     | A            |

---

## 14. Performance Requirements

### 14.1 Timing Performance

| Requirement ID | Description                                                    | Target        | Priority | Verification |
|----------------|----------------------------------------------------------------|---------------|----------|--------------|
| PERF-001       | Context switch latency                                         | ≤ 5 µs        | Must     | T            |
| PERF-002       | Interrupt latency (hardware assertion to first ISR instruction)| ≤ 1 µs        | Must     | T            |
| PERF-003       | Mutex lock acquisition (uncontended)                           | ≤ 1 µs        | Should   | T            |
| PERF-004       | Semaphore signal/wait (uncontended)                            | ≤ 2 µs        | Should   | T            |
| PERF-005       | Message queue send/receive (uncontended)                       | ≤ 3 µs        | Should   | T            |
| PERF-006       | Critical section entry/exit                                    | ≤ 0.3 µs      | Must     | T            |
| PERF-007       | System tick jitter                                             | ≤ 1%          | Should   | T            |
| PERF-008       | Boot time to first user task                                   | ≤ 10 ms       | Should   | T            |

### 14.2 Memory Performance

| Requirement ID | Description                                                    | Target        | Priority | Verification |
|----------------|----------------------------------------------------------------|---------------|----------|--------------|
| PERF-010       | Kernel code size                                               | ≤ 16 KB       | Should   | T            |
| PERF-011       | Kernel RAM usage (excluding task stacks)                       | ≤ 4 KB        | Should   | T            |
| PERF-012       | Per-task overhead (TCB + minimal stack)                        | ≤ 256 bytes   | Should   | A            |
| PERF-013       | Total system footprint (kernel + HAL + app)                    | ≤ 64 KB       | Must     | T            |

### 14.3 Throughput Performance

| Requirement ID | Description                                                    | Target              | Priority | Verification |
|----------------|----------------------------------------------------------------|---------------------|----------|--------------|
| PERF-020       | Maximum task switch rate                                       | ≥ 10,000 /sec       | Should   | T            |
| PERF-021       | UART throughput                                                | 115200 bps sustained| Must     | T            |
| PERF-022       | Interrupt throughput (short ISRs)                              | ≥ 50,000 /sec       | Should   | T            |

---

## 15. Safety and Reliability Requirements

### 15.1 Memory Safety

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| SAFE-001       | Written in safe Rust where possible                                | Must     | A            |
| SAFE-002       | Minimal unsafe code (only for hardware access, inline asm)         | Must     | A            |
| SAFE-003       | Unsafe code clearly documented with safety invariants              | Must     | I            |
| SAFE-004       | No C++ exceptions (not applicable - Rust)                          | Must     | A            |
| SAFE-005       | Stack overflow detection via canary values                         | Should   | T            |
| SAFE-006       | No undefined behavior (proper volatile access, alignment)          | Must     | A            |
| SAFE-007       | All unsafe blocks shall have `// SAFETY:` comments                 | Must     | I            |
| SAFE-008       | Unsafe code percentage shall be ≤ 5% of total codebase             | Should   | A            |

### 15.2 Reliability

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| REL-001        | System shall operate continuously for ≥ 30 days without failure    | Should   | T            |
| REL-002        | Watchdog timer shall reset system on hang                          | Should   | T            |
| REL-003        | System shall recover from transient errors without reboot          | Should   | T            |
| REL-004        | No memory leaks (static allocation only)                           | Must     | A            |
| REL-005        | No priority inversion scenarios in mutex implementation            | Should   | A            |
| REL-006        | Deadlock-free design for core synchronization primitives           | Must     | A            |
| REL-007        | Graceful degradation under resource exhaustion                     | Should   | T            |

### 15.3 Fault Handling

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| REL-010        | All exceptions shall be caught and handled                         | Must     | T            |
| REL-011        | Fatal errors shall output diagnostic information before halt       | Should   | D            |
| REL-012        | Stack overflow shall trigger controlled system response            | Should   | T            |
| REL-013        | Invalid pointer access shall be detected and reported              | Should   | T            |
| REL-014        | Task failure shall not crash the entire system                     | Should   | T            |

---

## 16. Security Requirements

### 16.1 Code Security

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| SEC-001        | No buffer overflows possible in safe Rust code                     | Must     | A            |
| SEC-002        | Input validation on all external data                              | Should   | A            |
| SEC-003        | No use of deprecated or vulnerable APIs                            | Must     | I            |
| SEC-004        | Dependency audit for known vulnerabilities                         | Should   | A            |
| SEC-005        | Secure coding practices per CERT guidelines where applicable       | Should   | I            |

### 16.2 System Security

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| SEC-010        | Stack canaries for overflow detection                              | Should   | T            |
| SEC-011        | No sensitive data in debug output by default                       | Should   | I            |
| SEC-012        | Boot integrity verification (optional)                             | Could    | T            |

---

## 17. Quality Requirements

### 17.1 Code Quality

| Requirement ID | Description                                              | Priority | Verification |
|----------------|----------------------------------------------------------|----------|--------------|
| QUAL-001       | Documentation comments (`#![deny(missing_docs)]`)        | Should   | A            |
| QUAL-002       | Thread-safety via Send/Sync traits                       | Must     | A            |
| QUAL-003       | Critical section protection for shared state             | Must     | A            |
| QUAL-004       | Atomic operations for synchronization primitives         | Must     | A            |
| QUAL-005       | No clippy warnings (`#![deny(clippy::all)]`)             | Should   | A            |
| QUAL-006       | Consistent code formatting via rustfmt                   | Should   | A            |
| QUAL-007       | Unit tests where applicable (host-side)                  | Should   | T            |
| QUAL-008       | Code review required for all changes                     | Should   | I            |
| QUAL-009       | Cyclomatic complexity ≤ 15 per function                  | Should   | A            |
| QUAL-010       | Function length ≤ 100 lines                              | Should   | A            |

### 17.2 Test Quality

| Requirement ID | Description                                              | Priority | Verification |
|----------------|----------------------------------------------------------|----------|--------------|
| QUAL-020       | Unit test coverage ≥ 80% for testable code               | Should   | A            |
| QUAL-021       | All public APIs shall have test coverage                 | Should   | A            |
| QUAL-022       | Integration tests for kernel primitives                  | Should   | T            |
| QUAL-023       | Regression tests for all fixed bugs                      | Should   | T            |
| QUAL-024       | Performance regression tests                             | Could    | T            |

### 17.3 Maintainability

| Requirement ID | Description                                              | Priority | Verification |
|----------------|----------------------------------------------------------|----------|--------------|
| QUAL-030       | Modular architecture with clear interfaces               | Must     | A            |
| QUAL-031       | Single responsibility principle for modules              | Should   | A            |
| QUAL-032       | Minimal coupling between crates                          | Should   | A            |
| QUAL-033       | Configuration via compile-time constants                 | Should   | I            |
| QUAL-034       | Change impact analysis documentation                     | Should   | I            |

---

## 18. Deployment Requirements

### 18.1 Hardware Deployment

| Requirement ID | Description                                        | Priority | Verification |
|----------------|----------------------------------------------------|----------|--------------|
| DEPLOY-001     | Compatible with Xilinx Vitis 2025.2                | Must     | D            |
| DEPLOY-002     | JTAG programming via TCF/xsct protocol             | Must     | D            |
| DEPLOY-003     | FPGA bitstream programming first                   | Must     | D            |
| DEPLOY-004     | ELF download to BRAM target                        | Must     | D            |
| DEPLOY-005     | Debug support via JTAG and MDM                     | Should   | D            |
| DEPLOY-006     | Serial console at 115200 baud via USB-UART         | Must     | D            |
| DEPLOY-007     | Deployment procedure documented step-by-step       | Should   | I            |
| DEPLOY-008     | Flash programming for persistent storage           | Could    | D            |

### 18.2 Development Environment

| Requirement ID | Description                                   | Priority | Verification |
|----------------|-----------------------------------------------|----------|--------------|
| DEV-001        | VS Code integration with rust-analyzer        | Should   | D            |
| DEV-002        | Build scripts (`build.sh`, `clean.sh`)        | Should   | D            |
| DEV-003        | Launch configuration for debugging            | Should   | D            |
| DEV-004        | GDB integration for source-level debugging    | Should   | D            |
| DEV-005        | Memory view and register inspection           | Should   | D            |
| DEV-006        | Test coverage extraction (`coverage.sh`)      | Should   | D            |
| DEV-007        | Unsafe code usage analysis (`qa_safety.sh`)   | Should   | D            |
| DEV-008        | Test execution script (`test.sh`)             | Should   | D            |
| DEV-009        | CI/CD pipeline configuration                  | Should   | I            |
| DEV-010        | Development environment setup documentation   | Should   | I            |

---

## 19. Verification and Validation Requirements

### 19.1 Verification Methods

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| VER-001        | All Must requirements shall be verified before release             | Must     | I            |
| VER-002        | Unit tests shall cover all kernel algorithms                       | Should   | T            |
| VER-003        | Integration tests shall verify inter-module interfaces             | Should   | T            |
| VER-004        | Hardware validation on target platform                             | Must     | T            |
| VER-005        | Performance benchmarks shall validate timing requirements          | Should   | T            |
| VER-006        | Stress testing for reliability validation                          | Should   | T            |
| VER-007        | Code review for all production code                                | Should   | I            |
| VER-008        | Static analysis with clippy and miri (where applicable)            | Should   | A            |

### 19.2 Test Categories

| Category              | Description                                          | Coverage Target |
|-----------------------|------------------------------------------------------|-----------------|
| Unit Tests            | Individual function and module testing               | ≥ 80%           |
| Integration Tests     | Inter-module interface testing                       | All interfaces  |
| System Tests          | Full system behavior validation                      | All use cases   |
| Performance Tests     | Timing and throughput validation                     | All PERF reqs   |
| Stress Tests          | Extended operation and edge case testing             | 30+ days        |
| Regression Tests      | Verification of bug fixes                            | All fixed bugs  |

### 19.3 Acceptance Criteria

| Criterion             | Description                                          | Threshold       |
|-----------------------|------------------------------------------------------|-----------------|
| Functional            | All Must requirements pass verification              | 100%            |
| Performance           | All PERF requirements meet targets                   | 100%            |
| Code Quality          | No critical or high clippy warnings                  | 0 issues        |
| Test Coverage         | Line coverage for testable code                      | ≥ 80%           |
| Documentation         | All public APIs documented                           | 100%            |

---

## 20. Documentation Requirements

### 20.1 Technical Documentation

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| DOC-001        | API reference documentation (rustdoc)                              | Must     | I            |
| DOC-002        | Architecture design document                                       | Should   | I            |
| DOC-003        | Hardware interface specification                                   | Should   | I            |
| DOC-004        | Build and deployment guide                                         | Must     | I            |
| DOC-005        | Troubleshooting guide                                              | Should   | I            |
| DOC-006        | PAC provenance document                                            | Should   | I            |

### 20.2 User Documentation

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| DOC-010        | Getting started guide                                              | Should   | I            |
| DOC-011        | Task programming guide                                             | Should   | I            |
| DOC-012        | Synchronization primitives guide                                   | Should   | I            |
| DOC-013        | Example applications with explanations                             | Should   | I            |

### 20.3 Maintenance Documentation

| Requirement ID | Description                                                        | Priority | Verification |
|----------------|--------------------------------------------------------------------|----------|--------------|
| DOC-020        | Change log (CHANGELOG.md)                                          | Should   | I            |
| DOC-021        | Known issues and limitations                                       | Should   | I            |
| DOC-022        | Future roadmap                                                     | Could    | I            |

---

## 21. Constraints and Limitations

### 21.1 Known Limitations

| Limitation ID | Description                                                                                                                                               | Impact    | Mitigation                                    |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|-----------------------------------------------|
| LIM-001       | No priority inversion handling in mutex (no priority inheritance)                                                                                         | Medium    | Design tasks to avoid priority inversion      |
| LIM-002       | No strict FIFO fairness in semaphore (priority-based wake)                                                                                                | Low       | Document behavior, use queues for FIFO        |
| LIM-003       | Single interrupt priority level (no hardware nesting)                                                                                                     | Medium    | Keep ISRs short, use deferred processing      |
| LIM-004       | No dynamic task creation after boot (static only)                                                                                                         | Medium    | Pre-allocate all required tasks               |
| LIM-005       | Fixed memory layout (128 KB total BRAM)                                                                                                                   | Low       | Optimize memory usage, use external memory    |
| LIM-006       | Machine mode used for RTOS (supervisor mode with SV32 available but unused)                                                                               | Low       | Future enhancement possible                   |
| LIM-007       | Tick counter wraps after ~49 days at 1 ms rate                                                                                                            | Low       | Use 64-bit uptime for long durations          |
| LIM-008       | No instruction/data caches (direct BRAM access via LMB)                                                                                                   | Low       | Deterministic timing guaranteed               |
| LIM-009       | No MMU/MPU protection (flat memory model)                                                                                                                 | Medium    | Rely on Rust memory safety                    |
| LIM-010       | DDR3 and external Flash not used by default (BRAM only)                                                                                                   | Low       | Future enhancement for larger applications    |

### 21.2 Design Constraints

| Constraint ID | Description                                                              | Rationale                                          |
|---------------|--------------------------------------------------------------------------|----------------------------------------------------|
| CON-001       | Static memory allocation only                                            | Deterministic behavior, no fragmentation           |
| CON-002       | Maximum 16 tasks                                                         | Memory budget constraint                           |
| CON-003       | Maximum 2 KB stack per task (default)                                    | Total 32 KB for task stacks within budget          |
| CON-004       | No floating-point hardware support                                       | No FPU in target configuration                     |
| CON-005       | Single-core operation only                                               | Target hardware is single-core                     |
| CON-006       | 128 KB total memory budget                                               | BRAM size constraint                               |

### 21.3 External Dependencies

| Dependency          | Version   | Purpose                              | Risk        |
|---------------------|-----------|--------------------------------------|-------------|
| critical-section    | 1.1.x     | Critical section implementation      | Low         |
| embedded-hal        | 1.0.x     | Hardware abstraction traits          | Low         |
| riscv               | 0.11.x    | RISC-V CSR access and runtime        | Low         |
| heapless            | 0.8.x     | Static data structures               | Low         |
| Rust Toolchain      | ≥ 1.82.0  | Compiler and standard library        | Medium      |
| riscv64-unknown-elf | Latest    | Cross-compilation toolchain          | Low         |
| Xilinx Vitis        | 2025.2    | FPGA programming tools               | Medium      |

---

## 22. Risk Analysis

### 22.1 Technical Risks

| Risk ID | Description                                           | Probability | Impact | Mitigation Strategy                               |
|---------|-------------------------------------------------------|-------------|--------|---------------------------------------------------|
| RSK-001 | Memory exhaustion in 128 KB BRAM                      | Medium      | High   | Monitor usage, optimize code size                 |
| RSK-002 | Context switch latency exceeds target                 | Low         | Medium | Profile and optimize critical paths               |
| RSK-003 | Interrupt latency exceeds target                      | Low         | High   | Minimize critical sections, profile ISRs          |
| RSK-004 | Stack overflow in task execution                      | Medium      | High   | Canary values, stack monitoring                   |
| RSK-005 | Deadlock in synchronization primitives                | Low         | High   | Design review, runtime detection                  |
| RSK-006 | Compiler/toolchain incompatibility                    | Low         | Medium | Pin versions, CI testing                          |
| RSK-007 | Hardware errata affecting operation                   | Low         | High   | Vendor communication, workarounds                 |

### 22.2 Schedule Risks

| Risk ID | Description                                           | Probability | Impact | Mitigation Strategy                               |
|---------|-------------------------------------------------------|-------------|--------|---------------------------------------------------|
| RSK-010 | HAL driver development takes longer than expected     | Medium      | Medium | Prioritize Must drivers, defer Could items        |
| RSK-011 | Debug/bring-up issues on hardware                     | Medium      | High   | Host-based testing, JTAG debugging                |
| RSK-012 | Integration issues between crates                     | Low         | Medium | Clear interfaces, integration testing             |

### 22.3 Risk Acceptance Criteria

- **High Impact Risks**: Must have mitigation strategies in place before release
- **Medium Impact Risks**: Should have mitigation strategies documented
- **Low Impact Risks**: Accepted with monitoring

---

## 23. Traceability Matrix

### 23.1 Requirements to Source Mapping

| Requirement Category | Source Document/Section                    |
|----------------------|--------------------------------------------|
| HW-xxx               | hardware/README.md, hardware/artifacts/    |
| ISA-xxx              | RISC-V Specifications, BSP configuration   |
| PER-xxx              | bsp/README.md, Device Tree files           |
| PAC-xxx              | Xilinx Product Guides (PG099, PG142, etc.) |
| SCHED-xxx            | Design documentation                       |
| SAFE-xxx             | Rust Safety Guidelines                     |

### 23.2 Requirements to Test Mapping

Requirements with verification method `T` (Test) shall have corresponding test cases documented in the test plan. The mapping shall be maintained in a separate test traceability document.

### 23.3 Requirements Coverage Summary

| Category          | Must | Should | Could | Info | Total |
|-------------------|------|--------|-------|------|-------|
| Platform (HW/ISA) | 18   | 3      | 0     | 12   | 33    |
| Kernel            | 42   | 28     | 2     | 0    | 72    |
| Synchronization   | 18   | 10     | 5     | 0    | 33    |
| Memory            | 15   | 5      | 0     | 0    | 20    |
| HAL               | 16   | 35     | 15    | 1    | 67    |
| BSP               | 18   | 12     | 2     | 0    | 32    |
| PAC               | 12   | 25     | 10    | 0    | 47    |
| Build             | 14   | 12     | 0     | 0    | 26    |
| Performance       | 4    | 9      | 0     | 0    | 13    |
| Safety/Security   | 12   | 15     | 1     | 0    | 28    |
| Quality           | 6    | 17     | 1     | 0    | 24    |
| Deployment        | 6    | 12     | 1     | 0    | 19    |
| **Total**         | **181** | **183** | **37** | **13** | **414** |

---

## 24. Appendices

### Appendix A: Architecture Layers

```text
┌─────────────────────────────────────────┐
│         Application Layer               │
│    (User tasks, business logic)         │
├─────────────────────────────────────────┤
│         Synchronization Layer           │
│  (Mutex, Semaphore, MessageQueue)       │
├─────────────────────────────────────────┤
│         Kernel Core                     │
│  (Scheduler, Task Manager, Context)     │
├─────────────────────────────────────────┤
│    Hardware Abstraction Layer (HAL)     │
│  (UART, Timer, GPIO, SPI, I2C, WDT)     │
├─────────────────────────────────────────┤
│  Peripheral Access Crate (PAC)          │
│  (Register-level hardware access)       │
├─────────────────────────────────────────┤
│  Board Support Package (BSP)            │
│  (Startup, Trap Handling, Init)         │
├─────────────────────────────────────────┤
│      MicroBlaze V RISC-V Hardware       │
│  (rv32imacb_zicsr_zifencei_zbc @ 75MHz) │
│  (128KB BRAM, 11 IRQs, LMB Bus)         │
└─────────────────────────────────────────┘
```

### Appendix B: Hardware Platform Summary

| Property             | Value                                           |
|----------------------|-------------------------------------------------|
| Board                | Digilent Arty A7-35                             |
| FPGA                 | XC7A35TICSG324-1L (Artix-7)                     |
| Logic Slices         | 5,200                                           |
| Block RAM            | 1,800 Kbits                                     |
| DSP Slices           | 90                                              |
| DDR3                 | 256 MB @ 333 MHz (667 MT/s)                     |
| Quad-SPI Flash       | 16 MB                                           |
| Processor            | MicroBlaze V (RISC-V soft-core)                 |
| ISA                  | rv32imacb_zicsr_zifencei_zbc                    |
| Clock Frequency      | 75 MHz                                          |
| Local Memory         | 128 KB BRAM (64K instruction + 64K data)        |
| Cache                | None (direct LMB access)                        |
| Privilege Mode       | Supervisor with SV32 (machine mode used)        |
| Exception Handling   | Complete (illegal instr, misaligned, bus)       |
| Interrupt Sources    | 11 via AXI Interrupt Controller                 |
| Debug                | MDM V with 8 PC breakpoints, 4 R/W watchpoints  |
| External Trace       | 16-bit interface                                |
| Performance Counters | 13 event counters, 8 latency counters           |
| Vivado Version       | 2025.2                                          |
| Vitis Version        | 2025.2                                          |

### Appendix C: IP Core Reference

| IP Core                  | Version | Instance Name                          | Description                           |
|--------------------------|---------|----------------------------------------|---------------------------------------|
| MicroBlaze V             | v1.0    | mbv_microblaze_v                       | RISC-V soft-core processor            |
| Clocking Wizard          | v6.0    | mbv_clocking_wizard                    | 100 MHz → 75 MHz clock generation     |
| MDM V                    | v1.0    | mbv_microblaze_debug_module_v          | Debug module with JTAG                |
| LMB BRAM Controller      | v4.0    | mbv_*_lmb_bram_controller              | Memory controller (2 instances)       |
| LMB v10                  | v3.0    | mbv_*_local_memory_bus                 | Local memory bus (2 instances)        |
| Block Memory Generator   | v8.4    | mbv_block_memory_generator             | 128 KB BRAM                           |
| AXI SmartConnect         | v1.0    | mbv_axi_smartconnect                   | AXI interconnect                      |
| AXI Interrupt Controller | v4.1    | mbv_axi_interrupt_controller           | 11 interrupts                         |
| AXI UART Lite            | v2.0    | mbv_axi_uartlite                       | 115200/8N1 serial                     |
| AXI GPIO                 | v2.0    | mbv_axi_gpio_*                         | GPIO controllers (7 instances)        |
| AXI IIC                  | v2.1    | mbv_axi_iic                            | I2C master                            |
| AXI Quad SPI             | v3.2    | mbv_axi_quad_spi_*                     | SPI controllers (2 instances)         |
| AXI Ethernet Lite        | v3.0    | mbv_axi_ethernetlite                   | 10/100 Mbps MAC                       |
| AXI Timebase WDT         | v3.0    | mbv_axi_timebase_watchdog_timer        | Window watchdog                       |
| Fixed Interval Timer     | v2.0    | mbv_fixed_interval_timer_1_millisecond | 1 ms system tick                      |
| Processor System Reset   | v5.0    | mbv_processor_system_reset             | Reset sequencing                      |

### Appendix D: Glossary of Terms

See Section 3 (Definitions, Acronyms, and Abbreviations) for comprehensive terminology definitions.

### Appendix E: Change Request Process

1. **Initiation**: Submit change request with rationale and impact assessment
2. **Review**: Technical review by architecture team
3. **Approval**: Sign-off by Technical Lead and Quality Assurance
4. **Implementation**: Update requirements document and traceability
5. **Verification**: Confirm all affected test cases updated
6. **Communication**: Notify all stakeholders of changes

### Appendix F: Requirements Status Definitions

| Status          | Description                                                  |
|-----------------|--------------------------------------------------------------|
| Draft           | Initial capture, not yet reviewed                            |
| Under Review    | Being reviewed by stakeholders                               |
| Approved        | Formally approved and baselined                              |
| Implemented     | Code complete, awaiting verification                         |
| Verified        | Verification complete and passed                             |
| Deferred        | Postponed to future release                                  |
| Rejected        | Will not be implemented                                      |

---

*Document ID: RUSTOS-SRS-001*
*Version: 2.0.0*
*Classification: Internal*
*Last Updated: January 11, 2026*

**End of Document**
