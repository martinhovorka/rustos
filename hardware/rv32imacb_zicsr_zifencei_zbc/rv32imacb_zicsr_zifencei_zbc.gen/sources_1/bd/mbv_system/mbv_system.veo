// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
// DO NOT MODIFY THIS FILE.

// MODULE VLNV: amd.com:blockdesign:mbv_system:1.0

// The following must be inserted into your Verilog file for this
// module to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

// INST_TAG     ------ Begin cut for INSTANTIATION Template ------
mbv_system your_instance_name (
  .usb_uart_rxd(usb_uart_rxd), // input wire usb_uart_rxd
  .usb_uart_txd(usb_uart_txd), // output wire usb_uart_txd
  .qspi_flash_io0_i(qspi_flash_io0_i), // input wire qspi_flash_io0_i
  .qspi_flash_io0_o(qspi_flash_io0_o), // output wire qspi_flash_io0_o
  .qspi_flash_io0_t(qspi_flash_io0_t), // output wire qspi_flash_io0_t
  .qspi_flash_io1_i(qspi_flash_io1_i), // input wire qspi_flash_io1_i
  .qspi_flash_io1_o(qspi_flash_io1_o), // output wire qspi_flash_io1_o
  .qspi_flash_io1_t(qspi_flash_io1_t), // output wire qspi_flash_io1_t
  .qspi_flash_io2_i(qspi_flash_io2_i), // input wire qspi_flash_io2_i
  .qspi_flash_io2_o(qspi_flash_io2_o), // output wire qspi_flash_io2_o
  .qspi_flash_io2_t(qspi_flash_io2_t), // output wire qspi_flash_io2_t
  .qspi_flash_io3_i(qspi_flash_io3_i), // input wire qspi_flash_io3_i
  .qspi_flash_io3_o(qspi_flash_io3_o), // output wire qspi_flash_io3_o
  .qspi_flash_io3_t(qspi_flash_io3_t), // output wire qspi_flash_io3_t
  .qspi_flash_sck_i(qspi_flash_sck_i), // input wire qspi_flash_sck_i
  .qspi_flash_sck_o(qspi_flash_sck_o), // output wire qspi_flash_sck_o
  .qspi_flash_sck_t(qspi_flash_sck_t), // output wire qspi_flash_sck_t
  .qspi_flash_ss_i(qspi_flash_ss_i), // input wire qspi_flash_ss_i
  .qspi_flash_ss_o(qspi_flash_ss_o), // output wire qspi_flash_ss_o
  .qspi_flash_ss_t(qspi_flash_ss_t), // output wire qspi_flash_ss_t
  .shield_dp0_dp19_tri_i(shield_dp0_dp19_tri_i), // input wire [19:0] shield_dp0_dp19_tri_i
  .shield_dp0_dp19_tri_o(shield_dp0_dp19_tri_o), // output wire [19:0] shield_dp0_dp19_tri_o
  .shield_dp0_dp19_tri_t(shield_dp0_dp19_tri_t), // output wire [19:0] shield_dp0_dp19_tri_t
  .shield_dp26_dp41_tri_i(shield_dp26_dp41_tri_i), // input wire [15:0] shield_dp26_dp41_tri_i
  .shield_dp26_dp41_tri_o(shield_dp26_dp41_tri_o), // output wire [15:0] shield_dp26_dp41_tri_o
  .shield_dp26_dp41_tri_t(shield_dp26_dp41_tri_t), // output wire [15:0] shield_dp26_dp41_tri_t
  .push_buttons_4bits_tri_i(push_buttons_4bits_tri_i), // input wire [3:0] push_buttons_4bits_tri_i
  .dip_switches_4bits_tri_i(dip_switches_4bits_tri_i), // input wire [3:0] dip_switches_4bits_tri_i
  .led_4bits_tri_o(led_4bits_tri_o), // output wire [3:0] led_4bits_tri_o
  .rgb_led_tri_o(rgb_led_tri_o), // output wire [11:0] rgb_led_tri_o
  .eth_mii_col(eth_mii_col), // input wire eth_mii_col
  .eth_mii_crs(eth_mii_crs), // input wire eth_mii_crs
  .eth_mii_rst_n(eth_mii_rst_n), // output wire eth_mii_rst_n
  .eth_mii_rx_clk(eth_mii_rx_clk), // input wire eth_mii_rx_clk
  .eth_mii_rx_dv(eth_mii_rx_dv), // input wire eth_mii_rx_dv
  .eth_mii_rx_er(eth_mii_rx_er), // input wire eth_mii_rx_er
  .eth_mii_rxd(eth_mii_rxd), // input wire [3:0] eth_mii_rxd
  .eth_mii_tx_clk(eth_mii_tx_clk), // input wire eth_mii_tx_clk
  .eth_mii_tx_en(eth_mii_tx_en), // output wire eth_mii_tx_en
  .eth_mii_txd(eth_mii_txd), // output wire [3:0] eth_mii_txd
  .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc), // output wire eth_mdio_mdc_mdc
  .eth_mdio_mdc_mdio_i(eth_mdio_mdc_mdio_i), // input wire eth_mdio_mdc_mdio_i
  .eth_mdio_mdc_mdio_o(eth_mdio_mdc_mdio_o), // output wire eth_mdio_mdc_mdio_o
  .eth_mdio_mdc_mdio_t(eth_mdio_mdc_mdio_t), // output wire eth_mdio_mdc_mdio_t
  .spi_io0_i(spi_io0_i), // input wire spi_io0_i
  .spi_io0_o(spi_io0_o), // output wire spi_io0_o
  .spi_io0_t(spi_io0_t), // output wire spi_io0_t
  .spi_io1_i(spi_io1_i), // input wire spi_io1_i
  .spi_io1_o(spi_io1_o), // output wire spi_io1_o
  .spi_io1_t(spi_io1_t), // output wire spi_io1_t
  .spi_sck_i(spi_sck_i), // input wire spi_sck_i
  .spi_sck_o(spi_sck_o), // output wire spi_sck_o
  .spi_sck_t(spi_sck_t), // output wire spi_sck_t
  .spi_ss_i(spi_ss_i), // input wire spi_ss_i
  .spi_ss_o(spi_ss_o), // output wire spi_ss_o
  .spi_ss_t(spi_ss_t), // output wire spi_ss_t
  .i2c_scl_i(i2c_scl_i), // input wire i2c_scl_i
  .i2c_scl_o(i2c_scl_o), // output wire i2c_scl_o
  .i2c_scl_t(i2c_scl_t), // output wire i2c_scl_t
  .i2c_sda_i(i2c_sda_i), // input wire i2c_sda_i
  .i2c_sda_o(i2c_sda_o), // output wire i2c_sda_o
  .i2c_sda_t(i2c_sda_t), // output wire i2c_sda_t
  .i2c_pullups_tri_o(i2c_pullups_tri_o), // output wire [1:0] i2c_pullups_tri_o
  .sys_clock(sys_clock), // input wire sys_clock
  .reset(reset) // input wire reset
);
// INST_TAG_END ------  End cut for INSTANTIATION Template  ------

// You must compile the wrapper file mbv_system.v when simulating
// the module, mbv_system. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.
