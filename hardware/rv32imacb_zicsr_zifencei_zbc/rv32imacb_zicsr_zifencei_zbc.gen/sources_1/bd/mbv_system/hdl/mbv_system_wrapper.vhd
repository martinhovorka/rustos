--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
--Date        : Sat Jan 10 22:10:24 2026
--Host        : STUDIOPC running 64-bit major release  (build 9200)
--Command     : generate_target mbv_system_wrapper.bd
--Design      : mbv_system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_wrapper is
  port (
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_io : inout STD_LOGIC;
    eth_mii_col : in STD_LOGIC;
    eth_mii_crs : in STD_LOGIC;
    eth_mii_rst_n : out STD_LOGIC;
    eth_mii_rx_clk : in STD_LOGIC;
    eth_mii_rx_dv : in STD_LOGIC;
    eth_mii_rx_er : in STD_LOGIC;
    eth_mii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_mii_tx_clk : in STD_LOGIC;
    eth_mii_tx_en : out STD_LOGIC;
    eth_mii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i2c_pullups_tri_o : out STD_LOGIC_VECTOR ( 1 downto 0 );
    i2c_scl_io : inout STD_LOGIC;
    i2c_sda_io : inout STD_LOGIC;
    led_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    qspi_flash_io0_io : inout STD_LOGIC;
    qspi_flash_io1_io : inout STD_LOGIC;
    qspi_flash_io2_io : inout STD_LOGIC;
    qspi_flash_io3_io : inout STD_LOGIC;
    qspi_flash_sck_io : inout STD_LOGIC;
    qspi_flash_ss_io : inout STD_LOGIC;
    reset : in STD_LOGIC;
    rgb_led_tri_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    shield_dp0_dp19_tri_io : inout STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp26_dp41_tri_io : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    spi_io0_io : inout STD_LOGIC;
    spi_io1_io : inout STD_LOGIC;
    spi_sck_io : inout STD_LOGIC;
    spi_ss_io : inout STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end mbv_system_wrapper;

architecture STRUCTURE of mbv_system_wrapper is
  component mbv_system is
  port (
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    qspi_flash_io0_i : in STD_LOGIC;
    qspi_flash_io0_o : out STD_LOGIC;
    qspi_flash_io0_t : out STD_LOGIC;
    qspi_flash_io1_i : in STD_LOGIC;
    qspi_flash_io1_o : out STD_LOGIC;
    qspi_flash_io1_t : out STD_LOGIC;
    qspi_flash_io2_i : in STD_LOGIC;
    qspi_flash_io2_o : out STD_LOGIC;
    qspi_flash_io2_t : out STD_LOGIC;
    qspi_flash_io3_i : in STD_LOGIC;
    qspi_flash_io3_o : out STD_LOGIC;
    qspi_flash_io3_t : out STD_LOGIC;
    qspi_flash_sck_i : in STD_LOGIC;
    qspi_flash_sck_o : out STD_LOGIC;
    qspi_flash_sck_t : out STD_LOGIC;
    qspi_flash_ss_i : in STD_LOGIC;
    qspi_flash_ss_o : out STD_LOGIC;
    qspi_flash_ss_t : out STD_LOGIC;
    shield_dp0_dp19_tri_i : in STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp0_dp19_tri_o : out STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp0_dp19_tri_t : out STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp26_dp41_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    shield_dp26_dp41_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    shield_dp26_dp41_tri_t : out STD_LOGIC_VECTOR ( 15 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    rgb_led_tri_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    eth_mii_col : in STD_LOGIC;
    eth_mii_crs : in STD_LOGIC;
    eth_mii_rst_n : out STD_LOGIC;
    eth_mii_rx_clk : in STD_LOGIC;
    eth_mii_rx_dv : in STD_LOGIC;
    eth_mii_rx_er : in STD_LOGIC;
    eth_mii_rxd : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_mii_tx_clk : in STD_LOGIC;
    eth_mii_tx_en : out STD_LOGIC;
    eth_mii_txd : out STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_i : in STD_LOGIC;
    eth_mdio_mdc_mdio_o : out STD_LOGIC;
    eth_mdio_mdc_mdio_t : out STD_LOGIC;
    spi_io0_i : in STD_LOGIC;
    spi_io0_o : out STD_LOGIC;
    spi_io0_t : out STD_LOGIC;
    spi_io1_i : in STD_LOGIC;
    spi_io1_o : out STD_LOGIC;
    spi_io1_t : out STD_LOGIC;
    spi_sck_i : in STD_LOGIC;
    spi_sck_o : out STD_LOGIC;
    spi_sck_t : out STD_LOGIC;
    spi_ss_i : in STD_LOGIC;
    spi_ss_o : out STD_LOGIC;
    spi_ss_t : out STD_LOGIC;
    i2c_scl_i : in STD_LOGIC;
    i2c_scl_o : out STD_LOGIC;
    i2c_scl_t : out STD_LOGIC;
    i2c_sda_i : in STD_LOGIC;
    i2c_sda_o : out STD_LOGIC;
    i2c_sda_t : out STD_LOGIC;
    i2c_pullups_tri_o : out STD_LOGIC_VECTOR ( 1 downto 0 );
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  end component mbv_system;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal eth_mdio_mdc_mdio_i : STD_LOGIC;
  signal eth_mdio_mdc_mdio_o : STD_LOGIC;
  signal eth_mdio_mdc_mdio_t : STD_LOGIC;
  signal i2c_scl_i : STD_LOGIC;
  signal i2c_scl_o : STD_LOGIC;
  signal i2c_scl_t : STD_LOGIC;
  signal i2c_sda_i : STD_LOGIC;
  signal i2c_sda_o : STD_LOGIC;
  signal i2c_sda_t : STD_LOGIC;
  signal qspi_flash_io0_i : STD_LOGIC;
  signal qspi_flash_io0_o : STD_LOGIC;
  signal qspi_flash_io0_t : STD_LOGIC;
  signal qspi_flash_io1_i : STD_LOGIC;
  signal qspi_flash_io1_o : STD_LOGIC;
  signal qspi_flash_io1_t : STD_LOGIC;
  signal qspi_flash_io2_i : STD_LOGIC;
  signal qspi_flash_io2_o : STD_LOGIC;
  signal qspi_flash_io2_t : STD_LOGIC;
  signal qspi_flash_io3_i : STD_LOGIC;
  signal qspi_flash_io3_o : STD_LOGIC;
  signal qspi_flash_io3_t : STD_LOGIC;
  signal qspi_flash_sck_i : STD_LOGIC;
  signal qspi_flash_sck_o : STD_LOGIC;
  signal qspi_flash_sck_t : STD_LOGIC;
  signal qspi_flash_ss_i : STD_LOGIC;
  signal qspi_flash_ss_o : STD_LOGIC;
  signal qspi_flash_ss_t : STD_LOGIC;
  signal shield_dp0_dp19_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp0_dp19_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp0_dp19_tri_i_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp0_dp19_tri_i_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp0_dp19_tri_i_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp0_dp19_tri_i_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp0_dp19_tri_i_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp0_dp19_tri_i_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp0_dp19_tri_i_16 : STD_LOGIC_VECTOR ( 16 to 16 );
  signal shield_dp0_dp19_tri_i_17 : STD_LOGIC_VECTOR ( 17 to 17 );
  signal shield_dp0_dp19_tri_i_18 : STD_LOGIC_VECTOR ( 18 to 18 );
  signal shield_dp0_dp19_tri_i_19 : STD_LOGIC_VECTOR ( 19 to 19 );
  signal shield_dp0_dp19_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp0_dp19_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp0_dp19_tri_i_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp0_dp19_tri_i_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp0_dp19_tri_i_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp0_dp19_tri_i_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp0_dp19_tri_i_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp0_dp19_tri_i_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp0_dp19_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp0_dp19_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp0_dp19_tri_io_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp0_dp19_tri_io_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp0_dp19_tri_io_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp0_dp19_tri_io_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp0_dp19_tri_io_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp0_dp19_tri_io_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp0_dp19_tri_io_16 : STD_LOGIC_VECTOR ( 16 to 16 );
  signal shield_dp0_dp19_tri_io_17 : STD_LOGIC_VECTOR ( 17 to 17 );
  signal shield_dp0_dp19_tri_io_18 : STD_LOGIC_VECTOR ( 18 to 18 );
  signal shield_dp0_dp19_tri_io_19 : STD_LOGIC_VECTOR ( 19 to 19 );
  signal shield_dp0_dp19_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp0_dp19_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp0_dp19_tri_io_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp0_dp19_tri_io_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp0_dp19_tri_io_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp0_dp19_tri_io_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp0_dp19_tri_io_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp0_dp19_tri_io_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp0_dp19_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp0_dp19_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp0_dp19_tri_o_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp0_dp19_tri_o_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp0_dp19_tri_o_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp0_dp19_tri_o_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp0_dp19_tri_o_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp0_dp19_tri_o_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp0_dp19_tri_o_16 : STD_LOGIC_VECTOR ( 16 to 16 );
  signal shield_dp0_dp19_tri_o_17 : STD_LOGIC_VECTOR ( 17 to 17 );
  signal shield_dp0_dp19_tri_o_18 : STD_LOGIC_VECTOR ( 18 to 18 );
  signal shield_dp0_dp19_tri_o_19 : STD_LOGIC_VECTOR ( 19 to 19 );
  signal shield_dp0_dp19_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp0_dp19_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp0_dp19_tri_o_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp0_dp19_tri_o_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp0_dp19_tri_o_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp0_dp19_tri_o_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp0_dp19_tri_o_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp0_dp19_tri_o_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp0_dp19_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp0_dp19_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp0_dp19_tri_t_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp0_dp19_tri_t_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp0_dp19_tri_t_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp0_dp19_tri_t_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp0_dp19_tri_t_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp0_dp19_tri_t_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp0_dp19_tri_t_16 : STD_LOGIC_VECTOR ( 16 to 16 );
  signal shield_dp0_dp19_tri_t_17 : STD_LOGIC_VECTOR ( 17 to 17 );
  signal shield_dp0_dp19_tri_t_18 : STD_LOGIC_VECTOR ( 18 to 18 );
  signal shield_dp0_dp19_tri_t_19 : STD_LOGIC_VECTOR ( 19 to 19 );
  signal shield_dp0_dp19_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp0_dp19_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp0_dp19_tri_t_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp0_dp19_tri_t_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp0_dp19_tri_t_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp0_dp19_tri_t_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp0_dp19_tri_t_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp0_dp19_tri_t_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp26_dp41_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp26_dp41_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp26_dp41_tri_i_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp26_dp41_tri_i_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp26_dp41_tri_i_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp26_dp41_tri_i_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp26_dp41_tri_i_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp26_dp41_tri_i_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp26_dp41_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp26_dp41_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp26_dp41_tri_i_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp26_dp41_tri_i_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp26_dp41_tri_i_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp26_dp41_tri_i_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp26_dp41_tri_i_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp26_dp41_tri_i_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp26_dp41_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp26_dp41_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp26_dp41_tri_io_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp26_dp41_tri_io_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp26_dp41_tri_io_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp26_dp41_tri_io_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp26_dp41_tri_io_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp26_dp41_tri_io_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp26_dp41_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp26_dp41_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp26_dp41_tri_io_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp26_dp41_tri_io_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp26_dp41_tri_io_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp26_dp41_tri_io_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp26_dp41_tri_io_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp26_dp41_tri_io_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp26_dp41_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp26_dp41_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp26_dp41_tri_o_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp26_dp41_tri_o_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp26_dp41_tri_o_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp26_dp41_tri_o_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp26_dp41_tri_o_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp26_dp41_tri_o_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp26_dp41_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp26_dp41_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp26_dp41_tri_o_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp26_dp41_tri_o_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp26_dp41_tri_o_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp26_dp41_tri_o_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp26_dp41_tri_o_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp26_dp41_tri_o_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal shield_dp26_dp41_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal shield_dp26_dp41_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal shield_dp26_dp41_tri_t_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal shield_dp26_dp41_tri_t_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal shield_dp26_dp41_tri_t_12 : STD_LOGIC_VECTOR ( 12 to 12 );
  signal shield_dp26_dp41_tri_t_13 : STD_LOGIC_VECTOR ( 13 to 13 );
  signal shield_dp26_dp41_tri_t_14 : STD_LOGIC_VECTOR ( 14 to 14 );
  signal shield_dp26_dp41_tri_t_15 : STD_LOGIC_VECTOR ( 15 to 15 );
  signal shield_dp26_dp41_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal shield_dp26_dp41_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal shield_dp26_dp41_tri_t_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal shield_dp26_dp41_tri_t_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal shield_dp26_dp41_tri_t_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal shield_dp26_dp41_tri_t_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal shield_dp26_dp41_tri_t_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal shield_dp26_dp41_tri_t_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal spi_io0_i : STD_LOGIC;
  signal spi_io0_o : STD_LOGIC;
  signal spi_io0_t : STD_LOGIC;
  signal spi_io1_i : STD_LOGIC;
  signal spi_io1_o : STD_LOGIC;
  signal spi_io1_t : STD_LOGIC;
  signal spi_sck_i : STD_LOGIC;
  signal spi_sck_o : STD_LOGIC;
  signal spi_sck_t : STD_LOGIC;
  signal spi_ss_i : STD_LOGIC;
  signal spi_ss_o : STD_LOGIC;
  signal spi_ss_t : STD_LOGIC;
begin
eth_mdio_mdc_mdio_iobuf: component IOBUF
     port map (
      I => eth_mdio_mdc_mdio_o,
      IO => eth_mdio_mdc_mdio_io,
      O => eth_mdio_mdc_mdio_i,
      T => eth_mdio_mdc_mdio_t
    );
i2c_scl_iobuf: component IOBUF
     port map (
      I => i2c_scl_o,
      IO => i2c_scl_io,
      O => i2c_scl_i,
      T => i2c_scl_t
    );
i2c_sda_iobuf: component IOBUF
     port map (
      I => i2c_sda_o,
      IO => i2c_sda_io,
      O => i2c_sda_i,
      T => i2c_sda_t
    );
mbv_system_i: component mbv_system
     port map (
      dip_switches_4bits_tri_i(3 downto 0) => dip_switches_4bits_tri_i(3 downto 0),
      eth_mdio_mdc_mdc => eth_mdio_mdc_mdc,
      eth_mdio_mdc_mdio_i => eth_mdio_mdc_mdio_i,
      eth_mdio_mdc_mdio_o => eth_mdio_mdc_mdio_o,
      eth_mdio_mdc_mdio_t => eth_mdio_mdc_mdio_t,
      eth_mii_col => eth_mii_col,
      eth_mii_crs => eth_mii_crs,
      eth_mii_rst_n => eth_mii_rst_n,
      eth_mii_rx_clk => eth_mii_rx_clk,
      eth_mii_rx_dv => eth_mii_rx_dv,
      eth_mii_rx_er => eth_mii_rx_er,
      eth_mii_rxd(3 downto 0) => eth_mii_rxd(3 downto 0),
      eth_mii_tx_clk => eth_mii_tx_clk,
      eth_mii_tx_en => eth_mii_tx_en,
      eth_mii_txd(3 downto 0) => eth_mii_txd(3 downto 0),
      i2c_pullups_tri_o(1 downto 0) => i2c_pullups_tri_o(1 downto 0),
      i2c_scl_i => i2c_scl_i,
      i2c_scl_o => i2c_scl_o,
      i2c_scl_t => i2c_scl_t,
      i2c_sda_i => i2c_sda_i,
      i2c_sda_o => i2c_sda_o,
      i2c_sda_t => i2c_sda_t,
      led_4bits_tri_o(3 downto 0) => led_4bits_tri_o(3 downto 0),
      push_buttons_4bits_tri_i(3 downto 0) => push_buttons_4bits_tri_i(3 downto 0),
      qspi_flash_io0_i => qspi_flash_io0_i,
      qspi_flash_io0_o => qspi_flash_io0_o,
      qspi_flash_io0_t => qspi_flash_io0_t,
      qspi_flash_io1_i => qspi_flash_io1_i,
      qspi_flash_io1_o => qspi_flash_io1_o,
      qspi_flash_io1_t => qspi_flash_io1_t,
      qspi_flash_io2_i => qspi_flash_io2_i,
      qspi_flash_io2_o => qspi_flash_io2_o,
      qspi_flash_io2_t => qspi_flash_io2_t,
      qspi_flash_io3_i => qspi_flash_io3_i,
      qspi_flash_io3_o => qspi_flash_io3_o,
      qspi_flash_io3_t => qspi_flash_io3_t,
      qspi_flash_sck_i => qspi_flash_sck_i,
      qspi_flash_sck_o => qspi_flash_sck_o,
      qspi_flash_sck_t => qspi_flash_sck_t,
      qspi_flash_ss_i => qspi_flash_ss_i,
      qspi_flash_ss_o => qspi_flash_ss_o,
      qspi_flash_ss_t => qspi_flash_ss_t,
      reset => reset,
      rgb_led_tri_o(11 downto 0) => rgb_led_tri_o(11 downto 0),
      shield_dp0_dp19_tri_i(19) => shield_dp0_dp19_tri_i_19(19),
      shield_dp0_dp19_tri_i(18) => shield_dp0_dp19_tri_i_18(18),
      shield_dp0_dp19_tri_i(17) => shield_dp0_dp19_tri_i_17(17),
      shield_dp0_dp19_tri_i(16) => shield_dp0_dp19_tri_i_16(16),
      shield_dp0_dp19_tri_i(15) => shield_dp0_dp19_tri_i_15(15),
      shield_dp0_dp19_tri_i(14) => shield_dp0_dp19_tri_i_14(14),
      shield_dp0_dp19_tri_i(13) => shield_dp0_dp19_tri_i_13(13),
      shield_dp0_dp19_tri_i(12) => shield_dp0_dp19_tri_i_12(12),
      shield_dp0_dp19_tri_i(11) => shield_dp0_dp19_tri_i_11(11),
      shield_dp0_dp19_tri_i(10) => shield_dp0_dp19_tri_i_10(10),
      shield_dp0_dp19_tri_i(9) => shield_dp0_dp19_tri_i_9(9),
      shield_dp0_dp19_tri_i(8) => shield_dp0_dp19_tri_i_8(8),
      shield_dp0_dp19_tri_i(7) => shield_dp0_dp19_tri_i_7(7),
      shield_dp0_dp19_tri_i(6) => shield_dp0_dp19_tri_i_6(6),
      shield_dp0_dp19_tri_i(5) => shield_dp0_dp19_tri_i_5(5),
      shield_dp0_dp19_tri_i(4) => shield_dp0_dp19_tri_i_4(4),
      shield_dp0_dp19_tri_i(3) => shield_dp0_dp19_tri_i_3(3),
      shield_dp0_dp19_tri_i(2) => shield_dp0_dp19_tri_i_2(2),
      shield_dp0_dp19_tri_i(1) => shield_dp0_dp19_tri_i_1(1),
      shield_dp0_dp19_tri_i(0) => shield_dp0_dp19_tri_i_0(0),
      shield_dp0_dp19_tri_o(19) => shield_dp0_dp19_tri_o_19(19),
      shield_dp0_dp19_tri_o(18) => shield_dp0_dp19_tri_o_18(18),
      shield_dp0_dp19_tri_o(17) => shield_dp0_dp19_tri_o_17(17),
      shield_dp0_dp19_tri_o(16) => shield_dp0_dp19_tri_o_16(16),
      shield_dp0_dp19_tri_o(15) => shield_dp0_dp19_tri_o_15(15),
      shield_dp0_dp19_tri_o(14) => shield_dp0_dp19_tri_o_14(14),
      shield_dp0_dp19_tri_o(13) => shield_dp0_dp19_tri_o_13(13),
      shield_dp0_dp19_tri_o(12) => shield_dp0_dp19_tri_o_12(12),
      shield_dp0_dp19_tri_o(11) => shield_dp0_dp19_tri_o_11(11),
      shield_dp0_dp19_tri_o(10) => shield_dp0_dp19_tri_o_10(10),
      shield_dp0_dp19_tri_o(9) => shield_dp0_dp19_tri_o_9(9),
      shield_dp0_dp19_tri_o(8) => shield_dp0_dp19_tri_o_8(8),
      shield_dp0_dp19_tri_o(7) => shield_dp0_dp19_tri_o_7(7),
      shield_dp0_dp19_tri_o(6) => shield_dp0_dp19_tri_o_6(6),
      shield_dp0_dp19_tri_o(5) => shield_dp0_dp19_tri_o_5(5),
      shield_dp0_dp19_tri_o(4) => shield_dp0_dp19_tri_o_4(4),
      shield_dp0_dp19_tri_o(3) => shield_dp0_dp19_tri_o_3(3),
      shield_dp0_dp19_tri_o(2) => shield_dp0_dp19_tri_o_2(2),
      shield_dp0_dp19_tri_o(1) => shield_dp0_dp19_tri_o_1(1),
      shield_dp0_dp19_tri_o(0) => shield_dp0_dp19_tri_o_0(0),
      shield_dp0_dp19_tri_t(19) => shield_dp0_dp19_tri_t_19(19),
      shield_dp0_dp19_tri_t(18) => shield_dp0_dp19_tri_t_18(18),
      shield_dp0_dp19_tri_t(17) => shield_dp0_dp19_tri_t_17(17),
      shield_dp0_dp19_tri_t(16) => shield_dp0_dp19_tri_t_16(16),
      shield_dp0_dp19_tri_t(15) => shield_dp0_dp19_tri_t_15(15),
      shield_dp0_dp19_tri_t(14) => shield_dp0_dp19_tri_t_14(14),
      shield_dp0_dp19_tri_t(13) => shield_dp0_dp19_tri_t_13(13),
      shield_dp0_dp19_tri_t(12) => shield_dp0_dp19_tri_t_12(12),
      shield_dp0_dp19_tri_t(11) => shield_dp0_dp19_tri_t_11(11),
      shield_dp0_dp19_tri_t(10) => shield_dp0_dp19_tri_t_10(10),
      shield_dp0_dp19_tri_t(9) => shield_dp0_dp19_tri_t_9(9),
      shield_dp0_dp19_tri_t(8) => shield_dp0_dp19_tri_t_8(8),
      shield_dp0_dp19_tri_t(7) => shield_dp0_dp19_tri_t_7(7),
      shield_dp0_dp19_tri_t(6) => shield_dp0_dp19_tri_t_6(6),
      shield_dp0_dp19_tri_t(5) => shield_dp0_dp19_tri_t_5(5),
      shield_dp0_dp19_tri_t(4) => shield_dp0_dp19_tri_t_4(4),
      shield_dp0_dp19_tri_t(3) => shield_dp0_dp19_tri_t_3(3),
      shield_dp0_dp19_tri_t(2) => shield_dp0_dp19_tri_t_2(2),
      shield_dp0_dp19_tri_t(1) => shield_dp0_dp19_tri_t_1(1),
      shield_dp0_dp19_tri_t(0) => shield_dp0_dp19_tri_t_0(0),
      shield_dp26_dp41_tri_i(15) => shield_dp26_dp41_tri_i_15(15),
      shield_dp26_dp41_tri_i(14) => shield_dp26_dp41_tri_i_14(14),
      shield_dp26_dp41_tri_i(13) => shield_dp26_dp41_tri_i_13(13),
      shield_dp26_dp41_tri_i(12) => shield_dp26_dp41_tri_i_12(12),
      shield_dp26_dp41_tri_i(11) => shield_dp26_dp41_tri_i_11(11),
      shield_dp26_dp41_tri_i(10) => shield_dp26_dp41_tri_i_10(10),
      shield_dp26_dp41_tri_i(9) => shield_dp26_dp41_tri_i_9(9),
      shield_dp26_dp41_tri_i(8) => shield_dp26_dp41_tri_i_8(8),
      shield_dp26_dp41_tri_i(7) => shield_dp26_dp41_tri_i_7(7),
      shield_dp26_dp41_tri_i(6) => shield_dp26_dp41_tri_i_6(6),
      shield_dp26_dp41_tri_i(5) => shield_dp26_dp41_tri_i_5(5),
      shield_dp26_dp41_tri_i(4) => shield_dp26_dp41_tri_i_4(4),
      shield_dp26_dp41_tri_i(3) => shield_dp26_dp41_tri_i_3(3),
      shield_dp26_dp41_tri_i(2) => shield_dp26_dp41_tri_i_2(2),
      shield_dp26_dp41_tri_i(1) => shield_dp26_dp41_tri_i_1(1),
      shield_dp26_dp41_tri_i(0) => shield_dp26_dp41_tri_i_0(0),
      shield_dp26_dp41_tri_o(15) => shield_dp26_dp41_tri_o_15(15),
      shield_dp26_dp41_tri_o(14) => shield_dp26_dp41_tri_o_14(14),
      shield_dp26_dp41_tri_o(13) => shield_dp26_dp41_tri_o_13(13),
      shield_dp26_dp41_tri_o(12) => shield_dp26_dp41_tri_o_12(12),
      shield_dp26_dp41_tri_o(11) => shield_dp26_dp41_tri_o_11(11),
      shield_dp26_dp41_tri_o(10) => shield_dp26_dp41_tri_o_10(10),
      shield_dp26_dp41_tri_o(9) => shield_dp26_dp41_tri_o_9(9),
      shield_dp26_dp41_tri_o(8) => shield_dp26_dp41_tri_o_8(8),
      shield_dp26_dp41_tri_o(7) => shield_dp26_dp41_tri_o_7(7),
      shield_dp26_dp41_tri_o(6) => shield_dp26_dp41_tri_o_6(6),
      shield_dp26_dp41_tri_o(5) => shield_dp26_dp41_tri_o_5(5),
      shield_dp26_dp41_tri_o(4) => shield_dp26_dp41_tri_o_4(4),
      shield_dp26_dp41_tri_o(3) => shield_dp26_dp41_tri_o_3(3),
      shield_dp26_dp41_tri_o(2) => shield_dp26_dp41_tri_o_2(2),
      shield_dp26_dp41_tri_o(1) => shield_dp26_dp41_tri_o_1(1),
      shield_dp26_dp41_tri_o(0) => shield_dp26_dp41_tri_o_0(0),
      shield_dp26_dp41_tri_t(15) => shield_dp26_dp41_tri_t_15(15),
      shield_dp26_dp41_tri_t(14) => shield_dp26_dp41_tri_t_14(14),
      shield_dp26_dp41_tri_t(13) => shield_dp26_dp41_tri_t_13(13),
      shield_dp26_dp41_tri_t(12) => shield_dp26_dp41_tri_t_12(12),
      shield_dp26_dp41_tri_t(11) => shield_dp26_dp41_tri_t_11(11),
      shield_dp26_dp41_tri_t(10) => shield_dp26_dp41_tri_t_10(10),
      shield_dp26_dp41_tri_t(9) => shield_dp26_dp41_tri_t_9(9),
      shield_dp26_dp41_tri_t(8) => shield_dp26_dp41_tri_t_8(8),
      shield_dp26_dp41_tri_t(7) => shield_dp26_dp41_tri_t_7(7),
      shield_dp26_dp41_tri_t(6) => shield_dp26_dp41_tri_t_6(6),
      shield_dp26_dp41_tri_t(5) => shield_dp26_dp41_tri_t_5(5),
      shield_dp26_dp41_tri_t(4) => shield_dp26_dp41_tri_t_4(4),
      shield_dp26_dp41_tri_t(3) => shield_dp26_dp41_tri_t_3(3),
      shield_dp26_dp41_tri_t(2) => shield_dp26_dp41_tri_t_2(2),
      shield_dp26_dp41_tri_t(1) => shield_dp26_dp41_tri_t_1(1),
      shield_dp26_dp41_tri_t(0) => shield_dp26_dp41_tri_t_0(0),
      spi_io0_i => spi_io0_i,
      spi_io0_o => spi_io0_o,
      spi_io0_t => spi_io0_t,
      spi_io1_i => spi_io1_i,
      spi_io1_o => spi_io1_o,
      spi_io1_t => spi_io1_t,
      spi_sck_i => spi_sck_i,
      spi_sck_o => spi_sck_o,
      spi_sck_t => spi_sck_t,
      spi_ss_i => spi_ss_i,
      spi_ss_o => spi_ss_o,
      spi_ss_t => spi_ss_t,
      sys_clock => sys_clock,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
qspi_flash_io0_iobuf: component IOBUF
     port map (
      I => qspi_flash_io0_o,
      IO => qspi_flash_io0_io,
      O => qspi_flash_io0_i,
      T => qspi_flash_io0_t
    );
qspi_flash_io1_iobuf: component IOBUF
     port map (
      I => qspi_flash_io1_o,
      IO => qspi_flash_io1_io,
      O => qspi_flash_io1_i,
      T => qspi_flash_io1_t
    );
qspi_flash_io2_iobuf: component IOBUF
     port map (
      I => qspi_flash_io2_o,
      IO => qspi_flash_io2_io,
      O => qspi_flash_io2_i,
      T => qspi_flash_io2_t
    );
qspi_flash_io3_iobuf: component IOBUF
     port map (
      I => qspi_flash_io3_o,
      IO => qspi_flash_io3_io,
      O => qspi_flash_io3_i,
      T => qspi_flash_io3_t
    );
qspi_flash_sck_iobuf: component IOBUF
     port map (
      I => qspi_flash_sck_o,
      IO => qspi_flash_sck_io,
      O => qspi_flash_sck_i,
      T => qspi_flash_sck_t
    );
qspi_flash_ss_iobuf: component IOBUF
     port map (
      I => qspi_flash_ss_o,
      IO => qspi_flash_ss_io,
      O => qspi_flash_ss_i,
      T => qspi_flash_ss_t
    );
shield_dp0_dp19_tri_iobuf_0: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_0(0),
      IO => shield_dp0_dp19_tri_io(0),
      O => shield_dp0_dp19_tri_i_0(0),
      T => shield_dp0_dp19_tri_t_0(0)
    );
shield_dp0_dp19_tri_iobuf_1: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_1(1),
      IO => shield_dp0_dp19_tri_io(1),
      O => shield_dp0_dp19_tri_i_1(1),
      T => shield_dp0_dp19_tri_t_1(1)
    );
shield_dp0_dp19_tri_iobuf_10: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_10(10),
      IO => shield_dp0_dp19_tri_io(10),
      O => shield_dp0_dp19_tri_i_10(10),
      T => shield_dp0_dp19_tri_t_10(10)
    );
shield_dp0_dp19_tri_iobuf_11: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_11(11),
      IO => shield_dp0_dp19_tri_io(11),
      O => shield_dp0_dp19_tri_i_11(11),
      T => shield_dp0_dp19_tri_t_11(11)
    );
shield_dp0_dp19_tri_iobuf_12: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_12(12),
      IO => shield_dp0_dp19_tri_io(12),
      O => shield_dp0_dp19_tri_i_12(12),
      T => shield_dp0_dp19_tri_t_12(12)
    );
shield_dp0_dp19_tri_iobuf_13: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_13(13),
      IO => shield_dp0_dp19_tri_io(13),
      O => shield_dp0_dp19_tri_i_13(13),
      T => shield_dp0_dp19_tri_t_13(13)
    );
shield_dp0_dp19_tri_iobuf_14: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_14(14),
      IO => shield_dp0_dp19_tri_io(14),
      O => shield_dp0_dp19_tri_i_14(14),
      T => shield_dp0_dp19_tri_t_14(14)
    );
shield_dp0_dp19_tri_iobuf_15: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_15(15),
      IO => shield_dp0_dp19_tri_io(15),
      O => shield_dp0_dp19_tri_i_15(15),
      T => shield_dp0_dp19_tri_t_15(15)
    );
shield_dp0_dp19_tri_iobuf_16: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_16(16),
      IO => shield_dp0_dp19_tri_io(16),
      O => shield_dp0_dp19_tri_i_16(16),
      T => shield_dp0_dp19_tri_t_16(16)
    );
shield_dp0_dp19_tri_iobuf_17: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_17(17),
      IO => shield_dp0_dp19_tri_io(17),
      O => shield_dp0_dp19_tri_i_17(17),
      T => shield_dp0_dp19_tri_t_17(17)
    );
shield_dp0_dp19_tri_iobuf_18: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_18(18),
      IO => shield_dp0_dp19_tri_io(18),
      O => shield_dp0_dp19_tri_i_18(18),
      T => shield_dp0_dp19_tri_t_18(18)
    );
shield_dp0_dp19_tri_iobuf_19: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_19(19),
      IO => shield_dp0_dp19_tri_io(19),
      O => shield_dp0_dp19_tri_i_19(19),
      T => shield_dp0_dp19_tri_t_19(19)
    );
shield_dp0_dp19_tri_iobuf_2: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_2(2),
      IO => shield_dp0_dp19_tri_io(2),
      O => shield_dp0_dp19_tri_i_2(2),
      T => shield_dp0_dp19_tri_t_2(2)
    );
shield_dp0_dp19_tri_iobuf_3: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_3(3),
      IO => shield_dp0_dp19_tri_io(3),
      O => shield_dp0_dp19_tri_i_3(3),
      T => shield_dp0_dp19_tri_t_3(3)
    );
shield_dp0_dp19_tri_iobuf_4: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_4(4),
      IO => shield_dp0_dp19_tri_io(4),
      O => shield_dp0_dp19_tri_i_4(4),
      T => shield_dp0_dp19_tri_t_4(4)
    );
shield_dp0_dp19_tri_iobuf_5: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_5(5),
      IO => shield_dp0_dp19_tri_io(5),
      O => shield_dp0_dp19_tri_i_5(5),
      T => shield_dp0_dp19_tri_t_5(5)
    );
shield_dp0_dp19_tri_iobuf_6: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_6(6),
      IO => shield_dp0_dp19_tri_io(6),
      O => shield_dp0_dp19_tri_i_6(6),
      T => shield_dp0_dp19_tri_t_6(6)
    );
shield_dp0_dp19_tri_iobuf_7: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_7(7),
      IO => shield_dp0_dp19_tri_io(7),
      O => shield_dp0_dp19_tri_i_7(7),
      T => shield_dp0_dp19_tri_t_7(7)
    );
shield_dp0_dp19_tri_iobuf_8: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_8(8),
      IO => shield_dp0_dp19_tri_io(8),
      O => shield_dp0_dp19_tri_i_8(8),
      T => shield_dp0_dp19_tri_t_8(8)
    );
shield_dp0_dp19_tri_iobuf_9: component IOBUF
     port map (
      I => shield_dp0_dp19_tri_o_9(9),
      IO => shield_dp0_dp19_tri_io(9),
      O => shield_dp0_dp19_tri_i_9(9),
      T => shield_dp0_dp19_tri_t_9(9)
    );
shield_dp26_dp41_tri_iobuf_0: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_0(0),
      IO => shield_dp26_dp41_tri_io(0),
      O => shield_dp26_dp41_tri_i_0(0),
      T => shield_dp26_dp41_tri_t_0(0)
    );
shield_dp26_dp41_tri_iobuf_1: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_1(1),
      IO => shield_dp26_dp41_tri_io(1),
      O => shield_dp26_dp41_tri_i_1(1),
      T => shield_dp26_dp41_tri_t_1(1)
    );
shield_dp26_dp41_tri_iobuf_10: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_10(10),
      IO => shield_dp26_dp41_tri_io(10),
      O => shield_dp26_dp41_tri_i_10(10),
      T => shield_dp26_dp41_tri_t_10(10)
    );
shield_dp26_dp41_tri_iobuf_11: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_11(11),
      IO => shield_dp26_dp41_tri_io(11),
      O => shield_dp26_dp41_tri_i_11(11),
      T => shield_dp26_dp41_tri_t_11(11)
    );
shield_dp26_dp41_tri_iobuf_12: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_12(12),
      IO => shield_dp26_dp41_tri_io(12),
      O => shield_dp26_dp41_tri_i_12(12),
      T => shield_dp26_dp41_tri_t_12(12)
    );
shield_dp26_dp41_tri_iobuf_13: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_13(13),
      IO => shield_dp26_dp41_tri_io(13),
      O => shield_dp26_dp41_tri_i_13(13),
      T => shield_dp26_dp41_tri_t_13(13)
    );
shield_dp26_dp41_tri_iobuf_14: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_14(14),
      IO => shield_dp26_dp41_tri_io(14),
      O => shield_dp26_dp41_tri_i_14(14),
      T => shield_dp26_dp41_tri_t_14(14)
    );
shield_dp26_dp41_tri_iobuf_15: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_15(15),
      IO => shield_dp26_dp41_tri_io(15),
      O => shield_dp26_dp41_tri_i_15(15),
      T => shield_dp26_dp41_tri_t_15(15)
    );
shield_dp26_dp41_tri_iobuf_2: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_2(2),
      IO => shield_dp26_dp41_tri_io(2),
      O => shield_dp26_dp41_tri_i_2(2),
      T => shield_dp26_dp41_tri_t_2(2)
    );
shield_dp26_dp41_tri_iobuf_3: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_3(3),
      IO => shield_dp26_dp41_tri_io(3),
      O => shield_dp26_dp41_tri_i_3(3),
      T => shield_dp26_dp41_tri_t_3(3)
    );
shield_dp26_dp41_tri_iobuf_4: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_4(4),
      IO => shield_dp26_dp41_tri_io(4),
      O => shield_dp26_dp41_tri_i_4(4),
      T => shield_dp26_dp41_tri_t_4(4)
    );
shield_dp26_dp41_tri_iobuf_5: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_5(5),
      IO => shield_dp26_dp41_tri_io(5),
      O => shield_dp26_dp41_tri_i_5(5),
      T => shield_dp26_dp41_tri_t_5(5)
    );
shield_dp26_dp41_tri_iobuf_6: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_6(6),
      IO => shield_dp26_dp41_tri_io(6),
      O => shield_dp26_dp41_tri_i_6(6),
      T => shield_dp26_dp41_tri_t_6(6)
    );
shield_dp26_dp41_tri_iobuf_7: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_7(7),
      IO => shield_dp26_dp41_tri_io(7),
      O => shield_dp26_dp41_tri_i_7(7),
      T => shield_dp26_dp41_tri_t_7(7)
    );
shield_dp26_dp41_tri_iobuf_8: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_8(8),
      IO => shield_dp26_dp41_tri_io(8),
      O => shield_dp26_dp41_tri_i_8(8),
      T => shield_dp26_dp41_tri_t_8(8)
    );
shield_dp26_dp41_tri_iobuf_9: component IOBUF
     port map (
      I => shield_dp26_dp41_tri_o_9(9),
      IO => shield_dp26_dp41_tri_io(9),
      O => shield_dp26_dp41_tri_i_9(9),
      T => shield_dp26_dp41_tri_t_9(9)
    );
spi_io0_iobuf: component IOBUF
     port map (
      I => spi_io0_o,
      IO => spi_io0_io,
      O => spi_io0_i,
      T => spi_io0_t
    );
spi_io1_iobuf: component IOBUF
     port map (
      I => spi_io1_o,
      IO => spi_io1_io,
      O => spi_io1_i,
      T => spi_io1_t
    );
spi_sck_iobuf: component IOBUF
     port map (
      I => spi_sck_o,
      IO => spi_sck_io,
      O => spi_sck_i,
      T => spi_sck_t
    );
spi_ss_iobuf: component IOBUF
     port map (
      I => spi_ss_o,
      IO => spi_ss_io,
      O => spi_ss_i,
      T => spi_ss_t
    );
end STRUCTURE;
