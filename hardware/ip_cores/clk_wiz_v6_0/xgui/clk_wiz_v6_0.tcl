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
set devicefamily [get_project_property ARCHITECTURE]
package require xilinx::board 1.0
namespace import ::xilinx::board::*
source_ipfile "xgui/clk_wiz_v6_0_utils.tcl"
source_ipfile "xgui/top_mmcme3.tcl"
source_ipfile "xgui/clk_wiz_v6_0_mmcm.tcl"
  
set clk_vlnv "xilinx.com:signal:clock_rtl:1.0" 
set diff_clk_vlnv "xilinx.com:interface:diff_clock_rtl:1.0" 
set rst_vlnv "xilinx.com:signal:reset_rtl:1.0" 
proc EvalSubstituting {parameters procedure {numlevels 1}} {
    set paramlist {}
    if {[string index $numlevels 0]!="#"} {
       set numlevels [expr $numlevels+1]
    }
    foreach parameter $parameters {
        upvar 1 $parameter $parameter\_value
        lappend paramlist \$$parameter [set $parameter\_value]
    }
    uplevel $numlevels [string map $paramlist $procedure]
}

namespace import clk_wiz_v6_0_utils::* 
namespace import top_mmcme3::*
set Jitter_Changed false

variable fh ""
variable forCalc_Done ""
variable c_device ""
variable c_package ""
variable c_speed ""
variable c_family ""
variable text_Outclk_Sum_Clkout1_Out_Freq ""
variable text_Outclk_Sum_Clkout1_Name ""
variable text_Outclk_Sum_Clkout1_Out_Time ""
variable text_Outclk_Sum_Clkout1_Phase ""
variable text_Outclk_Sum_Clkout1_Duty_Cycle ""
variable text_Outclk_Sum_Clkout2_Name ""
variable text_Outclk_Sum_Clkout2_Out_Freq ""
variable text_Outclk_Sum_Clkout2_Out_Time ""
variable text_Outclk_Sum_Clkout2_Phase ""
variable text_Outclk_Sum_Clkout2_Duty_Cycle ""
variable text_Outclk_Sum_Clkout3_Out_Freq ""
variable text_Outclk_Sum_Clkout3_Out_Time ""
variable text_Outclk_Sum_Clkout3_Phase ""
variable text_Outclk_Sum_Clkout3_Duty_Cycle ""
variable text_Outclk_Sum_Clkout4_Out_Freq ""
variable text_Outclk_Sum_Clkout4_Out_Time ""
variable text_Outclk_Sum_Clkout4_Phase ""
variable text_Outclk_Sum_Clkout4_Duty_Cycle ""
variable text_Outclk_Sum_Clkout5_Out_Freq ""
variable text_Outclk_Sum_Clkout5_Out_Time ""
variable text_Outclk_Sum_Clkout5_Phase ""
variable text_Outclk_Sum_Clkout5_Duty_Cycle ""
variable text_Outclk_Sum_Clkout6_Out_Freq ""
variable text_Outclk_Sum_Clkout6_Out_Time ""
variable text_Outclk_Sum_Clkout6_Phase ""
variable text_Outclk_Sum_Clkout6_Duty_Cycle ""
variable text_Outclk_Sum_Clkout7_Out_Freq ""
variable text_Outclk_Sum_Clkout7_Out_Time ""
variable text_Outclk_Sum_Clkout7_Phase ""
variable text_Outclk_Sum_Clkout7_Duty_Cycle ""
	  ### GUI fix for hang issue with specific freq
variable test_case "1"

variable text_Outclk_Sum_Clkout1_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout1_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout2_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout2_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout3_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout3_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout4_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout4_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout5_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout5_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout6_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout6_Phase_Error "OFF"
variable text_Outclk_Sum_Clkout7_Pktopk_Jitter "OFF"
variable text_Outclk_Sum_Clkout7_Phase_Error "OFF"

variable text_c_inclk_sum_row0 ""
variable text_c_inclk_sum_row1 ""
variable text_c_inclk_sum_row2 ""
variable text_c_outclk_sum_row0a ""
variable text_c_outclk_sum_row0b ""
variable text_c_outclk_sum_row1 ""
variable text_c_outclk_sum_row2 ""
variable text_c_outclk_sum_row3 ""
variable text_c_outclk_sum_row4 ""
variable text_c_outclk_sum_row5 ""
variable text_c_outclk_sum_row6 ""
variable text_c_outclk_sum_row7 ""

variable text_CLKOUT1_driver_max_freq ""
variable text_CLKOUT2_driver_max_freq ""
variable text_CLKOUT3_driver_max_freq ""
variable text_CLKOUT4_driver_max_freq ""
variable text_CLKOUT5_driver_max_freq ""
variable text_CLKOUT6_driver_max_freq ""
variable text_CLKOUT7_driver_max_freq ""

variable CLKOUT1_freq_in_buffer_range true
variable CLKOUT2_freq_in_buffer_range true
variable CLKOUT3_freq_in_buffer_range true
variable CLKOUT4_freq_in_buffer_range true
variable CLKOUT5_freq_in_buffer_range true
variable CLKOUT6_freq_in_buffer_range true
variable CLKOUT7_freq_in_buffer_range true

# Resource variables
variable c_numBUFG  0
variable c_numBUFGCE  0
variable c_numBUFR  0
variable c_numBUFH  0
variable c_numIBUFG  0
variable c_numIBUFGDS  0
variable c_numIBUFDS  0
variable c_numIBUF  0
variable c_numODDR  0
variable c_numODDR2  0
variable c_numOBUFDS  0
variable c_numIBUFDS_DIFF_OUT 0
variable c_numBUFIO2FB 0
variable  dup_numBUFG 0
variable  dup_numBUFGCE 0

variable text_Label_Res_2 ""
variable text_Label_Res_3 ""
variable text_Label_Res_4 ""
variable text_Label_Res_5 ""
variable text_Label_Res_6 ""
variable text_Label_Res_7 ""
variable text_Label_Res_8 ""

# Constants used for clkin source
variable c_IBUFG_src       "Single_ended_clock_capable_pin"
variable c_IBUFGDS_src     "Differential_clock_capable_pin"
variable c_IBUF_BUFG_src   "Single_ended_non_clock_pin"
variable c_IBUFDS_BUFG_src "Differential_non_clock_pin"
variable c_BUFG_src        "Global_buffer"
variable c_No_buffer_src   "No_buffer"

# Min and Max for Modulation freq when Spread Spectrum is true
variable c_min_mod_freq "25"
variable c_max_mod_freq "250"
variable c_min_mod_time "0.004"
variable c_max_mod_time "0.04"

variable numBUFGCE_DIV 0
variable clk1_bufgce ""
variable clk2_bufgce ""
variable clk3_bufgce ""
variable clk4_bufgce ""
variable clk5_bufgce ""
variable clk6_bufgce ""
variable clk7_bufgce ""
variable  mmcm_bufgcediv1 false
variable  mmcm_bufgcediv2 false
variable  mmcm_bufgcediv3 false
variable  mmcm_bufgcediv4 false
variable  mmcm_bufgcediv5 false
variable  mmcm_bufgcediv6 false
variable  mmcm_bufgcediv7 false
# variable  drive_bufgcediv1 false
# variable  drive_bufgcediv2 false
# variable  drive_bufgcediv3 false
# variable  drive_bufgcediv4 false
# variable  drive_bufgcediv5 false
# variable  drive_bufgcediv6 false
# variable  drive_bufgcediv7 false

proc getDeviceType {family1} {
    switch -- $family1 {
		"virtex7" {
			return 1
			}	
		"kintex7" {
			return 1
			}	
		"spartan7" {
			return 1
			}	
		"virtex7l" {
			return 1
			}	
		"kintex7l" {
			return 1
			}	
		"artix7" {
			return 1
			}
		"artix7l" {
			return 1
			}
		"aartix7" {
			return 1
			}	
		"zynq" {          
			return 1
			}	    
	"qvirtex7" {
			return 1
			}	
	"qkintex7" {
			return 1
			}	
	"qartix7" {
			return 1
			}
	"qvirtex7l" {
			return 1
			}	
	"qkintex7l" {
			return 1
			}	
	"qartix7l" {
			return 1
			}
	"qzynq" {          
			return 1
			}	
	"azynq" {          
			return 1
			}	
	"virtexu" {          
			return 2
			}	
	"virtexuplus" {          
			return 2
			}	
	"virtexuplusHBM" {          
			return 2
			}	
	"virtexuplus58g" {          
			return 2
			}	
	"kintexuplus" {          
			return 2
			}
	"spartanuplus" {          
			return 2
			}		
	"zynquplus" {          
			return 2
			}	
    "kintexu" {          
			return 2
			}	
    "zynquplusRFSOC" {          
			return 2
			}	
        default {
		    return 2
            # return -code error \
                # -errorinfo "Unknown device family in getTransceiverType"
        }
    }
}
proc getDevicefamily {family1} {
    switch -- $family1 {
		"virtex7" {
			return 1
			}	
		"kintex7" {
			return 1
			}	
		"spartan7" {
			return 1
			}	
		"virtex7l" {
			return 1
			}	
		"kintex7l" {
			return 1
			}	
		"artix7" {
			return 1
			}
		"artix7l" {
			return 1
			}
		"aartix7" {
			return 1
			}	
		"zynq" {          
			return 1
			}	    
	"qvirtex7" {
			return 1
			}	
	"qkintex7" {
			return 1
			}	
	"qartix7" {
			return 1
			}
	"qvirtex7l" {
			return 1
			}	
	"qkintex7l" {
			return 1
			}	
	"qartix7l" {
			return 1
			}
	"qzynq" {          
			return 1
			}	
	"azynq" {          
			return 1
			}	
	"virtexu" {          
			return 2
			}	
	"virtexuplus" {          
			return 3
			}	
	"virtexuplus58g" {          
			return 3
			}	
	"virtexuplusHBM" {          
			return 3
			}	
	"kintexuplus" {          
			return 3
			}
	"spartanuplus" {          
			return 3
			}	
	"zynquplus" {          
			return 3
			}
    "zynquplusRFSOC" {          
			return 3
			}	
    "kintexu" {          
			return 2
			}	
        default {
		    return 3
            # return -code error \
                # -errorinfo "Unknown device family in getTransceiverType"
        }
    }
}
################################################################################
# proc RESET_BOARD_INTERFACE_updated { IpView } {
    # if { [get_project_property BOARD] != "" } {
	  # set param_range [get_board_interface_param_range $IpView -name "RESET_BOARD_INTERFACE" -matchparam "TYPE"]
      # if {[llength [split $param_range ","]] > 1} {
          # set_property range $param_range [ipgui::get_paramspec  RESET_BOARD_INTERFACE -of $IpView] 
      # }
    # }
# }

proc updateOf_RESET_BOARD_INTERFACE { IpView } {
 if { [get_project_property BOARD] != "" } {
 set param_range [get_board_interface_param_range $IpView -name "RESET_BOARD_INTERFACE" -matchparam "TYPE"]
 if {[llength [split $param_range ","]] > 1} { 
 set_property range $param_range [ipgui::get_paramspec RESET_BOARD_INTERFACE -of $IpView] 
 } 
}
 }
################################################################################
proc config_prim_freq_gui_option { IpView } {
    set val_clk_in1       [get_param_value CLK_IN1_BOARD_INTERFACE ]
    if { $val_clk_in1 ne "Custom" } {
        set_property enabled false [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView ] 
     } else {
        set_property enabled true [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView ] 
     }
}
################################################################################
proc config_prim_tp_gui_option { IpView } {
    set val_clk_in1       [get_param_value CLK_IN1_BOARD_INTERFACE ]
    if { $val_clk_in1 ne "Custom" } {
        set_property enabled false [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView ] 
     } else {
        set_property enabled true [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView ] 
     }
}


################################################################################
proc config_sec_freq_gui_option { IpView } {
    set val_clk_in2       [get_param_value CLK_IN2_BOARD_INTERFACE ]
    set bEnable [get_param_value USE_INCLK_SWITCHOVER]
    if { $bEnable == false} {
        set_property enabled false [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView ]
        set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView ]
    } elseif { $val_clk_in2 ne "Custom" } {
        set_property enabled false [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView ] 
        set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView ]
     } else {
        set_property enabled true [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView ] 
	 if {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin" } {
        set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView ]
     } else {
        set_property enabled true [ipgui::get_paramspec SECONDARY_PORT -of $IpView ]
	 }
}
}
proc sec_freq_calc { IpView } {
   if { [get_param_value USE_INCLK_SWITCHOVER ] == true && [get_param_value OVERRIDE_MMCM] == true} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  if {[get_param_value PRIMITIVE] == "Auto"} {
  set value_primitive [get_param_value AUTO_PRIMITIVE]
  } else {
  set value_primitive [get_param_value PRIMITIVE]
  }
  set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
      set sec_freq [get_param_value SECONDARY_IN_FREQ]
      set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
      set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
      set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
      if {($value_primitive == "PLL") && ($devicetype != 2)  } {
         if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
            set sec_clk_val [format "%3.3f" $sec_clk_val ]
         }
      } else {
         if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         } elseif {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         }
      }
      if {$sec_freq < $sec_clk_val} {
      set infreq2 $sec_clk_val
      set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
      } else {
      set infreq2 $sec_freq
      set_property value $sec_freq [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
      }
      ####
   set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq2]
   set rounding_per [clk_wiz_v6_0_utils::setup_display_float $clkinp] 
   set vco_freq [ expr (1.0* $infreq2 * $clkFBMult) / ( $clkFBDiv) ]
   set vco_freq [setup_display_float $vco_freq] 
   set actual_per [expr (1000 / $infreq2) ]
   set diff_per [ expr ($rounding_per - $actual_per)]
   if {($value_primitive == "PLL") && ($devicetype != 2)  } {
      if {($vco_freq <= 800.001 && $vco_freq >= 800.000) && $diff_per > 0.000} {
         set clkinp [expr $clkinp - 0.001]
      }
   } else {
      if {($vco_freq <= 600.001 && $vco_freq >= 600.000) && $diff_per > 0.000} {
         set clkinp [expr $clkinp - 0.001]
      } elseif {($vco_freq <= 800.001 && $vco_freq >= 800.000) && $diff_per > 0.000} {
         set clkinp [expr $clkinp - 0.001]
      }
   }
   set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView] 
      ####
   } else {
      set sec_freq [get_param_value SECONDARY_IN_FREQ]
      set sec_clk_value $sec_freq
   }
}

################################################################################
proc config_sec_time_gui_option { IpView } {
    set val_clk_in2       [get_param_value CLK_IN2_BOARD_INTERFACE ]
    set bEnable [get_param_value USE_INCLK_SWITCHOVER]
    if { $bEnable == false} {
        set_property enabled false [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView ] 
    } elseif { $val_clk_in2 ne "Custom" } {
        set_property enabled false [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView ] 
     } else {
        set_property enabled true [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView ] 
     }
}


################################################################################
proc set_prim_freq  { IpView boardIfName param } {
    if { [get_project_property BOARD] == "" } {
        return
    }
    if {$boardIfName ne "Custom" } {
        set freq [get_interface_property $boardIfName PARAM.frequency]
		if {$freq ne "" } {
            set freq_Mhz [format "%3.3f" [expr $freq / 1000000.000]]
            set_property value $freq_Mhz [ipgui::get_paramspec $param -of $IpView ] 
		}
    }
}

################################################################################
proc set_prim_tp  { IpView boardIfName param } {
    if { [get_project_property BOARD] == "" } {
        return
    }
    if {$boardIfName ne "Custom" } {
        set time [get_interface_property $boardIfName PARAM.Time]
        if {$time ne "" } {
            set time_ns [expr $time / 1000000000]
            set_property value $time_ns [ipgui::get_paramspec $param -of $IpView ] 
        }
    }
}

################################################################################
proc set_sec_freq  { IpView boardIfName param } {
    if { [get_project_property BOARD] == "" } {
        return
    }
    if {$boardIfName ne "Custom" } {
        set freq [get_interface_property $boardIfName PARAM.frequency]
        if {$freq ne "" } {
            set freq_Mhz [format "%3.3f" [expr $freq / 1000000.000]]
            set_property value $freq_Mhz [ipgui::get_paramspec $param -of $IpView ] 
        }
    }
}
################################################################################
proc set_sec_tp  { IpView boardIfName param } {
    if { [get_project_property BOARD] == "" } {
        return
    }
    if {$boardIfName ne "Custom" } {
        set time [get_interface_property $boardIfName PARAM.Time]
        if {$time ne "" } {
            set time_ns [expr $time / 1000000000]
            set_property value $time_ns [ipgui::get_paramspec $param -of $IpView ] 
        }
    }
}

################################################################################
proc get_inclk_in_MHz { bPrim } {
   if { [get_param_value INPUT_MODE] == "Time" } {
      set infreq [convert_ns_to_MHz $bprim]
   } 
else {
      set infreq [get_param_value PRIM_IN_FREQ ]
  }
   return $infreq
}

#################################################################

proc updateOf_CLK_IN1_BOARD_INTERFACE {IpView} {
      set param_range [get_board_interface_param_range $IpView -name "CLK_IN1_BOARD_INTERFACE" -matchparam "TYPE"]
      if {[llength [split $param_range ","]] > 1} {
          set_property range $param_range [ipgui::get_paramspec  CLK_IN1_BOARD_INTERFACE -of $IpView] 
      }   
}
proc CLK_IN1_BOARD_INTERFACE_updated { IpView } {
    variable c_IBUFGDS_src
    variable c_IBUFG_src
    variable clk_vlnv
    variable diff_clk_vlnv
    if { [get_project_property BOARD] != "" } {
	  set boardIfName [get_param_value CLK_IN1_BOARD_INTERFACE]
         if {$boardIfName ne "Custom"} {
            set vlnv [get_property VLNV [get_board_part_interfaces $boardIfName] ]
            set_property enabled false [ipgui::get_paramspec PRIM_SOURCE -of $IpView] 
         } else {
            set_property enabled true [ipgui::get_paramspec PRIM_SOURCE -of $IpView] 
            set vlnv "Custom"
            set_property value $c_IBUFG_src [ipgui::get_paramspec PRIM_SOURCE -of $IpView] 
         }
         if {$vlnv == $diff_clk_vlnv} {
            set_property value $c_IBUFGDS_src [ipgui::get_paramspec PRIM_SOURCE -of $IpView] 
         } elseif {$vlnv == $clk_vlnv} {
            set_property value $c_IBUFG_src [ipgui::get_paramspec PRIM_SOURCE -of $IpView] 
         }
         set_prim_freq $IpView $boardIfName PRIM_IN_FREQ
         config_prim_freq_gui_option $IpView

         set_prim_tp $IpView $boardIfName PRIM_IN_TIMEPERIOD
         config_prim_tp_gui_option $IpView

    }
}

proc DIFF_CLK_IN1_BOARD_INTERFACE_updated {IpView} {
    if { [get_project_property BOARD] != "" && [get_param_value DIFF_CLK_IN1_BOARD_INTERFACE] != "Custom" } {
        set_property value [get_param_value DIFF_CLK_IN1_BOARD_INTERFACE] [ipgui::get_paramspec CLK_IN1_BOARD_INTERFACE -of $IpView] 
    }
}

################################################################################
proc validate_CLK_IN1_BOARD_INTERFACE {IpView} {
    set clkin1_boardIfName [get_param_value CLK_IN1_BOARD_INTERFACE]
    set clkin2_boardIfName [get_param_value CLK_IN2_BOARD_INTERFACE]
       if {$clkin1_boardIfName eq $clkin2_boardIfName && $clkin1_boardIfName ne "Custom" } {
          set_property errmsg "Clock interface can't be same for primary and secondary input clocks" [ipgui::get_paramspec CLK_IN1_BOARD_INTERFACE -of $IpView ]
          return false
       } else {
          return true
       }
    return true
}
################################################################################
proc updateOf_CLK_IN2_BOARD_INTERFACE {IpView} {
      set param_range [get_board_interface_param_range $IpView -name "CLK_IN2_BOARD_INTERFACE" -matchparam "TYPE"]
      if {[llength [split $param_range ","]] > 1} {
          set_property range $param_range [ipgui::get_paramspec  CLK_IN2_BOARD_INTERFACE -of $IpView] 
      }   
}
proc CLK_IN2_BOARD_INTERFACE_updated {IpView} {
    variable c_IBUFGDS_src
    variable c_IBUFG_src
    variable clk_vlnv
    variable diff_clk_vlnv
    
	if { [get_project_property BOARD] != "" } {
	  set bEnable [get_param_value USE_INCLK_SWITCHOVER]
      set boardIfName [get_param_value CLK_IN2_BOARD_INTERFACE]
       if {$boardIfName ne "Custom"} {
          set vlnv [get_property VLNV [get_board_part_interfaces $boardIfName] ]
          set_property value true [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView] 
          set_property enabled false [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView] 
          set_property enabled false [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
          set freq [get_interface_property $boardIfName PARAM.frequency]
          if {$freq ne "" } {
              set freq_Mhz [format "%3.3f" [expr $freq / 1000000.000]]
              set_property value $freq_Mhz [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView ] 
          }
       } else {
          set vlnv "Custom"
          set_property value $c_IBUFG_src [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
          if {$bEnable} {
             set_property enabled false [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
          } else {
             set_property enabled false [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
          }
          set_property enabled true [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView] 
          #set_property value false [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView] 
       }
       if {$vlnv == $diff_clk_vlnv} {
          set_property value $c_IBUFGDS_src [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
       } elseif {$vlnv == $clk_vlnv} {
          set_property value $c_IBUFG_src [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView] 
       }
       set_sec_freq $IpView $boardIfName SECONDARY_IN_FREQ
       config_sec_freq_gui_option $IpView
    }
}

proc DIFF_CLK_IN2_BOARD_INTERFACE_updated {IpView} {
    if { [get_project_property BOARD] != "" && [get_param_value DIFF_CLK_IN2_BOARD_INTERFACE] != "Custom" } {
        set_property value [get_param_value DIFF_CLK_IN2_BOARD_INTERFACE] [ipgui::get_paramspec CLK_IN2_BOARD_INTERFACE -of $IpView] 
    }
}

proc ENABLE_CLKOUTPHY_updated {IpView} {
     utils_calc_done $IpView
     pre_calculate $IpView
     common_all_update_calc_done $IpView
}

proc CLKOUTPHY_REQUESTED_FREQ_updated {IpView} {
     utils_calc_done $IpView
     pre_calculate $IpView
     common_all_update_calc_done $IpView
     variable clk_wiz_v6_0_utils::phy_mode
     if {[get_param_value ENABLE_CLKOUTPHY]  == "true" && ($phy_mode == "VCO" || $phy_mode ==  "VCO_HALF" || $phy_mode ==  "VCO_2X")} {
        set_property modelparam_value $phy_mode [ipgui::get_modelparamspec  C_CLKOUTPHY_MODE -of $IpView]
     }
}
################################################################################
proc validate_CLK_IN2_BOARD_INTERFACE {IpView} {
    set clkin1_boardIfName [get_param_value CLK_IN1_BOARD_INTERFACE]
    set clkin2_boardIfName [get_param_value CLK_IN2_BOARD_INTERFACE]
       if {$clkin2_boardIfName eq $clkin1_boardIfName && $clkin2_boardIfName ne "Custom" } {
          set_property errmsg "Clock interface can't be same for primary and secondary input clocks" [ipgui::get_paramspec CLK_IN2_BOARD_INTERFACE -of $IpView ]
          return false
       } else {
          return true
       }
    return true
}
################################################################################
proc updateVisibilityOfInputMode {IpView} {
   set infreq1 [get_param_value PRIM_IN_FREQ]
   set modfreq [get_param_value SS_MOD_FREQ]
   set modperiod [get_param_value SS_MOD_TIME]
			set_property visible false [ipgui::get_paramspec SS_MOD_FREQ -of $IpView]
			set_property visible false [ipgui::get_paramspec SS_MOD_TIME -of $IpView]
	
		if {[ get_param_value INPUT_MODE] == "Time" } {	
			set_property visible true [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView]
			set_property visible false [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
                        set_property visible false [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
			set_property visible true [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView]
                        if {[get_param_value USE_SPREAD_SPECTRUM]  == "true"} {
			set_property visible true [ipgui::get_paramspec  SS_MOD_TIME -of $IpView]
                        set_property enabled true [ipgui::get_textspec Label_ModulationTimeperiod -of $IpView]
                        set_property visible true [ipgui::get_textspec Label_ModulationTimeperiod -of $IpView]
                        set_property visible true [ipgui::get_textspec Mod_TimePeriod_Range -of $IpView]
                         } else {
			set_property visible false [ipgui::get_paramspec SS_MOD_TIME -of $IpView]
                        set_property visible false [ipgui::get_textspec Label_ModulationTimeperiod -of $IpView]
                        set_property visible false [ipgui::get_textspec Mod_TimePeriod_Range -of $IpView]
                         }
			set_property visible false [ipgui::get_paramspec SS_MOD_FREQ -of $IpView]
                        set_property visible false [ipgui::get_textspec Label_ModulationFreq -of $IpView]
                        set_property visible false [ipgui::get_textspec Mod_Freq_Range -of $IpView]
		} else {
			set_property visible false [ipgui::get_paramspec SS_MOD_TIME -of $IpView]
                        set_property visible false [ipgui::get_textspec Label_ModulationTimeperiod -of $IpView]
                        set_property visible false [ipgui::get_textspec Mod_TimePeriod_Range -of $IpView]
			set_property visible false [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView]
			set_property visible true  [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
			set_property visible false [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView]
			set_property visible true [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
                        if {[get_param_value USE_SPREAD_SPECTRUM]  == "true"} {
			set_property visible true [ipgui::get_paramspec  SS_MOD_FREQ -of $IpView]
                        set_property enabled true [ipgui::get_textspec Label_ModulationFreq -of $IpView]
                        set_property visible true [ipgui::get_textspec Label_ModulationFreq -of $IpView]
                        set_property visible true [ipgui::get_textspec Mod_Freq_Range -of $IpView]
                         } else {
			set_property visible false [ipgui::get_paramspec SS_MOD_FREQ -of $IpView]
                        set_property visible false [ipgui::get_textspec Label_ModulationFreq -of $IpView]
                        set_property visible false [ipgui::get_textspec Mod_Freq_Range -of $IpView]
                         }
		}
}
#######################################################################################################
proc create_gui {IpView } {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
  variable clk_wiz_v6_0_utils::PartName
  variable clk_wiz_v6_0_utils::ComponentName
  variable fh
  ipgui::add_param  $IpView -parent $IpView -name Component_Name 
  ##############################################################################
  add_board_tab $IpView -display_name { CLK_IN1_BOARD_INTERFACE "CLK_IN1" CLK_IN2_BOARD_INTERFACE "CLK_IN2" RESET_BOARD_INTERFACE "EXT_RESET_IN" }
  ##############################################################################
  #set ProjectName [current_project]
  set PartName [get_project_property PART]
  set ComponentName [current_instname]
  setupDLL $IpView
  set fh [::ipgen::add_ipfile -force summary.log ]
	create_page1 $IpView
	create_page2 $IpView
	create_page5 $IpView
	create_page4_MMCM $IpView
	#create_page4_MMCM_2 $IpView
	create_clkmon $IpView
	create_DRPreg $IpView
	create_page6 $IpView
	create_Resource $IpView
  Initialize $IpView
  setMmcmTooltips $IpView
	  # if {$getDevicefamily == 3} {
      # set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # } else {
      # set_property enabled true [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # }
    updateModel_C_CLKOUT1_DRIVES $IpView
    updateModel_C_CLKOUT2_DRIVES $IpView
    updateModel_C_CLKOUT3_DRIVES $IpView
    updateModel_C_CLKOUT4_DRIVES $IpView
    updateModel_C_CLKOUT5_DRIVES $IpView
    updateModel_C_CLKOUT6_DRIVES $IpView
    updateModel_C_CLKOUT7_DRIVES $IpView
	updateOf_RESET_BOARD_INTERFACE $IpView
	updateOf_CLK_IN1_BOARD_INTERFACE $IpView
	updateOf_CLK_IN2_BOARD_INTERFACE $IpView
	}

proc setMmcmParamRanges {IpView} {
   set_property range "1,64" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT2_DIVIDE -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT3_DIVIDE -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT4_DIVIDE -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT5_DIVIDE -of $IpView]
   set_property range "1,128" [ipgui::get_paramspec MMCM_CLKOUT6_DIVIDE -of $IpView]
}

proc setMmcmTooltips { IpView } {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set getDevicefamily  [getDevicefamily $devicefamily]
   # tooltips
   set_property tooltip "Duty cycle for CLKOUT0 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT0_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT1 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT1_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT2 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT2_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT3 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT3_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT4 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT4_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT5 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT5_DUTY_CYCLE -of $IpView]
   set_property tooltip "Duty cycle for CLKOUT6 output (0.01-0.99)" [ipgui::get_paramspec MMCM_CLKOUT6_DUTY_CYCLE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT0 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT0_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT1 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT1_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT2 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT2_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT3 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT3_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT4 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT4_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT5 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT5_PHASE -of $IpView]
   set_property tooltip "Phase offset for CLKOUT6 output (-360.000-360.000)" [ipgui::get_paramspec MMCM_CLKOUT6_PHASE -of $IpView]
   if { ($devicetype == 2) } {
	  if {$getDevicefamily == 3} {
       set_property tooltip "Divide amount for CLKOUT0 (1.000-128.000) for MMCME4 and (1-128) for PLLE4. When using fractional divide value for MMCME4 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
      set_property tooltip "Divide amount for CLKOUT1 (1-128) for MMCME4 and (1-128) for PLLE4" [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
     } else {
       set_property tooltip "Divide amount for CLKOUT0 (1.000-128.000) for MMCME3 and (1-128) for PLLE3. When using fractional divide value for MMCME3 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
      set_property tooltip "Divide amount for CLKOUT1 (1-128) for MMCME3 and (1-128) for PLLE3" [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
     }
   } else {
      set_property tooltip "Divide amount for CLKOUT0 (1.000-128.000) for MMCME2 and (1-128) for PLLE2. When using fractional divide value for MMCME2 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKOUT0_DIVIDE_F -of $IpView]
      set_property tooltip "Divide amount for CLKOUT1 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT1_DIVIDE -of $IpView]
   }
   set_property tooltip "Divide amount for CLKOUT2 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT2_DIVIDE -of $IpView]
   set_property tooltip "Divide amount for CLKOUT3 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT3_DIVIDE -of $IpView]
   set_property tooltip "Divide amount for CLKOUT4 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT4_DIVIDE -of $IpView]
   set_property tooltip "Divide amount for CLKOUT5 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT5_DIVIDE -of $IpView]
   set_property tooltip "Divide amount for CLKOUT6 (1-128)" [ipgui::get_paramspec MMCM_CLKOUT6_DIVIDE -of $IpView]
   set_property tooltip "Primary input clock period in nS to ps resolution (i.e. 33.333 is 33 MHz)" [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
   set_property tooltip "Secondary input clock period in nS to ps resolution (i.e. 33.333 is 33 MHz)" [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
   set_property tooltip "Primary clock reference input jitter in UI (0.000-0.999)" [ipgui::get_paramspec MMCM_REF_JITTER1 -of $IpView]
   set_property tooltip "Secondary clock reference input jitter in UI (0.000-0.999)" [ipgui::get_paramspec MMCM_REF_JITTER2 -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT0_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT1_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT2_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT3_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT4_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT5_USE_FINE_PS -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT6_USE_FINE_PS -of $IpView]
   set_property tooltip "Jitter programming (HIGH,LOW,OPTIMIZED)" [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
   if { ($devicetype == 2) } {
	  if {$getDevicefamily == 3} {
      set_property tooltip "Multiply value for all CLKOUT (2.0-128.0) for MMCME4 and (2-21) for PLLE4. When using fractional multiply value for MMCME4 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F  -of $IpView]
     } else {
      set_property tooltip "Multiply value for all CLKOUT (2.0-64.0) for MMCME3 and (1-19) for PLLE3. When using fractional multiply value for MMCME3 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F  -of $IpView]
     }
   } else {
      set_property tooltip "Multiply value for all CLKOUT (2.0-64.0) for MMCME2 and (1-64) for PLLE2. When using fractional multiply value for MMCME2 in override mode, please enter in multiples of 0.125. If the fractional value entered is not a multiple of 0.125, then tool will round up/down to the nearest multiple of 0.125" [ipgui::get_paramspec MMCM_CLKFBOUT_MULT_F  -of $IpView]
   }
   set_property tooltip "Phase offset in degrees of CLKFB (0.00-360.00)" [ipgui::get_paramspec MMCM_CLKFBOUT_PHASE -of $IpView]
   set_property tooltip "Fine phase shift enable (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView]
   set_property tooltip "Hold VCO Frequency (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLOCK_HOLD       -of $IpView]
   if { ($devicetype == 2) } {
	  if {$getDevicefamily == 3} {
      set_property tooltip "For MMCME4 this can be 1-106, PLLE4 can have 1-15" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE    -of $IpView]
     } else {
      set_property tooltip "For MMCME3 this can be 1-106, PLLE3 can have 1-15" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE    -of $IpView]
     }
   } else {
      set_property tooltip "For MMCME2 this can be 1-106, PLLE2 can have 1-56" [ipgui::get_paramspec MMCM_DIVCLK_DIVIDE    -of $IpView]
   }
   set_property tooltip "This feature enables the wait during the configuration start-up cycle for the Clocking Primitive to lock" [ipgui::get_paramspec MMCM_STARTUP_WAIT     -of $IpView]
   set_property tooltip "Cascase CLKOUT4 counter with CLKOUT6 (TRUE/FALSE)" [ipgui::get_paramspec MMCM_CLKOUT4_CASCADE  -of $IpView]
   if { ($devicetype == 2) } {
   set_property tooltip "Clock input compensation. Defines how the MMCM feedback is configured. ZHOLD indicates  the MMCM is configured to provide a negative hold time at the I/O registers. INTERNAL indicates the MMCM is using its own internal feedback path so no delay is being compensated. EXTERNAL indicates a network external to the FPGA is being compensated. BUF_IN  indicates that the configuration does not match with the other compensation modes and no delay will be compensated. When AUTO, SW will determine the proper setting for COMPENSATION based on topology and change it.  Else, SW will not change it. Either way, DRC will check the final value is legal and warn/err as appropriate" [ipgui::get_paramspec MMCM_COMPENSATION     -of $IpView]
   } else {
   set_property tooltip "Clock input compensation. Defines how the MMCM feedback is configured. ZHOLD indicates  the MMCM is configured to provide a negative hold time at the I/O registers. INTERNAL indicates the MMCM is using its own internal feedback path so no delay is being compensated. EXTERNAL indicates a network external to the FPGA is being compensated. CASCADE indicates cascading of 2 MMCM. BUF_IN  indicates that the configuration does not match with the other compensation modes and no delay will be compensated. This is the case if a clock input is driven by a BUFG/BUFH/BUFR/GT." [ipgui::get_paramspec MMCM_COMPENSATION     -of $IpView]
   }
}

proc setupDLL {IpView} {
   variable c_device 
   variable c_package
   variable c_speed 
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName

   set c_device [get_project_property PART]
   set c_package [get_project_property PACKAGE]
   set c_speed [string tolower [get_project_property SPEEDGRADE]]

   # TODO: Need to check family
#   if {$devicefamily eq "virtex7" || $devicefamily eq "kintex7" || $devicefamily eq "virtex7l" || $devicefamily eq "kintex7l" || $devicefamily eq "artix7" || $devicefamily eq "zynq" || $devicefamily eq "kintexu" || $devicefamily eq "virtexu" } {
#   }
#   set fulldevice "$c_device"
   set fulldevice "$c_device"
   Init_Clkwiz $PartName $ComponentName $fulldevice
}

proc create_Resource {IpView} {
  set Resource [  ipgui::add_page  $IpView  -left  -name Resource -layout vertical]
	set Label_Res_1	[ipgui::add_dynamic_text $IpView -name Label_Res_1 -parent Resource -tclproc Label_Res_1_SetText]
	set Label_Res_2	[ipgui::add_dynamic_text $IpView -name Label_Res_2 -parent Resource -tclproc Label_Res_2_SetText]
	set Label_Res_3	[ipgui::add_dynamic_text $IpView -name Label_Res_3 -parent Resource -tclproc Label_Res_3_SetText]
	set Label_Res_4	[ipgui::add_dynamic_text $IpView -name Label_Res_4 -parent Resource -tclproc Label_Res_4_SetText]
	set Label_Res_5	[ipgui::add_dynamic_text $IpView -name Label_Res_5 -parent Resource -tclproc Label_Res_5_SetText]
	set Label_Res_6	[ipgui::add_dynamic_text $IpView -name Label_Res_6 -parent Resource -tclproc Label_Res_6_SetText]
	set Label_Res_7	[ipgui::add_dynamic_text $IpView -name Label_Res_7 -parent Resource -tclproc Label_Res_7_SetText]
	set Label_Res_8	[ipgui::add_dynamic_text $IpView -name Label_Res_8 -parent Resource -tclproc Label_Res_8_SetText]
}


proc create_page1 {IpView} {
	set page1 [ipgui::add_page $IpView -parent $IpView -name page1 -layout horizontal]
	ipgui::add_row $IpView -parent $page1 
     set Clock_Monitor [ipgui::add_group $IpView -parent $page1 -name "Clock Monitor" -layout horizontal]
  set ENABLE_CLOCK_MONITOR   [ipgui::add_param $IpView -name ENABLE_CLOCK_MONITOR -parent $Clock_Monitor -layout horizontal]
        set_property tooltip "This feature allows the user to monitor the Stop, Glitch and frequency changes in the clock." $ENABLE_CLOCK_MONITOR
	ipgui::add_row $IpView -parent $page1 
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
    
  set PRIMITIVE      [ipgui::add_param $IpView -name PRIMITIVE -parent $page1 -layout horizontal]
        set_property tooltip "Select the Clocking Primitive to be used for clock generation. Selecting Auto, Wizard would decide which primitive to use based on the requirements." $PRIMITIVE
	ipgui::add_row $IpView -parent $page1  
        if {$devicetype == 2} {
  set OPTIMIZE_CLOCKING_STRUCTURE_EN  [ipgui::add_param $IpView -name OPTIMIZE_CLOCKING_STRUCTURE_EN -parent $page1 -layout horizontal]
        set_property tooltip "This option will be available to user only for MMCM/PLL Primitive. On enabling this, IP will generate optimal clocking structure for explicit primitive in combination with Auto Buffer selection." $OPTIMIZE_CLOCKING_STRUCTURE_EN
	ipgui::add_row $IpView -parent $page1  
	set optimize_str_message [ipgui::add_dynamic_text $IpView -name optimize_str_message -parent $page1 -tclproc "optimize_str_message_SetText"]
	ipgui::add_row $IpView -parent $page1  
        }
	set_property display_name "Clocking Options" $page1
    set Groupbox_Clocking_Features [ipgui::add_panel $IpView -parent $page1 -name Groupbox_Clocking_Features -layout horizontal]
    set groupBox_features [ipgui::add_group $IpView -name Clocking_Features -parent $Groupbox_Clocking_Features -layout horizontal]
	set USE_FREQ_SYNTH [ipgui::add_param  $IpView -parent $groupBox_features -name USE_FREQ_SYNTH]
	set USE_MIN_POWER [ipgui::add_param  $IpView -parent $groupBox_features -name USE_MIN_POWER]
        set_property tooltip "When Enabled wizard calculates optimal settings of attribute for power reduction" $USE_MIN_POWER
	ipgui::add_row $IpView -parent $groupBox_features  
	set USE_PHASE_ALIGNMENT [ipgui::add_param  $IpView -parent $groupBox_features -name USE_PHASE_ALIGNMENT]
	set USE_SPREAD_SPECTRUM [ipgui::add_param  $IpView -parent $groupBox_features -name USE_SPREAD_SPECTRUM]
        set_property tooltip "Enables Spread Spectrum Clocking for MMCM" $USE_SPREAD_SPECTRUM
	ipgui::add_row $IpView -parent $groupBox_features  
	set USE_DYN_RECONFIG [ipgui::add_param  $IpView -parent $groupBox_features -name USE_DYN_RECONFIG]
	set USE_DYN_PHASE_SHIFT [ipgui::add_param  $IpView -parent $groupBox_features -name USE_DYN_PHASE_SHIFT]
        set_property tooltip "This feature allows user to change the phase relationship on the output clocks" $USE_DYN_PHASE_SHIFT
    ipgui::add_row $IpView -parent $groupBox_features
    set USE_SAFE_CLOCK_STARTUP [ipgui::add_param  $IpView -parent $groupBox_features -name USE_SAFE_CLOCK_STARTUP]
        set_property tooltip "Delays output clock operation until MMCM/PLL is locked and clock is stable. This feature may create an overall more reliable circuit however may impact performance when operating at very high speeds." $USE_SAFE_CLOCK_STARTUP
    set ENABLE_CDDC [ipgui::add_param  $IpView -parent $groupBox_features -name ENABLE_CDDC]
        set_property tooltip "Clock Divide Dynamic Change Enables ability to change output counter values thus changing output frequencies without requiring reset of the MMCM" $ENABLE_CDDC

	set JITTER_SEL [ipgui::add_param  $IpView -parent $Groupbox_Clocking_Features -name JITTER_SEL]
	
	set_property display_name "Frequency Synthesis" $USE_FREQ_SYNTH
	set_property display_name "Spread Spectrum" $USE_SPREAD_SPECTRUM
	set_property display_name "Phase Alignment" $USE_PHASE_ALIGNMENT
	set_property display_name "Minimize Power" $USE_MIN_POWER
	set_property display_name "Dynamic Phase Shift" $USE_DYN_PHASE_SHIFT
	set_property display_name "Dynamic Reconfig" $USE_DYN_RECONFIG
	set_property display_name "Jitter Optimization" $JITTER_SEL
	set_property tooltip "Balanced : selecting this option allows the software chosing the correct bandwidth for jitter optimization\nMinimize output Jitter : Selecting this option minimizes the jitter on the output clocks at the expense of power and output clock phase error \n Maximixe input jitter filtering : Selecting this option allows larger input jitter on the input clocks" $JITTER_SEL
        set_property display_name "Safe Clock Startup" $USE_SAFE_CLOCK_STARTUP
        set_property display_name "Use CDDC" $ENABLE_CDDC

  set_property tooltip "This feature allows output clocks to have different frequencies" $USE_FREQ_SYNTH
  set_property tooltip "Known phase relationship to input clock" $USE_PHASE_ALIGNMENT

	ipgui::add_row $IpView -parent $page1  


  #ipgui::add_row $IpView -parent $groupBox_features

	#set Jitter_Warning [ipgui::add_dynamic_text $IpView -name Jitter_Warning -parent $groupBox_features -tclproc "Jitter_Warning_SetText"]
	#ipgui::add_row $IpView -parent $groupBox_features
	#set Label_Ip_Symbol [ipgui::add_dynamic_text $IpView -name Label_Ip_Symbol -parent $groupBox_features -tclproc "Label_Ip_Symbol_SetText"] 
  set groupBox_drp [ipgui::add_panel $IpView -parent $page1 -name Dynamic_Reconfig_Options -layout horizontal]
  set INTERFACE_SELECTION [ipgui::add_param  $IpView -parent $groupBox_drp -name INTERFACE_SELECTION -layout horizontal]
  set_property display_name "Dynamic Interface Options" $groupBox_drp
  set_property display_name "Dynamic Reconfig Interface Options" $INTERFACE_SELECTION
  set_property tooltip "Selection of AXI4Lite interface to dynamically change the Multiply and Divide values of the output clocks or DRP for accessing MMCM/PLL registers" $INTERFACE_SELECTION

  set PHASE_DUTY_CONFIG [ipgui::add_param  $IpView -parent $groupBox_drp -name PHASE_DUTY_CONFIG -layout horizontal]
  set_property tooltip "Select this option to enable phase and Duty Cycle dynamic reconfiguration through AXI4-Lite. Enabling this uses DSP resources of FPGA. Without enabling this option phase and duty cycle dynamic reconfiguration is not guarenteed." $PHASE_DUTY_CONFIG
    
  set AXI_DRP [ipgui::add_param  $IpView -parent $groupBox_drp -name AXI_DRP -layout horizontal]
  set_property tooltip "Enabling this user must write direct DRP values into the registers. Refer to DRP registers tab for calculating the register values." $AXI_DRP
    ipgui::add_row $IpView -parent $page1  

	set Groupbox_InClkInfo [ipgui::add_group $IpView -parent $page1 -name "Input_Clock_Information"]

        set INPUT_MODE [ipgui::add_param $IpView -name INPUT_MODE -parent $Groupbox_InClkInfo -layout horizontal]
       # set_property tooltip "Selection of Clock input mode as Timeperiod or Frequency" $IpView
        # set_property tooltip "Selection of Clock input mode as Timeperiod or Frequency"  [ipgui::get_paramspec INPUT_MODE   -of $IpView]
	ipgui::add_row $IpView -parent $Groupbox_InClkInfo

	set table [ipgui::add_table $IpView  -name "table" -rows "3" -columns "9" -parent $Groupbox_InClkInfo -table_header true]
	set Label_Input_Clock [ipgui::add_static_text  $IpView -name Label_Input_Clock -parent  $table -text "Input Clock"]
	set Label_InFreq [ipgui::add_static_text  $IpView -name Label_InFreq -parent  $table -text "Input Frequency(MHz)"]
	set Label_InTime [ipgui::add_static_text  $IpView -name Label_InTime -parent  $table -text "Time Period (ns)"]
	set Label_IInput_Jitter [ipgui::add_static_text  $IpView -name Label_Iclk_Source -parent  $table -text "Input Jitter"]
	set Label_IJitter_Options [ipgui::add_static_text  $IpView -name Label_Iclk_Source -parent  $table -text "Jitter Options"]
	set Label_Iclk_Source [ipgui::add_static_text  $IpView -name Label_Iclk_Source -parent  $table -text "Source"]
	set Label_Primary1 [ipgui::add_static_text  $IpView -name Label_Primary1 -parent  $table -text "Primary"]
	set_property tooltip "Primary Input Clock" $Label_Primary1
	set Label_Secondary1 [ipgui::add_static_text  $IpView -name Label_Secondary1 -parent  $table -text "Secondary"]
	set_property tooltip "Secondary Input Clock" $Label_Secondary1
	set USE_INCLK_SWITCHOVER [ipgui::add_param  $IpView -parent $table -name USE_INCLK_SWITCHOVER -show_label false]
	set_property display_name "Secondary" $USE_INCLK_SWITCHOVER
	set_property tooltip "check this option to enable the secondary input clock" $USE_INCLK_SWITCHOVER
	set PRIM_IN_FREQ [ipgui::add_param  $IpView -parent $table -name PRIM_IN_FREQ]
	set_property tooltip "specify the frequency for primary input clock, when spread spectrum is selected all the frequencies under range may not result in proper M and D values. Then adjust the input frequency accordingly" $PRIM_IN_FREQ  
	set PRIM_IN_TIMEPERIOD [ipgui::add_param  $IpView -parent $table -name PRIM_IN_TIMEPERIOD]
	set SECONDARY_IN_FREQ [ipgui::add_param  $IpView -parent $table -name SECONDARY_IN_FREQ]
	set_property tooltip "specify the frequency for secondary input clock" $SECONDARY_IN_FREQ
	set SECONDARY_IN_TIMEPERIOD [ipgui::add_param  $IpView -parent $table -name SECONDARY_IN_TIMEPERIOD]
	set CLKIN1_JITTER_PS [ipgui::add_param  $IpView -parent $page1 -name CLKIN1_JITTER_PS]
	set CLKIN2_JITTER_PS [ipgui::add_param  $IpView -parent $page1 -name CLKIN2_JITTER_PS]
	set USE_MAX_I_JITTER [ipgui::add_param  $IpView -parent $page1 -name USE_MAX_I_JITTER]
	set USE_MIN_O_JITTER [ipgui::add_param  $IpView -parent $page1 -name USE_MIN_O_JITTER]
	set IN_FREQ_UNITS 	 [ipgui::add_param  $IpView -parent $page1 -name IN_FREQ_UNITS]
	set PRIM_SOURCE [ipgui::add_param  $IpView -parent $table -name PRIM_SOURCE]
	set SECONDARY_SOURCE [ipgui::add_param  $IpView -parent $table -name SECONDARY_SOURCE]
	set In_Freq_Range_1 [ipgui::add_dynamic_text $IpView -name In_Freq_Range_1 -parent $table -tclproc "In_Freq_Range_1_SetText"]
	set In_Freq_Range_2 [ipgui::add_dynamic_text $IpView -name In_Freq_Range_2 -parent $table -tclproc "In_Freq_Range_2_SetText"]
	set NUM_OUT_CLKS 		 [ipgui::add_param  $IpView -parent $page1 -name NUM_OUT_CLKS]
	set AUTO_PRIMITIVE 		 [ipgui::add_param  $IpView -parent $page1 -name AUTO_PRIMITIVE]
	set Label_portrenaming [ipgui::add_static_text  $IpView -name Label_portrenaming -parent  $table -text "Port Name"]
	set PRIMARY_PORT [ipgui::add_param  $IpView -parent $table -name "PRIMARY_PORT"]
	set SECONDARY_PORT [ipgui::add_param  $IpView -parent $table -name "SECONDARY_PORT"]
  set CLKIN1_UI_JITTER [ipgui::add_param  $IpView -parent $table -name CLKIN1_UI_JITTER]
	set CLKIN2_UI_JITTER [ipgui::add_param  $IpView -parent $table -name CLKIN2_UI_JITTER]
  set JITTER_OPTIONS [ipgui::add_param  $IpView -parent $table -name JITTER_OPTIONS ]
	  # if {$getDevicefamily == 3} {
      # set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
  # set_property tooltip "Dynamic Reconfiguration feature is not available for this device" $USE_DYN_RECONFIG
	  # } else {
      # set_property enabled true [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
   set_property tooltip "Used for system output freq modification. Check this option to enable AXI4Lite or DRP interface." $USE_DYN_RECONFIG
	  # }
	# As per the Coregen TCL file; the following param are set to hidden
	set_property visible false $CLKIN1_JITTER_PS
	set_property visible false $CLKIN2_JITTER_PS
	set_property visible false $USE_MAX_I_JITTER
	set_property visible false $USE_MIN_O_JITTER
	set_property visible false $IN_FREQ_UNITS
	set_property visible false $NUM_OUT_CLKS
	set_property visible false $AUTO_PRIMITIVE
	#set_property enabled false $CLKIN2_JITTER_PS
	#set_property enabled false $USE_MAX_I_JITTER
	#set_property enabled false $USE_MIN_O_JITTER
	#set_property enabled false $IN_FREQ_UNITS
	set_property enabled false $NUM_OUT_CLKS
	set_property enabled false $AUTO_PRIMITIVE
  
  set_property cell_location "0,0" [ipgui::add_static_text $IpView -name ST1 -parent $table -text ""]
	set_property cell_location "0,1" $Label_Input_Clock
	set_property cell_location "0,2" $Label_portrenaming
	set_property cell_location "0,3" $Label_InFreq
	set_property cell_location "0,4" $Label_InTime
  set_property cell_location "0,5" [ipgui::add_static_text $IpView -name ST1 -parent $table -text ""]	
	set_property cell_location "0,6" $Label_IJitter_Options
	set_property cell_location "0,7" $Label_IInput_Jitter
	set_property cell_location "0,8" $Label_Iclk_Source

	set_property cell_location "1,1" $Label_Primary1
	set_property cell_location "1,2" $PRIMARY_PORT
	set_property cell_location "1,3" $PRIM_IN_FREQ
	set_property cell_location "1,4" $PRIM_IN_TIMEPERIOD
	set_property cell_location "1,5" $In_Freq_Range_1
	set_property cell_location "1,6" $JITTER_OPTIONS
	set_property cell_location "1,7" $CLKIN1_UI_JITTER
	set_property cell_location "1,8" $PRIM_SOURCE

	set_property cell_location "2,0" $USE_INCLK_SWITCHOVER
	set_property cell_location "2,1" $Label_Secondary1
	set_property cell_location "2,2" $SECONDARY_PORT
	set_property cell_location "2,3" $SECONDARY_IN_FREQ
	set_property cell_location "2,4" $SECONDARY_IN_TIMEPERIOD
	set_property cell_location "2,5" $In_Freq_Range_2
	set_property cell_location "2,7" $CLKIN2_UI_JITTER
	set_property cell_location "2,8" $SECONDARY_SOURCE
	set_property cell_location "2,8" $SECONDARY_SOURCE

	set PRIM_IN_JITTER [ipgui::add_param  $IpView -parent $page1 -name PRIM_IN_JITTER]
	set SECONDARY_IN_JITTER [ipgui::add_param  $IpView -parent $page1 -name SECONDARY_IN_JITTER]
	set CALC_DONE [ipgui::add_param  $IpView -parent $page1 -name CALC_DONE]
	set_property visible false $PRIM_IN_JITTER
	set_property visible false $SECONDARY_IN_JITTER
	set_property visible false $CALC_DONE

        ipgui::add_row $IpView -parent $page1
	set Prim_in_freq_Warning [ipgui::add_dynamic_text $IpView -name Prim_in_freq_Warning -parent $page1 -tclproc "Prim_in_freq_Warning_SetText"]
        ipgui::add_row $IpView -parent $page1
	set Jitter_Warning [ipgui::add_dynamic_text $IpView -name Jitter_Warning -parent $page1 -tclproc "Jitter_Warning_SetText"]
	set Vco_Error [ipgui::add_dynamic_text $IpView -name Vco_Error -parent $page1 -tclproc "Vco_Error_SetText"]

}

proc create_page2 {IpView} {
	set page2 [ipgui::add_page $IpView -parent $IpView -name page2]
	set_property display_name "Output Clocks" $page2
	#ipgui::add_dynamic_text $IpView -name Label_Debug_Warning_p2 -parent $page2 -tclproc "Label_Debug_Warning_p2_SetText"
        set ENABLE_CLKOUTPHY [ipgui::add_param $IpView -name ENABLE_CLKOUTPHY -parent $page2 -layout horizontal]
	#set_property visible false $ENABLE_CLKOUTPHY
	#set Label_clkphyreqFreq [ipgui::add_static_text  $IpView -name Label_clkphyreqFreq -parent  $page2 -text "Clkoutphy Requested Freq(MHz)"]
        set CLKOUTPHY_REQUESTED_FREQ [ipgui::add_param $IpView -parent $page2 -name CLKOUTPHY_REQUESTED_FREQ -layout vertical -show_label false]
	#set_property visible false $CLKOUTPHY_REQUESTED_FREQ
	set Groupbox_SS [ipgui::add_group $IpView -parent $page2 -name Groupbox_SS -layout horizontal]
	set_property display_name "Spread Spectrum Mode and Mod Freq" $Groupbox_SS
	set ssmode [ipgui::add_param  $IpView -parent $Groupbox_SS -name SS_MODE -widget comboBox]
	#ipgui::add_static_text  $IpView -name dummytext -parent $Groupbox_SS -text "                                             "
	#set ModulationFreqTable [ipgui::add_table $IpView  -name "ModulationFreqTable" -rows "1" -columns "3" -parent $Groupbox_SS]
	#set_property cell_location "0,0" $ssmode
	#set_property cell_location "0,1" $ModulationFreqTable

	set Label_ModulationFreq [ipgui::add_static_text  $IpView -name Label_ModulationFreq -parent  $Groupbox_SS -text "Modulation Freq(KHz)"]
	set Label_ModulationTimePeriod [ipgui::add_static_text  $IpView -name Label_ModulationTimeperiod -parent  $Groupbox_SS -text "Modulation TimePeriod(ms)"]
	#set Label_ModulationFreq_Value_Header [ipgui::add_static_text  $IpView -name Label_ModulationFreq_Value_Header -parent  $ModulationFreqTable -text "Value"]
	#set Label_ModulationFreq_Valid_Range_Header [ipgui::add_static_text  $IpView -name Label_ModulationFreq_Valid_Range_Header -parent  $ModulationFreqTable -text "Valid Range"]
	set SS_MOD_FREQ [ipgui::add_param  $IpView -parent $Groupbox_SS -name SS_MOD_FREQ -show_label false]
	set Mod_Freq_Range [ipgui::add_dynamic_text $IpView -name Mod_Freq_Range -parent $Groupbox_SS -tclproc "Mod_Freq_Range_SetText"]
	set SS_MOD_TIME [ipgui::add_param  $IpView -parent $Groupbox_SS -name SS_MOD_TIME -show_label false]
	set Mod_TimePeriod_Range [ipgui::add_dynamic_text $IpView -name Mod_TimePeriod_Range -parent $Groupbox_SS -tclproc "Mod_Time_Range_SetText"]
#
  
	#set_property cell_location "0,1" $Label_ModulationFreq_Value_Header
	#set_property cell_location "0,2" $Label_ModulationFreq_Valid_Range_Header
	#set_property cell_location "0,0" $Label_ModulationFreq
	#set_property cell_location "0,1" $SS_MOD_FREQ
	#set_property cell_location "0,2" $Mod_Freq_Range


	ipgui::add_dynamic_text $IpView -name Label_Phase_Clock -parent $page2 -tclproc "Label_Phase_Clock_SetText"
	set Outputclocktable [ipgui::add_table $IpView  -name "Outputclocktable" -rows "9" -columns "12" -parent $page2]
        #set_property tooltip "Suggested to rename output clocks using Port Renaming tab to provide better understanding in design and timing report" $Outputclocktable
    set Label_OutClkHeader [ipgui::add_static_text  $IpView -name Label_OutClkHeader -parent  $Outputclocktable -text "<b>Output Clock</b>"]
	set_property cell_location "0,0,1,0" $Label_OutClkHeader
    set Label_Portname [ipgui::add_static_text  $IpView -name Label_Portname -parent  $Outputclocktable -text "<b>Port Name</b>"]
	set_property cell_location "0,1,1,1" $Label_Portname
        set Label_OutFreqHeader [ipgui::add_dynamic_text  $IpView -name Label_OutFreqHeader -parent $Outputclocktable -tclproc "Label_OutFreqHeader_SetText"]
	set_property cell_location "0,2,0,3" $Label_OutFreqHeader
	set Label_Requested1 [ipgui::add_static_text  $IpView -name Label_Requested1 -parent  $Outputclocktable -text "<b>Requested</b>"]
	set_property cell_location "1,2" $Label_Requested1
	set Label_Actual1 [ipgui::add_static_text  $IpView -name Label_Actual1 -parent  $Outputclocktable -text "<b>Actual</b>"]
	set_property cell_location "1,3" $Label_Actual1
	set Label_PhaseHeader [ipgui::add_static_text  $IpView -name Label_PhaseHeader -parent  $Outputclocktable -text "<b>Phase (degrees)</b>"]
	set_property cell_location "0,4,0,5" $Label_PhaseHeader
	set Label_Requested2 [ipgui::add_static_text  $IpView -name Label_Requested2 -parent  $Outputclocktable -text "<b>Requested</b>"]
	set_property cell_location "1,4" $Label_Requested2
	set Label_Actual2 [ipgui::add_static_text  $IpView -name Label_Actual2 -parent  $Outputclocktable -text "<b>Actual</b>"]
	set_property cell_location "1,5" $Label_Actual2
	set Label_Duty_Cycle_Header [ipgui::add_static_text  $IpView -name Label_Duty_Cycle_Header -parent  $Outputclocktable -text "<b>Duty Cycle (%)</b>"]
	set_property cell_location "0,6,0,7" $Label_Duty_Cycle_Header
	set Label_Requested3 [ipgui::add_static_text  $IpView -name Label_Requested3 -parent  $Outputclocktable -text "<b>Requested<b/>"]
	set_property cell_location "1,6" $Label_Requested3
	set Label_Actual3 [ipgui::add_static_text  $IpView -name Label_Actual3 -parent  $Outputclocktable -text "<b>Actual</b>"]
	set_property cell_location "1,7" $Label_Actual3
	set Label_Drives [ipgui::add_static_text  $IpView -name Label_Drives -parent  $Outputclocktable -text "<b>Drives</b>"]
	set_property cell_location "0,8,1,8" $Label_Drives
	set Label_Drives_2 [ipgui::add_static_text  $IpView -name Label_Drives_2 -parent  $Outputclocktable -text "<b>Use \nFine PS</b>"]
	set_property cell_location "0,9,1,9" $Label_Drives_2
	set Matched_Routing [ipgui::add_static_text  $IpView -name Matched_Routing -parent  $Outputclocktable -text "<b>Matched \nRouting</b>"]
	set_property cell_location "0,10,1,10" $Matched_Routing
	set Label_Drives_Max_freq [ipgui::add_static_text  $IpView -name Buffer_Max_Freq -parent  $Outputclocktable -text "<b>Max Freq. \nof buffer</b>"]
	set_property cell_location "0,11,1,11" $Label_Drives_Max_freq
	set CLKOUT1_USED [ipgui::add_param  $IpView -parent  $Outputclocktable -name CLKOUT1_USED]
	set_property cell_location "2,0" $CLKOUT1_USED
	set CLKOUT2_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT2_USED]
	set_property cell_location "3,0" $CLKOUT2_USED
	set CLKOUT3_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT3_USED]
	set_property cell_location "4,0" $CLKOUT3_USED
	set CLKOUT4_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT4_USED]
	set_property cell_location "5,0" $CLKOUT4_USED
	set CLKOUT5_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT5_USED]
	set_property cell_location "6,0" $CLKOUT5_USED
	set CLKOUT6_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT6_USED]
	set_property cell_location "7,0" $CLKOUT6_USED
	set CLKOUT7_USED [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT7_USED]
	set_property cell_location "8,0" $CLKOUT7_USED
	set_property show_label true $CLKOUT1_USED
	set_property show_label true $CLKOUT2_USED
	set_property show_label true $CLKOUT3_USED
	set_property show_label true $CLKOUT4_USED
	set_property show_label true $CLKOUT5_USED
	set_property show_label true $CLKOUT6_USED
	set_property show_label true $CLKOUT7_USED

	set_property display_name "clk_out1" $CLKOUT1_USED
	set_property display_name "clk_out2" $CLKOUT2_USED
	set_property display_name "clk_out3" $CLKOUT3_USED
	set_property display_name "clk_out4" $CLKOUT4_USED
	set_property display_name "clk_out5" $CLKOUT5_USED
	set_property display_name "clk_out6" $CLKOUT6_USED
	set_property display_name "clk_out7" $CLKOUT7_USED
	
	for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {
			set Clkout_REQUESTED_OUT_FREQ [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT$i_REQUESTED_OUT_FREQ]
			set_property tooltip "Specify the requested frequency for the output clock$i. The Actual frequency mentioned in the GUI is 5 decimal truncated in the decimal places." $Clkout_REQUESTED_OUT_FREQ
			set Clkout_PORT_NAME [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT$i_PORT]
			set_property tooltip "Specify the user requested name for the output clock$i" $Clkout_PORT_NAME
			set j [expr "$i + 1"]
			set_property cell_location "$j,1" $Clkout_PORT_NAME
			set_property cell_location "$j,2" $Clkout_REQUESTED_OUT_FREQ
			set Clkout_Actual_Out_Freq [ipgui::add_dynamic_text $IpView -name CLKOUT$i_ACTUAL_OUT_FREQ -parent $Outputclocktable -tclproc "CLKOUT$i_ACTUAL_OUT_FREQ_SetText"]
			set_property cell_location "$j,3" $Clkout_Actual_Out_Freq
			set_property tooltip "Actual output frequency for the output clock$i" $Clkout_Actual_Out_Freq
			set Clkout_Requested_Phase [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT$i_REQUESTED_PHASE]
			set_property cell_location "$j,4" $Clkout_Requested_Phase
			set_property tooltip "Specify the requested phase for the output clock$i" $Clkout_Requested_Phase
			set Clkout_Actual_Phase [ipgui::add_dynamic_text $IpView -name CLKOUT$i_ACTUAL_PHASE -parent $Outputclocktable -tclproc "CLKOUT$i_ACTUAL_PHASE_SetText"]
			set_property tooltip "Actual phase for the output clock$i" $Clkout_Actual_Phase
			set_property cell_location "$j,5" $Clkout_Actual_Phase
			set Clkout_Requested_Duty_Cycle [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT$i_REQUESTED_DUTY_CYCLE]
			set_property cell_location "$j,6" $Clkout_Requested_Duty_Cycle
			set_property tooltip "Specify the requested Duty Cycle for the output clock$i" $Clkout_Requested_Duty_Cycle
			set Clkout_Actual_Duty_Cycle [ipgui::add_dynamic_text $IpView -name CLKOUT$i_ACTUAL_DUTY_CYCLE -parent $Outputclocktable -tclproc "CLKOUT$i_ACTUAL_DUTY_CYCLE_SetText"]
			set_property tooltip "Actual Duty Cycle for the output clock$i" $Clkout_Actual_Duty_Cycle
			set_property cell_location "$j,7" $Clkout_Actual_Duty_Cycle
			set Clkout_Drives [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT$i_DRIVES]
			set_property cell_location "$j,8" $Clkout_Drives
			set Clk_Out_Use_Fine_Ps_GUI [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT$i_USE_FINE_PS_GUI]
			set_property cell_location "$j,9" $Clk_Out_Use_Fine_Ps_GUI
			set Clk_Out_Matched_Routing [ipgui::add_param  $IpView -parent $Outputclocktable -name CLKOUT$i_MATCHED_ROUTING]
			set_property cell_location "$j,10" $Clk_Out_Matched_Routing
			set Clk_Out_Driver_Max_freq [ipgui::add_dynamic_text  $IpView -name CLKOUT$i_driver_max_freq -parent $Outputclocktable -tclproc "CLKOUT$i_driver_max_freq_SetText"]
			set_property cell_location "$j,11" $Clk_Out_Driver_Max_freq

			set_property tooltip "Setting Matched Routing will force the implementation tools to use the same CLOCK_ROOT for all selected clocks by setting the CLOCK_DELAY_GROUP property on the corresponding clock nets in the Clocking Wizard IP XDC file. For clocks without Matched Routing, the clock skew on timing paths with other clocks will not be optimized and can lead to difficult timing closure. Use Matched Routing preferably for high frequency clocks with many clock domain crossing paths. Using Matched Routing on too many clocks can lead to sub-optimal placement and difficult timing closure. For specifying more than 1 group of clocks with Matched Routing, select this option only for the first group, and create the CLOCK_DELAY_GROUP constraints in the design XDC file for the other groups." $Clk_Out_Matched_Routing
			set_property tooltip "Choose the specific Drives you want to insert in the clock path. Choosing Buffer or Buffer_with_CE wizard places the best suited buffer." $Clkout_Drives
		} 0
	}
            # set Clkout_PORT_NAME1 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT1_PORT]
            # set Clkout_PORT_NAME2 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT2_PORT]
            # set Clkout_PORT_NAME3 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT3_PORT]
            # set Clkout_PORT_NAME4 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT4_PORT]
            # set Clkout_PORT_NAME5 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT4_PORT]
            # set Clkout_PORT_NAME6 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT6_PORT]
            # set Clkout_PORT_NAME7 [ipgui::add_param  $IpView -parent $Outputclocktable -name CLK_OUT7_PORT]
		    # set_property tooltip "Specify the name the output clock1" $Clkout_PORT_NAME1
		    # set_property tooltip "Specify the name the output clock2" $Clkout_PORT_NAME2
		    # set_property tooltip "Specify the name the output clock3" $Clkout_PORT_NAME3
		    # set_property tooltip "Specify the name the output clock4" $Clkout_PORT_NAME4
		    # set_property tooltip "Specify the name the output clock5" $Clkout_PORT_NAME5
		    # set_property tooltip "Specify the name the output clock6" $Clkout_PORT_NAME6
		    # set_property tooltip "Specify the name the output clock7" $Clkout_PORT_NAME7
            # set_property cell_location "2,1" $Clkout_PORT_NAME1
            # set_property cell_location "3,1" $Clkout_PORT_NAME2
            # set_property cell_location "4,1" $Clkout_PORT_NAME3
            # set_property cell_location "5,1" $Clkout_PORT_NAME4
            # set_property cell_location "6,1" $Clkout_PORT_NAME5
            # set_property cell_location "7,1" $Clkout_PORT_NAME6
            # set_property cell_location "8,1" $Clkout_PORT_NAME7
   
	ipgui::add_dynamic_text $IpView -name Label_Actual_Err_Str -parent $page2 -tclproc "Label_Actual_Err_Str_SetText"
	set Max_Buffer_Freq_Warning [ipgui::add_dynamic_text $IpView -name Max_Buffer_Freq_Warning -parent $page2 -tclproc "Max_Buffer_Freq_Warning_SetText"]
	set Freq_match_Warning [ipgui::add_dynamic_text $IpView -name Freq_match_Warning -parent $page2 -tclproc "Freq_match_Warning_SetText"]
	set Dyn_Reconf_Connection_Warning [ipgui::add_dynamic_text $IpView -name Dyn_Reconf_Connection_Warning -parent $page2 -tclproc "Dyn_Reconf_Connection_Warning_SetText"]

    #Clock Sequencing Table
    set topPanel [ipgui::add_panel $IpView -parent $page2 -name topPanel -layout horizontal] 
    set Panel_Clock_Sequencing [ipgui::add_panel $IpView -parent $topPanel -name Panel_Clock_Sequencing -layout vertical]
    set Groupbox_Clock_Sequencing [ipgui::add_group $IpView -parent $Panel_Clock_Sequencing -header_param "USE_CLOCK_SEQUENCING" -name Groupbox_Clock_Sequencing -layout vertical ]
	set clocksequencetable [ipgui::add_table $IpView  -name "clocksequencetable" -rows "9" -columns "2" -parent $Groupbox_Clock_Sequencing]
    set_property enabled false $clocksequencetable
        set_property tooltip "Clocks to the design are enabled in provided sequence using BUFGCE after LOCKED is high and eight cycles of the stable clocks are passed throug the previous sequenced clock. Sampling of LOCKED and enable are performed using clock through BUFH. Clock Frequency of the output clock shouldn't be more than eight times of the next output clock in sequence for safe clock generation." $clocksequencetable
	set Label_OutClkHeader1 [ipgui::add_static_text  $IpView -name Label_OutClkHeader1 -parent  $clocksequencetable -text "<b>Output Clock</b>"]
	set_property cell_location "0,0,1,0" $Label_OutClkHeader1
	set Label_NumClocks [ipgui::add_static_text  $IpView -name Label_NumClocks -parent  $clocksequencetable -text "<b>Sequence Number</b>"]
	set_property cell_location "0,1,1,1" $Label_NumClocks
	set Label_Clkout1 [ipgui::add_static_text  $IpView -name Label_Clkout1_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out1"]
	set_property cell_location "2,0" $Label_Clkout1
    set Label_Clkout2 [ipgui::add_static_text  $IpView -name Label_Clkout2_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out2"]
	set_property cell_location "3,0" $Label_Clkout2
    set Label_Clkout3 [ipgui::add_static_text  $IpView -name Label_Clkout3_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out3"]
	set_property cell_location "4,0" $Label_Clkout3
    set Label_Clkout4 [ipgui::add_static_text  $IpView -name Label_Clkout4_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out4"]
	set_property cell_location "5,0" $Label_Clkout4
    set Label_Clkout5 [ipgui::add_static_text  $IpView -name Label_Clkout5_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out5"]
	set_property cell_location "6,0" $Label_Clkout5
    set Label_Clkout6 [ipgui::add_static_text  $IpView -name Label_Clkout6_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out6"]
	set_property cell_location "7,0" $Label_Clkout6
    set Label_Clkout7 [ipgui::add_static_text  $IpView -name Label_Clkout7_Seq -parent  $clocksequencetable -text "&nbsp;&nbsp;&nbsp;&nbsp;clk_out7"]
	set_property cell_location "8,0" $Label_Clkout7

    for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {
			set Clkout_Sequencing [ipgui::add_param  $IpView -parent $clocksequencetable -name CLKOUT$i_SEQUENCE_NUMBER]
			set j [expr "$i + 1"]
            set_property cell_location "$j,1" $Clkout_Sequencing

		} 0
	}
 
  set dummyPanel [ipgui::add_panel $IpView -parent $topPanel -name dummyPanel -layout horizontal]
  set tab2Panel [ipgui::add_group $IpView -parent $dummyPanel -name tab2Panel -layout horizontal]
  set FEEDBACK_SOURCE [ipgui::add_param  $IpView -parent $tab2Panel -name FEEDBACK_SOURCE]
  set_property tooltip "If the path is completely on FPGA, then select on-chip
  else select off-chip feedback. selecting user-controlled feedback will expose clkfb_in port
  for the user control" $FEEDBACK_SOURCE
  set CLKFB_IN_SIGNALING [ipgui::add_param  $IpView -parent $tab2Panel -name CLKFB_IN_SIGNALING]

  ipgui::add_dynamic_text $IpView -name Label_Actual_Err_Str2 -parent $page2 -tclproc "Label_Actual_Err_Str2_SetText"
  
  set Groupbox_Optional_IO_Features [ipgui::add_panel $IpView -parent $page2 -name Groupbox_Optional_IO_Features -layout horizontal]

    set Groupbox_Optional_IO [ipgui::add_group $IpView -parent $Groupbox_Optional_IO_Features -name Groupbox_Optional_IO -layout horizontal]
	set USE_RESET [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO -name USE_RESET]
	set USE_POWER_DOWN [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO -name USE_POWER_DOWN]
	set_property tooltip "Selecting this option enables power_down input port for the user selection. Asserting power_down will place the clocking
	primitives in low power state which stops the output clocks" $USE_POWER_DOWN
	set USE_INCLK_STOPPED [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO -name USE_INCLK_STOPPED]
  ipgui::add_row $IpView -parent $Groupbox_Optional_IO
	set_property tooltip "selecting this option enables the
	input_clk_stopped port which is used to indicate that the selected
	input clock is no longer toggling" $USE_INCLK_STOPPED
	set USE_LOCKED [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO -name USE_LOCKED]
	set_property tooltip "Selecting this option will enable the locked port which indicates the stability of the output
	clocks" $USE_LOCKED
	set USE_CLKFB_STOPPED [ipgui::add_param $IpView -name USE_CLKFB_STOPPED -parent $Groupbox_Optional_IO]
  ipgui::add_row $IpView -parent $Groupbox_Optional_IO
    set_property tooltip "Selecting this option will enable the clkfb_stopped port, which will be  asserted when the feedback clock is lost" $USE_CLKFB_STOPPED
  #set dummyPanel2 [ipgui::add_panel $IpView -parent $Groupbox_Optional_IO_Features -name dummyPanel2]
 set RESET_TYPE [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO_Features -name RESET_TYPE -layout horizontal]
 set PHASESHIFT_MODE [ipgui::add_param  $IpView -parent $Groupbox_Optional_IO_Features -name PHASESHIFT_MODE -layout horizontal]
    set_property tooltip "Select whether the phase-shifted clock should be modelled into the clock WAVEFORM or LATENCY through the CMB. No multicycle constraint is needed when modelled through latency." $PHASESHIFT_MODE
  # set tab2Panel [ipgui::add_group $IpView -parent $Panel_Clock_Sequencing -name tab2Panel -layout horizontal]
 # set FEEDBACK_SOURCE [ipgui::add_param  $IpView -parent $tab2Panel -name FEEDBACK_SOURCE]
#  set CLKFB_IN_SIGNALING [ipgui::add_param  $IpView -parent $tab2Panel -name CLKFB_IN_SIGNALING]


    set_property display_name "Enable Optional Inputs / Outputs for MMCM/PLL" $Groupbox_Optional_IO
    set_property display_name "reset" $USE_RESET
    set_property display_name "locked" $USE_LOCKED
    set_property display_name "input_clk_stopped" $USE_INCLK_STOPPED
    set_property display_name "power_down" $USE_POWER_DOWN
    set_property display_name "Clocking Feedback" $tab2Panel
    set_property display_name "clkfbstopped" $USE_CLKFB_STOPPED
    set_property display_name "Source" $FEEDBACK_SOURCE
    set_property display_name "Signaling" $CLKFB_IN_SIGNALING
    set_property display_name "Reset Type" $RESET_TYPE
    set_property display_name "Phase Shift Mode" $PHASESHIFT_MODE
	
	ipgui::add_dynamic_text $IpView -name Label_Actual_Err_Str3 -parent $page2 -tclproc "Label_Actual_Err_Str3_SetText"
   
}

proc create_page4_MMCM {IpView} {
        variable devicefamily
        set devicetype  [getDeviceType $devicefamily]
        set value_primitive [get_param_value PRIMITIVE]
	set page4_MMCM [ipgui::add_page $IpView -parent $IpView -name page4_MMCM -layout horizontal]
	set_property display_name "MMCM Settings" $page4_MMCM 	
	ipgui::add_static_text  $IpView -name LabelMMCM -parent $page4_MMCM -text "These are the settings based on inputs from previous pages. Any update on this page \nwill override the optimal settings calculated by the wizard"
	ipgui::add_row $IpView -parent $page4_MMCM
	set OVERRIDE_MMCM [ipgui::add_param  $IpView -parent $page4_MMCM -name OVERRIDE_MMCM]
	set TEST_PARAM [ipgui::add_param  $IpView -parent $page4_MMCM -name PLL_CLKIN_PERIOD]
        set_property visible false $TEST_PARAM
    set_property display_name "Allow Override Mode" $OVERRIDE_MMCM
	ipgui::add_dynamic_text $IpView -name Override_Label -parent $page4_MMCM -tclproc "Override_Label_SetText"
	ipgui::add_row $IpView -parent $page4_MMCM
	
	set MMCMTable1 [ipgui::add_table $IpView  -name "MMCMTable1" -rows "14" -columns "2" -parent $page4_MMCM -table_header true]
    ipgui::add_static_text $IpView -parent $page4_MMCM -name emptytext -text ""
	set MMCMlable1 [ipgui::add_static_text  $IpView -name MMCMlable1 -parent $MMCMTable1 -text "Attribute"]
	set_property cell_location "0,0" $MMCMlable1
	set MMCMlable2 [ipgui::add_static_text  $IpView -name MMCMlable2 -parent $MMCMTable1 -text "Value"]
	set_property cell_location "0,1" $MMCMlable2
	
	#set Labellist "BANDWIDTH CLKFBOUT_MULT_F CLKFBOUT_PHASE  CLKIN1_PERIOD DIVCLK_DIVIDE REF_JITTER1 STARTUP_WAIT "
	#set Paramlist "MMCM_BANDWIDTH MMCM_CLKFBOUT_MULT_F MMCM_CLKFBOUT_PHASE  MMCM_CLKIN1_PERIOD MMCM_DIVCLK_DIVIDE MMCM_REF_JITTER1 \
					 MMCM_STARTUP_WAIT "
	set Labellist "BANDWIDTH CLKFBOUT_MULT_F CLKFBOUT_PHASE  CLKIN1_PERIOD CLKIN2_PERIOD COMPENSATION DIVCLK_DIVIDE REF_JITTER1 REF_JITTER2 STARTUP_WAIT \
              CLKFBOUT_USE_FINE_PS CLKOUT4_CASCADE CLOCK_HOLD  "
	set Paramlist "MMCM_BANDWIDTH MMCM_CLKFBOUT_MULT_F MMCM_CLKFBOUT_PHASE  MMCM_CLKIN1_PERIOD MMCM_CLKIN2_PERIOD  MMCM_COMPENSATION MMCM_DIVCLK_DIVIDE MMCM_REF_JITTER1 \
					MMCM_REF_JITTER2 MMCM_STARTUP_WAIT MMCM_CLKFBOUT_USE_FINE_PS MMCM_CLKOUT4_CASCADE MMCM_CLOCK_HOLD "
	for {set i 0} {$i < 14} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		if {$i == 1 || $i == 13} {
		continue
		}
		EvalSubstituting {i LabelName ParamName} {
			set LabelMMCMTable [ipgui::add_static_text  $IpView -name $LabelName -parent $MMCMTable1 -text "$LabelName"]
			set ParamMMCMTable [ipgui::add_param  $IpView -parent $MMCMTable1 -name $ParamName]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelMMCMTable
			set_property cell_location "$j,1" $ParamMMCMTable
		} 0
	}
	set LabelMMCMTable [ipgui::add_dynamic_text $IpView -name CLKFBOUT_MULT_F -parent $MMCMTable1 -tclproc "CLKFBOUT_MULT_F_SetText"]
	set ParamMMCMTable [ipgui::add_param  $IpView -parent $MMCMTable1 -name MMCM_CLKFBOUT_MULT_F]
	set_property cell_location "2,0" $LabelMMCMTable
	set_property cell_location "2,1" $ParamMMCMTable
	
	
	ipgui::add_row $IpView -parent $page4_MMCM
  set table2panel [ipgui::add_panel $IpView  -parent $page4_MMCM -name "table2panel" ]

  set MMCMTable2 [ipgui::add_table $IpView  -name "MMCMTable2" -rows "8" -columns "7" -parent $table2panel -table_header true]
  set wizclockNames [ipgui::add_static_text $IpView -parent $MMCMTable2 -name wizclockNames -text "Clk Wizard Port"]
  set wizclockreNames [ipgui::add_static_text $IpView -parent $MMCMTable2 -name wizclockreNames -text "Renamed Port"]
  set mmcmclockNames [ipgui::add_static_text $IpView -parent $MMCMTable2 -name mmcmclockNames -text "MMCM/PLL Port"]
  set clockdiv [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clockdiv -text "Divide"]
  set clockdut [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clockdut -text "Duty Cycle"]
  set clockpha [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clockpha -text "Phase"]
  set clockps [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clockps -text "Use Fine Ps"]
  set clock0 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock0 -text "clk_out1"]
  set clock1 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock1 -text "clk_out2"]
  set clock2 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock2 -text "clk_out3"]
  set clock3 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock3 -text "clk_out4"]
  set clock4 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock4 -text "clk_out5"]
  set clock5 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock5 -text "clk_out6"]
  set clock6 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name clock6 -text "clk_out7"]
  set mmcmout0 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name mmcmout0 -text "CLKOUT0"]
  set mmcmout1 [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout1 -tclproc "Label_mmcm_connect_clk_out2"]
  set mmcmout2 [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout2 -tclproc "Label_mmcm_connect_clk_out3"]
  set mmcmout3 [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout3 -tclproc "Label_mmcm_connect_clk_out4"]
  set mmcmout4 [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout4 -tclproc "Label_mmcm_connect_clk_out5"]
  set mmcmout5 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name mmcmout5 -text "CLKOUT5"]
  set mmcmout6 [ipgui::add_static_text $IpView -parent $MMCMTable2 -name mmcmout6 -text "CLKOUT6"]
  set mmcmout0_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout0 -tclproc "Label_mmcm_rename_clk_out1"]
  set mmcmout1_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout1 -tclproc "Label_mmcm_rename_clk_out2"]
  set mmcmout2_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout2 -tclproc "Label_mmcm_rename_clk_out3"]
  set mmcmout3_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout3 -tclproc "Label_mmcm_rename_clk_out4"]
  set mmcmout4_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout4 -tclproc "Label_mmcm_rename_clk_out5"]
  set mmcmout5_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout5 -tclproc "Label_mmcm_rename_clk_out6"]
  set mmcmout6_re [ipgui::add_dynamic_text $IpView -parent $MMCMTable2 -name mmcmout6 -tclproc "Label_mmcm_rename_clk_out7"]
	set_property cell_location "1,0" $clock0
	set_property cell_location "0,0" $wizclockNames
	set_property cell_location "0,1" $wizclockreNames
	set_property cell_location "1,1" $mmcmout0_re
	set_property cell_location "2,1" $mmcmout1_re
	set_property cell_location "3,1" $mmcmout2_re
	set_property cell_location "4,1" $mmcmout3_re
	set_property cell_location "5,1" $mmcmout4_re
	set_property cell_location "6,1" $mmcmout5_re
	set_property cell_location "7,1" $mmcmout6_re
	set_property cell_location "0,2" $mmcmclockNames
	set_property cell_location "1,2" $mmcmout0
	set_property cell_location "2,2" $mmcmout1
	set_property cell_location "3,2" $mmcmout2
	set_property cell_location "4,2" $mmcmout3
	set_property cell_location "5,2" $mmcmout4
	set_property cell_location "6,2" $mmcmout5
	set_property cell_location "7,2" $mmcmout6
	set_property cell_location "0,3" $clockdiv
	set_property cell_location "0,4" $clockdut
	set_property cell_location "0,5" $clockpha
	set_property cell_location "0,6" $clockps
	set_property cell_location "2,0" $clock1
	set_property cell_location "3,0" $clock2
	set_property cell_location "4,0" $clock3
	set_property cell_location "5,0" $clock4
	set_property cell_location "6,0" $clock5
	set_property cell_location "7,0" $clock6

	for {set i 0} {$i < 7} {incr i} {
    set j [expr $i+1]
			EvalSubstituting {i j LabelName ParamName} {
        if { $i== "0"} {
			set MMCM_CLKOUT${i}_DIVIDE [ipgui::add_param  $IpView -parent $MMCMTable2 -name "MMCM_CLKOUT${i}_DIVIDE_F" -show_label false]
        } else {
			set MMCM_CLKOUT${i}_DIVIDE [ipgui::add_param  $IpView -parent $MMCMTable2 -name "MMCM_CLKOUT${i}_DIVIDE" -show_label false]
        }
			set MMCM_CLKOUT${i}_DUTY_CYCLE [ipgui::add_param  $IpView -parent $MMCMTable2 -name "MMCM_CLKOUT${i}_DUTY_CYCLE" -show_label false]
			set MMCM_CLKOUT${i}_PHASE [ipgui::add_param  $IpView -parent $MMCMTable2 -name "MMCM_CLKOUT${i}_PHASE" -show_label false]
			set MMCM_CLKOUT${i}_USE_FINE_PS [ipgui::add_param  $IpView -parent $MMCMTable2 -name "MMCM_CLKOUT${i}_USE_FINE_PS" -show_label false]
			set_property cell_location "$j,3" [set MMCM_CLKOUT${i}_DIVIDE]
			set_property cell_location "$j,4" [set MMCM_CLKOUT${i}_DUTY_CYCLE]
			set_property cell_location "$j,5" [set MMCM_CLKOUT${i}_PHASE]
			set_property cell_location "$j,6" [set MMCM_CLKOUT${i}_USE_FINE_PS]
		} 0
	}
	#ipgui::add_row $IpView -parent $page4_MMCM
	#ipgui::add_static_text $IpView -name ST1 -parent $page4_MMCM -text "Additional attributes are listed on the next page"
	ipgui::add_row $IpView -parent $page4_MMCM
	ipgui::add_dynamic_text $IpView -name Label_Mmcm_Override_Warning -parent $page4_MMCM -tclproc "Label_Mmcm_Override_Warning_SetText"
  #setMmcmParamRanges $IpView
}


proc create_page4_MMCM_2 {IpView} {
	set page4_MMCM [ipgui::get_pagespec page4_MMCM -of $IpView]
	set MMCM_2_Table [ipgui::add_table $IpView  -name "MMCM_2_Table" -rows "9" -columns "2" -parent $page4_MMCM -table_header true]
	set MMCM_2lable1 [ipgui::add_static_text  $IpView -name MMCM_2lable1 -parent $MMCM_2_Table -text "Attribute"]
	set_property cell_location "0,0" $MMCM_2lable1
	set MMCM_2lable2 [ipgui::add_static_text  $IpView -name MMCM_2lable2 -parent $MMCM_2_Table -text "Value"]
	set_property cell_location "0,1" $MMCM_2lable2
	
	set Labellist "CLKOUT5_DIVIDE CLKOUT5_DUTY_CYCLE CLKOUT5_PHASE CLKOUT5_USE_FINE_PS CLKOUT6_DIVIDE CLKOUT6_DUTY_CYCLE CLKOUT6_PHASE CLKOUT6_USE_FINE_PS"
					
	set Paramlist "MMCM_CLKOUT5_DIVIDE MMCM_CLKOUT5_DUTY_CYCLE MMCM_CLKOUT5_PHASE MMCM_CLKOUT5_USE_FINE_PS MMCM_CLKOUT6_DIVIDE MMCM_CLKOUT6_DUTY_CYCLE MMCM_CLKOUT6_PHASE MMCM_CLKOUT6_USE_FINE_PS"
					
	for {set i 0} {$i < 8} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		EvalSubstituting {i LabelName ParamName} {
			set LabelMMCM2Table [ipgui::add_static_text  $IpView -name $LabelName -parent $MMCM_2_Table -text "$LabelName"]
			set ParamMMCM2Table [ipgui::add_param  $IpView -parent $MMCM_2_Table -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelMMCM2Table
			set_property cell_location "$j,1" $ParamMMCM2Table
		} 0
	}
}

proc create_page5 {IpView} {	
	set page5 [ipgui::add_page $IpView -parent $IpView -name page5 -layout horizontal]
	set_property display_name "Port Renaming" $page5
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property visible false $page5
	 } else {
	 }
	#ipgui::add_dynamic_text $IpView -name Beta_Warning -parent $page5 -tclproc "Beta_Warning_SetText"
	#ipgui::add_row $IpView -parent $page5
  
  #set Summary [ipgui::add_panel $IpView -name Summary -parent $page5]
  # set ICS [ipgui::add_group $IpView -name "Input Clock" -parent $page5]	
	#set page5_Table [ipgui::add_table $IpView  -name "page5_Table" -rows "3" -columns "5" -parent $ICS -table_header true]
         #set_property tooltip "Renamed output port shows up in instantiation and timing reports" $page5_Table
	# set Label_Inclk_Sum_Inclk_Header [ipgui::add_static_text  $IpView -name Label_Inclk_Sum_Inclk_Header -parent $page5_Table -text "Input Clock"]
	# set Label_Inclk_Sum_Freq_Header_2 [ipgui::add_static_text  $IpView -name Label_Inclk_Sum_Freq_Header_2 -parent $page5_Table -text "Port Name"]
	# set Label_Inclk_Sum_Freq_Header [ipgui::add_static_text  $IpView -name Label_Inclk_Sum_Freq_Header -parent $page5_Table -text "Input Frequency (MHz)"]
	# set Label_Inclk_Sum_Time_Header [ipgui::add_static_text  $IpView -name Label_Inclk_Sum_Time_Header -parent $page5_Table -text "Time Period (ns)"]
	# set Label_Inclk_Sum_Jitter_Header [ipgui::add_dynamic_text  $IpView -name Label_Inclk_Sum_Jitter_Header -parent $page5_Table -tclproc "Label_Inclk_Sum_Jitter_Header_SetText"]
	# set Label_Inclk_Sum_Primary [ipgui::add_static_text  $IpView -name Label_Inclk_Sum_Primary -parent $page5_Table -text "Primary"]
	# set Inclk_Sum_Secondary [ipgui::add_static_text  $IpView -name Inclk_Sum_Secondary -parent $page5_Table -text "Secondary"]
	# set PRIMARY_PORT [ipgui::add_param  $IpView -parent $page5_Table -name "PRIMARY_PORT"]
	# set SECONDARY_PORT [ipgui::add_param  $IpView -parent $page5_Table -name "SECONDARY_PORT"]
	# set Inclk_Sum_Prim_Freq [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Prim_Freq -parent $page5_Table -tclproc "Inclk_Sum_Prim_Freq_SetText"]
	# set Inclk_Sum_Secondary_Freq [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Secondary_Freq -parent $page5_Table -tclproc "Inclk_Sum_Secondary_Freq_SetText"]
	# set Inclk_Sum_Prim_Time [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Prim_Time -parent $page5_Table -tclproc "Inclk_Sum_Prim_Time_SetText"]
	# set Inclk_Sum_Secondary_Time [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Secondary_Time -parent $page5_Table -tclproc "Inclk_Sum_Secondary_Time_SetText"]
	# set Inclk_Sum_Prim_Jitter [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Prim_Jitter -parent $page5_Table -tclproc "Inclk_Sum_Prim_Jitter_SetText"]
	# set Inclk_Sum_Secondary_Jitter [ipgui::add_dynamic_text $IpView -name Inclk_Sum_Secondary_Jitter -parent $page5_Table -tclproc "Inclk_Sum_Secondary_Jitter_SetText"]
	
	# set_property cell_location "0,0" $Label_Inclk_Sum_Inclk_Header
	# set_property cell_location "0,1" $Label_Inclk_Sum_Freq_Header_2
	# set_property cell_location "0,2" $Label_Inclk_Sum_Freq_Header
	# set_property cell_location "0,3" $Label_Inclk_Sum_Time_Header
	# set_property cell_location "0,4" $Label_Inclk_Sum_Jitter_Header
	# set_property cell_location "1,0" $Label_Inclk_Sum_Primary
	# set_property cell_location "2,0" $Inclk_Sum_Secondary
	# set_property cell_location "1,1" $PRIMARY_PORT
	# set_property cell_location "2,1" $SECONDARY_PORT
	# set_property cell_location "1,2" $Inclk_Sum_Prim_Freq
	# set_property cell_location "2,2" $Inclk_Sum_Secondary_Freq
	# set_property cell_location "2,3" $Inclk_Sum_Secondary_Time
	# set_property cell_location "1,3" $Inclk_Sum_Prim_Time
	# set_property cell_location "1,4" $Inclk_Sum_Prim_Jitter
	# set_property cell_location "2,4" $Inclk_Sum_Secondary_Jitter
	
	set panelpage5 [ipgui::add_panel $IpView -name panelpage5 -parent $page5]
	set PLATFORM [ipgui::add_param  $IpView -parent $panelpage5 -name "PLATFORM"]
	set summary [ipgui::add_param  $IpView -parent $panelpage5 -name "SUMMARY_STRINGS"]
	set_property visible false $PLATFORM
	set_property visible false $summary
	set_property enabled false $PLATFORM
	set_property enabled false $summary
	
	ipgui::add_row $IpView -parent $page5
	set Output_Clock_Summary [ipgui::add_group $IpView -parent $page5 -name Output_Clock_Summary ]
  set_property display_name "VCO Frequency" $Output_Clock_Summary
	set rel [ipgui::add_param  $IpView -parent $Output_Clock_Summary -name "RELATIVE_INCLK" -layout horizontal]
  set_property  display_name "VCO Frequency Relative To" $rel
	set panel1page5 [ipgui::add_panel $IpView -name panel1page5 -parent $Output_Clock_Summary -layout horizontal]
	ipgui::add_dynamic_text $IpView -name Label_Vco_Freq -parent $panel1page5 -tclproc "Label_Vco_Freq_SetText"
	ipgui::add_dynamic_text $IpView -name Label_Modulation_Freq -parent $panel1page5 -tclproc "Label_Modulation_Freq_SetText" 
	#ipgui::add_dynamic_text $IpView -name Jitter_DCM_Warning -parent $panel1page5 -tclproc "Jitter_DCM_Warning_SetText"
	#ipgui::add_dynamic_text $IpView -name Jitter_DCM_Warning_1 -parent $panel1page5 -tclproc "Jitter_DCM_Warning_1_SetText"
	ipgui::add_row $IpView -parent $Output_Clock_Summary
	
	# set page5_Table2 [ipgui::add_table $IpView  -name "page5_Table2" -rows "8" -columns "9" -parent $Output_Clock_Summary -table_header true]
	# #set_property show_grid true $page5_Table2
	# set Outclk_Sum_Output_Clock_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Output_Clock_Header -parent $page5_Table2 -text "Output Clock"]
	# set Outclk_Sum_Phase_Error_Header_2 [ipgui::add_static_text  $IpView -name Outclk_Sum_Phase_Error_Header_2 -parent $page5_Table2 -text "Port Name"]
        # set Outclk_Sum_Output_Freq_Header [ipgui::add_dynamic_text  $IpView -name Outclk_Sum_Output_Freq_Header -parent $page5_Table2 -tclproc "Outclk_Sum_Output_Freq_Header_SetText"]
	# set Outclk_Sum_Output_Timeperiod_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Output_Timeperiod_Header -parent $page5_Table2 -text "Output TimePeriod (ns)"]
	# set Outclk_Sum_Phase_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Phase_Header -parent $page5_Table2 -text "Phase (degrees)"]
	# set Outclk_Sum_Duty_Cycle_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Duty_Cycle_Header -parent $page5_Table2 -text "Duty Cycle (%)"]
	# set Outclk_Spread_Header [ipgui::add_static_text  $IpView -name OutClk_Spread_Header -parent $page5_Table2 -text "Tspread (ps)"]
	# set Outclk_Sum_Pktopk_Jitter_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Pktopk_Jitter_Header -parent $page5_Table2 -text "Pk-to-Pk Jitter (ps)"]
	# set Outclk_Sum_Phase_Error_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Phase_Error_Header -parent $page5_Table2 -text "Phase Error (ps)"]
	# set_property cell_location "0,0" $Outclk_Sum_Output_Clock_Header
	# set_property cell_location "0,1" $Outclk_Sum_Phase_Error_Header_2
	# set_property cell_location "0,2" $Outclk_Sum_Output_Freq_Header
	# set_property cell_location "0,3" $Outclk_Sum_Output_Timeperiod_Header
	# set_property cell_location "0,4" $Outclk_Sum_Phase_Header
	# set_property cell_location "0,5" $Outclk_Sum_Duty_Cycle_Header
	# set_property cell_location "0,6" $Outclk_Spread_Header
	# set_property cell_location "0,7" $Outclk_Sum_Pktopk_Jitter_Header
	# set_property cell_location "0,8" $Outclk_Sum_Phase_Error_Header
	
	# for {set i 1} {$i <= 7} {incr i} {
		# EvalSubstituting {i} {
			# set Label_Outclk_Sum_Clkout [ipgui::add_static_text  $IpView -name Label_Outclk_Sum_CLKOUT$i -parent $page5_Table2 -text "clk_out$i"]
			# set_property cell_location "$i,0" $Label_Outclk_Sum_Clkout
			# set CLK_OUT_port [ipgui::add_param  $IpView -parent $page5_Table2 -name "CLK_OUT${i}_PORT"]
			# set_property cell_location "$i,1" $CLK_OUT_port
			# set Outclk_Sum_Clkout_Out_Freq [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Out_Freq" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_Out_Freq_SetText"]
			# set_property cell_location "$i,2" $Outclk_Sum_Clkout_Out_Freq
			# set_property cell_location "$i,3" $Outclk_Sum_Clkout_Out_Freq
			# set Outclk_Sum_Clkout_Phase [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Phase" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_Phase_SetText"]
			# set_property cell_location "$i,4" $Outclk_Sum_Clkout_Phase
			# set Outclk_Sum_Clkout_Duty_Cycle [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Duty_Cycle" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_Duty_Cycle_SetText"]
			# set_property cell_location "$i,5" $Outclk_Sum_Clkout_Duty_Cycle
			# set Spread [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_TSpread" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_TSpread_SetText"]
			# set_property cell_location "$i,6" $Spread
			# set Outclk_Sum_Clkout_Pktopk_Jitter [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Pktopk_Jitter" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_Pktopk_Jitter_SetText"]
			# set_property cell_location "$i,7" $Outclk_Sum_Clkout_Pktopk_Jitter
			# set Outclk_Sum_Clkout_Phase_Error [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Phase_Error" -parent $page5_Table2 -tclproc "Outclk_Sum_Clkout$i_Phase_Error_SetText"]
			# set_property cell_location "$i,8" $Outclk_Sum_Clkout_Phase_Error
		# } 0
	# } 
	
	ipgui::add_row $IpView -parent $page5
  set PN [ipgui::add_group $IpView -name "Optional Port Names" -parent $page5 -layout horizontal]
	set page5_Table3 [ipgui::add_table $IpView  -name "page5_Table3" -rows "7" -columns "2" -parent $PN]
	set T3lable1 [ipgui::add_static_text  $IpView -name T3lable1 -parent $page5_Table3 -text "Other Pins"]
	set_property cell_location "0,0" $T3lable1
	set T3lable2 [ipgui::add_static_text  $IpView -name T3lable2 -parent $page5_Table3 -text "Port Name"]
	set_property cell_location "0,1" $T3lable2
	
	set Labellist "reset locked power_down clk_in_sel input_clk_stopped clkfb_stopped"
	set Paramlist "RESET_PORT LOCKED_PORT POWER_DOWN_PORT CLK_IN_SEL_PORT INPUT_CLK_STOPPED_PORT CLKFB_STOPPED_PORT"
					
	for {set i 0} {$i < 6} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		EvalSubstituting {i LabelName ParamName} {
            if { "$LabelName" == "reset" } {
                set LabelT3 [ipgui::add_dynamic_text $IpView -name "$LabelName" -parent $page5_Table3 -tclproc "Label_RESET_port_SetText"]
            } else {
    			set LabelT3 [ipgui::add_static_text  $IpView -name "$LabelName" -parent $page5_Table3 -text "$LabelName"]
            }    
			set ParamT3 [ipgui::add_param  $IpView -parent $page5_Table3 -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelT3
			set_property cell_location "$j,1" $ParamT3
		} 0
	}
	
	set page5_Table4 [ipgui::add_table $IpView  -name "page5_Table4" -rows "7" -columns "2" -parent $PN]
	set T4lable1 [ipgui::add_static_text  $IpView -name T4lable1 -parent $page5_Table4 -text "Other Pins"]
	set_property cell_location "0,0" $T4lable1
	set T4lable2 [ipgui::add_static_text  $IpView -name T4lable2 -parent $page5_Table4 -text "Port Name"]
	set_property cell_location "0,1" $T4lable2
	
	set Labellist "clkfb_in clkfb_in_p clkfb_in_n clkfb_out clkfb_out_p clkfb_out_n"
	set Paramlist "CLKFB_IN_PORT CLKFB_IN_P_PORT CLKFB_IN_N_PORT CLKFB_OUT_PORT CLKFB_OUT_P_PORT CLKFB_OUT_N_PORT"
					
	for {set i 0} {$i < 6} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		EvalSubstituting {i LabelName ParamName} {
			set LabelT4 [ipgui::add_static_text  $IpView -name "$LabelName" -parent $page5_Table4 -text "$LabelName"]
			set ParamT4 [ipgui::add_param  $IpView -parent $page5_Table4 -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelT4
			set_property cell_location "$j,1" $ParamT4
		} 0
	}
	
	set page5_Table5 [ipgui::add_table $IpView  -name "page5_Table5" -rows "8" -columns "2" -parent $PN]
	set T5lable1 [ipgui::add_static_text  $IpView -name T5lable1 -parent $page5_Table5 -text "Other Pins"]
	set_property cell_location "0,0" $T5lable1
	set T5lable2 [ipgui::add_static_text  $IpView -name T5lable2 -parent $page5_Table5 -text "Port Name"]
	set_property cell_location "0,1" $T5lable2
	
	set Labellist "daddr dclk drdy dwe din dout den"
	set Paramlist "DADDR_PORT DCLK_PORT DRDY_PORT DWE_PORT DIN_PORT DOUT_PORT DEN_PORT"
					
	for {set i 0} {$i < 7} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
	  	
		EvalSubstituting {i LabelName ParamName} {
			set LabelT5 [ipgui::add_static_text  $IpView -name "$LabelName" -parent $page5_Table5 -text "$LabelName"]
			set ParamT5 [ipgui::add_param  $IpView -parent $page5_Table5 -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelT5
			set_property cell_location "$j,1" $ParamT5
		} 0
	}
	
	set page5_Table6 [ipgui::add_table $IpView  -name "page5_Table6" -rows "5" -columns "2" -parent $PN]
	set T6lable1 [ipgui::add_static_text  $IpView -name T6lable1 -parent $page5_Table6 -text "Other Pins"]
	set_property cell_location "0,0" $T6lable1
	set T6lable2 [ipgui::add_static_text  $IpView -name T6lable2 -parent $page5_Table6 -text "Port Name"]
	set_property cell_location "0,1" $T6lable2
	
	set Labellist "psclk psen psincdec psdone"
	set Paramlist "PSCLK_PORT PSEN_PORT PSINCDEC_PORT PSDONE_PORT"
					
	for {set i 0} {$i < 4} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		EvalSubstituting {i LabelName ParamName} {
			set LabelT5 [ipgui::add_static_text  $IpView -name "$LabelName" -parent $page5_Table6 -text "$LabelName"]
			set ParamT5 [ipgui::add_param  $IpView -parent $page5_Table6 -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelT5
			set_property cell_location "$j,1" $ParamT5
		} 0
	}

	set page5_Table7 [ipgui::add_table $IpView  -name "page5_Table7" -rows "3" -columns "2" -parent $PN]
	set T7lable1 [ipgui::add_static_text  $IpView -name T7lable1 -parent $page5_Table7 -text "CDDC Pins"]
	set_property cell_location "0,0" $T7lable1
	set T7lable2 [ipgui::add_static_text  $IpView -name T7lable2 -parent $page5_Table7 -text "Port Name"]
	set_property cell_location "0,1" $T7lable2
	
	set Labellist "cddcreq cddcdone"
	set Paramlist "CDDCREQ_PORT CDDCDONE_PORT"
					
	for {set i 0} {$i < 2} {incr i} {
		set LabelName [lindex $Labellist $i]
		set ParamName [lindex $Paramlist $i]
		
		EvalSubstituting {i LabelName ParamName} {
			set LabelT5 [ipgui::add_static_text  $IpView -name "$LabelName" -parent $page5_Table7 -text "$LabelName"]
			set ParamT5 [ipgui::add_param  $IpView -parent $page5_Table7 -name "$ParamName"]
			set j [expr "$i +1"]
			set_property cell_location "$j,0" $LabelT5
			set_property cell_location "$j,1" $ParamT5
		} 0
	}

        set diff_param_clk1 [ipgui::add_param  $IpView -parent $page5 -name DIFF_CLK_IN1_BOARD_INTERFACE]
        set diff_param_clk2 [ipgui::add_param  $IpView -parent $page5 -name DIFF_CLK_IN2_BOARD_INTERFACE]
	set_property visible false $diff_param_clk1
	set_property visible false $diff_param_clk2

  #set_property tooltip "Port renaming and output clock summary. Renamed output port shows up in instantiation and timing reports" $page5_Table2
  set_property tooltip "Port renaming. Renamed output port shows up in instantiation and timing reports" $page5_Table3
  set_property tooltip "Port renaming. Renamed output port shows up in instantiation and timing reports" $page5_Table4
  set_property tooltip "Port renaming. Renamed output port shows up in instantiation and timing reports" $page5_Table5
  set_property tooltip "Port renaming. Renamed output port shows up in instantiation and timing reports" $page5_Table6
  set_property tooltip "Port renaming. Renamed output port shows up in instantiation and timing reports" $page5_Table7

	set CLKOUT1_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT1_JITTER]
	set CLKOUT1_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT1_PHASE_ERROR]
	set CLKOUT2_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT2_JITTER]
	set CLKOUT2_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT2_PHASE_ERROR]
	set CLKOUT3_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT3_JITTER]
	set CLKOUT3_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT3_PHASE_ERROR]
	set CLKOUT4_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT4_JITTER]
	set CLKOUT4_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT4_PHASE_ERROR]
	set CLKOUT5_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT5_JITTER]
	set CLKOUT5_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT5_PHASE_ERROR]
	set CLKOUT6_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT6_JITTER]
	set CLKOUT6_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT6_PHASE_ERROR]
	set CLKOUT7_JITTER	 [ipgui::add_param  $IpView -parent $page5 -name CLKOUT7_JITTER]
	set CLKOUT7_PHASE_ERROR [ipgui::add_param  $IpView -parent $page5 -name CLKOUT7_PHASE_ERROR]

	set_property visible false $CLKOUT1_JITTER
	set_property visible false $CLKOUT1_PHASE_ERROR
	set_property visible false $CLKOUT2_JITTER
	set_property visible false $CLKOUT2_PHASE_ERROR
	set_property visible false $CLKOUT3_JITTER
	set_property visible false $CLKOUT3_PHASE_ERROR
	set_property visible false $CLKOUT4_JITTER
	set_property visible false $CLKOUT4_PHASE_ERROR
	set_property visible false $CLKOUT5_JITTER
	set_property visible false $CLKOUT5_PHASE_ERROR
	set_property visible false $CLKOUT6_JITTER
	set_property visible false $CLKOUT6_PHASE_ERROR
	set_property visible false $CLKOUT7_JITTER
	set_property visible false $CLKOUT7_PHASE_ERROR
	ipgui::add_row $IpView -parent $page5
  

}

proc create_page6 {IpView} {

	set page6 [ipgui::add_page $IpView -parent $IpView -name page6 -layout vertical]
	set_property display_name "Summary" $page6
#ipgui::add_static_text  $IpView -name Label_Xpower_Table -parent $page6 -text "XPower Estimator input parameters"
# ipgui::add_row $IpView -parent $page6

	set one_in_clk_sum [ipgui::add_group $IpView -name "Primary Input Clock Attributes" -parent $page6]
	set page6_inclk [ipgui::add_table $IpView  -name "page6_inclk" -rows "3" -columns "2" -parent $one_in_clk_sum]
	set Header_pri_Inclk [ipgui::add_dynamic_text $IpView -name Header_pri_Inclk -parent $page6_inclk -tclproc "Header_Xpe_Inclk_SetText"]
   set Header_pri_source [ipgui::add_static_text  $IpView -name Header_pri_source -parent $page6_inclk -text "<b>Clock Source</b>"]
   set Header_pri_jitter [ipgui::add_static_text  $IpView -name Header_pri_jitter -parent $page6_inclk -text "<b>Jitter</b>"]
    
	set Header_pri_Inclk_val [ipgui::add_dynamic_text $IpView -name Header_pri_Inclk_val -parent $page6_inclk -tclproc "Inclk_Sum_Prim_Freq_SetText"]
	set Header_pri_source_val [ipgui::add_dynamic_text $IpView -name Header_pri_source_val -parent $page6_inclk -tclproc "Inclk_Sum_Prim_Source_SetText"]
	set Header_pri_jitter_val [ipgui::add_dynamic_text $IpView -name Header_pri_jitter_val -parent $page6_inclk -tclproc "Inclk_Sum_Prim_Jitter_SetText"]
   
   set_property cell_location "0,0" $Header_pri_Inclk
   set_property cell_location "1,0" $Header_pri_source
   set_property cell_location "2,0" $Header_pri_jitter
   
   set_property cell_location "0,1" $Header_pri_Inclk_val
   set_property cell_location "1,1" $Header_pri_source_val
   set_property cell_location "2,1" $Header_pri_jitter_val


	set two_in_clk_sum [ipgui::add_group $IpView -name "Secondary Input Clock Attributes" -parent $page6]
	set page6_se_inclk [ipgui::add_table $IpView  -name "page6_se_inclk" -rows "3" -columns "2" -parent $two_in_clk_sum]
	set Header_se_Inclk [ipgui::add_dynamic_text $IpView -name Header_se_Inclk -parent $page6_se_inclk -tclproc "Header_Xpe_Inclk_SetText"]
   set Header_se_source [ipgui::add_static_text  $IpView -name Header_se_source -parent $page6_se_inclk -text "<b>Clock Source</b>"]
   set Header_se_jitter [ipgui::add_static_text  $IpView -name Header_se_jitter -parent $page6_se_inclk -text "<b>Jitter</b>"]
    
	set Header_se_Inclk_val [ipgui::add_dynamic_text $IpView -name Header_se_Inclk_val -parent $page6_se_inclk -tclproc "Inclk_Sum_Secondary_Freq_SetText"]
	set Header_se_source_val [ipgui::add_dynamic_text $IpView -name Header_se_source_val -parent $page6_se_inclk -tclproc "Inclk_Sum_Secondary_Source_SetText"]
	set Header_se_jitter_val [ipgui::add_dynamic_text $IpView -name Header_se_jitter_val -parent $page6_se_inclk -tclproc "Inclk_Sum_Secondary_Jitter_SetText"]
   
   set_property cell_location "0,0" $Header_se_Inclk
   set_property cell_location "1,0" $Header_se_source
   set_property cell_location "2,0" $Header_se_jitter
   
   set_property cell_location "0,1" $Header_se_Inclk_val
   set_property cell_location "1,1" $Header_se_source_val
   set_property cell_location "2,1" $Header_se_jitter_val

	#set GB1 [ipgui::add_group $IpView -name GB1 -parent $page6]
	#set_property display_name "" $GB1
	set prim_attributes [ipgui::add_group $IpView -name "Clocking Primitive Attributes" -parent $page6]
   ipgui::add_dynamic_text $IpView -name prim_instantiated -parent $prim_attributes -tclproc "Label_Prim_Instantiated_SetText"
   ipgui::add_dynamic_text $IpView -name prim_divide -parent $prim_attributes -tclproc "Label_Divide_Counter_SetText"
   ipgui::add_dynamic_text $IpView -name prim_mult -parent $prim_attributes -tclproc "Label_Mult_Counter_SetText"
	ipgui::add_dynamic_text $IpView -name Label_Xpe_Phase_Shift -parent $prim_attributes -tclproc "Label_Xpe_Phase_Shift_SetText"



	set page6_Table1 [ipgui::add_table $IpView  -name "page6_Table1" -rows "8" -columns "6" -parent $prim_attributes -table_header true]
	set_property show_grid true $page6_Table1
#set Header_Xpe_Core_Name [ipgui::add_static_text  $IpView -name Header_Xpe_Core_Name -parent $page6_Table1 -text "Core Name"]
set Header_Xpe_Core_Name [ipgui::add_static_text  $IpView -name Header_Xpe_Core_Name -parent $page6_Table1 -text "Clock Wiz O/p Pins"]
	set Header_Xpe_Inclk [ipgui::add_dynamic_text $IpView -name Header_Xpe_Inclk -parent $page6_Table1 -tclproc "Header_Xpe_Inclk_SetText"]
	set Source_wizard [ipgui::add_dynamic_text $IpView -name Source_wizard -parent $page6_Table1 -tclproc "Source_wizard"]
	 set Outclk_Spread_Header [ipgui::add_static_text  $IpView -name OutClk_Spread_Header -parent $page6_Table1 -text "Tspread (ps)"]
	 set Outclk_Sum_Pktopk_Jitter_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Pktopk_Jitter_Header -parent $page6_Table1 -text "Pk-to-Pk Jitter (ps)"]
	 set Outclk_Sum_Phase_Error_Header [ipgui::add_static_text  $IpView -name Outclk_Sum_Phase_Error_Header -parent $page6_Table1 -text "Phase Error (ps)"]

	
	set Header_Xpe_Phase_Shift [ipgui::add_static_text  $IpView -name Header_Xpe_Phase_Shift -parent $page6_Table1 -text "Phase Shift"]
#set Label_Xpe_Core_Name [ipgui::add_dynamic_text $IpView -name Label_Xpe_Core_Name -parent $page6_Table1 -tclproc "Label_Xpe_Core_Name_SetText"]
set Label_Xpe_Core_Name [ipgui::add_static_text $IpView -name Label_Xpe_Core_Name -parent $page6_Table1 -text "Divider Value"]
set Label2_Xpe_Core_Name [ipgui::add_static_text $IpView -name Label_Xpe_Core_Name -parent $page6_Table1 -text "Source                                                                "]
	set Label_Xpe_Inclk [ipgui::add_dynamic_text $IpView -name Label_Xpe_Inclk -parent $page6_Table1 -tclproc "Label_Xpe_Inclk_SetText"]
	set Label_Xpe_Phase_Shift [ipgui::add_dynamic_text $IpView -name Label_Xpe_Phase_Shift -parent $page6_Table1 -tclproc "Label_Xpe_Phase_Shift_SetText"]
	
	set Label_Name_Clkout1 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout1 -parent $page6_Table1 -tclproc "Label_Clkout1_Name_SetText"]
	set Label_Name_Clkout2 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout2 -parent $page6_Table1 -tclproc "Label_Clkout2_Name_SetText"]
	set Label_Name_Clkout3 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout3 -parent $page6_Table1 -tclproc "Label_Clkout3_Name_SetText"]
	set Label_Name_Clkout4 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout4 -parent $page6_Table1 -tclproc "Label_Clkout4_Name_SetText"]
	set Label_Name_Clkout5 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout5 -parent $page6_Table1 -tclproc "Label_Clkout5_Name_SetText"]
	set Label_Name_Clkout6 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout6 -parent $page6_Table1 -tclproc "Label_Clkout6_Name_SetText"]
	set Label_Name_Clkout7 [ipgui::add_dynamic_text $IpView -name Label_Name_Clkout7 -parent $page6_Table1 -tclproc "Label_Clkout7_Name_SetText"]

	set Label_Source_Clkout1 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout1 -parent $page6_Table1 -tclproc "Label_Clkout1_Source_SetText"]
	set Label_Source_Clkout2 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout2 -parent $page6_Table1 -tclproc "Label_Clkout2_Source_SetText"]
	set Label_Source_Clkout3 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout3 -parent $page6_Table1 -tclproc "Label_Clkout3_Source_SetText"]
	set Label_Source_Clkout4 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout4 -parent $page6_Table1 -tclproc "Label_Clkout4_Source_SetText"]
	set Label_Source_Clkout5 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout5 -parent $page6_Table1 -tclproc "Label_Clkout5_Source_SetText"]
	set Label_Source_Clkout6 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout6 -parent $page6_Table1 -tclproc "Label_Clkout6_Source_SetText"]
	set Label_Source_Clkout7 [ipgui::add_dynamic_text $IpView -name Label_Source_Clkout7 -parent $page6_Table1 -tclproc "Label_Clkout7_Source_SetText"]
  
	set Label_Divide_Clkout1 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout1 -parent $page6_Table1 -tclproc "Label_Clkout1_Divider_SetText"]
	set Label_Divide_Clkout2 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout2 -parent $page6_Table1 -tclproc "Label_Clkout2_Divider_SetText"]
	set Label_Divide_Clkout3 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout3 -parent $page6_Table1 -tclproc "Label_Clkout3_Divider_SetText"]
	set Label_Divide_Clkout4 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout4 -parent $page6_Table1 -tclproc "Label_Clkout4_Divider_SetText"]
	set Label_Divide_Clkout5 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout5 -parent $page6_Table1 -tclproc "Label_Clkout5_Divider_SetText"]
	set Label_Divide_Clkout6 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout6 -parent $page6_Table1 -tclproc "Label_Clkout6_Divider_SetText"]
	set Label_Divide_Clkout7 [ipgui::add_dynamic_text $IpView -name Label_Divide_Clkout7 -parent $page6_Table1 -tclproc "Label_Clkout7_Divider_SetText"]

   set_property cell_location "0,0" $Header_Xpe_Core_Name
	set_property cell_location "0,1" $Label2_Xpe_Core_Name
	set_property cell_location "0,2" $Label_Xpe_Core_Name
	set_property cell_location "0,3" $Outclk_Spread_Header
	set_property cell_location "0,4" $Outclk_Sum_Pktopk_Jitter_Header
	set_property cell_location "0,5" $Outclk_Sum_Phase_Error_Header
   
   set_property cell_location "1,0" $Label_Name_Clkout1
   set_property cell_location "2,0" $Label_Name_Clkout2
   set_property cell_location "3,0" $Label_Name_Clkout3
   set_property cell_location "4,0" $Label_Name_Clkout4
   set_property cell_location "5,0" $Label_Name_Clkout5
   set_property cell_location "6,0" $Label_Name_Clkout6
   set_property cell_location "7,0" $Label_Name_Clkout7
	
   set_property cell_location "1,1" $Label_Source_Clkout1
	set_property cell_location "2,1" $Label_Source_Clkout2
	set_property cell_location "3,1" $Label_Source_Clkout3
	set_property cell_location "4,1" $Label_Source_Clkout4
	set_property cell_location "5,1" $Label_Source_Clkout5
	set_property cell_location "6,1" $Label_Source_Clkout6
	set_property cell_location "7,1" $Label_Source_Clkout7
	
   set_property cell_location "1,2" $Label_Divide_Clkout1
   set_property cell_location "2,2" $Label_Divide_Clkout2
   set_property cell_location "3,2" $Label_Divide_Clkout3
   set_property cell_location "4,2" $Label_Divide_Clkout4
   set_property cell_location "5,2" $Label_Divide_Clkout5
   set_property cell_location "6,2" $Label_Divide_Clkout6
   set_property cell_location "7,2" $Label_Divide_Clkout7

   	 for {set i 1} {$i <= 7} {incr i} {
		 EvalSubstituting {i} {
			 set Spread [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_TSpread" -parent $page6_Table1 -tclproc "Outclk_Sum_Clkout$i_TSpread_SetText"]
			 set_property cell_location "$i,3" $Spread
			 set Outclk_Sum_Clkout_Pktopk_Jitter [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Pktopk_Jitter" -parent $page6_Table1 -tclproc "Outclk_Sum_Clkout$i_Pktopk_Jitter_SetText"]
			 set_property cell_location "$i,4" $Outclk_Sum_Clkout_Pktopk_Jitter
			 set Outclk_Sum_Clkout_Phase_Error [ipgui::add_dynamic_text $IpView -name "Outclk_Sum_Clkout$i_Phase_Error" -parent $page6_Table1 -tclproc "Outclk_Sum_Clkout$i_Phase_Error_SetText"]
			 set_property cell_location "$i,5" $Outclk_Sum_Clkout_Phase_Error
		 } 0
	 } 
	

  #ipgui::add_static_text $IpView -name ST1 -text " " -parent $page6
  #ipgui::add_row $IpView -parent $page6
	
	#set GB2 [ipgui::add_group $IpView -name GB2 -parent $page6]
	#set_property display_name "" $GB2
#set page6_Table2 [ipgui::add_table $IpView  -name "page6_Table2" -rows "9" -columns "2" -parent $page6]
#  set page6_Table2 $page6_Table1
	##set Labellist {"CLKOUT0" "CLKOUT1" "CLKOUT2" "CLKOUT3" "CLKOUT4" "CLKOUT5" "CLKOUT6"}
	##set Metalablelist "Label_Clkout_Divider Label_Clkout1_Divider Label_Clkout2_Divider Label_Clkout3_Divider Label_Clkout4_Divider Label_Clkout5_Divider Label_Clkout6_Divider Label_Clkout7_Divider"
	##for {set i 1} {$i < 9} {incr i} {
	##	set LabelName [lindex $Labellist $i]
	##	set MetaLableName [lindex $Metalablelist $i]
	##	
	##	EvalSubstituting {i LabelName MetaLableName} {
   ##   set j [expr $i]
	##		set page6_TableLableName [ipgui::add_static_text  $IpView -name page6_TableLable$i -parent $page6_Table1 -text "$LabelName"]
	##		set_property cell_location "$j,0" $page6_TableLableName
	##		set page6_TableMetaLableName [ipgui::add_dynamic_text $IpView -name $MetaLableName -parent $page6_Table1 -tclproc "$MetaLableName_SetText"]
	##		set_property cell_location "$j,2" $page6_TableMetaLableName
	##	} 0
	##}
	
	
}



 proc  create_DRPreg {IpView } {

	set create_DRPreg [ipgui::add_page $IpView -parent $IpView -name create_DRPreg -layout horizontal]
	set_property display_name "DRP Registers" $create_DRPreg
    set Register_Table [ipgui::add_group $IpView -parent $create_DRPreg -name "Register_Table" -layout horizontal]
	set table_drp_reg [ipgui::add_table $IpView  -name "table_drp_reg" -rows "24" -columns "3" -parent $Register_Table -table_header true -layout horizontal]
  add_static_text $IpView -name spaces -parent create_DRPreg -text "           "
     set Registers [ipgui::add_static_text  $IpView -name Registers -parent  $table_drp_reg -text "DRP Register Name"]
     set Address [ipgui::add_static_text  $IpView -name Registers -parent  $table_drp_reg -text "Register Address"]
     set Values [ipgui::add_static_text  $IpView -name Values -parent  $table_drp_reg -text "Register Values"]
     
	 set Power [ipgui::add_static_text  $IpView -name Power -parent  $table_drp_reg -text "Power Reg"]
	 set CLKOUT0_1 [ipgui::add_static_text  $IpView -name CLKOUT0_1 -parent  $table_drp_reg -text "CLKOUT0 Reg1"]
	 set CLKOUT0_2 [ipgui::add_static_text  $IpView -name CLKOUT0_2 -parent  $table_drp_reg -text "CLKOUT0 Reg2"]
	 set CLKOUT1_1 [ipgui::add_static_text  $IpView -name CLKOUT1_1 -parent  $table_drp_reg -text "CLKOUT1 Reg1"]
	 set CLKOUT1_2 [ipgui::add_static_text  $IpView -name CLKOUT1_2 -parent  $table_drp_reg -text "CLKOUT1 Reg2"]
	 set CLKOUT2_1 [ipgui::add_static_text  $IpView -name CLKOUT2_1 -parent  $table_drp_reg -text "CLKOUT2 Reg1"]
	 set CLKOUT2_2 [ipgui::add_static_text  $IpView -name CLKOUT2_2 -parent  $table_drp_reg -text "CLKOUT2 Reg2"]
	 set CLKOUT3_1 [ipgui::add_static_text  $IpView -name CLKOUT3_1 -parent  $table_drp_reg -text "CLKOUT3 Reg1"]
	 set CLKOUT3_2 [ipgui::add_static_text  $IpView -name CLKOUT3_2 -parent  $table_drp_reg -text "CLKOUT3 Reg2"]
	 set CLKOUT4_1 [ipgui::add_static_text  $IpView -name CLKOUT4_1 -parent  $table_drp_reg -text "CLKOUT4 Reg1"]
	 set CLKOUT4_2 [ipgui::add_static_text  $IpView -name CLKOUT4_2 -parent  $table_drp_reg -text "CLKOUT4 Reg2"]
	 set CLKOUT5_1 [ipgui::add_static_text  $IpView -name CLKOUT5_1 -parent  $table_drp_reg -text "CLKOUT5 Reg1"]
	 set CLKOUT5_2 [ipgui::add_static_text  $IpView -name CLKOUT5_2 -parent  $table_drp_reg -text "CLKOUT5 Reg2"]
	 set CLKOUT6_1 [ipgui::add_static_text  $IpView -name CLKOUT6_1 -parent  $table_drp_reg -text "CLKOUT6 Reg1"]
	 set CLKOUT6_2 [ipgui::add_static_text  $IpView -name CLKOUT6_2 -parent  $table_drp_reg -text "CLKOUT6 Reg2"]
	 set DIV_CLK [ipgui::add_static_text  $IpView -name DIV_CLK -parent  $table_drp_reg -text "DIV_CLK Reg"]
	 set CLKFBOUT_1 [ipgui::add_static_text  $IpView -name CLKFBOUT_1 -parent  $table_drp_reg -text "CLKFBOUT Reg1"]
	 set CLKFBOUT_2 [ipgui::add_static_text  $IpView -name CLKFBOUT_2 -parent  $table_drp_reg -text "CLKFBOUT Reg2"]
	 set LOCK_1 [ipgui::add_static_text  $IpView -name LOCK_1 -parent  $table_drp_reg -text "LOCK Reg1"]
	 set LOCK_2 [ipgui::add_static_text  $IpView -name LOCK_2 -parent  $table_drp_reg -text "LOCK Reg2"]
	 set LOCK_3 [ipgui::add_static_text  $IpView -name LOCK_3 -parent  $table_drp_reg -text "LOCK Reg3"]
	 set FILTER_1 [ipgui::add_static_text  $IpView -name Filter_1 -parent  $table_drp_reg -text "Filter Reg1"]
	 set FILTER_2 [ipgui::add_static_text  $IpView -name Filter_2 -parent  $table_drp_reg -text "Filter Reg2 "]
     
     set Power_Addr [ipgui::add_static_text  $IpView -name Power -parent  $table_drp_reg -text "0x300"]
	 set CLKOUT0_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT0_1 -parent  $table_drp_reg -text "0x304"]
	 set CLKOUT0_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT0_2 -parent  $table_drp_reg -text "0x308"]
	 set CLKOUT1_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT1_1 -parent  $table_drp_reg -text "0x30C"]
	 set CLKOUT1_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT1_2 -parent  $table_drp_reg -text "0x310"]
	 set CLKOUT2_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT2_1 -parent  $table_drp_reg -text "0x314"]
	 set CLKOUT2_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT2_2 -parent  $table_drp_reg -text "0x318"]
	 set CLKOUT3_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT3_1 -parent  $table_drp_reg -text "0x31C"]
	 set CLKOUT3_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT3_2 -parent  $table_drp_reg -text "0x320"]
	 set CLKOUT4_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT4_1 -parent  $table_drp_reg -text "0x324"]
	 set CLKOUT4_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT4_2 -parent  $table_drp_reg -text "0x328"]
	 set CLKOUT5_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT5_1 -parent  $table_drp_reg -text "0x32C"]
	 set CLKOUT5_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT5_2 -parent  $table_drp_reg -text "0x330"]
	 set CLKOUT6_1_Addr [ipgui::add_static_text  $IpView -name CLKOUT6_1 -parent  $table_drp_reg -text "0x334"]
	 set CLKOUT6_2_Addr [ipgui::add_static_text  $IpView -name CLKOUT6_2 -parent  $table_drp_reg -text "0x338"]
	 set DIV_CLK_Addr [ipgui::add_static_text  $IpView -name DIV_CLK -parent  $table_drp_reg -text "0x33C"]
	 set CLKFBOUT_1_Addr [ipgui::add_static_text  $IpView -name CLKFBOUT_1 -parent  $table_drp_reg -text "0x340"]
	 set CLKFBOUT_2_Addr [ipgui::add_static_text  $IpView -name CLKFBOUT_2 -parent  $table_drp_reg -text "0x344"]
	 set LOCK_1_Addr [ipgui::add_static_text  $IpView -name LOCK_1 -parent  $table_drp_reg -text "0x348"]
	 set LOCK_2_Addr [ipgui::add_static_text  $IpView -name LOCK_2 -parent  $table_drp_reg -text "0x34C"]
	 set LOCK_3_Addr [ipgui::add_static_text  $IpView -name LOCK_3 -parent  $table_drp_reg -text "0x350"]
	 set FILTER_1_Addr [ipgui::add_static_text  $IpView -name Filter_1 -parent  $table_drp_reg -text "0x354"]
	 set FILTER_2_Addr [ipgui::add_static_text  $IpView -name Filter_2 -parent  $table_drp_reg -text "0x358"]


     set Power_reg [ipgui::add_dynamic_text $IpView -name Power_reg(0x300) -parent $table_drp_reg -tclproc "Power_Register_proc"]
     set CLKOUT0_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT0_1_reg(0x304) -parent $table_drp_reg -tclproc "CLKOUT0_1_proc"]
     set CLKOUT0_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT0_2_reg(0x308) -parent $table_drp_reg -tclproc "CLKOUT0_2_proc"]
     set CLKOUT1_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT1_1_reg(0x30C) -parent $table_drp_reg -tclproc "CLKOUT1_1_proc"]
     set CLKOUT1_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT1_2_reg(0x310) -parent $table_drp_reg -tclproc "CLKOUT1_2_proc"]
     set CLKOUT2_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT2_1_reg(0x314) -parent $table_drp_reg -tclproc "CLKOUT2_1_proc"]
     set CLKOUT2_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT2_2_reg(0x318) -parent $table_drp_reg -tclproc "CLKOUT2_2_proc"]
     set CLKOUT3_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT3_1_reg(0x31C) -parent $table_drp_reg -tclproc "CLKOUT3_1_proc"]
     set CLKOUT3_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT3_2_reg(0x320) -parent $table_drp_reg -tclproc "CLKOUT3_2_proc"]
     set CLKOUT4_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT4_1_reg(0x324) -parent $table_drp_reg -tclproc "CLKOUT4_1_proc"]
     set CLKOUT4_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT4_2_reg(0x328) -parent $table_drp_reg -tclproc "CLKOUT4_2_proc"]
     set CLKOUT5_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT5_1_reg(0x32C) -parent $table_drp_reg -tclproc "CLKOUT5_1_proc"]
     set CLKOUT5_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT5_2_reg(0x330) -parent $table_drp_reg -tclproc "CLKOUT5_2_proc"]
     set CLKOUT6_1_reg [ipgui::add_dynamic_text $IpView -name CLKOUT6_1_reg(0x334) -parent $table_drp_reg -tclproc "CLKOUT6_1_proc"]
     set CLKOUT6_2_reg [ipgui::add_dynamic_text $IpView -name CLKOUT6_2_reg(0x338) -parent $table_drp_reg -tclproc "CLKOUT6_2_proc"]
     set DIV_CLK_reg [ipgui::add_dynamic_text $IpView -name DIV_CLK_reg(0x33C) -parent $table_drp_reg -tclproc "DIV_CLK_proc"]
     set CLKFBOUT_1_reg [ipgui::add_dynamic_text $IpView -name CLKFBOUT_1_reg(0x340) -parent $table_drp_reg -tclproc "CLKFBOUT_1_proc"]
     set CLKFBOUT_2_reg [ipgui::add_dynamic_text $IpView -name CLKFBOUT_2_reg(0x344) -parent $table_drp_reg -tclproc "CLKFBOUT_2_proc"]
     set LOCK_1_reg [ipgui::add_dynamic_text $IpView -name LOCK_1_reg(0x348) -parent $table_drp_reg -tclproc "LOCK_1_proc"]
     set LOCK_2_reg [ipgui::add_dynamic_text $IpView -name LOCK_2_reg(0x34C) -parent $table_drp_reg -tclproc "LOCK_2_proc"]
     set LOCK_3_reg [ipgui::add_dynamic_text $IpView -name LOCK_3_reg(0x350) -parent $table_drp_reg -tclproc "LOCK_3_proc"]
     set FILTER_1_reg [ipgui::add_dynamic_text $IpView -name FILTER_1_reg(0x354) -parent $table_drp_reg -tclproc "FILTER_1_proc"]
     set FILTER_2_reg [ipgui::add_dynamic_text $IpView -name FILTER_2_reg(0x358) -parent $table_drp_reg -tclproc "FILTER_2_proc"]

     set_property cell_location "0,0" $Registers 
     set_property cell_location "0,2" $Values
     set_property cell_location "0,1" $Address
     
	 set_property cell_location "1,0" $Power 
	 set_property cell_location "2,0" $CLKOUT0_1 
	 set_property cell_location "3,0" $CLKOUT0_2
	 set_property cell_location "4,0" $CLKOUT1_1
	 set_property cell_location "5,0" $CLKOUT1_2
	 set_property cell_location "6,0" $CLKOUT2_1
	 set_property cell_location "7,0" $CLKOUT2_2
	 set_property cell_location "8,0" $CLKOUT3_1
	 set_property cell_location "9,0" $CLKOUT3_2
	 set_property cell_location "10,0" $CLKOUT4_1
	 set_property cell_location "11,0" $CLKOUT4_2
	 set_property cell_location "12,0" $CLKOUT5_1
	 set_property cell_location "13,0" $CLKOUT5_2
	 set_property cell_location "14,0" $CLKOUT6_1
	 set_property cell_location "15,0" $CLKOUT6_2
	 set_property cell_location "16,0" $DIV_CLK
	 set_property cell_location "17,0" $CLKFBOUT_1
	 set_property cell_location "18,0" $CLKFBOUT_2
	 set_property cell_location "19,0" $LOCK_1
	 set_property cell_location "20,0" $LOCK_2
	 set_property cell_location "21,0" $LOCK_3
	 set_property cell_location "22,0" $FILTER_1
	 set_property cell_location "23,0" $FILTER_2
     
	 set_property cell_location "1,1" $Power_Addr
	 set_property cell_location "2,1" $CLKOUT0_1_Addr
	 set_property cell_location "3,1" $CLKOUT0_2_Addr
	 set_property cell_location "4,1" $CLKOUT1_1_Addr
	 set_property cell_location "5,1" $CLKOUT1_2_Addr
	 set_property cell_location "6,1" $CLKOUT2_1_Addr
	 set_property cell_location "7,1" $CLKOUT2_2_Addr
	 set_property cell_location "8,1" $CLKOUT3_1_Addr
	 set_property cell_location "9,1" $CLKOUT3_2_Addr
	 set_property cell_location "10,1" $CLKOUT4_1_Addr
	 set_property cell_location "11,1" $CLKOUT4_2_Addr
	 set_property cell_location "12,1" $CLKOUT5_1_Addr
	 set_property cell_location "13,1" $CLKOUT5_2_Addr
	 set_property cell_location "14,1" $CLKOUT6_1_Addr
	 set_property cell_location "15,1" $CLKOUT6_2_Addr
	 set_property cell_location "16,1" $DIV_CLK_Addr
	 set_property cell_location "17,1" $CLKFBOUT_1_Addr
	 set_property cell_location "18,1" $CLKFBOUT_2_Addr
	 set_property cell_location "19,1" $LOCK_1_Addr
	 set_property cell_location "20,1" $LOCK_2_Addr
	 set_property cell_location "21,1" $LOCK_3_Addr
	 set_property cell_location "22,1" $FILTER_1_Addr
	 set_property cell_location "23,1" $FILTER_2_Addr
     
	 set_property cell_location "1,2" $Power_reg
	 set_property cell_location "2,2" $CLKOUT0_1_reg
	 set_property cell_location "3,2" $CLKOUT0_2_reg
	 set_property cell_location "4,2" $CLKOUT1_1_reg
	 set_property cell_location "5,2" $CLKOUT1_2_reg
	 set_property cell_location "6,2" $CLKOUT2_1_reg
	 set_property cell_location "7,2" $CLKOUT2_2_reg
	 set_property cell_location "8,2" $CLKOUT3_1_reg
	 set_property cell_location "9,2" $CLKOUT3_2_reg
	 set_property cell_location "10,2" $CLKOUT4_1_reg
	 set_property cell_location "11,2" $CLKOUT4_2_reg
	 set_property cell_location "12,2" $CLKOUT5_1_reg
	 set_property cell_location "13,2" $CLKOUT5_2_reg
	 set_property cell_location "14,2" $CLKOUT6_1_reg
	 set_property cell_location "15,2" $CLKOUT6_2_reg
	 set_property cell_location "16,2" $DIV_CLK_reg
	 set_property cell_location "17,2" $CLKFBOUT_1_reg
	 set_property cell_location "18,2" $CLKFBOUT_2_reg
	 set_property cell_location "19,2" $LOCK_1_reg
	 set_property cell_location "20,2" $LOCK_2_reg
	 set_property cell_location "21,2" $LOCK_3_reg
	 set_property cell_location "22,2" $FILTER_1_reg
	 set_property cell_location "23,2" $FILTER_2_reg
    
}
 proc create_clkmon {IpView } {
	set create_clkmon [ipgui::add_page $IpView -parent $IpView -name create_clkmon -layout horizontal]
	set_property display_name "Clock Monitor" $create_clkmon
     set Clock_Specifications [ipgui::add_group $IpView -parent $create_clkmon -name "Specifications" -layout horizontal]
     set REF_CLK_FREQ      [ipgui::add_param $IpView -name REF_CLK_FREQ -parent $Clock_Specifications -layout horizontal]
	 ipgui::add_row $IpView -parent $Clock_Specifications  
     set PRECISION      [ipgui::add_param $IpView -name PRECISION -parent $Clock_Specifications -layout horizontal]
	  ipgui::add_row $IpView -parent $Clock_Specifications 
	  ipgui::add_row $IpView -parent $Clock_Specifications 
	  ipgui::add_row $IpView -parent $Clock_Specifications 
	  ipgui::add_row $IpView -parent $Clock_Specifications 
      ipgui::add_row $IpView -parent $create_clkmon  
     set Groupbox_UserClkInfo [ipgui::add_group $IpView -parent $create_clkmon -name "User Clock Information" -layout horizontal]
	  ipgui::add_row $IpView -parent $create_clkmon  
	  ipgui::add_row $IpView -parent $create_clkmon  
	 set table_clk_mon [ipgui::add_table $IpView  -name "table_clk_mon" -rows "5" -columns "4" -parent $Groupbox_UserClkInfo -table_header true -layout horizontal]
     
	 set Enable_User_Clock [ipgui::add_static_text  $IpView -name Enable_User_Clock -parent  $table_clk_mon -text "Enable Clock"]
	 set Clock_Freq [ipgui::add_static_text  $IpView -name Clock_Freq -parent  $table_clk_mon -text "User Frequency(MHz)"]
	 set PLL_MMCM [ipgui::add_static_text  $IpView -name PLL_MMCM -parent  $table_clk_mon -text "PLL/MMCM"]
	 set User_CLk0 [ipgui::add_static_text  $IpView -name User_CLk0 -parent  $table_clk_mon -text "User_CLk0"]
	 set User_CLk1 [ipgui::add_static_text  $IpView -name User_CLk1 -parent  $table_clk_mon -text "User_CLk1"]
	 set User_CLk2 [ipgui::add_static_text  $IpView -name User_CLk2 -parent  $table_clk_mon -text "User_CLk2"]
	 set User_CLk3 [ipgui::add_static_text  $IpView -name User_CLk3 -parent  $table_clk_mon -text "User_CLk3"]
     
	 set ENABLE_USER_CLOCK0 [ipgui::add_param  $IpView -parent $table_clk_mon -name ENABLE_USER_CLOCK0 -show_label false]
	 set_property display_name "Clk0" $ENABLE_USER_CLOCK0
	 set_property tooltip "check this option to enable the user clock" $ENABLE_USER_CLOCK0
	 set ENABLE_USER_CLOCK1 [ipgui::add_param  $IpView -parent $table_clk_mon -name ENABLE_USER_CLOCK1 -show_label false]
	 set_property display_name "Clk1" $ENABLE_USER_CLOCK1
	 set_property tooltip "check this option to enable the user clock" $ENABLE_USER_CLOCK1
	 set ENABLE_USER_CLOCK2 [ipgui::add_param  $IpView -parent $table_clk_mon -name ENABLE_USER_CLOCK2 -show_label false]
	 set_property display_name "Clk2" $ENABLE_USER_CLOCK2
	 set_property tooltip "check this option to enable the user clock" $ENABLE_USER_CLOCK2
	 set ENABLE_USER_CLOCK3 [ipgui::add_param  $IpView -parent $table_clk_mon -name ENABLE_USER_CLOCK3 -show_label false]
	 set_property display_name "Clk3" $ENABLE_USER_CLOCK3
	 set_property tooltip "check this option to enable the user clock" $ENABLE_USER_CLOCK3
     
	 set Enable_PLL0 [ipgui::add_param  $IpView -parent $table_clk_mon -name Enable_PLL0 -show_label false]
	 set_property tooltip "Enable PLL/MMCM for User Clock 0. If this parameter is enabled primary clock source is considered as user clock0, recommended 1 to 300MHz" $Enable_PLL0
	 set Enable_PLL1 [ipgui::add_param  $IpView -parent $table_clk_mon -name Enable_PLL1 -show_label false]
	 set_property tooltip "Enable PLL/MMCM for User Clock 1. If this parameter is enabled secondary clock source is considered as user clock1,recommended 1 to 300MHz" $Enable_PLL1
	 # set Enable_PLL2 [ipgui::add_param  $IpView -parent $table_clk_mon -name Enable_PLL2 -show_label false]
	 # set_property tooltip "Enable PLL/MMCM for User Clock 2" $Enable_PLL2
	 # set Enable_PLL3 [ipgui::add_param  $IpView -parent $table_clk_mon -name Enable_PLL3 -show_label false]
	 # set_property tooltip "Enable PLL/MMCM for User Clock 3" $Enable_PLL3
     

	 set USER_CLK_FREQ0 [ipgui::add_param  $IpView -parent $table_clk_mon -name USER_CLK_FREQ0]
	 set_property tooltip "specify the frequency for User Clock 0, recommended 1 to 300MHz" $USER_CLK_FREQ0  
	 set USER_CLK_FREQ1 [ipgui::add_param  $IpView -parent $table_clk_mon -name USER_CLK_FREQ1]
	 set_property tooltip "specify the frequency for User Clock 1, recommended 1 to 300MHz" $USER_CLK_FREQ1  
	 set USER_CLK_FREQ2 [ipgui::add_param  $IpView -parent $table_clk_mon -name USER_CLK_FREQ2]
	 set_property tooltip "specify the frequency for User Clock 2, recommended 1 to 300MHz" $USER_CLK_FREQ2  
	 set USER_CLK_FREQ3 [ipgui::add_param  $IpView -parent $table_clk_mon -name USER_CLK_FREQ3]
	 set_property tooltip "specify the frequency for User Clock 3, recommended 1 to 300MHz" $USER_CLK_FREQ3  
 
     set_property cell_location "0,0" [ipgui::add_static_text $IpView -name ST1 -parent $table_clk_mon -text ""]
     set_property cell_location "0,1" $Enable_User_Clock
	 set_property cell_location "0,2" $PLL_MMCM
	 set_property cell_location "0,3" $Clock_Freq
     set_property cell_location "1,0" $User_CLk0
	 set_property cell_location "1,1" $ENABLE_USER_CLOCK0
	 set_property cell_location "1,3" $USER_CLK_FREQ0
	 set_property cell_location "1,2" $Enable_PLL0
     set_property cell_location "2,0" $User_CLk1
	 set_property cell_location "2,1" $ENABLE_USER_CLOCK1
	 set_property cell_location "2,3" $USER_CLK_FREQ1
	 set_property cell_location "2,2" $Enable_PLL1
     set_property cell_location "3,0" $User_CLk2
	 set_property cell_location "3,1" $ENABLE_USER_CLOCK2
	 set_property cell_location "3,3" $USER_CLK_FREQ2
	 #set_property cell_location "3,2" $Enable_PLL2
     set_property cell_location "4,0" $User_CLk3
	 set_property cell_location "4,1" $ENABLE_USER_CLOCK3
	 set_property cell_location "4,3" $USER_CLK_FREQ3
	 #set_property cell_location "4,2" $Enable_PLL3

     	  ipgui::add_row $IpView -parent $create_clkmon  
     	  ipgui::add_row $IpView -parent $create_clkmon  

    set Label_ClockMon2 [ipgui::add_static_text  $IpView -name Label_ClockMon2 -parent  $create_clkmon -text "Note: Glitch less than one time period of the reference clock cannot be detected."]

 }



proc Initialize {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  #variable c_min_in_freq
  #variable c_min_vco_freq

  # Get numbers from speedsfile (using DLL)
  getspeedfiledata $IpView
  clk_wiz_v6_0_utils::setup_valid_infreq_range_label1 
  clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]
}

# Xspice calls it release the object
proc release_Objs {IpView} {
   variable clk_wiz_v4_2_utils::PartName
   variable clk_wiz_v4_2_utils::ComponentName

   UnInit_Clkwiz $PartName $ComponentName
}
proc Label_InFreq_SetText {IpView} {
   set str "Input Frequency(MHz)"
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str "Time Period (ns)"
   }
   return $str
}
#proc Label_Inclk_Sum_Freq_Header_SetText {IpView} {
#   set str "Input Frequency (MHz)"
#   if { [get_param_value INPUT_MODE] == "Time" } {
#      set str "Input TimePeriod (ns)"
#   }
#   return $str
#}

proc In_Freq_Range_1_SetText {IpView} {
  getspeedfiledata $IpView
  set str [clk_wiz_v6_0_utils::setup_valid_infreq_range_label1 ]
   if { [get_param_value INPUT_MODE] == "Time" } {
  set str [clk_wiz_v6_0_utils::setup_valid_intime_range_label1 ] 
  }
  return $str
}

proc In_Freq_Range_2_SetText {IpView} {
  getspeedfiledata $IpView
  set str [clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
   if { [get_param_value INPUT_MODE] == "Time" } {
  set str [clk_wiz_v6_0_utils::setup_valid_intime_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
}
  return $str
}

proc Label_Inclk_Sum_Jitter_Header_SetText {IpView} {
   set str "Input Jitter (UI)"
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set str "Input Jitter (ps)"
   }
   return $str
}

proc Label_Actual_Err_Str_SetText {IpView} {
   variable clk_wiz_v6_0_utils::text_Label_Actual_Err_Str
   return $text_Label_Actual_Err_Str
}

proc Label_RESET_port_SetText {IpView} {
  set str "reset"
  if { [get_param_value RESET_TYPE] == "ACTIVE_LOW" } {
    set str "resetn"
  }

  return $str
}
 
proc Mod_Freq_Range_SetText {IpView} {
   variable c_min_mod_freq
   variable c_max_mod_freq
   return "$c_min_mod_freq - $c_max_mod_freq"
}

proc Mod_Time_Range_SetText {IpView} {
   variable c_min_mod_freq
   variable c_max_mod_freq
   set c_max_mod_time [setup_display_float [convert_KHz_to_ms $c_min_mod_freq]]
   set c_min_mod_time [setup_display_float [convert_KHz_to_ms $c_max_mod_freq]]
   return "$c_max_mod_time - $c_min_mod_time"
}


for { set i 1 } { $i <= 7} { incr i } {
    EvalSubstituting {i} {
      proc CLKOUT$i_REQUESTED_OUT_FREQ_updated {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set value_primitive [get_param_value PRIMITIVE]
         pre_calculate $IpView
         common_all_update_calc_done $IpView
  set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
   if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set sec_freq [get_param_value SECONDARY_IN_FREQ]
      set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
      set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
      set sec_clkperiod [ expr 1000.0 / $sec_clk_val ]
      set sec_period_val [setup_display_float_freq $sec_clkperiod ]
      set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
      if {($value_primitive == "PLL") && ($devicetype != 2)  } {
         if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
            set sec_clk_val [format "%3.3f" $sec_clk_val ]
         }
      } else {
         if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         }
      }
      if {$sec_freq < $sec_clk_val} {
      set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
      }
   }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
      } ;# end 
      proc CLKOUT$i_REQUESTED_PHASE_updated {IpView} {
         pre_calculate $IpView
         common_all_update_calc_done $IpView
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
      } ;# end 
      proc CLKOUT$i_REQUESTED_DUTY_CYCLE_updated {IpView} {
         pre_calculate $IpView
         common_all_update_calc_done $IpView
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
      } ;# end 
      proc CLKOUT$i_ACTUAL_OUT_FREQ_SetText {IpView} {
         variable clk_wiz_v6_0_utils::text_CLKOUT$i_ACTUAL_OUT_FREQ
         pre_calculate $IpView
         #common_all_update_calc_done $IpView
         set str $text_CLKOUT$i_ACTUAL_OUT_FREQ
         if { $i > 1 } {
            if { [get_param_value CLKOUT$i_USED] == false } {
               set str "N/A"
            }
         }
         return $str
      }
      proc CLKOUT$i_ACTUAL_PHASE_SetText {IpView} {
         variable clk_wiz_v6_0_utils::text_CLKOUT$i_ACTUAL_PHASE
         #pre_calculate $IpView
         #common_all_update_calc_done $IpView
         set str $text_CLKOUT$i_ACTUAL_PHASE  ;#edited from this condition
         #puts "the value of str is $str \n"
         #set j [expr $i - 1]
         #set str [get_param_value MMCM_CLKOUT${j}_PHASE]
         if { $i > 1 } {
            if { [get_param_value CLKOUT$i_USED] == false } {
               set str "N/A"
            }
         }
         return $str
      }
      proc CLKOUT$i_ACTUAL_DUTY_CYCLE_SetText {IpView} {
         variable clk_wiz_v6_0_utils::text_CLKOUT$i_ACTUAL_DUTY_CYCLE
         #pre_calculate $IpView
         #common_all_update_calc_done $IpView
         set str $text_CLKOUT$i_ACTUAL_DUTY_CYCLE
         if { $i > 1 } {
            if { [get_param_value CLKOUT$i_USED] == false } {
               set str "N/A"
            }
         }
         return $str
      }
      proc CLKOUT$i_driver_max_freq_SetText {IpView} {
         variable text_CLKOUT$i_driver_max_freq
	 return $text_CLKOUT$i_driver_max_freq
      }
      proc Outclk_Sum_Clkout$i_Out_Freq_SetText {IpView} {
         variable text_Outclk_Sum_Clkout$i_Out_Freq
         #pre_calculate $IpView
         #fix for CR 716462
         mmcm_pll_load_oclk_sum_tbl $IpView $i true
         return $text_Outclk_Sum_Clkout$i_Out_Freq
      }
      proc Outclk_Sum_Clkout$i_Phase_SetText {IpView} {
         variable text_Outclk_Sum_Clkout$i_Phase
         #pre_calculate $IpView
         #mmcm_pll_load_oclk_sum_tbl $IpView $i [get_param_value OVERRIDE_MMCM]
         mmcm_pll_load_oclk_sum_tbl $IpView $i true
         return $text_Outclk_Sum_Clkout$i_Phase
      }
      proc Outclk_Sum_Clkout$i_Duty_Cycle_SetText {IpView} {
         variable text_Outclk_Sum_Clkout$i_Duty_Cycle
         #pre_calculate $IpView
         #mmcm_pll_load_oclk_sum_tbl $IpView $i [get_param_value OVERRIDE_MMCM]

         mmcm_pll_load_oclk_sum_tbl $IpView $i true
         return $text_Outclk_Sum_Clkout$i_Duty_Cycle
      }
      proc Outclk_Sum_Clkout$i_Pktopk_Jitter_SetText {IpView} {
         variable text_Outclk_Sum_Clkout$i_Pktopk_Jitter
         calculate_jitter_and_phase_error $IpView
         return $text_Outclk_Sum_Clkout$i_Pktopk_Jitter
      }
      proc Outclk_Sum_Clkout$i_Phase_Error_SetText {IpView} {
         variable text_Outclk_Sum_Clkout$i_Phase_Error
         calculate_jitter_and_phase_error $IpView
         return $text_Outclk_Sum_Clkout$i_Phase_Error
      }
    } 0
}

proc Outclk_Sum_Clkout1_TSpread_SetText {IpView} {
   set o [get_param_value MMCM_CLKOUT0_DIVIDE_F]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
     set spread "OFF"
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         #Kalyani - CR 683159
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
         #set spread [expr {1e+6 * (1/($freq*($m-0.125*2)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         #Kalyani - CR 683159
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
         #set spread [expr {1e+6 * (1/($freq*($m-0.125*2)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
        set str [setup_display_float $spread]
        return $str
   } else {
      set spread "OFF"
     return $spread   
   }
}

proc Outclk_Sum_Clkout2_TSpread_SetText {IpView} {
   set o [get_param_value MMCM_CLKOUT1_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT2_USED] == true} {
     set spread "OFF" 
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
      set str [setup_display_float $spread]
      return $str
   } else {
      set spread "OFF"
     return $spread   
   }
}

proc Outclk_Sum_Clkout3_TSpread_SetText {IpView} {

   set o [get_param_value MMCM_CLKOUT2_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT3_USED] == true} {
        set spread "OFF"  
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
        set str [setup_display_float $spread]
        return $str
   } else {
      set spread "OFF"
     return $spread   
   }
}
proc Outclk_Sum_Clkout4_TSpread_SetText {IpView} {

   set o [get_param_value MMCM_CLKOUT3_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT4_USED] == true} {
      set spread "OFF"  
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
     set str [setup_display_float $spread]
     return $str   
   } else {
      set spread "OFF"
     return $spread   
   }
}
proc Outclk_Sum_Clkout5_TSpread_SetText {IpView} {
   set o [get_param_value MMCM_CLKOUT4_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT5_USED] == true} {
      set spread "OFF" 
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
      set str [setup_display_float $spread]
      return $str   
   } else {
      set spread "OFF"
     return $spread   
   }
}
proc Outclk_Sum_Clkout6_TSpread_SetText {IpView} {
   set o [get_param_value MMCM_CLKOUT5_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT6_USED] == true} {
      set spread "OFF"  
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
   set str [setup_display_float $spread]
   return $str   
   } else {
      set spread "OFF"
     return $spread   
   }
}

proc Outclk_Sum_Clkout7_TSpread_SetText {IpView} {
   set o [get_param_value MMCM_CLKOUT6_DIVIDE]
   set m [get_param_value MMCM_CLKFBOUT_MULT_F]
   set d [get_param_value MMCM_DIVCLK_DIVIDE]
   set freq [get_param_value PRIM_IN_FREQ]
   set ssmode [get_param_value SS_MODE]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true && [get_param_value CLKOUT7_USED] == true} {
      set spread "OFF"      
      if { $ssmode == "CENTER_HIGH" } {
         set spread [expr {1e+6 * (1 / ($freq * ($m - 0.125 * 4) / $d / $o) - 1 / ($freq * $m / $d / $o))}]
      } elseif { $ssmode == "CENTER_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_HIGH" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      } elseif { $ssmode == "DOWN_LOW" } {
         set spread [expr {1e+6 * (1/($freq*($m-0.125*4)/$d/$o) - 1/($freq*$m/$d/$o))}]
      }
     set str [setup_display_float $spread]
     return $str   
   } else {
      set spread "OFF"
     return $spread   
   }
}

proc updateModel_C_POWER_REG {IpView} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
} else {
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
}
} else {
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
}
} else {
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
}
set value [lindex $value 6]
set_property modelparam_value $value [ipgui::get_modelparamspec C_POWER_REG -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_POWER_REG -of $IpView]
}
}

proc mult_val {a} {
    if {[expr fmod($a,1)] == 0  }  {
        set b [expr round($a)]
       } else {
        set b $a
       }
}
proc updateModel_C_CLKOUT0_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT0_DIVIDE_F]
set divN [mult_val $divN]
set phase [get_param_value MMCM_CLKOUT0_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT0_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout0]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout0]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout0]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout0]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT0_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT0_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT0_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT0_DIVIDE_F]
set divN [mult_val $divN]
set phase [get_param_value MMCM_CLKOUT0_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT0_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout0]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout0]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout0]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout0]
}
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT0_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT0_2 -of $IpView]
}
}

proc updateModel_C_CLKOUT1_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT1_DIVIDE]
set phase [get_param_value MMCM_CLKOUT1_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT1_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout1]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout1]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout1]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout1]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT1_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT1_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT1_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT1_DIVIDE]
set phase [get_param_value MMCM_CLKOUT1_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT1_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout1]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout1]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout1]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout1]
}
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT1_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT1_2 -of $IpView]
}
}



proc updateModel_C_CLKOUT2_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT2_DIVIDE]
set phase [get_param_value MMCM_CLKOUT2_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT2_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout2]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout2]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout2]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout2]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT2_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT2_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT2_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT2_DIVIDE]
set phase [get_param_value MMCM_CLKOUT2_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT2_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout2]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout2]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout2]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout2]
}
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT2_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT2_2 -of $IpView]
}
}

proc updateModel_C_CLKOUT3_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT3_DIVIDE]
set phase [get_param_value MMCM_CLKOUT3_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT3_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout3]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout3]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout3]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout3]
##########send_msg INFO 111 "Value $value  div $divN duty $dutyCycle"
}
set value [lindex $value 0]
##########send_msg INFO 222 "Value $value"
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT3_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT3_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT3_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT3_DIVIDE]
set phase [get_param_value MMCM_CLKOUT3_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT3_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout3]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout3]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout3]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout3]
}
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT3_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT3_2 -of $IpView]
}
}

proc updateModel_C_CLKOUT4_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT4_DIVIDE]
set phase [get_param_value MMCM_CLKOUT4_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT4_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout4]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout4]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout4]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout4]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT4_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT4_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT4_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT4_DIVIDE]
set phase [get_param_value MMCM_CLKOUT4_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT4_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout4]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout4]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout4]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout4]
}
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT4_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT4_2 -of $IpView]
}
}

proc updateModel_C_CLKOUT5_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT5_DIVIDE]
set phase [get_param_value MMCM_CLKOUT5_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT5_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout5]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout5]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout5]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout5]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT5_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT5_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT5_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT5_DIVIDE]
set phase [get_param_value MMCM_CLKOUT5_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT5_DUTY_CYCLE ]
set divN_0 [get_param_value MMCM_CLKOUT0_DIVIDE_F]
set divN_0 [mult_val $divN_0]
set phase_0 [get_param_value MMCM_CLKOUT0_PHASE ]
set dutyCycle_0 [get_param_value MMCM_CLKOUT0_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value_5 [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout5]
set value_5 0x[lindex $value_5 1]
set value_0 [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN_0 $dutyCycle_0 $phase_0 clkout0]
set value_0 0x[lindex $value_0 2]
set value [format %.4x [expr $value_5 | $value_0]]
} else {
set value_5 [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout5]
set value_5 0x[lindex $value_5 1]
set value_0 [top_mmcme3::xapp888_drp_clkout_plle4 $divN_0 $dutyCycle_0 $phase_0 clkout0]
set value_0 0x[lindex $value_0 2]
set value [format %.4x [expr $value_5 | $value_0]]
}
} else {
set value_5 [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout5]
set value_5 0x[lindex $value_5 1]
set value_0 [top_mmcme3::xapp888_drp_clkout $divN_0 $dutyCycle_0 $phase_0 clkout0]
set value_0 0x[lindex $value_0 2]
set value [format %.4x [expr $value_5 | $value_0]]
}
} else {
set value_5 [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout5]
set value_5 0x[lindex $value_5 1]
set value_0 [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN_0 $dutyCycle_0 $phase_0 clkout0]
set value_0 0x[lindex $value_0 2]
set value [format %.4x [expr $value_5 | $value_0]]
}
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT5_2 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT5_2 -of $IpView]
}
}

proc updateModel_C_CLKOUT6_1 {IpView} {
set divN [get_param_value MMCM_CLKOUT6_DIVIDE]
set phase [get_param_value MMCM_CLKOUT6_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT6_DUTY_CYCLE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout6]
} else {
set value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout6]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout6]
}
} else {
set value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout6]
}
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT6_1 -of $IpView]
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT6_1 -of $IpView]
}
}

proc updateModel_C_CLKOUT6_2 {IpView} {
set divN [get_param_value MMCM_CLKOUT6_DIVIDE]
set phase [get_param_value MMCM_CLKOUT6_PHASE ]
set dutyCycle [get_param_value MMCM_CLKOUT6_DUTY_CYCLE ]
set clkfbout_DIVCLK [get_param_value MMCM_DIVCLK_DIVIDE]
set clkfbout_mult [get_param_value MMCM_CLKFBOUT_MULT_F]
set clkfbout_phase [get_param_value MMCM_CLKFBOUT_PHASE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set clkfbout_value [top_mmcme3::xapp888_drp_settings_mmcme4 $clkfbout_mult $clkfbout_DIVCLK $clkfbout_phase low]
set clkfbout_value 0x[lindex $clkfbout_value 2]
set clk6_value [top_mmcme3::xapp888_drp_clkout_mmcme4 $divN $dutyCycle $phase clkout6]
set clk6_value 0x[lindex $clk6_value 1]
set value [format %.4x [expr $clkfbout_value | $clk6_value]]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]
} else {
set clkfbout_value [top_mmcme3::xapp888_drp_settings_plle4 $clkfbout_mult $clkfbout_DIVCLK $clkfbout_phase]
set clkfbout_value 0x[lindex $clkfbout_value 2]
set clk6_value [top_mmcme3::xapp888_drp_clkout_plle4 $divN $dutyCycle $phase clkout6]
set clk6_value 0x[lindex $clk6_value 1]
set value [format %.4x [expr $clkfbout_value | $clk6_value]]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]
}
} else {
set clkfbout_value [top_mmcme3::xapp888_drp_settings $clkfbout_mult $clkfbout_DIVCLK $clkfbout_phase low]
set clkfbout_value 0x[lindex $clkfbout_value 2]
set clk6_value [top_mmcme3::xapp888_drp_clkout $divN $dutyCycle $phase clkout6]
set clk6_value 0x[lindex $clk6_value 1]
set value [format %.4x [expr $clkfbout_value | $clk6_value]]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]
}
} else {
set clkfbout_value [top_mmcme3::xapp888_drp_settings_mmcme2 $clkfbout_mult $clkfbout_DIVCLK $clkfbout_phase low]
set clkfbout_value 0x[lindex $clkfbout_value 2]
set clk6_value [top_mmcme3::xapp888_drp_clkout_mmcme2 $divN $dutyCycle $phase clkout6]
set clk6_value 0x[lindex $clk6_value 1]
set value [format %.4x [expr $clkfbout_value | $clk6_value]]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]
}
}

proc updateModel_C_DIVCLK {IpView} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 3]
set_property modelparam_value $value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 2]
set_property modelparam_value $value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 3]
set_property modelparam_value $value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 2]
set_property modelparam_value $value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
}
}
} else {
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 3]
set_property modelparam_value $value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_DIVCLK -of $IpView]
}
}

proc updateModel_C_CLKFBOUT_1 {IpView} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
}
}
} else {
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 0]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
}
}

# proc updateModel_C_CLKFBOUT_1 {IpView} {
# set divN [get_param_value MMCM_DIVCLK_DIVIDE]
# set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
# set phase [get_param_value MMCM_CLKFBOUT_PHASE]
# variable devicefamily
# set auto_selection [auto_selection $IpView ]
# set devicetype  [getDeviceType $devicefamily]
# if { [get_param_value AXI_DRP] == true} {
# if { $devicetype == 2} {
# if {[get_param_value PRIMITIVE ] != "PLL"} {
 # #########send_msg INFO 111 "MMCM"
# set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
# set value [lindex $value 0]
# set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
# } else {
 # #########send_msg INFO 111 "PLL"
# set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
# set value [lindex $value 0]
# set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
# }
# } else {
# set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
# set value [lindex $value 0]
# set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
# }
# } else {
# set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]
# }
# }

proc updateModel_C_CLKFBOUT_2 {IpView} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
} else {
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
}
}
} else {
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 1]
set_property modelparam_value $value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]
}
}

proc updateModel_C_LOCK_1 {IpView} {
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 7]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 5]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 7]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 5]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
}
}
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 7]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]
}
}

proc updateModel_C_LOCK_2 {IpView} {
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 8]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 6]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 8]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 6]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
}
}
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 8]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]
}
}

proc updateModel_C_LOCK_3 {IpView} {
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 9]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 7]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 9]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 7]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
}
}
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 9]
set_property modelparam_value $value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]
}
}

proc updateModel_C_FILTER_1 {IpView} {
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 5]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 4]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 5]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 4]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
}
}
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 5]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
}
} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]
}
}

proc updateModel_C_FILTER_2 {IpView} {
variable devicefamily
set devicetype  [getDeviceType $devicefamily]
set getDevicefamily  [getDevicefamily $devicefamily]
if { [get_param_value AXI_DRP] == true} {
if { $devicetype == 2} {
if { $getDevicefamily == 3} {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme4 $mul $divN $phase low]
set value [lindex $value 4]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_plle4 $mul $divN $phase]
set value [lindex $value 3]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
}
} else {
if {[get_param_value PRIMITIVE ] != "PLL"} {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings $mul $divN $phase low]
set value [lindex $value 4]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_pll $mul $divN $phase]
set value [lindex $value 3]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
}
}
} else {
set divN [get_param_value MMCM_DIVCLK_DIVIDE]
set mul [get_param_value MMCM_CLKFBOUT_MULT_F]
set phase [get_param_value MMCM_CLKFBOUT_PHASE ]
set value [top_mmcme3::xapp888_drp_settings_mmcme2 $mul $divN $phase low]
set value [lindex $value 4]
set_property modelparam_value $value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
}

} else {
set_property modelparam_value 0000 [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]
}
}


proc Power_Register_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_POWER_REG -of $IpView]]
return $value
}

proc CLKOUT0_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT0_1 -of $IpView]]
return $value
}

proc CLKOUT0_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT0_2 -of $IpView]]
return $value
}

proc CLKOUT1_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT1_1 -of $IpView]]
return $value
}

proc CLKOUT1_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT1_2 -of $IpView]]
return $value
}

proc CLKOUT2_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT2_1 -of $IpView]]
return $value
}

proc CLKOUT2_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT2_2 -of $IpView]]
return $value
}

proc CLKOUT3_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT3_1 -of $IpView]]
return $value
}

proc CLKOUT3_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT3_2 -of $IpView]]
return $value
}

proc CLKOUT4_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT4_1 -of $IpView]]
return $value
}

proc CLKOUT4_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT4_2 -of $IpView]]
return $value
}

proc CLKOUT5_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT5_1 -of $IpView]]
return $value
}

proc CLKOUT5_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT5_2 -of $IpView]]
return $value
}

proc CLKOUT6_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT6_1 -of $IpView]]
return $value
}

proc CLKOUT6_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT6_2 -of $IpView]]
return $value
}

proc DIV_CLK_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_DIVCLK -of $IpView]]
return $value
}

proc CLKFBOUT_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKFBOUT_1 -of $IpView]]
return $value
}

proc CLKFBOUT_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_CLKFBOUT_2 -of $IpView]]
return $value
}

proc LOCK_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_LOCK_1 -of $IpView]]
return $value
}

proc LOCK_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_LOCK_2 -of $IpView]]
return $value
}

proc LOCK_3_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_LOCK_3 -of $IpView]]
return $value
}

proc FILTER_1_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_FILTER_1 -of $IpView]]
return $value
}

proc FILTER_2_proc {IpView} {
set value [get_property modelparam_value [ipgui::get_modelparamspec C_FILTER_2 -of $IpView]]
return $value
}

proc Inclk_Sum_Prim_Freq_SetText {IpView} {
   set infreq1 [get_param_value PRIM_IN_FREQ]
   set intime1 [get_param_value PRIM_IN_TIMEPERIOD]
   set str [setup_display_float $infreq1]
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str [setup_display_float $intime1]
   }
   return $str
}

proc Inclk_Sum_Prim_Time_SetText {IpView} {
   set intime1 [get_param_value PRIM_IN_TIMEPERIOD]
   set str [setup_display_float $intime1]
   return $str
}

proc Inclk_Sum_Secondary_Freq_SetText {IpView} {
   set infreq2 [get_param_value SECONDARY_IN_FREQ]
   set intime2 [get_param_value SECONDARY_IN_TIMEPERIOD]
   set str [setup_display_float $infreq2]
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str [setup_display_float $intime2]
   }
   return $str
}

proc Inclk_Sum_Secondary_Time_SetText {IpView} {
   set intime2 [get_param_value SECONDARY_IN_TIMEPERIOD]
   set str [setup_display_float $intime2]
   return $str
}

proc Inclk_Sum_Prim_Source_SetText {IpView} {
   set str [get_param_value PRIM_SOURCE]
   return $str
}

proc Inclk_Sum_Secondary_Source_SetText {IpView} {
   set str [get_param_value SECONDARY_SOURCE]
   return $str
}

proc Inclk_Sum_Prim_Jitter_SetText {IpView} {
   set str [setup_display_float [get_param_value CLKIN1_UI_JITTER] ]
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set str [setup_display_float [get_param_value CLKIN1_JITTER_PS] ]
   }
   return $str
}

proc Inclk_Sum_Secondary_Jitter_SetText {IpView} {
   set str [setup_display_float [get_param_value CLKIN2_UI_JITTER] ]
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set str [setup_display_float [get_param_value CLKIN2_JITTER_PS] ]
   }
   return $str
}

proc Label_Vco_Freq_SetText {IpView} {
   variable clk_wiz_v6_0_utils::c_vco_freq
   set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set divClkDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
   set div0 [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
   if { [get_param_value RELATIVE_INCLK ] == "REL_PRIMARY" } {
      set inFreq  [get_param_value PRIM_IN_FREQ ]
   } else {
      set inFreq  [get_param_value SECONDARY_IN_FREQ]
   }
   set period [ expr 1000.0 / $inFreq ]
   set period_val [setup_display_float_freq $period ]

   set vco [expr (1.0 * $inFreq * $clkFBMult / ($divClkDiv )) ]
   set c_vco_freq [setup_display_float_freq $vco ]
   return "VCO Freq = $c_vco_freq MHz"
}

proc Label_Modulation_Freq_SetText {IpView} {
   variable clk_wiz_v6_0_utils::text_SSModActFreq
   set str ""
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      #set modfreq [get_param_value SS_MOD_FREQ]
      set modfreq $text_SSModActFreq
      set str "                  Modulation Freq = $modfreq KHz"
   }
   return $str
}

proc Label_Res_1_SetText {IpView} {
   set prim [get_param_value PRIMITIVE]
     if { $prim == "Auto" } {
   set auto_selection [auto_selection $IpView ]
   set auto_prim [get_param_value AUTO_PRIMITIVE]
	   if { $auto_prim != "BUFGCE_DIV"} {
   return "1 $auto_prim"
	   } else {
   return ""
	   }
     } else {
   return "1 $prim"
     }
}

for { set i 2 } { $i <= 8} { incr i } {
    EvalSubstituting {i} {
      proc Label_Res_$i_SetText {IpView} {
         set str ""
         variable text_Label_Res_$i
         reset_res_params
         setup_ibuf_res_numbers $IpView
         setup_oclk_res_numbers $IpView
         show_res_labels

         if { $text_Label_Res_$i == "none" } {
            set str ""
         } else {
            set str $text_Label_Res_$i
         }
         return $str
      }
    } 0
}

proc Label_Xpe_Core_Name_SetText {IpView} {
   set str [get_param_value Component_Name] 
   return $str
}

proc Label_Xpe_Inclk_SetText {IpView} {
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   set prim [get_param_value PRIM_IN_FREQ ]
   set sec [get_param_value SECONDARY_IN_FREQ ]
   set str "$prim"
   if { ($c_using_2_inclks == true) && ($prim < $sec) } {
      set str "$sec"
   }
   return $str
}
proc Header_Xpe_Inclk_SetText {IpView} {
 set str "<b>Input Clock Frequency (MHz)</b>"
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str "<b>Input TimePeriod (ns)"
   }
   return $str

}
proc Source_wizard {IpView} {
 set str "<b>Source</b>"
   return $str

}


proc Label_OutFreqHeader_SetText {IpView} {
   set str "<b>Output Freq (MHz)</b>"
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str "<b>Output TimePeriod </b>(ns)"
   }
   return $str
}

proc Outclk_Sum_Output_Freq_Header_SetText {IpView} {
   set str "<b>Output Freq (MHz)</b>"
   if { [get_param_value INPUT_MODE] == "Time" } {
      set str "<b> Output TimePeriod</b>(ns)"
   }
   return $str
}

proc Label_Xpe_Phase_Shift_SetText {IpView} {
   set str ""
   if { [get_param_value USE_DYN_PHASE_SHIFT ] == true } {
      set str "<b> Dynamic Phase Shift</b> : Enabled"
   } else {
      if { ([get_param_value MMCM_CLKOUT0_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT1_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT2_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT3_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT4_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT5_PHASE ] != 0.0) || ([get_param_value MMCM_CLKOUT6_PHASE ] != 0.0)} {
         set str "<b> Clock Phase Shift</b> : Fixed"
      } else {
         set str "<b> Clock Phase Shift</b> : None"
      }
   }
   return $str
}

proc Label_Prim_Instantiated_SetText {IpView} {
   set prim_user_sel [get_param_value PRIMITIVE]
   if {$prim_user_sel != "Auto"} {
     return "<b>Primitive Instantiated   :</b>   $prim_user_sel"
   } else {
# if { [get_param_value PRIMITIVE ] == "Auto" } {
        # determine_auto_primitive $IpView
	# }
     set auto_prim [get_param_value AUTO_PRIMITIVE]
     return "<b>Primitive Instantiated   :</b>   $auto_prim"
   }
}

proc Label_Divide_Counter_SetText {IpView} {
   return "<b>Divide Counter   :</b>   [get_param_value MMCM_DIVCLK_DIVIDE]"
}
proc Label_Mult_Counter_SetText {IpView} {
   return "<b>Mult Counter   :</b>   [get_param_value MMCM_CLKFBOUT_MULT_F]"
}
proc Label_Clkout_Divider_SetText {IpView} {
 set str "<b>Divider Value</b>"
   return $str

}
proc Label_Clkout1_Divider_SetText {IpView} {
   return [get_param_value MMCM_CLKOUT0_DIVIDE_F]
}
proc Label_Clkout2_Divider_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
pll_bufgcediv_seperation $IpView 
   variable clk2_bufgce
   variable divide_clk2
   if { $c_num_oclks >= 2 } {
      if {$clk2_bufgce == "true"} {
        set str $divide_clk2
      } else {
        set str [get_param_value MMCM_CLKOUT1_DIVIDE]
      }
   } else {
      set str "OFF"
   }
   return $str
}
 
proc Label_Clkout3_Divider_SetText {IpView} {
   variable clk_wiz_v6_0_utils::c_num_oclks
pll_bufgcediv_seperation $IpView 
   variable clk3_bufgce
   variable divide_clk3
   if { $c_num_oclks >= 3 } {
      if {$clk3_bufgce == "true"} {
        set str $divide_clk3
      } else {
        set str [get_param_value MMCM_CLKOUT2_DIVIDE]
      }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout4_Divider_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
pll_bufgcediv_seperation $IpView 
   variable clk4_bufgce
   variable divide_clk4
   if { $c_num_oclks >= 4 } {
      if {$clk4_bufgce == "true"} {
        set str $divide_clk4
      } else {
        set str [get_param_value MMCM_CLKOUT3_DIVIDE]
      }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout5_Divider_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   if { $c_num_oclks >= 5 } {
      set str [get_param_value MMCM_CLKOUT4_DIVIDE]
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout6_Divider_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   if { $c_num_oclks >= 6 } {
      set str [get_param_value MMCM_CLKOUT5_DIVIDE]
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout7_Divider_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   if { $c_num_oclks >= 7 } {
      set str [get_param_value MMCM_CLKOUT6_DIVIDE]
   } else {
      set str "OFF"
   }
   return $str
}


proc Label_Clkout1_Name_SetText {IpView} {
 return [get_param_value CLK_OUT1_PORT]
}

proc Label_Clkout2_Name_SetText {IpView} {
 return [get_param_value CLK_OUT2_PORT]
}

proc Label_Clkout3_Name_SetText {IpView} {
 return [get_param_value CLK_OUT3_PORT]
}

proc Label_Clkout4_Name_SetText {IpView} {
 return [get_param_value CLK_OUT4_PORT]
}

proc Label_Clkout5_Name_SetText {IpView} {
 return [get_param_value CLK_OUT5_PORT]
}

proc Label_Clkout6_Name_SetText {IpView} {
 return [get_param_value CLK_OUT6_PORT]
}

proc Label_Clkout7_Name_SetText {IpView} {
 return [get_param_value CLK_OUT7_PORT]
}

proc Clkout1_Source_SetText {Primitive} {
 if {$Primitive == "MMCM"} {
    set str "MMCM CLKOUT0"
  } elseif {$Primitive == "PLL"} {
    set str "PLL CLKOUT0"
  } else {
    set str $Primitive
  }
}

proc Clkout_PLL_Source_SetText {clk_no} {
#pll_bufgcediv_seperation $IpView 
variable clk2_bufgce
variable clk3_bufgce
variable clk4_bufgce
set idx [expr {$clk_no - 2}]
set pll_clk_scr [list $clk2_bufgce $clk3_bufgce $clk4_bufgce]

if {[lindex $pll_clk_scr $idx] == "true"} {
  set str "BUFGCE_DIV driven by PLL CLKOUT0"
} else {
  set str "PLL CLKOUT1"
}
return $str
}

proc Clkout_MMCM_Source_SetText {clk_no} {
set str ""
variable  mmcm_bufgcediv2
variable  mmcm_bufgcediv3
variable  mmcm_bufgcediv4
variable  mmcm_bufgcediv5
variable  mmcm_bufgcediv6
variable  mmcm_bufgcediv7
set idx [expr {$clk_no - 2}]
set mmcm_clk_scr [list $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7]
set mmcm_clk_str [list "MMCM CLKOUT1" "MMCM CLKOUT2" "MMCM CLKOUT3" "MMCM CLKOUT4" "MMCM CLKOUT5" "MMCM CLKOUT6"]

if {[lindex $mmcm_clk_scr $idx] == "true"} {
  set str "BUFGCE_DIV driven by MMCM CLKOUT0"
} else {
  set str [lindex $mmcm_clk_str $idx]
}
return $str
}

proc Label_Clkout1_Source_SetText {IpView} {
set list [pll_bufgcediv_seperation $IpView ]
 if { [get_param_value PRIMITIVE] == "Auto" } {
set auto_selection [get_param_value AUTO_PRIMITIVE]
   return [Clkout1_Source_SetText $auto_selection]
   } else {
   return [Clkout1_Source_SetText [get_param_value PRIMITIVE]]
   }
}
proc Label_Clkout2_Source_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 2 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
        set auto_selection [get_param_value AUTO_PRIMITIVE]
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 2]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 2]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}
 
proc Label_Clkout3_Source_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   set auto_selection [get_param_value AUTO_PRIMITIVE]
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 3 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 3]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 3]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout4_Source_SetText {IpView} {
   variable clk_wiz_v6_0_utils::c_num_oclks
   set auto_selection [get_param_value AUTO_PRIMITIVE]
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 4 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 4]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 4]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout5_Source_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   set auto_selection [get_param_value AUTO_PRIMITIVE]
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 5 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 5]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 5]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout6_Source_SetText {IpView} {
   variable clk_wiz_v6_0_utils::c_num_oclks
   set auto_selection [get_param_value AUTO_PRIMITIVE]
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 6 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 6]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 6]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}
proc Label_Clkout7_Source_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::c_num_oclks
   set auto_selection [get_param_value AUTO_PRIMITIVE]
set list [pll_bufgcediv_seperation $IpView ]
   if { $c_num_oclks >= 7 } {
     if { [get_param_value PRIMITIVE] == "Auto" } {
       set prim $auto_selection
     } else {
      set prim [get_param_value PRIMITIVE]
     }
     if {$prim == "PLL"} {
       set str [Clkout_PLL_Source_SetText 7]
     } elseif {$prim == "MMCM"} {
       set str [Clkout_MMCM_Source_SetText 7]
     } else {
        set str $prim
     }
   } else {
      set str "OFF"
   }
   return $str
}

#################################################################
#
#################################################################
#
#   Update Section
#
#   These Tcl procedures are responsible for updating Params
#   parameters and their associated state (e.g. enabled/disabled)
#   following an update in the front-end GUI.
#
#################################################################

proc USE_MIN_POWER_updated {IpView} {
  set value_Use_Min_Power [get_param_value USE_MIN_POWER]
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
  set Jitter_Sel_handle [ipgui::get_paramspec -name JITTER_SEL -of $IpView]
  set value_Jitter_Sel [get_property value $Jitter_Sel_handle]
  if { $value_Use_Min_Power == true } {
    if { $value_Jitter_Sel == "Min_O_Jitter" } {
      #set_property value "No_Jitter" $Jitter_Sel_handle
      set value_Jitter_Sel "No_Jitter"
    }
    set_property range_value "$value_Jitter_Sel,No_Jitter,Max_I_Jitter" $Jitter_Sel_handle 
    #set_property enabled false $Jitter_Sel_handle
  } else {
    set_property range_value "$value_Jitter_Sel,No_Jitter,Min_O_Jitter,Max_I_Jitter" $Jitter_Sel_handle 
  }
  
   pre_calculate $IpView
   common_all_update_calc_done $IpView
}

# It's mainly for testing. Actually PRIM_IN_JITTER is legacy param
proc PRIM_IN_JITTER_updated {IpView} {
   #set_property value [get_param_value PRIM_IN_JITTER] [ipgui::get_paramspec  CLKIN1_UI_JITTER -of $IpView] 
}

proc SECONDARY_IN_JITTER_updated {IpView} {
   #set_property value [get_param_value SECONDARY_IN_JITTER] [ipgui::get_paramspec  CLKIN2_UI_JITTER -of $IpView] 
}

proc CLKIN1_UI_JITTER_updated {IpView} {
   #set_property value [get_param_value CLKIN1_UI_JITTER] [ipgui::get_paramspec  PRIM_IN_JITTER -of $IpView] 
   common_uijitter_jitteroptions_infreq $IpView
}

proc CLKIN2_UI_JITTER_updated {IpView} {
   #set_property value [get_param_value CLKIN2_UI_JITTER] [ipgui::get_paramspec  SECONDARY_IN_JITTER -of $IpView] 
   common_uijitter_jitteroptions_infreq $IpView
}

proc common_uijitter_jitteroptions_infreq {IpView} {
   set MMCM_REF_JITTER1 [ipgui::get_paramspec MMCM_REF_JITTER1 -of $IpView]
   set MMCM_REF_JITTER2 [ipgui::get_paramspec MMCM_REF_JITTER2 -of $IpView]
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set psjitter [get_param_value CLKIN1_UI_JITTER]
      set_property value $psjitter [ipgui::get_paramspec CLKIN1_JITTER_PS -of $IpView]
      set jit [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psjitter [get_param_value PRIM_IN_FREQ] ]
      set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] $MMCM_REF_JITTER1
      set psjitter [get_param_value CLKIN2_UI_JITTER]
      set_property value $psjitter [ipgui::get_paramspec CLKIN2_JITTER_PS -of $IpView]
      set jit [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psjitter [get_param_value SECONDARY_IN_FREQ] ]
      set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] $MMCM_REF_JITTER2
   } else {
      set jit [get_param_value CLKIN1_UI_JITTER]
      set freq [get_param_value PRIM_IN_FREQ]
      set_property value [clk_wiz_v6_0_utils::convert_UI_to_ps_for_inclk $jit $freq] [ipgui::get_paramspec CLKIN1_JITTER_PS -of $IpView]
      set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] $MMCM_REF_JITTER1
      set jit [get_param_value CLKIN2_UI_JITTER]
      set freq [get_param_value SECONDARY_IN_FREQ]
      set_property value [clk_wiz_v6_0_utils::convert_UI_to_ps_for_inclk $jit $freq] [ipgui::get_paramspec CLKIN2_JITTER_PS -of $IpView]
      set_property value [clk_wiz_v6_0_utils::setup_display_float $jit] $MMCM_REF_JITTER2
   }
}

proc pre_calculate {IpView} {
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::text_SSModActFreq
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::text_Label_Actual_Err_Str
   variable forCalc_Done "false"
   variable forCalc_Done1 ""
  ## Fix to resolve calc_done
 variable clk_wiz_v6_0_utils::Error
 ##send_msg INFO 191 "Error :$Error"
   determine_num_oclks $IpView
pll_bufgcediv_seperation $IpView 
# if { [get_param_value PRIMITIVE ] == "Auto" } {
        # determine_auto_primitive $IpView
	# }
   variable clk2_bufgce
   variable clk3_bufgce
   variable clk4_bufgce
   variable divide_clk2
   variable divide_clk3
   variable divide_clk4
   set clkphy_en [get_param_value ENABLE_CLKOUTPHY]
   set clkphy_freq [get_param_value CLKOUTPHY_REQUESTED_FREQ]
   set auto_prim [get_param_value AUTO_PRIMITIVE]

   if { [get_param_value OVERRIDE_MMCM] == true } {
   for { set i 1 } { $i < 8 } { incr i } {
   if { $c_num_oclks >= $i } {
   
          mmcm_pll_load_oclk_sum_tbl $IpView $i [get_param_value OVERRIDE_MMCM]

         }
         }
   } else {
      set clkin2 0.0
      set clkin1 [get_param_value PRIM_IN_FREQ]
      set cascade [get_param_value MMCM_CLKOUT4_CASCADE]

      if { $c_using_2_inclks == true } {
         set clkin2 [get_param_value SECONDARY_IN_FREQ ]
      }
      set bMinOJitterUsed false
      if { [get_param_value JITTER_SEL ] == "Min_O_Jitter" } {
         set bMinOJitterUsed true
      }
      set nonDefaultPhaseDC [has_non_default_phase_or_duty_cycle $IpView]
      set bandw [get_param_value MMCM_BANDWIDTH ]
      if { $bandw == "LOW" } {
         SetClkwizProperty $PartName $ComponentName "LowBandwidth" true
      } else {
         SetClkwizProperty $PartName $ComponentName "LowBandwidth" false
      }
      if { [get_param_value USE_DYN_RECONFIG ] == true } {
         SetClkwizProperty $PartName $ComponentName "DynReconfig" true
      } else {
         SetClkwizProperty $PartName $ComponentName "DynReconfig" false 
      }
      
	  if { [get_param_value USE_DYN_PHASE_SHIFT ] == true } {
         # setting Dyn_Phase_Shift would result in same thing
         # only integer value should be used
         ##########send_msg INFO 111 "Entered dyn_phase_shift_loop"
		 SetClkwizProperty $PartName $ComponentName "UseFinePS" true
      } else {
         SetClkwizProperty $PartName $ComponentName "UseFinePS" false 
      }
      
      if { [get_param_value PRIMITIVE ] == "Auto" } {
	      set auto true
      if { [get_param_value AUTO_PRIMITIVE ] == "PLL" } {
         set bPLL true
      } else {
         set bPLL false
		 }
      } elseif { [get_param_value PRIMITIVE ] == "PLL" } {
	      set auto false
         set bPLL true
		 } else {
	      set auto false
         set bPLL false
		 }

      set reqOutFreqStr [construct_req_outfreq_str $IpView]

      set reqPhaseStr [construct_req_phase_str $IpView]
      set reqDutyCycleStr [construct_req_duty_cycle_str $IpView]
      if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set modfreq $text_SSModActFreq
      set modperiod [clk_wiz_v6_0_utils::convert_KHz_to_ms $modfreq]
      SetClkwizProperty $PartName $ComponentName "SpreadSpectrum" true
      SetClkwizProperty $PartName $ComponentName "SSMode" [get_param_value SS_MODE]
      if { [get_param_value INPUT_MODE] == "Time" } {
         SetClkwizProperty $PartName $ComponentName "SSModFreq" $modperiod
         } else {
         SetClkwizProperty $PartName $ComponentName "SSModFreq" [get_param_value SS_MOD_FREQ]
         }
      } else {
         SetClkwizProperty $PartName $ComponentName "SpreadSpectrum" false
      }
      if { [clk_wiz_v6_0_utils::check_prim_infreq $clkin1] == false } {
        set_property errmsg "Please enter a valid input frequency" [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
        return false
      } else {   
           set primMode [get_param_value PRIMITIVE]
           set timePeriod ""           
           if { $primMode == "Auto" || $primMode == "MMCM" } {
           	set timePeriod [get_param_value MMCM_CLKIN1_PERIOD]
           } elseif { $primMode == "PLL" } {
           	set timePeriod [get_param_value PLL_CLKIN_PERIOD]
           }
           
        if { [get_param_value USE_MIN_POWER ] == true } {
           # If using Min Power, calc outfreqs, then phase, then duty cycle.
          
           set rtn [ clk_wiz_v6_0_utils::mmcm_pll_calc_outfreqs $clkin1 $clkin2 $bMinOJitterUsed $nonDefaultPhaseDC $bPLL $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkphy_en $clkphy_freq $auto $timePeriod]
           
           if { $rtn == true } {
              mmcm_pll_calc_phases $IpView
              mmcm_pll_calc_duty_cycles $IpView
           }
        } else {
           # Not min power, so calculate all at once.
           #puts "this is not called  ==================================================================================  testing area"
           
           
           
         clk_wiz_v6_0_utils::mmcm_pll_calc_optimals $clkin1 $clkin2 $bMinOJitterUsed $nonDefaultPhaseDC $bPLL $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkphy_en $clkphy_freq $clk2_bufgce $divide_clk2 $clk3_bufgce $divide_clk3 $clk4_bufgce $divide_clk4 $auto $timePeriod $IpView
      #send_msg INFO 192 "clkin1 :$clkin1 clkin2 :$clkin2 bMinOJitterUsed :$bMinOJitterUsed nonDefaultPhaseDC :$nonDefaultPhaseDC bPLL :$bPLL reqOutFreqStr :$reqOutFreqStr reqPhaseStr :$reqPhaseStr reqDutyCycleStr :$reqDutyCycleStr clkphy_en :$clkphy_en clkphy_freq :$clkphy_freq clk2_bufgce :$clk2_bufgce divide_clk2 :$divide_clk2 clk3_bufgce :$clk3_bufgce divide_clk3 :$divide_clk3 clk4_bufgce :$clk4_bufgce divide_clk4 :$divide_clk4 auto :$auto"
           }
     # send_msg INFO 196 [get_param_value PRIMITIVE]
          variable clk_wiz_v6_0_utils::Error
          variable forCalc_Done1 [mmcm_pll_vco_freq_check $IpView]
          #z puts "mmcm_pll_vco_freq_check : $Error"
          #puts "mmcm_pll_vco_freq_check : $forCalc_Done1"
          if {([get_param_value AUTO_PRIMITIVE] == "PLL" && [get_param_value PRIMITIVE] == "Auto" && $Error != "false") } {
            # puts "lollllllllllllllllllllllllllllllllllllllllllllllllllllllll           ::"
             determine_auto_primitive $IpView
          } else {
            set forCalc_Done1 ""
          }
          if {([get_param_value AUTO_PRIMITIVE] == "MMCM" && [get_param_value PRIMITIVE] == "Auto" && $Error != "false") || ([get_param_value AUTO_PRIMITIVE] == "MMCM" && [get_param_value PRIMITIVE] == "Auto" && $forCalc_Done1 != "")  } {
            variable forCalc_Done $forCalc_Done1
          } else {
            variable forCalc_Done "false"
          }
      # send_msg INFO 195 "Erroruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu :"
      # send_msg INFO 199 $forCalc_Done
  
      }
   }
}

proc USE_FREQ_SYNTH_updated {IpView} {
   common_usefreqsynth_priminfreq $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
}

proc common_usefreqsynth_priminfreq {IpView} {
   if { [get_param_value USE_FREQ_SYNTH] == false } {
      for { set i 1 } { $i <= 7 } { incr i } {
          set Clkout_REQUESTED_OUT_FREQ [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
          set_property enabled false $Clkout_REQUESTED_OUT_FREQ
          set_property value [get_param_value PRIM_IN_FREQ ] $Clkout_REQUESTED_OUT_FREQ
          set_property tooltip "Automatically set to the primary input clock frequency because Frequency Synthesis is not used." $Clkout_REQUESTED_OUT_FREQ
      }
   } else {
      for { set i 1 } { $i <= 7 } { incr i } {
          set Clkout_REQUESTED_OUT_FREQ [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
          if { $i == 1 } {
             set_property enabled true $Clkout_REQUESTED_OUT_FREQ
          } else {
             if { [get_param_value CLKOUT${i}_USED] == true } {
                set_property enabled true $Clkout_REQUESTED_OUT_FREQ
             }
          }
          #set_property tooltip "The requested output frequency for the 1st output clock." $Clkout_REQUESTED_OUT_FREQ
      }
   }
}

proc common_matched_priminfreq {IpView} {
      for { set i 1 } { $i <= 7 } { incr i } {
          set Clkout_Matched_Routing [ipgui::get_paramspec CLKOUT${i}_MATCHED_ROUTING -of $IpView]
          if { $i == 1 } {
             set_property enabled true $Clkout_Matched_Routing
          } else {
             if { [get_param_value CLKOUT${i}_USED] == true } {
                set_property enabled true $Clkout_Matched_Routing
             }
          }
      }
   }

proc Label_Phase_Clock_SetText {IpView} {
   set str ""
   if { [get_param_value USE_PHASE_ALIGNMENT] == true } {
      set str "The phase is calculated relative to the active input clock."
   } else {
      set str "The phase is calculated relative to clk_out1."
   }
   return $str
}

proc common_FeedbackSource_PhaseAlignment {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set CLKFB_IN_SIGNALING [ipgui::get_paramspec CLKFB_IN_SIGNALING -of $IpView]
   if { $usePhaseAlignment == true } {
      set_property visible true $CLKFB_IN_SIGNALING
      if { [get_param_value FEEDBACK_SOURCE] == "FDBK_AUTO_OFFCHIP" } {
         set_property enabled true $CLKFB_IN_SIGNALING
      } else {
         set_property value "SINGLE" $CLKFB_IN_SIGNALING
         set_property enabled false $CLKFB_IN_SIGNALING
      } 
   } else {
      set_property visible false $CLKFB_IN_SIGNALING
      set_property value "SINGLE" $CLKFB_IN_SIGNALING
   }
}

proc disable_phase_dc_params {IpView} {
     common_clkoutused_spreadspectrum $IpView true "1"
   for { set i 2 } { $i < 8 } { incr i } {
     common_clkoutused_spreadspectrum $IpView [get_param_value CLKOUT${i}_USED] $i
   }
      
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
	  set_property hidden_rows "4,5" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property visible true [ipgui::get_groupspec Groupbox_SS -of $IpView]
     # set_property hidden_columns "" [ipgui::get_tablespec page5_Table2 -of $IpView]
      set_property hidden_rows "4,5" [ipgui::get_tablespec clocksequencetable -of $IpView]  
      set_property hidden_columns "9" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
   }
}

proc USE_SPREAD_SPECTRUM_updated {IpView} {
   updateVisibilityOfInputMode $IpView
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]

   set value_primitive [get_param_value PRIMITIVE]
   set USE_DYN_PHASE_SHIFT [ipgui::get_paramspec -name USE_DYN_PHASE_SHIFT -of $IpView]
   set USE_INCLK_SWITCHOVER [ipgui::get_paramspec -name USE_INCLK_SWITCHOVER -of $IpView]
   set USE_MIN_POWER [ipgui::get_paramspec -name USE_MIN_POWER -of $IpView]
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set_property value false $USE_DYN_PHASE_SHIFT
      set_property enabled false $USE_DYN_PHASE_SHIFT
      set_property value false $USE_MIN_POWER
      set_property enabled  false $USE_MIN_POWER
      set_property value false $USE_INCLK_SWITCHOVER
      set_property enabled false $USE_INCLK_SWITCHOVER
      set_property hidden_rows "4,5" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property visible true [ipgui::get_groupspec Groupbox_SS -of $IpView]
     # set_property hidden_columns "" [ipgui::get_tablespec page5_Table2 -of $IpView]
      set_property hidden_rows "4,5" [ipgui::get_tablespec clocksequencetable -of $IpView]  
      set_property hidden_columns "9" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
	  if {$getDevicefamily == 3} {
      set_property value 125 [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView ] 
         }	  
	  } else {
	  # if {$getDevicefamily == 3} {
      # set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # } else {
      set_property enabled true [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # }
      #set_property visible true $USE_MIN_POWER
      set_property enabled true $USE_INCLK_SWITCHOVER
      if { $value_primitive == "MMCM" || $value_primitive == "Auto" } {
        set_property hidden_rows "" [ipgui::get_tablespec Outputclocktable -of $IpView]
        set_property hidden_rows "" [ipgui::get_tablespec clocksequencetable -of $IpView]
      } elseif {($value_primitive == "PLL") && ($devicetype == 2)  } {
           set_property hidden_rows "4,5,6,7,8" [ipgui::get_tablespec Outputclocktable -of $IpView]
           set_property hidden_rows "4,5,6,7,8" [ipgui::get_tablespec clocksequencetable -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT5_USED -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT6_USED -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT7_USED -of $IpView]
      } else {
           set_property hidden_rows "8" [ipgui::get_tablespec Outputclocktable -of $IpView]
           set_property value false [ipgui::get_paramspec CLKOUT7_USED -of $IpView]
           set_property hidden_rows "8" [ipgui::get_tablespec clocksequencetable -of $IpView]
      }
      set_property visible false [ipgui::get_groupspec Groupbox_SS -of $IpView]
      #set_property hidden_columns "5" [ipgui::get_tablespec page5_Table2 -of $IpView]
      set_property enabled true $USE_DYN_PHASE_SHIFT
      set_property enabled  true $USE_MIN_POWER
   }
   getspeedfiledata $IpView 
   common_OverrideMmcm_JitterSel_SS $IpView
   clkout5_spereadspectrum $IpView
   disable_phase_dc_params $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
   common_clkout3_used_ss $IpView
   common_clkout4_used_ss $IpView
   common_clkout5_used_ss $IpView
   common_clkout6_used_ss $IpView
   common_clkout7_used_ss $IpView
}

proc SS_MODE_updated {IpView} {
   pre_calculate $IpView
   common_all_update_calc_done $IpView
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
}


proc SS_MOD_TIME_updated {IpView} {
   set modperiod [get_param_value SS_MOD_TIME]
  if { [get_param_value INPUT_MODE ] =="Time"} {
      set modfreq [clk_wiz_v6_0_utils::convert_ms_to_KHz $modperiod]
  #set modperiod [clk_wiz_v6_0_utils::convert_MHz_to_ms $modfreq]
      set_property value $modfreq [ipgui::get_paramspec SS_MOD_FREQ -of $IpView] 
   }
}


 # set modfreq [get_param_value SS_MOD_FREQ]
#if { [get_param_value INPUT_MODE] == "Time" } {
 # set modperiod [get_param_value SS_MOD_TIME]
  #set modperiod [clk_wiz_v6_0_utils::convert_MHz_to_ms $modfreq]
  #set modperiod_in_ms [expr ($modperiod / 1000000) * 1000000 ]
  #set_property modelparam_value  $modperiod [ipgui::get_modelparamspec C_SS_MOD_PERIOD -of $IpView]
#} else {
 # set modfreq [get_param_value SS_MOD_FREQ]
  #set_property modelparam_value  $modfreq [ipgui::get_modelparamspec C_SS_MOD_PERIOD -of $IpView]
#}



proc USE_PHASE_ALIGNMENT_updated {IpView} {
   variable c_IBUF_BUFG_src
   variable c_IBUFDS_BUFG_src
   variable c_IBUFG_src
   variable c_IBUFGDS_src
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   common_phase_alignment_inclk_switchover $IpView
   common_Primitve_PhaseAlignment $IpView
   common_FeedbackSource_PhaseAlignment $IpView 
   set curPrimValue [get_param_value PRIM_SOURCE]
   set PRIM_SOURCE [ipgui::get_paramspec PRIM_SOURCE -of $IpView]
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set CLKOUT1_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
   set CLKOUT2_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
   set CLKOUT3_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
   set CLKOUT4_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
   set CLKOUT5_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
   set CLKOUT6_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
   set CLKOUT7_REQUESTED_PHASE [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
   set FEEDBACK_SOURCE [ipgui::get_paramspec FEEDBACK_SOURCE -of $IpView]
   set FEEDBACK_SOURCE_group [ipgui::get_groupspec tab2Panel -of $IpView]
   if {($value_primitive == "MMCM" || $value_primitive == "Auto")} {
      set_property tooltip "Specify the requested phase for the 1st output clock." $CLKOUT1_REQUESTED_PHASE
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT1_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT1_REQUESTED_PHASE
		}
      if {[get_param_value CLKOUT2_USED]  == "true"} {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT2_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT2_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT2_REQUESTED_PHASE
	  }
      if {[get_param_value CLKOUT3_USED]  == "true"} {	  
   if { [get_param_value CLK_OUT3_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT3_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT3_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT3_REQUESTED_PHASE
	  }
      if {[get_param_value CLKOUT4_USED]  == "true"} {	  
   if { [get_param_value CLK_OUT4_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT4_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT4_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT4_REQUESTED_PHASE
	  }
      if {[get_param_value CLKOUT5_USED]  == "true"} {
   if { [get_param_value CLK_OUT5_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT5_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT5_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT5_REQUESTED_PHASE
	  }
      if {[get_param_value CLKOUT6_USED]  == "true"} {	  
   if { [get_param_value CLK_OUT6_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT6_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT6_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT6_REQUESTED_PHASE
	  }
      if {[get_param_value CLKOUT7_USED]  == "true"} {	  
   if { [get_param_value CLK_OUT7_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT7_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT7_REQUESTED_PHASE
		}
      } else {
        set_property enabled false $CLKOUT7_REQUESTED_PHASE
	  }
      # If Phase Alignment is being used, show the FEEDBACK_SOURCE box.
      # set_property visible true $FEEDBACK_SOURCE
      # # If the current value is one of the values not allowed in this case, change it to the default.
      # if { $curPrimValue == $c_IBUF_BUFG_src ||  $curPrimValue == $c_IBUFDS_BUFG_src } {
         # set curPrimValue $c_IBUFG_src
      # }
      # set_property range_value "$curPrimValue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $PRIM_SOURCE
      if { $usePhaseAlignment == true } {
        set_property visible true $FEEDBACK_SOURCE
        set_property visible true $FEEDBACK_SOURCE_group
        set_property enabled true $FEEDBACK_SOURCE
	  } else {
        set_property enabled false $FEEDBACK_SOURCE
        set_property visible false $FEEDBACK_SOURCE
        set_property visible false $FEEDBACK_SOURCE_group
        #set_property enabled false $FEEDBACK_SOURCE
	  }
   } elseif { $usePhaseAlignment == true } {
      set_property tooltip "Specify the requested phase for the 1st output clock." $CLKOUT1_REQUESTED_PHASE
      # If Phase Alignment is being used, show the FEEDBACK_SOURCE box.
      set_property visible true $FEEDBACK_SOURCE
      set_property visible true $FEEDBACK_SOURCE_group
      set_property enabled true $FEEDBACK_SOURCE
      # If the current value is one of the values not allowed in this case, change it to the default.
      if { $curPrimValue == $c_IBUF_BUFG_src ||  $curPrimValue == $c_IBUFDS_BUFG_src } {
         set curPrimValue $c_IBUFG_src
      }
      set_property range_value "$curPrimValue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $PRIM_SOURCE
   } else {
      # Phase Alignment is NOT being used:
      if {($value_primitive == "PLL")} {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
	    set_property enabled false $CLKOUT1_REQUESTED_PHASE
		} else {
	    set_property enabled true $CLKOUT1_REQUESTED_PHASE
		}
        if {[get_param_value CLKOUT2_USED]  == "true"} {  
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
     set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
	    }
          set_property enabled false $CLKOUT3_REQUESTED_PHASE
          set_property enabled false $CLKOUT4_REQUESTED_PHASE
          set_property enabled false $CLKOUT5_REQUESTED_PHASE
          set_property enabled false $CLKOUT6_REQUESTED_PHASE
          set_property enabled false $CLKOUT7_REQUESTED_PHASE
		  set_property enabled false $FEEDBACK_SOURCE
		  set_property visible false $FEEDBACK_SOURCE
         set_property visible false $FEEDBACK_SOURCE_group
          #set_property value "FDBK_AUTO" $FEEDBACK_SOURCE
          set_property range_value "$curPrimValue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $PRIM_SOURCE	  
	  } else {
	    set_property tooltip "Automatically set to 0.0 because Phase Alignment is not used." $CLKOUT1_REQUESTED_PHASE
        set_property value 0.000 $CLKOUT1_REQUESTED_PHASE
        set_property enabled false $CLKOUT1_REQUESTED_PHASE
        set_property enabled false $CLKOUT2_REQUESTED_PHASE
        set_property enabled false $CLKOUT3_REQUESTED_PHASE
        set_property enabled false $CLKOUT4_REQUESTED_PHASE
        set_property enabled false $CLKOUT5_REQUESTED_PHASE
        set_property enabled false $CLKOUT6_REQUESTED_PHASE
        set_property enabled false $CLKOUT7_REQUESTED_PHASE
        set_property visible false $FEEDBACK_SOURCE
        set_property enabled false $FEEDBACK_SOURCE
        set_property visible false $FEEDBACK_SOURCE_group
        #set_property enabled false $FEEDBACK_SOURCE
        #set_property value "FDBK_AUTO" $FEEDBACK_SOURCE
        set_property range_value "$curPrimValue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $PRIM_SOURCE
        #set_property range_value "$curPrimValue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Single_ended_non_clock_pin,Differential_non_clock_pin,Global_buffer,No_buffer" $PRIM_SOURCE
      }
   }
   #common_all_update_calc_done $IpView
}

proc common_Primitve_PhaseAlignment { IpView } {
   variable devicefamily


   set devicetype  [getDeviceType $devicefamily]
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set safe_clk [get_param_value USE_SAFE_CLOCK_STARTUP]
   for {set j 1} {$j <= 7} {incr j} {
     set clkoutDrives [get_param_value CLKOUT${j}_DRIVES]
     set clkoutDrives_handle [ipgui::get_paramspec CLKOUT${j}_DRIVES -of $IpView]

      
     if {$devicetype == 2 } {
      if {$safe_clk == true } {
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
		} else { 
        set_property range_value "Buffer,Buffer,Buffer_with_CE,BUFG,BUFGCE,BUFGCE_DIV,No_buffer" $clkoutDrives_handle
        }
     } else {
        if { ([get_param_value PRIMITIVE] == "MMCM")} {
           if { $usePhaseAlignment == true } {
              if { $clkoutDrives == "BUFR" } {
                 set clkoutDrives "BUFG"
              }
      if {$safe_clk == true } {
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
		} else { 
              set_property range_value "$clkoutDrives,BUFG,BUFH,BUFGCE,BUFHCE,No_buffer" $clkoutDrives_handle
        }
           } else {
              if { $j > 4 } {
      if {$safe_clk == true } {
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
		} else { 
         set_property range_value "$clkoutDrives,BUFG,BUFH,BUFGCE,BUFHCE,No_buffer" $clkoutDrives_handle
        }
              } else {
      if {$safe_clk == true } {
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
		} else { 
                 set_property range_value "$clkoutDrives,BUFG,BUFR,BUFH,BUFGCE,BUFHCE,No_buffer" $clkoutDrives_handle
        }
              }
           }
        } else {
      if {$safe_clk == true } {
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
		} else { 
           set_property range_value "$clkoutDrives,BUFG,BUFH,BUFGCE,BUFHCE,No_buffer" $clkoutDrives_handle
        }
        }
     }
   }
}

proc JITTER_SEL_updated {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set value_primitive [get_param_value PRIMITIVE]
  set value_Jitter_Sel [get_param_value JITTER_SEL]
  common_OverrideMmcm_JitterSel_SS $IpView
  pre_calculate $IpView
  common_all_update_calc_done $IpView
  set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
  if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
     set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
     set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
     set sec_clkperiod [ expr 1000.0 / $sec_clk_val ]
     set sec_period_val [setup_display_float_freq $sec_clkperiod ]
     set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
     if {($value_primitive == "PLL") && ($devicetype != 2)  } {
        if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
           set sec_clk_val [expr $sec_clk_val + 0.001]
           set sec_clk_val [format "%3.3f" $sec_clk_val ]
        }
     } else {
        if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
           set sec_clk_val [expr $sec_clk_val + 0.001]
        }
     }
     set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
  }
}

proc USE_SAFE_CLOCK_STARTUP_updated {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  if {[get_param_value USE_SAFE_CLOCK_STARTUP] == true } {
     set_property enabled true [ipgui::get_paramspec USE_CLOCK_SEQUENCING -of $IpView]

     for {set j 1} {$j <= 7} {incr j} {
         set clkoutDrives_handle [ipgui::get_paramspec CLKOUT${j}_DRIVES -of $IpView]
         set_property range_value "BUFGCE,BUFGCE" $clkoutDrives_handle
     }
  } else { 
     set_property enabled false [ipgui::get_paramspec USE_CLOCK_SEQUENCING -of $IpView]
     set_property value false [ipgui::get_paramspec USE_CLOCK_SEQUENCING -of $IpView]
     common_Primitve_PhaseAlignment $IpView
     for {set j 1} {$j <= 7} {incr j} {
	    if {$devicetype == 1 } {
        set_property value BUFG [ipgui::get_paramspec CLKOUT${j}_DRIVES -of $IpView]
		} else {
        set_property value Buffer [ipgui::get_paramspec CLKOUT${j}_DRIVES -of $IpView]
		}
     }
  }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
}

proc USE_CLOCK_SEQUENCING_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
  set val [get_param_value USE_CLOCK_SEQUENCING]
  set_property enabled $val [ipgui::get_textspec Label_Clkout1_Seq -of $IpView]
  set_property enabled $val [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView]
  for { set i 2 } { $i < 8 } { incr i } {
   if {$val == true} {  
       if {[get_param_value CLKOUT${i}_USED] == true} { 
        set_property enabled true [ipgui::get_textspec Label_Clkout${i}_Seq -of $IpView]
        set_property enabled true [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
       } else {
          set_property enabled false [ipgui::get_textspec Label_Clkout${i}_Seq -of $IpView]
        set_property enabled false [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
       }
   } else {
        set_property enabled false [ipgui::get_textspec Label_Clkout${i}_Seq -of $IpView]
        set_property enabled false [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
   }
  }  
 
}

    for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {

proc validate_CLKOUT$i_DRIVES {IpView} {
 set length [count_bufgcediv $IpView]
   if {$length > 4} {
        set_property errmsg "Only 4 BUFGCE_DIV primitives can be selected." [ipgui::get_paramspec CLKOUT$i_DRIVES -of $IpView ]
   return false
   } else {
   return true
   }
  #return true
} 

} 0
}
proc validate_CLKOUT1_SEQUENCE_NUMBER {IpView} {
   return [utils_Validate_Clkout_Sequencing $IpView 1] 
  #return true
} 

proc validate_CLKOUT2_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT2_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 2 ]  
	 } else {
     return true
	 }
} 

proc validate_CLKOUT3_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT2_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 3 ]  
	 } else {
     return true
	 }
} 

proc validate_CLKOUT4_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT4_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 4 ]  
	 } else {
     return true
	 }
} 

proc validate_CLKOUT5_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT5_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 5 ]  
	 } else {
     return true
	 }
} 

proc validate_CLKOUT6_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT6_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 6 ]  
	 } else {
     return true
	 }
} 

proc validate_CLKOUT7_SEQUENCE_NUMBER {IpView} {
       if {[get_param_value CLKOUT7_USED] == true} { 
     return [utils_Validate_Clkout_Sequencing $IpView 7 ]  
	 } else {
     return true
	 }
} 

proc utils_Validate_Clkout_Sequencing {IpView clknum} {

   if {[get_param_value USE_CLOCK_SEQUENCING] == false} {
    return true
   }

  if {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT0_DIVIDE_F]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT1_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT2_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT1_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT2_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT3_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT2_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT3_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT4_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT3_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT4_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT5_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT4_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT5_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT6_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT7_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT6_DIVIDE]/[get_param_value MMCM_CLKOUT5_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT6_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  if {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT1_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT0_DIVIDE_F]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT2_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT1_DIVIDE]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT3_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT2_DIVIDE]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT4_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT3_DIVIDE]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT5_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT4_DIVIDE]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 } elseif {[get_param_value CLKOUT7_SEQUENCE_NUMBER] == [expr [get_param_value CLKOUT6_SEQUENCE_NUMBER] + 1]} { 
    if {[ expr [get_param_value MMCM_CLKOUT5_DIVIDE]/[get_param_value MMCM_CLKOUT6_DIVIDE]] >= 8 } {
        set_property errmsg "sequenced clock is 8X faster than the previous sequence clock. Please update Freq or Sequence number" [ipgui::get_paramspec CLKOUT7_SEQUENCE_NUMBER -of $IpView ]
       return false
    }
 }

  #get number of valid clocks
   set nEnabledClks 1
   for { set i 2 } { $i < 8 } { incr i } {
      if {[get_param_value CLKOUT${i}_USED] == true} {
        incr nEnabledClks
      }
   }

  #check out of order
  set sumSeqNum 0
  for { set seqNum 1 } { $seqNum <= $nEnabledClks } { incr seqNum } {
   set seqNumcount 0
   set sequence [get_param_value CLKOUT${seqNum}_SEQUENCE_NUMBER]
   if { $sequence > $nEnabledClks} {
    set_property errmsg "Sequence Number $sequence for Clkout $seqNum is out of range[1..$nEnabledClks]" [ipgui::get_paramspec CLKOUT${clknum}_SEQUENCE_NUMBER -of $IpView ]
    return false
   }
    
   if {[get_param_value CLKOUT1_SEQUENCE_NUMBER] == $seqNum} {
    incr seqNumcount
   }
   for { set i 2} { $i <= $nEnabledClks } { incr i } {
      if {[get_param_value CLKOUT${i}_USED] == true &&
          [get_param_value CLKOUT${i}_SEQUENCE_NUMBER] == $seqNum} {
        incr seqNumcount
      }
   }
  
   if {$seqNumcount == 0} {
      set_property errmsg "Sequence Number $sequence cannot exist" [ipgui::get_paramspec CLKOUT${clknum}_SEQUENCE_NUMBER -of $IpView ]
     return false
   }

   incr sumSeqNum $seqNumcount
   if {$sumSeqNum == $nEnabledClks} {
    return true
   } 
 }

 set_property errmsg "Sequence Number order failed for Clkout1 to CLKOUT${nEnabledClks}" [ipgui::get_paramspec CLKOUT${clknum}_SEQUENCE_NUMBER -of $IpView ]
 return false 
} 

#CR fix for 952992 use_fin_ps fix where disbale the phase column on the 4th page for not selecting the phase if use_fine_ps is selected
for { set i 0 } { $i < 7} { incr i } {
  EvalSubstituting {i} {
      proc MMCM_CLKOUT$i_USE_FINE_PS_updated {IpView} {
      
         if { [get_param_value OVERRIDE_MMCM] == "true" } {
             if { [get_param_value MMCM_CLKOUT$i_USE_FINE_PS] == "true" } {
               set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT$i_PHASE -of $IpView] 
             }  else { 
                set_property enabled true [ipgui::get_paramspec MMCM_CLKOUT$i_PHASE -of $IpView] 
                }
            } else { 
                set_property enabled false [ipgui::get_paramspec MMCM_CLKOUT$i_PHASE -of $IpView] 
              }
      
      }
  } 0
}





proc utils_primitive {IpView bFlag plle3_Flag} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
   set FEEDBACK_SOURCE_group [ipgui::get_groupspec tab2Panel -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec USE_INCLK_STOPPED -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec USE_CLKFB_STOPPED -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT4_CASCADE -of $IpView]
    set_property visible $bFlag [ipgui::get_textspec CLKOUT4_CASCADE -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_textspec CLKFBOUT_USE_FINE_PS -of $IpView]
    set_property visible $bFlag  [ipgui::get_paramspec MMCM_CLKOUT0_USE_FINE_PS -of $IpView]
# set_property visible $bFlag [ipgui::get_textspec CLKOUT0_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT1_USE_FINE_PS -of $IpView]
#   set_property visible $bFlag [ipgui::get_textspec CLKOUT1_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT2_USE_FINE_PS -of $IpView]
#    set_property visible $bFlag [ipgui::get_textspec CLKOUT2_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT3_USE_FINE_PS -of $IpView]
#  set_property visible $bFlag [ipgui::get_textspec CLKOUT3_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT4_USE_FINE_PS -of $IpView]
#    set_property visible $bFlag [ipgui::get_textspec CLKOUT4_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT5_USE_FINE_PS -of $IpView]
#   set_property visible $bFlag [ipgui::get_textspec CLKOUT5_USE_FINE_PS -of $IpView]
    set_property visible $bFlag [ipgui::get_paramspec MMCM_CLKOUT6_USE_FINE_PS -of $IpView]
#   set_property visible $bFlag [ipgui::get_textspec CLKOUT6_USE_FINE_PS -of $IpView]
	if {$plle3_Flag == "true"} {
           #set_property visible $plle3_Flag [ipgui::get_textspec STARTUP_WAIT -of $IpView]
           #set_property visible $plle3_Flag [ipgui::get_paramspec MMCM_STARTUP_WAIT -of $IpView]
	   	set hideRows 1,5,9,11,12,13 
	   	#set hideColumns 3,4
	   	set hideColumns 6
	   	set hideColumns_co 9
	   	set hiderows_summary 8,9,10,11
	} else {
           #set_property visible $bFlag [ipgui::get_textspec STARTUP_WAIT -of $IpView]
           #set_property visible $bFlag [ipgui::get_paramspec MMCM_STARTUP_WAIT -of $IpView]
	   if {$bFlag == "true"} {
	   	set hideRows "13"
	   	set hideColumns ""
 if { $devicetype == 1} {
	   	set hideColumns_co "10"
} else {
	   	set hideColumns_co ""
}	   	
       set hiderows_summary ""
	   } else {
	   	set hideRows 11,12,13
	   	set hideColumns 6
	   	set hideColumns_co 9,10
	   	set hiderows_summary "11"
	   }
	}
# if { [get_param_value PRIMITIVE ] == "Auto" } {
        # determine_auto_primitive $IpView
	# }
	set_property hidden_rows $hideRows [ipgui::get_tablespec MMCMTable1 -of $IpView]
	set_property hidden_columns $hideColumns [ipgui::get_tablespec MMCMTable2 -of $IpView]
	set_property hidden_columns $hideColumns_co [ipgui::get_tablespec Outputclocktable -of $IpView]
	set_property hidden_rows $hiderows_summary [ipgui::get_tablespec page6_Table1 -of $IpView]
}

proc PRIMITIVE_updated {IpView} {
   set FEEDBACK_SOURCE_group [ipgui::get_groupspec tab2Panel -of $IpView]
  variable clk_wiz_v6_0_utils::c_max_oclks
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
  set value_primitive [get_param_value PRIMITIVE]
#puts "ADDING new settings to BANDWIDTH for MMCME3 "
if { $getDevicefamily == 2 } {
   #set listValues "LOW,HIGH,OPTIMIZED,POSTCRC"
    set listValues "LOW,HIGH,OPTIMIZED"
} else {
   set listValues "LOW,HIGH,OPTIMIZED"
}
#set_property range_value $listValues [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]
set_property range $listValues [ipgui::get_paramspec MMCM_BANDWIDTH -of $IpView]



  getspeedfiledata $IpView 
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT1_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT2_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT3_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT4_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT5_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT6_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT7_PORT -of $IpView]
	 } elseif {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin" } {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in1 [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in2 [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	 } else {
	   set_property enabled true [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
      if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
	   set_property enabled true [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   }
	 }
	set_property enabled false [ipgui::get_paramspec MMCM_CLKFBOUT_USE_FINE_PS -of $IpView]
      if { [get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto"} {
	set_property enabled false [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
    } else {
	set_property enabled true [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
    }
if { [get_param_value PRIMITIVE ] == "Auto" } {
       set_property value false [ipgui::get_paramspec USE_RESET -of $IpView]
       set_property value false [ipgui::get_paramspec USE_LOCKED -of $IpView]
    } else {
       set_property value true [ipgui::get_paramspec USE_RESET -of $IpView]
       set_property value true [ipgui::get_paramspec USE_LOCKED -of $IpView]
    }
if {$devicetype == 2} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
       set_property value true [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property enabled false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property visible false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
} elseif { [get_param_value PRIMITIVE ] == "None" } {
       set_property value false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property enabled false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property visible false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
} else {
       set_property value false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property enabled true [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property visible true [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
}
}
if { [get_param_value PRIMITIVE ] == "None" } {
       set_property visible false [ipgui::get_groupspec Clocking_Features -of $IpView]
       set_property visible false [ipgui::get_groupspec Input_Clock_Information -of $IpView]
       set_property visible false [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView]
	   set_property visible false [ipgui::get_pagespec page2 -of $IpView]
	   set_property visible false [ipgui::get_pagespec page4_MMCM -of $IpView]
	   set_property visible false [ipgui::get_pagespec page5 -of $IpView]
	   set_property visible false [ipgui::get_pagespec page6 -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT1_USED -of $IpView]
       set_property value true [ipgui::get_paramspec ENABLE_USER_CLOCK0 -of $IpView]
       set_property enabled false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
       set_property enabled false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
       set_property value false [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView]
       set_property value false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
       set_property value false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
    } else {
       set_property visible true [ipgui::get_groupspec Input_Clock_Information -of $IpView]
       set_property visible true [ipgui::get_groupspec Clocking_Features -of $IpView]
       set_property visible true [ipgui::get_paramspec USE_INCLK_SWITCHOVER -of $IpView]
       set_property value false [ipgui::get_paramspec ENABLE_USER_CLOCK0 -of $IpView]
	   set_property visible true [ipgui::get_pagespec page2 -of $IpView]
	   set_property visible true [ipgui::get_pagespec page4_MMCM -of $IpView]
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property visible false [ipgui::get_pagespec page5 -of $IpView]
	 } else {
	   set_property visible true [ipgui::get_pagespec page5 -of $IpView]
	 }
	   set_property visible true [ipgui::get_pagespec page6 -of $IpView]
       set_property value true [ipgui::get_paramspec CLKOUT1_USED -of $IpView]
    }
  clk_wiz_v6_0_utils::setup_valid_infreq_range_label1
  clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]
  set page4_MMCM_handle [ipgui::get_pagespec page4_MMCM -of $IpView]
  set USE_PHASE_ALIGNMENT [ipgui::get_paramspec -name USE_PHASE_ALIGNMENT -of $IpView]
  set USE_DYN_PHASE_SHIFT [ipgui::get_paramspec -name USE_DYN_PHASE_SHIFT -of $IpView]
  set USE_SPREAD_SPECTRUM [ipgui::get_paramspec -name USE_SPREAD_SPECTRUM -of $IpView]
  set USE_INCLK_SWITCHOVER [ipgui::get_paramspec -name USE_INCLK_SWITCHOVER -of $IpView]
  set CLKFB_IN_SIGNALING [ipgui::get_paramspec CLKFB_IN_SIGNALING -of $IpView]
  set FEEDBACK_SOURCE [ipgui::get_paramspec FEEDBACK_SOURCE -of $IpView]
  set ENABLE_CDDC [ipgui::get_paramspec ENABLE_CDDC -of $IpView]
  set ENABLE_CLKOUTPHY [ipgui::get_paramspec ENABLE_CLKOUTPHY -of $IpView]
  set CLKOUTPHY_REQUESTED_FREQ [ipgui::get_paramspec CLKOUTPHY_REQUESTED_FREQ -of $IpView]
  set INPUT_MODE [ipgui::get_paramspec INPUT_MODE -of $IpView]
         set_property visible false $INPUT_MODE
         set_property enabled false $INPUT_MODE
         #set_property visible true $INPUT_MODE
  set_property visible false $ENABLE_CDDC
  if { $devicetype == 2} {
  set_property value AUTO [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
  } else {
  set_property value ZHOLD [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
  }
  if { $devicetype == 2} {
  if { $getDevicefamily == 3} {
  set_property value LATENCY [ipgui::get_paramspec PHASESHIFT_MODE -of $IpView]
  } else {
  set_property value WAVEFORM [ipgui::get_paramspec PHASESHIFT_MODE -of $IpView]
  }
  } else {
  set_property visible false [ipgui::get_paramspec PHASESHIFT_MODE -of $IpView]
  set_property enabled false [ipgui::get_paramspec PHASESHIFT_MODE -of $IpView]
  }
  if { $value_primitive == "MMCM" || $value_primitive == "Auto" || $value_primitive == "None"} {
    set_property display_name "MMCM Settings" $page4_MMCM_handle
    set c_max_oclks 7
    set bFlag true 
    set plle3_Flag false
    set_property visible true $USE_DYN_PHASE_SHIFT
    set_property visible true $USE_SPREAD_SPECTRUM
    set_property visible false $ENABLE_CLKOUTPHY
    set_property visible false $CLKOUTPHY_REQUESTED_FREQ
    set_property hidden_rows "" [ipgui::get_tablespec Outputclocktable -of $IpView]
    set_property hidden_rows "" [ipgui::get_tablespec clocksequencetable -of $IpView]
    set_property hidden_rows "" [ipgui::get_tablespec table -of $IpView]
    set_property range_value "[get_param_value FEEDBACK_SOURCE], FDBK_AUTO, FDBK_AUTO_OFFCHIP, FDBK_ONCHIP, FDBK_OFFCHIP" $FEEDBACK_SOURCE
    set_property enabled true [ipgui::get_paramspec USE_PHASE_ALIGNMENT -of $IpView]
  if { $value_primitive == "Auto"} {
    set_property value false $USE_PHASE_ALIGNMENT
    } elseif { $devicetype == 2 } {
    set_property value false $USE_PHASE_ALIGNMENT ;# CR-982271	
    } else {
    set_property value true $USE_PHASE_ALIGNMENT ;# CR-982271
    }
    if { $devicetype == 2} {
      set_property visible true $ENABLE_CDDC
      set_property range "AUTO,EXTERNAL,INTERNAL,BUF_IN,ZHOLD" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
      if {[get_param_value CLKOUT2_USED]  == "true"} {
        set_property enabled true [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
	  }
	} else {
      set_property visible false $ENABLE_CDDC
      set_property range "ZHOLD,EXTERNAL,INTERNAL,BUF_IN" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
    }
  if { $value_primitive == "Auto" || $value_primitive == "None"} {
       set_property visible false [ipgui::get_paramspec JITTER_SEL -of $IpView]
    } else {
       set_property visible true [ipgui::get_paramspec JITTER_SEL -of $IpView]
    }  
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set USE_DYN_PHASE_SHIFT [ipgui::get_paramspec -name USE_DYN_PHASE_SHIFT -of $IpView]
   set USE_INCLK_SWITCHOVER [ipgui::get_paramspec -name USE_INCLK_SWITCHOVER -of $IpView]
   set USE_MIN_POWER [ipgui::get_paramspec -name USE_MIN_POWER -of $IpView]
      set_property value false $USE_DYN_PHASE_SHIFT
      set_property enabled false $USE_DYN_PHASE_SHIFT
      set_property value false $USE_MIN_POWER
      set_property enabled  false $USE_MIN_POWER
      set_property value false $USE_INCLK_SWITCHOVER
      set_property enabled false $USE_INCLK_SWITCHOVER
      set_property hidden_rows "4,5" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property visible true [ipgui::get_groupspec Groupbox_SS -of $IpView]
     # set_property hidden_columns "" [ipgui::get_tablespec page5_Table2 -of $IpView]
      set_property hidden_rows "4,5" [ipgui::get_tablespec clocksequencetable -of $IpView]  
      set_property hidden_columns "9" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
   
   } 
  } elseif {($value_primitive == "PLL") && ($devicetype == 2)  } {
       set_property display_name "PLL Settings" $page4_MMCM_handle
       set c_max_oclks 2
       set bFlag false
       set plle3_Flag true
       set_property value false $USE_PHASE_ALIGNMENT
       set_property enabled false [ipgui::get_paramspec USE_PHASE_ALIGNMENT -of $IpView]	   
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
       if {[get_param_value CLKOUT2_USED]  == "true"} {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
     set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
       } else {
         set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
	   }
	   set_property value false $USE_DYN_PHASE_SHIFT
       set_property visible false $USE_DYN_PHASE_SHIFT
       set_property value false $USE_SPREAD_SPECTRUM
       set_property visible false $USE_SPREAD_SPECTRUM
       set_property value false $USE_INCLK_SWITCHOVER
       set_property hidden_rows "2" [ipgui::get_tablespec table -of $IpView]
       set_property hidden_rows "4,5,6,7,8" [ipgui::get_tablespec Outputclocktable -of $IpView]
       set_property hidden_rows "4,5,6,7,8" [ipgui::get_tablespec clocksequencetable -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT5_USED -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT6_USED -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT7_USED -of $IpView]
	   set_property visible false $ENABLE_CDDC
       set_property value false $ENABLE_CDDC
       #set_property visible true $ENABLE_CLKOUTPHY
       #set_property visible true $CLKOUTPHY_REQUESTED_FREQ
       set_property visible false $ENABLE_CLKOUTPHY
       set_property visible false $CLKOUTPHY_REQUESTED_FREQ
       set_property enabled false $FEEDBACK_SOURCE
       set_property visible false $FEEDBACK_SOURCE
        set_property visible false $FEEDBACK_SOURCE_group
       #set_property range_value "FDBK_AUTO, FDBK_AUTO, FDBK_ONCHIP" $FEEDBACK_SOURCE
	   set_property range "AUTO,INTERNAL,BUF_IN" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
       set_property visible false  [ipgui::get_paramspec JITTER_SEL -of $IpView]
       #set_property enabled false  [ipgui::get_paramspec JITTER_SEL -of $IpView]
  } else {
       set_property display_name "PLLE2 Settings" $page4_MMCM_handle
       set c_max_oclks 6
       set bFlag false
       set plle3_Flag false
       set_property enabled true [ipgui::get_paramspec USE_PHASE_ALIGNMENT -of $IpView]
       set_property value true $USE_PHASE_ALIGNMENT	   ;#CR-982271
       set_property value false $USE_DYN_PHASE_SHIFT
       set_property visible false $USE_DYN_PHASE_SHIFT
       set_property value false $USE_SPREAD_SPECTRUM
       set_property visible false $USE_SPREAD_SPECTRUM
       set_property hidden_rows "" [ipgui::get_tablespec table -of $IpView]
       set_property hidden_rows "8" [ipgui::get_tablespec Outputclocktable -of $IpView]
       set_property value false [ipgui::get_paramspec CLKOUT7_USED -of $IpView]
       set_property hidden_rows "8" [ipgui::get_tablespec clocksequencetable -of $IpView]
       set_property visible false $ENABLE_CDDC
       set_property visible false $ENABLE_CLKOUTPHY
       set_property visible false $CLKOUTPHY_REQUESTED_FREQ       
	   set_property range "ZHOLD,EXTERNAL,INTERNAL,BUF_IN" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
       set_property visible true [ipgui::get_paramspec JITTER_SEL -of $IpView]
  }
   utils_primitive $IpView $bFlag $plle3_Flag
   common_Primitve_PhaseAlignment $IpView
   common_Primitive_DynPhaseShift $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
   set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
   if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
      set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
      set sec_clkperiod [ expr 1000.0 / $sec_clk_val ]
      set sec_period_val [setup_display_float_freq $sec_clkperiod ]
      set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
      if {($value_primitive == "PLL") && ($devicetype != 2)  } {
         if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
            set sec_clk_val [format "%3.3f" $sec_clk_val ]
         }
      } else {
         if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         }
      }
      set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
   }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
if { [get_param_value OVERRIDE_MMCM ] == true } {
   mmcm_do_override $IpView
   config_prim_freq_gui_option $IpView
   config_sec_freq_gui_option  $IpView
	
}
}

proc common_phase_alignment_inclk_switchover {IpView} {
   set SECONDARY_SOURCE [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   set boardIfName [get_param_value CLK_IN2_BOARD_INTERFACE]
   if { [get_param_value USE_INCLK_SWITCHOVER] == true } {  
      if { [get_param_value USE_PHASE_ALIGNMENT] == true } {
         set_property enabled false $SECONDARY_SOURCE
      } else {
         if {$boardIfName ne "Custom"} {
            set_property enabled false $SECONDARY_SOURCE
         } else {
            set_property enabled true $SECONDARY_SOURCE
         }
      }
   } else {
      set_property enabled false $SECONDARY_SOURCE
   }
      # If Use-Phase-Alignment is used and both inclks are used, set to SECONDARY_SOURCE to the 
   # PRIM_SOURCE value and disabled (the disabling is done in validate_USE_INCLK_SWITCHOVER).
   if { [get_param_value USE_PHASE_ALIGNMENT ] == true && [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set curvalue [get_param_value SECONDARY_SOURCE ]
      set_property range_value "$curvalue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $SECONDARY_SOURCE
      set_property value [get_param_value PRIM_SOURCE ] $SECONDARY_SOURCE
   } else {
      # Phase Alignment is NOT being used:
      set curvalue [get_param_value SECONDARY_SOURCE ]
      set_property range_value "$curvalue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Global_buffer,No_buffer" $SECONDARY_SOURCE
      #set_property range_value "$curvalue,Single_ended_clock_capable_pin,Differential_clock_capable_pin,Single_ended_non_clock_pin,Differential_non_clock_pin,Global_buffer,No_buffer" $SECONDARY_SOURCE
   }

}

proc INPUT_MODE_updated {IpView} {
	updateVisibilityOfInputMode $IpView
    PRIMITIVE_updated $IpView
    set infreq1 [get_param_value PRIM_IN_FREQ]
    set intime2 [get_param_value PRIM_IN_TIMEPERIOD]
    set sec_in_freq1 [get_param_value SECONDARY_IN_FREQ]
	set sec_in_time2 [get_param_value SECONDARY_IN_TIMEPERIOD]

if { [get_param_value INPUT_MODE ] =="Time"} {
        set_property hidden_columns "3" [ipgui::get_tablespec table -of $IpView]
} elseif {[get_param_value INPUT_MODE ] =="frequency"} {
        set_property hidden_columns "4" [ipgui::get_tablespec table -of $IpView]
}

# if { [get_param_value INPUT_MODE ] =="Time"} {
        # set_property hidden_columns "2" [ipgui::get_tablespec page5_Table -of $IpView]
# } elseif {[get_param_value INPUT_MODE ] =="frequency"} {
        # set_property hidden_columns "3" [ipgui::get_tablespec page5_Table -of $IpView]
# }

# if { [get_param_value INPUT_MODE ] =="Time"} {
        # #set_property hidden_columns "2" [ipgui::get_tablespec page5_Table2 -of $IpView]
# } elseif {[get_param_value INPUT_MODE ] =="frequency"} {
       # # set_property hidden_columns "3" [ipgui::get_tablespec page5_Table2 -of $IpView]
# }

################# Frequency to Timeperiod conversions ####################
#   if { [get_param_value INPUT_MODE] =="Time"} {
#	 set intime1 [convert_MHz_to_ns $infreq1]
#	 set_property value $intime1 [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set infreq2 [convert_ns_to_MHz $intime2]
#     set_property value $infreq2 [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] =="Time"} {
#	 set sec_in_time1 [convert_MHz_to_ns $sec_in_freq1]
#	 set_property value $sec_in_time1 [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set sec_in_freq2 [convert_ns_to_MHz $sec_in_time2]
#     set_property value $sec_in_freq2 [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT2_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT2_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT3_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT3_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT4_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT4_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT5_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT5_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT6_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT6_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] == "Time"} {
#	 set out_time1 [convert_MHz_to_ns [get_param_value CLKOUT7_REQUESTED_OUT_FREQ]]
#     set_property value $out_time1 [ipgui::get_paramspec CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]
#   }
#
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set out_freq1 [convert_ns_to_MHz [get_param_value CLKOUT7_REQUESTED_OUT_FREQ]]
#     set_property value $out_freq1 [ipgui::get_paramspec CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]
#   }

##########################################################################
}

#proc update_clk_out_freq_format {IpView clk_out_req_freq_time} {
#
#   if { [get_param_value INPUT_MODE] =="Time"} {
#	 set Clkout [convert_MHz_to_ns $sec_in_freq1]
#	 set_property value $sec_in_time1 [ipgui::get_paramspec SECONDARY_IN_TIMEPERIOD -of $IpView]
#   }
#   
#   if { [get_param_value INPUT_MODE] != "Time"} {
#	 set sec_in_freq2 [convert_ns_to_MHz $sec_in_time2]
#     set_property value $sec_in_freq2 [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
#   }
#
#}

proc PRIM_IN_FREQ_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set infreq1 [get_param_value PRIM_IN_FREQ]
   set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq1] 
   set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView] 
   if { $value_primitive == "PLL" } {
     set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq1] 
     set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec PLL_CLKIN_PERIOD -of $IpView] 
   }

   set_property value false [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
   common_usefreqsynth_priminfreq $IpView
   common_matched_priminfreq $IpView
   common_uijitter_jitteroptions_infreq $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
   clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]
   set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
   if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
      set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
      set sec_clkperiod [ expr 1000.0 / $sec_clk_val ]
      set sec_period_val [setup_display_float_freq $sec_clkperiod ]
      set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
      if {($value_primitive == "PLL") && ($devicetype != 2)  } {
         if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
            set sec_clk_val [format "%3.3f" $sec_clk_val ]
         }
      } else {
         if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         }
      }
      set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
   }

if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
}

proc PRIM_IN_TIMEPERIOD_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set intime2 [get_param_value PRIM_IN_TIMEPERIOD]
   return true
}
proc SECONDARY_IN_FREQ_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set infreq2 [get_param_value SECONDARY_IN_FREQ] 
   set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq2]
   set rounding_per [clk_wiz_v6_0_utils::setup_display_float $clkinp] 
   set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
   set sec_clkperiod [ expr 1000.0 / $infreq2 ]
   set sec_period_val [setup_display_float_freq $sec_clkperiod ]
   set vco_freq [ expr (1.0* $infreq2 * $clkFBMult) / ( $clkFBDiv) ]
   set actual_per [expr (1000 / $infreq2) ]
   set diff_per [ expr ($rounding_per - $actual_per)]
   Enable_PLL1_updated $IpView
   if {($value_primitive == "PLL") && ($devicetype != 2)  } {
      if {$vco_freq == 800.000 && $diff_per > 0.000} {
         set clkinp [expr $clkinp - 0.001]
      }
   } else {
      if {$vco_freq == 600.000 && $diff_per > 0.000} {
         set clkinp [expr $clkinp - 0.001]
      }
   }
   set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView] 
   common_uijitter_jitteroptions_infreq $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
}

proc SECONDARY_IN_TIMEPERIOD_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
 set intime2 [get_param_value SECONDARY_IN_TIMEPERIOD]
  if { [get_param_value INPUT_MODE ] =="Time"} {
      set infreq2 [convert_ns_to_MHz $intime2]
      set_property value $infreq2 [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
   }

   }

proc USE_INCLK_SWITCHOVER_updated {IpView} {
   variable devicefamily
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   variable clk_wiz_v6_0_utils::c_using_2_inclks
ENABLE_USER_CLOCK1_updated $IpView
   set CLKIN2_UI_JITTER [ipgui::get_paramspec -name CLKIN2_UI_JITTER -of $IpView ]
   set SECONDARY_IN_FREQ [ipgui::get_paramspec -name SECONDARY_IN_FREQ -of $IpView ]
   set SECONDARY_PORT [ipgui::get_paramspec -name SECONDARY_PORT -of $IpView ]
   # Enable/disable the secondary input clock row based on this use.
   set bEnable [get_param_value USE_INCLK_SWITCHOVER ]
   set c_using_2_inclks $bEnable 
   set_property enabled $bEnable $SECONDARY_IN_FREQ
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
   set_property enabled false $SECONDARY_PORT
	   } else {
	 if {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin" } {
   set_property enabled false $SECONDARY_PORT
   } else {
   set_property enabled $bEnable $SECONDARY_PORT
   }
	   }
   set_property enabled $bEnable [ipgui::get_textspec In_Freq_Range_2 -of $IpView]
   set_property enabled $bEnable $CLKIN2_UI_JITTER
   set_property enabled false [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   set_property visible $bEnable [ipgui::get_paramspec -name RELATIVE_INCLK -of $IpView ]
   set_property visible $bEnable [ipgui::get_groupspec "Secondary Input Clock Attributes" -of $IpView ]
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "4" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
   set sec_clk_val [ clk_wiz_v6_0_utils::setup_infreq_min_sec [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
   if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
      set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
      set sec_clkperiod [ expr 1000.0 / $sec_clk_val ]
      set sec_period_val [setup_display_float_freq $sec_clkperiod ]
      set vco_freq [ expr (1.0 * $sec_clk_val * $clkFBMult) / ($clkFBDiv) ]
      if {($value_primitive == "PLL") && ($devicetype != 2)  } {
         if {$vco_freq >= 799.990 && $vco_freq <= 800.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
            set sec_clk_val [format "%3.3f" $sec_clk_val ]
         }
      } else {
         if {$vco_freq >= 599.990 && $vco_freq <= 600.000} {
            set sec_clk_val [expr $sec_clk_val + 0.001]
         }
      }
      set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
   }
#   set_property value $sec_clk_val [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView] 
   #set_property visible $bEnable [ipgui::get_textspec clk_in_sel -of $IpView]
   #set_property visible $bEnable [ipgui::get_paramspec CLK_IN_SEL_PORT -of $IpView]
   #set_property visible $bEnable [ipgui::get_textspec -name Inclk_Sum_Secondary -of $IpView ]
   #set_property visible $bEnable [ipgui::get_textspec -name Inclk_Sum_Secondary_Freq -of $IpView ]
   #set_property visible $bEnable [ipgui::get_textspec -name Inclk_Sum_Secondary_Jitter -of $IpView ]
   #set_property visible $bEnable [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
   #set_property visible $bEnable [ipgui::get_paramspec Inclk_Sum_Secondary_Freq -of $IpView]
   #set_property visible $bEnable [ipgui::get_paramspec Inclk_Sum_Secondary_Jitter -of $IpView]
   #set_property enabled $bEnable [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   # If USE_INCLK_SWITCHOVER is true (2 input clks are used), then USE_RESET must be true
   # and disabled.
   # (Note, 2 inclks can only be possible for V6, so no need to check for that here.)
   set USE_RESET [ipgui::get_paramspec USE_RESET -of $IpView]
   if { $bEnable == true  } {
      set_property hidden_rows "$rows" $page5_Table3
      set_property enabled false $USE_RESET
      set_property value true $USE_RESET
      if { ([get_param_value USE_DYN_RECONFIG] == true || [get_param_value ENABLE_CLOCK_MONITOR] == true ) && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
        set_property enabled false [ipgui::get_paramspec RESET_TYPE -of $IpView]
      } else {
		set_property enabled true [ipgui::get_paramspec RESET_TYPE -of $IpView]
      }
	  #set_property hidden_rows "" [ipgui::get_tablespec page5_Table -of $IpView]
      set_property tooltip "Specify the secondary input clock's peak-to-peak period jitter, in UI or ps." $CLKIN2_UI_JITTER
      set_property tooltip "Specify the secondary clock input frequency to the clock manager." $SECONDARY_IN_FREQ
   } else {
   if { [get_param_value PRIMITIVE] == "Auto"} {
      set_property value false $USE_RESET
   } else {
      set_property value true $USE_RESET
   }
      set_property hidden_rows "4,$rows" $page5_Table3
      if { ([get_param_value USE_DYN_RECONFIG] == true || [get_param_value ENABLE_CLOCK_MONITOR] == true ) && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
	    set_property enabled false $USE_RESET
      } else {
        set_property enabled true $USE_RESET
      }
	  
      if { [get_param_value ENABLE_CLOCK_MONITOR] == true } {
	    set_property enabled false $USE_RESET
      } else {
        set_property enabled true $USE_RESET
      }
	 # set_property hidden_rows "2" [ipgui::get_tablespec page5_Table -of $IpView]
      set_property tooltip "When Input clock switchover is used, \nspecify the input peak-to-peak period jitter on the secondary clock." $CLKIN2_UI_JITTER
      set_property tooltip "When Input clock switchover is used, \nspecify the secondary clock input frequency to the clock manager." $SECONDARY_IN_FREQ
   }
   common_phase_alignment_inclk_switchover $IpView
   pre_calculate $IpView
   common_all_update_calc_done $IpView
   set infreq2 [get_param_value SECONDARY_IN_FREQ] 
   set clkinp [clk_wiz_v6_0_utils::get_inclk_period $infreq2]
   set rounding_per [clk_wiz_v6_0_utils::setup_display_float $clkinp] 
   set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
   set sec_clkperiod [ expr 1000.0 / $infreq2 ]
   set sec_period_val [setup_display_float_freq $sec_clkperiod ]
   set vco_freq [ expr (1.0 * $infreq2 * $clkFBMult) / ($clkFBDiv) ]
   set actual_per [expr (1000 / $infreq2) ]
   set diff_per [ expr ($rounding_per - $actual_per)]
   if {$vco_freq == 600.000 && $diff_per > 0.000} {
      set clkinp [expr $clkinp - 0.001]
   }
   
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT1_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT2_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT3_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT4_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT5_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT6_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT7_PORT -of $IpView]
	 } elseif {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin" } {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in1 [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in2 [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	 } else {
	   set_property enabled true [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
      if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
	   set_property enabled true [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   }
	 }
   set_property value [clk_wiz_v6_0_utils::setup_display_float $clkinp] [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView] 
} ;# end update_Use_Inclk_Switchover

proc JITTER_OPTIONS_updated {IpView} {
   variable Jitter_Changed
   set CLKIN1_UI_JITTER [ipgui::get_paramspec CLKIN1_UI_JITTER -of $IpView]
   set CLKIN2_UI_JITTER [ipgui::get_paramspec CLKIN2_UI_JITTER -of $IpView]

   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set freq1 [get_param_value PRIM_IN_FREQ]
      set maxValue [expr ( 1000 / $freq1 ) * 1000 ]
      set_property range "0,$maxValue" $CLKIN1_UI_JITTER
      set freq2 [get_param_value SECONDARY_IN_FREQ]
      set maxValue [expr ( 1000 / $freq2 ) * 1000 ]
      set_property range "0,$maxValue" $CLKIN2_UI_JITTER
      set val1 [get_param_value CLKIN1_UI_JITTER]
      set val2 [get_param_value CLKIN2_UI_JITTER]
      if { $val1 < 1 } {
         set convertedVal [clk_wiz_v6_0_utils::convert_UI_to_ps_for_inclk $val1 $freq1 ]
         set convertedVal [clk_wiz_v6_0_utils::setup_display_float $convertedVal]
         set_property value $convertedVal $CLKIN1_UI_JITTER
         set Jitter_Changed true
      }
      if { $val2 < 1 } { 
         set convertedVal [clk_wiz_v6_0_utils::convert_UI_to_ps_for_inclk $val2 $freq2 ]
         set convertedVal [clk_wiz_v6_0_utils::setup_display_float $convertedVal]
         set_property value $convertedVal $CLKIN2_UI_JITTER
         set Jitter_Changed true
      }
   } else {
      if { $Jitter_Changed == true } {
         set_property range "0.000,0.999" $CLKIN1_UI_JITTER
         set_property range "0.000,0.999" $CLKIN2_UI_JITTER
         set freq1 [get_param_value PRIM_IN_FREQ]
         set freq2 [get_param_value SECONDARY_IN_FREQ]
         set val1 [get_param_value CLKIN1_UI_JITTER]
         set val2 [get_param_value CLKIN2_UI_JITTER]
         if { $val1 > 1 } {
            set convertedVal [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $val1 $freq1 ]
            set convertedVal [clk_wiz_v6_0_utils::setup_display_float $convertedVal]
            set_property value $ $CLKIN1_UI_JITTER
         }
         if { $val2 > 1 } {
            set convertedVal [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $val2 $freq2 ]
            set convertedVal [clk_wiz_v6_0_utils::setup_display_float $convertedVal]
            set_property value $convertedVal $CLKIN2_UI_JITTER
         }
      }
   }
   common_uijitter_jitteroptions_infreq $IpView
}

proc CLKOUT1_DRIVES_updated {IpView} {
  variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set value_primitive [get_param_value PRIMITIVE] 
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
  set FEEDBACK_SOURCE [ipgui::get_paramspec FEEDBACK_SOURCE -of $IpView]
   
   if { [get_param_value CLKOUT1_DRIVES] == "No_buffer" } {
      if {($value_primitive == "PLL") && ($devicetype == 2)  } {
        set_property range_value "[get_param_value FEEDBACK_SOURCE ], FDBK_ONCHIP" $FEEDBACK_SOURCE
      } else {	  
        set_property range_value "[get_param_value FEEDBACK_SOURCE ], FDBK_ONCHIP, FDBK_OFFCHIP" $FEEDBACK_SOURCE
      }  
	set_property enabled false [ipgui::get_paramspec CLKOUT1_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT1_MATCHED_ROUTING -of $IpView]  
   } else {
      if {($value_primitive == "PLL") && ($devicetype == 2)  } {     
        set_property range_value "[get_param_value FEEDBACK_SOURCE ], FDBK_AUTO, FDBK_ONCHIP" $FEEDBACK_SOURCE
      } else {
        set_property range_value "[get_param_value FEEDBACK_SOURCE ], FDBK_AUTO, FDBK_AUTO_OFFCHIP, FDBK_ONCHIP, FDBK_OFFCHIP" $FEEDBACK_SOURCE
      }
	set_property enabled true [ipgui::get_paramspec CLKOUT1_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT1_MATCHED_ROUTING -of $IpView]  
   }
   #common_primitive_phasealignment_drives $IpView [get_param_value CLKOUT1_DRIVES]
   #common_all_update_calc_done $IpView
}

proc CLKOUT2_DRIVES_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { [get_param_value CLKOUT2_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT2_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT2_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT2_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT2_MATCHED_ROUTING -of $IpView]  
   }
}

proc CLKOUT3_DRIVES_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { [get_param_value CLKOUT3_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT3_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT3_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT3_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT3_MATCHED_ROUTING -of $IpView]  
   }
}

proc CLKOUT4_DRIVES_updated {IpView} {
   if { [get_param_value CLKOUT4_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT4_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT4_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT4_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT4_MATCHED_ROUTING -of $IpView]  
   }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
}

proc CLKOUT5_DRIVES_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { [get_param_value CLKOUT5_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT5_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT5_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT5_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT5_MATCHED_ROUTING -of $IpView]  
   }
}

proc CLKOUT6_DRIVES_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { [get_param_value CLKOUT6_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT6_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT6_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT6_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT6_MATCHED_ROUTING -of $IpView]  
   }
}

proc CLKOUT7_DRIVES_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { [get_param_value CLKOUT7_DRIVES] == "No_buffer" } {
	set_property enabled false [ipgui::get_paramspec CLKOUT7_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT7_MATCHED_ROUTING -of $IpView]  
   } else {
	set_property enabled true [ipgui::get_paramspec CLKOUT7_MATCHED_ROUTING -of $IpView]  
	set_property value false [ipgui::get_paramspec CLKOUT7_MATCHED_ROUTING -of $IpView]  
   }
}

# To fix CR 650750, The MMCME2_ADV block CLKOUT pins that do not drive the same kind of BUFFER load as the other CLKOUT pins Routing from the different buffer types will not be phase aligned
# Not using this, please refere CR 669250
proc common_primitive_phasealignment_drives {IpView drives} {
   if { $drives != "No_buffer" } {
      if { [get_param_value PRIMITIVE] == "MMCM" } {
         for {set j 1} {$j <= 7} {incr j} {
           if { [get_param_value USE_PHASE_ALIGNMENT] == true } {
              if { $drives == "BUFR" } {
                 set drives "BUFG"
              }
           } else {
              if { $j > 4 && $drives == "BUFR" } {
                 set drives "No_buffer"
              }
           }
           if { [get_param_value CLKOUT${j}_DRIVES] != "No_buffer" } {
              set_property value $drives [ipgui::get_paramspec CLKOUT${j}_DRIVES -of $IpView]
           }
         }
      }
   }
# if { [get_param_value PRIMITIVE ] == "Auto" } {
        # determine_auto_primitive $IpView
	# }
}

proc Prim_in_freq_Warning_SetText {IpView} {
   set str ""
   if { [get_param_value OVERRIDE_MMCM] == true } {
   set_property enabled true [ipgui::get_textspec Prim_in_freq_Warning -of $IpView]
   set str "<font color=red>WARNING : On Changing the input frequency when override mode is selected, M/D/O values will be calculated based on Requested frequency and OVERRIDE_MODE will be set to FALSE </font>"
   } else {
   set_property enabled false [ipgui::get_textspec Prim_in_freq_Warning -of $IpView]
   }
   return $str
}
proc Jitter_Warning_SetText {IpView} {
  set freq [get_param_value PRIM_IN_FREQ]
   set period [ expr 1000 / $freq ]
   set period20 [expr $period*0.2]
   if { $period20 > 1 } {
      set period20 1
   }
   set maxJitterPeriod 0
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]

   if {$devicetype == 2 } {
       set maxJitter  [clk_wiz_v6_0_utils::get_speedsfile_key_value "MMCM_REF_CLK_JITTER_MAX"]
       if { $maxJitter > 1 } {
          set maxJitterPeriod [expr $maxJitter / 1000]
       }
   }

   set str ""
   set jitter [get_param_value CLKIN1_UI_JITTER]
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set jitter [expr $jitter/1000]
   } else {
      set jitter [expr $jitter * $period]
   }

  if {$devicetype == 2} {
   if { $jitter >= $maxJitterPeriod } {
      set_property enabled true [ipgui::get_textspec Jitter_Warning -of $IpView]
     # set maxP [expr ($period20*999)]
      set str "<font color=red>Jitter value entered exceeds the specified range(0 - $maxJitter) PS. Primitive performance may not be guaranteed</font>"
   } else {
      set_property enabled false [ipgui::get_textspec Jitter_Warning -of $IpView]
   }
  } else {
     if { $jitter >= $period20 } {
      set_property enabled true [ipgui::get_textspec Jitter_Warning -of $IpView]
      set maxP [expr ($period20*999)]
      set str "<font color=red>Jitter value entered exceeds the specified range(0 - $maxP) PS. Primitive performance may not be guaranteed</font>"
     } else {
      set_property enabled false [ipgui::get_textspec Jitter_Warning -of $IpView]
     }
  }  

   return $str
}

proc Max_Buffer_Freq_Warning_SetText {IpView} {
   set str ""
   variable CLKOUT1_freq_in_buffer_range
   variable CLKOUT2_freq_in_buffer_range
   variable CLKOUT3_freq_in_buffer_range
   variable CLKOUT4_freq_in_buffer_range
   variable CLKOUT5_freq_in_buffer_range
   variable CLKOUT6_freq_in_buffer_range
   variable CLKOUT7_freq_in_buffer_range
   
   set llist {}
   set str ""
   
   for { set i 1} { $i <= 7 } { incr i } {
    EvalSubstituting {i} {
      if {$CLKOUT$i_freq_in_buffer_range == "false"} {
         set llist [concat $llist clk_out$i]
      }
    } 0
   }
   
   set llist [join $llist ,] 
   
   if {$llist != ""} {
      set_property enabled true [ipgui::get_textspec Max_Buffer_Freq_Warning -of $IpView]
      set str "<font color=red>WARNING : $llist output frequencies are out of range for the corresponding buffers. Timing violations may be present.</font>"
   } else {
      set_property enabled false [ipgui::get_textspec Max_Buffer_Freq_Warning -of $IpView]
   }
   
   return $str
}
proc optimize_str_message_SetText {IpView} {
   variable devicefamily
    set str ""
    set devicetype  [getDeviceType $devicefamily]
   set prim [get_param_value PRIMITIVE ]
   set dyn_reconfig_en [get_param_value USE_DYN_RECONFIG]
   if {($prim == "MMCM" || $prim == "PLL") && ($devicetype == 2) && !$dyn_reconfig_en} {
   set str "<font color=green><b> RECOMMENDED TO ENABLE THE \"OPTIMIZE CLOCKING STRUCUTRE\" CHECK-BOX TO GET OPTIMIZED CLOCKING STRUCTURE </b></font>"
   } else {
   }
   return $str
}
proc Freq_match_Warning_SetText {IpView} {
   set str ""
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_OUT_FREQ
   set out_freq1 [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]
   set out_freq2 [get_param_value CLKOUT2_REQUESTED_OUT_FREQ]
   set out_freq3 [get_param_value CLKOUT3_REQUESTED_OUT_FREQ]
   set out_freq4 [get_param_value CLKOUT4_REQUESTED_OUT_FREQ]
   set out_freq5 [get_param_value CLKOUT5_REQUESTED_OUT_FREQ]
   set out_freq6 [get_param_value CLKOUT6_REQUESTED_OUT_FREQ]
   set out_freq7 [get_param_value CLKOUT7_REQUESTED_OUT_FREQ]
   set ss_en [get_param_value USE_SPREAD_SPECTRUM]
   set str ""
   set override_primitive [get_param_value OVERRIDE_MMCM]
     
   if {$out_freq1 != $text_CLKOUT1_ACTUAL_OUT_FREQ && !$override_primitive} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out1 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT1_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq2 != $text_CLKOUT2_ACTUAL_OUT_FREQ && [get_param_value CLKOUT2_USED] && !$override_primitive} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out2 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT2_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq3 != $text_CLKOUT3_ACTUAL_OUT_FREQ && [get_param_value CLKOUT3_USED] && !$override_primitive && !$ss_en} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out3 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT3_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq4 != $text_CLKOUT4_ACTUAL_OUT_FREQ && [get_param_value CLKOUT4_USED] && !$override_primitive && !$ss_en} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out4 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT4_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq5 != $text_CLKOUT5_ACTUAL_OUT_FREQ && [get_param_value CLKOUT5_USED] && !$override_primitive} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out5 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT5_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq6 != $text_CLKOUT6_ACTUAL_OUT_FREQ && [get_param_value CLKOUT6_USED] && !$override_primitive} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out6 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT6_ACTUAL_OUT_FREQ</font>"
   } elseif {$out_freq7 != $text_CLKOUT7_ACTUAL_OUT_FREQ && [get_param_value CLKOUT7_USED] && !$override_primitive} {  
   set_property enabled true [ipgui::get_textspec Freq_match_Warning -of $IpView]
   set str "<font color=red>WARNING : The Requested frequency value for clk_out7 can not be achieved. Please change the requested frequency or proceed with the nearest obtained frequency value of $text_CLKOUT7_ACTUAL_OUT_FREQ</font>"
   } else {
   set_property enabled false [ipgui::get_textspec Freq_match_Warning -of $IpView]
   }
   return $str
}
#edited
proc Dyn_Reconf_Connection_Warning_SetText {IpView} {
   variable devicefamily
   set str ""
   set warning_connect_clk_out2 ""
   set warning_connect_clk_out3 ""
   set warning_connect_clk_out4 ""
   set warning_connect_clk_out5 ""
   set devicetype  [getDeviceType $devicefamily]
   set prim [get_property modelparam_value [ipgui::get_modelparamspec C_PRIMITIVE -of $IpView]]
   set clklist {}
   set llist {}
   set str ""
   #clkout2
   if { $prim == "MMCM" && [get_param_value CLKOUT2_USED]}  { 
     if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS])}  { 
       set warning_connect_clk_out2 ""
     } else  {
       set warning_connect_clk_out2 "clk_out2 is connected to CLKOUT0B port of MMCM instead of CLKOUT1 port of MMCM"
     } 
   } elseif { [get_param_value CLKOUT2_USED]} {
     if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) || ([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1)}  { 
       set warning_connect_clk_out2 ""
     } else  {
       set warning_connect_clk_out2 "clk_out2 is connected to CLKOUT0B port of PLL instead of CLKOUT1 port of PLL"
     } 
   } 
   #clkout3
   if {$prim == "MMCM" && [get_param_value CLKOUT3_USED] }  { 
     if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set warning_connect_clk_out3 "clk_out3 is connected to CLKOUT1B port of MMCM instead of CLKOUT2 port of MMCM"
     } else  {
       set warning_connect_clk_out3 ""
     } 
   } elseif {[get_param_value CLKOUT3_USED]} {
     if {!([get_param_value MMCM_CLKOUT1_DIVIDE ] == [get_param_value MMCM_CLKOUT0_DIVIDE_F] && ([get_param_value MMCM_CLKOUT1_PHASE] - [get_param_value MMCM_CLKOUT0_PHASE]) == 180 && [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT1_USE_FINE_PS] == [get_param_value MMCM_CLKOUT0_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1) }  {  
       set warning_connect_clk_out3 "clk_out3 is connected to CLKOUT1B port of PLL instead of CLKOUT2 port of PLL"
     } else  {
       set warning_connect_clk_out3 ""
     } 
   }
   #clkout4
   if {!([get_param_value MMCM_CLKOUT2_DIVIDE ] == [get_param_value MMCM_CLKOUT1_DIVIDE] && ([get_param_value MMCM_CLKOUT2_PHASE] - [get_param_value MMCM_CLKOUT1_PHASE]) == 180 && [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT2_USE_FINE_PS] == [get_param_value MMCM_CLKOUT1_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT3_DIVIDE ] == [get_param_value MMCM_CLKOUT2_DIVIDE] && ([get_param_value MMCM_CLKOUT3_PHASE] - [get_param_value MMCM_CLKOUT2_PHASE]) == 180 && [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT3_USE_FINE_PS] == [get_param_value MMCM_CLKOUT2_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1)  && [get_param_value CLKOUT4_USED] }  {  
      set warning_connect_clk_out4 "clk_out4 is connected to CLKOUT2B port of MMCM instead of CLKOUT3 port of MMCM"
   } else  {
      set warning_connect_clk_out4 ""
   } 
   #clkout5
   if {!([get_param_value MMCM_CLKOUT3_DIVIDE ] == [get_param_value MMCM_CLKOUT2_DIVIDE] && ([get_param_value MMCM_CLKOUT3_PHASE] - [get_param_value MMCM_CLKOUT2_PHASE]) == 180 && [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT3_USE_FINE_PS] == [get_param_value MMCM_CLKOUT2_USE_FINE_PS]) && ([get_param_value MMCM_CLKOUT4_DIVIDE ] == [get_param_value MMCM_CLKOUT3_DIVIDE] && ([get_param_value MMCM_CLKOUT4_PHASE] - [get_param_value MMCM_CLKOUT3_PHASE]) == 180 && [get_param_value MMCM_CLKOUT4_DUTY_CYCLE] == [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] && [get_param_value MMCM_CLKOUT4_USE_FINE_PS] == [get_param_value MMCM_CLKOUT3_USE_FINE_PS]) && !([get_param_value PRIMITIVE] == "PLL" && $devicetype == 1)  && [get_param_value CLKOUT5_USED] }  {  
      set warning_connect_clk_out5 "clk_out5 is connected to CLKOUT3B port of MMCM instead of CLKOUT4 port of MMCM"
   } else  {
      set warning_connect_clk_out5 "" 
   } 

   if {$warning_connect_clk_out2 != ""} {
      set clklist [lappend clklist clk_out2]
      set llist [lappend llist $warning_connect_clk_out2]
   }
   if {$warning_connect_clk_out3 != ""} {
      set clklist [lappend clklist clk_out3]
      set llist [lappend llist $warning_connect_clk_out3]
   }
   if {$warning_connect_clk_out4 != ""} {
      set clklist [lappend clklist clk_out4]
      set llist [lappend llist $warning_connect_clk_out4]
   }
   if {$warning_connect_clk_out5 != ""} {
      set clklist [lappend clklist clk_out5]
      set llist [lappend llist $warning_connect_clk_out5]
   }
   
   set llist [join $llist ", "] 
   set clklist [join $clklist ,]   

   if {$clklist != "" && [get_param_value USE_DYN_RECONFIG]} {
      set_property enabled true [ipgui::get_textspec Dyn_Reconf_Connection_Warning -of $IpView]
      set str "<font color=red>WARNING : Dynamic Reconfiguration feature will not work for $clklist ports because, $llist</font>"
   } else {
      set_property enabled false [ipgui::get_textspec Dyn_Reconf_Connection_Warning -of $IpView]
   }
   
   return $str
}

proc CLKIN1_JITTER_PS_updated {IpView} {
   #$CLKIN1_JITTER_PS SetValue [ clk_wiz_v6_0_utils::get_ps_jitter 1 ]
} ;# end 

proc USE_RESET_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set RESET_PORT [ipgui::get_paramspec RESET_PORT -of $IpView] 
   set reset [ipgui::get_textspec reset -of $IpView]
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "1" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }

   if { [get_param_value USE_RESET] == false } {
      set_property hidden_rows "1,$rows" $page5_Table3
      set_property visible false $reset
      set_property enabled false [ipgui::get_paramspec RESET_TYPE -of $IpView]
      set_property visible false $RESET_PORT
     # set_property enabled false $RESET_PORT
   } else {
      set_property hidden_rows "1,$rows" $page5_Table3
      set_property visible true $reset
      set_property visible true $RESET_PORT
      if { [get_param_value USE_DYN_RECONFIG] == true && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
        set_property enabled false [ipgui::get_paramspec RESET_TYPE -of $IpView]
        set_property enabled false [ipgui::get_paramspec USE_RESET -of $IpView]
      } else {  
		set_property enabled true [ipgui::get_paramspec RESET_TYPE -of $IpView]
      }   
   }
}

proc RESET_TYPE_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
    if { [get_param_value RESET_TYPE] == "ACTIVE_LOW" } {
       set_property value "resetn" [ipgui::get_paramspec RESET_PORT -of $IpView] 
    } else {
       set_property value "reset" [ipgui::get_paramspec RESET_PORT -of $IpView] 
    }
}

proc USE_LOCKED_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set locked [ipgui::get_textspec locked -of $IpView] 
   set LOCKED_PORT [ipgui::get_paramspec LOCKED_PORT -of $IpView] 
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "2" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
   if { [get_param_value USE_LOCKED] == false } {
      set_property hidden_rows "2,$rows" $page5_Table3
      set_property visible false $locked
      set_property visible false $LOCKED_PORT
   } else {
      set_property hidden_rows "$rows" $page5_Table3
      set_property visible true $locked
      set_property visible true $LOCKED_PORT
   }
}

proc USE_POWER_DOWN_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "3" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
   if { [get_param_value USE_POWER_DOWN] == false } {
      set_property hidden_rows "3,$rows" $page5_Table3
      set_property visible false [ipgui::get_textspec power_down -of $IpView] 
      set_property visible false [ipgui::get_paramspec POWER_DOWN_PORT -of $IpView] 
   } else {
      set_property hidden_rows "$rows" $page5_Table3
      set_property visible true [ipgui::get_textspec power_down -of $IpView] 
      set_property visible true [ipgui::get_paramspec POWER_DOWN_PORT -of $IpView] 
   }
}
proc USE_INCLK_STOPPED_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "5" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
   if { [get_param_value USE_INCLK_STOPPED] == false } {
      set_property hidden_rows "5,$rows" $page5_Table3
      set_property visible false [ipgui::get_textspec input_clk_stopped -of $IpView] 
      set_property visible false [ipgui::get_paramspec INPUT_CLK_STOPPED_PORT -of $IpView] 
   } else {
      set_property hidden_rows "$rows" $page5_Table3
      set_property visible true [ipgui::get_textspec input_clk_stopped -of $IpView] 
      set_property visible true [ipgui::get_paramspec INPUT_CLK_STOPPED_PORT -of $IpView] 
   }
}
proc USE_CLKFB_STOPPED_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "6" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
   if { [get_param_value USE_CLKFB_STOPPED ] == false } {
      set_property hidden_rows "6,$rows" $page5_Table3
      set_property visible false [ipgui::get_textspec clkfb_stopped -of $IpView] 
      set_property visible false [ipgui::get_paramspec CLKFB_STOPPED_PORT -of $IpView] 
   } else {
      set_property hidden_rows "$rows" $page5_Table3
      set_property visible true [ipgui::get_textspec clkfb_stopped -of $IpView] 
      set_property visible true [ipgui::get_paramspec CLKFB_STOPPED_PORT -of $IpView] 
   }
}

proc CLK_OUT1_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT0_USE_FINE_PS -of $IpView]
   } else {
     if {$usePhaseAlignment == true} {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
	 } else { 
	   if {($value_primitive == "PLL") && ($devicetype == 2)  } {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
	   } else {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
       }
	 }      
	  set_property value false [ipgui::get_paramspec MMCM_CLKOUT0_USE_FINE_PS -of $IpView]
   }
}

proc CLK_OUT2_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]

   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT1_USE_FINE_PS -of $IpView]
   } elseif { [get_param_value CLKOUT2_USED] } {
      if {($value_primitive == "MMCM" || $value_primitive == "Auto") && ($devicetype == 2)  } {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
     set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
      } elseif {$usePhaseAlignment == true} {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
     set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
      } else {
	    if {($value_primitive == "PLL") && ($devicetype == 2)  } {
          set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
        } else {
		  set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
	    }
	  } 
	  set_property value false [ipgui::get_paramspec MMCM_CLKOUT1_USE_FINE_PS -of $IpView]
   }
}
proc CLK_OUT3_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   if { [get_param_value CLK_OUT3_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT2_USE_FINE_PS -of $IpView]
   } elseif { [get_param_value CLKOUT3_USED] } {
      if {$usePhaseAlignment == true} {
	    set_property enabled true [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
      } else {
        set_property enabled false [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
	  }
	  set_property value false [ipgui::get_paramspec MMCM_CLKOUT2_USE_FINE_PS -of $IpView]
   }
}
proc CLK_OUT4_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   if { [get_param_value CLK_OUT4_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT3_USE_FINE_PS -of $IpView]
   } elseif { [get_param_value CLKOUT4_USED] } {
      if {$usePhaseAlignment == true} {
	    set_property enabled true [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
      } else {
        set_property enabled false [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
	  }
      set_property value false [ipgui::get_paramspec MMCM_CLKOUT3_USE_FINE_PS -of $IpView]
   }
}
proc CLK_OUT5_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   if { [get_param_value CLK_OUT5_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT4_USE_FINE_PS -of $IpView]
   } elseif { [get_param_value CLKOUT5_USED] } {
      if {$usePhaseAlignment == true} {
	    set_property enabled true [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
      } else {
        set_property enabled false [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
	  }
      set_property value false [ipgui::get_paramspec MMCM_CLKOUT4_USE_FINE_PS -of $IpView]
   }
}
proc CLK_OUT6_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   if { [get_param_value CLK_OUT6_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT5_USE_FINE_PS -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
   } elseif { [get_param_value CLKOUT6_USED] } {
      if {$usePhaseAlignment == true} {
	    set_property enabled true [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
      } else {
        set_property enabled false [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
	  }
      set_property value false [ipgui::get_paramspec MMCM_CLKOUT5_USE_FINE_PS -of $IpView]
   }
}
proc CLK_OUT7_USE_FINE_PS_GUI_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   if { [get_param_value CLK_OUT7_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
      set_property value true [ipgui::get_paramspec MMCM_CLKOUT6_USE_FINE_PS -of $IpView]
   } elseif { [get_param_value CLKOUT7_USED] } {
      if {$usePhaseAlignment == true} {
	    set_property enabled true [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
      } else {
        set_property enabled false [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
	  }
      set_property value false [ipgui::get_paramspec MMCM_CLKOUT6_USE_FINE_PS -of $IpView]
   }
}

proc common_Primitive_DynPhaseShift { IpView } {
   if { ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT1_USE_FINE_PS_GUI -of $IpView]
      for { set i 2} { $i <= 7 } { incr i } {
          if { [ get_param_value CLKOUT${i}_USED] } {
             set_property enabled true [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
          }
      }
   } else {
      for { set i 1} { $i <= 7 } { incr i } {
          set_property enabled false [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
          set_property value false [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
      }
   }
}

#################################################################
#
#   updateModel Section
#
#   These Tcl procedures are responsible for XCO to SIM parameter
#   translation performed on core Generation only.
#
#################################################################

proc updateModel_C_MMCMBUFGCEDIV  {IpView} {
   if { [get_param_value AUTO_PRIMITIVE] == "MMCM"} {
   set list [mmcm_bufgcediv_seperation $IpView ]
   
   set length [llength $list]
    if { $length > 0 } {
   set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV -of $IpView]
   } else {
   set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV -of $IpView]
   }
   } else {
   set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV -of $IpView]
   }
} ;# end

proc updateModel_C_MMCMBUFGCEDIV1  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv1
variable  buffer_bufgcediv1
   if {$mmcm_bufgcediv1 == true} {
set  buffer_bufgcediv1 true
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV1 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV1 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV1 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV2  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv2 
   if {$mmcm_bufgcediv2 == true} {
 ########send_msg INFO 881 "MMCM true"
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV2 -of $IpView]
		} else {
 ########send_msg INFO 882 " MMCM false"
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV2 -of $IpView]
		}
		} else {
 ########send_msg INFO 883 "non MMCM"
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV2 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV3  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
set ss [get_param_value USE_SPREAD_SPECTRUM]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv3
   if {$mmcm_bufgcediv3 == true && !$ss} {
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV3 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV3 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV3 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV4  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
set ss [get_param_value USE_SPREAD_SPECTRUM]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv4
   if {$mmcm_bufgcediv4 == true && !$ss} {
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV4 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV4 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV4 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV5  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv5
   if {$mmcm_bufgcediv5 == true} {
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV5 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV5 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV5 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV6  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv6
   if {$mmcm_bufgcediv6 == true} {
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV6 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV6 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV6 -of $IpView]
		}
} ;# end
proc updateModel_C_MMCMBUFGCEDIV7  {IpView} {
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
 if  { ([get_param_value AUTO_PRIMITIVE] == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM")) } {
decide_buffers $IpView
variable  mmcm_bufgcediv7
   if {$mmcm_bufgcediv7 == true} {
        set_property modelparam_value "true" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV7 -of $IpView]
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV7 -of $IpView]
		}
		} else {
        set_property modelparam_value "false" [ipgui::get_modelparamspec  C_MMCMBUFGCEDIV7 -of $IpView]
		}
} ;# end

proc updateModel_C_PLLBUFGCEDIV  {IpView} {
   set auto_prim [get_param_value AUTO_PRIMITIVE]
   set prim_type [get_param_value PRIMITIVE]
   set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
   if { ($auto_prim == "PLL") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ($prim_type == "PLL")) } {
    set list [pll_bufgcediv_seperation $IpView ]
    set length [llength $list] 
   if { $length > 0 } {
   set_property modelparam_value "true" [ipgui::get_modelparamspec  C_PLLBUFGCEDIV -of $IpView]
   } else {
   set_property modelparam_value "false" [ipgui::get_modelparamspec  C_PLLBUFGCEDIV -of $IpView]
   }
   } else {
   set_property modelparam_value "false" [ipgui::get_modelparamspec  C_PLLBUFGCEDIV -of $IpView]
   }
} ;# end

proc updateModel_C_PLLBUFGCEDIV1  {IpView} {
variable clk1_bufgce
   set_property modelparam_value $clk1_bufgce [ipgui::get_modelparamspec  C_PLLBUFGCEDIV1 -of $IpView]
} ;# end

proc updateModel_C_PLLBUFGCEDIV2  {IpView} {
variable clk2_bufgce
   set_property modelparam_value $clk2_bufgce [ipgui::get_modelparamspec  C_PLLBUFGCEDIV2 -of $IpView]
} ;# end

proc updateModel_C_PLLBUFGCEDIV3  {IpView} {
variable clk3_bufgce
   set_property modelparam_value $clk3_bufgce [ipgui::get_modelparamspec  C_PLLBUFGCEDIV3 -of $IpView]
} ;# end

proc updateModel_C_PLLBUFGCEDIV4  {IpView} {
variable clk4_bufgce
   set_property modelparam_value $clk4_bufgce [ipgui::get_modelparamspec  C_PLLBUFGCEDIV4 -of $IpView]
} ;# end

proc updateModel_C_PRIMARY_PORT  {IpView} {
   set_property modelparam_value [get_param_value PRIMARY_PORT] [ipgui::get_modelparamspec  C_PRIMARY_PORT -of $IpView]
} ;# end

proc updateModel_C_SECONDARY_PORT  {IpView} {
   set_property modelparam_value [get_param_value SECONDARY_PORT] [ipgui::get_modelparamspec  C_SECONDARY_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT1_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT1_PORT] [ipgui::get_modelparamspec  C_CLK_OUT1_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT2_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT2_PORT] [ipgui::get_modelparamspec  C_CLK_OUT2_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT3_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT3_PORT] [ipgui::get_modelparamspec  C_CLK_OUT3_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT4_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT4_PORT] [ipgui::get_modelparamspec  C_CLK_OUT4_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT5_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT5_PORT] [ipgui::get_modelparamspec  C_CLK_OUT5_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT6_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT6_PORT] [ipgui::get_modelparamspec  C_CLK_OUT6_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_OUT7_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_OUT7_PORT] [ipgui::get_modelparamspec  C_CLK_OUT7_PORT -of $IpView]
} ;# end

proc updateModel_C_RESET_PORT  {IpView} {
   set_property modelparam_value [get_param_value RESET_PORT] [ipgui::get_modelparamspec  C_RESET_PORT -of $IpView]
} ;# end

proc updateModel_C_LOCKED_PORT  {IpView} {
   set_property modelparam_value [get_param_value LOCKED_PORT] [ipgui::get_modelparamspec  C_LOCKED_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_VALID_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_VALID_PORT] [ipgui::get_modelparamspec  C_CLK_VALID_PORT -of $IpView]
} ;# end

proc updateModel_C_STATUS_PORT  {IpView} {
   set_property modelparam_value [get_param_value STATUS_PORT] [ipgui::get_modelparamspec  C_STATUS_PORT -of $IpView]
} ;# end

proc updateModel_C_CLK_IN_SEL_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLK_IN_SEL_PORT] [ipgui::get_modelparamspec  C_CLK_IN_SEL_PORT -of $IpView]
} ;# end

proc updateModel_C_INPUT_CLK_STOPPED_PORT  {IpView} {
   set_property modelparam_value [get_param_value INPUT_CLK_STOPPED_PORT] [ipgui::get_modelparamspec  C_INPUT_CLK_STOPPED_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_STOPPED_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_STOPPED_PORT] [ipgui::get_modelparamspec  C_CLKFB_STOPPED_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_IN_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_IN_PORT] [ipgui::get_modelparamspec  C_CLKFB_IN_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_IN_P_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_IN_P_PORT] [ipgui::get_modelparamspec  C_CLKFB_IN_P_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_IN_N_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_IN_N_PORT] [ipgui::get_modelparamspec  C_CLKFB_IN_N_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_OUT_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_OUT_PORT] [ipgui::get_modelparamspec  C_CLKFB_OUT_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_OUT_P_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_OUT_P_PORT] [ipgui::get_modelparamspec  C_CLKFB_OUT_P_PORT -of $IpView]
} ;# end

proc updateModel_C_CLKFB_OUT_N_PORT  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_OUT_N_PORT] [ipgui::get_modelparamspec  C_CLKFB_OUT_N_PORT -of $IpView]
} ;# end

proc updateModel_C_POWER_DOWN_PORT  {IpView} {
   set_property modelparam_value [get_param_value POWER_DOWN_PORT] [ipgui::get_modelparamspec  C_POWER_DOWN_PORT -of $IpView]
} ;# end

proc updateModel_C_DADDR_PORT  {IpView} {
   set_property modelparam_value [get_param_value DADDR_PORT] [ipgui::get_modelparamspec  C_DADDR_PORT -of $IpView]
} ;# end

proc updateModel_C_DCLK_PORT  {IpView} {
   set_property modelparam_value [get_param_value DCLK_PORT] [ipgui::get_modelparamspec  C_DCLK_PORT -of $IpView]
} ;# end

proc updateModel_C_DRDY_PORT  {IpView} {
   set_property modelparam_value [get_param_value DRDY_PORT] [ipgui::get_modelparamspec  C_DRDY_PORT -of $IpView]
} ;# end

proc updateModel_C_DWE_PORT  {IpView} {
   set_property modelparam_value [get_param_value DWE_PORT] [ipgui::get_modelparamspec  C_DWE_PORT -of $IpView]
} ;# end

proc updateModel_C_DIN_PORT  {IpView} {
   set_property modelparam_value [get_param_value DIN_PORT] [ipgui::get_modelparamspec  C_DIN_PORT -of $IpView]
} ;# end

proc updateModel_C_DOUT_PORT  {IpView} {
   set_property modelparam_value [get_param_value DOUT_PORT] [ipgui::get_modelparamspec  C_DOUT_PORT -of $IpView]
} ;# end

proc updateModel_C_DEN_PORT  {IpView} {
   set_property modelparam_value [get_param_value DEN_PORT] [ipgui::get_modelparamspec  C_DEN_PORT -of $IpView]
} ;# end

proc updateModel_C_PSCLK_PORT  {IpView} {
   set_property modelparam_value [get_param_value PSCLK_PORT] [ipgui::get_modelparamspec  C_PSCLK_PORT -of $IpView]
} ;# end

proc updateModel_C_PSEN_PORT  {IpView} {
   set_property modelparam_value [get_param_value PSEN_PORT] [ipgui::get_modelparamspec  C_PSEN_PORT -of $IpView]
} ;# end

proc updateModel_C_PSINCDEC_PORT  {IpView} {
   set_property modelparam_value [get_param_value PSINCDEC_PORT] [ipgui::get_modelparamspec  C_PSINCDEC_PORT -of $IpView]
} ;# end

proc updateModel_C_PSDONE_PORT  {IpView} {
   set_property modelparam_value [get_param_value PSDONE_PORT] [ipgui::get_modelparamspec  C_PSDONE_PORT -of $IpView]
} ;# end

proc updateModel_c_component_name  {IpView} {

   set_property modelparam_value [get_param_value Component_Name] [ipgui::get_modelparamspec  c_component_name -of $IpView]
} ;# end 

proc updateModel_C_USE_FREQ_SYNTH  {IpView} {
   if {[get_param_value USE_FREQ_SYNTH]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_FREQ_SYNTH -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_FREQ_SYNTH -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_PHASE_ALIGNMENT  {IpView} {
   if {[get_param_value USE_PHASE_ALIGNMENT]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_PHASE_ALIGNMENT -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_PHASE_ALIGNMENT -of $IpView]
   }
} ;# end 

 
proc updateModel_C_JITTER_SEL  {IpView} {
   set_property modelparam_value [get_param_value JITTER_SEL] [ipgui::get_modelparamspec  C_JITTER_SEL -of $IpView]
} 
proc updateModel_C_USE_MIN_POWER  {IpView} {
   if {[get_param_value USE_MIN_POWER]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_MIN_POWER -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_MIN_POWER -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_DYN_PHASE_SHIFT  {IpView} {
   if {[get_param_value USE_DYN_PHASE_SHIFT]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_DYN_PHASE_SHIFT -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_DYN_PHASE_SHIFT -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_INCLK_SWITCHOVER  {IpView} {
   if {[get_param_value USE_INCLK_SWITCHOVER]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_INCLK_SWITCHOVER -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_INCLK_SWITCHOVER -of $IpView]
   }
} ;# end 

proc updateModel_C_OPTIMIZE_CLOCKING_STRUCTURE_EN  {IpView} {
   if {[get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_DYN_RECONFIG  {IpView} {
   if {[get_param_value USE_DYN_RECONFIG]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_DYN_RECONFIG -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_DYN_RECONFIG -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_FAST_SIMULATION {IpView} {
} ;# end 

proc updateModel_C_USE_SPREAD_SPECTRUM  {IpView} {
   if {[get_param_value USE_SPREAD_SPECTRUM]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_SPREAD_SPECTRUM -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_SPREAD_SPECTRUM -of $IpView]
   }

} ;# end 

proc updateModel_C_USE_MIN_O_JITTER  {IpView} {
  variable JITTER_SEL
   if { [get_param_value JITTER_SEL ] == "Min_O_Jitter" } {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_MIN_O_JITTER -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_MIN_O_JITTER -of $IpView]
   }

} ;

proc updateModel_C_USE_MAX_I_JITTER  {IpView} {
  variable JITTER_SEL
   if { [get_param_value JITTER_SEL ] == "Max_I_Jitter" } {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_MAX_I_JITTER -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_MAX_I_JITTER -of $IpView]
   }

} ;

proc updateModel_C_PRIMITIVE  {IpView} {
   set_property modelparam_value [get_param_value PRIMITIVE] [ipgui::get_modelparamspec  C_PRIMITIVE -of $IpView]
} ;

proc updateModel_C_PRIM_IN_FREQ  {IpView} {
   set_property modelparam_value [get_param_value PRIM_IN_FREQ] [ipgui::get_modelparamspec  C_PRIM_IN_FREQ -of $IpView]

} ;# end 

proc updateModel_C_PRIM_IN_TIMEPERIOD  {IpView} {
   set_property modelparam_value [get_param_value PRIM_IN_TIMEPERIOD] [ipgui::get_modelparamspec  C_PRIM_IN_TIMEPERIOD -of $IpView]

} ;# end  

proc updateModel_C_CLKIN1_JITTER_PS  {IpView} {
   set_property modelparam_value [get_param_value CLKIN1_JITTER_PS] [ipgui::get_modelparamspec  C_CLKIN1_JITTER_PS -of $IpView]
} ;# end 

proc updateModel_C_CLKIN2_JITTER_PS  {IpView} {
   set_property modelparam_value [get_param_value CLKIN2_JITTER_PS] [ipgui::get_modelparamspec  C_CLKIN2_JITTER_PS -of $IpView]
} ;# end 

proc updateModel_C_PRIM_SOURCE  {IpView} {
   set_property modelparam_value [get_param_value PRIM_SOURCE] [ipgui::get_modelparamspec  C_PRIM_SOURCE -of $IpView]

} ;# end 

proc updateModel_C_SECONDARY_SOURCE  {IpView} {
   set_property modelparam_value [get_param_value SECONDARY_SOURCE] [ipgui::get_modelparamspec  C_SECONDARY_SOURCE -of $IpView]

} ;# end 


    for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {
proc updateModel_C_CLKOUT$i_DRIVES  {IpView} {
         decide_buffers $IpView
variable  mmcm_bufgcediv$i
variable  drive_bufgcediv$i
variable  clk$i_bufgce
variable  numBUFGCE_DIV
variable  c_numBUFG
variable  c_numBUFGCE
variable  dup_numBUFG 0
variable  dup_numBUFGCE 0
if {$i == 1} {
        reset_res_params
        variable  dup_numBUFG 0
        variable  dup_numBUFGCE 0
		}
if {$i == 1} {
        if {[info exists numBUFGCE_DIV]} {
          variable numBUFGCE_DIV 0
        }
    }
    set used [get_param_value CLKOUT$i_USED]
   set primitive [get_param_value PRIMITIVE ]
   set auto_prim [get_param_value AUTO_PRIMITIVE]
   set safe_clk [get_param_value USE_SAFE_CLOCK_STARTUP]
   set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
    if { $used == true} {
    if { ($primitive == "Auto") && ($auto_prim == "BUFGCE_DIV" )} {
    if { $used == true} {
      set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	} else {
     set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	}
	} elseif { (($primitive == "Auto") && ($auto_prim == "PLL")) || (($primitive == "PLL") && $OPTIMIZE_CLOCKING_STRUCTURE_EN) } {
   if {($primitive == "PLL") && $OPTIMIZE_CLOCKING_STRUCTURE_EN} {
   pll_bufgcediv_seperation $IpView
   }
   if {[ get_param_value CLKOUT$i_DRIVES] == "BUFG" || [get_param_value CLKOUT$i_DRIVES] == "BUFGCE" || [get_param_value CLKOUT$i_DRIVES] == "No_buffer"} {
   set_property modelparam_value [get_param_value CLKOUT$i_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
   } elseif  {[get_param_value CLKOUT$i_DRIVES] == "BUFGCE_DIV" && $clk$i_bufgce == false} {
   set_property modelparam_value [get_param_value CLKOUT$i_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   } else {

    if { $clk$i_bufgce == true || $auto_prim == "BUFGCE_DIV" } {
      set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       } else {
##fix to resolve buffer instantiation issue
   if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
     if {[ get_param_value CLKOUT$i_MATCHED_ROUTING] == true} {
     set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	  } else {
     set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFG [expr {$c_numBUFG + 1}]
	  }
	 } elseif {[ get_param_value CLKOUT$i_DRIVES] == "Buffer_with_CE"} {
     if {[ get_param_value CLKOUT$i_MATCHED_ROUTING] == true} {
     set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	  } else {
     set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFGCE [expr {$c_numBUFGCE + 1}]
	  }
	 }
	   }
  }
	
	
	} else {

   if {[ get_param_value CLKOUT$i_DRIVES] == "BUFR" || [ get_param_value CLKOUT$i_DRIVES] == "BUFH" || [ get_param_value CLKOUT$i_DRIVES] == "BUFHCE" || [ get_param_value CLKOUT$i_DRIVES] == "BUFG" || [get_param_value CLKOUT$i_DRIVES] == "BUFGCE" || [get_param_value CLKOUT$i_DRIVES] == "No_buffer"} {
   set_property modelparam_value [get_param_value CLKOUT$i_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
   } elseif  {[get_param_value CLKOUT$i_DRIVES] == "BUFGCE_DIV" && $mmcm_bufgcediv$i == false} {
   set_property modelparam_value [get_param_value CLKOUT$i_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   } else {

	  if { $numBUFGCE_DIV < 4 } {
    if { $mmcm_bufgcediv$i == true} {
      set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   } elseif { $drive_bufgcediv$i == true} {
     set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       } else {
##fix to resolve buffer instantiation issue
   if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
     set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFG [expr {$c_numBUFG + 1}]
	 } elseif {[ get_param_value CLKOUT$i_DRIVES] == "Buffer_with_CE"} {
     set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFGCE [expr {$c_numBUFGCE + 1}]
	 }
	   }
  } else {
   if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
     set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFG [expr {$c_numBUFG + 1}]
	 } elseif  {[ get_param_value CLKOUT$i_DRIVES] == "Buffer_with_CE"} {
     set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
	 variable c_numBUFGCE [expr {$c_numBUFGCE  + 1}]
	 }
  }
  }
  }
  } else {
   if { $safe_clk == true} {
     set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
   } else {
     set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT$i_DRIVES -of $IpView]
   }
  

  }
  variable  dup_numBUFG $c_numBUFG
  variable  dup_numBUFGCE $c_numBUFGCE
} ;# end 

		} 0
	}


# proc updateModel_C_CLKOUT1_DRIVES  {IpView} {
         # reset_res_params
         # setup_ibuf_res_numbers $IpView
         # setup_oclk_res_numbers $IpView
         # show_res_labels
         # decide_buffers $IpView

# variable  mmcm_bufgcediv1
# variable  drive_bufgcediv1
   # variable  c_numBUFGCE_DIV
   # variable  numBUFGCE_DIV $c_numBUFGCE_DIV
   # if { $drive_bufgcediv1 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT1_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT1_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT1_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT1_DRIVES -of $IpView]
	  # }
# } ;# end 

# proc updateModel_C_CLKOUT2_DRIVES  {IpView} {
# variable  mmcm_bufgcediv2
# variable  drive_bufgcediv2
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv2 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv2 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT2_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT2_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT2_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT2_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT2_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT2_DRIVES -of $IpView]
	  # }
# } ;# end 

# proc updateModel_C_CLKOUT3_DRIVES  {IpView} {
# variable  mmcm_bufgcediv3
# variable  drive_bufgcediv3
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv3 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv3 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT3_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT3_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT3_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT3_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT3_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT3_DRIVES -of $IpView]
	  # }
# } ;# end 

# proc updateModel_C_CLKOUT4_DRIVES  {IpView} {
# variable  mmcm_bufgcediv4
# variable  drive_bufgcediv4
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv4 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv4 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT4_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT4_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT4_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT4_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT4_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT4_DRIVES -of $IpView]
	  # }
# } ;# end 

# proc updateModel_C_CLKOUT5_DRIVES  {IpView} {
# variable  mmcm_bufgcediv5
# variable  drive_bufgcediv5
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv5 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv5 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT5_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT5_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT5_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT5_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT5_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT5_DRIVES -of $IpView]
	  # }
# } ;# end 


# proc updateModel_C_CLKOUT6_DRIVES  {IpView} {
# variable  mmcm_bufgcediv6
# variable  drive_bufgcediv6
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv6 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv6 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT6_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT6_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT6_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT6_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT6_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT6_DRIVES -of $IpView]
	  # }
# } ;# end 

# proc updateModel_C_CLKOUT7_DRIVES  {IpView} {
# variable  mmcm_bufgcediv7
# variable  drive_bufgcediv7
   # variable  numBUFGCE_DIV
   # if { $mmcm_bufgcediv7 == true} {
     # set_property modelparam_value "No_buffer" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
  # } elseif { $drive_bufgcediv7 == true} {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	   # }
  # } elseif {[get_param_value CLKOUT7_DRIVES] == "Buffer"} {
     # if { [get_param_value CLKOUT7_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFG" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
      # }
   # } elseif {[get_param_value CLKOUT7_DRIVES] == "Buffer_with_CE"} {
     # if { [get_param_value CLKOUT7_MATCHED_ROUTING] == true }   {
	  # if { $numBUFGCE_DIV < 4 } {
     # set_property modelparam_value "BUFGCE_DIV" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	 # set numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
	   # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	   # }
       # } else {
     # set_property modelparam_value "BUFGCE" [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
      # }
	  # } else {
   # set_property modelparam_value [get_param_value CLKOUT7_DRIVES] [ipgui::get_modelparamspec  C_CLKOUT7_DRIVES -of $IpView]
	  # }
# } ;# end 

proc updateModel_C_IN_FREQ_UNITS  {IpView} {

   set_property modelparam_value [get_param_value IN_FREQ_UNITS] [ipgui::get_modelparamspec  C_IN_FREQ_UNITS -of $IpView]

} ;# end 

proc updateModel_C_SECONDARY_IN_FREQ  {IpView} {

   set_property modelparam_value [get_param_value SECONDARY_IN_FREQ] [ipgui::get_modelparamspec  C_SECONDARY_IN_FREQ -of $IpView]

} ;# end

proc updateModel_C_SECONDARY_IN_TIMEPERIOD  {IpView} {

   set_property modelparam_value [get_param_value SECONDARY_IN_TIMEPERIOD] [ipgui::get_modelparamspec  C_SECONDARY_IN_TIMEPERIOD -of $IpView]

} ;# end 

proc updateModel_C_PRIM_IN_JITTER  {IpView} {
   set_property modelparam_value [get_param_value PRIM_IN_JITTER] [ipgui::get_modelparamspec  C_PRIM_IN_JITTER -of $IpView]

} ;# end 

proc updateModel_C_SECONDARY_IN_JITTER  {IpView} {
   set_property modelparam_value [get_param_value SECONDARY_IN_JITTER] [ipgui::get_modelparamspec  C_SECONDARY_IN_JITTER -of $IpView]

} ;# end 

proc updateModel_C_NUM_OUT_CLKS  {IpView} {
   set_property modelparam_value [get_param_value NUM_OUT_CLKS] [ipgui::get_modelparamspec  C_NUM_OUT_CLKS -of $IpView]

} ;# end 

proc updateModel_C_USE_POWER_DOWN  {IpView} {
   if {[get_param_value USE_POWER_DOWN]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_POWER_DOWN -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_POWER_DOWN -of $IpView]
   }

} ;# end 

proc updateModel_C_USE_RESET  {IpView} {
   if {[get_param_value USE_RESET]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_RESET -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_RESET -of $IpView]
   }
} ;# end 

proc updateModel_C_RESET_LOW  {IpView} {
   if {[get_param_value RESET_TYPE]  == "ACTIVE_LOW"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_RESET_LOW -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_RESET_LOW -of $IpView]
   }
} ;# end

proc updateModel_C_USE_LOCKED  {IpView} {
   if {[get_param_value USE_LOCKED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_LOCKED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_LOCKED -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_CLK_VALID  {IpView} {
   if {[get_param_value USE_CLK_VALID]  == "true"} {
      #set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_CLK_VALID -of $IpView]
      #CR 845060 : User parameter is not used
	  set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_CLK_VALID -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_CLK_VALID -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_FREEZE  {IpView} {
   if {[get_param_value USE_FREEZE]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_FREEZE -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_FREEZE -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_STATUS  {IpView} {
   if {[get_param_value USE_STATUS]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_STATUS -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_STATUS -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_INCLK_STOPPED  {IpView} {
   if {[get_param_value USE_INCLK_STOPPED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_INCLK_STOPPED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_INCLK_STOPPED -of $IpView]
   }
} ;# end 

proc updateModel_C_USE_CLKFB_STOPPED  {IpView} {
   if {[get_param_value USE_CLKFB_STOPPED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_CLKFB_STOPPED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_CLKFB_STOPPED -of $IpView]
   }
} ;# end 

proc updateModel_C_FEEDBACK_SOURCE  {IpView} {
   set_property modelparam_value [get_param_value FEEDBACK_SOURCE] [ipgui::get_modelparamspec  C_FEEDBACK_SOURCE -of $IpView]

} ;# end 

proc updateModel_C_CLKFB_IN_SIGNALING  {IpView} {
   set_property modelparam_value [get_param_value CLKFB_IN_SIGNALING] [ipgui::get_modelparamspec  C_CLKFB_IN_SIGNALING -of $IpView]

} ;# end 

proc updateModel_C_PLATFORM  {IpView} {
   set_property modelparam_value [get_param_value PLATFORM] [ipgui::get_modelparamspec  C_PLATFORM -of $IpView]

} ;# end 

proc updateModel_C_CLKOUT2_USED  {IpView} {
   if {[get_param_value CLKOUT2_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT2_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT2_USED -of $IpView]
   }
} ;# end 

proc updateModel_C_CLKOUT3_USED  {IpView} {
   if {[get_param_value CLKOUT3_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT3_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT3_USED -of $IpView]
   }
} ;# end 

proc updateModel_C_CLKOUT4_USED  {IpView} {
   if {[get_param_value CLKOUT4_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT4_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT4_USED -of $IpView]
   }
} ;# end 

proc updateModel_C_CLKOUT5_USED  {IpView} {
   if {[get_param_value CLKOUT5_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT5_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT5_USED -of $IpView]
   }
} ;# end 

proc updateModel_C_CLKOUT6_USED  {IpView} {
   if {[get_param_value CLKOUT6_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT6_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT6_USED -of $IpView]
   }
} ;# end 

proc updateModel_C_CLKOUT7_USED  {IpView} {
   if {[get_param_value CLKOUT7_USED]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_CLKOUT7_USED -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_CLKOUT7_USED -of $IpView]
   }
} ;# end 

# translate oIpViewquest values for the user
proc updateModel_C_CLKOUT1_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT1_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
} ;;# end 
proc updateModel_C_CLKOUT2_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT2_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT3_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT3_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT4_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT4_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT5_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT5_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT6_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT6_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT7_REQUESTED_OUT_FREQ  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT7_REQUESTED_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT1_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT1_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT1_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT2_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT2_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT2_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT3_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT3_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT3_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT4_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT4_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT4_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT5_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT5_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT5_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT6_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT6_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT6_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT7_REQUESTED_PHASE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT7_REQUESTED_PHASE] [ipgui::get_modelparamspec  C_CLKOUT7_REQUESTED_PHASE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT1_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT1_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT2_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT2_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT2_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT3_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT3_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT3_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT4_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT4_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT4_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT5_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT5_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT5_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT6_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT6_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT6_REQUESTED_DUTY_CYCLE -of $IpView]
} ;# end 
proc updateModel_C_CLKOUT7_REQUESTED_DUTY_CYCLE  {IpView} {
  set_property modelparam_value [get_param_value CLKOUT7_REQUESTED_DUTY_CYCLE] [ipgui::get_modelparamspec  C_CLKOUT7_REQUESTED_DUTY_CYCLE -of $IpView]
   updateModel_c_summary_strings $IpView
} ;# end 
 
proc updateModel_C_SS_MODE {IpView} {
  set_property modelparam_value [get_param_value SS_MODE] [ipgui::get_modelparamspec C_SS_MODE -of $IpView]
}

proc updateModel_C_SS_MOD_PERIOD {IpView} {
  set modfreq [get_param_value SS_MOD_FREQ]
  set modperiod [clk_wiz_v6_0_utils::convert_KHz_to_ns $modfreq]
  set_property modelparam_value  $modperiod [ipgui::get_modelparamspec C_SS_MOD_PERIOD -of $IpView]
}
proc updateModel_C_SS_MOD_TIME  {IpView} {
if { [get_param_value INPUT_MODE] == "Time" } {
   set_property modelparam_value [get_param_value SS_MOD_TIME] [ipgui::get_modelparamspec  C_SS_MOD_TIME -of $IpView]
}
} ;# end  

proc updateModel_C_SS_MOD_FREQ  {IpView} {
  set modfreq [get_param_value SS_MOD_FREQ]
   set_property modelparam_value $modfreq [ipgui::get_modelparamspec  C_SS_MOD_FREQ -of $IpView]

} ;# end  

proc updateModel_C_CLKIN1_JITTER_PS  {IpView} {
   set_property modelparam_value [get_param_value CLKIN1_JITTER_PS] [ipgui::get_modelparamspec  C_CLKIN1_JITTER_PS -of $IpView]
} ;# end 
proc updateModel_C_HAS_CDDC  {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if {[get_param_value ENABLE_CDDC]  == "true" && $devicetype == 2} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_HAS_CDDC -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_HAS_CDDC -of $IpView]
   }
} 

proc updateModel_C_CDDCDONE_PORT {IpView} {
   set_property modelparam_value [get_param_value CDDCDONE_PORT] [ipgui::get_modelparamspec  C_CDDCDONE_PORT -of $IpView]
} 
proc updateModel_C_AUTO_PRIMITIVE {IpView} {
#set auto_selection [auto_selection $IpView ]
   set_property modelparam_value [get_param_value AUTO_PRIMITIVE] [ipgui::get_modelparamspec  C_AUTO_PRIMITIVE -of $IpView]
   #set_property value $auto_selection [ipgui::get_paramspec AUTO_PRIMITIVE -of $IpView]
} 
proc updateModel_C_USER_CLK_FREQ0 {IpView} {
   set_property modelparam_value [get_param_value USER_CLK_FREQ0] [ipgui::get_modelparamspec  C_USER_CLK_FREQ0 -of $IpView]
} 
proc updateModel_C_USER_CLK_FREQ1 {IpView} {
   set_property modelparam_value [get_param_value USER_CLK_FREQ1] [ipgui::get_modelparamspec  C_USER_CLK_FREQ1 -of $IpView]
} 
proc updateModel_C_USER_CLK_FREQ2 {IpView} {
   set_property modelparam_value [get_param_value USER_CLK_FREQ2] [ipgui::get_modelparamspec  C_USER_CLK_FREQ2 -of $IpView]
} 
proc updateModel_C_USER_CLK_FREQ3 {IpView} {
   set_property modelparam_value [get_param_value USER_CLK_FREQ3] [ipgui::get_modelparamspec  C_USER_CLK_FREQ3 -of $IpView]
} 
proc updateModel_C_ENABLE_USER_CLOCK0 {IpView} {
   set_property modelparam_value [get_param_value ENABLE_USER_CLOCK0] [ipgui::get_modelparamspec  C_ENABLE_USER_CLOCK0 -of $IpView]
} 
proc updateModel_C_ENABLE_USER_CLOCK1 {IpView} {
   set_property modelparam_value [get_param_value ENABLE_USER_CLOCK1] [ipgui::get_modelparamspec  C_ENABLE_USER_CLOCK1 -of $IpView]
} 
proc updateModel_C_ENABLE_USER_CLOCK2 {IpView} {
   set_property modelparam_value [get_param_value ENABLE_USER_CLOCK2] [ipgui::get_modelparamspec  C_ENABLE_USER_CLOCK2 -of $IpView]
} 
proc updateModel_C_ENABLE_USER_CLOCK3 {IpView} {
   set_property modelparam_value [get_param_value ENABLE_USER_CLOCK3] [ipgui::get_modelparamspec  C_ENABLE_USER_CLOCK3 -of $IpView]
} 
proc updateModel_C_Enable_PLL0 {IpView} {
   set_property modelparam_value [get_param_value Enable_PLL0] [ipgui::get_modelparamspec  C_Enable_PLL0 -of $IpView]
} 
proc updateModel_C_Enable_PLL1 {IpView} {
   set_property modelparam_value [get_param_value Enable_PLL1] [ipgui::get_modelparamspec  C_Enable_PLL1 -of $IpView]
} 
proc updateModel_C_REF_CLK_FREQ {IpView} {
   set_property modelparam_value [get_param_value REF_CLK_FREQ] [ipgui::get_modelparamspec  C_REF_CLK_FREQ -of $IpView]
} 
proc updateModel_C_PRECISION {IpView} {
   set_property modelparam_value [get_param_value PRECISION] [ipgui::get_modelparamspec  C_PRECISION -of $IpView]
} 
proc updateModel_C_ENABLE_CLOCK_MONITOR {IpView} {
   set_property modelparam_value [get_param_value ENABLE_CLOCK_MONITOR] [ipgui::get_modelparamspec  C_ENABLE_CLOCK_MONITOR -of $IpView]
} 

proc updateModel_C_CDDCREQ_PORT  {IpView} {
   set_property modelparam_value [get_param_value CDDCREQ_PORT] [ipgui::get_modelparamspec  C_CDDCREQ_PORT -of $IpView]
} 

proc updateModel_C_INTERFACE_SELECTION  {IpView} {
	if {[get_param_value INTERFACE_SELECTION] == "Enable_AXI" && [get_param_value USE_DYN_RECONFIG]  == "true" || [get_param_value ENABLE_CLOCK_MONITOR] == "true" } {set value 1} else {set value 0}
	set_property modelparam_value $value [ipgui::get_modelparamspec C_INTERFACE_SELECTION -of $IpView]
} 
proc updateModel_C_S_AXI_ADDR_WIDTH  {IpView} {
	set_property modelparam_value 11 [ipgui::get_modelparamspec C_S_AXI_ADDR_WIDTH -of $IpView]
} 
proc updateModel_C_S_AXI_DATA_WIDTH  {IpView} {
	set_property modelparam_value 32 [ipgui::get_modelparamspec C_S_AXI_DATA_WIDTH -of $IpView]
} 

proc updateModel_c_summary_strings {IpView} {
   # the summary strings, nicely constructed
   variable text_c_inclk_sum_row0
   variable text_c_inclk_sum_row1
   variable text_c_inclk_sum_row2
   variable text_c_outclk_sum_row0a
   variable text_c_outclk_sum_row0b
   variable text_c_outclk_sum_row1
   variable text_c_outclk_sum_row2
   variable text_c_outclk_sum_row3
   variable text_c_outclk_sum_row4
   variable text_c_outclk_sum_row5
   variable text_c_outclk_sum_row6
   variable text_c_outclk_sum_row7
   # the input clock summary table
   setup_summary_strings $IpView
   set_property modelparam_value $text_c_inclk_sum_row0 [ipgui::get_modelparamspec  C_INCLK_SUM_ROW0 -of $IpView]
   set_property modelparam_value $text_c_inclk_sum_row1 [ipgui::get_modelparamspec  C_INCLK_SUM_ROW1 -of $IpView]
   set_property modelparam_value $text_c_inclk_sum_row2 [ipgui::get_modelparamspec  C_INCLK_SUM_ROW2 -of $IpView]
   set_property modelparam_value $text_c_outclk_sum_row0a [ipgui::get_modelparamspec  C_OUTCLK_SUM_ROW0A -of $IpView]
   set_property modelparam_value $text_c_outclk_sum_row0b [ipgui::get_modelparamspec  C_OUTCLK_SUM_ROW0B -of $IpView]

   # Actual values
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_OUT_FREQ
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_DUTY_CYCLE
   # all of the individual Actual values
for { set i 1 } { $i < 8 } { incr i } {
    EvalSubstituting {i} {
       set_property modelparam_value [set text_c_outclk_sum_row$i] [ipgui::get_modelparamspec  C_OUTCLK_SUM_ROW$i -of $IpView]
       set_property modelparam_value [set text_CLKOUT$i_ACTUAL_PHASE] [ipgui::get_modelparamspec  C_CLKOUT$i_PHASE -of $IpView]
       set_property modelparam_value [set text_CLKOUT$i_ACTUAL_DUTY_CYCLE]  [ipgui::get_modelparamspec  C_CLKOUT$i_DUTY_CYCLE -of $IpView]
   } 0
   }

    for { set i 1 } { $i < 8 } { incr i } {
    EvalSubstituting {i} {
      if {$text_CLKOUT$i_ACTUAL_OUT_FREQ == "<font color=red>XXX</font>"} { 
        set_property modelparam_value "9999999" [ipgui::get_modelparamspec  C_CLKOUT$i_OUT_FREQ -of $IpView]
       } else {
        set_property modelparam_value [set text_CLKOUT$i_ACTUAL_OUT_FREQ] [ipgui::get_modelparamspec  C_CLKOUT$i_OUT_FREQ -of $IpView]        
       }
   } 0
  }

} ;# end translate SUMMARY_STRINGS

# Dummy updatemodel procs to remove warning
proc updateModel_C_PRIMTYPE_SEL {IpView} {
}
proc updateModel_C_INCLK_SUM_ROW0 {IpView} {
}
proc updateModel_C_INCLK_SUM_ROW1 {IpView} {
}
proc updateModel_C_INCLK_SUM_ROW2 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW0A {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW0B {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW1 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW2 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW3 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW4 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW5 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW6 {IpView} {
}
proc updateModel_C_OUTCLK_SUM_ROW7 {IpView} {
}
proc updateModel_C_CLKOUT1_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT2_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT3_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT4_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT5_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT6_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT7_OUT_FREQ {IpView} {
}
proc updateModel_C_CLKOUT1_PHASE {IpView} {
}
proc updateModel_C_CLKOUT2_PHASE {IpView} {
}
proc updateModel_C_CLKOUT3_PHASE {IpView} {
}
proc updateModel_C_CLKOUT4_PHASE {IpView} {
}
proc updateModel_C_CLKOUT5_PHASE {IpView} {
}
proc updateModel_C_CLKOUT6_PHASE {IpView} {
}
proc updateModel_C_CLKOUT7_PHASE {IpView} {
}
proc updateModel_C_CLKOUT1_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT2_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT3_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT4_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT5_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT6_DUTY_CYCLE {IpView} {
}
proc updateModel_C_CLKOUT7_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_NOTES {IpView} {
}
proc updateModel_C_PLL_BANDWIDTH {IpView} {
}
proc updateModel_C_PLL_CLK_FEEDBACK {IpView} {
}
proc updateModel_C_PLL_CLKFBOUT_MULT {IpView} {
}
proc updateModel_C_PLL_CLKIN_PERIOD {IpView} {
}
proc updateModel_C_PLL_COMPENSATION {IpView} {
}
proc updateModel_C_PLL_DIVCLK_DIVIDE {IpView} {
}
proc updateModel_C_PLL_REF_JITTER {IpView} {
}
proc updateModel_C_PLL_CLKOUT0_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT1_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT2_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT3_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT4_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT5_DIVIDE {IpView} {
}
proc updateModel_C_PLL_CLKOUT0_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT1_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT2_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT3_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT4_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT5_DUTY_CYCLE {IpView} {
}
proc updateModel_C_PLL_CLKOUT0_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKOUT1_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKOUT2_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKOUT3_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKOUT4_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKOUT5_PHASE {IpView} {
}
proc updateModel_C_PLL_CLKFBOUT_PHASE {IpView} {
}
proc updateModel_C_OVERRIDE_PLL {IpView} {
}
proc updateModel_C_CLOCK_MGR_TYPE {IpView} {
}
proc updateModel_C_USE_CLKOUT1_BAR {IpView} {
}
proc updateModel_C_USE_CLKOUT2_BAR {IpView} {
}
proc updateModel_C_USE_CLKOUT3_BAR {IpView} {
}
proc updateModel_C_USE_CLKOUT4_BAR {IpView} {
}

proc updateModel_C_USE_SAFE_CLOCK_STARTUP  {IpView} {
   if {[get_param_value USE_SAFE_CLOCK_STARTUP]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_SAFE_CLOCK_STARTUP -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_SAFE_CLOCK_STARTUP -of $IpView]
   }
} 

proc updateModel_C_USE_CLOCK_SEQUENCING  {IpView} {
   if {[get_param_value USE_CLOCK_SEQUENCING]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_USE_CLOCK_SEQUENCING -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_USE_CLOCK_SEQUENCING -of $IpView]
   }
}  

proc updateModel_C_CLKOUT1_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT1_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT1_SEQUENCE_NUMBER -of $IpView]
} 

proc updateModel_C_CLKOUT2_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT2_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT2_SEQUENCE_NUMBER -of $IpView]
} 

proc updateModel_C_CLKOUT3_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT3_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT3_SEQUENCE_NUMBER -of $IpView]
}  

proc updateModel_C_CLKOUT4_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT4_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT4_SEQUENCE_NUMBER -of $IpView]
}  

proc updateModel_C_CLKOUT5_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT5_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT5_SEQUENCE_NUMBER -of $IpView]
} 

proc updateModel_C_CLKOUT6_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT6_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT6_SEQUENCE_NUMBER -of $IpView]
}  

proc updateModel_C_CLKOUT7_SEQUENCE_NUMBER  {IpView} {
    set_property modelparam_value [get_param_value CLKOUT7_SEQUENCE_NUMBER] [ipgui::get_modelparamspec  C_CLKOUT7_SEQUENCE_NUMBER -of $IpView]
} 

proc updateModel_C_ENABLE_CLKOUTPHY {IpView} {
   if {[get_param_value ENABLE_CLKOUTPHY]  == "true"} {
      set_property modelparam_value 1 [ipgui::get_modelparamspec  C_ENABLE_CLKOUTPHY -of $IpView]
   } else {
      set_property modelparam_value 0 [ipgui::get_modelparamspec  C_ENABLE_CLKOUTPHY -of $IpView]
   }
} 

proc updateModel_C_CLKOUTPHY_MODE {IpView} {
   variable clk_wiz_v6_0_utils::phy_mode
   if {[get_param_value ENABLE_CLKOUTPHY]  == "true" && ($phy_mode == "VCO" || $phy_mode ==  "VCO_HALF" || $phy_mode ==  "VCO_2X")} {
   set_property modelparam_value $phy_mode [ipgui::get_modelparamspec  C_CLKOUTPHY_MODE -of $IpView]
   }
} 
proc updateModel_C_PHASESHIFT_MODE {IpView} {
   set_property modelparam_value [get_param_value PHASESHIFT_MODE] [ipgui::get_modelparamspec  C_PHASESHIFT_MODE -of $IpView]
} 

# Validate Procs
proc validate_Component_Name {IpView} {
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::PartName
   set errStr [ipgui::component_validate [get_param_value    Component_Name  ] ]
   if { $errStr == "" } {
      set ComponentOldName $ComponentName
      set ComponentName [get_param_value Component_Name]
      if { !($ComponentName == "clk_wiz_v6_0" || $ComponentName == "" || $ComponentName == $ComponentOldName) } {
         ChangeCompInstName $PartName $ComponentOldName $ComponentName
      }
      return true
   } else {
      set_property errmsg $errStr  [ipgui::get_paramspec Component_Name -of $IpView ]
      return false
   }
} ;# end validate_Component_Name

proc validate_PRECISION {IpView} {
   set val [get_param_value PRECISION]
   set ival [expr {int($val)}]
   set diff [expr ($val - $ival)]
   if { $diff != 0 && ($diff > 0.000001 && $diff < 0.999999) } {
       set_property errmsg "Precision/Tolerance should be integer and it is to be in steps of 1MHz" [ipgui::get_paramspec PRECISION -of $IpView]
       return FALSE
   }
   return TRUE
}

proc validate_USE_INCLK_SWITCHOVER {IpView} {
   return true
}

proc validate_PRIMITIVE {IpView} {
   return true
} 

proc validate_PRIM_IN_FREQ {IpView} {
   set infreq [get_param_value PRIM_IN_FREQ]
   if { [clk_wiz_v6_0_utils::check_prim_infreq $infreq] == false } {
      set_property errmsg "Please enter a valid input frequency" [ipgui::get_paramspec PRIM_IN_FREQ -of $IpView]
      return false
   }
   return true
} ;# end 

proc validate_PRIM_IN_TIMEPERIOD {IpView} {
   set intime1 [get_param_value PRIM_IN_TIMEPERIOD]
  if { [get_param_value INPUT_MODE ] =="Time"} {
      set infreq [convert_ns_to_MHz $intime1]
   if { [clk_wiz_v6_0_utils::check_prim_infreq $infreq] == false } {
      set_property errmsg "Please enter a valid input Time period" [ipgui::get_paramspec PRIM_IN_TIMEPERIOD -of $IpView]
      return false
   }
   }
   return true
} ;# end  

proc validate_SECONDARY_IN_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   set second_in_freq [get_param_value SECONDARY_IN_FREQ]
   
   #set range [clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value Primary_In_Freq] ]
   if { ($c_using_2_inclks == true) } {
      getspeedfiledata $IpView 
      set range [clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
      if { [clk_wiz_v6_0_utils::check_2nd_infreq $second_in_freq ] == false } {
         set_property errmsg "Please enter a valid secondary input frequency $range" [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
         return false
      }
   }
   return true
} ;# end

proc validate_SECONDARY_IN_TIMEPERIOD {IpView} {
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   set intime2 [get_param_value PRIM_IN_TIMEPERIOD]
   set second_in_freq [get_param_value SECONDARY_IN_TIMEPERIOD]
   if { [get_param_value INPUT_MODE] == "Time" } {
      set second_in_freq [convert_ns_to_MHz $intime2]
   #set range [clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value Primary_In_Freq] ]
   if { ($c_using_2_inclks == true) } {
      getspeedfiledata $IpView 
      set range [clk_wiz_v6_0_utils::setup_valid_infreq_range_label2 [get_param_value PRIM_IN_FREQ] [get_param_value MMCM_CLKFBOUT_MULT_F ] [get_param_value MMCM_DIVCLK_DIVIDE ]]
      if { [clk_wiz_v6_0_utils::check_2nd_infreq $second_in_freq ] == false } {
         set_property errmsg "Please enter a valid secondary input Timeperiod $range" [ipgui::get_paramspec SECONDARY_IN_FREQ -of $IpView]
         return false
      }
   }
   }
   return true
} ;# end 

proc validate_CLKIN1_UI_JITTER {IpView} {
   if { [get_param_value JITTER_OPTIONS] == "PS" } {
      set psvalue [get_param_value CLKIN1_UI_JITTER]
      set infreq [get_param_value PRIM_IN_FREQ]
      set injitter [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psvalue $infreq]
   } else {
      set injitter [get_param_value CLKIN1_UI_JITTER]
   }
   if { [clk_wiz_v6_0_utils::verify_injitter $injitter ] == false } {
      set_property errmsg "Please enter a valid input jitter value" [ipgui::get_paramspec CLKIN1_UI_JITTER -of $IpView]
      return false
   }
   return true
} ;# end 

proc validate_CLKIN2_UI_JITTER {IpView} {
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   if { ($c_using_2_inclks == true) } {
      if { [get_param_value JITTER_OPTIONS] == "PS" } {
         set psvalue [get_param_value CLKIN2_UI_JITTER]
         set infreq [get_param_value SECONDARY_IN_FREQ]
         set injitter [clk_wiz_v6_0_utils::convert_ps_to_UI_for_inclk $psvalue $infreq]
      } else {
         set injitter [get_param_value CLKIN2_UI_JITTER]
      }
      if { [clk_wiz_v6_0_utils::verify_injitter $injitter] == false } {
         set_property errmsg "Please enter a valid secondary input jitter value" [ipgui::get_paramspec CLKIN2_UI_JITTER -of $IpView]
         return false
      }
   }
   return true
} ;# end 


proc validate_PRIM_SOURCE {IpView} {
   return true
}

proc validate_CALC_DONE {IpView} {
  # variable text_Label_Actual_Err_Str
  variable clk_wiz_v6_0_utils::text_Label_Actual_Err_Str
  variable forCalc_Done 
  # puts "7777777777777777777777777777777777777777777777777777777 $text_Label_Actual_Err_Str"
  #puts [get_param_value PRIMITIVE]
  if {[get_param_value PRIMITIVE] == "None"} {
            return true
	} elseif {[get_param_value PRIMITIVE] == "Auto"} {    
          if {$forCalc_Done != "false"} {
              set_property errmsg $forCalc_Done [ipgui::get_paramspec CALC_DONE -of $IpView]
              return false
            } else {
              return true
            }
            return true
  } else {
    if { $text_Label_Actual_Err_Str != "" } {
     ########send_msg INFO 121 "text_Label_Actual_Err_Str :$text_Label_Actual_Err_Str"
      set_property errmsg $text_Label_Actual_Err_Str [ipgui::get_paramspec CALC_DONE -of $IpView]
      return false
    }
    set str [mmcm_pll_vco_freq_check $IpView]
    if { $str != "" } {
     ########send_msg INFO 121 "mmcm_pll_vco_freq_check :$str"
       set_property errmsg $str [ipgui::get_paramspec -name CALC_DONE -of $IpView ] 
       return false
    }
  return true
  }
}

proc validate_MMCM_CLKOUT0_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value " [ipgui::get_paramspec MMCM_CLKOUT0_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT0_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT0_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_MMCM_CLKOUT1_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT1_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT1_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT1_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_MMCM_CLKOUT2_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT2_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT2_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT2_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_MMCM_CLKOUT3_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT3_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT3_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT3_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_MMCM_CLKOUT4_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT4_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT4_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT4_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT4_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_MMCM_CLKOUT5_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT5_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT5_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT5_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT5_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_MMCM_CLKOUT6_DUTY_CYCLE {IpView} {
   if { [get_param_value MMCM_CLKOUT6_DUTY_CYCLE] >= 1.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT6_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value MMCM_CLKOUT6_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value" [ipgui::get_paramspec MMCM_CLKOUT6_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT1_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT1_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT1_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_CLKOUT2_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT2_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT2_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT2_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT2_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_CLKOUT3_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT3_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT3_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT3_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT3_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT4_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT4_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT4_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT4_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT4_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_CLKOUT5_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT5_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT5_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT5_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT5_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT6_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT6_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT6_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT6_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT6_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_CLKOUT7_REQUESTED_DUTY_CYCLE {IpView} {
   if { [get_param_value CLKOUT7_REQUESTED_DUTY_CYCLE] >= 100.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value[0-100]" [ipgui::get_paramspec CLKOUT7_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
   if { [get_param_value CLKOUT7_REQUESTED_DUTY_CYCLE] <= 0.000 } {
      set_property errmsg "Please enter a valid Duty Cycle value [0-100]" [ipgui::get_paramspec CLKOUT7_REQUESTED_DUTY_CYCLE -of $IpView]
      return false
   }
  return true
} ;# end 

proc PRIM_SOURCE_updated {IpView} {
   variable c_IBUF_BUFG_src
   variable c_IBUFDS_BUFG_src
   variable c_IBUFG_src
   variable c_IBUFGDS_src
   variable c_BUFG_src
   variable c_No_buffer_src

   getspeedfiledata $IpView
   if { [get_param_value USE_PHASE_ALIGNMENT ] == true && [get_param_value USE_INCLK_SWITCHOVER ] == true } {
      set_property value [get_param_value PRIM_SOURCE ] [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   } 

   # Set the tooltip to describe the current setting.
   set src [get_param_value PRIM_SOURCE]
   set PRIM_SOURCE [ipgui::get_paramspec PRIM_SOURCE -of $IpView]
   if { $src == $c_IBUF_BUFG_src } {
      set_property tooltip "An IBUF->BUFG pair is inserted on the primary input clock" $PRIM_SOURCE 
   } elseif { $src == $c_IBUFDS_BUFG_src } {
      set_property tooltip "An IBUFDS->BUFG pair is inserted on the primary input clock" $PRIM_SOURCE
   } elseif { $src == $c_IBUFG_src } {
      set_property tooltip "An IBUFG is inserted on the primary input clock" $PRIM_SOURCE
   } elseif { $src == $c_IBUFGDS_src } {
      set_property tooltip "An IBUFGDS is inserted on the primary input clock" $PRIM_SOURCE
   } elseif { $src == $c_BUFG_src } {
      set_property tooltip "A BUFG is inserted on the primary input clock" $PRIM_SOURCE
   } elseif { $src == $c_No_buffer_src } {
      set_property tooltip "No buffer is inserted on the primary input clock" $PRIM_SOURCE
   } 
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT1_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT2_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT3_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT4_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT5_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT6_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT7_PORT -of $IpView]
	 } elseif {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin" } {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in1 [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in2 [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	 } else {
	   set_property enabled true [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
      if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
	   set_property enabled true [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   }
	 }
   return true
}

proc SECONDARY_SOURCE_updated {IpView} {
   variable c_IBUF_BUFG_src
   variable c_IBUFDS_BUFG_src
   variable c_IBUFG_src
   variable c_IBUFGDS_src
   variable c_BUFG_src
   variable c_No_buffer_src

   # Set the tooltip to describe the current setting.
   set src [get_param_value SECONDARY_SOURCE]
   set SECONDARY_SOURCE [ipgui::get_paramspec SECONDARY_SOURCE -of $IpView]
   if { $src == $c_IBUF_BUFG_src } {
      set_property tooltip "An IBUF->BUFG pair is inserted on the primary input clock" $SECONDARY_SOURCE
   } elseif { $src == $c_IBUFDS_BUFG_src } {
      set_property tooltip "An IBUFDS->BUFG pair is inserted on the primary input clock" $SECONDARY_SOURCE
   } elseif { $src == $c_IBUFG_src } {
      set_property tooltip "An IBUFG is inserted on the primary input clock" $SECONDARY_SOURCE
   } elseif { $src == $c_IBUFGDS_src } {
      set_property tooltip "An IBUFGDS is inserted on the primary input clock" $SECONDARY_SOURCE
   } elseif { $src == $c_BUFG_src } {
      set_property tooltip "A BUFG is inserted on the primary input clock" $SECONDARY_SOURCE
   } elseif { $src == $c_No_buffer_src } {
      set_property tooltip "No buffer is inserted on the primary input clock" $SECONDARY_SOURCE
   } 
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT1_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT2_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT3_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT4_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT5_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT6_PORT -of $IpView]
	   # set_property enabled false [ipgui::get_paramspec CLK_OUT7_PORT -of $IpView]
	 } elseif {[get_param_value PRIM_SOURCE ] == "Differential_clock_capable_pin"  } {
	   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in1 [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
	   set_property value clk_in2 [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	 } else {
	   set_property enabled true [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
      if { [get_param_value USE_INCLK_SWITCHOVER ] == true } {
	   set_property enabled true [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
	   }
	 }
   return true
}

proc validate_SECONDARY_SOURCE {IpView} {
   return true
}

proc validate_SS_MOD_FREQ {IpView} {
   variable c_min_mod_freq
   variable c_max_mod_freq
   set modfreq [get_param_value SS_MOD_FREQ]
   if { $modfreq > $c_max_mod_freq || $modfreq < $c_min_mod_freq } {
      set_property errmsg "Please enter a valid modulation frequency" [ipgui::get_paramspec SS_MOD_FREQ -of $IpView]
      return false
   }
   return true
}
proc validate_SS_MOD_TIME {IpView} {
   variable c_min_mod_freq
   variable c_max_mod_freq
   #set modfreq [get_param_value SS_MOD_FREQ]
  set modperiod [get_param_value SS_MOD_TIME]
 if { [get_param_value INPUT_MODE] == "Time" } {
 set modfreq [clk_wiz_v6_0_utils::convert_ms_to_KHz $modperiod]
 set c_max_mod_time [clk_wiz_v6_0_utils::convert_KHz_to_ms $c_min_mod_freq]
 set c_min_mod_time [clk_wiz_v6_0_utils::convert_KHz_to_ms $c_max_mod_freq]
# set modperiod [clk_wiz_v6_0_utils::convert_MHz_to_ms $modfreq]
 # set modperiod_in_ms [expr ($modperiod ) * 1000000 ]
 if { $modperiod < $c_min_mod_time || $modperiod > $c_max_mod_time } {
   set_property errmsg "Please enter a valid modulation timeperiod" [ipgui::get_paramspec SS_MOD_TIME -of $IpView]
      return false
   }
   }
   return true
}
proc utils_Clkout_Used { nClkout bFlag IpView } {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]   
   set i $nClkout
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
   if { [get_param_value USE_FREQ_SYNTH] == false } {
      set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
   } 
   set_property enabled $bFlag [ipgui::get_textspec CLKOUT${i}_ACTUAL_OUT_FREQ -of $IpView]
   set_property enabled $bFlag [ipgui::get_paramspec CLK_OUT${i}_PORT -of $IpView]
   if { [get_param_value CLK_OUT${i}_USE_FINE_PS_GUI] == true } {
   set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		} else {
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		}
   set_property enabled $bFlag [ipgui::get_textspec CLKOUT${i}_ACTUAL_PHASE -of $IpView]
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
   set_property enabled $bFlag [ipgui::get_textspec CLKOUT${i}_ACTUAL_DUTY_CYCLE -of $IpView]
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_DRIVES -of $IpView]
   set_property enabled $bFlag [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
   set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_MATCHED_ROUTING -of $IpView]
   #update clock sequence parameters
   utils_Clkout_Sequencing $nClkout $bFlag $IpView 
   if { $i <= 6 } {
      set j [expr $i + 1]
      if {($value_primitive == "PLL") && ($devicetype == 2)  } {
	    if { $j>2 } {
	    set_property enabled false [ipgui::get_paramspec CLKOUT${j}_USED -of $IpView]
        set_property value false [ipgui::get_paramspec CLKOUT${j}_USED -of $IpView]
		}    
	  } else {
	    set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${j}_USED -of $IpView]
        set_property value false [ipgui::get_paramspec CLKOUT${j}_USED -of $IpView]
      }
   }
   if { [get_param_value CLK_OUT${i}_USE_FINE_PS_GUI] == true } {
      set_property value 0.000 [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
   } 
   
   if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
	  set_property hidden_rows "4,5" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property visible true [ipgui::get_groupspec Groupbox_SS -of $IpView]
      #set_property hidden_columns "" [ipgui::get_tablespec page5_Table2 -of $IpView]
      set_property hidden_rows "4,5" [ipgui::get_tablespec clocksequencetable -of $IpView]  
      set_property hidden_columns "9" [ipgui::get_tablespec Outputclocktable -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
   }   
   if {[get_param_value OVERRIDE_MMCM] == true } {
      set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_OUT_FREQ -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
      set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
   }
   pre_calculate $IpView
   common_all_update_calc_done $IpView
   common_clkoutused_spreadspectrum $IpView $bFlag $i
}

proc utils_Clkout_Sequencing { nClkout bFlag IpView } {
   set i $nClkout
   set cur_clk_sequence [get_param_value CLKOUT${i}_SEQUENCE_NUMBER]
   if {[get_param_value USE_CLOCK_SEQUENCING] == true && $i < 8} {
              
       #get number of valid clocks
       set nEnabledClks 1
       for { set j 2 } { $j < 8 } { incr j } {
         if {[get_param_value CLKOUT${j}_USED] == true} {
           incr nEnabledClks
         }
       }
       if {$bFlag == false} {
             set_property range_value 1,1,7 [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
       } else {
         set_property range 1,$nEnabledClks [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
         for { set j 1 } { $j <= $nEnabledClks } { incr j } {
             set_property range 1,$nEnabledClks [ipgui::get_paramspec CLKOUT${j}_SEQUENCE_NUMBER -of $IpView]
         }

       }; #end else
      
       set_property enabled $bFlag [ipgui::get_textspec Label_Clkout${i}_Seq -of $IpView]
       set_property enabled $bFlag [ipgui::get_paramspec CLKOUT${i}_SEQUENCE_NUMBER -of $IpView]
 
   } 
}

proc common_clkoutused_spreadspectrum {IpView bFlag i} {
   if { $bFlag == true } {
      # algo is updated to support phase shift, when SS enabled
	  if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
         #set_property value 0.000 [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
         #set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
         #set_property enabled false [ipgui::get_textspec CLKOUT${i}_ACTUAL_PHASE -of $IpView]
         set_property value 50.0 [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
         set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
         set_property enabled false [ipgui::get_textspec CLKOUT${i}_ACTUAL_DUTY_CYCLE -of $IpView]
         #set_property enabled false [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
      } else {
   if { [get_param_value CLK_OUT${i}_USE_FINE_PS_GUI] == true } {
   set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		} else {
   set_property enabled true [ipgui::get_paramspec CLKOUT${i}_REQUESTED_PHASE -of $IpView]
		}
         set_property enabled true [ipgui::get_textspec CLKOUT${i}_ACTUAL_PHASE -of $IpView]
         if { [get_param_value OVERRIDE_MMCM ] == true } {
         set_property enabled false [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
         set_property enabled true [ipgui::get_paramspec CLKOUT${i}_REQUESTED_DUTY_CYCLE -of $IpView]
         }
         set_property enabled true [ipgui::get_textspec CLKOUT${i}_ACTUAL_DUTY_CYCLE -of $IpView]
         set_property enabled true [ipgui::get_paramspec CLK_OUT${i}_USE_FINE_PS_GUI -of $IpView]
      } 
   }
}

proc clkout5_spereadspectrum {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]   
   set CLKOUT3_USED [ipgui::get_paramspec CLKOUT3_USED -of $IpView]
   set CLKOUT4_USED [ipgui::get_paramspec CLKOUT4_USED -of $IpView]
   if { [get_param_value CLKOUT2_USED] == true } {
      if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
         set_property enabled true $CLKOUT3_USED
         set_property value true $CLKOUT3_USED
         set_property enabled true $CLKOUT4_USED
         set_property value true $CLKOUT4_USED
      } else {
         set_property value false $CLKOUT3_USED
        # if {($value_primitive == "PLL") && ($devicetype == 2)  } {
           #set_property enabled false $CLKOUT3_USED
		 #} else {
		   set_property enabled true $CLKOUT3_USED
         #}
		 #set_property value false $CLKOUT4_USED
        # set_property enabled false $CLKOUT4_USED
      }
   } else {
      set_property value false $CLKOUT3_USED
      set_property enabled false $CLKOUT3_USED
      set_property value false $CLKOUT4_USED
      set_property enabled false $CLKOUT4_USED
   }
}

proc common_clkout3_used_ss {IpView} {
   set hrows1 [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
   if { [get_param_value USE_SPREAD_SPECTRUM] != true } {
     if {[get_param_value CLKOUT3_USED] == true} {
         set rows   [string map {"3," "" "3" ""}  $hrows1]
       set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
     } else {
       set_property hidden_rows "3,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
     }
   } else {
     set_property hidden_rows "3,4,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
   }
   set hidden_rows ""
   for { set i 4 } { $i <= 7 } { incr i } {
       set hidden_rows [join [tcl::lappend hidden_rows $i] ,]
   }
  # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
   # if { [get_param_value CLKOUT3_USED] == true && [get_param_value USE_SPREAD_SPECTRUM] == false } {
      # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
   # } else {
      # set_property hidden_rows "3,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
   # }
# }

proc common_clkout4_used_ss {IpView} {
    set hrows1 [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
    if { [get_param_value USE_SPREAD_SPECTRUM] != true } {
      if {[get_param_value CLKOUT4_USED] == true} {
         set rows   [string map {"4," "" "4" ""}  $hrows1]
        set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
      } else {
        set_property hidden_rows "4,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
      }
    } else {
      set_property hidden_rows "3,4,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

   set hidden_rows ""
   for { set i 5 } { $i <= 7 } { incr i } {
       set hidden_rows [join [tcl::lappend hidden_rows $i] ,]
   }
   # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
   # if { [get_param_value CLKOUT4_USED] == true && [get_param_value USE_SPREAD_SPECTRUM] == false } {
      # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
   # } else {
      # set_property hidden_rows "4,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
   # }

}
 
proc common_clkout5_used_ss {IpView} {
    set hrows1 [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
    if { [get_param_value CLKOUT5_USED] == true } {
         set rows   [string map {"5," "" "5" ""}  $hrows1]
      set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    } else {
      set_property hidden_rows "5,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

    if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set  curhideden [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
      set_property hidden_rows "$curhideden,3,4" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

   set hidden_rows ""
   for { set i 6 } { $i <= 7 } { incr i } {
       set hidden_rows [join [tcl::lappend hidden_rows $i] ,]
   }
   # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
   # if { [get_param_value CLKOUT5_USED] == true } {
      # if { [get_param_value USE_SPREAD_SPECTRUM] == false } {
         # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
      # } else {
         # set_property hidden_rows "3,4,$hidden_rows" [ipgui::get_tablespec page5_Table2 -of $IpView]
      # }
   # } else {
      # set_property hidden_rows "5,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
   # }
}

proc common_clkout6_used_ss {IpView} {
   set hrows1 [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
     set hrows [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
     if { [get_param_value CLKOUT6_USED] == true } {
         set rows   [string map {"6," "" "6" ""}  $hrows1]
         set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
     } else {
       set_property hidden_rows "6,$hrows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
     }

    if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set  curhideden [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
      set_property hidden_rows "$curhideden,3,4" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

   set hidden_rows "7"
   # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
   # if { [get_param_value CLKOUT6_USED] == true } {
      # if { [get_param_value USE_SPREAD_SPECTRUM] == false } {
         # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
      # } else {
         # set_property hidden_rows "3,4,$hidden_rows" [ipgui::get_tablespec page5_Table2 -of $IpView]
      # }
   # } else {
      # set_property hidden_rows "6,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
   # }
}

proc common_clkout7_used_ss {IpView} {
    set hrows [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
    if { [get_param_value CLKOUT7_USED] == true } {
         set rows   [string map {"7," "" "7" ""}  $hrows]
         set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    } else {
      set_property hidden_rows "$hrows,7" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

    if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set  curhideden [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
      set_property hidden_rows "$curhideden,3,4" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

  set hidden_rows ""
    # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
    # if { [get_param_value CLKOUT7_USED] == true } {
      # if { [get_param_value USE_SPREAD_SPECTRUM] == false } {
        # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
      # } else {
        # set_property hidden_rows "3,4,$hidden_rows" [ipgui::get_tablespec page5_Table2 -of $IpView]
      # }
    # } else {
      # set_property hidden_rows "7,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
    # }
}

proc CLKOUT1_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout1_Used [get_param_value CLKOUT1_USED]
   utils_Clkout_Used 1 $value_Clkout1_Used $IpView
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { $value_Clkout1_Used == true && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT1_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT1_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT1_USE_FINE_PS_GUI -of $IpView]
   }
   if { $value_Clkout1_Used == true && $usePhaseAlignment == true} {
   if { [get_param_value CLK_OUT1_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
		}
   } else {
      if {($value_primitive == "PLL") && ($devicetype == 2) && $value_Clkout1_Used == true } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
		}
	  } else {
	    set_property enabled false [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
      }
   }
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   #set_property enabled false [ipgui::get_paramspec CLK_OUT1_PORT -of $IpView]
	   }
}

proc CLKOUT2_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout2_Used [get_param_value CLKOUT2_USED]
   utils_Clkout_Used 2 $value_Clkout2_Used $IpView
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { $value_Clkout2_Used == true && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT]} {
      set_property enabled true [ipgui::get_paramspec CLK_OUT2_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT2_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT2_USE_FINE_PS_GUI -of $IpView]
   }
   if {($value_primitive == "MMCM" || $value_primitive == "Auto") && ($devicetype == 2) && $value_Clkout2_Used == true } {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
		}
   } elseif { $value_Clkout2_Used == true && $usePhaseAlignment == true} {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
		}
   } else {
      if {($value_primitive == "PLL") && ($devicetype == 2) && $value_Clkout2_Used == true } {
   if { [get_param_value CLK_OUT2_USE_FINE_PS_GUI] == true } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
		}
		}
      } else {
	    set_property enabled false [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
      }
   }
   set_property enabled $value_Clkout2_Used [ipgui::get_textspec CLKOUT2_driver_max_freq -of $IpView]

   set rows1 [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
   if { $value_Clkout2_Used == true } {
     set rows   [string map {"2," "" "2" ""}  $rows1]
     set_property hidden_rows "$rows" [ipgui::get_tablespec MMCMTable2 -of $IpView]
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT2_MATCHED_ROUTING -of $IpView]
      set_property hidden_rows "2,3,4,$rows1" [ipgui::get_tablespec MMCMTable2 -of $IpView]
   }
    if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
      set  curhideden [ get_property hidden_rows [ipgui::get_tablespec MMCMTable2 -of $IpView] ]
      set_property hidden_rows "$curhideden,3,4" [ipgui::get_tablespec MMCMTable2 -of $IpView]
    }

   set hidden_rows ""
   for { set i 3 } { $i <= 7 } { incr i } {
       set hidden_rows [join [tcl::lappend hidden_rows $i] ,]
   }
   # set hrows [ get_property hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView] ]
   # if { $value_Clkout2_Used == true } {
      # set_property hidden_rows $hidden_rows [ipgui::get_tablespec page5_Table2 -of $IpView]
   # } else {
      # set_property hidden_rows "2,$hrows" [ipgui::get_tablespec page5_Table2 -of $IpView]
   # }
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   #set_property enabled false [ipgui::get_paramspec CLK_OUT2_PORT -of $IpView]
	   }
   clkout5_spereadspectrum $IpView
}

proc CLKOUT3_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout3_Used [get_param_value CLKOUT3_USED]
   utils_Clkout_Used 3 $value_Clkout3_Used $IpView
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   if { $value_Clkout3_Used == true && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT3_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT3_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT3_USE_FINE_PS_GUI -of $IpView]
   }
   if { $value_Clkout3_Used == true && ( $usePhaseAlignment == true || $devicetype == 2)  } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
		}
   } else {
      set_property enabled false [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
   }
   if { $value_Clkout3_Used == true } {
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT3_MATCHED_ROUTING -of $IpView]
   }
   set_property enabled $value_Clkout3_Used [ipgui::get_textspec CLKOUT3_driver_max_freq -of $IpView]
   common_clkout3_used_ss $IpView
   	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   #set_property enabled false [ipgui::get_paramspec CLK_OUT3_PORT -of $IpView]
	   }

}

proc CLKOUT4_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout4_Used [get_param_value CLKOUT4_USED]
   utils_Clkout_Used 4 $value_Clkout4_Used $IpView
   variable devicefamily
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set devicetype  [getDeviceType $devicefamily]
   if { $value_Clkout4_Used && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT4_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT4_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT4_USE_FINE_PS_GUI -of $IpView]
   }
   if { $value_Clkout4_Used == true && ( $usePhaseAlignment == true || $devicetype == 2) } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
		}
   } else {
      set_property enabled false [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
   }
   if { $value_Clkout4_Used == true } {
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT4_MATCHED_ROUTING -of $IpView]
   }
   set_property enabled $value_Clkout4_Used [ipgui::get_textspec CLKOUT4_driver_max_freq -of $IpView]
   common_clkout4_used_ss $IpView
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   #set_property enabled false [ipgui::get_paramspec CLK_OUT4_PORT -of $IpView]
	   }
}

proc CLKOUT5_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout5_Used [get_param_value CLKOUT5_USED]
   utils_Clkout_Used 5 $value_Clkout5_Used $IpView
   variable devicefamily
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set devicetype  [getDeviceType $devicefamily]
   if { $value_Clkout5_Used && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT5_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT5_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT5_USE_FINE_PS_GUI -of $IpView]
   }
   
   if { $value_Clkout5_Used == true && ( $usePhaseAlignment == true || $devicetype == 2) } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
		}
   } else {
      set_property enabled false [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
   }
   
   if { $value_Clkout5_Used == true } {
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT5_MATCHED_ROUTING -of $IpView]
   }
   set_property enabled $value_Clkout5_Used [ipgui::get_textspec CLKOUT5_driver_max_freq -of $IpView]
   common_clkout5_used_ss $IpView
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	  # set_property enabled false [ipgui::get_paramspec CLK_OUT5_PORT -of $IpView]
	   }
}

proc CLKOUT6_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout6_Used [get_param_value CLKOUT6_USED]
   utils_Clkout_Used 6 $value_Clkout6_Used $IpView
   variable devicefamily
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set devicetype  [getDeviceType $devicefamily]
   if { $value_Clkout6_Used && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT6_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT6_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT6_USE_FINE_PS_GUI -of $IpView]
   }
   if { $value_Clkout6_Used == true && ( $usePhaseAlignment == true || $devicetype == 2) } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
		}
   } else {
      set_property enabled false [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
   }   
   if { $value_Clkout6_Used == true } {
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT6_MATCHED_ROUTING -of $IpView]
   }
   set_property enabled $value_Clkout6_Used [ipgui::get_textspec CLKOUT6_driver_max_freq -of $IpView]
   common_clkout6_used_ss $IpView
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	  # set_property enabled false [ipgui::get_paramspec CLK_OUT6_PORT -of $IpView]
	   }
}

proc CLKOUT7_USED_updated {IpView} {
   set usePhaseAlignment [get_param_value USE_PHASE_ALIGNMENT]
   set value_Clkout7_Used [get_param_value CLKOUT7_USED]
   utils_Clkout_Used 7 $value_Clkout7_Used $IpView
   variable devicefamily
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set devicetype  [getDeviceType $devicefamily]
   if { $value_Clkout7_Used && ([get_param_value PRIMITIVE] != "PLL") && [get_param_value USE_DYN_PHASE_SHIFT] } {
      set_property enabled true [ipgui::get_paramspec CLK_OUT7_USE_FINE_PS_GUI -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec CLK_OUT7_USE_FINE_PS_GUI -of $IpView]
      set_property value false [ipgui::get_paramspec CLK_OUT7_USE_FINE_PS_GUI -of $IpView]
   }

   if { $value_Clkout7_Used == true && ( $usePhaseAlignment == true || $devicetype == 2) } {
        if { [get_param_value OVERRIDE_MMCM ] == "true" } {
       set_property enabled false [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
		} else {
       set_property enabled true [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
		}
   } else {
      set_property enabled false [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
   }
   if { $value_Clkout7_Used == true } {
   } else {
     set_property value false [ipgui::get_paramspec CLKOUT7_MATCHED_ROUTING -of $IpView]
   }
   set_property enabled $value_Clkout7_Used [ipgui::get_textspec CLKOUT7_driver_max_freq -of $IpView]
   common_clkout7_used_ss $IpView
	 if {[ipgui::get_xpg_context -of $IpView] == "xpg_bd"} {
	   #set_property enabled false [ipgui::get_paramspec CLK_OUT7_PORT -of $IpView]
	   }
}

proc AUTO_PRIMITIVE_updated {IpView} {
       if { [get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto"} {
	set_property enabled false [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
    } else {
	set_property enabled true [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
    }
	   getspeedfiledata $IpView
}
proc ENABLE_USER_CLOCK0_updated {IpView} {
	if { [get_param_value ENABLE_USER_CLOCK0] == true } {
     if { [get_param_value PRIMITIVE] == "None" } {
      set_property enabled false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
	  } elseif { [get_param_value PRIMITIVE] == "Auto" } {
       if { [get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" } {
      set_property enabled false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
      set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
      } else {
      set_property enabled true [ipgui::get_paramspec Enable_PLL0 -of $IpView]
      }
      } else {
      set_property enabled true [ipgui::get_paramspec Enable_PLL0 -of $IpView]
      set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
      }
   } else {
      set_property enabled false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
      set_property value false [ipgui::get_paramspec Enable_PLL0 -of $IpView]
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
}
}

proc Enable_PLL0_updated {IpView} {
    set primary_clock [get_param_value PRIM_IN_FREQ]
	if { [get_param_value Enable_PLL0] == true } {
      set_property value $primary_clock [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
    } else {
       set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
}
}
proc ENABLE_USER_CLOCK1_updated {IpView} {
	if { [get_param_value ENABLE_USER_CLOCK1] == true } {
	if { [get_param_value USE_INCLK_SWITCHOVER] == true } {
      set_property enabled true [ipgui::get_paramspec Enable_PLL1 -of $IpView]
    } else {
      set_property enabled false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
      set_property value false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
   }
      set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ1 -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
      set_property value false [ipgui::get_paramspec Enable_PLL1 -of $IpView]
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ1 -of $IpView]
}
}
proc Enable_PLL1_updated {IpView} {
    set secondary_clock [get_param_value SECONDARY_IN_FREQ]
	if { [get_param_value Enable_PLL1] == true } {
      set_property value $secondary_clock [ipgui::get_paramspec USER_CLK_FREQ1 -of $IpView]
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ1 -of $IpView]
    } else {
       set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ0 -of $IpView]
}
}

proc ENABLE_USER_CLOCK2_updated {IpView} {
	if { [get_param_value ENABLE_USER_CLOCK2] == true } {
      set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ2 -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ2 -of $IpView]
}
}

proc ENABLE_USER_CLOCK3_updated {IpView} {
	if { [get_param_value ENABLE_USER_CLOCK3] == true } {
      set_property enabled true [ipgui::get_paramspec USER_CLK_FREQ3 -of $IpView]
   } else {
      set_property enabled false [ipgui::get_paramspec USER_CLK_FREQ3 -of $IpView]
}
}

proc validate_CLKOUT1_USED {IpView} {
    if { [get_param_value CLKOUT1_USED] == false && [get_param_value PRIMITIVE] != "None" } {
      set_property enabled false [ipgui::get_paramspec CLKOUT2_USED -of $IpView]
      set_property errmsg "Please select atleast one output clock" [ipgui::get_paramspec CLKOUT1_USED -of $IpView]
      return false
    }
   return true 
} ;# end 

proc validate_CLKOUT2_USED {IpView} {
   return true 
} ;# end 

proc validate_CLKOUT3_USED {IpView} {
   return true 
} ;# end 

proc validate_CLKOUT4_USED {IpView} {
   return true 
} ;# end 

proc validate_CLKOUT5_USED {IpView} {
   return true 
} ;# end 

proc validate_CLKOUT6_USED {IpView} {
   return true 
} ;# end 

proc validate_CLKOUT7_USED {IpView} {
   return true 
} ;# end 

# NOTE - the Clkout#_REQUESTED_OUT_FREQ validate functions aren't needed unless the MHz/ns
# switch is turned on.  Otherwise, just make sure to set the widget's min/max values for the
# correct validation.
proc validate_CLKOUT1_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT1_driver_max_freq 
   variable CLKOUT1_freq_in_buffer_range

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]


   set out_freq [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]
   updateModel_C_CLKOUT1_DRIVES $IpView 
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT1_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT1_driver_max_freq $c_min_period_mhz
   set CLKOUT1_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time  }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT1_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq  }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT1_freq_in_buffer_range false       
       return true
      }
   }
   return true
}

proc validate_CLKOUT2_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT2_driver_max_freq 
   variable CLKOUT2_freq_in_buffer_range
   
   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   set out_freq [get_param_value CLKOUT2_REQUESTED_OUT_FREQ]
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT2_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT2_driver_max_freq $c_min_period_mhz
   set CLKOUT2_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT2_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT2_freq_in_buffer_range false
       return true
      }
   }
   return true
}

proc validate_CLKOUT3_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT3_driver_max_freq 
   variable CLKOUT3_freq_in_buffer_range

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   set out_freq [get_param_value CLKOUT3_REQUESTED_OUT_FREQ] 
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT3_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT3_driver_max_freq $c_min_period_mhz
   set CLKOUT3_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT3_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT3_freq_in_buffer_range false
       return true
      }
   }
   return true
}

proc validate_CLKOUT4_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT4_driver_max_freq 
   variable CLKOUT4_freq_in_buffer_range

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   set out_freq [get_param_value CLKOUT4_REQUESTED_OUT_FREQ] 
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT4_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT4_driver_max_freq $c_min_period_mhz
   set CLKOUT4_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT4_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT4_freq_in_buffer_range false
       return true
      }
   }
   return true
}

proc validate_CLKOUT5_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT5_driver_max_freq 
   variable CLKOUT5_freq_in_buffer_range

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   # TODO change range based on mmcm_clkout4_cascade
   set out_freq [get_param_value CLKOUT5_REQUESTED_OUT_FREQ] 
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT5_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT5_driver_max_freq $c_min_period_mhz
   set CLKOUT5_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT5_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT5_freq_in_buffer_range false
       return true
      }
   }

   return true
}

proc validate_CLKOUT6_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT6_driver_max_freq 
   variable CLKOUT6_freq_in_buffer_range 

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   set out_freq [get_param_value CLKOUT6_REQUESTED_OUT_FREQ]
  set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT6_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT6_driver_max_freq $c_min_period_mhz
   set CLKOUT6_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT6_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT6_freq_in_buffer_range false
       return true
      }
   }
   return true
}

proc validate_CLKOUT7_REQUESTED_OUT_FREQ {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable text_CLKOUT7_driver_max_freq 
   variable CLKOUT7_freq_in_buffer_range

   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]

   set out_freq [get_param_value CLKOUT7_REQUESTED_OUT_FREQ]
   set drive_type [get_property modelparam_value [ipgui::get_modelparamspec C_CLKOUT7_DRIVES -of $IpView]]

   set min_period_time [clk_wiz_v6_0_utils::get_freq_range_of_buffers $drive_type]
   set c_min_period_time [setup_display_float $min_period_time]
   set c_min_period_mhz  [setup_display_float [convert_ns_to_MHz $c_min_period_time]]
   set out_period [setup_display_float [convert_MHz_to_ns $out_freq]] 
   
   set text_CLKOUT7_driver_max_freq $c_min_period_mhz
   set CLKOUT7_freq_in_buffer_range true

   if {[ get_param_value INPUT_MODE] == "Time" } {
     if { $out_period > $c_max_out_time || $out_period < $c_min_out_time }  {
       set_property errmsg "Please enter valid time period in range ($c_min_out_time - $c_max_out_time)" [ipgui::get_paramspec CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_period < $c_min_period_time } { 
       set CLKOUT7_freq_in_buffer_range false
       return true
      }

   } else {
     if { $out_freq > $c_max_out_freq || $out_freq < $c_min_out_freq }  {
       set_property errmsg "Please enter valid freq in range ($c_min_out_freq - $c_max_out_freq)" [ipgui::get_paramspec CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]
       return false
     } elseif { $out_freq > $c_min_period_mhz  }  { 
       set CLKOUT7_freq_in_buffer_range false
       return true
      }
   }
   return true
}

proc validate_CLKOUT1_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT1_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT1_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT1_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 


proc validate_CLKOUT2_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT2_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT2_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT2_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT3_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT3_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT3_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT3_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT4_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT4_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT4_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT4_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT5_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT5_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT5_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT5_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT6_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT6_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT6_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT6_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 

proc validate_CLKOUT7_REQUESTED_PHASE {IpView} {
   if { [get_param_value CLKOUT7_REQUESTED_PHASE] > 360 } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
      return false
   }
    if { [expr [get_param_value CLKOUT7_REQUESTED_PHASE] < -360] } {
      set_property errmsg "Please enter a valid Phase shift value -360 to 360" [ipgui::get_paramspec CLKOUT7_REQUESTED_PHASE -of $IpView]
      return false
   }
  return true
} ;# end 



proc validate_USE_DYN_RECONFIG {IpView} {
   return true
}

 proc ENABLE_CLOCK_MONITOR_updated {IpView} {
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
 variable devicefamily
  set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
	  # if {$getDevicefamily == 3} {
      # set_property enabled false [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # } else {
      # set_property enabled true [ipgui::get_paramspec USE_DYN_RECONFIG -of $IpView]
	  # }
    if { [get_param_value ENABLE_CLOCK_MONITOR] == true } {
      if {$devicetype == 2 } {
       set_property range "MMCM,PLL,Auto,None" [ipgui::get_paramspec PRIMITIVE -of $IpView]
       } else {
       set_property range "MMCM,PLL,None" [ipgui::get_paramspec PRIMITIVE -of $IpView]
	set_property hidden_columns "10" [ipgui::get_tablespec Outputclocktable -of $IpView]
       }
	   set_property visible true [ipgui::get_pagespec create_clkmon -of $IpView]
	   set_property enabled false [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	   set_property value "Enable_AXI" [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
    } elseif { [get_param_value USE_DYN_RECONFIG] == true } {
      if {$devicetype == 2 } {
       set_property range "MMCM,PLL,Auto" [ipgui::get_paramspec PRIMITIVE -of $IpView]
       } else {
       set_property range "MMCM,PLL" [ipgui::get_paramspec PRIMITIVE -of $IpView]
	set_property hidden_columns "10" [ipgui::get_tablespec Outputclocktable -of $IpView]
       }
	   set_property visible false [ipgui::get_pagespec create_clkmon -of $IpView]
	   set_property enabled true [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
    } else {
      if {$devicetype == 2 } {
       set_property range "MMCM,PLL,Auto" [ipgui::get_paramspec PRIMITIVE -of $IpView]
       } else {
       set_property range "MMCM,PLL" [ipgui::get_paramspec PRIMITIVE -of $IpView]
	set_property hidden_columns "10" [ipgui::get_tablespec Outputclocktable -of $IpView]
       }
	   set_property visible false [ipgui::get_pagespec create_clkmon -of $IpView]
	   set_property enabled false [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
    }
      if { ([get_param_value USE_DYN_RECONFIG] == true || [get_param_value ENABLE_CLOCK_MONITOR] == true ) && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
      set_property value true [ipgui::get_paramspec USE_RESET -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec USE_RESET -of $IpView]
	  } else {
	  set_property enabled true [ipgui::get_paramspec USE_RESET -of $IpView]
	  }
    
    } 
proc USE_DYN_RECONFIG_updated {IpView} {
   set page5_Table5_handle [ipgui::get_tablespec page5_Table5 -of $IpView] 
   set RESET_PORT [ipgui::get_paramspec RESET_PORT -of $IpView] 
   set reset [ipgui::get_textspec reset -of $IpView]
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "1" $rows]
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   if {$devicetype == 2} {
   if {[get_param_value USE_DYN_RECONFIG] == true} {
       set_property value false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
       set_property enabled false [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
   } else {
       set_property enabled true [ipgui::get_paramspec OPTIMIZE_CLOCKING_STRUCTURE_EN -of $IpView]
   }
   }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   
   if { ([get_param_value USE_DYN_RECONFIG] == true) && ([get_param_value INTERFACE_SELECTION] != "Enable_AXI") } {
      set_property visible true $page5_Table5_handle
   } else {
      set_property visible false $page5_Table5_handle
   }
   if { [get_param_value USE_DYN_RECONFIG] == true } {
   if { [get_param_value ENABLE_CLOCK_MONITOR] == true } {
	  set_property enabled false [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	  set_property value "Enable_AXI" [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
   } else {
	  set_property enabled true [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	  set_property enabled false [ipgui::get_paramspec USE_SPREAD_SPECTRUM -of $IpView]}
   } else {
   if { [get_param_value ENABLE_CLOCK_MONITOR] == true } {
	  set_property enabled false [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	  set_property value "Enable_AXI" [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
   } else {
	  #set_property value "Enable_AXI" [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	  set_property enabled false [ipgui::get_paramspec INTERFACE_SELECTION -of $IpView]
	  set_property enabled true [ipgui::get_paramspec USE_SPREAD_SPECTRUM -of $IpView]
   }}
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
      if { ([get_param_value USE_DYN_RECONFIG] == true || [get_param_value ENABLE_CLOCK_MONITOR] == true ) && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
      set_property value true [ipgui::get_paramspec USE_RESET -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec USE_RESET -of $IpView]
      set_property value ACTIVE_HIGH [ipgui::get_paramspec RESET_TYPE -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec RESET_TYPE -of $IpView]
      set_property value true [ipgui::get_paramspec USE_LOCKED -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec USE_LOCKED -of $IpView]
	  set_property enabled true [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property enabled true [ipgui::get_paramspec AXI_DRP -of $IpView]
   } else {
if { [get_param_value PRIMITIVE ] == "Auto" } {
      set_property value false [ipgui::get_paramspec USE_RESET -of $IpView] 
      set_property value false [ipgui::get_paramspec USE_LOCKED -of $IpView]
}	  
	  set_property value 0 [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property value 0 [ipgui::get_paramspec AXI_DRP -of $IpView]
	  set_property enabled false [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property enabled false [ipgui::get_paramspec AXI_DRP -of $IpView]
	  set_property enabled true [ipgui::get_paramspec USE_RESET -of $IpView]
	  set_property enabled true [ipgui::get_paramspec USE_LOCKED -of $IpView]
	  set_property enabled true [ipgui::get_paramspec RESET_TYPE -of $IpView]
   }
   if { ([get_param_value USE_DYN_RECONFIG] == true) && ([get_param_value INTERFACE_SELECTION] != "Enable_AXI") } {
      set_property visible true $page5_Table5_handle
   } else {
      set_property visible false $page5_Table5_handle
   }
   if { ([get_param_value USE_RESET] == false) || ([get_param_value INTERFACE_SELECTION] == "Enable_AXI") } {
      set_property hidden_rows "1,$rows" $page5_Table3
      set_property visible false $reset
      set_property visible false $RESET_PORT
   } else {
      set_property hidden_rows "1,$rows" $page5_Table3
      set_property visible true $reset
      set_property visible true $RESET_PORT
   }
   #pre_calculate $IpView
   #common_all_update_calc_done $IpView
}

proc INTERFACE_SELECTION_updated {IpView} {
   set page5_Table5_handle [ipgui::get_tablespec page5_Table5 -of $IpView] 
   set RESET_PORT [ipgui::get_paramspec RESET_PORT -of $IpView] 
   set reset [ipgui::get_textspec reset -of $IpView]
   set page5_Table3 [ipgui::get_tablespec page5_Table3 -of $IpView]
   set rows [ get_property hidden_rows $page5_Table3]
   set index [string first "1" $rows]
   if { $index != -1 } {
      set rows [string replace $rows $index [expr $index + 1] ""]
   }
      if { ([get_param_value USE_DYN_RECONFIG] == true || [get_param_value ENABLE_CLOCK_MONITOR] == true ) && [get_param_value INTERFACE_SELECTION] == "Enable_AXI" } {
      set_property value true [ipgui::get_paramspec USE_RESET -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec USE_RESET -of $IpView]
      set_property value ACTIVE_HIGH [ipgui::get_paramspec RESET_TYPE -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec RESET_TYPE -of $IpView]
      set_property value true [ipgui::get_paramspec USE_LOCKED -of $IpView] 
	  set_property enabled false [ipgui::get_paramspec USE_LOCKED -of $IpView]
	  set_property enabled true [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property enabled true [ipgui::get_paramspec AXI_DRP -of $IpView]
   } else {
	  set_property value 0 [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property value 0 [ipgui::get_paramspec AXI_DRP -of $IpView]
	  set_property enabled false [ipgui::get_paramspec PHASE_DUTY_CONFIG -of $IpView]
	  set_property enabled false [ipgui::get_paramspec AXI_DRP -of $IpView]
	  set_property enabled true [ipgui::get_paramspec USE_RESET -of $IpView]
	  set_property enabled true [ipgui::get_paramspec USE_LOCKED -of $IpView]
	  set_property enabled true [ipgui::get_paramspec RESET_TYPE -of $IpView]
   }
   if { ([get_param_value USE_DYN_RECONFIG] == true) && ([get_param_value INTERFACE_SELECTION] != "Enable_AXI") } {
      set_property visible true $page5_Table5_handle
   } else {
      set_property visible false $page5_Table5_handle
   }
   if { ([get_param_value USE_RESET] == false) || ([get_param_value INTERFACE_SELECTION] == "Enable_AXI") } {
      set_property hidden_rows "1,$rows" $page5_Table3
      set_property visible false $reset
      set_property visible false $RESET_PORT
   } else {
      set_property hidden_rows "$rows" $page5_Table3
      set_property visible true $reset
      set_property visible true $RESET_PORT
   }
}

proc PHASE_DUTY_CONFIG_updated {IpView} {
}


proc AXI_DRP_updated {IpView} {
    if { [get_param_value AXI_DRP] == true } {
	   set_property visible true [ipgui::get_pagespec create_DRPreg -of $IpView]
    } else {
	   set_property visible false [ipgui::get_pagespec create_DRPreg -of $IpView]
    }    
    } 

proc CLKFB_IN_SIGNALING_updated {IpView} {
   common_feedbacksource_clkfbinsignaling $IpView
}

proc FEEDBACK_SOURCE_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]
   set value_primitive [get_param_value PRIMITIVE]
   set page5_Table4_handle [ipgui::get_tablespec page5_Table4 -of $IpView] 
   if { [get_param_value FEEDBACK_SOURCE] == "FDBK_AUTO" } {
      set_property visible false $page5_Table4_handle
   } else {
      set_property visible true $page5_Table4_handle
   }
 if { [get_param_value OVERRIDE_MMCM] == "false" } {
   if {($value_primitive == "PLL") && ($devicetype == 2)  } {
      set_property value "AUTO" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView] 
   } else {
       if { [get_param_value FEEDBACK_SOURCE] == "FDBK_OFFCHIP" || [get_param_value FEEDBACK_SOURCE] == "FDBK_AUTO_OFFCHIP"} {
          set_property value "EXTERNAL" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView] 
       } else {
          if {($value_primitive == "MMCM") && ($devicetype == 2)  } {
             set_property value "AUTO" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
          } elseif {$value_primitive == "Auto"} {
             set_property value "AUTO" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
			 } else {
             set_property value "ZHOLD" [ipgui::get_paramspec MMCM_COMPENSATION -of $IpView]
          }
       }
   }
 }
   common_feedbacksource_clkfbinsignaling $IpView
   common_FeedbackSource_PhaseAlignment $IpView 
}
proc validate_FEEDBACK_SOURCE {IpView} {
         if { [get_param_value FEEDBACK_SOURCE] == "FDBK_AUTO"  && ( [get_param_value OVERRIDE_MMCM] == "true" && [get_param_value MMCM_COMPENSATION] == "EXTERNAL") } {
         set_property errmsg "With the Given Feedback source Compensation should not set to EXTERNAL. Please chage the Feedback Source or else Change the Compensation " [ipgui::get_paramspec FEEDBACK_SOURCE -of $IpView]
         return false
        } else {
          return true
        }
}

proc common_feedbacksource_clkfbinsignaling {IpView} {
   set page5_Table4 [ipgui::get_tablespec page5_Table4 -of $IpView]

   if { [get_param_value FEEDBACK_SOURCE ] == "FDBK_AUTO" } {
      set_property hidden_rows "1,2,3,4,5,6" $page5_Table4
   } elseif { [get_param_value FEEDBACK_SOURCE ] == "FDBK_ONCHIP"  || [get_param_value FEEDBACK_SOURCE ] == "FDBK_OFFCHIP" } {
      set_property hidden_rows "2,3,5,6" $page5_Table4
   } elseif { [get_param_value FEEDBACK_SOURCE] == "FDBK_AUTO_OFFCHIP" } {
      if { [get_param_value CLKFB_IN_SIGNALING ] == "SINGLE" } {
         set_property hidden_rows "2,3,5,6" $page5_Table4
      } else {
         set_property hidden_rows "1,4" $page5_Table4
      }
   }
}

proc validate_USE_DYN_PHASE_SHIFT {IpView} {
   return true
}

proc USE_DYN_PHASE_SHIFT_updated {IpView} {
   common_Primitive_DynPhaseShift $IpView
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
   set page5_Table6_handle [ipgui::get_tablespec page5_Table6 -of $IpView] 

   if { [get_param_value USE_DYN_PHASE_SHIFT] == true } {
      set_property visible true $page5_Table6_handle
      set_property hidden_columns "" [ipgui::get_tablespec Outputclocktable -of $IpView]
	for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {
			#set_property enabled true [ipgui::get_paramspec CLK_OUT$i_USE_FINE_PS_GUI -of $IpView]
            }}
   } else {
      set_property hidden_columns "9" [ipgui::get_tablespec Outputclocktable -of $IpView]
	for {set i 1} {$i <= 7} {incr i} {
		EvalSubstituting {i} {
			#set_property enabled false [ipgui::get_paramspec CLK_OUT$i_USE_FINE_PS_GUI -of $IpView]
            }}
      set_property visible false $page5_Table6_handle
   }
}

proc ENABLE_CDDC_updated {IpView} {
   variable devicefamily
   set devicetype  [getDeviceType $devicefamily]	
   set page5_Table7_handle [ipgui::get_tablespec page5_Table7 -of $IpView] 
   if { [get_param_value ENABLE_CDDC] == true && $devicetype == 2 } {
      set_property visible true $page5_Table7_handle
   } else {
      set_property visible false $page5_Table7_handle
   }
if { [get_param_value PRIMITIVE ] == "Auto" } {
        determine_auto_primitive $IpView
	}
    set devicetype  [getDeviceType $devicefamily]	
	if { [get_param_value ENABLE_CDDC] == true && $devicetype == 2} {set value 1} else {set value 0}
	set_property modelparam_value $value [ipgui::get_modelparamspec C_HAS_CDDC -of $IpView]
}


proc validate_PRIMARY_PORT {IpView} {
   # set sig_n [get_param_value PRIMARY_PORT] 
   # set errStr [ipgui::component_validate $sig_n ]
# #########send_msg INFO 111 "errStr  $errStr"
   # if { $errStr == "" } {
       # return true
    # } else {
       # set_property errmsg $errStr  [ipgui::get_paramspec PRIMARY_PORT -of $IpView ]
       # return false
    # }
    set sig_n [get_param_value PRIMARY_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
         return false
       } else {
       return true
       }

      
   
}
proc validate_SECONDARY_PORT {IpView} {
    set sig_n [get_param_value SECONDARY_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
         return false
       } else {
       return true
       }
}
   for {set i 1} {$i <= 7} {incr i} {                                              
    EvalSubstituting {i} {
proc validate_CLK_OUT$i_PORT {IpView} {
    set sig_n [get_param_value CLK_OUT$i_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLK_OUT$i_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLK_OUT$i_PORT -of $IpView]
         return false
       } else {
       return true
       }
}
} 0
}
proc validate_RESET_PORT {IpView} {
    set sig_n [get_param_value RESET_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec RESET_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec RESET_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_LOCKED_PORT {IpView} {
    set sig_n [get_param_value LOCKED_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec LOCKED_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec LOCKED_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_STATUS_PORT {IpView} {
    set sig_n [get_param_value STATUS_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec STATUS_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec STATUS_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLK_IN_SEL_PORT {IpView} {
    set sig_n [get_param_value CLK_IN_SEL_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLK_IN_SEL_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLK_IN_SEL_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLK_VALID_PORT {IpView} {
    set sig_n [get_param_value CLK_VALID_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLK_VALID_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLK_VALID_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_INPUT_CLK_STOPPED_PORT {IpView} {
    set sig_n [get_param_value INPUT_CLK_STOPPED_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec INPUT_CLK_STOPPED_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec INPUT_CLK_STOPPED_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_STOPPED_PORT {IpView} {
    set sig_n [get_param_value CLKFB_STOPPED_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_STOPPED_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_STOPPED_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_IN_PORT {IpView} {
    set sig_n [get_param_value CLKFB_IN_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_IN_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_IN_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_IN_P_PORT {IpView} {
    set sig_n [get_param_value CLKFB_IN_P_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_IN_P_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_IN_P_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_IN_N_PORT {IpView} {
    set sig_n [get_param_value CLKFB_IN_N_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_IN_N_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_IN_N_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_OUT_PORT {IpView} {
    set sig_n [get_param_value CLKFB_OUT_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_OUT_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_OUT_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_OUT_P_PORT {IpView} {
    set sig_n [get_param_value CLKFB_OUT_P_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_OUT_P_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_OUT_P_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_CLKFB_OUT_N_PORT {IpView} {
    set sig_n [get_param_value CLKFB_OUT_N_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec CLKFB_OUT_N_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec CLKFB_OUT_N_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_POWER_DOWN_PORT {IpView} {
    set sig_n [get_param_value POWER_DOWN_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec POWER_DOWN_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec POWER_DOWN_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DADDR_PORT {IpView} {
    set sig_n [get_param_value DADDR_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DADDR_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DADDR_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DCLK_PORT {IpView} {
    set sig_n [get_param_value DCLK_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DCLK_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DCLK_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DRDY_PORT {IpView} {
    set sig_n [get_param_value DRDY_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DRDY_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DRDY_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DWE_PORT {IpView} {
    set sig_n [get_param_value DWE_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DWE_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DWE_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DIN_PORT {IpView} {
    set sig_n [get_param_value DIN_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DIN_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DIN_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DOUT_PORT {IpView} {
    set sig_n [get_param_value DOUT_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DOUT_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DOUT_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_DEN_PORT {IpView} {
    set sig_n [get_param_value DEN_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec DEN_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec DEN_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_PSCLK_PORT {IpView} {
    set sig_n [get_param_value PSCLK_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec PSCLK_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec PSCLK_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_PSEN_PORT {IpView} {
    set sig_n [get_param_value PSEN_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec PSEN_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec PSEN_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_PSINCDEC_PORT {IpView} {
    set sig_n [get_param_value PSINCDEC_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec PSINCDEC_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec PSINCDEC_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc validate_PSDONE_PORT {IpView} {
    set sig_n [get_param_value PSDONE_PORT] 
    set sp_sig_n [split $sig_n ""]
       if {[regexp {[_0-9]} [lindex $sp_sig_n 0]] == 1} {
         set_property errmsg "Signal Name should not start with a Number/Underscore" [ipgui::get_paramspec PSDONE_PORT -of $IpView]
         return false
       } else {
       return true
       }

       if {$sig_n == ""} {
         set_property errmsg "Signal Name cannot be empty" [ipgui::get_paramspec PSDONE_PORT -of $IpView]
         return false
       } else {
       return true
       }
}

proc setup_valid_injitter_range_labels {IpView} {
   variable clk_wiz_v6_0_utils::c_min_in_jitter
   variable clk_wiz_v6_0_utils::c_max_in_jitter

   set Clkin1_UI_Jitter_handle [ipgui::get_paramspec -name CLKIN1_UI_JITTER -of $IpView]
   set Secondary_In_Jitter_handle [ipgui::get_paramspec -name SECONDARY_IN_JITTER -of $IpView]

# TODO - handle ps/UI
   set_property tooltip "Valid range: $c_min_in_jitter - $c_max_in_jitter UI" $Clkin1_UI_Jitter_handle
   set_property tooltip "Valid range: $c_min_in_jitter - $c_max_in_jitter UI" $Secondary_In_Jitter_handle
}

######################################
# Returns a string containing all the requested output frequencies, for the output clocks 
# that are used, each separated by a space.
proc construct_req_outfreq_str {IpView } {
   variable clk_wiz_v6_0_utils::c_num_oclks

   set bMHz true
   if { [get_param_value IN_FREQ_UNITS ] == "Units_ns" } {
      set bMHz false
   }

   # Get all the requested out freqs (MHz) in one long string, separated by spaces.
   set oFreq [get_param_value CLKOUT1_REQUESTED_OUT_FREQ ]
   if { $bMHz == false } {
      set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz $oFreq ]
   }
   set reqOutFreqStr "$oFreq"
   for { set ctr 1 } { $ctr < $c_num_oclks } { incr ctr } {
      if { $ctr == 1 } {
         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT2_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT2_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      } elseif { $ctr == 2 } {

         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT3_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT3_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      } elseif { $ctr == 3 } {
         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT4_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT4_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      } elseif { $ctr == 4 } {
         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT5_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT5_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      } elseif { $ctr == 5 } {
         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT6_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT6_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      } elseif { $ctr == 6 } {
         if { $bMHz == false } {
            set oFreq [clk_wiz_v6_0_utils::convert_ns_to_MHz [get_param_value CLKOUT7_REQUESTED_OUT_FREQ ]]
         } else {
            set oFreq [get_param_value CLKOUT7_REQUESTED_OUT_FREQ ]
         }
         set reqOutFreqStr "$reqOutFreqStr $oFreq"
      }
   }
   return $reqOutFreqStr
}

######################################
# Returns a string containing all the requested phases, for the output clocks 
# that are used, each separated by a space.
proc construct_req_phase_str {IpView } {

   variable clk_wiz_v6_0_utils::c_num_oclks

   # Get all the requested phases in one long string, separated by spaces.
   set phase [get_param_value CLKOUT1_REQUESTED_PHASE ]
   set reqPhaseStr "$phase"

   for { set ctr 1 } { $ctr < $c_num_oclks } { incr ctr } {
      if { $ctr == 1 } {
         set phase [get_param_value CLKOUT2_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      } elseif { $ctr == 2 } {
         set phase [get_param_value CLKOUT3_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      } elseif { $ctr == 3 } {
         set phase [get_param_value CLKOUT4_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      } elseif { $ctr == 4 } {
         set phase [get_param_value CLKOUT5_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      } elseif { $ctr == 5 } {
         set phase [get_param_value CLKOUT6_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      } elseif { $ctr == 6 } {
         set phase [get_param_value CLKOUT7_REQUESTED_PHASE ]
         set reqPhaseStr "$reqPhaseStr $phase"
      }
   }
   return $reqPhaseStr
}

######################################
# Returns a string containing all the requested duty cycles, for the output clocks 
# that are used, each separated by a space.
proc construct_req_duty_cycle_str {IpView } {

   variable clk_wiz_v6_0_utils::c_num_oclks

   # Get all the requested duty cycles in one long string, separated by spaces.
   set dutyCycle [get_param_value CLKOUT1_REQUESTED_DUTY_CYCLE ]
   set reqDutyCycleStr "$dutyCycle"

   for { set ctr 1 } { $ctr < $c_num_oclks } { incr ctr } {
      if { $ctr == 1 } {
         set dutyCycle [get_param_value CLKOUT2_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      } elseif { $ctr == 2 } {
         set dutyCycle [get_param_value CLKOUT3_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      } elseif { $ctr == 3 } {
         set dutyCycle [get_param_value CLKOUT4_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      } elseif { $ctr == 4 } {
         set dutyCycle [get_param_value CLKOUT5_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      } elseif { $ctr == 5 } {
         set dutyCycle [get_param_value CLKOUT6_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      } elseif { $ctr == 6 } {
         set dutyCycle [get_param_value CLKOUT7_REQUESTED_DUTY_CYCLE ]
         set reqDutyCycleStr "$reqDutyCycleStr $dutyCycle"
      }
   }
   return $reqDutyCycleStr
}

######################################
## Determines the current number of oclks used.
proc determine_num_oclks {IpView} {
   variable clk_wiz_v6_0_utils::c_num_oclks

   set c_num_oclks 1
   if { [get_param_value CLKOUT2_USED ] == true } {
      set c_num_oclks 2
   }
   if { [get_param_value CLKOUT3_USED ] == true } {
      set c_num_oclks 3
   }
   if { [get_param_value CLKOUT4_USED ] == true } {
      set c_num_oclks 4
   }
   if { [get_param_value CLKOUT5_USED ] == true } {
      set c_num_oclks 5
   }
   if { [get_param_value CLKOUT6_USED ] == true } {
      set c_num_oclks 6
   }
   if { [get_param_value CLKOUT7_USED ] == true } {
      set c_num_oclks 7
   }
   set_property value $c_num_oclks [ipgui::get_paramspec NUM_OUT_CLKS -of $IpView]
}
######################################
## Determines auto primitive selection.
proc determine_auto_primitive {IpView} {
    ### GUI fix for hang issue with specific freq
variable test_case
set auto_selection [auto_selection $IpView ]
set PRIMITIVE [get_param_value PRIMITIVE ]
  set page4_MMCM_handle [ipgui::get_pagespec page4_MMCM -of $IpView]
  # if {$test_case == "1"} {
    ENABLE_USER_CLOCK0_updated $IpView
    set_property value $auto_selection [ipgui::get_paramspec AUTO_PRIMITIVE -of $IpView]

 ########send_msg INFO 313 " determine auto_selection :$auto_selection"
if { [get_param_value PRIMITIVE ] == "None" } {
     set_property visible false $page4_MMCM_handle
    } elseif {[get_param_value PRIMITIVE ] == "Auto"} {
      if {$auto_selection == "BUFGCE_DIV"} {
     set_property enabled false [ipgui::get_paramspec OVERRIDE_MMCM -of $IpView]
       set_property visible false  [ipgui::get_pagespec page4_MMCM -of $IpView]
      } elseif {$auto_selection == "MMCM"} {
        set_property display_name "MMCM Settings" $page4_MMCM_handle
       set_property visible true  [ipgui::get_pagespec page4_MMCM -of $IpView]
	  } else {
        set_property display_name "PLL Settings" $page4_MMCM_handle
       set_property visible true  [ipgui::get_pagespec page4_MMCM -of $IpView]
	  }
	  } elseif {[get_param_value PRIMITIVE ] == "MMCM"} {
        set_property display_name "MMCM Settings" $page4_MMCM_handle
       set_property visible true  [ipgui::get_pagespec page4_MMCM -of $IpView]
	  } else {
        set_property display_name "PLL Settings" $page4_MMCM_handle
       set_property visible true  [ipgui::get_pagespec page4_MMCM -of $IpView]
    }
    
    ### GUI fix for hang issue with specific freq
      # common_all_update_calc_done $IpView

      pre_calculate $IpView
    ### previously it was commented to solve hang issue, hang issue is solved. Now to solve pdrc this is uncommented.
      common_all_update_calc_done $IpView
    # }
}


proc auto_selection {Ipview} {
  variable devicefamily
 variable clk_wiz_v6_0_utils::Error
 #variable forCalc_Done1
  set devicetype  [getDeviceType $devicefamily]
  set clk_mon [ get_param_value  ENABLE_CLOCK_MONITOR ]
  set phase_alignment [ get_param_value  USE_PHASE_ALIGNMENT ]
  set spread_spectrum [ get_param_value  USE_SPREAD_SPECTRUM ]
  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
  set dyn_phase_shift [ get_param_value  USE_DYN_PHASE_SHIFT ]
  set cddc [ get_param_value  ENABLE_CDDC ]
  set second_ip [ get_param_value  USE_INCLK_SWITCHOVER ]
  set locked [ get_param_value  USE_LOCKED ]
  set reset [ get_param_value  USE_RESET ]
  set pwr_dwn [ get_param_value  USE_POWER_DOWN ]
  set inclk_stopped [ get_param_value  USE_INCLK_STOPPED ]
  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
  set clkfb_stopped [ get_param_value  USE_CLKFB_STOPPED ]
  set phase_shift [ phase_shift  $Ipview]
  set no_of_clks [ no_of_clks  $Ipview]
  set prim_in_pll [ prim_in_pll  $Ipview]
  set prim_in_bufgce [ prim_in_bufgce  $Ipview]
  set out_in_frq [ out_in_frq  $Ipview]
  set duty_cycle [ duty_cycle  $Ipview]
  #set pll_bufgcediv [ pll_bufgcediv  $Ipview]
  set pll_bufgcediv_seperation [ pll_bufgcediv_seperation  $Ipview]
  set drives [ drives  $Ipview]
  if {$spread_spectrum} {
  set pll_infer false
  } else {
  set pll_infer [ pll_infer  $Ipview]
  }
  set mmcm_infer [ mmcm_infer  $Ipview]
  #set mmcm_bufgcediv1 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV1]
  #set mmcm_bufgcediv2 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV2]
  #set mmcm_bufgcediv3 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV3]
  #set mmcm_bufgcediv4 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV4]
  #set mmcm_bufgcediv5 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV5]
  #set mmcm_bufgcediv6 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV6]
  #set mmcm_bufgcediv7 [get_property MODELPARAM_VALUE.C_MMCMBUFGCEDIV7]
 #send_msg INFO 112 "Error :$Error entered proc" 
  if { $phase_alignment == true } {
      return MMCM
   } elseif { $spread_spectrum == true } {
      return MMCM
   } elseif { $dyn_phase_shift == true } { 
      return MMCM
   } elseif { $cddc == true } {
      return MMCM
   } elseif { $second_ip == true } {
      return MMCM
   } elseif { $inclk_stopped == true } { 
      return MMCM
   } elseif { $clkfb_stopped == true } { 
      return MMCM
   } elseif { $no_of_clks == false } { 
      return MMCM
   } elseif { $pll_infer == false && $duty_cycle == false } {
      return MMCM
   } elseif { $prim_in_pll == false && $duty_cycle == true && !$reset && !$locked && !$pwr_dwn } {
      return BUFGCE_DIV
   } elseif { $prim_in_pll == false && $duty_cycle == false } {
      return MMCM
   } elseif { $Error == true } {
      return MMCM
   } elseif { $locked == true } { 
 #send_msg INFO 112 "Error :$Error entered proc" 
      return PLL
   } elseif { $reset == true } { 
 #send_msg INFO 112 "Error :$Error entered proc" 
      return PLL
   } elseif { $pwr_dwn == true } {
      return PLL
   } elseif { $dyn_reconfig == true } {
      return PLL
   } elseif { $safe_clk == true } { 
      return PLL
   } elseif { $phase_shift == false } { 
      return PLL
   } elseif { $out_in_frq == false } { 
      return PLL
   } elseif { $drives == false } { 
      return PLL
   } elseif { $duty_cycle == false } { 
      return PLL
   } elseif { $prim_in_bufgce == false } { 
      return PLL
   } else {
      return BUFGCE_DIV
   }
}

#################################################################
# Set the min/max range for the Clkout#_REQUESTED_OUT_FREQ params.
# Does not do any calculations; just uses c_min/max_out_freq.
proc set_outfreq_min_max_values {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq


   set clkout1_req_freq [ipgui::get_paramspec -name  CLKOUT1_REQUESTED_OUT_FREQ -of $IpView]
   set clkout2_req_freq [ipgui::get_paramspec -name  CLKOUT2_REQUESTED_OUT_FREQ -of $IpView]
   set clkout3_req_freq [ipgui::get_paramspec -name  CLKOUT3_REQUESTED_OUT_FREQ -of $IpView]
   set clkout4_req_freq [ipgui::get_paramspec -name  CLKOUT4_REQUESTED_OUT_FREQ -of $IpView]
   set clkout5_req_freq [ipgui::get_paramspec -name  CLKOUT5_REQUESTED_OUT_FREQ -of $IpView]
   set clkout6_req_freq [ipgui::get_paramspec -name  CLKOUT6_REQUESTED_OUT_FREQ -of $IpView]
   set clkout7_req_freq [ipgui::get_paramspec -name  CLKOUT7_REQUESTED_OUT_FREQ -of $IpView]

   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout1_req_freq
   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout2_req_freq
   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout3_req_freq
   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout4_req_freq
   if { [get_param_value MMCM_CLKOUT4_CASCADE] == true } {
      set min_freq 0.0244
   } else {
      set min_freq $c_min_out_freq
   }
   set_property range "$min_freq, $c_max_out_freq" $clkout5_req_freq
   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout6_req_freq
   set_property range "$c_min_out_freq, $c_max_out_freq" $clkout7_req_freq
}

proc set_outtimeperiod_min_max_values {IpView} {
   variable clk_wiz_v6_0_utils::c_min_out_freq
   variable clk_wiz_v6_0_utils::c_max_out_freq
   variable clkout1_req_freq
   variable clkout2_req_freq
   variable clkout3_req_freq
   variable clkout4_req_freq
   variable clkout5_req_freq
   variable clkout6_req_freq
   variable clkout7_req_freq

   set clkout1_req_time [setup_display_float [convert_MHz_to_ns $clkout1_req_freq]]
   set clkout2_req_time [setup_display_float [convert_MHz_to_ns $clkout2_req_freq]]
   set clkout3_req_time [setup_display_float [convert_MHz_to_ns $clkout3_req_freq]]
   set clkout4_req_time [setup_display_float [convert_MHz_to_ns $clkout4_req_freq]]
   set clkout5_req_time [setup_display_float [convert_MHz_to_ns $clkout5_req_freq]]
   set clkout6_req_time [setup_display_float [convert_MHz_to_ns $clkout6_req_freq]]
   set clkout7_req_time [setup_display_float [convert_MHz_to_ns $clkout7_req_freq]]

   set c_min_out_time [setup_display_float [convert_MHz_to_ns $c_min_out_freq]]
   set c_max_out_time [setup_display_float [convert_MHz_to_ns $c_max_out_freq]]
   

   set_property range "$c_min_out_time, $c_max_out_time" $clkout1_req_time
   set_property range "$c_min_out_time, $c_max_out_time" $clkout2_req_time
   set_property range "$c_min_out_time, $c_max_out_time" $clkout3_req_time
   set_property range "$c_min_out_time, $c_max_out_time" $clkout4_req_time
      if { [get_param_value MMCM_CLKOUT4_CASCADE] == true } {
      set min_time 40.98
   } else {
      set min_time $c_min_out_time
   }
  set_property range "$c_min_out_time,  $c_max_out_time" $clkout5_req_time
   set_property range "$c_min_out_time, $c_max_out_time" $clkout6_req_time
   set_property range "$c_min_out_time, $c_max_out_time" $clkout7_req_time

}

proc calculate_jitter_and_phase_error_user_query {IpView} {
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::c_vco_freq
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_using_2_inclks

   set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set bandwidth [get_param_value MMCM_BANDWIDTH ]
   set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
   set clkin1 [get_param_value MMCM_CLKIN1_PERIOD ]
   set clkin2 [get_param_value MMCM_CLKIN2_PERIOD ]
   set inPeriod [get_param_value MMCM_CLKIN2_PERIOD ]
   if { [get_param_value RELATIVE_INCLK ] == "REL_PRIMARY" } {
      set inPeriod [get_param_value MMCM_CLKIN1_PERIOD ]
   }
   set inFreq  [get_param_value PRIM_IN_FREQ ]

   set c_vco_freq [ expr (1.0 * $clkFBMult * $inFreq) / ($clkFBDiv) ]

   # Get the correct input jitter (Prim/Sec), in ps.
   if { $c_using_2_inclks == true && [get_param_value RELATIVE_INCLK ] == "REL_SECONDARY" } {
      if { [get_param_value JITTER_OPTIONS ] == "UI" } {
        set inJitter [convert_UI_to_ps [get_param_value CLKIN2_UI_JITTER ] $clkin2]
      } else {
        set inJitter [get_param_value CLKIN2_UI_JITTER ]
      }
   } else {
      if { [get_param_value JITTER_OPTIONS]  == "UI" } {
        set inJitter [convert_UI_to_ps [get_param_value CLKIN1_UI_JITTER ] $clkin1]
      } else {
         set inJitter [get_param_value CLKIN1_UI_JITTER ]
      }
   }
   # Only calculate the values for clocks that are used.
   for { set ctr1 0 } { $ctr1 < $c_num_oclks } { incr ctr1 } {
      if { $ctr1 == 0 } { 
            set clkoutDiv [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
      } elseif { $ctr1 == 1 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT1_DIVIDE ]
      } elseif { $ctr1 == 2 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT2_DIVIDE ]
      } elseif { $ctr1 == 3 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT3_DIVIDE ]
      } elseif { $ctr1 == 4 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT4_DIVIDE ]
      } elseif { $ctr1 == 5 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT5_DIVIDE ]
      } elseif { $ctr1 == 6 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT6_DIVIDE ]
      }
      set pktopkJitter 0.001
      # MMCM and PLL
      set pktopkJitter [ GetPkToPkJitter $PartName $ComponentName $inJitter $c_vco_freq $clkFBMult $bandwidth $clkFBDiv $clkoutDiv ]
      set phaseError [ GetPhaseError $PartName $ComponentName $c_vco_freq $clkFBMult $bandwidth ]
      set pktopkJitter [clk_wiz_v6_0_utils::setup_display_float $pktopkJitter]
      set phaseError [clk_wiz_v6_0_utils::setup_display_float $phaseError]

      if { $ctr1 == 0 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT1_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT1_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 1 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT2_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT2_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 2 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT3_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT3_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 3 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT4_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT4_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 4 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT5_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT5_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 5 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT6_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT6_PHASE_ERROR    -of $IpView ]
      } elseif { $ctr1 == 6 } {
		 set_property  value $pktopkJitter [ipgui::get_paramspec CLKOUT7_JITTER    -of $IpView ]
		 set_property  value $phaseError   [ipgui::get_paramspec CLKOUT7_PHASE_ERROR    -of $IpView ]
      }
   }
}

proc calculate_jitter_and_phase_error {IpView} {

   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::c_vco_freq
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable text_Outclk_Sum_Clkout1_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout1_Phase_Error
   variable text_Outclk_Sum_Clkout2_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout2_Phase_Error
   variable text_Outclk_Sum_Clkout3_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout3_Phase_Error
   variable text_Outclk_Sum_Clkout4_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout4_Phase_Error
   variable text_Outclk_Sum_Clkout5_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout5_Phase_Error
   variable text_Outclk_Sum_Clkout6_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout6_Phase_Error
   variable text_Outclk_Sum_Clkout7_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout7_Phase_Error

   set clkFBMult [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set bandwidth [get_param_value MMCM_BANDWIDTH ]
   set clkFBDiv [get_param_value MMCM_DIVCLK_DIVIDE ]
   set clkin1 [get_param_value MMCM_CLKIN1_PERIOD ]
   set clkin2 [get_param_value MMCM_CLKIN2_PERIOD ]
   set inPeriod [get_param_value MMCM_CLKIN2_PERIOD ]
   if { [get_param_value RELATIVE_INCLK ] == "REL_PRIMARY" } {
      set inPeriod [get_param_value MMCM_CLKIN1_PERIOD ]
   }
   set inFreq  [get_param_value PRIM_IN_FREQ ]

   set c_vco_freq [ expr (1.0 * $clkFBMult * $inFreq) / ($clkFBDiv) ]

   # Get the correct input jitter (Prim/Sec), in ps.
   if { $c_using_2_inclks == true && [get_param_value RELATIVE_INCLK ] == "REL_SECONDARY" } {
      if { [get_param_value JITTER_OPTIONS ] == "UI" } {
        set inJitter [convert_UI_to_ps [get_param_value CLKIN2_UI_JITTER ] $clkin2]
      } else {
        set inJitter [get_param_value CLKIN2_UI_JITTER ]
      }
   } else {
      if { [get_param_value JITTER_OPTIONS]  == "UI" } {
        set inJitter [convert_UI_to_ps [get_param_value CLKIN1_UI_JITTER ] $clkin1]
      } else {
         set inJitter [get_param_value CLKIN1_UI_JITTER ]
      }
   }
   # Only calculate the values for clocks that are used.
   for { set ctr1 0 } { $ctr1 < $c_num_oclks } { incr ctr1 } {
      if { $ctr1 == 0 } { 
            set clkoutDiv [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
      } elseif { $ctr1 == 1 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT1_DIVIDE ]
      } elseif { $ctr1 == 2 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT2_DIVIDE ]
      } elseif { $ctr1 == 3 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT3_DIVIDE ]
      } elseif { $ctr1 == 4 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT4_DIVIDE ]
      } elseif { $ctr1 == 5 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT5_DIVIDE ]
      } elseif { $ctr1 == 6 } {
            set clkoutDiv [get_param_value MMCM_CLKOUT6_DIVIDE ]
      }
      set pktopkJitter 0.001
      # MMCM and PLL
      set pktopkJitter [ GetPkToPkJitter $PartName $ComponentName $inJitter $c_vco_freq $clkFBMult $bandwidth $clkFBDiv $clkoutDiv ]
      set phaseError [ GetPhaseError $PartName $ComponentName $c_vco_freq $clkFBMult $bandwidth ]
      set pktopkJitter [clk_wiz_v6_0_utils::setup_display_float $pktopkJitter]
      set phaseError [clk_wiz_v6_0_utils::setup_display_float $phaseError]

      if { $ctr1 == 0 } {
         set text_Outclk_Sum_Clkout1_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout1_Phase_Error "$phaseError"
      } elseif { $ctr1 == 1 } {
         set text_Outclk_Sum_Clkout2_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout2_Phase_Error "$phaseError"
      } elseif { $ctr1 == 2 } {
         set text_Outclk_Sum_Clkout3_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout3_Phase_Error "$phaseError"
      } elseif { $ctr1 == 3 } {
         set text_Outclk_Sum_Clkout4_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout4_Phase_Error "$phaseError"
      } elseif { $ctr1 == 4 } {
         set text_Outclk_Sum_Clkout5_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout5_Phase_Error "$phaseError"
      } elseif { $ctr1 == 5 } {
         set text_Outclk_Sum_Clkout6_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout6_Phase_Error "$phaseError"
      } elseif { $ctr1 == 6 } {
         set text_Outclk_Sum_Clkout7_Pktopk_Jitter "$pktopkJitter"
         set text_Outclk_Sum_Clkout7_Phase_Error "$phaseError"
      }
   }

}

proc has_non_default_phase_or_duty_cycle {IpView } {
   variable clk_wiz_v6_0_utils::c_num_oclks

   set rtn false
   for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
      if { $ctr == 0 } {
         set phase [get_param_value CLKOUT1_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT1_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 1 } {
         set phase [get_param_value CLKOUT2_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT2_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 2 } {
         set phase [get_param_value CLKOUT3_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT3_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 3 } {
         set phase [get_param_value CLKOUT4_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT4_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 4 } {
         set phase [get_param_value CLKOUT5_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT5_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 5 } {
         set phase [get_param_value CLKOUT6_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT6_REQUESTED_DUTY_CYCLE ]
      } elseif { $ctr == 6 } {
         set phase [get_param_value CLKOUT7_REQUESTED_PHASE ]
         set dc [get_param_value CLKOUT7_REQUESTED_DUTY_CYCLE ]
      }
      if { ($dc != "50.000" && $dc != "undefined") } {
         set rtn true
         break
      }
   }
   return $rtn
}

proc mmcm_pll_calc_phases {IpView } {

   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   #variable clk_wiz_v6_0_utils::text_Clkout1_Actual_Phase 
   #edited this variable text_Clkout1_Actual_Phase to  text_CLKOUT1_ACTUAL_PHASE because the model parameters values are not getting updated from batch mdoe.
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_PHASE
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::c_debug_phase

   for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
       set j [expr $ctr + 1]
       set reqPhase [get_param_value CLKOUT${j}_REQUESTED_PHASE ]
       if { $ctr == 0 } {
          set divN [GetClkwizProperty $PartName $ComponentName ChosenDiv0]
       } else {
          set divN [GetClkwizProperty $PartName $ComponentName ChosenDivN $ctr]
       }

       set actPhase [ MMCMCalculateActualPhase $PartName $ComponentName $reqPhase $divN $c_debug_phase]
       if { $ctr == 0 } {
          #edited this variable text_Clkout1_Actual_Phase to  text_CLKOUT1_ACTUAL_PHASE because the model parameters values are not getting updated from batch mdoe.
          set text_CLKOUT1_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 1 } {
          set text_CLKOUT2_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 2 } {
          set text_CLKOUT3_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 3 } {
          set text_CLKOUT4_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 4 } {
          set text_CLKOUT5_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 5 } {
          set text_CLKOUT6_ACTUAL_PHASE $actPhase
       } elseif { $ctr == 6 } {
          set text_CLKOUT7_ACTUAL_PHASE $actPhase
       }
   }
}

proc mmcm_pll_calc_duty_cycles {IpView} {

   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_DUTY_CYCLE
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable clk_wiz_v6_0_utils::c_debug_duty_cycle

   for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
       set j [expr $ctr + 1]
       set reqDutyCycle [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE ]
       if { $ctr == 0 } {
          set divN [GetClkwizProperty $PartName $ComponentName ChosenDiv0]
       } else {
          set divN [GetClkwizProperty $PartName $ComponentName ChosenDivN $ctr]
       }

      # NOTE: reqDutyCycle is in %
      set actDutyCycle [ MMCMCalculateActualDutyCycle $PartName $ComponentName $reqDutyCycle $divN $c_debug_duty_cycle]

      if { $ctr == 0 } {
          #edited this variable text_Clkout1_Actual_Duty_Cycle to  text_CLKOUT1_ACTUAL_DUTY_CYCLE because the model parameters values are not getting updated from batch mdoe.
         set text_CLKOUT1_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1.0 } {
            set_property tooltip  "The actual Duty Cycle is 50% because CLKOUT0_DIVIDE_F = 1.0" [ipgui::get_paramspec CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]

         } else {
            set_property tooltip "Specify the requested duty cycle for the 1st output clock." [ipgui::get_paramspec CLKOUT1_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 1 } {
         set text_CLKOUT2_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT1_DIVIDE = 1" [ipgui::get_paramspec CLKOUT2_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 2nd output clock." [ipgui::get_paramspec CLKOUT2_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 2 } {
         set text_CLKOUT3_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT2_DIVIDE = 1" [ipgui::get_paramspec CLKOUT3_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 3rd output clock." [ipgui::get_paramspec CLKOUT3_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 3 } {
         set text_CLKOUT4_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT3_DIVIDE = 1" [ipgui::get_paramspec CLKOUT4_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 4th output clock." [ipgui::get_paramspec CLKOUT4_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 4 } {
         set text_CLKOUT5_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT4_DIVIDE = 1" [ipgui::get_paramspec CLKOUT5_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 5th output clock." [ipgui::get_paramspec CLKOUT5_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 5 } {
         set text_CLKOUT6_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT5_DIVIDE = 1" [ipgui::get_paramspec CLKOUT6_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 6th output clock." [ipgui::get_paramspec CLKOUT6_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      } elseif { $ctr == 6 } {
         set text_CLKOUT7_ACTUAL_DUTY_CYCLE $actDutyCycle
         if { $divN == 1 } {
            set_property tooltip "The actual Duty Cycle is 50% because CLKOUT6_DIVIDE = 1" [ipgui::get_paramspec CLKOUT7_REQUESTED_DUTY_CYCLE -of $IpView]
         } else {
            set_property tooltip "Specify the requested duty cycle for the 7th output clock." [ipgui::get_paramspec CLKOUT7_REQUESTED_DUTY_CYCLE -of $IpView]
         }
      }
   }
}

######################################
# For MMCM or PLL, for the given output clknum, figures out the out freq, phase, and duty cycle
# using the current M, D, and Div# numbers.  These values populate the columns in the 
# output clk summary table.  They are also used to populate the Actual column fields on 
# page 2, if bCopyToActualCol is TRUE.
# bCopyToActualCol -- if TRUE, copy the values to the Actual column on page 2.
proc mmcm_pll_load_oclk_sum_tbl  { IpView clknum bCopyToActualCol } {
   variable  clk_wiz_v6_0_utils::c_vco_freq
   variable  text_Outclk_Sum_Clkout${clknum}_Out_Freq
   variable  text_Outclk_Sum_Clkout${clknum}_Phase
   variable  text_Outclk_Sum_Clkout${clknum}_Duty_Cycle 
   variable  clk_wiz_v6_0_utils::text_CLKOUT${clknum}_ACTUAL_OUT_FREQ 
   variable  clk_wiz_v6_0_utils::text_CLKOUT${clknum}_ACTUAL_PHASE 
   variable  clk_wiz_v6_0_utils::text_CLKOUT${clknum}_ACTUAL_DUTY_CYCLE 

   set temp [get_param_value MMCM_CLKFBOUT_MULT_F ]
   set Mval $temp
   
   set Mvalue [format "%3.3f" $temp ]
   set Dvalue [get_param_value MMCM_DIVCLK_DIVIDE ]
   set Dvaluef [format "%3.3f" $Dvalue]
   set clkfbPhase [get_param_value MMCM_CLKFBOUT_PHASE ]
   set j [expr $clknum - 1]
   if { $clknum == 1 } {
      set divN [get_param_value MMCM_CLKOUT0_DIVIDE_F ]
      set phase [get_param_value MMCM_CLKOUT0_PHASE ]
      #puts "debug:1 phase is $phase\n"
      set dutyCycle [get_param_value MMCM_CLKOUT0_DUTY_CYCLE ]
   } else {
      set divNf [get_param_value MMCM_CLKOUT${j}_DIVIDE ]
      set phase [get_param_value MMCM_CLKOUT${j}_PHASE ]
      set dutyCycle [get_param_value MMCM_CLKOUT${j}_DUTY_CYCLE ]
   }

   if { $c_vco_freq == "XXX" } {
       set c_vco_freq "XXX"
   } else {
      # Calculate the oFreq using c_vco_freq and divN: oFreq = VCO / divN.
      # Note: divN is a float for V6 clknum=0; else it is an integer.
      set clkin [get_param_value SECONDARY_IN_FREQ]
      if { [get_param_value RELATIVE_INCLK ] == "REL_PRIMARY" } {
          set clkin [get_param_value PRIM_IN_FREQ ]
      }
      
      if { $j == 0 } {
          #set oFreq [expr $c_vco_freq / $divN ]
          set oFreq [expr {$clkin*(double($Mval)/($Dvalue*$divN))}]
      } else {
          #set oFreq [expr $c_vco_freq / $divN.0 ]
          set oFreq [expr {$clkin*(double($Mval)/($Dvaluef*$divNf))}]
      }
   }
  
   set operiod [convert_MHz_to_ns $oFreq]
   if {[get_param_value INPUT_MODE] == "Time"} {
     set displayF $operiod
   } else {
     set displayF $oFreq
   }
   set displayF [clk_wiz_v6_0_utils::setup_display_float_freq $displayF]
   set phase [clk_wiz_v6_0_utils::setup_display_float $phase]
   # NOTE: the dutyCycle obtained is fractional.
   set dutyCycle [clk_wiz_v6_0_utils::setup_display_float_duty_cycle [expr $dutyCycle * 100] ]

   #if { [get_param_value CLKOUT${clknum}_ACTUAL_OUT_FREQ] == "<font color=red>XXX</font>" } {
   #   set displayF "<font color=red>XXX</font>"
   #}
   set text_Outclk_Sum_Clkout${clknum}_Out_Freq "$displayF"
   set text_Outclk_Sum_Clkout${clknum}_Phase "$phase"
   set text_Outclk_Sum_Clkout${clknum}_Duty_Cycle "$dutyCycle"
   
   if { $bCopyToActualCol == true } {
      set text_CLKOUT${clknum}_ACTUAL_OUT_FREQ "$displayF"
      set text_CLKOUT${clknum}_ACTUAL_PHASE "$phase"
      set text_CLKOUT${clknum}_ACTUAL_DUTY_CYCLE "$dutyCycle"
   }
   if { $clknum == 5 } {
      check_for_cascade $IpView
   }
}

proc check_for_cascade { IpView } {
   variable clk_wiz_v6_0_utils::c_vco_freq
   variable clk_wiz_v6_0_utils::text_Outclk_Sum_Clkout5_Out_Freq
   variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_OUT_FREQ

   if { [get_param_value MMCM_CLKOUT4_CASCADE] == true } {
      set val [expr $c_vco_freq/ [ get_param_value MMCM_CLKOUT6_DIVIDE ] ]
      set newval [expr $val/ [ get_param_value MMCM_CLKOUT4_DIVIDE ] ]
      set newval "[setup_display_float $newval]"
      set text_CLKOUT5_ACTUAL_OUT_FREQ $newval
   } else {
   }

}

proc getspeedfiledata {IpView} {
  variable devicefamily
   variable clk_wiz_v6_0_utils::min_period
   determine_num_oclks $IpView
  set devicetype  [getDeviceType $devicefamily]
  set getDevicefamily  [getDevicefamily $devicefamily]
   set primitive [get_param_value PRIMITIVE ]
   set auto_prim [get_param_value AUTO_PRIMITIVE]
  variable clk_wiz_v6_0_utils::c_min_in_freq
  variable clk_wiz_v6_0_utils::c_max_in_freq
#mahavir
  variable clk_wiz_v6_0_utils::min_period_mhz
  variable clk_wiz_v6_0_utils::min_period_time
  variable clk_wiz_v6_0_utils::PartName
  variable clk_wiz_v6_0_utils::ComponentName
  variable clk_wiz_v6_0_utils::c_num_oclks
  set global_buffer_used false 
  if { [get_param_value PRIM_SOURCE ] == "Global_buffer" } {
    set global_buffer_used true 
  }
  SetClkwizProperty $PartName $ComponentName "GlobalBuffer_InputClk" $global_buffer_used 

  clk_wiz_v6_0_utils::get_speedsfile_data $primitive $devicetype $auto_prim $devicefamily 
  if { [get_param_value USE_SPREAD_SPECTRUM] == true } {
  if { $getDevicefamily == 3} {
  set c_min_in_freq "30.000"
  } else {
  set c_min_in_freq "25.000"
  }
     set c_max_in_freq "150.000"
  }
  #set_outfreq_min_max_values $IpView
  #set_prim_inperiod_ranges $IpView
#mahavir
#        for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
#               set j [expr $ctr + 1]
#               set driver [get_param_value CLKOUT${j}_DRIVES]
#               set min_period_mhz [setup_display_float [convert_MHz_to_ns [clk_wiz_v6_0_utils::get_freq_range_of_buffers $driver]]]
#               set min_period_time [setup_display_float $min_period_mhz]
#        }
#clk_wiz_v6_0_utils::tt
}

######################################
# Sets the current PRIMITIVE's input freq attributes ranges (i.e.,
# CLKIN1_PERIOD range) so it will show the correct values in error msg.
proc set_prim_inperiod_ranges  {IpView} {
   variable clk_wiz_v6_0_utils::c_min_in_freq
   variable clk_wiz_v6_0_utils::c_max_in_freq
   variable clk_wiz_v6_0_utils::c_min_2nd_in_freq
   variable clk_wiz_v6_0_utils::c_max_2nd_in_freq
   variable clk_wiz_v6_0_utils::c_using_2_inclks

   # c_min/max_in_freq is always in MHz, but these params' ranges need to be in ns.
   set prim [get_param_value PRIMITIVE ]
   set min_inperiod [setup_display_float [convert_MHz_to_ns $c_min_in_freq]]
   set max_inperiod [setup_display_float [convert_MHz_to_ns $c_max_in_freq]]
   set min_inperiod2 [setup_display_float [convert_MHz_to_ns $c_min_2nd_in_freq]]
   set max_inperiod2 [setup_display_float [convert_MHz_to_ns $c_max_2nd_in_freq]]
   set_property range "$min_inperiod,$max_inperiod" [ipgui::get_paramspec MMCM_CLKIN1_PERIOD -of $IpView]
   if { $c_using_2_inclks == true } {
      set_property range "$min_inperiod2,$max_inperiod2" [ipgui::get_paramspec MMCM_CLKIN2_PERIOD -of $IpView]
   }
}

##########################################
# Auto selection of the primitive
##########################################




##########################################
# Phase shift of the output clocks
##########################################
proc phase_shift {Ipview} {
    set list ""
	for {set i 1} {$i<8} {incr i} {
    set phase [get_param_value CLKOUT${i}_REQUESTED_PHASE]
    if {$phase > 0} {
		 lappend list "$i" 
	}
    }
   set length [llength $list] 
   if {$length > 0 } {
	return false
        } else {
	return true
    }
}
##########################################
# Number of the output clocks
##########################################
proc no_of_clks {Ipview} {
    variable  clk_wiz_v6_0_utils::c_num_oclks
    if {$c_num_oclks > 4 } {
	return false
        } else {
	return true
    }
}
##########################################
# Primary frequency check for PLL
##########################################
proc prim_in_pll {Ipview} {
       set min_freq  [clk_wiz_v6_0_utils::get_speedsfile_key_value "PLL_CLKIN_FREQ_MIN"]
       set max_freq  [clk_wiz_v6_0_utils::get_speedsfile_key_value "PLL_CLKIN_FREQ_MAX"]
       set in_frq [get_param_value PRIM_IN_FREQ]
    if {$in_frq >= $min_freq && $in_frq <= $max_freq } {
	return true
        } else {
	return false
    }
}
##########################################
# Primary frequency check for BUFGCE_DIV
##########################################
proc prim_in_bufgce {Ipview} {
       set max_freq  [clk_wiz_v6_0_utils::get_speedsfile_key_value "FMAX_BUFGCE_DIV"]
       set in_frq [get_param_value PRIM_IN_FREQ]
    if { $in_frq <= $max_freq } {
	return true
        } else {
	return false
    }
}
##########################################
# Output Clock greater than input check
##########################################
proc out_in_frq {Ipview} {
    set in_frq [get_param_value PRIM_IN_FREQ]
    set list ""
	for {set i 1} {$i<8} {incr i} {
    set used [get_param_value CLKOUT${i}_USED]
    set out_frq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
    if {$out_frq > $in_frq} {
     if { $used == true } {
		 lappend list "$i" 
	 }
    }
    }
   set length [llength $list] 
   if {$length > 0 } {
	return false
        } else {
	return true
    }
}

##########################################
# Duty cycle check of the output clocks
##########################################

proc duty_cycle {Ipview} {
    set list ""
     set mult [get_param_value MMCM_CLKFBOUT_MULT_F]
     set div [get_param_value MMCM_DIVCLK_DIVIDE]
    variable  clk_wiz_v6_0_utils::c_num_oclks
    # set duty [get_param_value MMCM_CLKOUT${i}_DUTY_CYCLE]
    set in_frq [get_param_value PRIM_IN_FREQ]
    set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
    set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
	for {set i 0} {$i<7} {incr i} {
     if {$i == 0 } {
     set Out [get_param_value MMCM_CLKOUT0_DIVIDE_F]
     } else {
      set Out [get_param_value MMCM_CLKOUT${i}_DIVIDE]
      }
	set j [expr $i + 1]
	variable bufgce_divide_clkout${j}
    set used [get_param_value CLKOUT${j}_USED]
    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
    set out_frq [get_param_value CLKOUT${j}_REQUESTED_OUT_FREQ]
    set driver [get_param_value CLKOUT${j}_DRIVES]
    set driver_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 set driver_used false  
	 } else {
		 set driver_used true  
	 }
	 }
	
    set divide [ expr $in_frq *1.0 / $out_frq ]
    #set divide [ expr ($div * $Out) *1.0 / ($mult) ]
	variable bufgce_divide_clkout${j} $divide
    if { $safe_clk == true || $dyn_reconfig == true } {
   } else {
    if {$divide == 1.0 && $used == true && $driver_used == true} {
      if { $duty == 50 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 2.0 && $used == true && $driver_used == true} {
      if { $duty == 50 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 3 && $used == true && $driver_used == true} {
      if { $duty >= 33 && $duty <= 34 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 4 && $used == true && $driver_used == true} {
      if { $duty == 50 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 5 && $used == true && $driver_used == true} {
      if { $duty == 40 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 6 && $used == true && $driver_used == true} {
      if { $duty == 50 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 7 && $used == true && $driver_used == true} {
      if { $duty >= 42 && $duty <= 43 } {
		  lappend list "$i" 
         } else {
         }
	} elseif {$divide == 8 && $used == true && $driver_used == true} {
      if { $duty == 50 } {
		  lappend list "$i" 
         } else {
         }
    } 
	}
    }
   set length [llength $list] 
   if {$length >= $c_num_oclks } {
   #send_msg INFO 881 "list $list"
	return true
        } else {
   #send_msg INFO 882 "list $list"
	return false
    }

}
##########################################
# Drives Check
##########################################
proc drives {Ipview} {
    set list ""
	for {set i 1} {$i<8} {incr i} {
    set driver [get_param_value CLKOUT${i}_DRIVES]
    set used [get_param_value CLKOUT${i}_USED]
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 lappend list "$i" 
	 }
    }
    }
   set length [llength $list] 
   set length [llength $list] 
   if {$length > 0 } {
	return false
        } else {
	return true
    }
}
##########################################
# PLL,BUFGCE_DIV combination for Auto primitive selection
##########################################
proc pll_infer {Ipview} {
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::c_debug
    variable  clk_wiz_v6_0_utils::c_num_oclks
   variable clk2_bufgce
   variable clk3_bufgce
   variable clk4_bufgce
   variable divide_clk2
   variable divide_clk3
   variable divide_clk4
  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
      set reqOutFreqStr [construct_req_outfreq_str $Ipview]

      set reqPhaseStr [construct_req_phase_str $Ipview]
      set reqDutyCycleStr [construct_req_duty_cycle_str $Ipview]
      set clkin1 [get_param_value PRIM_IN_FREQ]
      set clkin2 0.0
      if { $c_using_2_inclks == true } {
         set clkin2 [get_param_value SECONDARY_IN_FREQ ]
      }
      set bMinOJitterUsed false
      if { [get_param_value JITTER_SEL ] == "Min_O_Jitter" } {
         set bMinOJitterUsed true
      }
      set nonDefaultPhaseDC [has_non_default_phase_or_duty_cycle $Ipview]
           set timePeriod ""           
           set primMode [get_param_value PRIMITIVE]
           if { $primMode == "Auto" || $primMode == "MMCM" } {
           	set timePeriod [get_param_value MMCM_CLKIN1_PERIOD]
           } elseif { $primMode == "PLL" } {
           	set timePeriod [get_param_value PLL_CLKIN_PERIOD]
           }
   set clkphy_en [get_param_value ENABLE_CLKOUTPHY]
   set clkphy_freq [get_param_value CLKOUTPHY_REQUESTED_FREQ]
   ## THis is for PLL
   set list ""
        set errStr [ GetClosestSolution $PartName $ComponentName $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC true $c_debug $timePeriod $clkphy_en $clkphy_freq ]
   if { $errStr == "1" } {
      set Dvalue [ GetClkwizProperty $PartName $ComponentName ChosenD ]
      set Mvalue [ GetClkwizProperty $PartName $ComponentName ChosenM ]
      set divN0 [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
      set divN [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
	for {set i 1} {$i<4} {incr i} {
              set divN [ GetClkwizProperty $PartName $ComponentName ChosenDivN $i ]
        set divide [ expr $divN / ($divN0*1.0) ]
	set j [expr {$i + 1}]
    set used [get_param_value CLKOUT${j}_USED]
    set driver [get_param_value CLKOUT${j}_DRIVES]
    set driver_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 set driver_used false  
	 } else {
		 set driver_used true  
	 }
	 }
    set phase [get_param_value CLKOUT${j}_REQUESTED_PHASE]
    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
    if { $safe_clk == true || $dyn_reconfig == true } {
   } else {
    if {$divide == 1.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$i" 
	} elseif {$divide == 2.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 3 && $duty >= 33 && $duty <= 34 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 4 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 5 && $duty == 40 && $driver_used == true && $phase == 0 && $used == true}  {
		  lappend list "$i" 
	} elseif {$divide == 6 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 7 && $duty >= 42 && $duty <= 43 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 8 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
    } 
    } 
    }
   }
   set length_pll [llength $list]
   set diff_pll [expr $c_num_oclks - $length_pll]
   if {$diff_pll >= 3} {
   return false
   } else {
   return true
   }
}

proc mmcm_infer {Ipview} {
   variable clk_wiz_v6_0_utils::PartName
   variable clk_wiz_v6_0_utils::ComponentName
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::c_debug
    variable  clk_wiz_v6_0_utils::c_num_oclks
   variable clk2_bufgce
   variable clk3_bufgce
   variable clk4_bufgce
   variable divide_clk2
   variable divide_clk3
   variable divide_clk4
  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
      set reqOutFreqStr [construct_req_outfreq_str $Ipview]

      set reqPhaseStr [construct_req_phase_str $Ipview]
      set reqDutyCycleStr [construct_req_duty_cycle_str $Ipview]
      set clkin1 [get_param_value PRIM_IN_FREQ]
      set clkin2 0.0
      if { $c_using_2_inclks == true } {
         set clkin2 [get_param_value SECONDARY_IN_FREQ ]
      }
      set bMinOJitterUsed false
      if { [get_param_value JITTER_SEL ] == "Min_O_Jitter" } {
         set bMinOJitterUsed true
      }
      set nonDefaultPhaseDC [has_non_default_phase_or_duty_cycle $Ipview]
           set timePeriod ""           
           set primMode [get_param_value PRIMITIVE]
           if { $primMode == "Auto" || $primMode == "MMCM" } {
           	set timePeriod [get_param_value MMCM_CLKIN1_PERIOD]
           } elseif { $primMode == "PLL" } {
           	set timePeriod [get_param_value PLL_CLKIN_PERIOD]
           }
   set clkphy_en [get_param_value ENABLE_CLKOUTPHY]
   set clkphy_freq [get_param_value CLKOUTPHY_REQUESTED_FREQ]
   ## THis is for MMCM
   set list ""
        set errStr [ GetClosestSolution $PartName $ComponentName $reqOutFreqStr $reqPhaseStr $reqDutyCycleStr $clkin1 $clkin2 $c_num_oclks $bMinOJitterUsed $nonDefaultPhaseDC false $c_debug $timePeriod $clkphy_en $clkphy_freq ]
   if { $errStr == "1" } {
      set Dvalue [ GetClkwizProperty $PartName $ComponentName ChosenD ]
      set Mvalue [ GetClkwizProperty $PartName $ComponentName ChosenM ]
      set divN0 [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
      set divN [ GetClkwizProperty $PartName $ComponentName ChosenDiv0 ]
	for {set i 1} {$i<4} {incr i} {
              set divN [ GetClkwizProperty $PartName $ComponentName ChosenDivN $i ]
        set divide [ expr $divN / ($divN0*1.0) ]
	set j [expr {$i + 1}]
    set used [get_param_value CLKOUT${j}_USED]
    set driver [get_param_value CLKOUT${j}_DRIVES]
    set driver_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 set driver_used false  
	 } else {
		 set driver_used true  
	 }
	 }
    set phase [get_param_value CLKOUT${j}_REQUESTED_PHASE]
    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
    if { $safe_clk == true || $dyn_reconfig == true } {
   } else {
    if {$divide == 1.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$i" 
	} elseif {$divide == 2.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 3 && $duty >= 33 && $duty <= 34 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 4 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 5 && $duty == 40 && $driver_used == true && $phase == 0 && $used == true}  {
		  lappend list "$i" 
	} elseif {$divide == 6 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 7 && $duty >= 42 && $duty <= 43 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
	} elseif {$divide == 8 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$i" 
    } 
    } 
    }
   }
   set length_mmcm [llength $list]
   set diff_mmcm [expr $c_num_oclks - $length_mmcm]
   if {$diff_mmcm >= 3} {
   return false
   } else {
   return true
   }
}

#proc pll_bufgcediv {Ipview} {
#    set list ""
#    set mult [get_param_value MMCM_CLKFBOUT_MULT_F]
#    set div [get_param_value MMCM_DIVCLK_DIVIDE]
#    set out1_freq [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]
#    set out1_divide [get_param_value MMCM_CLKOUT0_DIVIDE_F]
#  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
#  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
#    variable  clk_wiz_v6_0_utils::c_num_oclks
#	for {set i 1} {$i<4} {incr i} {
#	set j [expr {$i + 1}]
#    set used [get_param_value CLKOUT${j}_USED]
#    set driver [get_param_value CLKOUT${j}_DRIVES]
#    set driver_used true
#    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
#     if { $used == true } {
#		 set driver_used false  
#	 } else {
#		 set driver_used true  
#	 }
#	 }
#    set out_freq [get_param_value CLKOUT${j}_REQUESTED_OUT_FREQ]
#    set out_divide [get_param_value MMCM_CLKOUT${i}_DIVIDE]
#    set phase [get_param_value CLKOUT${j}_REQUESTED_PHASE]
#    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
#    #set divide [ expr $out1_freq / ($out_freq*1.0) ]
#    set divide [ expr $out_divide / ($out1_divide*1.0) ]
#    if { $safe_clk == true || $dyn_reconfig == true } {
#   } else {
#    if {$divide == 1.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
#		  lappend list "$i" 
#	} elseif {$divide == 2.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#	} elseif {$divide == 3 && $duty >= 33 && $duty <= 34 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#	} elseif {$divide == 4 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#	} elseif {$divide == 5 && $duty == 40 && $driver_used == true && $phase == 0 && $used == true}  {
#		  lappend list "$i" 
#	} elseif {$divide == 6 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#	} elseif {$divide == 7 && $duty >= 42 && $duty <= 43 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#	} elseif {$divide == 8 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
#		  lappend list "$i" 
#    } 
#    } 
#    }
#	
#   set length [llength $list]
#   set diff [expr $c_num_oclks - $length]
#   if {$diff >= 3} {
#	return false
#        } else {
#	return true
#    }
#
#}
######################################
# Setup the outclk buffer resource numbers.
proc setup_oclk_res_numbers {IpView} {
   variable  clk_wiz_v6_0_utils::c_num_oclks
   variable  dup_numBUFG
   variable  dup_numBUFGCE

   variable  c_numBUFR 
   variable  c_numBUFG
   variable  c_numBUFR
   variable  c_numBUFH
   variable  c_numODDR2
   variable  c_numODDR
   variable  c_numOBUFDS
   variable  c_numBUFGCE $dup_numBUFGCE
   variable  c_numBUFHCE
   set value_Clkout0_Drives [ get_param_value  CLKOUT1_DRIVES ]
   set value_Clkout1_Drives [ get_param_value  CLKOUT2_DRIVES ]
   set value_Clkout2_Drives [ get_param_value  CLKOUT3_DRIVES ]
   set value_Clkout3_Drives [ get_param_value  CLKOUT4_DRIVES ]
   set value_Clkout4_Drives [ get_param_value  CLKOUT5_DRIVES ]
   set value_Clkout5_Drives [ get_param_value  CLKOUT6_DRIVES ]
   set value_Clkout6_Drives [ get_param_value  CLKOUT7_DRIVES ]
   set value_Feedback_Source [ get_param_value FEEDBACK_SOURCE ]
   set value_Clkfb_In_Signaling [ get_param_value CLKFB_IN_SIGNALING ]
   set value_UPA [ get_param_value USE_PHASE_ALIGNMENT ]
   
   # if {$dup_numBUFG == 0 && ($c_numBUFG == 0 || $c_numBUFG == 1) && $c_numBUFR == 0 && $c_numBUFH == 0 && $c_numODDR2 == 0 && $c_numODDR == 0 && $c_numOBUFDS == 0 && $c_numBUFGCE == 0} {
   #    for {set i 1} {$i <= 7} {incr i} {
   #      EvalSubstituting {i} {
   #          set used [get_param_value CLKOUT$i_USED]
   #          if { $used == true} {
   #             set primitive [get_param_value PRIMITIVE ]
   #             set auto_prim [get_param_value AUTO_PRIMITIVE]
   #            if { ($primitive == "Auto") && ($auto_prim == "PLL") } {
   #              if {[ get_param_value CLKOUT$i_DRIVES] == "BUFG" || [get_param_value CLKOUT$i_DRIVES] == "BUFGCE" || [get_param_value CLKOUT$i_DRIVES] == "No_buffer"} {
   #                # Do nothing
   #              } else {
   #                if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
   #                     if {[ get_param_value CLKOUT$i_MATCHED_ROUTING] == true} {
   #                      #Do Nothing
   #                    } else {
   #                      variable  c_numBUFG
   #                      variable c_numBUFG [expr {$c_numBUFG + 1}]
   #                    }
   #                 } 
   #              }
   #            } else {
   #                 variable mmcm_bufgcediv$i
   #                 variable drive_bufgcediv$i
   #                 if {[ get_param_value CLKOUT$i_DRIVES] == "BUFR" || [ get_param_value CLKOUT$i_DRIVES] == "BUFH" || [ get_param_value CLKOUT$i_DRIVES] == "BUFHCE" || [ get_param_value CLKOUT$i_DRIVES] == "BUFG" || [get_param_value CLKOUT$i_DRIVES] == "BUFGCE" || [get_param_value CLKOUT$i_DRIVES] == "No_buffer"} {
   #                    # Do nothing
   #                 } elseif  {[get_param_value CLKOUT$i_DRIVES] == "BUFGCE_DIV" && $mmcm_bufgcediv$i == false} {
   #                 # variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   #                 } else {
   #                  variable numBUFGCE_DIV
   #                  if { $numBUFGCE_DIV < 4 } {
   #                      if { $mmcm_bufgcediv$i == true} {
   #                      # variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   #                      } elseif { $drive_bufgcediv$i == true} {
   #                      # variable numBUFGCE_DIV [expr {$numBUFGCE_DIV + 1}]
   #                        } else {
   #                    ##fix to resolve buffer instantiation issue
   #                       if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
   #                        variable c_numBUFG 
   #                        variable c_numBUFG [expr {$c_numBUFG + 1}]
   #                       } elseif {[ get_param_value CLKOUT$i_DRIVES] == "Buffer_with_CE"} {
   #                       # variable c_numBUFGCE [expr {$c_numBUFGCE + 1}]
   #                       }
   #                      }
   #                    } else {
   #                     if {[ get_param_value CLKOUT$i_DRIVES] == "Buffer"} {
   #                      variable c_numBUFG 
   #                      variable c_numBUFG [expr {$c_numBUFG + 1}]
   #                     } elseif  {[ get_param_value CLKOUT$i_DRIVES] == "Buffer_with_CE"} {
   #                     # variable c_numBUFGCE [expr {$c_numBUFGCE  + 1}]
   #                     }
   #                    }
   #                }
   #            }

   #          }
   #        }
   #      }
   #    }


   for { set ctr 0 } { $ctr < $c_num_oclks } { incr ctr } {
      if { $ctr == 0 } {
         set oclkBuf $value_Clkout0_Drives
      } elseif { $ctr == 1 } {
         set oclkBuf $value_Clkout1_Drives
      } elseif { $ctr == 2 } {
         set oclkBuf $value_Clkout2_Drives
      } elseif { $ctr == 3 } {
         set oclkBuf $value_Clkout3_Drives
      } elseif { $ctr == 4 } {
         set oclkBuf $value_Clkout4_Drives
      } elseif { $ctr == 5 } {
         set oclkBuf $value_Clkout5_Drives
      } elseif { $ctr == 6 } {
         set oclkBuf $value_Clkout6_Drives
      }
      if { $oclkBuf == "BUFG" } {
         variable c_numBUFG [expr $c_numBUFG + 1]
      } elseif { $oclkBuf == "BUFR" } {
         set c_numBUFR [expr $c_numBUFR + 1]
      } elseif { $oclkBuf == "BUFH" } {
         set c_numBUFH [expr $c_numBUFH + 1]
      } elseif { $oclkBuf == "BUFGCE" } {
         variable c_numBUFGCE [expr $c_numBUFGCE + 1]
      } elseif { $oclkBuf == "BUFHCE" } {
         set c_numBUFHCE [expr $c_numBUFHCE + 1]
      }
  
   }

   # If FDBK_AUTO_OFFCHIP is used, then add extra logic.
   if { $value_Feedback_Source == "FDBK_AUTO" && $value_UPA == true } {
      variable c_numBUFG [expr $c_numBUFG + 1]
   } elseif { [get_param_value FEEDBACK_SOURCE ] == "FDBK_AUTO_OFFCHIP" } {
      variable c_numBUFG [expr $c_numBUFG + 1]
      set c_numODDR [expr $c_numODDR + 1]
      if { $value_Clkfb_In_Signaling == "DIFF" } {
         set c_numOBUFDS [expr $c_numOBUFDS + 1]
      }
   }
}

######################################
# Sets the text of the next open resource to str1 and shows the widget.
proc set_next_open_resource { str1 } {
   variable text_Label_Res_2
   variable text_Label_Res_3
   variable text_Label_Res_4
   variable text_Label_Res_5
   variable text_Label_Res_6
   variable text_Label_Res_7
   variable text_Label_Res_8

   if { $text_Label_Res_2  == "none" } {
      set text_Label_Res_2 $str1
   } elseif { $text_Label_Res_3  == "none" } {
      set text_Label_Res_3 $str1
   } elseif { $text_Label_Res_4  == "none" } {
      set text_Label_Res_4 $str1
   } elseif { $text_Label_Res_5  == "none" } {
      set text_Label_Res_5 $str1
   } elseif { $text_Label_Res_6  == "none" } {
      set text_Label_Res_6 $str1
   } elseif { $text_Label_Res_7  == "none" } {
      set text_Label_Res_7 $str1
   } elseif { $text_Label_Res_8  == "none" } {
      set text_Label_Res_8 $str1
   }
}

######################################
# Resets the resource params to 0.
proc reset_res_params {} {
   variable c_numIBUFGDS
   variable c_numIBUFDS
   variable c_numIBUF
   variable c_numIBUFG
   variable c_numBUFG
   variable c_numBUFR
   variable c_numBUFH
   variable c_numODDR
   variable c_numODDR2
   variable c_numOBUFDS
   variable c_numIBUFDS_DIFF_OUT
   variable c_numBUFIO2FB
   variable c_numBUFGCE
   variable c_numBUFHCE

   set c_numIBUFGDS 0
   set c_numIBUFDS 0
   set c_numIBUF 0
   set c_numIBUFG 0
   variable c_numBUFG 0
   set c_numBUFR 0
   set c_numBUFH 0
   set c_numODDR 0
   set c_numODDR2 0
   set c_numOBUFDS 0
   set c_numIBUFDS_DIFF_OUT 0
   set c_numBUFIO2FB 0
   variable c_numBUFGCE 0
   set c_numBUFHCE 0
}

######################################
# Setup the input buffer resource numbers.
proc setup_ibuf_res_numbers {IpView} {
   variable c_IBUFG_src
   variable c_IBUFGDS_src
   variable c_IBUF_BUFG_src
   variable c_IBUFDS_BUFG_src
   variable c_numIBUFGDS
   variable c_numIBUFDS
   variable c_numIBUF
   variable c_numIBUFG
   variable dup_numBUFG
   variable c_numBUFG $dup_numBUFG
   variable c_numIBUFDS_DIFF_OUT
   variable c_numBUFIO2FB
   variable clk_wiz_v6_0_utils::c_using_2_inclks

   if {[get_param_value PRIM_SOURCE ] == $c_IBUFGDS_src } {
      set c_numIBUFGDS [expr $c_numIBUFGDS + 1]
   } elseif {[get_param_value PRIM_SOURCE ] == $c_IBUFDS_BUFG_src} {
      set c_numIBUFDS [expr $c_numIBUFDS + 1]
      variable c_numBUFG [expr $c_numBUFG + 1]
   } elseif {[get_param_value PRIM_SOURCE ] == $c_IBUF_BUFG_src} {
      set numIBUF 1
      variable c_numBUFG [expr $c_numBUFG + 1]
   } elseif {[get_param_value PRIM_SOURCE ] == $c_IBUFG_src} {
      set c_numIBUFG [expr $c_numIBUFG + 1]
   } elseif {[get_param_value PRIM_SOURCE ] == "Global_buffer"} {
      variable c_numBUFG [expr $c_numBUFG + 1]
   }
   if { $c_using_2_inclks == true } {
      if {[get_param_value SECONDARY_SOURCE ] == $c_IBUFGDS_src } {
         set c_numIBUFGDS [expr $c_numIBUFGDS + 1]
      } elseif {[get_param_value SECONDARY_SOURCE ] == $c_IBUFDS_BUFG_src} {
         set c_numIBUFDS [expr $c_numIBUFDS + 1]
         variable c_numBUFG [expr $c_numBUFG + 1 ]
      } elseif {[get_param_value SECONDARY_SOURCE ] == $c_IBUF_BUFG_src} {
         set c_numIBUF [expr $c_numIBUF + 1]
         variable c_numBUFG [expr $c_numBUFG + 1]
      } elseif {[get_param_value SECONDARY_SOURCE ] == $c_IBUFG_src} {
         set c_numIBUFG [expr $c_numIBUFG + 1]
      } elseif {[get_param_value SECONDARY_SOURCE ] == "Global_buffer"} {
         variable c_numBUFG [expr $c_numBUFG + 1]
      }
   }
   #If FDBK_AUTO_OFFCHIP then compute input buffers used for feedback
   if { [get_param_value FEEDBACK_SOURCE ] == "FDBK_AUTO_OFFCHIP" } {
      if { [get_param_value CLKFB_IN_SIGNALING ] == "DIFF" } {
         set c_numIBUFGDS [expr $c_numIBUFGDS + 1]
      } elseif { [get_param_value CLKFB_IN_SIGNALING ] == "SINGLE" } {
         variable c_numIBUFG [expr $c_numIBUFG + 1]
      }
   }
}

######################################
# Write out the resource labels with the latest numbers.
proc show_res_labels {} {
   variable text_Label_Res_2
   variable text_Label_Res_3
   variable text_Label_Res_4
   variable text_Label_Res_5
   variable text_Label_Res_6
   variable text_Label_Res_7
   variable text_Label_Res_8
   variable c_numIBUFGDS
   variable c_numIBUFDS
   variable c_numIBUF
   variable c_numIBUFG
   variable c_numBUFG
   variable c_numIBUFDS_DIFF_OUT
   variable c_numBUFIO2FB
   variable c_numBUFH
   variable c_numBUFR
   variable c_numODDR
   variable c_numODDR2
   variable c_numOBUFDS
   variable c_numBUFGCE
   variable c_numBUFHCE
   variable numBUFGCE_DIV
   # Reset all the resource labels: hide and set to "none"
   set text_Label_Res_2 "none"
   set text_Label_Res_3 "none"
   set text_Label_Res_4 "none"
   set text_Label_Res_5 "none"
   set text_Label_Res_6 "none"
   set text_Label_Res_7 "none"
   set text_Label_Res_8 "none"

   if { $c_numIBUF > 0 } {
      set_next_open_resource "$c_numIBUF IBUF"
   }
   if { $c_numIBUFG > 0 } {
      set_next_open_resource "$c_numIBUFG IBUFG"
   }
   if { $c_numIBUFDS > 0 } {
      set_next_open_resource "$c_numIBUFDS IBUFDS"
   }
   if { $c_numIBUFGDS > 0 } {
      set_next_open_resource "$c_numIBUFGDS IBUFDS"
   }
   if { $c_numIBUFDS_DIFF_OUT > 0 } {
      set_next_open_resource "$c_numIBUFDS_DIFF_OUT IBUFDS_DIFF_OUT"
   }
   if { $c_numBUFIO2FB > 0 } {
      set_next_open_resource "$c_numBUFIO2FB BUFIO2FB"
   }
   if { $c_numBUFG > 0 } {
      set_next_open_resource "$c_numBUFG BUFG"
   }
   if { $c_numBUFR > 0 } {
      set_next_open_resource "$c_numBUFR BUFR"
   }
   if { $c_numBUFH > 0 } {
      set_next_open_resource "$c_numBUFH BUFH"
   }
   if { $c_numBUFGCE > 0 } {
      set_next_open_resource "$c_numBUFGCE BUFGCE"
   }
   if { $c_numBUFHCE > 0 } {
      set_next_open_resource "$c_numBUFHCE BUFHCE"
   }
   if { $numBUFGCE_DIV > 0 } {
      set_next_open_resource "$numBUFGCE_DIV BUFGCE_DIV"
   }
   if { $c_numODDR > 0 } {
      set_next_open_resource "$c_numODDR ODDR"
   }
   if { $c_numODDR2 > 0 } {
      set_next_open_resource "$c_numODDR2 ODDR2"
   }
   if { $c_numOBUFDS > 0 } {
      set_next_open_resource "$c_numOBUFDS OBUFDS"
   }
}

#################################################################
# Setup summary strings, used in generated files.
proc setup_summary_strings {IpView} {
   variable clk_wiz_v6_0_utils::c_using_2_inclks
   variable clk_wiz_v6_0_utils::c_num_oclks
   variable text_c_inclk_sum_row0
   variable text_c_inclk_sum_row1
   variable text_c_inclk_sum_row2
   variable text_c_outclk_sum_row0a
   variable text_c_outclk_sum_row0b
   variable text_c_outclk_sum_row1
   variable text_c_outclk_sum_row2
   variable text_c_outclk_sum_row3
   variable text_c_outclk_sum_row4
   variable text_c_outclk_sum_row5
   variable text_c_outclk_sum_row6
   variable text_c_outclk_sum_row7

   variable text_Outclk_Sum_Clkout1_Name
   variable text_Outclk_Sum_Clkout1_Out_Freq
   variable text_Outclk_Sum_Clkout1_Out_Time
   variable text_Outclk_Sum_Clkout1_Phase
   variable text_Outclk_Sum_Clkout1_Duty_Cycle
   variable text_Outclk_Sum_Clkout1_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout1_Phase_Error
   variable text_Outclk_Sum_Clkout2_Out_Freq
   variable text_Outclk_Sum_Clkout2_Out_Time
   variable text_Outclk_Sum_Clkout2_Phase
   variable text_Outclk_Sum_Clkout2_Duty_Cycle
   variable text_Outclk_Sum_Clkout2_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout2_Phase_Error
   variable text_Outclk_Sum_Clkout3_Out_Freq
   variable text_Outclk_Sum_Clkout3_Out_Time
   variable text_Outclk_Sum_Clkout3_Phase
   variable text_Outclk_Sum_Clkout3_Duty_Cycle
   variable text_Outclk_Sum_Clkout3_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout3_Phase_Error
   variable text_Outclk_Sum_Clkout4_Out_Freq
   variable text_Outclk_Sum_Clkout4_Out_Time
   variable text_Outclk_Sum_Clkout4_Phase
   variable text_Outclk_Sum_Clkout4_Duty_Cycle
   variable text_Outclk_Sum_Clkout4_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout4_Phase_Error
   variable text_Outclk_Sum_Clkout5_Out_Freq
   variable text_Outclk_Sum_Clkout5_Out_Time
   variable text_Outclk_Sum_Clkout5_Phase
   variable text_Outclk_Sum_Clkout5_Duty_Cycle
   variable text_Outclk_Sum_Clkout5_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout5_Phase_Error
   variable text_Outclk_Sum_Clkout6_Out_Freq
   variable text_Outclk_Sum_Clkout6_Out_Time
   variable text_Outclk_Sum_Clkout6_Phase
   variable text_Outclk_Sum_Clkout6_Duty_Cycle
   variable text_Outclk_Sum_Clkout6_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout6_Phase_Error
   variable text_Outclk_Sum_Clkout7_Out_Freq
   variable text_Outclk_Sum_Clkout7_Out_Time
   variable text_Outclk_Sum_Clkout7_Phase
   variable text_Outclk_Sum_Clkout7_Duty_Cycle
   variable text_Outclk_Sum_Clkout7_Pktopk_Jitter
   variable text_Outclk_Sum_Clkout7_Phase_Error
  
   # TODO it's not working xspcie bug Input Clock Summary Table rows.
   set text_c_inclk_sum_row0 "Input Clock   Freq (MHz)    Input Jitter (UI)"
   #set text_c_inclk_sum_row0 "Input Clock [clk_wiz_v6_0_utils::format_str [get_property value [ipgui::get_textspec Label_Inclk_Sum_Freq_Header -of $IpView]] 18]"
# [clk_wiz_v6_0_utils::format_str [get_property value [ipgui::get_textspec Label_Inclk_Sum_Jitter_Header -of $IpView]] 19]"
   set text_c_inclk_sum_row1 "__primary________[clk_wiz_v6_0_utils::format_str [get_param_value PRIM_IN_FREQ ] 8]___________[clk_wiz_v6_0_utils::format_str [get_param_value CLKIN1_UI_JITTER] 6]"
   if { $c_using_2_inclks == true } {
      set text_c_inclk_sum_row2 "_secondary______[clk_wiz_v6_0_utils::format_str [get_param_value SECONDARY_IN_FREQ ] 8]___________[clk_wiz_v6_0_utils::format_str [get_param_value CLKIN2_UI_JITTER] 6]"
   } else {
      set text_c_inclk_sum_row2 "no_secondary_input_clock "
   }

   # Output Clock Summary Table rows.
   set text_c_outclk_sum_row0a " Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase"
   set text_c_outclk_sum_row0b "  Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)"
   calculate_jitter_and_phase_error $IpView
   for { set i 1 } { $i < 8 } { incr i } {
   if { $c_num_oclks >= $i } {
   #fix for CR 716462
   #mmcm_pll_load_oclk_sum_tbl $IpView $i [get_param_value OVERRIDE_MMCM]
   mmcm_pll_load_oclk_sum_tbl $IpView $i true
      set text_c_outclk_sum_row${i} "[clk_wiz_v6_0_utils::format_str [get_param_value CLK_OUT${i}_PORT ] 8]__[clk_wiz_v6_0_utils::format_str [clk_wiz_v6_0_utils::convertXXX [set text_Outclk_Sum_Clkout${i}_Out_Freq] ] 8]____[clk_wiz_v6_0_utils::format_str [clk_wiz_v6_0_utils::convertXXX [set text_Outclk_Sum_Clkout${i}_Phase] ] 7]___[clk_wiz_v6_0_utils::format_str [convertXXX [set text_Outclk_Sum_Clkout${i}_Duty_Cycle] ] 7]_____[clk_wiz_v6_0_utils::format_str [set text_Outclk_Sum_Clkout${i}_Pktopk_Jitter] 8]___[clk_wiz_v6_0_utils::format_str [set text_Outclk_Sum_Clkout${i}_Phase_Error] 8]"
   } else {
      set text_c_outclk_sum_row${i} "no_CLK_OUT${i}_output"
   }
   }
}
proc init_xpg_bd {IpView} {
   ##Disable Input Ports Renaming 
   set_property enabled false [ipgui::get_paramspec PRIMARY_PORT -of $IpView]
   set_property enabled false [ipgui::get_paramspec SECONDARY_PORT -of $IpView]
    
   ##Disable Output Port Renaming  
   for {set i 1} {$i <= 7} {incr i} {
        EvalSubstituting {i} {
            #set_property enabled false [ipgui::get_paramspec CLK_OUT${i}_PORT -of  $IpView] 
        } 0    
   }

   ##Disabled Optional Ports Renaming
   set Paramlist "RESET_PORT LOCKED_PORT POWER_DOWN_PORT CLK_IN_SEL_PORT INPUT_CLK_STOPPED_PORT CLKFB_STOPPED_PORT CLKFB_IN_PORT CLKFB_IN_P_PORT CLKFB_IN_N_PORT CLKFB_OUT_PORT CLKFB_OUT_P_PORT CLKFB_OUT_N_PORT DADDR_PORT DCLK_PORT DRDY_PORT DWE_PORT DIN_PORT DOUT_PORT DEN_PORT"
	for {set j 0} {$j < 19} {incr j} {
        EvalSubstituting {j} {
    		set ParamName [lindex $Paramlist $j]
	    	set_property enabled false [ipgui::get_paramspec $ParamName -of $IpView]
       } 0 
	} 
}


proc pll_bufgcediv_seperation {IpView} {
  set phase_alignment [ get_param_value  USE_PHASE_ALIGNMENT ]
  set spread_spectrum [ get_param_value  USE_SPREAD_SPECTRUM ]
  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
  set dyn_phase_shift [ get_param_value  USE_DYN_PHASE_SHIFT ]
  set cddc [ get_param_value  ENABLE_CDDC ]
  set second_ip [ get_param_value  USE_INCLK_SWITCHOVER ]
  set locked [ get_param_value  USE_LOCKED ]
  set reset [ get_param_value  USE_RESET ]
  set pwr_dwn [ get_param_value  USE_POWER_DOWN ]
  set inclk_stopped [ get_param_value  USE_INCLK_STOPPED ]
  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
  set clkfb_stopped [ get_param_value  USE_CLKFB_STOPPED ]
    set list ""
	    variable clk5_bufgce "false"
	    variable clk6_bufgce "false"
	    variable clk7_bufgce "false"
    set mult [get_param_value MMCM_CLKFBOUT_MULT_F]
    set div [get_param_value MMCM_DIVCLK_DIVIDE]
    set out1_freq [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]
    set out1_divide [get_param_value MMCM_CLKOUT0_DIVIDE_F]
    variable  clk_wiz_v6_0_utils::c_num_oclks
	for {set i 1} {$i<4} {incr i} {
	set j [expr {$i + 1}]
    set used [get_param_value CLKOUT${j}_USED]
    set driver [get_param_value CLKOUT${j}_DRIVES]
    set driver_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 set driver_used false  
	 } else {
		 set driver_used true  
	 }
	 }
    set out_freq [get_param_value CLKOUT${j}_REQUESTED_OUT_FREQ]
    set out_divide [get_param_value MMCM_CLKOUT${i}_DIVIDE]
    set phase [get_param_value CLKOUT${j}_REQUESTED_PHASE]
    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
    #set divide [ expr $out1_freq / ($out_freq*1.0) ]
    set divide [ expr $out_divide / ($out1_divide*1.0) ]
	variable divide_clk$j $divide
	
    if { $safe_clk == true || $dyn_reconfig == true } {
   } else {
    if {$divide == 1.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 2.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 3 && $duty >= 33 && $duty <= 34 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 4 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 5 && $duty == 40 && $driver_used == true && $phase == 0 && $used == true}  {
		  lappend list "$j" 
	} elseif {$divide == 6 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 7 && $duty >= 42 && $duty <= 43 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 8 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
    } 
    }
	}

   set auto_prim [get_param_value AUTO_PRIMITIVE]
   set prim_type [get_param_value PRIMITIVE]
   set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
   if  { ($auto_prim == "PLL") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ($prim_type == "PLL")) } {
     if {[lsearch -inline $list 1] == 1 } {
	    variable clk1_bufgce "true"
     } else {
	    variable clk1_bufgce "false"
     }
     
     if {[lsearch -inline $list 2] == 2 } {
	    variable clk2_bufgce "true"
     } else {
	    variable clk2_bufgce "false"
     }
     
     if {[lsearch -inline $list 3] == 3 } {
	    variable clk3_bufgce "true"
     } else {
	    variable clk3_bufgce "false"
     }
     
     if {[lsearch -inline $list 4] == 4 } {
	    variable clk4_bufgce "true"
     } else {
	    variable clk4_bufgce "false"
     }

   } else {
	    variable clk1_bufgce "false"
	    variable clk2_bufgce "false"
	    variable clk3_bufgce "false"
	    variable clk4_bufgce "false"
   }
	return $list
	}

proc mmcm_bufgcediv_seperation {IpView} {
  set phase_alignment [ get_param_value  USE_PHASE_ALIGNMENT ]
  set spread_spectrum [ get_param_value  USE_SPREAD_SPECTRUM ]
  set dyn_reconfig [ get_param_value  USE_DYN_RECONFIG ]
  set dyn_phase_shift [ get_param_value  USE_DYN_PHASE_SHIFT ]
  set cddc [ get_param_value  ENABLE_CDDC ]
  set second_ip [ get_param_value  USE_INCLK_SWITCHOVER ]
    set matched_clk1 [get_param_value CLKOUT1_MATCHED_ROUTING]
  set locked [ get_param_value  USE_LOCKED ]
  set reset [ get_param_value  USE_RESET ]
  set pwr_dwn [ get_param_value  USE_POWER_DOWN ]
  set inclk_stopped [ get_param_value  USE_INCLK_STOPPED ]
  set safe_clk [ get_param_value  USE_SAFE_CLOCK_STARTUP ]
  set clkfb_stopped [ get_param_value  USE_CLKFB_STOPPED ]
    set list ""
    set mult [get_param_value MMCM_CLKFBOUT_MULT_F]
    set div [get_param_value MMCM_DIVCLK_DIVIDE]
    set out1_freq [get_param_value CLKOUT1_REQUESTED_OUT_FREQ]
    set out1_divide [get_param_value MMCM_CLKOUT0_DIVIDE_F]
    variable  clk_wiz_v6_0_utils::c_num_oclks
	for {set i 1} {$i<7} {incr i} {
	set j [expr {$i + 1}]
    set used [get_param_value CLKOUT${j}_USED]
    set driver [get_param_value CLKOUT${j}_DRIVES]
    set driver_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "No_buffer" } {
     if { $used == true } {
		 set driver_used false  
	 } else {
		 set driver_used true  
	 }
	 }
    set matched [get_param_value CLKOUT${j}_MATCHED_ROUTING]
    set out_freq [get_param_value CLKOUT${j}_REQUESTED_OUT_FREQ]
    set out_divide [get_param_value MMCM_CLKOUT${i}_DIVIDE]
    set phase [get_param_value CLKOUT${j}_REQUESTED_PHASE]
    set duty [get_param_value CLKOUT${j}_REQUESTED_DUTY_CYCLE]
    #set divide [ expr $out1_freq / ($out_freq*1.0) ]
    set divide [ expr $out_divide / ($out1_divide*1.0) ]
	variable divide_clk$j $divide
	
    if { $safe_clk == true || $dyn_reconfig == true || $cddc == true  } {
   } else {
    if {$divide == 1.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 2.0 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 3 && $duty >= 33 && $duty <= 34 && $driver_used == true && $phase == 0 && $used == true} {
		  lappend list "$j" 
	} elseif {$divide == 4 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 5 && $duty == 40 && $driver_used == true && $phase == 0 && $used == true}  {
		  lappend list "$j" 
	} elseif {$divide == 6 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 7 && $duty >= 42 && $duty <= 43 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
	} elseif {$divide == 8 && $duty == 50 && $driver_used == true && $phase == 0 && $used == true } {
		  lappend list "$j" 
    } 
    }
	}
   set auto_prim [get_param_value AUTO_PRIMITIVE]
   set prim_type [get_param_value PRIMITIVE]
   set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
   set ss [get_param_value USE_SPREAD_SPECTRUM]
   if  { ($auto_prim == "MMCM") || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ($prim_type == "MMCM")) } {
     if {[lsearch -inline $list 1] == 1 } {
	    variable mmcm_bufgcediv1 "true"
     } else {
	    variable mmcm_bufgcediv1 "false"
     }
     
     if {[lsearch -inline $list 2] == 2 } {
	    variable mmcm_bufgcediv2 "true"
     } else {
	    variable mmcm_bufgcediv2 "false"
     }
     
     if {([lsearch -inline $list 3] == 3) && !$ss } {
	    variable mmcm_bufgcediv3 "true"
     } else {
	    variable mmcm_bufgcediv3 "false"
     }
     
     if {([lsearch -inline $list 4] == 4) && !$ss } {
	    variable mmcm_bufgcediv4 "true"
     } else {
	    variable mmcm_bufgcediv4 "false"
     }

     if {[lsearch -inline $list 5] == 5 } {
	    variable mmcm_bufgcediv5 "true"
     } else {
	    variable mmcm_bufgcediv5 "false"
     }
     
     if {[lsearch -inline $list 6] == 6 } {
	    variable mmcm_bufgcediv6 "true"
     } else {
	    variable mmcm_bufgcediv6 "false"
     }
     
     if {[lsearch -inline $list 7] == 7 } {
	    variable mmcm_bufgcediv7 "true"
     } else {
	    variable mmcm_bufgcediv7 "false"
     }

   } else {
	    variable mmcm_bufgcediv1 "false"
	    variable mmcm_bufgcediv2 "false"
	    variable mmcm_bufgcediv3 "false"
	    variable mmcm_bufgcediv4 "false"
	    variable mmcm_bufgcediv5 "false"
	    variable mmcm_bufgcediv6 "false"
	    variable mmcm_bufgcediv7 "false"
   }
	return $list

}

proc updateModel_C_DIVIDE1_AUTO {IpView} {
	variable bufgce_divide_clkout1 
   if {([get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto") } {
   set_property modelparam_value $bufgce_divide_clkout1 [ipgui::get_modelparamspec  C_DIVIDE1_AUTO -of $IpView]
} else {
   set_property modelparam_value 1 [ipgui::get_modelparamspec  C_DIVIDE1_AUTO -of $IpView]
}
}

proc updateModel_C_DIVIDE2_AUTO {IpView} {
variable divide_clk2
variable bufgce_divide_clkout2
   if {([get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto") } {
   set_property modelparam_value $bufgce_divide_clkout2 [ipgui::get_modelparamspec  C_DIVIDE2_AUTO -of $IpView]
} else {
   set_property modelparam_value $divide_clk2 [ipgui::get_modelparamspec  C_DIVIDE2_AUTO -of $IpView]
} 
} 
proc updateModel_C_DIVIDE3_AUTO {IpView} {
variable divide_clk3
variable bufgce_divide_clkout3
   if {([get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto") } {
   set_property modelparam_value $bufgce_divide_clkout3 [ipgui::get_modelparamspec  C_DIVIDE3_AUTO -of $IpView]
} else {
   set_property modelparam_value $divide_clk3 [ipgui::get_modelparamspec  C_DIVIDE3_AUTO -of $IpView]
} 
} 
proc updateModel_C_DIVIDE4_AUTO {IpView} {
variable divide_clk4
variable bufgce_divide_clkout4
   if {([get_param_value AUTO_PRIMITIVE] == "BUFGCE_DIV" && [get_param_value PRIMITIVE] == "Auto") } {
   set_property modelparam_value $bufgce_divide_clkout4 [ipgui::get_modelparamspec  C_DIVIDE4_AUTO -of $IpView]
} else {
   set_property modelparam_value $divide_clk4 [ipgui::get_modelparamspec  C_DIVIDE4_AUTO -of $IpView]
} 
} 
proc updateModel_C_DIVIDE5_AUTO {IpView} {
variable divide_clk5
   set_property modelparam_value $divide_clk5 [ipgui::get_modelparamspec  C_DIVIDE5_AUTO -of $IpView]
} 
proc updateModel_C_DIVIDE6_AUTO {IpView} {
variable divide_clk6
   set_property modelparam_value $divide_clk6 [ipgui::get_modelparamspec  C_DIVIDE6_AUTO -of $IpView]
} 
proc updateModel_C_DIVIDE7_AUTO {IpView} {
variable divide_clk7
   set_property modelparam_value $divide_clk7 [ipgui::get_modelparamspec  C_DIVIDE7_AUTO -of $IpView]
} 
proc updateModel_C_CLKOUT1_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT1_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT1_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT2_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT2_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT2_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT3_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT3_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT3_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT4_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT4_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT4_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT5_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT5_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT5_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT6_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT6_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT6_MATCHED_ROUTING -of $IpView]
} 
proc updateModel_C_CLKOUT7_MATCHED_ROUTING {IpView} {
   set_property modelparam_value [get_param_value CLKOUT7_MATCHED_ROUTING] [ipgui::get_modelparamspec  C_CLKOUT7_MATCHED_ROUTING -of $IpView]
} 

proc updateModel_C_MMCM_CLKOUT1_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT1_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT1_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout1_Divide


proc updateModel_C_MMCM_CLKOUT2_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT2_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT2_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout2_Divide


proc updateModel_C_MMCM_CLKOUT3_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT3_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT3_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout4_Divide

proc updateModel_C_MMCM_CLKOUT4_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT4_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT4_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout5_Divide

proc updateModel_C_MMCM_CLKOUT5_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT5_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT5_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout6_Divide

proc updateModel_C_MMCM_CLKOUT6_DIVIDE  {IpView} {
   set_property modelparam_value [get_param_value MMCM_CLKOUT6_DIVIDE] [ipgui::get_modelparamspec C_MMCM_CLKOUT6_DIVIDE -of $IpView] 
} ;# _Mmcm_Clkout6_Divide

proc sortDictByValue {dict args} {
    set lst {}
    dict for {k v} $dict {lappend lst [list $k $v]}
    return [concat {*}[lsort -decreasing -real -index 1 {*}$args $lst]]
}
proc sortDictByValueIncreasing {dict args} {
    set lst {}
    dict for {k v} $dict {lappend lst [list $k $v]}
    return [concat {*}[lsort -real -index 1 {*}$args $lst]]
}

proc count_bufgcediv {IpView} {
set list_bufgcediv ""
	 for {set i 1} {$i<8} {incr i} {
     set buffer [get_param_value CLKOUT${i}_DRIVES]
     if { $buffer == "BUFGCE_DIV" } {
		 lappend list_bufgcediv "$i" 
	 }
	 }
   set length_bufgcediv [llength $list_bufgcediv]
return $length_bufgcediv	   
}

proc decide_buffers {IpView} {
mmcm_bufgcediv_seperation $IpView
variable  mmcm_bufgcediv1 false
variable  mmcm_bufgcediv2 false
variable  mmcm_bufgcediv3 false
variable  mmcm_bufgcediv4 false
variable  mmcm_bufgcediv5 false
variable  mmcm_bufgcediv6 false
variable  mmcm_bufgcediv7 false
variable  drive_bufgcediv1 false
variable  drive_bufgcediv2 false
variable  drive_bufgcediv3 false
variable  drive_bufgcediv4 false
variable  drive_bufgcediv5 false
variable  drive_bufgcediv6 false
variable  drive_bufgcediv7 false
set length_diff_1 0
set list_full ""
set list_freq ""
set list_bufgcediv ""
set list_common ""
set list_diff ""
set list_common_derived ""
set list_diff_derived ""
set list_freq_derived ""
set OPTIMIZE_CLOCKING_STRUCTURE_EN [get_param_value OPTIMIZE_CLOCKING_STRUCTURE_EN]
set ss [get_param_value USE_SPREAD_SPECTRUM]
 if  { [get_param_value PRIMITIVE] == "Auto" || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM"))} {
####send_msg INFO 991 "Auto"
 if  { [get_param_value AUTO_PRIMITIVE] == "MMCM" || ($OPTIMIZE_CLOCKING_STRUCTURE_EN && ([get_param_value PRIMITIVE] == "MMCM"))} {
####send_msg INFO 993 "Auto MMCM"
set list [mmcm_bufgcediv_seperation $IpView ]
if {$ss} {
regsub 3 $list "" list
regsub 4 $list "" list
}
    set driver [get_param_value CLKOUT1_DRIVES]
    set driver1_used true
    if {$driver == "BUFG" || $driver == "BUFGCE" || $driver == "BUFGCE_DIV" ||  $driver == "No_buffer" } {
		 set driver1_used false  
	 } else {
		 set driver1_used true  
	 }
   set length [llength $list]
   set list_freq ""
   
	 for {set i 1} {$i<8} {incr i} {
     set buffer [get_param_value CLKOUT${i}_DRIVES]
     if { $buffer == "BUFGCE_DIV" } {
		 lappend list_bufgcediv "$i" 
	 }
	 }
	 
   set length_bufgcediv [llength $list_bufgcediv]
#send_msg INFO 993 "list_bufgcediv $list_bufgcediv"
#send_msg INFO 997 "list $list"
   
if { $length >= 4 } {
###send_msg INFO 995 "Auto MMCM length >4"
###send_msg INFO 111 "bufgce_div derived list :$list"
###send_msg INFO 222 "bufgce_div list :$list_bufgcediv"
for {set i 1} {$i<8} {incr i} {
set  mmcm_bufgcediv$i false
set  drive_bufgcediv$i false
	}

# if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true && $driver1_used == true } {
		 # lappend list "1" 
# }

foreach m $list_bufgcediv {
     if {[lsearch -inline $list $m ] == $m } {
		 lappend list_common "$m" 
             } else {
		 lappend list_diff "$m" 
			 }
}
foreach m $list {
     if {[lsearch -inline $list_bufgcediv $m ] == $m } {
		 lappend list_common_derived "$m" 
             } else {
		 lappend list_diff_derived "$m" 
			 }
}
###send_msg INFO 122 "list_common list :$list_common"
####send_msg INFO 133 "list_diff list :$list_diff"

set length_common [llength $list_common]

if {$length_common  == 4 } {
###send_msg INFO 122 "length ==4"
foreach m $list_common {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
} else {
###send_msg INFO 122 "length <4"
foreach m $list_common {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
foreach m $list_diff {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}

set length_diff_bufgce_div [expr 4 - $length_bufgcediv]
##fix to resolve buffer instantiation issue
if {$length_diff_bufgce_div  != 0 } {

if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true && $driver1_used == true } {
set length_diff [expr 2 - $length_bufgcediv]
set  mmcm_bufgcediv1 false
set  drive_bufgcediv1 true
} else {
set length_diff [expr 3 - $length_bufgcediv]
set  mmcm_bufgcediv1 false
set  drive_bufgcediv1 false
}
###send_msg INFO 1211 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
###send_msg INFO 1233 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "
###send_msg INFO 311 "length_diff list :$length_diff length_bufgcediv $length_bufgcediv"
if { $length_diff >= 0} {
foreach i $list_diff_derived {
     set j [expr $i - 1]
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
     set out_div [get_param_value MMCM_CLKOUT${j}_DIVIDE]
		 lappend list_freq "$out_freq" 
		 lappend list_div "$out_div" 
	 }
	 
	set mm_bufgcediv [dict create]
    for {set v 0} {$v < [llength $list_diff_derived]} {incr v} {
      #dict set mm_bufgcediv [lindex $list_diff_derived $v] [lindex $list_freq $v]
      dict set mm_bufgcediv [lindex $list_diff_derived $v] [lindex $list_div $v]
     } 
	 
	set mm_bufgcediv_sorted [sortDictByValueIncreasing $mm_bufgcediv] 
	set mm_bufgcediv_clks [ lrange [dict keys $mm_bufgcediv_sorted] 0 $length_diff ]
	# set all variables
####send_msg INFO 1111 "mm_bufgcediv_sorted derived list :$mm_bufgcediv_sorted"
####send_msg INFO 1112 "mm_bufgcediv_clks derived list :$mm_bufgcediv_clks"
foreach m $mm_bufgcediv_clks {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
####send_msg INFO 2211 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
####send_msg INFO 2233 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "

}
}
}
####send_msg INFO 2211 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
####send_msg INFO 2233 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "
} elseif { $length > 0} {
#send_msg INFO 996 "Auto MMCM length <4"
#send_msg INFO 333 "bufgce_div derived list :$list"
#send_msg INFO 444 "bufgce_div list :$list_bufgcediv"
	for {set i 1} {$i<8} {incr i} {
set  mmcm_bufgcediv$i false
set  drive_bufgcediv$i false
	}
# if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true && $driver1_used == true } {
		 # lappend list "1" 
# }
########send_msg INFO 101 "1"

   set length [llength $list]
   set length_remaining [expr 3 - $length]
foreach m $list_bufgcediv {
     if {[lsearch -inline $list $m ] == $m } {
		 lappend list_common "$m" 
             } else {
		 lappend list_diff "$m" 
			 }
}
########send_msg INFO 102 "1"
foreach m $list {
     if {[lsearch -inline $list_bufgcediv $m ] == $m } {
		 lappend list_common_derived "$m" 
             } else {
		 lappend list_diff_derived "$m" 
			 }
}

set length_common [llength $list_common]
########send_msg INFO 103 "1"

foreach m $list_common {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
foreach m $list_diff {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}

set length_diff [expr 4 - $length_bufgcediv]
#send_msg INFO 1011 "1difference $length_diff"

if { $length_diff > 0} {

if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true && $driver1_used == true } {
####send_msg INFO 101 "1"
set length_diff_1 [expr 3 - $length_bufgcediv]
set  mmcm_bufgcediv1 false
set  drive_bufgcediv1 true
} else {
######send_msg INFO 102 "1"
set length_diff_1 [expr 4 - $length_bufgcediv]
set  mmcm_bufgcediv1 false
set  drive_bufgcediv1 false
}

}
######send_msg INFO 103 "1"

if { $length_diff_1 > 0} {
# set variables of list
set length_list_diff_derived [llength $list_diff_derived]
if { $length_diff_1 >= $length_list_diff_derived} {
foreach m $list_diff_derived {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
set length_left [expr $length_diff_1 - $length_list_diff_derived]
########send_msg INFO 105 "1"
#send_msg INFO 444 "length_left :$length_left"

if { $length_left > 0 } {
########send_msg INFO 106 "1"

	for {set i 2} {$i<8} {incr i} {
    set matched [get_param_value CLKOUT${i}_MATCHED_ROUTING]
    set used [get_param_value CLKOUT${i}_USED]
    set driver [get_param_value CLKOUT${i}_DRIVES]
    set driver_used false
    if {$driver == "Buffer" || $driver == "Buffer_with_CE" } {
     if { $used == true } {
		 set driver_used true  
	 } else {
		 set driver_used false  
	 }
	 }
     if { $matched == true && $driver_used == true } {
		 lappend list_full "$i" 
	 }
	 }
########send_msg INFO 107 "1"
foreach m $list {
 set x [lsearch $list_full $m]
 set list_full [lreplace $list_full $x $x]
}
	 foreach i $list_full {
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
		 lappend list_freq "$out_freq" 
	 }

	set mm_bufgcediv [dict create]
    for {set v 0} {$v < [llength $list_full]} {incr v} {
      dict set mm_bufgcediv [lindex $list_full $v] [lindex $list_freq $v]
     } 
	set mm_bufgcediv_sorted [sortDictByValue $mm_bufgcediv] 
########send_msg INFO 108 "1"
	set mm_bufgcediv_clks [ lrange [dict keys $mm_bufgcediv_sorted] 0 [expr $length_left - 1]]
 # set for all clks in the list
#send_msg INFO 4449999 "mm_bufgcediv_sorted :$mm_bufgcediv_sorted"
#send_msg INFO 1149999 "mm_bufgcediv_clks :$mm_bufgcediv_clks"
########send_msg INFO 109 "1"
foreach m $mm_bufgcediv_clks {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}
}
} else {
	 foreach i $list_diff_derived {
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
		 lappend list_freq_derived "$out_freq" 
	 }

	set mm_bufgcediv_derived [dict create]
    for {set v 0} {$v < [llength $list_diff_derived]} {incr v} {
      dict set mm_bufgcediv_derived [lindex $list_diff_derived $v] [lindex $list_freq_derived $v]
     } 
######send_msg INFO 107 "1"
	 
	set mm_bufgcediv_sorted_derived [sortDictByValue $mm_bufgcediv_derived] 
	set mm_bufgcediv_clks_derived [ lrange [dict keys $mm_bufgcediv_sorted_derived] 0 [expr $length_diff_1 - 1]]
######send_msg INFO 108 "1"
 
 # set for all clks in the list
foreach m $mm_bufgcediv_clks_derived {
set  mmcm_bufgcediv$m true
set  drive_bufgcediv$m false
}
}
# if { [get_param_value CLKOUT1_MATCHED_ROUTING] == true && $driver1_used == true } {
# set length_diff [expr 2 - $length_bufgcediv]
# set  mmcm_bufgcediv1 false
# set  drive_bufgcediv1 true
# } else {
# set  mmcm_bufgcediv1 false
# set  drive_bufgcediv1 false
# }
}
} else {
####send_msg INFO 997 "Auto MMCM length <0"
####send_msg INFO 555 "bufgce_div derived list :$list"
####send_msg INFO 666 "bufgce_div list :$list_bufgcediv"
foreach m $list_bufgcediv {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}

set length_diff [expr 4 - $length_bufgcediv]

if {$length_diff > 0 } {

	for {set i 1} {$i<8} {incr i} {
set  mmcm_bufgcediv$i false
set  drive_bufgcediv$i false
	}
	for {set i 1} {$i<8} {incr i} {
    set matched [get_param_value CLKOUT${i}_MATCHED_ROUTING]
    set used [get_param_value CLKOUT${i}_USED]
    set driver [get_param_value CLKOUT${i}_DRIVES]
    set driver_used false
    if {$driver == "Buffer" || $driver == "Buffer_with_CE" } {
     if { $used == true } {
		 set driver_used true  
	 } else {
		 set driver_used false  
	 }
	 }
     if { $matched == true && $driver_used == true } {
		 lappend list_full "$i" 
	 }
	 }
	 foreach i $list_full {
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
		 lappend list_freq "$out_freq" 
	 }

	set mm_bufgcediv [dict create]
	
    for {set v 0} {$v < [llength $list_full]} {incr v} {
      dict set mm_bufgcediv [lindex $list_full $v] [lindex $list_freq $v]
     } 
	set mm_bufgcediv_sorted [sortDictByValue $mm_bufgcediv] 
	set mm_bufgcediv_clks [ lrange [dict keys $mm_bufgcediv_sorted] 0 [expr $length_diff - 1] ]
foreach m $mm_bufgcediv_clks {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}

}
}
} else {
####send_msg INFO 993 "Auto not MMCM"
	for {set i 1} {$i<8} {incr i} {
set  mmcm_bufgcediv$i false
set  drive_bufgcediv$i false
	}
	for {set i 1} {$i<8} {incr i} {
    set matched [get_param_value CLKOUT${i}_MATCHED_ROUTING]
    set used [get_param_value CLKOUT${i}_USED]
    set driver [get_param_value CLKOUT${i}_DRIVES]
    set driver_used false
    if {$driver == "Buffer" || $driver == "Buffer_with_CE" } {
     if { $used == true } {
		 set driver_used true  
	 } else {
		 set driver_used false  
	 }
	 }
     if { $matched == true && $driver_used == true } {
		 lappend list_full "$i" 
	 }
	 }
	 foreach i $list_full {
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
		 lappend list_freq "$out_freq" 
	 }

	set mm_bufgcediv [dict create]
	
    for {set v 0} {$v < [llength $list_full]} {incr v} {
      dict set mm_bufgcediv [lindex $list_full $v] [lindex $list_freq $v]
     } 
	 
	set mm_bufgcediv_sorted [sortDictByValue $mm_bufgcediv] 
	set mm_bufgcediv_clks [ lrange [dict keys $mm_bufgcediv_sorted] 0 3 ]
 # set for all clks in the list
foreach m $mm_bufgcediv_clks {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}

} 

} else {
#send_msg INFO 992 "non Auto"
	for {set i 1} {$i<8} {incr i} {
set  mmcm_bufgcediv$i false
set  drive_bufgcediv$i false
	}
	
	 for {set i 1} {$i<8} {incr i} {
     set buffer [get_param_value CLKOUT${i}_DRIVES]
     if { $buffer == "BUFGCE_DIV" } {
		 lappend list_bufgcediv "$i" 
	 }
	 }
	 
   set length_bufgcediv [llength $list_bufgcediv]
#send_msg INFO 666 "bufgce_div list :$list_bufgcediv"
#send_msg INFO 12119911 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
#send_msg INFO 12339922 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "
   
foreach m $list_bufgcediv {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}
#send_msg INFO 12119933 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
#send_msg INFO 12339944 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "

if { $length_bufgcediv < 4 } {

set length_diff [expr 3 - $length_bufgcediv]
#send_msg INFO 666999 "length_diff :$length_diff"
	for {set i 1} {$i<8} {incr i} {
    set matched [get_param_value CLKOUT${i}_MATCHED_ROUTING]
    set used [get_param_value CLKOUT${i}_USED]
    set driver [get_param_value CLKOUT${i}_DRIVES]
    set driver_used false
    if {$driver == "Buffer" || $driver == "Buffer_with_CE" } {
     if { $used == true } {
		 set driver_used true  
	 } else {
		 set driver_used false  
	 }
	 }
     if { $matched == true && $driver_used == true } {
		 lappend list_full "$i" 
	 }
	 }
	 foreach i $list_full {
     set out_freq [get_param_value CLKOUT${i}_REQUESTED_OUT_FREQ]
		 lappend list_freq "$out_freq" 
	 }

	set mm_bufgcediv [dict create]
#send_msg INFO 6669 "list_full :$list_full"
#send_msg INFO 66691 "list_freq :$list_freq"
    for {set v 0} {$v < [llength $list_full]} {incr v} {
      dict set mm_bufgcediv [lindex $list_full $v] [lindex $list_freq $v]
     } 
	 
	set mm_bufgcediv_sorted [sortDictByValue $mm_bufgcediv] 
	set mm_bufgcediv_clks [ lrange [dict keys $mm_bufgcediv_sorted] 0 $length_diff ]
#send_msg INFO 666933 "mm_bufgcediv_sorted :$mm_bufgcediv_sorted"
#send_msg INFO 6669133 "mm_bufgcediv_clks :$mm_bufgcediv_clks"
 # set for all clks in the list
#send_msg INFO 121199 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
#send_msg INFO 123399 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "
foreach m $mm_bufgcediv_clks {
set  mmcm_bufgcediv$m false
set  drive_bufgcediv$m true
}
}
#send_msg INFO 1211 "buffer :$drive_bufgcediv1 $drive_bufgcediv2 $drive_bufgcediv3 $drive_bufgcediv4 $drive_bufgcediv5 $drive_bufgcediv6 $drive_bufgcediv7 "
#send_msg INFO 1233 "derived :$mmcm_bufgcediv1 $mmcm_bufgcediv2 $mmcm_bufgcediv3 $mmcm_bufgcediv4 $mmcm_bufgcediv5 $mmcm_bufgcediv6 $mmcm_bufgcediv7 "
}
}
######
#proc update_MODELPARAM_VALUE.C_M_MAX {MODELPARAM_VALUE.C_M_MAX PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set m_max [get_index_next_value [get_metaparam_value speeds_file_data] "c_m_max"]
#  set_property value [setup_display_float $m_max] [set MODELPARAM_VALUE.C_M_MAX]
#}
#proc update_MODELPARAM_VALUE.C_M_MIN {MODELPARAM_VALUE.C_M_MIN PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set m_min [get_index_next_value [get_metaparam_value speeds_file_data] "c_m_min"]
#  set_property value [setup_display_float $m_min] [set MODELPARAM_VALUE.C_M_MIN]
#}
#proc update_MODELPARAM_VALUE.C_D_MAX {MODELPARAM_VALUE.C_D_MAX PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set d_max [get_index_next_value [get_metaparam_value speeds_file_data] "c_d_max"]
#  set_property value [setup_display_float $d_max] [set MODELPARAM_VALUE.C_D_MAX]
#}
#proc update_MODELPARAM_VALUE.C_D_MIN {MODELPARAM_VALUE.C_D_MIN PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set d_min [get_index_next_value [get_metaparam_value speeds_file_data] "c_d_min"]
#  set_property value [setup_display_float $d_min] [set MODELPARAM_VALUE.C_D_MIN]
#}
#proc update_MODELPARAM_VALUE.C_O_MAX {MODELPARAM_VALUE.C_O_MAX PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set o_max [get_index_next_value [get_metaparam_value speeds_file_data] "c_o_max"]
#  set_property value [setup_display_float $o_max] [set MODELPARAM_VALUE.C_O_MAX]
#}
#proc update_MODELPARAM_VALUE.C_O_MIN {MODELPARAM_VALUE.C_O_MIN PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set o_min [get_index_next_value [get_metaparam_value speeds_file_data] "c_o_min"]
#  set_property value [setup_display_float $o_min] [set MODELPARAM_VALUE.C_O_MIN]
#}
#proc update_MODELPARAM_VALUE.C_VCO_MIN {MODELPARAM_VALUE.C_VCO_MIN PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set list [get_metaparam_value speeds_file_data]
#  set min_vco [get_index_next_value $list c_min_vco_freq]
#  set_property value [setup_display_float $min_vco] [set MODELPARAM_VALUE.C_VCO_MIN]
#}
#proc update_MODELPARAM_VALUE.C_VCO_MAX {MODELPARAM_VALUE.C_VCO_MAX PARAM_VALUE.AUTO_PRIMITIVE} \
#{
#  set list [get_metaparam_value speeds_file_data]
#  set max_vco [get_index_next_value $list c_max_vco_freq]
#  set_property value [setup_display_float $max_vco] [set MODELPARAM_VALUE.C_VCO_MAX]
#}
#######


proc updateModel_C_CLKOUT0_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT1_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT1_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT0_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT1_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT2_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT2_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT1_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT2_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT3_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT3_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT2_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT3_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT4_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT4_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT3_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT4_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT5_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT5_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT4_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT5_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT6_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT6_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT5_ACTUAL_FREQ -of $IpView]
} 

proc updateModel_C_CLKOUT6_ACTUAL_FREQ {IpView} {
     pre_calculate $IpView
variable clk_wiz_v6_0_utils::text_CLKOUT7_ACTUAL_OUT_FREQ
   set_property modelparam_value $text_CLKOUT7_ACTUAL_OUT_FREQ [ipgui::get_modelparamspec C_CLKOUT6_ACTUAL_FREQ -of $IpView]
} 
proc updateModel_C_M_MAX {IpView} {
    variable clk_wiz_v6_0_utils::c_m_max
   set_property modelparam_value $c_m_max [ipgui::get_modelparamspec C_M_MAX -of $IpView]
} 
proc updateModel_C_M_MIN {IpView} {
    variable clk_wiz_v6_0_utils::c_m_min
   set_property modelparam_value $c_m_min [ipgui::get_modelparamspec C_M_MIN -of $IpView]
} 
proc updateModel_C_D_MAX {IpView} {
    variable clk_wiz_v6_0_utils::c_d_max
   set_property modelparam_value $c_d_max [ipgui::get_modelparamspec C_D_MAX -of $IpView]
} 
proc updateModel_C_D_MIN {IpView} {
    variable clk_wiz_v6_0_utils::c_d_min
   set_property modelparam_value $c_d_min [ipgui::get_modelparamspec C_D_MIN -of $IpView]
} 
proc updateModel_C_O_MAX {IpView} {
    variable clk_wiz_v6_0_utils::c_o_max
   set_property modelparam_value $c_o_max [ipgui::get_modelparamspec C_O_MAX -of $IpView]
} 
proc updateModel_C_O_MIN {IpView} {
    variable clk_wiz_v6_0_utils::c_o_min
   set_property modelparam_value $c_o_min [ipgui::get_modelparamspec C_O_MIN -of $IpView]
} 
proc updateModel_C_VCO_MIN {IpView} {
    variable clk_wiz_v6_0_utils::c_min_vco_freq
   set_property modelparam_value $c_min_vco_freq [ipgui::get_modelparamspec C_VCO_MIN -of $IpView]
} 
proc updateModel_C_VCO_MAX {IpView} {
    variable clk_wiz_v6_0_utils::c_max_vco_freq
   set_property modelparam_value $c_max_vco_freq [ipgui::get_modelparamspec C_VCO_MAX -of $IpView]
} 
