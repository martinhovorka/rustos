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
package require xilinx::board 1.0
namespace import ::xilinx::board::*

#Declare metaparams 
proc init_meta_params {IPINST} {
  ipgui::add_meta_param $IPINST -name "iic_vlnv" -type "string"
}

proc update_iic_vlnv {} {
  return "xilinx.com:interface:iic_rtl:1.0"
}

proc init_params {IPINST PARAM_VALUE.IIC_BOARD_INTERFACE} {
  set_property preset_proc "IIC_BOARD_INTERFACE_PREST" ${PARAM_VALUE.IIC_BOARD_INTERFACE}
}

proc IIC_BOARD_INTERFACE_PREST {IPINST PRESET_VALUE} {
  if { $PRESET_VALUE == "Custom" } {
    return ""
  }
  set board [::ipxit::get_project_property BOARD]
  set vlnv [get_property ipdef $IPINST] 
  set preset_params [board_ip_presets $vlnv $PRESET_VALUE $board "IIC"]
  if { $preset_params != "" } {
    return $preset_params
  } else {
    return ""
  }
}

#Definitional proc to organize widgets for parameters.
proc init_gui { IPINST PROJECT_PARAM.BOARD } {
  variable c_family
	set board ${PROJECT_PARAM.BOARD}
  
	#set_property ip_complexity "simple" [ipgui::get_canvasspec -of $IPINST]
	set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]
	############################################################################
    # Board Gui  
	add_board_tab $IPINST
  ############################################################################
	set Page0 [ ipgui::add_page $IPINST  -name "IP Configuration" -layout vertical]
	set tabgroup0 [ipgui::add_group $IPINST -parent $Page0 -name "IIC Parameters" -layout vertical]
	set IIC_FREQ_KHZ [ipgui::add_param $IPINST -parent $tabgroup0 -name IIC_FREQ_KHZ]
	set TEN_BIT_ADR [ipgui::add_param $IPINST -parent $tabgroup0 -name TEN_BIT_ADR -widget comboBox]
	set C_SCL_INERTIAL_DELAY [ipgui::add_param $IPINST -parent $tabgroup0 -name C_SCL_INERTIAL_DELAY ]
	set C_SDA_INERTIAL_DELAY [ipgui::add_param $IPINST -parent $tabgroup0 -name C_SDA_INERTIAL_DELAY ]
	set C_SDA_LEVEL [ipgui::add_param $IPINST -parent $tabgroup0 -name C_SDA_LEVEL -widget comboBox]
	#set AXI_ACLK_FREQ_MHZ [ipgui::add_param $IPINST -parent $Page0 -name AXI_ACLK_FREQ_MHZ ]
	set tabgroup1 [ipgui::add_group $IPINST -parent $Page0 -name "Other Parameters" -layout vertical]
	set AXI_ACLK_FREQ_MHZ [ipgui::add_param $IPINST -parent $tabgroup1 -name AXI_ACLK_FREQ_MHZ ]
	#set Page1 [ ipgui::add_page $IPINST  -name "Advanced" -layout vertical]
	#set C_GPO_WIDTH [ipgui::add_param $IPINST -parent $Page1 -name C_GPO_WIDTH ]
	set C_GPO_WIDTH [ipgui::add_param $IPINST -parent $tabgroup1 -name C_GPO_WIDTH ]
	set C_DEFAULT_VALUE [ipgui::add_param $IPINST -parent $tabgroup1 -name C_DEFAULT_VALUE ]
}

################################################################################
proc update_PARAM_VALUE.IIC_BOARD_INTERFACE {PARAM_VALUE.IIC_BOARD_INTERFACE PROJECT_PARAM.BOARD IPINST} {
	set param_range [get_board_interface_param_range $IPINST -name "IIC_BOARD_INTERFACE"]
	set_property range $param_range ${PARAM_VALUE.IIC_BOARD_INTERFACE}
}

#########################################################
### RSB related procs
##########################################################
#proc make_params_auto { IpView paramList } {
#   foreach param $paramList {
#      set paramhandle [ipgui::get_paramspec $param -of $IpView]
#      set dtext [get_property display_name $paramhandle]
#      #changing the display text
#      set_property display_name "$dtext (Auto)" $paramhandle
#      #disabling the parameter
#      #set_property visible false $paramhandle
#      #locking the parameter enablement, so that no drc enables it
#      set_property locked true $paramhandle
#   }
#} 
##proc init_xpg_bd { IpView } {
##   set params_to_mask "AXI_ACLK_FREQ_MHZ"
##   make_params_auto $IpView $params_to_mask
##}
#########################################################

# Procedure called to validate AXI_ACLK_FREQ_MHZ
proc validate_PARAM_VALUE.AXI_ACLK_FREQ_MHZ {PARAM_VALUE.AXI_ACLK_FREQ_MHZ PARAM_VALUE.IIC_FREQ_KHZ} {
  set value_clk_freq [get_property value ${PARAM_VALUE.IIC_FREQ_KHZ}]
  set val_clk_Khz [expr {$value_clk_freq*25} ];
  set axi_clk [get_property value ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ}] 
  set val_clk_Mhz [expr {$axi_clk*1000000} ]
  #CR-1096946 Added a tolerance of 0.1MHz
  set tolerance_Hz 100000

  if {$val_clk_Mhz < $val_clk_Khz} {
#AXI clock frequency must be at least 25 MHz and 25 times faster than the SCL clock frequency;
    set_property errmsg "AXI clock frequency must be at least 25 times faster than the SCL clock frequency" ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ}
    return false
  }
  if {[expr {$val_clk_Mhz+$tolerance_Hz}] < 25000000} {
#AXI clock frequency must be at least 25 MHz;
    set_property errmsg "AXI clock frequency must be at least 25 MHz" ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ} 
    return false
  }
  return true
}

proc validate_PARAM_VALUE.C_DEFAULT_VALUE { PARAM_VALUE.C_DEFAULT_VALUE} {
	set value [ get_property value ${PARAM_VALUE.C_DEFAULT_VALUE} ]
        set tmp [string match 0x* $value]
        set tmp1 [string length  $value]
        if {$tmp == 0 } {
                set_property errmsg "Please specify this value starting with 0x"  ${PARAM_VALUE.C_DEFAULT_VALUE} 
                return false
        } else {
        if {$tmp1 != 4 } {
                set_property errmsg "There should be 2 character after 0x" ${PARAM_VALUE.C_DEFAULT_VALUE}
                return false

        } else {
	if {$value < 0x00 || $value > 0xFF } {
		set_property errmsg "The value entered is out of range 0x00,0xFF"  ${PARAM_VALUE.C_DEFAULT_VALUE} 
		return false
	} else {
		return true
	}
        }
}
}

proc update_MODELPARAM_VALUE.C_IIC_FREQ {MODELPARAM_VALUE.C_IIC_FREQ PARAM_VALUE.IIC_FREQ_KHZ} {
	set value_clk_freq [get_property value ${PARAM_VALUE.IIC_FREQ_KHZ}]
	set val_clk_Mhz [expr {int ($value_clk_freq*1000)} ];
	#puts "INFO:: IIC Frequency $val_clk_Mhz\n";
	set_property value $val_clk_Mhz ${MODELPARAM_VALUE.C_IIC_FREQ} 
}

proc update_MODELPARAM_VALUE.C_TEN_BIT_ADR {MODELPARAM_VALUE.C_TEN_BIT_ADR PARAM_VALUE.TEN_BIT_ADR} {
  set ten_bit [get_property value ${PARAM_VALUE.TEN_BIT_ADR}] 
  if {$ten_bit == "10_bit"} {
    set_property value 1 ${MODELPARAM_VALUE.C_TEN_BIT_ADR} 
  } else {
    set_property value 0 ${MODELPARAM_VALUE.C_TEN_BIT_ADR} 
  }
}

proc update_MODELPARAM_VALUE.C_GPO_WIDTH {MODELPARAM_VALUE.C_GPO_WIDTH PARAM_VALUE.C_GPO_WIDTH} {
	set gpo [get_property value ${PARAM_VALUE.C_GPO_WIDTH}] 
  set_property value $gpo ${MODELPARAM_VALUE.C_GPO_WIDTH} 
}

proc update_PORT_VECTOR_LEFT.GPO { MODELPARAM_VALUE.C_GPO_WIDTH PORT_VECTOR_LEFT.GPO } {
	set gpo [get_property value ${MODELPARAM_VALUE.C_GPO_WIDTH}] 
  set_property value $gpo ${PORT_VECTOR_LEFT.GPO}
}

proc update_PORT_ENABLEMENT.GPO { MODELPARAM_VALUE.C_GPO_WIDTH PORT_ENABLEMENT.GPO } {
	set gpo [get_property value ${MODELPARAM_VALUE.C_GPO_WIDTH}] 
  set t true
  if { $gpo > 4 } {
    set t false 
  }
  set_property value $t ${PORT_ENABLEMENT.GPO}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ {MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ PARAM_VALUE.AXI_ACLK_FREQ_MHZ} {
	set axi_clk [get_property value ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ}]
	set val_clk_Mhz [expr {int($axi_clk*1000000)} ];
	#puts "clock value is $val_clk_Mhz";
	set_property value $val_clk_Mhz ${MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ} 
}

proc update_MODELPARAM_VALUE.C_SCL_INERTIAL_DELAY {MODELPARAM_VALUE.C_SCL_INERTIAL_DELAY PARAM_VALUE.C_SCL_INERTIAL_DELAY} {
  set scl [get_property value ${PARAM_VALUE.C_SCL_INERTIAL_DELAY}]
  set_property value $scl ${MODELPARAM_VALUE.C_SCL_INERTIAL_DELAY} 
}

proc update_MODELPARAM_VALUE.C_SDA_INERTIAL_DELAY {MODELPARAM_VALUE.C_SDA_INERTIAL_DELAY PARAM_VALUE.C_SDA_INERTIAL_DELAY} {
  set sda [get_property value ${PARAM_VALUE.C_SDA_INERTIAL_DELAY}]
  set_property value $sda ${MODELPARAM_VALUE.C_SDA_INERTIAL_DELAY}
}

proc update_MODELPARAM_VALUE.C_SDA_LEVEL {MODELPARAM_VALUE.C_SDA_LEVEL PARAM_VALUE.C_SDA_LEVEL} {
  set sda [get_property value ${PARAM_VALUE.C_SDA_LEVEL}]
  set_property value $sda ${MODELPARAM_VALUE.C_SDA_LEVEL} 
}

proc update_MODELPARAM_VALUE.C_DISABLE_SETUP_VIOLATION_CHECK {MODELPARAM_VALUE.C_DISABLE_SETUP_VIOLATION_CHECK PARAM_VALUE.C_DISABLE_SETUP_VIOLATION_CHECK} {
  set sda_setup [get_property value ${PARAM_VALUE.C_DISABLE_SETUP_VIOLATION_CHECK}]
  set_property value $sda_setup ${MODELPARAM_VALUE.C_DISABLE_SETUP_VIOLATION_CHECK} 
}

proc update_MODELPARAM_VALUE.C_STATIC_TIMING_REG_WIDTH {MODELPARAM_VALUE.C_STATIC_TIMING_REG_WIDTH PARAM_VALUE.C_STATIC_TIMING_REG_WIDTH} {
  set fix_width_en [get_property value ${PARAM_VALUE.C_STATIC_TIMING_REG_WIDTH}]
  set_property value $fix_width_en ${MODELPARAM_VALUE.C_STATIC_TIMING_REG_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_TIMING_REG_WIDTH {MODELPARAM_VALUE.C_TIMING_REG_WIDTH PARAM_VALUE.C_TIMING_REG_WIDTH} {
  set time_width [get_property value ${PARAM_VALUE.C_TIMING_REG_WIDTH}]
  set_property value $time_width ${MODELPARAM_VALUE.C_TIMING_REG_WIDTH} 
}
proc update_MODELPARAM_VALUE.C_DEFAULT_VALUE { MODELPARAM_VALUE.C_DEFAULT_VALUE PARAM_VALUE.C_DEFAULT_VALUE} {
	set_property value [ get_property value ${PARAM_VALUE.C_DEFAULT_VALUE} ]  ${MODELPARAM_VALUE.C_DEFAULT_VALUE} 
}
