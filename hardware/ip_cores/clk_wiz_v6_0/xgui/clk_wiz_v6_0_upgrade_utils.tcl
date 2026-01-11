# (c) Copyright 2023 Advanced Micro Devices, Inc. All rights reserved.
#
# This file contains confidential and proprietary information
# of AMD and is protected under U.S. and international copyright
# and other intellectual property laws.
#
# DISCLAIMER
# This disclaimer is not a license and does not grant any
# rights to the materials distributed herewith. Except as
# otherwise provided in a valid license issued to you by
# AMD, and to the maximum extent permitted by applicable
# law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
# WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
# AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
# BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
# INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
# (2) AMD shall not be liable (whether in contract or tort,
# including negligence, or under any other theory of
# liability) for any loss or damage of any kind or nature
# related to, arising under or in connection with these
# materials, including for any direct, or any indirect,
# special, incidental, or consequential loss or damage
# (including loss of data, profits, goodwill, or any type of
# loss or damage suffered as a result of any action brought
# by a third party) even if such damage or loss was
# reasonably foreseeable or AMD had been advised of the
# possibility of the same.
#
# CRITICAL APPLICATIONS
# AMD products are not designed or intended to be fail-
# safe, or for use in any application requiring fail-safe
# performance, such as life-support or safety devices or
# systems, Class III medical devices, nuclear facilities,
# applications related to the deployment of airbags, or any
# other applications that could lead to death, personal
# injury, or severe property or environmental damage
# (individually and collectively, "Critical
# Applications"). Customer assumes the sole risk and
# liability of any use of AMD products in Critical
# Applications, subject only to applicable laws and
# regulations governing limitations on product liability.
#
# THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
# PART OF THIS FILE AT ALL TIMES.
############################################################
namespace eval clk_wiz_v6_0_utils {

   # Call this procedure before any call to update_parameters_from_before_v5_0
   proc update_parameters_from_before_v4_2 {parameterArray} {

      upvar $parameterArray xco
       
      removeParameter Override_Dcm               xco
      removeParameter Override_Dcm_Clkgen        xco
      removeParameter Dcm_Clk_Feedback           xco
      removeParameter Dcm_Clk_Out1_Port          xco
      removeParameter Dcm_Clk_Out2_Port          xco
      removeParameter Dcm_Clk_Out3_Port          xco
      removeParameter Dcm_Clk_Out4_Port          xco
      removeParameter Dcm_Clk_Out5_Port          xco
      removeParameter Dcm_Clk_Out6_Port          xco
      removeParameter Dcm_Clkdv_Divide           xco
      removeParameter Dcm_Clkfx_Divide           xco
      removeParameter Dcm_Clkfx_Multiply         xco
      removeParameter Dcm_Clkgen_Clk_Out1_Port   xco
      removeParameter Dcm_Clkgen_Clk_Out2_Port   xco
      removeParameter Dcm_Clkgen_Clk_Out3_Port   xco
      removeParameter Dcm_Clkgen_Clkfx_Divide    xco
      removeParameter Dcm_Clkgen_Clkfx_Md_Max    xco
      removeParameter Dcm_Clkgen_Clkfx_Multiply  xco
      removeParameter Dcm_Clkgen_Clkfxdv_Divide  xco
      removeParameter Dcm_Clkgen_Clkin_Period    xco
      removeParameter Dcm_Clkgen_Startup_Wait    xco
      removeParameter Dcm_Clkin_Divide_By_2      xco
      removeParameter Dcm_Clkout_Phase_Shift     xco
      removeParameter Dcm_Deskew_Adjust          xco
      removeParameter Dcm_Phase_Shift            xco
      removeParameter Dcm_Startup_Wait           xco
      removeParameter Dcm_Clkgen_Notes           xco
      removeParameter Dcm_Clkgen_Spread_Spectrum xco
      removeParameter Dcm_Clkin_Period           xco
      removeParameter Dcm_Notes                  xco
      removeParameter dcm_pll_cascade            xco
   }

   # Call this procedure before any call to update_parameters_from_before_v5_0
   proc update_parameters_from_before_v4_4 {parameterArray} {

      upvar $parameterArray xco

      addParameter Reset_Type "ACTIVE_HIGH" xco
   }

   # Only call this procedure after any call to update_parameters_from_before_v4_2
   proc update_parameters_from_before_v5_0 {parameterArray} {

      upvar $parameterArray xco

      addParameter     USE_SAFE_CLOCK_STARTUP       false  xco
      addParameter     USE_CLOCK_SEQUENCING         false  xco
      addParameter     CLKOUT1_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT2_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT3_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT4_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT5_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT6_SEQUENCE_NUMBER      1      xco
      addParameter     CLKOUT7_SEQUENCE_NUMBER      1      xco

      renameParameter  Reset_Type                   RESET_TYPE                   xco 
      renameParameter  clock_mgr_type               CLOCK_MGR_TYPE               xco 
      renameParameter  Use_Freq_Synth               USE_FREQ_SYNTH               xco 
      renameParameter  Use_Spread_Spectrum          USE_SPREAD_SPECTRUM          xco 
      renameParameter  Use_Phase_Alignment          USE_PHASE_ALIGNMENT          xco 
      renameParameter  Use_Min_Power                USE_MIN_POWER                xco 
      renameParameter  Use_Dyn_Phase_Shift          USE_DYN_PHASE_SHIFT          xco 
      renameParameter  Use_Dyn_Reconfig             USE_DYN_RECONFIG             xco 
      renameParameter  Jitter_Sel                   JITTER_SEL                   xco 
      renameParameter  Prim_In_Freq                 PRIM_IN_FREQ                 xco 
      renameParameter  In_Freq_Units                IN_FREQ_UNITS                xco 
      renameParameter  In_Jitter_Units              IN_JITTER_UNITS              xco 
      renameParameter  Relative_Inclk               RELATIVE_INCLK               xco 
      renameParameter  Use_Inclk_Switchover         USE_INCLK_SWITCHOVER         xco 
      renameParameter  Secondary_In_Freq            SECONDARY_IN_FREQ            xco 
      renameParameter  secondary_port               SECONDARY_PORT               xco 
      renameParameter  Secondary_Source             SECONDARY_SOURCE             xco 
      renameParameter  Jitter_Options               JITTER_OPTIONS               xco 
      renameParameter  Clkin1_UI_Jitter             CLKIN1_UI_JITTER             xco 
      renameParameter  Clkin2_UI_Jitter             CLKIN2_UI_JITTER             xco 
      renameParameter  Prim_In_Jitter               PRIM_IN_JITTER               xco 
      renameParameter  Secondary_In_Jitter          SECONDARY_IN_JITTER          xco 
      renameParameter  Clkin1_Jitter_Ps             CLKIN1_JITTER_PS             xco 
      renameParameter  Clkin2_Jitter_Ps             CLKIN2_JITTER_PS             xco 
      renameParameter  Clkout2_Used                 CLKOUT2_USED                 xco 
      renameParameter  Clkout3_Used                 CLKOUT3_USED                 xco 
      renameParameter  Clkout4_Used                 CLKOUT4_USED                 xco 
      renameParameter  Clkout5_Used                 CLKOUT5_USED                 xco 
      renameParameter  Clkout6_Used                 CLKOUT6_USED                 xco 
      renameParameter  Clkout7_Used                 CLKOUT7_USED                 xco 
      renameParameter  Num_Out_Clks                 NUM_OUT_CLKS                 xco 
      renameParameter  Clk_Out1_Use_Fine_Ps_GUI     CLK_OUT1_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out2_Use_Fine_Ps_GUI     CLK_OUT2_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out3_Use_Fine_Ps_GUI     CLK_OUT3_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out4_Use_Fine_Ps_GUI     CLK_OUT4_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out5_Use_Fine_Ps_GUI     CLK_OUT5_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out6_Use_Fine_Ps_GUI     CLK_OUT6_USE_FINE_PS_GUI     xco 
      renameParameter  Clk_Out7_Use_Fine_Ps_GUI     CLK_OUT7_USE_FINE_PS_GUI     xco 
      renameParameter  primary_port                 PRIMARY_PORT                 xco 
      renameParameter  CLK_OUT1_port                CLK_OUT1_PORT                xco 
      renameParameter  CLK_OUT2_port                CLK_OUT2_PORT                xco 
      renameParameter  CLK_OUT3_port                CLK_OUT3_PORT                xco 
      renameParameter  CLK_OUT4_port                CLK_OUT4_PORT                xco 
      renameParameter  CLK_OUT5_port                CLK_OUT5_PORT                xco 
      renameParameter  CLK_OUT6_port                CLK_OUT6_PORT                xco 
      renameParameter  CLK_OUT7_port                CLK_OUT7_PORT                xco 
      renameParameter  DADDR_port                   DADDR_PORT                   xco 
      renameParameter  DCLK_port                    DCLK_PORT                    xco 
      renameParameter  DRDY_port                    DRDY_PORT                    xco 
      renameParameter  DWE_port                     DWE_PORT                     xco 
      renameParameter  DIN_port                     DIN_PORT                     xco 
      renameParameter  DOUT_port                    DOUT_PORT                    xco 
      renameParameter  DEN_port                     DEN_PORT                     xco 
      renameParameter  PSCLK_port                   PSCLK_PORT                   xco 
      renameParameter  PSEN_port                    PSEN_PORT                    xco 
      renameParameter  PSINCDEC_port                PSINCDEC_PORT                xco 
      renameParameter  PSDONE_port                  PSDONE_PORT                  xco 
      renameParameter  Clkout1_Requested_Out_Freq   CLKOUT1_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout1_Requested_Phase      CLKOUT1_REQUESTED_PHASE      xco 
      renameParameter  Clkout1_Requested_Duty_Cycle CLKOUT1_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout2_Requested_Out_Freq   CLKOUT2_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout2_Requested_Phase      CLKOUT2_REQUESTED_PHASE      xco 
      renameParameter  Clkout2_Requested_Duty_Cycle CLKOUT2_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout3_Requested_Out_Freq   CLKOUT3_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout3_Requested_Phase      CLKOUT3_REQUESTED_PHASE      xco 
      renameParameter  Clkout3_Requested_Duty_Cycle CLKOUT3_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout4_Requested_Out_Freq   CLKOUT4_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout4_Requested_Phase      CLKOUT4_REQUESTED_PHASE      xco 
      renameParameter  Clkout4_Requested_Duty_Cycle CLKOUT4_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout5_Requested_Out_Freq   CLKOUT5_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout5_Requested_Phase      CLKOUT5_REQUESTED_PHASE      xco 
      renameParameter  Clkout5_Requested_Duty_Cycle CLKOUT5_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout6_Requested_Out_Freq   CLKOUT6_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout6_Requested_Phase      CLKOUT6_REQUESTED_PHASE      xco 
      renameParameter  Clkout6_Requested_Duty_Cycle CLKOUT6_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Clkout7_Requested_Out_Freq   CLKOUT7_REQUESTED_OUT_FREQ   xco 
      renameParameter  Clkout7_Requested_Phase      CLKOUT7_REQUESTED_PHASE      xco 
      renameParameter  Clkout7_Requested_Duty_Cycle CLKOUT7_REQUESTED_DUTY_CYCLE xco 
      renameParameter  Use_Max_I_Jitter             USE_MAX_I_JITTER             xco 
      renameParameter  Use_Min_O_Jitter             USE_MIN_O_JITTER             xco 
      renameParameter  Prim_Source                  PRIM_SOURCE                  xco 
      renameParameter  Clkout1_Drives               CLKOUT1_DRIVES               xco 
      renameParameter  Clkout2_Drives               CLKOUT2_DRIVES               xco 
      renameParameter  Clkout3_Drives               CLKOUT3_DRIVES               xco 
      renameParameter  Clkout4_Drives               CLKOUT4_DRIVES               xco 
      renameParameter  Clkout5_Drives               CLKOUT5_DRIVES               xco 
      renameParameter  Clkout6_Drives               CLKOUT6_DRIVES               xco 
      renameParameter  Clkout7_Drives               CLKOUT7_DRIVES               xco 
      renameParameter  Feedback_Source              FEEDBACK_SOURCE              xco 
      renameParameter  Clkfb_In_Signaling           CLKFB_IN_SIGNALING           xco 
      renameParameter  CLKFB_IN_port                CLKFB_IN_PORT                xco 
      renameParameter  CLKFB_IN_P_port              CLKFB_IN_P_PORT              xco 
      renameParameter  CLKFB_IN_N_port              CLKFB_IN_N_PORT              xco 
      renameParameter  CLKFB_OUT_port               CLKFB_OUT_PORT               xco 
      renameParameter  CLKFB_OUT_P_port             CLKFB_OUT_P_PORT             xco 
      renameParameter  CLKFB_OUT_N_port             CLKFB_OUT_N_PORT             xco 
      renameParameter  Platform                     PLATFORM                     xco 
      renameParameter  Summary_Strings              SUMMARY_STRINGS              xco 
      renameParameter  Use_Locked                   USE_LOCKED                   xco 
      renameParameter  calc_done                    CALC_DONE                    xco 
      renameParameter  Use_Reset                    USE_RESET                    xco 
      renameParameter  Use_Power_Down               USE_POWER_DOWN               xco 
      renameParameter  Use_Status                   USE_STATUS                   xco 
      renameParameter  Use_Freeze                   USE_FREEZE                   xco 
      renameParameter  Use_Clk_Valid                USE_CLK_VALID                xco 
      renameParameter  Use_Inclk_Stopped            USE_INCLK_STOPPED            xco 
      renameParameter  Use_Clkfb_Stopped            USE_CLKFB_STOPPED            xco 
      renameParameter  RESET_port                   RESET_PORT                   xco 
      renameParameter  LOCKED_port                  LOCKED_PORT                  xco 
      renameParameter  Power_Down_port              POWER_DOWN_PORT              xco 
      renameParameter  CLK_VALID_port               CLK_VALID_PORT               xco 
      renameParameter  STATUS_port                  STATUS_PORT                  xco 
      renameParameter  CLK_IN_SEL_port              CLK_IN_SEL_PORT              xco 
      renameParameter  INPUT_CLK_STOPPED_port       INPUT_CLK_STOPPED_PORT       xco 
      renameParameter  CLKFB_STOPPED_port           CLKFB_STOPPED_PORT           xco 
      renameParameter  Override_Mmcm                OVERRIDE_MMCM                xco 
      renameParameter  Mmcm_Notes                   MMCM_NOTES                   xco 
      renameParameter  Mmcm_Divclk_Divide           MMCM_DIVCLK_DIVIDE           xco 
      renameParameter  Mmcm_Bandwidth               MMCM_BANDWIDTH               xco 
      renameParameter  Mmcm_Clkfbout_Mult_F         MMCM_CLKFBOUT_MULT_F         xco 
      renameParameter  Mmcm_Clkfbout_Phase          MMCM_CLKFBOUT_PHASE          xco 
      renameParameter  Mmcm_Clkfbout_Use_Fine_Ps    MMCM_CLKFBOUT_USE_FINE_PS    xco 
      renameParameter  Mmcm_Clkin1_Period           MMCM_CLKIN1_PERIOD           xco 
      renameParameter  Mmcm_Clkin2_Period           MMCM_CLKIN2_PERIOD           xco 
      renameParameter  Mmcm_Clkout4_Cascade         MMCM_CLKOUT4_CASCADE         xco 
      renameParameter  Mmcm_Clock_Hold              MMCM_CLOCK_HOLD              xco 
      renameParameter  Mmcm_Compensation            MMCM_COMPENSATION            xco 
      renameParameter  Mmcm_Ref_Jitter1             MMCM_REF_JITTER1             xco 
      renameParameter  Mmcm_Ref_Jitter2             MMCM_REF_JITTER2             xco 
      renameParameter  Mmcm_Startup_Wait            MMCM_STARTUP_WAIT            xco 
      renameParameter  Mmcm_Clkout0_Divide_F        MMCM_CLKOUT0_DIVIDE_F        xco 
      renameParameter  Mmcm_Clkout0_Duty_Cycle      MMCM_CLKOUT0_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout0_Phase           MMCM_CLKOUT0_PHASE           xco 
      renameParameter  Mmcm_Clkout0_Use_Fine_Ps     MMCM_CLKOUT0_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout1_Divide          MMCM_CLKOUT1_DIVIDE          xco 
      renameParameter  Mmcm_Clkout1_Duty_Cycle      MMCM_CLKOUT1_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout1_Phase           MMCM_CLKOUT1_PHASE           xco 
      renameParameter  Mmcm_Clkout1_Use_Fine_Ps     MMCM_CLKOUT1_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout2_Divide          MMCM_CLKOUT2_DIVIDE          xco 
      renameParameter  Mmcm_Clkout2_Duty_Cycle      MMCM_CLKOUT2_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout2_Phase           MMCM_CLKOUT2_PHASE           xco 
      renameParameter  Mmcm_Clkout2_Use_Fine_Ps     MMCM_CLKOUT2_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout3_Divide          MMCM_CLKOUT3_DIVIDE          xco 
      renameParameter  Mmcm_Clkout3_Duty_Cycle      MMCM_CLKOUT3_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout3_Phase           MMCM_CLKOUT3_PHASE           xco 
      renameParameter  Mmcm_Clkout3_Use_Fine_Ps     MMCM_CLKOUT3_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout4_Divide          MMCM_CLKOUT4_DIVIDE          xco 
      renameParameter  Mmcm_Clkout4_Duty_Cycle      MMCM_CLKOUT4_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout4_Phase           MMCM_CLKOUT4_PHASE           xco 
      renameParameter  Mmcm_Clkout4_Use_Fine_Ps     MMCM_CLKOUT4_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout5_Divide          MMCM_CLKOUT5_DIVIDE          xco 
      renameParameter  Mmcm_Clkout5_Duty_Cycle      MMCM_CLKOUT5_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout5_Phase           MMCM_CLKOUT5_PHASE           xco 
      renameParameter  Mmcm_Clkout5_Use_Fine_Ps     MMCM_CLKOUT5_USE_FINE_PS     xco 
      renameParameter  Mmcm_Clkout6_Divide          MMCM_CLKOUT6_DIVIDE          xco 
      renameParameter  Mmcm_Clkout6_Duty_Cycle      MMCM_CLKOUT6_DUTY_CYCLE      xco 
      renameParameter  Mmcm_Clkout6_Phase           MMCM_CLKOUT6_PHASE           xco 
      renameParameter  Mmcm_Clkout6_Use_Fine_Ps     MMCM_CLKOUT6_USE_FINE_PS     xco 
      renameParameter  Override_Pll                 OVERRIDE_PLL                 xco 
      renameParameter  Pll_Notes                    PLL_NOTES                    xco 
      renameParameter  Pll_Bandwidth                PLL_BANDWIDTH                xco 
      renameParameter  Pll_Clkfbout_Mult            PLL_CLKFBOUT_MULT            xco 
      renameParameter  Pll_Clkfbout_Phase           PLL_CLKFBOUT_PHASE           xco 
      renameParameter  Pll_Clk_Feedback             PLL_CLK_FEEDBACK             xco 
      renameParameter  Pll_Divclk_Divide            PLL_DIVCLK_DIVIDE            xco 
      renameParameter  Pll_Clkin_Period             PLL_CLKIN_PERIOD             xco 
      renameParameter  Pll_Compensation             PLL_COMPENSATION             xco 
      renameParameter  Pll_Ref_Jitter               PLL_REF_JITTER               xco 
      renameParameter  Pll_Clkout0_Divide           PLL_CLKOUT0_DIVIDE           xco 
      renameParameter  Pll_Clkout0_Duty_Cycle       PLL_CLKOUT0_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout0_Phase            PLL_CLKOUT0_PHASE            xco 
      renameParameter  Pll_Clkout1_Divide           PLL_CLKOUT1_DIVIDE           xco 
      renameParameter  Pll_Clkout1_Duty_Cycle       PLL_CLKOUT1_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout1_Phase            PLL_CLKOUT1_PHASE            xco 
      renameParameter  Pll_Clkout2_Divide           PLL_CLKOUT2_DIVIDE           xco 
      renameParameter  Pll_Clkout2_Duty_Cycle       PLL_CLKOUT2_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout2_Phase            PLL_CLKOUT2_PHASE            xco 
      renameParameter  Pll_Clkout3_Divide           PLL_CLKOUT3_DIVIDE           xco 
      renameParameter  Pll_Clkout3_Duty_Cycle       PLL_CLKOUT3_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout3_Phase            PLL_CLKOUT3_PHASE            xco 
      renameParameter  Pll_Clkout4_Divide           PLL_CLKOUT4_DIVIDE           xco 
      renameParameter  Pll_Clkout4_Duty_Cycle       PLL_CLKOUT4_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout4_Phase            PLL_CLKOUT4_PHASE            xco 
      renameParameter  Pll_Clkout5_Divide           PLL_CLKOUT5_DIVIDE           xco 
      renameParameter  Pll_Clkout5_Duty_Cycle       PLL_CLKOUT5_DUTY_CYCLE       xco 
      renameParameter  Pll_Clkout5_Phase            PLL_CLKOUT5_PHASE            xco 

      # The case of the "Primitive" parameters varies inconsistently across previous versions
      if {[isParameter primitive xco]} {
         renameParameter  primitive PRIMITIVE xco
      } elseif {[isParameter Primitive xco]} {
         renameParameter  Primitive PRIMITIVE xco
      }
      if {[isParameter primtype_sel xco]} {
         renameParameter  primtype_sel PRIMTYPE_SEL xco
      } elseif {[isParameter Primtype_Sel xco]} {
         renameParameter  Primtype_Sel PRIMTYPE_SEL xco
      }
   }

   proc upgrade_parameters_from_v5_0 {parameterArray} {
      upvar $parameterArray xco

      if { ([getParameter PRIMITIVE xco] == "PLLE2") } {
      setParameter PRIMITIVE "PLL" xco
      } else {
      setParameter PRIMITIVE "MMCM" xco
      }
      addParameter ENABLE_CDDC "false" xco
      addParameter CDDCDONE_PORT "cddcdone" xco
      addParameter CDDCREQ_PORT "cddcreq" xco
      addParameter CLKOUT1_JITTER 0.0 xco
      addParameter CLKOUT1_PHASE_ERROR 0.0 xco
      addParameter CLKOUT2_JITTER 0.0 xco
      addParameter CLKOUT2_PHASE_ERROR 0.0 xco
      addParameter CLKOUT3_JITTER 0.0 xco
      addParameter CLKOUT3_PHASE_ERROR 0.0 xco
      addParameter CLKOUT4_JITTER 0.0 xco
      addParameter CLKOUT4_PHASE_ERROR 0.0 xco
      addParameter CLKOUT5_JITTER 0.0 xco
      addParameter CLKOUT5_PHASE_ERROR 0.0 xco
      addParameter CLKOUT6_JITTER 0.0 xco
      addParameter CLKOUT6_PHASE_ERROR 0.0 xco
      addParameter CLKOUT7_JITTER 0.0 xco
      addParameter CLKOUT7_PHASE_ERROR 0.0 xco
      addParameter INTERFACE_SELECTION "Enable_AXI" xco
   }

   proc update_parameters_from_before_v5_1 {parameterArray} {
      upvar $parameterArray valueArray 
      set freq_prim [getParameter PRIM_IN_FREQ valueArray]
      set freq_sec [getParameter SECONDARY_IN_FREQ valueArray]
      if { (([getParameter DIFF_CLK_IN1_BOARD_INTERFACE valueArray] != "Custom") || ([getParameter CLK_IN1_BOARD_INTERFACE valueArray] != "Custom")) } {
         removeParameter PRIM_IN_FREQ valueArray
         addParameter  PRIM_IN_FREQ [join "$freq_prim 000" "."] valueArray
      }  
      if { (([getParameter DIFF_CLK_IN2_BOARD_INTERFACE valueArray] != "Custom") || ([getParameter CLK_IN2_BOARD_INTERFACE valueArray] != "Custom")) } {
         removeParameter SECONDARY_IN_FREQ valueArray
         addParameter  SECONDARY_IN_FREQ [join "$freq_sec 000" "."] valueArray
      }  
	  
   }
   proc upgrade_from_clk_wiz_v5_1 {xciValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xciValues valueArray

      update_parameters_from_before_v5_1 valueArray

      if {[getParameter PRIMITIVE valueArray] == "PLL" && ([string equal -nocase kintexu [getOption architecture valueArray] ] || [string equal -nocase virtexu [getOption architecture valueArray] ] || [string equal -nocase zynquplus [getOption architecture valueArray] ] || [string equal -nocase virtexuplus [getOption architecture valueArray] ] || [string equal -nocase kintexuplus [getOption architecture valueArray] ] )} {

         # Phase alignment is set to 0 for PLLE3 and above         
		 removeParameter USE_PHASE_ALIGNMENT valueArray
         addParameter USE_PHASE_ALIGNMENT false valueArray  
         # Disable all the requested phase and set to 0.000
		 #clkout1
		 removeParameter CLKOUT1_REQUESTED_PHASE valueArray	  
         addParameter CLKOUT1_REQUESTED_PHASE 0.000 valueArray
		 #clkout2
		 removeParameter CLKOUT2_REQUESTED_PHASE valueArray	  
         addParameter CLKOUT2_REQUESTED_PHASE 0.000 valueArray
         #MMCM_clkout0_phase
		 removeParameter MMCM_CLKOUT0_PHASE valueArray
		 addParameter MMCM_CLKOUT0_PHASE 0.000 valueArray
		 #MMCM_clkout1_phase
		 removeParameter MMCM_CLKOUT1_PHASE valueArray
		 addParameter MMCM_CLKOUT1_PHASE 0.000 valueArray

	  }

      namespace forget ::xcoUpgradeLib::\*
   }

   proc upgrade_from_clk_wiz_v5_0 {xciValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xciValues valueArray

      upgrade_parameters_from_v5_0 valueArray

      if { [getParameter USE_BOARD_FLOW valueArray] == true } {
         setParameter USE_BOARD_FLOW true valueArray
      } else {
         setParameter USE_BOARD_FLOW false valueArray
      }

      if { [getParameter DIFF_CLK_IN1_BOARD_INTERFACE valueArray] != "Custom" } {
         setParameter CLK_IN1_BOARD_INTERFACE [getParameter DIFF_CLK_IN1_BOARD_INTERFACE valueArray]  valueArray
      } elseif { [getParameter CLK_IN1_BOARD_INTERFACE valueArray] != "Custom"  } {
         setParameter CLK_IN1_BOARD_INTERFACE [getParameter CLK_IN1_BOARD_INTERFACE valueArray]  valueArray
      } else {
         setParameter CLK_IN1_BOARD_INTERFACE "Custom" valueArray
      }

      if { [getParameter DIFF_CLK_IN2_BOARD_INTERFACE valueArray] != "Custom" } {
         setParameter CLK_IN2_BOARD_INTERFACE [getParameter DIFF_CLK_IN2_BOARD_INTERFACE valueArray]  valueArray
      } elseif { [getParameter CLK_IN2_BOARD_INTERFACE valueArray] != "Custom"  } {
         setParameter CLK_IN2_BOARD_INTERFACE [getParameter CLK_IN2_BOARD_INTERFACE valueArray]  valueArray
      } else {
         setParameter CLK_IN2_BOARD_INTERFACE "Custom" valueArray
      }


      namespace forget ::xcoUpgradeLib::\*
   }

   proc upgrade_from_clk_wiz_v4_4 {xciValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xciValues valueArray
  
      update_parameters_from_before_v5_0 valueArray    
      renameParameter SS_Mode     SS_MODE     valueArray
      renameParameter SS_Mod_Freq SS_MOD_FREQ valueArray
      upgrade_parameters_from_v5_0 valueArray
     
      namespace forget ::xcoUpgradeLib::\*
   }

   proc upgrade_from_clk_wiz_v4_3 {xciValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xciValues valueArray

      update_parameters_from_before_v4_4 valueArray    

      removeParameter Use_Fast_Simulation     valueArray
      update_parameters_from_before_v5_0 valueArray    
      renameParameter SS_Mode     SS_MODE     valueArray
      renameParameter SS_Mod_Freq SS_MOD_FREQ valueArray
      upgrade_parameters_from_v5_0 valueArray

      namespace forget ::xcoUpgradeLib::\*
   }


   proc upgrade_from_clk_wiz_v3_6 {xcoValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xcoValues valueArray

      # These procedures are order-sensitive
      update_parameters_from_before_v4_2 valueArray    
      update_parameters_from_before_v4_4 valueArray    
      update_parameters_from_before_v5_0 valueArray    
      upgrade_parameters_from_v5_0 valueArray

      # v3.6 has an additional "Use_Spread_Spectrum_1" parameter
      if { ([getParameter use_spread_spectrum_1 valueArray] == "true") } {
         setParameter USE_SPREAD_SPECTRUM "true"  valueArray
      } else {
         setParameter USE_SPREAD_SPECTRUM "false" valueArray
      }
      removeParameter Use_Spread_Spectrum_1 valueArray

      if {([getParameter PRIMTYPE_SEL valueArray] != "PLLE2") } {
         setParameter PRIMTYPE_SEL "MMCM_ADV" valueArray
      }

      namespace forget ::xcoUpgradeLib::\*
   }

   proc upgrade_from_clk_wiz_v3_5 {xcoValues} {
      namespace import ::xcoUpgradeLib::\*
      upvar $xcoValues valueArray

      # These procedures are order-sensitive
      update_parameters_from_before_v4_2 valueArray    
      update_parameters_from_before_v4_4 valueArray    
      update_parameters_from_before_v5_0 valueArray    
      upgrade_parameters_from_v5_0 valueArray

      addParameter SS_MODE      "CENTER_HIGH" valueArray
      addParameter SS_MOD_FREQ  250           valueArray

      if {([getParameter PRIMTYPE_SEL valueArray] != "PLLE2") } {
         setParameter PRIMTYPE_SEL "MMCM_ADV" valueArray
      }

      namespace forget ::xcoUpgradeLib::\*
   }


}

