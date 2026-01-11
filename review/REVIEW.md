# Project Review

## Data Consistency Review - January 11, 2026

### Summary

A comprehensive review of data consistency between the BSP documentation ([bsp/README.md](../bsp/README.md)), hardware documentation ([hardware/README.md](../hardware/README.md)), and the actual configuration files (device tree, YAML configs, address segments) was performed.

---

## ✅ Verified Consistent Data

### Memory Map
- **BRAM**: 0x00000000 - 0x0001FFFF (128 KB) - ✅ Consistent across all sources
- **All peripheral addresses**: ✅ Consistent between hardware/README.md, bsp/README.md, address_segments.csv, and device tree files

### Processor Configuration
- **Clock Frequency**: 75 MHz (0x47868c0 Hz) - ✅ Consistent
- **Architecture**: rv32imacb_zicsr_zifencei_zbc - ✅ Consistent
- **ABI**: ilp32 - ✅ Consistent
- **MMU**: SV32 (Supervisor mode, use-mmu = 3) - ✅ Consistent
- **Caches**: Disabled - ✅ Consistent
- **PC Breakpoints**: 8 - ✅ Consistent
- **Read/Write Watchpoints**: 4 each - ✅ Consistent
- **Event Counters**: 13 - ✅ Consistent
- **Latency Counters**: 8 - ✅ Consistent

### Peripheral Configuration
- **UART**: 115200 baud, 8-N-1 - ✅ Consistent (device tree: 0x1c200 = 115200)
- **I2C Delays**: SCL=4, SDA=4 AXI clocks - ✅ Consistent
- **SPI Flash FIFO**: 256 entries - ✅ Consistent
- **Watchdog Window WDT**: Enabled - ✅ Consistent

---

## ⚠️ Inconsistencies Found

### 1. CRITICAL: Interrupt Number Mapping Mismatch

**Location**: [bsp/README.md](../bsp/README.md#interrupt-mapping) vs [hardware/README.md](../hardware/README.md#interrupt-vector-table) vs Device Tree

| Peripheral | BSP README | Hardware README | Device Tree (actual) |
|------------|------------|-----------------|----------------------|
| Ethernet Lite | IRQ 0 | IRQ 8 | `interrupts = <0x8 0x0>` |
| Watchdog Timer | IRQ 1, 10 | IRQ 1 | `interrupts = <0x1 0x2>` |
| FIT Timer 1ms | Not listed | IRQ 0 | Not in device tree (direct signal) |
| I2C (IIC) | IRQ 8 | IRQ 10 | `interrupts = <0xa 0x2>` (0xa = 10) |

**Analysis**:
- The **device tree is the authoritative source** as it's generated from the hardware design
- The BSP README shows IRQ assignments that **do not match** the device tree
- The Hardware README IRQ table is **correct** and matches the device tree

**Actual IRQ Mapping (from device tree)**:
| IRQ # | Peripheral | Device Tree Evidence |
|-------|------------|---------------------|
| 0 | FIT Timer 1ms | (direct connection, not in DTS) |
| 1 | Watchdog Timer | `interrupts = <0x1 0x2>` |
| 2 | UART Lite | `interrupts = <0x2 0x0>` |
| 3 | SPI Flash | `interrupts = <0x3 0x0>` |
| 4 | GPIO Shield 0-19 | `interrupts = <0x4 0x2>` |
| 5 | GPIO Shield 26-41 | `interrupts = <0x5 0x2>` |
| 6 | GPIO Push Buttons | `interrupts = <0x6 0x2>` |
| 7 | GPIO DIP Switches | `interrupts = <0x7 0x2>` |
| 8 | Ethernet Lite | `interrupts = <0x8 0x0>` |
| 9 | SPI External | `interrupts = <0x9 0x0>` |
| 10 | I2C (IIC) | `interrupts = <0xa 0x2>` |

**Required Action**: Update [bsp/README.md](../bsp/README.md) interrupt mapping table to match device tree values.

---

### 2. MEDIUM: Driver Version Inconsistencies

**Location**: [bsp/README.md](../bsp/README.md#driver-support-and-api-reference) vs [bsp/bsp.yaml](../bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml)

| Driver | BSP README States | bsp.yaml Path Shows |
|--------|-------------------|---------------------|
| uartlite | v2.0 | `uartlite_v3_12` |
| wdttb | v3.0 | `wdttb_v5_11` |
| bram | Not specified | `bram_v4_13` |

**Required Action**: Update BSP README driver versions to match actual bsp.yaml paths.

---

### 3. MINOR: SPI Configuration Discrepancies

**Location**: [bsp/README.md](../bsp/README.md#4-spi-driver-spi-v415) vs Device Tree

**BSP README states (SPI Flash)**:
- SCK Ratio: 2 (37.5 MHz SPI clock)
- SPI Mode: Mode 2 (CPOL=1, CPHA=0)

**Device Tree shows (mbv_axi_quad_spi_flash)**:
- `xlnx,sck-ratio = <0x2>` ✅ Matches
- `xlnx,spi-mode = <0x2>` ✅ Matches

**BSP README states (SPI External)**:
- SCK Ratio: 16 (4.6875 MHz SPI clock)
- SPI Mode: Mode 0 (CPOL=0, CPHA=0)

**Device Tree shows (mbv_axi_quad_spi)**:
- `xlnx,sck-ratio = <0x10>` (16) ✅ Matches
- `xlnx,spi-mode = <0x0>` ✅ Matches

**Status**: ✅ Actually consistent upon closer review.

---

### 4. MINOR: Ethernet MAC Address

**Location**: [bsp/README.md](../bsp/README.md#5-ethernet-lite-driver-emaclite-v412) vs Device Tree

| Source | MAC Address |
|--------|-------------|
| BSP README | 00:0A:35:00:01:02 |
| Device Tree | 00:0A:23:00:00:00 |

**Device Tree**: `local-mac-address = [00 0A 23 00 00 00];`

**Required Action**: Update BSP README to note the default MAC from device tree, and clarify this is configurable at runtime.

---

### 5. MINOR: Missing FIT Timer Documentation

**Location**: [bsp/README.md](../bsp/README.md)

The Fixed Interval Timer (`mbv_fixed_interval_timer_1_millisecond`) is documented in the hardware README but **not covered** in the BSP README driver documentation.

**Hardware README States**:
- Number of clocks: 75000 (1ms @ 75 MHz)
- Generates IRQ 0

**Required Action**: Add FIT Timer section to BSP README under Driver Support.

---

### 6. INFO: Watchdog Timer Second Interrupt

**Location**: [bsp/README.md](../bsp/README.md#interrupt-mapping)

BSP README lists Watchdog with "IRQ 1, 10" suggesting two interrupts, but:
- Device tree shows only: `interrupts = <0x1 0x2>` (single interrupt)
- Hardware README shows only IRQ 1

**Clarification**: The device tree only shows one interrupt connection. The "second window timeout" may be a feature of the IP but isn't wired as a separate IRQ in this design.

**Required Action**: Clarify in BSP README that only IRQ 1 is connected.

---

## Action Items

| Priority | Item | File(s) to Update | Status |
|----------|------|-------------------|--------|
| 🔴 HIGH | Fix interrupt mapping table | bsp/README.md | ✅ FIXED |
| 🟡 MEDIUM | Update driver versions | bsp/README.md | ✅ FIXED |
| 🟢 LOW | Correct default MAC address | bsp/README.md | ✅ FIXED |
| 🟢 LOW | Add FIT Timer documentation | bsp/README.md | ✅ FIXED |
| 🟢 LOW | Clarify single watchdog IRQ | bsp/README.md | ✅ FIXED |

**All issues resolved on January 11, 2026.**

---

## Validation Methodology

Files compared:
1. `bsp/README.md` - BSP documentation
2. `hardware/README.md` - Hardware documentation  
3. `bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/bsp.yaml` - BSP configuration
4. `bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/hw_artifacts/mbv_microblaze_v_baremetal.dts` - Device tree (authoritative)
5. `hardware/artifacts/address_segments/rv32imacb_zicsr_zifencei_zbc-address_segments.csv` - Address map
6. `bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/cflags.yaml` - Compiler flags
7. `bsp/mbv_microblaze_v/standalone_mbv_microblaze_v/bsp/include/bspconfig.h` - BSP config header

---

*Review performed: January 11, 2026*
*Reviewer: GitHub Copilot Deep Review*
