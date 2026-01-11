-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Tue Dec 23 07:28:33 2025
-- Host        : STUDIOPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               x:/hw/rv32imafcb_zicsr_zifencei_zbc/rv32imafcb_zicsr_zifencei_zbc.gen/sources_1/bd/mbv_system/ip/mbv_system_axi_timebase_wdt_0_0/mbv_system_axi_timebase_wdt_0_0_sim_netlist.vhdl
-- Design      : mbv_system_axi_timebase_wdt_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1\ is
  port (
    ce_expnd_i_10 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\(2),
      I2 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\(1),
      O => ce_expnd_i_10
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10\ is
  port (
    ce_expnd_i_1 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\(2),
      I1 => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\(3),
      I2 => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\(1),
      O => ce_expnd_i_1
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11\ is
  port (
    ce_expnd_i_0 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\(1),
      I1 => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\(0),
      I2 => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\(3),
      I3 => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\(2),
      O => ce_expnd_i_0
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3\ is
  port (
    ce_expnd_i_8 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\(1),
      I2 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\(2),
      O => ce_expnd_i_8
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4\ is
  port (
    ce_expnd_i_7 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(1),
      I2 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(2),
      O => ce_expnd_i_7
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5\ is
  port (
    ce_expnd_i_6 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(0),
      I2 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(1),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(2),
      O => ce_expnd_i_6
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6\ is
  port (
    ce_expnd_i_5 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(2),
      I2 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(1),
      O => ce_expnd_i_5
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7\ is
  port (
    ce_expnd_i_4 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0100"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(2),
      I1 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(1),
      I2 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(3),
      O => ce_expnd_i_4
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8\ is
  port (
    ce_expnd_i_3 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(2),
      I1 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(1),
      I2 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(3),
      I3 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(0),
      O => ce_expnd_i_3
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9\ is
  port (
    ce_expnd_i_2 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9\ : entity is "pselect_f";
end \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9\;

architecture STRUCTURE of \mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9\ is
begin
CS: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\(2),
      I1 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\(0),
      I2 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\(3),
      I3 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\(1),
      O => ce_expnd_i_2
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_window_wdt_counter is
  port (
    minusOp : out STD_LOGIC_VECTOR ( 30 downto 0 );
    Q : out STD_LOGIC_VECTOR ( 7 downto 0 );
    wint_int : out STD_LOGIC;
    dis_wdt_cnt : out STD_LOGIC;
    dis_wdt_int_reg_0 : out STD_LOGIC;
    PSME_reg_reg : out STD_LOGIC;
    \LBE_reg_reg[0]\ : out STD_LOGIC;
    dis_wdt_int_reg_1 : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 1 downto 0 );
    \FW_reg_reg[22]\ : out STD_LOGIC;
    WEN_clear_reg_reg : out STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[0]\ : out STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]\ : out STD_LOGIC;
    wdt_reset_reg_reg : out STD_LOGIC;
    \SW_reg_reg[8]\ : out STD_LOGIC;
    \SW_reg_reg[21]\ : out STD_LOGIC;
    \SW_reg_reg[26]\ : out STD_LOGIC;
    \SW_reg_reg[0]\ : out STD_LOGIC;
    \SW_reg_reg[25]\ : out STD_LOGIC;
    \SW_reg_reg[5]\ : out STD_LOGIC;
    dis_wdt_int_reg_2 : out STD_LOGIC;
    SR : out STD_LOGIC_VECTOR ( 0 to 0 );
    S : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \FW_reg_reg[29]\ : out STD_LOGIC;
    \FW_reg_reg[12]\ : out STD_LOGIC;
    wdt_reset_reg_reg_0 : out STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    wint_int_reg_0 : in STD_LOGIC;
    wint_int_reg_1 : in STD_LOGIC;
    wint_int_reg_2 : in STD_LOGIC;
    LBE_reg : in STD_LOGIC_VECTOR ( 0 to 0 );
    \LBE_reg_reg[0]_0\ : in STD_LOGIC;
    LBE_reg0 : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    wint_int_reg_3 : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_0\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[0]_0\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[0]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    fc_sst_enc : in STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_WDT_Current_State_reg[0]_2\ : in STD_LOGIC;
    wdt_reset_reg_reg_1 : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_1\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State[0]_i_3_0\ : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    PSME_reg : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State[0]_i_3_1\ : in STD_LOGIC;
    \LBE_reg_reg[0]_1\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_2\ : in STD_LOGIC;
    \int_cnt_int[7]_i_3\ : in STD_LOGIC;
    WEN_change : in STD_LOGIC;
    p_11_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    \int_cnt_int[7]_i_3_0\ : in STD_LOGIC;
    \int_cnt_int[31]_i_12_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \load_val9_carry__1\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \load_val9_carry__1_0\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    wint_int_reg_4 : in STD_LOGIC_VECTOR ( 1 downto 0 );
    wint_int_i_6_0 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \int_cnt_int[31]_i_14_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wdt_reset_reg_reg_2 : in STD_LOGIC;
    wdt_reset_reg_reg_3 : in STD_LOGIC;
    wdt_reset_int : in STD_LOGIC;
    E : in STD_LOGIC_VECTOR ( 0 to 0 );
    \int_cnt_int_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_window_wdt_counter : entity is "window_wdt_counter";
end mbv_system_axi_timebase_wdt_0_0_window_wdt_counter;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_window_wdt_counter is
  signal \FSM_sequential_WDT_Current_State[0]_i_3_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[0]_i_5_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_12_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_13_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_14_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_15_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_4_n_0\ : STD_LOGIC;
  signal \FSM_sequential_WDT_Current_State[1]_i_5_n_0\ : STD_LOGIC;
  signal \^fw_reg_reg[22]\ : STD_LOGIC;
  signal \^psme_reg_reg\ : STD_LOGIC;
  signal \^q\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^sr\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^wen_clear_reg_reg\ : STD_LOGIC;
  signal \^dis_wdt_cnt\ : STD_LOGIC;
  signal dis_wdt_int_i_1_n_0 : STD_LOGIC;
  signal dis_wdt_int_i_2_n_0 : STD_LOGIC;
  signal dis_wdt_int_i_3_n_0 : STD_LOGIC;
  signal dis_wdt_int_i_4_n_0 : STD_LOGIC;
  signal dis_wdt_int_i_5_n_0 : STD_LOGIC;
  signal dis_wdt_int_i_6_n_0 : STD_LOGIC;
  signal \^dis_wdt_int_reg_0\ : STD_LOGIC;
  signal \^dis_wdt_int_reg_1\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_17_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_18_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_19_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_20_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_21_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_22_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_23_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_24_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_25_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_26_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_27_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_28_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_29_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_30_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_31_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_32_n_0\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[10]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[11]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[12]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[13]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[14]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[15]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[16]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[17]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[18]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[19]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[20]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[21]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[22]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[23]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[24]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[25]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[26]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[27]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[28]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[29]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[30]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[31]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[8]\ : STD_LOGIC;
  signal \int_cnt_int_reg_n_0_[9]\ : STD_LOGIC;
  signal \minusOp_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_n_0\ : STD_LOGIC;
  signal \minusOp_carry__0_n_1\ : STD_LOGIC;
  signal \minusOp_carry__0_n_2\ : STD_LOGIC;
  signal \minusOp_carry__0_n_3\ : STD_LOGIC;
  signal \minusOp_carry__1_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__1_n_1\ : STD_LOGIC;
  signal \minusOp_carry__1_n_2\ : STD_LOGIC;
  signal \minusOp_carry__1_n_3\ : STD_LOGIC;
  signal \minusOp_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__2_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__2_n_1\ : STD_LOGIC;
  signal \minusOp_carry__2_n_2\ : STD_LOGIC;
  signal \minusOp_carry__2_n_3\ : STD_LOGIC;
  signal \minusOp_carry__3_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__3_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__3_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__3_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__3_n_1\ : STD_LOGIC;
  signal \minusOp_carry__3_n_2\ : STD_LOGIC;
  signal \minusOp_carry__3_n_3\ : STD_LOGIC;
  signal \minusOp_carry__4_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__4_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__4_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__4_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__4_n_1\ : STD_LOGIC;
  signal \minusOp_carry__4_n_2\ : STD_LOGIC;
  signal \minusOp_carry__4_n_3\ : STD_LOGIC;
  signal \minusOp_carry__5_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__5_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__5_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__5_i_4_n_0\ : STD_LOGIC;
  signal \minusOp_carry__5_n_0\ : STD_LOGIC;
  signal \minusOp_carry__5_n_1\ : STD_LOGIC;
  signal \minusOp_carry__5_n_2\ : STD_LOGIC;
  signal \minusOp_carry__5_n_3\ : STD_LOGIC;
  signal \minusOp_carry__6_i_1_n_0\ : STD_LOGIC;
  signal \minusOp_carry__6_i_2_n_0\ : STD_LOGIC;
  signal \minusOp_carry__6_i_3_n_0\ : STD_LOGIC;
  signal \minusOp_carry__6_n_2\ : STD_LOGIC;
  signal \minusOp_carry__6_n_3\ : STD_LOGIC;
  signal minusOp_carry_i_1_n_0 : STD_LOGIC;
  signal minusOp_carry_i_2_n_0 : STD_LOGIC;
  signal minusOp_carry_i_3_n_0 : STD_LOGIC;
  signal minusOp_carry_i_4_n_0 : STD_LOGIC;
  signal minusOp_carry_n_0 : STD_LOGIC;
  signal minusOp_carry_n_1 : STD_LOGIC;
  signal minusOp_carry_n_2 : STD_LOGIC;
  signal minusOp_carry_n_3 : STD_LOGIC;
  signal wdt_reset_reg_i_3_n_0 : STD_LOGIC;
  signal wdt_reset_reg_i_6_n_0 : STD_LOGIC;
  signal \^wint_int\ : STD_LOGIC;
  signal wint_int_i_10_n_0 : STD_LOGIC;
  signal wint_int_i_11_n_0 : STD_LOGIC;
  signal wint_int_i_12_n_0 : STD_LOGIC;
  signal wint_int_i_13_n_0 : STD_LOGIC;
  signal wint_int_i_14_n_0 : STD_LOGIC;
  signal wint_int_i_15_n_0 : STD_LOGIC;
  signal wint_int_i_16_n_0 : STD_LOGIC;
  signal wint_int_i_17_n_0 : STD_LOGIC;
  signal wint_int_i_18_n_0 : STD_LOGIC;
  signal wint_int_i_19_n_0 : STD_LOGIC;
  signal wint_int_i_1_n_0 : STD_LOGIC;
  signal wint_int_i_20_n_0 : STD_LOGIC;
  signal wint_int_i_21_n_0 : STD_LOGIC;
  signal wint_int_i_22_n_0 : STD_LOGIC;
  signal wint_int_i_23_n_0 : STD_LOGIC;
  signal wint_int_i_24_n_0 : STD_LOGIC;
  signal wint_int_i_25_n_0 : STD_LOGIC;
  signal wint_int_i_26_n_0 : STD_LOGIC;
  signal wint_int_i_27_n_0 : STD_LOGIC;
  signal wint_int_i_28_n_0 : STD_LOGIC;
  signal wint_int_i_29_n_0 : STD_LOGIC;
  signal wint_int_i_2_n_0 : STD_LOGIC;
  signal wint_int_i_3_n_0 : STD_LOGIC;
  signal wint_int_i_4_n_0 : STD_LOGIC;
  signal wint_int_i_5_n_0 : STD_LOGIC;
  signal wint_int_i_6_n_0 : STD_LOGIC;
  signal wint_int_i_7_n_0 : STD_LOGIC;
  signal wint_int_i_8_n_0 : STD_LOGIC;
  signal wint_int_i_9_n_0 : STD_LOGIC;
  signal \NLW_minusOp_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_minusOp_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[0]_i_4\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_10\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_11\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_12\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_13\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_14\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_15\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_5\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_8\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_9\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \LBE_reg[0]_i_2\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of WCFG_reg_In_i_3 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of dis_wdt_int_i_3 : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of dis_wdt_int_i_4 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of dis_wdt_int_i_5 : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_10\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_16\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_18\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_20\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_22\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_24\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_26\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_28\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_30\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_32\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \int_cnt_int[31]_i_8\ : label is "soft_lutpair33";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of minusOp_carry : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \minusOp_carry__6\ : label is 35;
  attribute SOFT_HLUTNM of wdt_reset_reg_i_3 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of wdt_reset_reg_i_6 : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of wint_int_i_14 : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of wint_int_i_28 : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of wint_int_i_29 : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of wint_int_i_5 : label is "soft_lutpair30";
begin
  \FW_reg_reg[22]\ <= \^fw_reg_reg[22]\;
  PSME_reg_reg <= \^psme_reg_reg\;
  Q(7 downto 0) <= \^q\(7 downto 0);
  SR(0) <= \^sr\(0);
  WEN_clear_reg_reg <= \^wen_clear_reg_reg\;
  dis_wdt_cnt <= \^dis_wdt_cnt\;
  dis_wdt_int_reg_0 <= \^dis_wdt_int_reg_0\;
  dis_wdt_int_reg_1 <= \^dis_wdt_int_reg_1\;
  wint_int <= \^wint_int\;
\FSM_sequential_WDT_Current_State[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF0F880088"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[0]_0\,
      I1 => \FSM_sequential_WDT_Current_State[0]_i_3_n_0\,
      I2 => \^dis_wdt_cnt\,
      I3 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I4 => fc_sst_enc(0),
      I5 => \^dis_wdt_int_reg_0\,
      O => D(0)
    );
\FSM_sequential_WDT_Current_State[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"888888880000000F"
    )
        port map (
      I0 => fc_sst_enc(0),
      I1 => \FSM_sequential_WDT_Current_State[0]_i_5_n_0\,
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_2\,
      I3 => \^fw_reg_reg[22]\,
      I4 => wdt_reset_reg_reg_1,
      I5 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      O => \FSM_sequential_WDT_Current_State[0]_i_3_n_0\
    );
\FSM_sequential_WDT_Current_State[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"44444440"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I3 => \^wen_clear_reg_reg\,
      I4 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      O => \^dis_wdt_int_reg_0\
    );
\FSM_sequential_WDT_Current_State[0]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22EE222203FF0303"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I2 => \FSM_sequential_WDT_Current_State[0]_i_3_0\,
      I3 => CO(0),
      I4 => PSME_reg,
      I5 => \FSM_sequential_WDT_Current_State[0]_i_3_1\,
      O => \FSM_sequential_WDT_Current_State[0]_i_5_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4FFF4F4FFFF"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[1]_0\,
      I1 => \^fw_reg_reg[22]\,
      I2 => \FSM_sequential_WDT_Current_State[1]_i_4_n_0\,
      I3 => \FSM_sequential_WDT_Current_State[1]_i_5_n_0\,
      I4 => \LBE_reg_reg[0]_0\,
      I5 => \^psme_reg_reg\,
      O => D(1)
    );
\FSM_sequential_WDT_Current_State[1]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(21),
      I1 => \int_cnt_int[31]_i_12_0\(18),
      I2 => \int_cnt_int[31]_i_12_0\(29),
      I3 => \int_cnt_int[31]_i_12_0\(17),
      I4 => \int_cnt_int[31]_i_19_n_0\,
      O => \SW_reg_reg[21]\
    );
\FSM_sequential_WDT_Current_State[1]_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(26),
      I1 => \int_cnt_int[31]_i_12_0\(19),
      I2 => \int_cnt_int[31]_i_12_0\(16),
      I3 => \int_cnt_int[31]_i_12_0\(13),
      I4 => \int_cnt_int[31]_i_17_n_0\,
      O => \SW_reg_reg[26]\
    );
\FSM_sequential_WDT_Current_State[1]_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(22),
      I1 => \int_cnt_int[31]_i_14_0\(21),
      I2 => \int_cnt_int[31]_i_14_0\(23),
      I3 => \int_cnt_int[31]_i_14_0\(20),
      I4 => \int_cnt_int[31]_i_31_n_0\,
      O => \FSM_sequential_WDT_Current_State[1]_i_12_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000001"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(11),
      I1 => \int_cnt_int[31]_i_14_0\(8),
      I2 => \int_cnt_int[31]_i_14_0\(10),
      I3 => \int_cnt_int[31]_i_14_0\(9),
      I4 => \int_cnt_int[31]_i_29_n_0\,
      O => \FSM_sequential_WDT_Current_State[1]_i_13_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(27),
      I1 => \int_cnt_int[31]_i_14_0\(26),
      I2 => \int_cnt_int[31]_i_14_0\(25),
      I3 => \int_cnt_int[31]_i_14_0\(24),
      I4 => \int_cnt_int[31]_i_27_n_0\,
      O => \FSM_sequential_WDT_Current_State[1]_i_14_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(2),
      I1 => \int_cnt_int[31]_i_14_0\(1),
      I2 => \int_cnt_int[31]_i_14_0\(3),
      I3 => \int_cnt_int[31]_i_14_0\(0),
      I4 => \int_cnt_int[31]_i_25_n_0\,
      O => \FSM_sequential_WDT_Current_State[1]_i_15_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State[1]_i_12_n_0\,
      I1 => \FSM_sequential_WDT_Current_State[1]_i_13_n_0\,
      I2 => \FSM_sequential_WDT_Current_State[1]_i_14_n_0\,
      I3 => \FSM_sequential_WDT_Current_State[1]_i_15_n_0\,
      O => \^fw_reg_reg[22]\
    );
\FSM_sequential_WDT_Current_State[1]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2828282A28282828"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I1 => \^dis_wdt_cnt\,
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I3 => \^wen_clear_reg_reg\,
      I4 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      I5 => fc_sst_enc(0),
      O => \FSM_sequential_WDT_Current_State[1]_i_4_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"E0EF"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I2 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      I3 => fc_sst_enc(0),
      O => \FSM_sequential_WDT_Current_State[1]_i_5_n_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF04FFFF"
    )
        port map (
      I0 => CO(0),
      I1 => PSME_reg,
      I2 => \^wen_clear_reg_reg\,
      I3 => \^dis_wdt_cnt\,
      I4 => \LBE_reg_reg[0]_1\,
      O => \^psme_reg_reg\
    );
\FSM_sequential_WDT_Current_State[1]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(25),
      I1 => \int_cnt_int[31]_i_12_0\(11),
      I2 => \int_cnt_int[31]_i_12_0\(24),
      I3 => \int_cnt_int[31]_i_12_0\(14),
      I4 => \int_cnt_int[31]_i_23_n_0\,
      O => \SW_reg_reg[25]\
    );
\FSM_sequential_WDT_Current_State[1]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(5),
      I1 => \int_cnt_int[31]_i_12_0\(3),
      I2 => \int_cnt_int[31]_i_12_0\(23),
      I3 => \int_cnt_int[31]_i_12_0\(20),
      I4 => \int_cnt_int[31]_i_21_n_0\,
      O => \SW_reg_reg[5]\
    );
\LBE_reg[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FFAEFFA2"
    )
        port map (
      I0 => LBE_reg(0),
      I1 => \^psme_reg_reg\,
      I2 => \LBE_reg_reg[0]_0\,
      I3 => \^dis_wdt_int_reg_1\,
      I4 => \^dis_wdt_cnt\,
      I5 => LBE_reg0,
      O => \LBE_reg_reg[0]\
    );
\LBE_reg[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I2 => \^wen_clear_reg_reg\,
      I3 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      O => \^dis_wdt_int_reg_1\
    );
WCFG_reg_In_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => wdt_reset_reg_reg_1,
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      O => wdt_reset_reg_reg
    );
dis_wdt_int_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000020"
    )
        port map (
      I0 => dis_wdt_int_i_2_n_0,
      I1 => dis_wdt_int_i_3_n_0,
      I2 => \^q\(0),
      I3 => dis_wdt_int_i_4_n_0,
      I4 => dis_wdt_int_i_5_n_0,
      O => dis_wdt_int_i_1_n_0
    );
dis_wdt_int_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => dis_wdt_int_i_6_n_0,
      I1 => \int_cnt_int_reg_n_0_[17]\,
      I2 => \int_cnt_int_reg_n_0_[16]\,
      I3 => wint_int_i_7_n_0,
      O => dis_wdt_int_i_2_n_0
    );
dis_wdt_int_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^q\(7),
      I1 => \^q\(6),
      I2 => \^q\(4),
      I3 => \^q\(5),
      O => dis_wdt_int_i_3_n_0
    );
dis_wdt_int_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \^q\(2),
      I1 => \^q\(1),
      I2 => \^q\(3),
      O => dis_wdt_int_i_4_n_0
    );
dis_wdt_int_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[8]\,
      I1 => \int_cnt_int_reg_n_0_[9]\,
      I2 => wint_int_i_8_n_0,
      O => dis_wdt_int_i_5_n_0
    );
dis_wdt_int_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[23]\,
      I1 => \int_cnt_int_reg_n_0_[22]\,
      I2 => \int_cnt_int_reg_n_0_[21]\,
      I3 => \int_cnt_int_reg_n_0_[20]\,
      I4 => \int_cnt_int_reg_n_0_[18]\,
      I5 => \int_cnt_int_reg_n_0_[19]\,
      O => dis_wdt_int_i_6_n_0
    );
dis_wdt_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => dis_wdt_int_i_1_n_0,
      Q => \^dis_wdt_cnt\,
      R => '0'
    );
\int_cnt_int[31]_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I1 => \^wen_clear_reg_reg\,
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      O => \FSM_sequential_WDT_Current_State_reg[0]\
    );
\int_cnt_int[31]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \int_cnt_int[31]_i_17_n_0\,
      I1 => \int_cnt_int[31]_i_18_n_0\,
      I2 => \int_cnt_int[31]_i_19_n_0\,
      I3 => \int_cnt_int[31]_i_20_n_0\,
      O => \SW_reg_reg[8]\
    );
\int_cnt_int[31]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_21_n_0\,
      I1 => \int_cnt_int[31]_i_22_n_0\,
      I2 => \int_cnt_int[31]_i_23_n_0\,
      I3 => \int_cnt_int[31]_i_24_n_0\,
      O => \SW_reg_reg[0]\
    );
\int_cnt_int[31]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_25_n_0\,
      I1 => \int_cnt_int[31]_i_26_n_0\,
      I2 => \int_cnt_int[31]_i_27_n_0\,
      I3 => \int_cnt_int[31]_i_28_n_0\,
      O => \FW_reg_reg[29]\
    );
\int_cnt_int[31]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0004"
    )
        port map (
      I0 => \int_cnt_int[31]_i_29_n_0\,
      I1 => \int_cnt_int[31]_i_30_n_0\,
      I2 => \int_cnt_int[31]_i_31_n_0\,
      I3 => \int_cnt_int[31]_i_32_n_0\,
      O => \FW_reg_reg[12]\
    );
\int_cnt_int[31]_i_16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      I2 => \^dis_wdt_cnt\,
      O => \FSM_sequential_WDT_Current_State_reg[1]\
    );
\int_cnt_int[31]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(8),
      I1 => \int_cnt_int[31]_i_12_0\(12),
      I2 => \int_cnt_int[31]_i_12_0\(9),
      I3 => \int_cnt_int[31]_i_12_0\(10),
      O => \int_cnt_int[31]_i_17_n_0\
    );
\int_cnt_int[31]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(13),
      I1 => \int_cnt_int[31]_i_12_0\(16),
      I2 => \int_cnt_int[31]_i_12_0\(19),
      I3 => \int_cnt_int[31]_i_12_0\(26),
      O => \int_cnt_int[31]_i_18_n_0\
    );
\int_cnt_int[31]_i_19\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(28),
      I1 => \int_cnt_int[31]_i_12_0\(31),
      I2 => \int_cnt_int[31]_i_12_0\(27),
      I3 => \int_cnt_int[31]_i_12_0\(30),
      O => \int_cnt_int[31]_i_19_n_0\
    );
\int_cnt_int[31]_i_20\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(17),
      I1 => \int_cnt_int[31]_i_12_0\(29),
      I2 => \int_cnt_int[31]_i_12_0\(18),
      I3 => \int_cnt_int[31]_i_12_0\(21),
      O => \int_cnt_int[31]_i_20_n_0\
    );
\int_cnt_int[31]_i_21\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(0),
      I1 => \int_cnt_int[31]_i_12_0\(4),
      I2 => \int_cnt_int[31]_i_12_0\(2),
      I3 => \int_cnt_int[31]_i_12_0\(7),
      O => \int_cnt_int[31]_i_21_n_0\
    );
\int_cnt_int[31]_i_22\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(20),
      I1 => \int_cnt_int[31]_i_12_0\(23),
      I2 => \int_cnt_int[31]_i_12_0\(3),
      I3 => \int_cnt_int[31]_i_12_0\(5),
      O => \int_cnt_int[31]_i_22_n_0\
    );
\int_cnt_int[31]_i_23\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(1),
      I1 => \int_cnt_int[31]_i_12_0\(22),
      I2 => \int_cnt_int[31]_i_12_0\(6),
      I3 => \int_cnt_int[31]_i_12_0\(15),
      O => \int_cnt_int[31]_i_23_n_0\
    );
\int_cnt_int[31]_i_24\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_12_0\(14),
      I1 => \int_cnt_int[31]_i_12_0\(24),
      I2 => \int_cnt_int[31]_i_12_0\(11),
      I3 => \int_cnt_int[31]_i_12_0\(25),
      O => \int_cnt_int[31]_i_24_n_0\
    );
\int_cnt_int[31]_i_25\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(29),
      I1 => \int_cnt_int[31]_i_14_0\(31),
      I2 => \int_cnt_int[31]_i_14_0\(28),
      I3 => \int_cnt_int[31]_i_14_0\(30),
      O => \int_cnt_int[31]_i_25_n_0\
    );
\int_cnt_int[31]_i_26\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(0),
      I1 => \int_cnt_int[31]_i_14_0\(3),
      I2 => \int_cnt_int[31]_i_14_0\(1),
      I3 => \int_cnt_int[31]_i_14_0\(2),
      O => \int_cnt_int[31]_i_26_n_0\
    );
\int_cnt_int[31]_i_27\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(6),
      I1 => \int_cnt_int[31]_i_14_0\(7),
      I2 => \int_cnt_int[31]_i_14_0\(4),
      I3 => \int_cnt_int[31]_i_14_0\(5),
      O => \int_cnt_int[31]_i_27_n_0\
    );
\int_cnt_int[31]_i_28\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(24),
      I1 => \int_cnt_int[31]_i_14_0\(25),
      I2 => \int_cnt_int[31]_i_14_0\(26),
      I3 => \int_cnt_int[31]_i_14_0\(27),
      O => \int_cnt_int[31]_i_28_n_0\
    );
\int_cnt_int[31]_i_29\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(12),
      I1 => \int_cnt_int[31]_i_14_0\(13),
      I2 => \int_cnt_int[31]_i_14_0\(14),
      I3 => \int_cnt_int[31]_i_14_0\(15),
      O => \int_cnt_int[31]_i_29_n_0\
    );
\int_cnt_int[31]_i_30\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(9),
      I1 => \int_cnt_int[31]_i_14_0\(10),
      I2 => \int_cnt_int[31]_i_14_0\(8),
      I3 => \int_cnt_int[31]_i_14_0\(11),
      O => \int_cnt_int[31]_i_30_n_0\
    );
\int_cnt_int[31]_i_31\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(18),
      I1 => \int_cnt_int[31]_i_14_0\(19),
      I2 => \int_cnt_int[31]_i_14_0\(16),
      I3 => \int_cnt_int[31]_i_14_0\(17),
      O => \int_cnt_int[31]_i_31_n_0\
    );
\int_cnt_int[31]_i_32\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int[31]_i_14_0\(20),
      I1 => \int_cnt_int[31]_i_14_0\(23),
      I2 => \int_cnt_int[31]_i_14_0\(21),
      I3 => \int_cnt_int[31]_i_14_0\(22),
      O => \int_cnt_int[31]_i_32_n_0\
    );
\int_cnt_int[31]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      O => dis_wdt_int_reg_2
    );
\int_cnt_int_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(0),
      Q => \^q\(0),
      R => \^sr\(0)
    );
\int_cnt_int_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(10),
      Q => \int_cnt_int_reg_n_0_[10]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(11),
      Q => \int_cnt_int_reg_n_0_[11]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(12),
      Q => \int_cnt_int_reg_n_0_[12]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(13),
      Q => \int_cnt_int_reg_n_0_[13]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(14),
      Q => \int_cnt_int_reg_n_0_[14]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(15),
      Q => \int_cnt_int_reg_n_0_[15]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(16),
      Q => \int_cnt_int_reg_n_0_[16]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(17),
      Q => \int_cnt_int_reg_n_0_[17]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(18),
      Q => \int_cnt_int_reg_n_0_[18]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(19),
      Q => \int_cnt_int_reg_n_0_[19]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(1),
      Q => \^q\(1),
      R => \^sr\(0)
    );
\int_cnt_int_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(20),
      Q => \int_cnt_int_reg_n_0_[20]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(21),
      Q => \int_cnt_int_reg_n_0_[21]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(22),
      Q => \int_cnt_int_reg_n_0_[22]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(23),
      Q => \int_cnt_int_reg_n_0_[23]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(24),
      Q => \int_cnt_int_reg_n_0_[24]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(25),
      Q => \int_cnt_int_reg_n_0_[25]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(26),
      Q => \int_cnt_int_reg_n_0_[26]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(27),
      Q => \int_cnt_int_reg_n_0_[27]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(28),
      Q => \int_cnt_int_reg_n_0_[28]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(29),
      Q => \int_cnt_int_reg_n_0_[29]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(2),
      Q => \^q\(2),
      R => \^sr\(0)
    );
\int_cnt_int_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(30),
      Q => \int_cnt_int_reg_n_0_[30]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(31),
      Q => \int_cnt_int_reg_n_0_[31]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(3),
      Q => \^q\(3),
      R => \^sr\(0)
    );
\int_cnt_int_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(4),
      Q => \^q\(4),
      R => \^sr\(0)
    );
\int_cnt_int_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(5),
      Q => \^q\(5),
      R => \^sr\(0)
    );
\int_cnt_int_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(6),
      Q => \^q\(6),
      R => \^sr\(0)
    );
\int_cnt_int_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(7),
      Q => \^q\(7),
      R => \^sr\(0)
    );
\int_cnt_int_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(8),
      Q => \int_cnt_int_reg_n_0_[8]\,
      R => \^sr\(0)
    );
\int_cnt_int_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => E(0),
      D => \int_cnt_int_reg[31]_0\(9),
      Q => \int_cnt_int_reg_n_0_[9]\,
      R => \^sr\(0)
    );
\load_val9_carry__1_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => \load_val9_carry__1\(6),
      I1 => \load_val9_carry__1_0\(6),
      I2 => \load_val9_carry__1_0\(7),
      I3 => \load_val9_carry__1\(7),
      O => S(2)
    );
\load_val9_carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \load_val9_carry__1_0\(3),
      I1 => \load_val9_carry__1\(3),
      I2 => \load_val9_carry__1_0\(5),
      I3 => \load_val9_carry__1\(5),
      I4 => \load_val9_carry__1\(4),
      I5 => \load_val9_carry__1_0\(4),
      O => S(1)
    );
\load_val9_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => \load_val9_carry__1_0\(2),
      I1 => \load_val9_carry__1\(2),
      I2 => \load_val9_carry__1_0\(0),
      I3 => \load_val9_carry__1\(0),
      I4 => \load_val9_carry__1\(1),
      I5 => \load_val9_carry__1_0\(1),
      O => S(0)
    );
minusOp_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => minusOp_carry_n_0,
      CO(2) => minusOp_carry_n_1,
      CO(1) => minusOp_carry_n_2,
      CO(0) => minusOp_carry_n_3,
      CYINIT => \^q\(0),
      DI(3 downto 0) => \^q\(4 downto 1),
      O(3 downto 0) => minusOp(3 downto 0),
      S(3) => minusOp_carry_i_1_n_0,
      S(2) => minusOp_carry_i_2_n_0,
      S(1) => minusOp_carry_i_3_n_0,
      S(0) => minusOp_carry_i_4_n_0
    );
\minusOp_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => minusOp_carry_n_0,
      CO(3) => \minusOp_carry__0_n_0\,
      CO(2) => \minusOp_carry__0_n_1\,
      CO(1) => \minusOp_carry__0_n_2\,
      CO(0) => \minusOp_carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[8]\,
      DI(2 downto 0) => \^q\(7 downto 5),
      O(3 downto 0) => minusOp(7 downto 4),
      S(3) => \minusOp_carry__0_i_1_n_0\,
      S(2) => \minusOp_carry__0_i_2_n_0\,
      S(1) => \minusOp_carry__0_i_3_n_0\,
      S(0) => \minusOp_carry__0_i_4_n_0\
    );
\minusOp_carry__0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[8]\,
      O => \minusOp_carry__0_i_1_n_0\
    );
\minusOp_carry__0_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(7),
      O => \minusOp_carry__0_i_2_n_0\
    );
\minusOp_carry__0_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(6),
      O => \minusOp_carry__0_i_3_n_0\
    );
\minusOp_carry__0_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(5),
      O => \minusOp_carry__0_i_4_n_0\
    );
\minusOp_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__0_n_0\,
      CO(3) => \minusOp_carry__1_n_0\,
      CO(2) => \minusOp_carry__1_n_1\,
      CO(1) => \minusOp_carry__1_n_2\,
      CO(0) => \minusOp_carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[12]\,
      DI(2) => \int_cnt_int_reg_n_0_[11]\,
      DI(1) => \int_cnt_int_reg_n_0_[10]\,
      DI(0) => \int_cnt_int_reg_n_0_[9]\,
      O(3 downto 0) => minusOp(11 downto 8),
      S(3) => \minusOp_carry__1_i_1_n_0\,
      S(2) => \minusOp_carry__1_i_2_n_0\,
      S(1) => \minusOp_carry__1_i_3_n_0\,
      S(0) => \minusOp_carry__1_i_4_n_0\
    );
\minusOp_carry__1_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[12]\,
      O => \minusOp_carry__1_i_1_n_0\
    );
\minusOp_carry__1_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[11]\,
      O => \minusOp_carry__1_i_2_n_0\
    );
\minusOp_carry__1_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[10]\,
      O => \minusOp_carry__1_i_3_n_0\
    );
\minusOp_carry__1_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[9]\,
      O => \minusOp_carry__1_i_4_n_0\
    );
\minusOp_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__1_n_0\,
      CO(3) => \minusOp_carry__2_n_0\,
      CO(2) => \minusOp_carry__2_n_1\,
      CO(1) => \minusOp_carry__2_n_2\,
      CO(0) => \minusOp_carry__2_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[16]\,
      DI(2) => \int_cnt_int_reg_n_0_[15]\,
      DI(1) => \int_cnt_int_reg_n_0_[14]\,
      DI(0) => \int_cnt_int_reg_n_0_[13]\,
      O(3 downto 0) => minusOp(15 downto 12),
      S(3) => \minusOp_carry__2_i_1_n_0\,
      S(2) => \minusOp_carry__2_i_2_n_0\,
      S(1) => \minusOp_carry__2_i_3_n_0\,
      S(0) => \minusOp_carry__2_i_4_n_0\
    );
\minusOp_carry__2_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[16]\,
      O => \minusOp_carry__2_i_1_n_0\
    );
\minusOp_carry__2_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[15]\,
      O => \minusOp_carry__2_i_2_n_0\
    );
\minusOp_carry__2_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[14]\,
      O => \minusOp_carry__2_i_3_n_0\
    );
\minusOp_carry__2_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[13]\,
      O => \minusOp_carry__2_i_4_n_0\
    );
\minusOp_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__2_n_0\,
      CO(3) => \minusOp_carry__3_n_0\,
      CO(2) => \minusOp_carry__3_n_1\,
      CO(1) => \minusOp_carry__3_n_2\,
      CO(0) => \minusOp_carry__3_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[20]\,
      DI(2) => \int_cnt_int_reg_n_0_[19]\,
      DI(1) => \int_cnt_int_reg_n_0_[18]\,
      DI(0) => \int_cnt_int_reg_n_0_[17]\,
      O(3 downto 0) => minusOp(19 downto 16),
      S(3) => \minusOp_carry__3_i_1_n_0\,
      S(2) => \minusOp_carry__3_i_2_n_0\,
      S(1) => \minusOp_carry__3_i_3_n_0\,
      S(0) => \minusOp_carry__3_i_4_n_0\
    );
\minusOp_carry__3_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[20]\,
      O => \minusOp_carry__3_i_1_n_0\
    );
\minusOp_carry__3_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[19]\,
      O => \minusOp_carry__3_i_2_n_0\
    );
\minusOp_carry__3_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[18]\,
      O => \minusOp_carry__3_i_3_n_0\
    );
\minusOp_carry__3_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[17]\,
      O => \minusOp_carry__3_i_4_n_0\
    );
\minusOp_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__3_n_0\,
      CO(3) => \minusOp_carry__4_n_0\,
      CO(2) => \minusOp_carry__4_n_1\,
      CO(1) => \minusOp_carry__4_n_2\,
      CO(0) => \minusOp_carry__4_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[24]\,
      DI(2) => \int_cnt_int_reg_n_0_[23]\,
      DI(1) => \int_cnt_int_reg_n_0_[22]\,
      DI(0) => \int_cnt_int_reg_n_0_[21]\,
      O(3 downto 0) => minusOp(23 downto 20),
      S(3) => \minusOp_carry__4_i_1_n_0\,
      S(2) => \minusOp_carry__4_i_2_n_0\,
      S(1) => \minusOp_carry__4_i_3_n_0\,
      S(0) => \minusOp_carry__4_i_4_n_0\
    );
\minusOp_carry__4_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[24]\,
      O => \minusOp_carry__4_i_1_n_0\
    );
\minusOp_carry__4_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[23]\,
      O => \minusOp_carry__4_i_2_n_0\
    );
\minusOp_carry__4_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[22]\,
      O => \minusOp_carry__4_i_3_n_0\
    );
\minusOp_carry__4_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[21]\,
      O => \minusOp_carry__4_i_4_n_0\
    );
\minusOp_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__4_n_0\,
      CO(3) => \minusOp_carry__5_n_0\,
      CO(2) => \minusOp_carry__5_n_1\,
      CO(1) => \minusOp_carry__5_n_2\,
      CO(0) => \minusOp_carry__5_n_3\,
      CYINIT => '0',
      DI(3) => \int_cnt_int_reg_n_0_[28]\,
      DI(2) => \int_cnt_int_reg_n_0_[27]\,
      DI(1) => \int_cnt_int_reg_n_0_[26]\,
      DI(0) => \int_cnt_int_reg_n_0_[25]\,
      O(3 downto 0) => minusOp(27 downto 24),
      S(3) => \minusOp_carry__5_i_1_n_0\,
      S(2) => \minusOp_carry__5_i_2_n_0\,
      S(1) => \minusOp_carry__5_i_3_n_0\,
      S(0) => \minusOp_carry__5_i_4_n_0\
    );
\minusOp_carry__5_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[28]\,
      O => \minusOp_carry__5_i_1_n_0\
    );
\minusOp_carry__5_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[27]\,
      O => \minusOp_carry__5_i_2_n_0\
    );
\minusOp_carry__5_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[26]\,
      O => \minusOp_carry__5_i_3_n_0\
    );
\minusOp_carry__5_i_4\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[25]\,
      O => \minusOp_carry__5_i_4_n_0\
    );
\minusOp_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \minusOp_carry__5_n_0\,
      CO(3 downto 2) => \NLW_minusOp_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \minusOp_carry__6_n_2\,
      CO(0) => \minusOp_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \int_cnt_int_reg_n_0_[30]\,
      DI(0) => \int_cnt_int_reg_n_0_[29]\,
      O(3) => \NLW_minusOp_carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => minusOp(30 downto 28),
      S(3) => '0',
      S(2) => \minusOp_carry__6_i_1_n_0\,
      S(1) => \minusOp_carry__6_i_2_n_0\,
      S(0) => \minusOp_carry__6_i_3_n_0\
    );
\minusOp_carry__6_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[31]\,
      O => \minusOp_carry__6_i_1_n_0\
    );
\minusOp_carry__6_i_2\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[30]\,
      O => \minusOp_carry__6_i_2_n_0\
    );
\minusOp_carry__6_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[29]\,
      O => \minusOp_carry__6_i_3_n_0\
    );
minusOp_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(4),
      O => minusOp_carry_i_1_n_0
    );
minusOp_carry_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(3),
      O => minusOp_carry_i_2_n_0
    );
minusOp_carry_i_3: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(2),
      O => minusOp_carry_i_3_n_0
    );
minusOp_carry_i_4: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^q\(1),
      O => minusOp_carry_i_4_n_0
    );
wdt_reset_reg_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => s_axi_aresetn,
      O => \^sr\(0)
    );
wdt_reset_reg_i_10: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000FFFB"
    )
        port map (
      I0 => \int_cnt_int[7]_i_3\,
      I1 => WEN_change,
      I2 => p_11_in(0),
      I3 => \int_cnt_int[7]_i_3_0\,
      I4 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      O => \^wen_clear_reg_reg\
    );
wdt_reset_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABBBFFFFABBB0000"
    )
        port map (
      I0 => wdt_reset_reg_i_3_n_0,
      I1 => wdt_reset_reg_reg_2,
      I2 => wdt_reset_reg_reg_3,
      I3 => wdt_reset_reg_i_6_n_0,
      I4 => wdt_reset_int,
      I5 => wdt_reset_reg_reg_1,
      O => wdt_reset_reg_reg_0
    );
wdt_reset_reg_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => \^dis_wdt_cnt\,
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I2 => \FSM_sequential_WDT_Current_State_reg[0]_1\(0),
      O => wdt_reset_reg_i_3_n_0
    );
wdt_reset_reg_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \^wen_clear_reg_reg\,
      I1 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      I2 => \^dis_wdt_cnt\,
      O => wdt_reset_reg_i_6_n_0
    );
wint_int_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"20202000A0A0A080"
    )
        port map (
      I0 => s_axi_aresetn,
      I1 => \^wint_int\,
      I2 => wint_int_i_2_n_0,
      I3 => wint_int_i_3_n_0,
      I4 => wint_int_i_4_n_0,
      I5 => wint_int_reg_3,
      O => wint_int_i_1_n_0
    );
wint_int_i_10: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => wint_int_i_19_n_0,
      I1 => dis_wdt_int_i_5_n_0,
      I2 => dis_wdt_int_i_6_n_0,
      I3 => wint_int_i_20_n_0,
      I4 => wint_int_i_21_n_0,
      O => wint_int_i_10_n_0
    );
wint_int_i_11: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000041000041"
    )
        port map (
      I0 => wint_int_i_22_n_0,
      I1 => wint_int_i_6_0(5),
      I2 => \int_cnt_int_reg_n_0_[13]\,
      I3 => wint_int_i_6_0(2),
      I4 => \int_cnt_int_reg_n_0_[10]\,
      I5 => wint_int_i_23_n_0,
      O => wint_int_i_11_n_0
    );
wint_int_i_12: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
        port map (
      I0 => \^q\(5),
      I1 => wint_int_i_6_0(5),
      I2 => \^q\(2),
      I3 => wint_int_i_6_0(2),
      I4 => wint_int_i_24_n_0,
      I5 => wint_int_i_25_n_0,
      O => wint_int_i_12_n_0
    );
wint_int_i_13: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBEFFFFBE"
    )
        port map (
      I0 => dis_wdt_int_i_5_n_0,
      I1 => wint_int_i_6_0(6),
      I2 => \^q\(6),
      I3 => wint_int_i_6_0(7),
      I4 => \^q\(7),
      I5 => wint_int_reg_4(0),
      O => wint_int_i_13_n_0
    );
wint_int_i_14: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^q\(0),
      I1 => \^q\(3),
      I2 => \^q\(1),
      I3 => \^q\(2),
      O => wint_int_i_14_n_0
    );
wint_int_i_15: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BEFFFFBE"
    )
        port map (
      I0 => dis_wdt_int_i_3_n_0,
      I1 => \int_cnt_int_reg_n_0_[22]\,
      I2 => wint_int_i_6_0(6),
      I3 => \int_cnt_int_reg_n_0_[23]\,
      I4 => wint_int_i_6_0(7),
      O => wint_int_i_15_n_0
    );
wint_int_i_16: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[30]\,
      I1 => \int_cnt_int_reg_n_0_[26]\,
      I2 => \int_cnt_int_reg_n_0_[24]\,
      I3 => \int_cnt_int_reg_n_0_[28]\,
      O => wint_int_i_16_n_0
    );
wint_int_i_17: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(0),
      I1 => \int_cnt_int_reg_n_0_[16]\,
      I2 => wint_int_i_6_0(1),
      I3 => \int_cnt_int_reg_n_0_[17]\,
      O => wint_int_i_17_n_0
    );
wint_int_i_18: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(4),
      I1 => \int_cnt_int_reg_n_0_[20]\,
      I2 => wint_int_i_6_0(3),
      I3 => \int_cnt_int_reg_n_0_[19]\,
      O => wint_int_i_18_n_0
    );
wint_int_i_19: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[29]\,
      I1 => wint_int_i_6_0(5),
      I2 => \int_cnt_int_reg_n_0_[26]\,
      I3 => wint_int_i_6_0(2),
      I4 => wint_int_i_26_n_0,
      I5 => wint_int_i_27_n_0,
      O => wint_int_i_19_n_0
    );
wint_int_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4F4F5"
    )
        port map (
      I0 => wint_int_reg_0,
      I1 => wint_int_i_5_n_0,
      I2 => \^dis_wdt_int_reg_0\,
      I3 => \^psme_reg_reg\,
      I4 => wint_int_reg_1,
      I5 => wint_int_reg_2,
      O => wint_int_i_2_n_0
    );
wint_int_i_20: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFBF"
    )
        port map (
      I0 => wint_int_i_14_n_0,
      I1 => wint_int_reg_4(0),
      I2 => wint_int_reg_4(1),
      I3 => \int_cnt_int_reg_n_0_[17]\,
      I4 => \int_cnt_int_reg_n_0_[16]\,
      O => wint_int_i_20_n_0
    );
wint_int_i_21: unisim.vcomponents.LUT5
    generic map(
      INIT => X"BEFFFFBE"
    )
        port map (
      I0 => dis_wdt_int_i_3_n_0,
      I1 => \int_cnt_int_reg_n_0_[31]\,
      I2 => wint_int_i_6_0(7),
      I3 => \int_cnt_int_reg_n_0_[30]\,
      I4 => wint_int_i_6_0(6),
      O => wint_int_i_21_n_0
    );
wint_int_i_22: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF6FF6"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[12]\,
      I1 => wint_int_i_6_0(4),
      I2 => \int_cnt_int_reg_n_0_[11]\,
      I3 => wint_int_i_6_0(3),
      I4 => wint_int_i_28_n_0,
      O => wint_int_i_22_n_0
    );
wint_int_i_23: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBEFFFFBE"
    )
        port map (
      I0 => wint_int_i_29_n_0,
      I1 => wint_int_i_6_0(7),
      I2 => \int_cnt_int_reg_n_0_[15]\,
      I3 => wint_int_i_6_0(6),
      I4 => \int_cnt_int_reg_n_0_[14]\,
      I5 => wint_int_i_14_n_0,
      O => wint_int_i_23_n_0
    );
wint_int_i_24: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(1),
      I1 => \^q\(1),
      I2 => \^q\(0),
      I3 => wint_int_i_6_0(0),
      O => wint_int_i_24_n_0
    );
wint_int_i_25: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(3),
      I1 => \^q\(3),
      I2 => wint_int_i_6_0(4),
      I3 => \^q\(4),
      O => wint_int_i_25_n_0
    );
wint_int_i_26: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(0),
      I1 => \int_cnt_int_reg_n_0_[24]\,
      I2 => wint_int_i_6_0(1),
      I3 => \int_cnt_int_reg_n_0_[25]\,
      O => wint_int_i_26_n_0
    );
wint_int_i_27: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(4),
      I1 => \int_cnt_int_reg_n_0_[28]\,
      I2 => wint_int_i_6_0(3),
      I3 => \int_cnt_int_reg_n_0_[27]\,
      O => wint_int_i_27_n_0
    );
wint_int_i_28: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6FF6"
    )
        port map (
      I0 => wint_int_i_6_0(1),
      I1 => \int_cnt_int_reg_n_0_[9]\,
      I2 => wint_int_i_6_0(0),
      I3 => \int_cnt_int_reg_n_0_[8]\,
      O => wint_int_i_28_n_0
    );
wint_int_i_29: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFEF"
    )
        port map (
      I0 => \^q\(7),
      I1 => \^q\(6),
      I2 => wint_int_reg_4(0),
      I3 => \^q\(5),
      I4 => \^q\(4),
      O => wint_int_i_29_n_0
    );
wint_int_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF0100"
    )
        port map (
      I0 => wint_int_i_6_n_0,
      I1 => wint_int_i_7_n_0,
      I2 => wint_int_i_8_n_0,
      I3 => wint_int_i_9_n_0,
      I4 => wint_int_i_10_n_0,
      O => wint_int_i_3_n_0
    );
wint_int_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AE00"
    )
        port map (
      I0 => wint_int_i_11_n_0,
      I1 => wint_int_i_12_n_0,
      I2 => wint_int_i_13_n_0,
      I3 => dis_wdt_int_i_2_n_0,
      I4 => wint_int_reg_4(1),
      O => wint_int_i_4_n_0
    );
wint_int_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I1 => \^dis_wdt_cnt\,
      I2 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      I3 => \FSM_sequential_WDT_Current_State_reg[0]_1\(1),
      O => wint_int_i_5_n_0
    );
wint_int_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFEF"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[8]\,
      I1 => \int_cnt_int_reg_n_0_[9]\,
      I2 => wint_int_reg_4(1),
      I3 => wint_int_reg_4(0),
      I4 => wint_int_i_14_n_0,
      I5 => wint_int_i_15_n_0,
      O => wint_int_i_6_n_0
    );
wint_int_i_7: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[27]\,
      I1 => \int_cnt_int_reg_n_0_[29]\,
      I2 => \int_cnt_int_reg_n_0_[25]\,
      I3 => \int_cnt_int_reg_n_0_[31]\,
      I4 => wint_int_i_16_n_0,
      O => wint_int_i_7_n_0
    );
wint_int_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[15]\,
      I1 => \int_cnt_int_reg_n_0_[14]\,
      I2 => \int_cnt_int_reg_n_0_[13]\,
      I3 => \int_cnt_int_reg_n_0_[12]\,
      I4 => \int_cnt_int_reg_n_0_[10]\,
      I5 => \int_cnt_int_reg_n_0_[11]\,
      O => wint_int_i_8_n_0
    );
wint_int_i_9: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000009009"
    )
        port map (
      I0 => \int_cnt_int_reg_n_0_[21]\,
      I1 => wint_int_i_6_0(5),
      I2 => \int_cnt_int_reg_n_0_[18]\,
      I3 => wint_int_i_6_0(2),
      I4 => wint_int_i_17_n_0,
      I5 => wint_int_i_18_n_0,
      O => wint_int_i_9_n_0
    );
wint_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => wint_int_i_1_n_0,
      Q => \^wint_int\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt is
  port (
    \fail_cnt_int_reg[2]_0\ : out STD_LOGIC;
    FCV_reg : out STD_LOGIC_VECTOR ( 2 downto 0 );
    \FSM_sequential_WDT_Current_State_reg[0]\ : out STD_LOGIC;
    WDP_reg_reg : out STD_LOGIC;
    \LBE_reg_reg[1]\ : out STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]\ : out STD_LOGIC;
    WEN_reg_cleark : out STD_LOGIC;
    WEN_clear_reg_reg : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    \FSM_sequential_WDT_Current_State_reg[1]_0\ : out STD_LOGIC;
    PSME_reg_reg : out STD_LOGIC;
    \fail_cnt_int_reg[0]_0\ : out STD_LOGIC;
    \SW_reg_reg[31]\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PSME_reg_reg_0 : out STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[0]_0\ : out STD_LOGIC;
    WCFG_reg_In_reg : out STD_LOGIC;
    WEN_clear_reg_reg_0 : out STD_LOGIC;
    \SW_reg_reg[25]\ : out STD_LOGIC;
    SSTE_reg_reg : out STD_LOGIC;
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    fc_sst_enc : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_aclk : in STD_LOGIC;
    CO : in STD_LOGIC_VECTOR ( 0 to 0 );
    PSME_reg : in STD_LOGIC;
    WEN_reg_reg : in STD_LOGIC;
    LBE_reg : in STD_LOGIC_VECTOR ( 0 to 0 );
    \LBE_reg_reg[1]_0\ : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 1 downto 0 );
    dis_wdt_cnt : in STD_LOGIC;
    LBE_reg0 : in STD_LOGIC;
    WEN_reg_reg_0 : in STD_LOGIC;
    WEN_reg_reg_1 : in STD_LOGIC;
    \int_cnt_int_reg[31]\ : in STD_LOGIC;
    \int_cnt_int_reg[31]_0\ : in STD_LOGIC;
    \int_cnt_int_reg[31]_1\ : in STD_LOGIC;
    dis_wdt_int_reg_0 : in STD_LOGIC;
    \int_cnt_int_reg[31]_2\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    minusOp : in STD_LOGIC_VECTOR ( 30 downto 0 );
    \int_cnt_int_reg[31]_3\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \int_cnt_int_reg[0]\ : in STD_LOGIC_VECTOR ( 0 to 0 );
    \int_cnt_int_reg[0]_0\ : in STD_LOGIC;
    WCFG_reg_In_reg_0 : in STD_LOGIC;
    WEN_change : in STD_LOGIC;
    p_11_in : in STD_LOGIC_VECTOR ( 0 to 0 );
    WCFG_reg_In_reg_1 : in STD_LOGIC;
    WCFG_reg_In : in STD_LOGIC;
    WCFG_reg_In_reg_2 : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    WCFG_reg_In_reg_3 : in STD_LOGIC;
    \int_cnt_int_reg[0]_1\ : in STD_LOGIC;
    \int_cnt_int_reg[0]_2\ : in STD_LOGIC;
    \int_cnt_int_reg[0]_3\ : in STD_LOGIC;
    \int_cnt_int_reg[0]_4\ : in STD_LOGIC;
    \int_cnt_int_reg[0]_5\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_1\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_2\ : in STD_LOGIC;
    \int_cnt_int[31]_i_4_0\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_3\ : in STD_LOGIC;
    \FSM_sequential_WDT_Current_State_reg[1]_4\ : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR ( 0 to 0 );
    wdt_state_vec : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt : entity is "window_wdt_fail_cnt";
end mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt is
  signal \^fcv_reg\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal \^fsm_sequential_wdt_current_state_reg[0]\ : STD_LOGIC;
  signal \^fsm_sequential_wdt_current_state_reg[1]\ : STD_LOGIC;
  signal \^fsm_sequential_wdt_current_state_reg[1]_0\ : STD_LOGIC;
  signal \^psme_reg_reg\ : STD_LOGIC;
  signal \^psme_reg_reg_0\ : STD_LOGIC;
  signal \^wdp_reg_reg\ : STD_LOGIC;
  signal \^wen_clear_reg_reg\ : STD_LOGIC;
  signal \^wen_clear_reg_reg_0\ : STD_LOGIC;
  signal WEN_reg_i_2_n_0 : STD_LOGIC;
  signal WEN_reg_i_3_n_0 : STD_LOGIC;
  signal dis_wdt_int : STD_LOGIC;
  signal \dis_wdt_int_i_1__0_n_0\ : STD_LOGIC;
  signal \dis_wdt_int_i_2__0_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[0]_i_1_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[0]_i_2_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[1]_i_1_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[2]_i_1_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[2]_i_2_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[2]_i_3_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[2]_i_4_n_0\ : STD_LOGIC;
  signal \fail_cnt_int[2]_i_5_n_0\ : STD_LOGIC;
  signal \^fail_cnt_int_reg[0]_0\ : STD_LOGIC;
  signal \^fail_cnt_int_reg[2]_0\ : STD_LOGIC;
  signal fc_en_d : STD_LOGIC;
  signal \int_cnt_int[31]_i_11_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_3_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_4_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_5_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_6_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_7_n_0\ : STD_LOGIC;
  signal \int_cnt_int[31]_i_9_n_0\ : STD_LOGIC;
  signal \int_cnt_int[7]_i_2_n_0\ : STD_LOGIC;
  signal \int_cnt_int[7]_i_3_n_0\ : STD_LOGIC;
  signal wdt_reset_reg_i_11_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_16\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \FSM_sequential_WDT_Current_State[1]_i_6\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of WEN_reg_i_4 : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \dis_wdt_int_i_2__0\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \fail_cnt_int[0]_i_2\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \fail_cnt_int[2]_i_4\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \fail_cnt_int[2]_i_5\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \fail_cnt_int[2]_i_6\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \int_cnt_int[7]_i_4\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of wdt_reset_reg_i_11 : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of wdt_reset_reg_i_5 : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of wdt_reset_reg_i_9 : label is "soft_lutpair34";
begin
  FCV_reg(2 downto 0) <= \^fcv_reg\(2 downto 0);
  \FSM_sequential_WDT_Current_State_reg[0]\ <= \^fsm_sequential_wdt_current_state_reg[0]\;
  \FSM_sequential_WDT_Current_State_reg[1]\ <= \^fsm_sequential_wdt_current_state_reg[1]\;
  \FSM_sequential_WDT_Current_State_reg[1]_0\ <= \^fsm_sequential_wdt_current_state_reg[1]_0\;
  PSME_reg_reg <= \^psme_reg_reg\;
  PSME_reg_reg_0 <= \^psme_reg_reg_0\;
  WDP_reg_reg <= \^wdp_reg_reg\;
  WEN_clear_reg_reg <= \^wen_clear_reg_reg\;
  WEN_clear_reg_reg_0 <= \^wen_clear_reg_reg_0\;
  \fail_cnt_int_reg[0]_0\ <= \^fail_cnt_int_reg[0]_0\;
  \fail_cnt_int_reg[2]_0\ <= \^fail_cnt_int_reg[2]_0\;
\FSM_sequential_WDT_Current_State[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFDFDFDFDFDFDFDF"
    )
        port map (
      I0 => Q(1),
      I1 => dis_wdt_int,
      I2 => fc_sst_enc(0),
      I3 => \^fcv_reg\(1),
      I4 => \^fcv_reg\(2),
      I5 => \^fcv_reg\(0),
      O => \^fsm_sequential_wdt_current_state_reg[1]_0\
    );
\FSM_sequential_WDT_Current_State[1]_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFB"
    )
        port map (
      I0 => WCFG_reg_In_reg_0,
      I1 => WEN_change,
      I2 => p_11_in(0),
      I3 => WCFG_reg_In_reg_1,
      I4 => \^fail_cnt_int_reg[2]_0\,
      O => \^wen_clear_reg_reg\
    );
\FSM_sequential_WDT_Current_State[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFF0100"
    )
        port map (
      I0 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      I1 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I2 => \FSM_sequential_WDT_Current_State_reg[1]_3\,
      I3 => \FSM_sequential_WDT_Current_State_reg[1]_4\,
      I4 => WEN_reg_i_2_n_0,
      I5 => WCFG_reg_In_reg_2,
      O => \SW_reg_reg[25]\
    );
\FSM_sequential_WDT_Current_State[1]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => \^psme_reg_reg\,
      I1 => Q(0),
      I2 => Q(1),
      I3 => \^psme_reg_reg_0\,
      O => \FSM_sequential_WDT_Current_State_reg[0]_0\
    );
\LBE_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BBBBB3BB"
    )
        port map (
      I0 => LBE_reg(0),
      I1 => \^fsm_sequential_wdt_current_state_reg[1]\,
      I2 => \LBE_reg_reg[1]_0\,
      I3 => Q(0),
      I4 => dis_wdt_cnt,
      I5 => LBE_reg0,
      O => \LBE_reg_reg[1]\
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => Q(0),
      I1 => Q(1),
      O => \^fsm_sequential_wdt_current_state_reg[0]\
    );
WCFG_reg_In_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000A20000"
    )
        port map (
      I0 => \^wen_clear_reg_reg_0\,
      I1 => WEN_reg_i_2_n_0,
      I2 => WCFG_reg_In,
      I3 => WCFG_reg_In_reg_2,
      I4 => s_axi_aresetn,
      I5 => WCFG_reg_In_reg_3,
      O => WCFG_reg_In_reg
    );
WCFG_reg_In_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAAE"
    )
        port map (
      I0 => WEN_reg_i_2_n_0,
      I1 => \FSM_sequential_WDT_Current_State_reg[1]_4\,
      I2 => \FSM_sequential_WDT_Current_State_reg[1]_3\,
      I3 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I4 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      O => \^wen_clear_reg_reg_0\
    );
WEN_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF00F1F0F1"
    )
        port map (
      I0 => WEN_reg_reg_0,
      I1 => WEN_reg_i_2_n_0,
      I2 => Q(0),
      I3 => Q(1),
      I4 => dis_wdt_cnt,
      I5 => WEN_reg_i_3_n_0,
      O => WEN_reg_cleark
    );
WEN_reg_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1515155515151515"
    )
        port map (
      I0 => WCFG_reg_In_reg_0,
      I1 => D(0),
      I2 => wdt_state_vec(0),
      I3 => WCFG_reg_In_reg_1,
      I4 => p_11_in(0),
      I5 => \^fail_cnt_int_reg[2]_0\,
      O => WEN_reg_i_2_n_0
    );
WEN_reg_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5454555455555555"
    )
        port map (
      I0 => \int_cnt_int[31]_i_7_n_0\,
      I1 => WEN_reg_reg,
      I2 => WEN_reg_reg_1,
      I3 => PSME_reg,
      I4 => CO(0),
      I5 => \^wen_clear_reg_reg\,
      O => WEN_reg_i_3_n_0
    );
WEN_reg_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => \^fcv_reg\(2),
      I1 => \^fcv_reg\(1),
      I2 => \^fcv_reg\(0),
      I3 => fc_sst_enc(0),
      O => \^fail_cnt_int_reg[2]_0\
    );
\dis_wdt_int_i_1__0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0E00FFFF0000FFFF"
    )
        port map (
      I0 => \^fsm_sequential_wdt_current_state_reg[0]\,
      I1 => \dis_wdt_int_i_2__0_n_0\,
      I2 => \fail_cnt_int[2]_i_3_n_0\,
      I3 => fc_en_d,
      I4 => fc_sst_enc(0),
      I5 => dis_wdt_int,
      O => \dis_wdt_int_i_1__0_n_0\
    );
\dis_wdt_int_i_2__0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"DDDCCCCC"
    )
        port map (
      I0 => \^wdp_reg_reg\,
      I1 => \fail_cnt_int[2]_i_5_n_0\,
      I2 => \^fcv_reg\(2),
      I3 => \^fcv_reg\(1),
      I4 => fc_sst_enc(0),
      O => \dis_wdt_int_i_2__0_n_0\
    );
dis_wdt_int_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \dis_wdt_int_i_1__0_n_0\,
      Q => dis_wdt_int,
      R => SR(0)
    );
\fail_cnt_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03FFFFFFF8000000"
    )
        port map (
      I0 => \fail_cnt_int[0]_i_2_n_0\,
      I1 => \fail_cnt_int[2]_i_2_n_0\,
      I2 => \fail_cnt_int[2]_i_3_n_0\,
      I3 => fc_en_d,
      I4 => fc_sst_enc(0),
      I5 => \^fcv_reg\(0),
      O => \fail_cnt_int[0]_i_1_n_0\
    );
\fail_cnt_int[0]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^fcv_reg\(2),
      I1 => \^fcv_reg\(1),
      O => \fail_cnt_int[0]_i_2_n_0\
    );
\fail_cnt_int[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF33CF0000CC20"
    )
        port map (
      I0 => \^fcv_reg\(2),
      I1 => \^fcv_reg\(0),
      I2 => \fail_cnt_int[2]_i_2_n_0\,
      I3 => \fail_cnt_int[2]_i_3_n_0\,
      I4 => \fail_cnt_int[2]_i_4_n_0\,
      I5 => \^fcv_reg\(1),
      O => \fail_cnt_int[1]_i_1_n_0\
    );
\fail_cnt_int[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFEF00008800"
    )
        port map (
      I0 => \^fcv_reg\(0),
      I1 => \^fcv_reg\(1),
      I2 => \fail_cnt_int[2]_i_2_n_0\,
      I3 => \fail_cnt_int[2]_i_3_n_0\,
      I4 => \fail_cnt_int[2]_i_4_n_0\,
      I5 => \^fcv_reg\(2),
      O => \fail_cnt_int[2]_i_1_n_0\
    );
\fail_cnt_int[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00550015"
    )
        port map (
      I0 => \^fsm_sequential_wdt_current_state_reg[0]\,
      I1 => fc_sst_enc(0),
      I2 => \fail_cnt_int[0]_i_2_n_0\,
      I3 => \fail_cnt_int[2]_i_5_n_0\,
      I4 => \^wdp_reg_reg\,
      O => \fail_cnt_int[2]_i_2_n_0\
    );
\fail_cnt_int[2]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"888A8888"
    )
        port map (
      I0 => \^fail_cnt_int_reg[0]_0\,
      I1 => dis_wdt_int_reg_0,
      I2 => \int_cnt_int[31]_i_7_n_0\,
      I3 => \^psme_reg_reg\,
      I4 => \int_cnt_int_reg[31]\,
      O => \fail_cnt_int[2]_i_3_n_0\
    );
\fail_cnt_int[2]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => fc_sst_enc(0),
      I1 => fc_en_d,
      O => \fail_cnt_int[2]_i_4_n_0\
    );
\fail_cnt_int[2]_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"4F"
    )
        port map (
      I0 => CO(0),
      I1 => PSME_reg,
      I2 => WEN_reg_reg,
      O => \fail_cnt_int[2]_i_5_n_0\
    );
\fail_cnt_int[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => WCFG_reg_In_reg_1,
      I1 => p_11_in(0),
      I2 => WEN_change,
      I3 => WCFG_reg_In_reg_0,
      O => \^wdp_reg_reg\
    );
\fail_cnt_int_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \fail_cnt_int[0]_i_1_n_0\,
      Q => \^fcv_reg\(0),
      S => SR(0)
    );
\fail_cnt_int_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \fail_cnt_int[1]_i_1_n_0\,
      Q => \^fcv_reg\(1),
      R => SR(0)
    );
\fail_cnt_int_reg[2]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \fail_cnt_int[2]_i_1_n_0\,
      Q => \^fcv_reg\(2),
      S => SR(0)
    );
fc_en_d_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => fc_sst_enc(0),
      Q => fc_en_d,
      R => SR(0)
    );
\int_cnt_int[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(0),
      I2 => \int_cnt_int[31]_i_4_n_0\,
      I3 => \int_cnt_int_reg[0]\(0),
      I4 => \int_cnt_int_reg[31]_3\(0),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(0)
    );
\int_cnt_int[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(10),
      I2 => minusOp(9),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(10),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(10)
    );
\int_cnt_int[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(11),
      I2 => minusOp(10),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(11),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(11)
    );
\int_cnt_int[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(12),
      I2 => minusOp(11),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(12),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(12)
    );
\int_cnt_int[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(13),
      I2 => minusOp(12),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(13),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(13)
    );
\int_cnt_int[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(14),
      I2 => minusOp(13),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(14),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(14)
    );
\int_cnt_int[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(15),
      I2 => minusOp(14),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(15),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(15)
    );
\int_cnt_int[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(16),
      I2 => minusOp(15),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(16),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(16)
    );
\int_cnt_int[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(17),
      I2 => minusOp(16),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(17),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(17)
    );
\int_cnt_int[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(18),
      I2 => minusOp(17),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(18),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(18)
    );
\int_cnt_int[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(19),
      I2 => minusOp(18),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(19),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(19)
    );
\int_cnt_int[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(1),
      I2 => minusOp(0),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(1),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(1)
    );
\int_cnt_int[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(20),
      I2 => minusOp(19),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(20),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(20)
    );
\int_cnt_int[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(21),
      I2 => minusOp(20),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(21),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(21)
    );
\int_cnt_int[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(22),
      I2 => minusOp(21),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(22),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(22)
    );
\int_cnt_int[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(23),
      I2 => minusOp(22),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(23),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(23)
    );
\int_cnt_int[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(24),
      I2 => minusOp(23),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(24),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(24)
    );
\int_cnt_int[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(25),
      I2 => minusOp(24),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(25),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(25)
    );
\int_cnt_int[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(26),
      I2 => minusOp(25),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(26),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(26)
    );
\int_cnt_int[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(27),
      I2 => minusOp(26),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(27),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(27)
    );
\int_cnt_int[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(28),
      I2 => minusOp(27),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(28),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(28)
    );
\int_cnt_int[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(29),
      I2 => minusOp(28),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(29),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(29)
    );
\int_cnt_int[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(2),
      I2 => minusOp(1),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(2),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(2)
    );
\int_cnt_int[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(30),
      I2 => minusOp(29),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(30),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(30)
    );
\int_cnt_int[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"7"
    )
        port map (
      I0 => \int_cnt_int[31]_i_3_n_0\,
      I1 => \int_cnt_int[31]_i_4_n_0\,
      O => E(0)
    );
\int_cnt_int[31]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AA8A8A8A8A8A8A8A"
    )
        port map (
      I0 => fc_sst_enc(1),
      I1 => dis_wdt_int,
      I2 => fc_sst_enc(0),
      I3 => \^fcv_reg\(1),
      I4 => \^fcv_reg\(2),
      I5 => \^fcv_reg\(0),
      O => \int_cnt_int[31]_i_11_n_0\
    );
\int_cnt_int[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(31),
      I2 => minusOp(30),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(31),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(31)
    );
\int_cnt_int[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0F0F0F0F0E0E0E00"
    )
        port map (
      I0 => \int_cnt_int[31]_i_7_n_0\,
      I1 => \int_cnt_int_reg[31]\,
      I2 => \int_cnt_int_reg[31]_0\,
      I3 => \^fsm_sequential_wdt_current_state_reg[1]_0\,
      I4 => \int_cnt_int_reg[31]_1\,
      I5 => \^psme_reg_reg\,
      O => \int_cnt_int[31]_i_3_n_0\
    );
\int_cnt_int[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000AAA2AAAAAAAA"
    )
        port map (
      I0 => \int_cnt_int[31]_i_9_n_0\,
      I1 => \int_cnt_int_reg[31]\,
      I2 => \^psme_reg_reg\,
      I3 => \int_cnt_int[31]_i_7_n_0\,
      I4 => \int_cnt_int_reg[0]_0\,
      I5 => \int_cnt_int[31]_i_11_n_0\,
      O => \int_cnt_int[31]_i_4_n_0\
    );
\int_cnt_int[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAFFFFFEFFFEFF"
    )
        port map (
      I0 => Q(1),
      I1 => \^wen_clear_reg_reg_0\,
      I2 => WEN_reg_reg_0,
      I3 => \int_cnt_int_reg[0]_5\,
      I4 => dis_wdt_cnt,
      I5 => Q(0),
      O => \int_cnt_int[31]_i_5_n_0\
    );
\int_cnt_int[31]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EEFEFFFFEEFEEEFE"
    )
        port map (
      I0 => WCFG_reg_In_reg_2,
      I1 => WEN_reg_i_2_n_0,
      I2 => \int_cnt_int_reg[0]_1\,
      I3 => \int_cnt_int_reg[0]_2\,
      I4 => \int_cnt_int_reg[0]_3\,
      I5 => \int_cnt_int_reg[0]_4\,
      O => \int_cnt_int[31]_i_6_n_0\
    );
\int_cnt_int[31]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF44040000"
    )
        port map (
      I0 => \^wdp_reg_reg\,
      I1 => WEN_reg_reg,
      I2 => PSME_reg,
      I3 => CO(0),
      I4 => wdt_reset_reg_i_11_n_0,
      I5 => \^fsm_sequential_wdt_current_state_reg[0]\,
      O => \int_cnt_int[31]_i_7_n_0\
    );
\int_cnt_int[31]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000EEEEEEFE"
    )
        port map (
      I0 => WCFG_reg_In_reg_2,
      I1 => WEN_reg_i_2_n_0,
      I2 => \int_cnt_int_reg[0]_1\,
      I3 => \FSM_sequential_WDT_Current_State_reg[1]_1\,
      I4 => \FSM_sequential_WDT_Current_State_reg[1]_2\,
      I5 => \int_cnt_int[31]_i_4_0\,
      O => \int_cnt_int[31]_i_9_n_0\
    );
\int_cnt_int[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(3),
      I2 => minusOp(2),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(3),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(3)
    );
\int_cnt_int[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(4),
      I2 => minusOp(3),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(4),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(4)
    );
\int_cnt_int[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(5),
      I2 => minusOp(4),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(5),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(5)
    );
\int_cnt_int[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(6),
      I2 => minusOp(5),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(6),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(6)
    );
\int_cnt_int[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFBABABA"
    )
        port map (
      I0 => \int_cnt_int[7]_i_2_n_0\,
      I1 => \int_cnt_int[31]_i_5_n_0\,
      I2 => \int_cnt_int_reg[31]_2\(7),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => minusOp(6),
      I5 => \int_cnt_int[7]_i_3_n_0\,
      O => \SW_reg_reg[31]\(7)
    );
\int_cnt_int[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1000FFFF10001000"
    )
        port map (
      I0 => \int_cnt_int[31]_i_7_n_0\,
      I1 => \^psme_reg_reg\,
      I2 => \int_cnt_int_reg[31]\,
      I3 => \int_cnt_int[31]_i_11_n_0\,
      I4 => \int_cnt_int[31]_i_6_n_0\,
      I5 => \int_cnt_int_reg[31]_3\(7),
      O => \int_cnt_int[7]_i_2_n_0\
    );
\int_cnt_int[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000040000"
    )
        port map (
      I0 => \^fail_cnt_int_reg[0]_0\,
      I1 => fc_sst_enc(1),
      I2 => Q(1),
      I3 => WEN_reg_reg_1,
      I4 => Q(0),
      I5 => dis_wdt_cnt,
      O => \int_cnt_int[7]_i_3_n_0\
    );
\int_cnt_int[7]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F00"
    )
        port map (
      I0 => \^fcv_reg\(0),
      I1 => \^fcv_reg\(2),
      I2 => \^fcv_reg\(1),
      I3 => fc_sst_enc(0),
      I4 => dis_wdt_int,
      O => \^fail_cnt_int_reg[0]_0\
    );
\int_cnt_int[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(8),
      I2 => minusOp(7),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(8),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(8)
    );
\int_cnt_int[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \int_cnt_int[31]_i_5_n_0\,
      I1 => \int_cnt_int_reg[31]_2\(9),
      I2 => minusOp(8),
      I3 => \int_cnt_int[31]_i_4_n_0\,
      I4 => \int_cnt_int_reg[31]_3\(9),
      I5 => \int_cnt_int[31]_i_6_n_0\,
      O => \SW_reg_reg[31]\(9)
    );
wdt_reset_reg_i_11: unisim.vcomponents.LUT4
    generic map(
      INIT => X"10FF"
    )
        port map (
      I0 => \^fcv_reg\(2),
      I1 => \^fcv_reg\(1),
      I2 => \^fcv_reg\(0),
      I3 => fc_sst_enc(0),
      O => wdt_reset_reg_i_11_n_0
    );
wdt_reset_reg_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AABABABABABABABA"
    )
        port map (
      I0 => fc_sst_enc(1),
      I1 => dis_wdt_int,
      I2 => fc_sst_enc(0),
      I3 => \^fcv_reg\(1),
      I4 => \^fcv_reg\(2),
      I5 => \^fcv_reg\(0),
      O => SSTE_reg_reg
    );
wdt_reset_reg_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFBFFFF"
    )
        port map (
      I0 => \^psme_reg_reg_0\,
      I1 => Q(1),
      I2 => Q(0),
      I3 => \^psme_reg_reg\,
      I4 => \int_cnt_int_reg[31]\,
      O => \^fsm_sequential_wdt_current_state_reg[1]\
    );
wdt_reset_reg_i_8: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00008A00"
    )
        port map (
      I0 => wdt_reset_reg_i_11_n_0,
      I1 => CO(0),
      I2 => PSME_reg,
      I3 => WEN_reg_reg,
      I4 => \^wdp_reg_reg\,
      O => \^psme_reg_reg_0\
    );
wdt_reset_reg_i_9: unisim.vcomponents.LUT5
    generic map(
      INIT => X"51515100"
    )
        port map (
      I0 => WEN_reg_reg_1,
      I1 => PSME_reg,
      I2 => CO(0),
      I3 => \^fail_cnt_int_reg[2]_0\,
      I4 => WEN_reg_reg,
      O => \^psme_reg_reg\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_address_decoder is
  port (
    bus2ip_cs : out STD_LOGIC_VECTOR ( 0 to 0 );
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    is_write_reg : out STD_LOGIC;
    ip2bus_rdack_reg : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 0 to 0 );
    \state_reg[0]\ : out STD_LOGIC;
    s_axi_wdata_0_sp_1 : out STD_LOGIC;
    WEN_clear_reg_reg : out STD_LOGIC;
    \TSR1_reg_reg[31]\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    \FSM_onehot_state_reg[2]\ : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ip2bus_rdack_i : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    WEN_clear_reg0 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata_1_sp_1 : out STD_LOGIC;
    Bus_RNW_reg_reg_0 : out STD_LOGIC;
    Q : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    \state_reg[0]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \FSM_onehot_state_reg[3]\ : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_bvalid_i_reg : in STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_reg_d : in STD_LOGIC;
    WEN_reg : in STD_LOGIC;
    p_11_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_clear_reg_reg_0 : in STD_LOGIC;
    WCFG_reg_In : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[15]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[8]\ : in STD_LOGIC;
    \FSM_onehot_state_reg[3]_0\ : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : in STD_LOGIC;
    ip2bus_rdack : in STD_LOGIC;
    s_axi_arready : in STD_LOGIC;
    s_axi_arready_0 : in STD_LOGIC_VECTOR ( 5 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[5]\ : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[0]\ : in STD_LOGIC;
    fc_sst_enc : in STD_LOGIC_VECTOR ( 1 downto 0 );
    PSME_reg : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wdt_interrupt : in STD_LOGIC;
    wdt_reset_pending : in STD_LOGIC;
    FCV_reg : in STD_LOGIC_VECTOR ( 2 downto 0 );
    LBE_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aen_trig : in STD_LOGIC;
    Bus_RNW_reg_reg_1 : in STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\ : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_address_decoder : entity is "address_decoder";
end mbv_system_axi_timebase_wdt_0_0_address_decoder;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_address_decoder is
  signal Bus_RNW_reg : STD_LOGIC;
  signal Bus_RNW_reg_i_1_n_0 : STD_LOGIC;
  signal \^e\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\ : STD_LOGIC;
  signal \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\ : STD_LOGIC;
  signal \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0\ : STD_LOGIC;
  signal WEN_clear_reg_i_2_n_0 : STD_LOGIC;
  signal \^bus2ip_cs\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal ce_expnd_i_0 : STD_LOGIC;
  signal ce_expnd_i_1 : STD_LOGIC;
  signal ce_expnd_i_10 : STD_LOGIC;
  signal ce_expnd_i_2 : STD_LOGIC;
  signal ce_expnd_i_3 : STD_LOGIC;
  signal ce_expnd_i_4 : STD_LOGIC;
  signal ce_expnd_i_5 : STD_LOGIC;
  signal ce_expnd_i_6 : STD_LOGIC;
  signal ce_expnd_i_7 : STD_LOGIC;
  signal ce_expnd_i_8 : STD_LOGIC;
  signal ce_expnd_i_9 : STD_LOGIC;
  signal cs_ce_clr : STD_LOGIC;
  signal ip2bus_rdack_i_2_n_0 : STD_LOGIC;
  signal \^ip2bus_rdack_reg\ : STD_LOGIC;
  signal \^is_write_reg\ : STD_LOGIC;
  signal s_axi_arready_INST_0_i_1_n_0 : STD_LOGIC;
  signal s_axi_wdata_0_sn_1 : STD_LOGIC;
  signal s_axi_wdata_1_sn_1 : STD_LOGIC;
  signal s_axi_wready_INST_0_i_1_n_0 : STD_LOGIC;
  signal s_axi_wready_INST_0_i_2_n_0 : STD_LOGIC;
  signal s_axi_wready_INST_0_i_3_n_0 : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \FW_reg[31]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \LBE_clear_reg[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[0]_i_3\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[10]_i_3\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[11]_i_3\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[15]_i_2\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[15]_i_4\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[25]_i_4\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[25]_i_5\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[31]_i_3\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[31]_i_4\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[31]_i_5\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[31]_i_8\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[31]_i_9\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[5]_i_5\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[8]_i_2\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[8]_i_5\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[9]_i_3\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \SW_reg[31]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \TSR0_reg[31]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \TSR1_reg[31]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of WDP_reg_i_1 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of WEN_change_i_1 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of WEN_clear_reg_i_2 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of ip2bus_rdack_i_2 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of s_axi_wready_INST_0_i_2 : label is "soft_lutpair8";
begin
  E(0) <= \^e\(0);
  bus2ip_cs(0) <= \^bus2ip_cs\(0);
  ip2bus_rdack_reg <= \^ip2bus_rdack_reg\;
  is_write_reg <= \^is_write_reg\;
  s_axi_wdata_0_sp_1 <= s_axi_wdata_0_sn_1;
  s_axi_wdata_1_sp_1 <= s_axi_wdata_1_sn_1;
Bus_RNW_reg_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => Bus_RNW_reg_reg_1,
      I1 => Q,
      I2 => Bus_RNW_reg,
      O => Bus_RNW_reg_i_1_n_0
    );
Bus_RNW_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => Bus_RNW_reg_i_1_n_0,
      Q => Bus_RNW_reg,
      R => '0'
    );
\FSM_onehot_state[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4000FFFF40004000"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \FSM_onehot_state_reg[3]_0\(0),
      I2 => s_axi_wvalid,
      I3 => s_axi_awvalid,
      I4 => \^is_write_reg\,
      I5 => \FSM_onehot_state_reg[3]_0\(2),
      O => \FSM_onehot_state_reg[2]\(0)
    );
\FSM_onehot_state[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F888F888FFFFF888"
    )
        port map (
      I0 => \^is_write_reg\,
      I1 => \FSM_onehot_state_reg[3]_0\(2),
      I2 => \FSM_onehot_state_reg[3]_0\(1),
      I3 => \^ip2bus_rdack_reg\,
      I4 => \FSM_onehot_state_reg[3]_0\(3),
      I5 => \FSM_onehot_state_reg[3]\,
      O => \FSM_onehot_state_reg[2]\(1)
    );
\FW_reg[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => p_11_in(0),
      I3 => WEN_reg,
      O => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0\(0)
    );
\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_2,
      Q => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_1,
      Q => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[12].ce_out_i[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FB"
    )
        port map (
      I0 => \^is_write_reg\,
      I1 => s_axi_aresetn,
      I2 => \^ip2bus_rdack_reg\,
      O => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_0,
      Q => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_10,
      Q => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[3].ce_out_i[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(2),
      I2 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(0),
      I3 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(1),
      O => ce_expnd_i_9
    );
\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_9,
      Q => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_8,
      Q => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_7,
      Q => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_6,
      Q => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_5,
      Q => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_4,
      Q => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      R => cs_ce_clr
    );
\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => Q,
      D => ce_expnd_i_3,
      Q => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      R => cs_ce_clr
    );
\LBE_clear_reg[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => p_11_in(0),
      I2 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      O => Bus_RNW_reg_reg_0
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[10].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9\
     port map (
      \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_2 => ce_expnd_i_2
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[11].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10\
     port map (
      \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_1 => ce_expnd_i_1
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[12].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11\
     port map (
      \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_0 => ce_expnd_i_0
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[2].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1\
     port map (
      \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_10 => ce_expnd_i_10
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[4].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3\
     port map (
      \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_8 => ce_expnd_i_8
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[5].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4\
     port map (
      \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_7 => ce_expnd_i_7
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[6].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5\
     port map (
      \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_6 => ce_expnd_i_6
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[7].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6\
     port map (
      \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_5 => ce_expnd_i_5
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[8].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7\
     port map (
      \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_4 => ce_expnd_i_4
    );
\MEM_DECODE_GEN[0].PER_CE_GEN[9].MULTIPLE_CES_THIS_CS_GEN.CE_I\: entity work.\mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8\
     port map (
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(3 downto 0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3 downto 0),
      ce_expnd_i_3 => ce_expnd_i_3
    );
\MEM_DECODE_GEN[0].cs_out_i[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04040400"
    )
        port map (
      I0 => \^is_write_reg\,
      I1 => s_axi_aresetn,
      I2 => \^ip2bus_rdack_reg\,
      I3 => \^bus2ip_cs\(0),
      I4 => Q,
      O => \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\
    );
\MEM_DECODE_GEN[0].cs_out_i_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0\,
      Q => \^bus2ip_cs\(0),
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFC4440444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[0]\,
      I5 => \STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(0)
    );
\STATUS_I0_WDT.ip2bus_data[0]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000DD0D"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(0),
      I1 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(0),
      I3 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8C808080"
    )
        port map (
      I0 => p_11_in(0),
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I3 => WEN_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[0]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F444F444FFFFF444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(0),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(0),
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(0),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(10),
      I2 => \STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(10),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(10)
    );
\STATUS_I0_WDT.ip2bus_data[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(10),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(10),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[10]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(2),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(11),
      I2 => \STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(11),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(11)
    );
\STATUS_I0_WDT.ip2bus_data[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(11),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(11),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[11]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(3),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(12),
      I2 => \STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(12),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(12)
    );
\STATUS_I0_WDT.ip2bus_data[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(12),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(12),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[12]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(4),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(13),
      I2 => \STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(13),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(13)
    );
\STATUS_I0_WDT.ip2bus_data[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(13),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(13),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[13]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(5),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(14),
      I2 => \STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(14),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(14)
    );
\STATUS_I0_WDT.ip2bus_data[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(14),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(14),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[14]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(6),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(15),
      I2 => \STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(15),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0\,
      O => \TSR1_reg_reg[31]\(15)
    );
\STATUS_I0_WDT.ip2bus_data[15]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      O => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[15]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(15),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(15),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[15]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FEFFFFFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      O => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[15]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(7),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(16),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => wdt_interrupt,
      O => \TSR1_reg_reg[31]\(16)
    );
\STATUS_I0_WDT.ip2bus_data[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(16),
      I2 => \STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(16),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(16),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => wdt_interrupt,
      O => \STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(17),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => wdt_reset_pending,
      O => \TSR1_reg_reg[31]\(17)
    );
\STATUS_I0_WDT.ip2bus_data[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(17),
      I2 => \STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(17),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(17),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => wdt_reset_pending,
      O => \STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(18),
      I2 => \STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(18),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(18)
    );
\STATUS_I0_WDT.ip2bus_data[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(18),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(18),
      O => \STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(19),
      I2 => \STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(19),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(19)
    );
\STATUS_I0_WDT.ip2bus_data[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F4000000440000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(19),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(19),
      O => \STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEAAAAAAAEAAAAA"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0\,
      I1 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I2 => WCFG_reg_In,
      I3 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => p_11_in(1),
      O => \TSR1_reg_reg[31]\(1)
    );
\STATUS_I0_WDT.ip2bus_data[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8A88AAAA8A888A88"
    )
        port map (
      I0 => ip2bus_rdack_i_2_n_0,
      I1 => \STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0\,
      I2 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(1),
      I4 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(1),
      O => \STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF44F444F444F4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(1),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(1),
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(1),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(20),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => FCV_reg(0),
      O => \TSR1_reg_reg[31]\(20)
    );
\STATUS_I0_WDT.ip2bus_data[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(20),
      I2 => \STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(20),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF40000040400000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(20),
      I3 => FCV_reg(0),
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(21),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => FCV_reg(1),
      O => \TSR1_reg_reg[31]\(21)
    );
\STATUS_I0_WDT.ip2bus_data[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(21),
      I2 => \STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(21),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(21),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => FCV_reg(1),
      O => \STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(22),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => FCV_reg(2),
      O => \TSR1_reg_reg[31]\(22)
    );
\STATUS_I0_WDT.ip2bus_data[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(22),
      I2 => \STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(22),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(22),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => FCV_reg(2),
      O => \STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(23),
      I2 => \STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(23),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(23)
    );
\STATUS_I0_WDT.ip2bus_data[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(23),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(23),
      O => \STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(24),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => LBE_reg(0),
      O => \TSR1_reg_reg[31]\(24)
    );
\STATUS_I0_WDT.ip2bus_data[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(24),
      I2 => \STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(24),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(24),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => LBE_reg(0),
      O => \STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAEAE00AE00"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(25),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      I5 => LBE_reg(1),
      O => \TSR1_reg_reg[31]\(25)
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F4F4F4F4F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(25),
      I2 => \STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(25),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFBF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I5 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFBF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[25]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF00400040004000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(25),
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => LBE_reg(1),
      O => \STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(26),
      I2 => \STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(26),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(26)
    );
\STATUS_I0_WDT.ip2bus_data[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F4000000440000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(26),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(26),
      O => \STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(27),
      I2 => \STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(27),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(27)
    );
\STATUS_I0_WDT.ip2bus_data[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00F4000000440000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(27),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(27),
      O => \STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(28),
      I2 => \STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(28),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(28)
    );
\STATUS_I0_WDT.ip2bus_data[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(28),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(28),
      O => \STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(29),
      I2 => \STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(29),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(29)
    );
\STATUS_I0_WDT.ip2bus_data[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(29),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(29),
      O => \STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAE00000000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(2),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I3 => fc_sst_enc(0),
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(2)
    );
\STATUS_I0_WDT.ip2bus_data[2]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(2),
      I2 => \STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(2),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(2),
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I3 => fc_sst_enc(0),
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(2),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(30),
      I2 => \STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(30),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(30)
    );
\STATUS_I0_WDT.ip2bus_data[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(30),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(30),
      O => \STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0\,
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \^e\(0)
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(31),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31),
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      O => \TSR1_reg_reg[31]\(31)
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CCC8"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"1F"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"EEEEEEEA"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F000000880000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31),
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I3 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I4 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31),
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFDFFFFFFFFFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[31]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      O => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAE00000000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(3),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I3 => PSME_reg,
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(3)
    );
\STATUS_I0_WDT.ip2bus_data[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEFFAEAE"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(3),
      I2 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(3),
      O => \STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(3),
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I3 => PSME_reg,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(3),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAE00000000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(4),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I3 => fc_sst_enc(1),
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(4)
    );
\STATUS_I0_WDT.ip2bus_data[4]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEFFAEAE"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(4),
      I2 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(4),
      O => \STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[4]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(4),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(4),
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => fc_sst_enc(1),
      O => \STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF4444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(5),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(5),
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[5]\,
      I4 => \^e\(0),
      I5 => \STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(5)
    );
\STATUS_I0_WDT.ip2bus_data[5]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F444F4FFFF44F4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(5),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(5),
      I3 => \STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(5),
      I5 => \STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFBFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      I4 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I5 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[5]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFDF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAE00000000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(6),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(0),
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(6)
    );
\STATUS_I0_WDT.ip2bus_data[6]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AEFFAEAE"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(6),
      I2 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(6),
      O => \STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[6]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(6),
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(0),
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(6),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AE00AEAE00000000"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[7]\(7),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1),
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(7)
    );
\STATUS_I0_WDT.ip2bus_data[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(7),
      I2 => \STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(7),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFF7FFFFFFFFFFFF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I3 => \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0\,
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1),
      I5 => \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(0),
      O => \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[7]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF444F444F444"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(7),
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1),
      I4 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(7),
      I5 => \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000FF0D0D"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(0),
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[8]\,
      I4 => \STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0\,
      O => \TSR1_reg_reg[31]\(8)
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0D0D000D"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(8),
      I1 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I2 => \STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(8),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      O => \STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[8]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(8),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(8),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000F4F4FFF4"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(9),
      I2 => \STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0\,
      I3 => \STATUS_I0_WDT.ip2bus_data_reg[31]\(9),
      I4 => \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0\,
      I5 => \STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0\,
      O => \TSR1_reg_reg[31]\(9)
    );
\STATUS_I0_WDT.ip2bus_data[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0000F0880000"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(9),
      I2 => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(9),
      I3 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I4 => Bus_RNW_reg,
      I5 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data[9]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F0F0F040"
    )
        port map (
      I0 => \STATUS_I0_WDT.ip2bus_data_reg[15]\(1),
      I1 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I2 => Bus_RNW_reg,
      I3 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I4 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => \STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0\
    );
\SW_reg[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => p_11_in(0),
      I3 => WEN_reg,
      O => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0\(0)
    );
\TSR0_reg[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I1 => p_11_in(0),
      I2 => Bus_RNW_reg,
      O => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0\(0)
    );
\TSR1_reg[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I1 => p_11_in(0),
      I2 => Bus_RNW_reg,
      O => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0\(0)
    );
WDP_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0020"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => Bus_RNW_reg,
      I2 => p_11_in(0),
      I3 => WEN_reg,
      O => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0\(0)
    );
WEN_change_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I1 => p_11_in(0),
      I2 => Bus_RNW_reg,
      O => WEN_clear_reg0
    );
WEN_clear_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000BA8A0000"
    )
        port map (
      I0 => WEN_clear_reg_reg_0,
      I1 => WEN_clear_reg_i_2_n_0,
      I2 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I3 => s_axi_wdata(0),
      I4 => s_axi_aresetn,
      I5 => WCFG_reg_In,
      O => WEN_clear_reg_reg
    );
WEN_clear_reg_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => Bus_RNW_reg,
      I1 => p_11_in(0),
      O => WEN_clear_reg_i_2_n_0
    );
aen_reg_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFEF0020"
    )
        port map (
      I0 => s_axi_wdata(1),
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I3 => aen_trig,
      I4 => p_11_in(1),
      O => s_axi_wdata_1_sn_1
    );
ip2bus_rdack_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFFFFFFF0FFF0FF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      I2 => \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0\,
      I3 => ip2bus_rdack_i_2_n_0,
      I4 => s_axi_wready_INST_0_i_3_n_0,
      I5 => Bus_RNW_reg,
      O => ip2bus_rdack_i
    );
ip2bus_rdack_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"01FF"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I3 => Bus_RNW_reg,
      O => ip2bus_rdack_i_2_n_0
    );
mwc_reg_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EF00EFEF20002020"
    )
        port map (
      I0 => s_axi_wdata(0),
      I1 => Bus_RNW_reg,
      I2 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      I3 => WEN_reg_d,
      I4 => WEN_reg,
      I5 => p_11_in(0),
      O => s_axi_wdata_0_sn_1
    );
s_axi_arready_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => ip2bus_rdack,
      I1 => s_axi_arready_INST_0_i_1_n_0,
      I2 => s_axi_arready,
      O => \^ip2bus_rdack_reg\
    );
s_axi_arready_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFB"
    )
        port map (
      I0 => s_axi_arready_0(4),
      I1 => s_axi_arready_0(5),
      I2 => s_axi_arready_0(3),
      I3 => s_axi_arready_0(2),
      I4 => s_axi_arready_0(0),
      I5 => s_axi_arready_0(1),
      O => s_axi_arready_INST_0_i_1_n_0
    );
s_axi_bvalid_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"20FF2020"
    )
        port map (
      I0 => \^is_write_reg\,
      I1 => \state_reg[0]_0\(0),
      I2 => \state_reg[0]_0\(1),
      I3 => s_axi_bready,
      I4 => s_axi_bvalid_i_reg,
      O => \state_reg[0]\
    );
s_axi_wready_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4F4F4F444F4F4F4F"
    )
        port map (
      I0 => s_axi_arready_INST_0_i_1_n_0,
      I1 => s_axi_awready,
      I2 => Bus_RNW_reg,
      I3 => s_axi_wready_INST_0_i_1_n_0,
      I4 => s_axi_wready_INST_0_i_2_n_0,
      I5 => s_axi_wready_INST_0_i_3_n_0,
      O => \^is_write_reg\
    );
s_axi_wready_INST_0_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg\,
      O => s_axi_wready_INST_0_i_1_n_0
    );
s_axi_wready_INST_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg\,
      I3 => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg\,
      O => s_axi_wready_INST_0_i_2_n_0
    );
s_axi_wready_INST_0_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg\,
      I1 => \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg\,
      I2 => \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg\,
      O => s_axi_wready_INST_0_i_3_n_0
    );
\state[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2FEF2CEC"
    )
        port map (
      I0 => \^is_write_reg\,
      I1 => \state_reg[0]_0\(0),
      I2 => \state_reg[0]_0\(1),
      I3 => \FSM_onehot_state_reg[3]\,
      I4 => s_axi_arvalid,
      O => D(0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_slave_attachment is
  port (
    s_axi_rresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    bus2ip_rnw_i_reg_0 : out STD_LOGIC;
    bus2ip_cs : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid_i_reg_0 : out STD_LOGIC;
    s_axi_bvalid_i_reg_0 : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    is_write_reg_0 : out STD_LOGIC;
    ip2bus_rdack_reg : out STD_LOGIC;
    s_axi_wdata_0_sp_1 : out STD_LOGIC;
    WEN_clear_reg_reg : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ip2bus_rdack_i : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    WEN_clear_reg0 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata_1_sp_1 : out STD_LOGIC;
    Bus_RNW_reg_reg : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    ip2bus_error : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_reg_d : in STD_LOGIC;
    WEN_reg : in STD_LOGIC;
    p_11_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_clear_reg_reg_0 : in STD_LOGIC;
    WCFG_reg_In : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[8]\ : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    ip2bus_rdack : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[31]\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[5]\ : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[0]\ : in STD_LOGIC;
    fc_sst_enc : in STD_LOGIC_VECTOR ( 1 downto 0 );
    PSME_reg : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rready : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wdt_interrupt : in STD_LOGIC;
    wdt_reset_pending : in STD_LOGIC;
    FCV_reg : in STD_LOGIC_VECTOR ( 2 downto 0 );
    LBE_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    aen_trig : in STD_LOGIC;
    \s_axi_rdata_i_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_slave_attachment : entity is "slave_attachment";
end mbv_system_axi_timebase_wdt_0_0_slave_attachment;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_slave_attachment is
  signal \FSM_onehot_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state[3]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[0]\ : STD_LOGIC;
  signal \FSM_onehot_state_reg_n_0_[3]\ : STD_LOGIC;
  signal \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\ : STD_LOGIC;
  signal \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal I_DECODER_n_4 : STD_LOGIC;
  signal I_DECODER_n_40 : STD_LOGIC;
  signal I_DECODER_n_41 : STD_LOGIC;
  signal I_DECODER_n_5 : STD_LOGIC;
  signal \bus2ip_addr_i[2]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[3]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[4]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[5]_i_1_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i[5]_i_2_n_0\ : STD_LOGIC;
  signal \bus2ip_addr_i_reg_n_0_[2]\ : STD_LOGIC;
  signal \bus2ip_addr_i_reg_n_0_[3]\ : STD_LOGIC;
  signal \bus2ip_addr_i_reg_n_0_[4]\ : STD_LOGIC;
  signal \bus2ip_addr_i_reg_n_0_[5]\ : STD_LOGIC;
  signal \^bus2ip_rnw_i_reg_0\ : STD_LOGIC;
  signal \^ip2bus_rdack_reg\ : STD_LOGIC;
  signal is_read_i_1_n_0 : STD_LOGIC;
  signal is_read_reg_n_0 : STD_LOGIC;
  signal is_write_i_1_n_0 : STD_LOGIC;
  signal is_write_i_2_n_0 : STD_LOGIC;
  signal is_write_reg_n_0 : STD_LOGIC;
  signal plusOp : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal rst : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s_axi_bresp_i : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \s_axi_bresp_i[1]_i_1_n_0\ : STD_LOGIC;
  signal \^s_axi_bvalid_i_reg_0\ : STD_LOGIC;
  signal s_axi_rresp_i : STD_LOGIC_VECTOR ( 0 to 0 );
  signal s_axi_rvalid_i_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_rvalid_i_reg_0\ : STD_LOGIC;
  signal s_axi_wdata_0_sn_1 : STD_LOGIC;
  signal s_axi_wdata_1_sn_1 : STD_LOGIC;
  signal start2 : STD_LOGIC;
  signal start2_i_1_n_0 : STD_LOGIC;
  signal \state[1]_i_1_n_0\ : STD_LOGIC;
  signal \state[1]_i_2_n_0\ : STD_LOGIC;
  signal \state_reg_n_0_[0]\ : STD_LOGIC;
  signal \state_reg_n_0_[1]\ : STD_LOGIC;
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[0]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[1]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[2]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute FSM_ENCODED_STATES of \FSM_onehot_state_reg[3]\ : label is "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \INCLUDE_DPHASE_TIMER.dpto_cnt[4]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[4]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \bus2ip_addr_i[5]_i_2\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of start2_i_1 : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \state[1]_i_2\ : label is "soft_lutpair14";
begin
  bus2ip_rnw_i_reg_0 <= \^bus2ip_rnw_i_reg_0\;
  ip2bus_rdack_reg <= \^ip2bus_rdack_reg\;
  s_axi_bresp(0) <= \^s_axi_bresp\(0);
  s_axi_bvalid_i_reg_0 <= \^s_axi_bvalid_i_reg_0\;
  s_axi_rvalid_i_reg_0 <= \^s_axi_rvalid_i_reg_0\;
  s_axi_wdata_0_sp_1 <= s_axi_wdata_0_sn_1;
  s_axi_wdata_1_sp_1 <= s_axi_wdata_1_sn_1;
\FSM_onehot_state[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"88888F888F888F88"
    )
        port map (
      I0 => \FSM_onehot_state[3]_i_2_n_0\,
      I1 => \FSM_onehot_state_reg_n_0_[3]\,
      I2 => s_axi_arvalid,
      I3 => \FSM_onehot_state_reg_n_0_[0]\,
      I4 => s_axi_wvalid,
      I5 => s_axi_awvalid,
      O => \FSM_onehot_state[0]_i_1_n_0\
    );
\FSM_onehot_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8F88"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => s_axi_arvalid,
      I2 => \^ip2bus_rdack_reg\,
      I3 => s_axi_rresp_i(0),
      O => \FSM_onehot_state[1]_i_1_n_0\
    );
\FSM_onehot_state[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"F888"
    )
        port map (
      I0 => \^s_axi_bvalid_i_reg_0\,
      I1 => s_axi_bready,
      I2 => \^s_axi_rvalid_i_reg_0\,
      I3 => s_axi_rready,
      O => \FSM_onehot_state[3]_i_2_n_0\
    );
\FSM_onehot_state_reg[0]\: unisim.vcomponents.FDSE
    generic map(
      INIT => '1'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[0]_i_1_n_0\,
      Q => \FSM_onehot_state_reg_n_0_[0]\,
      S => rst
    );
\FSM_onehot_state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \FSM_onehot_state[1]_i_1_n_0\,
      Q => s_axi_rresp_i(0),
      R => rst
    );
\FSM_onehot_state_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_DECODER_n_41,
      Q => s_axi_bresp_i(0),
      R => rst
    );
\FSM_onehot_state_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_DECODER_n_40,
      Q => \FSM_onehot_state_reg_n_0_[3]\,
      R => rst
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      O => plusOp(0)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      O => plusOp(1)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(2),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      O => plusOp(2)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(3),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(2),
      O => plusOp(3)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(4),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(2),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      I4 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(3),
      O => plusOp(4)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => \state_reg_n_0_[1]\,
      I1 => \state_reg_n_0_[0]\,
      O => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(5),
      I1 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(3),
      I2 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      I3 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      I4 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(2),
      I5 => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(4),
      O => plusOp(5)
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(0),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(0),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(1),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(1),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(2),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(2),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(3),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(3),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(4),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(4),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
\INCLUDE_DPHASE_TIMER.dpto_cnt_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => plusOp(5),
      Q => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(5),
      R => \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0\
    );
I_DECODER: entity work.mbv_system_axi_timebase_wdt_0_0_address_decoder
     port map (
      Bus_RNW_reg_reg_0 => Bus_RNW_reg_reg,
      Bus_RNW_reg_reg_1 => \^bus2ip_rnw_i_reg_0\,
      D(0) => I_DECODER_n_4,
      E(0) => E(0),
      FCV_reg(2 downto 0) => FCV_reg(2 downto 0),
      \FSM_onehot_state_reg[2]\(1) => I_DECODER_n_40,
      \FSM_onehot_state_reg[2]\(0) => I_DECODER_n_41,
      \FSM_onehot_state_reg[3]\ => \FSM_onehot_state[3]_i_2_n_0\,
      \FSM_onehot_state_reg[3]_0\(3) => \FSM_onehot_state_reg_n_0_[3]\,
      \FSM_onehot_state_reg[3]_0\(2) => s_axi_bresp_i(0),
      \FSM_onehot_state_reg[3]_0\(1) => s_axi_rresp_i(0),
      \FSM_onehot_state_reg[3]_0\(0) => \FSM_onehot_state_reg_n_0_[0]\,
      \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0\(0) => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(0),
      \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0\(0) => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(0),
      \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0\(0) => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(0),
      \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0\(0) => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(0),
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0\(0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(0),
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(3) => \bus2ip_addr_i_reg_n_0_[5]\,
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(2) => \bus2ip_addr_i_reg_n_0_[4]\,
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(1) => \bus2ip_addr_i_reg_n_0_[3]\,
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1\(0) => \bus2ip_addr_i_reg_n_0_[2]\,
      LBE_reg(1 downto 0) => LBE_reg(1 downto 0),
      PSME_reg => PSME_reg,
      Q => start2,
      \STATUS_I0_WDT.ip2bus_data_reg[0]\ => \STATUS_I0_WDT.ip2bus_data_reg[0]\,
      \STATUS_I0_WDT.ip2bus_data_reg[15]\(7 downto 0) => Q(7 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[5]\ => \STATUS_I0_WDT.ip2bus_data_reg[5]\,
      \STATUS_I0_WDT.ip2bus_data_reg[7]\(7 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]\(7 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[8]\ => \STATUS_I0_WDT.ip2bus_data_reg[8]\,
      \TSR1_reg_reg[31]\(31 downto 0) => D(31 downto 0),
      WCFG_reg_In => WCFG_reg_In,
      WEN_clear_reg0 => WEN_clear_reg0,
      WEN_clear_reg_reg => WEN_clear_reg_reg,
      WEN_clear_reg_reg_0 => WEN_clear_reg_reg_0,
      WEN_reg => WEN_reg,
      WEN_reg_d => WEN_reg_d,
      aen_trig => aen_trig,
      bus2ip_cs(0) => bus2ip_cs(0),
      fc_sst_enc(1 downto 0) => fc_sst_enc(1 downto 0),
      ip2bus_rdack => ip2bus_rdack,
      ip2bus_rdack_i => ip2bus_rdack_i,
      ip2bus_rdack_reg => \^ip2bus_rdack_reg\,
      is_write_reg => is_write_reg_0,
      p_11_in(1 downto 0) => p_11_in(1 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => is_read_reg_n_0,
      s_axi_arready_0(5 downto 0) => \INCLUDE_DPHASE_TIMER.dpto_cnt_reg\(5 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awready => is_write_reg_n_0,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid_i_reg => \^s_axi_bvalid_i_reg_0\,
      s_axi_wdata(1 downto 0) => s_axi_wdata(1 downto 0),
      s_axi_wdata_0_sp_1 => s_axi_wdata_0_sn_1,
      s_axi_wdata_1_sp_1 => s_axi_wdata_1_sn_1,
      s_axi_wvalid => s_axi_wvalid,
      \state_reg[0]\ => I_DECODER_n_5,
      \state_reg[0]_0\(1) => \state_reg_n_0_[1]\,
      \state_reg[0]_0\(0) => \state_reg_n_0_[0]\,
      wdt_interrupt => wdt_interrupt,
      wdt_reset_pending => wdt_reset_pending
    );
\bus2ip_addr_i[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_araddr(0),
      I1 => s_axi_arvalid,
      I2 => s_axi_awaddr(0),
      O => \bus2ip_addr_i[2]_i_1_n_0\
    );
\bus2ip_addr_i[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_araddr(1),
      I1 => s_axi_arvalid,
      I2 => s_axi_awaddr(1),
      O => \bus2ip_addr_i[3]_i_1_n_0\
    );
\bus2ip_addr_i[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_araddr(2),
      I1 => s_axi_arvalid,
      I2 => s_axi_awaddr(2),
      O => \bus2ip_addr_i[4]_i_1_n_0\
    );
\bus2ip_addr_i[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"03020202"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \state_reg_n_0_[1]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => s_axi_wvalid,
      I4 => s_axi_awvalid,
      O => \bus2ip_addr_i[5]_i_1_n_0\
    );
\bus2ip_addr_i[5]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => s_axi_araddr(3),
      I1 => s_axi_arvalid,
      I2 => s_axi_awaddr(3),
      O => \bus2ip_addr_i[5]_i_2_n_0\
    );
\bus2ip_addr_i_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[5]_i_1_n_0\,
      D => \bus2ip_addr_i[2]_i_1_n_0\,
      Q => \bus2ip_addr_i_reg_n_0_[2]\,
      R => rst
    );
\bus2ip_addr_i_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[5]_i_1_n_0\,
      D => \bus2ip_addr_i[3]_i_1_n_0\,
      Q => \bus2ip_addr_i_reg_n_0_[3]\,
      R => rst
    );
\bus2ip_addr_i_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[5]_i_1_n_0\,
      D => \bus2ip_addr_i[4]_i_1_n_0\,
      Q => \bus2ip_addr_i_reg_n_0_[4]\,
      R => rst
    );
\bus2ip_addr_i_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[5]_i_1_n_0\,
      D => \bus2ip_addr_i[5]_i_2_n_0\,
      Q => \bus2ip_addr_i_reg_n_0_[5]\,
      R => rst
    );
bus2ip_rnw_i_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => \bus2ip_addr_i[5]_i_1_n_0\,
      D => s_axi_arvalid,
      Q => \^bus2ip_rnw_i_reg_0\,
      R => rst
    );
is_read_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"8BBB8888"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => \FSM_onehot_state_reg_n_0_[0]\,
      I2 => \FSM_onehot_state[3]_i_2_n_0\,
      I3 => \FSM_onehot_state_reg_n_0_[3]\,
      I4 => is_read_reg_n_0,
      O => is_read_i_1_n_0
    );
is_read_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => is_read_i_1_n_0,
      Q => is_read_reg_n_0,
      R => rst
    );
is_write_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0080FFFF00800000"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_wvalid,
      I2 => \FSM_onehot_state_reg_n_0_[0]\,
      I3 => s_axi_arvalid,
      I4 => is_write_i_2_n_0,
      I5 => is_write_reg_n_0,
      O => is_write_i_1_n_0
    );
is_write_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFEAEAEAAAAAAAAA"
    )
        port map (
      I0 => \FSM_onehot_state_reg_n_0_[0]\,
      I1 => \^s_axi_bvalid_i_reg_0\,
      I2 => s_axi_bready,
      I3 => \^s_axi_rvalid_i_reg_0\,
      I4 => s_axi_rready,
      I5 => \FSM_onehot_state_reg_n_0_[3]\,
      O => is_write_i_2_n_0
    );
is_write_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => is_write_i_1_n_0,
      Q => is_write_reg_n_0,
      R => rst
    );
rst_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => SR(0),
      Q => rst,
      R => '0'
    );
\s_axi_bresp_i[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => ip2bus_error,
      I1 => s_axi_bresp_i(0),
      I2 => \^s_axi_bresp\(0),
      O => \s_axi_bresp_i[1]_i_1_n_0\
    );
\s_axi_bresp_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \s_axi_bresp_i[1]_i_1_n_0\,
      Q => \^s_axi_bresp\(0),
      R => rst
    );
s_axi_bvalid_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_DECODER_n_5,
      Q => \^s_axi_bvalid_i_reg_0\,
      R => rst
    );
\s_axi_rdata_i_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(0),
      Q => s_axi_rdata(0),
      R => rst
    );
\s_axi_rdata_i_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(10),
      Q => s_axi_rdata(10),
      R => rst
    );
\s_axi_rdata_i_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(11),
      Q => s_axi_rdata(11),
      R => rst
    );
\s_axi_rdata_i_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(12),
      Q => s_axi_rdata(12),
      R => rst
    );
\s_axi_rdata_i_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(13),
      Q => s_axi_rdata(13),
      R => rst
    );
\s_axi_rdata_i_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(14),
      Q => s_axi_rdata(14),
      R => rst
    );
\s_axi_rdata_i_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(15),
      Q => s_axi_rdata(15),
      R => rst
    );
\s_axi_rdata_i_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(16),
      Q => s_axi_rdata(16),
      R => rst
    );
\s_axi_rdata_i_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(17),
      Q => s_axi_rdata(17),
      R => rst
    );
\s_axi_rdata_i_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(18),
      Q => s_axi_rdata(18),
      R => rst
    );
\s_axi_rdata_i_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(19),
      Q => s_axi_rdata(19),
      R => rst
    );
\s_axi_rdata_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(1),
      Q => s_axi_rdata(1),
      R => rst
    );
\s_axi_rdata_i_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(20),
      Q => s_axi_rdata(20),
      R => rst
    );
\s_axi_rdata_i_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(21),
      Q => s_axi_rdata(21),
      R => rst
    );
\s_axi_rdata_i_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(22),
      Q => s_axi_rdata(22),
      R => rst
    );
\s_axi_rdata_i_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(23),
      Q => s_axi_rdata(23),
      R => rst
    );
\s_axi_rdata_i_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(24),
      Q => s_axi_rdata(24),
      R => rst
    );
\s_axi_rdata_i_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(25),
      Q => s_axi_rdata(25),
      R => rst
    );
\s_axi_rdata_i_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(26),
      Q => s_axi_rdata(26),
      R => rst
    );
\s_axi_rdata_i_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(27),
      Q => s_axi_rdata(27),
      R => rst
    );
\s_axi_rdata_i_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(28),
      Q => s_axi_rdata(28),
      R => rst
    );
\s_axi_rdata_i_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(29),
      Q => s_axi_rdata(29),
      R => rst
    );
\s_axi_rdata_i_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(2),
      Q => s_axi_rdata(2),
      R => rst
    );
\s_axi_rdata_i_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(30),
      Q => s_axi_rdata(30),
      R => rst
    );
\s_axi_rdata_i_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(31),
      Q => s_axi_rdata(31),
      R => rst
    );
\s_axi_rdata_i_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(3),
      Q => s_axi_rdata(3),
      R => rst
    );
\s_axi_rdata_i_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(4),
      Q => s_axi_rdata(4),
      R => rst
    );
\s_axi_rdata_i_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(5),
      Q => s_axi_rdata(5),
      R => rst
    );
\s_axi_rdata_i_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(6),
      Q => s_axi_rdata(6),
      R => rst
    );
\s_axi_rdata_i_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(7),
      Q => s_axi_rdata(7),
      R => rst
    );
\s_axi_rdata_i_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(8),
      Q => s_axi_rdata(8),
      R => rst
    );
\s_axi_rdata_i_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => \s_axi_rdata_i_reg[31]_0\(9),
      Q => s_axi_rdata(9),
      R => rst
    );
\s_axi_rresp_i_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => s_axi_rresp_i(0),
      D => ip2bus_error,
      Q => s_axi_rresp(0),
      R => rst
    );
s_axi_rvalid_i_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"75553000"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \state_reg_n_0_[1]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => \^ip2bus_rdack_reg\,
      I4 => \^s_axi_rvalid_i_reg_0\,
      O => s_axi_rvalid_i_i_1_n_0
    );
s_axi_rvalid_i_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_rvalid_i_i_1_n_0,
      Q => \^s_axi_rvalid_i_reg_0\,
      R => rst
    );
start2_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"000F0008"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => s_axi_awvalid,
      I2 => \state_reg_n_0_[1]\,
      I3 => \state_reg_n_0_[0]\,
      I4 => s_axi_arvalid,
      O => start2_i_1_n_0
    );
start2_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => start2_i_1_n_0,
      Q => start2,
      R => rst
    );
\state[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2C2F2C2CECEFECEC"
    )
        port map (
      I0 => \^ip2bus_rdack_reg\,
      I1 => \state_reg_n_0_[1]\,
      I2 => \state_reg_n_0_[0]\,
      I3 => s_axi_arvalid,
      I4 => \state[1]_i_2_n_0\,
      I5 => \FSM_onehot_state[3]_i_2_n_0\,
      O => \state[1]_i_1_n_0\
    );
\state[1]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => s_axi_awvalid,
      O => \state[1]_i_2_n_0\
    );
\state_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => I_DECODER_n_4,
      Q => \state_reg_n_0_[0]\,
      R => rst
    );
\state_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => \state[1]_i_1_n_0\,
      Q => \state_reg_n_0_[1]\,
      R => rst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif is
  port (
    s_axi_rresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    bus2ip_rnw_i_reg : out STD_LOGIC;
    bus2ip_cs : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rvalid_i_reg : out STD_LOGIC;
    s_axi_bvalid_i_reg : out STD_LOGIC;
    E : out STD_LOGIC_VECTOR ( 0 to 0 );
    is_write_reg : out STD_LOGIC;
    ip2bus_rdack_reg : out STD_LOGIC;
    s_axi_wdata_0_sp_1 : out STD_LOGIC;
    WEN_clear_reg_reg : out STD_LOGIC;
    D : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ip2bus_rdack_i : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    WEN_clear_reg0 : out STD_LOGIC;
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\ : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_wdata_1_sp_1 : out STD_LOGIC;
    Bus_RNW_reg_reg : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    SR : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_aclk : in STD_LOGIC;
    ip2bus_error : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_reg_d : in STD_LOGIC;
    WEN_reg : in STD_LOGIC;
    p_11_in : in STD_LOGIC_VECTOR ( 1 downto 0 );
    WEN_clear_reg_reg_0 : in STD_LOGIC;
    WCFG_reg_In : in STD_LOGIC;
    Q : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[8]\ : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    ip2bus_rdack : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[31]\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]\ : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[5]\ : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[0]\ : in STD_LOGIC;
    fc_sst_enc : in STD_LOGIC_VECTOR ( 1 downto 0 );
    PSME_reg : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1\ : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rready : in STD_LOGIC;
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2\ : in STD_LOGIC_VECTOR ( 31 downto 0 );
    wdt_interrupt : in STD_LOGIC;
    wdt_reset_pending : in STD_LOGIC;
    FCV_reg : in STD_LOGIC_VECTOR ( 2 downto 0 );
    LBE_reg : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    aen_trig : in STD_LOGIC;
    \s_axi_rdata_i_reg[31]\ : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif : entity is "axi_lite_ipif";
end mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif is
  signal s_axi_wdata_0_sn_1 : STD_LOGIC;
  signal s_axi_wdata_1_sn_1 : STD_LOGIC;
begin
  s_axi_wdata_0_sp_1 <= s_axi_wdata_0_sn_1;
  s_axi_wdata_1_sp_1 <= s_axi_wdata_1_sn_1;
I_SLAVE_ATTACHMENT: entity work.mbv_system_axi_timebase_wdt_0_0_slave_attachment
     port map (
      Bus_RNW_reg_reg => Bus_RNW_reg_reg,
      D(31 downto 0) => D(31 downto 0),
      E(0) => E(0),
      FCV_reg(2 downto 0) => FCV_reg(2 downto 0),
      \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(0) => \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(0),
      \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(0) => \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(0),
      \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(0) => \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(0),
      \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(0) => \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(0),
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(0) => \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(0),
      LBE_reg(1 downto 0) => LBE_reg(1 downto 0),
      PSME_reg => PSME_reg,
      Q(7 downto 0) => Q(7 downto 0),
      SR(0) => SR(0),
      \STATUS_I0_WDT.ip2bus_data_reg[0]\ => \STATUS_I0_WDT.ip2bus_data_reg[0]\,
      \STATUS_I0_WDT.ip2bus_data_reg[31]\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[5]\ => \STATUS_I0_WDT.ip2bus_data_reg[5]\,
      \STATUS_I0_WDT.ip2bus_data_reg[7]\(7 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]\(7 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1 downto 0) => \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[8]\ => \STATUS_I0_WDT.ip2bus_data_reg[8]\,
      WCFG_reg_In => WCFG_reg_In,
      WEN_clear_reg0 => WEN_clear_reg0,
      WEN_clear_reg_reg => WEN_clear_reg_reg,
      WEN_clear_reg_reg_0 => WEN_clear_reg_reg_0,
      WEN_reg => WEN_reg,
      WEN_reg_d => WEN_reg_d,
      aen_trig => aen_trig,
      bus2ip_cs(0) => bus2ip_cs(0),
      bus2ip_rnw_i_reg_0 => bus2ip_rnw_i_reg,
      fc_sst_enc(1 downto 0) => fc_sst_enc(1 downto 0),
      ip2bus_error => ip2bus_error,
      ip2bus_rdack => ip2bus_rdack,
      ip2bus_rdack_i => ip2bus_rdack_i,
      ip2bus_rdack_reg => ip2bus_rdack_reg,
      is_write_reg_0 => is_write_reg,
      p_11_in(1 downto 0) => p_11_in(1 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(3 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(3 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => s_axi_bresp(0),
      s_axi_bvalid_i_reg_0 => s_axi_bvalid_i_reg,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      \s_axi_rdata_i_reg[31]_0\(31 downto 0) => \s_axi_rdata_i_reg[31]\(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(0) => s_axi_rresp(0),
      s_axi_rvalid_i_reg_0 => s_axi_rvalid_i_reg,
      s_axi_wdata(1 downto 0) => s_axi_wdata(1 downto 0),
      s_axi_wdata_0_sp_1 => s_axi_wdata_0_sn_1,
      s_axi_wdata_1_sp_1 => s_axi_wdata_1_sn_1,
      s_axi_wvalid => s_axi_wvalid,
      wdt_interrupt => wdt_interrupt,
      wdt_reset_pending => wdt_reset_pending
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_axi_window_wdt is
  port (
    is_write_reg : out STD_LOGIC;
    ip2bus_rdack_reg_0 : out STD_LOGIC;
    s_axi_bvalid_i_reg : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    wdt_interrupt : out STD_LOGIC;
    wdt_state_vec : out STD_LOGIC_VECTOR ( 5 downto 0 );
    wdt_reset_reg_reg_0 : out STD_LOGIC;
    s_axi_rvalid_i_reg : out STD_LOGIC;
    wdt_reset_pending : out STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_axi_window_wdt : entity is "axi_window_wdt";
end mbv_system_axi_timebase_wdt_0_0_axi_window_wdt;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_axi_window_wdt is
  signal AXI4_LITE_I_n_1 : STD_LOGIC;
  signal AXI4_LITE_I_n_49 : STD_LOGIC;
  signal AXI4_LITE_I_n_5 : STD_LOGIC;
  signal AXI4_LITE_I_n_50 : STD_LOGIC;
  signal AXI4_LITE_I_n_8 : STD_LOGIC;
  signal AXI4_LITE_I_n_9 : STD_LOGIC;
  signal BSS_reg : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal FCV_reg : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal FW_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal FW_reg0 : STD_LOGIC;
  signal LBE_clear_reg : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal LBE_reg : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal LBE_reg0 : STD_LOGIC;
  signal \LBE_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal PSME_reg : STD_LOGIC;
  signal SBC_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal SBC_reg0 : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[0]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[10]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[11]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[12]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[13]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[14]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[15]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[16]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[17]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[18]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[19]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[1]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[20]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[21]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[22]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[23]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[24]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[25]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[26]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[27]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[28]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[29]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[2]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[30]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[31]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[3]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[4]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[5]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[6]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[7]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[8]\ : STD_LOGIC;
  signal \STATUS_I0_WDT.ip2bus_data_reg_n_0_[9]\ : STD_LOGIC;
  signal SW_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal SW_reg0 : STD_LOGIC;
  signal TSR0_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal TSR0_reg0 : STD_LOGIC;
  signal TSR1_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal TSR1_reg0 : STD_LOGIC;
  signal WCFG_clear_reg_reg_n_0 : STD_LOGIC;
  signal WCFG_reg_In : STD_LOGIC;
  signal WDP_reg_reg_n_0 : STD_LOGIC;
  signal WDT_Current_State : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal WEN_change : STD_LOGIC;
  signal WEN_clear_reg0 : STD_LOGIC;
  signal WEN_clear_reg_reg_n_0 : STD_LOGIC;
  signal WEN_reg : STD_LOGIC;
  signal WEN_reg_cleark : STD_LOGIC;
  signal WEN_reg_d : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_41 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_42 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_43 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_44 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_45 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_46 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_47 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_48 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_49 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_50 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_51 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_52 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_53 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_54 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_55 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_56 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_57 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_58 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_60 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_61 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_62 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_63 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_64 : STD_LOGIC;
  signal WINDOW_WDT_CNT_I_n_65 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_0 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_10 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_11 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_12 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_13 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_4 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_46 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_47 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_48 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_49 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_5 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_50 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_51 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_6 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_7 : STD_LOGIC;
  signal WINDOW_WDT_FAIL_CNT_I_n_9 : STD_LOGIC;
  signal WINT_clear_reg_reg_n_0 : STD_LOGIC;
  signal WRP_clear_reg_reg_n_0 : STD_LOGIC;
  signal WRP_reg_i_1_n_0 : STD_LOGIC;
  signal WSW_clear_reg_reg_n_0 : STD_LOGIC;
  signal WSW_reg : STD_LOGIC;
  signal aen_trig : STD_LOGIC;
  signal aen_trig_i_1_n_0 : STD_LOGIC;
  signal bus2ip_cs : STD_LOGIC_VECTOR ( 0 to 0 );
  signal bus2ip_reset : STD_LOGIC;
  signal cnt_wrp : STD_LOGIC;
  signal cnt_wrp_i_1_n_0 : STD_LOGIC;
  signal dis_wdt_cnt : STD_LOGIC;
  signal fc_sst_enc : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal ip2bus_data : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \ip2bus_error__0\ : STD_LOGIC;
  signal ip2bus_rdack : STD_LOGIC;
  signal ip2bus_rdack_i : STD_LOGIC;
  signal load_val9 : STD_LOGIC;
  signal \load_val9_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \load_val9_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \load_val9_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \load_val9_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \load_val9_carry__0_n_0\ : STD_LOGIC;
  signal \load_val9_carry__0_n_1\ : STD_LOGIC;
  signal \load_val9_carry__0_n_2\ : STD_LOGIC;
  signal \load_val9_carry__0_n_3\ : STD_LOGIC;
  signal \load_val9_carry__1_n_2\ : STD_LOGIC;
  signal \load_val9_carry__1_n_3\ : STD_LOGIC;
  signal load_val9_carry_i_1_n_0 : STD_LOGIC;
  signal load_val9_carry_i_2_n_0 : STD_LOGIC;
  signal load_val9_carry_i_3_n_0 : STD_LOGIC;
  signal load_val9_carry_i_4_n_0 : STD_LOGIC;
  signal load_val9_carry_n_0 : STD_LOGIC;
  signal load_val9_carry_n_1 : STD_LOGIC;
  signal load_val9_carry_n_2 : STD_LOGIC;
  signal load_val9_carry_n_3 : STD_LOGIC;
  signal minusOp : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal p_11_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal wdt_cnt_val : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^wdt_interrupt\ : STD_LOGIC;
  signal wdt_reset_int : STD_LOGIC;
  signal \^wdt_reset_pending\ : STD_LOGIC;
  signal \^wdt_reset_reg_reg_0\ : STD_LOGIC;
  signal \^wdt_state_vec\ : STD_LOGIC_VECTOR ( 5 downto 0 );
  signal wint_int : STD_LOGIC;
  signal NLW_load_val9_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_load_val9_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_load_val9_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_load_val9_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_WDT_Current_State_reg[0]\ : label is "first_window:01,second_window:10,sste_state:11,idle:00";
  attribute FSM_ENCODED_STATES of \FSM_sequential_WDT_Current_State_reg[1]\ : label is "first_window:01,second_window:10,sste_state:11,idle:00";
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \STATUS_I0_WDT.ip2bus_data[5]_i_2\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of WRP_reg_i_1 : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of cnt_wrp_i_1 : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of wdt_reset_reg_i_7 : label is "soft_lutpair40";
begin
  wdt_interrupt <= \^wdt_interrupt\;
  wdt_reset_pending <= \^wdt_reset_pending\;
  wdt_reset_reg_reg_0 <= \^wdt_reset_reg_reg_0\;
  wdt_state_vec(5 downto 0) <= \^wdt_state_vec\(5 downto 0);
AXI4_LITE_I: entity work.mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif
     port map (
      Bus_RNW_reg_reg => AXI4_LITE_I_n_50,
      D(31 downto 0) => ip2bus_data(31 downto 0),
      E(0) => AXI4_LITE_I_n_5,
      FCV_reg(2 downto 0) => FCV_reg(2 downto 0),
      \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]\(0) => SBC_reg0,
      \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]\(0) => FW_reg0,
      \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]\(0) => SW_reg0,
      \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]\(0) => TSR0_reg0,
      \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]\(0) => TSR1_reg0,
      LBE_reg(1 downto 0) => LBE_reg(1 downto 0),
      PSME_reg => PSME_reg,
      Q(7 downto 0) => SBC_reg(7 downto 0),
      SR(0) => bus2ip_reset,
      \STATUS_I0_WDT.ip2bus_data_reg[0]\ => WDP_reg_reg_n_0,
      \STATUS_I0_WDT.ip2bus_data_reg[31]\(31 downto 0) => TSR1_reg(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_0\(31 downto 0) => TSR0_reg(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_1\(31 downto 0) => SW_reg(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[31]_2\(31 downto 0) => FW_reg(31 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[5]\ => \STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0\,
      \STATUS_I0_WDT.ip2bus_data_reg[7]\(7 downto 0) => wdt_cnt_val(7 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_0\(1 downto 0) => BSS_reg(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[7]_1\(1 downto 0) => WDT_Current_State(1 downto 0),
      \STATUS_I0_WDT.ip2bus_data_reg[8]\ => WINDOW_WDT_FAIL_CNT_I_n_4,
      WCFG_reg_In => WCFG_reg_In,
      WEN_clear_reg0 => WEN_clear_reg0,
      WEN_clear_reg_reg => AXI4_LITE_I_n_9,
      WEN_clear_reg_reg_0 => WEN_clear_reg_reg_n_0,
      WEN_reg => WEN_reg,
      WEN_reg_d => WEN_reg_d,
      aen_trig => aen_trig,
      bus2ip_cs(0) => bus2ip_cs(0),
      bus2ip_rnw_i_reg => AXI4_LITE_I_n_1,
      fc_sst_enc(1 downto 0) => fc_sst_enc(1 downto 0),
      ip2bus_error => \ip2bus_error__0\,
      ip2bus_rdack => ip2bus_rdack,
      ip2bus_rdack_i => ip2bus_rdack_i,
      ip2bus_rdack_reg => ip2bus_rdack_reg_0,
      is_write_reg => is_write_reg,
      p_11_in(1 downto 0) => p_11_in(1 downto 0),
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(3 downto 0),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(3 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => s_axi_bresp(0),
      s_axi_bvalid_i_reg => s_axi_bvalid_i_reg,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      \s_axi_rdata_i_reg[31]\(31) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[31]\,
      \s_axi_rdata_i_reg[31]\(30) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[30]\,
      \s_axi_rdata_i_reg[31]\(29) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[29]\,
      \s_axi_rdata_i_reg[31]\(28) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[28]\,
      \s_axi_rdata_i_reg[31]\(27) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[27]\,
      \s_axi_rdata_i_reg[31]\(26) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[26]\,
      \s_axi_rdata_i_reg[31]\(25) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[25]\,
      \s_axi_rdata_i_reg[31]\(24) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[24]\,
      \s_axi_rdata_i_reg[31]\(23) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[23]\,
      \s_axi_rdata_i_reg[31]\(22) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[22]\,
      \s_axi_rdata_i_reg[31]\(21) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[21]\,
      \s_axi_rdata_i_reg[31]\(20) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[20]\,
      \s_axi_rdata_i_reg[31]\(19) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[19]\,
      \s_axi_rdata_i_reg[31]\(18) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[18]\,
      \s_axi_rdata_i_reg[31]\(17) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[17]\,
      \s_axi_rdata_i_reg[31]\(16) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[16]\,
      \s_axi_rdata_i_reg[31]\(15) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[15]\,
      \s_axi_rdata_i_reg[31]\(14) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[14]\,
      \s_axi_rdata_i_reg[31]\(13) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[13]\,
      \s_axi_rdata_i_reg[31]\(12) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[12]\,
      \s_axi_rdata_i_reg[31]\(11) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[11]\,
      \s_axi_rdata_i_reg[31]\(10) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[10]\,
      \s_axi_rdata_i_reg[31]\(9) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[9]\,
      \s_axi_rdata_i_reg[31]\(8) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[8]\,
      \s_axi_rdata_i_reg[31]\(7) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[7]\,
      \s_axi_rdata_i_reg[31]\(6) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[6]\,
      \s_axi_rdata_i_reg[31]\(5) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[5]\,
      \s_axi_rdata_i_reg[31]\(4) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[4]\,
      \s_axi_rdata_i_reg[31]\(3) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[3]\,
      \s_axi_rdata_i_reg[31]\(2) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[2]\,
      \s_axi_rdata_i_reg[31]\(1) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[1]\,
      \s_axi_rdata_i_reg[31]\(0) => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[0]\,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(0) => s_axi_rresp(0),
      s_axi_rvalid_i_reg => s_axi_rvalid_i_reg,
      s_axi_wdata(1 downto 0) => s_axi_wdata(1 downto 0),
      s_axi_wdata_0_sp_1 => AXI4_LITE_I_n_8,
      s_axi_wdata_1_sp_1 => AXI4_LITE_I_n_49,
      s_axi_wvalid => s_axi_wvalid,
      wdt_interrupt => \^wdt_interrupt\,
      wdt_reset_pending => \^wdt_reset_pending\
    );
\BSS_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(6),
      Q => BSS_reg(0),
      R => bus2ip_reset
    );
\BSS_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(7),
      Q => BSS_reg(1),
      R => bus2ip_reset
    );
FCE_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(2),
      Q => fc_sst_enc(0),
      R => bus2ip_reset
    );
\FSM_sequential_WDT_Current_State_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_CNT_I_n_46,
      Q => WDT_Current_State(0),
      R => bus2ip_reset
    );
\FSM_sequential_WDT_Current_State_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_CNT_I_n_45,
      Q => WDT_Current_State(1),
      R => bus2ip_reset
    );
\FW_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(0),
      Q => FW_reg(0),
      R => bus2ip_reset
    );
\FW_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(10),
      Q => FW_reg(10),
      R => bus2ip_reset
    );
\FW_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(11),
      Q => FW_reg(11),
      R => bus2ip_reset
    );
\FW_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(12),
      Q => FW_reg(12),
      R => bus2ip_reset
    );
\FW_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(13),
      Q => FW_reg(13),
      R => bus2ip_reset
    );
\FW_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(14),
      Q => FW_reg(14),
      R => bus2ip_reset
    );
\FW_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(15),
      Q => FW_reg(15),
      R => bus2ip_reset
    );
\FW_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(16),
      Q => FW_reg(16),
      R => bus2ip_reset
    );
\FW_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(17),
      Q => FW_reg(17),
      R => bus2ip_reset
    );
\FW_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(18),
      Q => FW_reg(18),
      R => bus2ip_reset
    );
\FW_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(19),
      Q => FW_reg(19),
      R => bus2ip_reset
    );
\FW_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(1),
      Q => FW_reg(1),
      R => bus2ip_reset
    );
\FW_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(20),
      Q => FW_reg(20),
      R => bus2ip_reset
    );
\FW_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(21),
      Q => FW_reg(21),
      R => bus2ip_reset
    );
\FW_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(22),
      Q => FW_reg(22),
      R => bus2ip_reset
    );
\FW_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(23),
      Q => FW_reg(23),
      R => bus2ip_reset
    );
\FW_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(24),
      Q => FW_reg(24),
      R => bus2ip_reset
    );
\FW_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(25),
      Q => FW_reg(25),
      R => bus2ip_reset
    );
\FW_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(26),
      Q => FW_reg(26),
      R => bus2ip_reset
    );
\FW_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(27),
      Q => FW_reg(27),
      R => bus2ip_reset
    );
\FW_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(28),
      Q => FW_reg(28),
      R => bus2ip_reset
    );
\FW_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(29),
      Q => FW_reg(29),
      R => bus2ip_reset
    );
\FW_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(2),
      Q => FW_reg(2),
      R => bus2ip_reset
    );
\FW_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(30),
      Q => FW_reg(30),
      R => bus2ip_reset
    );
\FW_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(31),
      Q => FW_reg(31),
      R => bus2ip_reset
    );
\FW_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(3),
      Q => FW_reg(3),
      R => bus2ip_reset
    );
\FW_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(4),
      Q => FW_reg(4),
      R => bus2ip_reset
    );
\FW_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(5),
      Q => FW_reg(5),
      R => bus2ip_reset
    );
\FW_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(6),
      Q => FW_reg(6),
      R => bus2ip_reset
    );
\FW_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(7),
      Q => FW_reg(7),
      R => bus2ip_reset
    );
\FW_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(8),
      Q => FW_reg(8),
      R => bus2ip_reset
    );
\FW_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => FW_reg0,
      D => s_axi_wdata(9),
      Q => FW_reg(9),
      R => bus2ip_reset
    );
\LBE_clear_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(24),
      Q => LBE_clear_reg(0),
      R => AXI4_LITE_I_n_50
    );
\LBE_clear_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(25),
      Q => LBE_clear_reg(1),
      R => AXI4_LITE_I_n_50
    );
\LBE_clear_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(26),
      Q => LBE_clear_reg(2),
      R => AXI4_LITE_I_n_50
    );
\LBE_reg[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBBBBBBBBBBABBBB"
    )
        port map (
      I0 => WDT_Current_State(1),
      I1 => WSW_clear_reg_reg_n_0,
      I2 => WDP_reg_reg_n_0,
      I3 => p_11_in(1),
      I4 => WEN_change,
      I5 => WEN_clear_reg_reg_n_0,
      O => \LBE_reg[1]_i_2_n_0\
    );
\LBE_reg[1]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => LBE_clear_reg(0),
      I1 => LBE_clear_reg(2),
      I2 => LBE_clear_reg(1),
      I3 => \^wdt_reset_reg_reg_0\,
      O => LBE_reg0
    );
\LBE_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_CNT_I_n_43,
      Q => LBE_reg(0),
      R => '0'
    );
\LBE_reg_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_FAIL_CNT_I_n_6,
      Q => LBE_reg(1),
      R => '0'
    );
PSME_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(3),
      Q => PSME_reg,
      R => bus2ip_reset
    );
\SBC_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(8),
      Q => SBC_reg(0),
      R => bus2ip_reset
    );
\SBC_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(9),
      Q => SBC_reg(1),
      R => bus2ip_reset
    );
\SBC_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(10),
      Q => SBC_reg(2),
      R => bus2ip_reset
    );
\SBC_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(11),
      Q => SBC_reg(3),
      R => bus2ip_reset
    );
\SBC_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(12),
      Q => SBC_reg(4),
      R => bus2ip_reset
    );
\SBC_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(13),
      Q => SBC_reg(5),
      R => bus2ip_reset
    );
\SBC_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(14),
      Q => SBC_reg(6),
      R => bus2ip_reset
    );
\SBC_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(15),
      Q => SBC_reg(7),
      R => bus2ip_reset
    );
SSTE_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(4),
      Q => fc_sst_enc(1),
      R => bus2ip_reset
    );
\STATUS_I0_WDT.ip2bus_data[5]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => WDT_Current_State(0),
      I1 => WDT_Current_State(1),
      O => \STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0\
    );
\STATUS_I0_WDT.ip2bus_data_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(0),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[0]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(10),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[10]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(11),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[11]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(12),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[12]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(13),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[13]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(14),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[14]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(15),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[15]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(16),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[16]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(17),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[17]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(18),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[18]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(19),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[19]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(1),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[1]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(20),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[20]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(21),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[21]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(22),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[22]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(23),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[23]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(24),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[24]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(25),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[25]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(26),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[26]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(27),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[27]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(28),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[28]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(29),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[29]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(2),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[2]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(30),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[30]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(31),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[31]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(3),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[3]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(4),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[4]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(5),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[5]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(6),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[6]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_data(7),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[7]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(8),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[8]\,
      R => '0'
    );
\STATUS_I0_WDT.ip2bus_data_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => AXI4_LITE_I_n_5,
      D => ip2bus_data(9),
      Q => \STATUS_I0_WDT.ip2bus_data_reg_n_0_[9]\,
      R => '0'
    );
\SW_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(0),
      Q => SW_reg(0),
      R => bus2ip_reset
    );
\SW_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(10),
      Q => SW_reg(10),
      R => bus2ip_reset
    );
\SW_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(11),
      Q => SW_reg(11),
      R => bus2ip_reset
    );
\SW_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(12),
      Q => SW_reg(12),
      R => bus2ip_reset
    );
\SW_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(13),
      Q => SW_reg(13),
      R => bus2ip_reset
    );
\SW_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(14),
      Q => SW_reg(14),
      R => bus2ip_reset
    );
\SW_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(15),
      Q => SW_reg(15),
      R => bus2ip_reset
    );
\SW_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(16),
      Q => SW_reg(16),
      R => bus2ip_reset
    );
\SW_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(17),
      Q => SW_reg(17),
      R => bus2ip_reset
    );
\SW_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(18),
      Q => SW_reg(18),
      R => bus2ip_reset
    );
\SW_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(19),
      Q => SW_reg(19),
      R => bus2ip_reset
    );
\SW_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(1),
      Q => SW_reg(1),
      R => bus2ip_reset
    );
\SW_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(20),
      Q => SW_reg(20),
      R => bus2ip_reset
    );
\SW_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(21),
      Q => SW_reg(21),
      R => bus2ip_reset
    );
\SW_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(22),
      Q => SW_reg(22),
      R => bus2ip_reset
    );
\SW_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(23),
      Q => SW_reg(23),
      R => bus2ip_reset
    );
\SW_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(24),
      Q => SW_reg(24),
      R => bus2ip_reset
    );
\SW_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(25),
      Q => SW_reg(25),
      R => bus2ip_reset
    );
\SW_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(26),
      Q => SW_reg(26),
      R => bus2ip_reset
    );
\SW_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(27),
      Q => SW_reg(27),
      R => bus2ip_reset
    );
\SW_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(28),
      Q => SW_reg(28),
      R => bus2ip_reset
    );
\SW_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(29),
      Q => SW_reg(29),
      R => bus2ip_reset
    );
\SW_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(2),
      Q => SW_reg(2),
      R => bus2ip_reset
    );
\SW_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(30),
      Q => SW_reg(30),
      R => bus2ip_reset
    );
\SW_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(31),
      Q => SW_reg(31),
      R => bus2ip_reset
    );
\SW_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(3),
      Q => SW_reg(3),
      R => bus2ip_reset
    );
\SW_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(4),
      Q => SW_reg(4),
      R => bus2ip_reset
    );
\SW_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(5),
      Q => SW_reg(5),
      R => bus2ip_reset
    );
\SW_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(6),
      Q => SW_reg(6),
      R => bus2ip_reset
    );
\SW_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(7),
      Q => SW_reg(7),
      R => bus2ip_reset
    );
\SW_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(8),
      Q => SW_reg(8),
      R => bus2ip_reset
    );
\SW_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SW_reg0,
      D => s_axi_wdata(9),
      Q => SW_reg(9),
      R => bus2ip_reset
    );
\TSR0_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(0),
      Q => TSR0_reg(0),
      R => bus2ip_reset
    );
\TSR0_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(10),
      Q => TSR0_reg(10),
      R => bus2ip_reset
    );
\TSR0_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(11),
      Q => TSR0_reg(11),
      R => bus2ip_reset
    );
\TSR0_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(12),
      Q => TSR0_reg(12),
      R => bus2ip_reset
    );
\TSR0_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(13),
      Q => TSR0_reg(13),
      R => bus2ip_reset
    );
\TSR0_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(14),
      Q => TSR0_reg(14),
      R => bus2ip_reset
    );
\TSR0_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(15),
      Q => TSR0_reg(15),
      R => bus2ip_reset
    );
\TSR0_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(16),
      Q => TSR0_reg(16),
      R => bus2ip_reset
    );
\TSR0_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(17),
      Q => TSR0_reg(17),
      R => bus2ip_reset
    );
\TSR0_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(18),
      Q => TSR0_reg(18),
      R => bus2ip_reset
    );
\TSR0_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(19),
      Q => TSR0_reg(19),
      R => bus2ip_reset
    );
\TSR0_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(1),
      Q => TSR0_reg(1),
      R => bus2ip_reset
    );
\TSR0_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(20),
      Q => TSR0_reg(20),
      R => bus2ip_reset
    );
\TSR0_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(21),
      Q => TSR0_reg(21),
      R => bus2ip_reset
    );
\TSR0_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(22),
      Q => TSR0_reg(22),
      R => bus2ip_reset
    );
\TSR0_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(23),
      Q => TSR0_reg(23),
      R => bus2ip_reset
    );
\TSR0_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(24),
      Q => TSR0_reg(24),
      R => bus2ip_reset
    );
\TSR0_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(25),
      Q => TSR0_reg(25),
      R => bus2ip_reset
    );
\TSR0_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(26),
      Q => TSR0_reg(26),
      R => bus2ip_reset
    );
\TSR0_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(27),
      Q => TSR0_reg(27),
      R => bus2ip_reset
    );
\TSR0_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(28),
      Q => TSR0_reg(28),
      R => bus2ip_reset
    );
\TSR0_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(29),
      Q => TSR0_reg(29),
      R => bus2ip_reset
    );
\TSR0_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(2),
      Q => TSR0_reg(2),
      R => bus2ip_reset
    );
\TSR0_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(30),
      Q => TSR0_reg(30),
      R => bus2ip_reset
    );
\TSR0_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(31),
      Q => TSR0_reg(31),
      R => bus2ip_reset
    );
\TSR0_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(3),
      Q => TSR0_reg(3),
      R => bus2ip_reset
    );
\TSR0_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(4),
      Q => TSR0_reg(4),
      R => bus2ip_reset
    );
\TSR0_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(5),
      Q => TSR0_reg(5),
      R => bus2ip_reset
    );
\TSR0_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(6),
      Q => TSR0_reg(6),
      R => bus2ip_reset
    );
\TSR0_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(7),
      Q => TSR0_reg(7),
      R => bus2ip_reset
    );
\TSR0_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(8),
      Q => TSR0_reg(8),
      R => bus2ip_reset
    );
\TSR0_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR0_reg0,
      D => s_axi_wdata(9),
      Q => TSR0_reg(9),
      R => bus2ip_reset
    );
\TSR1_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(0),
      Q => TSR1_reg(0),
      R => bus2ip_reset
    );
\TSR1_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(10),
      Q => TSR1_reg(10),
      R => bus2ip_reset
    );
\TSR1_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(11),
      Q => TSR1_reg(11),
      R => bus2ip_reset
    );
\TSR1_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(12),
      Q => TSR1_reg(12),
      R => bus2ip_reset
    );
\TSR1_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(13),
      Q => TSR1_reg(13),
      R => bus2ip_reset
    );
\TSR1_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(14),
      Q => TSR1_reg(14),
      R => bus2ip_reset
    );
\TSR1_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(15),
      Q => TSR1_reg(15),
      R => bus2ip_reset
    );
\TSR1_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(16),
      Q => TSR1_reg(16),
      R => bus2ip_reset
    );
\TSR1_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(17),
      Q => TSR1_reg(17),
      R => bus2ip_reset
    );
\TSR1_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(18),
      Q => TSR1_reg(18),
      R => bus2ip_reset
    );
\TSR1_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(19),
      Q => TSR1_reg(19),
      R => bus2ip_reset
    );
\TSR1_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(1),
      Q => TSR1_reg(1),
      R => bus2ip_reset
    );
\TSR1_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(20),
      Q => TSR1_reg(20),
      R => bus2ip_reset
    );
\TSR1_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(21),
      Q => TSR1_reg(21),
      R => bus2ip_reset
    );
\TSR1_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(22),
      Q => TSR1_reg(22),
      R => bus2ip_reset
    );
\TSR1_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(23),
      Q => TSR1_reg(23),
      R => bus2ip_reset
    );
\TSR1_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(24),
      Q => TSR1_reg(24),
      R => bus2ip_reset
    );
\TSR1_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(25),
      Q => TSR1_reg(25),
      R => bus2ip_reset
    );
\TSR1_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(26),
      Q => TSR1_reg(26),
      R => bus2ip_reset
    );
\TSR1_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(27),
      Q => TSR1_reg(27),
      R => bus2ip_reset
    );
\TSR1_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(28),
      Q => TSR1_reg(28),
      R => bus2ip_reset
    );
\TSR1_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(29),
      Q => TSR1_reg(29),
      R => bus2ip_reset
    );
\TSR1_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(2),
      Q => TSR1_reg(2),
      R => bus2ip_reset
    );
\TSR1_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(30),
      Q => TSR1_reg(30),
      R => bus2ip_reset
    );
\TSR1_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(31),
      Q => TSR1_reg(31),
      R => bus2ip_reset
    );
\TSR1_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(3),
      Q => TSR1_reg(3),
      R => bus2ip_reset
    );
\TSR1_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(4),
      Q => TSR1_reg(4),
      R => bus2ip_reset
    );
\TSR1_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(5),
      Q => TSR1_reg(5),
      R => bus2ip_reset
    );
\TSR1_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(6),
      Q => TSR1_reg(6),
      R => bus2ip_reset
    );
\TSR1_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(7),
      Q => TSR1_reg(7),
      R => bus2ip_reset
    );
\TSR1_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(8),
      Q => TSR1_reg(8),
      R => bus2ip_reset
    );
\TSR1_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => TSR1_reg0,
      D => s_axi_wdata(9),
      Q => TSR1_reg(9),
      R => bus2ip_reset
    );
WCFG_clear_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(1),
      Q => WCFG_clear_reg_reg_n_0,
      R => AXI4_LITE_I_n_50
    );
WCFG_reg_In_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_FAIL_CNT_I_n_48,
      Q => WCFG_reg_In,
      R => '0'
    );
WDP_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => SBC_reg0,
      D => s_axi_wdata(0),
      Q => WDP_reg_reg_n_0,
      R => bus2ip_reset
    );
WEN_change_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WEN_clear_reg0,
      Q => WEN_change,
      R => '0'
    );
WEN_clear_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => AXI4_LITE_I_n_9,
      Q => WEN_clear_reg_reg_n_0,
      R => '0'
    );
WEN_reg_d_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => s_axi_aclk,
      CE => '1',
      D => WEN_reg,
      Q => WEN_reg_d,
      R => bus2ip_reset
    );
WEN_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WEN_reg_cleark,
      Q => WEN_reg,
      R => bus2ip_reset
    );
WINDOW_WDT_CNT_I: entity work.mbv_system_axi_timebase_wdt_0_0_window_wdt_counter
     port map (
      CO(0) => load_val9,
      D(1) => WINDOW_WDT_CNT_I_n_45,
      D(0) => WINDOW_WDT_CNT_I_n_46,
      E(0) => WINDOW_WDT_FAIL_CNT_I_n_10,
      \FSM_sequential_WDT_Current_State[0]_i_3_0\ => WINDOW_WDT_FAIL_CNT_I_n_0,
      \FSM_sequential_WDT_Current_State[0]_i_3_1\ => WINDOW_WDT_FAIL_CNT_I_n_5,
      \FSM_sequential_WDT_Current_State_reg[0]\ => WINDOW_WDT_CNT_I_n_49,
      \FSM_sequential_WDT_Current_State_reg[0]_0\ => WINDOW_WDT_FAIL_CNT_I_n_11,
      \FSM_sequential_WDT_Current_State_reg[0]_1\(1 downto 0) => WDT_Current_State(1 downto 0),
      \FSM_sequential_WDT_Current_State_reg[0]_2\ => WINDOW_WDT_FAIL_CNT_I_n_49,
      \FSM_sequential_WDT_Current_State_reg[1]\ => WINDOW_WDT_CNT_I_n_50,
      \FSM_sequential_WDT_Current_State_reg[1]_0\ => WINDOW_WDT_FAIL_CNT_I_n_50,
      \FSM_sequential_WDT_Current_State_reg[1]_1\ => WSW_clear_reg_reg_n_0,
      \FSM_sequential_WDT_Current_State_reg[1]_2\ => WINDOW_WDT_FAIL_CNT_I_n_13,
      \FW_reg_reg[12]\ => WINDOW_WDT_CNT_I_n_64,
      \FW_reg_reg[22]\ => WINDOW_WDT_CNT_I_n_47,
      \FW_reg_reg[29]\ => WINDOW_WDT_CNT_I_n_63,
      LBE_reg(0) => LBE_reg(0),
      LBE_reg0 => LBE_reg0,
      \LBE_reg_reg[0]\ => WINDOW_WDT_CNT_I_n_43,
      \LBE_reg_reg[0]_0\ => WINDOW_WDT_FAIL_CNT_I_n_47,
      \LBE_reg_reg[0]_1\ => WINDOW_WDT_FAIL_CNT_I_n_9,
      PSME_reg => PSME_reg,
      PSME_reg_reg => WINDOW_WDT_CNT_I_n_42,
      Q(7 downto 0) => wdt_cnt_val(7 downto 0),
      S(2) => WINDOW_WDT_CNT_I_n_60,
      S(1) => WINDOW_WDT_CNT_I_n_61,
      S(0) => WINDOW_WDT_CNT_I_n_62,
      SR(0) => bus2ip_reset,
      \SW_reg_reg[0]\ => WINDOW_WDT_CNT_I_n_55,
      \SW_reg_reg[21]\ => WINDOW_WDT_CNT_I_n_53,
      \SW_reg_reg[25]\ => WINDOW_WDT_CNT_I_n_56,
      \SW_reg_reg[26]\ => WINDOW_WDT_CNT_I_n_54,
      \SW_reg_reg[5]\ => WINDOW_WDT_CNT_I_n_57,
      \SW_reg_reg[8]\ => WINDOW_WDT_CNT_I_n_52,
      WEN_change => WEN_change,
      WEN_clear_reg_reg => WINDOW_WDT_CNT_I_n_48,
      dis_wdt_cnt => dis_wdt_cnt,
      dis_wdt_int_reg_0 => WINDOW_WDT_CNT_I_n_41,
      dis_wdt_int_reg_1 => WINDOW_WDT_CNT_I_n_44,
      dis_wdt_int_reg_2 => WINDOW_WDT_CNT_I_n_58,
      fc_sst_enc(0) => fc_sst_enc(1),
      \int_cnt_int[31]_i_12_0\(31 downto 0) => SW_reg(31 downto 0),
      \int_cnt_int[31]_i_14_0\(31 downto 0) => FW_reg(31 downto 0),
      \int_cnt_int[7]_i_3\ => WEN_clear_reg_reg_n_0,
      \int_cnt_int[7]_i_3_0\ => WDP_reg_reg_n_0,
      \int_cnt_int_reg[31]_0\(31 downto 0) => p_1_in(31 downto 0),
      \load_val9_carry__1\(7 downto 0) => TSR0_reg(31 downto 24),
      \load_val9_carry__1_0\(7 downto 0) => TSR1_reg(31 downto 24),
      minusOp(30 downto 0) => minusOp(31 downto 1),
      p_11_in(0) => p_11_in(1),
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      wdt_reset_int => wdt_reset_int,
      wdt_reset_reg_reg => WINDOW_WDT_CNT_I_n_51,
      wdt_reset_reg_reg_0 => WINDOW_WDT_CNT_I_n_65,
      wdt_reset_reg_reg_1 => \^wdt_reset_reg_reg_0\,
      wdt_reset_reg_reg_2 => WINDOW_WDT_FAIL_CNT_I_n_51,
      wdt_reset_reg_reg_3 => WINDOW_WDT_FAIL_CNT_I_n_7,
      wint_int => wint_int,
      wint_int_i_6_0(7 downto 0) => SBC_reg(7 downto 0),
      wint_int_reg_0 => WINDOW_WDT_FAIL_CNT_I_n_12,
      wint_int_reg_1 => WINDOW_WDT_FAIL_CNT_I_n_46,
      wint_int_reg_2 => WINDOW_WDT_FAIL_CNT_I_n_4,
      wint_int_reg_3 => WINT_clear_reg_reg_n_0,
      wint_int_reg_4(1 downto 0) => BSS_reg(1 downto 0)
    );
WINDOW_WDT_FAIL_CNT_I: entity work.mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt
     port map (
      CO(0) => load_val9,
      D(0) => WEN_reg,
      E(0) => WINDOW_WDT_FAIL_CNT_I_n_10,
      FCV_reg(2 downto 0) => FCV_reg(2 downto 0),
      \FSM_sequential_WDT_Current_State_reg[0]\ => WINDOW_WDT_FAIL_CNT_I_n_4,
      \FSM_sequential_WDT_Current_State_reg[0]_0\ => WINDOW_WDT_FAIL_CNT_I_n_47,
      \FSM_sequential_WDT_Current_State_reg[1]\ => WINDOW_WDT_FAIL_CNT_I_n_7,
      \FSM_sequential_WDT_Current_State_reg[1]_0\ => WINDOW_WDT_FAIL_CNT_I_n_11,
      \FSM_sequential_WDT_Current_State_reg[1]_1\ => WINDOW_WDT_CNT_I_n_57,
      \FSM_sequential_WDT_Current_State_reg[1]_2\ => WINDOW_WDT_CNT_I_n_56,
      \FSM_sequential_WDT_Current_State_reg[1]_3\ => WINDOW_WDT_CNT_I_n_53,
      \FSM_sequential_WDT_Current_State_reg[1]_4\ => WINDOW_WDT_CNT_I_n_54,
      LBE_reg(0) => LBE_reg(1),
      LBE_reg0 => LBE_reg0,
      \LBE_reg_reg[1]\ => WINDOW_WDT_FAIL_CNT_I_n_6,
      \LBE_reg_reg[1]_0\ => \LBE_reg[1]_i_2_n_0\,
      PSME_reg => PSME_reg,
      PSME_reg_reg => WINDOW_WDT_FAIL_CNT_I_n_12,
      PSME_reg_reg_0 => WINDOW_WDT_FAIL_CNT_I_n_46,
      Q(1 downto 0) => WDT_Current_State(1 downto 0),
      SR(0) => bus2ip_reset,
      SSTE_reg_reg => WINDOW_WDT_FAIL_CNT_I_n_51,
      \SW_reg_reg[25]\ => WINDOW_WDT_FAIL_CNT_I_n_50,
      \SW_reg_reg[31]\(31 downto 0) => p_1_in(31 downto 0),
      WCFG_reg_In => WCFG_reg_In,
      WCFG_reg_In_reg => WINDOW_WDT_FAIL_CNT_I_n_48,
      WCFG_reg_In_reg_0 => WEN_clear_reg_reg_n_0,
      WCFG_reg_In_reg_1 => WDP_reg_reg_n_0,
      WCFG_reg_In_reg_2 => WINDOW_WDT_CNT_I_n_51,
      WCFG_reg_In_reg_3 => WCFG_clear_reg_reg_n_0,
      WDP_reg_reg => WINDOW_WDT_FAIL_CNT_I_n_5,
      WEN_change => WEN_change,
      WEN_clear_reg_reg => WINDOW_WDT_FAIL_CNT_I_n_9,
      WEN_clear_reg_reg_0 => WINDOW_WDT_FAIL_CNT_I_n_49,
      WEN_reg_cleark => WEN_reg_cleark,
      WEN_reg_reg => WSW_clear_reg_reg_n_0,
      WEN_reg_reg_0 => \^wdt_reset_reg_reg_0\,
      WEN_reg_reg_1 => WINDOW_WDT_CNT_I_n_48,
      dis_wdt_cnt => dis_wdt_cnt,
      dis_wdt_int_reg_0 => WINDOW_WDT_CNT_I_n_44,
      \fail_cnt_int_reg[0]_0\ => WINDOW_WDT_FAIL_CNT_I_n_13,
      \fail_cnt_int_reg[2]_0\ => WINDOW_WDT_FAIL_CNT_I_n_0,
      fc_sst_enc(1 downto 0) => fc_sst_enc(1 downto 0),
      \int_cnt_int[31]_i_4_0\ => WINDOW_WDT_CNT_I_n_50,
      \int_cnt_int_reg[0]\(0) => wdt_cnt_val(0),
      \int_cnt_int_reg[0]_0\ => WINDOW_WDT_CNT_I_n_49,
      \int_cnt_int_reg[0]_1\ => WINDOW_WDT_CNT_I_n_52,
      \int_cnt_int_reg[0]_2\ => WINDOW_WDT_CNT_I_n_55,
      \int_cnt_int_reg[0]_3\ => WINDOW_WDT_CNT_I_n_63,
      \int_cnt_int_reg[0]_4\ => WINDOW_WDT_CNT_I_n_64,
      \int_cnt_int_reg[0]_5\ => WINDOW_WDT_CNT_I_n_47,
      \int_cnt_int_reg[31]\ => WINDOW_WDT_CNT_I_n_42,
      \int_cnt_int_reg[31]_0\ => WINDOW_WDT_CNT_I_n_41,
      \int_cnt_int_reg[31]_1\ => WINDOW_WDT_CNT_I_n_58,
      \int_cnt_int_reg[31]_2\(31 downto 0) => SW_reg(31 downto 0),
      \int_cnt_int_reg[31]_3\(31 downto 0) => FW_reg(31 downto 0),
      minusOp(30 downto 0) => minusOp(31 downto 1),
      p_11_in(0) => p_11_in(1),
      s_axi_aclk => s_axi_aclk,
      s_axi_aresetn => s_axi_aresetn,
      wdt_state_vec(0) => \^wdt_state_vec\(1)
    );
WINT_clear_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(16),
      Q => WINT_clear_reg_reg_n_0,
      R => AXI4_LITE_I_n_50
    );
WINT_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => wint_int,
      Q => \^wdt_interrupt\,
      R => '0'
    );
WRP_clear_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(17),
      Q => WRP_clear_reg_reg_n_0,
      R => AXI4_LITE_I_n_50
    );
WRP_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0080"
    )
        port map (
      I0 => WDT_Current_State(1),
      I1 => WDT_Current_State(0),
      I2 => s_axi_aresetn,
      I3 => cnt_wrp,
      O => WRP_reg_i_1_n_0
    );
WRP_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WRP_reg_i_1_n_0,
      Q => \^wdt_reset_pending\,
      R => '0'
    );
WSW_clear_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => s_axi_wdata(8),
      Q => WSW_clear_reg_reg_n_0,
      R => AXI4_LITE_I_n_50
    );
aen_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => AXI4_LITE_I_n_49,
      Q => p_11_in(1),
      R => bus2ip_reset
    );
aen_trig_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => p_11_in(1),
      I1 => aen_trig,
      O => aen_trig_i_1_n_0
    );
aen_trig_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => aen_trig_i_1_n_0,
      Q => aen_trig,
      R => bus2ip_reset
    );
cnt_wrp_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF80"
    )
        port map (
      I0 => WDT_Current_State(0),
      I1 => WDT_Current_State(1),
      I2 => WRP_clear_reg_reg_n_0,
      I3 => cnt_wrp,
      O => cnt_wrp_i_1_n_0
    );
cnt_wrp_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => cnt_wrp_i_1_n_0,
      Q => cnt_wrp,
      R => bus2ip_reset
    );
ip2bus_error: unisim.vcomponents.LUT6
    generic map(
      INIT => X"002A00AA00AA00AA"
    )
        port map (
      I0 => bus2ip_cs(0),
      I1 => s_axi_wstrb(2),
      I2 => s_axi_wstrb(0),
      I3 => AXI4_LITE_I_n_1,
      I4 => s_axi_wstrb(1),
      I5 => s_axi_wstrb(3),
      O => \ip2bus_error__0\
    );
ip2bus_rdack_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => ip2bus_rdack_i,
      Q => ip2bus_rdack,
      R => '0'
    );
load_val9_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => load_val9_carry_n_0,
      CO(2) => load_val9_carry_n_1,
      CO(1) => load_val9_carry_n_2,
      CO(0) => load_val9_carry_n_3,
      CYINIT => '1',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => NLW_load_val9_carry_O_UNCONNECTED(3 downto 0),
      S(3) => load_val9_carry_i_1_n_0,
      S(2) => load_val9_carry_i_2_n_0,
      S(1) => load_val9_carry_i_3_n_0,
      S(0) => load_val9_carry_i_4_n_0
    );
\load_val9_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => load_val9_carry_n_0,
      CO(3) => \load_val9_carry__0_n_0\,
      CO(2) => \load_val9_carry__0_n_1\,
      CO(1) => \load_val9_carry__0_n_2\,
      CO(0) => \load_val9_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_load_val9_carry__0_O_UNCONNECTED\(3 downto 0),
      S(3) => \load_val9_carry__0_i_1_n_0\,
      S(2) => \load_val9_carry__0_i_2_n_0\,
      S(1) => \load_val9_carry__0_i_3_n_0\,
      S(0) => \load_val9_carry__0_i_4_n_0\
    );
\load_val9_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(21),
      I1 => TSR0_reg(21),
      I2 => TSR1_reg(23),
      I3 => TSR0_reg(23),
      I4 => TSR0_reg(22),
      I5 => TSR1_reg(22),
      O => \load_val9_carry__0_i_1_n_0\
    );
\load_val9_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(20),
      I1 => TSR0_reg(20),
      I2 => TSR1_reg(18),
      I3 => TSR0_reg(18),
      I4 => TSR0_reg(19),
      I5 => TSR1_reg(19),
      O => \load_val9_carry__0_i_2_n_0\
    );
\load_val9_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(15),
      I1 => TSR0_reg(15),
      I2 => TSR1_reg(17),
      I3 => TSR0_reg(17),
      I4 => TSR0_reg(16),
      I5 => TSR1_reg(16),
      O => \load_val9_carry__0_i_3_n_0\
    );
\load_val9_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(14),
      I1 => TSR0_reg(14),
      I2 => TSR1_reg(13),
      I3 => TSR0_reg(13),
      I4 => TSR0_reg(12),
      I5 => TSR1_reg(12),
      O => \load_val9_carry__0_i_4_n_0\
    );
\load_val9_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \load_val9_carry__0_n_0\,
      CO(3) => \NLW_load_val9_carry__1_CO_UNCONNECTED\(3),
      CO(2) => load_val9,
      CO(1) => \load_val9_carry__1_n_2\,
      CO(0) => \load_val9_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_load_val9_carry__1_O_UNCONNECTED\(3 downto 0),
      S(3) => '0',
      S(2) => WINDOW_WDT_CNT_I_n_60,
      S(1) => WINDOW_WDT_CNT_I_n_61,
      S(0) => WINDOW_WDT_CNT_I_n_62
    );
load_val9_carry_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(10),
      I1 => TSR0_reg(10),
      I2 => TSR1_reg(11),
      I3 => TSR0_reg(11),
      I4 => TSR0_reg(9),
      I5 => TSR1_reg(9),
      O => load_val9_carry_i_1_n_0
    );
load_val9_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(6),
      I1 => TSR0_reg(6),
      I2 => TSR1_reg(8),
      I3 => TSR0_reg(8),
      I4 => TSR0_reg(7),
      I5 => TSR1_reg(7),
      O => load_val9_carry_i_2_n_0
    );
load_val9_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(5),
      I1 => TSR0_reg(5),
      I2 => TSR1_reg(3),
      I3 => TSR0_reg(3),
      I4 => TSR0_reg(4),
      I5 => TSR1_reg(4),
      O => load_val9_carry_i_3_n_0
    );
load_val9_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => TSR1_reg(1),
      I1 => TSR0_reg(1),
      I2 => TSR1_reg(2),
      I3 => TSR0_reg(2),
      I4 => TSR0_reg(0),
      I5 => TSR1_reg(0),
      O => load_val9_carry_i_4_n_0
    );
mwc_reg_reg: unisim.vcomponents.FDSE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => AXI4_LITE_I_n_8,
      Q => p_11_in(0),
      S => bus2ip_reset
    );
wdt_reset_reg_i_7: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => WDT_Current_State(0),
      I1 => WDT_Current_State(1),
      O => wdt_reset_int
    );
wdt_reset_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WINDOW_WDT_CNT_I_n_65,
      Q => \^wdt_reset_reg_reg_0\,
      R => bus2ip_reset
    );
\wdt_state_vec[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => WDT_Current_State(1),
      I1 => WDT_Current_State(0),
      O => WSW_reg
    );
\wdt_state_vec_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WEN_reg,
      Q => \^wdt_state_vec\(0),
      R => bus2ip_reset
    );
\wdt_state_vec_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => WSW_reg,
      Q => \^wdt_state_vec\(1),
      R => bus2ip_reset
    );
\wdt_state_vec_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => fc_sst_enc(0),
      Q => \^wdt_state_vec\(2),
      R => bus2ip_reset
    );
\wdt_state_vec_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => FCV_reg(0),
      Q => \^wdt_state_vec\(3),
      R => bus2ip_reset
    );
\wdt_state_vec_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => FCV_reg(1),
      Q => \^wdt_state_vec\(4),
      R => bus2ip_reset
    );
\wdt_state_vec_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => s_axi_aclk,
      CE => '1',
      D => FCV_reg(2),
      Q => \^wdt_state_vec\(5),
      R => bus2ip_reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top is
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
    freeze : in STD_LOGIC;
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    timebase_interrupt : out STD_LOGIC;
    wdt_interrupt : out STD_LOGIC;
    wdt_reset : out STD_LOGIC;
    wdt_reset_pending : out STD_LOGIC;
    wdt_state_vec : out STD_LOGIC_VECTOR ( 6 downto 0 )
  );
  attribute C_ENABLE_WINDOW_WDT : integer;
  attribute C_ENABLE_WINDOW_WDT of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is "artix7";
  attribute C_MAX_COUNT_WIDTH : integer;
  attribute C_MAX_COUNT_WIDTH of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 32;
  attribute C_SST_COUNT_WIDTH : integer;
  attribute C_SST_COUNT_WIDTH of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 8;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 6;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 32;
  attribute C_WDT_ENABLE_ONCE : integer;
  attribute C_WDT_ENABLE_ONCE of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 1;
  attribute C_WDT_INTERVAL : integer;
  attribute C_WDT_INTERVAL of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is 30;
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top : entity is "axi_timebase_wdt_top";
end mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top is
  signal \<const0>\ : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^s_axi_rresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^wdt_state_vec\ : STD_LOGIC_VECTOR ( 6 downto 0 );
begin
  s_axi_awready <= \^s_axi_awready\;
  s_axi_bresp(1) <= \^s_axi_bresp\(1);
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rresp(1) <= \^s_axi_rresp\(1);
  s_axi_rresp(0) <= \<const0>\;
  s_axi_wready <= \^s_axi_awready\;
  timebase_interrupt <= \<const0>\;
  wdt_state_vec(6 downto 3) <= \^wdt_state_vec\(6 downto 3);
  wdt_state_vec(2) <= \<const0>\;
  wdt_state_vec(1 downto 0) <= \^wdt_state_vec\(1 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
\WINDOW_WDT.axi_window_wdt_i\: entity work.mbv_system_axi_timebase_wdt_0_0_axi_window_wdt
     port map (
      ip2bus_rdack_reg_0 => s_axi_arready,
      is_write_reg => \^s_axi_awready\,
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(3 downto 0) => s_axi_araddr(5 downto 2),
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(3 downto 0) => s_axi_awaddr(5 downto 2),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => \^s_axi_bresp\(1),
      s_axi_bvalid_i_reg => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(0) => \^s_axi_rresp\(1),
      s_axi_rvalid_i_reg => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      wdt_interrupt => wdt_interrupt,
      wdt_reset_pending => wdt_reset_pending,
      wdt_reset_reg_reg_0 => wdt_reset,
      wdt_state_vec(5 downto 2) => \^wdt_state_vec\(6 downto 3),
      wdt_state_vec(1 downto 0) => \^wdt_state_vec\(1 downto 0)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mbv_system_axi_timebase_wdt_0_0 is
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of mbv_system_axi_timebase_wdt_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of mbv_system_axi_timebase_wdt_0_0 : entity is "mbv_system_axi_timebase_wdt_0_0,axi_timebase_wdt_top,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of mbv_system_axi_timebase_wdt_0_0 : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of mbv_system_axi_timebase_wdt_0_0 : entity is "axi_timebase_wdt_top,Vivado 2025.2";
end mbv_system_axi_timebase_wdt_0_0;

architecture STRUCTURE of mbv_system_axi_timebase_wdt_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^s_axi_rresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^wdt_state_vec\ : STD_LOGIC_VECTOR ( 6 downto 0 );
  signal NLW_U0_timebase_interrupt_UNCONNECTED : STD_LOGIC;
  signal NLW_U0_s_axi_bresp_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_s_axi_rresp_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_U0_wdt_state_vec_UNCONNECTED : STD_LOGIC_VECTOR ( 2 to 2 );
  attribute C_ENABLE_WINDOW_WDT : integer;
  attribute C_ENABLE_WINDOW_WDT of U0 : label is 1;
  attribute C_FAMILY : string;
  attribute C_FAMILY of U0 : label is "artix7";
  attribute C_MAX_COUNT_WIDTH : integer;
  attribute C_MAX_COUNT_WIDTH of U0 : label is 32;
  attribute C_SST_COUNT_WIDTH : integer;
  attribute C_SST_COUNT_WIDTH of U0 : label is 8;
  attribute C_S_AXI_ADDR_WIDTH : integer;
  attribute C_S_AXI_ADDR_WIDTH of U0 : label is 6;
  attribute C_S_AXI_DATA_WIDTH : integer;
  attribute C_S_AXI_DATA_WIDTH of U0 : label is 32;
  attribute C_WDT_ENABLE_ONCE : integer;
  attribute C_WDT_ENABLE_ONCE of U0 : label is 1;
  attribute C_WDT_INTERVAL : integer;
  attribute C_WDT_INTERVAL of U0 : label is 30;
  attribute x_interface_info : string;
  attribute x_interface_info of s_axi_aclk : signal is "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of s_axi_aclk : signal is "slave S_AXI_ACLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of s_axi_aclk : signal is "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET s_axi_aresetn:wdt_reset, FREQ_HZ 75000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of s_axi_aresetn : signal is "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST";
  attribute x_interface_mode of s_axi_aresetn : signal is "slave S_AXI_ARESETN";
  attribute x_interface_parameter of s_axi_aresetn : signal is "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARREADY";
  attribute x_interface_info of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARVALID";
  attribute x_interface_info of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWREADY";
  attribute x_interface_info of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWVALID";
  attribute x_interface_info of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 S_AXI BREADY";
  attribute x_interface_info of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI BVALID";
  attribute x_interface_info of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 S_AXI RREADY";
  attribute x_interface_info of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI RVALID";
  attribute x_interface_info of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 S_AXI WREADY";
  attribute x_interface_info of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 S_AXI WVALID";
  attribute x_interface_info of wdt_interrupt : signal is "xilinx.com:signal:interrupt:1.0 WDT_INTERRUPT INTERRUPT";
  attribute x_interface_mode of wdt_interrupt : signal is "master WDT_INTERRUPT";
  attribute x_interface_parameter of wdt_interrupt : signal is "XIL_INTERFACENAME WDT_INTERRUPT, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  attribute x_interface_info of wdt_reset : signal is "xilinx.com:signal:reset:1.0 WDT_RESET RST";
  attribute x_interface_mode of wdt_reset : signal is "master WDT_RESET";
  attribute x_interface_parameter of wdt_reset : signal is "XIL_INTERFACENAME WDT_RESET, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute x_interface_info of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI ARADDR";
  attribute x_interface_mode of s_axi_araddr : signal is "slave S_AXI";
  attribute x_interface_parameter of s_axi_araddr : signal is "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 75000000, ID_WIDTH 0, ADDR_WIDTH 6, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 S_AXI AWADDR";
  attribute x_interface_info of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI BRESP";
  attribute x_interface_info of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI RDATA";
  attribute x_interface_info of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 S_AXI RRESP";
  attribute x_interface_info of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 S_AXI WDATA";
  attribute x_interface_info of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 S_AXI WSTRB";
begin
  s_axi_bresp(1) <= \^s_axi_bresp\(1);
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rresp(1) <= \^s_axi_rresp\(1);
  s_axi_rresp(0) <= \<const0>\;
  wdt_state_vec(6 downto 3) <= \^wdt_state_vec\(6 downto 3);
  wdt_state_vec(2) <= \<const0>\;
  wdt_state_vec(1 downto 0) <= \^wdt_state_vec\(1 downto 0);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top
     port map (
      freeze => '0',
      s_axi_aclk => s_axi_aclk,
      s_axi_araddr(5 downto 2) => s_axi_araddr(5 downto 2),
      s_axi_araddr(1 downto 0) => B"00",
      s_axi_aresetn => s_axi_aresetn,
      s_axi_arready => s_axi_arready,
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(5 downto 2) => s_axi_awaddr(5 downto 2),
      s_axi_awaddr(1 downto 0) => B"00",
      s_axi_awready => s_axi_awready,
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bresp(1) => \^s_axi_bresp\(1),
      s_axi_bresp(0) => NLW_U0_s_axi_bresp_UNCONNECTED(0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1) => \^s_axi_rresp\(1),
      s_axi_rresp(0) => NLW_U0_s_axi_rresp_UNCONNECTED(0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid,
      timebase_interrupt => NLW_U0_timebase_interrupt_UNCONNECTED,
      wdt_interrupt => wdt_interrupt,
      wdt_reset => wdt_reset,
      wdt_reset_pending => wdt_reset_pending,
      wdt_state_vec(6 downto 3) => \^wdt_state_vec\(6 downto 3),
      wdt_state_vec(2) => NLW_U0_wdt_state_vec_UNCONNECTED(2),
      wdt_state_vec(1 downto 0) => \^wdt_state_vec\(1 downto 0)
    );
end STRUCTURE;
