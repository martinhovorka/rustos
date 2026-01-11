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

set Mmcm_Override_used false
set last_Override_Mmcm false
set val false
variable Mmcm_Bandwidth_backup ""
variable Mmcm_Pll_frq_error false
variable Mmcm_Clkfbout_Mult_F_backup ""
variable Mmcm_Clkfbout_Phase_backup ""
variable Mmcm_Clkfbout_Use_Fine_Ps_backup ""
variable Mmcm_Clkin1_Period_backup ""
variable Mmcm_Clkin2_Period_backup ""
variable Mmcm_Clkout4_Cascade_backup ""
variable Mmcm_Clock_Hold_backup ""
variable Mmcm_Compensation_backup_pll "AUTO"
variable Mmcm_Compensation_backup_mmcm "AUTO"
variable Mmcm_Divclk_Divide_backup ""
variable Mmcm_Ref_Jitter1_backup ""
variable Mmcm_Ref_Jitter2_backup ""
variable Mmcm_Startup_Wait_backup ""
variable Mmcm_Clkout0_Divide_F_backup ""
variable Mmcm_Clkout0_Duty_Cycle_backup ""
variable Mmcm_Clkout0_Phase_backup ""
variable Mmcm_Clkout0_Use_Fine_Ps_backup ""
variable Mmcm_Clkout1_Divide_backup ""
variable Mmcm_Clkout1_Duty_Cycle_backup ""
variable Mmcm_Clkout1_Phase_backup ""
variable Mmcm_Clkout1_Use_Fine_Ps_backup ""
variable Mmcm_Clkout2_Divide_backup ""
variable Mmcm_Clkout2_Duty_Cycle_backup ""
variable Mmcm_Clkout2_Phase_backup ""
variable Mmcm_Clkout2_Use_Fine_Ps_backup ""
variable Mmcm_Clkout3_Divide_backup ""
variable Mmcm_Clkout3_Duty_Cycle_backup ""
variable Mmcm_Clkout3_Phase_backup ""
variable Mmcm_Clkout3_Use_Fine_Ps_backup ""
variable Mmcm_Clkout4_Divide_backup ""
variable Mmcm_Clkout4_Duty_Cycle_backup ""
variable Mmcm_Clkout4_Phase_backup ""
variable Mmcm_Clkout4_Use_Fine_Ps_backup ""
variable Mmcm_Clkout5_Divide_backup ""
variable Mmcm_Clkout5_Duty_Cycle_backup ""
variable Mmcm_Clkout5_Phase_backup ""
variable Mmcm_Clkout5_Use_Fine_Ps_backup ""
variable Mmcm_Clkout6_Divide_backup ""
variable Mmcm_Clkout6_Duty_Cycle_backup ""
variable Mmcm_Clkout6_Phase_backup ""
variable Mmcm_Clkout6_Use_Fine_Ps_backup ""

#################################################################
#
#   Validation Section
#
#################################################################

proc validate_MMCM_NOTES {IpView} {
   return TRUE
} ;# end validate_MMCM_NOTES

proc validate_OVERRIDE_MMCM {IpView} {
   return TRUE
} ;# end validate_OVERRIDE_MMCM

proc validate_MMCM_CLKIN1_PERIOD {IpView} {
   
   if { [get_param_value OVERRIDE_MMCM ] == true } {
      set infreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value MMCM_CLKIN1_PERIOD ]]
      if { [clk_wiz_v6_0_utils::within_prim_infreq_range $infreq] == false } {
         set errMsg clk_wiz_v6_0_utils::get_inperiod1_valid_range_err_msg
         set_property errmsg "$errMsg" [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
         return FALSE
      }
   }
   return TRUE
} ;# end validate_MMCM_CLKIN1_PERIOD

proc validate_MMCM_CLKIN2_PERIOD {IpView} {
   
   # Only validate 2nd inclk period if override is true and second inclk is used.
   if { [get_param_value OVERRIDE_MMCM ] == true && [get_param_value USE_INCLK_SWITCHOVER ] == true} {
      set infreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value MMCM_CLKIN2_PERIOD ]]
      if { [clk_wiz_v6_0_utils::within_2nd_infreq_range $infreq] == false } {
         set errMsg clk_wiz_v6_0_utils::get_inperiod2_valid_range_err_msg
         set_property errmsg "$errMsg" [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
         return FALSE
      }
   }
   return TRUE
} ;# end validate_MMCM_CLKIN2_PERIOD

proc validate_MMCM_BANDWIDTH {IpView} {
  return TRUE;
} ;# end validate_MMCM_BANDWIDTH

#################################################################
#
#   Update Section
#
#   These Tcl procedures are responsible for updating XCO
#   parameters and their associated state (e.g. enabled/disabled)
#   following an update in the front-end GUI.
#
#################################################################

proc CLKFBOUT_MULT_F_SetText {IpView} {
if { [get_param_value PRIMITIVE] == "Auto" } {
   set prim_val [get_param_value AUTO_PRIMITIVE ]
} else {
   set prim_val [get_param_value PRIMITIVE ]
}
   if { $prim_val == "PLL" } {
      set str "CLKFBOUT_MULT"
   } else {
      set str "CLKFBOUT_MULT_F"
   }
   return $str
}

proc CLKOUT0_DIVIDE_F_SetText {IpView} {
if { [get_param_value PRIMITIVE] == "Auto" } {
   set prim_val [get_param_value AUTO_PRIMITIVE ]
} else {
   set prim_val [get_param_value PRIMITIVE ]
}
   if { $prim_val == "PLL" } {
      set str "CLKOUT0_DIVIDE"
   } else {
      set str "CLKOUT0_DIVIDE_F"
   }
   return $str
}

proc Label_Mmcm_Override_Warning_SetText {IpView} {
   set str ""
   if { [get_param_value OVERRIDE_MMCM] == true } {
      set str [mmcm_pll_override_freq_check $IpView]
   }
   # There is some issue with xspice so using some extra string Warning
   return "$str"
}

proc Label_mmcm_rename_clk_out1 {IpView} {
      set str [get_param_value CLK_OUT1_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out2 {IpView} {
      set str [get_param_value CLK_OUT2_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out3 {IpView} {
      set str [get_param_value CLK_OUT3_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out4 {IpView} {
      set str [get_param_value CLK_OUT4_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out5 {IpView} {
      set str [get_param_value CLK_OUT5_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out6 {IpView} {
      set str [get_param_value CLK_OUT6_PORT ]
   return $str
}

proc Label_mmcm_rename_clk_out7 {IpView} {
      set str [get_param_value CLK_OUT7_PORT ]
   return $str
}

proc Label_mmcm_connect_clk_out2 {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
   set str ""
 if {[get_param_value PRIMITIVE] == "MMCM" }  { 
    if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS])}  { 
       set str CLKOUT1
    } else  {
       set str CLKOUT0B
    } 
 } else  {
     if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) || ([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1)}  { 
       set str CLKOUT1
    } else  {
       set str CLKOUT0B
    } 
    } 
   return "$str"
}

proc Label_mmcm_connect_clk_out3 {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
   set str ""
 if {[get_param_value PRIMITIVE] == "MMCM" }  { 
   if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set str CLKOUT1B
    } else  {
       set str CLKOUT2
    } 
 } else  {
   if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set str CLKOUT1B
    } else  {
       set str CLKOUT2
    } 
 }
   return "$str"
}

proc Label_mmcm_connect_clk_out4 {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
   set str ""
if {!([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT3_DIVIDE ] == [get_param_value MMCM_CLKOUT2_DIVIDE] && ([get_param_value MMCM_CLKOUT3_PHASE] - [get_param_value MMCM_CLKOUT2_PHASE]) == 180 && [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT3_USE_FINE_PS] == [get_param_value MMCM_CLKOUT2_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set str CLKOUT2B
    } else  {
       set str CLKOUT3
    } 
   return "$str"
}

proc Label_mmcm_connect_clk_out5 {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
   set str ""
if {!([get_param_value MMCM_CLKOUT3_DIVIDE ] == [get_param_value MMCM_CLKOUT2_DIVIDE] && ([get_param_value MMCM_CLKOUT3_PHASE] - [get_param_value MMCM_CLKOUT2_PHASE]) == 180 && [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT3_USE_FINE_PS] == [get_param_value MMCM_CLKOUT2_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT4_DIVIDE ] == [get_param_value MMCM_CLKOUT3_DIVIDE] && ([get_param_value MMCM_CLKOUT4_PHASE] - [get_param_value MMCM_CLKOUT3_PHASE]) == 180 && [get_param_value MMCM_CLKOUT4_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT4_USE_FINE_PS] == [get_param_value MMCM_CLKOUT3_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set str CLKOUT3B
    } else  {
       set str CLKOUT4 
    } 
   return "$str"
}



######################################
# MMCM and PLL: Checks if the override values result in a valid VCO and PFD freqs.
# If not, a warning is displayed on the override page.
# Assumes this is for MMCM or PLL and override is true.
proc mmcm_pll_override_freq_check {IpView} {

   variable clk_wiz_v6_0_utils::c_min_vco_freq
   variable clk_wiz_v6_0_utils::c_max_vco_freq
   variable clk_wiz_v6_0_utils::c_min_pfd_freq
   variable clk_wiz_v6_0_utils::c_max_pfd_freq
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::c_vco_freq
   

   set adjMinVco $c_min_vco_freq
   set adjMaxVco $c_max_vco_freq
   set mValue [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set dValue [get_param_value MMCM_DIVCLK_DIVIDE ]
   set clkin1  [get_param_value PRIM_IN_FREQ ]
   set clkperiod [ expr 1000.0 / $clkin1 ]
   set period_val [setup_display_float_freq $clkperiod ]

  # if { $c_using_2_inclks == true } {
  #    set clkin2 [get_param_value SECONDARY_IN_FREQ ]

  #    # If 2 input clocks are used, get adjusted min/max for VCO.
  #    if { $clkin1 > $clkin2 } {
  #       set factor1 [expr $clkin1 / $clkin2 ]
  #       set adjMinVco [expr $c_min_vco_freq * $factor1 ]
  #    } else {
  #       set factor1 [expr $clkin2 / $clkin1 ]
  #       set adjMaxVco [expr $c_max_vco_freq / $factor1 ]
  #    }
  # }

   # Now calculate the VCO freq. The value must be within the adjMin/MaxVco freq.
   # VCO = (M * clkin1) / D
   set vcoErr false
   set vco_full [expr (1.0 * $clkin1 * $mValue / ( $dValue)) ]
   set vco [setup_display_float_freq $vco_full ]
   #set vco $c_vco_freq
   if { $vco < $adjMinVco || $vco > $adjMaxVco } {
      set vcoErr true
   }

   # Now calculate the PFD freq. The value must be within the c_min/max_pfd_freq.
   # PFD =  clkin1 / D
   set pfdErr false
   set pfd [expr (1.0 * $clkin1 / $dValue )]
   if { $pfd < $c_min_pfd_freq || $pfd > $c_max_pfd_freq } {
      set pfdErr true
   }

   set msg ""
   if { $vcoErr == true && $pfdErr == false } {
      set msg "<font color=red>The CLKFBOUT_MULT_F and DIVCLK_DIVIDE values result in an invalid VCO freq. </font>"
   } elseif { $vcoErr == true && $pfdErr == true } {
      set msg "<font color=red>The CLKFBOUT_MULT_F and DIVCLK_DIVIDE values result in invalid VCO and PFD freqs.</font>"
   } elseif { $vcoErr == false && $pfdErr == true } {
      set msg "<font color=red>The DIVCLK_DIVIDE value results in an invalid PFD freq.</font>"
   }
   if { $vcoErr == true || $pfdErr == true} {
      return $msg
   } else {
      return ""
   }
}

proc mmcm_pll_vco_freq_check {IpView} {
  # variable Mmcm_Pll_frq_error false
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]


  # set primitive 
  
   variable clk_wiz_v6_0_utils::c_min_vco_freq
   variable clk_wiz_v6_0_utils::c_max_vco_freq
   variable clk_wiz_v6_0_utils::c_min_pfd_freq
   variable clk_wiz_v6_0_utils::c_max_pfd_freq
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::c_vco_freq

   set adjMinVco $c_min_vco_freq
   set adjMaxVco $c_max_vco_freq
   set adjMinPfd $c_min_pfd_freq
   set adjMaxPfd $c_max_pfd_freq
   set mValue [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set dValue [get_param_value MMCM_DIVCLK_DIVIDE ]
   set clkin1 [get_param_value PRIM_IN_FREQ ]
   set clkperiod [ expr 1000.0 / $clkin1 ]
   set period_val [setup_display_float_freq $clkperiod ]
   #if { $c_using_2_inclks == true } {
   #   set clkin2 [get_param_value SECONDARY_IN_FREQ]

   #   # If 2 input clocks are used, get adjusted min/max for VCO.
   #   if { $clkin1 > $clkin2 } {
   #      set factor1 [expr $clkin1 / $clkin2 ]
   #      set adjMinVco [expr $c_min_vco_freq * $factor1 ]
   #   } else {
   #      set factor1 [expr $clkin2 / $clkin1 ]
   #      set adjMaxVco [expr $c_max_vco_freq / $factor1 ]
   #   }
   #}

   # Now calculate the VCO freq. The value must be within the adjMin/MaxVco freq.
   # VCO = (M * clkin1) / D
   set vcoErr false
   set vco_full [expr (1.0 * $clkin1 * $mValue / ( $dValue)) ]
   set vco [setup_display_float_freq $vco_full ]
   #set vco $c_vco_freq
   if { $vco < $adjMinVco || $vco > $adjMaxVco } {
      set vcoErr true
   }
   set pfdErr1 false
   set pfdErr2 false
   set pfd_p [expr (1.0 * $clkin1 / $dValue )]
   set pfd_p_freq [setup_display_float_freq $pfd_p ]
   if { $c_using_2_inclks == true } {
   set clkin2 [get_param_value SECONDARY_IN_FREQ ]
   set pfd_s [expr (1.0 * $clkin2 / $dValue )]
   set pfd_s_freq [setup_display_float_freq $pfd_s ]
   }
   if { $pfd_p < $adjMinPfd || $pfd_p > $adjMaxPfd } {
      set pfdErr1 true
   } elseif { ($c_using_2_inclks == true) && ($pfd_s < $adjMinPfd || $pfd_s > $adjMaxPfd) } {
      set pfdErr2 true
   }

   set msg ""
   set msg1 ""
   set msg2 ""
  # send_msg INFO 11 "reddy $vco $adjMinVco $adjMaxVco $vcoErr $pfdErr $mValue $clkin1 $dValue "
   if { $vcoErr == true } {
      if { [get_param_value OVERRIDE_MMCM ] == false } {
         set msg "<font color=red>The CLKFBOUT_MULT_F and DIVCLK_DIVIDE values result in an invalid VCO freq $vco MHz. \n Valid VCO range is [$adjMinVco:$adjMaxVco]. \n Toggle and Untoggle any option on this page to get valid values for CLKFBOUT_MULT_F and DIVCLK_DIVIDE and VCO </font>"
      } else {
         set msg "<font color=red>The CLKFBOUT_MULT_F and DIVCLK_DIVIDE values result in an invalid VCO freq $vco MHz. \n Valid VCO range is [$adjMinVco:$adjMaxVco]. \n unselect override mode to get valid values for CLKFBOUT_MULT_F and DIVCLK_DIVIDE and VCO </font>"
      } 
   } 
   if { $pfdErr1 == true } {
      if { [get_param_value OVERRIDE_MMCM ] == false } {
         set msg1 "<font color=red> The Computed PFD value w.r.t Primary clock resulting in an invalid PFD freq $pfd_p_freq MHz. \n Valid PFD range is [$adjMinVco:$adjMaxVco]. \n Please adjust either the input frequency or DIVCLK_DIVIDE in order to achieve a PFD frequency within the rated operating range for this device </font>"
      } else {
         set msg1 "<font color=red> The Computed PFD value w.r.t Primary clock resulting in an invalid PFD freq $pfd_p_freq MHz. \n Valid PFD range is [$adjMinVco:$adjMaxVco]. \n Please unselect override mode to get valid values for CLKFBOUT_MULT_F, DIVCLK_DIVIDE and PFD </font>"
      } 
   } 
   if { $pfdErr2 == true } {
      if { [get_param_value OVERRIDE_MMCM ] == false } {
         set msg2 "<font color=red> The Computed PFD value w.r.t Secondary clock resulting in an invalid PFD freq $pfd_s_freq MHz. \n Valid PFD range is [$adjMinVco:$adjMaxVco]. \n Please adjust either the input frequency or DIVCLK_DIVIDE in order to achieve a PFD frequency within the rated operating range for this device </font>"
      } else {
         set msg2 "<font color=red> The Computed PFD value w.r.t Secondary clock resulting in an invalid PFD freq $pfd_s_freq MHz. \n Valid PFD range is [$adjMinVco:$adjMaxVco]. \n Please unselect override mode to get valid values for CLKFBOUT_MULT_F, DIVCLK_DIVIDE and PFD </font>"
      } 
   } 
   
   if { $vcoErr == true } {
      return $msg
   } elseif { $pfdErr1 == true } {
      return $msg1
   } elseif { $pfdErr2 == true } {
      return $msg2
   } else {
      return ""
   }
}


proc OVERRIDE_MMCM_updated {IpView} {
   common_OverrideMmcm_JitterSel_SS $IpView
   update_Mmcm_Compensation $IpView
   # Whenever PRIM_IN_FREQ or override changes, if MMCM is being used: set 
   # MMCM_CLKIN1_PERIOD to its value.
   # Whenever SECONDARY_IN_FREQ or override changes, if MMCM is being used: set 
   # MMCM_CLKIN2_PERIOD to its value.
   set infreq1 [get_param_value PRIM_IN_FREQ]
   set infreq2 [get_param_value SECONDARY_IN_FREQ]
   if { [get_param_value OVERRIDE_MMCM ] == false } {
     #set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq1]
     #set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
     #set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq2]
     #set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
   # Whenever PRIM_IN_JITTER or override changes, set Ref_Jitter1 to its value.
      if { [get_param_value JITTER_OPTIONS] == "PS" } {
         set psjitter [get_param_value CLKIN1_UI_JITTER]
         set jit [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psjitter [get_param_value PRIM_IN_FREQ] ]
         set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] [ipgui::get_paramspec MMCM_REF_JITTER1 -of $IpView]
         set psjitter [get_param_value CLKIN2_UI_JITTER]
         set jit [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psjitter [get_param_value SECONDARY_IN_FREQ] ]
         set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] [ipgui::get_paramspec MMCM_REF_JITTER2 -of $IpView]
      } else {
         set jit [get_param_value CLKIN1_UI_JITTER]
         set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] [ipgui::get_paramspec MMCM_REF_JITTER1 -of $IpView]
         set jit [get_param_value CLKIN2_UI_JITTER]
         set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] [ipgui::get_paramspec MMCM_REF_JITTER2 -of $IpView]
      }
   }
   mmcm_do_override $IpView
   config_prim_freq_gui_option $IpView
   config_sec_freq_gui_option  $IpView
}

proc common_OverrideMmcm_JitterSel_SS {IpView} {

   if { [get_param_value OVERRIDE_MMCM ] == false } {
      if { [get_param_value USE_SPREAD_SPECTRUM] == false } {
         if { [get_param_value JITTER_SEL ] == "Min_O_Jitter" } {
            set_property value "HIGH" [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
         } elseif { [get_param_value JITTER_SEL ] == "Max_I_Jitter" } {
            set_property value "LOW" [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
         } else {
            set_property value "OPTIMIZED" [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
         }
      } else {
         set_property value "LOW" [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
      }
   }
}

proc update_Mmcm_Compensation {IpView} {
#   variable devicefamily
#   set devicetype  [getDeviceType $devicefamily]
#     if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2) } {
#        if { [get_param_value OVERRIDE_MMCM ] == false } {
#           set_property value "AUTO" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
#        } 
#      } else {
#        if { [get_param_value OVERRIDE_MMCM ] == false } {
#           set_property value "ZHOLD" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
#        } 
#      }
}

proc common_all_update_calc_done {IpView} {
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
    if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim [get_param_value AUTO_PRIMITIVE ]
    } else {
       set prim [get_param_value PRIMITIVE ]
    }
      # determine_auto_primitive $IpView
      # set infreq [get_param_value PRIM_IN_FREQ ]
      # check_freq_rev_vco $IpView $infreq 1
      # set infreq [get_param_value SECONDARY_IN_FREQ ]
      # check_freq_rev_vco $IpView $infreq 2
      set Mvalue [  GetClkwizProperty $PartName $ComponentName ChosenM ]
      set Dvalue [  GetClkwizProperty $PartName $ComponentName ChosenD ]
      set div0 [  GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
      if { $prim == "PLL" } {
         set_property value [expr {int($Mvalue)}] [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
         set_property value [expr {int($div0)}] [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
         if {$devicetype == 2 } {
            #set_property range "1,15" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
         } else {
            #set_property range "1,56" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
         }
      } else {
         set_property value $Mvalue [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
         set_property value $div0 [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
         #set_property range "1,106" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
      }
      set_property value $Dvalue [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 1 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 2 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT2_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 3 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT3_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 4 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT4_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 5 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT5_DIVIDE -of $IpView]
      set divN [  GetClkwizProperty $PartName $ComponentName ChosenDivN 6 ]
      set_property value $divN [ipgui::get_paramspec MMCM_CLKOUT6_DIVIDE -of $IpView]
      set infreq [get_param_value PRIM_IN_FREQ ]
      check_freq_rev_vco $IpView $infreq 1
      set infreq [get_param_value SECONDARY_IN_FREQ ]
      check_freq_rev_vco $IpView $infreq 2
      utils_calc_done $IpView
      calculate_jitter_and_phase_error_user_query $IpView
}

proc utils_calc_done {IpView} {
   variable clk_wiz_v6_0_utils::c_debug_phase
   variable clk_wiz_v6_0_utils::c_debug_duty_cycle
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT4_Actual_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT5_Actual_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT6_Actual_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT7_Actual_PHASE

   for { set i 0 } { $i < $c_num_oclks } { incr i } {
       set j [expr $i + 1]
       if { $i == 0 } {
          set div [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
       } else {
          set div [get_param_value MMCM_CLKOUT${i}_DIVIDE ]
       }
       if { [get_param_value USE_MIN_POWER ] == true } {
          set reqPhase [get_param_value CLKOUT${j}_REQUESTED_PHASE ]
          set reqDutyCycle [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE ]
          set actDutyCycle [  MMCMCalculateActualDutyCycle $PartName $ComponentName $reqDutyCycle $div $c_debug_duty_cycle]
          set_property value [expr $actDutyCycle / 100 ] [ipgui::get_paramspec MMCM_CLKOUT${i}_DUTY_CYCLE -of $IpView]
          set actPhase [  MMCMCalculateActualPhase $PartName $ComponentName $reqPhase $div $c_debug_phase]
          set_property value $actPhase [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView]
       } else {
          set phase [  GetClkwizProperty $PartName $ComponentName ChosenPhaseN $i ]
          set_property value $phase [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView]
          set dutyCycle [  GetClkwizProperty $PartName $ComponentName ChosenDutyCycleN $i ]
          set_property value $dutyCycle [ipgui::get_paramspec MMCM_CLKOUT${i}_DUTY_CYCLE -of $IpView]
       }
       set phase1 [get_param_value MMCM_CLKOUT${i}_PHASE ]
       set negPhase false
       if { ($div > 64) } {
          set MAX_PS  [expr {((63.0 / $div) * 360) + (7 * (45.0 / $div)) - (0.001)}]
          if { $phase1 < 0.0 } {
            set phase1 [expr ($phase1 + 360.0)]
            set negPhase true
          }
          if { ($phase1 > $MAX_PS) } {
             set phase1 $MAX_PS
          }
       }
       set val [expr ($phase1 * $div / 45.0)]
       set ival [expr {int($val)}]
       set diff [expr ($val - $ival)]
       if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
          set mulphase [expr {45.0*$ival/$div}]
          if { $negPhase == true } {
             set mulphase [expr ($mulphase - 360)]
          }
          set_property value [clk_wiz_v6_0_utils::setup_display_float $mulphase] [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView]
          set text_CLKOUT${j}_ACTUAL_PHASE [clk_wiz_v6_0_utils::setup_display_float $mulphase]
       }
    }
}

proc check_freq_rev_vco {IpView infreq bPrim} {
   variable clk_wiz_v6_0_utils::c_min_infreq
   variable clk_wiz_v6_0_utils::c_max_infreq
   variable clk_wiz_v6_0_utils::c_max_vco_freq
   variable clk_wiz_v6_0_utils::c_min_vco_freq
   variable clk_wiz_v6_0_utils::c_min_pfd_freq
   variable clk_wiz_v6_0_utils::c_max_pfd_freq
   set divide [get_param_value MMCM_DIVCLK_DIVIDE]
   set c_min_infreq [clk_wiz_v6_0_utils::get_speedsfile_key_value "MMCM_CLKIN_FREQ_MIN" ]
   set c_max_infreq [clk_wiz_v6_0_utils::get_speedsfile_key_value "MMCM_CLKIN_FREQ_MAX" ]
   set period1 [clk_wiz_v6_0_utils::convert_MHz_to_ns $infreq ]
   set period2 [clk_wiz_v6_0_utils::setup_display_float $period1]
   set freq [expr 1000 / $period2]
   set rev_vco [expr ( [get_param_value MMCM_CLKFBOUT_MULT_F ] * 1.0 * $infreq / ([get_param_value MMCM_DIVCLK_DIVIDE ]) ) ] 
   set rev_pfd [expr ( 1.0 * $infreq / ([get_param_value MMCM_DIVCLK_DIVIDE ] ) ) ] 
   if { $rev_vco < $c_max_vco_freq && $rev_vco > $c_min_vco_freq } {
      if { $rev_pfd > $c_max_pfd_freq } {
      set period [expr ceil($period1*1000.000) / 1000.000]
	  } elseif { $rev_pfd < $c_min_pfd_freq } {
      set period [expr floor($period1*1000.000) / 1000.000]
	  } else {
      set period $period2
	  }
	  
      if { $bPrim == 1 } {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
      } else {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
      }
   } elseif { $rev_vco < $c_min_vco_freq || $freq < $c_min_infreq } {
      set period [expr floor($period1*1000.000) / 1000.000]
      if { $bPrim == 1 } {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
      } else {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
      }
   } elseif { $rev_vco > $c_max_vco_freq || $freq > $c_max_infreq } {
      set period [expr ceil($period1*1000.000) / 1000.000]
      if { $bPrim == 1 } {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
      } else {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
      }
   } else {
      set period [expr floor($period1*1000.000) / 1000.000]
      if { $bPrim == 1 } {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
      } else {
         set_property value $period [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
      }
   }
} 
 

#################################################################
#
#   Translation Section
#
#################################################################

proc updateModel_C_MMCM_NOTES  {IpView} {

   set_property modelparam_value [get_param_value MMCM_NOTES] [ipgui::get_modelparamspec C_MMCM_NOTES -of $IpView] 

} ;# _Mmcm_Notes

proc updateModel_C_MMCM_NOTES {IpView} {
   set_property modelparam_value [get_param_value MMCM_NOTES] [ipgui::get_modelparamspec C_MMCM_NOTES -of $IpView]
}

proc updateModel_C_MMCM_BANDWIDTH  {IpView} {
   
   set_property modelparam_value [get_param_value MMCM_BANDWIDTH] [ipgui::get_modelparamspec C_MMCM_BANDWIDTH -of $IpView] 

} ;# _Mmcm_Bandwidth

proc updateModel_C_MMCM_CLKFBOUT_MULT_F  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKFBOUT_MULT_F]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKFBOUT_MULT_F -of $IpView] 

} ;# _Mmcm_Clkfbout_Mult_F

proc updateModel_C_MMCM_CLKFBOUT_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKFBOUT_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKFBOUT_PHASE -of $IpView] 

} ;# _Mmcm_Clkfbout_Phase

proc updateModel_C_MMCM_CLKFBOUT_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKFBOUT_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKFBOUT_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKFBOUT_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkfbout_Use_Fine_Ps

proc updateModel_C_MMCM_CLKIN1_PERIOD  {IpView} {
   # If not in override mode, set this value using PRIM_IN_FREQ
	# CR 573895
#   if { [clk_wiz_v6_0_utils::is_override_used] == true } {
      set value [get_param_value MMCM_CLKIN1_PERIOD]  
#   } else {
#      set value [clk_wiz_v6_0_utils::get_inclk_period 1 ]
#   }
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKIN1_PERIOD -of $IpView] 

} ;# _Mmcm_Clkin1_Period

proc updateModel_C_MMCM_CLKIN2_PERIOD  {IpView} {
   # If not in override mode, set this value using SECONDARY_IN_FREQ
	# CR 573895
#   if { [clk_wiz_v6_0_utils::is_override_used] == true } {
      set value [get_param_value MMCM_CLKIN2_PERIOD]  
#   } else {
#      set value [clk_wiz_v6_0_utils::get_inclk_period 2 ]
#   }
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKIN2_PERIOD -of $IpView] 

} ;# _Mmcm_Clkin2_Period

proc updateModel_C_MMCM_CLKOUT4_CASCADE  {IpView} {

   if {[get_param_value MMCM_CLKOUT4_CASCADE]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT4_CASCADE -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT4_CASCADE -of $IpView] 
   }

} ;# _Mmcm_Clkout4_Cascade

proc updateModel_C_MMCM_CLOCK_HOLD  {IpView} {

   if {[get_param_value MMCM_CLOCK_HOLD]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLOCK_HOLD -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLOCK_HOLD -of $IpView] 
   }

} ;# _Mmcm_Clock_Hold

proc updateModel_C_MMCM_COMPENSATION  {IpView} {

   set_property modelparam_value [get_param_value MMCM_COMPENSATION] [ipgui::get_modelparamspec C_MMCM_COMPENSATION -of $IpView] 

} ;# _Mmcm_Compensation

proc updateModel_C_MMCM_DIVCLK_DIVIDE  {IpView} {

   set_property modelparam_value [get_param_value MMCM_DIVCLK_DIVIDE] [ipgui::get_modelparamspec C_MMCM_DIVCLK_DIVIDE -of $IpView] 

} ;# _Mmcm_Divclk_Divide

proc updateModel_C_MMCM_REF_JITTER1  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_REF_JITTER1]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_REF_JITTER1 -of $IpView] 

} ;# _Mmcm_Ref_Jitter1

proc updateModel_C_MMCM_REF_JITTER2 {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_REF_JITTER2]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_REF_JITTER2 -of $IpView] 

} ;# _Mmcm_Ref_Jitter2

proc updateModel_C_MMCM_STARTUP_WAIT {IpView} {

   if {[get_param_value MMCM_STARTUP_WAIT]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_STARTUP_WAIT -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_STARTUP_WAIT -of $IpView] 
   }

} ;# _Mmcm_Startup_Wait

proc updateModel_C_MMCM_CLKOUT0_DIVIDE_F {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT0_DIVIDE_F]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT0_DIVIDE_F -of $IpView] 

} ;# _Mmcm_Clkout0_Divide_F

proc updateModel_C_MMCM_CLKOUT0_DUTY_CYCLE {IpView} {

   set_property modelparam_value [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] [ipgui::get_modelparamspec C_MMCM_CLKOUT0_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout0_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT0_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT0_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT0_PHASE -of $IpView] 

} ;# _Mmcm_Clkout0_Phase

proc updateModel_C_MMCM_CLKOUT0_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT0_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT0_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT0_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout0_Use_Fine_Ps


proc updateModel_C_MMCM_CLKOUT1_DUTY_CYCLE  {IpView} {

   set_property modelparam_value [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] [ipgui::get_modelparamspec C_MMCM_CLKOUT1_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout1_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT1_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT1_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT1_PHASE -of $IpView] 

} ;# _Mmcm_Clkout1_Phase

proc updateModel_C_MMCM_CLKOUT1_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT1_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT1_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT1_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout1_Use_Fine_Ps


proc updateModel_C_MMCM_CLKOUT2_DUTY_CYCLE  {IpView} {

   set_property modelparam_value [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] [ipgui::get_modelparamspec C_MMCM_CLKOUT2_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout2_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT2_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT2_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT2_PHASE -of $IpView] 

} ;# _Mmcm_Clkout2_Phase

proc updateModel_C_MMCM_CLKOUT2_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT2_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT2_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT2_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout2_Use_Fine_Ps


proc updateModel_C_MMCM_CLKOUT3_DUTY_CYCLE  {IpView} {

   set_property modelparam_value [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] [ipgui::get_modelparamspec C_MMCM_CLKOUT3_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout3_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT3_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT3_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT3_PHASE -of $IpView] 

} ;# _Mmcm_Clkout3_Phase

proc updateModel_C_MMCM_CLKOUT3_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT3_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT3_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT3_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout3_Use_Fine_Ps

proc updateModel_C_MMCM_CLKOUT4_DUTY_CYCLE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT4_DUTY_CYCLE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT4_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout4_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT4_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT4_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT4_PHASE -of $IpView] 

} ;# _Mmcm_Clkout4_Phase

proc updateModel_C_MMCM_CLKOUT4_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT4_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT4_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT4_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout4_Use_Fine_Ps


proc updateModel_C_MMCM_CLKOUT5_DUTY_CYCLE  {IpView} {

   set_property modelparam_value [get_param_value MMCM_CLKOUT5_DUTY_CYCLE] [ipgui::get_modelparamspec C_MMCM_CLKOUT5_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout5_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT5_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT5_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT5_PHASE -of $IpView] 

} ;# _Mmcm_Clkout5_Phase

proc updateModel_C_MMCM_CLKOUT5_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT5_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT5_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT5_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout5_Use_Fine_Ps


proc updateModel_C_MMCM_CLKOUT6_DUTY_CYCLE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT6_DUTY_CYCLE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT6_DUTY_CYCLE -of $IpView] 

} ;# _Mmcm_Clkout6_Duty_Cycle

proc updateModel_C_MMCM_CLKOUT6_PHASE  {IpView} {

   set value [clk_wiz_v6_0_utils::setup_display_float [get_param_value MMCM_CLKOUT6_PHASE]  ]
   set_property modelparam_value $value [ipgui::get_modelparamspec C_MMCM_CLKOUT6_PHASE -of $IpView] 

} ;# _Mmcm_Clkout6_Phase

proc updateModel_C_MMCM_CLKOUT6_USE_FINE_PS  {IpView} {

   if {[get_param_value MMCM_CLKOUT6_USE_FINE_PS]  == "true"} {
      set_property modelparam_value TRUE [ipgui::get_modelparamspec C_MMCM_CLKOUT6_USE_FINE_PS -of $IpView] 
   } else {
      set_property modelparam_value FALSE [ipgui::get_modelparamspec C_MMCM_CLKOUT6_USE_FINE_PS -of $IpView] 
   }

} ;# _Mmcm_Clkout6_Use_Fine_Ps

proc  updateModel_C_OVERRIDE_MMCM {IpView} {
   if {[get_param_value OVERRIDE_MMCM] == "true"} {
     set_property modelparam_value 1 [ipgui::get_modelparamspec C_OVERRIDE_MMCM -of $IpView] 
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec C_OVERRIDE_MMCM -of $IpView]
   }
} ;# _Override_Mmcm



#################################################################
################  MMCM Utility Processes  #######################
#################################################################
# Enables or disables the MMCM attribute values based on the manual override value.
# If override is checked, also disable the Clkout#_Requested_* fields.
proc mmcm_do_override {IpView} {
   variable Mmcm_Override_used
   variable last_Override_Mmcm
   variable val
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set boardIfName [get_param_value CLK_IN1_BOARD_INTERFACE]

   set valuesEnabled false 
   set reqEnabled true 
   if { [get_param_value OVERRIDE_MMCM ] == true } {
     set reqEnabled false 
     set valuesEnabled true 
     set Mmcm_Override_used true
     set_property tooltip "All timing calculations are done using the attribute values entered here.\nUncheck this box to revert back to the wizard-calculated optimal settings." [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView ]

      # Get the backu
      set val [get_param_value OVERRIDE_MMCM ]
      if { ($val == true && $last_Override_Mmcm == false) } {
         Mmcm_Get_Backup $IpView
      }

   } else {
     set_property tooltip "The wizard has determined the optimal settings as displayed here.\nCheck this box to override those settings with your own." [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
     if {$Mmcm_Override_used == true} {
        set val [get_param_value OVERRIDE_MMCM ]
        if { ($val == false && $last_Override_Mmcm == true) } {
            Mmcm_Restore_Original_Values $IpView
        }
        set Mmcm_Override_used false
     }
   }

   set val [get_param_value OVERRIDE_MMCM ]
   set last_Override_Mmcm $val

   #$Groupbox_Mmcm_1 SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout1_Values SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout2_Values SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout3_Values SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout4_Values SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout5_Values SetEnabled $valuesEnabled
   #$Groupbox_Mmcm_Clkout6_Values SetEnabled $valuesEnabled
   #$Groupbox_Clocking_Features SetEnabled $reqEnabled
   set_property enabled $reqEnabled [ipgui::get_groupspec Clocking_Features -of $IpView]
   #set_property enabled $reqEnabled [ipgui::get_tablespec Outputclocktable -of $IpView]
   set_property enabled $valuesEnabled [ipgui::get_tablespec MMCMTable1 -of $IpView]
   set_property enabled $valuesEnabled [ipgui::get_tablespec MMCMTable2 -of $IpView]
   setup_clocking_features $IpView $reqEnabled
   setup_mmcmtable $IpView $valuesEnabled
   setup_clkoutreqs $IpView $reqEnabled
   if {$usePhaseAlignment == true} {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
     set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
   } else {
     if {($value_primitive == "PLL") && ($devicetype == 2)  } {
     set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
	 } elseif {($value_primitive == "Auto") && ([get_param_value USE_SPREAD_SPECTRUM] == true)  } {
     set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
	 }
   }
   set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
   set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]
   set_property enabled $reqEnabled [ipgui::get_paramspec CLKOUT1_DRIVES -of $IpView]
   set_property enabled $reqEnabled [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
   set_property enabled $reqEnabled [ipgui::get_textspec In_Freq_Range_1 -of $IpView]
   set_property enabled $reqEnabled [ipgui::get_paramspec CLKIN1_UI_JITTER -of $IpView]
   #fix for CR824423
   if {$boardIfName ne "Custom"} {
     set_property enabled false [ipgui::get_paramspec PRIM_SOURCE -of $IpView]
   } else {
     set_property enabled true [ipgui::get_paramspec PRIM_SOURCE -of $IpView]
   }
   
   if { [get_param_value USE_INCLK_SWITCHOVER] == true } {
      set_property enabled $reqEnabled [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
      set_property enabled $reqEnabled [ipgui::get_textspec In_Freq_Range_2 -of $IpView]
      set_property enabled $reqEnabled [ipgui::get_paramspec CLKIN2_UI_JITTER -of $IpView]
      #set_property enabled $reqEnabled [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   }
   if { [get_param_value USE_INCLK_SWITCHOVER] == true && [get_param_value OVERRIDE_MMCM ] == true} {
      set_property enabled true [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView] 
   } else {
      set_property enabled false [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView] 
   }
   if { [get_param_value USE_DYN_PHASE_SHIFT] == true } {
      set_property enabled true [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView] 
   } else {
      set_property value false [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView] 
      set_property enabled false [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView] 
   }
   for {set i 0} {$i < 7} {incr i} {
      set j [expr $i+1]
      if { [get_param_value CLKOUT${j}_USED] == true && ([get_param_value PRIMITIVE] == "MMCM") && [get_param_value USE_DYN_PHASE_SHIFT] && [get_param_value OVERRIDE_MMCM] } {
         set_property enabled true [ipgui::get_paramspec MMCM_CLKOUT${i}_USE_FINE_PS -of $IpView]
      } else {
         set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT${i}_USE_FINE_PS -of $IpView]
         set_property value [get_param_value CLK_OUT${j}_USE_FINE_PS_GUI ] [ipgui::get_paramspec MMCM_CLKOUT${i}_USE_FINE_PS -of $IpView]
      }

#CR fix for 952992 use_fin_ps fix where disbale the phase column on the 4th page for not selecting the phase if use_fine_ps is selected
if { [get_param_value OVERRIDE_MMCM] == "true" } {
       if { [get_param_value MMCM_CLKOUT${i}_USE_FINE_PS] == "true" } {
         set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView] 
       }  else { 
          set_property enabled true [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView] 
          }
      } else { 
          set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView] 
        }

       if { [get_param_value MMCM_CLKOUT${i}_USE_FINE_PS] == "true" } {
         set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView] 
       }  else { 
          set_property enabled true [ipgui::get_paramspec MMCM_CLKOUT${i}_PHASE -of $IpView] 
          }


   }

}

proc setup_clocking_features {IpView bFlag} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]

   set_property enabled $bFlag [ipgui::get_paramspec USE_FREQ_SYNTH -of $IpView]
   if { [get_param_value USE_DYN_RECONFIG] == true } {
     set_property enabled false [ipgui::get_paramspec USE_SPREAD_SPECTRUM -of $IpView]
   } else {
     set_property enabled $bFlag [ipgui::get_paramspec USE_SPREAD_SPECTRUM -of $IpView]
   }

   if {($value_primitive == "PLL") && ($devicetype == 2)} {
     set_property enabled false [ipgui::get_paramspec USE_PHASE_ALIGNMENT -of $IpView]
   } else {
     set_property enabled $bFlag [ipgui::get_paramspec USE_PHASE_ALIGNMENT -of $IpView]
   }
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
     set_property enabled false [ipgui::get_paramspec USE_DYN_PHASE_SHIFT -of $IpView]
     set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
     set_property enabled false [ipgui::get_paramspec USE_MIN_POWER -of $IpView]
   } else {
     set_property enabled $bFlag [ipgui::get_paramspec USE_DYN_PHASE_SHIFT -of $IpView]
     set_property enabled $bFlag [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
     set_property enabled $bFlag [ipgui::get_paramspec USE_MIN_POWER -of $IpView]
   }

   set_property enabled $bFlag [ipgui::get_paramspec JITTER_SEL -of $IpView]
}

proc setup_mmcmtable { IpView bFlag } {

   set Paramlist "MMCM_BANDWIDTH MMCM_CLKFBOUT_MULT_F MMCM_CLKFBOUT_PHASE MMCM_CLKFBOUT_USE_FINE_PS MMCM_CLKIN1_PERIOD MMCM_CLKIN2_PERIOD MMCM_CLKOUT4_CASCADE MMCM_CLOCK_HOLD MMCM_COMPENSATION MMCM_DIVCLK_DIVIDE MMCM_REF_JITTER1 \                     
         MMCM_REF_JITTER2 MMCM_STARTUP_WAIT MMCM_CLKOUT0_DIVIDE_F MMCM_CLKOUT0_DUTY_CYCLE MMCM_CLKOUT0_PHASE MMCM_CLKOUT0_USE_FINE_PS MMCM_CLKOUT1_DIVIDE MMCM_CLKOUT1_DUTY_CYCLE MMCM_CLKOUT1_PHASE MMCM_CLKOUT1_USE_FINE_PS"                           
   for {set i 0} {$i < 20} {incr i} {                                              
       set ParamName [lindex $Paramlist $i]                                       
       set_property enabled $bFlag [ipgui::get_paramspec $ParamName -of $IpView]
   }
   set Paramlist "MMCM_CLKOUT2_DIVIDE MMCM_CLKOUT2_DUTY_CYCLE MMCM_CLKOUT2_PHASE MMCM_CLKOUT2_USE_FINE_PS \
          MMCM_CLKOUT3_DIVIDE MMCM_CLKOUT3_DUTY_CYCLE MMCM_CLKOUT3_PHASE MMCM_CLKOUT3_USE_FINE_PS MMCM_CLKOUT4_DIVIDE MMCM_CLKOUT4_DUTY_CYCLE MMCM_CLKOUT4_PHASE MMCM_CLKOUT4_USE_FINE_PS MMCM_CLKOUT5_DIVIDE MMCM_CLKOUT5_DUTY_CYCLE MMCM_CLKOUT5_PHASE MMCM_CLKOUT5_USE_FINE_PS MMCM_CLKOUT6_DIVIDE MMCM_CLKOUT6_DUTY_CYCLE MMCM_CLKOUT6_PHASE MMCM_CLKOUT6_USE_FINE_PS"

   for {set i 0} {$i < 20} {incr i} {                                              
       set ParamName [lindex $Paramlist $i]                                       
       set_property enabled $bFlag [ipgui::get_paramspec $ParamName -of $IpView]
   }
}

proc setup_clkoutreqs {IpView bFlag} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]

   for { set i 2 } { $i <= 7 } { incr i } {
       if { [get_param_value CLKOUT${i}_USED] } {
          set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
          if {($value_primitive == "MMCM" || $value_primitive == "Auto") && ($devicetype == 2)  } {
   if { [get_param_value CLK_OUT${i}_USE_FINE_PS_GUI] == true } {
   set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		} else {
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		}
          } elseif {$usePhaseAlignment == true } {
   if { [get_param_value CLK_OUT${i}_USE_FINE_PS_GUI] == true } {
   set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		} else {
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		}
          } else {
            if {($value_primitive == "PLL") && ($devicetype == 2)  } {
              set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
              set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
            }
		  }
		  set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
          set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_DRIVES -of $IpView]       
	 # } else {
     #     set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_USED -of $IpView]
	  }
   }
}

proc Mmcm_Get_Backup {IpView} {
   variable Mmcm_Bandwidth_backup 
   variable Mmcm_Clkfbout_Mult_F_backup 
   variable Mmcm_Clkfbout_Phase_backup 
   variable Mmcm_Clkfbout_Use_Fine_Ps_backup 
   variable Mmcm_Clkin1_Period_backup 
   variable Mmcm_Clkin2_Period_backup 
   variable Mmcm_Clkout4_Cascade_backup 
   variable Mmcm_Clock_Hold_backup 
   variable Mmcm_Compensation_backup_pll 
   variable Mmcm_Compensation_backup_mmcm 
   variable Mmcm_Divclk_Divide_backup 
   variable Mmcm_Ref_Jitter1_backup 
   variable Mmcm_Ref_Jitter2_backup 
   variable Mmcm_Startup_Wait_backup 
   variable Mmcm_Clkout0_Divide_F_backup 
   variable Mmcm_Clkout0_Duty_Cycle_backup 
   variable Mmcm_Clkout0_Phase_backup 
   variable Mmcm_Clkout0_Use_Fine_Ps_backup 
   variable Mmcm_Clkout1_Divide_backup 
   variable Mmcm_Clkout1_Duty_Cycle_backup 
   variable Mmcm_Clkout1_Phase_backup 
   variable Mmcm_Clkout1_Use_Fine_Ps_backup 
   variable Mmcm_Clkout2_Divide_backup 
   variable Mmcm_Clkout2_Duty_Cycle_backup 
   variable Mmcm_Clkout2_Phase_backup 
   variable Mmcm_Clkout2_Use_Fine_Ps_backup 
   variable Mmcm_Clkout3_Divide_backup 
   variable Mmcm_Clkout3_Duty_Cycle_backup 
   variable Mmcm_Clkout3_Phase_backup 
   variable Mmcm_Clkout3_Use_Fine_Ps_backup 
   variable Mmcm_Clkout4_Divide_backup 
   variable Mmcm_Clkout4_Duty_Cycle_backup 
   variable Mmcm_Clkout4_Phase_backup 
   variable Mmcm_Clkout4_Use_Fine_Ps_backup 
   variable Mmcm_Clkout5_Divide_backup 
   variable Mmcm_Clkout5_Duty_Cycle_backup 
   variable Mmcm_Clkout5_Phase_backup 
   variable Mmcm_Clkout5_Use_Fine_Ps_backup 
   variable Mmcm_Clkout6_Divide_backup 
   variable Mmcm_Clkout6_Duty_Cycle_backup 
   variable Mmcm_Clkout6_Phase_backup 
   variable Mmcm_Clkout6_Use_Fine_Ps_backup 

   set mmcmbw [get_param_value MMCM_BANDWIDTH ]
   set Mmcm_Bandwidth_backup $mmcmbw

   set mmcmclkfboutmultf [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set Mmcm_Clkfbout_Mult_F_backup $mmcmclkfboutmultf

   set mmcmclkfboutphases [get_param_value MMCM_CLKFBOUT_PHASE ]
   set Mmcm_Clkfbout_Phase_backup $mmcmclkfboutphases

   set mmcmclkfboutusefineps [get_param_value MMCM_CLKFBOUT_USE_FINE_PS ]
   set Mmcm_Clkfbout_Use_Fine_Ps_backup $mmcmclkfboutusefineps

   set mmcmclkin1period [get_param_value MMCM_CLKIN1_PERIOD ]
   set Mmcm_Clkin1_Period_backup $mmcmclkin1period

   set mmcmclkin2period [get_param_value MMCM_CLKIN2_PERIOD ]
   set Mmcm_Clkin2_Period_backup $mmcmclkin2period

   set mmcmclkout4cascade [get_param_value MMCM_CLKOUT4_CASCADE ]
   set Mmcm_Clkout4_Cascade_backup $mmcmclkout4cascade

   set mmcmclkhold [get_param_value MMCM_CLOCK_HOLD ]
   set Mmcm_Clock_Hold_backup $mmcmclkhold

   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
     if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2) } {
        set mmcmcompen1 [get_param_value MMCM_COMPENSATION ]
        set Mmcm_Compensation_backup_pll $mmcmcompen1
      } else {
        set mmcmcompen2 [get_param_value MMCM_COMPENSATION ]
        set Mmcm_Compensation_backup_mmcm $mmcmcompen2
      }


   set mmcmdivclkdivide [get_param_value MMCM_DIVCLK_DIVIDE ]
   set Mmcm_Divclk_Divide_backup $mmcmdivclkdivide

   set mmcmrefjitter1 [get_param_value MMCM_REF_JITTER1 ]
   set Mmcm_Ref_Jitter1_backup $mmcmrefjitter1

   set mmcmrefjitter2 [get_param_value MMCM_REF_JITTER2 ]
   set Mmcm_Ref_Jitter2_backup $mmcmrefjitter2
  
   set mmcmstartupwait [get_param_value MMCM_STARTUP_WAIT ]
   set Mmcm_Startup_Wait_backup $mmcmstartupwait

   set mmcmclkout0dividef [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
   set Mmcm_Clkout0_Divide_F_backup $mmcmclkout0dividef
   set mmcmclkout0dutycycle [get_param_value MMCM_CLKOUT0_DUTY_CYCLE ]
   set Mmcm_Clkout0_Duty_Cycle_backup $mmcmclkout0dutycycle
   set mmcmclkout0phase [get_param_value MMCM_CLKOUT0_PHASE ]
   set Mmcm_Clkout0_Phase_backup $mmcmclkout0phase
   set mmcmclkout0usefneps [get_param_value MMCM_CLKOUT0_USE_FINE_PS ]
   set Mmcm_Clkout0_Use_Fine_Ps_backup $mmcmclkout0usefneps

   set mmcmclkout1divide [get_param_value MMCM_CLKOUT1_DIVIDE ]
   set Mmcm_Clkout1_Divide_backup $mmcmclkout1divide
   set mmcmclkout1dutycycle [get_param_value MMCM_CLKOUT1_DUTY_CYCLE ]
   set Mmcm_Clkout1_Duty_Cycle_backup $mmcmclkout1dutycycle
   set mmcmclkout1phase [get_param_value MMCM_CLKOUT1_PHASE ]
   set Mmcm_Clkout1_Phase_backup $mmcmclkout1phase
   set mmcmclkout1usefineps [get_param_value MMCM_CLKOUT1_USE_FINE_PS ]
   set Mmcm_Clkout1_Use_Fine_Ps_backup $mmcmclkout1usefineps
   
   set mmcmclkout2divide [get_param_value MMCM_CLKOUT2_DIVIDE ]
   set Mmcm_Clkout2_Divide_backup $mmcmclkout2divide
   set mmcmclkout2dutycycle [get_param_value MMCM_CLKOUT2_DUTY_CYCLE ]
   set Mmcm_Clkout2_Duty_Cycle_backup $mmcmclkout2dutycycle
   set mmcmclkout2phase [get_param_value MMCM_CLKOUT2_PHASE ]
   set Mmcm_Clkout2_Phase_backup $mmcmclkout2phase
   set mmcmclkout2usefineps [get_param_value MMCM_CLKOUT2_USE_FINE_PS ]
   set Mmcm_Clkout2_Use_Fine_Ps_backup $mmcmclkout2usefineps
 
   set mmcmclkout3divide [get_param_value MMCM_CLKOUT3_DIVIDE ]
   set Mmcm_Clkout3_Divide_backup $mmcmclkout3divide
   set mmcmclkout3dutycycle [get_param_value MMCM_CLKOUT3_DUTY_CYCLE ]
   set Mmcm_Clkout3_Duty_Cycle_backup $mmcmclkout3dutycycle
   set mmcmclkout3phase [get_param_value MMCM_CLKOUT3_PHASE ]
   set Mmcm_Clkout3_Phase_backup $mmcmclkout3phase
   set mmcmclkout3usefineps [get_param_value MMCM_CLKOUT3_USE_FINE_PS ]
   set Mmcm_Clkout3_Use_Fine_Ps_backup $mmcmclkout3usefineps

   set mmcmclkout4divide [get_param_value MMCM_CLKOUT4_DIVIDE ]
   set Mmcm_Clkout4_Divide_backup $mmcmclkout4divide
   set mmcmclkout4dutycycle [get_param_value MMCM_CLKOUT4_DUTY_CYCLE ]
   set Mmcm_Clkout4_Duty_Cycle_backup $mmcmclkout4dutycycle
   set mmcmclkout4phase [get_param_value MMCM_CLKOUT4_PHASE ]
   set Mmcm_Clkout4_Phase_backup $mmcmclkout4phase
   set mmcmclkout4usefineps [get_param_value MMCM_CLKOUT4_USE_FINE_PS ]
   set Mmcm_Clkout4_Use_Fine_Ps_backup $mmcmclkout4usefineps

   set mmcmclkout5divide [get_param_value MMCM_CLKOUT5_DIVIDE ]
   set Mmcm_Clkout5_Divide_backup $mmcmclkout5divide
   set mmcmclkout5dutycycle [get_param_value MMCM_CLKOUT5_DUTY_CYCLE ]
   set Mmcm_Clkout5_Duty_Cycle_backup $mmcmclkout5dutycycle
   set mmcmclkout5phase [get_param_value MMCM_CLKOUT5_PHASE ]
   set Mmcm_Clkout5_Phase_backup $mmcmclkout5phase
   set mmcmclkout5usefineps [get_param_value MMCM_CLKOUT5_USE_FINE_PS ]
   set Mmcm_Clkout5_Use_Fine_Ps_backup $mmcmclkout5usefineps

   set mmcmclkout6divide [get_param_value MMCM_CLKOUT6_DIVIDE ]
   set Mmcm_Clkout6_Divide_backup $mmcmclkout6divide
   set mmcmclkout6dutycycle [get_param_value MMCM_CLKOUT6_DUTY_CYCLE ]
   set Mmcm_Clkout6_Duty_Cycle_backup $mmcmclkout6dutycycle
   set mmcmclkout6phase [get_param_value MMCM_CLKOUT6_PHASE ]
   set Mmcm_Clkout6_Phase_backup $mmcmclkout6phase
   set mmcmclkout6usefineps [get_param_value MMCM_CLKOUT6_USE_FINE_PS ]
   set Mmcm_Clkout6_Use_Fine_Ps_backup $mmcmclkout6usefineps
   
}

proc Mmcm_Restore_Original_Values {IpView} {
   variable Mmcm_Bandwidth_backup
   variable Mmcm_Clkfbout_Mult_F_backup
   variable Mmcm_Clkfbout_Phase_backup
   variable Mmcm_Clkfbout_Use_Fine_Ps_backup
   variable Mmcm_Clkin1_Period_backup
   variable Mmcm_Clkin2_Period_backup
   variable Mmcm_Clkout4_Cascade_backup
   variable Mmcm_Clock_Hold_backup
   variable Mmcm_Compensation_backup_pll
   variable Mmcm_Compensation_backup_mmcm
   variable Mmcm_Divclk_Divide_backup
   variable Mmcm_Ref_Jitter1_backup
   variable Mmcm_Ref_Jitter2_backup
   variable Mmcm_Startup_Wait_backup
   variable Mmcm_Clkout0_Divide_F_backup
   variable Mmcm_Clkout0_Duty_Cycle_backup
   variable Mmcm_Clkout0_Phase_backup
   variable Mmcm_Clkout0_Use_Fine_Ps_backup
   variable Mmcm_Clkout1_Divide_backup
   variable Mmcm_Clkout1_Duty_Cycle_backup
   variable Mmcm_Clkout1_Phase_backup
   variable Mmcm_Clkout1_Use_Fine_Ps_backup
   variable Mmcm_Clkout2_Divide_backup
   variable Mmcm_Clkout2_Duty_Cycle_backup
   variable Mmcm_Clkout2_Phase_backup
   variable Mmcm_Clkout2_Use_Fine_Ps_backup
   variable Mmcm_Clkout3_Divide_backup
   variable Mmcm_Clkout3_Duty_Cycle_backup
   variable Mmcm_Clkout3_Phase_backup
   variable Mmcm_Clkout3_Use_Fine_Ps_backup
   variable Mmcm_Clkout4_Divide_backup
   variable Mmcm_Clkout4_Duty_Cycle_backup
   variable Mmcm_Clkout4_Phase_backup
   variable Mmcm_Clkout4_Use_Fine_Ps_backup
   variable Mmcm_Clkout5_Divide_backup
   variable Mmcm_Clkout5_Duty_Cycle_backup
   variable Mmcm_Clkout5_Phase_backup
   variable Mmcm_Clkout5_Use_Fine_Ps_backup
   variable Mmcm_Clkout6_Divide_backup
   variable Mmcm_Clkout6_Duty_Cycle_backup
   variable Mmcm_Clkout6_Phase_backup
   variable Mmcm_Clkout6_Use_Fine_Ps_backup

   set_property value $Mmcm_Bandwidth_backup [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
   set_property value $Mmcm_Clkfbout_Mult_F_backup [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
   set_property value $Mmcm_Clkfbout_Phase_backup [ipgui::get_paramspec MMCM_CLKFBOUT_PHASE -of $IpView]
   set_property value $Mmcm_Clkfbout_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkin1_Period_backup [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
   set_property value $Mmcm_Clkin2_Period_backup [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
   set_property value $Mmcm_Clkout4_Cascade_backup [ipgui::get_paramspec MMCM_CLKOUT4_CASCADE -of $IpView]
   set_property value $Mmcm_Clock_Hold_backup [ipgui::get_paramspec MMCM_CLOCK_HOLD -of $IpView]
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
     if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2) } {
        set_property value $Mmcm_Compensation_backup_pll [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
      } else {
        set_property value $Mmcm_Compensation_backup_mmcm [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
      }

   set_property value $Mmcm_Divclk_Divide_backup [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
   set_property value $Mmcm_Ref_Jitter1_backup [ipgui::get_paramspec MMCM_REF_JITTER1 -of $IpView]
   set_property value $Mmcm_Ref_Jitter2_backup [ipgui::get_paramspec MMCM_REF_JITTER2 -of $IpView]
   set_property value $Mmcm_Startup_Wait_backup [ipgui::get_paramspec MMCM_STARTUP_WAIT -of $IpView]
   set_property value $Mmcm_Clkout0_Divide_F_backup [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
   set_property value $Mmcm_Clkout0_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT0_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout0_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT0_PHASE -of $IpView]
   set_property value $Mmcm_Clkout0_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT0_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout1_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout1_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT1_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout1_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT1_PHASE -of $IpView]
   set_property value $Mmcm_Clkout1_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT1_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout2_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT2_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout2_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT2_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout2_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT2_PHASE -of $IpView]
   set_property value $Mmcm_Clkout2_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT2_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout3_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT3_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout3_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT3_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout3_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT3_PHASE -of $IpView]
   set_property value $Mmcm_Clkout3_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT3_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout4_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT4_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout4_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT4_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout4_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT4_PHASE -of $IpView]
   set_property value $Mmcm_Clkout4_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT4_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout5_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT5_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout5_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT5_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout5_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT5_PHASE -of $IpView]
   set_property value $Mmcm_Clkout5_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT5_USE_FINE_PS -of $IpView]
   set_property value $Mmcm_Clkout6_Divide_backup [ipgui::get_paramspec MMCM_CLKOUT6_DIVIDE -of $IpView]
   set_property value $Mmcm_Clkout6_Duty_Cycle_backup [ipgui::get_paramspec MMCM_CLKOUT6_DUTY_CYCLE -of $IpView]
   set_property value $Mmcm_Clkout6_Phase_backup [ipgui::get_paramspec MMCM_CLKOUT6_PHASE -of $IpView]
   set_property value $Mmcm_Clkout6_Use_Fine_Ps_backup [ipgui::get_paramspec MMCM_CLKOUT6_USE_FINE_PS -of $IpView]
   
}

proc validate_MMCM_CLKFBOUT_MULT_F {IpView} {
   variable devicefamily
   set devicetype  [getDevicefamily $devicefamily]
   set val [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set ival [expr {int($val)}]
   set val_8 [expr {$val * 8}]
   set ival_8 [expr {int($val_8)}]
   set diff [expr ($val - $ival)]
   set diff_8 [expr ($val_8 - $ival_8)]
   set min 2
   set max 128 
   if { [get_param_value PRIMITIVE] == "PLL" || ([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto")} {
      if {$devicetype == 2 } {
      set min 1
	  }
   }
   if { [get_param_value PRIMITIVE] == "PLL" || ([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto")} {
      if {$devicetype == 3 } {
      set max 21
	  } elseif {$devicetype == 2 } {
      set max 19
	  } else {
      set max 64
	  }
    } else {
      if {$devicetype == 3 } {
      set max 128
	  } else {
      set max 64
	  }
	}
         if { $val < $min  || $val > $max } {
            set_property errmsg "It should be in the range $min - $max" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
		   return FALSE
			
         }
   if { [get_param_value PRIMITIVE] == "PLL" || ([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto")} {
         if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
             set_property errmsg "It should be integer for PLL" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
			              return FALSE
           }
        } else {
         if { $diff_8 != 0 && ($diff_8 > 0.001 && $diff_8 < 0.999) } {
             set_property errmsg "Fractional part must be multiples of 0.125 for MMCM" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
             return FALSE
			 }
		}
   return TRUE
}

proc MMCM_CLKFBOUT_MULT_F_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_DIVCLK_DIVIDE {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT0_DIVIDE_F_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT1_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT2_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT3_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT4_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT5_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}
proc MMCM_CLKOUT6_DIVIDE_updated {IpView} {
    sec_freq_calc $IpView
}

proc validate_MMCM_DIVCLK_DIVIDE {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set val [get_param_value MMCM_DIVCLK_DIVIDE]
   set max 106
   if { [get_param_value PRIMITIVE] == "PLL"} {
      if {$devicetype == 2 } {
        set max 15
      } else {
        set max 56
      }
   }

   if { $val < 1 || $val > $max } {
      set_property errmsg "It should be in the range 1 - $max" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT0_DIVIDE_F {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set val [get_param_value MMCM_CLKOUT0_DIVIDE_F]
   set ival [expr {int($val)}]
   set diff [expr ($val - $ival)]
   set val_8 [expr {$val * 8}]
   set ival_8 [expr {int($val_8)}]
   set diff_8 [expr ($val_8 - $ival_8)]

   if { [get_param_value PRIMITIVE] == "PLL" || ([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto")} {
      if { $devicetype == 2 } {
         if { $val < 1 || $val > 128 } {
            set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
            return FALSE
         }
      } else {
         if { $val < 1 || $val > 128 } {
            set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
            return FALSE
         }
      }
   } else {
      if { $val < 1.000 || $val > 128.000 } {
         set_property errmsg "It should be in the range 1.000 - 128.000" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]

         return FALSE
      }
   }
   
   if { [get_param_value PRIMITIVE] == "PLL" || ([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto")} {
         if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
             set_property errmsg "It should be integer for PLL" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
			  return FALSE
           }
        } else {
         if { ($diff != 0 && ($diff > 0.001 && $diff < 0.999)) && $ival == 1 } {
             set_property errmsg "Fractional part are allowed only for range 2-128 for MMCM" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
             return FALSE
		  }
		
         if { $diff_8 != 0 && ($diff_8 > 0.001 && $diff_8 < 0.999) } {
             set_property errmsg "Fractional part must multiples of 0.125 for MMCM" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
             return FALSE
		   }
		}
   return TRUE
}

proc validate_MMCM_CLKOUT1_DIVIDE {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set val [get_param_value MMCM_CLKOUT1_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT2_DIVIDE {IpView} {
   set val [get_param_value MMCM_CLKOUT2_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT2_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT3_DIVIDE {IpView} {
   set val [get_param_value MMCM_CLKOUT3_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT3_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT4_DIVIDE {IpView} {
   set val [get_param_value MMCM_CLKOUT4_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT4_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT5_DIVIDE {IpView} {
   set val [get_param_value MMCM_CLKOUT5_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT5_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT6_DIVIDE {IpView} {
   set val [get_param_value MMCM_CLKOUT6_DIVIDE]
   if { $val < 1 || $val > 128 } {
      set_property errmsg "It should be in the range 1 - 128" [ipgui::get_paramspec MMCM_CLKOUT6_DIVIDE -of $IpView]
      return FALSE
   }
   return TRUE
}

proc validate_MMCM_CLKOUT0_PHASE {IpView } {

   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
      set phase1 [get_param_value MMCM_CLKOUT0_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT0_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT0_PHASE -of $IpView] 
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT0_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT0_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT0_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT0_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

proc validate_MMCM_CLKOUT1_PHASE {IpView } {

   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT1_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT1_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((64.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase $phase1 shouldn't be greater than $MAX_PS when CLK_OUT1_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT1_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT1_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT1_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT1_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT1_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}
   
proc validate_MMCM_CLKOUT2_PHASE {IpView } {

   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT2_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT2_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT2_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT2_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT2_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT2_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT2_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT2_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

proc validate_MMCM_CLKOUT3_PHASE {IpView } {

   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT3_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT3_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT3_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT3_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT3_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT3_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT3_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT3_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

proc validate_MMCM_CLKOUT4_PHASE {IpView } {

   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT4_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT4_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT4_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT4_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT4_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT4_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT4_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT4_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

proc validate_MMCM_CLKOUT5_PHASE {IpView } {
   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT5_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT5_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT5_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT5_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT5_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT5_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT5_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT5_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

proc validate_MMCM_CLKOUT6_PHASE {IpView } {
   if { [ get_param_value OVERRIDE_MMCM ] == true } {
      set div [get_param_value MMCM_CLKOUT6_DIVIDE ]
      set phase1 [get_param_value MMCM_CLKOUT6_PHASE ]
      set MAX_PS 0
      if { $div != 0 } {
         set MAX_PS  [expr ((63.0 / $div) * 360) + (7 * (45.0 / $div))]
      }
      set pdiff [expr ($phase1 - $MAX_PS)]
      if { ($div > 64) && ($pdiff > 0.001) } {
         set_property errmsg "Max Phase shouldn't be greater than $MAX_PS when CLK_OUT6_DIVIDE is greater than 64" [ipgui::get_paramspec MMCM_CLKOUT6_PHASE -of $IpView]
         return FALSE
      }
	variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if { [get_param_value PRIMITIVE] == "PLL" && ($devicetype == 2 || $devicetype == 3) } {
      set val [expr ($phase1 * $div / 360.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 360/CLK_OUT6_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT6_PHASE -of $IpView]
         return FALSE
      }
	  } else {
      set val [expr ($phase1 * $div / 45.0)] 
      set ival [expr {int($val)}]
      set diff [expr ($val - $ival)]
      if { $diff != 0 && ($diff > 0.001 && $diff < 0.999) } {
         set_property errmsg "Phase should be integer multiple of 45/CLK_OUT6_DIVIDE" [ipgui::get_paramspec MMCM_CLKOUT6_PHASE -of $IpView]
         return FALSE
    }
   }
   }
   return TRUE
}

