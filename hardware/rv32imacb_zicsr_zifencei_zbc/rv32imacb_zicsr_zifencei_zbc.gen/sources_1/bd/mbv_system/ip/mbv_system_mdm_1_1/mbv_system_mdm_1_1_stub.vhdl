-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
-- Date        : Tue Dec 23 07:28:50 2025
-- Host        : STUDIOPC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top mbv_system_mdm_1_1 -prefix
--               mbv_system_mdm_1_1_ mbv_system_mdm_1_1_stub.vhdl
-- Design      : mbv_system_mdm_1_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mbv_system_mdm_1_1 is
  Port ( 
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

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of mbv_system_mdm_1_1 : entity is "mbv_system_mdm_1_1,mdm_riscv,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of mbv_system_mdm_1_1 : entity is "mbv_system_mdm_1_1,mdm_riscv,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mdm_riscv,x_ipVersion=1.0,x_ipCoreRevision=7,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_FAMILY=artix7,C_DEVICE=xc7a35ti,C_JTAG_CHAIN=2,C_USE_BSCAN=0,C_BSCANID=0,C_USE_BSCAN_SWITCH=0,C_USE_JTAG_BSCAN=1,C_DTM_IDCODE=147,C_DEBUG_INTERFACE=0,C_USE_CONFIG_RESET=0,C_AVOID_PRIMITIVES=0,C_INTERCONNECT=2,C_MB_DBG_PORTS=1,C_USE_UART=0,C_DBG_REG_ACCESS=0,C_DBG_MEM_ACCESS=0,C_USE_CROSS_TRIGGER=0,C_EXT_TRIG_RESET_VALUE=0xF1234,C_TRACE_OUTPUT=1,C_TRACE_DATA_WIDTH=16,C_TRACE_CLK_FREQ_HZ=200000000,C_TRACE_CLK_OUT_PHASE=90,C_TRACE_ASYNC_RESET=0,C_TRACE_PROTOCOL=1,C_TRACE_ID=110,C_S_AXI_ADDR_WIDTH=14,C_S_AXI_DATA_WIDTH=32,C_S_AXI_ACLK_FREQ_HZ=100000000,C_M_AXI_ADDR_WIDTH=34,C_M_AXI_DATA_WIDTH=32,C_M_AXI_THREAD_ID_WIDTH=1,C_ADDR_SIZE=34,C_DATA_SIZE=32,C_LMB_PROTOCOL=0,C_M_AXIS_DATA_WIDTH=32,C_M_AXIS_ID_WIDTH=7}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of mbv_system_mdm_1_1 : entity is "yes";
end mbv_system_mdm_1_1;

architecture stub of mbv_system_mdm_1_1 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "M_AXI_ACLK,M_AXI_ARESETN,Debug_SYS_Rst,TRACE_CLK_OUT,TRACE_CLK,TRACE_CTL,TRACE_DATA[15:0],Dbg_Clk_0,Dbg_TDI_0,Dbg_TDO_0,Dbg_Reg_En_0[0:7],Dbg_Capture_0,Dbg_Shift_0,Dbg_Update_0,Dbg_Rst_0,Dbg_Trig_In_0[0:7],Dbg_TrClk_0,Dbg_TrData_0[0:35],Dbg_TrReady_0,Dbg_TrValid_0,Dbg_Disable_0,Dbg_AWADDR_0[14:2],Dbg_AWVALID_0,Dbg_AWREADY_0,Dbg_WDATA_0[31:0],Dbg_WVALID_0,Dbg_WREADY_0,Dbg_BRESP_0[1:0],Dbg_BVALID_0,Dbg_BREADY_0,Dbg_ARADDR_0[14:2],Dbg_ARVALID_0,Dbg_ARREADY_0,Dbg_RDATA_0[31:0],Dbg_RRESP_0[1:0],Dbg_RVALID_0,Dbg_RREADY_0";
  attribute x_interface_info : string;
  attribute x_interface_info of M_AXI_ACLK : signal is "xilinx.com:signal:clock:1.0 CLK.M_AXI_ACLK CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of M_AXI_ACLK : signal is "slave CLK.M_AXI_ACLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of M_AXI_ACLK : signal is "XIL_INTERFACENAME CLK.M_AXI_ACLK, ASSOCIATED_BUSIF M_AXI:LMB_0:LMB_1:LMB_2:LMB_3:LMB_4:LMB_5:LMB_6:LMB_7:LMB_8:LMB_9:LMB_10:LMB_11:LMB_12:LMB_13:LMB_14:LMB_15:LMB_16:LMB_17:LMB_18:LMB_19:LMB_20:LMB_21:LMB_22:LMB_23:LMB_24:LMB_25:LMB_26:LMB_27:LMB_28:LMB_29:LMB_30:LMB_31, ASSOCIATED_RESET M_AXI_ARESETN, FREQ_HZ 75000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, INSERT_VIP 0";
  attribute x_interface_info of M_AXI_ARESETN : signal is "xilinx.com:signal:reset:1.0 RST.M_AXI_ARESETN RST";
  attribute x_interface_mode of M_AXI_ARESETN : signal is "slave RST.M_AXI_ARESETN";
  attribute x_interface_parameter of M_AXI_ARESETN : signal is "XIL_INTERFACENAME RST.M_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of Debug_SYS_Rst : signal is "xilinx.com:signal:reset:1.0 RST.Debug_SYS_Rst RST";
  attribute x_interface_mode of Debug_SYS_Rst : signal is "master RST.Debug_SYS_Rst";
  attribute x_interface_parameter of Debug_SYS_Rst : signal is "XIL_INTERFACENAME RST.Debug_SYS_Rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0";
  attribute x_interface_info of TRACE_CLK_OUT : signal is "xilinx.com:interface:zynq_trace:1.0 TRACE CLK_O";
  attribute x_interface_mode of TRACE_CLK_OUT : signal is "master TRACE";
  attribute x_interface_info of TRACE_CLK : signal is "xilinx.com:interface:zynq_trace:1.0 TRACE CLK_I";
  attribute x_interface_info of TRACE_CTL : signal is "xilinx.com:interface:zynq_trace:1.0 TRACE CTL";
  attribute x_interface_info of TRACE_DATA : signal is "xilinx.com:interface:zynq_trace:1.0 TRACE DATA";
  attribute x_interface_info of Dbg_Clk_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CLK";
  attribute x_interface_mode of Dbg_Clk_0 : signal is "master MBDEBUG_0";
  attribute x_interface_info of Dbg_TDI_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDI";
  attribute x_interface_info of Dbg_TDO_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDO";
  attribute x_interface_info of Dbg_Reg_En_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 REG_EN";
  attribute x_interface_info of Dbg_Capture_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CAPTURE";
  attribute x_interface_info of Dbg_Shift_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 SHIFT";
  attribute x_interface_info of Dbg_Update_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 UPDATE";
  attribute x_interface_info of Dbg_Rst_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RST";
  attribute x_interface_info of Dbg_Trig_In_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRIG_IN";
  attribute x_interface_info of Dbg_TrClk_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRCLK";
  attribute x_interface_info of Dbg_TrData_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRDATA";
  attribute x_interface_info of Dbg_TrReady_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRREADY";
  attribute x_interface_info of Dbg_TrValid_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRVALID";
  attribute x_interface_info of Dbg_Disable_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 DISABLE";
  attribute x_interface_info of Dbg_AWADDR_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWADDR";
  attribute x_interface_info of Dbg_AWVALID_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWVALID";
  attribute x_interface_info of Dbg_AWREADY_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWREADY";
  attribute x_interface_info of Dbg_WDATA_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WDATA";
  attribute x_interface_info of Dbg_WVALID_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WVALID";
  attribute x_interface_info of Dbg_WREADY_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WREADY";
  attribute x_interface_info of Dbg_BRESP_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BRESP";
  attribute x_interface_info of Dbg_BVALID_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BVALID";
  attribute x_interface_info of Dbg_BREADY_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BREADY";
  attribute x_interface_info of Dbg_ARADDR_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARADDR";
  attribute x_interface_info of Dbg_ARVALID_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARVALID";
  attribute x_interface_info of Dbg_ARREADY_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARREADY";
  attribute x_interface_info of Dbg_RDATA_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RDATA";
  attribute x_interface_info of Dbg_RRESP_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RRESP";
  attribute x_interface_info of Dbg_RVALID_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RVALID";
  attribute x_interface_info of Dbg_RREADY_0 : signal is "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RREADY";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "mdm_riscv,Vivado 2025.2";
begin
end;
