// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.2 (win64) Build 6299465 Fri Nov 14 19:35:11 GMT 2025
// Date        : Tue Dec 23 07:28:33 2025
// Host        : STUDIOPC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               x:/hw/rv32imafcb_zicsr_zifencei_zbc/rv32imafcb_zicsr_zifencei_zbc.gen/sources_1/bd/mbv_system/ip/mbv_system_axi_timebase_wdt_0_0/mbv_system_axi_timebase_wdt_0_0_sim_netlist.v
// Design      : mbv_system_axi_timebase_wdt_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mbv_system_axi_timebase_wdt_0_0,axi_timebase_wdt_top,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "axi_timebase_wdt_top,Vivado 2025.2" *) 
(* NotValidForBitStream *)
module mbv_system_axi_timebase_wdt_0_0
   (s_axi_araddr,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_aclk,
    s_axi_aresetn,
    wdt_interrupt,
    wdt_reset,
    wdt_reset_pending,
    wdt_state_vec);
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *) (* x_interface_mode = "slave S_AXI" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 75000000, ID_WIDTH 0, ADDR_WIDTH 6, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [5:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *) input [5:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *) input s_axi_rready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 S_AXI_ACLK CLK" *) (* x_interface_mode = "slave S_AXI_ACLK" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI_ACLK, ASSOCIATED_BUSIF S_AXI, ASSOCIATED_RESET s_axi_aresetn:wdt_reset, FREQ_HZ 75000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /mbv_clocking_wizard_clk_out1, INSERT_VIP 0" *) input s_axi_aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 S_AXI_ARESETN RST" *) (* x_interface_mode = "slave S_AXI_ARESETN" *) (* x_interface_parameter = "XIL_INTERFACENAME S_AXI_ARESETN, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input s_axi_aresetn;
  (* x_interface_info = "xilinx.com:signal:interrupt:1.0 WDT_INTERRUPT INTERRUPT" *) (* x_interface_mode = "master WDT_INTERRUPT" *) (* x_interface_parameter = "XIL_INTERFACENAME WDT_INTERRUPT, SENSITIVITY LEVEL_HIGH, PortWidth 1" *) output wdt_interrupt;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 WDT_RESET RST" *) (* x_interface_mode = "master WDT_RESET" *) (* x_interface_parameter = "XIL_INTERFACENAME WDT_RESET, POLARITY ACTIVE_HIGH, INSERT_VIP 0" *) output wdt_reset;
  output wdt_reset_pending;
  output [6:0]wdt_state_vec;

  wire \<const0> ;
  wire s_axi_aclk;
  wire [5:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [5:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:1]\^s_axi_bresp ;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:1]\^s_axi_rresp ;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire wdt_interrupt;
  wire wdt_reset;
  wire wdt_reset_pending;
  wire [6:0]\^wdt_state_vec ;
  wire NLW_U0_timebase_interrupt_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [0:0]NLW_U0_s_axi_rresp_UNCONNECTED;
  wire [2:2]NLW_U0_wdt_state_vec_UNCONNECTED;

  assign s_axi_bresp[1] = \^s_axi_bresp [1];
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \^s_axi_rresp [1];
  assign s_axi_rresp[0] = \<const0> ;
  assign wdt_state_vec[6:3] = \^wdt_state_vec [6:3];
  assign wdt_state_vec[2] = \<const0> ;
  assign wdt_state_vec[1:0] = \^wdt_state_vec [1:0];
  GND GND
       (.G(\<const0> ));
  (* C_ENABLE_WINDOW_WDT = "1" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_MAX_COUNT_WIDTH = "32" *) 
  (* C_SST_COUNT_WIDTH = "8" *) 
  (* C_S_AXI_ADDR_WIDTH = "6" *) 
  (* C_S_AXI_DATA_WIDTH = "32" *) 
  (* C_WDT_ENABLE_ONCE = "1" *) 
  (* C_WDT_INTERVAL = "30" *) 
  mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top U0
       (.freeze(1'b0),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr({s_axi_araddr[5:2],1'b0,1'b0}),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(s_axi_arready),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr({s_axi_awaddr[5:2],1'b0,1'b0}),
        .s_axi_awready(s_axi_awready),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp({\^s_axi_bresp ,NLW_U0_s_axi_bresp_UNCONNECTED[0]}),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp({\^s_axi_rresp ,NLW_U0_s_axi_rresp_UNCONNECTED[0]}),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .timebase_interrupt(NLW_U0_timebase_interrupt_UNCONNECTED),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset(wdt_reset),
        .wdt_reset_pending(wdt_reset_pending),
        .wdt_state_vec(\^wdt_state_vec ));
endmodule

(* ORIG_REF_NAME = "address_decoder" *) 
module mbv_system_axi_timebase_wdt_0_0_address_decoder
   (bus2ip_cs,
    E,
    is_write_reg,
    ip2bus_rdack_reg,
    D,
    \state_reg[0] ,
    s_axi_wdata_0_sp_1,
    WEN_clear_reg_reg,
    \TSR1_reg_reg[31] ,
    \FSM_onehot_state_reg[2] ,
    ip2bus_rdack_i,
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0 ,
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0 ,
    WEN_clear_reg0,
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0 ,
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0 ,
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0 ,
    s_axi_wdata_1_sp_1,
    Bus_RNW_reg_reg_0,
    Q,
    s_axi_aclk,
    s_axi_aresetn,
    \state_reg[0]_0 ,
    \FSM_onehot_state_reg[3] ,
    s_axi_arvalid,
    s_axi_bready,
    s_axi_bvalid_i_reg,
    s_axi_wdata,
    WEN_reg_d,
    WEN_reg,
    p_11_in,
    WEN_clear_reg_reg_0,
    WCFG_reg_In,
    \STATUS_I0_WDT.ip2bus_data_reg[15] ,
    \STATUS_I0_WDT.ip2bus_data_reg[8] ,
    \FSM_onehot_state_reg[3]_0 ,
    s_axi_wvalid,
    s_axi_awvalid,
    s_axi_awready,
    ip2bus_rdack,
    s_axi_arready,
    s_axi_arready_0,
    \STATUS_I0_WDT.ip2bus_data_reg[31] ,
    \STATUS_I0_WDT.ip2bus_data_reg[7] ,
    \STATUS_I0_WDT.ip2bus_data_reg[5] ,
    \STATUS_I0_WDT.ip2bus_data_reg[0] ,
    fc_sst_enc,
    PSME_reg,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2 ,
    wdt_interrupt,
    wdt_reset_pending,
    FCV_reg,
    LBE_reg,
    aen_trig,
    Bus_RNW_reg_reg_1,
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 );
  output [0:0]bus2ip_cs;
  output [0:0]E;
  output is_write_reg;
  output ip2bus_rdack_reg;
  output [0:0]D;
  output \state_reg[0] ;
  output s_axi_wdata_0_sp_1;
  output WEN_clear_reg_reg;
  output [31:0]\TSR1_reg_reg[31] ;
  output [1:0]\FSM_onehot_state_reg[2] ;
  output ip2bus_rdack_i;
  output [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0 ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0 ;
  output WEN_clear_reg0;
  output [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0 ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0 ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0 ;
  output s_axi_wdata_1_sp_1;
  output Bus_RNW_reg_reg_0;
  input Q;
  input s_axi_aclk;
  input s_axi_aresetn;
  input [1:0]\state_reg[0]_0 ;
  input \FSM_onehot_state_reg[3] ;
  input s_axi_arvalid;
  input s_axi_bready;
  input s_axi_bvalid_i_reg;
  input [1:0]s_axi_wdata;
  input WEN_reg_d;
  input WEN_reg;
  input [1:0]p_11_in;
  input WEN_clear_reg_reg_0;
  input WCFG_reg_In;
  input [7:0]\STATUS_I0_WDT.ip2bus_data_reg[15] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  input [3:0]\FSM_onehot_state_reg[3]_0 ;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input s_axi_awready;
  input ip2bus_rdack;
  input s_axi_arready;
  input [5:0]s_axi_arready_0;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  input [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  input [1:0]fc_sst_enc;
  input PSME_reg;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  input wdt_interrupt;
  input wdt_reset_pending;
  input [2:0]FCV_reg;
  input [1:0]LBE_reg;
  input aen_trig;
  input Bus_RNW_reg_reg_1;
  input [3:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ;

  wire Bus_RNW_reg;
  wire Bus_RNW_reg_i_1_n_0;
  wire Bus_RNW_reg_reg_0;
  wire Bus_RNW_reg_reg_1;
  wire [0:0]D;
  wire [0:0]E;
  wire [2:0]FCV_reg;
  wire [1:0]\FSM_onehot_state_reg[2] ;
  wire \FSM_onehot_state_reg[3] ;
  wire [3:0]\FSM_onehot_state_reg[3]_0 ;
  wire \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ;
  wire \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0 ;
  wire \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0 ;
  wire \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0 ;
  wire \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0 ;
  wire \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0 ;
  wire [3:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ;
  wire [1:0]LBE_reg;
  wire \MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ;
  wire PSME_reg;
  wire Q;
  wire \STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  wire [7:0]\STATUS_I0_WDT.ip2bus_data_reg[15] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  wire [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  wire [31:0]\TSR1_reg_reg[31] ;
  wire WCFG_reg_In;
  wire WEN_clear_reg0;
  wire WEN_clear_reg_i_2_n_0;
  wire WEN_clear_reg_reg;
  wire WEN_clear_reg_reg_0;
  wire WEN_reg;
  wire WEN_reg_d;
  wire aen_trig;
  wire [0:0]bus2ip_cs;
  wire ce_expnd_i_0;
  wire ce_expnd_i_1;
  wire ce_expnd_i_10;
  wire ce_expnd_i_2;
  wire ce_expnd_i_3;
  wire ce_expnd_i_4;
  wire ce_expnd_i_5;
  wire ce_expnd_i_6;
  wire ce_expnd_i_7;
  wire ce_expnd_i_8;
  wire ce_expnd_i_9;
  wire cs_ce_clr;
  wire [1:0]fc_sst_enc;
  wire ip2bus_rdack;
  wire ip2bus_rdack_i;
  wire ip2bus_rdack_i_2_n_0;
  wire ip2bus_rdack_reg;
  wire is_write_reg;
  wire [1:0]p_11_in;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire [5:0]s_axi_arready_0;
  wire s_axi_arready_INST_0_i_1_n_0;
  wire s_axi_arvalid;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid_i_reg;
  wire [1:0]s_axi_wdata;
  wire s_axi_wdata_0_sn_1;
  wire s_axi_wdata_1_sn_1;
  wire s_axi_wready_INST_0_i_1_n_0;
  wire s_axi_wready_INST_0_i_2_n_0;
  wire s_axi_wready_INST_0_i_3_n_0;
  wire s_axi_wvalid;
  wire \state_reg[0] ;
  wire [1:0]\state_reg[0]_0 ;
  wire wdt_interrupt;
  wire wdt_reset_pending;

  assign s_axi_wdata_0_sp_1 = s_axi_wdata_0_sn_1;
  assign s_axi_wdata_1_sp_1 = s_axi_wdata_1_sn_1;
  LUT3 #(
    .INIT(8'hB8)) 
    Bus_RNW_reg_i_1
       (.I0(Bus_RNW_reg_reg_1),
        .I1(Q),
        .I2(Bus_RNW_reg),
        .O(Bus_RNW_reg_i_1_n_0));
  FDRE Bus_RNW_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(Bus_RNW_reg_i_1_n_0),
        .Q(Bus_RNW_reg),
        .R(1'b0));
  LUT6 #(
    .INIT(64'h4000FFFF40004000)) 
    \FSM_onehot_state[2]_i_1 
       (.I0(s_axi_arvalid),
        .I1(\FSM_onehot_state_reg[3]_0 [0]),
        .I2(s_axi_wvalid),
        .I3(s_axi_awvalid),
        .I4(is_write_reg),
        .I5(\FSM_onehot_state_reg[3]_0 [2]),
        .O(\FSM_onehot_state_reg[2] [0]));
  LUT6 #(
    .INIT(64'hF888F888FFFFF888)) 
    \FSM_onehot_state[3]_i_1 
       (.I0(is_write_reg),
        .I1(\FSM_onehot_state_reg[3]_0 [2]),
        .I2(\FSM_onehot_state_reg[3]_0 [1]),
        .I3(ip2bus_rdack_reg),
        .I4(\FSM_onehot_state_reg[3]_0 [3]),
        .I5(\FSM_onehot_state_reg[3] ),
        .O(\FSM_onehot_state_reg[2] [1]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h0020)) 
    \FW_reg[31]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(p_11_in[0]),
        .I3(WEN_reg),
        .O(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0 ));
  FDRE \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_2),
        .Q(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_1),
        .Q(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg ),
        .R(cs_ce_clr));
  LUT3 #(
    .INIT(8'hFB)) 
    \GEN_BKEND_CE_REGISTERS[12].ce_out_i[12]_i_1 
       (.I0(is_write_reg),
        .I1(s_axi_aresetn),
        .I2(ip2bus_rdack_reg),
        .O(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_0),
        .Q(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_10),
        .Q(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg ),
        .R(cs_ce_clr));
  LUT4 #(
    .INIT(16'h1000)) 
    \GEN_BKEND_CE_REGISTERS[3].ce_out_i[3]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 [2]),
        .I2(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 [1]),
        .O(ce_expnd_i_9));
  FDRE \GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_9),
        .Q(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_8),
        .Q(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_7),
        .Q(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_6),
        .Q(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_5),
        .Q(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_4),
        .Q(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .R(cs_ce_clr));
  FDRE \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] 
       (.C(s_axi_aclk),
        .CE(Q),
        .D(ce_expnd_i_3),
        .Q(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .R(cs_ce_clr));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    \LBE_clear_reg[2]_i_1 
       (.I0(Bus_RNW_reg),
        .I1(p_11_in[0]),
        .I2(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .O(Bus_RNW_reg_reg_0));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9 \MEM_DECODE_GEN[0].PER_CE_GEN[10].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_2(ce_expnd_i_2));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10 \MEM_DECODE_GEN[0].PER_CE_GEN[11].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_1(ce_expnd_i_1));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11 \MEM_DECODE_GEN[0].PER_CE_GEN[12].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_0(ce_expnd_i_0));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1 \MEM_DECODE_GEN[0].PER_CE_GEN[2].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_10(ce_expnd_i_10));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3 \MEM_DECODE_GEN[0].PER_CE_GEN[4].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_8(ce_expnd_i_8));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4 \MEM_DECODE_GEN[0].PER_CE_GEN[5].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_7(ce_expnd_i_7));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5 \MEM_DECODE_GEN[0].PER_CE_GEN[6].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_6(ce_expnd_i_6));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6 \MEM_DECODE_GEN[0].PER_CE_GEN[7].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_5(ce_expnd_i_5));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7 \MEM_DECODE_GEN[0].PER_CE_GEN[8].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_4(ce_expnd_i_4));
  mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8 \MEM_DECODE_GEN[0].PER_CE_GEN[9].MULTIPLE_CES_THIS_CS_GEN.CE_I 
       (.\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ),
        .ce_expnd_i_3(ce_expnd_i_3));
  LUT5 #(
    .INIT(32'h04040400)) 
    \MEM_DECODE_GEN[0].cs_out_i[0]_i_1 
       (.I0(is_write_reg),
        .I1(s_axi_aresetn),
        .I2(ip2bus_rdack_reg),
        .I3(bus2ip_cs),
        .I4(Q),
        .O(\MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ));
  FDRE \MEM_DECODE_GEN[0].cs_out_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\MEM_DECODE_GEN[0].cs_out_i[0]_i_1_n_0 ),
        .Q(bus2ip_cs),
        .R(1'b0));
  LUT6 #(
    .INIT(64'hFFFFFFFFC4440444)) 
    \STATUS_I0_WDT.ip2bus_data[0]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[0] ),
        .I5(\STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [0]));
  LUT5 #(
    .INIT(32'h0000DD0D)) 
    \STATUS_I0_WDT.ip2bus_data[0]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[7] [0]),
        .I1(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31] [0]),
        .I3(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'h8C808080)) 
    \STATUS_I0_WDT.ip2bus_data[0]_i_3 
       (.I0(p_11_in[0]),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I3(WEN_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[0]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \STATUS_I0_WDT.ip2bus_data[0]_i_4 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [0]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [0]),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [0]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[0]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[10]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [10]),
        .I2(\STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [10]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [10]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[10]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [10]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [10]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[10]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[10]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [2]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[10]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[11]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [11]),
        .I2(\STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [11]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [11]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[11]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [11]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [11]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[11]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[11]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[11]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[12]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [12]),
        .I2(\STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [12]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [12]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[12]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [12]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [12]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[12]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[12]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [4]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[12]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[13]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [13]),
        .I2(\STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [13]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [13]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[13]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [13]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [13]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[13]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[13]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [5]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[13]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[14]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [14]),
        .I2(\STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [14]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [14]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[14]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [14]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [14]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[14]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[14]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [6]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[14]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[15]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [15]),
        .I2(\STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [15]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0 ),
        .O(\TSR1_reg_reg[31] [15]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hEFFF)) 
    \STATUS_I0_WDT.ip2bus_data[15]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I3(Bus_RNW_reg),
        .O(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[15]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [15]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [15]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[15]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'hFEFFFFFF)) 
    \STATUS_I0_WDT.ip2bus_data[15]_i_4 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .O(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[15]_i_5 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [7]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[16]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [16]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(wdt_interrupt),
        .O(\TSR1_reg_reg[31] [16]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[16]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [16]),
        .I2(\STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [16]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[16]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [16]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(wdt_interrupt),
        .O(\STATUS_I0_WDT.ip2bus_data[16]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[17]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [17]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(wdt_reset_pending),
        .O(\TSR1_reg_reg[31] [17]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[17]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [17]),
        .I2(\STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [17]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[17]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [17]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(wdt_reset_pending),
        .O(\STATUS_I0_WDT.ip2bus_data[17]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[18]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [18]),
        .I2(\STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [18]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [18]));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[18]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [18]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [18]),
        .O(\STATUS_I0_WDT.ip2bus_data[18]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[19]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [19]),
        .I2(\STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [19]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [19]));
  LUT6 #(
    .INIT(64'h00F4000000440000)) 
    \STATUS_I0_WDT.ip2bus_data[19]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [19]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [19]),
        .O(\STATUS_I0_WDT.ip2bus_data[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFEAAAAAAAEAAAAA)) 
    \STATUS_I0_WDT.ip2bus_data[1]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0 ),
        .I1(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I2(WCFG_reg_In),
        .I3(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(p_11_in[1]),
        .O(\TSR1_reg_reg[31] [1]));
  LUT6 #(
    .INIT(64'h8A88AAAA8A888A88)) 
    \STATUS_I0_WDT.ip2bus_data[1]_i_2 
       (.I0(ip2bus_rdack_i_2_n_0),
        .I1(\STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0 ),
        .I2(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [1]),
        .I4(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[7] [1]),
        .O(\STATUS_I0_WDT.ip2bus_data[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF44F444F444F4)) 
    \STATUS_I0_WDT.ip2bus_data[1]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [1]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [1]),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [1]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[20]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [20]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(FCV_reg[0]),
        .O(\TSR1_reg_reg[31] [20]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[20]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [20]),
        .I2(\STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [20]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF40000040400000)) 
    \STATUS_I0_WDT.ip2bus_data[20]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [20]),
        .I3(FCV_reg[0]),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[20]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[21]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [21]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(FCV_reg[1]),
        .O(\TSR1_reg_reg[31] [21]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[21]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [21]),
        .I2(\STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [21]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[21]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [21]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(FCV_reg[1]),
        .O(\STATUS_I0_WDT.ip2bus_data[21]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[22]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [22]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(FCV_reg[2]),
        .O(\TSR1_reg_reg[31] [22]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[22]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [22]),
        .I2(\STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [22]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[22]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [22]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(FCV_reg[2]),
        .O(\STATUS_I0_WDT.ip2bus_data[22]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[23]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [23]),
        .I2(\STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [23]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [23]));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[23]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [23]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [23]),
        .O(\STATUS_I0_WDT.ip2bus_data[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[24]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [24]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(LBE_reg[0]),
        .O(\TSR1_reg_reg[31] [24]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[24]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [24]),
        .I2(\STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [24]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[24]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [24]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(LBE_reg[0]),
        .O(\STATUS_I0_WDT.ip2bus_data[24]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAEAE00AE00)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [25]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .I5(LBE_reg[1]),
        .O(\TSR1_reg_reg[31] [25]));
  LUT6 #(
    .INIT(64'hF4F4F4F4F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [25]),
        .I2(\STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [25]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFBF)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I5(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[25]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_4 
       (.I0(Bus_RNW_reg),
        .I1(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_5 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[25]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFF00400040004000)) 
    \STATUS_I0_WDT.ip2bus_data[25]_i_6 
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [25]),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(LBE_reg[1]),
        .O(\STATUS_I0_WDT.ip2bus_data[25]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[26]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [26]),
        .I2(\STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [26]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [26]));
  LUT6 #(
    .INIT(64'h00F4000000440000)) 
    \STATUS_I0_WDT.ip2bus_data[26]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [26]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [26]),
        .O(\STATUS_I0_WDT.ip2bus_data[26]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[27]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [27]),
        .I2(\STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [27]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [27]));
  LUT6 #(
    .INIT(64'h00F4000000440000)) 
    \STATUS_I0_WDT.ip2bus_data[27]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [27]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [27]),
        .O(\STATUS_I0_WDT.ip2bus_data[27]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[28]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [28]),
        .I2(\STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [28]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [28]));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[28]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [28]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [28]),
        .O(\STATUS_I0_WDT.ip2bus_data[28]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[29]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [29]),
        .I2(\STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [29]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [29]));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[29]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [29]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [29]),
        .O(\STATUS_I0_WDT.ip2bus_data[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAE00000000)) 
    \STATUS_I0_WDT.ip2bus_data[2]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[7] [2]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I3(fc_sst_enc[0]),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [2]));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[2]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [2]),
        .I2(\STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [2]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    \STATUS_I0_WDT.ip2bus_data[2]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [2]),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I3(fc_sst_enc[0]),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [2]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[2]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[30]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [30]),
        .I2(\STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [30]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [30]));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[30]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [30]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [30]),
        .O(\STATUS_I0_WDT.ip2bus_data[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0 ),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(E));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [31]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [31]),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .O(\TSR1_reg_reg[31] [31]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hCCC8)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h1F)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_4 
       (.I0(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hEEEEEEEA)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_5 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h008F000000880000)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_6 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [31]),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I4(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [31]),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_7 
       (.I0(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_8 
       (.I0(Bus_RNW_reg),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    \STATUS_I0_WDT.ip2bus_data[31]_i_9 
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .O(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAE00000000)) 
    \STATUS_I0_WDT.ip2bus_data[3]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[7] [3]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I3(PSME_reg),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [3]));
  LUT5 #(
    .INIT(32'hAEFFAEAE)) 
    \STATUS_I0_WDT.ip2bus_data[3]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [3]),
        .I2(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31] [3]),
        .O(\STATUS_I0_WDT.ip2bus_data[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    \STATUS_I0_WDT.ip2bus_data[3]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [3]),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I3(PSME_reg),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [3]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAE00000000)) 
    \STATUS_I0_WDT.ip2bus_data[4]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[7] [4]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I3(fc_sst_enc[1]),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [4]));
  LUT5 #(
    .INIT(32'hAEFFAEAE)) 
    \STATUS_I0_WDT.ip2bus_data[4]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [4]),
        .I2(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31] [4]),
        .O(\STATUS_I0_WDT.ip2bus_data[4]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    \STATUS_I0_WDT.ip2bus_data[4]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [4]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [4]),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(fc_sst_enc[1]),
        .O(\STATUS_I0_WDT.ip2bus_data[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF4444F444)) 
    \STATUS_I0_WDT.ip2bus_data[5]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_5_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [5]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[7] [5]),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[5] ),
        .I4(E),
        .I5(\STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [5]));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \STATUS_I0_WDT.ip2bus_data[5]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_7_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [5]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [5]),
        .I3(\STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [5]),
        .I5(\STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFBFF)) 
    \STATUS_I0_WDT.ip2bus_data[5]_i_4 
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I3(Bus_RNW_reg),
        .I4(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I5(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'hFFFFFFDF)) 
    \STATUS_I0_WDT.ip2bus_data[5]_i_5 
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[5]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAE00000000)) 
    \STATUS_I0_WDT.ip2bus_data[6]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[7] [6]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[7]_0 [0]),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [6]));
  LUT5 #(
    .INIT(32'hAEFFAEAE)) 
    \STATUS_I0_WDT.ip2bus_data[6]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [6]),
        .I2(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31] [6]),
        .O(\STATUS_I0_WDT.ip2bus_data[6]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    \STATUS_I0_WDT.ip2bus_data[6]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [6]),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[7]_0 [0]),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [6]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAE00AEAE00000000)) 
    \STATUS_I0_WDT.ip2bus_data[7]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[7] [7]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[7]_0 [1]),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [7]));
  LUT5 #(
    .INIT(32'hF4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[7]_i_2 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31] [7]),
        .I2(\STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [7]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFF7FFFFFFFFFFFF)) 
    \STATUS_I0_WDT.ip2bus_data[7]_i_3 
       (.I0(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I3(\STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0 ),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[7]_1 [1]),
        .I5(\STATUS_I0_WDT.ip2bus_data_reg[7]_1 [0]),
        .O(\STATUS_I0_WDT.ip2bus_data[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFF444F444F444)) 
    \STATUS_I0_WDT.ip2bus_data[7]_i_4 
       (.I0(\STATUS_I0_WDT.ip2bus_data[31]_i_9_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [7]),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[7]_0 [1]),
        .I4(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [7]),
        .I5(\STATUS_I0_WDT.ip2bus_data[31]_i_8_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000FF0D0D)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[15] [0]),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[8] ),
        .I4(\STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[25]_i_4_n_0 ),
        .O(\TSR1_reg_reg[31] [8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_2 
       (.I0(Bus_RNW_reg),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[8]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0D0D000D)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[31] [8]),
        .I1(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I2(\STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [8]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .O(\STATUS_I0_WDT.ip2bus_data[8]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_5 
       (.I0(Bus_RNW_reg),
        .I1(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[8]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_6 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [8]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [8]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[8]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h00000000F4F4FFF4)) 
    \STATUS_I0_WDT.ip2bus_data[9]_i_1 
       (.I0(\STATUS_I0_WDT.ip2bus_data[15]_i_2_n_0 ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_0 [9]),
        .I2(\STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0 ),
        .I3(\STATUS_I0_WDT.ip2bus_data_reg[31] [9]),
        .I4(\STATUS_I0_WDT.ip2bus_data[15]_i_4_n_0 ),
        .I5(\STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0 ),
        .O(\TSR1_reg_reg[31] [9]));
  LUT6 #(
    .INIT(64'hFFFF0000F0880000)) 
    \STATUS_I0_WDT.ip2bus_data[9]_i_2 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\STATUS_I0_WDT.ip2bus_data_reg[31]_1 [9]),
        .I2(\STATUS_I0_WDT.ip2bus_data_reg[31]_2 [9]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I4(Bus_RNW_reg),
        .I5(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[9]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hF0F0F040)) 
    \STATUS_I0_WDT.ip2bus_data[9]_i_3 
       (.I0(\STATUS_I0_WDT.ip2bus_data_reg[15] [1]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I2(Bus_RNW_reg),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I4(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(\STATUS_I0_WDT.ip2bus_data[9]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h0020)) 
    \SW_reg[31]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(p_11_in[0]),
        .I3(WEN_reg),
        .O(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \TSR0_reg[31]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I1(p_11_in[0]),
        .I2(Bus_RNW_reg),
        .O(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h08)) 
    \TSR1_reg[31]_i_1 
       (.I0(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I1(p_11_in[0]),
        .I2(Bus_RNW_reg),
        .O(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'h0020)) 
    WDP_reg_i_1
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(Bus_RNW_reg),
        .I2(p_11_in[0]),
        .I3(WEN_reg),
        .O(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h08)) 
    WEN_change_i_1
       (.I0(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I1(p_11_in[0]),
        .I2(Bus_RNW_reg),
        .O(WEN_clear_reg0));
  LUT6 #(
    .INIT(64'h00000000BA8A0000)) 
    WEN_clear_reg_i_1
       (.I0(WEN_clear_reg_reg_0),
        .I1(WEN_clear_reg_i_2_n_0),
        .I2(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I3(s_axi_wdata[0]),
        .I4(s_axi_aresetn),
        .I5(WCFG_reg_In),
        .O(WEN_clear_reg_reg));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'hB)) 
    WEN_clear_reg_i_2
       (.I0(Bus_RNW_reg),
        .I1(p_11_in[0]),
        .O(WEN_clear_reg_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFEF0020)) 
    aen_reg_i_1
       (.I0(s_axi_wdata[1]),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I3(aen_trig),
        .I4(p_11_in[1]),
        .O(s_axi_wdata_1_sn_1));
  LUT6 #(
    .INIT(64'hFEFFFFFFF0FFF0FF)) 
    ip2bus_rdack_i_1
       (.I0(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .I2(\STATUS_I0_WDT.ip2bus_data[31]_i_3_n_0 ),
        .I3(ip2bus_rdack_i_2_n_0),
        .I4(s_axi_wready_INST_0_i_3_n_0),
        .I5(Bus_RNW_reg),
        .O(ip2bus_rdack_i));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    ip2bus_rdack_i_2
       (.I0(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I3(Bus_RNW_reg),
        .O(ip2bus_rdack_i_2_n_0));
  LUT6 #(
    .INIT(64'hEF00EFEF20002020)) 
    mwc_reg_i_1
       (.I0(s_axi_wdata[0]),
        .I1(Bus_RNW_reg),
        .I2(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .I3(WEN_reg_d),
        .I4(WEN_reg),
        .I5(p_11_in[0]),
        .O(s_axi_wdata_0_sn_1));
  LUT3 #(
    .INIT(8'hBA)) 
    s_axi_arready_INST_0
       (.I0(ip2bus_rdack),
        .I1(s_axi_arready_INST_0_i_1_n_0),
        .I2(s_axi_arready),
        .O(ip2bus_rdack_reg));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFB)) 
    s_axi_arready_INST_0_i_1
       (.I0(s_axi_arready_0[4]),
        .I1(s_axi_arready_0[5]),
        .I2(s_axi_arready_0[3]),
        .I3(s_axi_arready_0[2]),
        .I4(s_axi_arready_0[0]),
        .I5(s_axi_arready_0[1]),
        .O(s_axi_arready_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'h20FF2020)) 
    s_axi_bvalid_i_i_1
       (.I0(is_write_reg),
        .I1(\state_reg[0]_0 [0]),
        .I2(\state_reg[0]_0 [1]),
        .I3(s_axi_bready),
        .I4(s_axi_bvalid_i_reg),
        .O(\state_reg[0] ));
  LUT6 #(
    .INIT(64'h4F4F4F444F4F4F4F)) 
    s_axi_wready_INST_0
       (.I0(s_axi_arready_INST_0_i_1_n_0),
        .I1(s_axi_awready),
        .I2(Bus_RNW_reg),
        .I3(s_axi_wready_INST_0_i_1_n_0),
        .I4(s_axi_wready_INST_0_i_2_n_0),
        .I5(s_axi_wready_INST_0_i_3_n_0),
        .O(is_write_reg));
  LUT4 #(
    .INIT(16'hFFFE)) 
    s_axi_wready_INST_0_i_1
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[3].ce_out_i_reg ),
        .O(s_axi_wready_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    s_axi_wready_INST_0_i_2
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg ),
        .I3(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg ),
        .O(s_axi_wready_INST_0_i_2_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    s_axi_wready_INST_0_i_3
       (.I0(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg ),
        .I1(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg ),
        .I2(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg ),
        .O(s_axi_wready_INST_0_i_3_n_0));
  LUT5 #(
    .INIT(32'h2FEF2CEC)) 
    \state[0]_i_1 
       (.I0(is_write_reg),
        .I1(\state_reg[0]_0 [0]),
        .I2(\state_reg[0]_0 [1]),
        .I3(\FSM_onehot_state_reg[3] ),
        .I4(s_axi_arvalid),
        .O(D));
endmodule

(* ORIG_REF_NAME = "axi_lite_ipif" *) 
module mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif
   (s_axi_rresp,
    bus2ip_rnw_i_reg,
    bus2ip_cs,
    s_axi_rvalid_i_reg,
    s_axi_bvalid_i_reg,
    E,
    is_write_reg,
    ip2bus_rdack_reg,
    s_axi_wdata_0_sp_1,
    WEN_clear_reg_reg,
    D,
    ip2bus_rdack_i,
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ,
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ,
    WEN_clear_reg0,
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ,
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ,
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ,
    s_axi_wdata_1_sp_1,
    Bus_RNW_reg_reg,
    s_axi_bresp,
    s_axi_rdata,
    SR,
    s_axi_aclk,
    ip2bus_error,
    s_axi_arvalid,
    s_axi_aresetn,
    s_axi_bready,
    s_axi_wdata,
    WEN_reg_d,
    WEN_reg,
    p_11_in,
    WEN_clear_reg_reg_0,
    WCFG_reg_In,
    Q,
    \STATUS_I0_WDT.ip2bus_data_reg[8] ,
    s_axi_wvalid,
    s_axi_awvalid,
    ip2bus_rdack,
    \STATUS_I0_WDT.ip2bus_data_reg[31] ,
    \STATUS_I0_WDT.ip2bus_data_reg[7] ,
    \STATUS_I0_WDT.ip2bus_data_reg[5] ,
    \STATUS_I0_WDT.ip2bus_data_reg[0] ,
    fc_sst_enc,
    PSME_reg,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1 ,
    s_axi_rready,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2 ,
    wdt_interrupt,
    wdt_reset_pending,
    FCV_reg,
    LBE_reg,
    s_axi_araddr,
    s_axi_awaddr,
    aen_trig,
    \s_axi_rdata_i_reg[31] );
  output [0:0]s_axi_rresp;
  output bus2ip_rnw_i_reg;
  output [0:0]bus2ip_cs;
  output s_axi_rvalid_i_reg;
  output s_axi_bvalid_i_reg;
  output [0:0]E;
  output is_write_reg;
  output ip2bus_rdack_reg;
  output s_axi_wdata_0_sp_1;
  output WEN_clear_reg_reg;
  output [31:0]D;
  output ip2bus_rdack_i;
  output [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;
  output WEN_clear_reg0;
  output [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;
  output s_axi_wdata_1_sp_1;
  output Bus_RNW_reg_reg;
  output [0:0]s_axi_bresp;
  output [31:0]s_axi_rdata;
  input [0:0]SR;
  input s_axi_aclk;
  input ip2bus_error;
  input s_axi_arvalid;
  input s_axi_aresetn;
  input s_axi_bready;
  input [1:0]s_axi_wdata;
  input WEN_reg_d;
  input WEN_reg;
  input [1:0]p_11_in;
  input WEN_clear_reg_reg_0;
  input WCFG_reg_In;
  input [7:0]Q;
  input \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input ip2bus_rdack;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  input [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  input [1:0]fc_sst_enc;
  input PSME_reg;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  input s_axi_rready;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  input wdt_interrupt;
  input wdt_reset_pending;
  input [2:0]FCV_reg;
  input [1:0]LBE_reg;
  input [3:0]s_axi_araddr;
  input [3:0]s_axi_awaddr;
  input aen_trig;
  input [31:0]\s_axi_rdata_i_reg[31] ;

  wire Bus_RNW_reg_reg;
  wire [31:0]D;
  wire [0:0]E;
  wire [2:0]FCV_reg;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;
  wire [1:0]LBE_reg;
  wire PSME_reg;
  wire [7:0]Q;
  wire [0:0]SR;
  wire \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  wire [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  wire WCFG_reg_In;
  wire WEN_clear_reg0;
  wire WEN_clear_reg_reg;
  wire WEN_clear_reg_reg_0;
  wire WEN_reg;
  wire WEN_reg_d;
  wire aen_trig;
  wire [0:0]bus2ip_cs;
  wire bus2ip_rnw_i_reg;
  wire [1:0]fc_sst_enc;
  wire ip2bus_error;
  wire ip2bus_rdack;
  wire ip2bus_rdack_i;
  wire ip2bus_rdack_reg;
  wire is_write_reg;
  wire [1:0]p_11_in;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire [3:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire s_axi_bvalid_i_reg;
  wire [31:0]s_axi_rdata;
  wire [31:0]\s_axi_rdata_i_reg[31] ;
  wire s_axi_rready;
  wire [0:0]s_axi_rresp;
  wire s_axi_rvalid_i_reg;
  wire [1:0]s_axi_wdata;
  wire s_axi_wdata_0_sn_1;
  wire s_axi_wdata_1_sn_1;
  wire s_axi_wvalid;
  wire wdt_interrupt;
  wire wdt_reset_pending;

  assign s_axi_wdata_0_sp_1 = s_axi_wdata_0_sn_1;
  assign s_axi_wdata_1_sp_1 = s_axi_wdata_1_sn_1;
  mbv_system_axi_timebase_wdt_0_0_slave_attachment I_SLAVE_ATTACHMENT
       (.Bus_RNW_reg_reg(Bus_RNW_reg_reg),
        .D(D),
        .E(E),
        .FCV_reg(FCV_reg),
        .\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] (\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ),
        .\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] (\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ),
        .\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] (\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ),
        .\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] (\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ),
        .\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ),
        .LBE_reg(LBE_reg),
        .PSME_reg(PSME_reg),
        .Q(Q),
        .SR(SR),
        .\STATUS_I0_WDT.ip2bus_data_reg[0] (\STATUS_I0_WDT.ip2bus_data_reg[0] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31] (\STATUS_I0_WDT.ip2bus_data_reg[31] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_0 (\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_1 (\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_2 (\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[5] (\STATUS_I0_WDT.ip2bus_data_reg[5] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7] (\STATUS_I0_WDT.ip2bus_data_reg[7] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_0 (\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_1 (\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[8] (\STATUS_I0_WDT.ip2bus_data_reg[8] ),
        .WCFG_reg_In(WCFG_reg_In),
        .WEN_clear_reg0(WEN_clear_reg0),
        .WEN_clear_reg_reg(WEN_clear_reg_reg),
        .WEN_clear_reg_reg_0(WEN_clear_reg_reg_0),
        .WEN_reg(WEN_reg),
        .WEN_reg_d(WEN_reg_d),
        .aen_trig(aen_trig),
        .bus2ip_cs(bus2ip_cs),
        .bus2ip_rnw_i_reg_0(bus2ip_rnw_i_reg),
        .fc_sst_enc(fc_sst_enc),
        .ip2bus_error(ip2bus_error),
        .ip2bus_rdack(ip2bus_rdack),
        .ip2bus_rdack_i(ip2bus_rdack_i),
        .ip2bus_rdack_reg(ip2bus_rdack_reg),
        .is_write_reg_0(is_write_reg),
        .p_11_in(p_11_in),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid_i_reg_0(s_axi_bvalid_i_reg),
        .s_axi_rdata(s_axi_rdata),
        .\s_axi_rdata_i_reg[31]_0 (\s_axi_rdata_i_reg[31] ),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid_i_reg_0(s_axi_rvalid_i_reg),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wdata_0_sp_1(s_axi_wdata_0_sn_1),
        .s_axi_wdata_1_sp_1(s_axi_wdata_1_sn_1),
        .s_axi_wvalid(s_axi_wvalid),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset_pending(wdt_reset_pending));
endmodule

(* C_ENABLE_WINDOW_WDT = "1" *) (* C_FAMILY = "artix7" *) (* C_MAX_COUNT_WIDTH = "32" *) 
(* C_SST_COUNT_WIDTH = "8" *) (* C_S_AXI_ADDR_WIDTH = "6" *) (* C_S_AXI_DATA_WIDTH = "32" *) 
(* C_WDT_ENABLE_ONCE = "1" *) (* C_WDT_INTERVAL = "30" *) (* ORIG_REF_NAME = "axi_timebase_wdt_top" *) 
module mbv_system_axi_timebase_wdt_0_0_axi_timebase_wdt_top
   (s_axi_araddr,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    freeze,
    s_axi_aclk,
    s_axi_aresetn,
    timebase_interrupt,
    wdt_interrupt,
    wdt_reset,
    wdt_reset_pending,
    wdt_state_vec);
  input [5:0]s_axi_araddr;
  output s_axi_arready;
  input s_axi_arvalid;
  input [5:0]s_axi_awaddr;
  output s_axi_awready;
  input s_axi_awvalid;
  input s_axi_bready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  output [31:0]s_axi_rdata;
  input s_axi_rready;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input [31:0]s_axi_wdata;
  output s_axi_wready;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  input freeze;
  input s_axi_aclk;
  input s_axi_aresetn;
  output timebase_interrupt;
  output wdt_interrupt;
  output wdt_reset;
  output wdt_reset_pending;
  output [6:0]wdt_state_vec;

  wire \<const0> ;
  wire s_axi_aclk;
  wire [5:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arready;
  wire s_axi_arvalid;
  wire [5:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [1:1]\^s_axi_bresp ;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [1:1]\^s_axi_rresp ;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire wdt_interrupt;
  wire wdt_reset;
  wire wdt_reset_pending;
  wire [6:0]\^wdt_state_vec ;

  assign s_axi_bresp[1] = \^s_axi_bresp [1];
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \^s_axi_rresp [1];
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_wready = s_axi_awready;
  assign timebase_interrupt = \<const0> ;
  assign wdt_state_vec[6:3] = \^wdt_state_vec [6:3];
  assign wdt_state_vec[2] = \<const0> ;
  assign wdt_state_vec[1:0] = \^wdt_state_vec [1:0];
  GND GND
       (.G(\<const0> ));
  mbv_system_axi_timebase_wdt_0_0_axi_window_wdt \WINDOW_WDT.axi_window_wdt_i 
       (.ip2bus_rdack_reg_0(s_axi_arready),
        .is_write_reg(s_axi_awready),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr[5:2]),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[5:2]),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(\^s_axi_bresp ),
        .s_axi_bvalid_i_reg(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(\^s_axi_rresp ),
        .s_axi_rvalid_i_reg(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset_pending(wdt_reset_pending),
        .wdt_reset_reg_reg_0(wdt_reset),
        .wdt_state_vec({\^wdt_state_vec [6:3],\^wdt_state_vec [1:0]}));
endmodule

(* ORIG_REF_NAME = "axi_window_wdt" *) 
module mbv_system_axi_timebase_wdt_0_0_axi_window_wdt
   (is_write_reg,
    ip2bus_rdack_reg_0,
    s_axi_bvalid_i_reg,
    s_axi_bresp,
    s_axi_rdata,
    s_axi_rresp,
    wdt_interrupt,
    wdt_state_vec,
    wdt_reset_reg_reg_0,
    s_axi_rvalid_i_reg,
    wdt_reset_pending,
    s_axi_aresetn,
    s_axi_arvalid,
    s_axi_bready,
    s_axi_aclk,
    s_axi_wvalid,
    s_axi_awvalid,
    s_axi_wdata,
    s_axi_rready,
    s_axi_araddr,
    s_axi_awaddr,
    s_axi_wstrb);
  output is_write_reg;
  output ip2bus_rdack_reg_0;
  output s_axi_bvalid_i_reg;
  output [0:0]s_axi_bresp;
  output [31:0]s_axi_rdata;
  output [0:0]s_axi_rresp;
  output wdt_interrupt;
  output [5:0]wdt_state_vec;
  output wdt_reset_reg_reg_0;
  output s_axi_rvalid_i_reg;
  output wdt_reset_pending;
  input s_axi_aresetn;
  input s_axi_arvalid;
  input s_axi_bready;
  input s_axi_aclk;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input [31:0]s_axi_wdata;
  input s_axi_rready;
  input [3:0]s_axi_araddr;
  input [3:0]s_axi_awaddr;
  input [3:0]s_axi_wstrb;

  wire AXI4_LITE_I_n_1;
  wire AXI4_LITE_I_n_49;
  wire AXI4_LITE_I_n_5;
  wire AXI4_LITE_I_n_50;
  wire AXI4_LITE_I_n_8;
  wire AXI4_LITE_I_n_9;
  wire [1:0]BSS_reg;
  wire [2:0]FCV_reg;
  wire [31:0]FW_reg;
  wire FW_reg0;
  wire [2:0]LBE_clear_reg;
  wire [1:0]LBE_reg;
  wire LBE_reg0;
  wire \LBE_reg[1]_i_2_n_0 ;
  wire PSME_reg;
  wire [7:0]SBC_reg;
  wire SBC_reg0;
  wire \STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[0] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[10] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[11] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[12] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[13] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[14] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[15] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[16] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[17] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[18] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[19] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[1] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[20] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[21] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[22] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[23] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[24] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[25] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[26] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[27] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[28] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[29] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[2] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[30] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[31] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[3] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[4] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[5] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[6] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[7] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[8] ;
  wire \STATUS_I0_WDT.ip2bus_data_reg_n_0_[9] ;
  wire [31:0]SW_reg;
  wire SW_reg0;
  wire [31:0]TSR0_reg;
  wire TSR0_reg0;
  wire [31:0]TSR1_reg;
  wire TSR1_reg0;
  wire WCFG_clear_reg_reg_n_0;
  wire WCFG_reg_In;
  wire WDP_reg_reg_n_0;
  wire [1:0]WDT_Current_State;
  wire WEN_change;
  wire WEN_clear_reg0;
  wire WEN_clear_reg_reg_n_0;
  wire WEN_reg;
  wire WEN_reg_cleark;
  wire WEN_reg_d;
  wire WINDOW_WDT_CNT_I_n_41;
  wire WINDOW_WDT_CNT_I_n_42;
  wire WINDOW_WDT_CNT_I_n_43;
  wire WINDOW_WDT_CNT_I_n_44;
  wire WINDOW_WDT_CNT_I_n_45;
  wire WINDOW_WDT_CNT_I_n_46;
  wire WINDOW_WDT_CNT_I_n_47;
  wire WINDOW_WDT_CNT_I_n_48;
  wire WINDOW_WDT_CNT_I_n_49;
  wire WINDOW_WDT_CNT_I_n_50;
  wire WINDOW_WDT_CNT_I_n_51;
  wire WINDOW_WDT_CNT_I_n_52;
  wire WINDOW_WDT_CNT_I_n_53;
  wire WINDOW_WDT_CNT_I_n_54;
  wire WINDOW_WDT_CNT_I_n_55;
  wire WINDOW_WDT_CNT_I_n_56;
  wire WINDOW_WDT_CNT_I_n_57;
  wire WINDOW_WDT_CNT_I_n_58;
  wire WINDOW_WDT_CNT_I_n_60;
  wire WINDOW_WDT_CNT_I_n_61;
  wire WINDOW_WDT_CNT_I_n_62;
  wire WINDOW_WDT_CNT_I_n_63;
  wire WINDOW_WDT_CNT_I_n_64;
  wire WINDOW_WDT_CNT_I_n_65;
  wire WINDOW_WDT_FAIL_CNT_I_n_0;
  wire WINDOW_WDT_FAIL_CNT_I_n_10;
  wire WINDOW_WDT_FAIL_CNT_I_n_11;
  wire WINDOW_WDT_FAIL_CNT_I_n_12;
  wire WINDOW_WDT_FAIL_CNT_I_n_13;
  wire WINDOW_WDT_FAIL_CNT_I_n_4;
  wire WINDOW_WDT_FAIL_CNT_I_n_46;
  wire WINDOW_WDT_FAIL_CNT_I_n_47;
  wire WINDOW_WDT_FAIL_CNT_I_n_48;
  wire WINDOW_WDT_FAIL_CNT_I_n_49;
  wire WINDOW_WDT_FAIL_CNT_I_n_5;
  wire WINDOW_WDT_FAIL_CNT_I_n_50;
  wire WINDOW_WDT_FAIL_CNT_I_n_51;
  wire WINDOW_WDT_FAIL_CNT_I_n_6;
  wire WINDOW_WDT_FAIL_CNT_I_n_7;
  wire WINDOW_WDT_FAIL_CNT_I_n_9;
  wire WINT_clear_reg_reg_n_0;
  wire WRP_clear_reg_reg_n_0;
  wire WRP_reg_i_1_n_0;
  wire WSW_clear_reg_reg_n_0;
  wire WSW_reg;
  wire aen_trig;
  wire aen_trig_i_1_n_0;
  wire [0:0]bus2ip_cs;
  wire bus2ip_reset;
  wire cnt_wrp;
  wire cnt_wrp_i_1_n_0;
  wire dis_wdt_cnt;
  wire [1:0]fc_sst_enc;
  wire [31:0]ip2bus_data;
  wire ip2bus_error__0;
  wire ip2bus_rdack;
  wire ip2bus_rdack_i;
  wire ip2bus_rdack_reg_0;
  wire is_write_reg;
  wire load_val9;
  wire load_val9_carry__0_i_1_n_0;
  wire load_val9_carry__0_i_2_n_0;
  wire load_val9_carry__0_i_3_n_0;
  wire load_val9_carry__0_i_4_n_0;
  wire load_val9_carry__0_n_0;
  wire load_val9_carry__0_n_1;
  wire load_val9_carry__0_n_2;
  wire load_val9_carry__0_n_3;
  wire load_val9_carry__1_n_2;
  wire load_val9_carry__1_n_3;
  wire load_val9_carry_i_1_n_0;
  wire load_val9_carry_i_2_n_0;
  wire load_val9_carry_i_3_n_0;
  wire load_val9_carry_i_4_n_0;
  wire load_val9_carry_n_0;
  wire load_val9_carry_n_1;
  wire load_val9_carry_n_2;
  wire load_val9_carry_n_3;
  wire [31:1]minusOp;
  wire [1:0]p_11_in;
  wire [31:0]p_1_in;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire [3:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire s_axi_bvalid_i_reg;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire [0:0]s_axi_rresp;
  wire s_axi_rvalid_i_reg;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire [7:0]wdt_cnt_val;
  wire wdt_interrupt;
  wire wdt_reset_int;
  wire wdt_reset_pending;
  wire wdt_reset_reg_reg_0;
  wire [5:0]wdt_state_vec;
  wire wint_int;
  wire [3:0]NLW_load_val9_carry_O_UNCONNECTED;
  wire [3:0]NLW_load_val9_carry__0_O_UNCONNECTED;
  wire [3:3]NLW_load_val9_carry__1_CO_UNCONNECTED;
  wire [3:0]NLW_load_val9_carry__1_O_UNCONNECTED;

  mbv_system_axi_timebase_wdt_0_0_axi_lite_ipif AXI4_LITE_I
       (.Bus_RNW_reg_reg(AXI4_LITE_I_n_50),
        .D(ip2bus_data),
        .E(AXI4_LITE_I_n_5),
        .FCV_reg(FCV_reg),
        .\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] (SBC_reg0),
        .\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] (FW_reg0),
        .\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] (SW_reg0),
        .\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] (TSR0_reg0),
        .\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] (TSR1_reg0),
        .LBE_reg(LBE_reg),
        .PSME_reg(PSME_reg),
        .Q(SBC_reg),
        .SR(bus2ip_reset),
        .\STATUS_I0_WDT.ip2bus_data_reg[0] (WDP_reg_reg_n_0),
        .\STATUS_I0_WDT.ip2bus_data_reg[31] (TSR1_reg),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_0 (TSR0_reg),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_1 (SW_reg),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_2 (FW_reg),
        .\STATUS_I0_WDT.ip2bus_data_reg[5] (\STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7] (wdt_cnt_val),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_0 (BSS_reg),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_1 (WDT_Current_State),
        .\STATUS_I0_WDT.ip2bus_data_reg[8] (WINDOW_WDT_FAIL_CNT_I_n_4),
        .WCFG_reg_In(WCFG_reg_In),
        .WEN_clear_reg0(WEN_clear_reg0),
        .WEN_clear_reg_reg(AXI4_LITE_I_n_9),
        .WEN_clear_reg_reg_0(WEN_clear_reg_reg_n_0),
        .WEN_reg(WEN_reg),
        .WEN_reg_d(WEN_reg_d),
        .aen_trig(aen_trig),
        .bus2ip_cs(bus2ip_cs),
        .bus2ip_rnw_i_reg(AXI4_LITE_I_n_1),
        .fc_sst_enc(fc_sst_enc),
        .ip2bus_error(ip2bus_error__0),
        .ip2bus_rdack(ip2bus_rdack),
        .ip2bus_rdack_i(ip2bus_rdack_i),
        .ip2bus_rdack_reg(ip2bus_rdack_reg_0),
        .is_write_reg(is_write_reg),
        .p_11_in(p_11_in),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid_i_reg(s_axi_bvalid_i_reg),
        .s_axi_rdata(s_axi_rdata),
        .\s_axi_rdata_i_reg[31] ({\STATUS_I0_WDT.ip2bus_data_reg_n_0_[31] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[30] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[29] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[28] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[27] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[26] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[25] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[24] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[23] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[22] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[21] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[20] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[19] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[18] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[17] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[16] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[15] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[14] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[13] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[12] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[11] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[10] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[9] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[8] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[7] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[6] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[5] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[4] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[3] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[2] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[1] ,\STATUS_I0_WDT.ip2bus_data_reg_n_0_[0] }),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid_i_reg(s_axi_rvalid_i_reg),
        .s_axi_wdata(s_axi_wdata[1:0]),
        .s_axi_wdata_0_sp_1(AXI4_LITE_I_n_8),
        .s_axi_wdata_1_sp_1(AXI4_LITE_I_n_49),
        .s_axi_wvalid(s_axi_wvalid),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset_pending(wdt_reset_pending));
  FDRE \BSS_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[6]),
        .Q(BSS_reg[0]),
        .R(bus2ip_reset));
  FDRE \BSS_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[7]),
        .Q(BSS_reg[1]),
        .R(bus2ip_reset));
  FDRE FCE_reg_reg
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[2]),
        .Q(fc_sst_enc[0]),
        .R(bus2ip_reset));
  (* FSM_ENCODED_STATES = "first_window:01,second_window:10,sste_state:11,idle:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_WDT_Current_State_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_CNT_I_n_46),
        .Q(WDT_Current_State[0]),
        .R(bus2ip_reset));
  (* FSM_ENCODED_STATES = "first_window:01,second_window:10,sste_state:11,idle:00" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_sequential_WDT_Current_State_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_CNT_I_n_45),
        .Q(WDT_Current_State[1]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[0]),
        .Q(FW_reg[0]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[10]),
        .Q(FW_reg[10]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[11]),
        .Q(FW_reg[11]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[12]),
        .Q(FW_reg[12]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[13]),
        .Q(FW_reg[13]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[14]),
        .Q(FW_reg[14]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[15]),
        .Q(FW_reg[15]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[16]),
        .Q(FW_reg[16]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[17]),
        .Q(FW_reg[17]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[18]),
        .Q(FW_reg[18]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[19]),
        .Q(FW_reg[19]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[1]),
        .Q(FW_reg[1]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[20]),
        .Q(FW_reg[20]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[21]),
        .Q(FW_reg[21]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[22]),
        .Q(FW_reg[22]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[23]),
        .Q(FW_reg[23]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[24]),
        .Q(FW_reg[24]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[25]),
        .Q(FW_reg[25]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[26]),
        .Q(FW_reg[26]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[27]),
        .Q(FW_reg[27]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[28]),
        .Q(FW_reg[28]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[29]),
        .Q(FW_reg[29]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[2]),
        .Q(FW_reg[2]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[30]),
        .Q(FW_reg[30]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[31]),
        .Q(FW_reg[31]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[3]),
        .Q(FW_reg[3]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[4]),
        .Q(FW_reg[4]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[5]),
        .Q(FW_reg[5]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[6]),
        .Q(FW_reg[6]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[7]),
        .Q(FW_reg[7]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[8]),
        .Q(FW_reg[8]),
        .R(bus2ip_reset));
  FDRE \FW_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(FW_reg0),
        .D(s_axi_wdata[9]),
        .Q(FW_reg[9]),
        .R(bus2ip_reset));
  FDRE \LBE_clear_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[24]),
        .Q(LBE_clear_reg[0]),
        .R(AXI4_LITE_I_n_50));
  FDRE \LBE_clear_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[25]),
        .Q(LBE_clear_reg[1]),
        .R(AXI4_LITE_I_n_50));
  FDRE \LBE_clear_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[26]),
        .Q(LBE_clear_reg[2]),
        .R(AXI4_LITE_I_n_50));
  LUT6 #(
    .INIT(64'hBBBBBBBBBBBABBBB)) 
    \LBE_reg[1]_i_2 
       (.I0(WDT_Current_State[1]),
        .I1(WSW_clear_reg_reg_n_0),
        .I2(WDP_reg_reg_n_0),
        .I3(p_11_in[1]),
        .I4(WEN_change),
        .I5(WEN_clear_reg_reg_n_0),
        .O(\LBE_reg[1]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0080)) 
    \LBE_reg[1]_i_3 
       (.I0(LBE_clear_reg[0]),
        .I1(LBE_clear_reg[2]),
        .I2(LBE_clear_reg[1]),
        .I3(wdt_reset_reg_reg_0),
        .O(LBE_reg0));
  FDRE #(
    .INIT(1'b0)) 
    \LBE_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_CNT_I_n_43),
        .Q(LBE_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \LBE_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_FAIL_CNT_I_n_6),
        .Q(LBE_reg[1]),
        .R(1'b0));
  FDRE PSME_reg_reg
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[3]),
        .Q(PSME_reg),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[8]),
        .Q(SBC_reg[0]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[9]),
        .Q(SBC_reg[1]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[10]),
        .Q(SBC_reg[2]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[11]),
        .Q(SBC_reg[3]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[12]),
        .Q(SBC_reg[4]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[13]),
        .Q(SBC_reg[5]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[14]),
        .Q(SBC_reg[6]),
        .R(bus2ip_reset));
  FDRE \SBC_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[15]),
        .Q(SBC_reg[7]),
        .R(bus2ip_reset));
  FDRE SSTE_reg_reg
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[4]),
        .Q(fc_sst_enc[1]),
        .R(bus2ip_reset));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \STATUS_I0_WDT.ip2bus_data[5]_i_2 
       (.I0(WDT_Current_State[0]),
        .I1(WDT_Current_State[1]),
        .O(\STATUS_I0_WDT.ip2bus_data[5]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[0]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[10] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[10]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[11] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[11]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[11] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[12] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[12]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[12] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[13] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[13]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[13] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[14] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[14]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[14] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[15] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[15]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[15] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[16] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[16]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[16] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[17] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[17]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[17] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[18] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[18]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[18] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[19] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[19]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[19] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[1]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[20] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[20]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[20] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[21] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[21]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[21] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[22] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[22]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[22] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[23] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[23]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[23] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[24] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[24]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[25] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[25]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[26] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[26]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[27] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[27]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[28] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[28]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[29] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[29]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[2]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[30] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[30]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[31] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[31]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[3]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[4]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[5]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[6]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[7] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_data[7]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[8] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[8]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[8] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \STATUS_I0_WDT.ip2bus_data_reg[9] 
       (.C(s_axi_aclk),
        .CE(AXI4_LITE_I_n_5),
        .D(ip2bus_data[9]),
        .Q(\STATUS_I0_WDT.ip2bus_data_reg_n_0_[9] ),
        .R(1'b0));
  FDRE \SW_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[0]),
        .Q(SW_reg[0]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[10]),
        .Q(SW_reg[10]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[11]),
        .Q(SW_reg[11]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[12]),
        .Q(SW_reg[12]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[13]),
        .Q(SW_reg[13]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[14]),
        .Q(SW_reg[14]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[15]),
        .Q(SW_reg[15]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[16]),
        .Q(SW_reg[16]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[17]),
        .Q(SW_reg[17]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[18]),
        .Q(SW_reg[18]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[19]),
        .Q(SW_reg[19]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[1]),
        .Q(SW_reg[1]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[20]),
        .Q(SW_reg[20]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[21]),
        .Q(SW_reg[21]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[22]),
        .Q(SW_reg[22]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[23]),
        .Q(SW_reg[23]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[24]),
        .Q(SW_reg[24]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[25]),
        .Q(SW_reg[25]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[26]),
        .Q(SW_reg[26]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[27]),
        .Q(SW_reg[27]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[28]),
        .Q(SW_reg[28]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[29]),
        .Q(SW_reg[29]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[2]),
        .Q(SW_reg[2]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[30]),
        .Q(SW_reg[30]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[31]),
        .Q(SW_reg[31]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[3]),
        .Q(SW_reg[3]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[4]),
        .Q(SW_reg[4]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[5]),
        .Q(SW_reg[5]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[6]),
        .Q(SW_reg[6]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[7]),
        .Q(SW_reg[7]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[8]),
        .Q(SW_reg[8]),
        .R(bus2ip_reset));
  FDRE \SW_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(SW_reg0),
        .D(s_axi_wdata[9]),
        .Q(SW_reg[9]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[0]),
        .Q(TSR0_reg[0]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[10]),
        .Q(TSR0_reg[10]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[11]),
        .Q(TSR0_reg[11]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[12]),
        .Q(TSR0_reg[12]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[13]),
        .Q(TSR0_reg[13]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[14]),
        .Q(TSR0_reg[14]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[15]),
        .Q(TSR0_reg[15]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[16]),
        .Q(TSR0_reg[16]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[17]),
        .Q(TSR0_reg[17]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[18]),
        .Q(TSR0_reg[18]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[19]),
        .Q(TSR0_reg[19]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[1]),
        .Q(TSR0_reg[1]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[20]),
        .Q(TSR0_reg[20]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[21]),
        .Q(TSR0_reg[21]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[22]),
        .Q(TSR0_reg[22]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[23]),
        .Q(TSR0_reg[23]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[24]),
        .Q(TSR0_reg[24]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[25]),
        .Q(TSR0_reg[25]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[26]),
        .Q(TSR0_reg[26]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[27]),
        .Q(TSR0_reg[27]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[28]),
        .Q(TSR0_reg[28]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[29]),
        .Q(TSR0_reg[29]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[2]),
        .Q(TSR0_reg[2]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[30]),
        .Q(TSR0_reg[30]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[31]),
        .Q(TSR0_reg[31]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[3]),
        .Q(TSR0_reg[3]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[4]),
        .Q(TSR0_reg[4]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[5]),
        .Q(TSR0_reg[5]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[6]),
        .Q(TSR0_reg[6]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[7]),
        .Q(TSR0_reg[7]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[8]),
        .Q(TSR0_reg[8]),
        .R(bus2ip_reset));
  FDRE \TSR0_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(TSR0_reg0),
        .D(s_axi_wdata[9]),
        .Q(TSR0_reg[9]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[0] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[0]),
        .Q(TSR1_reg[0]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[10] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[10]),
        .Q(TSR1_reg[10]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[11] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[11]),
        .Q(TSR1_reg[11]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[12] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[12]),
        .Q(TSR1_reg[12]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[13] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[13]),
        .Q(TSR1_reg[13]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[14] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[14]),
        .Q(TSR1_reg[14]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[15] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[15]),
        .Q(TSR1_reg[15]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[16] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[16]),
        .Q(TSR1_reg[16]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[17] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[17]),
        .Q(TSR1_reg[17]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[18] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[18]),
        .Q(TSR1_reg[18]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[19] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[19]),
        .Q(TSR1_reg[19]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[1] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[1]),
        .Q(TSR1_reg[1]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[20] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[20]),
        .Q(TSR1_reg[20]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[21] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[21]),
        .Q(TSR1_reg[21]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[22] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[22]),
        .Q(TSR1_reg[22]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[23] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[23]),
        .Q(TSR1_reg[23]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[24] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[24]),
        .Q(TSR1_reg[24]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[25] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[25]),
        .Q(TSR1_reg[25]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[26] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[26]),
        .Q(TSR1_reg[26]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[27] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[27]),
        .Q(TSR1_reg[27]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[28] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[28]),
        .Q(TSR1_reg[28]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[29] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[29]),
        .Q(TSR1_reg[29]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[2] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[2]),
        .Q(TSR1_reg[2]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[30] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[30]),
        .Q(TSR1_reg[30]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[31] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[31]),
        .Q(TSR1_reg[31]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[3] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[3]),
        .Q(TSR1_reg[3]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[4] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[4]),
        .Q(TSR1_reg[4]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[5] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[5]),
        .Q(TSR1_reg[5]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[6] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[6]),
        .Q(TSR1_reg[6]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[7] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[7]),
        .Q(TSR1_reg[7]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[8] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[8]),
        .Q(TSR1_reg[8]),
        .R(bus2ip_reset));
  FDRE \TSR1_reg_reg[9] 
       (.C(s_axi_aclk),
        .CE(TSR1_reg0),
        .D(s_axi_wdata[9]),
        .Q(TSR1_reg[9]),
        .R(bus2ip_reset));
  FDRE WCFG_clear_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[1]),
        .Q(WCFG_clear_reg_reg_n_0),
        .R(AXI4_LITE_I_n_50));
  FDRE WCFG_reg_In_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_FAIL_CNT_I_n_48),
        .Q(WCFG_reg_In),
        .R(1'b0));
  FDRE WDP_reg_reg
       (.C(s_axi_aclk),
        .CE(SBC_reg0),
        .D(s_axi_wdata[0]),
        .Q(WDP_reg_reg_n_0),
        .R(bus2ip_reset));
  FDRE WEN_change_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WEN_clear_reg0),
        .Q(WEN_change),
        .R(1'b0));
  FDRE WEN_clear_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(AXI4_LITE_I_n_9),
        .Q(WEN_clear_reg_reg_n_0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    WEN_reg_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WEN_reg),
        .Q(WEN_reg_d),
        .R(bus2ip_reset));
  FDRE WEN_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WEN_reg_cleark),
        .Q(WEN_reg),
        .R(bus2ip_reset));
  mbv_system_axi_timebase_wdt_0_0_window_wdt_counter WINDOW_WDT_CNT_I
       (.CO(load_val9),
        .D({WINDOW_WDT_CNT_I_n_45,WINDOW_WDT_CNT_I_n_46}),
        .E(WINDOW_WDT_FAIL_CNT_I_n_10),
        .\FSM_sequential_WDT_Current_State[0]_i_3_0 (WINDOW_WDT_FAIL_CNT_I_n_0),
        .\FSM_sequential_WDT_Current_State[0]_i_3_1 (WINDOW_WDT_FAIL_CNT_I_n_5),
        .\FSM_sequential_WDT_Current_State_reg[0] (WINDOW_WDT_CNT_I_n_49),
        .\FSM_sequential_WDT_Current_State_reg[0]_0 (WINDOW_WDT_FAIL_CNT_I_n_11),
        .\FSM_sequential_WDT_Current_State_reg[0]_1 (WDT_Current_State),
        .\FSM_sequential_WDT_Current_State_reg[0]_2 (WINDOW_WDT_FAIL_CNT_I_n_49),
        .\FSM_sequential_WDT_Current_State_reg[1] (WINDOW_WDT_CNT_I_n_50),
        .\FSM_sequential_WDT_Current_State_reg[1]_0 (WINDOW_WDT_FAIL_CNT_I_n_50),
        .\FSM_sequential_WDT_Current_State_reg[1]_1 (WSW_clear_reg_reg_n_0),
        .\FSM_sequential_WDT_Current_State_reg[1]_2 (WINDOW_WDT_FAIL_CNT_I_n_13),
        .\FW_reg_reg[12] (WINDOW_WDT_CNT_I_n_64),
        .\FW_reg_reg[22] (WINDOW_WDT_CNT_I_n_47),
        .\FW_reg_reg[29] (WINDOW_WDT_CNT_I_n_63),
        .LBE_reg(LBE_reg[0]),
        .LBE_reg0(LBE_reg0),
        .\LBE_reg_reg[0] (WINDOW_WDT_CNT_I_n_43),
        .\LBE_reg_reg[0]_0 (WINDOW_WDT_FAIL_CNT_I_n_47),
        .\LBE_reg_reg[0]_1 (WINDOW_WDT_FAIL_CNT_I_n_9),
        .PSME_reg(PSME_reg),
        .PSME_reg_reg(WINDOW_WDT_CNT_I_n_42),
        .Q(wdt_cnt_val),
        .S({WINDOW_WDT_CNT_I_n_60,WINDOW_WDT_CNT_I_n_61,WINDOW_WDT_CNT_I_n_62}),
        .SR(bus2ip_reset),
        .\SW_reg_reg[0] (WINDOW_WDT_CNT_I_n_55),
        .\SW_reg_reg[21] (WINDOW_WDT_CNT_I_n_53),
        .\SW_reg_reg[25] (WINDOW_WDT_CNT_I_n_56),
        .\SW_reg_reg[26] (WINDOW_WDT_CNT_I_n_54),
        .\SW_reg_reg[5] (WINDOW_WDT_CNT_I_n_57),
        .\SW_reg_reg[8] (WINDOW_WDT_CNT_I_n_52),
        .WEN_change(WEN_change),
        .WEN_clear_reg_reg(WINDOW_WDT_CNT_I_n_48),
        .dis_wdt_cnt(dis_wdt_cnt),
        .dis_wdt_int_reg_0(WINDOW_WDT_CNT_I_n_41),
        .dis_wdt_int_reg_1(WINDOW_WDT_CNT_I_n_44),
        .dis_wdt_int_reg_2(WINDOW_WDT_CNT_I_n_58),
        .fc_sst_enc(fc_sst_enc[1]),
        .\int_cnt_int[31]_i_12_0 (SW_reg),
        .\int_cnt_int[31]_i_14_0 (FW_reg),
        .\int_cnt_int[7]_i_3 (WEN_clear_reg_reg_n_0),
        .\int_cnt_int[7]_i_3_0 (WDP_reg_reg_n_0),
        .\int_cnt_int_reg[31]_0 (p_1_in),
        .load_val9_carry__1(TSR0_reg[31:24]),
        .load_val9_carry__1_0(TSR1_reg[31:24]),
        .minusOp(minusOp),
        .p_11_in(p_11_in[1]),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .wdt_reset_int(wdt_reset_int),
        .wdt_reset_reg_reg(WINDOW_WDT_CNT_I_n_51),
        .wdt_reset_reg_reg_0(WINDOW_WDT_CNT_I_n_65),
        .wdt_reset_reg_reg_1(wdt_reset_reg_reg_0),
        .wdt_reset_reg_reg_2(WINDOW_WDT_FAIL_CNT_I_n_51),
        .wdt_reset_reg_reg_3(WINDOW_WDT_FAIL_CNT_I_n_7),
        .wint_int(wint_int),
        .wint_int_i_6_0(SBC_reg),
        .wint_int_reg_0(WINDOW_WDT_FAIL_CNT_I_n_12),
        .wint_int_reg_1(WINDOW_WDT_FAIL_CNT_I_n_46),
        .wint_int_reg_2(WINDOW_WDT_FAIL_CNT_I_n_4),
        .wint_int_reg_3(WINT_clear_reg_reg_n_0),
        .wint_int_reg_4(BSS_reg));
  mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt WINDOW_WDT_FAIL_CNT_I
       (.CO(load_val9),
        .D(WEN_reg),
        .E(WINDOW_WDT_FAIL_CNT_I_n_10),
        .FCV_reg(FCV_reg),
        .\FSM_sequential_WDT_Current_State_reg[0] (WINDOW_WDT_FAIL_CNT_I_n_4),
        .\FSM_sequential_WDT_Current_State_reg[0]_0 (WINDOW_WDT_FAIL_CNT_I_n_47),
        .\FSM_sequential_WDT_Current_State_reg[1] (WINDOW_WDT_FAIL_CNT_I_n_7),
        .\FSM_sequential_WDT_Current_State_reg[1]_0 (WINDOW_WDT_FAIL_CNT_I_n_11),
        .\FSM_sequential_WDT_Current_State_reg[1]_1 (WINDOW_WDT_CNT_I_n_57),
        .\FSM_sequential_WDT_Current_State_reg[1]_2 (WINDOW_WDT_CNT_I_n_56),
        .\FSM_sequential_WDT_Current_State_reg[1]_3 (WINDOW_WDT_CNT_I_n_53),
        .\FSM_sequential_WDT_Current_State_reg[1]_4 (WINDOW_WDT_CNT_I_n_54),
        .LBE_reg(LBE_reg[1]),
        .LBE_reg0(LBE_reg0),
        .\LBE_reg_reg[1] (WINDOW_WDT_FAIL_CNT_I_n_6),
        .\LBE_reg_reg[1]_0 (\LBE_reg[1]_i_2_n_0 ),
        .PSME_reg(PSME_reg),
        .PSME_reg_reg(WINDOW_WDT_FAIL_CNT_I_n_12),
        .PSME_reg_reg_0(WINDOW_WDT_FAIL_CNT_I_n_46),
        .Q(WDT_Current_State),
        .SR(bus2ip_reset),
        .SSTE_reg_reg(WINDOW_WDT_FAIL_CNT_I_n_51),
        .\SW_reg_reg[25] (WINDOW_WDT_FAIL_CNT_I_n_50),
        .\SW_reg_reg[31] (p_1_in),
        .WCFG_reg_In(WCFG_reg_In),
        .WCFG_reg_In_reg(WINDOW_WDT_FAIL_CNT_I_n_48),
        .WCFG_reg_In_reg_0(WEN_clear_reg_reg_n_0),
        .WCFG_reg_In_reg_1(WDP_reg_reg_n_0),
        .WCFG_reg_In_reg_2(WINDOW_WDT_CNT_I_n_51),
        .WCFG_reg_In_reg_3(WCFG_clear_reg_reg_n_0),
        .WDP_reg_reg(WINDOW_WDT_FAIL_CNT_I_n_5),
        .WEN_change(WEN_change),
        .WEN_clear_reg_reg(WINDOW_WDT_FAIL_CNT_I_n_9),
        .WEN_clear_reg_reg_0(WINDOW_WDT_FAIL_CNT_I_n_49),
        .WEN_reg_cleark(WEN_reg_cleark),
        .WEN_reg_reg(WSW_clear_reg_reg_n_0),
        .WEN_reg_reg_0(wdt_reset_reg_reg_0),
        .WEN_reg_reg_1(WINDOW_WDT_CNT_I_n_48),
        .dis_wdt_cnt(dis_wdt_cnt),
        .dis_wdt_int_reg_0(WINDOW_WDT_CNT_I_n_44),
        .\fail_cnt_int_reg[0]_0 (WINDOW_WDT_FAIL_CNT_I_n_13),
        .\fail_cnt_int_reg[2]_0 (WINDOW_WDT_FAIL_CNT_I_n_0),
        .fc_sst_enc(fc_sst_enc),
        .\int_cnt_int[31]_i_4_0 (WINDOW_WDT_CNT_I_n_50),
        .\int_cnt_int_reg[0] (wdt_cnt_val[0]),
        .\int_cnt_int_reg[0]_0 (WINDOW_WDT_CNT_I_n_49),
        .\int_cnt_int_reg[0]_1 (WINDOW_WDT_CNT_I_n_52),
        .\int_cnt_int_reg[0]_2 (WINDOW_WDT_CNT_I_n_55),
        .\int_cnt_int_reg[0]_3 (WINDOW_WDT_CNT_I_n_63),
        .\int_cnt_int_reg[0]_4 (WINDOW_WDT_CNT_I_n_64),
        .\int_cnt_int_reg[0]_5 (WINDOW_WDT_CNT_I_n_47),
        .\int_cnt_int_reg[31] (WINDOW_WDT_CNT_I_n_42),
        .\int_cnt_int_reg[31]_0 (WINDOW_WDT_CNT_I_n_41),
        .\int_cnt_int_reg[31]_1 (WINDOW_WDT_CNT_I_n_58),
        .\int_cnt_int_reg[31]_2 (SW_reg),
        .\int_cnt_int_reg[31]_3 (FW_reg),
        .minusOp(minusOp),
        .p_11_in(p_11_in[1]),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .wdt_state_vec(wdt_state_vec[1]));
  FDRE WINT_clear_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[16]),
        .Q(WINT_clear_reg_reg_n_0),
        .R(AXI4_LITE_I_n_50));
  FDRE WINT_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(wint_int),
        .Q(wdt_interrupt),
        .R(1'b0));
  FDRE WRP_clear_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[17]),
        .Q(WRP_clear_reg_reg_n_0),
        .R(AXI4_LITE_I_n_50));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h0080)) 
    WRP_reg_i_1
       (.I0(WDT_Current_State[1]),
        .I1(WDT_Current_State[0]),
        .I2(s_axi_aresetn),
        .I3(cnt_wrp),
        .O(WRP_reg_i_1_n_0));
  FDRE WRP_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WRP_reg_i_1_n_0),
        .Q(wdt_reset_pending),
        .R(1'b0));
  FDRE WSW_clear_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_wdata[8]),
        .Q(WSW_clear_reg_reg_n_0),
        .R(AXI4_LITE_I_n_50));
  FDRE aen_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(AXI4_LITE_I_n_49),
        .Q(p_11_in[1]),
        .R(bus2ip_reset));
  LUT2 #(
    .INIT(4'hE)) 
    aen_trig_i_1
       (.I0(p_11_in[1]),
        .I1(aen_trig),
        .O(aen_trig_i_1_n_0));
  FDRE aen_trig_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(aen_trig_i_1_n_0),
        .Q(aen_trig),
        .R(bus2ip_reset));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'hFF80)) 
    cnt_wrp_i_1
       (.I0(WDT_Current_State[0]),
        .I1(WDT_Current_State[1]),
        .I2(WRP_clear_reg_reg_n_0),
        .I3(cnt_wrp),
        .O(cnt_wrp_i_1_n_0));
  FDRE cnt_wrp_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(cnt_wrp_i_1_n_0),
        .Q(cnt_wrp),
        .R(bus2ip_reset));
  LUT6 #(
    .INIT(64'h002A00AA00AA00AA)) 
    ip2bus_error
       (.I0(bus2ip_cs),
        .I1(s_axi_wstrb[2]),
        .I2(s_axi_wstrb[0]),
        .I3(AXI4_LITE_I_n_1),
        .I4(s_axi_wstrb[1]),
        .I5(s_axi_wstrb[3]),
        .O(ip2bus_error__0));
  FDRE ip2bus_rdack_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(ip2bus_rdack_i),
        .Q(ip2bus_rdack),
        .R(1'b0));
  CARRY4 load_val9_carry
       (.CI(1'b0),
        .CO({load_val9_carry_n_0,load_val9_carry_n_1,load_val9_carry_n_2,load_val9_carry_n_3}),
        .CYINIT(1'b1),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_load_val9_carry_O_UNCONNECTED[3:0]),
        .S({load_val9_carry_i_1_n_0,load_val9_carry_i_2_n_0,load_val9_carry_i_3_n_0,load_val9_carry_i_4_n_0}));
  CARRY4 load_val9_carry__0
       (.CI(load_val9_carry_n_0),
        .CO({load_val9_carry__0_n_0,load_val9_carry__0_n_1,load_val9_carry__0_n_2,load_val9_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_load_val9_carry__0_O_UNCONNECTED[3:0]),
        .S({load_val9_carry__0_i_1_n_0,load_val9_carry__0_i_2_n_0,load_val9_carry__0_i_3_n_0,load_val9_carry__0_i_4_n_0}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__0_i_1
       (.I0(TSR1_reg[21]),
        .I1(TSR0_reg[21]),
        .I2(TSR1_reg[23]),
        .I3(TSR0_reg[23]),
        .I4(TSR0_reg[22]),
        .I5(TSR1_reg[22]),
        .O(load_val9_carry__0_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__0_i_2
       (.I0(TSR1_reg[20]),
        .I1(TSR0_reg[20]),
        .I2(TSR1_reg[18]),
        .I3(TSR0_reg[18]),
        .I4(TSR0_reg[19]),
        .I5(TSR1_reg[19]),
        .O(load_val9_carry__0_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__0_i_3
       (.I0(TSR1_reg[15]),
        .I1(TSR0_reg[15]),
        .I2(TSR1_reg[17]),
        .I3(TSR0_reg[17]),
        .I4(TSR0_reg[16]),
        .I5(TSR1_reg[16]),
        .O(load_val9_carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__0_i_4
       (.I0(TSR1_reg[14]),
        .I1(TSR0_reg[14]),
        .I2(TSR1_reg[13]),
        .I3(TSR0_reg[13]),
        .I4(TSR0_reg[12]),
        .I5(TSR1_reg[12]),
        .O(load_val9_carry__0_i_4_n_0));
  CARRY4 load_val9_carry__1
       (.CI(load_val9_carry__0_n_0),
        .CO({NLW_load_val9_carry__1_CO_UNCONNECTED[3],load_val9,load_val9_carry__1_n_2,load_val9_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(NLW_load_val9_carry__1_O_UNCONNECTED[3:0]),
        .S({1'b0,WINDOW_WDT_CNT_I_n_60,WINDOW_WDT_CNT_I_n_61,WINDOW_WDT_CNT_I_n_62}));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry_i_1
       (.I0(TSR1_reg[10]),
        .I1(TSR0_reg[10]),
        .I2(TSR1_reg[11]),
        .I3(TSR0_reg[11]),
        .I4(TSR0_reg[9]),
        .I5(TSR1_reg[9]),
        .O(load_val9_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry_i_2
       (.I0(TSR1_reg[6]),
        .I1(TSR0_reg[6]),
        .I2(TSR1_reg[8]),
        .I3(TSR0_reg[8]),
        .I4(TSR0_reg[7]),
        .I5(TSR1_reg[7]),
        .O(load_val9_carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry_i_3
       (.I0(TSR1_reg[5]),
        .I1(TSR0_reg[5]),
        .I2(TSR1_reg[3]),
        .I3(TSR0_reg[3]),
        .I4(TSR0_reg[4]),
        .I5(TSR1_reg[4]),
        .O(load_val9_carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry_i_4
       (.I0(TSR1_reg[1]),
        .I1(TSR0_reg[1]),
        .I2(TSR1_reg[2]),
        .I3(TSR0_reg[2]),
        .I4(TSR0_reg[0]),
        .I5(TSR1_reg[0]),
        .O(load_val9_carry_i_4_n_0));
  FDSE mwc_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(AXI4_LITE_I_n_8),
        .Q(p_11_in[0]),
        .S(bus2ip_reset));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'hE)) 
    wdt_reset_reg_i_7
       (.I0(WDT_Current_State[0]),
        .I1(WDT_Current_State[1]),
        .O(wdt_reset_int));
  FDRE wdt_reset_reg_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WINDOW_WDT_CNT_I_n_65),
        .Q(wdt_reset_reg_reg_0),
        .R(bus2ip_reset));
  LUT2 #(
    .INIT(4'h2)) 
    \wdt_state_vec[1]_i_1 
       (.I0(WDT_Current_State[1]),
        .I1(WDT_Current_State[0]),
        .O(WSW_reg));
  FDRE \wdt_state_vec_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WEN_reg),
        .Q(wdt_state_vec[0]),
        .R(bus2ip_reset));
  FDRE \wdt_state_vec_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(WSW_reg),
        .Q(wdt_state_vec[1]),
        .R(bus2ip_reset));
  FDRE \wdt_state_vec_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(fc_sst_enc[0]),
        .Q(wdt_state_vec[2]),
        .R(bus2ip_reset));
  FDRE \wdt_state_vec_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(FCV_reg[0]),
        .Q(wdt_state_vec[3]),
        .R(bus2ip_reset));
  FDRE \wdt_state_vec_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(FCV_reg[1]),
        .Q(wdt_state_vec[4]),
        .R(bus2ip_reset));
  FDRE \wdt_state_vec_reg[6] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(FCV_reg[2]),
        .Q(wdt_state_vec[5]),
        .R(bus2ip_reset));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized1
   (ce_expnd_i_10,
    \GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] );
  output ce_expnd_i_10;
  input [3:0]\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] ;
  wire ce_expnd_i_10;

  LUT4 #(
    .INIT(16'h0100)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] [2]),
        .I2(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[2].ce_out_i_reg[2] [1]),
        .O(ce_expnd_i_10));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized10
   (ce_expnd_i_1,
    \GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] );
  output ce_expnd_i_1;
  input [3:0]\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] ;
  wire ce_expnd_i_1;

  LUT4 #(
    .INIT(16'h4000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] [2]),
        .I1(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] [3]),
        .I2(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[11].ce_out_i_reg[11] [1]),
        .O(ce_expnd_i_1));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized11
   (ce_expnd_i_0,
    \GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] );
  output ce_expnd_i_0;
  input [3:0]\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] ;
  wire ce_expnd_i_0;

  LUT4 #(
    .INIT(16'h1000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] [1]),
        .I1(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] [0]),
        .I2(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] [3]),
        .I3(\GEN_BKEND_CE_REGISTERS[12].ce_out_i_reg[12] [2]),
        .O(ce_expnd_i_0));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized3
   (ce_expnd_i_8,
    \GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] );
  output ce_expnd_i_8;
  input [3:0]\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] ;
  wire ce_expnd_i_8;

  LUT4 #(
    .INIT(16'h0100)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] [1]),
        .I2(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[4].ce_out_i_reg[4] [2]),
        .O(ce_expnd_i_8));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized4
   (ce_expnd_i_7,
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] );
  output ce_expnd_i_7;
  input [3:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;
  wire ce_expnd_i_7;

  LUT4 #(
    .INIT(16'h1000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] [1]),
        .I2(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] [2]),
        .O(ce_expnd_i_7));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized5
   (ce_expnd_i_6,
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] );
  output ce_expnd_i_6;
  input [3:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;
  wire ce_expnd_i_6;

  LUT4 #(
    .INIT(16'h1000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] [0]),
        .I2(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] [1]),
        .I3(\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] [2]),
        .O(ce_expnd_i_6));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized6
   (ce_expnd_i_5,
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] );
  output ce_expnd_i_5;
  input [3:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;
  wire ce_expnd_i_5;

  LUT4 #(
    .INIT(16'h4000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] [3]),
        .I1(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] [2]),
        .I2(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] [1]),
        .O(ce_expnd_i_5));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized7
   (ce_expnd_i_4,
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] );
  output ce_expnd_i_4;
  input [3:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;
  wire ce_expnd_i_4;

  LUT4 #(
    .INIT(16'h0100)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] [2]),
        .I1(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] [1]),
        .I2(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] [0]),
        .I3(\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] [3]),
        .O(ce_expnd_i_4));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized8
   (ce_expnd_i_3,
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] );
  output ce_expnd_i_3;
  input [3:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;
  wire ce_expnd_i_3;

  LUT4 #(
    .INIT(16'h1000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] [2]),
        .I1(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] [1]),
        .I2(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] [3]),
        .I3(\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] [0]),
        .O(ce_expnd_i_3));
endmodule

(* ORIG_REF_NAME = "pselect_f" *) 
module mbv_system_axi_timebase_wdt_0_0_pselect_f__parameterized9
   (ce_expnd_i_2,
    \GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] );
  output ce_expnd_i_2;
  input [3:0]\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] ;

  wire [3:0]\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] ;
  wire ce_expnd_i_2;

  LUT4 #(
    .INIT(16'h1000)) 
    CS
       (.I0(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] [2]),
        .I1(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] [0]),
        .I2(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] [3]),
        .I3(\GEN_BKEND_CE_REGISTERS[10].ce_out_i_reg[10] [1]),
        .O(ce_expnd_i_2));
endmodule

(* ORIG_REF_NAME = "slave_attachment" *) 
module mbv_system_axi_timebase_wdt_0_0_slave_attachment
   (s_axi_rresp,
    bus2ip_rnw_i_reg_0,
    bus2ip_cs,
    s_axi_rvalid_i_reg_0,
    s_axi_bvalid_i_reg_0,
    E,
    is_write_reg_0,
    ip2bus_rdack_reg,
    s_axi_wdata_0_sp_1,
    WEN_clear_reg_reg,
    D,
    ip2bus_rdack_i,
    \GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ,
    \GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ,
    WEN_clear_reg0,
    \GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ,
    \GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ,
    \GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ,
    s_axi_wdata_1_sp_1,
    Bus_RNW_reg_reg,
    s_axi_bresp,
    s_axi_rdata,
    SR,
    s_axi_aclk,
    ip2bus_error,
    s_axi_arvalid,
    s_axi_aresetn,
    s_axi_bready,
    s_axi_wdata,
    WEN_reg_d,
    WEN_reg,
    p_11_in,
    WEN_clear_reg_reg_0,
    WCFG_reg_In,
    Q,
    \STATUS_I0_WDT.ip2bus_data_reg[8] ,
    s_axi_wvalid,
    s_axi_awvalid,
    ip2bus_rdack,
    \STATUS_I0_WDT.ip2bus_data_reg[31] ,
    \STATUS_I0_WDT.ip2bus_data_reg[7] ,
    \STATUS_I0_WDT.ip2bus_data_reg[5] ,
    \STATUS_I0_WDT.ip2bus_data_reg[0] ,
    fc_sst_enc,
    PSME_reg,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[7]_1 ,
    s_axi_rready,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_0 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_1 ,
    \STATUS_I0_WDT.ip2bus_data_reg[31]_2 ,
    wdt_interrupt,
    wdt_reset_pending,
    FCV_reg,
    LBE_reg,
    s_axi_araddr,
    s_axi_awaddr,
    aen_trig,
    \s_axi_rdata_i_reg[31]_0 );
  output [0:0]s_axi_rresp;
  output bus2ip_rnw_i_reg_0;
  output [0:0]bus2ip_cs;
  output s_axi_rvalid_i_reg_0;
  output s_axi_bvalid_i_reg_0;
  output [0:0]E;
  output is_write_reg_0;
  output ip2bus_rdack_reg;
  output s_axi_wdata_0_sp_1;
  output WEN_clear_reg_reg;
  output [31:0]D;
  output ip2bus_rdack_i;
  output [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;
  output WEN_clear_reg0;
  output [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;
  output [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;
  output s_axi_wdata_1_sp_1;
  output Bus_RNW_reg_reg;
  output [0:0]s_axi_bresp;
  output [31:0]s_axi_rdata;
  input [0:0]SR;
  input s_axi_aclk;
  input ip2bus_error;
  input s_axi_arvalid;
  input s_axi_aresetn;
  input s_axi_bready;
  input [1:0]s_axi_wdata;
  input WEN_reg_d;
  input WEN_reg;
  input [1:0]p_11_in;
  input WEN_clear_reg_reg_0;
  input WCFG_reg_In;
  input [7:0]Q;
  input \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  input s_axi_wvalid;
  input s_axi_awvalid;
  input ip2bus_rdack;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  input [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  input \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  input [1:0]fc_sst_enc;
  input PSME_reg;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  input [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  input s_axi_rready;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  input [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  input wdt_interrupt;
  input wdt_reset_pending;
  input [2:0]FCV_reg;
  input [1:0]LBE_reg;
  input [3:0]s_axi_araddr;
  input [3:0]s_axi_awaddr;
  input aen_trig;
  input [31:0]\s_axi_rdata_i_reg[31]_0 ;

  wire Bus_RNW_reg_reg;
  wire [31:0]D;
  wire [0:0]E;
  wire [2:0]FCV_reg;
  wire \FSM_onehot_state[0]_i_1_n_0 ;
  wire \FSM_onehot_state[1]_i_1_n_0 ;
  wire \FSM_onehot_state[3]_i_2_n_0 ;
  wire \FSM_onehot_state_reg_n_0_[0] ;
  wire \FSM_onehot_state_reg_n_0_[3] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ;
  wire [0:0]\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ;
  wire \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ;
  wire [5:0]\INCLUDE_DPHASE_TIMER.dpto_cnt_reg ;
  wire I_DECODER_n_4;
  wire I_DECODER_n_40;
  wire I_DECODER_n_41;
  wire I_DECODER_n_5;
  wire [1:0]LBE_reg;
  wire PSME_reg;
  wire [7:0]Q;
  wire [0:0]SR;
  wire \STATUS_I0_WDT.ip2bus_data_reg[0] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31] ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ;
  wire [31:0]\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[5] ;
  wire [7:0]\STATUS_I0_WDT.ip2bus_data_reg[7] ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ;
  wire [1:0]\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ;
  wire \STATUS_I0_WDT.ip2bus_data_reg[8] ;
  wire WCFG_reg_In;
  wire WEN_clear_reg0;
  wire WEN_clear_reg_reg;
  wire WEN_clear_reg_reg_0;
  wire WEN_reg;
  wire WEN_reg_d;
  wire aen_trig;
  wire \bus2ip_addr_i[2]_i_1_n_0 ;
  wire \bus2ip_addr_i[3]_i_1_n_0 ;
  wire \bus2ip_addr_i[4]_i_1_n_0 ;
  wire \bus2ip_addr_i[5]_i_1_n_0 ;
  wire \bus2ip_addr_i[5]_i_2_n_0 ;
  wire \bus2ip_addr_i_reg_n_0_[2] ;
  wire \bus2ip_addr_i_reg_n_0_[3] ;
  wire \bus2ip_addr_i_reg_n_0_[4] ;
  wire \bus2ip_addr_i_reg_n_0_[5] ;
  wire [0:0]bus2ip_cs;
  wire bus2ip_rnw_i_reg_0;
  wire [1:0]fc_sst_enc;
  wire ip2bus_error;
  wire ip2bus_rdack;
  wire ip2bus_rdack_i;
  wire ip2bus_rdack_reg;
  wire is_read_i_1_n_0;
  wire is_read_reg_n_0;
  wire is_write_i_1_n_0;
  wire is_write_i_2_n_0;
  wire is_write_reg_0;
  wire is_write_reg_n_0;
  wire [1:0]p_11_in;
  wire [5:0]plusOp;
  wire rst;
  wire s_axi_aclk;
  wire [3:0]s_axi_araddr;
  wire s_axi_aresetn;
  wire s_axi_arvalid;
  wire [3:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire [0:0]s_axi_bresp_i;
  wire \s_axi_bresp_i[1]_i_1_n_0 ;
  wire s_axi_bvalid_i_reg_0;
  wire [31:0]s_axi_rdata;
  wire [31:0]\s_axi_rdata_i_reg[31]_0 ;
  wire s_axi_rready;
  wire [0:0]s_axi_rresp;
  wire [0:0]s_axi_rresp_i;
  wire s_axi_rvalid_i_i_1_n_0;
  wire s_axi_rvalid_i_reg_0;
  wire [1:0]s_axi_wdata;
  wire s_axi_wdata_0_sn_1;
  wire s_axi_wdata_1_sn_1;
  wire s_axi_wvalid;
  wire start2;
  wire start2_i_1_n_0;
  wire \state[1]_i_1_n_0 ;
  wire \state[1]_i_2_n_0 ;
  wire \state_reg_n_0_[0] ;
  wire \state_reg_n_0_[1] ;
  wire wdt_interrupt;
  wire wdt_reset_pending;

  assign s_axi_wdata_0_sp_1 = s_axi_wdata_0_sn_1;
  assign s_axi_wdata_1_sp_1 = s_axi_wdata_1_sn_1;
  LUT6 #(
    .INIT(64'h88888F888F888F88)) 
    \FSM_onehot_state[0]_i_1 
       (.I0(\FSM_onehot_state[3]_i_2_n_0 ),
        .I1(\FSM_onehot_state_reg_n_0_[3] ),
        .I2(s_axi_arvalid),
        .I3(\FSM_onehot_state_reg_n_0_[0] ),
        .I4(s_axi_wvalid),
        .I5(s_axi_awvalid),
        .O(\FSM_onehot_state[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8F88)) 
    \FSM_onehot_state[1]_i_1 
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(s_axi_arvalid),
        .I2(ip2bus_rdack_reg),
        .I3(s_axi_rresp_i),
        .O(\FSM_onehot_state[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'hF888)) 
    \FSM_onehot_state[3]_i_2 
       (.I0(s_axi_bvalid_i_reg_0),
        .I1(s_axi_bready),
        .I2(s_axi_rvalid_i_reg_0),
        .I3(s_axi_rready),
        .O(\FSM_onehot_state[3]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001" *) 
  FDSE #(
    .INIT(1'b1)) 
    \FSM_onehot_state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[0]_i_1_n_0 ),
        .Q(\FSM_onehot_state_reg_n_0_[0] ),
        .S(rst));
  (* FSM_ENCODED_STATES = "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\FSM_onehot_state[1]_i_1_n_0 ),
        .Q(s_axi_rresp_i),
        .R(rst));
  (* FSM_ENCODED_STATES = "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_DECODER_n_41),
        .Q(s_axi_bresp_i),
        .R(rst));
  (* FSM_ENCODED_STATES = "iSTATE:0010,iSTATE0:0100,iSTATE1:1000,iSTATE2:0001" *) 
  FDRE #(
    .INIT(1'b0)) 
    \FSM_onehot_state_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_DECODER_n_40),
        .Q(\FSM_onehot_state_reg_n_0_[3] ),
        .R(rst));
  LUT1 #(
    .INIT(2'h1)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[0]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .O(plusOp[0]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[1]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .O(plusOp[1]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[2]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [2]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .O(plusOp[2]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[3]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [3]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [2]),
        .O(plusOp[3]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[4]_i_1 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [4]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [2]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .I4(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [3]),
        .O(plusOp[4]));
  LUT2 #(
    .INIT(4'h9)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1 
       (.I0(\state_reg_n_0_[1] ),
        .I1(\state_reg_n_0_[0] ),
        .O(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    \INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_2 
       (.I0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [5]),
        .I1(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [3]),
        .I2(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .I3(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .I4(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [2]),
        .I5(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [4]),
        .O(plusOp[5]));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[0]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [0]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[1]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [1]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[2]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [2]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[3] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[3]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [3]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[4] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[4]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [4]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  FDRE \INCLUDE_DPHASE_TIMER.dpto_cnt_reg[5] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(plusOp[5]),
        .Q(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg [5]),
        .R(\INCLUDE_DPHASE_TIMER.dpto_cnt[5]_i_1_n_0 ));
  mbv_system_axi_timebase_wdt_0_0_address_decoder I_DECODER
       (.Bus_RNW_reg_reg_0(Bus_RNW_reg_reg),
        .Bus_RNW_reg_reg_1(bus2ip_rnw_i_reg_0),
        .D(I_DECODER_n_4),
        .E(E),
        .FCV_reg(FCV_reg),
        .\FSM_onehot_state_reg[2] ({I_DECODER_n_40,I_DECODER_n_41}),
        .\FSM_onehot_state_reg[3] (\FSM_onehot_state[3]_i_2_n_0 ),
        .\FSM_onehot_state_reg[3]_0 ({\FSM_onehot_state_reg_n_0_[3] ,s_axi_bresp_i,s_axi_rresp_i,\FSM_onehot_state_reg_n_0_[0] }),
        .\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5]_0 (\GEN_BKEND_CE_REGISTERS[5].ce_out_i_reg[5] ),
        .\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6]_0 (\GEN_BKEND_CE_REGISTERS[6].ce_out_i_reg[6] ),
        .\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7]_0 (\GEN_BKEND_CE_REGISTERS[7].ce_out_i_reg[7] ),
        .\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8]_0 (\GEN_BKEND_CE_REGISTERS[8].ce_out_i_reg[8] ),
        .\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_0 (\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9] ),
        .\GEN_BKEND_CE_REGISTERS[9].ce_out_i_reg[9]_1 ({\bus2ip_addr_i_reg_n_0_[5] ,\bus2ip_addr_i_reg_n_0_[4] ,\bus2ip_addr_i_reg_n_0_[3] ,\bus2ip_addr_i_reg_n_0_[2] }),
        .LBE_reg(LBE_reg),
        .PSME_reg(PSME_reg),
        .Q(start2),
        .\STATUS_I0_WDT.ip2bus_data_reg[0] (\STATUS_I0_WDT.ip2bus_data_reg[0] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[15] (Q),
        .\STATUS_I0_WDT.ip2bus_data_reg[31] (\STATUS_I0_WDT.ip2bus_data_reg[31] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_0 (\STATUS_I0_WDT.ip2bus_data_reg[31]_0 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_1 (\STATUS_I0_WDT.ip2bus_data_reg[31]_1 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[31]_2 (\STATUS_I0_WDT.ip2bus_data_reg[31]_2 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[5] (\STATUS_I0_WDT.ip2bus_data_reg[5] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7] (\STATUS_I0_WDT.ip2bus_data_reg[7] ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_0 (\STATUS_I0_WDT.ip2bus_data_reg[7]_0 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[7]_1 (\STATUS_I0_WDT.ip2bus_data_reg[7]_1 ),
        .\STATUS_I0_WDT.ip2bus_data_reg[8] (\STATUS_I0_WDT.ip2bus_data_reg[8] ),
        .\TSR1_reg_reg[31] (D),
        .WCFG_reg_In(WCFG_reg_In),
        .WEN_clear_reg0(WEN_clear_reg0),
        .WEN_clear_reg_reg(WEN_clear_reg_reg),
        .WEN_clear_reg_reg_0(WEN_clear_reg_reg_0),
        .WEN_reg(WEN_reg),
        .WEN_reg_d(WEN_reg_d),
        .aen_trig(aen_trig),
        .bus2ip_cs(bus2ip_cs),
        .fc_sst_enc(fc_sst_enc),
        .ip2bus_rdack(ip2bus_rdack),
        .ip2bus_rdack_i(ip2bus_rdack_i),
        .ip2bus_rdack_reg(ip2bus_rdack_reg),
        .is_write_reg(is_write_reg_0),
        .p_11_in(p_11_in),
        .s_axi_aclk(s_axi_aclk),
        .s_axi_aresetn(s_axi_aresetn),
        .s_axi_arready(is_read_reg_n_0),
        .s_axi_arready_0(\INCLUDE_DPHASE_TIMER.dpto_cnt_reg ),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awready(is_write_reg_n_0),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid_i_reg(s_axi_bvalid_i_reg_0),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wdata_0_sp_1(s_axi_wdata_0_sn_1),
        .s_axi_wdata_1_sp_1(s_axi_wdata_1_sn_1),
        .s_axi_wvalid(s_axi_wvalid),
        .\state_reg[0] (I_DECODER_n_5),
        .\state_reg[0]_0 ({\state_reg_n_0_[1] ,\state_reg_n_0_[0] }),
        .wdt_interrupt(wdt_interrupt),
        .wdt_reset_pending(wdt_reset_pending));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[2]_i_1 
       (.I0(s_axi_araddr[0]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[0]),
        .O(\bus2ip_addr_i[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[3]_i_1 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[1]),
        .O(\bus2ip_addr_i[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[4]_i_1 
       (.I0(s_axi_araddr[2]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[2]),
        .O(\bus2ip_addr_i[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h03020202)) 
    \bus2ip_addr_i[5]_i_1 
       (.I0(s_axi_arvalid),
        .I1(\state_reg_n_0_[1] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(s_axi_wvalid),
        .I4(s_axi_awvalid),
        .O(\bus2ip_addr_i[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \bus2ip_addr_i[5]_i_2 
       (.I0(s_axi_araddr[3]),
        .I1(s_axi_arvalid),
        .I2(s_axi_awaddr[3]),
        .O(\bus2ip_addr_i[5]_i_2_n_0 ));
  FDRE \bus2ip_addr_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[5]_i_1_n_0 ),
        .D(\bus2ip_addr_i[2]_i_1_n_0 ),
        .Q(\bus2ip_addr_i_reg_n_0_[2] ),
        .R(rst));
  FDRE \bus2ip_addr_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[5]_i_1_n_0 ),
        .D(\bus2ip_addr_i[3]_i_1_n_0 ),
        .Q(\bus2ip_addr_i_reg_n_0_[3] ),
        .R(rst));
  FDRE \bus2ip_addr_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[5]_i_1_n_0 ),
        .D(\bus2ip_addr_i[4]_i_1_n_0 ),
        .Q(\bus2ip_addr_i_reg_n_0_[4] ),
        .R(rst));
  FDRE \bus2ip_addr_i_reg[5] 
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[5]_i_1_n_0 ),
        .D(\bus2ip_addr_i[5]_i_2_n_0 ),
        .Q(\bus2ip_addr_i_reg_n_0_[5] ),
        .R(rst));
  FDRE bus2ip_rnw_i_reg
       (.C(s_axi_aclk),
        .CE(\bus2ip_addr_i[5]_i_1_n_0 ),
        .D(s_axi_arvalid),
        .Q(bus2ip_rnw_i_reg_0),
        .R(rst));
  LUT5 #(
    .INIT(32'h8BBB8888)) 
    is_read_i_1
       (.I0(s_axi_arvalid),
        .I1(\FSM_onehot_state_reg_n_0_[0] ),
        .I2(\FSM_onehot_state[3]_i_2_n_0 ),
        .I3(\FSM_onehot_state_reg_n_0_[3] ),
        .I4(is_read_reg_n_0),
        .O(is_read_i_1_n_0));
  FDRE is_read_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(is_read_i_1_n_0),
        .Q(is_read_reg_n_0),
        .R(rst));
  LUT6 #(
    .INIT(64'h0080FFFF00800000)) 
    is_write_i_1
       (.I0(s_axi_awvalid),
        .I1(s_axi_wvalid),
        .I2(\FSM_onehot_state_reg_n_0_[0] ),
        .I3(s_axi_arvalid),
        .I4(is_write_i_2_n_0),
        .I5(is_write_reg_n_0),
        .O(is_write_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFEAEAEAAAAAAAAA)) 
    is_write_i_2
       (.I0(\FSM_onehot_state_reg_n_0_[0] ),
        .I1(s_axi_bvalid_i_reg_0),
        .I2(s_axi_bready),
        .I3(s_axi_rvalid_i_reg_0),
        .I4(s_axi_rready),
        .I5(\FSM_onehot_state_reg_n_0_[3] ),
        .O(is_write_i_2_n_0));
  FDRE is_write_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(is_write_i_1_n_0),
        .Q(is_write_reg_n_0),
        .R(rst));
  FDRE rst_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(SR),
        .Q(rst),
        .R(1'b0));
  LUT3 #(
    .INIT(8'hB8)) 
    \s_axi_bresp_i[1]_i_1 
       (.I0(ip2bus_error),
        .I1(s_axi_bresp_i),
        .I2(s_axi_bresp),
        .O(\s_axi_bresp_i[1]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_bresp_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\s_axi_bresp_i[1]_i_1_n_0 ),
        .Q(s_axi_bresp),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_bvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_DECODER_n_5),
        .Q(s_axi_bvalid_i_reg_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[0] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [0]),
        .Q(s_axi_rdata[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[10] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [10]),
        .Q(s_axi_rdata[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[11] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [11]),
        .Q(s_axi_rdata[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[12] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [12]),
        .Q(s_axi_rdata[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[13] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [13]),
        .Q(s_axi_rdata[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[14] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [14]),
        .Q(s_axi_rdata[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[15] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [15]),
        .Q(s_axi_rdata[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[16] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [16]),
        .Q(s_axi_rdata[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[17] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [17]),
        .Q(s_axi_rdata[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[18] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [18]),
        .Q(s_axi_rdata[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[19] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [19]),
        .Q(s_axi_rdata[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [1]),
        .Q(s_axi_rdata[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[20] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [20]),
        .Q(s_axi_rdata[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[21] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [21]),
        .Q(s_axi_rdata[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[22] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [22]),
        .Q(s_axi_rdata[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[23] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [23]),
        .Q(s_axi_rdata[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[24] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [24]),
        .Q(s_axi_rdata[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[25] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [25]),
        .Q(s_axi_rdata[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[26] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [26]),
        .Q(s_axi_rdata[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[27] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [27]),
        .Q(s_axi_rdata[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[28] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [28]),
        .Q(s_axi_rdata[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[29] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [29]),
        .Q(s_axi_rdata[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[2] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [2]),
        .Q(s_axi_rdata[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[30] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [30]),
        .Q(s_axi_rdata[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[31] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [31]),
        .Q(s_axi_rdata[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[3] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [3]),
        .Q(s_axi_rdata[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[4] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [4]),
        .Q(s_axi_rdata[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[5] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [5]),
        .Q(s_axi_rdata[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[6] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [6]),
        .Q(s_axi_rdata[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[7] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [7]),
        .Q(s_axi_rdata[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[8] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [8]),
        .Q(s_axi_rdata[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rdata_i_reg[9] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(\s_axi_rdata_i_reg[31]_0 [9]),
        .Q(s_axi_rdata[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \s_axi_rresp_i_reg[1] 
       (.C(s_axi_aclk),
        .CE(s_axi_rresp_i),
        .D(ip2bus_error),
        .Q(s_axi_rresp),
        .R(rst));
  LUT5 #(
    .INIT(32'h75553000)) 
    s_axi_rvalid_i_i_1
       (.I0(s_axi_rready),
        .I1(\state_reg_n_0_[1] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(ip2bus_rdack_reg),
        .I4(s_axi_rvalid_i_reg_0),
        .O(s_axi_rvalid_i_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    s_axi_rvalid_i_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(s_axi_rvalid_i_i_1_n_0),
        .Q(s_axi_rvalid_i_reg_0),
        .R(rst));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h000F0008)) 
    start2_i_1
       (.I0(s_axi_wvalid),
        .I1(s_axi_awvalid),
        .I2(\state_reg_n_0_[1] ),
        .I3(\state_reg_n_0_[0] ),
        .I4(s_axi_arvalid),
        .O(start2_i_1_n_0));
  FDRE start2_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(start2_i_1_n_0),
        .Q(start2),
        .R(rst));
  LUT6 #(
    .INIT(64'h2C2F2C2CECEFECEC)) 
    \state[1]_i_1 
       (.I0(ip2bus_rdack_reg),
        .I1(\state_reg_n_0_[1] ),
        .I2(\state_reg_n_0_[0] ),
        .I3(s_axi_arvalid),
        .I4(\state[1]_i_2_n_0 ),
        .I5(\FSM_onehot_state[3]_i_2_n_0 ),
        .O(\state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \state[1]_i_2 
       (.I0(s_axi_wvalid),
        .I1(s_axi_awvalid),
        .O(\state[1]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(I_DECODER_n_4),
        .Q(\state_reg_n_0_[0] ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \state_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\state[1]_i_1_n_0 ),
        .Q(\state_reg_n_0_[1] ),
        .R(rst));
endmodule

(* ORIG_REF_NAME = "window_wdt_counter" *) 
module mbv_system_axi_timebase_wdt_0_0_window_wdt_counter
   (minusOp,
    Q,
    wint_int,
    dis_wdt_cnt,
    dis_wdt_int_reg_0,
    PSME_reg_reg,
    \LBE_reg_reg[0] ,
    dis_wdt_int_reg_1,
    D,
    \FW_reg_reg[22] ,
    WEN_clear_reg_reg,
    \FSM_sequential_WDT_Current_State_reg[0] ,
    \FSM_sequential_WDT_Current_State_reg[1] ,
    wdt_reset_reg_reg,
    \SW_reg_reg[8] ,
    \SW_reg_reg[21] ,
    \SW_reg_reg[26] ,
    \SW_reg_reg[0] ,
    \SW_reg_reg[25] ,
    \SW_reg_reg[5] ,
    dis_wdt_int_reg_2,
    SR,
    S,
    \FW_reg_reg[29] ,
    \FW_reg_reg[12] ,
    wdt_reset_reg_reg_0,
    s_axi_aclk,
    wint_int_reg_0,
    wint_int_reg_1,
    wint_int_reg_2,
    LBE_reg,
    \LBE_reg_reg[0]_0 ,
    LBE_reg0,
    s_axi_aresetn,
    wint_int_reg_3,
    \FSM_sequential_WDT_Current_State_reg[1]_0 ,
    \FSM_sequential_WDT_Current_State_reg[0]_0 ,
    \FSM_sequential_WDT_Current_State_reg[0]_1 ,
    fc_sst_enc,
    \FSM_sequential_WDT_Current_State_reg[0]_2 ,
    wdt_reset_reg_reg_1,
    \FSM_sequential_WDT_Current_State_reg[1]_1 ,
    \FSM_sequential_WDT_Current_State[0]_i_3_0 ,
    CO,
    PSME_reg,
    \FSM_sequential_WDT_Current_State[0]_i_3_1 ,
    \LBE_reg_reg[0]_1 ,
    \FSM_sequential_WDT_Current_State_reg[1]_2 ,
    \int_cnt_int[7]_i_3 ,
    WEN_change,
    p_11_in,
    \int_cnt_int[7]_i_3_0 ,
    \int_cnt_int[31]_i_12_0 ,
    load_val9_carry__1,
    load_val9_carry__1_0,
    wint_int_reg_4,
    wint_int_i_6_0,
    \int_cnt_int[31]_i_14_0 ,
    wdt_reset_reg_reg_2,
    wdt_reset_reg_reg_3,
    wdt_reset_int,
    E,
    \int_cnt_int_reg[31]_0 );
  output [30:0]minusOp;
  output [7:0]Q;
  output wint_int;
  output dis_wdt_cnt;
  output dis_wdt_int_reg_0;
  output PSME_reg_reg;
  output \LBE_reg_reg[0] ;
  output dis_wdt_int_reg_1;
  output [1:0]D;
  output \FW_reg_reg[22] ;
  output WEN_clear_reg_reg;
  output \FSM_sequential_WDT_Current_State_reg[0] ;
  output \FSM_sequential_WDT_Current_State_reg[1] ;
  output wdt_reset_reg_reg;
  output \SW_reg_reg[8] ;
  output \SW_reg_reg[21] ;
  output \SW_reg_reg[26] ;
  output \SW_reg_reg[0] ;
  output \SW_reg_reg[25] ;
  output \SW_reg_reg[5] ;
  output dis_wdt_int_reg_2;
  output [0:0]SR;
  output [2:0]S;
  output \FW_reg_reg[29] ;
  output \FW_reg_reg[12] ;
  output wdt_reset_reg_reg_0;
  input s_axi_aclk;
  input wint_int_reg_0;
  input wint_int_reg_1;
  input wint_int_reg_2;
  input [0:0]LBE_reg;
  input \LBE_reg_reg[0]_0 ;
  input LBE_reg0;
  input s_axi_aresetn;
  input wint_int_reg_3;
  input \FSM_sequential_WDT_Current_State_reg[1]_0 ;
  input \FSM_sequential_WDT_Current_State_reg[0]_0 ;
  input [1:0]\FSM_sequential_WDT_Current_State_reg[0]_1 ;
  input [0:0]fc_sst_enc;
  input \FSM_sequential_WDT_Current_State_reg[0]_2 ;
  input wdt_reset_reg_reg_1;
  input \FSM_sequential_WDT_Current_State_reg[1]_1 ;
  input \FSM_sequential_WDT_Current_State[0]_i_3_0 ;
  input [0:0]CO;
  input PSME_reg;
  input \FSM_sequential_WDT_Current_State[0]_i_3_1 ;
  input \LBE_reg_reg[0]_1 ;
  input \FSM_sequential_WDT_Current_State_reg[1]_2 ;
  input \int_cnt_int[7]_i_3 ;
  input WEN_change;
  input [0:0]p_11_in;
  input \int_cnt_int[7]_i_3_0 ;
  input [31:0]\int_cnt_int[31]_i_12_0 ;
  input [7:0]load_val9_carry__1;
  input [7:0]load_val9_carry__1_0;
  input [1:0]wint_int_reg_4;
  input [7:0]wint_int_i_6_0;
  input [31:0]\int_cnt_int[31]_i_14_0 ;
  input wdt_reset_reg_reg_2;
  input wdt_reset_reg_reg_3;
  input wdt_reset_int;
  input [0:0]E;
  input [31:0]\int_cnt_int_reg[31]_0 ;

  wire [0:0]CO;
  wire [1:0]D;
  wire [0:0]E;
  wire \FSM_sequential_WDT_Current_State[0]_i_3_0 ;
  wire \FSM_sequential_WDT_Current_State[0]_i_3_1 ;
  wire \FSM_sequential_WDT_Current_State[0]_i_3_n_0 ;
  wire \FSM_sequential_WDT_Current_State[0]_i_5_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_12_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_13_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_14_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_15_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_4_n_0 ;
  wire \FSM_sequential_WDT_Current_State[1]_i_5_n_0 ;
  wire \FSM_sequential_WDT_Current_State_reg[0] ;
  wire \FSM_sequential_WDT_Current_State_reg[0]_0 ;
  wire [1:0]\FSM_sequential_WDT_Current_State_reg[0]_1 ;
  wire \FSM_sequential_WDT_Current_State_reg[0]_2 ;
  wire \FSM_sequential_WDT_Current_State_reg[1] ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_0 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_1 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_2 ;
  wire \FW_reg_reg[12] ;
  wire \FW_reg_reg[22] ;
  wire \FW_reg_reg[29] ;
  wire [0:0]LBE_reg;
  wire LBE_reg0;
  wire \LBE_reg_reg[0] ;
  wire \LBE_reg_reg[0]_0 ;
  wire \LBE_reg_reg[0]_1 ;
  wire PSME_reg;
  wire PSME_reg_reg;
  wire [7:0]Q;
  wire [2:0]S;
  wire [0:0]SR;
  wire \SW_reg_reg[0] ;
  wire \SW_reg_reg[21] ;
  wire \SW_reg_reg[25] ;
  wire \SW_reg_reg[26] ;
  wire \SW_reg_reg[5] ;
  wire \SW_reg_reg[8] ;
  wire WEN_change;
  wire WEN_clear_reg_reg;
  wire dis_wdt_cnt;
  wire dis_wdt_int_i_1_n_0;
  wire dis_wdt_int_i_2_n_0;
  wire dis_wdt_int_i_3_n_0;
  wire dis_wdt_int_i_4_n_0;
  wire dis_wdt_int_i_5_n_0;
  wire dis_wdt_int_i_6_n_0;
  wire dis_wdt_int_reg_0;
  wire dis_wdt_int_reg_1;
  wire dis_wdt_int_reg_2;
  wire [0:0]fc_sst_enc;
  wire [31:0]\int_cnt_int[31]_i_12_0 ;
  wire [31:0]\int_cnt_int[31]_i_14_0 ;
  wire \int_cnt_int[31]_i_17_n_0 ;
  wire \int_cnt_int[31]_i_18_n_0 ;
  wire \int_cnt_int[31]_i_19_n_0 ;
  wire \int_cnt_int[31]_i_20_n_0 ;
  wire \int_cnt_int[31]_i_21_n_0 ;
  wire \int_cnt_int[31]_i_22_n_0 ;
  wire \int_cnt_int[31]_i_23_n_0 ;
  wire \int_cnt_int[31]_i_24_n_0 ;
  wire \int_cnt_int[31]_i_25_n_0 ;
  wire \int_cnt_int[31]_i_26_n_0 ;
  wire \int_cnt_int[31]_i_27_n_0 ;
  wire \int_cnt_int[31]_i_28_n_0 ;
  wire \int_cnt_int[31]_i_29_n_0 ;
  wire \int_cnt_int[31]_i_30_n_0 ;
  wire \int_cnt_int[31]_i_31_n_0 ;
  wire \int_cnt_int[31]_i_32_n_0 ;
  wire \int_cnt_int[7]_i_3 ;
  wire \int_cnt_int[7]_i_3_0 ;
  wire [31:0]\int_cnt_int_reg[31]_0 ;
  wire \int_cnt_int_reg_n_0_[10] ;
  wire \int_cnt_int_reg_n_0_[11] ;
  wire \int_cnt_int_reg_n_0_[12] ;
  wire \int_cnt_int_reg_n_0_[13] ;
  wire \int_cnt_int_reg_n_0_[14] ;
  wire \int_cnt_int_reg_n_0_[15] ;
  wire \int_cnt_int_reg_n_0_[16] ;
  wire \int_cnt_int_reg_n_0_[17] ;
  wire \int_cnt_int_reg_n_0_[18] ;
  wire \int_cnt_int_reg_n_0_[19] ;
  wire \int_cnt_int_reg_n_0_[20] ;
  wire \int_cnt_int_reg_n_0_[21] ;
  wire \int_cnt_int_reg_n_0_[22] ;
  wire \int_cnt_int_reg_n_0_[23] ;
  wire \int_cnt_int_reg_n_0_[24] ;
  wire \int_cnt_int_reg_n_0_[25] ;
  wire \int_cnt_int_reg_n_0_[26] ;
  wire \int_cnt_int_reg_n_0_[27] ;
  wire \int_cnt_int_reg_n_0_[28] ;
  wire \int_cnt_int_reg_n_0_[29] ;
  wire \int_cnt_int_reg_n_0_[30] ;
  wire \int_cnt_int_reg_n_0_[31] ;
  wire \int_cnt_int_reg_n_0_[8] ;
  wire \int_cnt_int_reg_n_0_[9] ;
  wire [7:0]load_val9_carry__1;
  wire [7:0]load_val9_carry__1_0;
  wire [30:0]minusOp;
  wire minusOp_carry__0_i_1_n_0;
  wire minusOp_carry__0_i_2_n_0;
  wire minusOp_carry__0_i_3_n_0;
  wire minusOp_carry__0_i_4_n_0;
  wire minusOp_carry__0_n_0;
  wire minusOp_carry__0_n_1;
  wire minusOp_carry__0_n_2;
  wire minusOp_carry__0_n_3;
  wire minusOp_carry__1_i_1_n_0;
  wire minusOp_carry__1_i_2_n_0;
  wire minusOp_carry__1_i_3_n_0;
  wire minusOp_carry__1_i_4_n_0;
  wire minusOp_carry__1_n_0;
  wire minusOp_carry__1_n_1;
  wire minusOp_carry__1_n_2;
  wire minusOp_carry__1_n_3;
  wire minusOp_carry__2_i_1_n_0;
  wire minusOp_carry__2_i_2_n_0;
  wire minusOp_carry__2_i_3_n_0;
  wire minusOp_carry__2_i_4_n_0;
  wire minusOp_carry__2_n_0;
  wire minusOp_carry__2_n_1;
  wire minusOp_carry__2_n_2;
  wire minusOp_carry__2_n_3;
  wire minusOp_carry__3_i_1_n_0;
  wire minusOp_carry__3_i_2_n_0;
  wire minusOp_carry__3_i_3_n_0;
  wire minusOp_carry__3_i_4_n_0;
  wire minusOp_carry__3_n_0;
  wire minusOp_carry__3_n_1;
  wire minusOp_carry__3_n_2;
  wire minusOp_carry__3_n_3;
  wire minusOp_carry__4_i_1_n_0;
  wire minusOp_carry__4_i_2_n_0;
  wire minusOp_carry__4_i_3_n_0;
  wire minusOp_carry__4_i_4_n_0;
  wire minusOp_carry__4_n_0;
  wire minusOp_carry__4_n_1;
  wire minusOp_carry__4_n_2;
  wire minusOp_carry__4_n_3;
  wire minusOp_carry__5_i_1_n_0;
  wire minusOp_carry__5_i_2_n_0;
  wire minusOp_carry__5_i_3_n_0;
  wire minusOp_carry__5_i_4_n_0;
  wire minusOp_carry__5_n_0;
  wire minusOp_carry__5_n_1;
  wire minusOp_carry__5_n_2;
  wire minusOp_carry__5_n_3;
  wire minusOp_carry__6_i_1_n_0;
  wire minusOp_carry__6_i_2_n_0;
  wire minusOp_carry__6_i_3_n_0;
  wire minusOp_carry__6_n_2;
  wire minusOp_carry__6_n_3;
  wire minusOp_carry_i_1_n_0;
  wire minusOp_carry_i_2_n_0;
  wire minusOp_carry_i_3_n_0;
  wire minusOp_carry_i_4_n_0;
  wire minusOp_carry_n_0;
  wire minusOp_carry_n_1;
  wire minusOp_carry_n_2;
  wire minusOp_carry_n_3;
  wire [0:0]p_11_in;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire wdt_reset_int;
  wire wdt_reset_reg_i_3_n_0;
  wire wdt_reset_reg_i_6_n_0;
  wire wdt_reset_reg_reg;
  wire wdt_reset_reg_reg_0;
  wire wdt_reset_reg_reg_1;
  wire wdt_reset_reg_reg_2;
  wire wdt_reset_reg_reg_3;
  wire wint_int;
  wire wint_int_i_10_n_0;
  wire wint_int_i_11_n_0;
  wire wint_int_i_12_n_0;
  wire wint_int_i_13_n_0;
  wire wint_int_i_14_n_0;
  wire wint_int_i_15_n_0;
  wire wint_int_i_16_n_0;
  wire wint_int_i_17_n_0;
  wire wint_int_i_18_n_0;
  wire wint_int_i_19_n_0;
  wire wint_int_i_1_n_0;
  wire wint_int_i_20_n_0;
  wire wint_int_i_21_n_0;
  wire wint_int_i_22_n_0;
  wire wint_int_i_23_n_0;
  wire wint_int_i_24_n_0;
  wire wint_int_i_25_n_0;
  wire wint_int_i_26_n_0;
  wire wint_int_i_27_n_0;
  wire wint_int_i_28_n_0;
  wire wint_int_i_29_n_0;
  wire wint_int_i_2_n_0;
  wire wint_int_i_3_n_0;
  wire wint_int_i_4_n_0;
  wire wint_int_i_5_n_0;
  wire [7:0]wint_int_i_6_0;
  wire wint_int_i_6_n_0;
  wire wint_int_i_7_n_0;
  wire wint_int_i_8_n_0;
  wire wint_int_i_9_n_0;
  wire wint_int_reg_0;
  wire wint_int_reg_1;
  wire wint_int_reg_2;
  wire wint_int_reg_3;
  wire [1:0]wint_int_reg_4;
  wire [3:2]NLW_minusOp_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_minusOp_carry__6_O_UNCONNECTED;

  LUT6 #(
    .INIT(64'hFFFFFFFF0F880088)) 
    \FSM_sequential_WDT_Current_State[0]_i_1 
       (.I0(\FSM_sequential_WDT_Current_State_reg[0]_0 ),
        .I1(\FSM_sequential_WDT_Current_State[0]_i_3_n_0 ),
        .I2(dis_wdt_cnt),
        .I3(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I4(fc_sst_enc),
        .I5(dis_wdt_int_reg_0),
        .O(D[0]));
  LUT6 #(
    .INIT(64'h888888880000000F)) 
    \FSM_sequential_WDT_Current_State[0]_i_3 
       (.I0(fc_sst_enc),
        .I1(\FSM_sequential_WDT_Current_State[0]_i_5_n_0 ),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_2 ),
        .I3(\FW_reg_reg[22] ),
        .I4(wdt_reset_reg_reg_1),
        .I5(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .O(\FSM_sequential_WDT_Current_State[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h44444440)) 
    \FSM_sequential_WDT_Current_State[0]_i_4 
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I3(WEN_clear_reg_reg),
        .I4(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .O(dis_wdt_int_reg_0));
  LUT6 #(
    .INIT(64'h22EE222203FF0303)) 
    \FSM_sequential_WDT_Current_State[0]_i_5 
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I2(\FSM_sequential_WDT_Current_State[0]_i_3_0 ),
        .I3(CO),
        .I4(PSME_reg),
        .I5(\FSM_sequential_WDT_Current_State[0]_i_3_1 ),
        .O(\FSM_sequential_WDT_Current_State[0]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hF4F4F4FFF4F4FFFF)) 
    \FSM_sequential_WDT_Current_State[1]_i_1 
       (.I0(\FSM_sequential_WDT_Current_State_reg[1]_0 ),
        .I1(\FW_reg_reg[22] ),
        .I2(\FSM_sequential_WDT_Current_State[1]_i_4_n_0 ),
        .I3(\FSM_sequential_WDT_Current_State[1]_i_5_n_0 ),
        .I4(\LBE_reg_reg[0]_0 ),
        .I5(PSME_reg_reg),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_10 
       (.I0(\int_cnt_int[31]_i_12_0 [21]),
        .I1(\int_cnt_int[31]_i_12_0 [18]),
        .I2(\int_cnt_int[31]_i_12_0 [29]),
        .I3(\int_cnt_int[31]_i_12_0 [17]),
        .I4(\int_cnt_int[31]_i_19_n_0 ),
        .O(\SW_reg_reg[21] ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \FSM_sequential_WDT_Current_State[1]_i_11 
       (.I0(\int_cnt_int[31]_i_12_0 [26]),
        .I1(\int_cnt_int[31]_i_12_0 [19]),
        .I2(\int_cnt_int[31]_i_12_0 [16]),
        .I3(\int_cnt_int[31]_i_12_0 [13]),
        .I4(\int_cnt_int[31]_i_17_n_0 ),
        .O(\SW_reg_reg[26] ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_12 
       (.I0(\int_cnt_int[31]_i_14_0 [22]),
        .I1(\int_cnt_int[31]_i_14_0 [21]),
        .I2(\int_cnt_int[31]_i_14_0 [23]),
        .I3(\int_cnt_int[31]_i_14_0 [20]),
        .I4(\int_cnt_int[31]_i_31_n_0 ),
        .O(\FSM_sequential_WDT_Current_State[1]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'h00000001)) 
    \FSM_sequential_WDT_Current_State[1]_i_13 
       (.I0(\int_cnt_int[31]_i_14_0 [11]),
        .I1(\int_cnt_int[31]_i_14_0 [8]),
        .I2(\int_cnt_int[31]_i_14_0 [10]),
        .I3(\int_cnt_int[31]_i_14_0 [9]),
        .I4(\int_cnt_int[31]_i_29_n_0 ),
        .O(\FSM_sequential_WDT_Current_State[1]_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_14 
       (.I0(\int_cnt_int[31]_i_14_0 [27]),
        .I1(\int_cnt_int[31]_i_14_0 [26]),
        .I2(\int_cnt_int[31]_i_14_0 [25]),
        .I3(\int_cnt_int[31]_i_14_0 [24]),
        .I4(\int_cnt_int[31]_i_27_n_0 ),
        .O(\FSM_sequential_WDT_Current_State[1]_i_14_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_15 
       (.I0(\int_cnt_int[31]_i_14_0 [2]),
        .I1(\int_cnt_int[31]_i_14_0 [1]),
        .I2(\int_cnt_int[31]_i_14_0 [3]),
        .I3(\int_cnt_int[31]_i_14_0 [0]),
        .I4(\int_cnt_int[31]_i_25_n_0 ),
        .O(\FSM_sequential_WDT_Current_State[1]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h0004)) 
    \FSM_sequential_WDT_Current_State[1]_i_3 
       (.I0(\FSM_sequential_WDT_Current_State[1]_i_12_n_0 ),
        .I1(\FSM_sequential_WDT_Current_State[1]_i_13_n_0 ),
        .I2(\FSM_sequential_WDT_Current_State[1]_i_14_n_0 ),
        .I3(\FSM_sequential_WDT_Current_State[1]_i_15_n_0 ),
        .O(\FW_reg_reg[22] ));
  LUT6 #(
    .INIT(64'h2828282A28282828)) 
    \FSM_sequential_WDT_Current_State[1]_i_4 
       (.I0(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I1(dis_wdt_cnt),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I3(WEN_clear_reg_reg),
        .I4(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .I5(fc_sst_enc),
        .O(\FSM_sequential_WDT_Current_State[1]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hE0EF)) 
    \FSM_sequential_WDT_Current_State[1]_i_5 
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I2(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .I3(fc_sst_enc),
        .O(\FSM_sequential_WDT_Current_State[1]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFF04FFFF)) 
    \FSM_sequential_WDT_Current_State[1]_i_7 
       (.I0(CO),
        .I1(PSME_reg),
        .I2(WEN_clear_reg_reg),
        .I3(dis_wdt_cnt),
        .I4(\LBE_reg_reg[0]_1 ),
        .O(PSME_reg_reg));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_8 
       (.I0(\int_cnt_int[31]_i_12_0 [25]),
        .I1(\int_cnt_int[31]_i_12_0 [11]),
        .I2(\int_cnt_int[31]_i_12_0 [24]),
        .I3(\int_cnt_int[31]_i_12_0 [14]),
        .I4(\int_cnt_int[31]_i_23_n_0 ),
        .O(\SW_reg_reg[25] ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \FSM_sequential_WDT_Current_State[1]_i_9 
       (.I0(\int_cnt_int[31]_i_12_0 [5]),
        .I1(\int_cnt_int[31]_i_12_0 [3]),
        .I2(\int_cnt_int[31]_i_12_0 [23]),
        .I3(\int_cnt_int[31]_i_12_0 [20]),
        .I4(\int_cnt_int[31]_i_21_n_0 ),
        .O(\SW_reg_reg[5] ));
  LUT6 #(
    .INIT(64'h00000000FFAEFFA2)) 
    \LBE_reg[0]_i_1 
       (.I0(LBE_reg),
        .I1(PSME_reg_reg),
        .I2(\LBE_reg_reg[0]_0 ),
        .I3(dis_wdt_int_reg_1),
        .I4(dis_wdt_cnt),
        .I5(LBE_reg0),
        .O(\LBE_reg_reg[0] ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT4 #(
    .INIT(16'h0004)) 
    \LBE_reg[0]_i_2 
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I2(WEN_clear_reg_reg),
        .I3(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .O(dis_wdt_int_reg_1));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    WCFG_reg_In_i_3
       (.I0(wdt_reset_reg_reg_1),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .O(wdt_reset_reg_reg));
  LUT5 #(
    .INIT(32'h00000020)) 
    dis_wdt_int_i_1
       (.I0(dis_wdt_int_i_2_n_0),
        .I1(dis_wdt_int_i_3_n_0),
        .I2(Q[0]),
        .I3(dis_wdt_int_i_4_n_0),
        .I4(dis_wdt_int_i_5_n_0),
        .O(dis_wdt_int_i_1_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    dis_wdt_int_i_2
       (.I0(dis_wdt_int_i_6_n_0),
        .I1(\int_cnt_int_reg_n_0_[17] ),
        .I2(\int_cnt_int_reg_n_0_[16] ),
        .I3(wint_int_i_7_n_0),
        .O(dis_wdt_int_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    dis_wdt_int_i_3
       (.I0(Q[7]),
        .I1(Q[6]),
        .I2(Q[4]),
        .I3(Q[5]),
        .O(dis_wdt_int_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    dis_wdt_int_i_4
       (.I0(Q[2]),
        .I1(Q[1]),
        .I2(Q[3]),
        .O(dis_wdt_int_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    dis_wdt_int_i_5
       (.I0(\int_cnt_int_reg_n_0_[8] ),
        .I1(\int_cnt_int_reg_n_0_[9] ),
        .I2(wint_int_i_8_n_0),
        .O(dis_wdt_int_i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    dis_wdt_int_i_6
       (.I0(\int_cnt_int_reg_n_0_[23] ),
        .I1(\int_cnt_int_reg_n_0_[22] ),
        .I2(\int_cnt_int_reg_n_0_[21] ),
        .I3(\int_cnt_int_reg_n_0_[20] ),
        .I4(\int_cnt_int_reg_n_0_[18] ),
        .I5(\int_cnt_int_reg_n_0_[19] ),
        .O(dis_wdt_int_i_6_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dis_wdt_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dis_wdt_int_i_1_n_0),
        .Q(dis_wdt_cnt),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \int_cnt_int[31]_i_10 
       (.I0(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I1(WEN_clear_reg_reg),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .O(\FSM_sequential_WDT_Current_State_reg[0] ));
  LUT4 #(
    .INIT(16'h0004)) 
    \int_cnt_int[31]_i_12 
       (.I0(\int_cnt_int[31]_i_17_n_0 ),
        .I1(\int_cnt_int[31]_i_18_n_0 ),
        .I2(\int_cnt_int[31]_i_19_n_0 ),
        .I3(\int_cnt_int[31]_i_20_n_0 ),
        .O(\SW_reg_reg[8] ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_13 
       (.I0(\int_cnt_int[31]_i_21_n_0 ),
        .I1(\int_cnt_int[31]_i_22_n_0 ),
        .I2(\int_cnt_int[31]_i_23_n_0 ),
        .I3(\int_cnt_int[31]_i_24_n_0 ),
        .O(\SW_reg_reg[0] ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_14 
       (.I0(\int_cnt_int[31]_i_25_n_0 ),
        .I1(\int_cnt_int[31]_i_26_n_0 ),
        .I2(\int_cnt_int[31]_i_27_n_0 ),
        .I3(\int_cnt_int[31]_i_28_n_0 ),
        .O(\FW_reg_reg[29] ));
  LUT4 #(
    .INIT(16'h0004)) 
    \int_cnt_int[31]_i_15 
       (.I0(\int_cnt_int[31]_i_29_n_0 ),
        .I1(\int_cnt_int[31]_i_30_n_0 ),
        .I2(\int_cnt_int[31]_i_31_n_0 ),
        .I3(\int_cnt_int[31]_i_32_n_0 ),
        .O(\FW_reg_reg[12] ));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT3 #(
    .INIT(8'h40)) 
    \int_cnt_int[31]_i_16 
       (.I0(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .I2(dis_wdt_cnt),
        .O(\FSM_sequential_WDT_Current_State_reg[1] ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_17 
       (.I0(\int_cnt_int[31]_i_12_0 [8]),
        .I1(\int_cnt_int[31]_i_12_0 [12]),
        .I2(\int_cnt_int[31]_i_12_0 [9]),
        .I3(\int_cnt_int[31]_i_12_0 [10]),
        .O(\int_cnt_int[31]_i_17_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \int_cnt_int[31]_i_18 
       (.I0(\int_cnt_int[31]_i_12_0 [13]),
        .I1(\int_cnt_int[31]_i_12_0 [16]),
        .I2(\int_cnt_int[31]_i_12_0 [19]),
        .I3(\int_cnt_int[31]_i_12_0 [26]),
        .O(\int_cnt_int[31]_i_18_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_19 
       (.I0(\int_cnt_int[31]_i_12_0 [28]),
        .I1(\int_cnt_int[31]_i_12_0 [31]),
        .I2(\int_cnt_int[31]_i_12_0 [27]),
        .I3(\int_cnt_int[31]_i_12_0 [30]),
        .O(\int_cnt_int[31]_i_19_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_20 
       (.I0(\int_cnt_int[31]_i_12_0 [17]),
        .I1(\int_cnt_int[31]_i_12_0 [29]),
        .I2(\int_cnt_int[31]_i_12_0 [18]),
        .I3(\int_cnt_int[31]_i_12_0 [21]),
        .O(\int_cnt_int[31]_i_20_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_21 
       (.I0(\int_cnt_int[31]_i_12_0 [0]),
        .I1(\int_cnt_int[31]_i_12_0 [4]),
        .I2(\int_cnt_int[31]_i_12_0 [2]),
        .I3(\int_cnt_int[31]_i_12_0 [7]),
        .O(\int_cnt_int[31]_i_21_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_22 
       (.I0(\int_cnt_int[31]_i_12_0 [20]),
        .I1(\int_cnt_int[31]_i_12_0 [23]),
        .I2(\int_cnt_int[31]_i_12_0 [3]),
        .I3(\int_cnt_int[31]_i_12_0 [5]),
        .O(\int_cnt_int[31]_i_22_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_23 
       (.I0(\int_cnt_int[31]_i_12_0 [1]),
        .I1(\int_cnt_int[31]_i_12_0 [22]),
        .I2(\int_cnt_int[31]_i_12_0 [6]),
        .I3(\int_cnt_int[31]_i_12_0 [15]),
        .O(\int_cnt_int[31]_i_23_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_24 
       (.I0(\int_cnt_int[31]_i_12_0 [14]),
        .I1(\int_cnt_int[31]_i_12_0 [24]),
        .I2(\int_cnt_int[31]_i_12_0 [11]),
        .I3(\int_cnt_int[31]_i_12_0 [25]),
        .O(\int_cnt_int[31]_i_24_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_25 
       (.I0(\int_cnt_int[31]_i_14_0 [29]),
        .I1(\int_cnt_int[31]_i_14_0 [31]),
        .I2(\int_cnt_int[31]_i_14_0 [28]),
        .I3(\int_cnt_int[31]_i_14_0 [30]),
        .O(\int_cnt_int[31]_i_25_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_26 
       (.I0(\int_cnt_int[31]_i_14_0 [0]),
        .I1(\int_cnt_int[31]_i_14_0 [3]),
        .I2(\int_cnt_int[31]_i_14_0 [1]),
        .I3(\int_cnt_int[31]_i_14_0 [2]),
        .O(\int_cnt_int[31]_i_26_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_27 
       (.I0(\int_cnt_int[31]_i_14_0 [6]),
        .I1(\int_cnt_int[31]_i_14_0 [7]),
        .I2(\int_cnt_int[31]_i_14_0 [4]),
        .I3(\int_cnt_int[31]_i_14_0 [5]),
        .O(\int_cnt_int[31]_i_27_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_28 
       (.I0(\int_cnt_int[31]_i_14_0 [24]),
        .I1(\int_cnt_int[31]_i_14_0 [25]),
        .I2(\int_cnt_int[31]_i_14_0 [26]),
        .I3(\int_cnt_int[31]_i_14_0 [27]),
        .O(\int_cnt_int[31]_i_28_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_29 
       (.I0(\int_cnt_int[31]_i_14_0 [12]),
        .I1(\int_cnt_int[31]_i_14_0 [13]),
        .I2(\int_cnt_int[31]_i_14_0 [14]),
        .I3(\int_cnt_int[31]_i_14_0 [15]),
        .O(\int_cnt_int[31]_i_29_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    \int_cnt_int[31]_i_30 
       (.I0(\int_cnt_int[31]_i_14_0 [9]),
        .I1(\int_cnt_int[31]_i_14_0 [10]),
        .I2(\int_cnt_int[31]_i_14_0 [8]),
        .I3(\int_cnt_int[31]_i_14_0 [11]),
        .O(\int_cnt_int[31]_i_30_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_31 
       (.I0(\int_cnt_int[31]_i_14_0 [18]),
        .I1(\int_cnt_int[31]_i_14_0 [19]),
        .I2(\int_cnt_int[31]_i_14_0 [16]),
        .I3(\int_cnt_int[31]_i_14_0 [17]),
        .O(\int_cnt_int[31]_i_31_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \int_cnt_int[31]_i_32 
       (.I0(\int_cnt_int[31]_i_14_0 [20]),
        .I1(\int_cnt_int[31]_i_14_0 [23]),
        .I2(\int_cnt_int[31]_i_14_0 [21]),
        .I3(\int_cnt_int[31]_i_14_0 [22]),
        .O(\int_cnt_int[31]_i_32_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \int_cnt_int[31]_i_8 
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .O(dis_wdt_int_reg_2));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[0] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [0]),
        .Q(Q[0]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[10] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [10]),
        .Q(\int_cnt_int_reg_n_0_[10] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[11] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [11]),
        .Q(\int_cnt_int_reg_n_0_[11] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[12] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [12]),
        .Q(\int_cnt_int_reg_n_0_[12] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[13] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [13]),
        .Q(\int_cnt_int_reg_n_0_[13] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[14] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [14]),
        .Q(\int_cnt_int_reg_n_0_[14] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[15] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [15]),
        .Q(\int_cnt_int_reg_n_0_[15] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[16] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [16]),
        .Q(\int_cnt_int_reg_n_0_[16] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[17] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [17]),
        .Q(\int_cnt_int_reg_n_0_[17] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[18] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [18]),
        .Q(\int_cnt_int_reg_n_0_[18] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[19] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [19]),
        .Q(\int_cnt_int_reg_n_0_[19] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[1] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [1]),
        .Q(Q[1]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[20] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [20]),
        .Q(\int_cnt_int_reg_n_0_[20] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[21] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [21]),
        .Q(\int_cnt_int_reg_n_0_[21] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[22] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [22]),
        .Q(\int_cnt_int_reg_n_0_[22] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[23] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [23]),
        .Q(\int_cnt_int_reg_n_0_[23] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[24] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [24]),
        .Q(\int_cnt_int_reg_n_0_[24] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[25] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [25]),
        .Q(\int_cnt_int_reg_n_0_[25] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[26] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [26]),
        .Q(\int_cnt_int_reg_n_0_[26] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[27] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [27]),
        .Q(\int_cnt_int_reg_n_0_[27] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[28] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [28]),
        .Q(\int_cnt_int_reg_n_0_[28] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[29] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [29]),
        .Q(\int_cnt_int_reg_n_0_[29] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [2]),
        .Q(Q[2]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[30] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [30]),
        .Q(\int_cnt_int_reg_n_0_[30] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[31] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [31]),
        .Q(\int_cnt_int_reg_n_0_[31] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[3] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [3]),
        .Q(Q[3]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[4] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [4]),
        .Q(Q[4]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[5] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [5]),
        .Q(Q[5]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[6] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [6]),
        .Q(Q[6]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[7] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [7]),
        .Q(Q[7]),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[8] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [8]),
        .Q(\int_cnt_int_reg_n_0_[8] ),
        .R(SR));
  FDRE #(
    .INIT(1'b0)) 
    \int_cnt_int_reg[9] 
       (.C(s_axi_aclk),
        .CE(E),
        .D(\int_cnt_int_reg[31]_0 [9]),
        .Q(\int_cnt_int_reg_n_0_[9] ),
        .R(SR));
  LUT4 #(
    .INIT(16'h9009)) 
    load_val9_carry__1_i_1
       (.I0(load_val9_carry__1[6]),
        .I1(load_val9_carry__1_0[6]),
        .I2(load_val9_carry__1_0[7]),
        .I3(load_val9_carry__1[7]),
        .O(S[2]));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__1_i_2
       (.I0(load_val9_carry__1_0[3]),
        .I1(load_val9_carry__1[3]),
        .I2(load_val9_carry__1_0[5]),
        .I3(load_val9_carry__1[5]),
        .I4(load_val9_carry__1[4]),
        .I5(load_val9_carry__1_0[4]),
        .O(S[1]));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    load_val9_carry__1_i_3
       (.I0(load_val9_carry__1_0[2]),
        .I1(load_val9_carry__1[2]),
        .I2(load_val9_carry__1_0[0]),
        .I3(load_val9_carry__1[0]),
        .I4(load_val9_carry__1[1]),
        .I5(load_val9_carry__1_0[1]),
        .O(S[0]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry
       (.CI(1'b0),
        .CO({minusOp_carry_n_0,minusOp_carry_n_1,minusOp_carry_n_2,minusOp_carry_n_3}),
        .CYINIT(Q[0]),
        .DI(Q[4:1]),
        .O(minusOp[3:0]),
        .S({minusOp_carry_i_1_n_0,minusOp_carry_i_2_n_0,minusOp_carry_i_3_n_0,minusOp_carry_i_4_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__0
       (.CI(minusOp_carry_n_0),
        .CO({minusOp_carry__0_n_0,minusOp_carry__0_n_1,minusOp_carry__0_n_2,minusOp_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[8] ,Q[7:5]}),
        .O(minusOp[7:4]),
        .S({minusOp_carry__0_i_1_n_0,minusOp_carry__0_i_2_n_0,minusOp_carry__0_i_3_n_0,minusOp_carry__0_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_1
       (.I0(\int_cnt_int_reg_n_0_[8] ),
        .O(minusOp_carry__0_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_2
       (.I0(Q[7]),
        .O(minusOp_carry__0_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_3
       (.I0(Q[6]),
        .O(minusOp_carry__0_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__0_i_4
       (.I0(Q[5]),
        .O(minusOp_carry__0_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__1
       (.CI(minusOp_carry__0_n_0),
        .CO({minusOp_carry__1_n_0,minusOp_carry__1_n_1,minusOp_carry__1_n_2,minusOp_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[12] ,\int_cnt_int_reg_n_0_[11] ,\int_cnt_int_reg_n_0_[10] ,\int_cnt_int_reg_n_0_[9] }),
        .O(minusOp[11:8]),
        .S({minusOp_carry__1_i_1_n_0,minusOp_carry__1_i_2_n_0,minusOp_carry__1_i_3_n_0,minusOp_carry__1_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_1
       (.I0(\int_cnt_int_reg_n_0_[12] ),
        .O(minusOp_carry__1_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_2
       (.I0(\int_cnt_int_reg_n_0_[11] ),
        .O(minusOp_carry__1_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_3
       (.I0(\int_cnt_int_reg_n_0_[10] ),
        .O(minusOp_carry__1_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__1_i_4
       (.I0(\int_cnt_int_reg_n_0_[9] ),
        .O(minusOp_carry__1_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__2
       (.CI(minusOp_carry__1_n_0),
        .CO({minusOp_carry__2_n_0,minusOp_carry__2_n_1,minusOp_carry__2_n_2,minusOp_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[16] ,\int_cnt_int_reg_n_0_[15] ,\int_cnt_int_reg_n_0_[14] ,\int_cnt_int_reg_n_0_[13] }),
        .O(minusOp[15:12]),
        .S({minusOp_carry__2_i_1_n_0,minusOp_carry__2_i_2_n_0,minusOp_carry__2_i_3_n_0,minusOp_carry__2_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__2_i_1
       (.I0(\int_cnt_int_reg_n_0_[16] ),
        .O(minusOp_carry__2_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__2_i_2
       (.I0(\int_cnt_int_reg_n_0_[15] ),
        .O(minusOp_carry__2_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__2_i_3
       (.I0(\int_cnt_int_reg_n_0_[14] ),
        .O(minusOp_carry__2_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__2_i_4
       (.I0(\int_cnt_int_reg_n_0_[13] ),
        .O(minusOp_carry__2_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__3
       (.CI(minusOp_carry__2_n_0),
        .CO({minusOp_carry__3_n_0,minusOp_carry__3_n_1,minusOp_carry__3_n_2,minusOp_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[20] ,\int_cnt_int_reg_n_0_[19] ,\int_cnt_int_reg_n_0_[18] ,\int_cnt_int_reg_n_0_[17] }),
        .O(minusOp[19:16]),
        .S({minusOp_carry__3_i_1_n_0,minusOp_carry__3_i_2_n_0,minusOp_carry__3_i_3_n_0,minusOp_carry__3_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__3_i_1
       (.I0(\int_cnt_int_reg_n_0_[20] ),
        .O(minusOp_carry__3_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__3_i_2
       (.I0(\int_cnt_int_reg_n_0_[19] ),
        .O(minusOp_carry__3_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__3_i_3
       (.I0(\int_cnt_int_reg_n_0_[18] ),
        .O(minusOp_carry__3_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__3_i_4
       (.I0(\int_cnt_int_reg_n_0_[17] ),
        .O(minusOp_carry__3_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__4
       (.CI(minusOp_carry__3_n_0),
        .CO({minusOp_carry__4_n_0,minusOp_carry__4_n_1,minusOp_carry__4_n_2,minusOp_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[24] ,\int_cnt_int_reg_n_0_[23] ,\int_cnt_int_reg_n_0_[22] ,\int_cnt_int_reg_n_0_[21] }),
        .O(minusOp[23:20]),
        .S({minusOp_carry__4_i_1_n_0,minusOp_carry__4_i_2_n_0,minusOp_carry__4_i_3_n_0,minusOp_carry__4_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__4_i_1
       (.I0(\int_cnt_int_reg_n_0_[24] ),
        .O(minusOp_carry__4_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__4_i_2
       (.I0(\int_cnt_int_reg_n_0_[23] ),
        .O(minusOp_carry__4_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__4_i_3
       (.I0(\int_cnt_int_reg_n_0_[22] ),
        .O(minusOp_carry__4_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__4_i_4
       (.I0(\int_cnt_int_reg_n_0_[21] ),
        .O(minusOp_carry__4_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__5
       (.CI(minusOp_carry__4_n_0),
        .CO({minusOp_carry__5_n_0,minusOp_carry__5_n_1,minusOp_carry__5_n_2,minusOp_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({\int_cnt_int_reg_n_0_[28] ,\int_cnt_int_reg_n_0_[27] ,\int_cnt_int_reg_n_0_[26] ,\int_cnt_int_reg_n_0_[25] }),
        .O(minusOp[27:24]),
        .S({minusOp_carry__5_i_1_n_0,minusOp_carry__5_i_2_n_0,minusOp_carry__5_i_3_n_0,minusOp_carry__5_i_4_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__5_i_1
       (.I0(\int_cnt_int_reg_n_0_[28] ),
        .O(minusOp_carry__5_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__5_i_2
       (.I0(\int_cnt_int_reg_n_0_[27] ),
        .O(minusOp_carry__5_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__5_i_3
       (.I0(\int_cnt_int_reg_n_0_[26] ),
        .O(minusOp_carry__5_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__5_i_4
       (.I0(\int_cnt_int_reg_n_0_[25] ),
        .O(minusOp_carry__5_i_4_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 minusOp_carry__6
       (.CI(minusOp_carry__5_n_0),
        .CO({NLW_minusOp_carry__6_CO_UNCONNECTED[3:2],minusOp_carry__6_n_2,minusOp_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,\int_cnt_int_reg_n_0_[30] ,\int_cnt_int_reg_n_0_[29] }),
        .O({NLW_minusOp_carry__6_O_UNCONNECTED[3],minusOp[30:28]}),
        .S({1'b0,minusOp_carry__6_i_1_n_0,minusOp_carry__6_i_2_n_0,minusOp_carry__6_i_3_n_0}));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__6_i_1
       (.I0(\int_cnt_int_reg_n_0_[31] ),
        .O(minusOp_carry__6_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__6_i_2
       (.I0(\int_cnt_int_reg_n_0_[30] ),
        .O(minusOp_carry__6_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry__6_i_3
       (.I0(\int_cnt_int_reg_n_0_[29] ),
        .O(minusOp_carry__6_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_1
       (.I0(Q[4]),
        .O(minusOp_carry_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_2
       (.I0(Q[3]),
        .O(minusOp_carry_i_2_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_3
       (.I0(Q[2]),
        .O(minusOp_carry_i_3_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    minusOp_carry_i_4
       (.I0(Q[1]),
        .O(minusOp_carry_i_4_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    wdt_reset_reg_i_1
       (.I0(s_axi_aresetn),
        .O(SR));
  LUT5 #(
    .INIT(32'h0000FFFB)) 
    wdt_reset_reg_i_10
       (.I0(\int_cnt_int[7]_i_3 ),
        .I1(WEN_change),
        .I2(p_11_in),
        .I3(\int_cnt_int[7]_i_3_0 ),
        .I4(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .O(WEN_clear_reg_reg));
  LUT6 #(
    .INIT(64'hABBBFFFFABBB0000)) 
    wdt_reset_reg_i_2
       (.I0(wdt_reset_reg_i_3_n_0),
        .I1(wdt_reset_reg_reg_2),
        .I2(wdt_reset_reg_reg_3),
        .I3(wdt_reset_reg_i_6_n_0),
        .I4(wdt_reset_int),
        .I5(wdt_reset_reg_reg_1),
        .O(wdt_reset_reg_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h80)) 
    wdt_reset_reg_i_3
       (.I0(dis_wdt_cnt),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I2(\FSM_sequential_WDT_Current_State_reg[0]_1 [0]),
        .O(wdt_reset_reg_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    wdt_reset_reg_i_6
       (.I0(WEN_clear_reg_reg),
        .I1(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .I2(dis_wdt_cnt),
        .O(wdt_reset_reg_i_6_n_0));
  LUT6 #(
    .INIT(64'h20202000A0A0A080)) 
    wint_int_i_1
       (.I0(s_axi_aresetn),
        .I1(wint_int),
        .I2(wint_int_i_2_n_0),
        .I3(wint_int_i_3_n_0),
        .I4(wint_int_i_4_n_0),
        .I5(wint_int_reg_3),
        .O(wint_int_i_1_n_0));
  LUT5 #(
    .INIT(32'h00000002)) 
    wint_int_i_10
       (.I0(wint_int_i_19_n_0),
        .I1(dis_wdt_int_i_5_n_0),
        .I2(dis_wdt_int_i_6_n_0),
        .I3(wint_int_i_20_n_0),
        .I4(wint_int_i_21_n_0),
        .O(wint_int_i_10_n_0));
  LUT6 #(
    .INIT(64'h0000000041000041)) 
    wint_int_i_11
       (.I0(wint_int_i_22_n_0),
        .I1(wint_int_i_6_0[5]),
        .I2(\int_cnt_int_reg_n_0_[13] ),
        .I3(wint_int_i_6_0[2]),
        .I4(\int_cnt_int_reg_n_0_[10] ),
        .I5(wint_int_i_23_n_0),
        .O(wint_int_i_11_n_0));
  LUT6 #(
    .INIT(64'h0000000000009009)) 
    wint_int_i_12
       (.I0(Q[5]),
        .I1(wint_int_i_6_0[5]),
        .I2(Q[2]),
        .I3(wint_int_i_6_0[2]),
        .I4(wint_int_i_24_n_0),
        .I5(wint_int_i_25_n_0),
        .O(wint_int_i_12_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFBEFFFFBE)) 
    wint_int_i_13
       (.I0(dis_wdt_int_i_5_n_0),
        .I1(wint_int_i_6_0[6]),
        .I2(Q[6]),
        .I3(wint_int_i_6_0[7]),
        .I4(Q[7]),
        .I5(wint_int_reg_4[0]),
        .O(wint_int_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    wint_int_i_14
       (.I0(Q[0]),
        .I1(Q[3]),
        .I2(Q[1]),
        .I3(Q[2]),
        .O(wint_int_i_14_n_0));
  LUT5 #(
    .INIT(32'hBEFFFFBE)) 
    wint_int_i_15
       (.I0(dis_wdt_int_i_3_n_0),
        .I1(\int_cnt_int_reg_n_0_[22] ),
        .I2(wint_int_i_6_0[6]),
        .I3(\int_cnt_int_reg_n_0_[23] ),
        .I4(wint_int_i_6_0[7]),
        .O(wint_int_i_15_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    wint_int_i_16
       (.I0(\int_cnt_int_reg_n_0_[30] ),
        .I1(\int_cnt_int_reg_n_0_[26] ),
        .I2(\int_cnt_int_reg_n_0_[24] ),
        .I3(\int_cnt_int_reg_n_0_[28] ),
        .O(wint_int_i_16_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_17
       (.I0(wint_int_i_6_0[0]),
        .I1(\int_cnt_int_reg_n_0_[16] ),
        .I2(wint_int_i_6_0[1]),
        .I3(\int_cnt_int_reg_n_0_[17] ),
        .O(wint_int_i_17_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_18
       (.I0(wint_int_i_6_0[4]),
        .I1(\int_cnt_int_reg_n_0_[20] ),
        .I2(wint_int_i_6_0[3]),
        .I3(\int_cnt_int_reg_n_0_[19] ),
        .O(wint_int_i_18_n_0));
  LUT6 #(
    .INIT(64'h0000000000009009)) 
    wint_int_i_19
       (.I0(\int_cnt_int_reg_n_0_[29] ),
        .I1(wint_int_i_6_0[5]),
        .I2(\int_cnt_int_reg_n_0_[26] ),
        .I3(wint_int_i_6_0[2]),
        .I4(wint_int_i_26_n_0),
        .I5(wint_int_i_27_n_0),
        .O(wint_int_i_19_n_0));
  LUT6 #(
    .INIT(64'h00000000F4F4F4F5)) 
    wint_int_i_2
       (.I0(wint_int_reg_0),
        .I1(wint_int_i_5_n_0),
        .I2(dis_wdt_int_reg_0),
        .I3(PSME_reg_reg),
        .I4(wint_int_reg_1),
        .I5(wint_int_reg_2),
        .O(wint_int_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFBF)) 
    wint_int_i_20
       (.I0(wint_int_i_14_n_0),
        .I1(wint_int_reg_4[0]),
        .I2(wint_int_reg_4[1]),
        .I3(\int_cnt_int_reg_n_0_[17] ),
        .I4(\int_cnt_int_reg_n_0_[16] ),
        .O(wint_int_i_20_n_0));
  LUT5 #(
    .INIT(32'hBEFFFFBE)) 
    wint_int_i_21
       (.I0(dis_wdt_int_i_3_n_0),
        .I1(\int_cnt_int_reg_n_0_[31] ),
        .I2(wint_int_i_6_0[7]),
        .I3(\int_cnt_int_reg_n_0_[30] ),
        .I4(wint_int_i_6_0[6]),
        .O(wint_int_i_21_n_0));
  LUT5 #(
    .INIT(32'hFFFF6FF6)) 
    wint_int_i_22
       (.I0(\int_cnt_int_reg_n_0_[12] ),
        .I1(wint_int_i_6_0[4]),
        .I2(\int_cnt_int_reg_n_0_[11] ),
        .I3(wint_int_i_6_0[3]),
        .I4(wint_int_i_28_n_0),
        .O(wint_int_i_22_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFBEFFFFBE)) 
    wint_int_i_23
       (.I0(wint_int_i_29_n_0),
        .I1(wint_int_i_6_0[7]),
        .I2(\int_cnt_int_reg_n_0_[15] ),
        .I3(wint_int_i_6_0[6]),
        .I4(\int_cnt_int_reg_n_0_[14] ),
        .I5(wint_int_i_14_n_0),
        .O(wint_int_i_23_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_24
       (.I0(wint_int_i_6_0[1]),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(wint_int_i_6_0[0]),
        .O(wint_int_i_24_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_25
       (.I0(wint_int_i_6_0[3]),
        .I1(Q[3]),
        .I2(wint_int_i_6_0[4]),
        .I3(Q[4]),
        .O(wint_int_i_25_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_26
       (.I0(wint_int_i_6_0[0]),
        .I1(\int_cnt_int_reg_n_0_[24] ),
        .I2(wint_int_i_6_0[1]),
        .I3(\int_cnt_int_reg_n_0_[25] ),
        .O(wint_int_i_26_n_0));
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_27
       (.I0(wint_int_i_6_0[4]),
        .I1(\int_cnt_int_reg_n_0_[28] ),
        .I2(wint_int_i_6_0[3]),
        .I3(\int_cnt_int_reg_n_0_[27] ),
        .O(wint_int_i_27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h6FF6)) 
    wint_int_i_28
       (.I0(wint_int_i_6_0[1]),
        .I1(\int_cnt_int_reg_n_0_[9] ),
        .I2(wint_int_i_6_0[0]),
        .I3(\int_cnt_int_reg_n_0_[8] ),
        .O(wint_int_i_28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'hFFFFFFEF)) 
    wint_int_i_29
       (.I0(Q[7]),
        .I1(Q[6]),
        .I2(wint_int_reg_4[0]),
        .I3(Q[5]),
        .I4(Q[4]),
        .O(wint_int_i_29_n_0));
  LUT5 #(
    .INIT(32'hFFFF0100)) 
    wint_int_i_3
       (.I0(wint_int_i_6_n_0),
        .I1(wint_int_i_7_n_0),
        .I2(wint_int_i_8_n_0),
        .I3(wint_int_i_9_n_0),
        .I4(wint_int_i_10_n_0),
        .O(wint_int_i_3_n_0));
  LUT5 #(
    .INIT(32'h0000AE00)) 
    wint_int_i_4
       (.I0(wint_int_i_11_n_0),
        .I1(wint_int_i_12_n_0),
        .I2(wint_int_i_13_n_0),
        .I3(dis_wdt_int_i_2_n_0),
        .I4(wint_int_reg_4[1]),
        .O(wint_int_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'h1000)) 
    wint_int_i_5
       (.I0(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I1(dis_wdt_cnt),
        .I2(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .I3(\FSM_sequential_WDT_Current_State_reg[0]_1 [1]),
        .O(wint_int_i_5_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFEF)) 
    wint_int_i_6
       (.I0(\int_cnt_int_reg_n_0_[8] ),
        .I1(\int_cnt_int_reg_n_0_[9] ),
        .I2(wint_int_reg_4[1]),
        .I3(wint_int_reg_4[0]),
        .I4(wint_int_i_14_n_0),
        .I5(wint_int_i_15_n_0),
        .O(wint_int_i_6_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    wint_int_i_7
       (.I0(\int_cnt_int_reg_n_0_[27] ),
        .I1(\int_cnt_int_reg_n_0_[29] ),
        .I2(\int_cnt_int_reg_n_0_[25] ),
        .I3(\int_cnt_int_reg_n_0_[31] ),
        .I4(wint_int_i_16_n_0),
        .O(wint_int_i_7_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    wint_int_i_8
       (.I0(\int_cnt_int_reg_n_0_[15] ),
        .I1(\int_cnt_int_reg_n_0_[14] ),
        .I2(\int_cnt_int_reg_n_0_[13] ),
        .I3(\int_cnt_int_reg_n_0_[12] ),
        .I4(\int_cnt_int_reg_n_0_[10] ),
        .I5(\int_cnt_int_reg_n_0_[11] ),
        .O(wint_int_i_8_n_0));
  LUT6 #(
    .INIT(64'h0000000000009009)) 
    wint_int_i_9
       (.I0(\int_cnt_int_reg_n_0_[21] ),
        .I1(wint_int_i_6_0[5]),
        .I2(\int_cnt_int_reg_n_0_[18] ),
        .I3(wint_int_i_6_0[2]),
        .I4(wint_int_i_17_n_0),
        .I5(wint_int_i_18_n_0),
        .O(wint_int_i_9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    wint_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(wint_int_i_1_n_0),
        .Q(wint_int),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "window_wdt_fail_cnt" *) 
module mbv_system_axi_timebase_wdt_0_0_window_wdt_fail_cnt
   (\fail_cnt_int_reg[2]_0 ,
    FCV_reg,
    \FSM_sequential_WDT_Current_State_reg[0] ,
    WDP_reg_reg,
    \LBE_reg_reg[1] ,
    \FSM_sequential_WDT_Current_State_reg[1] ,
    WEN_reg_cleark,
    WEN_clear_reg_reg,
    E,
    \FSM_sequential_WDT_Current_State_reg[1]_0 ,
    PSME_reg_reg,
    \fail_cnt_int_reg[0]_0 ,
    \SW_reg_reg[31] ,
    PSME_reg_reg_0,
    \FSM_sequential_WDT_Current_State_reg[0]_0 ,
    WCFG_reg_In_reg,
    WEN_clear_reg_reg_0,
    \SW_reg_reg[25] ,
    SSTE_reg_reg,
    SR,
    fc_sst_enc,
    s_axi_aclk,
    CO,
    PSME_reg,
    WEN_reg_reg,
    LBE_reg,
    \LBE_reg_reg[1]_0 ,
    Q,
    dis_wdt_cnt,
    LBE_reg0,
    WEN_reg_reg_0,
    WEN_reg_reg_1,
    \int_cnt_int_reg[31] ,
    \int_cnt_int_reg[31]_0 ,
    \int_cnt_int_reg[31]_1 ,
    dis_wdt_int_reg_0,
    \int_cnt_int_reg[31]_2 ,
    minusOp,
    \int_cnt_int_reg[31]_3 ,
    \int_cnt_int_reg[0] ,
    \int_cnt_int_reg[0]_0 ,
    WCFG_reg_In_reg_0,
    WEN_change,
    p_11_in,
    WCFG_reg_In_reg_1,
    WCFG_reg_In,
    WCFG_reg_In_reg_2,
    s_axi_aresetn,
    WCFG_reg_In_reg_3,
    \int_cnt_int_reg[0]_1 ,
    \int_cnt_int_reg[0]_2 ,
    \int_cnt_int_reg[0]_3 ,
    \int_cnt_int_reg[0]_4 ,
    \int_cnt_int_reg[0]_5 ,
    \FSM_sequential_WDT_Current_State_reg[1]_1 ,
    \FSM_sequential_WDT_Current_State_reg[1]_2 ,
    \int_cnt_int[31]_i_4_0 ,
    \FSM_sequential_WDT_Current_State_reg[1]_3 ,
    \FSM_sequential_WDT_Current_State_reg[1]_4 ,
    D,
    wdt_state_vec);
  output \fail_cnt_int_reg[2]_0 ;
  output [2:0]FCV_reg;
  output \FSM_sequential_WDT_Current_State_reg[0] ;
  output WDP_reg_reg;
  output \LBE_reg_reg[1] ;
  output \FSM_sequential_WDT_Current_State_reg[1] ;
  output WEN_reg_cleark;
  output WEN_clear_reg_reg;
  output [0:0]E;
  output \FSM_sequential_WDT_Current_State_reg[1]_0 ;
  output PSME_reg_reg;
  output \fail_cnt_int_reg[0]_0 ;
  output [31:0]\SW_reg_reg[31] ;
  output PSME_reg_reg_0;
  output \FSM_sequential_WDT_Current_State_reg[0]_0 ;
  output WCFG_reg_In_reg;
  output WEN_clear_reg_reg_0;
  output \SW_reg_reg[25] ;
  output SSTE_reg_reg;
  input [0:0]SR;
  input [1:0]fc_sst_enc;
  input s_axi_aclk;
  input [0:0]CO;
  input PSME_reg;
  input WEN_reg_reg;
  input [0:0]LBE_reg;
  input \LBE_reg_reg[1]_0 ;
  input [1:0]Q;
  input dis_wdt_cnt;
  input LBE_reg0;
  input WEN_reg_reg_0;
  input WEN_reg_reg_1;
  input \int_cnt_int_reg[31] ;
  input \int_cnt_int_reg[31]_0 ;
  input \int_cnt_int_reg[31]_1 ;
  input dis_wdt_int_reg_0;
  input [31:0]\int_cnt_int_reg[31]_2 ;
  input [30:0]minusOp;
  input [31:0]\int_cnt_int_reg[31]_3 ;
  input [0:0]\int_cnt_int_reg[0] ;
  input \int_cnt_int_reg[0]_0 ;
  input WCFG_reg_In_reg_0;
  input WEN_change;
  input [0:0]p_11_in;
  input WCFG_reg_In_reg_1;
  input WCFG_reg_In;
  input WCFG_reg_In_reg_2;
  input s_axi_aresetn;
  input WCFG_reg_In_reg_3;
  input \int_cnt_int_reg[0]_1 ;
  input \int_cnt_int_reg[0]_2 ;
  input \int_cnt_int_reg[0]_3 ;
  input \int_cnt_int_reg[0]_4 ;
  input \int_cnt_int_reg[0]_5 ;
  input \FSM_sequential_WDT_Current_State_reg[1]_1 ;
  input \FSM_sequential_WDT_Current_State_reg[1]_2 ;
  input \int_cnt_int[31]_i_4_0 ;
  input \FSM_sequential_WDT_Current_State_reg[1]_3 ;
  input \FSM_sequential_WDT_Current_State_reg[1]_4 ;
  input [0:0]D;
  input [0:0]wdt_state_vec;

  wire [0:0]CO;
  wire [0:0]D;
  wire [0:0]E;
  wire [2:0]FCV_reg;
  wire \FSM_sequential_WDT_Current_State_reg[0] ;
  wire \FSM_sequential_WDT_Current_State_reg[0]_0 ;
  wire \FSM_sequential_WDT_Current_State_reg[1] ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_0 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_1 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_2 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_3 ;
  wire \FSM_sequential_WDT_Current_State_reg[1]_4 ;
  wire [0:0]LBE_reg;
  wire LBE_reg0;
  wire \LBE_reg_reg[1] ;
  wire \LBE_reg_reg[1]_0 ;
  wire PSME_reg;
  wire PSME_reg_reg;
  wire PSME_reg_reg_0;
  wire [1:0]Q;
  wire [0:0]SR;
  wire SSTE_reg_reg;
  wire \SW_reg_reg[25] ;
  wire [31:0]\SW_reg_reg[31] ;
  wire WCFG_reg_In;
  wire WCFG_reg_In_reg;
  wire WCFG_reg_In_reg_0;
  wire WCFG_reg_In_reg_1;
  wire WCFG_reg_In_reg_2;
  wire WCFG_reg_In_reg_3;
  wire WDP_reg_reg;
  wire WEN_change;
  wire WEN_clear_reg_reg;
  wire WEN_clear_reg_reg_0;
  wire WEN_reg_cleark;
  wire WEN_reg_i_2_n_0;
  wire WEN_reg_i_3_n_0;
  wire WEN_reg_reg;
  wire WEN_reg_reg_0;
  wire WEN_reg_reg_1;
  wire dis_wdt_cnt;
  wire dis_wdt_int;
  wire dis_wdt_int_i_1__0_n_0;
  wire dis_wdt_int_i_2__0_n_0;
  wire dis_wdt_int_reg_0;
  wire \fail_cnt_int[0]_i_1_n_0 ;
  wire \fail_cnt_int[0]_i_2_n_0 ;
  wire \fail_cnt_int[1]_i_1_n_0 ;
  wire \fail_cnt_int[2]_i_1_n_0 ;
  wire \fail_cnt_int[2]_i_2_n_0 ;
  wire \fail_cnt_int[2]_i_3_n_0 ;
  wire \fail_cnt_int[2]_i_4_n_0 ;
  wire \fail_cnt_int[2]_i_5_n_0 ;
  wire \fail_cnt_int_reg[0]_0 ;
  wire \fail_cnt_int_reg[2]_0 ;
  wire fc_en_d;
  wire [1:0]fc_sst_enc;
  wire \int_cnt_int[31]_i_11_n_0 ;
  wire \int_cnt_int[31]_i_3_n_0 ;
  wire \int_cnt_int[31]_i_4_0 ;
  wire \int_cnt_int[31]_i_4_n_0 ;
  wire \int_cnt_int[31]_i_5_n_0 ;
  wire \int_cnt_int[31]_i_6_n_0 ;
  wire \int_cnt_int[31]_i_7_n_0 ;
  wire \int_cnt_int[31]_i_9_n_0 ;
  wire \int_cnt_int[7]_i_2_n_0 ;
  wire \int_cnt_int[7]_i_3_n_0 ;
  wire [0:0]\int_cnt_int_reg[0] ;
  wire \int_cnt_int_reg[0]_0 ;
  wire \int_cnt_int_reg[0]_1 ;
  wire \int_cnt_int_reg[0]_2 ;
  wire \int_cnt_int_reg[0]_3 ;
  wire \int_cnt_int_reg[0]_4 ;
  wire \int_cnt_int_reg[0]_5 ;
  wire \int_cnt_int_reg[31] ;
  wire \int_cnt_int_reg[31]_0 ;
  wire \int_cnt_int_reg[31]_1 ;
  wire [31:0]\int_cnt_int_reg[31]_2 ;
  wire [31:0]\int_cnt_int_reg[31]_3 ;
  wire [30:0]minusOp;
  wire [0:0]p_11_in;
  wire s_axi_aclk;
  wire s_axi_aresetn;
  wire wdt_reset_reg_i_11_n_0;
  wire [0:0]wdt_state_vec;

  LUT6 #(
    .INIT(64'hFFDFDFDFDFDFDFDF)) 
    \FSM_sequential_WDT_Current_State[0]_i_2 
       (.I0(Q[1]),
        .I1(dis_wdt_int),
        .I2(fc_sst_enc[0]),
        .I3(FCV_reg[1]),
        .I4(FCV_reg[2]),
        .I5(FCV_reg[0]),
        .O(\FSM_sequential_WDT_Current_State_reg[1]_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFB)) 
    \FSM_sequential_WDT_Current_State[1]_i_16 
       (.I0(WCFG_reg_In_reg_0),
        .I1(WEN_change),
        .I2(p_11_in),
        .I3(WCFG_reg_In_reg_1),
        .I4(\fail_cnt_int_reg[2]_0 ),
        .O(WEN_clear_reg_reg));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF0100)) 
    \FSM_sequential_WDT_Current_State[1]_i_2 
       (.I0(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .I1(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I2(\FSM_sequential_WDT_Current_State_reg[1]_3 ),
        .I3(\FSM_sequential_WDT_Current_State_reg[1]_4 ),
        .I4(WEN_reg_i_2_n_0),
        .I5(WCFG_reg_In_reg_2),
        .O(\SW_reg_reg[25] ));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \FSM_sequential_WDT_Current_State[1]_i_6 
       (.I0(PSME_reg_reg),
        .I1(Q[0]),
        .I2(Q[1]),
        .I3(PSME_reg_reg_0),
        .O(\FSM_sequential_WDT_Current_State_reg[0]_0 ));
  LUT6 #(
    .INIT(64'h00000000BBBBB3BB)) 
    \LBE_reg[1]_i_1 
       (.I0(LBE_reg),
        .I1(\FSM_sequential_WDT_Current_State_reg[1] ),
        .I2(\LBE_reg_reg[1]_0 ),
        .I3(Q[0]),
        .I4(dis_wdt_cnt),
        .I5(LBE_reg0),
        .O(\LBE_reg_reg[1] ));
  LUT2 #(
    .INIT(4'hB)) 
    \STATUS_I0_WDT.ip2bus_data[8]_i_4 
       (.I0(Q[0]),
        .I1(Q[1]),
        .O(\FSM_sequential_WDT_Current_State_reg[0] ));
  LUT6 #(
    .INIT(64'h0000000000A20000)) 
    WCFG_reg_In_i_1
       (.I0(WEN_clear_reg_reg_0),
        .I1(WEN_reg_i_2_n_0),
        .I2(WCFG_reg_In),
        .I3(WCFG_reg_In_reg_2),
        .I4(s_axi_aresetn),
        .I5(WCFG_reg_In_reg_3),
        .O(WCFG_reg_In_reg));
  LUT5 #(
    .INIT(32'hAAAAAAAE)) 
    WCFG_reg_In_i_2
       (.I0(WEN_reg_i_2_n_0),
        .I1(\FSM_sequential_WDT_Current_State_reg[1]_4 ),
        .I2(\FSM_sequential_WDT_Current_State_reg[1]_3 ),
        .I3(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I4(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .O(WEN_clear_reg_reg_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF00F1F0F1)) 
    WEN_reg_i_1
       (.I0(WEN_reg_reg_0),
        .I1(WEN_reg_i_2_n_0),
        .I2(Q[0]),
        .I3(Q[1]),
        .I4(dis_wdt_cnt),
        .I5(WEN_reg_i_3_n_0),
        .O(WEN_reg_cleark));
  LUT6 #(
    .INIT(64'h1515155515151515)) 
    WEN_reg_i_2
       (.I0(WCFG_reg_In_reg_0),
        .I1(D),
        .I2(wdt_state_vec),
        .I3(WCFG_reg_In_reg_1),
        .I4(p_11_in),
        .I5(\fail_cnt_int_reg[2]_0 ),
        .O(WEN_reg_i_2_n_0));
  LUT6 #(
    .INIT(64'h5454555455555555)) 
    WEN_reg_i_3
       (.I0(\int_cnt_int[31]_i_7_n_0 ),
        .I1(WEN_reg_reg),
        .I2(WEN_reg_reg_1),
        .I3(PSME_reg),
        .I4(CO),
        .I5(WEN_clear_reg_reg),
        .O(WEN_reg_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    WEN_reg_i_4
       (.I0(FCV_reg[2]),
        .I1(FCV_reg[1]),
        .I2(FCV_reg[0]),
        .I3(fc_sst_enc[0]),
        .O(\fail_cnt_int_reg[2]_0 ));
  LUT6 #(
    .INIT(64'h0E00FFFF0000FFFF)) 
    dis_wdt_int_i_1__0
       (.I0(\FSM_sequential_WDT_Current_State_reg[0] ),
        .I1(dis_wdt_int_i_2__0_n_0),
        .I2(\fail_cnt_int[2]_i_3_n_0 ),
        .I3(fc_en_d),
        .I4(fc_sst_enc[0]),
        .I5(dis_wdt_int),
        .O(dis_wdt_int_i_1__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT5 #(
    .INIT(32'hDDDCCCCC)) 
    dis_wdt_int_i_2__0
       (.I0(WDP_reg_reg),
        .I1(\fail_cnt_int[2]_i_5_n_0 ),
        .I2(FCV_reg[2]),
        .I3(FCV_reg[1]),
        .I4(fc_sst_enc[0]),
        .O(dis_wdt_int_i_2__0_n_0));
  FDRE #(
    .INIT(1'b0)) 
    dis_wdt_int_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(dis_wdt_int_i_1__0_n_0),
        .Q(dis_wdt_int),
        .R(SR));
  LUT6 #(
    .INIT(64'h03FFFFFFF8000000)) 
    \fail_cnt_int[0]_i_1 
       (.I0(\fail_cnt_int[0]_i_2_n_0 ),
        .I1(\fail_cnt_int[2]_i_2_n_0 ),
        .I2(\fail_cnt_int[2]_i_3_n_0 ),
        .I3(fc_en_d),
        .I4(fc_sst_enc[0]),
        .I5(FCV_reg[0]),
        .O(\fail_cnt_int[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \fail_cnt_int[0]_i_2 
       (.I0(FCV_reg[2]),
        .I1(FCV_reg[1]),
        .O(\fail_cnt_int[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFF33CF0000CC20)) 
    \fail_cnt_int[1]_i_1 
       (.I0(FCV_reg[2]),
        .I1(FCV_reg[0]),
        .I2(\fail_cnt_int[2]_i_2_n_0 ),
        .I3(\fail_cnt_int[2]_i_3_n_0 ),
        .I4(\fail_cnt_int[2]_i_4_n_0 ),
        .I5(FCV_reg[1]),
        .O(\fail_cnt_int[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFEF00008800)) 
    \fail_cnt_int[2]_i_1 
       (.I0(FCV_reg[0]),
        .I1(FCV_reg[1]),
        .I2(\fail_cnt_int[2]_i_2_n_0 ),
        .I3(\fail_cnt_int[2]_i_3_n_0 ),
        .I4(\fail_cnt_int[2]_i_4_n_0 ),
        .I5(FCV_reg[2]),
        .O(\fail_cnt_int[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00550015)) 
    \fail_cnt_int[2]_i_2 
       (.I0(\FSM_sequential_WDT_Current_State_reg[0] ),
        .I1(fc_sst_enc[0]),
        .I2(\fail_cnt_int[0]_i_2_n_0 ),
        .I3(\fail_cnt_int[2]_i_5_n_0 ),
        .I4(WDP_reg_reg),
        .O(\fail_cnt_int[2]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h888A8888)) 
    \fail_cnt_int[2]_i_3 
       (.I0(\fail_cnt_int_reg[0]_0 ),
        .I1(dis_wdt_int_reg_0),
        .I2(\int_cnt_int[31]_i_7_n_0 ),
        .I3(PSME_reg_reg),
        .I4(\int_cnt_int_reg[31] ),
        .O(\fail_cnt_int[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h7)) 
    \fail_cnt_int[2]_i_4 
       (.I0(fc_sst_enc[0]),
        .I1(fc_en_d),
        .O(\fail_cnt_int[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h4F)) 
    \fail_cnt_int[2]_i_5 
       (.I0(CO),
        .I1(PSME_reg),
        .I2(WEN_reg_reg),
        .O(\fail_cnt_int[2]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hFFEF)) 
    \fail_cnt_int[2]_i_6 
       (.I0(WCFG_reg_In_reg_1),
        .I1(p_11_in),
        .I2(WEN_change),
        .I3(WCFG_reg_In_reg_0),
        .O(WDP_reg_reg));
  FDSE #(
    .INIT(1'b1)) 
    \fail_cnt_int_reg[0] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\fail_cnt_int[0]_i_1_n_0 ),
        .Q(FCV_reg[0]),
        .S(SR));
  FDRE #(
    .INIT(1'b0)) 
    \fail_cnt_int_reg[1] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\fail_cnt_int[1]_i_1_n_0 ),
        .Q(FCV_reg[1]),
        .R(SR));
  FDSE #(
    .INIT(1'b1)) 
    \fail_cnt_int_reg[2] 
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(\fail_cnt_int[2]_i_1_n_0 ),
        .Q(FCV_reg[2]),
        .S(SR));
  FDRE #(
    .INIT(1'b0)) 
    fc_en_d_reg
       (.C(s_axi_aclk),
        .CE(1'b1),
        .D(fc_sst_enc[0]),
        .Q(fc_en_d),
        .R(SR));
  LUT6 #(
    .INIT(64'h44F444F4FFFF44F4)) 
    \int_cnt_int[0]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [0]),
        .I2(\int_cnt_int[31]_i_4_n_0 ),
        .I3(\int_cnt_int_reg[0] ),
        .I4(\int_cnt_int_reg[31]_3 [0]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [0]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[10]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [10]),
        .I2(minusOp[9]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [10]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [10]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[11]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [11]),
        .I2(minusOp[10]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [11]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [11]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[12]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [12]),
        .I2(minusOp[11]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [12]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [12]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[13]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [13]),
        .I2(minusOp[12]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [13]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [13]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[14]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [14]),
        .I2(minusOp[13]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [14]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [14]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[15]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [15]),
        .I2(minusOp[14]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [15]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [15]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[16]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [16]),
        .I2(minusOp[15]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [16]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [16]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[17]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [17]),
        .I2(minusOp[16]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [17]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [17]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[18]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [18]),
        .I2(minusOp[17]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [18]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [18]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[19]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [19]),
        .I2(minusOp[18]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [19]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [19]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[1]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [1]),
        .I2(minusOp[0]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [1]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [1]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[20]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [20]),
        .I2(minusOp[19]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [20]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [20]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[21]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [21]),
        .I2(minusOp[20]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [21]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [21]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[22]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [22]),
        .I2(minusOp[21]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [22]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [22]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[23]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [23]),
        .I2(minusOp[22]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [23]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [23]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[24]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [24]),
        .I2(minusOp[23]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [24]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [24]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[25]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [25]),
        .I2(minusOp[24]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [25]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [25]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[26]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [26]),
        .I2(minusOp[25]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [26]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [26]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[27]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [27]),
        .I2(minusOp[26]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [27]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [27]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[28]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [28]),
        .I2(minusOp[27]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [28]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [28]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[29]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [29]),
        .I2(minusOp[28]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [29]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [29]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[2]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [2]),
        .I2(minusOp[1]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [2]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [2]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[30]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [30]),
        .I2(minusOp[29]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [30]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [30]));
  LUT2 #(
    .INIT(4'h7)) 
    \int_cnt_int[31]_i_1 
       (.I0(\int_cnt_int[31]_i_3_n_0 ),
        .I1(\int_cnt_int[31]_i_4_n_0 ),
        .O(E));
  LUT6 #(
    .INIT(64'hAA8A8A8A8A8A8A8A)) 
    \int_cnt_int[31]_i_11 
       (.I0(fc_sst_enc[1]),
        .I1(dis_wdt_int),
        .I2(fc_sst_enc[0]),
        .I3(FCV_reg[1]),
        .I4(FCV_reg[2]),
        .I5(FCV_reg[0]),
        .O(\int_cnt_int[31]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[31]_i_2 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [31]),
        .I2(minusOp[30]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [31]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [31]));
  LUT6 #(
    .INIT(64'h0F0F0F0F0E0E0E00)) 
    \int_cnt_int[31]_i_3 
       (.I0(\int_cnt_int[31]_i_7_n_0 ),
        .I1(\int_cnt_int_reg[31] ),
        .I2(\int_cnt_int_reg[31]_0 ),
        .I3(\FSM_sequential_WDT_Current_State_reg[1]_0 ),
        .I4(\int_cnt_int_reg[31]_1 ),
        .I5(PSME_reg_reg),
        .O(\int_cnt_int[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000AAA2AAAAAAAA)) 
    \int_cnt_int[31]_i_4 
       (.I0(\int_cnt_int[31]_i_9_n_0 ),
        .I1(\int_cnt_int_reg[31] ),
        .I2(PSME_reg_reg),
        .I3(\int_cnt_int[31]_i_7_n_0 ),
        .I4(\int_cnt_int_reg[0]_0 ),
        .I5(\int_cnt_int[31]_i_11_n_0 ),
        .O(\int_cnt_int[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAFFFFFEFFFEFF)) 
    \int_cnt_int[31]_i_5 
       (.I0(Q[1]),
        .I1(WEN_clear_reg_reg_0),
        .I2(WEN_reg_reg_0),
        .I3(\int_cnt_int_reg[0]_5 ),
        .I4(dis_wdt_cnt),
        .I5(Q[0]),
        .O(\int_cnt_int[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hEEFEFFFFEEFEEEFE)) 
    \int_cnt_int[31]_i_6 
       (.I0(WCFG_reg_In_reg_2),
        .I1(WEN_reg_i_2_n_0),
        .I2(\int_cnt_int_reg[0]_1 ),
        .I3(\int_cnt_int_reg[0]_2 ),
        .I4(\int_cnt_int_reg[0]_3 ),
        .I5(\int_cnt_int_reg[0]_4 ),
        .O(\int_cnt_int[31]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF44040000)) 
    \int_cnt_int[31]_i_7 
       (.I0(WDP_reg_reg),
        .I1(WEN_reg_reg),
        .I2(PSME_reg),
        .I3(CO),
        .I4(wdt_reset_reg_i_11_n_0),
        .I5(\FSM_sequential_WDT_Current_State_reg[0] ),
        .O(\int_cnt_int[31]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h00000000EEEEEEFE)) 
    \int_cnt_int[31]_i_9 
       (.I0(WCFG_reg_In_reg_2),
        .I1(WEN_reg_i_2_n_0),
        .I2(\int_cnt_int_reg[0]_1 ),
        .I3(\FSM_sequential_WDT_Current_State_reg[1]_1 ),
        .I4(\FSM_sequential_WDT_Current_State_reg[1]_2 ),
        .I5(\int_cnt_int[31]_i_4_0 ),
        .O(\int_cnt_int[31]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[3]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [3]),
        .I2(minusOp[2]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [3]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [3]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[4]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [4]),
        .I2(minusOp[3]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [4]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [4]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[5]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [5]),
        .I2(minusOp[4]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [5]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [5]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[6]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [6]),
        .I2(minusOp[5]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [6]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [6]));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFBABABA)) 
    \int_cnt_int[7]_i_1 
       (.I0(\int_cnt_int[7]_i_2_n_0 ),
        .I1(\int_cnt_int[31]_i_5_n_0 ),
        .I2(\int_cnt_int_reg[31]_2 [7]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(minusOp[6]),
        .I5(\int_cnt_int[7]_i_3_n_0 ),
        .O(\SW_reg_reg[31] [7]));
  LUT6 #(
    .INIT(64'h1000FFFF10001000)) 
    \int_cnt_int[7]_i_2 
       (.I0(\int_cnt_int[31]_i_7_n_0 ),
        .I1(PSME_reg_reg),
        .I2(\int_cnt_int_reg[31] ),
        .I3(\int_cnt_int[31]_i_11_n_0 ),
        .I4(\int_cnt_int[31]_i_6_n_0 ),
        .I5(\int_cnt_int_reg[31]_3 [7]),
        .O(\int_cnt_int[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000040000)) 
    \int_cnt_int[7]_i_3 
       (.I0(\fail_cnt_int_reg[0]_0 ),
        .I1(fc_sst_enc[1]),
        .I2(Q[1]),
        .I3(WEN_reg_reg_1),
        .I4(Q[0]),
        .I5(dis_wdt_cnt),
        .O(\int_cnt_int[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT5 #(
    .INIT(32'h00007F00)) 
    \int_cnt_int[7]_i_4 
       (.I0(FCV_reg[0]),
        .I1(FCV_reg[2]),
        .I2(FCV_reg[1]),
        .I3(fc_sst_enc[0]),
        .I4(dis_wdt_int),
        .O(\fail_cnt_int_reg[0]_0 ));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[8]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [8]),
        .I2(minusOp[7]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [8]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [8]));
  LUT6 #(
    .INIT(64'hF444F444FFFFF444)) 
    \int_cnt_int[9]_i_1 
       (.I0(\int_cnt_int[31]_i_5_n_0 ),
        .I1(\int_cnt_int_reg[31]_2 [9]),
        .I2(minusOp[8]),
        .I3(\int_cnt_int[31]_i_4_n_0 ),
        .I4(\int_cnt_int_reg[31]_3 [9]),
        .I5(\int_cnt_int[31]_i_6_n_0 ),
        .O(\SW_reg_reg[31] [9]));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h10FF)) 
    wdt_reset_reg_i_11
       (.I0(FCV_reg[2]),
        .I1(FCV_reg[1]),
        .I2(FCV_reg[0]),
        .I3(fc_sst_enc[0]),
        .O(wdt_reset_reg_i_11_n_0));
  LUT6 #(
    .INIT(64'hAABABABABABABABA)) 
    wdt_reset_reg_i_4
       (.I0(fc_sst_enc[1]),
        .I1(dis_wdt_int),
        .I2(fc_sst_enc[0]),
        .I3(FCV_reg[1]),
        .I4(FCV_reg[2]),
        .I5(FCV_reg[0]),
        .O(SSTE_reg_reg));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT5 #(
    .INIT(32'hFFFBFFFF)) 
    wdt_reset_reg_i_5
       (.I0(PSME_reg_reg_0),
        .I1(Q[1]),
        .I2(Q[0]),
        .I3(PSME_reg_reg),
        .I4(\int_cnt_int_reg[31] ),
        .O(\FSM_sequential_WDT_Current_State_reg[1] ));
  LUT5 #(
    .INIT(32'h00008A00)) 
    wdt_reset_reg_i_8
       (.I0(wdt_reset_reg_i_11_n_0),
        .I1(CO),
        .I2(PSME_reg),
        .I3(WEN_reg_reg),
        .I4(WDP_reg_reg),
        .O(PSME_reg_reg_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT5 #(
    .INIT(32'h51515100)) 
    wdt_reset_reg_i_9
       (.I0(WEN_reg_reg_1),
        .I1(PSME_reg),
        .I2(CO),
        .I3(\fail_cnt_int_reg[2]_0 ),
        .I4(WEN_reg_reg),
        .O(PSME_reg_reg));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
