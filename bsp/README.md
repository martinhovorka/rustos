# Board Support Package (BSP) - README

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Processor Configuration](#processor-configuration-from-bspyaml)
4. [Complete Memory Map](#complete-memory-map-from-device-tree)
5. [Driver Support and API Reference](#driver-support-and-api-reference)
6. [Available Software Libraries](#available-software-libraries-from-lib_listyaml)
7. [Application Templates](#application-templates-from-app_listyaml)
8. [RISC-V Specific Details for RTOS Development](#risc-v-specific-details-for-rtos-development)
   - [Exception and Interrupt Handling](#exception-and-interrupt-handling)
   - [Memory Layout for Bare-Metal/RTOS](#memory-layout-for-bare-metalrtos)
   - [Startup and Boot Sequence](#startup-and-boot-sequence)
   - [Cache Coherency](#cache-coherency)
   - [Atomic Operations Support](#atomic-operations-support)
   - [Platform-Specific Considerations for Rust RTOS](#platform-specific-considerations-for-rust-rtos)
9. [Quick Reference Tables](#quick-reference-tables)
10. [Direct Hardware Access](#direct-hardware-access-bare-metalrtos-development)
    - [Peripheral Register Maps](#peripheral-register-maps)
    - [Memory-Mapped I/O Access Pattern](#memory-mapped-io-access-pattern)
    - [Interrupt Handler Setup](#interrupt-handler-setup-bare-metal)
11. [Extended Peripheral Documentation](#extended-peripheral-documentation)
    - [SPI Flash Memory Access](#spi-flash-memory-access)
    - [Ethernet MDIO/PHY Configuration](#ethernet-mdiophy-configuration)
    - [Extended I2C Protocol Documentation](#extended-i2c-protocol-documentation)
    - [Extended Watchdog Timer Documentation](#extended-watchdog-timer-documentation)
    - [Timer and Sleep APIs](#timer-and-sleep-apis)
    - [Debug Interface (JTAG/MDM)](#debug-interface-jtagmdm)
12. [Usage](#usage)
13. [Regenerating the BSP](#regenerating-the-bsp)
14. [Troubleshooting](#troubleshooting)
15. [Key Files Reference](#key-files-reference)
16. [Related Resources](#related-resources)
17. [Tools and Versions](#tools-and-versions)
18. [License and Copyright](#license-and-copyright)

---

## Overview

This directory contains the Vitis 2025.2 workspace with Board Support Package (BSP) and platform configuration for the RISC-V based hardware design. The BSP provides essential drivers, libraries, and runtime support for embedded software development on the `rv32imacb_zicsr_zifencei_zbc` RISC-V processor.

**Critical Information for RTOS Development:**

- This BSP is designed for bare-metal and standalone applications
- All driver source code is available in `libsrc/` subdirectories
- Direct hardware register access is documented in device tree files
- No existing RTOS support is provided - this is a greenfield implementation target

## Directory Structure

### Root Directory Files

- [vitis-comp.json](./vitis-comp.json) - Top-level platform configuration
- [hw/](./hw/) - Hardware specification and device tree files
  - `rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa` - Vivado hardware export
  - `sdt/system-top.dts` - Complete system device tree
- [mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/) - Core BSP implementation
- [export/bsp/](./export/bsp/) - Pre-built BSP platform package
- [logs/](./logs/) - Build generation logs

### BSP Domain: standalone_mbv_microblaze_v

Located at: `mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/`

**Key Configuration Files:**

- [bsp.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml) - Complete BSP configuration and driver mapping
- [cflags.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/cflags.yaml) - Compiler and linker flags
- [lib_list.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/lib_list.yaml) - Available libraries (lwIP, xiltimer, xilsecure, etc.)
- [app_list.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/app_list.yaml) - Pre-configured application templates
- [CMakeLists.txt](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/CMakeLists.txt) - CMake build configuration
- [microblaze_riscv_toolchain.cmake](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/microblaze_riscv_toolchain.cmake) - Toolchain configuration
- [Xilinx.spec](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/Xilinx.spec) - GCC specs file for startup

**Directory Structure:**

- `include/` - All driver headers and BSP configuration (59+ header files)
- `lib/` - Compiled libraries (libxil.a, driver libraries)
- `libsrc/` - Driver source code for all peripherals
- `hw_artifacts/` - Device tree files specific to baremetal configuration

## Processor Configuration (from bsp.yaml)

### Processor: mbv_microblaze_v (MicroBlaze V RISC-V)

**Processor Type:** `microblaze_riscv` (RV32IMACB_Zicsr_Zifencei_Zbc)

**Toolchain:**

- **Compiler:** `riscv64-unknown-elf-gcc.exe` (GCC RISC-V 64-bit toolchain for 32-bit targets)
- **Assembler:** `riscv64-unknown-elf-gcc`
- **Archiver:** `riscv64-unknown-elf-gcc-ar.exe`
- **Linker:** Uses GCC with custom specs file

**Compiler Flags (from cflags.yaml and bsp.yaml):**

```text
-march=rv32imacb_zicsr_zifencei_zbc
-mabi=ilp32
-DSDT
-O2
-g
-ffunction-sections
-fdata-sections
-Wall
-Wextra
-fno-tree-loop-distribute-patterns
```

**Linker Flags:**

```text
-march=rv32imacb_zicsr_zifencei_zbc
-Wl,--gc-sections
```

**Architecture Breakdown:**

- `-march=rv32imacb_zicsr_zifencei_zbc`: Full ISA specification
  - `rv32`: 32-bit RISC-V base
  - `i`: Integer base ISA
  - `m`: Integer multiplication and division
  - `a`: Atomic instructions (load-reserved/store-conditional, atomic memory operations)
  - `c`: Compressed 16-bit instructions
  - `b`: Bit manipulation (implies Zba + Zbb + Zbs)
  - `Zicsr`: Control and Status Register instructions
  - `Zifencei`: Instruction-fetch fence
  - `Zbc`: Carry-less multiplication (polynomial arithmetic)
- `-mabi=ilp32`: 32-bit integer, long, and pointer ABI (soft-float)
  - Integers: 32-bit
  - Longs: 32-bit
  - Pointers: 32-bit
  - Floating-point: Software emulation (no hardware FPU used)

**CPU Characteristics (from device tree):**

- **Clock Frequency:** 75 MHz (0x47868c0 Hz)
- **Timebase Frequency:** 75 MHz
- **Address Size:** 32-bit (physical and virtual)
- **Data Size:** 32 bits
- **Instruction Size:** 32 bits
- **PC Width:** 17 bits
- **MMU:** Enabled (SV32 - Supervisor mode with 32-bit virtual memory)
  - `xlnx,use-mmu = 3` (Supervisor mode)
- **Caches:** Disabled (direct memory access via LMB)
  - No I-Cache (`xlnx,use-icache = 0`)
  - No D-Cache (`xlnx,use-dcache = 0`)
- **Interrupts:**
  - External interrupt support enabled (`xlnx,use-interrupt = 2`)
  - Asynchronous interrupts enabled
  - Edge-positive triggering
- **Debug Features:**
  - Debug enabled (`xlnx,debug-enabled = 1`)
  - PC Breakpoints: 8
  - Read Address Breakpoints: 4
  - Write Address Breakpoints: 4
  - External trace enabled (16-bit trace port)
  - Event Counters: 13
  - Latency Counters: 8
  - Debug Program Buffer: 2 entries
- **Exception Handling:**
  - Illegal instruction exceptions: Enabled (level 2)
  - Misaligned exceptions: Enabled
  - ECC exceptions: Disabled
- **Bit Manipulation:**
  - Zba: Address generation (enabled)
  - Zbb: Basic bit manipulation (enabled)
  - Zbs: Single-bit instructions (enabled)
  - Zbc: Carry-less multiply (enabled)
- **Other Features:**
  - Barrel shifter: Enabled
  - Atomic instructions: Enabled
  - Hardware counters: Enabled
  - Compressed instructions: Enabled
  - Multiply/Divide: Hardware (level 2)
  - FPU: Disabled
  - PMP (Physical Memory Protection): 0 entries (disabled)

### Standalone OS Configuration (from bsp.yaml)

**Standard I/O:**

- **stdin:** `mbv_axi_uartlite` @ 0x40600000
- **stdout:** `mbv_axi_uartlite` @ 0x40600000
- **Baud Rate:** 115200 (default for UART Lite)

**OS Options:**

- **XPM Support:** Disabled (no power management)
- **Sleep Timer:** Deprecated (use xiltimer library instead)
- **Profile Timer:** Disabled in Unified IDE
- **Software Intrusive Profiling:** Disabled in Unified IDE

**Build System:**

- **Template:** empty_application
- **Specs File:** Xilinx.spec (custom GCC specs for startup files)
- **Build Tool:** CMake 3.15+

## Complete Memory Map (from Device Tree)

### Local Memory (LMB - Local Memory Bus)

| Address Range | Size | Description | Device |
|||||
| 0x00000000 - 0x0001FFFF | 128 KB | BRAM (Block RAM) - Instruction & Data | mbv_local_memory (dual-port) |

**Memory Characteristics:**

- **Type:** On-chip Block RAM (BRAM)
- **Access:** Zero-wait-state via LMB
- **Configuration:** Unified instruction and data memory (Harvard architecture via dual LMB controllers)
- **ECC:** Disabled
- **Width:** 32-bit data path
- **Protocol:** LMB (Local Memory Bus) - optimized, low-latency

### Peripheral Memory Map (AXI4-Lite)

All peripherals are accessed via AXI4-Lite interconnect (SmartConnect):

| Address Range | Size | Peripheral | Driver | IRQ |
||||||
| 0x40000000 - 0x4000FFFF | 64 KB | GPIO Shield Pins 0-19 | gpio v4.12 | Yes (IRQ 4) |
| 0x40010000 - 0x4001FFFF | 64 KB | GPIO Shield Pins 26-41 | gpio v4.12 | Yes (IRQ 5) |
| 0x40020000 - 0x4002FFFF | 64 KB | GPIO Push Buttons | gpio v4.12 | Yes (IRQ 6) |
| 0x40030000 - 0x4003FFFF | 64 KB | GPIO DIP Switches | gpio v4.12 | Yes (IRQ 7) |
| 0x40040000 - 0x4004FFFF | 64 KB | GPIO LED 4-bits | gpio v4.12 | No |
| 0x40050000 - 0x4005FFFF | 64 KB | GPIO RGB LEDs | gpio v4.12 | No |
| 0x40060000 - 0x4006FFFF | 64 KB | GPIO I2C Pullups | gpio v4.12 | No |
| 0x40600000 - 0x4060FFFF | 64 KB | AXI UART Lite | uartlite v2.0 | Yes (IRQ 2) |
| 0x40800000 - 0x4080FFFF | 64 KB | AXI IIC (I2C) | iic v3.14 | Yes (IRQ 8) |
| 0x40E00000 - 0x40E0FFFF | 64 KB | AXI Ethernet Lite MAC | emaclite v4.12 | Yes (IRQ 0) |
| 0x41200000 - 0x4120FFFF | 64 KB | AXI Interrupt Controller | intc v3.21 | N/A |
| 0x41A00000 - 0x41A0FFFF | 64 KB | AXI Timebase WDT | wdttb v3.0 | Yes (IRQ 1, 10) |
| 0x44A00000 - 0x44A0FFFF | 64 KB | AXI Quad SPI Flash | spi v4.15 | Yes (IRQ 3) |
| 0x44A10000 - 0x44A1FFFF | 64 KB | AXI Quad SPI | spi v4.15 | Yes (IRQ 9) |

**Notes:**

- All peripherals operate at 75 MHz AXI clock
- Each peripheral region is 64 KB (0x10000 bytes) aligned
- Interrupt numbers correspond to AXI Interrupt Controller inputs

### Interrupt Mapping

**Interrupt Controller:** `mbv_axi_interrupt_controller` @ 0x41200000

| IRQ # | Peripheral | Signal | Type |
|||||
| 0 | Ethernet Lite | ip2intc_irpt | Rising Edge |
| 1 | Watchdog Timer | wdt_interrupt | Rising & Level |
| 2 | UART Lite | interrupt | Rising Edge |
| 3 | Quad SPI Flash | ip2intc_irpt | Rising Edge |
| 4 | GPIO Shield 0-19 | ip2intc_irpt | Rising Edge |
| 5 | GPIO Shield 26-41 | ip2intc_irpt | Rising Edge |
| 6 | GPIO Push Buttons | ip2intc_irpt | Rising Edge |
| 7 | GPIO DIP Switches | ip2intc_irpt | Rising Edge |
| 8 | I2C (IIC) | iic2intc_irpt | Rising Edge |
| 9 | Quad SPI | ip2intc_irpt | Rising Edge |
| 10 | Watchdog Timer | wdt_interrupt (second) | Level |

**Interrupt Controller Configuration:**

- **Type:** AXI Interrupt Controller v4.1
- **Mode:** Fast Interrupt mode (has IVR - Interrupt Vector Register)
- **Edge/Level:** Configurable per interrupt (see `xlnx,kind-of-irq`)
- **Cascading:** Not used (single controller)
- **Software Interface:** XIntc driver (see include/xintc.h)
- **RISC-V Integration:** Maps to external interrupts via PLIC interface

## Driver Support and API Reference

### Available Drivers (from bsp.yaml drv_info)

All drivers are located in: `libsrc/<driver_name>/src/`

#### 1. GPIO Driver (gpio v4.12)

**Header Files:**

- `xgpio.h` - High-level GPIO API
- `xgpio_l.h` - Low-level register access macros
- `xgpio_i.h` - Internal declarations

**Instances:**

- mbv_axi_gpio_shield_pins_0_19 (20 pins, dual-channel, interrupt-capable)
- mbv_axi_gpio_shield_pins_26_41 (16 pins, dual-channel, interrupt-capable)
- mbv_axi_gpio_push_buttons (4 buttons, interrupt-capable)
- mbv_axi_gpio_dip_switches (4 switches, interrupt-capable)
- mbv_axi_gpio_led_4_bits (4 LEDs, output-only)
- mbv_axi_gpio_led_rgb (12 pins for 4 RGB LEDs, output-only)
- mbv_axi_gpio_iic_pullups (I2C pull-up control)

**Key Functions:**

- `XGpio_Initialize()` - Initialize GPIO instance
- `XGpio_SetDataDirection()` - Configure pin direction
- `XGpio_DiscreteRead()` - Read input pins
- `XGpio_DiscreteWrite()` - Write output pins
- `XGpio_InterruptEnable()` - Enable pin interrupts
- `XGpio_InterruptGetStatus()` - Read interrupt status

#### 2. UART Lite Driver (uartlite v2.0)

**Header Files:**

- `xuartlite.h` - High-level UART API
- `xuartlite_l.h` - Low-level register access

**Instance:** mbv_axi_uartlite @ 0x40600000

**Configuration:**

- **Baud Rate:** 115200 bps
- **Data Bits:** 8
- **Parity:** None
- **Stop Bits:** 1
- **FIFO:** 16-byte TX/RX FIFOs

**Key Functions:**

- `XUartLite_Initialize()` - Initialize UART
- `XUartLite_Send()` - Transmit buffer
- `XUartLite_Recv()` - Receive buffer
- `XUartLite_SetRecvHandler()` - Set RX interrupt handler
- `XUartLite_SetSendHandler()` - Set TX interrupt handler

**Stdio Integration:**

- Configured as stdin/stdout in BSP
- Standard printf()/scanf() automatically use this UART

#### 3. I2C Driver (iic v3.14)

**Header Files:**

- `xiic.h` - High-level I2C API
- `xiic_l.h` - Low-level register access
- `xiic_i.h` - Internal declarations

**Instance:** mbv_axi_iic @ 0x40800000

**Configuration:**

- **I2C Frequency:** 100 kHz (0x186a0 Hz)
- **SDA Inertial Delay:** 4 AXI clocks
- **SCL Inertial Delay:** 4 AXI clocks
- **10-bit Addressing:** Disabled
- **GPO Width:** 1 bit

**Key Functions:**

- `XIic_Initialize()` - Initialize I2C controller
- `XIic_Start()` - Start I2C transaction
- `XIic_MasterSend()` - Transmit data (master mode)
- `XIic_MasterRecv()` - Receive data (master mode)
- `XIic_SetAddress()` - Set slave address

**Hardware Note:**

- Use mbv_axi_gpio_iic_pullups to control external I2C pull-up resistors

#### 4. SPI Driver (spi v4.15)

**Header Files:**

- `xspi.h` - High-level SPI API
- `xspi_l.h` - Low-level register access

**Instances:**

- mbv_axi_quad_spi_flash @ 0x44A00000 (on-board SPI flash)
- mbv_axi_quad_spi @ 0x44A10000 (external devices)

**Configuration (Flash):**

- **Transfer Width:** 8 bits
- **FIFO Depth:** 256 entries
- **Num CS:** 1 chip select
- **SPI Mode:** Mode 2 (CPOL=1, CPHA=0)
- **SCK Ratio:** 2 (37.5 MHz SPI clock from 75 MHz AXI)

**Configuration (External):**

- **Transfer Width:** 32 bits
- **FIFO Depth:** 256 entries
- **Num CS:** 1 chip select
- **SPI Mode:** Mode 0 (CPOL=0, CPHA=0)
- **SCK Ratio:** 16 (4.6875 MHz SPI clock)

**Key Functions:**

- `XSpi_Initialize()` - Initialize SPI controller
- `XSpi_Start()` - Start SPI transaction
- `XSpi_Transfer()` - Bidirectional data transfer
- `XSpi_SetOptions()` - Configure mode, clock polarity, etc.
- `XSpi_SetSlaveSelect()` - Assert/deassert chip select

#### 5. Ethernet Lite Driver (emaclite v4.12)

**Header Files:**

- `xemaclite.h` - High-level Ethernet API
- `xemaclite_l.h` - Low-level register access
- `xemaclite_i.h` - Internal declarations

**Instance:** mbv_axi_ethernetlite @ 0x40E00000

**Configuration:**

- **MAC Address:** 00:0A:35:00:01:02 (default, configurable)
- **Speed:** 10/100 Mbps auto-negotiation
- **Interface:** MII (Media Independent Interface)
- **Ping/Pong Buffers:** Enabled (for concurrent TX/RX)

**Key Functions:**

- `XEmacLite_Initialize()` - Initialize Ethernet MAC
- `XEmacLite_Send()` - Transmit Ethernet frame
- `XEmacLite_Recv()` - Receive Ethernet frame
- `XEmacLite_SetMacAddress()` - Set MAC address
- `XEmacLite_PhyRead()` - Read PHY register (MDIO)
- `XEmacLite_PhyWrite()` - Write PHY register (MDIO)

**Network Stack Integration:**

- Use with lwIP 2.2.0 library (see lib_list.yaml)
- Application templates available: echo_server, tcp_perf, udp_perf

#### 6. Interrupt Controller Driver (intc v3.21)

**Header Files:**

- `xintc.h` - High-level interrupt API
- `xintc_l.h` - Low-level register access macros

**Instance:** mbv_axi_interrupt_controller @ 0x41200000

**Configuration:**

- **Number of Interrupts:** 11 (IRQ 0-10)
- **Fast Interrupt:** Enabled (IVR register for vector table)
- **Cascade:** Not used

**Key Functions:**

- `XIntc_Initialize()` - Initialize interrupt controller
- `XIntc_Start()` - Start interrupt controller
- `XIntc_Connect()` - Connect handler to IRQ
- `XIntc_Enable()` - Enable specific interrupt
- `XIntc_Disable()` - Disable specific interrupt
- `XIntc_Acknowledge()` - Acknowledge interrupt

**RISC-V Integration:**

- Uses RISC-V PLIC (Platform-Level Interrupt Controller) interface
- Maps to external interrupts on RISC-V core
- See `riscv_interface.h` for low-level RISC-V interrupt handling

#### 7. Watchdog Timer Driver (wdttb v3.0)

**Header Files:**

- `xwdttb.h` - High-level watchdog API
- `xwdttb_l.h` - Low-level register access

**Instance:** mbv_axi_timebase_watchdog_timer @ 0x41A00000

**Configuration:**

- **Window WDT:** Enabled
- **Max Count Width:** 32 bits
- **Second Sequence Timer:** 8 bits wide
- **Interval:** 30 seconds (default)
- **Enable Once:** True (cannot be disabled after start)

**Key Functions:**

- `XWdtTb_Initialize()` - Initialize watchdog
- `XWdtTb_Start()` - Start watchdog timer
- `XWdtTb_RestartWdt()` - Restart (feed) the watchdog
- `XWdtTb_GetTbValue()` - Read current timer value
- `XWdtTb_SetOptions()` - Configure watchdog options

**Interrupts:**

- IRQ 1: First window timeout warning
- IRQ 10: Second window timeout (reset imminent)

#### 8. BRAM Controller (lmb_bram_if_cntlr v4.0)

**Header Files:**

- `xbram.h` - BRAM controller API
- `xbram_hw.h` - Hardware definitions

**Instances:**

- mbv_local_memory_mbv_data_lmb_bram_controller
- mbv_local_memory_mbv_instruction_lmb_bram_controller

**Configuration:**

- **ECC:** Disabled
- **Width:** 32-bit
- **Protocol:** LMB (Local Memory Bus)
- **Arbitration:** None (single master)

**Note:** Typically no driver needed - direct memory access via pointers

## Available Software Libraries (from lib_list.yaml)

### For Standalone OS

#### 1. lwIP 2.2.0 (lwip220 v1.3)

**Description:** Lightweight TCP/IP stack for embedded systems

**Path:** `ThirdParty/sw_services/lwip220_v1_3`

**Features:**

- TCP/IPv4 and IPv6 support
- UDP, ICMP, ARP, DHCP, DNS
- Socket API and raw API
- Optimized for Xilinx Ethernet MACs
- RTOS or bare-metal operation

**Application Templates:**

- `lwip_echo_server` - Echo server on port 7
- `lwip_tcp_perf_client` - TCP throughput test client
- `lwip_tcp_perf_server` - TCP throughput test server
- `lwip_udp_perf_client` - UDP throughput test client
- `lwip_udp_perf_server` - UDP throughput test server

**Configuration:**

- Default IP: 192.168.1.10
- Default MAC: 00:0A:35:00:01:02
- Supports IPv6 link-local addressing

#### 2. XilTimer (xiltimer v2.3)

**Description:** Generic timer abstraction library

**Path:** `lib/sw_services/xiltimer_v2_3`

**Purpose:**

- Provides platform-independent timer API
- Replaces deprecated standalone sleep/profile timers
- Used by all application templates

**Key Functions:**

- `XTimer_Initialize()` - Initialize timer subsystem
- `usleep()` - Microsecond delay
- `sleep()` - Second delay
- Timer callback registration

**Hardware Mapping:**

- Uses mbv_fixed_interval_timer_1_millisecond (FIT Timer @ 1 ms tick)
- Can also use CPU cycle counter for high-resolution timing

#### 3. XilSecure (xilsecure v5.6)

**Description:** Cryptographic and secure boot library

**Path:** `lib/sw_services/xilsecure_v5_6`

**Features:**

- AES encryption/decryption
- RSA signing/verification
- SHA-256/384/512 hashing
- Designed for Zynq UltraScale+ and Versal
- Limited applicability to MicroBlaze V (no hardware crypto engines)

#### 4. XilSFL (xilsfl v1.2)

**Description:** Serial NOR Flash Library

**Path:** `lib/sw_services/xilsfl_v1_2`

**Purpose:**

- High-level API for SPI NOR flash operations
- Works with mbv_axi_quad_spi_flash instance
- Supports common flash chips (Spansion, Micron, Winbond, etc.)

**Key Functions:**

- `XilSfl_Initialize()` - Initialize flash library
- `XilSfl_Read()` - Read from flash
- `XilSfl_Write()` - Write to flash
- `XilSfl_Erase()` - Erase flash sectors
- Flash protection and status management

#### 5. XilNVM (xilnvm v3.6)

**Description:** Non-Volatile Memory (eFUSE, BBRAM) library

**Applicability:** Limited to Zynq/Versal (not applicable to Artix-7)

#### 6. XilPUF (xilpuf v2.6)

**Description:** Physical Unclonable Function library

**Applicability:** Limited to Zynq UltraScale+/Versal (not applicable to Artix-7)

### Library Dependencies

Most application templates depend on:

- `xiltimer` (required for all templates)
- `lwip220` (required for network applications)

No inter-library dependencies exist for the standalone BSP.

## Application Templates (from app_list.yaml)

Pre-configured application examples (access via Vitis: File → New → Application Project):

1. **empty_application** - Blank C project skeleton
   - Dependencies: xiltimer

2. **hello_world** - Classic "Hello World" via UART
   - Dependencies: xiltimer
   - Uses printf() to stdout (UART Lite)

3. **dhrystone** - Dhrystone synthetic benchmark
   - Dependencies: xiltimer
   - Performance measurement tool

4. **memory_tests** - Tests all memory regions
   - Dependencies: xiltimer
   - Validates BRAM functionality

5. **peripheral_tests** - Simple peripheral test routines
   - Dependencies: xiltimer
   - Tests GPIO, UART, SPI, I2C, Ethernet

6. **lwip_echo_server** - TCP/UDP echo server
   - Dependencies: lwip220, xiltimer
   - Listens on port 7, echoes received data
   - Default IP: 192.168.1.10

7. **lwip_tcp_perf_client** - TCP uplink performance test
   - Dependencies: lwip220, xiltimer
   - Measures TCP throughput to host server

8. **lwip_tcp_perf_server** - TCP downlink performance test
   - Dependencies: lwip220, xiltimer
   - Measures TCP throughput from host client

9. **lwip_udp_perf_client** - UDP uplink performance test
   - Dependencies: lwip220, xiltimer

10. **lwip_udp_perf_server** - UDP downlink performance test
    - Dependencies: lwip220, xiltimer

11. **srec_bootloader** - SREC image bootloader
    - Loads firmware from SPI flash (BPI)

## RISC-V Specific Details for RTOS Development

### Exception and Interrupt Handling

**Header Files:**

- [xil_exception.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xil_exception.h) - Exception handling API
- [xreg_riscv.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xreg_riscv.h) - Complete RISC-V CSR definitions
- [riscv_interface.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_interface.h) - Low-level RISC-V CSR access
- [riscv_exceptions_g.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_exceptions_g.h) - Exception handler configuration

**RISC-V General Purpose Registers (GPRs):**

| Register | ABI Name | Description | Saver |
|||||
| x0 | zero | Hard-wired zero | N/A |
| x1 | ra | Return address | Caller |
| x2 | sp | Stack pointer | Callee |
| x3 | gp | Global pointer | N/A |
| x4 | tp | Thread pointer | N/A |
| x5-x7 | t0-t2 | Temporaries | Caller |
| x8 | s0/fp | Saved register / Frame pointer | Callee |
| x9 | s1 | Saved register | Callee |
| x10-x11 | a0-a1 | Function arguments / Return values | Caller |
| x12-x17 | a2-a7 | Function arguments | Caller |
| x18-x27 | s2-s11 | Saved registers | Callee |
| x28-x31 | t3-t6 | Temporaries | Caller |

**RISC-V CSRs (Control and Status Registers):**

| CSR Address | Name | Description |
|||||
| 0x300 | mstatus | Machine status register (MIE, MPIE, MPP bits) |
| 0x301 | misa | Machine ISA register |
| 0x302 | medeleg | Machine exception delegation |
| 0x303 | mideleg | Machine interrupt delegation |
| 0x304 | mie | Machine interrupt enable (MEIE, MTIE, MSIE) |
| 0x305 | mtvec | Machine trap-vector base address |
| 0x306 | mcounteren | Machine counter enable |
| 0x340 | mscratch | Machine scratch register |
| 0x341 | mepc | Machine exception program counter |
| 0x342 | mcause | Machine cause register |
| 0x343 | mtval | Machine trap value |
| 0x344 | mip | Machine interrupt pending |
| 0x3A0-0x3AF | pmpcfg0-15 | PMP configuration registers |
| 0x3B0-0x3EF | pmpaddr0-63 | PMP address registers |
| 0xC00 | cycle | Cycle counter (low 32-bits) |
| 0xC01 | time | Timer (low 32-bits) |
| 0xC02 | instret | Instructions retired (low 32-bits) |
| 0xC80 | cycleh | Cycle counter (high 32-bits) |
| 0xC81 | timeh | Timer (high 32-bits) |
| 0xC82 | instreth | Instructions retired (high 32-bits) |
| 0xF11 | mvendorid | Vendor ID |
| 0xF12 | marchid | Architecture ID |
| 0xF13 | mimpid | Implementation ID |
| 0xF14 | mhartid | Hardware thread ID |

**mstatus Register Bit Fields:**

```text
Bit 3:  MIE  - Machine Interrupt Enable (global)
Bit 7:  MPIE - Machine Previous Interrupt Enable
Bit 12-11: MPP - Machine Previous Privilege (00=User, 01=Supervisor, 11=Machine)
```

**mie/mip Register Bit Fields:**

```text
Bit 3:  MSIE/MSIP - Machine Software Interrupt Enable/Pending
Bit 7:  MTIE/MTIP - Machine Timer Interrupt Enable/Pending
Bit 11: MEIE/MEIP - Machine External Interrupt Enable/Pending
```

**Interrupt Types:**

- Machine timer interrupt (MTI)
- Machine external interrupt (MEI) - connected to AXI Interrupt Controller
- Machine software interrupt (MSI)

**Critical for RTOS:**

- Context switch implementation requires saving/restoring all 32 integer registers (x0-x31)
- Stack pointer: `sp` (x2)
- Return address: `ra` (x1)
- Saved registers: `s0-s11` (x8-x9, x18-x27) - must be preserved across function calls
- Temporary registers: `t0-t6` (x5-x7, x28-x31) - caller-saved
- Argument registers: `a0-a7` (x10-x17)
- No floating-point registers (soft-float ABI)

**Exception Codes (mcause - synchronous):**

| Code | Exception |
|||||
| 0 | Instruction address misaligned |
| 1 | Instruction access fault |
| 2 | Illegal instruction |
| 3 | Breakpoint |
| 4 | Load address misaligned |
| 5 | Load access fault |
| 6 | Store/AMO address misaligned |
| 7 | Store/AMO access fault |
| 8 | Environment call from U-mode (ECALL) |
| 9 | Environment call from S-mode (ECALL) |
| 11 | Environment call from M-mode (ECALL) |
| 12 | Instruction page fault |
| 13 | Load page fault |
| 15 | Store/AMO page fault |

**Interrupt Codes (mcause - asynchronous, MSB=1):**

| Code (mcause) | Interrupt |
|||||
| 0x80000003 | Machine software interrupt |
| 0x80000007 | Machine timer interrupt |
| 0x8000000B | Machine external interrupt |

**Trap Handler Implementation (from libsrc/standalone/src/riscv/trap_handler.S):**

The BSP provides a reference trap handler that:

- Saves all 32 GPRs to the stack (128 bytes for RV32)
- Checks `mcause` for the trap type
- Handles misaligned load/store in software
- Calls registered exception/interrupt handlers
- Restores registers and executes `mret`

**Context Size for RTOS:**

- Integer registers: 32 × 4 bytes = 128 bytes
- CSRs to save: mepc, mstatus, mcause = 12 bytes
- Total minimum context: ~140 bytes per task

### Memory Layout for Bare-Metal/RTOS

**Linker Script Location:** Applications must provide linker script

**Typical Memory Sections:**

```text
MEMORY
{
    ram : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
    .text : { *(.text*) } > ram          /* Code section */
    .rodata : { *(.rodata*) } > ram      /* Read-only data */
    .data : { *(.data*) } > ram          /* Initialized data */
    .bss : { *(.bss*) } > ram            /* Uninitialized data */
    _heap_start = .;                     /* Heap starts after BSS */
    _heap_end = ORIGIN(ram) + LENGTH(ram) - 0x2000;  /* Reserve for stack */
    _stack_top = ORIGIN(ram) + LENGTH(ram);           /* Stack at top */
}
```

**Stack Considerations:**

- Stack grows downward from 0x0001FFFF
- Recommended stack size: 8-16 KB per task/thread
- With 128 KB total: ~8 KB for stack, ~120 KB for code/data/heap

### Startup and Boot Sequence

**Startup Files (from libsrc/standalone/src/riscv/):**

| File | Purpose |
|||
| boot.S | Initial boot code, register initialization |
| trap_handler.S | Exception and interrupt handling |
| xil_exception.c | Exception registration API |
| riscv_interrupt_handler.c | Interrupt dispatch logic |
| _sbrk.c | Heap memory allocation support |

**Boot Sequence (boot.S):**

1. **Reset Entry (address 0x00000000):**

   ```asm
   _boot:
       la      t0, _trap_handler    # Load trap handler address
       csrw    mtvec, t0            # Set trap vector
   ```

2. **Register Initialization:**
   - Clear all 32 GPRs (x1-x31) to zero
   - Floating-point registers cleared if FPU enabled (not in this design)

3. **Stack Pointer Setup:**

   ```asm
       .option push
       .option norelax
       la      sp, __stack          # Load stack top address
       .option pop
   ```

4. **Jump to C Runtime:**

   ```asm
       sw      zero, 0(sp)          # argc = 0
       j       _start               # Jump to C startup
   ```

5. **C Runtime (_start):**
   - Initialize `.data` section (copy initialized data)
   - Zero `.bss` section
   - Call global constructors (C++)
   - Call `main()`
   - On return: infinite loop at `.Ldone`

**Key Symbols for RTOS:**

| Symbol | Description |
|||||
| `_boot` | Reset entry point |
| `__stack` | Stack top address (end of RAM) |
| `_trap_handler` | Trap vector entry point |
| `_start` | C runtime entry point |
| `__bss_start` | Start of BSS section |
| `__bss_end` | End of BSS section |
| `_end` | End of program (heap start) |

### Cache Coherency

**Important:** This system has NO caches enabled

- All memory access is coherent by default
- No cache flush/invalidate needed
- Simplifies DMA and peripheral access
- Predictable, deterministic timing
- Lower performance but suitable for RTOS

### Atomic Operations Support

The processor supports RISC-V `A` extension (atomics):

- `lr.w` (load-reserved word)
- `sc.w` (store-conditional word)
- `amoswap.w`, `amoadd.w`, `amoxor.w`, `amoand.w`, `amoor.w`
- `amomin.w`, `amomax.w`, `amominu.w`, `amomaxu.w`

**Use for RTOS:**

- Spinlocks
- Mutexes
- Semaphores
- Lock-free data structures

**Example (pseudo-code for spinlock):**

```c
void spinlock_acquire(atomic_int *lock) {
    int expected = 0;
    while (1) {
        int result = __atomic_compare_exchange_n(lock, &expected, 1,
                                                  0, __ATOMIC_ACQUIRE, __ATOMIC_ACQUIRE);
        if (result) break;
        expected = 0;  // Reset for retry
    }
}

void spinlock_release(atomic_int *lock) {
    __atomic_store_n(lock, 0, __ATOMIC_RELEASE);
}
```

### Platform-Specific Considerations for Rust RTOS

1. **No Standard Rust Target:** RV32IMACB is not a tier-1 or tier-2 Rust target
   - Custom target specification required
   - Target triple: `riscv32imac-unknown-none-elf` (closest standard target)
   - Custom target JSON needed for full ISA support

2. **Soft-Float ABI:** No hardware floating-point
   - Use `ilp32` ABI, not `ilp32f`
   - Avoid `f32`/`f64` in critical paths (software emulation is slow)

3. **Embedded-HAL Integration:**
   - Implement `embedded-hal` traits for peripherals
   - Use memory-mapped I/O (volatile reads/writes)
   - Peripheral base addresses from this document

4. **Interrupt Handling:**
   - Use `riscv-rt` crate as starting point
   - Customize for AXI Interrupt Controller
   - Implement vectored interrupts using IVR register

5. **Memory Safety:**
   - All peripheral access must use `unsafe` blocks
   - Wrap in safe abstractions (Zero-Cost Abstraction principle)
   - Use `volatile_register` crate for MMIO

6. **Timing and Scheduling:**
   - Use RISC-V `rdcycle` instruction for high-resolution timing
   - 75 MHz clock = 13.33 ns per cycle
   - Consider tickless kernel for power efficiency

### Rust Target Specification

Create a custom target JSON file for the exact ISA:

```json
{
  "arch": "riscv32",
  "cpu": "generic-rv32",
  "data-layout": "e-m:e-p:32:32-i64:64-n32-S128",
  "eh-frame-header": false,
  "emit-debug-gdb-scripts": false,
  "executables": true,
  "features": "+m,+a,+c,+zicsr,+zifencei,+zba,+zbb,+zbs,+zbc",
  "is-builtin": false,
  "linker": "rust-lld",
  "linker-flavor": "ld.lld",
  "llvm-target": "riscv32",
  "max-atomic-width": 32,
  "panic-strategy": "abort",
  "relocation-model": "static",
  "target-pointer-width": "32"
}
```

### Rust Peripheral Access Crate Structure

Recommended structure for peripheral access crate (PAC):

```rust
// src/lib.rs
#![no_std]

pub mod uart {
    use volatile_register::{RO, RW, WO};

    #[repr(C)]
    pub struct RegisterBlock {
        pub rx_fifo: RO<u32>,      // 0x00
        pub tx_fifo: WO<u32>,      // 0x04
        pub stat_reg: RO<u32>,     // 0x08
        pub ctrl_reg: WO<u32>,     // 0x0C
    }

    pub const BASE_ADDR: usize = 0x40600000;

    pub mod stat {
        pub const RX_VALID: u32 = 1 << 0;
        pub const RX_FULL: u32 = 1 << 1;
        pub const TX_EMPTY: u32 = 1 << 2;
        pub const TX_FULL: u32 = 1 << 3;
    }

    impl RegisterBlock {
        pub unsafe fn instance() -> &'static mut Self {
            &mut *(BASE_ADDR as *mut Self)
        }

        pub fn write_byte(&mut self, byte: u8) {
            while self.stat_reg.read() & stat::TX_FULL != 0 {}
            unsafe { self.tx_fifo.write(byte as u32); }
        }

        pub fn read_byte(&mut self) -> Option<u8> {
            if self.stat_reg.read() & stat::RX_VALID != 0 {
                Some(self.rx_fifo.read() as u8)
            } else {
                None
            }
        }
    }
}

pub mod gpio {
    use volatile_register::RW;

    #[repr(C)]
    pub struct RegisterBlock {
        pub data: RW<u32>,     // 0x00
        pub tri: RW<u32>,      // 0x04
        pub data2: RW<u32>,    // 0x08
        pub tri2: RW<u32>,     // 0x0C
        _reserved: [u32; 67],  // Gap to 0x11C
        pub gier: RW<u32>,     // 0x11C
        pub isr: RW<u32>,      // 0x120
        _reserved2: u32,       // 0x124
        pub ier: RW<u32>,      // 0x128
    }

    pub const LED_BASE: usize = 0x40040000;
    pub const BUTTONS_BASE: usize = 0x40020000;
    pub const SWITCHES_BASE: usize = 0x40030000;
}

pub mod intc {
    use volatile_register::{RO, RW, WO};

    #[repr(C)]
    pub struct RegisterBlock {
        pub isr: RO<u32>,      // 0x00 - Interrupt Status
        pub ipr: RO<u32>,      // 0x04 - Interrupt Pending
        pub ier: RW<u32>,      // 0x08 - Interrupt Enable
        pub iar: WO<u32>,      // 0x0C - Interrupt Acknowledge
        pub sie: WO<u32>,      // 0x10 - Set Interrupt Enable
        pub cie: WO<u32>,      // 0x14 - Clear Interrupt Enable
        pub ivr: RO<u32>,      // 0x18 - Interrupt Vector
        pub mer: RW<u32>,      // 0x1C - Master Enable
        pub imr: RW<u32>,      // 0x20 - Interrupt Mode
        pub ilr: RW<u32>,      // 0x24 - Interrupt Level
    }

    pub const BASE_ADDR: usize = 0x41200000;

    pub mod mer {
        pub const ME: u32 = 1 << 0;   // Master Enable
        pub const HIE: u32 = 1 << 1;  // Hardware Interrupt Enable
    }

    // IRQ numbers
    pub const IRQ_ETHERNET: u32 = 0;
    pub const IRQ_WDT: u32 = 1;
    pub const IRQ_UART: u32 = 2;
    pub const IRQ_SPI_FLASH: u32 = 3;
    pub const IRQ_GPIO_SHIELD0: u32 = 4;
    pub const IRQ_GPIO_SHIELD1: u32 = 5;
    pub const IRQ_GPIO_BUTTONS: u32 = 6;
    pub const IRQ_GPIO_SWITCHES: u32 = 7;
    pub const IRQ_I2C: u32 = 8;
    pub const IRQ_SPI: u32 = 9;
    pub const IRQ_WDT2: u32 = 10;
}
```

### Rust RTOS Context Switch Example

```rust
// Context structure for task switching
#[repr(C)]
pub struct TaskContext {
    pub ra: u32,       // x1 - Return address
    pub sp: u32,       // x2 - Stack pointer
    pub gp: u32,       // x3 - Global pointer
    pub tp: u32,       // x4 - Thread pointer
    pub t0: u32,       // x5
    pub t1: u32,       // x6
    pub t2: u32,       // x7
    pub s0: u32,       // x8 - Frame pointer
    pub s1: u32,       // x9
    pub a0: u32,       // x10
    pub a1: u32,       // x11
    pub a2: u32,       // x12
    pub a3: u32,       // x13
    pub a4: u32,       // x14
    pub a5: u32,       // x15
    pub a6: u32,       // x16
    pub a7: u32,       // x17
    pub s2: u32,       // x18
    pub s3: u32,       // x19
    pub s4: u32,       // x20
    pub s5: u32,       // x21
    pub s6: u32,       // x22
    pub s7: u32,       // x23
    pub s8: u32,       // x24
    pub s9: u32,       // x25
    pub s10: u32,      // x26
    pub s11: u32,      // x27
    pub t3: u32,       // x28
    pub t4: u32,       // x29
    pub t5: u32,       // x30
    pub t6: u32,       // x31
    pub mepc: u32,     // Exception program counter
    pub mstatus: u32,  // Machine status
}

// Inline assembly for CSR access
#[inline(always)]
pub unsafe fn read_mstatus() -> u32 {
    let value: u32;
    core::arch::asm!("csrr {}, mstatus", out(reg) value);
    value
}

#[inline(always)]
pub unsafe fn write_mtvec(addr: u32) {
    core::arch::asm!("csrw mtvec, {}", in(reg) addr);
}

#[inline(always)]
pub unsafe fn enable_interrupts() {
    core::arch::asm!("csrsi mstatus, 0x8"); // Set MIE bit
}

#[inline(always)]
pub unsafe fn disable_interrupts() -> u32 {
    let prev: u32;
    core::arch::asm!("csrrci {}, mstatus, 0x8", out(reg) prev);
    prev
}

// High-resolution timing using cycle counter
#[inline(always)]
pub fn read_cycle() -> u64 {
    let lo: u32;
    let hi: u32;
    unsafe {
        core::arch::asm!("csrr {}, cycle", out(reg) lo);
        core::arch::asm!("csrr {}, cycleh", out(reg) hi);
    }
    ((hi as u64) << 32) | (lo as u64)
}

// Convert cycles to microseconds at 75 MHz
pub fn cycles_to_us(cycles: u64) -> u64 {
    cycles / 75  // 75 cycles per microsecond
}
```

### Cargo.toml for Rust RTOS

```toml
[package]
name = "rustos"
version = "0.1.0"
edition = "2021"

[dependencies]
riscv = "0.11"
riscv-rt = "0.12"
volatile-register = "0.2"
critical-section = "1.1"
heapless = "0.8"

[profile.release]
opt-level = "s"        # Optimize for size
lto = true             # Link-time optimization
codegen-units = 1      # Better optimization
panic = "abort"        # No unwinding

[profile.dev]
opt-level = 1          # Some optimization for dev
panic = "abort"
```

### Linker Script for 128KB BRAM

```ld
/* memory.x - Linker script for RustOS on MicroBlaze V */
MEMORY
{
    RAM : ORIGIN = 0x00000000, LENGTH = 128K
}

REGION_ALIAS("REGION_TEXT", RAM);
REGION_ALIAS("REGION_RODATA", RAM);
REGION_ALIAS("REGION_DATA", RAM);
REGION_ALIAS("REGION_BSS", RAM);
REGION_ALIAS("REGION_HEAP", RAM);
REGION_ALIAS("REGION_STACK", RAM);

/* Stack size per task - adjust based on requirements */
_stack_size = 8K;

/* Heap size for dynamic allocation */
_heap_size = 16K;

SECTIONS
{
    /* Vector table at start of memory */
    .vectors : ALIGN(4)
    {
        KEEP(*(.vectors))
    } > RAM

    /* Code section */
    .text : ALIGN(4)
    {
        *(.text .text.*)
    } > RAM

    /* Read-only data */
    .rodata : ALIGN(4)
    {
        *(.rodata .rodata.*)
    } > RAM

    /* Initialized data */
    .data : ALIGN(4)
    {
        __sdata = .;
        *(.data .data.*)
        __edata = .;
    } > RAM

    /* Uninitialized data */
    .bss (NOLOAD) : ALIGN(4)
    {
        __sbss = .;
        *(.bss .bss.*)
        *(COMMON)
        __ebss = .;
    } > RAM

    /* Heap */
    .heap (NOLOAD) : ALIGN(8)
    {
        __sheap = .;
        . += _heap_size;
        __eheap = .;
    } > RAM

    /* Stack (grows downward) */
    .stack (NOLOAD) : ALIGN(16)
    {
        . += _stack_size;
        __stack = .;
    } > RAM

    /* Ensure we don't exceed memory */
    ASSERT(. <= ORIGIN(RAM) + LENGTH(RAM), "Memory overflow!")
}

/* Entry point */
ENTRY(_start)
```

### Processor Architecture

The platform is built for the **rv32imacb_zicsr_zifencei_zbc** RISC-V ISA:

- 32-bit RISC-V with integer, multiply, atomic, bit manipulation, and compressed instructions
- CSR support (Zicsr) and instruction fence (Zifencei)
- Bit manipulation (Zba+Zbb+Zbs) with carry-less multiply (Zbc)
- Soft-float ABI (ilp32) - no hardware FPU
- 75 MHz clock, 128 KB unified BRAM, no caches
- SV32 MMU support (not enabled by default in bare-metal)
- 8 hardware breakpoints, 4 read watchpoints, 4 write watchpoints

**Complete ISA Details:** See hardware README at [../hardware/README.md](../hardware/README.md)

## Quick Reference Tables

### Peripheral Base Addresses

| Peripheral | Base Address | Size | IRQ |
|||||
| BRAM (Memory) | 0x00000000 | 128 KB | - |
| GPIO Shield 0-19 | 0x40000000 | 64 KB | 4 |
| GPIO Shield 26-41 | 0x40010000 | 64 KB | 5 |
| GPIO Push Buttons | 0x40020000 | 64 KB | 6 |
| GPIO DIP Switches | 0x40030000 | 64 KB | 7 |
| GPIO LEDs (4-bit) | 0x40040000 | 64 KB | - |
| GPIO RGB LEDs | 0x40050000 | 64 KB | - |
| GPIO I2C Pullups | 0x40060000 | 64 KB | - |
| UART Lite | 0x40600000 | 64 KB | 2 |
| I2C (IIC) | 0x40800000 | 64 KB | 8 |
| Ethernet Lite | 0x40E00000 | 64 KB | 0 |
| Interrupt Controller | 0x41200000 | 64 KB | - |
| Watchdog Timer | 0x41A00000 | 64 KB | 1,10 |
| SPI Flash | 0x44A00000 | 64 KB | 3 |
| SPI (External) | 0x44A10000 | 64 KB | 9 |

### System Parameters

| Parameter | Value |
|||
| CPU Clock | 75 MHz |
| AXI Clock | 75 MHz |
| Memory Size | 128 KB |
| Stack Size (recommended) | 8 KB |
| ISA | RV32IMACB_Zicsr_Zifencei_Zbc |
| ABI | ilp32 (soft-float) |
| Number of IRQs | 11 (0-10) |
| Endianness | Little-endian |
| MMU | SV32 (available, not enabled) |
| Caches | None |
| FPU | None (software emulation) |

### GPIO Pin Widths

| Instance | Width | Direction | Interrupt |
|||||
| Shield Pins 0-19 | 20 bits | Bidirectional | Yes |
| Shield Pins 26-41 | 16 bits | Bidirectional | Yes |
| Push Buttons | 4 bits | Input only | Yes |
| DIP Switches | 4 bits | Input only | Yes |
| LEDs (4-bit) | 4 bits | Output only | No |
| RGB LEDs | 12 bits | Output only | No |
| I2C Pullups | 2 bits | Output only | No |

### Timing Reference

| Operation | Cycles | Time @ 75 MHz |
|||||
| 1 microsecond | 75 | 1 µs |
| 1 millisecond | 75,000 | 1 ms |
| 1 second | 75,000,000 | 1 s |
| UART byte @ 115200 | ~651 | ~8.68 µs |
| I2C byte @ 100 kHz | ~750 | ~10 µs |

### Driver Versions

| Driver | Version | Header File |
|||||
| GPIO | v4.12 | xgpio.h |
| UART Lite | v3.12 | xuartlite.h |
| I2C (IIC) | v3.14 | xiic.h |
| SPI | v4.15 | xspi.h |
| Ethernet Lite | v4.12 | xemaclite.h |
| Interrupt Controller | v3.21 | xintc.h |
| Watchdog | v5.11 | xwdttb.h |
| BRAM | v4.13 | xbram.h |
| Timer | v2.3 | xiltimer.h |
| Standalone OS | v9.4 | xil_*.h |

## Usage

### Importing the Platform (Vitis IDE)

1. Open Vitis 2025.2
2. From the menu: **File → Import → Vitis Platform**
3. Select the exported platform directory: [export/bsp/](./export/bsp/)
4. The platform will be added to your workspace

### Creating an Application (Vitis IDE)

1. Create a new application project: **File → New → Application Project**
2. Select the `bsp` platform
3. Choose the `standalone_mbv_microblaze_v` domain
4. Select an application template (e.g., "Hello World")
5. Build and debug/run your application on the RISC-V processor

### Platform Configuration

The platform is pre-configured with:

- **Local Memory**: 128 KB BRAM @ 0x00000000
- **Clock Frequency**: 75 MHz (via Clocking Wizard)
- **Debug**: Enabled (via MDM) - JTAG debugging support
- **Interrupts**: AXI Interrupt Controller @ 0x41200000 (11 IRQs)
- **Peripheral Access**: Via AXI4-Lite SmartConnect

## Direct Hardware Access (Bare-Metal/RTOS Development)

For RTOS development without using Xilinx BSP drivers:

### Peripheral Register Maps

All register offsets are from the peripheral base address.

#### AXI UART Lite Registers (0x40600000)

| Offset | Register | Access | Description |
|||||
| 0x00 | RX_FIFO | R | Receive FIFO (8-bit data in bits 0-7) |
| 0x04 | TX_FIFO | W | Transmit FIFO (8-bit data in bits 0-7) |
| 0x08 | STAT_REG | R | Status register |
| 0x0C | CTRL_REG | W | Control register |

**Status Register Bits:**

```text
Bit 0: RX_FIFO_VALID_DATA - Data available in RX FIFO
Bit 1: RX_FIFO_FULL      - RX FIFO full
Bit 2: TX_FIFO_EMPTY     - TX FIFO empty
Bit 3: TX_FIFO_FULL      - TX FIFO full
Bit 4: INTR_ENABLED      - Interrupt enabled
Bit 5: OVERRUN_ERROR     - RX overrun error
Bit 6: FRAMING_ERROR     - Framing error
Bit 7: PARITY_ERROR      - Parity error
```

**Control Register Bits:**

```text
Bit 0: RST_TX_FIFO  - Reset TX FIFO
Bit 1: RST_RX_FIFO  - Reset RX FIFO
Bit 4: ENABLE_INTR  - Enable interrupt
```

**UART Configuration (fixed in hardware):**

- Baud Rate: 115200
- Data Bits: 8
- Parity: None
- Stop Bits: 1
- FIFO Size: 16 bytes

#### AXI GPIO Registers (multiple instances)

| Offset | Register | Access | Description |
|||||
| 0x000 | GPIO_DATA | R/W | Channel 1 data register |
| 0x004 | GPIO_TRI | R/W | Channel 1 tri-state (1=input, 0=output) |
| 0x008 | GPIO2_DATA | R/W | Channel 2 data register (if dual-channel) |
| 0x00C | GPIO2_TRI | R/W | Channel 2 tri-state |
| 0x11C | GIER | R/W | Global interrupt enable register |
| 0x120 | IP_ISR | R/TOW | IP interrupt status register |
| 0x128 | IP_IER | R/W | IP interrupt enable register |

**GIER Bit:**

```text
Bit 31: GIE - Global Interrupt Enable
```

**IP_ISR/IP_IER Bits:**

```text
Bit 0: Channel 1 interrupt
Bit 1: Channel 2 interrupt
```

#### AXI Interrupt Controller Registers (0x41200000)

| Offset | Register | Access | Description |
|||||
| 0x00 | ISR | R | Interrupt Status Register |
| 0x04 | IPR | R | Interrupt Pending Register |
| 0x08 | IER | R/W | Interrupt Enable Register |
| 0x0C | IAR | W | Interrupt Acknowledge Register |
| 0x10 | SIE | W | Set Interrupt Enable bits |
| 0x14 | CIE | W | Clear Interrupt Enable bits |
| 0x18 | IVR | R | Interrupt Vector Register |
| 0x1C | MER | R/W | Master Enable Register |
| 0x20 | IMR | R/W | Interrupt Mode Register (Fast mode) |
| 0x24 | ILR | R/W | Interrupt Level Register |
| 0x100+ | IVAR[n] | R/W | Interrupt Vector Address Register n |

**MER Bits:**

```text
Bit 0: ME  - Master IRQ Enable
Bit 1: HIE - Hardware Interrupt Enable (once set, cannot clear)
```

**Kind of IRQ (from xparameters.h: 0x30C):**

```text
Bit set = Level-sensitive, Bit clear = Edge-sensitive
IRQ 2,3,8,9 = Level (UART, SPI, I2C)
IRQ 0,1,4,5,6,7,10 = Edge (Ethernet, WDT, GPIOs)
```

#### AXI IIC (I2C) Registers (0x40800000)

| Offset | Register | Access | Description |
|||||
| 0x00 | GIE | R/W | Global interrupt enable |
| 0x08 | ISR | R/TOW | Interrupt status register |
| 0x0C | IER | R/W | Interrupt enable register |
| 0x1C | SOFTR | W | Soft reset register |
| 0x100 | CR | R/W | Control register |
| 0x104 | SR | R | Status register |
| 0x108 | TX_FIFO | W | Transmit FIFO |
| 0x10C | RX_FIFO | R | Receive FIFO |
| 0x110 | ADR | R/W | Slave address register |
| 0x114 | TX_FIFO_OCY | R | TX FIFO occupancy |
| 0x118 | RX_FIFO_OCY | R | RX FIFO occupancy |
| 0x11C | TEN_ADR | R/W | Slave 10-bit address |
| 0x120 | RX_FIFO_PIRQ | R/W | RX FIFO programmable depth interrupt |
| 0x124 | GPO | R/W | General purpose output |

**I2C Configuration:**

- Clock: 100 kHz (Standard mode)
- 7-bit addressing

#### AXI Quad SPI Registers (0x44A00000, 0x44A10000)

| Offset | Register | Access | Description |
|||||
| 0x1C | DGIER | R/W | Global interrupt enable |
| 0x20 | IPISR | R/TOW | IP interrupt status |
| 0x28 | IPIER | R/W | IP interrupt enable |
| 0x40 | SRR | W | Software reset register (write 0x0A) |
| 0x60 | SPICR | R/W | SPI control register |
| 0x64 | SPISR | R | SPI status register |
| 0x68 | SPI_DTR | W | SPI data transmit register |
| 0x6C | SPI_DRR | R | SPI data receive register |
| 0x70 | SPISSR | R/W | SPI slave select register |
| 0x74 | TX_FIFO_OCY | R | TX FIFO occupancy |
| 0x78 | RX_FIFO_OCY | R | RX FIFO occupancy |

**SPI Control Register Bits:**

```text
Bit 0: LOOP      - Local loopback mode
Bit 1: SPE       - SPI system enable
Bit 2: MASTER    - Master mode select
Bit 3: CPOL      - Clock polarity
Bit 4: CPHA      - Clock phase
Bit 5: TX_FIFO_RESET - Reset TX FIFO
Bit 6: RX_FIFO_RESET - Reset RX FIFO
Bit 7: MANUAL_SS - Manual slave select
Bit 8: TRANS_INHIBIT - Master transaction inhibit
Bit 9: LSB_FIRST - LSB first transfer format
```

#### AXI Ethernet Lite Registers (0x40E00000)

| Offset | Register | Description |
|||||
| 0x000-0x7FC | TX_BUFFER0 | TX Buffer 0 (2KB) |
| 0x800-0xFFC | TX_BUFFER1 | TX Buffer 1 (2KB, ping-pong) |
| 0x1000-0x17FC | RX_BUFFER0 | RX Buffer 0 (2KB) |
| 0x1800-0x1FFC | RX_BUFFER1 | RX Buffer 1 (2KB, ping-pong) |
| 0x07F4 | TX_LEN0 | TX Length Register 0 |
| 0x07F8 | TX_GIE | Global Interrupt Enable |
| 0x07FC | TX_CTRL0 | TX Control Register 0 |
| 0x0FF4 | TX_LEN1 | TX Length Register 1 |
| 0x0FFC | TX_CTRL1 | TX Control Register 1 |
| 0x17FC | RX_CTRL0 | RX Control Register 0 |
| 0x1FFC | RX_CTRL1 | RX Control Register 1 |
| 0x07E4 | MDIO_ADDR | MDIO Address Register |
| 0x07E8 | MDIO_WR | MDIO Write Data Register |
| 0x07EC | MDIO_RD | MDIO Read Data Register |
| 0x07F0 | MDIO_CTRL | MDIO Control Register |

**TX/RX Control Bits:**

```text
Bit 0: STATUS/IE - TX done / RX data valid, and interrupt enable
Bit 3: PROGRAM - Program MAC address (TX only)
Bit 4: LOOPBACK - Internal loopback (TX only)
```

#### AXI Timebase WDT Registers (0x41A00000)

| Offset | Register | Access | Description |
|||||
| 0x00 | TWCSR0 | R/W | Control/Status Register 0 |
| 0x04 | TWCSR1 | R/W | Control/Status Register 1 |
| 0x08 | TBR | R | Timebase Register |
| 0x0C | FCR | R/W | Function Control Register (Window WDT) |
| 0x10 | FWR | R/W | First Window Configuration |
| 0x14 | SWR | R/W | Second Window Configuration |

**TWCSR0 Bits:**

```text
Bit 0: WDS  - WDT interrupt status
Bit 1: WRS  - WDT reset status
Bit 3: ENW  - Enable Window WDT (once set, cannot clear)
Bit 4: ENW2 - Enable Window WDT
```

---

## Extended Peripheral Documentation

This section provides extended documentation for complex peripherals that require additional programming guidance for RTOS development.

### SPI Flash Memory Access

The AXI Quad SPI controller supports external SPI flash memory access. This section documents common flash command sequences for non-volatile storage.

#### SPI Flash Command Reference

| Command | Opcode | Address Bytes | Data | Description |
|||||
| READ | 0x03 | 3 | 1+ | Read data (up to 25 MHz) |
| FAST_READ | 0x0B | 3 + dummy | 1+ | Fast read (up to 50 MHz) |
| RDID | 0x9F | 0 | 3 | Read JEDEC ID |
| RDSR | 0x05 | 0 | 1+ | Read status register |
| WRSR | 0x01 | 0 | 1 | Write status register |
| WREN | 0x06 | 0 | 0 | Write enable |
| WRDI | 0x04 | 0 | 0 | Write disable |
| PP | 0x02 | 3 | 1-256 | Page program (256 bytes max) |
| SE | 0x20 | 3 | 0 | Sector erase (4 KB) |
| BE | 0xD8 | 3 | 0 | Block erase (64 KB) |
| CE | 0xC7 | 0 | 0 | Chip erase |

#### SPI Control Register Configuration

```c
// SPI Master mode, manual slave select, CPOL=0, CPHA=0
#define SPI_CR_INIT  (XSP_CR_ENABLE_MASK | XSP_CR_MASTER_MODE_MASK | \
                      XSP_CR_MANUAL_SS_MASK | XSP_CR_TRANS_INHIBIT_MASK)

// SPI Status Register Masks
#define SPI_SR_RX_EMPTY   0x01  // RX FIFO empty
#define SPI_SR_RX_FULL    0x02  // RX FIFO full
#define SPI_SR_TX_EMPTY   0x04  // TX FIFO empty
#define SPI_SR_TX_FULL    0x08  // TX FIFO full
#define SPI_SR_MODF       0x10  // Mode fault error
```

#### SPI Flash Programming Sequence (Rust Example)

```rust
/// SPI Flash driver for RTOS
pub struct SpiFlash {
    base: usize,
}

impl SpiFlash {
    const SPI_CR: usize = 0x60;
    const SPI_SR: usize = 0x64;
    const SPI_DTR: usize = 0x68;
    const SPI_DRR: usize = 0x6C;
    const SPI_SSR: usize = 0x70;

    pub fn new(base: usize) -> Self {
        Self { base }
    }

    /// Initialize SPI controller for flash access
    pub fn init(&self) {
        unsafe {
            // Reset FIFOs
            let cr = self.base + Self::SPI_CR;
            core::ptr::write_volatile(cr as *mut u32, 0x1E6);  // Reset + init
            core::ptr::write_volatile(cr as *mut u32, 0x186);  // Master, manual SS
        }
    }

    /// Read JEDEC ID (manufacturer + device ID)
    pub fn read_jedec_id(&self) -> (u8, u16) {
        let mut id = [0u8; 3];
        self.select_slave();
        self.transfer(0x9F);  // RDID command
        id[0] = self.transfer(0xFF);
        id[1] = self.transfer(0xFF);
        id[2] = self.transfer(0xFF);
        self.deselect_slave();
        (id[0], ((id[1] as u16) << 8) | id[2] as u16)
    }

    /// Wait for flash write/erase completion
    pub fn wait_ready(&self) {
        loop {
            self.select_slave();
            self.transfer(0x05);  // RDSR command
            let status = self.transfer(0xFF);
            self.deselect_slave();
            if (status & 0x01) == 0 {  // WIP bit clear
                break;
            }
        }
    }

    /// Erase 4KB sector at address
    pub fn sector_erase(&self, addr: u32) {
        self.write_enable();
        self.select_slave();
        self.transfer(0x20);  // Sector erase
        self.transfer((addr >> 16) as u8);
        self.transfer((addr >> 8) as u8);
        self.transfer(addr as u8);
        self.deselect_slave();
        self.wait_ready();
    }

    fn transfer(&self, data: u8) -> u8 {
        unsafe {
            let dtr = (self.base + Self::SPI_DTR) as *mut u32;
            let drr = (self.base + Self::SPI_DRR) as *const u32;
            let sr = (self.base + Self::SPI_SR) as *const u32;

            core::ptr::write_volatile(dtr, data as u32);

            // Wait for TX empty and RX not empty
            while (core::ptr::read_volatile(sr) & 0x04) == 0 {}
            while (core::ptr::read_volatile(sr) & 0x01) != 0 {}

            core::ptr::read_volatile(drr) as u8
        }
    }

    fn select_slave(&self) {
        unsafe {
            let ssr = (self.base + Self::SPI_SSR) as *mut u32;
            core::ptr::write_volatile(ssr, 0xFFFFFFFE);  // Assert SS0
        }
    }

    fn deselect_slave(&self) {
        unsafe {
            let ssr = (self.base + Self::SPI_SSR) as *mut u32;
            core::ptr::write_volatile(ssr, 0xFFFFFFFF);  // Deassert all
        }
    }

    fn write_enable(&self) {
        self.select_slave();
        self.transfer(0x06);  // WREN command
        self.deselect_slave();
    }
}
```

### Ethernet MDIO/PHY Configuration

The Ethernet Lite controller includes an MDIO (Management Data Input/Output) interface for configuring and monitoring the external PHY.

#### MDIO Register Map

| Offset | Register | Description |
|||||
| 0x07E4 | MDIO_ADDR | PHY address (bits 4:0) + Register address (bits 9:5) |
| 0x07E8 | MDIO_WR | Write data (bits 15:0) |
| 0x07EC | MDIO_RD | Read data (bits 15:0) |
| 0x07F0 | MDIO_CTRL | Control/Status (bit 0: enable, bit 3: ready) |

#### Standard PHY Registers (IEEE 802.3)

| Reg | Name | Description |
|||||
| 0 | BMCR | Basic Mode Control Register |
| 1 | BMSR | Basic Mode Status Register |
| 2 | PHYID1 | PHY Identifier 1 |
| 3 | PHYID2 | PHY Identifier 2 |
| 4 | ANAR | Auto-Negotiation Advertisement Register |
| 5 | ANLPAR | Auto-Negotiation Link Partner Ability |
| 6 | ANER | Auto-Negotiation Expansion Register |

#### BMCR (Register 0) Bit Definitions

```text
Bit 15: Reset (self-clearing)
Bit 14: Loopback
Bit 13: Speed Select (1=100Mbps, 0=10Mbps)
Bit 12: Auto-Negotiation Enable
Bit 11: Power Down
Bit 10: Isolate
Bit 9:  Restart Auto-Negotiation
Bit 8:  Duplex Mode (1=Full, 0=Half)
Bit 7:  Collision Test
```

#### BMSR (Register 1) Bit Definitions

```text
Bit 5: Auto-Negotiation Complete
Bit 4: Remote Fault
Bit 3: Auto-Negotiation Ability
Bit 2: Link Status (1=Up, 0=Down)
Bit 1: Jabber Detect
Bit 0: Extended Capability
```

#### MDIO Access Sequence (Rust Example)

```rust
/// Ethernet PHY MDIO interface
pub struct EthernetMdio {
    base: usize,
}

impl EthernetMdio {
    const MDIO_ADDR: usize = 0x07E4;
    const MDIO_WR: usize = 0x07E8;
    const MDIO_RD: usize = 0x07EC;
    const MDIO_CTRL: usize = 0x07F0;

    const PHY_BMCR: u8 = 0;
    const PHY_BMSR: u8 = 1;
    const PHY_PHYID1: u8 = 2;
    const PHY_PHYID2: u8 = 3;

    pub fn new(base: usize) -> Self {
        Self { base }
    }

    /// Read PHY register via MDIO
    pub fn read_phy(&self, phy_addr: u8, reg_addr: u8) -> u16 {
        unsafe {
            let addr = (self.base + Self::MDIO_ADDR) as *mut u32;
            let ctrl = (self.base + Self::MDIO_CTRL) as *mut u32;
            let rd = (self.base + Self::MDIO_RD) as *const u32;

            // Set address: PHY addr in bits 4:0, Reg addr in bits 9:5
            let addr_val = ((reg_addr as u32) << 5) | (phy_addr as u32);
            core::ptr::write_volatile(addr, addr_val);

            // Enable MDIO and initiate read
            core::ptr::write_volatile(ctrl, 0x09);  // Enable + Read

            // Wait for ready
            while (core::ptr::read_volatile(ctrl) & 0x08) == 0 {}

            core::ptr::read_volatile(rd) as u16
        }
    }

    /// Write PHY register via MDIO
    pub fn write_phy(&self, phy_addr: u8, reg_addr: u8, data: u16) {
        unsafe {
            let addr = (self.base + Self::MDIO_ADDR) as *mut u32;
            let ctrl = (self.base + Self::MDIO_CTRL) as *mut u32;
            let wr = (self.base + Self::MDIO_WR) as *mut u32;

            // Set address
            let addr_val = ((reg_addr as u32) << 5) | (phy_addr as u32);
            core::ptr::write_volatile(addr, addr_val);

            // Write data
            core::ptr::write_volatile(wr, data as u32);

            // Enable MDIO and initiate write
            core::ptr::write_volatile(ctrl, 0x01);  // Enable + Write

            // Wait for ready
            while (core::ptr::read_volatile(ctrl) & 0x08) == 0 {}
        }
    }

    /// Check if Ethernet link is up
    pub fn is_link_up(&self, phy_addr: u8) -> bool {
        let bmsr = self.read_phy(phy_addr, Self::PHY_BMSR);
        (bmsr & 0x04) != 0  // Link Status bit
    }

    /// Get PHY identifier
    pub fn get_phy_id(&self, phy_addr: u8) -> u32 {
        let id1 = self.read_phy(phy_addr, Self::PHY_PHYID1) as u32;
        let id2 = self.read_phy(phy_addr, Self::PHY_PHYID2) as u32;
        (id1 << 16) | id2
    }

    /// Reset PHY and wait for completion
    pub fn reset_phy(&self, phy_addr: u8) {
        // Set reset bit
        self.write_phy(phy_addr, Self::PHY_BMCR, 0x8000);

        // Wait for reset to complete (bit self-clears)
        loop {
            let bmcr = self.read_phy(phy_addr, Self::PHY_BMCR);
            if (bmcr & 0x8000) == 0 {
                break;
            }
        }
    }

    /// Configure for auto-negotiation
    pub fn enable_autoneg(&self, phy_addr: u8) {
        // Enable auto-negotiation and restart
        self.write_phy(phy_addr, Self::PHY_BMCR, 0x1200);
    }
}
```

### Extended I2C Protocol Documentation

The AXI IIC controller supports both standard (100 kHz) and fast (400 kHz) I2C modes.

#### I2C Control Register (CR) Bit Definitions

```text
Bit 0: EN - Enable device
Bit 1: TX_FIFO_RESET - Reset transmit FIFO
Bit 2: MSMS - Master/Slave mode select (1=Master starts transmit)
Bit 3: TX - Transmit/Receive mode (1=Transmit, 0=Receive)
Bit 4: TXAK - Transmit acknowledge enable (1=No ACK)
Bit 5: RSTA - Repeated start
Bit 6: GC_EN - General call enable
```

#### I2C Status Register (SR) Bit Definitions

```text
Bit 0: ABGC - Addressed by a general call
Bit 1: AAS - Addressed as slave
Bit 2: BB - Bus busy
Bit 3: SRW - Slave read/write
Bit 4: TX_FIFO_FULL - Transmit FIFO full
Bit 5: RX_FIFO_FULL - Receive FIFO full
Bit 6: RX_FIFO_EMPTY - Receive FIFO empty
Bit 7: TX_FIFO_EMPTY - Transmit FIFO empty
```

#### I2C Interrupt Bits (ISR/IER)

```text
Bit 0: ARB_LOST - Arbitration lost
Bit 1: TX_ERROR - Transmit error (NACK received)
Bit 2: TX_EMPTY - Transmit FIFO empty
Bit 3: RX_FULL - Receive FIFO at programmed level
Bit 4: BNB - Bus not busy
Bit 5: AAS - Addressed as slave
Bit 6: NAAS - Not addressed as slave
Bit 7: TX_HALF_EMPTY - TX FIFO half empty
```

#### I2C Transaction Example (Rust)

```rust
/// I2C Master driver
pub struct I2cMaster {
    base: usize,
}

impl I2cMaster {
    const CR: usize = 0x100;
    const SR: usize = 0x104;
    const TX_FIFO: usize = 0x108;
    const RX_FIFO: usize = 0x10C;
    const ISR: usize = 0x020;

    const CR_EN: u32 = 0x01;
    const CR_TX_FIFO_RESET: u32 = 0x02;
    const CR_MSMS: u32 = 0x04;
    const CR_TX: u32 = 0x08;
    const CR_TXAK: u32 = 0x10;
    const CR_RSTA: u32 = 0x20;

    const SR_BB: u32 = 0x04;
    const SR_TX_FIFO_EMPTY: u32 = 0x80;
    const SR_RX_FIFO_EMPTY: u32 = 0x40;

    const TX_START: u32 = 0x100;  // Generate START
    const TX_STOP: u32 = 0x200;   // Generate STOP

    pub fn new(base: usize) -> Self {
        Self { base }
    }

    /// Initialize I2C controller
    pub fn init(&self) {
        unsafe {
            let cr = (self.base + Self::CR) as *mut u32;
            // Reset TX FIFO and enable device
            core::ptr::write_volatile(cr, Self::CR_TX_FIFO_RESET);
            core::ptr::write_volatile(cr, Self::CR_EN);
        }
    }

    /// Write bytes to I2C slave
    pub fn write(&self, addr: u8, data: &[u8]) -> Result<(), I2cError> {
        self.wait_bus_free()?;

        unsafe {
            let tx = (self.base + Self::TX_FIFO) as *mut u32;
            let cr = (self.base + Self::CR) as *mut u32;

            // Send address with START condition
            core::ptr::write_volatile(tx, Self::TX_START | ((addr << 1) as u32));

            // Set master transmit mode
            core::ptr::write_volatile(cr, Self::CR_EN | Self::CR_MSMS | Self::CR_TX);

            // Send data bytes
            for (i, &byte) in data.iter().enumerate() {
                let is_last = i == data.len() - 1;
                if is_last {
                    core::ptr::write_volatile(tx, Self::TX_STOP | (byte as u32));
                } else {
                    core::ptr::write_volatile(tx, byte as u32);
                }
            }
        }

        self.wait_tx_complete()?;
        Ok(())
    }

    /// Read bytes from I2C slave
    pub fn read(&self, addr: u8, buffer: &mut [u8]) -> Result<(), I2cError> {
        self.wait_bus_free()?;

        unsafe {
            let tx = (self.base + Self::TX_FIFO) as *mut u32;
            let rx = (self.base + Self::RX_FIFO) as *const u32;
            let cr = (self.base + Self::CR) as *mut u32;
            let sr = (self.base + Self::SR) as *const u32;

            // Send address with START condition (read mode)
            core::ptr::write_volatile(tx, Self::TX_START | (((addr << 1) | 1) as u32));

            // Send byte count
            core::ptr::write_volatile(tx, (buffer.len() as u32) | Self::TX_STOP);

            // Set master receive mode
            core::ptr::write_volatile(cr, Self::CR_EN | Self::CR_MSMS);

            // Read data
            for byte in buffer.iter_mut() {
                while (core::ptr::read_volatile(sr) & Self::SR_RX_FIFO_EMPTY) != 0 {}
                *byte = core::ptr::read_volatile(rx) as u8;
            }
        }

        Ok(())
    }

    fn wait_bus_free(&self) -> Result<(), I2cError> {
        unsafe {
            let sr = (self.base + Self::SR) as *const u32;
            let mut timeout = 100000u32;
            while (core::ptr::read_volatile(sr) & Self::SR_BB) != 0 {
                timeout -= 1;
                if timeout == 0 {
                    return Err(I2cError::BusBusy);
                }
            }
        }
        Ok(())
    }

    fn wait_tx_complete(&self) -> Result<(), I2cError> {
        unsafe {
            let sr = (self.base + Self::SR) as *const u32;
            let mut timeout = 100000u32;
            while (core::ptr::read_volatile(sr) & Self::SR_TX_FIFO_EMPTY) == 0 {
                timeout -= 1;
                if timeout == 0 {
                    return Err(I2cError::Timeout);
                }
            }
        }
        Ok(())
    }
}

#[derive(Debug)]
pub enum I2cError {
    BusBusy,
    Timeout,
    Nack,
}
```

### Extended Watchdog Timer Documentation

The AXI Timebase WDT supports both standard and "window" watchdog modes for enhanced safety.

#### Window WDT Concept

Window WDT requires the watchdog to be refreshed within a specific time window - not too early and not too late. This provides protection against:

- Runaway code that refreshes too frequently
- Stuck code that doesn't refresh at all

```text
┌─────────────────────────────────────────────────────────────┐
│                    Window WDT Timeline                       │
├─────────────────────────────────────────────────────────────┤
│  [First Window - Closed]  │  [Second Window - Open]  │Reset │
│   Refresh NOT allowed     │   Refresh allowed here   │      │
│◄─────────────────────────►│◄───────────────────────►│      │
│       FWR value           │       SWR value          │      │
└─────────────────────────────────────────────────────────────┘
```

#### Window WDT Registers

| Offset | Register | Description |
||||
| 0x0C | FCR | Function Control Register |
| 0x10 | FWR | First Window Register (closed window count) |
| 0x14 | SWR | Second Window Register (open window count) |
| 0x1C | TFR | Token Feedback Register |
| 0x20 | TRR | Token Response Register |

#### FCR (Function Control Register) Bits

```text
Bit 0: WDP - Window WDT Disable Protection
Bit 1: WM - Window WDT Mode enable
Bit 2: FCE - Fail Counter Enable
Bit 3: PSME - Program Sequence Monitor Enable
Bit 4: SSTE - Second Sequence Timer Enable
Bits 7:6: BSS - Byte Segment Selection
Bits 15:8: SBC - Selected Byte Count
```

#### Generic WDT Control Bits

```text
GWCSR (0x00):
  Bit 0: GWEN - Watchdog enable
  Bit 1: GWS1 - Watchdog interrupt status
  Bit 2: GWS2 - Watchdog reset status

GWRR (0x04):
  Write any value to refresh watchdog
```

#### Watchdog Timer Example (Rust)

```rust
/// Watchdog Timer driver
pub struct Watchdog {
    base: usize,
    is_window_mode: bool,
}

impl Watchdog {
    const TWCSR0: usize = 0x00;
    const TWCSR1: usize = 0x04;
    const TBR: usize = 0x08;
    const FCR: usize = 0x0C;
    const FWR: usize = 0x10;
    const SWR: usize = 0x14;

    const GWCSR_ENABLE: u32 = 0x01;
    const TWCSR0_WRS: u32 = 0x02;
    const TWCSR0_ENW: u32 = 0x08;

    pub fn new(base: usize) -> Self {
        Self {
            base,
            is_window_mode: false,
        }
    }

    /// Enable standard watchdog mode
    pub fn enable_standard(&mut self, timeout_cycles: u32) {
        unsafe {
            let csr0 = (self.base + Self::TWCSR0) as *mut u32;
            let csr1 = (self.base + Self::TWCSR1) as *mut u32;

            // Clear any pending status
            core::ptr::write_volatile(csr0, Self::TWCSR0_WRS);

            // Set timeout (loaded into TBR)
            core::ptr::write_volatile(csr1, timeout_cycles);

            // Enable watchdog
            core::ptr::write_volatile(csr0, Self::GWCSR_ENABLE);
        }
        self.is_window_mode = false;
    }

    /// Enable window watchdog mode
    /// first_window: Cycles where refresh is NOT allowed
    /// second_window: Cycles where refresh IS allowed
    pub fn enable_window(&mut self, first_window: u32, second_window: u32) {
        unsafe {
            let fcr = (self.base + Self::FCR) as *mut u32;
            let fwr = (self.base + Self::FWR) as *mut u32;
            let swr = (self.base + Self::SWR) as *mut u32;
            let csr0 = (self.base + Self::TWCSR0) as *mut u32;

            // Configure window sizes
            core::ptr::write_volatile(fwr, first_window);
            core::ptr::write_volatile(swr, second_window);

            // Enable window mode
            core::ptr::write_volatile(fcr, 0x02);  // WM bit

            // Enable watchdog (note: ENW cannot be cleared once set!)
            core::ptr::write_volatile(csr0, Self::TWCSR0_ENW);
        }
        self.is_window_mode = true;
    }

    /// Refresh (kick) the watchdog
    /// For window mode: must be called during second window only
    pub fn refresh(&self) {
        unsafe {
            let csr1 = (self.base + Self::TWCSR1) as *mut u32;
            // Write any value to refresh
            core::ptr::write_volatile(csr1, 0x01);
        }
    }

    /// Get current timebase value
    pub fn get_timebase(&self) -> u32 {
        unsafe {
            let tbr = (self.base + Self::TBR) as *const u32;
            core::ptr::read_volatile(tbr)
        }
    }

    /// Check if watchdog reset occurred
    pub fn was_reset_triggered(&self) -> bool {
        unsafe {
            let csr0 = (self.base + Self::TWCSR0) as *const u32;
            (core::ptr::read_volatile(csr0) & Self::TWCSR0_WRS) != 0
        }
    }

    /// Calculate timeout in milliseconds for given cycle count
    /// Based on 75 MHz clock
    pub fn cycles_to_ms(cycles: u32) -> u32 {
        cycles / 75_000
    }

    /// Calculate cycle count for given timeout in milliseconds
    pub fn ms_to_cycles(ms: u32) -> u32 {
        ms * 75_000
    }
}
```

### Timer and Sleep APIs

The BSP provides timer functionality through the xiltimer library for delays and timing measurements.

#### Available Timer APIs

| Function | Description |
|||
| `usleep(useconds)` | Sleep for specified microseconds |
| `msleep(mseconds)` | Sleep for specified milliseconds |
| `sleep(seconds)` | Sleep for specified seconds |
| `XTime_GetTime(&time)` | Get current timestamp |
| `Xil_GetRISCVFrequency()` | Get processor frequency |

#### Timing Calculations at 75 MHz

| Duration | CPU Cycles | Timing |
||||
| 1 µs | 75 | 13.33 ns/cycle |
| 10 µs | 750 | - |
| 100 µs | 7,500 | - |
| 1 ms | 75,000 | - |
| 10 ms | 750,000 | - |
| 100 ms | 7,500,000 | - |
| 1 s | 75,000,000 | - |

#### RTOS Timer Implementation (Rust)

```rust
/// System timer for RTOS tick generation
pub struct SystemTimer {
    frequency: u32,
    tick_interval_us: u32,
}

impl SystemTimer {
    const MTIME_BASE: usize = 0x0200_0000;  // If memory-mapped timer available
    const MTIMECMP_BASE: usize = 0x0200_4000;

    /// Create new system timer
    /// tick_interval_us: microseconds between RTOS ticks
    pub fn new(tick_interval_us: u32) -> Self {
        Self {
            frequency: 75_000_000,
            tick_interval_us,
        }
    }

    /// Initialize timer for periodic interrupts
    pub fn init(&self) {
        // For MicroBlaze V without MTIME, use FIT Timer or AXI Timer
        // Configure interrupt interval
        let cycles = (self.frequency / 1_000_000) * self.tick_interval_us;

        // Set up timer compare value
        unsafe {
            // Implementation depends on available timer peripheral
            // See AXI Timer or FIT Timer configuration
        }
    }

    /// Get current cycle count using RISC-V cycle CSR
    #[inline]
    pub fn get_cycles() -> u64 {
        let lo: u32;
        let hi: u32;
        unsafe {
            core::arch::asm!(
                "csrr {0}, cycle",
                "csrr {1}, cycleh",
                out(reg) lo,
                out(reg) hi,
            );
        }
        ((hi as u64) << 32) | (lo as u64)
    }

    /// Busy-wait delay in microseconds
    #[inline]
    pub fn delay_us(us: u32) {
        let cycles = (75 * us) as u64;
        let start = Self::get_cycles();
        while Self::get_cycles() - start < cycles {}
    }

    /// Busy-wait delay in milliseconds
    #[inline]
    pub fn delay_ms(ms: u32) {
        Self::delay_us(ms * 1000);
    }
}

/// Polling macro with timeout
#[macro_export]
macro_rules! poll_timeout {
    ($condition:expr, $timeout_us:expr) => {{
        let start = SystemTimer::get_cycles();
        let timeout_cycles = (75 * $timeout_us) as u64;
        loop {
            if $condition {
                break Ok(());
            }
            if SystemTimer::get_cycles() - start > timeout_cycles {
                break Err(TimeoutError);
            }
        }
    }};
}
```

### Debug Interface (JTAG/MDM)

The MicroBlaze Debug Module (MDM) provides JTAG-based debugging capabilities.

#### Debug Features Available

| Feature | Support |
|||
| JTAG Connection | Yes |
| Hardware Breakpoints | Yes (4 available) |
| Software Breakpoints | Yes (via EBREAK) |
| Single-Step | Yes |
| Memory Read/Write | Yes |
| Register Access | Yes |
| Cross-Trigger Interface | No |

#### Debug CSRs (dcsr, dpc, dscratch)

```text
dcsr (0x7B0) - Debug Control and Status:
  Bits 1:0: prv - Privilege mode before debug (always 3=Machine)
  Bit 2: step - Single-step mode
  Bit 3: nmip - Non-maskable interrupt pending
  Bit 4: mprven - MPRV in effect during debug
  Bits 8:6: cause - Cause of debug entry
  Bit 11: stopcount - Stop cycle/instret during debug
  Bit 12: stoptime - Stop time during debug
  Bits 31:28: xdebugver - Debug version (4)

dpc (0x7B1) - Debug PC:
  Contains PC when entering debug mode
  Written to set PC on debug exit

dscratch0/1 (0x7B2, 0x7B3) - Debug Scratch:
  Scratch registers for debug handler
```

#### Debug Entry Causes (dcsr.cause)

| Value | Cause |
|||
| 1 | EBREAK instruction |
| 2 | Trigger module (breakpoint) |
| 3 | Debug request (halt request) |
| 4 | Single step |

#### Breakpoint Implementation

```rust
/// Debug breakpoint utilities
pub mod debug {
    /// Trigger software breakpoint
    #[inline]
    pub fn breakpoint() {
        unsafe {
            core::arch::asm!("ebreak");
        }
    }

    /// Read debug cause
    #[inline]
    pub fn get_debug_cause() -> u8 {
        let dcsr: u32;
        unsafe {
            core::arch::asm!("csrr {}, 0x7B0", out(reg) dcsr);
        }
        ((dcsr >> 6) & 0x7) as u8
    }

    /// Check if we're in debug mode
    #[inline]
    pub fn in_debug_mode() -> bool {
        // In debug mode, certain operations behave differently
        // This is primarily for debugger use
        false  // Cannot reliably detect from software
    }
}
```

---

### Memory-Mapped I/O Access Pattern

All peripherals use standard MMIO (Memory-Mapped I/O):

```c
// Example: Reading from GPIO
#define GPIO_BUTTONS_BASE  0x40020000
#define GPIO_DATA_OFFSET   0x00

volatile uint32_t *gpio_data = (volatile uint32_t *)(GPIO_BUTTONS_BASE + GPIO_DATA_OFFSET);
uint32_t button_state = *gpio_data;

// Example: Writing to UART
#define UART_BASE         0x40600000
#define UART_TX_FIFO      0x04

volatile uint32_t *uart_tx = (volatile uint32_t *)(UART_BASE + UART_TX_FIFO);
*uart_tx = 'A';  // Send character
```

### Register Definitions

All peripheral register offsets and bit definitions can be found in:

- Low-level headers: `include/x*_l.h` (e.g., `xgpio_l.h`, `xuartlite_l.h`)
- Device tree: [hw/sdt/system-top.dts](./hw/sdt/system-top.dts)
- Hardware documentation: [../hardware/README.md](../hardware/README.md)

### Interrupt Handler Setup (Bare-Metal)

For direct interrupt handling without Xilinx drivers:

1. **Configure AXI Interrupt Controller:**

   ```c
   #define INTC_BASE       0x41200000
   #define INTC_ISR        0x00  // Interrupt Status Register
   #define INTC_IPR        0x04  // Interrupt Pending Register
   #define INTC_IER        0x08  // Interrupt Enable Register
   #define INTC_IAR        0x0C  // Interrupt Acknowledge Register
   #define INTC_SIE        0x10  // Set Interrupt Enable
   #define INTC_CIE        0x14  // Clear Interrupt Enable
   #define INTC_IVR        0x18  // Interrupt Vector Register
   #define INTC_MER        0x1C  // Master Enable Register

   // Enable master interrupt
   *(volatile uint32_t *)(INTC_BASE + INTC_MER) = 0x03;  // HIE=1, MIE=1

   // Enable specific interrupt (e.g., UART = IRQ 2)
   *(volatile uint32_t *)(INTC_BASE + INTC_IER) = (1 << 2);
   ```

2. **Configure RISC-V Machine Interrupt Enable:**

   ```c
   // Enable external interrupts in mie CSR
   __asm__ volatile ("csrsi mie, 0x800");  // Set MEI bit

   // Enable global interrupts in mstatus
   __asm__ volatile ("csrsi mstatus, 0x8"); // Set MIE bit
   ```

3. **Set Trap Vector:**

   ```c
   extern void trap_handler(void);
   __asm__ volatile ("csrw mtvec, %0" :: "r"(trap_handler));
   ```

4. **Implement Trap Handler:**

   ```asm
   trap_handler:
       # Save context (all registers)
       addi sp, sp, -128
       sw x1, 0(sp)
       sw x2, 4(sp)
       # ... save all registers ...

       # Call C interrupt handler
       jal handle_interrupt

       # Restore context
       lw x1, 0(sp)
       lw x2, 4(sp)
       # ... restore all registers ...
       addi sp, sp, 128

       # Return from trap
       mret
   ```

## Regenerating the BSP

If you modify the hardware design (XSA file), regenerate the BSP:

1. Update the XSA file in: [hw/](./hw/)
2. Open Vitis and load the platform project
3. Right-click the platform project → **Update Hardware Specification**
4. Build the platform project to regenerate BSP files
5. Rebuild any application projects using this platform

**Command-Line BSP Generation (Advanced):**

```powershell
# Set environment
cd C:\AMDDesignTools\2025.2\Vitis\scripts
.\vitis.bat

# In Vitis shell:
cd C:\rustos\bsp
xsct
% platform create -name bsp -hw ../hardware/artifacts/hardware_platform/*.xsa
% domain create -name standalone -proc mbv_microblaze_v -os standalone
% platform generate
```

## Troubleshooting

### Common Issues

- **Build errors after hardware changes**:
  - Regenerate the BSP and clean/rebuild applications
  - Check that XSA file is up-to-date
  - Verify processor name matches in hardware and BSP

- **Missing drivers**:
  - Ensure all hardware peripherals are properly included in the XSA
  - Check [bsp.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml) for driver mapping

- **UART not working**:
  - Verify mbv_axi_uartlite is configured in hardware @ 0x40600000
  - Check baud rate (115200) in terminal
  - Ensure UART is set as stdin/stdout in bsp.yaml

- **Application won't debug**:
  - Check JTAG connection and cable drivers
  - Ensure MDM (MicroBlaze Debug Module) is enabled in hardware
  - Verify processor is not held in reset
  - Check Vivado Hardware Manager can see the device

- **Interrupt not firing**:
  - Verify interrupt is enabled in peripheral
  - Check interrupt is enabled in AXI Interrupt Controller (IER register)
  - Verify master interrupt enable (MER register)
  - Ensure RISC-V `mie` and `mstatus` CSRs have interrupts enabled
  - Check interrupt number matches hardware (see Interrupt Mapping table)

- **Linker errors (undefined reference)**:
  - Ensure all required libraries are linked
  - Check library dependencies in [lib_list.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/lib_list.yaml)
  - Add `-lxil` to linker flags

### Platform Verification

Verify the platform configuration:

```powershell
# View platform configuration
cat vitis-comp.json

# View BSP settings
cat mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml

# View device tree (hardware mapping)
cat hw/sdt/system-top.dts

# View driver list
cat mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/ip_drv_map.yaml

# Check compiled libraries
dir mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/lib
```

### Debug Output

Enable verbose BSP build output:

```cmake
# In CMakeLists.txt, add:
set(CMAKE_VERBOSE_MAKEFILE ON)
```

## Key Files Reference

### Configuration Files

- [vitis-comp.json](./vitis-comp.json) - Platform definition
- [bsp.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml) - BSP configuration and driver mapping
- [cflags.yaml](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/cflags.yaml) - Compiler/linker flags
- [bspconfig.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/bspconfig.h) - C preprocessor defines

### Hardware Description

- [system-top.dts](./hw/sdt/system-top.dts) - Complete system device tree
- [mbv_microblaze_v_baremetal.dts](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/hw_artifacts/mbv_microblaze_v_baremetal.dts) - Bare-metal device tree
- [rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa](./hw/rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa) - Vivado hardware export

### Build System

- [CMakeLists.txt](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/CMakeLists.txt) - Top-level CMake build
- [microblaze_riscv_toolchain.cmake](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/microblaze_riscv_toolchain.cmake) - Toolchain configuration
- [Xilinx.spec](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/Xilinx.spec) - GCC specs file

### Driver Headers (Key Subset)

- [xgpio.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xgpio.h) - GPIO driver API
- [xuartlite.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xuartlite.h) - UART Lite driver API
- [xiic.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xiic.h) - I2C driver API
- [xspi.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xspi.h) - SPI driver API
- [xemaclite.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xemaclite.h) - Ethernet Lite driver API
- [xintc.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xintc.h) - Interrupt controller API
- [xwdttb.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/xwdttb.h) - Watchdog timer API
- [riscv_interface.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_interface.h) - RISC-V CSR access

**All Headers:** See `mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/` directory

## Related Resources

- **Hardware Design:** [../hardware/README.md](../hardware/README.md)
- **Hardware Artifacts:** [../hardware/artifacts/](../hardware/artifacts/)
- **IP Core Documentation:** [../hardware/ip_cores/](../hardware/ip_cores/)
- **Requirements:** [../requirements/REQUIREMENTS.md](../requirements/REQUIREMENTS.md)
- **AMD Vitis Documentation:** [AMD Vitis Unified Software Platform](https://docs.amd.com/r/en-US/ug1400-vitis-embedded)
- **RISC-V Specifications:** [RISC-V International](https://riscv.org/technical/specifications/)
- **Embedded Rust Resources:** [The Embedded Rust Book](https://docs.rust-embedded.org/book/)

## Tools and Versions

- **Vitis Unified IDE**: 2025.2
- **Vivado Design Suite**: 2025.2
- **Target Board**: Digilent Arty A7-35 (XC7A35TICSG324-1L)
- **Processor IP**: MicroBlaze V v1.0 (RISC-V RV32IMACB)
- **GCC Toolchain**: riscv64-unknown-elf-gcc (bundled with Vitis)
- **Embedded SW**: Xilinx embeddedsw 2025.2

## License and Copyright

Board Support Package files are:

- Copyright (C) 2023-2025 Advanced Micro Devices, Inc. All Rights Reserved.
- SPDX-License-Identifier: MIT

Hardware design and this documentation are part of the RustOS project.

---

**Document Version:** 4.0
**Last Updated:** 2025-01-11
**Generated From:** Comprehensive BSP analysis with extended peripheral documentation including SPI Flash, Ethernet MDIO/PHY, I2C protocol details, Window WDT, timers, and debug interface reference
