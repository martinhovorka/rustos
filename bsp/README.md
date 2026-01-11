# Board Support Package (BSP) - README

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

- [riscv_interface.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_interface.h) - Low-level RISC-V CSR access
- [riscv_exceptions_g.h](./mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/riscv_exceptions_g.h) - Exception handler setup

**RISC-V CSRs (Control and Status Registers):**

- `mstatus` - Machine status register
- `mie` - Machine interrupt enable
- `mip` - Machine interrupt pending
- `mtvec` - Machine trap-vector base address
- `mepc` - Machine exception program counter
- `mcause` - Machine cause register
- `mtval` - Machine trap value
- `mscratch` - Machine scratch register
- `mvendorid`, `marchid`, `mimpid` - Identification CSRs

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

**Exception Codes (mcause):**

- 0: Instruction address misaligned
- 1: Instruction access fault
- 2: Illegal instruction
- 3: Breakpoint
- 4: Load address misaligned
- 5: Load access fault
- 6: Store/AMO address misaligned
- 7: Store/AMO access fault
- 8: Environment call from U-mode
- 9: Environment call from S-mode
- 11: Environment call from M-mode

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

**Startup Files:**

- `crt0.S` - C runtime startup (provided by BSP in libsrc/standalone)
- Initializes `.data` section (copy from flash if needed)
- Zeros `.bss` section
- Sets up stack pointer
- Calls `main()`

**Boot Process:**

1. Reset vector → 0x00000000
2. `crt0.S` executes
3. Initialize data/bss
4. Call constructors (C++)
5. Call `main()`
6. On return, enter infinite loop or halt

**For RTOS:**

- Replace `crt0.S` with RTOS-specific startup
- Initialize RTOS scheduler before calling application tasks
- Set up timer for preemptive scheduling (use FIT timer or cycle counter)

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
   - Target triple: `riscv32imacb-unknown-none-elf`

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
   - FIT timer provides 1ms tick (75,000 cycles @ 75 MHz)
   - Consider tickless kernel for power efficiency

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

**Document Version:** 2.0
**Last Updated:** 2026-01-11
**Generated From:** Comprehensive BSP analysis of Vitis 2025.2 platform
