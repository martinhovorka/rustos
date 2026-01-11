#-------------------------------------------------------------------------------
# 
# (c) Copyright 2008-2013, 2023 Advanced Micro Devices, Inc. All rights reserved.
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

##################################################################################
# This TCL file contains all the utility processes used by the Clocking Wizard IP.
##################################################################################
namespace eval clk_wiz_v6_0_utils {

#################################################################
# Load and initialize libIp_Clkwiz.
#package require xilinx::board 1.0
#namespace import ::xilinx::board::*

namespace export *
  load librdi_iptasks[info sharedlibextension]

# DEBUG variable variable - set to 0 to turn off debug printfs
variable c_debug false
variable c_debug_phase false
variable c_debug_duty_cycle false
variable c_prim

variable PartName ""
variable ComponentName ""
variable c_is_V6 false
variable c_is_V7 false

variable c_num_oclks 1

#################################################################
# variable variables
#################################################################
variable c_using_2_inclks false
variable c_auto_selection 
;# To Be Verified Again --> This should be set to true
variable c_auto_selection false
variable c_max_oclks 7
# input freq variables
variable c_min_in_freq 19.000
variable c_max_in_freq 500.000
variable c_min_2nd_in_freq 25.000
variable c_max_2nd_in_freq 400.000

variable c_min_in_timeperiod 0.052
variable c_max_in_timeperiod 0.002
variable c_min_2nd_in_timeperiod 0.040
variable c_max_2nd_in_timeperiod 0.002

variable c_min_infreq_pll 19.000
variable c_max_infreq_pll 500.000
variable c_min_infreq_dll 5.000
variable c_min_infreq_dfs 0.200
variable c_max_infreq_dfs 751.880
variable c_max_infreq_dll_1x 558.658
variable c_max_infreq_dll_2x 374.532
# output freq variables
variable c_min_out_freq 3.125
variable c_max_out_freq 375.000
variable min_period_time 10.000
variable min_period_mhz  100.000
variable c_min_ofreq_pll 3.125
variable c_max_ofreq_pll 375.000
variable c_max_ofreq_pll2 1000.000
variable c_min_out_freq_clkout4 0.0244
variable c_min_ofreq_dll 5.0
variable c_max_ofreq_clk0_180_1x 280.112
variable c_max_ofreq_clk0_180_2x 187.617
variable c_max_ofreq_clk90_270_1x 200.0
variable c_max_ofreq_clk90_270_2x 187.617
variable c_min_ofreq_clk2x 10.0
variable c_max_ofreq_clk2x 374.532
variable c_min_ofreq_clkdv 0.313
variable c_max_ofreq_clkdv_1x 184.874
variable c_max_ofreq_clkdv_2x 125.000
variable c_min_ofreq_clkfx 0.5
variable c_max_ofreq_clkfx 375.5318
# PFD freq variables
variable c_min_pfd_freq 10.000
variable c_max_pfd_freq 650.000
# VCO freq variables
variable c_min_vco_freq 10.000
variable c_max_vco_freq 800.000
variable c_vco_freq 0.000
# input jitter variables
variable c_min_in_jitter 0.000
variable c_max_in_jitter 0.999
# c_clkout#_out_freq -> holds the Actual Out Freq, in whatever units are being used.
variable C_CLKOUT1_OUT_FREQ 100.000
variable C_CLKOUT2_OUT_FREQ 100.000
variable C_CLKOUT3_OUT_FREQ 100.000
variable C_CLKOUT4_OUT_FREQ 100.000
variable C_CLKOUT5_OUT_FREQ 100.000
variable C_CLKOUT6_OUT_FREQ 100.000
variable C_CLKOUT7_OUT_FREQ 100.000
# c_clkout#_phase -> holds the Actual Phase
variable C_CLKOUT1_PHASE 0.000
variable C_CLKOUT2_PHASE 0.000
variable C_CLKOUT3_PHASE 0.000
variable C_CLKOUT4_PHASE 0.000
variable C_CLKOUT5_PHASE 0.000
variable C_CLKOUT6_PHASE 0.000
variable C_CLKOUT7_PHASE 0.000
# c_clkout#_duty_cycle -> holds the Actual Duty Cycle
variable C_CLKOUT1_DUTY_CYCLE 50.000
variable C_CLKOUT2_DUTY_CYCLE 50.000
variable C_CLKOUT3_DUTY_CYCLE 50.000
variable C_CLKOUT4_DUTY_CYCLE 50.000
variable C_CLKOUT5_DUTY_CYCLE 50.000
variable C_CLKOUT6_DUTY_CYCLE 50.000
variable C_CLKOUT7_DUTY_CYCLE 50.000
# Summary Table string variables
variable C_INCLK_SUM_ROW0 "Input Clock   Freq (MHz)    Input Jitter (UI)"
variable C_INCLK_SUM_ROW1 "  primary       100.000        0.010"
variable C_INCLK_SUM_ROW2 " secondary      100.000        0.010"
variable C_OUTCLK_SUM_ROW0A " Output    Output      Phase     Duty     Pk-to-Pk     Phase"
variable C_OUTCLK_SUM_ROW0B " Clock    Freq (MHz) (degrees) Cycle (%) Jitter (ps)  Error (ps)"
variable C_OUTCLK_SUM_ROW1  "clk_out1   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW2  "clk_out2   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW3  "clk_out3   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW4  "clk_out4   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW5  "clk_out5   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW6  "clk_out6   100.000     0.000    50.000     130.000      0.000 "
variable C_OUTCLK_SUM_ROW7  "clk_out7   100.000     0.000    50.000     130.000      0.000 "


variable text_CLKOUT1_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT1_ACTUAL_PHASE "0.000"
variable text_CLKOUT1_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT2_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT2_ACTUAL_PHASE "0.000"
variable text_CLKOUT2_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT3_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT3_ACTUAL_PHASE "0.000"
variable text_CLKOUT3_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT4_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT4_ACTUAL_PHASE "0.000"
variable text_CLKOUT4_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT5_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT5_ACTUAL_PHASE "0.000"
variable text_CLKOUT5_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT6_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT6_ACTUAL_PHASE "0.000"
variable text_CLKOUT6_ACTUAL_DUTY_CYCLE "50.000"
variable text_CLKOUT7_ACTUAL_OUT_FREQ "100.000"
variable text_CLKOUT7_ACTUAL_PHASE "0.000"
variable text_CLKOUT7_ACTUAL_DUTY_CYCLE "50.000"
variable text_Label_Actual_Err_Str ""
variable text_SSModActFreq "100"
variable phy_mode ""
variable Error false
variable primitive false

#################################################################
# Clkwiz Procedures
#################################################################
# Get all the speedsfile MHz data we need, for this speedgrade.
proc get_speedsfile_data {value_primitive device_type auto_prim devicefamily} {
   variable c_min_in_freq
   variable c_max_in_freq
   variable c_min_vco_freq
   variable c_max_vco_freq
   variable c_min_out_freq
   variable c_max_out_freq
   variable min_period
   variable c_min_pfd_freq
   variable c_max_pfd_freq
   variable c_min_in_freq
   variable c_max_in_freq
   variable c_m_max
   variable c_m_min
   variable c_d_max
   variable c_d_min
   variable c_o_max
   variable c_o_min


   variable c_min_in_timeperiod
   variable c_max_in_timeperiod
   variable PartName
   variable ComponentName
   # Get input clock frequency min, max values.
   if { $value_primitive == "MMCM" || $value_primitive == "Auto" } {
      set c_min_in_freq [get_speedsfile_key_value "MMCM_CLKIN_FREQ_MIN" ]
      set c_max_in_freq [get_speedsfile_key_value "MMCM_CLKIN_FREQ_MAX" ]
      set c_min_vco_freq [get_speedsfile_key_value "MMCM_VCOCLK_FREQ_MIN" ]
      set c_max_vco_freq [get_speedsfile_key_value "MMCM_VCOCLK_FREQ_MAX" ]
      set c_min_out_freq [get_speedsfile_key_value "MMCM_CLKOUT_FREQ_MIN" ]
      set c_max_out_freq [get_speedsfile_key_value "MMCM_CLKOUT_FREQ_MAX" ]
      set c_min_pfd_freq [get_speedsfile_key_value "MMCM_CLKPFD_FREQ_MIN" ]
      set c_max_pfd_freq [get_speedsfile_key_value "MMCM_CLKPFD_FREQ_MAX" ]
      
      if {$device_type == 2 } {
        ##For olympus devices
        set c_m_max [get_speedsfile_key_value "MMCM_M_MAX"]
        set c_m_min [get_speedsfile_key_value "MMCM_M_MIN"]
        set c_d_max [get_speedsfile_key_value "MMCM_D_MAX"]
        set c_d_min [get_speedsfile_key_value "MMCM_D_MIN"]
        set c_o_max [get_speedsfile_key_value "MMCM_O_MAX"]
        set c_o_min [get_speedsfile_key_value "MMCM_O_MIN"]
      } else {
        ##For non-olympus devices
        set c_m_max [get_speedsfile_key_value "M_MAX"]
        set c_m_min [get_speedsfile_key_value "M_MIN"]
        set c_d_max [get_speedsfile_key_value "D_MAX"]
        set c_d_min [get_speedsfile_key_value "D_MIN"]
        set c_o_max [get_speedsfile_key_value "O_MAX"]
        set c_o_min [get_speedsfile_key_value "O_MIN"]      
      }

      set c_min_vco_freq [get_speedsfile_key_value "MMCM_VCOCLK_FREQ_MIN"]
      set c_max_vco_freq [get_speedsfile_key_value "MMCM_VCOCLK_FREQ_MAX"]
      
      if {$value_primitive == "Auto" && $auto_prim == "PLL"} {
         set c_min_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MIN" ]
         set c_max_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MAX" ]
      }
   } elseif { $value_primitive == "PLL" } {
      if {$device_type == 2 } {
         ##For olympus devices
         set c_min_in_freq [get_speedsfile_key_value "PLL_CLKIN_FREQ_MIN" ]
         set c_max_in_freq [get_speedsfile_key_value "PLL_CLKIN_FREQ_MAX" ]
         set c_min_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MIN" ]
         set c_max_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MAX" ]
         set c_min_out_freq [get_speedsfile_key_value "PLL_CLKOUT_FREQ_MIN" ]
         set c_max_out_freq [get_speedsfile_key_value "PLL_CLKOUT_FREQ_MAX" ]
         set c_min_pfd_freq [get_speedsfile_key_value "PLL_CLKPFD_FREQ_MIN" ]
         set c_max_pfd_freq [get_speedsfile_key_value "PLL_CLKPFD_FREQ_MAX" ]
         
         set c_m_max [get_speedsfile_key_value "PLL_M_MAX"]
         set c_m_min [get_speedsfile_key_value "PLL_M_MIN"]
         set c_d_max [get_speedsfile_key_value "PLL_D_MAX"]
         set c_d_min [get_speedsfile_key_value "PLL_D_MIN"]
         set c_o_max [get_speedsfile_key_value "PLL_O_MAX"]
         set c_o_min [get_speedsfile_key_value "PLL_O_MIN"]
         set c_min_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MIN"]
         set c_max_vco_freq [get_speedsfile_key_value "PLL_VCOCLK_FREQ_MAX"]
      } else {
         ##For Non-olympus devices where $device_type == 1
         set c_min_in_freq [get_speedsfile_key_value "PLLE2_CLKIN_FREQ_MIN" ]
         set c_max_in_freq [get_speedsfile_key_value "PLLE2_CLKIN_FREQ_MAX" ]
         set c_min_vco_freq [get_speedsfile_key_value "PLLE2_VCOCLK_FREQ_MIN" ]
         set c_max_vco_freq [get_speedsfile_key_value "PLLE2_VCOCLK_FREQ_MAX" ]
         set c_min_out_freq [get_speedsfile_key_value "PLLE2_CLKOUT_FREQ_MIN" ]
         set c_max_out_freq [get_speedsfile_key_value "PLLE2_CLKOUT_FREQ_MAX" ]
         set c_min_pfd_freq [get_speedsfile_key_value "PLLE2_CLKPFD_FREQ_MIN" ]
         set c_max_pfd_freq [get_speedsfile_key_value "PLLE2_CLKPFD_FREQ_MAX" ]
         
         set c_m_max [get_speedsfile_key_value "PLLE2_M_MAX"]
         set c_m_min [get_speedsfile_key_value "PLLE2_M_MIN"]
         set c_d_max [get_speedsfile_key_value "PLLE2_D_MAX"]
         set c_d_min [get_speedsfile_key_value "PLLE2_D_MIN"]
         set c_o_max [get_speedsfile_key_value "PLLE2_O_MAX"]
         set c_o_min [get_speedsfile_key_value "PLLE2_O_MIN"]
         set c_min_vco_freq [get_speedsfile_key_value "PLLE2_VCOCLK_FREQ_MIN"]
         set c_max_vco_freq [get_speedsfile_key_value "PLLE2_VCOCLK_FREQ_MAX"]
      }
   }   
}

#################################################################
# Get a key value from the speedsfile using the Clkwiz dll.
proc get_speedsfile_key_value { keyword } {
   variable PartName
   variable ComponentName

   set kValue [GetClkwizProperty $PartName $ComponentName "SpdKeyValue" $keyword]
   return $kValue
}

#################################################################
# Writes the primtype selection resource to Label_Res_1.
proc setup_prim_res_label {} {
   variable Label_Res_1
   set curr_prim [get_param_value PRIMITIVE ]
   $Label_Res_1 SetText "1 $curr_prim"
}

######################################
proc setup_outclk_settings_table {} {

   hide_unused_oclks
   if { [is_override_used] == false } {
      disable_requested_out_freqs
      disable_requested_duty_cycles
   }
}

######################################
# Loads the values into the xpower table.
proc load_xpower_table {} {

   set prim [get_param_value PRIMITIVE ]
   if { $prim == "MMCM_ADV"} {
      mmcm_load_xpower_table
   }
}

######################################
proc hide_unused_oclks {} {
   variable Groupbox_Oclk_Sum_Clkout2
   variable Groupbox_Oclk_Sum_Clkout3
   variable Groupbox_Oclk_Sum_Clkout4
   variable Groupbox_Oclk_Sum_Clkout5
   variable Groupbox_Oclk_Sum_Clkout6
   variable Groupbox_Oclk_Sum_Clkout7
   variable Groupbox_Mmcm_Clkout1_Attrs
   variable Groupbox_Mmcm_Clkout1_Values
   variable Groupbox_Mmcm_Clkout2_Attrs
   variable Groupbox_Mmcm_Clkout2_Values
   variable Groupbox_Mmcm_Clkout3_Attrs
   variable Groupbox_Mmcm_Clkout3_Values
   variable Groupbox_Mmcm_Clkout4_Attrs
   variable Groupbox_Mmcm_Clkout4_Values
   variable Groupbox_Mmcm_Clkout5_Attrs
   variable Groupbox_Mmcm_Clkout5_Values
   variable Groupbox_Mmcm_Clkout6_Attrs
   variable Groupbox_Mmcm_Clkout6_Values
   variable page4_MMCM_2
   variable c_num_oclks
   variable Label_Mmcm_Addnl

   # Get the number of output clocks used.
   # Only show the number of rows for the used clocks.
   set bHide2 true
   set bHide3 true
   set bHide4 true
   set bHide5 true
   set bHide6 true
   set bHide7 true
   set bHide8 true
   $page4_MMCM_2 SetHidden true
   $Label_Mmcm_Addnl SetHidden true
   if { $c_num_oclks >= 2 } {
      set bHide2 false
   }
   if { $c_num_oclks >= 3 } {
      set bHide3 false
   }
   if { $c_num_oclks >= 4 } {
      set bHide4 false
   }
   if { $c_num_oclks >= 5 } {
      set bHide5 false
   }
   if { $c_num_oclks >= 6 } {
      set bHide6 false
      $page4_MMCM_2 SetHidden false
      $Label_Mmcm_Addnl SetHidden false
   }
   if { $c_num_oclks >= 7 } {
      set bHide7 false
   }
   # Clock Summary page
   $Groupbox_Oclk_Sum_Clkout2 SetHidden $bHide2
   $Groupbox_Oclk_Sum_Clkout3 SetHidden $bHide3
   $Groupbox_Oclk_Sum_Clkout4 SetHidden $bHide4
   $Groupbox_Oclk_Sum_Clkout5 SetHidden $bHide5
   $Groupbox_Oclk_Sum_Clkout6 SetHidden $bHide6
   $Groupbox_Oclk_Sum_Clkout7 SetHidden $bHide7
   # MMCM override pages
   $Groupbox_Mmcm_Clkout1_Attrs SetHidden $bHide2
   $Groupbox_Mmcm_Clkout1_Values SetHidden $bHide2
   $Groupbox_Mmcm_Clkout2_Attrs SetHidden $bHide3
   $Groupbox_Mmcm_Clkout2_Values SetHidden $bHide3
   $Groupbox_Mmcm_Clkout3_Attrs SetHidden $bHide4
   $Groupbox_Mmcm_Clkout3_Values SetHidden $bHide4
   $Groupbox_Mmcm_Clkout4_Attrs SetHidden $bHide5
   $Groupbox_Mmcm_Clkout4_Values SetHidden $bHide5
   $Groupbox_Mmcm_Clkout5_Attrs SetHidden $bHide6
   $Groupbox_Mmcm_Clkout5_Values SetHidden $bHide6
   $Groupbox_Mmcm_Clkout6_Attrs SetHidden $bHide7
   $Groupbox_Mmcm_Clkout6_Values SetHidden $bHide7
}

######################################
proc setup_valid_infreq_range_label1 {} {
   variable c_min_in_freq
   variable c_max_in_freq

   # NOTE: c_min/max_in_freq is always in MHz
   set minFreq [setup_display_float $c_min_in_freq]
   set maxFreq [setup_display_float $c_max_in_freq]
   return "$minFreq - $maxFreq"
}
######################################
proc setup_valid_intime_range_label1 {} {
   variable c_min_in_freq
   variable c_max_in_freq

    set maxPeriod [convert_MHz_to_ns $c_max_in_freq]
    set minPeriod [convert_MHz_to_ns $c_min_in_freq]
    #return "$minPeriod - $maxPeriod"
    return "$maxPeriod - $minPeriod"
}

######################################
# NOTE: This is only used for MMCM.
proc setup_valid_infreq_range_label2 {prim_freq clkFBMult divClkDiv} {
   variable c_min_in_freq
   variable c_max_in_freq
   variable c_min_vco_freq
   variable c_max_vco_freq
   variable c_min_2nd_in_freq
   variable c_max_2nd_in_freq

   set clkperiod [ expr 1000.0 / $prim_freq ]
   set period_val [setup_display_float_freq $clkperiod ]
   set vco_freq [expr (1.0 * $prim_freq* $clkFBMult) / ($divClkDiv) ]

   # The secondary range is N x the primary infreq up to M x the primary infreq.
   # and   N = c_min_vco_freq / c_max_vco_freq
   # and   M = c_max_vco_freq / c_min_vco_freq
   # It also is still has to be within the input freq's min/max values.
   set N [expr $c_min_vco_freq / $vco_freq ]
   set M [expr $c_max_vco_freq / $vco_freq ]

   # Setup the valid min/max params (these are always in MHz).
   set c_min_2nd_in_freq [expr $prim_freq * $N ]
   set c_max_2nd_in_freq [expr $prim_freq * $M ]

   # Make sure to limit them to the actual min/max.
   if { $c_min_2nd_in_freq < $c_min_in_freq } {
      set c_min_2nd_in_freq $c_min_in_freq 
   }
   if { $c_max_2nd_in_freq > $c_max_in_freq } {
      set c_max_2nd_in_freq $c_max_in_freq 
   }

   set minFreq [setup_display_float $c_min_2nd_in_freq]
   set maxFreq [setup_display_float $c_max_2nd_in_freq]
   return "$minFreq - $maxFreq"
}

proc setup_valid_intime_range_label2 {prim_freq clkFBMult divClkDiv} {
   variable c_min_2nd_in_freq
   variable c_max_2nd_in_freq

   set minPeriod [convert_MHz_to_ns $c_min_2nd_in_freq]
   set maxPeriod [convert_MHz_to_ns $c_max_2nd_in_freq]
   #return "$minPeriod - $maxPeriod"
   return "$maxPeriod - $minPeriod"

}

proc setup_infreq_min_sec {prim_freq clkFBMult divClkDiv} {
   variable c_min_in_freq
   variable c_max_in_freq
   variable c_min_vco_freq
   #variable c_min_2nd_in_freq

   set clkperiod [ expr 1000.0 / $prim_freq ]
   set period_val [setup_display_float_freq $clkperiod ]
   set vco_freq [expr (1.0 * $prim_freq * $clkFBMult) / ($divClkDiv) ]

   # The secondary range is N x the primary infreq up to M x the primary infreq.
   # and   N = c_min_vco_freq / c_max_vco_freq
   # and   M = c_max_vco_freq / c_min_vco_freq
   # It also is still has to be within the input freq's min/max values.
   set N [expr $c_min_vco_freq / $vco_freq ]

   # Setup the valid min/max params (these are always in MHz).
   set min_2nd_in_freq [setup_display_float [expr $prim_freq * $N ]]

   # Make sure to limit them to the actual min/max.
   if { $min_2nd_in_freq < $c_min_in_freq } {
      set min_2nd_in_freq $c_min_in_freq 
   }

   return $min_2nd_in_freq
}

#proc for min_period values of buffers
proc get_freq_range_of_buffers  { buffer_type }   {
   variable PartName
   variable ComponentName
   variable c_num_oclks
   variable c_max_out_freq
 
   if { $buffer_type == "No_buffer"} {
      set min_period [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]
   } else {
      set min_period [GetClkwizProperty $PartName $ComponentName MinPeriod $buffer_type]
   }
   return $min_period
}

######################################
# For MMCM or PLL: Calculates the optimal output freqs, phases, and duty cycles for all 
# used output clocks.
# Returns true if successful; else false.
proc mmcm_pll_calc_optimals {clkin1 clkin2 bMinOJitterUsed nonDefaultPhaseDC bPLL reqOutFreqStr reqPhaseStr reqDutyCycleStr clkphy_en clkphy_freq clk2_bufgce clk2_bufgce_div clk3_bufgce clk3_bufgce_div clk4_bufgce clk4_bufgce_div auto timePeriod IpView} {

   variable PartName
   variable ComponentName
   variable c_num_oclks
   variable text_CLKOUT1_ACTUAL_OUT_FREQ
   variable text_CLKOUT1_ACTUAL_PHASE
   variable text_CLKOUT1_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT2_ACTUAL_OUT_FREQ
   variable text_CLKOUT2_ACTUAL_PHASE
   variable text_CLKOUT2_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT3_ACTUAL_OUT_FREQ
   variable text_CLKOUT3_ACTUAL_PHASE
   variable text_CLKOUT3_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT4_ACTUAL_OUT_FREQ
   variable text_CLKOUT4_ACTUAL_PHASE
   variable text_CLKOUT4_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT5_ACTUAL_OUT_FREQ
   variable text_CLKOUT5_ACTUAL_PHASE
   variable text_CLKOUT5_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT6_ACTUAL_OUT_FREQ
   variable text_CLKOUT6_ACTUAL_PHASE
   variable text_CLKOUT6_ACTUAL_DUTY_CYCLE
   variable text_CLKOUT7_ACTUAL_OUT_FREQ
   variable text_CLKOUT7_ACTUAL_PHASE
   variable text_CLKOUT7_ACTUAL_DUTY_CYCLE
   variable text_Label_Actual_Err_Str
   variable text_SSModActFreq
   variable c_vco_freq
   variable c_debug
   variable phy_mode ""

   set rtn false
   #$Label_Actual_Err_Str SetHidden true
   #$Label_Actual_Err_Str2 SetHidden true
   #$Label_Actual_Err_Str3 SetHidden true
   # Get all the requested out freqs (MHz) in one long string, separated by spaces.
   #set reqOutFreqStr [construct_req_outfreq_str]
   #set reqPhaseStr [construct_req_phase_str]
   #set reqDutyCycleStr [construct_req_duty_cycle_str]

   # Now calculate for the optimal VCO, M, D, Div#, OutFreqs, Phases, and Duty Cycles.
   # (They all are calculated at the same time.)
   if {$bPLL == "true"} {
        #puts " 5555555555555  PartName :$PartName ComponentName :$ComponentName reqOutFreqStr :$reqOutFreqStr reqPhaseStr :$reqPhaseStr reqDutyCycleStr :$reqDutyCycleStr clkin1 :$clkin1 clkin2 :$clkin2 c_num_oclks :$c_num_oclks bMinOJitterUsed :$bMinOJitterUsed nonDefaultPhaseDC :$nonDefaultPhaseDC bPLL :$bPLL c_debug :$c_debug clkphy_en :$clkphy_en clkphy_freq :$clkphy_freq"
        set errStr [ GetClosestSolution $PartName $ComponentName $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC true $c_debug $timePeriod $clkphy_en $clkphy_freq ]
        #puts " 444444444444444 $errStr  PartName :$PartName ComponentName :$ComponentName reqOutFreqStr :$reqOutFreqStr reqPhaseStr :$reqPhaseStr reqDutyCycleStr :$reqDutyCycleStr clkin1 :$clkin1 clkin2 :$clkin2 c_num_oclks :$c_num_oclks bMinOJitterUsed :$bMinOJitterUsed nonDefaultPhaseDC :$nonDefaultPhaseDC bPLL :$bPLL c_debug :$c_debug clkphy_en :$clkphy_en clkphy_freq :$clkphy_freq"

        if { $errStr == "1" } {
             set phy_mode [ GetClkwizProperty $PartName $ComponentName ChosenClkoutXiPhyMode ]
             set freq [ GetClkwizProperty $PartName $ComponentName ChosenClkoutXiPhyFreq ]
        }

   } else {
        set errStr [ GetClosestSolution $PartName $ComponentName $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC $bPLL $c_debug $timePeriod]
   }
   
   if { $errStr == "1" } {
      set rtn true
      set Dvalue [ GetClkwizProperty $PartName $ComponentName ChosenD ]
      set Mvalue [ GetClkwizProperty $PartName $ComponentName ChosenM ]
      set divN0 [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
      set divN [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
      #puts "Alogorith values nvledn n $Dvalue "
      #puts "Alogorith values $Mvalue "
      variable text_Label_Actual_Err_Str ""
      set text_SSModActFreq [ GetClkwizProperty $PartName $ComponentName SSModActFreq]
      variable text_Label_Actual_Err_Str ""
      for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
         if { $ctr != 0 } {
            if {$ctr == 1 && $clk2_bufgce == "true"} {
              set divN [expr {$clk2_bufgce_div * $divN0}]
            } elseif {$ctr == 2 && $clk3_bufgce == "true"} {
              set divN [expr {$clk3_bufgce_div * $divN0}]
            } elseif {$ctr == 3 && $clk4_bufgce == "true"} {
              set divN [expr {$clk4_bufgce_div * $divN0}]
            } else {
              set divN [ GetClkwizProperty $PartName $ComponentName ChosenDivN $ctr ]
            }
         }
          
    
         if { $ctr == 0 } {
            #set oFreq [get_calcd_out_freq $Mvalue $Dvalue $divN ]
            set oFreq [expr ($Mvalue * $clkin1) /  ($Dvalue * $divN) ]
         } else {
            set oFreq [expr ($Mvalue * $clkin1) /  ($Dvalue * $divN) ]
            #set oFreq [get_calcd_out_freq $Mvalue $Dvalue $divN.0 ]
         }

         set phase [ GetClkwizProperty $PartName $ComponentName ChosenPhaseN $ctr ]
         ### Phase Calculation #########
       set negPhase false
       set div $divN
       if { ($div > 64) } {
          set MAX_PS  [expr {((63.0 / $div) * 360) + (7 * (45.0 / $div)) - (0.001)}]
          if { $phase < 0.0 } {
            set phase [expr ($phase + 360.0)]
            set negPhase true
          }
          if { ($phase > $MAX_PS) } {
             set phase $MAX_PS
          }
       }
       set val [expr ($phase * $div / 45.0)]
       set ival [expr {int($val)}]
       set diff [expr ($val - $ival)]
       if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
          set mulphase [expr {45.0*$ival/$div}]
          if { $negPhase == true } {
             set mulphase [expr ($mulphase - 360)]
          }
          set phase $mulphase
          }
         set dutyCycle [ GetClkwizProperty $PartName $ComponentName ChosenDutyCycleN $ctr ]
         # duty cycle is in fractional value, so convert to %
         set dutyCyclePercent [expr $dutyCycle * 100 ]
         set dutyCyclePercent [setup_display_float_duty_cycle $dutyCyclePercent]
         set dutyCycle [setup_display_float $dutyCycle]
         set displayF $oFreq
         set displayF [setup_display_float_freq $displayF]

         if { $ctr == 0 } {
            set text_CLKOUT1_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT1_ACTUAL_PHASE $phase  
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            #puts "first proc value of phase is text_CLKOUT1_ACTUAL_PHASE $text_CLKOUT1_ACTUAL_PHASE\n" 
           set text_CLKOUT1_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 1 } {
            set text_CLKOUT2_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT2_ACTUAL_PHASE $phase 
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT2_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 2 } {
            set text_CLKOUT3_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT3_ACTUAL_PHASE $phase  
            ##CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT3_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 3 } {
            set text_CLKOUT4_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT4_ACTUAL_PHASE $phase  
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT4_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 4 } {
            set text_CLKOUT5_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT5_ACTUAL_PHASE $phase  
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT5_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 5 } {
            set text_CLKOUT6_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT6_ACTUAL_PHASE $phase  
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT6_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         } elseif { $ctr == 6 } {
            set text_CLKOUT7_ACTUAL_OUT_FREQ $displayF
            set text_CLKOUT7_ACTUAL_PHASE $phase  
            #CR fix CR-975434 where the values of actual_phase on the second page and override page were not same 
            set text_CLKOUT7_ACTUAL_DUTY_CYCLE $dutyCyclePercent
         }
      }
      if { $bPLL == true } {
         # Assuming this is required only for S6 PLL TO DO
         #check_req_outfreq_obuf_pll 
      }
      variable text_Label_Actual_Err_Str ""
   variable Error false
   # determine_auto_primitive $IpView
 ###send_msg INFO 444 "Error :$Error PLL $bPLL"
   } else {
      #puts "XXXXXXXXXX Value is called"
   variable Error true
   # auto_selection $IpView

 ###send_msg INFO 333 "Error :$Error PLL $bPLL"
      # Couldn't get actual out freq.
      if { $bPLL == true && $auto == true} {
         # Assuming this is required only for S6 PLL TO DO
         #check_req_outfreq_obuf_pll 
 ###send_msg INFO 100 "Auto PLL"
      variable text_Label_Actual_Err_Str ""
      } else {
 ###send_msg INFO 200 "Auto MMCM"
      variable text_Label_Actual_Err_Str $errStr
     }
     # variable text_Label_Actual_Err_Str $errStr
      #$Label_Actual_Err_Str SetHidden false
      # TODO change to font color
        set text_CLKOUT1_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      if {$c_num_oclks > 1} {
        set text_CLKOUT2_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 2} {
        set text_CLKOUT3_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 3} {
        set text_CLKOUT4_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 4} {
        set text_CLKOUT5_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 5} {
        set text_CLKOUT6_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 6} {
        set text_CLKOUT7_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      #set text_CLKOUT1_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT2_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT3_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT4_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT5_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT6_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT7_ACTUAL_OUT_FREQ "XXX"
      # determine_auto_primitive $IpView 
   }
   return $rtn
}



######################################
# For MMCM or PLL: Calculates the Actual output frequencies for all used output clocks.
# Returns true if successful; else false.
proc mmcm_pll_calc_outfreqs {clkin1 clkin2 bMinOJitterUsed nonDefaultPhaseDC bPLL reqOutFreqStr reqPhaseStr reqDutyCycleStr clkphy_en clkphy_freq auto timePeriod1} {

   variable PartName
   variable ComponentName
   variable c_num_oclks
   variable text_CLKOUT1_ACTUAL_OUT_FREQ
   variable text_CLKOUT2_ACTUAL_OUT_FREQ
   variable text_CLKOUT3_ACTUAL_OUT_FREQ
   variable text_CLKOUT4_ACTUAL_OUT_FREQ
   variable text_CLKOUT5_ACTUAL_OUT_FREQ
   variable text_CLKOUT6_ACTUAL_OUT_FREQ
   variable text_CLKOUT7_ACTUAL_OUT_FREQ
   variable text_Label_Actual_Err_Str
   variable c_using_2_inclks
   variable c_debug
   variable phy_mode ""

   set rtn false
   # Now calculate for the optimal VCO, M, D, Div#, and OutFreq.

   if { $bPLL == "true" } {
        set errStr [ PLLCalculateActualOutFreqs $PartName $ComponentName $reqOutFreqStr  $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC $c_debug $timePeriod1 $clkphy_en $clkphy_freq ]
        if { $errStr == "1" } {
             set phy_mode [ GetClkwizProperty $PartName $ComponentName ChosenClkoutXiPhyMode ]
             set freq [ GetClkwizProperty $PartName $ComponentName ChosenClkoutXiPhyFreq ]
        }

   } else {
      set errStr [ MMCMCalculateActualOutFreqs $PartName $ComponentName $reqOutFreqStr $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC $c_debug $timePeriod1]
   }
   
   if { $errStr == "1" } {
      set rtn true
      set Dvalue [ GetClkwizProperty $PartName $ComponentName ChosenD ]
      set Mvalue [ GetClkwizProperty $PartName $ComponentName ChosenM ]
      set divN [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]

      for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
         if { $ctr != 0 } {
           set divN [ GetClkwizProperty $PartName $ComponentName ChosenDivN $ctr ]
         }

         if { $ctr == 0 } {
            #set oFreq [get_calcd_out_freq $Mvalue $Dvalue $divN ]
            set oFreq [expr ($Mvalue * $clkin1) /  ($Dvalue * $divN) ]
         } else {
            #set oFreq [get_calcd_out_freq $Mvalue $Dvalue $divN.0 ]
            set oFreq [expr ($Mvalue * $clkin1) /  ($Dvalue * $divN) ]
         }

         set displayF $oFreq
         set displayF [setup_display_float_freq $displayF]

         if { $ctr == 0 } {
            set text_CLKOUT1_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 1 } {
            set text_CLKOUT2_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 2 } {
            set text_CLKOUT3_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 3 } {
            set text_CLKOUT4_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 4 } {
            set text_CLKOUT5_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 5 } {
            set text_CLKOUT6_ACTUAL_OUT_FREQ $displayF
         } elseif { $ctr == 6 } {
            set text_CLKOUT7_ACTUAL_OUT_FREQ $displayF
         }
      }
      variable text_Label_Actual_Err_Str ""
   variable Error false
 ###send_msg INFO 111 "Error :$Error PLL $bPLL"
   } else {
   variable Error true
 ###send_msg INFO 222 "Error :$Error PLL $bPLL"
      # Couldn't get actual out freq.
      if { $bPLL == true && $auto == true} {
         # Assuming this is required only for S6 PLL TO DO
         #check_req_outfreq_obuf_pll 
 ###send_msg INFO 100 "Auto PLL"
      variable text_Label_Actual_Err_Str ""
      } else {
 ###send_msg INFO 200 "Auto MMCM"
      variable text_Label_Actual_Err_Str $errStr
     }
      # Couldn't get actual out freq.
        set text_CLKOUT1_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      if {$c_num_oclks > 1} {
        set text_CLKOUT2_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 2} {
        set text_CLKOUT3_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 3} {
        set text_CLKOUT4_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 4} {
        set text_CLKOUT5_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 5} {
        set text_CLKOUT6_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      if {$c_num_oclks > 6} {
        set text_CLKOUT7_ACTUAL_OUT_FREQ "<font color=red>XXX</font>"
      }
      variable text_Label_Actual_Err_Str "<font color=red>$errStr</font>"
      #set text_CLKOUT1_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT2_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT3_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT4_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT5_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT6_ACTUAL_OUT_FREQ "XXX"
      #set text_CLKOUT7_ACTUAL_OUT_FREQ "XXX"
   }
   return $rtn
}

#################################################################
# Get the calculated output freq, using the given M, D, DivN values.
# Uses the primary inclk period as it is stored in the appropriate attr (so
# that it matches what the tools will calculate).
# Returns the output freq.  This should be the output freq that the tools
# would come up with, using these values that the wizard passes on.
proc get_calcd_out_freq { Mvalue Dvalue divN infreq } {

   # Get the input clock period, which is the ns value of PRIM_IN_FREQ, rounded to
   # 3 decimal places (which is how it is stored in the attr). Then convert that to MHz.
   set clkinp [get_inclk_period $infreq ]  
   set temp [setup_display_float $clkinp]; # this is what would be stored in CLKIN_PERIOD
   set infreq [convert_ns_to_MHz $temp]

   set vco [expr ($Mvalue / $Dvalue) * 1.0 * $infreq ]

   set vco_3pts [format "%3.3f" $vco]
   set fout [expr $vco_3pts / $divN ]
   return $fout 
}

#################################################################
# Converts the Primary and Secondary input jitter to match whatever the current units are.
# Assumes that the units were just changed, so whatever is in Prim/SECONDARY_IN_JITTER
# is still in the previous units.
proc convert_injitter_to_match_units {} {
   variable IN_JITTER_UNITS
   variable PRIM_IN_JITTER
   variable SECONDARY_IN_JITTER

   if { [get_param_value IN_JITTER_UNITS ] == "Units_ps" } {
      # This means that Prim/SECONDARY_IN_JITTER is still in UI.
      # So convert it to ps.
      $PRIM_IN_JITTER SetValue [convert_UI_to_ps_for_inclk [get_param_value PRIM_IN_JITTER ] 1 ]
      $SECONDARY_IN_JITTER SetValue [convert_UI_to_ps_for_inclk [get_param_value SECONDARY_IN_JITTER ] 2]
   } else {
      # This means that Prim/SECONDARY_IN_JITTER is still in ps.
      # So convert it to UI.
      $PRIM_IN_JITTER SetValue [convert_ps_to_UI_for_inclk [get_param_value PRIM_IN_JITTER ] 1]
      $SECONDARY_IN_JITTER SetValue [convert_ps_to_UI_for_inclk [get_param_value SECONDARY_IN_JITTER ] 2]
   }
}

#################################################################
# Returns the given ns value as MHz.
proc convert_ns_to_MHz { nsValue } {
   # 1 MHz = 1000/ns
   if { $nsValue != 0 } {
      return [format "%3.3f" [expr  1000.000 / $nsValue]]
   }
   return 0.0
}

#################################################################
# Returns the given ns value as MHz.
proc convert_ms_to_KHz { msValue } {
   if { $msValue != 0 } {
      return [format "%3.3f" [expr  1.000 / $msValue]]
   }
   return 0.0
}

#################################################################

# Returns the clock period in ns for the specified inclk, based on the current
# value of IN_FREQ_UNITS.
# Does not change the Prim/SECONDARY_IN_FREQ.
# If the inclk freq is already in ns (from IN_FREQ_UNITS), that value is returned.
# bPrim --> 2 = Secondary; 1 = Primary.
proc get_inclk_period { infreq } {

   set inPeriod [convert_MHz_to_ns $infreq ]

   set adjPeriod [ Adjust_Clkin_Period $inPeriod $infreq]
   set inPeriod $adjPeriod
   
   return $inPeriod
}

#####################################################################
# Returns the input clock frequency in MHz for the specified inclk, based on the current
# value of IN_FREQ_UNITS.
# Does not change the Prim/SECONDARY_IN_FREQ.
# bPrim --> 2 = Secondary; 1 = Primary.
proc get_inclk_in_MHz { bPrim } {
   variable IN_FREQ_UNITS
   variable PRIM_IN_FREQ

   if { [get_param_value IN_FREQ_UNITS ] == "Units_ns" } {
      set infreq [convert_ns_to_MHz [get_param_value PRIM_IN_FREQ ]]
   } else {
      set infreq [get_param_value PRIM_IN_FREQ ]
   }
   return $infreq
}

#################################################################
# Returns the given MHz value as ns.
proc convert_MHz_to_ns { MHzValue } {
   # 1 MHz = 1000/ns
   if { $MHzValue != 0 } {
      #return [expr  int(round(1000000.0 / $MHzValue)) / 1000.0]
      return [expr  int(10000000.0 / $MHzValue) / 10000.0]
   }
   return 0.0
}

#################################################################
# Returns the given KHz value as ns.
proc convert_KHz_to_ns { KHzValue } {
   # 1 KHz = 1000000/ns
   if { $KHzValue != 0 } {
      set ss_period_fval [expr  1000000 / $KHzValue]
      set ss_period_ival [expr {int($ss_period_fval + 0.5)}]
      return $ss_period_ival
   }
   return 0
}
#################################################################

# Returns the given KHz value as ms  
proc convert_KHz_to_ms { KHzValue } {
   if { $KHzValue != 0 } {
      return [format "%3.3f" [expr  1.000 / $KHzValue] ]
   }
   return 0.0
}

#################################################################
# Returns the inclk jitter in ps units, based on the current value of IN_JITTER_UNITS.
# Does not change the Prim/SECONDARY_IN_JITTER.
# If the inclk jitter is already in ps (from IN_JITTER_UNITS), that value is returned.
# bPrim   --  2 = Secondary; 1 = Primary
proc get_ps_jitter { bPrim } {
   variable PRIM_IN_JITTER
   variable IN_JITTER_UNITS
   variable SECONDARY_IN_JITTER

   set injitter [get_param_value SECONDARY_IN_JITTER ]
   if { $bPrim == 1 } {
      set injitter [get_param_value PRIM_IN_JITTER ]
   }
   if { [get_param_value IN_JITTER_UNITS ] == "Units_UI" } {
      # Value entered is in UI, so must convert injitter to ps.
      set injitter [convert_UI_to_ps_for_inclk $injitter $bPrim]
   }
   return $injitter
}

#################################################################
# Returns the inclk jitter in UI units, based on the current value of IN_JITTER_UNITS.
# Does not change the Prim/SECONDARY_IN_JITTER.
# If the inclk jitter is already in UI (from IN_JITTER_UNITS), that value is returned.
# bPrim   --  2 = Secondary; 1 = Primary
proc get_UI_jitter { injitter } {

   variable PRIM_IN_JITTER
   variable IN_JITTER_UNITS
   variable SECONDARY_IN_JITTER

   set injitter [get_param_value SECONDARY_IN_JITTER ]
   if { $bPrim == 1 } {
      set injitter [get_param_value PRIM_IN_JITTER ]
   }
   if { [get_param_value IN_JITTER_UNITS ] == "Units_ps" } {
      # Value entered is in ps, so must convert injitter to UI.
      set injitter [convert_ps_to_UI_for_inclk $injitter $bPrim]
   }
   return $injitter
}

#################################################################
# Returns the given psValue as UI.
proc convert_ps_to_UI { psValue inclkPeriod } {
  # UIvalue = psValue / (inclkPeriod(ns) * 1000)
   if { $psValue != 0.0 } {
     return [expr  $psValue / (1000.0 * $inclkPeriod) ]
   }
   return 0.0
}

#################################################################
# Returns the given psValue as UI.
# psValue   --   ps value to convert.
# bPrim     --   1 = Primary input clock, 2 = Secondary
proc convert_ps_to_UI_for_inclk { psValue infreq } {

   # First get input freq in ns
   set inPeriod [convert_MHz_to_ns $infreq ]
   #CR # 541914 Rounding error
   set adjPeriod [ Adjust_Clkin_Period $inPeriod $infreq]
   set inPeriod $adjPeriod
   #CR # 541914 Rounding error
   return [convert_ps_to_UI $psValue $inPeriod ]
}

#################################################################
# Returns the given UIvalue as ps.
# UIvalue       --   UI value to convert
# inclkPeriod   --   the input clock period (ns)
proc convert_UI_to_ps { UIvalue inclkPeriod } {

   # ps = UIvalue * inclkPeriod(ns) * 1000
   return [expr  $UIvalue * $inclkPeriod * 1000.000 ]
}

#################################################################
# Returns the given UIvalue as ps.
# UIvalue   --   UI value to convert.
# bPrim     --   1 = Primary input clock, 2 = Secondary
proc convert_UI_to_ps_for_inclk { UIvalue infreq } {

   # First get input freq in ns
   set inperiod [get_inclk_period $infreq] 
   return [convert_UI_to_ps $UIvalue $inperiod ]
}

#################################################################
# Formats the second input clock period (ns) valid range error message. 
proc get_inperiod2_valid_range_err_msg { } {
   variable c_min_2nd_in_freq
   variable c_max_2nd_in_freq

   set min_in2 [setup_display_float [convert_MHz_to_ns $c_min_2nd_in_freq]]
   set max_in2 [setup_display_float [convert_MHz_to_ns $c_max_2nd_in_freq]]
   set errMsg "Valid range is [$min_in2.. $max_in2] ns"
   return $errMsg
}

#################################################################
# Formats the first input clock period (ns) valid range error message. 
proc get_inperiod1_valid_range_err_msg { } {
   variable c_min_in_freq
   variable c_max_in_freq

   set min_in1 [setup_display_float [convert_MHz_to_ns $c_min_in_freq]]
   set max_inperiod2 [setup_display_float [convert_MHz_to_ns $c_max_2nd_in_freq]]
   set errMsg "Valid range is [$min_in1.. $max_in1] ns"
   return $errMsg
}

#################################################################
# NOTE: this function is not being used!!! (since MHz/ns switch is not used!).
# NOTE: c_max_out_freq and c_min_in_freq hold the normal range, but some 
# Clkout#_Requested_Out_Freqs have special values set for their min/max values, so those 
# variables can't be used universally.  You need to check the widget's GetMinValue/GetMaxValue.

# Formats the output freq valid range error message, using the IN_FREQ_UNITS
# units in the message.
proc get_outfreq_valid_range_err_msg { } {
   variable c_min_out_freq
   variable c_max_out_freq

   set min_out $c_min_out_freq
   set max_out $c_max_out_freq
   set errMsg "Valid range is [$min_out.. $max_out] MHz"
   return $errMsg
}

#################################################################
# Checks that the current SECONDARY_IN_FREQ is within the valid 2nd input frequency range.
# Assumes the given value's units are same as IN_FREQ_UNITS.
# Returns true if within range; else false.
proc check_2nd_infreq { second_infreq } {
   return [within_2nd_infreq_range $second_infreq ]
}

#################################################################
# Checks that the current PRIM_IN_FREQ is within the valid PRIMITIVE input frequency range.
# Assumes the given value's units are same as IN_FREQ_UNITS.
# Returns true if within range; else false.
proc check_prim_infreq { infreq } {
   return [within_prim_infreq_range $infreq ]
}

#################################################################
# Verifies the given freq is within the valid PRIMITIVE input frequency range.
# Assumes the value given is in MHz.
# If Spread Spectrum, it must be one of the possible: 24, 75, or 90 MHz.
# Returns true if within range; else false.
proc within_prim_infreq_range { infreq } {
   variable c_min_in_freq
   variable c_max_in_freq

   if { ($infreq < $c_min_in_freq) || ($infreq > $c_max_in_freq) } {
      return false 
   }
   return true
}

#################################################################
# Verifies the given freq is within the valid secondary input frequency range.
# Assumes the value given is in MHz.
# Returns true if within range; else false.
proc within_2nd_infreq_range { second_infreq } {
   variable c_min_2nd_in_freq
   variable c_max_2nd_in_freq

   # Check against the min and max (which are stored in MHz).
   if { ( $second_infreq < [format "%.3f" $c_min_2nd_in_freq]) || ($second_infreq > [format "%.3f" $c_max_2nd_in_freq]) } {
      return false 
   }
   return true
}

#################################################################
# Verifies the input jitter is within the valid range.
# Returns true if within range; else false.
proc verify_injitter { injitter } {
   variable c_min_in_jitter
   variable c_max_in_jitter

   if { ($injitter < $c_min_in_jitter) || ($injitter > $c_max_in_jitter) } {
      return false 
   }   
   return true
}

#################################################################
# Returns a string to display, with 4.3 format (3 decimal points).
# First checks if the value is a red XXX; if so, doesn't change anything.
proc setup_display_float { value } {

   #if { $value != "<font color=red>XXX</font>" } 
   if { $value != "XXX" } {
      set rtn [format "%4.3f" $value]
   } else {
      set rtn $value
   }
   return $rtn
}
proc setup_display_float_freq { value } {

   #if { $value != "<font color=red>XXX</font>" } 
   if { $value != "XXX" } {
      set rtn [format "%4.5f" $value]
   } else {
      set rtn $value
   }
   return $rtn
}

proc setup_display_float_duty_cycle { value } {

   #if { $value != "<font color=red>XXX</font>" } 
   if { $value != "XXX" } {
      set rtn [format "%3.1f" $value]
   } else {
      set rtn $value
   }
   return $rtn
}

#################################################################
# If the given string is the formated (red color) XXX, it converts it to just "XXX".
# Else makes sure the value is ----.--- format.
proc convertXXX { value } {

   set rtn $value
   #if { $value == "<font color=red>XXX</font>" } 
   if { $value == "XXX" } {
      set rtn "XXX"
   }
   return $rtn
}

#################################################################
# Returns the given str1 so that it has the specified width.
# If str1 is already wider than the given width, does nothing.
proc format_str { str1 width } {

   set rtn $str1
   set str1len [string length $str1]
   if { $str1len < $width } {
      set numSpacesToAdd [expr $width - $str1len]
      for { set ctr 0 } { $ctr < $numSpacesToAdd } { incr ctr } {
         append prepend1 "_" 
      }
      set rtn [format "%s%s" $prepend1 $str1]
   }
   return $rtn
}

#################################################################
# Sets the Actual values (as shown on page 2) in the c_clkout#_* params.
proc setup_actual_strings {} {
   variable C_CLKOUT1_OUT_FREQ
   variable C_CLKOUT1_PHASE
   variable C_CLKOUT1_DUTY_CYCLE
   variable C_CLKOUT2_OUT_FREQ
   variable C_CLKOUT2_PHASE
   variable C_CLKOUT2_DUTY_CYCLE
   variable C_CLKOUT3_OUT_FREQ
   variable C_CLKOUT3_PHASE
   variable C_CLKOUT3_DUTY_CYCLE
   variable C_CLKOUT4_OUT_FREQ
   variable C_CLKOUT4_PHASE
   variable C_CLKOUT4_DUTY_CYCLE
   variable C_CLKOUT5_OUT_FREQ
   variable C_CLKOUT5_PHASE
   variable C_CLKOUT5_DUTY_CYCLE
   variable C_CLKOUT6_OUT_FREQ
   variable C_CLKOUT6_PHASE
   variable C_CLKOUT6_DUTY_CYCLE
   variable C_CLKOUT7_OUT_FREQ
   variable C_CLKOUT7_PHASE
   variable C_CLKOUT7_DUTY_CYCLE
   variable CLKOUT1_ACTUAL_OUT_FREQ
   variable CLKOUT1_ACTUAL_PHASE
   variable CLKOUT1_ACTUAL_DUTY_CYCLE
   variable CLKOUT2_ACTUAL_OUT_FREQ
   variable CLKOUT2_ACTUAL_PHASE
   variable CLKOUT2_ACTUAL_DUTY_CYCLE
   variable CLKOUT3_ACTUAL_OUT_FREQ
   variable CLKOUT3_ACTUAL_PHASE
   variable CLKOUT3_ACTUAL_DUTY_CYCLE
   variable CLKOUT4_ACTUAL_OUT_FREQ
   variable CLKOUT4_ACTUAL_PHASE
   variable CLKOUT4_ACTUAL_DUTY_CYCLE
   variable CLKOUT5_ACTUAL_OUT_FREQ
   variable CLKOUT5_ACTUAL_PHASE
   variable CLKOUT5_ACTUAL_DUTY_CYCLE
   variable CLKOUT6_ACTUAL_OUT_FREQ
   variable CLKOUT6_ACTUAL_PHASE
   variable CLKOUT6_ACTUAL_DUTY_CYCLE
   variable CLKOUT7_ACTUAL_OUT_FREQ
   variable CLKOUT7_ACTUAL_PHASE
   variable CLKOUT7_ACTUAL_DUTY_CYCLE

   set C_CLKOUT1_OUT_FREQ [convertXXX [$CLKOUT1_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT1_PHASE [convertXXX [$CLKOUT1_ACTUAL_PHASE GetText]]
   set C_CLKOUT1_DUTY_CYCLE [convertXXX [$CLKOUT1_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT2_OUT_FREQ [convertXXX [$CLKOUT2_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT2_PHASE [convertXXX [$CLKOUT2_ACTUAL_PHASE GetText]]
   set C_CLKOUT2_DUTY_CYCLE [convertXXX [$CLKOUT2_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT3_OUT_FREQ [convertXXX [$CLKOUT3_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT3_PHASE [convertXXX [$CLKOUT3_ACTUAL_PHASE GetText]]
   set C_CLKOUT3_DUTY_CYCLE [convertXXX [$CLKOUT3_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT4_OUT_FREQ [convertXXX [$CLKOUT4_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT4_PHASE [convertXXX [$CLKOUT4_ACTUAL_PHASE GetText]]
   set C_CLKOUT4_DUTY_CYCLE [convertXXX [$CLKOUT4_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT5_OUT_FREQ [convertXXX [$CLKOUT5_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT5_PHASE [convertXXX [$CLKOUT5_ACTUAL_PHASE GetText]]
   set C_CLKOUT5_DUTY_CYCLE [convertXXX [$CLKOUT5_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT6_OUT_FREQ [convertXXX [$CLKOUT6_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT6_PHASE [convertXXX [$CLKOUT6_ACTUAL_PHASE GetText]]
   set C_CLKOUT6_DUTY_CYCLE [convertXXX [$CLKOUT6_ACTUAL_DUTY_CYCLE GetText]]
   set C_CLKOUT7_OUT_FREQ [convertXXX [$CLKOUT7_ACTUAL_OUT_FREQ GetText]]
   set C_CLKOUT7_PHASE [convertXXX [$CLKOUT7_ACTUAL_PHASE GetText]]
   set C_CLKOUT7_DUTY_CYCLE [convertXXX [$CLKOUT7_ACTUAL_DUTY_CYCLE GetText]]
}

#################################################################
# Setup summary strings, used in generated files.
proc setup_summary_strings {} {

   variable PRIM_IN_FREQ
   variable SECONDARY_IN_FREQ
   variable CLK_OUT1_PORT
   variable CLK_OUT2_PORT
   variable CLK_OUT3_PORT
   variable CLK_OUT4_PORT
   variable CLK_OUT5_PORT
   variable CLK_OUT6_PORT
   variable CLK_OUT7_PORT
   variable PRIM_IN_JITTER
   variable IN_FREQ_UNITS
   variable SECONDARY_IN_JITTER
   variable Label_Inclk_Sum_Freq_Header
   variable Label_Inclk_Sum_Jitter_Header
   variable C_INCLK_SUM_ROW0
   variable C_INCLK_SUM_ROW1
   variable C_INCLK_SUM_ROW2
   variable c_using_2_inclks
   variable Outclk_Sum_Clkout1_Phase
   variable Outclk_Sum_Clkout2_Phase
   variable Outclk_Sum_Clkout3_Phase
   variable Outclk_Sum_Clkout4_Phase
   variable Outclk_Sum_Clkout5_Phase
   variable Outclk_Sum_Clkout6_Phase
   variable Outclk_Sum_Clkout7_Phase
   variable Outclk_Sum_Clkout1_Duty_Cycle
   variable Outclk_Sum_Clkout2_Duty_Cycle
   variable Outclk_Sum_Clkout3_Duty_Cycle
   variable Outclk_Sum_Clkout4_Duty_Cycle
   variable Outclk_Sum_Clkout5_Duty_Cycle
   variable Outclk_Sum_Clkout6_Duty_Cycle
   variable Outclk_Sum_Clkout7_Duty_Cycle
   variable Outclk_Sum_Clkout1_Name
   variable Outclk_Sum_Clkout1_Out_Freq
   variable Outclk_Sum_Clkout2_Out_Freq
   variable Outclk_Sum_Clkout3_Out_Freq
   variable Outclk_Sum_Clkout4_Out_Freq
   variable Outclk_Sum_Clkout5_Out_Freq
   variable Outclk_Sum_Clkout6_Out_Freq
   variable Outclk_Sum_Clkout7_Out_Freq
   variable c_num_oclks
   variable Outclk_Sum_Clkout1_Pktopk_Jitter
   variable Outclk_Sum_Clkout1_Phase_Error
   variable Outclk_Sum_Clkout2_Pktopk_Jitter
   variable Outclk_Sum_Clkout2_Phase_Error
   variable Outclk_Sum_Clkout3_Pktopk_Jitter
   variable Outclk_Sum_Clkout3_Phase_Error
   variable Outclk_Sum_Clkout4_Pktopk_Jitter
   variable Outclk_Sum_Clkout4_Phase_Error
   variable Outclk_Sum_Clkout5_Pktopk_Jitter
   variable Outclk_Sum_Clkout5_Phase_Error
   variable Outclk_Sum_Clkout6_Pktopk_Jitter
   variable Outclk_Sum_Clkout6_Phase_Error
   variable Outclk_Sum_Clkout7_Pktopk_Jitter
   variable Outclk_Sum_Clkout7_Phase_Error
   variable C_OUTCLK_SUM_ROW0A
   variable C_OUTCLK_SUM_ROW0B
   variable C_OUTCLK_SUM_ROW1
   variable C_OUTCLK_SUM_ROW2
   variable C_OUTCLK_SUM_ROW3
   variable C_OUTCLK_SUM_ROW4
   variable C_OUTCLK_SUM_ROW5
   variable C_OUTCLK_SUM_ROW6
   variable C_OUTCLK_SUM_ROW7
  
   set bMhz true
   if { [get_param_value IN_FREQ_UNITS ] == "Units_ns" } {
      set bMhz false
   }
   # Input Clock Summary Table rows.
   set C_INCLK_SUM_ROW0 "Input Clock [format_str [$Label_Inclk_Sum_Freq_Header GetText] 18] [format_str [$Label_Inclk_Sum_Jitter_Header GetText] 19]"
   set C_INCLK_SUM_ROW1 "__primary________[format_str [get_param_value PRIM_IN_FREQ ] 8]___________[format_str [get_param_value PRIM_IN_JITTER ] 6]"
   if { $c_using_2_inclks == true } {
      set C_INCLK_SUM_ROW2 "_secondary______[format_str [get_param_value SECONDARY_IN_FREQ ] 8]___________[format_str [get_param_value SECONDARY_IN_JITTER ] 6]"
   } else {
      set C_INCLK_SUM_ROW2 "no_secondary_input_clock "
   }

   # Output Clock Summary Table rows.
   set C_OUTCLK_SUM_ROW0A " Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase"
   if { $bMhz == true } {
      set C_OUTCLK_SUM_ROW0B "  Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)"
   } else {
      set C_OUTCLK_SUM_ROW0B "  Clock   Period (ns) (degrees)    (%)     Jitter (ps)  Error (ps)"
   } 
  # set C_OUTCLK_SUM_ROW1 "__[format_str [convertXXX [$Outclk_Sum_Clkout1_Name GetText]] 8]__[format_str [convertXXX [$Outclk_Sum_Clkout1_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout1_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout1_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout1_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout1_Phase_Error GetText] 8]"
   set C_OUTCLK_SUM_ROW1 " output __[format_str [convertXXX [$Outclk_Sum_Clkout1_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout1_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout1_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout1_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout1_Phase_Error GetText] 8]"
   if { $c_num_oclks >= 2 } {
      set C_OUTCLK_SUM_ROW2 "[format_str [get_param_value CLK_OUT2_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout2_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout2_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout2_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout2_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout2_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW2 "no_CLK_OUT2_output"
   }
   if { $c_num_oclks >= 3 } {
      set C_OUTCLK_SUM_ROW3 "[format_str [get_param_value CLK_OUT3_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout3_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout3_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout3_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout3_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout3_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW3 "no_CLK_OUT3_output "
   }
   if { $c_num_oclks >= 4 } {
      set C_OUTCLK_SUM_ROW4 "[format_str [get_param_value CLK_OUT4_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout4_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout4_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout4_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout4_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout4_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW4 "no_CLK_OUT4_output"
   }
   if { $c_num_oclks >= 5 } {
      set C_OUTCLK_SUM_ROW5 "[format_str [get_param_value CLK_OUT5_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout5_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout5_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout5_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout5_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout5_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW5 "no_CLK_OUT5_output"
   }
   if { $c_num_oclks >= 6 } {
      set C_OUTCLK_SUM_ROW6 "[format_str [get_param_value CLK_OUT6_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout6_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout6_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout6_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout6_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout6_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW6 "no_CLK_OUT6_output"
   }
   if { $c_num_oclks >= 6 } {
      set C_OUTCLK_SUM_ROW7 "[format_str [get_param_value CLK_OUT7_PORT ] 16]__[format_str [convertXXX [$Outclk_Sum_Clkout7_Out_Freq GetText]] 8]____[format_str [convertXXX [$Outclk_Sum_Clkout7_Phase GetText]] 7]___[format_str [convertXXX [$Outclk_Sum_Clkout7_Duty_Cycle GetText]] 7]_____[format_str [$Outclk_Sum_Clkout7_Pktopk_Jitter GetText] 8]___[format_str [$Outclk_Sum_Clkout7_Phase_Error GetText] 8]"
   } else {
      set C_OUTCLK_SUM_ROW7 "no_CLK_OUT7_output "
   }
}

proc Adjust_Clkin_Period { inPeriod infreq } {

   set c_min_infreq   0
   set c_max_infreq 0
   set c_min_pfd_freq 0
   set c_max_pfd_freq 0

      set c_min_infreq [get_speedsfile_key_value "MMCM_CLKIN_FREQ_MIN" ]
      set c_max_infreq [get_speedsfile_key_value "MMCM_CLKIN_FREQ_MAX" ]
      set c_min_pfd_freq [get_speedsfile_key_value "MMCM_CLKPFD_FREQ_MIN" ]
      set c_max_pfd_freq [get_speedsfile_key_value "MMCM_CLKPFD_FREQ_MAX" ]
   set convertedFreq 0
   set adjPeriod 1 
   if { $inPeriod != 0 } {
      set convertedFreq [expr  1000.000 / $inPeriod]
   }
   set userfreq $infreq
   # if { $userfreq < $c_min_infreq || $userfreq < $c_min_pfd_freq } {
      # return $inPeriod
   # }

   # if { $userfreq > $c_max_infreq || $userfreq > $c_max_pfd_freq } {
      # return $inPeriod
   # }
   
   #Convert period back to frequency
   
   
   if { $convertedFreq < $c_min_infreq } {
      set adjPeriod [expr floor($inPeriod*1000.000) / 1000.000]
   } elseif { $convertedFreq > $c_max_infreq } {
      set adjPeriod [expr ceil($inPeriod*1000.000) / 1000.000]
   } elseif { $convertedFreq < $c_min_pfd_freq } {
      set adjPeriod [expr floor($inPeriod*1000.000) / 1000.000]
   } elseif { $convertedFreq > $c_max_pfd_freq} {
      set adjPeriod [expr ceil($inPeriod*1000.000) / 1000.000]
   } else { #floor by default
      set adjPeriod [expr floor($inPeriod*1000.000) / 1000.000]
   }
    if { $infreq == 574.518 } {
    }
   set adjFreq [expr  1000.000 / $adjPeriod]
   return $adjPeriod
}

}
