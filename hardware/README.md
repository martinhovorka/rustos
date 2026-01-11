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
- default configuration values used with these exceptions:
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
- default configuration values used with these exceptions:
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

```text
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
- Note: Some Digilent documentation may block automated link checks; if a link checker reports an error, open the link in a browser.
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

Simulation files are located in [rv32imacb_zicsr_zifencei_zbc.sim](./rv32imacb_zicsr_zifencei_zbc/rv32imacb_zicsr_zifencei_zbc.sim/)

---

## Software Development Reference

This section provides comprehensive hardware details for RTOS and embedded software development.

### Interrupt Vector Table

The system has 11 interrupt sources routed through the AXI Interrupt Controller at base address `0x41200000`.

|IRQ #|Source|Description|Peripheral|Base Address|
|------|---------------------|--------------------------------------|-----------------------------------------------------------------------------------|--------------|
|0|FIT Timer|1ms periodic timer interrupt|[mbv_fixed_interval_timer_1_millisecond](#mbv_fixed_interval_timer_1_millisecond)|N/A (direct)|
|1|Watchdog Timer|Watchdog timeout/window interrupt|[mbv_axi_timebase_watchdog_timer](#mbv_axi_timebase_watchdog_timer)|0x41A00000|
|2|UART|TX/RX interrupt|[mbv_axi_uartlite](#mbv_axi_uartlite)|0x40600000|
|3|SPI Flash|SPI flash transfer complete|[mbv_axi_quad_spi_flash](#mbv_axi_quad_spi_flash)|0x44A00000|
|4|GPIO Shield 0-19|GPIO interrupt (edge/level)|[mbv_axi_gpio_shield_pins_0_19](#mbv_axi_gpio_shield_pins_0_19)|0x40000000|
|5|GPIO Shield 26-41|GPIO interrupt (edge/level)|[mbv_axi_gpio_shield_pins_26_41](#mbv_axi_gpio_shield_pins_26_41)|0x40010000|
|6|Push Buttons|Button press interrupt|[mbv_axi_gpio_push_buttons](#mbv_axi_gpio_push_buttons)|0x40020000|
|7|DIP Switches|Switch change interrupt|[mbv_axi_gpio_dip_switches](#mbv_axi_gpio_dip_switches)|0x40030000|
|8|Ethernet|TX/RX complete, errors|[mbv_axi_ethernetlite](#mbv_axi_ethernetlite)|0x40E00000|
|9|SPI External|External SPI transfer complete|[mbv_axi_quad_spi](#mbv_axi_quad_spi)|0x44A10000|
|10|I2C|I2C bus events, transfer complete|[mbv_axi_iic](#mbv_axi_iic)|0x40800000|

**Interrupt Controller Registers** (Base: 0x41200000):

- `ISR` (0x00): Interrupt Status Register
- `IPR` (0x04): Interrupt Pending Register
- `IER` (0x08): Interrupt Enable Register
- `IAR` (0x0C): Interrupt Acknowledge Register
- `SIE` (0x10): Set Interrupt Enable
- `CIE` (0x14): Clear Interrupt Enable
- `IVR` (0x18): Interrupt Vector Register
- `MER` (0x1C): Master Enable Register

### Memory Map Summary (Software View)

```c
/* Memory Regions */
#define MEM_BRAM_BASE           0x00000000
#define MEM_BRAM_SIZE           (128 * 1024)    /* 128 KB */
#define MEM_BRAM_END            0x0001FFFF

/* GPIO Peripherals */
#define GPIO_SHIELD_0_19_BASE   0x40000000
#define GPIO_SHIELD_26_41_BASE  0x40010000
#define GPIO_BUTTONS_BASE       0x40020000
#define GPIO_SWITCHES_BASE      0x40030000
#define GPIO_LED_BASE           0x40040000
#define GPIO_RGB_BASE           0x40050000
#define GPIO_I2C_PULLUP_BASE    0x40060000

/* Communication Peripherals */
#define UART_BASE               0x40600000
#define I2C_BASE                0x40800000
#define ETHERNET_BASE           0x40E00000

/* System Peripherals */
#define INTC_BASE               0x41200000
#define WATCHDOG_BASE           0x41A00000
#define SPI_FLASH_BASE          0x44A00000
#define SPI_EXT_BASE            0x44A10000

/* Peripheral Size */
#define PERIPHERAL_SIZE         0x00010000      /* 64 KB per peripheral */
```

### Peripheral Register Offsets

#### AXI GPIO (All GPIO Peripherals)

Standard register offsets for all GPIO instances:

| Offset | Register | Access | Description |
| -------- | ------------- | -------- | ------------------------------------------------- |
| 0x00 | GPIO_DATA | R/W | Channel 1 Data Register |
| 0x04 | GPIO_TRI | R/W | Channel 1 Tri-state Control (0=output, 1=input) |
| 0x08 | GPIO2_DATA | R/W | Channel 2 Data Register (if enabled) |
| 0x0C | GPIO2_TRI | R/W | Channel 2 Tri-state Control (if enabled) |
| 0x11C | GIER | R/W | Global Interrupt Enable Register |
| 0x120 | IP_ISR | R/TOW | IP Interrupt Status Register |
| 0x124 | IP_IER | R/W | IP Interrupt Enable Register |

**GPIO Configuration by Instance:**

| Instance | Base Address | Width Ch1 | Width Ch2 | Interrupts | Physical Mapping |
| ------------------- | -------------- | ----------- | ----------- | ------------ | --------------------------- |
| Shield 0-19 | 0x40000000 | 20 bits | - | Yes | Arduino pins 0-19 |
| Shield 26-41 | 0x40010000 | 16 bits | - | Yes | Arduino pins 26-41 |
| Buttons | 0x40020000 | 4 bits | - | Yes | BTN0-BTN3 |
| Switches | 0x40030000 | 4 bits | - | Yes | SW0-SW3 |
| LED 4-bit | 0x40040000 | 4 bits | - | No | LD0-LD3 |
| RGB LED | 0x40050000 | 12 bits | - | No | LD4-LD7 (3 bits each) |
| I2C Pullup | 0x40060000 | 2 bits | - | No | Pull-up control |

#### AXI UART Lite (0x40600000)

| Offset | Register | Access | Description |
| -------- | ----------- | -------- | ----------------------------- |
| 0x00 | RX_FIFO | R | Receive Data FIFO (8 bits) |
| 0x04 | TX_FIFO | W | Transmit Data FIFO (8 bits) |
| 0x08 | STAT_REG | R | Status Register |
| 0x0C | CTRL_REG | R/W | Control Register |

**Status Register Bits:**

- Bit 0: RX_FIFO_VALID_DATA
- Bit 1: RX_FIFO_FULL
- Bit 2: TX_FIFO_EMPTY
- Bit 3: TX_FIFO_FULL
- Bit 4: INTR_ENABLED
- Bit 5: OVERRUN_ERROR
- Bit 6: FRAME_ERROR
- Bit 7: PARITY_ERROR

**Configuration:** 115200 baud, 8-N-1, 75 MHz AXI clock

#### AXI Quad SPI (Flash: 0x44A00000, External: 0x44A10000)

| Offset | Register | Access | Description |
| -------- | -------------- | -------- | -------------------------------- |
| 0x40 | SRR | W | Software Reset Register |
| 0x60 | SPICR | R/W | SPI Control Register |
| 0x64 | SPISR | R | SPI Status Register |
| 0x68 | SPI_DTR | W | SPI Data Transmit Register |
| 0x6C | SPI_DRR | R | SPI Data Receive Register |
| 0x70 | SPISSR | R/W | SPI Slave Select Register |
| 0x74 | TX_FIFO_OCR | R | Transmit FIFO Occupancy |
| 0x78 | RX_FIFO_OCR | R | Receive FIFO Occupancy |
| 0x1C | DGIER | R/W | Device Global Interrupt Enable |
| 0x20 | IPISR | R/TOW | IP Interrupt Status Register |
| 0x28 | IPIER | R/W | IP Interrupt Enable Register |

**SPI Flash Configuration:**

- Mode: Quad SPI
- Flash Device: Spansion compatible
- FIFO Depth: 256 bytes
- Clock: ~4.69 MHz (75 MHz / 16)

**SPI External Configuration:**

- Mode: Quad SPI
- Performance Mode: Enabled
- FIFO Depth: 256 bytes
- Clock: ~4.69 MHz (75 MHz / 16)

#### AXI IIC (I2C) (0x40800000)

| Offset | Register | Access | Description |
| -------- | ---------- | -------- | ------------- |
| 0x100 | GIE | R/W | Global Interrupt Enable |
| 0x104 | ISR | R/TOW | Interrupt Status Register |
| 0x108 | IER | R/W | Interrupt Enable Register |
| 0x110 | SOFTR | W | Soft Reset Register |
| 0x120 | CR | R/W | Control Register |
| 0x124 | SR | R | Status Register |
| 0x128 | TX_FIFO | W | Transmit FIFO |
| 0x12C | RX_FIFO | R | Receive FIFO |
| 0x130 | ADR | R/W | Address Register (slave mode) |
| 0x134 | TX_FIFO_OCY | R | TX FIFO Occupancy |
| 0x138 | RX_FIFO_OCY | R | RX FIFO Occupancy |
| 0x13C | TEN_ADR | R/W | 10-bit Address Register |
| 0x140 | RX_FIFO_PIRQ | R/W | RX FIFO Programmable Depth Int |
| 0x144 | GPO | R/W | General Purpose Output |

**I2C Configuration:**

- SCL Inertial Delay: 4 AXI clocks
- SDA Inertial Delay: 4 AXI clocks
- FIFO Depth: 16 bytes
- 10-bit addressing: Supported

#### AXI Ethernet Lite (0x40E00000)

| Offset | Register | Access | Description |
| -------- | ---------- | -------- | ------------- |
| 0x07F0 | TX_PING_LEN | R/W | Transmit Ping Frame Length |
| 0x07F4 | GIE | R/W | Global Interrupt Enable |
| 0x07F8 | TX_PING_CTRL | R/W | Transmit Ping Frame Control |
| 0x07FC | MDIO_CTRL | R/W | MDIO Control/Status |
| 0x0FF0 | TX_PONG_LEN | R/W | Transmit Pong Frame Length |
| 0x0FF4 | Reserved | - | - |
| 0x0FF8 | TX_PONG_CTRL | R/W | Transmit Pong Frame Control |
| 0x0FFC | RX_CTRL | R/W | Receive Frame Control |
| 0x0000-0x07EC | TX_PING_DATA | R/W | Transmit Ping Buffer (2KB) |
| 0x0800-0x0FEC | TX_PONG_DATA | R/W | Transmit Pong Buffer (2KB) |
| 0x1000-0x17EC | RX_PING_DATA | R | Receive Ping Buffer (2KB) |
| 0x1800-0x1FEC | RX_PONG_DATA | R | Receive Pong Buffer (2KB) |

**Ethernet Configuration:**

- PHY Interface: MII (Media Independent Interface)
- Speed: 10/100 Mbps
- Duplex: Full/Half (auto-negotiation)
- TX/RX Buffers: Ping-pong (2KB each)
- MDIO: Enabled for PHY management

#### AXI Timebase Watchdog Timer (0x41A00000)

| Offset | Register | Access | Description |
| -------- | ---------- | -------- | ------------- |
| 0x00 | TWCSR0 | R/W | Timebase Watchdog Control/Status 0 |
| 0x04 | TWCSR1 | R/W | Timebase Watchdog Control/Status 1 |
| 0x08 | TBR | R | Timebase Register |

**Watchdog Configuration:**

- Window WDT: Enabled
- Second Sequence Timer Width: 8 bits
- Clock: 75 MHz

### Physical Pin Mapping

#### UART (USB-UART Bridge)

|Signal|Pin|Package Pin|Arduino Shield|
|--------|------|-------------|----------------|
|RXD|A9|IOB_X0Y121|-|
|TXD|D10|IOB_X0Y111|-|

**Note:** UART is connected to on-board FTDI USB-UART bridge (typically /dev/ttyUSB0 on Linux)

#### Ethernet MII Interface

|Signal|Pin|Package Pin|Direction|
|--------|------|-------------|-----------|
|TX_CLK|H16|IOB_X0Y74|IN|
|TXD[0]|H14|IOB_X0Y70|OUT|
|TXD[1]|J14|IOB_X0Y62|OUT|
|TXD[2]|J13|IOB_X0Y65|OUT|
|TXD[3]|H17|IOB_X0Y64|OUT|
|TX_EN|H15|IOB_X0Y61|OUT|
|RX_CLK|F15|IOB_X0Y72|IN|
|RXD[0]|D18|IOB_X0Y57|IN|
|RXD[1]|E17|IOB_X0Y68|IN|
|RXD[2]|E18|IOB_X0Y58|IN|
|RXD[3]|G17|IOB_X0Y63|IN|
|RX_DV|G16|IOB_X0Y73|IN|
|RX_ER|C17|IOB_X0Y59|IN|
|CRS|G14|IOB_X0Y69|IN|
|COL|D17|IOB_X0Y67|IN|
|RST_N|C16|IOB_X0Y60|OUT|
|MDC|F16|IOB_X0Y71|OUT|
|MDIO|K13|IOB_X0Y66|INOUT|

**Electrical:** LVCMOS33, 12mA drive strength, SLOW slew rate

#### SPI Flash (On-board Quad-SPI Flash 16MB)

| Signal | Pin | Package Pin | Flash Connection |
| ------------ | ------ | ------------- | ----------------- |
| IO0 (MOSI) | K17 | IOB_X0Y48 | DQ0 |
| IO1 (MISO) | K18 | IOB_X0Y47 | DQ1 |
| IO2 (WP#) | L14 | IOB_X0Y46 | DQ2 |
| IO3 (HOLD#) | M14 | IOB_X0Y45 | DQ3 |
| SCK | L16 | IOB_X0Y43 | SCK |
| SS | L13 | IOB_X0Y38 | CS# |

#### External SPI (Arduino Shield SPI)

| Signal | Pin | Package Pin | Arduino Shield |
| -------- | ------ | ------------- | ---------------- |
| IO0 | H1 | IOB_X1Y66 | Shield SPI |
| IO1 | G1 | IOB_X1Y65 | Shield SPI |
| SCK | F1 | IOB_X1Y64 | Shield SPI |
| SS | V17 | IOB_X0Y13 | Shield SPI |

#### I2C (On-board and Shield)

| Signal | Pin | Package Pin | Connection |
| ----------- | ------ | ------------- | -------------------- |
| SCL | L18 | IOB_X0Y42 | On-board + Shield |
| SDA | M18 | IOB_X0Y41 | On-board + Shield |
| PULLUP[0] | A14 | IOB_X0Y81 | SDA Pull-up enable |
| PULLUP[1] | A13 | IOB_X0Y82 | SCL Pull-up enable |

**Note:** Pull-ups are GPIO-controlled (0x40060000)

#### User LEDs (Standard)

| LED | Bit | Pin | Package Pin | Color |
| ----- | ----- | ----- | ------------- | ------- |
| LD0 | 0 | H5 | IOB_X1Y51 | Green |
| LD1 | 1 | J5 | IOB_X1Y50 | Green |
| LD2 | 2 | T9 | IOB_X0Y2 | Green |
| LD3 | 3 | T10 | IOB_X0Y1 | Green |

**Base Address:** 0x40040000

#### RGB LEDs (4 LEDs × 3 colors each)

| LED | Red Bit | Green Bit | Blue Bit | Pins (R/G/B) |
| ----- | --------- | ----------- | ---------- | -------------- |
| LD4 | 0 | 1 | 2 | E1/F6/G6 |
| LD5 | 3 | 4 | 5 | G4/J4/G3 |
| LD6 | 6 | 7 | 8 | H4/J2/J3 |
| LD7 | 9 | 10 | 11 | K2/H6/K1 |

**Base Address:** 0x40050000
**Register:** 12-bit GPIO_DATA (bits [11:0])

#### Push Buttons

| Button | Bit | Pin | Package Pin | Label |
| -------- | ----- | ----- | ------------- | ------- |
| BTN0 | 0 | D9 | IOB_X0Y137 | BTN0 |
| BTN1 | 1 | C9 | IOB_X0Y128 | BTN1 |
| BTN2 | 2 | B9 | IOB_X0Y127 | BTN2 |
| BTN3 | 3 | B8 | IOB_X0Y126 | BTN3 |

**Base Address:** 0x40020000
**Note:** Active HIGH, generates interrupt on press

#### DIP Switches

| Switch | Bit | Pin | Package Pin | Label |
| -------- | ----- | ----- | ------------- | ------- |
| SW0 | 0 | A8 | IOB_X0Y125 | SW0 |
| SW1 | 1 | C11 | IOB_X0Y124 | SW1 |
| SW2 | 2 | C10 | IOB_X0Y123 | SW2 |
| SW3 | 3 | A10 | IOB_X0Y122 | SW3 |

**Base Address:** 0x40030000
**Note:** ON = 1, OFF = 0

#### Arduino Shield GPIO Pins (0-19)

**Base Address:** 0x40000000 (20-bit GPIO)

| Bit | Arduino Pin | FPGA Pin | Package Pin | Notes |
| ----- | ------------- | ---------- | ------------- | ---------------- |
| 0 | D0 | V15 | IOB_X0Y18 | Digital I/O |
| 1 | D1 | U16 | IOB_X0Y14 | Digital I/O |
| 2 | D2 | P14 | IOB_X0Y33 | Digital I/O |
| 3 | D3 | T11 | IOB_X0Y12 | PWM capable |
| 4 | D4 | R12 | IOB_X0Y40 | Digital I/O |
| 5 | D5 | T14 | IOB_X0Y22 | PWM capable |
| 6 | D6 | T15 | IOB_X0Y21 | PWM capable |
| 7 | D7 | T16 | IOB_X0Y19 | Digital I/O |
| 8 | D8 | N15 | IOB_X0Y28 | Digital I/O |
| 9 | D9 | M16 | IOB_X0Y30 | PWM capable |
| 10 | D10/SS | C1 | IOB_X1Y67 | SPI SS |
| 11 | D11/MOSI | U18 | IOB_X0Y15 | SPI MOSI |
| 12 | D12/MISO | R17 | IOB_X0Y25 | SPI MISO |
| 13 | D13/SCK | P17 | IOB_X0Y26 | SPI SCK/LED |
| 14 | A0 | F5 | IOB_X1Y99 | Analog/Digital |
| 15 | A1 | D8 | IOB_X1Y92 | Analog/Digital |
| 16 | A2 | C7 | IOB_X1Y91 | Analog/Digital |
| 17 | A3 | E7 | IOB_X1Y88 | Analog/Digital |
| 18 | A4/SDA | D7 | IOB_X1Y87 | I2C SDA |
| 19 | A5/SCL | D5 | IOB_X1Y78 | I2C SCL |

#### Arduino Shield GPIO Pins (26-41)

**Base Address:** 0x40010000 (16-bit GPIO)

| Bit | Arduino Pin | FPGA Pin | Package Pin | Notes |
| ----- | ------------- | ---------- | ------------- | ------------- |
| 0 | D26 | U11 | IOB_X0Y11 | Digital I/O |
| 1 | D27 | V16 | IOB_X0Y17 | Digital I/O |
| 2 | D28 | M13 | IOB_X0Y37 | Digital I/O |
| 3 | D29 | R10 | IOB_X0Y0 | Digital I/O |
| 4 | D30 | R11 | IOB_X0Y49 | Digital I/O |
| 5 | D31 | R13 | IOB_X0Y39 | Digital I/O |
| 6 | D32 | R15 | IOB_X0Y23 | Digital I/O |
| 7 | D33 | P15 | IOB_X0Y24 | Digital I/O |
| 8 | D34 | R16 | IOB_X0Y20 | Digital I/O |
| 9 | D35 | N16 | IOB_X0Y27 | Digital I/O |
| 10 | D36 | N14 | IOB_X0Y34 | Digital I/O |
| 11 | D37 | U17 | IOB_X0Y16 | Digital I/O |
| 12 | D38 | T18 | IOB_X0Y35 | Digital I/O |
| 13 | D39 | R18 | IOB_X0Y36 | Digital I/O |
| 14 | D40 | P18 | IOB_X0Y31 | Digital I/O |
| 15 | D41 | N17 | IOB_X0Y32 | Digital I/O |

**Note:** All GPIO configured as LVCMOS33, 12mA drive, SLOW slew rate

### System Clocks and Timing

#### Clock Configuration

| Clock Domain | Frequency | Source | Description |
| -------------- | ----------- | ---------------- | -------------------------------- |
| sys_clock | 100 MHz | External | Input clock from board oscillator |
| clk_out1 | 75 MHz | Clocking Wizard | Main system clock (AXI, CPU) |

**Input Clock Constraint:** `create_clock -period 10.000 [get_ports sys_clock]`

**Clock Tree:**

```text
Board Oscillator (100 MHz)
    └─> sys_clock (E3 pin)
        └─> mbv_clocking_wizard (Clocking Wizard v6.0)
            └─> clk_out1 (75 MHz)
                ├─> MicroBlaze V CPU
                ├─> AXI SmartConnect
                ├─> All AXI Peripherals
                └─> Local Memory (BRAM)
```

#### Peripheral Clock Dependencies

All peripherals operate on the 75 MHz system clock:

- **UART Baud Rate Calculation:** 75,000,000 / (16 × 115,200) = 40.69 (configured automatically)
- **FIT Timer (1ms):** 75,000 clocks = 1ms period
- **SPI Clock:** 75 MHz / 16 = 4.6875 MHz
- **I2C Clock:** Software configurable via divisor registers

### Reset Configuration

|Signal|Pin|Active|Source|Description|
|--------|-----|--------|--------------|----------------------------|
|reset|C2|HIGH|Board Button|System reset (BTN_CPU_RESET)|

**Reset Tree:**

```text
reset (C2) -> mbv_processor_system_reset
    ├─> peripheral_aresetn (Active LOW to peripherals)
    ├─> interconnect_aresetn (Active LOW to AXI interconnect)
    └─> mb_reset (Active HIGH to MicroBlaze V)
```

### Power Supply (VCCO) Information

|Bank|VCCO Voltage|Usage|
|------|--------------|----------------------------------------|
|14|3.30V|Arduino shield, SPI flash, some GPIO|
|15|3.30V|Ethernet, I2C|
|16|3.30V|UART, buttons, switches|
|34|TBD|Additional I/O (not fully utilized)|
|35|3.30V|RGB LEDs, some shield pins, system clock|

### Boot and Debug Configuration

#### Boot Mode

- **Boot Mode:** JTAG or SPI Flash (M[2:0] pins)
- **JTAG Pins:** TCK, TDI, TDO, TMS (standard JTAG)
- **Programming Interface:** USB-JTAG (on-board Digilent JTAG-HS2)

#### Debug Interface

**MicroBlaze Debug Module (MDM) Features:**

- **External Trace:** Enabled (16-bit trace data width)
- **JTAG Debug:** Full JTAG debug support via USB
- **Breakpoints:** 8 PC breakpoints
- **Watchpoints:** 4 read + 4 write address watchpoints
- **Real-time Trace:** 16-bit external trace interface for waveform analysis

**Debug Workflow:**

1. Connect via Vitis/XSCT using `connect` command
2. Download ELF via JTAG: `dow <file.elf>`
3. Set breakpoints: `bpadd <address>`
4. Run: `con` or single-step: `stp`

### Hardware Limitations and Constraints

#### Memory Constraints

- **Total BRAM:** 128 KB (shared instruction/data)
- **No DDR3 in this design** (board has 256MB DDR3, but not configured in hardware)
- **No instruction cache:** Direct BRAM access only
- **No data cache:** Direct BRAM access only
- **Stack/Heap:** Must fit within 128 KB BRAM

**Recommended Memory Allocation:**

```text
0x00000000 - 0x00013FFF: Code + Read-only data (80 KB)
0x00014000 - 0x00017FFF: Heap (16 KB)
0x00018000 - 0x0001FFFF: Stack (32 KB, grows downward from 0x0001FFFF)
```

#### Performance Characteristics

- **CPU Clock:** 75 MHz
- **IPC:** ~1.0 (performance optimized, no cache)
- **Memory Latency:** 1-2 cycles (BRAM access)
- **AXI Peripheral Access:** 2-5 cycles (depending on peripheral)
- **Interrupt Latency:** ~20-50 cycles (depends on pipeline state)

#### Peripheral Limitations

- **UART:** 16-byte TX/RX FIFOs, no hardware flow control
- **SPI:** 256-byte FIFOs, max ~4.69 MHz clock
- **I2C:** 16-byte FIFOs, standard/fast mode
- **Ethernet:** No DMA, software polling or interrupt-driven only
- **GPIO:** No hardware PWM (must be software-generated)
- **Watchdog:** Cannot be disabled once enabled (requires reset)

### RTOS Considerations

#### Critical Design Factors

1. **Memory Constraints:** 128 KB total (code + data + stack)
   - Use static allocation where possible
   - Minimize dynamic memory allocation
   - Consider lightweight RTOS (FreeRTOS, Zephyr, custom)

2. **Interrupt Prioritization:**
   - 11 interrupt sources, all at same priority level
   - Software must implement priority handling
   - Nested interrupts supported by RISC-V architecture

3. **Timer Resources:**
   - 1ms FIT timer for system tick
   - Watchdog timer for safety monitoring
   - No hardware PWM timers

4. **Communication Buffers:**
   - UART: 16-byte hardware FIFOs (software buffers recommended)
   - SPI: 256-byte FIFOs
   - I2C: 16-byte FIFOs
   - Ethernet: 2KB ping-pong buffers (4KB total)

5. **Real-time Performance:**
   - Deterministic interrupt latency (~20-50 cycles)
   - No cache = predictable memory access
   - AXI interconnect may add arbitration delays

#### Recommended RTOS Features

- **Preemptive scheduling** with priority-based task management
- **Mutex/Semaphore** for resource protection
- **Message queues** for inter-task communication
- **Software timers** using 1ms tick
- **Interrupt management** for 11 hardware sources
- **Memory pools** for fixed-size allocation (avoid fragmentation)

### Development Tools and References

#### Required Tools

- **Xilinx Vitis 2025.2** or **Vitis Classic 2025.2**
- **RISC-V GNU Toolchain** (included with Vitis)
- **OpenOCD** or **Xilinx System Debugger (XSCT)**
- **Serial Terminal** (115200 8-N-1)

#### Documentation Links

- AMD Vivado/Vitis Documentation: [docs.amd.com](https://docs.amd.com)
- MicroBlaze V Reference (UG1629): [MicroBlaze V Processor Reference Guide](https://docs.amd.com/r/en-US/ug1629-microblaze-v)
- MicroBlaze V Embedded Design (UG1711): [MicroBlaze V Processor Embedded Design User Guide](https://docs.amd.com/r/en-US/ug1711-mbv-embedded-design)
- Vitis Embedded Software (UG1400): [Vitis Embedded Software Development](https://docs.amd.com/r/en-US/ug1400-vitis-embedded)
- AXI Reference Guide (UG1037): Available in Vivado documentation

#### Example Code Structure

```c
/* Minimal bare-metal example */
#include "xparameters.h"     /* Hardware addresses from BSP */
#include "xil_io.h"          /* Xil_In32(), Xil_Out32() */
#include "xintc.h"           /* Interrupt controller */

/* Peripheral base addresses (from xparameters.h) */
#define LED_BASE    XPAR_AXI_GPIO_LED_4_BITS_BASEADDR
#define UART_BASE   XPAR_AXI_UARTLITE_BASEADDR
#define INTC_BASE   XPAR_AXI_INTC_BASEADDR

/* Simple LED blink */
void blink_led(void) {
    static uint32_t state = 0;
    Xil_Out32(LED_BASE + 0x00, state);  /* GPIO_DATA */
    state ^= 0x0F;
}

/* UART transmit */
void uart_putc(char c) {
    while (Xil_In32(UART_BASE + 0x08) & 0x08);  /* Wait for TX_FIFO not full */
    Xil_Out32(UART_BASE + 0x04, c);              /* Write to TX_FIFO */
}

int main(void) {
    /* Initialize hardware */
    init_platform();

    /* Setup 1ms timer interrupt */
    setup_timer_interrupt();

    /* Main loop */
    while (1) {
        /* RTOS scheduler or application code */
    }
}
```

### Register Access Macros

```c
/* Safe register access macros */
#define REG_READ(addr)          Xil_In32((addr))
#define REG_WRITE(addr, val)    Xil_Out32((addr), (val))
#define REG_SET_BITS(addr, mask)   REG_WRITE((addr), REG_READ(addr) | (mask))
#define REG_CLR_BITS(addr, mask)   REG_WRITE((addr), REG_READ(addr) & ~(mask))

/* GPIO helper macros */
#define GPIO_SET_OUTPUT(base, pin)  REG_CLR_BITS((base) + 0x04, (1 << (pin)))
#define GPIO_SET_INPUT(base, pin)   REG_SET_BITS((base) + 0x04, (1 << (pin)))
#define GPIO_WRITE(base, pin, val)  \
    do { \
        uint32_t data = REG_READ((base)); \
        if (val) data |= (1 << (pin)); \
        else data &= ~(1 << (pin)); \
        REG_WRITE((base), data); \
    } while(0)
#define GPIO_READ(base, pin)        ((REG_READ(base) >> (pin)) & 1)
```

---

## Appendix: Quick Reference Tables

### All Peripheral Base Addresses

|Peripheral|Base Address|Size|IRQ|Description|
|---------------------|--------------|------|-----|--------------------------------|
|BRAM|0x00000000|128KB|-|Local instruction/data memory|
|GPIO Shield 0-19|0x40000000|64KB|4|Arduino pins 0-19|
|GPIO Shield 26-41|0x40010000|64KB|5|Arduino pins 26-41|
|GPIO Buttons|0x40020000|64KB|6|Push buttons BTN0-3|
|GPIO Switches|0x40030000|64KB|7|DIP switches SW0-3|
|GPIO LEDs|0x40040000|64KB|-|Standard LEDs LD0-3|
|GPIO RGB|0x40050000|64KB|-|RGB LEDs LD4-7|
|GPIO I2C Pullup|0x40060000|64KB|-|I2C pull-up control|
|UART|0x40600000|64KB|2|USB-UART (115200 8-N-1)|
|I2C|0x40800000|64KB|10|I2C bus controller|
|Ethernet|0x40E00000|64KB|8|10/100 Ethernet MAC|
|Interrupt Ctrl|0x41200000|64KB|-|AXI Interrupt Controller|
|Watchdog|0x41A00000|64KB|1|Timebase watchdog timer|
|SPI Flash|0x44A00000|64KB|3|Quad-SPI flash (16MB)|
|SPI External|0x44A10000|64KB|9|Quad-SPI external devices|

### IRQ Priority Recommendations for RTOS

|Priority|IRQ #|Source|Rationale|
|--------------|-------|-----------------|--------------------------------|
|1 (Highest)|0|FIT Timer|System tick - critical for scheduling|
|2|1|Watchdog|Safety-critical timeout|
|3|2|UART|Time-sensitive communication|
|4|8|Ethernet|Network packet handling|
|5|3,9|SPI|Data transfer completion|
|6|10|I2C|Bus transaction completion|
|7|4,5|Shield GPIO|External events|
|8 (Lowest)|6,7|Buttons/Switches|User input (lowest priority)|

**Note:** Hardware does not support priority levels. Implement in software ISR dispatcher.

---

## Summary for Software Developers

This hardware platform provides:

- **Processor:** RISC-V RV32IMACB @ 75 MHz (MicroBlaze V)
- **Memory:** 128 KB BRAM (no caching, deterministic access)
- **Peripherals:** UART, SPI×2, I2C, Ethernet, GPIO, Timers
- **Interrupts:** 11 sources via AXI Interrupt Controller
- **Debug:** JTAG with hardware breakpoints and trace support
- **I/O:** 36 Arduino-compatible GPIO, 4 LEDs, 4 RGB LEDs, 4 buttons, 4 switches

**Key Software Constraints:**

- 128 KB total memory (code + data + stack)
- No MMU (bare-metal or RTOS only)
- No hardware floating-point (soft-float libraries required)
- No DMA (all I/O is programmed/interrupt-driven)
- Limited peripheral FIFOs (requires careful buffer management)

This platform is ideal for embedded RTOS development, IoT applications, and educational purposes.
