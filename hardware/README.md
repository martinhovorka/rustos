# Hardware Design - README

## Overview

This directory contains the complete hardware design for the **MicroBlaze V (RISC-V) rv32imacb_zicsr_zifencei_zbc** soft-core processor system implemented on the Digilent Arty A7-35 FPGA development board using Xilinx Vivado 2025.2.

The design includes:

- Complete RISC-V RV32 processor with full ISA extensions
- 128 KB local memory (BRAM)
- Comprehensive peripheral set (GPIO, UART, SPI, I2C, Ethernet, Timers)
- Debug infrastructure with external trace support
- Ready-to-use bitstream and project files

## Directory Content

- [rv32imacb_zicsr_zifencei_zbc](./rv32imacb_zicsr_zifencei_zbc)
  - directory contains hardware design for `rv32imacb_zicsr_zifencei_zbc` soft-core processor.
  - contains complete Vivado 2025.2 project in VHDL/Verilog and/or other formats including the project file
  - complete hardware specification can be found here including details
  - shall be recursively searched for any detailed information about the implemented hardware
- [artifacts](./artifacts)
  - this directory contains exported data from Vivado 2025.2 project
  - shall be recursively searched for any detailed information about the implemented hardware
  - [rv32imacb_zicsr_zifencei_zbc-address_segments.csv](./artifacts/address_segments/rv32imacb_zicsr_zifencei_zbc-address_segments.csv)
    - file contains address segments from the Address Editor
  - [rv32imacb_zicsr_zifencei_zbc-bitstream.bit](./artifacts/bitstream/rv32imacb_zicsr_zifencei_zbc-bitstream.bit)
    - file contains FPGA bitstream
  - [rv32imacb_zicsr_zifencei_zbc-block_design.tcl](./artifacts/block_design/rv32imacb_zicsr_zifencei_zbc-block_design.tcl)
    - file contains actual top level block design
  - [rv32imacb_zicsr_zifencei_zbc-constraints.xdc](./artifacts/constraints/rv32imacb_zicsr_zifencei_zbc-constraints.xdc)
    - file contains exported project constraints
  - [rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa](./artifacts/hardware_platform/rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa)
    - file contains exported hardware platform
  - [rv32imacb_zicsr_zifencei_zbc-ibis_model.ibs](./artifacts/ibis_model/rv32imacb_zicsr_zifencei_zbc-ibis_model.ibs)
    - file contains IBIS (Input/Output Buffer Information Specification)
  - [io_ports](./artifacts/io_ports)
    - directory contains I/O port description in various formats:
      - [rv32imacb_zicsr_zifencei_zbc-io_ports-csv.csv](./artifacts/io_ports/rv32imacb_zicsr_zifencei_zbc-io_ports-csv.csv)
      - [rv32imacb_zicsr_zifencei_zbc-io_ports-vhdl.vhd](./artifacts/io_ports/rv32imacb_zicsr_zifencei_zbc-io_ports-vhdl.vhd)
      - [rv32imacb_zicsr_zifencei_zbc-io_ports-xdc.xdc](./artifacts/io_ports/rv32imacb_zicsr_zifencei_zbc-io_ports-xdc.xdc)
  - [netlist](./artifacts/netlist)
    - directory contains netlist description of the project in various formats:
      - [rv32imacb_zicsr_zifencei_zbc-netlist_edif.edn](./artifacts/netlist/rv32imacb_zicsr_zifencei_zbc-netlist_edif.edn)
      - [rv32imacb_zicsr_zifencei_zbc-netlist_verilog.v](./artifacts/netlist/rv32imacb_zicsr_zifencei_zbc-netlist_verilog.v)
  - [rv32imacb_zicsr_zifencei_zbc-project.tcl](./artifacts/project/rv32imacb_zicsr_zifencei_zbc-project.tcl)
    - TCL script for complete project re-creation
  - [rv32imacb_zicsr_zifencei_zbc-schematic.sch](./artifacts/schematic/rv32imacb_zicsr_zifencei_zbc-schematic.sch)
    - generated schematic
- [ip_cores](./ip_cores/)
  - all IP Cores that were used by the rv32imacb_zicsr_zifencei_zbc
  - directly extracted from Vivado 2025.2 to be used as a hw reference

## Memory Map

The system memory map is defined as follows (see [rv32imacb_zicsr_zifencei_zbc-address_segments.csv](./artifacts/address_segments/rv32imacb_zicsr_zifencei_zbc-address_segments.csv) for complete details):

### Local Memory

- **0x00000000 - 0x0001FFFF** (128 KB): Local BRAM (Instruction & Data)

### Peripheral Address Space

- **0x40000000 - 0x4000FFFF**: GPIO Shield Pins 0-19
- **0x40010000 - 0x4001FFFF**: GPIO Shield Pins 26-41
- **0x40020000 - 0x4002FFFF**: GPIO Push Buttons
- **0x40030000 - 0x4003FFFF**: GPIO DIP Switches
- **0x40040000 - 0x4004FFFF**: GPIO LED 4-bits
- **0x40050000 - 0x4005FFFF**: GPIO RGB LEDs
- **0x40060000 - 0x4006FFFF**: GPIO I2C Pullups
- **0x40600000 - 0x4060FFFF**: AXI UART Lite
- **0x40800000 - 0x4080FFFF**: AXI IIC (I2C)
- **0x40E00000 - 0x40E0FFFF**: AXI Ethernet Lite
- **0x41200000 - 0x4120FFFF**: AXI Interrupt Controller
- **0x41A00000 - 0x41A0FFFF**: AXI Timebase Watchdog Timer
- **0x44A00000 - 0x44A0FFFF**: AXI Quad SPI Flash
- **0x44A10000 - 0x44A1FFFF**: AXI Quad SPI (External Devices)

## Physical Board Description

- Board used:
  - `Digilent Arty A7-35`
- Board specification:
  - `FPGA Part # XC7A35TICSG324-1L`
  - `Logic Slices 5,200`
  - `Block RAM 1,800 Kbits`
  - `DSP Slices 90`
  - `DDR3 256 MB @ 333 MHz (667 MT/s)`
  - `Internal clock 450 MHz+`
  - `Quad-SPI Flash 16 MB`
  - Ethernet 10/100 Mbps

## RISC-V platform (rv32imacb_zicsr_zifencei_zbc) description

### Base

- **RV32** 32-bit integer registers and 32-bit address space.
- **I** Base integer ISA.

### Single-letter extensions

- **M**: Integer multiply/divide.
- **A**: Atomic instructions (LR/SC, AMOs).
- **C**: Compressed 16-bit instructions.
- **B**: Bit-manipulation extension (umbrella shorthand for Zba + Zbb + Zbc + Zbs). Since **B** is present, the canonical assumption is a *full* B implementation unless the string restricts it explicitly.

### Z-extensions

- **Zicsr**: CSR read/write/modify instructions.
- **Zifencei**: Instruction-fetch fence (`fence.i`).
- **Zbc**: Carry-less polynomial bit-manipulation (crypto/CRC) subset.

Note: **Zbc** is already part of **B**. Listing it again is allowed; it simply makes the subset explicit.

### Processor Configuration Summary

- **Implementation**: 32-bit, Performance-optimized
- **Clock Frequency**: 75 MHz
- **Local Memory**: 128 KB (64K instruction + 64K data via LMB)
- **Cache**: None (direct memory access)
- **Debug**: Enabled with 8 PC breakpoints, 4 read/write watchpoints, external trace (16-bit)
- **Privilege Mode**: Supervisor with SV32 virtual memory support
- **Performance Monitors**: 13 event counters, 8 latency counters
- **Exceptions**: Complete illegal instruction handling, misaligned access exceptions, bus exceptions
- **Interrupts**: 11 external interrupts via AXI Interrupt Controller
- **Local Memory ECC**: `None`
- **Cache Configuration**: `None`
- **Debug Module**: Debug `Enabled`
- **Peripheral AXI Port**: `Enabled`
- **Interrupt Controller**: `Enabled`
- **Clock Connection**: `New Clocking Wizard`
  - base clock at 75 MHz (generated by `mbv_clocking_wizard` - see below)

### Detailed List of used IP Cores

Top level block design can be found here [rv32imacb_zicsr_zifencei_zbc-block_design.tcl](./artifacts/block_design/rv32imacb_zicsr_zifencei_zbc-block_design.tcl)

#### mbv_axi_ethernetlite

- IP core name: AXI Ethernet Lite MAC v3.0
- IP core data directory: [axi_ethernetlite_v3_0](./ip_cores/axi_ethernetlite_v3_0/)
- default configuration values used with these exceptions:
  - AXI Clock Frequency (in MHz): 75.0 (generated by `mbv_clocking_wizard`)

#### mbv_axi_gpio_dip_switches

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to read status of the dip switches on the board
- default configuration values used with these exceptions:
  - Enable Interrupt: True

#### mbv_axi_gpio_iic_pullups

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to control I2C pull-up resistors on the board
- default configuration values used

#### mbv_axi_gpio_led_4_bits

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to control 4 LEDs on the board
- default configuration values used

#### mbv_axi_gpio_led_rgb

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to control 4 RGB LEDs on the board
- default configuration values used

#### mbv_axi_gpio_push_buttons

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to read status of the push buttons on the board
- default configuration values used with these exceptions:
  - Enable Interrupt: True

#### mbv_axi_gpio_shield_pins_0_19

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to read/write/control status GPIO shield pins 0 - 19
- default configuration values used with these exceptions:
  - Enable Interrupt: True

#### mbv_axi_gpio_shield_pins_26_41

- IP core name: AXI GPIO v2.0
- IP core data directory: [axi_gpio_v2_0](./ip_cores/axi_gpio_v2_0/)
- NOTE: interface is used to read/write/control status GPIO shield pins 26 - 41
- default configuration values used with these exceptions:
  - Enable Interrupt: True

#### mbv_axi_iic

- IP core name: AXI IIC Bus Interface v2.1
- IP core data directory: [axi_iic_v2_1](./ip_cores/axi_iic_v2_1/)
- default configuration values used with these exceptions:
  - SCL Inertial Delay (in AXI clocks): 4
  - SDA Inertial Delay (in AXI clocks): 4

#### mbv_axi_quad_spi

- IP core name: AXI Quad SPI v3.2
- IP core data directory: [axi_quad_spi_v3_2](./ip_cores/axi_quad_spi_v3_2/)
- NOTE: this interface is used for communication with external devices
- default configuration values used with these exceptions:
  - AXI Interface Options
    - Enable XIP Mode: Disabled
    - Enable Performance Mode: Enabled
  - SPI Options
    - Mode: Quad
    - Transaction Width: 32
    - Frequency Ratio: 16 x 1 (SPI clock = AXI clock / 16 = 75 MHz / 16 = ~4.69 MHz)
    - Enable Master Mode: Enabled
    - Byte Level Interrupt Enable: Disabled
    - Enable FIFO: Enabled
    - FIFO Depth: 256

#### mbv_axi_quad_spi_flash

- IP core name: AXI Quad SPI v3.2
- IP core data directory: [axi_quad_spi_v3_2](./ip_cores/axi_quad_spi_v3_2/)
- NOTE: this interface is used for communication with on-board SPI flash memory
- default configuration values used with these exceptions:
  - AXI Interface Options
    - Enable XIP Mode: Disabled
    - Enable Performance Mode: Enabled
  - SPI Options
    - Mode: Quad
    - Slave Device: Spansion
    - FIFO Depth: 256

#### mbv_axi_smartconnect

- IP core name: SmartConnect v1.0
- IP core data directory: [smartconnect_v1_0](./ip_cores/smartconnect_v1_0/)
- default configuration values used

#### mbv_axi_timebase_watchdog_timer

- IP core name: AXI Timebase Watchdog Timer v3.0
- IP core data directory: [axi_timebase_wdt_v3_0](./ip_cores/axi_timebase_wdt_v3_0/)
- default configuration values used with these exceptions:
  - Enable Window WDT: Enabled
  - Width of Second Sequence Timer: 8

#### mbv_axi_uartlite

- IP core name: AXI UART Lite v2.0
- IP core data directory: [axi_uartlite_v2_0](./ip_cores/axi_uartlite_v2_0/)
- default configuration values used with these exceptions:
  - AXI CLK Frequency: auto (75 Mhz)
  - Baud Rate: 115200
  - Data Bits: 8
  - Parity: No parity

#### mbv_clocking_wizard

- IP core name: Clocking Wizard v6.0
- IP core data directory: [clk_wiz_v6_0](./ip_cores/clk_wiz_v6_0/)
- default configuration values used with these exceptions:
  - Output Clocks tab -> Output Clock
    - clk_out1 - Enabled
      - Port name: clk_out1
      - Output Freq (MHz)
        - Requested: 75
        - Actual: 75
    - NOTE: this is the main clock for the whole system

#### mbv_fixed_interval_timer_1_millisecond

- IP core name: Fixed Interval Timer v2.0
- IP core data directory: [fit_timer_v2_0](./ip_cores/fit_timer_v2_0/)
- default configuration values used with these exceptions:
  - Number of clocks: 75000

#### mbv_inline_utility_vector_logic

- IP core name: Inline Utility Vector Logic v1.0
- IP core data directory: [ilvector_logic_v1_0](./ip_cores/ilvector_logic_v1_0/)
- default configuration values used with these exceptions
  - C_OPERATION: not

#### mbv_local_memory

- NOTE: this is not IP core by itself

#### mbv_block_memory_generator

- IP core name: Block Memory Generator v8.4
- IP core data directory: [blk_mem_gen_v8_4](./ip_cores/blk_mem_gen_v8_4/)
- default configuration values used

#### mbv_data_lmb_bram_controller

- IP core name: LMB Block RAM Interface Controller v4.0
- IP core data directory: [lmb_bram_if_cntlr_v4_0](./ip_cores/lmb_bram_if_cntlr_v4_0/)
- default configuration values used

#### mbv_data_local_memory_bus

- IP core name: Local Memory Bus (LMB) v3.0
- IP core data directory: [lmb_v10_v3_0](./ip_cores/lmb_v10_v3_0/)
- default configuration values used

#### mbv_instruction_lmb_bram_controller

- IP core name: LMB Block RAM Interface Controller v4.0
- IP core data directory: [lmb_bram_if_cntlr_v4_0](./ip_cores/lmb_bram_if_cntlr_v4_0/)
- default configuration values used

#### mbv_instruction_local_memory_bus

- IP core name: Local Memory Bus (LMB) v3.0
- IP core data directory: [lmb_v10_v3_0](./ip_cores/lmb_v10_v3_0/)
- default configuration values used

#### mbv_microblaze_debug_module_v

- IP core name: MicroBlaze Debug Module V (MDM V) v1.0
- IP core data directory: [mdm_riscv_v1_0](./ip_cores/mdm_riscv_v1_0/)
- default configuration values used with these exceptions
  - Trace:
    - Select Trace Interface: External
    - External Trace Data Width: 16

#### mbv_microblaze_v

- IP core name: MicroBlaze V v1.0
- IP core data directory: [microblaze_riscv_v1_0](./ip_cores/microblaze_riscv_v1_0/)
- Documentation references:
  - MicroBlaze V Processor Reference Guide (UG1629)
  - MicroBlaze V Processor Embedded Design User Guide (UG1711)
  - Setup of a MicroBlaze Processor Design for Off-Chip Trace (XAPP1029)
- default configuration values used with these exceptions:
  - `Welcome to the Microblaze V Configuration Wizard` screen/tab:
    - Predefined configurations: None selected
    - Select processor implementation: 32
    - General Settings:
      - Selected implementation optimization: PERFORMANCE
      - Enable Instruction Cache: False
      - Enable Data Cache: False
      - Enable Discrete Ports: False
  - `General` screen/tab:
    - Instructions:
      - Enable Atomic Instructions: True
      - Enable Integer Multiply and Divide: OPTIMIZED
      - Enable Floating Point Unit: NONE
      - Enable Code Compression: True
      - Enable Bit Manipulation Extension:
        - Zba: True
        - Zbb: True
        - Zbc: True
        - Zbs: True
      - Privilege Mode: SUPERVISOR
      - Select Extended Addressing: SV32
    - Resources:
      - Select Barrel Shifter Implementation: PERFORMANCE
      - Enable Base Counters and Timers: True
    - Optimization
      - Enable Branch Target Cache: False
  - `Exception` screen/tab:
    - Bus Exceptions:
      - Enable Data-side AXI exception: True
    - Other Exceptions:
      - Enable Illegal Instruction Exception: COMPLETE
      - Enable Misaligned Exceptions: True
  - `Debug` screen/tab:
    - Debug Module Interface: True
    - Hardware Breakpoints:
      - Number of PC Breakpoints: 8
      - Number of Write Address Watchpoints: 4
      - Number of Read Address Watchpoints: 4
    - Performance Monitoring:
      - Number of Performance Monitor Event Counters: 13
      - Number of Performance Monitor Latency Counters: 8
    - Trace & Profiling:
      - External Trace: True
      - Profile Buffer Size: NONE
    - Interface: SERIAL
  - `Interrupt & Reset` screen/tab:
    - Interrupt:
      - use Interrupt: auto
    - Identification:
      - Architecture ID: 0x0000000000000001
      - Implementation ID: 0x0000000000000001
      - Hardware Thread ID: 0x0000000000000000
    - Vectors:
      - Vector Base Address: auto
  - `Buses` screen/tab:
    - Local Memory Bus Interface:
      - Enable Local Memory Bus Instruction Interface: True
      - Enable Local Memory Bus Data Interface: True
    - AXI interfaces:
      - Enable Peripheral AXI Instruction Interface: False
      - Enable Peripheral AXI Data Interface: True
      - Enable AXI Slave Interface: False
    - Stream Interfaces:
      - Number of Stream Links: 0
    - Other Interfaces:
      - Enable Trace Bus Interface: False
      - Lockstep Interface: NONE

#### mbv_processor_system_reset

- IP core name: Processor System Reset Module v5.0
- IP core data directory: [proc_sys_reset_v5_0](./ip_cores/proc_sys_reset_v5_0/)
- default configuration values used

#### mbv_inline_concat

- IP core name: Inline Concat v1.0
- IP core data directory: [ilconcat_v1_0](./ip_cores/ilconcat_v1_0/)
- default configuration values used
- NOTE: 11 interrupt signals are passed through that are generated by:
  - [mbv_fixed_interval_timer_1_millisecond](#mbv_fixed_interval_timer_1_millisecond) (In0[0:0] -> dout[10.0], bus[0])
  - [mbv_axi_timebase_watchdog_timer](#mbv_axi_timebase_watchdog_timer) (In1[0:0] -> dout[10.0], bus[1])
  - [mbv_axi_uartlite](#mbv_axi_uartlite) (In2[0:0] -> dout[10.0], bus[2])
  - [mbv_axi_quad_spi_flash](#mbv_axi_quad_spi_flash) (In3[0:0] -> dout[10.0], bus[3])
  - [mbv_axi_gpio_shield_pins_0_19](#mbv_axi_gpio_shield_pins_0_19) (In4[0:0] -> dout[10.0], bus[4])
  - [mbv_axi_gpio_shield_pins_26_41](#mbv_axi_gpio_shield_pins_26_41) (In5[0:0] -> dout[10.0], bus[5])
  - [mbv_axi_gpio_push_buttons](#mbv_axi_gpio_push_buttons) (In6[0:0] -> dout[10.0], bus[6])
  - [mbv_axi_gpio_dip_switches](#mbv_axi_gpio_dip_switches) (In7[0:0] -> dout[10.0], bus[7])
  - [mbv_axi_ethernetlite](#mbv_axi_ethernetlite) (In8[0:0] -> dout[10.0], bus[8])
  - [mbv_axi_quad_spi](#mbv_axi_quad_spi) (In9[0:0] -> dout[10.0], bus[9])
  - [mbv_axi_iic](#mbv_axi_iic) (In10[0:0] -> dout[10.0], bus[10])

#### mbv_axi_interrupt_controller

- IP core name: AXI Interrupt Controller v4.1
- IP core data directory: [axi_intc_v4_1](./ip_cores/axi_intc_v4_1/)
- default configuration values used
- NOTE: 11 interrupt signals are received that are generated by:
  - [mbv_fixed_interval_timer_1_millisecond](#mbv_fixed_interval_timer_1_millisecond) (dout[10.0] -> intr[10:0], bus[0])
  - [mbv_axi_timebase_watchdog_timer](#mbv_axi_timebase_watchdog_timer) (dout[10.0] -> intr[10:0], bus[1])
  - [mbv_axi_uartlite](#mbv_axi_uartlite) (dout[10.0] -> intr[10:0], bus[2])
  - [mbv_axi_quad_spi_flash](#mbv_axi_quad_spi_flash) (dout[10.0] -> intr[10:0], bus[3])
  - [mbv_axi_gpio_shield_pins_0_19](#mbv_axi_gpio_shield_pins_0_19) (dout[10.0] -> intr[10:0], bus[4])
  - [mbv_axi_gpio_shield_pins_26_41](#mbv_axi_gpio_shield_pins_26_41) (dout[10.0] -> intr[10:0], bus[5])
  - [mbv_axi_gpio_push_buttons](#mbv_axi_gpio_push_buttons) (dout[10.0] -> intr[10:0], bus[6])
  - [mbv_axi_gpio_dip_switches](#mbv_axi_gpio_dip_switches) (dout[10.0] -> intr[10:0], bus[7])
  - [mbv_axi_ethernetlite](#mbv_axi_ethernetlite) (dout[10.0] -> intr[10:0], bus[8])
  - [mbv_axi_quad_spi](#mbv_axi_quad_spi) (dout[10.0] -> intr[10:0], bus[9])
  - [mbv_axi_iic](#mbv_axi_iic) (dout[10.0] -> intr[10:0], bus[10])

## Getting Started

### Opening the Project in Vivado

1. Launch Vivado 2025.2
2. Open the project file: [rv32imacb_zicsr_zifencei_zbc.xpr](./rv32imacb_zicsr_zifencei_zbc/rv32imacb_zicsr_zifencei_zbc.xpr)
3. The complete design with all IP cores and constraints will be loaded

### Regenerating the Project from TCL

To recreate the project from scratch:

```tcl
source ./artifacts/project/rv32imacb_zicsr_zifencei_zbc-project.tcl
```

### Programming the FPGA

Use the pre-built bitstream:

```txt
./artifacts/bitstream/rv32imacb_zicsr_zifencei_zbc-bitstream.bit
```

Or generate a new bitstream:

1. Open the project in Vivado
2. Generate Bitstream (or run synthesis and implementation first if modified)
3. Program the Arty A7-35 board via USB JTAG

### Board I/O Connections

Refer to the constraints file for complete pin assignments:

- [rv32imacb_zicsr_zifencei_zbc-constraints.xdc](./artifacts/constraints/rv32imacb_zicsr_zifencei_zbc-constraints.xdc)

Key interfaces:

- **UART**: USB-UART bridge (115200 baud, 8-N-1)
- **Ethernet**: RJ45 connector (10/100 Mbps)
- **LEDs**: 4 standard LEDs + 4 RGB LEDs
- **Buttons**: 4 push buttons
- **Switches**: 4 DIP switches
- **Shield Pins**: Arduino-compatible I/O pins (0-19, 26-41)
- **I2C**: On-board I2C with programmable pull-ups
- **SPI**: Quad-SPI flash + external SPI interface

## Related Resources

- **Board Support Package (BSP)**: [../bsp/README.md](../bsp/README.md)
- **Digilent Arty A7 Reference Manual**: [Digilent Reference](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
- **MicroBlaze V Processor Documentation**:
  - [MicroBlaze V Processor Reference Guide (UG1629)](https://www.xilinx.com/support/documentation/user_guides/ug1629.html)
  - [MicroBlaze V Processor Embedded Design User Guide (UG1711)](https://www.xilinx.com/support/documentation/user_guides/ug1711.html)
- **Vivado Boards Repository**: [./vivado-boards/](./vivado-boards/)

## Modification Guidelines

### Changing Processor Configuration

1. Open the block design in Vivado (see [rv32imacb_zicsr_zifencei_zbc-block_design.tcl](./artifacts/block_design/rv32imacb_zicsr_zifencei_zbc-block_design.tcl) for TCL recreation)
2. Double-click on `mbv_microblaze_v` to open configuration wizard
3. Modify settings (refer to [mbv_microblaze_v](#mbv_microblaze_v) section for current configuration)
4. Regenerate block design outputs
5. Update constraints if needed
6. Rebuild BSP in Vitis

### Adding Peripherals

1. Open block design in Vivado Block Designer
2. Add new IP from IP Catalog
3. Connect to AXI interconnect (`mbv_axi_smartconnect`)
4. Assign address space via Address Editor
5. Connect interrupts to `mbv_inline_concat` if needed
6. Update constraints for external pins
7. Regenerate bitstream
8. Export XSA to Vitis and regenerate BSP

### Changing Clock Frequency

1. Modify `mbv_clocking_wizard` output frequency (currently 75 MHz)
2. Update all IP cores that reference clock frequency:
   - `mbv_axi_ethernetlite` (AXI Clock Frequency parameter)
   - `mbv_axi_uartlite` (AXI CLK Frequency parameter)
   - `mbv_fixed_interval_timer_1_millisecond` (Number of clocks parameter)
3. Re-run timing analysis
4. Regenerate bitstream

## Version Information

- **Vivado Version**: 2025.2
- **Board Files Version**: Latest from [./vivado-boards/](./vivado-boards/)
- **Target Device**: XC7A35TICSG324-1L
- **Design Language**: VHDL/Verilog mixed

## Hardware Simulation Files

