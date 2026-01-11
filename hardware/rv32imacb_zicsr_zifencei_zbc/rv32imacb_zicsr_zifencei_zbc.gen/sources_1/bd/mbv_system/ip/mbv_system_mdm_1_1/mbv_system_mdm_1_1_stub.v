// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Dec 23 07:28:50 2025
// Host        : STUDIOPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top mbv_system_mdm_1_1 -prefix
//               mbv_system_mdm_1_1_ mbv_system_mdm_1_1_stub.v
// Design      : mbv_system_mdm_1_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CHECK_LICENSE_TYPE = "mbv_system_mdm_1_1,mdm_riscv,{}" *) (* core_generation_info = "mbv_system_mdm_1_1,mdm_riscv,{x_ipProduct=Vivado 2025.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=mdm_riscv,x_ipVersion=1.0,x_ipCoreRevision=7,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_FAMILY=artix7,C_DEVICE=xc7a35ti,C_JTAG_CHAIN=2,C_USE_BSCAN=0,C_BSCANID=0,C_USE_BSCAN_SWITCH=0,C_USE_JTAG_BSCAN=1,C_DTM_IDCODE=147,C_DEBUG_INTERFACE=0,C_USE_CONFIG_RESET=0,C_AVOID_PRIMITIVES=0,C_INTERCONNECT=2,C_MB_DBG_PORTS=1,C_USE_UART=0,C_DBG_REG_ACCESS=0,C_DBG_MEM_ACCESS=0,C_USE_CROSS_TRIGGER=0,C_EXT_TRIG_RESET_VALUE=0xF1234,C_TRACE_OUTPUT=1,C_TRACE_DATA_WIDTH=16,C_TRACE_CLK_FREQ_HZ=200000000,C_TRACE_CLK_OUT_PHASE=90,C_TRACE_ASYNC_RESET=0,C_TRACE_PROTOCOL=1,C_TRACE_ID=110,C_S_AXI_ADDR_WIDTH=14,C_S_AXI_DATA_WIDTH=32,C_S_AXI_ACLK_FREQ_HZ=100000000,C_M_AXI_ADDR_WIDTH=34,C_M_AXI_DATA_WIDTH=32,C_M_AXI_THREAD_ID_WIDTH=1,C_ADDR_SIZE=34,C_DATA_SIZE=32,C_LMB_PROTOCOL=0,C_M_AXIS_DATA_WIDTH=32,C_M_AXIS_ID_WIDTH=7}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "mdm_riscv,Vivado 2025.2" *) 
module mbv_system_mdm_1_1(M_AXI_ACLK, M_AXI_ARESETN, Debug_SYS_Rst, 
  TRACE_CLK_OUT, TRACE_CLK, TRACE_CTL, TRACE_DATA, Dbg_Clk_0, Dbg_TDI_0, Dbg_TDO_0, Dbg_Reg_En_0, 
  Dbg_Capture_0, Dbg_Shift_0, Dbg_Update_0, Dbg_Rst_0, Dbg_Trig_In_0, Dbg_TrClk_0, 
  Dbg_TrData_0, Dbg_TrReady_0, Dbg_TrValid_0, Dbg_Disable_0, Dbg_AWADDR_0, Dbg_AWVALID_0, 
  Dbg_AWREADY_0, Dbg_WDATA_0, Dbg_WVALID_0, Dbg_WREADY_0, Dbg_BRESP_0, Dbg_BVALID_0, 
  Dbg_BREADY_0, Dbg_ARADDR_0, Dbg_ARVALID_0, Dbg_ARREADY_0, Dbg_RDATA_0, Dbg_RRESP_0, 
  Dbg_RVALID_0, Dbg_RREADY_0)
/* synthesis syn_black_box black_box_pad_pin="M_AXI_ARESETN,Debug_SYS_Rst,TRACE_CTL,TRACE_DATA[15:0],Dbg_TDI_0,Dbg_TDO_0,Dbg_Reg_En_0[0:7],Dbg_Capture_0,Dbg_Shift_0,Dbg_Rst_0,Dbg_Trig_In_0[0:7],Dbg_TrData_0[0:35],Dbg_TrReady_0,Dbg_TrValid_0,Dbg_Disable_0,Dbg_AWADDR_0[14:2],Dbg_AWVALID_0,Dbg_AWREADY_0,Dbg_WDATA_0[31:0],Dbg_WVALID_0,Dbg_WREADY_0,Dbg_BRESP_0[1:0],Dbg_BVALID_0,Dbg_BREADY_0,Dbg_ARADDR_0[14:2],Dbg_ARVALID_0,Dbg_ARREADY_0,Dbg_RDATA_0[31:0],Dbg_RRESP_0[1:0],Dbg_RVALID_0,Dbg_RREADY_0" */
/* synthesis syn_force_seq_prim="M_AXI_ACLK" */
/* synthesis syn_force_seq_prim="TRACE_CLK_OUT" */
/* synthesis syn_force_seq_prim="TRACE_CLK" */
/* synthesis syn_force_seq_prim="Dbg_Clk_0" */
/* synthesis syn_force_seq_prim="Dbg_Update_0" */
/* synthesis syn_force_seq_prim="Dbg_TrClk_0" */;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 CLK.M_AXI_ACLK CLK" *) (* x_interface_mode = "slave CLK.M_AXI_ACLK" *) (* x_interface_parameter = "XIL_INTERFACENAME CLK.M_AXI_ACLK, ASSOCIATED_BUSIF M_AXI:LMB_0:LMB_1:LMB_2:LMB_3:LMB_4:LMB_5:LMB_6:LMB_7:LMB_8:LMB_9:LMB_10:LMB_11:LMB_12:LMB_13:LMB_14:LMB_15:LMB_16:LMB_17:LMB_18:LMB_19:LMB_20:LMB_21:LMB_22:LMB_23:LMB_24:LMB_25:LMB_26:LMB_27:LMB_28:LMB_29:LMB_30:LMB_31, ASSOCIATED_RESET M_AXI_ARESETN, FREQ_HZ 75000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, INSERT_VIP 0" *) input M_AXI_ACLK /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.M_AXI_ARESETN RST" *) (* x_interface_mode = "slave RST.M_AXI_ARESETN" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.M_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input M_AXI_ARESETN;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 RST.Debug_SYS_Rst RST" *) (* x_interface_mode = "master RST.Debug_SYS_Rst" *) (* x_interface_parameter = "XIL_INTERFACENAME RST.Debug_SYS_Rst, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output Debug_SYS_Rst;
  (* x_interface_info = "xilinx.com:interface:zynq_trace:1.0 TRACE CLK_O" *) (* x_interface_mode = "master TRACE" *) output TRACE_CLK_OUT /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:zynq_trace:1.0 TRACE CLK_I" *) input TRACE_CLK /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:zynq_trace:1.0 TRACE CTL" *) output TRACE_CTL;
  (* x_interface_info = "xilinx.com:interface:zynq_trace:1.0 TRACE DATA" *) output [15:0]TRACE_DATA;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CLK" *) (* x_interface_mode = "master MBDEBUG_0" *) output Dbg_Clk_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDI" *) output Dbg_TDI_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TDO" *) input Dbg_TDO_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 REG_EN" *) output [0:7]Dbg_Reg_En_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 CAPTURE" *) output Dbg_Capture_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 SHIFT" *) output Dbg_Shift_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 UPDATE" *) output Dbg_Update_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RST" *) output Dbg_Rst_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRIG_IN" *) input [0:7]Dbg_Trig_In_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRCLK" *) output Dbg_TrClk_0 /* synthesis syn_isclock = 1 */;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRDATA" *) input [0:35]Dbg_TrData_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRREADY" *) output Dbg_TrReady_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 TRVALID" *) input Dbg_TrValid_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 DISABLE" *) output Dbg_Disable_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWADDR" *) output [14:2]Dbg_AWADDR_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWVALID" *) output Dbg_AWVALID_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 AWREADY" *) input Dbg_AWREADY_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WDATA" *) output [31:0]Dbg_WDATA_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WVALID" *) output Dbg_WVALID_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 WREADY" *) input Dbg_WREADY_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BRESP" *) input [1:0]Dbg_BRESP_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BVALID" *) input Dbg_BVALID_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 BREADY" *) output Dbg_BREADY_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARADDR" *) output [14:2]Dbg_ARADDR_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARVALID" *) output Dbg_ARVALID_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 ARREADY" *) input Dbg_ARREADY_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RDATA" *) input [31:0]Dbg_RDATA_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RRESP" *) input [1:0]Dbg_RRESP_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RVALID" *) input Dbg_RVALID_0;
  (* x_interface_info = "xilinx.com:interface:mbdebug:3.0 MBDEBUG_0 RREADY" *) output Dbg_RREADY_0;
endmodule
