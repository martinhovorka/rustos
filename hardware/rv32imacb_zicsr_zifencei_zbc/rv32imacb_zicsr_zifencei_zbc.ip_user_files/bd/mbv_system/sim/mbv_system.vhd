--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
--Date        : Tue Dec 23 09:21:57 2025
--Host        : STUDIOPC running 64-bit major release  (build 9200)
--Command     : generate_target mbv_system.bd
--Design      : mbv_system
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_local_memory_imp_1NP638B is
  port (
    DLMB_abus : in STD_LOGIC_VECTOR ( 0 to 33 );
    DLMB_addrstrobe : in STD_LOGIC;
    DLMB_be : in STD_LOGIC_VECTOR ( 0 to 3 );
    DLMB_ce : out STD_LOGIC;
    DLMB_readdbus : out STD_LOGIC_VECTOR ( 0 to 31 );
    DLMB_readstrobe : in STD_LOGIC;
    DLMB_ready : out STD_LOGIC;
    DLMB_ue : out STD_LOGIC;
    DLMB_wait : out STD_LOGIC;
    DLMB_writedbus : in STD_LOGIC_VECTOR ( 0 to 31 );
    DLMB_writestrobe : in STD_LOGIC;
    ILMB_abus : in STD_LOGIC_VECTOR ( 0 to 33 );
    ILMB_addrstrobe : in STD_LOGIC;
    ILMB_ce : out STD_LOGIC;
    ILMB_readdbus : out STD_LOGIC_VECTOR ( 0 to 31 );
    ILMB_readstrobe : in STD_LOGIC;
    ILMB_ready : out STD_LOGIC;
    ILMB_ue : out STD_LOGIC;
    ILMB_wait : out STD_LOGIC;
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC
  );
end mbv_local_memory_imp_1NP638B;

architecture STRUCTURE of mbv_local_memory_imp_1NP638B is
  component mbv_system_dlmb_v10_1 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 33 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 0 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 33 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component mbv_system_dlmb_v10_1;
  component mbv_system_ilmb_v10_1 is
  port (
    LMB_Clk : in STD_LOGIC;
    SYS_Rst : in STD_LOGIC;
    LMB_Rst : out STD_LOGIC;
    M_ABus : in STD_LOGIC_VECTOR ( 0 to 33 );
    M_ReadStrobe : in STD_LOGIC;
    M_WriteStrobe : in STD_LOGIC;
    M_AddrStrobe : in STD_LOGIC;
    M_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    M_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_Wait : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_UE : in STD_LOGIC_VECTOR ( 0 to 0 );
    Sl_CE : in STD_LOGIC_VECTOR ( 0 to 0 );
    LMB_ABus : out STD_LOGIC_VECTOR ( 0 to 33 );
    LMB_ReadStrobe : out STD_LOGIC;
    LMB_WriteStrobe : out STD_LOGIC;
    LMB_AddrStrobe : out STD_LOGIC;
    LMB_ReadDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_WriteDBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_Ready : out STD_LOGIC;
    LMB_Wait : out STD_LOGIC;
    LMB_UE : out STD_LOGIC;
    LMB_CE : out STD_LOGIC;
    LMB_BE : out STD_LOGIC_VECTOR ( 0 to 3 )
  );
  end component mbv_system_ilmb_v10_1;
  component mbv_system_dlmb_bram_if_cntlr_1 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 33 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component mbv_system_dlmb_bram_if_cntlr_1;
  component mbv_system_ilmb_bram_if_cntlr_1 is
  port (
    LMB_Clk : in STD_LOGIC;
    LMB_Rst : in STD_LOGIC;
    LMB_ABus : in STD_LOGIC_VECTOR ( 0 to 33 );
    LMB_WriteDBus : in STD_LOGIC_VECTOR ( 0 to 31 );
    LMB_AddrStrobe : in STD_LOGIC;
    LMB_ReadStrobe : in STD_LOGIC;
    LMB_WriteStrobe : in STD_LOGIC;
    LMB_BE : in STD_LOGIC_VECTOR ( 0 to 3 );
    Sl_DBus : out STD_LOGIC_VECTOR ( 0 to 31 );
    Sl_Ready : out STD_LOGIC;
    Sl_Wait : out STD_LOGIC;
    Sl_UE : out STD_LOGIC;
    Sl_CE : out STD_LOGIC;
    BRAM_Rst_A : out STD_LOGIC;
    BRAM_Clk_A : out STD_LOGIC;
    BRAM_Addr_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_EN_A : out STD_LOGIC;
    BRAM_WEN_A : out STD_LOGIC_VECTOR ( 0 to 3 );
    BRAM_Dout_A : out STD_LOGIC_VECTOR ( 0 to 31 );
    BRAM_Din_A : in STD_LOGIC_VECTOR ( 0 to 31 )
  );
  end component mbv_system_ilmb_bram_if_cntlr_1;
  component mbv_system_lmb_bram_1 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    clkb : in STD_LOGIC;
    rstb : in STD_LOGIC;
    enb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addrb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 31 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rsta_busy : out STD_LOGIC;
    rstb_busy : out STD_LOGIC
  );
  end component mbv_system_lmb_bram_1;
  signal mbv_riscv_dlmb_bus_ABUS : STD_LOGIC_VECTOR ( 0 to 33 );
  signal mbv_riscv_dlmb_bus_ADDRSTROBE : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal mbv_riscv_dlmb_bus_CE : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_bus_READSTROBE : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_READY : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_UE : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_WAIT : STD_LOGIC;
  signal mbv_riscv_dlmb_bus_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_bus_WRITESTROBE : STD_LOGIC;
  signal mbv_riscv_dlmb_cntlr_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_cntlr_CLK : STD_LOGIC;
  signal mbv_riscv_dlmb_cntlr_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_cntlr_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_dlmb_cntlr_EN : STD_LOGIC;
  signal mbv_riscv_dlmb_cntlr_RST : STD_LOGIC;
  signal mbv_riscv_dlmb_cntlr_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal mbv_riscv_ilmb_bus_ABUS : STD_LOGIC_VECTOR ( 0 to 33 );
  signal mbv_riscv_ilmb_bus_ADDRSTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal mbv_riscv_ilmb_bus_CE : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_ilmb_bus_READSTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_READY : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_UE : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_WAIT : STD_LOGIC;
  signal mbv_riscv_ilmb_bus_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_ilmb_bus_WRITESTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_cntlr_ADDR : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_ilmb_cntlr_CLK : STD_LOGIC;
  signal mbv_riscv_ilmb_cntlr_DIN : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_ilmb_cntlr_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_ilmb_cntlr_EN : STD_LOGIC;
  signal mbv_riscv_ilmb_cntlr_RST : STD_LOGIC;
  signal mbv_riscv_ilmb_cntlr_WE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal NLW_mbv_block_memory_generator_rsta_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_block_memory_generator_rstb_busy_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_data_local_memory_bus_LMB_Rst_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_instruction_local_memory_bus_LMB_Rst_UNCONNECTED : STD_LOGIC;
  attribute BMM_INFO_ADDRESS_SPACE : string;
  attribute BMM_INFO_ADDRESS_SPACE of mbv_data_lmb_bram_controller : label is "byte  0x00000000 32 > mbv_system mbv_local_memory/mbv_block_memory_generator";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of mbv_data_lmb_bram_controller : label is "YES";
begin
mbv_block_memory_generator: component mbv_system_lmb_bram_1
     port map (
      addra(31) => mbv_riscv_dlmb_cntlr_ADDR(0),
      addra(30) => mbv_riscv_dlmb_cntlr_ADDR(1),
      addra(29) => mbv_riscv_dlmb_cntlr_ADDR(2),
      addra(28) => mbv_riscv_dlmb_cntlr_ADDR(3),
      addra(27) => mbv_riscv_dlmb_cntlr_ADDR(4),
      addra(26) => mbv_riscv_dlmb_cntlr_ADDR(5),
      addra(25) => mbv_riscv_dlmb_cntlr_ADDR(6),
      addra(24) => mbv_riscv_dlmb_cntlr_ADDR(7),
      addra(23) => mbv_riscv_dlmb_cntlr_ADDR(8),
      addra(22) => mbv_riscv_dlmb_cntlr_ADDR(9),
      addra(21) => mbv_riscv_dlmb_cntlr_ADDR(10),
      addra(20) => mbv_riscv_dlmb_cntlr_ADDR(11),
      addra(19) => mbv_riscv_dlmb_cntlr_ADDR(12),
      addra(18) => mbv_riscv_dlmb_cntlr_ADDR(13),
      addra(17) => mbv_riscv_dlmb_cntlr_ADDR(14),
      addra(16) => mbv_riscv_dlmb_cntlr_ADDR(15),
      addra(15) => mbv_riscv_dlmb_cntlr_ADDR(16),
      addra(14) => mbv_riscv_dlmb_cntlr_ADDR(17),
      addra(13) => mbv_riscv_dlmb_cntlr_ADDR(18),
      addra(12) => mbv_riscv_dlmb_cntlr_ADDR(19),
      addra(11) => mbv_riscv_dlmb_cntlr_ADDR(20),
      addra(10) => mbv_riscv_dlmb_cntlr_ADDR(21),
      addra(9) => mbv_riscv_dlmb_cntlr_ADDR(22),
      addra(8) => mbv_riscv_dlmb_cntlr_ADDR(23),
      addra(7) => mbv_riscv_dlmb_cntlr_ADDR(24),
      addra(6) => mbv_riscv_dlmb_cntlr_ADDR(25),
      addra(5) => mbv_riscv_dlmb_cntlr_ADDR(26),
      addra(4) => mbv_riscv_dlmb_cntlr_ADDR(27),
      addra(3) => mbv_riscv_dlmb_cntlr_ADDR(28),
      addra(2) => mbv_riscv_dlmb_cntlr_ADDR(29),
      addra(1) => mbv_riscv_dlmb_cntlr_ADDR(30),
      addra(0) => mbv_riscv_dlmb_cntlr_ADDR(31),
      addrb(31) => mbv_riscv_ilmb_cntlr_ADDR(0),
      addrb(30) => mbv_riscv_ilmb_cntlr_ADDR(1),
      addrb(29) => mbv_riscv_ilmb_cntlr_ADDR(2),
      addrb(28) => mbv_riscv_ilmb_cntlr_ADDR(3),
      addrb(27) => mbv_riscv_ilmb_cntlr_ADDR(4),
      addrb(26) => mbv_riscv_ilmb_cntlr_ADDR(5),
      addrb(25) => mbv_riscv_ilmb_cntlr_ADDR(6),
      addrb(24) => mbv_riscv_ilmb_cntlr_ADDR(7),
      addrb(23) => mbv_riscv_ilmb_cntlr_ADDR(8),
      addrb(22) => mbv_riscv_ilmb_cntlr_ADDR(9),
      addrb(21) => mbv_riscv_ilmb_cntlr_ADDR(10),
      addrb(20) => mbv_riscv_ilmb_cntlr_ADDR(11),
      addrb(19) => mbv_riscv_ilmb_cntlr_ADDR(12),
      addrb(18) => mbv_riscv_ilmb_cntlr_ADDR(13),
      addrb(17) => mbv_riscv_ilmb_cntlr_ADDR(14),
      addrb(16) => mbv_riscv_ilmb_cntlr_ADDR(15),
      addrb(15) => mbv_riscv_ilmb_cntlr_ADDR(16),
      addrb(14) => mbv_riscv_ilmb_cntlr_ADDR(17),
      addrb(13) => mbv_riscv_ilmb_cntlr_ADDR(18),
      addrb(12) => mbv_riscv_ilmb_cntlr_ADDR(19),
      addrb(11) => mbv_riscv_ilmb_cntlr_ADDR(20),
      addrb(10) => mbv_riscv_ilmb_cntlr_ADDR(21),
      addrb(9) => mbv_riscv_ilmb_cntlr_ADDR(22),
      addrb(8) => mbv_riscv_ilmb_cntlr_ADDR(23),
      addrb(7) => mbv_riscv_ilmb_cntlr_ADDR(24),
      addrb(6) => mbv_riscv_ilmb_cntlr_ADDR(25),
      addrb(5) => mbv_riscv_ilmb_cntlr_ADDR(26),
      addrb(4) => mbv_riscv_ilmb_cntlr_ADDR(27),
      addrb(3) => mbv_riscv_ilmb_cntlr_ADDR(28),
      addrb(2) => mbv_riscv_ilmb_cntlr_ADDR(29),
      addrb(1) => mbv_riscv_ilmb_cntlr_ADDR(30),
      addrb(0) => mbv_riscv_ilmb_cntlr_ADDR(31),
      clka => mbv_riscv_dlmb_cntlr_CLK,
      clkb => mbv_riscv_ilmb_cntlr_CLK,
      dina(31) => mbv_riscv_dlmb_cntlr_DIN(0),
      dina(30) => mbv_riscv_dlmb_cntlr_DIN(1),
      dina(29) => mbv_riscv_dlmb_cntlr_DIN(2),
      dina(28) => mbv_riscv_dlmb_cntlr_DIN(3),
      dina(27) => mbv_riscv_dlmb_cntlr_DIN(4),
      dina(26) => mbv_riscv_dlmb_cntlr_DIN(5),
      dina(25) => mbv_riscv_dlmb_cntlr_DIN(6),
      dina(24) => mbv_riscv_dlmb_cntlr_DIN(7),
      dina(23) => mbv_riscv_dlmb_cntlr_DIN(8),
      dina(22) => mbv_riscv_dlmb_cntlr_DIN(9),
      dina(21) => mbv_riscv_dlmb_cntlr_DIN(10),
      dina(20) => mbv_riscv_dlmb_cntlr_DIN(11),
      dina(19) => mbv_riscv_dlmb_cntlr_DIN(12),
      dina(18) => mbv_riscv_dlmb_cntlr_DIN(13),
      dina(17) => mbv_riscv_dlmb_cntlr_DIN(14),
      dina(16) => mbv_riscv_dlmb_cntlr_DIN(15),
      dina(15) => mbv_riscv_dlmb_cntlr_DIN(16),
      dina(14) => mbv_riscv_dlmb_cntlr_DIN(17),
      dina(13) => mbv_riscv_dlmb_cntlr_DIN(18),
      dina(12) => mbv_riscv_dlmb_cntlr_DIN(19),
      dina(11) => mbv_riscv_dlmb_cntlr_DIN(20),
      dina(10) => mbv_riscv_dlmb_cntlr_DIN(21),
      dina(9) => mbv_riscv_dlmb_cntlr_DIN(22),
      dina(8) => mbv_riscv_dlmb_cntlr_DIN(23),
      dina(7) => mbv_riscv_dlmb_cntlr_DIN(24),
      dina(6) => mbv_riscv_dlmb_cntlr_DIN(25),
      dina(5) => mbv_riscv_dlmb_cntlr_DIN(26),
      dina(4) => mbv_riscv_dlmb_cntlr_DIN(27),
      dina(3) => mbv_riscv_dlmb_cntlr_DIN(28),
      dina(2) => mbv_riscv_dlmb_cntlr_DIN(29),
      dina(1) => mbv_riscv_dlmb_cntlr_DIN(30),
      dina(0) => mbv_riscv_dlmb_cntlr_DIN(31),
      dinb(31) => mbv_riscv_ilmb_cntlr_DIN(0),
      dinb(30) => mbv_riscv_ilmb_cntlr_DIN(1),
      dinb(29) => mbv_riscv_ilmb_cntlr_DIN(2),
      dinb(28) => mbv_riscv_ilmb_cntlr_DIN(3),
      dinb(27) => mbv_riscv_ilmb_cntlr_DIN(4),
      dinb(26) => mbv_riscv_ilmb_cntlr_DIN(5),
      dinb(25) => mbv_riscv_ilmb_cntlr_DIN(6),
      dinb(24) => mbv_riscv_ilmb_cntlr_DIN(7),
      dinb(23) => mbv_riscv_ilmb_cntlr_DIN(8),
      dinb(22) => mbv_riscv_ilmb_cntlr_DIN(9),
      dinb(21) => mbv_riscv_ilmb_cntlr_DIN(10),
      dinb(20) => mbv_riscv_ilmb_cntlr_DIN(11),
      dinb(19) => mbv_riscv_ilmb_cntlr_DIN(12),
      dinb(18) => mbv_riscv_ilmb_cntlr_DIN(13),
      dinb(17) => mbv_riscv_ilmb_cntlr_DIN(14),
      dinb(16) => mbv_riscv_ilmb_cntlr_DIN(15),
      dinb(15) => mbv_riscv_ilmb_cntlr_DIN(16),
      dinb(14) => mbv_riscv_ilmb_cntlr_DIN(17),
      dinb(13) => mbv_riscv_ilmb_cntlr_DIN(18),
      dinb(12) => mbv_riscv_ilmb_cntlr_DIN(19),
      dinb(11) => mbv_riscv_ilmb_cntlr_DIN(20),
      dinb(10) => mbv_riscv_ilmb_cntlr_DIN(21),
      dinb(9) => mbv_riscv_ilmb_cntlr_DIN(22),
      dinb(8) => mbv_riscv_ilmb_cntlr_DIN(23),
      dinb(7) => mbv_riscv_ilmb_cntlr_DIN(24),
      dinb(6) => mbv_riscv_ilmb_cntlr_DIN(25),
      dinb(5) => mbv_riscv_ilmb_cntlr_DIN(26),
      dinb(4) => mbv_riscv_ilmb_cntlr_DIN(27),
      dinb(3) => mbv_riscv_ilmb_cntlr_DIN(28),
      dinb(2) => mbv_riscv_ilmb_cntlr_DIN(29),
      dinb(1) => mbv_riscv_ilmb_cntlr_DIN(30),
      dinb(0) => mbv_riscv_ilmb_cntlr_DIN(31),
      douta(31 downto 0) => mbv_riscv_dlmb_cntlr_DOUT(31 downto 0),
      doutb(31 downto 0) => mbv_riscv_ilmb_cntlr_DOUT(31 downto 0),
      ena => mbv_riscv_dlmb_cntlr_EN,
      enb => mbv_riscv_ilmb_cntlr_EN,
      rsta => mbv_riscv_dlmb_cntlr_RST,
      rsta_busy => NLW_mbv_block_memory_generator_rsta_busy_UNCONNECTED,
      rstb => mbv_riscv_ilmb_cntlr_RST,
      rstb_busy => NLW_mbv_block_memory_generator_rstb_busy_UNCONNECTED,
      wea(3) => mbv_riscv_dlmb_cntlr_WE(0),
      wea(2) => mbv_riscv_dlmb_cntlr_WE(1),
      wea(1) => mbv_riscv_dlmb_cntlr_WE(2),
      wea(0) => mbv_riscv_dlmb_cntlr_WE(3),
      web(3) => mbv_riscv_ilmb_cntlr_WE(0),
      web(2) => mbv_riscv_ilmb_cntlr_WE(1),
      web(1) => mbv_riscv_ilmb_cntlr_WE(2),
      web(0) => mbv_riscv_ilmb_cntlr_WE(3)
    );
mbv_data_lmb_bram_controller: component mbv_system_dlmb_bram_if_cntlr_1
     port map (
      BRAM_Addr_A(0 to 31) => mbv_riscv_dlmb_cntlr_ADDR(0 to 31),
      BRAM_Clk_A => mbv_riscv_dlmb_cntlr_CLK,
      BRAM_Din_A(0) => mbv_riscv_dlmb_cntlr_DOUT(31),
      BRAM_Din_A(1) => mbv_riscv_dlmb_cntlr_DOUT(30),
      BRAM_Din_A(2) => mbv_riscv_dlmb_cntlr_DOUT(29),
      BRAM_Din_A(3) => mbv_riscv_dlmb_cntlr_DOUT(28),
      BRAM_Din_A(4) => mbv_riscv_dlmb_cntlr_DOUT(27),
      BRAM_Din_A(5) => mbv_riscv_dlmb_cntlr_DOUT(26),
      BRAM_Din_A(6) => mbv_riscv_dlmb_cntlr_DOUT(25),
      BRAM_Din_A(7) => mbv_riscv_dlmb_cntlr_DOUT(24),
      BRAM_Din_A(8) => mbv_riscv_dlmb_cntlr_DOUT(23),
      BRAM_Din_A(9) => mbv_riscv_dlmb_cntlr_DOUT(22),
      BRAM_Din_A(10) => mbv_riscv_dlmb_cntlr_DOUT(21),
      BRAM_Din_A(11) => mbv_riscv_dlmb_cntlr_DOUT(20),
      BRAM_Din_A(12) => mbv_riscv_dlmb_cntlr_DOUT(19),
      BRAM_Din_A(13) => mbv_riscv_dlmb_cntlr_DOUT(18),
      BRAM_Din_A(14) => mbv_riscv_dlmb_cntlr_DOUT(17),
      BRAM_Din_A(15) => mbv_riscv_dlmb_cntlr_DOUT(16),
      BRAM_Din_A(16) => mbv_riscv_dlmb_cntlr_DOUT(15),
      BRAM_Din_A(17) => mbv_riscv_dlmb_cntlr_DOUT(14),
      BRAM_Din_A(18) => mbv_riscv_dlmb_cntlr_DOUT(13),
      BRAM_Din_A(19) => mbv_riscv_dlmb_cntlr_DOUT(12),
      BRAM_Din_A(20) => mbv_riscv_dlmb_cntlr_DOUT(11),
      BRAM_Din_A(21) => mbv_riscv_dlmb_cntlr_DOUT(10),
      BRAM_Din_A(22) => mbv_riscv_dlmb_cntlr_DOUT(9),
      BRAM_Din_A(23) => mbv_riscv_dlmb_cntlr_DOUT(8),
      BRAM_Din_A(24) => mbv_riscv_dlmb_cntlr_DOUT(7),
      BRAM_Din_A(25) => mbv_riscv_dlmb_cntlr_DOUT(6),
      BRAM_Din_A(26) => mbv_riscv_dlmb_cntlr_DOUT(5),
      BRAM_Din_A(27) => mbv_riscv_dlmb_cntlr_DOUT(4),
      BRAM_Din_A(28) => mbv_riscv_dlmb_cntlr_DOUT(3),
      BRAM_Din_A(29) => mbv_riscv_dlmb_cntlr_DOUT(2),
      BRAM_Din_A(30) => mbv_riscv_dlmb_cntlr_DOUT(1),
      BRAM_Din_A(31) => mbv_riscv_dlmb_cntlr_DOUT(0),
      BRAM_Dout_A(0 to 31) => mbv_riscv_dlmb_cntlr_DIN(0 to 31),
      BRAM_EN_A => mbv_riscv_dlmb_cntlr_EN,
      BRAM_Rst_A => mbv_riscv_dlmb_cntlr_RST,
      BRAM_WEN_A(0 to 3) => mbv_riscv_dlmb_cntlr_WE(0 to 3),
      LMB_ABus(0 to 33) => mbv_riscv_dlmb_bus_ABUS(0 to 33),
      LMB_AddrStrobe => mbv_riscv_dlmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => mbv_riscv_dlmb_bus_BE(0 to 3),
      LMB_Clk => LMB_Clk,
      LMB_ReadStrobe => mbv_riscv_dlmb_bus_READSTROBE,
      LMB_Rst => SYS_Rst,
      LMB_WriteDBus(0 to 31) => mbv_riscv_dlmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => mbv_riscv_dlmb_bus_WRITESTROBE,
      Sl_CE => mbv_riscv_dlmb_bus_CE,
      Sl_DBus(0 to 31) => mbv_riscv_dlmb_bus_READDBUS(0 to 31),
      Sl_Ready => mbv_riscv_dlmb_bus_READY,
      Sl_UE => mbv_riscv_dlmb_bus_UE,
      Sl_Wait => mbv_riscv_dlmb_bus_WAIT
    );
mbv_data_local_memory_bus: component mbv_system_dlmb_v10_1
     port map (
      LMB_ABus(0 to 33) => mbv_riscv_dlmb_bus_ABUS(0 to 33),
      LMB_AddrStrobe => mbv_riscv_dlmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => mbv_riscv_dlmb_bus_BE(0 to 3),
      LMB_CE => DLMB_ce,
      LMB_Clk => LMB_Clk,
      LMB_ReadDBus(0 to 31) => DLMB_readdbus(0 to 31),
      LMB_ReadStrobe => mbv_riscv_dlmb_bus_READSTROBE,
      LMB_Ready => DLMB_ready,
      LMB_Rst => NLW_mbv_data_local_memory_bus_LMB_Rst_UNCONNECTED,
      LMB_UE => DLMB_ue,
      LMB_Wait => DLMB_wait,
      LMB_WriteDBus(0 to 31) => mbv_riscv_dlmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => mbv_riscv_dlmb_bus_WRITESTROBE,
      M_ABus(0 to 33) => DLMB_abus(0 to 33),
      M_AddrStrobe => DLMB_addrstrobe,
      M_BE(0 to 3) => DLMB_be(0 to 3),
      M_DBus(0 to 31) => DLMB_writedbus(0 to 31),
      M_ReadStrobe => DLMB_readstrobe,
      M_WriteStrobe => DLMB_writestrobe,
      SYS_Rst => SYS_Rst,
      Sl_CE(0) => mbv_riscv_dlmb_bus_CE,
      Sl_DBus(0 to 31) => mbv_riscv_dlmb_bus_READDBUS(0 to 31),
      Sl_Ready(0) => mbv_riscv_dlmb_bus_READY,
      Sl_UE(0) => mbv_riscv_dlmb_bus_UE,
      Sl_Wait(0) => mbv_riscv_dlmb_bus_WAIT
    );
mbv_instruction_lmb_bram_controller: component mbv_system_ilmb_bram_if_cntlr_1
     port map (
      BRAM_Addr_A(0 to 31) => mbv_riscv_ilmb_cntlr_ADDR(0 to 31),
      BRAM_Clk_A => mbv_riscv_ilmb_cntlr_CLK,
      BRAM_Din_A(0) => mbv_riscv_ilmb_cntlr_DOUT(31),
      BRAM_Din_A(1) => mbv_riscv_ilmb_cntlr_DOUT(30),
      BRAM_Din_A(2) => mbv_riscv_ilmb_cntlr_DOUT(29),
      BRAM_Din_A(3) => mbv_riscv_ilmb_cntlr_DOUT(28),
      BRAM_Din_A(4) => mbv_riscv_ilmb_cntlr_DOUT(27),
      BRAM_Din_A(5) => mbv_riscv_ilmb_cntlr_DOUT(26),
      BRAM_Din_A(6) => mbv_riscv_ilmb_cntlr_DOUT(25),
      BRAM_Din_A(7) => mbv_riscv_ilmb_cntlr_DOUT(24),
      BRAM_Din_A(8) => mbv_riscv_ilmb_cntlr_DOUT(23),
      BRAM_Din_A(9) => mbv_riscv_ilmb_cntlr_DOUT(22),
      BRAM_Din_A(10) => mbv_riscv_ilmb_cntlr_DOUT(21),
      BRAM_Din_A(11) => mbv_riscv_ilmb_cntlr_DOUT(20),
      BRAM_Din_A(12) => mbv_riscv_ilmb_cntlr_DOUT(19),
      BRAM_Din_A(13) => mbv_riscv_ilmb_cntlr_DOUT(18),
      BRAM_Din_A(14) => mbv_riscv_ilmb_cntlr_DOUT(17),
      BRAM_Din_A(15) => mbv_riscv_ilmb_cntlr_DOUT(16),
      BRAM_Din_A(16) => mbv_riscv_ilmb_cntlr_DOUT(15),
      BRAM_Din_A(17) => mbv_riscv_ilmb_cntlr_DOUT(14),
      BRAM_Din_A(18) => mbv_riscv_ilmb_cntlr_DOUT(13),
      BRAM_Din_A(19) => mbv_riscv_ilmb_cntlr_DOUT(12),
      BRAM_Din_A(20) => mbv_riscv_ilmb_cntlr_DOUT(11),
      BRAM_Din_A(21) => mbv_riscv_ilmb_cntlr_DOUT(10),
      BRAM_Din_A(22) => mbv_riscv_ilmb_cntlr_DOUT(9),
      BRAM_Din_A(23) => mbv_riscv_ilmb_cntlr_DOUT(8),
      BRAM_Din_A(24) => mbv_riscv_ilmb_cntlr_DOUT(7),
      BRAM_Din_A(25) => mbv_riscv_ilmb_cntlr_DOUT(6),
      BRAM_Din_A(26) => mbv_riscv_ilmb_cntlr_DOUT(5),
      BRAM_Din_A(27) => mbv_riscv_ilmb_cntlr_DOUT(4),
      BRAM_Din_A(28) => mbv_riscv_ilmb_cntlr_DOUT(3),
      BRAM_Din_A(29) => mbv_riscv_ilmb_cntlr_DOUT(2),
      BRAM_Din_A(30) => mbv_riscv_ilmb_cntlr_DOUT(1),
      BRAM_Din_A(31) => mbv_riscv_ilmb_cntlr_DOUT(0),
      BRAM_Dout_A(0 to 31) => mbv_riscv_ilmb_cntlr_DIN(0 to 31),
      BRAM_EN_A => mbv_riscv_ilmb_cntlr_EN,
      BRAM_Rst_A => mbv_riscv_ilmb_cntlr_RST,
      BRAM_WEN_A(0 to 3) => mbv_riscv_ilmb_cntlr_WE(0 to 3),
      LMB_ABus(0 to 33) => mbv_riscv_ilmb_bus_ABUS(0 to 33),
      LMB_AddrStrobe => mbv_riscv_ilmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => mbv_riscv_ilmb_bus_BE(0 to 3),
      LMB_Clk => LMB_Clk,
      LMB_ReadStrobe => mbv_riscv_ilmb_bus_READSTROBE,
      LMB_Rst => SYS_Rst,
      LMB_WriteDBus(0 to 31) => mbv_riscv_ilmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => mbv_riscv_ilmb_bus_WRITESTROBE,
      Sl_CE => mbv_riscv_ilmb_bus_CE,
      Sl_DBus(0 to 31) => mbv_riscv_ilmb_bus_READDBUS(0 to 31),
      Sl_Ready => mbv_riscv_ilmb_bus_READY,
      Sl_UE => mbv_riscv_ilmb_bus_UE,
      Sl_Wait => mbv_riscv_ilmb_bus_WAIT
    );
mbv_instruction_local_memory_bus: component mbv_system_ilmb_v10_1
     port map (
      LMB_ABus(0 to 33) => mbv_riscv_ilmb_bus_ABUS(0 to 33),
      LMB_AddrStrobe => mbv_riscv_ilmb_bus_ADDRSTROBE,
      LMB_BE(0 to 3) => mbv_riscv_ilmb_bus_BE(0 to 3),
      LMB_CE => ILMB_ce,
      LMB_Clk => LMB_Clk,
      LMB_ReadDBus(0 to 31) => ILMB_readdbus(0 to 31),
      LMB_ReadStrobe => mbv_riscv_ilmb_bus_READSTROBE,
      LMB_Ready => ILMB_ready,
      LMB_Rst => NLW_mbv_instruction_local_memory_bus_LMB_Rst_UNCONNECTED,
      LMB_UE => ILMB_ue,
      LMB_Wait => ILMB_wait,
      LMB_WriteDBus(0 to 31) => mbv_riscv_ilmb_bus_WRITEDBUS(0 to 31),
      LMB_WriteStrobe => mbv_riscv_ilmb_bus_WRITESTROBE,
      M_ABus(0 to 33) => ILMB_abus(0 to 33),
      M_AddrStrobe => ILMB_addrstrobe,
      M_BE(0 to 3) => B"0000",
      M_DBus(0 to 31) => B"00000000000000000000000000000000",
      M_ReadStrobe => ILMB_readstrobe,
      M_WriteStrobe => '0',
      SYS_Rst => SYS_Rst,
      Sl_CE(0) => mbv_riscv_ilmb_bus_CE,
      Sl_DBus(0 to 31) => mbv_riscv_ilmb_bus_READDBUS(0 to 31),
      Sl_Ready(0) => mbv_riscv_ilmb_bus_READY,
      Sl_UE(0) => mbv_riscv_ilmb_bus_UE,
      Sl_Wait(0) => mbv_riscv_ilmb_bus_WAIT
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system is
  port (
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    eth_mdio_mdc_mdc : out STD_LOGIC;
    eth_mdio_mdc_mdio_i : in STD_LOGIC;
    eth_mdio_mdc_mdio_o : out STD_LOGIC;
    eth_mdio_mdc_mdio_t : out STD_LOGIC;
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
    i2c_scl_i : in STD_LOGIC;
    i2c_scl_o : out STD_LOGIC;
    i2c_scl_t : out STD_LOGIC;
    i2c_sda_i : in STD_LOGIC;
    i2c_sda_o : out STD_LOGIC;
    i2c_sda_t : out STD_LOGIC;
    led_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
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
    reset : in STD_LOGIC;
    rgb_led_tri_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    shield_dp0_dp19_tri_i : in STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp0_dp19_tri_o : out STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp0_dp19_tri_t : out STD_LOGIC_VECTOR ( 19 downto 0 );
    shield_dp26_dp41_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    shield_dp26_dp41_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    shield_dp26_dp41_tri_t : out STD_LOGIC_VECTOR ( 15 downto 0 );
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
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of mbv_system : entity is "mbv_system,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=mbv_system,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=28,numReposBlks=27,numNonXlnxBlks=0,numHierBlks=1,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_axi4_cnt=15,da_board_cnt=10,da_clkrst_cnt=4,da_microblaze_riscv_cnt=2,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of mbv_system : entity is "mbv_system.hwdef";
end mbv_system;

architecture STRUCTURE of mbv_system is
  component mbv_system_microblaze_riscv_0_0 is
  port (
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Interrupt : in STD_LOGIC;
    Interrupt_Address : in STD_LOGIC_VECTOR ( 0 to 31 );
    Interrupt_Ack : out STD_LOGIC_VECTOR ( 0 to 1 );
    Instr_Addr : out STD_LOGIC_VECTOR ( 0 to 33 );
    Instr : in STD_LOGIC_VECTOR ( 0 to 31 );
    IFetch : out STD_LOGIC;
    I_AS : out STD_LOGIC;
    IReady : in STD_LOGIC;
    IWAIT : in STD_LOGIC;
    ICE : in STD_LOGIC;
    IUE : in STD_LOGIC;
    Data_Addr : out STD_LOGIC_VECTOR ( 0 to 33 );
    Data_Read : in STD_LOGIC_VECTOR ( 0 to 31 );
    Data_Write : out STD_LOGIC_VECTOR ( 0 to 31 );
    D_AS : out STD_LOGIC;
    Read_Strobe : out STD_LOGIC;
    Write_Strobe : out STD_LOGIC;
    DReady : in STD_LOGIC;
    DWait : in STD_LOGIC;
    DCE : in STD_LOGIC;
    DUE : in STD_LOGIC;
    Byte_Enable : out STD_LOGIC_VECTOR ( 0 to 3 );
    M_AXI_DP_AWADDR : out STD_LOGIC_VECTOR ( 33 downto 0 );
    M_AXI_DP_AWPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_AWVALID : out STD_LOGIC;
    M_AXI_DP_AWREADY : in STD_LOGIC;
    M_AXI_DP_WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M_AXI_DP_WVALID : out STD_LOGIC;
    M_AXI_DP_WREADY : in STD_LOGIC;
    M_AXI_DP_BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_BVALID : in STD_LOGIC;
    M_AXI_DP_BREADY : out STD_LOGIC;
    M_AXI_DP_ARADDR : out STD_LOGIC_VECTOR ( 33 downto 0 );
    M_AXI_DP_ARPROT : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M_AXI_DP_ARVALID : out STD_LOGIC;
    M_AXI_DP_ARREADY : in STD_LOGIC;
    M_AXI_DP_RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M_AXI_DP_RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M_AXI_DP_RVALID : in STD_LOGIC;
    M_AXI_DP_RREADY : out STD_LOGIC;
    Dbg_Clk : in STD_LOGIC;
    Dbg_TDI : in STD_LOGIC;
    Dbg_TDO : out STD_LOGIC;
    Dbg_Reg_En : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Shift : in STD_LOGIC;
    Dbg_Capture : in STD_LOGIC;
    Dbg_Update : in STD_LOGIC;
    Dbg_Trig_In : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Trig_Ack_In : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Trig_Out : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Trig_Ack_Out : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Trace_Clk : in STD_LOGIC;
    Dbg_Trace_Data : out STD_LOGIC_VECTOR ( 0 to 35 );
    Dbg_Trace_Ready : in STD_LOGIC;
    Dbg_Trace_Valid : out STD_LOGIC;
    Debug_Rst : in STD_LOGIC;
    Dbg_Disable : in STD_LOGIC;
    Dbg_AWADDR : in STD_LOGIC_VECTOR ( 14 downto 2 );
    Dbg_AWVALID : in STD_LOGIC;
    Dbg_AWREADY : out STD_LOGIC;
    Dbg_WDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dbg_WVALID : in STD_LOGIC;
    Dbg_WREADY : out STD_LOGIC;
    Dbg_BRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Dbg_BVALID : out STD_LOGIC;
    Dbg_BREADY : in STD_LOGIC;
    Dbg_ARADDR : in STD_LOGIC_VECTOR ( 14 downto 2 );
    Dbg_ARVALID : in STD_LOGIC;
    Dbg_ARREADY : out STD_LOGIC;
    Dbg_RDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Dbg_RRESP : out STD_LOGIC_VECTOR ( 1 downto 0 );
    Dbg_RVALID : out STD_LOGIC;
    Dbg_RREADY : in STD_LOGIC
  );
  end component mbv_system_microblaze_riscv_0_0;
  component mbv_system_mbv_riscv_axi_periph_1 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    S00_AXI_awaddr : in STD_LOGIC_VECTOR ( 33 downto 0 );
    S00_AXI_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_awvalid : in STD_LOGIC;
    S00_AXI_awready : out STD_LOGIC;
    S00_AXI_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S00_AXI_wvalid : in STD_LOGIC;
    S00_AXI_wready : out STD_LOGIC;
    S00_AXI_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_bvalid : out STD_LOGIC;
    S00_AXI_bready : in STD_LOGIC;
    S00_AXI_araddr : in STD_LOGIC_VECTOR ( 33 downto 0 );
    S00_AXI_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    S00_AXI_arvalid : in STD_LOGIC;
    S00_AXI_arready : out STD_LOGIC;
    S00_AXI_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S00_AXI_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    S00_AXI_rvalid : out STD_LOGIC;
    S00_AXI_rready : in STD_LOGIC;
    M00_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_awvalid : out STD_LOGIC;
    M00_AXI_awready : in STD_LOGIC;
    M00_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M00_AXI_wvalid : out STD_LOGIC;
    M00_AXI_wready : in STD_LOGIC;
    M00_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_bvalid : in STD_LOGIC;
    M00_AXI_bready : out STD_LOGIC;
    M00_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M00_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M00_AXI_arvalid : out STD_LOGIC;
    M00_AXI_arready : in STD_LOGIC;
    M00_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M00_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M00_AXI_rvalid : in STD_LOGIC;
    M00_AXI_rready : out STD_LOGIC;
    M01_AXI_awaddr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    M01_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_awvalid : out STD_LOGIC;
    M01_AXI_awready : in STD_LOGIC;
    M01_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M01_AXI_wvalid : out STD_LOGIC;
    M01_AXI_wready : in STD_LOGIC;
    M01_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_bvalid : in STD_LOGIC;
    M01_AXI_bready : out STD_LOGIC;
    M01_AXI_araddr : out STD_LOGIC_VECTOR ( 5 downto 0 );
    M01_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M01_AXI_arvalid : out STD_LOGIC;
    M01_AXI_arready : in STD_LOGIC;
    M01_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M01_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M01_AXI_rvalid : in STD_LOGIC;
    M01_AXI_rready : out STD_LOGIC;
    M02_AXI_awaddr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_awvalid : out STD_LOGIC;
    M02_AXI_awready : in STD_LOGIC;
    M02_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_wvalid : out STD_LOGIC;
    M02_AXI_wready : in STD_LOGIC;
    M02_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_bvalid : in STD_LOGIC;
    M02_AXI_bready : out STD_LOGIC;
    M02_AXI_araddr : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M02_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M02_AXI_arvalid : out STD_LOGIC;
    M02_AXI_arready : in STD_LOGIC;
    M02_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M02_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M02_AXI_rvalid : in STD_LOGIC;
    M02_AXI_rready : out STD_LOGIC;
    M03_AXI_awaddr : out STD_LOGIC_VECTOR ( 23 downto 0 );
    M03_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M03_AXI_awvalid : out STD_LOGIC;
    M03_AXI_awready : in STD_LOGIC;
    M03_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_wvalid : out STD_LOGIC;
    M03_AXI_wready : in STD_LOGIC;
    M03_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_bvalid : in STD_LOGIC;
    M03_AXI_bready : out STD_LOGIC;
    M03_AXI_araddr : out STD_LOGIC_VECTOR ( 23 downto 0 );
    M03_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M03_AXI_arvalid : out STD_LOGIC;
    M03_AXI_arready : in STD_LOGIC;
    M03_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M03_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_rvalid : in STD_LOGIC;
    M03_AXI_rready : out STD_LOGIC;
    M04_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M04_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M04_AXI_awvalid : out STD_LOGIC;
    M04_AXI_awready : in STD_LOGIC;
    M04_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M04_AXI_wvalid : out STD_LOGIC;
    M04_AXI_wready : in STD_LOGIC;
    M04_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_bvalid : in STD_LOGIC;
    M04_AXI_bready : out STD_LOGIC;
    M04_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M04_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M04_AXI_arvalid : out STD_LOGIC;
    M04_AXI_arready : in STD_LOGIC;
    M04_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M04_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M04_AXI_rvalid : in STD_LOGIC;
    M04_AXI_rready : out STD_LOGIC;
    M05_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M05_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M05_AXI_awvalid : out STD_LOGIC;
    M05_AXI_awready : in STD_LOGIC;
    M05_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M05_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M05_AXI_wvalid : out STD_LOGIC;
    M05_AXI_wready : in STD_LOGIC;
    M05_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M05_AXI_bvalid : in STD_LOGIC;
    M05_AXI_bready : out STD_LOGIC;
    M05_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M05_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M05_AXI_arvalid : out STD_LOGIC;
    M05_AXI_arready : in STD_LOGIC;
    M05_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M05_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M05_AXI_rvalid : in STD_LOGIC;
    M05_AXI_rready : out STD_LOGIC;
    M06_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M06_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M06_AXI_awvalid : out STD_LOGIC;
    M06_AXI_awready : in STD_LOGIC;
    M06_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M06_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M06_AXI_wvalid : out STD_LOGIC;
    M06_AXI_wready : in STD_LOGIC;
    M06_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M06_AXI_bvalid : in STD_LOGIC;
    M06_AXI_bready : out STD_LOGIC;
    M06_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M06_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M06_AXI_arvalid : out STD_LOGIC;
    M06_AXI_arready : in STD_LOGIC;
    M06_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M06_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M06_AXI_rvalid : in STD_LOGIC;
    M06_AXI_rready : out STD_LOGIC;
    M07_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M07_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M07_AXI_awvalid : out STD_LOGIC;
    M07_AXI_awready : in STD_LOGIC;
    M07_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M07_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M07_AXI_wvalid : out STD_LOGIC;
    M07_AXI_wready : in STD_LOGIC;
    M07_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M07_AXI_bvalid : in STD_LOGIC;
    M07_AXI_bready : out STD_LOGIC;
    M07_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M07_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M07_AXI_arvalid : out STD_LOGIC;
    M07_AXI_arready : in STD_LOGIC;
    M07_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M07_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M07_AXI_rvalid : in STD_LOGIC;
    M07_AXI_rready : out STD_LOGIC;
    M08_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M08_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M08_AXI_awvalid : out STD_LOGIC;
    M08_AXI_awready : in STD_LOGIC;
    M08_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M08_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M08_AXI_wvalid : out STD_LOGIC;
    M08_AXI_wready : in STD_LOGIC;
    M08_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M08_AXI_bvalid : in STD_LOGIC;
    M08_AXI_bready : out STD_LOGIC;
    M08_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M08_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M08_AXI_arvalid : out STD_LOGIC;
    M08_AXI_arready : in STD_LOGIC;
    M08_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M08_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M08_AXI_rvalid : in STD_LOGIC;
    M08_AXI_rready : out STD_LOGIC;
    M09_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M09_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M09_AXI_awvalid : out STD_LOGIC;
    M09_AXI_awready : in STD_LOGIC;
    M09_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M09_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M09_AXI_wvalid : out STD_LOGIC;
    M09_AXI_wready : in STD_LOGIC;
    M09_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M09_AXI_bvalid : in STD_LOGIC;
    M09_AXI_bready : out STD_LOGIC;
    M09_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M09_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M09_AXI_arvalid : out STD_LOGIC;
    M09_AXI_arready : in STD_LOGIC;
    M09_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M09_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M09_AXI_rvalid : in STD_LOGIC;
    M09_AXI_rready : out STD_LOGIC;
    M10_AXI_awaddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M10_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M10_AXI_awvalid : out STD_LOGIC;
    M10_AXI_awready : in STD_LOGIC;
    M10_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M10_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M10_AXI_wvalid : out STD_LOGIC;
    M10_AXI_wready : in STD_LOGIC;
    M10_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M10_AXI_bvalid : in STD_LOGIC;
    M10_AXI_bready : out STD_LOGIC;
    M10_AXI_araddr : out STD_LOGIC_VECTOR ( 12 downto 0 );
    M10_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M10_AXI_arvalid : out STD_LOGIC;
    M10_AXI_arready : in STD_LOGIC;
    M10_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M10_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M10_AXI_rvalid : in STD_LOGIC;
    M10_AXI_rready : out STD_LOGIC;
    M03_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M03_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M03_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M03_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_wlast : out STD_LOGIC;
    M03_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M03_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M03_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M03_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M03_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M03_AXI_rlast : in STD_LOGIC;
    M11_AXI_awaddr : out STD_LOGIC_VECTOR ( 23 downto 0 );
    M11_AXI_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M11_AXI_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M11_AXI_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M11_AXI_awlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M11_AXI_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M11_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M11_AXI_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M11_AXI_awvalid : out STD_LOGIC;
    M11_AXI_awready : in STD_LOGIC;
    M11_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M11_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M11_AXI_wlast : out STD_LOGIC;
    M11_AXI_wvalid : out STD_LOGIC;
    M11_AXI_wready : in STD_LOGIC;
    M11_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M11_AXI_bvalid : in STD_LOGIC;
    M11_AXI_bready : out STD_LOGIC;
    M11_AXI_araddr : out STD_LOGIC_VECTOR ( 23 downto 0 );
    M11_AXI_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    M11_AXI_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M11_AXI_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M11_AXI_arlock : out STD_LOGIC_VECTOR ( 0 to 0 );
    M11_AXI_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M11_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M11_AXI_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M11_AXI_arvalid : out STD_LOGIC;
    M11_AXI_arready : in STD_LOGIC;
    M11_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M11_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M11_AXI_rlast : in STD_LOGIC;
    M11_AXI_rvalid : in STD_LOGIC;
    M11_AXI_rready : out STD_LOGIC;
    M12_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M12_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M12_AXI_awvalid : out STD_LOGIC;
    M12_AXI_awready : in STD_LOGIC;
    M12_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M12_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M12_AXI_wvalid : out STD_LOGIC;
    M12_AXI_wready : in STD_LOGIC;
    M12_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M12_AXI_bvalid : in STD_LOGIC;
    M12_AXI_bready : out STD_LOGIC;
    M12_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M12_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M12_AXI_arvalid : out STD_LOGIC;
    M12_AXI_arready : in STD_LOGIC;
    M12_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M12_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M12_AXI_rvalid : in STD_LOGIC;
    M12_AXI_rready : out STD_LOGIC;
    M13_AXI_awaddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M13_AXI_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M13_AXI_awvalid : out STD_LOGIC;
    M13_AXI_awready : in STD_LOGIC;
    M13_AXI_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M13_AXI_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M13_AXI_wvalid : out STD_LOGIC;
    M13_AXI_wready : in STD_LOGIC;
    M13_AXI_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M13_AXI_bvalid : in STD_LOGIC;
    M13_AXI_bready : out STD_LOGIC;
    M13_AXI_araddr : out STD_LOGIC_VECTOR ( 8 downto 0 );
    M13_AXI_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    M13_AXI_arvalid : out STD_LOGIC;
    M13_AXI_arready : in STD_LOGIC;
    M13_AXI_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M13_AXI_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    M13_AXI_rvalid : in STD_LOGIC;
    M13_AXI_rready : out STD_LOGIC
  );
  end component mbv_system_mbv_riscv_axi_periph_1;
  component mbv_system_mbv_riscv_axi_intc_1 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    intr : in STD_LOGIC_VECTOR ( 10 downto 0 );
    processor_clk : in STD_LOGIC;
    processor_rst : in STD_LOGIC;
    irq : out STD_LOGIC;
    processor_ack : in STD_LOGIC_VECTOR ( 1 downto 0 );
    interrupt_address : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component mbv_system_mbv_riscv_axi_intc_1;
  component mbv_system_mdm_1_1 is
  port (
    M_AXI_ACLK : in STD_LOGIC;
    M_AXI_ARESETN : in STD_LOGIC;
    Debug_SYS_Rst : out STD_LOGIC;
    TRACE_CLK_OUT : out STD_LOGIC;
    TRACE_CLK : in STD_LOGIC;
    TRACE_CTL : out STD_LOGIC;
    TRACE_DATA : out STD_LOGIC_VECTOR ( 15 downto 0 );
    Dbg_Clk_0 : out STD_LOGIC;
    Dbg_TDI_0 : out STD_LOGIC;
    Dbg_TDO_0 : in STD_LOGIC;
    Dbg_Reg_En_0 : out STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_Capture_0 : out STD_LOGIC;
    Dbg_Shift_0 : out STD_LOGIC;
    Dbg_Update_0 : out STD_LOGIC;
    Dbg_Rst_0 : out STD_LOGIC;
    Dbg_Trig_In_0 : in STD_LOGIC_VECTOR ( 0 to 7 );
    Dbg_TrClk_0 : out STD_LOGIC;
    Dbg_TrData_0 : in STD_LOGIC_VECTOR ( 0 to 35 );
    Dbg_TrReady_0 : out STD_LOGIC;
    Dbg_TrValid_0 : in STD_LOGIC;
    Dbg_Disable_0 : out STD_LOGIC;
    Dbg_AWADDR_0 : out STD_LOGIC_VECTOR ( 14 downto 2 );
    Dbg_AWVALID_0 : out STD_LOGIC;
    Dbg_AWREADY_0 : in STD_LOGIC;
    Dbg_WDATA_0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Dbg_WVALID_0 : out STD_LOGIC;
    Dbg_WREADY_0 : in STD_LOGIC;
    Dbg_BRESP_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Dbg_BVALID_0 : in STD_LOGIC;
    Dbg_BREADY_0 : out STD_LOGIC;
    Dbg_ARADDR_0 : out STD_LOGIC_VECTOR ( 14 downto 2 );
    Dbg_ARVALID_0 : out STD_LOGIC;
    Dbg_ARREADY_0 : in STD_LOGIC;
    Dbg_RDATA_0 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Dbg_RRESP_0 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    Dbg_RVALID_0 : in STD_LOGIC;
    Dbg_RREADY_0 : out STD_LOGIC
  );
  end component mbv_system_mdm_1_1;
  component mbv_system_clk_wiz_1_1 is
  port (
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component mbv_system_clk_wiz_1_1;
  component mbv_system_rst_clk_wiz_1_100M_1 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component mbv_system_rst_clk_wiz_1_100M_1;
  component mbv_system_fit_timer_0_0 is
  port (
    Clk : in STD_LOGIC;
    Rst : in STD_LOGIC;
    Interrupt : out STD_LOGIC
  );
  end component mbv_system_fit_timer_0_0;
  component mbv_system_axi_timebase_wdt_0_0 is
  port (
    s_axi_araddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 5 downto 0 );
    s_axi_awready : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wready : out STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    wdt_interrupt : out STD_LOGIC;
    wdt_reset : out STD_LOGIC;
    wdt_reset_pending : out STD_LOGIC;
    wdt_state_vec : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  end component mbv_system_axi_timebase_wdt_0_0;
  component mbv_system_axi_uartlite_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    interrupt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    rx : in STD_LOGIC;
    tx : out STD_LOGIC
  );
  end component mbv_system_axi_uartlite_0_0;
  component mbv_system_axi_quad_spi_0_0 is
  port (
    ext_spi_clk : in STD_LOGIC;
    s_axi4_aclk : in STD_LOGIC;
    s_axi4_aresetn : in STD_LOGIC;
    s_axi4_awaddr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi4_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi4_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_awlock : in STD_LOGIC;
    s_axi4_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_awvalid : in STD_LOGIC;
    s_axi4_awready : out STD_LOGIC;
    s_axi4_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi4_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_wlast : in STD_LOGIC;
    s_axi4_wvalid : in STD_LOGIC;
    s_axi4_wready : out STD_LOGIC;
    s_axi4_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_bvalid : out STD_LOGIC;
    s_axi4_bready : in STD_LOGIC;
    s_axi4_araddr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi4_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi4_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_arlock : in STD_LOGIC;
    s_axi4_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_arvalid : in STD_LOGIC;
    s_axi4_arready : out STD_LOGIC;
    s_axi4_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi4_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_rlast : out STD_LOGIC;
    s_axi4_rvalid : out STD_LOGIC;
    s_axi4_rready : in STD_LOGIC;
    io0_i : in STD_LOGIC;
    io0_o : out STD_LOGIC;
    io0_t : out STD_LOGIC;
    io1_i : in STD_LOGIC;
    io1_o : out STD_LOGIC;
    io1_t : out STD_LOGIC;
    io2_i : in STD_LOGIC;
    io2_o : out STD_LOGIC;
    io2_t : out STD_LOGIC;
    io3_i : in STD_LOGIC;
    io3_o : out STD_LOGIC;
    io3_t : out STD_LOGIC;
    sck_i : in STD_LOGIC;
    sck_o : out STD_LOGIC;
    sck_t : out STD_LOGIC;
    ss_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    ss_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    ss_t : out STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC
  );
  end component mbv_system_axi_quad_spi_0_0;
  component mbv_system_axi_gpio_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 19 downto 0 );
    gpio_io_o : out STD_LOGIC_VECTOR ( 19 downto 0 );
    gpio_io_t : out STD_LOGIC_VECTOR ( 19 downto 0 )
  );
  end component mbv_system_axi_gpio_0_0;
  component mbv_system_axi_gpio_0_1 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    gpio_io_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    gpio_io_t : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component mbv_system_axi_gpio_0_1;
  component mbv_system_axi_gpio_0_2 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component mbv_system_axi_gpio_0_2;
  component mbv_system_axi_gpio_0_3 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    gpio_io_i : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component mbv_system_axi_gpio_0_3;
  component mbv_system_axi_gpio_0_4 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    gpio_io_o : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component mbv_system_axi_gpio_0_4;
  component mbv_system_axi_gpio_0_5 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    gpio_io_o : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component mbv_system_axi_gpio_0_5;
  component mbv_system_axi_ethernetlite_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    phy_tx_clk : in STD_LOGIC;
    phy_rx_clk : in STD_LOGIC;
    phy_crs : in STD_LOGIC;
    phy_dv : in STD_LOGIC;
    phy_rx_data : in STD_LOGIC_VECTOR ( 3 downto 0 );
    phy_col : in STD_LOGIC;
    phy_rx_er : in STD_LOGIC;
    phy_rst_n : out STD_LOGIC;
    phy_tx_en : out STD_LOGIC;
    phy_tx_data : out STD_LOGIC_VECTOR ( 3 downto 0 );
    phy_mdio_i : in STD_LOGIC;
    phy_mdio_o : out STD_LOGIC;
    phy_mdio_t : out STD_LOGIC;
    phy_mdc : out STD_LOGIC
  );
  end component mbv_system_axi_ethernetlite_0_0;
  component mbv_system_axi_quad_spi_0_1 is
  port (
    ext_spi_clk : in STD_LOGIC;
    s_axi4_aclk : in STD_LOGIC;
    s_axi4_aresetn : in STD_LOGIC;
    s_axi4_awaddr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi4_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi4_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_awlock : in STD_LOGIC;
    s_axi4_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_awvalid : in STD_LOGIC;
    s_axi4_awready : out STD_LOGIC;
    s_axi4_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi4_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_wlast : in STD_LOGIC;
    s_axi4_wvalid : in STD_LOGIC;
    s_axi4_wready : out STD_LOGIC;
    s_axi4_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_bvalid : out STD_LOGIC;
    s_axi4_bready : in STD_LOGIC;
    s_axi4_araddr : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axi4_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi4_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_arlock : in STD_LOGIC;
    s_axi4_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi4_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi4_arvalid : in STD_LOGIC;
    s_axi4_arready : out STD_LOGIC;
    s_axi4_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi4_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi4_rlast : out STD_LOGIC;
    s_axi4_rvalid : out STD_LOGIC;
    s_axi4_rready : in STD_LOGIC;
    io0_i : in STD_LOGIC;
    io0_o : out STD_LOGIC;
    io0_t : out STD_LOGIC;
    io1_i : in STD_LOGIC;
    io1_o : out STD_LOGIC;
    io1_t : out STD_LOGIC;
    sck_i : in STD_LOGIC;
    sck_o : out STD_LOGIC;
    sck_t : out STD_LOGIC;
    ss_i : in STD_LOGIC_VECTOR ( 0 to 0 );
    ss_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    ss_t : out STD_LOGIC;
    ip2intc_irpt : out STD_LOGIC
  );
  end component mbv_system_axi_quad_spi_0_1;
  component mbv_system_axi_iic_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    iic2intc_irpt : out STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    sda_i : in STD_LOGIC;
    sda_o : out STD_LOGIC;
    sda_t : out STD_LOGIC;
    scl_i : in STD_LOGIC;
    scl_o : out STD_LOGIC;
    scl_t : out STD_LOGIC;
    gpo : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component mbv_system_axi_iic_0_0;
  component mbv_system_axi_gpio_0_6 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 8 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    gpio_io_o : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  end component mbv_system_axi_gpio_0_6;
  signal axi_ethernetlite_0_ip2intc_irpt : STD_LOGIC;
  signal axi_gpio_0_ip2intc_irpt : STD_LOGIC;
  signal axi_iic_0_iic2intc_irpt : STD_LOGIC;
  signal axi_quad_spi_0_ip2intc_irpt : STD_LOGIC;
  signal axi_timebase_watchdog_timer_wdt_interrupt : STD_LOGIC;
  signal axi_timebase_watchdog_timer_wdt_reset : STD_LOGIC;
  signal clk_wiz_1_locked : STD_LOGIC;
  signal mbv_axi_gpio_dip_switches_ip2intc_irpt : STD_LOGIC;
  signal mbv_axi_gpio_shield_pins_0_19_ip2intc_irpt : STD_LOGIC;
  signal mbv_axi_gpio_shield_pins_26_41_ip2intc_irpt : STD_LOGIC;
  signal mbv_axi_quad_spi_ip2intc_irpt : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_ARADDR : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_AWADDR : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M01_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M01_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_ARADDR : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_AWADDR : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M02_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M02_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_ARADDR : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_AWADDR : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_RLAST : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_WLAST : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M03_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M03_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M04_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M04_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M05_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M05_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M06_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M06_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M07_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M07_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M08_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M08_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M09_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M09_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_ARADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_AWADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M10_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M10_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_ARADDR : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_AWADDR : STD_LOGIC_VECTOR ( 23 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWLOCK : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_RLAST : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_WLAST : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M11_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M11_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M12_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M12_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_ARREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_ARVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_AWREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_AWVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_BREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_BVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_RREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_RVALID : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_WREADY : STD_LOGIC;
  signal mbv_axi_smartconnect_M13_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_axi_smartconnect_M13_AXI_WVALID : STD_LOGIC;
  signal mbv_axi_uartlite_interrupt : STD_LOGIC;
  signal mbv_fixed_interval_timer_Interrupt : STD_LOGIC;
  signal mbv_processor_system_reset_peripheral_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal mbv_riscv_Clk : STD_LOGIC;
  signal mbv_riscv_axi_dp_ARADDR : STD_LOGIC_VECTOR ( 33 downto 0 );
  signal mbv_riscv_axi_dp_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_riscv_axi_dp_ARREADY : STD_LOGIC;
  signal mbv_riscv_axi_dp_ARVALID : STD_LOGIC;
  signal mbv_riscv_axi_dp_AWADDR : STD_LOGIC_VECTOR ( 33 downto 0 );
  signal mbv_riscv_axi_dp_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal mbv_riscv_axi_dp_AWREADY : STD_LOGIC;
  signal mbv_riscv_axi_dp_AWVALID : STD_LOGIC;
  signal mbv_riscv_axi_dp_BREADY : STD_LOGIC;
  signal mbv_riscv_axi_dp_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_axi_dp_BVALID : STD_LOGIC;
  signal mbv_riscv_axi_dp_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_axi_dp_RREADY : STD_LOGIC;
  signal mbv_riscv_axi_dp_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_axi_dp_RVALID : STD_LOGIC;
  signal mbv_riscv_axi_dp_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_axi_dp_WREADY : STD_LOGIC;
  signal mbv_riscv_axi_dp_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_riscv_axi_dp_WVALID : STD_LOGIC;
  signal mbv_riscv_debug_ARADDR : STD_LOGIC_VECTOR ( 14 downto 2 );
  signal mbv_riscv_debug_ARREADY : STD_LOGIC;
  signal mbv_riscv_debug_ARVALID : STD_LOGIC;
  signal mbv_riscv_debug_AWADDR : STD_LOGIC_VECTOR ( 14 downto 2 );
  signal mbv_riscv_debug_AWREADY : STD_LOGIC;
  signal mbv_riscv_debug_AWVALID : STD_LOGIC;
  signal mbv_riscv_debug_BREADY : STD_LOGIC;
  signal mbv_riscv_debug_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_debug_BVALID : STD_LOGIC;
  signal mbv_riscv_debug_CAPTURE : STD_LOGIC;
  signal mbv_riscv_debug_CLK : STD_LOGIC;
  signal mbv_riscv_debug_DISABLE : STD_LOGIC;
  signal mbv_riscv_debug_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_debug_REG_EN : STD_LOGIC_VECTOR ( 0 to 7 );
  signal mbv_riscv_debug_RREADY : STD_LOGIC;
  signal mbv_riscv_debug_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_debug_RST : STD_LOGIC;
  signal mbv_riscv_debug_RVALID : STD_LOGIC;
  signal mbv_riscv_debug_SHIFT : STD_LOGIC;
  signal mbv_riscv_debug_TDI : STD_LOGIC;
  signal mbv_riscv_debug_TDO : STD_LOGIC;
  signal mbv_riscv_debug_TRCLK : STD_LOGIC;
  signal mbv_riscv_debug_TRDATA : STD_LOGIC_VECTOR ( 0 to 35 );
  signal mbv_riscv_debug_TRIG_IN : STD_LOGIC_VECTOR ( 0 to 7 );
  signal mbv_riscv_debug_TRREADY : STD_LOGIC;
  signal mbv_riscv_debug_TRVALID : STD_LOGIC;
  signal mbv_riscv_debug_UPDATE : STD_LOGIC;
  signal mbv_riscv_debug_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_debug_WREADY : STD_LOGIC;
  signal mbv_riscv_debug_WVALID : STD_LOGIC;
  signal mbv_riscv_dlmb_1_ABUS : STD_LOGIC_VECTOR ( 0 to 33 );
  signal mbv_riscv_dlmb_1_ADDRSTROBE : STD_LOGIC;
  signal mbv_riscv_dlmb_1_BE : STD_LOGIC_VECTOR ( 0 to 3 );
  signal mbv_riscv_dlmb_1_CE : STD_LOGIC;
  signal mbv_riscv_dlmb_1_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_1_READSTROBE : STD_LOGIC;
  signal mbv_riscv_dlmb_1_READY : STD_LOGIC;
  signal mbv_riscv_dlmb_1_UE : STD_LOGIC;
  signal mbv_riscv_dlmb_1_WAIT : STD_LOGIC;
  signal mbv_riscv_dlmb_1_WRITEDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_dlmb_1_WRITESTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_1_ABUS : STD_LOGIC_VECTOR ( 0 to 33 );
  signal mbv_riscv_ilmb_1_ADDRSTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_1_CE : STD_LOGIC;
  signal mbv_riscv_ilmb_1_READDBUS : STD_LOGIC_VECTOR ( 0 to 31 );
  signal mbv_riscv_ilmb_1_READSTROBE : STD_LOGIC;
  signal mbv_riscv_ilmb_1_READY : STD_LOGIC;
  signal mbv_riscv_ilmb_1_UE : STD_LOGIC;
  signal mbv_riscv_ilmb_1_WAIT : STD_LOGIC;
  signal mbv_riscv_intc_axi_ARADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_riscv_intc_axi_ARREADY : STD_LOGIC;
  signal mbv_riscv_intc_axi_ARVALID : STD_LOGIC;
  signal mbv_riscv_intc_axi_AWADDR : STD_LOGIC_VECTOR ( 8 downto 0 );
  signal mbv_riscv_intc_axi_AWREADY : STD_LOGIC;
  signal mbv_riscv_intc_axi_AWVALID : STD_LOGIC;
  signal mbv_riscv_intc_axi_BREADY : STD_LOGIC;
  signal mbv_riscv_intc_axi_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_intc_axi_BVALID : STD_LOGIC;
  signal mbv_riscv_intc_axi_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_intc_axi_RREADY : STD_LOGIC;
  signal mbv_riscv_intc_axi_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal mbv_riscv_intc_axi_RVALID : STD_LOGIC;
  signal mbv_riscv_intc_axi_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_intc_axi_WREADY : STD_LOGIC;
  signal mbv_riscv_intc_axi_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal mbv_riscv_intc_axi_WVALID : STD_LOGIC;
  signal mbv_riscv_interrupt_ACK : STD_LOGIC_VECTOR ( 0 to 1 );
  signal mbv_riscv_interrupt_ADDRESS : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal mbv_riscv_interrupt_INTERRUPT : STD_LOGIC;
  signal mbv_riscv_intr : STD_LOGIC_VECTOR ( 10 downto 0 );
  signal mdm_1_debug_sys_rst : STD_LOGIC;
  signal \^qspi_flash_ss_o\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal reset_inv_0_Res : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_clk_wiz_1_100M_bus_struct_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_clk_wiz_1_100M_mb_reset : STD_LOGIC;
  signal rst_clk_wiz_1_100M_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^spi_ss_o\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_mbv_axi_iic_gpo_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_mbv_axi_smartconnect_M00_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M00_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M01_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M01_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M02_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M02_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M03_AXI_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mbv_axi_smartconnect_M03_AXI_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mbv_axi_smartconnect_M04_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M04_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M05_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M05_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M06_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M06_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M07_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M07_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M08_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M08_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M09_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M09_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M10_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M10_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M11_AXI_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mbv_axi_smartconnect_M11_AXI_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_mbv_axi_smartconnect_M12_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M12_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M13_AXI_arprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_smartconnect_M13_AXI_awprot_UNCONNECTED : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_mbv_axi_timebase_watchdog_timer_wdt_reset_pending_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_axi_timebase_watchdog_timer_wdt_state_vec_UNCONNECTED : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_mbv_microblaze_debug_module_v_TRACE_CLK_OUT_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_microblaze_debug_module_v_TRACE_CTL_UNCONNECTED : STD_LOGIC;
  signal NLW_mbv_microblaze_debug_module_v_TRACE_DATA_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal NLW_mbv_microblaze_v_Dbg_Trig_Ack_Out_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 7 );
  signal NLW_mbv_processor_system_reset_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute BMM_INFO_PROCESSOR : string;
  attribute BMM_INFO_PROCESSOR of mbv_microblaze_v : label is "riscv > mbv_system mbv_local_memory/mbv_data_lmb_bram_controller";
  attribute KEEP_HIERARCHY : string;
  attribute KEEP_HIERARCHY of mbv_microblaze_v : label is "YES";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of eth_mdio_mdc_mdc : signal is "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDC";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of eth_mdio_mdc_mdc : signal is "Master";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of eth_mdio_mdc_mdc : signal is "XIL_INTERFACENAME eth_mdio_mdc, CAN_DEBUG false";
  attribute X_INTERFACE_INFO of eth_mdio_mdc_mdio_i : signal is "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_I";
  attribute X_INTERFACE_INFO of eth_mdio_mdc_mdio_o : signal is "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_O";
  attribute X_INTERFACE_INFO of eth_mdio_mdc_mdio_t : signal is "xilinx.com:interface:mdio:1.0 eth_mdio_mdc MDIO_T";
  attribute X_INTERFACE_INFO of eth_mii_col : signal is "xilinx.com:interface:mii:1.0 eth_mii COL";
  attribute X_INTERFACE_MODE of eth_mii_col : signal is "Master";
  attribute X_INTERFACE_INFO of eth_mii_crs : signal is "xilinx.com:interface:mii:1.0 eth_mii CRS";
  attribute X_INTERFACE_INFO of eth_mii_rst_n : signal is "xilinx.com:interface:mii:1.0 eth_mii RST_N";
  attribute X_INTERFACE_INFO of eth_mii_rx_clk : signal is "xilinx.com:interface:mii:1.0 eth_mii RX_CLK";
  attribute X_INTERFACE_INFO of eth_mii_rx_dv : signal is "xilinx.com:interface:mii:1.0 eth_mii RX_DV";
  attribute X_INTERFACE_INFO of eth_mii_rx_er : signal is "xilinx.com:interface:mii:1.0 eth_mii RX_ER";
  attribute X_INTERFACE_INFO of eth_mii_tx_clk : signal is "xilinx.com:interface:mii:1.0 eth_mii TX_CLK";
  attribute X_INTERFACE_INFO of eth_mii_tx_en : signal is "xilinx.com:interface:mii:1.0 eth_mii TX_EN";
  attribute X_INTERFACE_INFO of i2c_scl_i : signal is "xilinx.com:interface:iic:1.0 i2c SCL_I";
  attribute X_INTERFACE_MODE of i2c_scl_i : signal is "Master";
  attribute X_INTERFACE_INFO of i2c_scl_o : signal is "xilinx.com:interface:iic:1.0 i2c SCL_O";
  attribute X_INTERFACE_INFO of i2c_scl_t : signal is "xilinx.com:interface:iic:1.0 i2c SCL_T";
  attribute X_INTERFACE_INFO of i2c_sda_i : signal is "xilinx.com:interface:iic:1.0 i2c SDA_I";
  attribute X_INTERFACE_INFO of i2c_sda_o : signal is "xilinx.com:interface:iic:1.0 i2c SDA_O";
  attribute X_INTERFACE_INFO of i2c_sda_t : signal is "xilinx.com:interface:iic:1.0 i2c SDA_T";
  attribute X_INTERFACE_INFO of qspi_flash_io0_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO0_I";
  attribute X_INTERFACE_MODE of qspi_flash_io0_i : signal is "Master";
  attribute X_INTERFACE_INFO of qspi_flash_io0_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO0_O";
  attribute X_INTERFACE_INFO of qspi_flash_io0_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO0_T";
  attribute X_INTERFACE_INFO of qspi_flash_io1_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO1_I";
  attribute X_INTERFACE_INFO of qspi_flash_io1_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO1_O";
  attribute X_INTERFACE_INFO of qspi_flash_io1_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO1_T";
  attribute X_INTERFACE_INFO of qspi_flash_io2_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO2_I";
  attribute X_INTERFACE_INFO of qspi_flash_io2_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO2_O";
  attribute X_INTERFACE_INFO of qspi_flash_io2_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO2_T";
  attribute X_INTERFACE_INFO of qspi_flash_io3_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO3_I";
  attribute X_INTERFACE_INFO of qspi_flash_io3_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO3_O";
  attribute X_INTERFACE_INFO of qspi_flash_io3_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash IO3_T";
  attribute X_INTERFACE_INFO of qspi_flash_sck_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash SCK_I";
  attribute X_INTERFACE_INFO of qspi_flash_sck_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash SCK_O";
  attribute X_INTERFACE_INFO of qspi_flash_sck_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash SCK_T";
  attribute X_INTERFACE_INFO of qspi_flash_ss_i : signal is "xilinx.com:interface:spi:1.0 qspi_flash SS_I";
  attribute X_INTERFACE_INFO of qspi_flash_ss_o : signal is "xilinx.com:interface:spi:1.0 qspi_flash SS_O";
  attribute X_INTERFACE_INFO of qspi_flash_ss_t : signal is "xilinx.com:interface:spi:1.0 qspi_flash SS_T";
  attribute X_INTERFACE_INFO of reset : signal is "xilinx.com:signal:reset:1.0 RST.RESET RST";
  attribute X_INTERFACE_PARAMETER of reset : signal is "XIL_INTERFACENAME RST.RESET, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of spi_io0_i : signal is "xilinx.com:interface:spi:1.0 spi IO0_I";
  attribute X_INTERFACE_MODE of spi_io0_i : signal is "Master";
  attribute X_INTERFACE_INFO of spi_io0_o : signal is "xilinx.com:interface:spi:1.0 spi IO0_O";
  attribute X_INTERFACE_INFO of spi_io0_t : signal is "xilinx.com:interface:spi:1.0 spi IO0_T";
  attribute X_INTERFACE_INFO of spi_io1_i : signal is "xilinx.com:interface:spi:1.0 spi IO1_I";
  attribute X_INTERFACE_INFO of spi_io1_o : signal is "xilinx.com:interface:spi:1.0 spi IO1_O";
  attribute X_INTERFACE_INFO of spi_io1_t : signal is "xilinx.com:interface:spi:1.0 spi IO1_T";
  attribute X_INTERFACE_INFO of spi_sck_i : signal is "xilinx.com:interface:spi:1.0 spi SCK_I";
  attribute X_INTERFACE_INFO of spi_sck_o : signal is "xilinx.com:interface:spi:1.0 spi SCK_O";
  attribute X_INTERFACE_INFO of spi_sck_t : signal is "xilinx.com:interface:spi:1.0 spi SCK_T";
  attribute X_INTERFACE_INFO of spi_ss_i : signal is "xilinx.com:interface:spi:1.0 spi SS_I";
  attribute X_INTERFACE_INFO of spi_ss_o : signal is "xilinx.com:interface:spi:1.0 spi SS_O";
  attribute X_INTERFACE_INFO of spi_ss_t : signal is "xilinx.com:interface:spi:1.0 spi SS_T";
  attribute X_INTERFACE_INFO of sys_clock : signal is "xilinx.com:signal:clock:1.0 CLK.SYS_CLOCK CLK";
  attribute X_INTERFACE_PARAMETER of sys_clock : signal is "XIL_INTERFACENAME CLK.SYS_CLOCK, CLK_DOMAIN mbv_system_sys_clock, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of usb_uart_rxd : signal is "xilinx.com:interface:uart:1.0 usb_uart RxD";
  attribute X_INTERFACE_MODE of usb_uart_rxd : signal is "Master";
  attribute X_INTERFACE_INFO of usb_uart_txd : signal is "xilinx.com:interface:uart:1.0 usb_uart TxD";
  attribute X_INTERFACE_INFO of dip_switches_4bits_tri_i : signal is "xilinx.com:interface:gpio:1.0 dip_switches_4bits TRI_I";
  attribute X_INTERFACE_MODE of dip_switches_4bits_tri_i : signal is "Master";
  attribute X_INTERFACE_INFO of eth_mii_rxd : signal is "xilinx.com:interface:mii:1.0 eth_mii RXD";
  attribute X_INTERFACE_INFO of eth_mii_txd : signal is "xilinx.com:interface:mii:1.0 eth_mii TXD";
  attribute X_INTERFACE_INFO of i2c_pullups_tri_o : signal is "xilinx.com:interface:gpio:1.0 i2c_pullups TRI_O";
  attribute X_INTERFACE_MODE of i2c_pullups_tri_o : signal is "Master";
  attribute X_INTERFACE_INFO of led_4bits_tri_o : signal is "xilinx.com:interface:gpio:1.0 led_4bits TRI_O";
  attribute X_INTERFACE_MODE of led_4bits_tri_o : signal is "Master";
  attribute X_INTERFACE_INFO of push_buttons_4bits_tri_i : signal is "xilinx.com:interface:gpio:1.0 push_buttons_4bits TRI_I";
  attribute X_INTERFACE_MODE of push_buttons_4bits_tri_i : signal is "Master";
  attribute X_INTERFACE_INFO of rgb_led_tri_o : signal is "xilinx.com:interface:gpio:1.0 rgb_led TRI_O";
  attribute X_INTERFACE_MODE of rgb_led_tri_o : signal is "Master";
  attribute X_INTERFACE_INFO of shield_dp0_dp19_tri_i : signal is "xilinx.com:interface:gpio:1.0 shield_dp0_dp19 TRI_I";
  attribute X_INTERFACE_MODE of shield_dp0_dp19_tri_i : signal is "Master";
  attribute X_INTERFACE_INFO of shield_dp0_dp19_tri_o : signal is "xilinx.com:interface:gpio:1.0 shield_dp0_dp19 TRI_O";
  attribute X_INTERFACE_INFO of shield_dp0_dp19_tri_t : signal is "xilinx.com:interface:gpio:1.0 shield_dp0_dp19 TRI_T";
  attribute X_INTERFACE_INFO of shield_dp26_dp41_tri_i : signal is "xilinx.com:interface:gpio:1.0 shield_dp26_dp41 TRI_I";
  attribute X_INTERFACE_MODE of shield_dp26_dp41_tri_i : signal is "Master";
  attribute X_INTERFACE_INFO of shield_dp26_dp41_tri_o : signal is "xilinx.com:interface:gpio:1.0 shield_dp26_dp41 TRI_O";
  attribute X_INTERFACE_INFO of shield_dp26_dp41_tri_t : signal is "xilinx.com:interface:gpio:1.0 shield_dp26_dp41 TRI_T";
begin
  qspi_flash_ss_o <= \^qspi_flash_ss_o\(0);
  spi_ss_o <= \^spi_ss_o\(0);
mbv_axi_ethernetlite: component mbv_system_axi_ethernetlite_0_0
     port map (
      ip2intc_irpt => axi_ethernetlite_0_ip2intc_irpt,
      phy_col => eth_mii_col,
      phy_crs => eth_mii_crs,
      phy_dv => eth_mii_rx_dv,
      phy_mdc => eth_mdio_mdc_mdc,
      phy_mdio_i => eth_mdio_mdc_mdio_i,
      phy_mdio_o => eth_mdio_mdc_mdio_o,
      phy_mdio_t => eth_mdio_mdc_mdio_t,
      phy_rst_n => eth_mii_rst_n,
      phy_rx_clk => eth_mii_rx_clk,
      phy_rx_data(3 downto 0) => eth_mii_rxd(3 downto 0),
      phy_rx_er => eth_mii_rx_er,
      phy_tx_clk => eth_mii_tx_clk,
      phy_tx_data(3 downto 0) => eth_mii_txd(3 downto 0),
      phy_tx_en => eth_mii_tx_en,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(12 downto 0) => mbv_axi_smartconnect_M10_AXI_ARADDR(12 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M10_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M10_AXI_ARVALID,
      s_axi_awaddr(12 downto 0) => mbv_axi_smartconnect_M10_AXI_AWADDR(12 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M10_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M10_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M10_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M10_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M10_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M10_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M10_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M10_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M10_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M10_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M10_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M10_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M10_AXI_WVALID
    );
mbv_axi_gpio_dip_switches: component mbv_system_axi_gpio_0_3
     port map (
      gpio_io_i(3 downto 0) => dip_switches_4bits_tri_i(3 downto 0),
      ip2intc_irpt => mbv_axi_gpio_dip_switches_ip2intc_irpt,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M07_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M07_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M07_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M07_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M07_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M07_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M07_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M07_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M07_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M07_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M07_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M07_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M07_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M07_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M07_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M07_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M07_AXI_WVALID
    );
mbv_axi_gpio_iic_pullups: component mbv_system_axi_gpio_0_6
     port map (
      gpio_io_o(1 downto 0) => i2c_pullups_tri_o(1 downto 0),
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M13_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M13_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M13_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M13_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M13_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M13_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M13_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M13_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M13_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M13_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M13_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M13_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M13_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M13_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M13_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M13_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M13_AXI_WVALID
    );
mbv_axi_gpio_led_4_bits: component mbv_system_axi_gpio_0_4
     port map (
      gpio_io_o(3 downto 0) => led_4bits_tri_o(3 downto 0),
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M08_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M08_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M08_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M08_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M08_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M08_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M08_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M08_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M08_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M08_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M08_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M08_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M08_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M08_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M08_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M08_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M08_AXI_WVALID
    );
mbv_axi_gpio_led_rgb: component mbv_system_axi_gpio_0_5
     port map (
      gpio_io_o(11 downto 0) => rgb_led_tri_o(11 downto 0),
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M09_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M09_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M09_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M09_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M09_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M09_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M09_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M09_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M09_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M09_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M09_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M09_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M09_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M09_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M09_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M09_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M09_AXI_WVALID
    );
mbv_axi_gpio_push_buttons: component mbv_system_axi_gpio_0_2
     port map (
      gpio_io_i(3 downto 0) => push_buttons_4bits_tri_i(3 downto 0),
      ip2intc_irpt => axi_gpio_0_ip2intc_irpt,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M06_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M06_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M06_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M06_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M06_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M06_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M06_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M06_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M06_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M06_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M06_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M06_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M06_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M06_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M06_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M06_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M06_AXI_WVALID
    );
mbv_axi_gpio_shield_pins_0_19: component mbv_system_axi_gpio_0_0
     port map (
      gpio_io_i(19 downto 0) => shield_dp0_dp19_tri_i(19 downto 0),
      gpio_io_o(19 downto 0) => shield_dp0_dp19_tri_o(19 downto 0),
      gpio_io_t(19 downto 0) => shield_dp0_dp19_tri_t(19 downto 0),
      ip2intc_irpt => mbv_axi_gpio_shield_pins_0_19_ip2intc_irpt,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M04_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M04_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M04_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M04_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M04_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M04_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M04_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M04_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M04_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M04_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M04_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M04_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M04_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M04_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M04_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M04_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M04_AXI_WVALID
    );
mbv_axi_gpio_shield_pins_26_41: component mbv_system_axi_gpio_0_1
     port map (
      gpio_io_i(15 downto 0) => shield_dp26_dp41_tri_i(15 downto 0),
      gpio_io_o(15 downto 0) => shield_dp26_dp41_tri_o(15 downto 0),
      gpio_io_t(15 downto 0) => shield_dp26_dp41_tri_t(15 downto 0),
      ip2intc_irpt => mbv_axi_gpio_shield_pins_26_41_ip2intc_irpt,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M05_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M05_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M05_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M05_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M05_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M05_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M05_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M05_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M05_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M05_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M05_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M05_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M05_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M05_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M05_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M05_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M05_AXI_WVALID
    );
mbv_axi_iic: component mbv_system_axi_iic_0_0
     port map (
      gpo(0) => NLW_mbv_axi_iic_gpo_UNCONNECTED(0),
      iic2intc_irpt => axi_iic_0_iic2intc_irpt,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_axi_smartconnect_M12_AXI_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M12_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M12_AXI_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_axi_smartconnect_M12_AXI_AWADDR(8 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M12_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M12_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M12_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M12_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M12_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M12_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M12_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M12_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M12_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M12_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M12_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M12_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M12_AXI_WVALID,
      scl_i => i2c_scl_i,
      scl_o => i2c_scl_o,
      scl_t => i2c_scl_t,
      sda_i => i2c_sda_i,
      sda_o => i2c_sda_o,
      sda_t => i2c_sda_t
    );
mbv_axi_interrupt_controller: component mbv_system_mbv_riscv_axi_intc_1
     port map (
      interrupt_address(31 downto 0) => mbv_riscv_interrupt_ADDRESS(31 downto 0),
      intr(10 downto 0) => mbv_riscv_intr(10 downto 0),
      irq => mbv_riscv_interrupt_INTERRUPT,
      processor_ack(1) => mbv_riscv_interrupt_ACK(0),
      processor_ack(0) => mbv_riscv_interrupt_ACK(1),
      processor_clk => mbv_riscv_Clk,
      processor_rst => rst_clk_wiz_1_100M_mb_reset,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(8 downto 0) => mbv_riscv_intc_axi_ARADDR(8 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_riscv_intc_axi_ARREADY,
      s_axi_arvalid => mbv_riscv_intc_axi_ARVALID,
      s_axi_awaddr(8 downto 0) => mbv_riscv_intc_axi_AWADDR(8 downto 0),
      s_axi_awready => mbv_riscv_intc_axi_AWREADY,
      s_axi_awvalid => mbv_riscv_intc_axi_AWVALID,
      s_axi_bready => mbv_riscv_intc_axi_BREADY,
      s_axi_bresp(1 downto 0) => mbv_riscv_intc_axi_BRESP(1 downto 0),
      s_axi_bvalid => mbv_riscv_intc_axi_BVALID,
      s_axi_rdata(31 downto 0) => mbv_riscv_intc_axi_RDATA(31 downto 0),
      s_axi_rready => mbv_riscv_intc_axi_RREADY,
      s_axi_rresp(1 downto 0) => mbv_riscv_intc_axi_RRESP(1 downto 0),
      s_axi_rvalid => mbv_riscv_intc_axi_RVALID,
      s_axi_wdata(31 downto 0) => mbv_riscv_intc_axi_WDATA(31 downto 0),
      s_axi_wready => mbv_riscv_intc_axi_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_riscv_intc_axi_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_riscv_intc_axi_WVALID
    );
mbv_axi_quad_spi: component mbv_system_axi_quad_spi_0_1
     port map (
      ext_spi_clk => mbv_riscv_Clk,
      io0_i => spi_io0_i,
      io0_o => spi_io0_o,
      io0_t => spi_io0_t,
      io1_i => spi_io1_i,
      io1_o => spi_io1_o,
      io1_t => spi_io1_t,
      ip2intc_irpt => axi_quad_spi_0_ip2intc_irpt,
      s_axi4_aclk => mbv_riscv_Clk,
      s_axi4_araddr(23 downto 0) => mbv_axi_smartconnect_M11_AXI_ARADDR(23 downto 0),
      s_axi4_arburst(1 downto 0) => mbv_axi_smartconnect_M11_AXI_ARBURST(1 downto 0),
      s_axi4_arcache(3 downto 0) => mbv_axi_smartconnect_M11_AXI_ARCACHE(3 downto 0),
      s_axi4_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi4_arlen(7 downto 0) => mbv_axi_smartconnect_M11_AXI_ARLEN(7 downto 0),
      s_axi4_arlock => mbv_axi_smartconnect_M11_AXI_ARLOCK(0),
      s_axi4_arprot(2 downto 0) => mbv_axi_smartconnect_M11_AXI_ARPROT(2 downto 0),
      s_axi4_arready => mbv_axi_smartconnect_M11_AXI_ARREADY,
      s_axi4_arsize(2 downto 0) => mbv_axi_smartconnect_M11_AXI_ARSIZE(2 downto 0),
      s_axi4_arvalid => mbv_axi_smartconnect_M11_AXI_ARVALID,
      s_axi4_awaddr(23 downto 0) => mbv_axi_smartconnect_M11_AXI_AWADDR(23 downto 0),
      s_axi4_awburst(1 downto 0) => mbv_axi_smartconnect_M11_AXI_AWBURST(1 downto 0),
      s_axi4_awcache(3 downto 0) => mbv_axi_smartconnect_M11_AXI_AWCACHE(3 downto 0),
      s_axi4_awlen(7 downto 0) => mbv_axi_smartconnect_M11_AXI_AWLEN(7 downto 0),
      s_axi4_awlock => mbv_axi_smartconnect_M11_AXI_AWLOCK(0),
      s_axi4_awprot(2 downto 0) => mbv_axi_smartconnect_M11_AXI_AWPROT(2 downto 0),
      s_axi4_awready => mbv_axi_smartconnect_M11_AXI_AWREADY,
      s_axi4_awsize(2 downto 0) => mbv_axi_smartconnect_M11_AXI_AWSIZE(2 downto 0),
      s_axi4_awvalid => mbv_axi_smartconnect_M11_AXI_AWVALID,
      s_axi4_bready => mbv_axi_smartconnect_M11_AXI_BREADY,
      s_axi4_bresp(1 downto 0) => mbv_axi_smartconnect_M11_AXI_BRESP(1 downto 0),
      s_axi4_bvalid => mbv_axi_smartconnect_M11_AXI_BVALID,
      s_axi4_rdata(31 downto 0) => mbv_axi_smartconnect_M11_AXI_RDATA(31 downto 0),
      s_axi4_rlast => mbv_axi_smartconnect_M11_AXI_RLAST,
      s_axi4_rready => mbv_axi_smartconnect_M11_AXI_RREADY,
      s_axi4_rresp(1 downto 0) => mbv_axi_smartconnect_M11_AXI_RRESP(1 downto 0),
      s_axi4_rvalid => mbv_axi_smartconnect_M11_AXI_RVALID,
      s_axi4_wdata(31 downto 0) => mbv_axi_smartconnect_M11_AXI_WDATA(31 downto 0),
      s_axi4_wlast => mbv_axi_smartconnect_M11_AXI_WLAST,
      s_axi4_wready => mbv_axi_smartconnect_M11_AXI_WREADY,
      s_axi4_wstrb(3 downto 0) => mbv_axi_smartconnect_M11_AXI_WSTRB(3 downto 0),
      s_axi4_wvalid => mbv_axi_smartconnect_M11_AXI_WVALID,
      sck_i => spi_sck_i,
      sck_o => spi_sck_o,
      sck_t => spi_sck_t,
      ss_i(0) => spi_ss_i,
      ss_o(0) => \^spi_ss_o\(0),
      ss_t => spi_ss_t
    );
mbv_axi_quad_spi_flash: component mbv_system_axi_quad_spi_0_0
     port map (
      ext_spi_clk => mbv_riscv_Clk,
      io0_i => qspi_flash_io0_i,
      io0_o => qspi_flash_io0_o,
      io0_t => qspi_flash_io0_t,
      io1_i => qspi_flash_io1_i,
      io1_o => qspi_flash_io1_o,
      io1_t => qspi_flash_io1_t,
      io2_i => qspi_flash_io2_i,
      io2_o => qspi_flash_io2_o,
      io2_t => qspi_flash_io2_t,
      io3_i => qspi_flash_io3_i,
      io3_o => qspi_flash_io3_o,
      io3_t => qspi_flash_io3_t,
      ip2intc_irpt => mbv_axi_quad_spi_ip2intc_irpt,
      s_axi4_aclk => mbv_riscv_Clk,
      s_axi4_araddr(23 downto 0) => mbv_axi_smartconnect_M03_AXI_ARADDR(23 downto 0),
      s_axi4_arburst(1 downto 0) => mbv_axi_smartconnect_M03_AXI_ARBURST(1 downto 0),
      s_axi4_arcache(3 downto 0) => mbv_axi_smartconnect_M03_AXI_ARCACHE(3 downto 0),
      s_axi4_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi4_arlen(7 downto 0) => mbv_axi_smartconnect_M03_AXI_ARLEN(7 downto 0),
      s_axi4_arlock => mbv_axi_smartconnect_M03_AXI_ARLOCK(0),
      s_axi4_arprot(2 downto 0) => mbv_axi_smartconnect_M03_AXI_ARPROT(2 downto 0),
      s_axi4_arready => mbv_axi_smartconnect_M03_AXI_ARREADY,
      s_axi4_arsize(2 downto 0) => mbv_axi_smartconnect_M03_AXI_ARSIZE(2 downto 0),
      s_axi4_arvalid => mbv_axi_smartconnect_M03_AXI_ARVALID,
      s_axi4_awaddr(23 downto 0) => mbv_axi_smartconnect_M03_AXI_AWADDR(23 downto 0),
      s_axi4_awburst(1 downto 0) => mbv_axi_smartconnect_M03_AXI_AWBURST(1 downto 0),
      s_axi4_awcache(3 downto 0) => mbv_axi_smartconnect_M03_AXI_AWCACHE(3 downto 0),
      s_axi4_awlen(7 downto 0) => mbv_axi_smartconnect_M03_AXI_AWLEN(7 downto 0),
      s_axi4_awlock => mbv_axi_smartconnect_M03_AXI_AWLOCK(0),
      s_axi4_awprot(2 downto 0) => mbv_axi_smartconnect_M03_AXI_AWPROT(2 downto 0),
      s_axi4_awready => mbv_axi_smartconnect_M03_AXI_AWREADY,
      s_axi4_awsize(2 downto 0) => mbv_axi_smartconnect_M03_AXI_AWSIZE(2 downto 0),
      s_axi4_awvalid => mbv_axi_smartconnect_M03_AXI_AWVALID,
      s_axi4_bready => mbv_axi_smartconnect_M03_AXI_BREADY,
      s_axi4_bresp(1 downto 0) => mbv_axi_smartconnect_M03_AXI_BRESP(1 downto 0),
      s_axi4_bvalid => mbv_axi_smartconnect_M03_AXI_BVALID,
      s_axi4_rdata(31 downto 0) => mbv_axi_smartconnect_M03_AXI_RDATA(31 downto 0),
      s_axi4_rlast => mbv_axi_smartconnect_M03_AXI_RLAST,
      s_axi4_rready => mbv_axi_smartconnect_M03_AXI_RREADY,
      s_axi4_rresp(1 downto 0) => mbv_axi_smartconnect_M03_AXI_RRESP(1 downto 0),
      s_axi4_rvalid => mbv_axi_smartconnect_M03_AXI_RVALID,
      s_axi4_wdata(31 downto 0) => mbv_axi_smartconnect_M03_AXI_WDATA(31 downto 0),
      s_axi4_wlast => mbv_axi_smartconnect_M03_AXI_WLAST,
      s_axi4_wready => mbv_axi_smartconnect_M03_AXI_WREADY,
      s_axi4_wstrb(3 downto 0) => mbv_axi_smartconnect_M03_AXI_WSTRB(3 downto 0),
      s_axi4_wvalid => mbv_axi_smartconnect_M03_AXI_WVALID,
      sck_i => qspi_flash_sck_i,
      sck_o => qspi_flash_sck_o,
      sck_t => qspi_flash_sck_t,
      ss_i(0) => qspi_flash_ss_i,
      ss_o(0) => \^qspi_flash_ss_o\(0),
      ss_t => qspi_flash_ss_t
    );
mbv_axi_smartconnect: component mbv_system_mbv_riscv_axi_periph_1
     port map (
      M00_AXI_araddr(8 downto 0) => mbv_riscv_intc_axi_ARADDR(8 downto 0),
      M00_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M00_AXI_arprot_UNCONNECTED(2 downto 0),
      M00_AXI_arready => mbv_riscv_intc_axi_ARREADY,
      M00_AXI_arvalid => mbv_riscv_intc_axi_ARVALID,
      M00_AXI_awaddr(8 downto 0) => mbv_riscv_intc_axi_AWADDR(8 downto 0),
      M00_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M00_AXI_awprot_UNCONNECTED(2 downto 0),
      M00_AXI_awready => mbv_riscv_intc_axi_AWREADY,
      M00_AXI_awvalid => mbv_riscv_intc_axi_AWVALID,
      M00_AXI_bready => mbv_riscv_intc_axi_BREADY,
      M00_AXI_bresp(1 downto 0) => mbv_riscv_intc_axi_BRESP(1 downto 0),
      M00_AXI_bvalid => mbv_riscv_intc_axi_BVALID,
      M00_AXI_rdata(31 downto 0) => mbv_riscv_intc_axi_RDATA(31 downto 0),
      M00_AXI_rready => mbv_riscv_intc_axi_RREADY,
      M00_AXI_rresp(1 downto 0) => mbv_riscv_intc_axi_RRESP(1 downto 0),
      M00_AXI_rvalid => mbv_riscv_intc_axi_RVALID,
      M00_AXI_wdata(31 downto 0) => mbv_riscv_intc_axi_WDATA(31 downto 0),
      M00_AXI_wready => mbv_riscv_intc_axi_WREADY,
      M00_AXI_wstrb(3 downto 0) => mbv_riscv_intc_axi_WSTRB(3 downto 0),
      M00_AXI_wvalid => mbv_riscv_intc_axi_WVALID,
      M01_AXI_araddr(5 downto 0) => mbv_axi_smartconnect_M01_AXI_ARADDR(5 downto 0),
      M01_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M01_AXI_arprot_UNCONNECTED(2 downto 0),
      M01_AXI_arready => mbv_axi_smartconnect_M01_AXI_ARREADY,
      M01_AXI_arvalid => mbv_axi_smartconnect_M01_AXI_ARVALID,
      M01_AXI_awaddr(5 downto 0) => mbv_axi_smartconnect_M01_AXI_AWADDR(5 downto 0),
      M01_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M01_AXI_awprot_UNCONNECTED(2 downto 0),
      M01_AXI_awready => mbv_axi_smartconnect_M01_AXI_AWREADY,
      M01_AXI_awvalid => mbv_axi_smartconnect_M01_AXI_AWVALID,
      M01_AXI_bready => mbv_axi_smartconnect_M01_AXI_BREADY,
      M01_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M01_AXI_BRESP(1 downto 0),
      M01_AXI_bvalid => mbv_axi_smartconnect_M01_AXI_BVALID,
      M01_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M01_AXI_RDATA(31 downto 0),
      M01_AXI_rready => mbv_axi_smartconnect_M01_AXI_RREADY,
      M01_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M01_AXI_RRESP(1 downto 0),
      M01_AXI_rvalid => mbv_axi_smartconnect_M01_AXI_RVALID,
      M01_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M01_AXI_WDATA(31 downto 0),
      M01_AXI_wready => mbv_axi_smartconnect_M01_AXI_WREADY,
      M01_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M01_AXI_WSTRB(3 downto 0),
      M01_AXI_wvalid => mbv_axi_smartconnect_M01_AXI_WVALID,
      M02_AXI_araddr(3 downto 0) => mbv_axi_smartconnect_M02_AXI_ARADDR(3 downto 0),
      M02_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M02_AXI_arprot_UNCONNECTED(2 downto 0),
      M02_AXI_arready => mbv_axi_smartconnect_M02_AXI_ARREADY,
      M02_AXI_arvalid => mbv_axi_smartconnect_M02_AXI_ARVALID,
      M02_AXI_awaddr(3 downto 0) => mbv_axi_smartconnect_M02_AXI_AWADDR(3 downto 0),
      M02_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M02_AXI_awprot_UNCONNECTED(2 downto 0),
      M02_AXI_awready => mbv_axi_smartconnect_M02_AXI_AWREADY,
      M02_AXI_awvalid => mbv_axi_smartconnect_M02_AXI_AWVALID,
      M02_AXI_bready => mbv_axi_smartconnect_M02_AXI_BREADY,
      M02_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M02_AXI_BRESP(1 downto 0),
      M02_AXI_bvalid => mbv_axi_smartconnect_M02_AXI_BVALID,
      M02_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M02_AXI_RDATA(31 downto 0),
      M02_AXI_rready => mbv_axi_smartconnect_M02_AXI_RREADY,
      M02_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M02_AXI_RRESP(1 downto 0),
      M02_AXI_rvalid => mbv_axi_smartconnect_M02_AXI_RVALID,
      M02_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M02_AXI_WDATA(31 downto 0),
      M02_AXI_wready => mbv_axi_smartconnect_M02_AXI_WREADY,
      M02_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M02_AXI_WSTRB(3 downto 0),
      M02_AXI_wvalid => mbv_axi_smartconnect_M02_AXI_WVALID,
      M03_AXI_araddr(23 downto 0) => mbv_axi_smartconnect_M03_AXI_ARADDR(23 downto 0),
      M03_AXI_arburst(1 downto 0) => mbv_axi_smartconnect_M03_AXI_ARBURST(1 downto 0),
      M03_AXI_arcache(3 downto 0) => mbv_axi_smartconnect_M03_AXI_ARCACHE(3 downto 0),
      M03_AXI_arlen(7 downto 0) => mbv_axi_smartconnect_M03_AXI_ARLEN(7 downto 0),
      M03_AXI_arlock(0) => mbv_axi_smartconnect_M03_AXI_ARLOCK(0),
      M03_AXI_arprot(2 downto 0) => mbv_axi_smartconnect_M03_AXI_ARPROT(2 downto 0),
      M03_AXI_arqos(3 downto 0) => NLW_mbv_axi_smartconnect_M03_AXI_arqos_UNCONNECTED(3 downto 0),
      M03_AXI_arready => mbv_axi_smartconnect_M03_AXI_ARREADY,
      M03_AXI_arsize(2 downto 0) => mbv_axi_smartconnect_M03_AXI_ARSIZE(2 downto 0),
      M03_AXI_arvalid => mbv_axi_smartconnect_M03_AXI_ARVALID,
      M03_AXI_awaddr(23 downto 0) => mbv_axi_smartconnect_M03_AXI_AWADDR(23 downto 0),
      M03_AXI_awburst(1 downto 0) => mbv_axi_smartconnect_M03_AXI_AWBURST(1 downto 0),
      M03_AXI_awcache(3 downto 0) => mbv_axi_smartconnect_M03_AXI_AWCACHE(3 downto 0),
      M03_AXI_awlen(7 downto 0) => mbv_axi_smartconnect_M03_AXI_AWLEN(7 downto 0),
      M03_AXI_awlock(0) => mbv_axi_smartconnect_M03_AXI_AWLOCK(0),
      M03_AXI_awprot(2 downto 0) => mbv_axi_smartconnect_M03_AXI_AWPROT(2 downto 0),
      M03_AXI_awqos(3 downto 0) => NLW_mbv_axi_smartconnect_M03_AXI_awqos_UNCONNECTED(3 downto 0),
      M03_AXI_awready => mbv_axi_smartconnect_M03_AXI_AWREADY,
      M03_AXI_awsize(2 downto 0) => mbv_axi_smartconnect_M03_AXI_AWSIZE(2 downto 0),
      M03_AXI_awvalid => mbv_axi_smartconnect_M03_AXI_AWVALID,
      M03_AXI_bready => mbv_axi_smartconnect_M03_AXI_BREADY,
      M03_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M03_AXI_BRESP(1 downto 0),
      M03_AXI_bvalid => mbv_axi_smartconnect_M03_AXI_BVALID,
      M03_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M03_AXI_RDATA(31 downto 0),
      M03_AXI_rlast => mbv_axi_smartconnect_M03_AXI_RLAST,
      M03_AXI_rready => mbv_axi_smartconnect_M03_AXI_RREADY,
      M03_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M03_AXI_RRESP(1 downto 0),
      M03_AXI_rvalid => mbv_axi_smartconnect_M03_AXI_RVALID,
      M03_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M03_AXI_WDATA(31 downto 0),
      M03_AXI_wlast => mbv_axi_smartconnect_M03_AXI_WLAST,
      M03_AXI_wready => mbv_axi_smartconnect_M03_AXI_WREADY,
      M03_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M03_AXI_WSTRB(3 downto 0),
      M03_AXI_wvalid => mbv_axi_smartconnect_M03_AXI_WVALID,
      M04_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M04_AXI_ARADDR(8 downto 0),
      M04_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M04_AXI_arprot_UNCONNECTED(2 downto 0),
      M04_AXI_arready => mbv_axi_smartconnect_M04_AXI_ARREADY,
      M04_AXI_arvalid => mbv_axi_smartconnect_M04_AXI_ARVALID,
      M04_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M04_AXI_AWADDR(8 downto 0),
      M04_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M04_AXI_awprot_UNCONNECTED(2 downto 0),
      M04_AXI_awready => mbv_axi_smartconnect_M04_AXI_AWREADY,
      M04_AXI_awvalid => mbv_axi_smartconnect_M04_AXI_AWVALID,
      M04_AXI_bready => mbv_axi_smartconnect_M04_AXI_BREADY,
      M04_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M04_AXI_BRESP(1 downto 0),
      M04_AXI_bvalid => mbv_axi_smartconnect_M04_AXI_BVALID,
      M04_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M04_AXI_RDATA(31 downto 0),
      M04_AXI_rready => mbv_axi_smartconnect_M04_AXI_RREADY,
      M04_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M04_AXI_RRESP(1 downto 0),
      M04_AXI_rvalid => mbv_axi_smartconnect_M04_AXI_RVALID,
      M04_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M04_AXI_WDATA(31 downto 0),
      M04_AXI_wready => mbv_axi_smartconnect_M04_AXI_WREADY,
      M04_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M04_AXI_WSTRB(3 downto 0),
      M04_AXI_wvalid => mbv_axi_smartconnect_M04_AXI_WVALID,
      M05_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M05_AXI_ARADDR(8 downto 0),
      M05_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M05_AXI_arprot_UNCONNECTED(2 downto 0),
      M05_AXI_arready => mbv_axi_smartconnect_M05_AXI_ARREADY,
      M05_AXI_arvalid => mbv_axi_smartconnect_M05_AXI_ARVALID,
      M05_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M05_AXI_AWADDR(8 downto 0),
      M05_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M05_AXI_awprot_UNCONNECTED(2 downto 0),
      M05_AXI_awready => mbv_axi_smartconnect_M05_AXI_AWREADY,
      M05_AXI_awvalid => mbv_axi_smartconnect_M05_AXI_AWVALID,
      M05_AXI_bready => mbv_axi_smartconnect_M05_AXI_BREADY,
      M05_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M05_AXI_BRESP(1 downto 0),
      M05_AXI_bvalid => mbv_axi_smartconnect_M05_AXI_BVALID,
      M05_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M05_AXI_RDATA(31 downto 0),
      M05_AXI_rready => mbv_axi_smartconnect_M05_AXI_RREADY,
      M05_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M05_AXI_RRESP(1 downto 0),
      M05_AXI_rvalid => mbv_axi_smartconnect_M05_AXI_RVALID,
      M05_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M05_AXI_WDATA(31 downto 0),
      M05_AXI_wready => mbv_axi_smartconnect_M05_AXI_WREADY,
      M05_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M05_AXI_WSTRB(3 downto 0),
      M05_AXI_wvalid => mbv_axi_smartconnect_M05_AXI_WVALID,
      M06_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M06_AXI_ARADDR(8 downto 0),
      M06_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M06_AXI_arprot_UNCONNECTED(2 downto 0),
      M06_AXI_arready => mbv_axi_smartconnect_M06_AXI_ARREADY,
      M06_AXI_arvalid => mbv_axi_smartconnect_M06_AXI_ARVALID,
      M06_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M06_AXI_AWADDR(8 downto 0),
      M06_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M06_AXI_awprot_UNCONNECTED(2 downto 0),
      M06_AXI_awready => mbv_axi_smartconnect_M06_AXI_AWREADY,
      M06_AXI_awvalid => mbv_axi_smartconnect_M06_AXI_AWVALID,
      M06_AXI_bready => mbv_axi_smartconnect_M06_AXI_BREADY,
      M06_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M06_AXI_BRESP(1 downto 0),
      M06_AXI_bvalid => mbv_axi_smartconnect_M06_AXI_BVALID,
      M06_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M06_AXI_RDATA(31 downto 0),
      M06_AXI_rready => mbv_axi_smartconnect_M06_AXI_RREADY,
      M06_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M06_AXI_RRESP(1 downto 0),
      M06_AXI_rvalid => mbv_axi_smartconnect_M06_AXI_RVALID,
      M06_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M06_AXI_WDATA(31 downto 0),
      M06_AXI_wready => mbv_axi_smartconnect_M06_AXI_WREADY,
      M06_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M06_AXI_WSTRB(3 downto 0),
      M06_AXI_wvalid => mbv_axi_smartconnect_M06_AXI_WVALID,
      M07_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M07_AXI_ARADDR(8 downto 0),
      M07_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M07_AXI_arprot_UNCONNECTED(2 downto 0),
      M07_AXI_arready => mbv_axi_smartconnect_M07_AXI_ARREADY,
      M07_AXI_arvalid => mbv_axi_smartconnect_M07_AXI_ARVALID,
      M07_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M07_AXI_AWADDR(8 downto 0),
      M07_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M07_AXI_awprot_UNCONNECTED(2 downto 0),
      M07_AXI_awready => mbv_axi_smartconnect_M07_AXI_AWREADY,
      M07_AXI_awvalid => mbv_axi_smartconnect_M07_AXI_AWVALID,
      M07_AXI_bready => mbv_axi_smartconnect_M07_AXI_BREADY,
      M07_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M07_AXI_BRESP(1 downto 0),
      M07_AXI_bvalid => mbv_axi_smartconnect_M07_AXI_BVALID,
      M07_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M07_AXI_RDATA(31 downto 0),
      M07_AXI_rready => mbv_axi_smartconnect_M07_AXI_RREADY,
      M07_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M07_AXI_RRESP(1 downto 0),
      M07_AXI_rvalid => mbv_axi_smartconnect_M07_AXI_RVALID,
      M07_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M07_AXI_WDATA(31 downto 0),
      M07_AXI_wready => mbv_axi_smartconnect_M07_AXI_WREADY,
      M07_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M07_AXI_WSTRB(3 downto 0),
      M07_AXI_wvalid => mbv_axi_smartconnect_M07_AXI_WVALID,
      M08_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M08_AXI_ARADDR(8 downto 0),
      M08_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M08_AXI_arprot_UNCONNECTED(2 downto 0),
      M08_AXI_arready => mbv_axi_smartconnect_M08_AXI_ARREADY,
      M08_AXI_arvalid => mbv_axi_smartconnect_M08_AXI_ARVALID,
      M08_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M08_AXI_AWADDR(8 downto 0),
      M08_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M08_AXI_awprot_UNCONNECTED(2 downto 0),
      M08_AXI_awready => mbv_axi_smartconnect_M08_AXI_AWREADY,
      M08_AXI_awvalid => mbv_axi_smartconnect_M08_AXI_AWVALID,
      M08_AXI_bready => mbv_axi_smartconnect_M08_AXI_BREADY,
      M08_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M08_AXI_BRESP(1 downto 0),
      M08_AXI_bvalid => mbv_axi_smartconnect_M08_AXI_BVALID,
      M08_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M08_AXI_RDATA(31 downto 0),
      M08_AXI_rready => mbv_axi_smartconnect_M08_AXI_RREADY,
      M08_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M08_AXI_RRESP(1 downto 0),
      M08_AXI_rvalid => mbv_axi_smartconnect_M08_AXI_RVALID,
      M08_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M08_AXI_WDATA(31 downto 0),
      M08_AXI_wready => mbv_axi_smartconnect_M08_AXI_WREADY,
      M08_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M08_AXI_WSTRB(3 downto 0),
      M08_AXI_wvalid => mbv_axi_smartconnect_M08_AXI_WVALID,
      M09_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M09_AXI_ARADDR(8 downto 0),
      M09_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M09_AXI_arprot_UNCONNECTED(2 downto 0),
      M09_AXI_arready => mbv_axi_smartconnect_M09_AXI_ARREADY,
      M09_AXI_arvalid => mbv_axi_smartconnect_M09_AXI_ARVALID,
      M09_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M09_AXI_AWADDR(8 downto 0),
      M09_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M09_AXI_awprot_UNCONNECTED(2 downto 0),
      M09_AXI_awready => mbv_axi_smartconnect_M09_AXI_AWREADY,
      M09_AXI_awvalid => mbv_axi_smartconnect_M09_AXI_AWVALID,
      M09_AXI_bready => mbv_axi_smartconnect_M09_AXI_BREADY,
      M09_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M09_AXI_BRESP(1 downto 0),
      M09_AXI_bvalid => mbv_axi_smartconnect_M09_AXI_BVALID,
      M09_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M09_AXI_RDATA(31 downto 0),
      M09_AXI_rready => mbv_axi_smartconnect_M09_AXI_RREADY,
      M09_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M09_AXI_RRESP(1 downto 0),
      M09_AXI_rvalid => mbv_axi_smartconnect_M09_AXI_RVALID,
      M09_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M09_AXI_WDATA(31 downto 0),
      M09_AXI_wready => mbv_axi_smartconnect_M09_AXI_WREADY,
      M09_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M09_AXI_WSTRB(3 downto 0),
      M09_AXI_wvalid => mbv_axi_smartconnect_M09_AXI_WVALID,
      M10_AXI_araddr(12 downto 0) => mbv_axi_smartconnect_M10_AXI_ARADDR(12 downto 0),
      M10_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M10_AXI_arprot_UNCONNECTED(2 downto 0),
      M10_AXI_arready => mbv_axi_smartconnect_M10_AXI_ARREADY,
      M10_AXI_arvalid => mbv_axi_smartconnect_M10_AXI_ARVALID,
      M10_AXI_awaddr(12 downto 0) => mbv_axi_smartconnect_M10_AXI_AWADDR(12 downto 0),
      M10_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M10_AXI_awprot_UNCONNECTED(2 downto 0),
      M10_AXI_awready => mbv_axi_smartconnect_M10_AXI_AWREADY,
      M10_AXI_awvalid => mbv_axi_smartconnect_M10_AXI_AWVALID,
      M10_AXI_bready => mbv_axi_smartconnect_M10_AXI_BREADY,
      M10_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M10_AXI_BRESP(1 downto 0),
      M10_AXI_bvalid => mbv_axi_smartconnect_M10_AXI_BVALID,
      M10_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M10_AXI_RDATA(31 downto 0),
      M10_AXI_rready => mbv_axi_smartconnect_M10_AXI_RREADY,
      M10_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M10_AXI_RRESP(1 downto 0),
      M10_AXI_rvalid => mbv_axi_smartconnect_M10_AXI_RVALID,
      M10_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M10_AXI_WDATA(31 downto 0),
      M10_AXI_wready => mbv_axi_smartconnect_M10_AXI_WREADY,
      M10_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M10_AXI_WSTRB(3 downto 0),
      M10_AXI_wvalid => mbv_axi_smartconnect_M10_AXI_WVALID,
      M11_AXI_araddr(23 downto 0) => mbv_axi_smartconnect_M11_AXI_ARADDR(23 downto 0),
      M11_AXI_arburst(1 downto 0) => mbv_axi_smartconnect_M11_AXI_ARBURST(1 downto 0),
      M11_AXI_arcache(3 downto 0) => mbv_axi_smartconnect_M11_AXI_ARCACHE(3 downto 0),
      M11_AXI_arlen(7 downto 0) => mbv_axi_smartconnect_M11_AXI_ARLEN(7 downto 0),
      M11_AXI_arlock(0) => mbv_axi_smartconnect_M11_AXI_ARLOCK(0),
      M11_AXI_arprot(2 downto 0) => mbv_axi_smartconnect_M11_AXI_ARPROT(2 downto 0),
      M11_AXI_arqos(3 downto 0) => NLW_mbv_axi_smartconnect_M11_AXI_arqos_UNCONNECTED(3 downto 0),
      M11_AXI_arready => mbv_axi_smartconnect_M11_AXI_ARREADY,
      M11_AXI_arsize(2 downto 0) => mbv_axi_smartconnect_M11_AXI_ARSIZE(2 downto 0),
      M11_AXI_arvalid => mbv_axi_smartconnect_M11_AXI_ARVALID,
      M11_AXI_awaddr(23 downto 0) => mbv_axi_smartconnect_M11_AXI_AWADDR(23 downto 0),
      M11_AXI_awburst(1 downto 0) => mbv_axi_smartconnect_M11_AXI_AWBURST(1 downto 0),
      M11_AXI_awcache(3 downto 0) => mbv_axi_smartconnect_M11_AXI_AWCACHE(3 downto 0),
      M11_AXI_awlen(7 downto 0) => mbv_axi_smartconnect_M11_AXI_AWLEN(7 downto 0),
      M11_AXI_awlock(0) => mbv_axi_smartconnect_M11_AXI_AWLOCK(0),
      M11_AXI_awprot(2 downto 0) => mbv_axi_smartconnect_M11_AXI_AWPROT(2 downto 0),
      M11_AXI_awqos(3 downto 0) => NLW_mbv_axi_smartconnect_M11_AXI_awqos_UNCONNECTED(3 downto 0),
      M11_AXI_awready => mbv_axi_smartconnect_M11_AXI_AWREADY,
      M11_AXI_awsize(2 downto 0) => mbv_axi_smartconnect_M11_AXI_AWSIZE(2 downto 0),
      M11_AXI_awvalid => mbv_axi_smartconnect_M11_AXI_AWVALID,
      M11_AXI_bready => mbv_axi_smartconnect_M11_AXI_BREADY,
      M11_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M11_AXI_BRESP(1 downto 0),
      M11_AXI_bvalid => mbv_axi_smartconnect_M11_AXI_BVALID,
      M11_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M11_AXI_RDATA(31 downto 0),
      M11_AXI_rlast => mbv_axi_smartconnect_M11_AXI_RLAST,
      M11_AXI_rready => mbv_axi_smartconnect_M11_AXI_RREADY,
      M11_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M11_AXI_RRESP(1 downto 0),
      M11_AXI_rvalid => mbv_axi_smartconnect_M11_AXI_RVALID,
      M11_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M11_AXI_WDATA(31 downto 0),
      M11_AXI_wlast => mbv_axi_smartconnect_M11_AXI_WLAST,
      M11_AXI_wready => mbv_axi_smartconnect_M11_AXI_WREADY,
      M11_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M11_AXI_WSTRB(3 downto 0),
      M11_AXI_wvalid => mbv_axi_smartconnect_M11_AXI_WVALID,
      M12_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M12_AXI_ARADDR(8 downto 0),
      M12_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M12_AXI_arprot_UNCONNECTED(2 downto 0),
      M12_AXI_arready => mbv_axi_smartconnect_M12_AXI_ARREADY,
      M12_AXI_arvalid => mbv_axi_smartconnect_M12_AXI_ARVALID,
      M12_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M12_AXI_AWADDR(8 downto 0),
      M12_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M12_AXI_awprot_UNCONNECTED(2 downto 0),
      M12_AXI_awready => mbv_axi_smartconnect_M12_AXI_AWREADY,
      M12_AXI_awvalid => mbv_axi_smartconnect_M12_AXI_AWVALID,
      M12_AXI_bready => mbv_axi_smartconnect_M12_AXI_BREADY,
      M12_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M12_AXI_BRESP(1 downto 0),
      M12_AXI_bvalid => mbv_axi_smartconnect_M12_AXI_BVALID,
      M12_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M12_AXI_RDATA(31 downto 0),
      M12_AXI_rready => mbv_axi_smartconnect_M12_AXI_RREADY,
      M12_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M12_AXI_RRESP(1 downto 0),
      M12_AXI_rvalid => mbv_axi_smartconnect_M12_AXI_RVALID,
      M12_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M12_AXI_WDATA(31 downto 0),
      M12_AXI_wready => mbv_axi_smartconnect_M12_AXI_WREADY,
      M12_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M12_AXI_WSTRB(3 downto 0),
      M12_AXI_wvalid => mbv_axi_smartconnect_M12_AXI_WVALID,
      M13_AXI_araddr(8 downto 0) => mbv_axi_smartconnect_M13_AXI_ARADDR(8 downto 0),
      M13_AXI_arprot(2 downto 0) => NLW_mbv_axi_smartconnect_M13_AXI_arprot_UNCONNECTED(2 downto 0),
      M13_AXI_arready => mbv_axi_smartconnect_M13_AXI_ARREADY,
      M13_AXI_arvalid => mbv_axi_smartconnect_M13_AXI_ARVALID,
      M13_AXI_awaddr(8 downto 0) => mbv_axi_smartconnect_M13_AXI_AWADDR(8 downto 0),
      M13_AXI_awprot(2 downto 0) => NLW_mbv_axi_smartconnect_M13_AXI_awprot_UNCONNECTED(2 downto 0),
      M13_AXI_awready => mbv_axi_smartconnect_M13_AXI_AWREADY,
      M13_AXI_awvalid => mbv_axi_smartconnect_M13_AXI_AWVALID,
      M13_AXI_bready => mbv_axi_smartconnect_M13_AXI_BREADY,
      M13_AXI_bresp(1 downto 0) => mbv_axi_smartconnect_M13_AXI_BRESP(1 downto 0),
      M13_AXI_bvalid => mbv_axi_smartconnect_M13_AXI_BVALID,
      M13_AXI_rdata(31 downto 0) => mbv_axi_smartconnect_M13_AXI_RDATA(31 downto 0),
      M13_AXI_rready => mbv_axi_smartconnect_M13_AXI_RREADY,
      M13_AXI_rresp(1 downto 0) => mbv_axi_smartconnect_M13_AXI_RRESP(1 downto 0),
      M13_AXI_rvalid => mbv_axi_smartconnect_M13_AXI_RVALID,
      M13_AXI_wdata(31 downto 0) => mbv_axi_smartconnect_M13_AXI_WDATA(31 downto 0),
      M13_AXI_wready => mbv_axi_smartconnect_M13_AXI_WREADY,
      M13_AXI_wstrb(3 downto 0) => mbv_axi_smartconnect_M13_AXI_WSTRB(3 downto 0),
      M13_AXI_wvalid => mbv_axi_smartconnect_M13_AXI_WVALID,
      S00_AXI_araddr(33 downto 0) => mbv_riscv_axi_dp_ARADDR(33 downto 0),
      S00_AXI_arprot(2 downto 0) => mbv_riscv_axi_dp_ARPROT(2 downto 0),
      S00_AXI_arready => mbv_riscv_axi_dp_ARREADY,
      S00_AXI_arvalid => mbv_riscv_axi_dp_ARVALID,
      S00_AXI_awaddr(33 downto 0) => mbv_riscv_axi_dp_AWADDR(33 downto 0),
      S00_AXI_awprot(2 downto 0) => mbv_riscv_axi_dp_AWPROT(2 downto 0),
      S00_AXI_awready => mbv_riscv_axi_dp_AWREADY,
      S00_AXI_awvalid => mbv_riscv_axi_dp_AWVALID,
      S00_AXI_bready => mbv_riscv_axi_dp_BREADY,
      S00_AXI_bresp(1 downto 0) => mbv_riscv_axi_dp_BRESP(1 downto 0),
      S00_AXI_bvalid => mbv_riscv_axi_dp_BVALID,
      S00_AXI_rdata(31 downto 0) => mbv_riscv_axi_dp_RDATA(31 downto 0),
      S00_AXI_rready => mbv_riscv_axi_dp_RREADY,
      S00_AXI_rresp(1 downto 0) => mbv_riscv_axi_dp_RRESP(1 downto 0),
      S00_AXI_rvalid => mbv_riscv_axi_dp_RVALID,
      S00_AXI_wdata(31 downto 0) => mbv_riscv_axi_dp_WDATA(31 downto 0),
      S00_AXI_wready => mbv_riscv_axi_dp_WREADY,
      S00_AXI_wstrb(3 downto 0) => mbv_riscv_axi_dp_WSTRB(3 downto 0),
      S00_AXI_wvalid => mbv_riscv_axi_dp_WVALID,
      aclk => mbv_riscv_Clk,
      aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0)
    );
mbv_axi_timebase_watchdog_timer: component mbv_system_axi_timebase_wdt_0_0
     port map (
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(5 downto 0) => mbv_axi_smartconnect_M01_AXI_ARADDR(5 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M01_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M01_AXI_ARVALID,
      s_axi_awaddr(5 downto 0) => mbv_axi_smartconnect_M01_AXI_AWADDR(5 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M01_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M01_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M01_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M01_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M01_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M01_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M01_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M01_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M01_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M01_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M01_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M01_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M01_AXI_WVALID,
      wdt_interrupt => axi_timebase_watchdog_timer_wdt_interrupt,
      wdt_reset => axi_timebase_watchdog_timer_wdt_reset,
      wdt_reset_pending => NLW_mbv_axi_timebase_watchdog_timer_wdt_reset_pending_UNCONNECTED,
      wdt_state_vec(6 downto 0) => NLW_mbv_axi_timebase_watchdog_timer_wdt_state_vec_UNCONNECTED(6 downto 0)
    );
mbv_axi_uartlite: component mbv_system_axi_uartlite_0_0
     port map (
      interrupt => mbv_axi_uartlite_interrupt,
      rx => usb_uart_rxd,
      s_axi_aclk => mbv_riscv_Clk,
      s_axi_araddr(3 downto 0) => mbv_axi_smartconnect_M02_AXI_ARADDR(3 downto 0),
      s_axi_aresetn => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      s_axi_arready => mbv_axi_smartconnect_M02_AXI_ARREADY,
      s_axi_arvalid => mbv_axi_smartconnect_M02_AXI_ARVALID,
      s_axi_awaddr(3 downto 0) => mbv_axi_smartconnect_M02_AXI_AWADDR(3 downto 0),
      s_axi_awready => mbv_axi_smartconnect_M02_AXI_AWREADY,
      s_axi_awvalid => mbv_axi_smartconnect_M02_AXI_AWVALID,
      s_axi_bready => mbv_axi_smartconnect_M02_AXI_BREADY,
      s_axi_bresp(1 downto 0) => mbv_axi_smartconnect_M02_AXI_BRESP(1 downto 0),
      s_axi_bvalid => mbv_axi_smartconnect_M02_AXI_BVALID,
      s_axi_rdata(31 downto 0) => mbv_axi_smartconnect_M02_AXI_RDATA(31 downto 0),
      s_axi_rready => mbv_axi_smartconnect_M02_AXI_RREADY,
      s_axi_rresp(1 downto 0) => mbv_axi_smartconnect_M02_AXI_RRESP(1 downto 0),
      s_axi_rvalid => mbv_axi_smartconnect_M02_AXI_RVALID,
      s_axi_wdata(31 downto 0) => mbv_axi_smartconnect_M02_AXI_WDATA(31 downto 0),
      s_axi_wready => mbv_axi_smartconnect_M02_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => mbv_axi_smartconnect_M02_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => mbv_axi_smartconnect_M02_AXI_WVALID,
      tx => usb_uart_txd
    );
mbv_clocking_wizard: component mbv_system_clk_wiz_1_1
     port map (
      clk_in1 => sys_clock,
      clk_out1 => mbv_riscv_Clk,
      locked => clk_wiz_1_locked,
      reset => reset_inv_0_Res(0)
    );
mbv_fixed_interval_timer_1_millisecond: component mbv_system_fit_timer_0_0
     port map (
      Clk => mbv_riscv_Clk,
      Interrupt => mbv_fixed_interval_timer_Interrupt,
      Rst => mbv_processor_system_reset_peripheral_reset(0)
    );
  mbv_riscv_intr <= (0 to 0 => axi_iic_0_iic2intc_irpt) & (0 to 0 => axi_quad_spi_0_ip2intc_irpt) & (0 to 0 => axi_ethernetlite_0_ip2intc_irpt) & (0 to 0 => mbv_axi_gpio_dip_switches_ip2intc_irpt) & (0 to 0 => axi_gpio_0_ip2intc_irpt) & (0 to 0 => mbv_axi_gpio_shield_pins_26_41_ip2intc_irpt) & (0 to 0 => mbv_axi_gpio_shield_pins_0_19_ip2intc_irpt) & (0 to 0 => mbv_axi_quad_spi_ip2intc_irpt) & (0 to 0 => mbv_axi_uartlite_interrupt) & (0 to 0 => axi_timebase_watchdog_timer_wdt_interrupt) & (0 to 0 => mbv_fixed_interval_timer_Interrupt);
  reset_inv_0_Res <= not (0 to 0 => reset);
mbv_local_memory: entity work.mbv_local_memory_imp_1NP638B
     port map (
      DLMB_abus(0 to 33) => mbv_riscv_dlmb_1_ABUS(0 to 33),
      DLMB_addrstrobe => mbv_riscv_dlmb_1_ADDRSTROBE,
      DLMB_be(0 to 3) => mbv_riscv_dlmb_1_BE(0 to 3),
      DLMB_ce => mbv_riscv_dlmb_1_CE,
      DLMB_readdbus(0 to 31) => mbv_riscv_dlmb_1_READDBUS(0 to 31),
      DLMB_readstrobe => mbv_riscv_dlmb_1_READSTROBE,
      DLMB_ready => mbv_riscv_dlmb_1_READY,
      DLMB_ue => mbv_riscv_dlmb_1_UE,
      DLMB_wait => mbv_riscv_dlmb_1_WAIT,
      DLMB_writedbus(0 to 31) => mbv_riscv_dlmb_1_WRITEDBUS(0 to 31),
      DLMB_writestrobe => mbv_riscv_dlmb_1_WRITESTROBE,
      ILMB_abus(0 to 33) => mbv_riscv_ilmb_1_ABUS(0 to 33),
      ILMB_addrstrobe => mbv_riscv_ilmb_1_ADDRSTROBE,
      ILMB_ce => mbv_riscv_ilmb_1_CE,
      ILMB_readdbus(0 to 31) => mbv_riscv_ilmb_1_READDBUS(0 to 31),
      ILMB_readstrobe => mbv_riscv_ilmb_1_READSTROBE,
      ILMB_ready => mbv_riscv_ilmb_1_READY,
      ILMB_ue => mbv_riscv_ilmb_1_UE,
      ILMB_wait => mbv_riscv_ilmb_1_WAIT,
      LMB_Clk => mbv_riscv_Clk,
      SYS_Rst => rst_clk_wiz_1_100M_bus_struct_reset(0)
    );
mbv_microblaze_debug_module_v: component mbv_system_mdm_1_1
     port map (
      Dbg_ARADDR_0(14 downto 2) => mbv_riscv_debug_ARADDR(14 downto 2),
      Dbg_ARREADY_0 => mbv_riscv_debug_ARREADY,
      Dbg_ARVALID_0 => mbv_riscv_debug_ARVALID,
      Dbg_AWADDR_0(14 downto 2) => mbv_riscv_debug_AWADDR(14 downto 2),
      Dbg_AWREADY_0 => mbv_riscv_debug_AWREADY,
      Dbg_AWVALID_0 => mbv_riscv_debug_AWVALID,
      Dbg_BREADY_0 => mbv_riscv_debug_BREADY,
      Dbg_BRESP_0(1 downto 0) => mbv_riscv_debug_BRESP(1 downto 0),
      Dbg_BVALID_0 => mbv_riscv_debug_BVALID,
      Dbg_Capture_0 => mbv_riscv_debug_CAPTURE,
      Dbg_Clk_0 => mbv_riscv_debug_CLK,
      Dbg_Disable_0 => mbv_riscv_debug_DISABLE,
      Dbg_RDATA_0(31 downto 0) => mbv_riscv_debug_RDATA(31 downto 0),
      Dbg_RREADY_0 => mbv_riscv_debug_RREADY,
      Dbg_RRESP_0(1 downto 0) => mbv_riscv_debug_RRESP(1 downto 0),
      Dbg_RVALID_0 => mbv_riscv_debug_RVALID,
      Dbg_Reg_En_0(0 to 7) => mbv_riscv_debug_REG_EN(0 to 7),
      Dbg_Rst_0 => mbv_riscv_debug_RST,
      Dbg_Shift_0 => mbv_riscv_debug_SHIFT,
      Dbg_TDI_0 => mbv_riscv_debug_TDI,
      Dbg_TDO_0 => mbv_riscv_debug_TDO,
      Dbg_TrClk_0 => mbv_riscv_debug_TRCLK,
      Dbg_TrData_0(0 to 35) => mbv_riscv_debug_TRDATA(0 to 35),
      Dbg_TrReady_0 => mbv_riscv_debug_TRREADY,
      Dbg_TrValid_0 => mbv_riscv_debug_TRVALID,
      Dbg_Trig_In_0(0 to 7) => mbv_riscv_debug_TRIG_IN(0 to 7),
      Dbg_Update_0 => mbv_riscv_debug_UPDATE,
      Dbg_WDATA_0(31 downto 0) => mbv_riscv_debug_WDATA(31 downto 0),
      Dbg_WREADY_0 => mbv_riscv_debug_WREADY,
      Dbg_WVALID_0 => mbv_riscv_debug_WVALID,
      Debug_SYS_Rst => mdm_1_debug_sys_rst,
      M_AXI_ACLK => mbv_riscv_Clk,
      M_AXI_ARESETN => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      TRACE_CLK => '0',
      TRACE_CLK_OUT => NLW_mbv_microblaze_debug_module_v_TRACE_CLK_OUT_UNCONNECTED,
      TRACE_CTL => NLW_mbv_microblaze_debug_module_v_TRACE_CTL_UNCONNECTED,
      TRACE_DATA(15 downto 0) => NLW_mbv_microblaze_debug_module_v_TRACE_DATA_UNCONNECTED(15 downto 0)
    );
mbv_microblaze_v: component mbv_system_microblaze_riscv_0_0
     port map (
      Byte_Enable(0 to 3) => mbv_riscv_dlmb_1_BE(0 to 3),
      Clk => mbv_riscv_Clk,
      DCE => mbv_riscv_dlmb_1_CE,
      DReady => mbv_riscv_dlmb_1_READY,
      DUE => mbv_riscv_dlmb_1_UE,
      DWait => mbv_riscv_dlmb_1_WAIT,
      D_AS => mbv_riscv_dlmb_1_ADDRSTROBE,
      Data_Addr(0 to 33) => mbv_riscv_dlmb_1_ABUS(0 to 33),
      Data_Read(0 to 31) => mbv_riscv_dlmb_1_READDBUS(0 to 31),
      Data_Write(0 to 31) => mbv_riscv_dlmb_1_WRITEDBUS(0 to 31),
      Dbg_ARADDR(14 downto 2) => mbv_riscv_debug_ARADDR(14 downto 2),
      Dbg_ARREADY => mbv_riscv_debug_ARREADY,
      Dbg_ARVALID => mbv_riscv_debug_ARVALID,
      Dbg_AWADDR(14 downto 2) => mbv_riscv_debug_AWADDR(14 downto 2),
      Dbg_AWREADY => mbv_riscv_debug_AWREADY,
      Dbg_AWVALID => mbv_riscv_debug_AWVALID,
      Dbg_BREADY => mbv_riscv_debug_BREADY,
      Dbg_BRESP(1 downto 0) => mbv_riscv_debug_BRESP(1 downto 0),
      Dbg_BVALID => mbv_riscv_debug_BVALID,
      Dbg_Capture => mbv_riscv_debug_CAPTURE,
      Dbg_Clk => mbv_riscv_debug_CLK,
      Dbg_Disable => mbv_riscv_debug_DISABLE,
      Dbg_RDATA(31 downto 0) => mbv_riscv_debug_RDATA(31 downto 0),
      Dbg_RREADY => mbv_riscv_debug_RREADY,
      Dbg_RRESP(1 downto 0) => mbv_riscv_debug_RRESP(1 downto 0),
      Dbg_RVALID => mbv_riscv_debug_RVALID,
      Dbg_Reg_En(0 to 7) => mbv_riscv_debug_REG_EN(0 to 7),
      Dbg_Shift => mbv_riscv_debug_SHIFT,
      Dbg_TDI => mbv_riscv_debug_TDI,
      Dbg_TDO => mbv_riscv_debug_TDO,
      Dbg_Trace_Clk => mbv_riscv_debug_TRCLK,
      Dbg_Trace_Data(0 to 35) => mbv_riscv_debug_TRDATA(0 to 35),
      Dbg_Trace_Ready => mbv_riscv_debug_TRREADY,
      Dbg_Trace_Valid => mbv_riscv_debug_TRVALID,
      Dbg_Trig_Ack_In(0 to 7) => B"00000000",
      Dbg_Trig_Ack_Out(0 to 7) => NLW_mbv_microblaze_v_Dbg_Trig_Ack_Out_UNCONNECTED(0 to 7),
      Dbg_Trig_In(0 to 7) => mbv_riscv_debug_TRIG_IN(0 to 7),
      Dbg_Trig_Out(0 to 7) => B"00000000",
      Dbg_Update => mbv_riscv_debug_UPDATE,
      Dbg_WDATA(31 downto 0) => mbv_riscv_debug_WDATA(31 downto 0),
      Dbg_WREADY => mbv_riscv_debug_WREADY,
      Dbg_WVALID => mbv_riscv_debug_WVALID,
      Debug_Rst => mbv_riscv_debug_RST,
      ICE => mbv_riscv_ilmb_1_CE,
      IFetch => mbv_riscv_ilmb_1_READSTROBE,
      IReady => mbv_riscv_ilmb_1_READY,
      IUE => mbv_riscv_ilmb_1_UE,
      IWAIT => mbv_riscv_ilmb_1_WAIT,
      I_AS => mbv_riscv_ilmb_1_ADDRSTROBE,
      Instr(0 to 31) => mbv_riscv_ilmb_1_READDBUS(0 to 31),
      Instr_Addr(0 to 33) => mbv_riscv_ilmb_1_ABUS(0 to 33),
      Interrupt => mbv_riscv_interrupt_INTERRUPT,
      Interrupt_Ack(0 to 1) => mbv_riscv_interrupt_ACK(0 to 1),
      Interrupt_Address(0) => mbv_riscv_interrupt_ADDRESS(31),
      Interrupt_Address(1) => mbv_riscv_interrupt_ADDRESS(30),
      Interrupt_Address(2) => mbv_riscv_interrupt_ADDRESS(29),
      Interrupt_Address(3) => mbv_riscv_interrupt_ADDRESS(28),
      Interrupt_Address(4) => mbv_riscv_interrupt_ADDRESS(27),
      Interrupt_Address(5) => mbv_riscv_interrupt_ADDRESS(26),
      Interrupt_Address(6) => mbv_riscv_interrupt_ADDRESS(25),
      Interrupt_Address(7) => mbv_riscv_interrupt_ADDRESS(24),
      Interrupt_Address(8) => mbv_riscv_interrupt_ADDRESS(23),
      Interrupt_Address(9) => mbv_riscv_interrupt_ADDRESS(22),
      Interrupt_Address(10) => mbv_riscv_interrupt_ADDRESS(21),
      Interrupt_Address(11) => mbv_riscv_interrupt_ADDRESS(20),
      Interrupt_Address(12) => mbv_riscv_interrupt_ADDRESS(19),
      Interrupt_Address(13) => mbv_riscv_interrupt_ADDRESS(18),
      Interrupt_Address(14) => mbv_riscv_interrupt_ADDRESS(17),
      Interrupt_Address(15) => mbv_riscv_interrupt_ADDRESS(16),
      Interrupt_Address(16) => mbv_riscv_interrupt_ADDRESS(15),
      Interrupt_Address(17) => mbv_riscv_interrupt_ADDRESS(14),
      Interrupt_Address(18) => mbv_riscv_interrupt_ADDRESS(13),
      Interrupt_Address(19) => mbv_riscv_interrupt_ADDRESS(12),
      Interrupt_Address(20) => mbv_riscv_interrupt_ADDRESS(11),
      Interrupt_Address(21) => mbv_riscv_interrupt_ADDRESS(10),
      Interrupt_Address(22) => mbv_riscv_interrupt_ADDRESS(9),
      Interrupt_Address(23) => mbv_riscv_interrupt_ADDRESS(8),
      Interrupt_Address(24) => mbv_riscv_interrupt_ADDRESS(7),
      Interrupt_Address(25) => mbv_riscv_interrupt_ADDRESS(6),
      Interrupt_Address(26) => mbv_riscv_interrupt_ADDRESS(5),
      Interrupt_Address(27) => mbv_riscv_interrupt_ADDRESS(4),
      Interrupt_Address(28) => mbv_riscv_interrupt_ADDRESS(3),
      Interrupt_Address(29) => mbv_riscv_interrupt_ADDRESS(2),
      Interrupt_Address(30) => mbv_riscv_interrupt_ADDRESS(1),
      Interrupt_Address(31) => mbv_riscv_interrupt_ADDRESS(0),
      M_AXI_DP_ARADDR(33 downto 0) => mbv_riscv_axi_dp_ARADDR(33 downto 0),
      M_AXI_DP_ARPROT(2 downto 0) => mbv_riscv_axi_dp_ARPROT(2 downto 0),
      M_AXI_DP_ARREADY => mbv_riscv_axi_dp_ARREADY,
      M_AXI_DP_ARVALID => mbv_riscv_axi_dp_ARVALID,
      M_AXI_DP_AWADDR(33 downto 0) => mbv_riscv_axi_dp_AWADDR(33 downto 0),
      M_AXI_DP_AWPROT(2 downto 0) => mbv_riscv_axi_dp_AWPROT(2 downto 0),
      M_AXI_DP_AWREADY => mbv_riscv_axi_dp_AWREADY,
      M_AXI_DP_AWVALID => mbv_riscv_axi_dp_AWVALID,
      M_AXI_DP_BREADY => mbv_riscv_axi_dp_BREADY,
      M_AXI_DP_BRESP(1 downto 0) => mbv_riscv_axi_dp_BRESP(1 downto 0),
      M_AXI_DP_BVALID => mbv_riscv_axi_dp_BVALID,
      M_AXI_DP_RDATA(31 downto 0) => mbv_riscv_axi_dp_RDATA(31 downto 0),
      M_AXI_DP_RREADY => mbv_riscv_axi_dp_RREADY,
      M_AXI_DP_RRESP(1 downto 0) => mbv_riscv_axi_dp_RRESP(1 downto 0),
      M_AXI_DP_RVALID => mbv_riscv_axi_dp_RVALID,
      M_AXI_DP_WDATA(31 downto 0) => mbv_riscv_axi_dp_WDATA(31 downto 0),
      M_AXI_DP_WREADY => mbv_riscv_axi_dp_WREADY,
      M_AXI_DP_WSTRB(3 downto 0) => mbv_riscv_axi_dp_WSTRB(3 downto 0),
      M_AXI_DP_WVALID => mbv_riscv_axi_dp_WVALID,
      Read_Strobe => mbv_riscv_dlmb_1_READSTROBE,
      Reset => rst_clk_wiz_1_100M_mb_reset,
      Write_Strobe => mbv_riscv_dlmb_1_WRITESTROBE
    );
mbv_processor_system_reset: component mbv_system_rst_clk_wiz_1_100M_1
     port map (
      aux_reset_in => axi_timebase_watchdog_timer_wdt_reset,
      bus_struct_reset(0) => rst_clk_wiz_1_100M_bus_struct_reset(0),
      dcm_locked => clk_wiz_1_locked,
      ext_reset_in => reset,
      interconnect_aresetn(0) => NLW_mbv_processor_system_reset_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => mdm_1_debug_sys_rst,
      mb_reset => rst_clk_wiz_1_100M_mb_reset,
      peripheral_aresetn(0) => rst_clk_wiz_1_100M_peripheral_aresetn(0),
      peripheral_reset(0) => mbv_processor_system_reset_peripheral_reset(0),
      slowest_sync_clk => mbv_riscv_Clk
    );
end STRUCTURE;
