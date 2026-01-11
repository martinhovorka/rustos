# Board Support Package (BSP) - README

## Overview

This directory contains the Vitis 2025.2 workspace with Board Support Package (BSP) and platform configuration for the RISC-V based hardware design. The BSP provides essential drivers, libraries, and runtime support for embedded software development on the `rv32imacb_zicsr_zifencei_zbc` RISC-V processor.

## Directory Structure

### Main Platform Project: [rv32imacb_zicsr_zifencei_zbc](./rv32imacb_zicsr_zifencei_zbc/)

This is a **Hardware Platform Project** that contains:

- **vitis-comp.json** - Platform configuration file defining:
  - Platform type: EMBEDDED FPGA
  - Processor mapping: `mbv_microblaze_v` → `microblaze_riscv`
  - Supported operating systems: `standalone`, `linux`
  - XSA hardware specification path
- **hw/** - Hardware specification directory:
  - `rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa` - Exported hardware platform from Vivado
  - `sdt/` - System Device Tree files for hardware description

- **mbv_microblaze_v/** - Processor-specific BSP:
  - `standalone_mbv_microblaze_v/` - Standalone BSP domain for bare-metal applications
  - Contains drivers and libraries for the RISC-V processor

- **resources/** - Additional platform resources:
  - `qemu/` - QEMU emulation configuration (if applicable)
  - `standalone_mbv_microblaze_v/` - Standalone domain resources

- **export/** - Exported platform files:
  - `rv32imacb_zicsr_zifencei_zbc/` - Complete exported platform for use in application projects

- **logs/** - Build and generation logs from Vitis

### Supported Domains

- **standalone_mbv_microblaze_v**: Bare-metal standalone domain for RISC-V processor
  - No operating system overhead
  - Direct hardware access
  - Optimized for real-time and embedded applications

### Driver Support

The BSP includes drivers for all peripherals in the hardware design, including:

- **AXI GPIO** - General-purpose I/O control
- **AXI UART Lite** - Serial communication (configured as stdin/stdout)
- **AXI Quad SPI** - SPI flash and external device communication
- **AXI Ethernet Lite** - 10/100 Mbps Ethernet connectivity
- **AXI IIC (I2C)** - I2C bus communication
- **AXI Interrupt Controller** - Centralized interrupt management
- **AXI Timer/Watchdog** - System timing and watchdog functionality
- **Memory controllers (LMB BRAM)** - High-speed local memory access
- **Debug Module (MDM)** - JTAG debugging support

**Standard I/O Configuration**:

- `stdin`: mbv_axi_uartlite
- `stdout`: mbv_axi_uartlite

### Processor Architecture

The platform is built for the **rv32imacb_zicsr_zifencei_zbc** RISC-V ISA:

- 32-bit RISC-V with integer, multiply, atomic, floating-point, compressed instructions
- CSR support (Zicsr) and instruction fence (Zifencei)
- Bit manipulation with carry-less multiply (Zbc)
- Compatible with GCC toolchain:
  - Compilation flags: `-march=rv32imacb_zicsr_zifencei_zbc -mabi=ilp32f`
  - Linking flags: `-march=rv32imacb_zicsr_zifencei_zbcf`

## Usage

### Importing the Platform

1. Open Vitis 2025.2
2. From the menu: **File → Import → Vitis Platform**
3. Select the exported platform directory: `export/rv32imacb_zicsr_zifencei_zbc/`
4. The platform will be added to your workspace

### Creating an Application

1. Create a new application project: **File → New → Application Project**
2. Select the `rv32imacb_zicsr_zifencei_zbc` platform
3. Choose the `standalone_mbv_microblaze_v` domain
4. Select an application template (e.g., "Hello World")
5. Build and debug/run your application on the RISC-V processor

### Platform Configuration

The platform is pre-configured with:

- **Local Memory**: 128 KB
- **Clock Frequency**: 75 MHz (via Clocking Wizard)
- **Debug**: Enabled (via MDM)
- **Interrupts**: AXI Interrupt Controller enabled
- **Peripheral Access**: Via AXI interconnect

## Regenerating the BSP

If you modify the hardware design (XSA file), regenerate the BSP:

1. Update the XSA file in: `rv32imacb_zicsr_zifencei_zbc/hw/`
2. Right-click the platform project → **Update Hardware Specification**
3. Build the platform project to regenerate BSP files
4. Rebuild any application projects using this platform

## Troubleshooting

### Common Issues

- **Build errors after hardware changes**: Regenerate the BSP and clean/rebuild applications
- **Missing drivers**: Ensure all hardware peripherals are properly included in the XSA
- **UART not working**: Verify mbv_axi_uartlite is configured in hardware and BSP
- **Application won't debug**: Check JTAG connection and ensure MDM is enabled in hardware

### Platform Verification

Verify the platform configuration:

```bash
cd rv32imacb_zicsr_zifencei_zbc
cat vitis-comp.json  # View platform configuration
cat mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml  # View BSP settings
```

## Related Resources

- Hardware design details: [../hw/README.md](../hw/README.md)
- Hardware platform XSA: [rv32imacb_zicsr_zifencei_zbc/hw/rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa](./rv32imacb_zicsr_zifencei_zbc/hw/rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa)
- Original Vivado project: [../hw/rv32imacb_zicsr_zifencei_zbc/](../hw/rv32imacb_zicsr_zifencei_zbc/)
- Vitis Unified IDE Documentation: [AMD Vitis Unified Software Platform Documentation](https://docs.amd.com/r/en-US/ug1400-vitis-embedded)

## Tools Version

- **Vitis**: 2025.2
- **Vivado**: 2025.2
- **Target Board**: Digilent Arty A7-35 (XC7A35TICSG324-1L)
