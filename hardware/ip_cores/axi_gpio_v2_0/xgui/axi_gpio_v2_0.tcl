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

proc get_gpio_vlnv {} {
	return "xilinx.com:interface:gpio_rtl:1.0"
}

proc init_params {IPINST PARAM_VALUE.GPIO_BOARD_INTERFACE PARAM_VALUE.GPIO2_BOARD_INTERFACE} {
  set_property preset_proc "GPIO_BOARD_INTERFACE_PRESET" ${PARAM_VALUE.GPIO_BOARD_INTERFACE}
  set_property preset_proc "GPIO2_BOARD_INTERFACE_PRESET" ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}
}

proc GPIO_BOARD_INTERFACE_PRESET {IPINST PRESET_VALUE} {
  if { $PRESET_VALUE == "Custom" } {
    return ""
  }
  set board [::ipxit::get_project_property BOARD]
  set vlnv [get_property ipdef $IPINST] 
  set preset_params [board_ip_presets $vlnv $PRESET_VALUE $board "GPIO"]
  if { $preset_params != "" } {
    return $preset_params
  } else {
    return ""
  }
}
proc GPIO2_BOARD_INTERFACE_PRESET {IPINST PRESET_VALUE} {
  if { $PRESET_VALUE == "Custom" } {
    return ""
  }
  set board [::ipxit::get_project_property BOARD]
  set vlnv [get_property ipdef $IPINST] 
  set preset_params [board_ip_presets $vlnv $PRESET_VALUE $board "GPIO2"]
  if { $preset_params != "" } {
    return $preset_params
  } else {
    return ""
  }
}

#Definitional proc to organize widgets for parameters.
proc init_gui {IPINST PROJECT_PARAM.ARCHITECTURE PROJECT_PARAM.BOARD} {
	set c_family ${PROJECT_PARAM.ARCHITECTURE}
	set board ${PROJECT_PARAM.BOARD}
	set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST  -name Component_Name ]
	add_board_tab $IPINST

	set Page0 [ ipgui::add_page $IPINST  -name "IP Configuration" -layout vertical]
	set group1 [ ipgui::add_group $IPINST  -name "GPIO" -parent $Page0 -layout vertical]
	set C_IS_DUAL [ipgui::add_param $IPINST -parent $Page0 -name C_IS_DUAL -widget checkBox]
	set_property tooltip "Set this checkbox if dual channel GPIO is required" $C_IS_DUAL
	set group2 [ ipgui::add_group $IPINST  -name "GPIO 2" -parent $Page0 -layout vertical]
	set C_ALL_INPUTS [ipgui::add_param $IPINST -parent $group1 -name C_ALL_INPUTS -widget checkBox]
	set_property tooltip "Set this checkbox if only inputs are present" $C_ALL_INPUTS
	set C_ALL_INPUTS_2 [ipgui::add_param $IPINST -parent $group2 -name C_ALL_INPUTS_2 -widget checkBox]
	set_property tooltip "Set this checkbox if only inputs are present" $C_ALL_INPUTS_2

	set C_ALL_OUTPUTS [ipgui::add_param $IPINST -parent $group1 -name C_ALL_OUTPUTS -widget checkBox]
	set_property tooltip "Set this checkbox if only outputs are present" $C_ALL_OUTPUTS
	set C_ALL_OUTPUTS_2 [ipgui::add_param $IPINST -parent $group2 -name C_ALL_OUTPUTS_2 -widget checkBox]
	set_property tooltip "Set this checkbox if only outputs are present" $C_ALL_OUTPUTS_2

	set C_INTERRUPT_PRESENT [ipgui::add_param $IPINST -parent $IPINST -name C_INTERRUPT_PRESENT -widget checkBox]
	set_property tooltip "Set this checkbox if interrupt is included" $C_INTERRUPT_PRESENT
	
	set panel1 [ipgui::add_panel $IPINST -parent $group1 -name panel1 -layout horizontal]
	set panel2 [ipgui::add_panel $IPINST -parent $group2 -name panel2 -layout horizontal]
	set C_GPIO_WIDTH [ipgui::add_param $IPINST -parent $panel1 -name C_GPIO_WIDTH]
	set_property tooltip "Set the GPIO port width" $C_GPIO_WIDTH
	set C_GPIO2_WIDTH [ipgui::add_param $IPINST -parent $panel2 -name C_GPIO2_WIDTH]
	set_property tooltip "Set the GPIO port width" $C_GPIO2_WIDTH
	ipgui::add_row $IPINST -parent $panel1 
	ipgui::add_row $IPINST -parent $panel2 
	set C_DOUT_DEFAULT [ipgui::add_param $IPINST -parent $panel1 -name C_DOUT_DEFAULT]
	set_property tooltip "Default Output values" $C_DOUT_DEFAULT
	ipgui::add_static_text $IPINST -name line_rate_units -parent $panel1 -text "[0x00000000,0xFFFFFFFF]"

	set C_DOUT_DEFAULT_2 [ipgui::add_param $IPINST -parent $panel2 -name C_DOUT_DEFAULT_2]
	set_property tooltip "Default Output values" $C_DOUT_DEFAULT_2
	ipgui::add_static_text $IPINST -name line_rate_units -parent $panel2 -text "[0x00000000,0xFFFFFFFF]"
	 
	ipgui::add_row $IPINST -parent $panel1 
	ipgui::add_row $IPINST -parent $panel2 
	set C_TRI_DEFAULT [ipgui::add_param $IPINST -parent $panel1 -name C_TRI_DEFAULT]
	set_property tooltip "Default tri-state values" $C_TRI_DEFAULT
	ipgui::add_static_text $IPINST -name line_rate_units -parent $panel1 -text "[0x00000000,0xFFFFFFFF]"

	set C_TRI_DEFAULT_2 [ipgui::add_param $IPINST -parent $panel2 -name C_TRI_DEFAULT_2]
	set_property tooltip "Default tri-state values" $C_TRI_DEFAULT_2
	ipgui::add_static_text $IPINST -name line_rate_units -parent $panel2 -text "[0x00000000,0xFFFFFFFF]"
}

proc update_PARAM_VALUE.GPIO_BOARD_INTERFACE {IPINST PARAM_VALUE.GPIO_BOARD_INTERFACE PROJECT_PARAM.BOARD} {
	set param_range [get_board_interface_param_range $IPINST -name "GPIO_BOARD_INTERFACE"]
	set_property range $param_range ${PARAM_VALUE.GPIO_BOARD_INTERFACE}
}

proc update_PARAM_VALUE.GPIO2_BOARD_INTERFACE {IPINST PARAM_VALUE.GPIO2_BOARD_INTERFACE PROJECT_PARAM.BOARD} {
	set param_range [get_board_interface_param_range $IPINST -name "GPIO2_BOARD_INTERFACE"]
	set_property range $param_range ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}
}

proc update_PARAM_VALUE.C_IS_DUAL {PARAM_VALUE.C_IS_DUAL PARAM_VALUE.GPIO2_BOARD_INTERFACE PROJECT_PARAM.BOARD} {
        set boardIfName [get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		set_property value 1 ${PARAM_VALUE.C_IS_DUAL} 
		set_property enabled false ${PARAM_VALUE.C_IS_DUAL}
	} else {
		set_property enabled true ${PARAM_VALUE.C_IS_DUAL}
	}
}
###############################################################################

proc update_PARAM_VALUE.C_ALL_OUTPUTS {PARAM_VALUE.C_ALL_OUTPUTS PARAM_VALUE.GPIO_BOARD_INTERFACE PARAM_VALUE.C_ALL_INPUTS PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		set_property enabled false ${PARAM_VALUE.C_ALL_OUTPUTS}
		set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq "" && $tri_i ne "" } {
            set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS}
		} elseif { $tri_o ne "" && $tri_i eq "" } {
            set_property value 1 ${PARAM_VALUE.C_ALL_OUTPUTS}
		} else {
			set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS}
		}

	} else {
		set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS}]
		if { $all_inputs == 1 } {
			set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS}
			set_property enabled false ${PARAM_VALUE.C_ALL_OUTPUTS}
		} else {
			set_property enabled true ${PARAM_VALUE.C_ALL_OUTPUTS}
		}
	} 
}


proc update_PARAM_VALUE.C_ALL_INPUTS {PARAM_VALUE.C_ALL_INPUTS PARAM_VALUE.GPIO_BOARD_INTERFACE PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		set_property enabled false ${PARAM_VALUE.C_ALL_INPUTS}
		set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq "" && $tri_i ne "" } {
			set_property value 1 ${PARAM_VALUE.C_ALL_INPUTS}
		} elseif { $tri_o ne "" && $tri_i eq "" } {
			set_property value 0 ${PARAM_VALUE.C_ALL_INPUTS}
		} else {
			set_property value 0 ${PARAM_VALUE.C_ALL_INPUTS}
		}
         } else {
	   set_property enabled true ${PARAM_VALUE.C_ALL_INPUTS}
	} 
}


proc update_PARAM_VALUE.C_GPIO_WIDTH {PARAM_VALUE.C_GPIO_WIDTH PARAM_VALUE.GPIO_BOARD_INTERFACE  PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
	   	set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq "" && $tri_i ne "" } {
			set port_width [get_width_of_intf_port $boardIfName TRI_I]
			set_property value $port_width ${PARAM_VALUE.C_GPIO_WIDTH}
		} elseif { $tri_o ne "" && $tri_i eq "" } {
			set port_width [get_width_of_intf_port $boardIfName TRI_O]
			set_property value $port_width ${PARAM_VALUE.C_GPIO_WIDTH}
		} else {
			set port_width [get_width_of_intf_port $boardIfName TRI_O]
			set_property value $port_width ${PARAM_VALUE.C_GPIO_WIDTH}
		}	
	   set_property enabled false ${PARAM_VALUE.C_GPIO_WIDTH}
	} else {
	   set_property enabled true ${PARAM_VALUE.C_GPIO_WIDTH}
	}
}

proc update_PARAM_VALUE.C_ALL_INPUTS_2 {PARAM_VALUE.C_ALL_INPUTS_2 PARAM_VALUE.GPIO2_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL   PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		set_property enabled false ${PARAM_VALUE.C_ALL_INPUTS_2}
		set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq ""  && $tri_i ne "" } {
			  set_property value 1 ${PARAM_VALUE.C_ALL_INPUTS_2}
		} elseif { $tri_o ne ""  && $tri_i eq "" } {
			  set_property value 0 ${PARAM_VALUE.C_ALL_INPUTS_2}
		} else {
		  set_property value 0 ${PARAM_VALUE.C_ALL_INPUTS_2}
		}
	} else {
		set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
		if { $dual } {
		   set_property enabled true ${PARAM_VALUE.C_ALL_INPUTS_2}
		} else {
		   set_property enabled false ${PARAM_VALUE.C_ALL_INPUTS_2}
		}
	} 
}

proc update_PARAM_VALUE.C_ALL_OUTPUTS_2 {PARAM_VALUE.C_ALL_OUTPUTS_2 PARAM_VALUE.GPIO2_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL PARAM_VALUE.C_ALL_INPUTS_2  PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		set_property enabled false ${PARAM_VALUE.C_ALL_OUTPUTS_2}
		set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq ""  && $tri_i ne "" } {
			set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS_2}
		} elseif { $tri_o ne ""  && $tri_i eq "" } {
			set_property value 1 ${PARAM_VALUE.C_ALL_OUTPUTS_2}
		} else {
			set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS_2}
		}
	} else {
		set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
		if { $dual } {
			set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS_2}]
			if { $all_inputs == 1} {
				set_property value 0 ${PARAM_VALUE.C_ALL_OUTPUTS_2}
				set_property enabled false ${PARAM_VALUE.C_ALL_OUTPUTS_2}
			} else {
				set_property enabled true ${PARAM_VALUE.C_ALL_OUTPUTS_2}
			} 
		} else {
			set_property enabled false ${PARAM_VALUE.C_ALL_OUTPUTS_2}
		}
	}
}


proc update_PARAM_VALUE.C_GPIO2_WIDTH {PARAM_VALUE.C_GPIO2_WIDTH PARAM_VALUE.GPIO2_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL PROJECT_PARAM.BOARD} {
	set boardIfName [get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}]
	if { $boardIfName ne "Custom"} {
		 #  set_property enabled false ${PARAM_VALUE.C_GPIO2_WIDTH}
		 set_property enabled true ${PARAM_VALUE.C_GPIO2_WIDTH}
		set tri_o [get_board_part_pins_of_intf_port $boardIfName TRI_O] 
		set tri_i [get_board_part_pins_of_intf_port $boardIfName TRI_I] 
		if { $tri_o eq ""  && $tri_i ne "" } {
			set port_width [get_width_of_intf_port $boardIfName TRI_I]
		set_property value $port_width ${PARAM_VALUE.C_GPIO2_WIDTH}
		} elseif { $tri_o ne ""  && $tri_i eq "" } {
			set port_width [get_width_of_intf_port $boardIfName TRI_O]
			set_property value $port_width ${PARAM_VALUE.C_GPIO2_WIDTH}
		} else {
			set port_width [get_width_of_intf_port $boardIfName TRI_O]
			set_property value $port_width ${PARAM_VALUE.C_GPIO2_WIDTH}
		} 
		set_property enabled false ${PARAM_VALUE.C_GPIO2_WIDTH}
	} else {
		set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
		if { $dual } {
		   set_property enabled true ${PARAM_VALUE.C_GPIO2_WIDTH}
		} else {
		   set_property enabled false ${PARAM_VALUE.C_GPIO2_WIDTH}
		} 
	}
}

proc update_PARAM_VALUE.C_DOUT_DEFAULT_2 {PARAM_VALUE.C_DOUT_DEFAULT_2 PARAM_VALUE.C_IS_DUAL PARAM_VALUE.C_ALL_INPUTS_2 PARAM_VALUE.C_ALL_OUTPUTS_2 } {
	set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
	set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS_2}]
	set all_outputs [get_property value ${PARAM_VALUE.C_ALL_OUTPUTS_2}]
    if { $dual } {
		if { $all_inputs == 1 } {
			set_property enabled false ${PARAM_VALUE.C_DOUT_DEFAULT_2}
		} else {
			set_property enabled true ${PARAM_VALUE.C_DOUT_DEFAULT_2}
		}
    } else {
    	set_property enabled false ${PARAM_VALUE.C_DOUT_DEFAULT_2}
    }
}

proc update_PARAM_VALUE.C_TRI_DEFAULT_2 {PARAM_VALUE.C_TRI_DEFAULT_2 PARAM_VALUE.C_IS_DUAL PARAM_VALUE.C_ALL_INPUTS_2 PARAM_VALUE.C_ALL_OUTPUTS_2 } {
	set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
	set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS_2}]
	set all_outputs [get_property value ${PARAM_VALUE.C_ALL_OUTPUTS_2}]
    if { $dual } {
		if { $all_inputs == 1 || $all_outputs == 1} {
			set_property enabled false ${PARAM_VALUE.C_TRI_DEFAULT_2}
		} else {
			set_property enabled true ${PARAM_VALUE.C_TRI_DEFAULT_2}
		} 
    } else {
    	set_property enabled false ${PARAM_VALUE.C_TRI_DEFAULT_2}
    }
}

# proc update_PARAM_VALUE.GPIO2_BOARD_INTERFACE {PARAM_VALUE.GPIO2_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL PARAM_VALUE.USE_BOARD_FLOW } {
	# set dual [get_property value ${PARAM_VALUE.C_IS_DUAL}]
    # if { $dual } {
        # set enableBoardFlow [get_property value ${PARAM_VALUE.USE_BOARD_FLOW}]
        # if {$enableBoardFlow == true } {
            # catch { set_property enabled true ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}}
        # }
    # } else {
        # catch { set_property enabled false ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}}
		# catch { set_property value "Custom"  ${PARAM_VALUE.GPIO2_BOARD_INTERFACE}}
    # }
# }

proc update_PARAM_VALUE.C_DOUT_DEFAULT {PARAM_VALUE.C_DOUT_DEFAULT PARAM_VALUE.C_ALL_INPUTS  PARAM_VALUE.C_ALL_OUTPUTS  } {
	set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS}]
	set all_outputs [get_property value ${PARAM_VALUE.C_ALL_OUTPUTS}]
    if { $all_inputs == 1 } {
		set_property enabled false ${PARAM_VALUE.C_DOUT_DEFAULT}
    } else {
    	set_property enabled true ${PARAM_VALUE.C_DOUT_DEFAULT}
    }
}

proc update_PARAM_VALUE.C_TRI_DEFAULT {PARAM_VALUE.C_TRI_DEFAULT PARAM_VALUE.C_ALL_OUTPUTS PARAM_VALUE.C_ALL_INPUTS  } {
	set all_inputs [get_property value ${PARAM_VALUE.C_ALL_INPUTS}]
	set all_outputs [get_property value ${PARAM_VALUE.C_ALL_OUTPUTS}]
    if { $all_inputs == 1 || $all_outputs == 1} {
		set_property enabled false ${PARAM_VALUE.C_TRI_DEFAULT}
    } else {
    	set_property enabled true ${PARAM_VALUE.C_TRI_DEFAULT}
    }
}


proc validate_PARAM_VALUE.GPIO2_BOARD_INTERFACE { PARAM_VALUE.GPIO2_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL   
  PARAM_VALUE.GPIO_BOARD_INTERFACE PARAM_VALUE.USE_BOARD_FLOW IPINST PROJECT_PARAM.BOARD} {
	set gpio_vlnv [get_gpio_vlnv]
	set dual [ get_property value ${PARAM_VALUE.C_IS_DUAL} ]
	set intf2 [ get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE} ]
	set intf [ get_property value ${PARAM_VALUE.GPIO_BOARD_INTERFACE} ]
	set board ${PROJECT_PARAM.BOARD}
	if {$dual==1 && ($intf==$intf2) && ($intf2 ne "Custom")} {
		set_property errmsg "Board Interfaces cannot be same for both the channels."  ${PARAM_VALUE.GPIO2_BOARD_INTERFACE} 
		return false
	} else {
		return true
	}
}

proc validate_PARAM_VALUE.C_TRI_DEFAULT { PARAM_VALUE.C_TRI_DEFAULT} {
	set value [ get_property value ${PARAM_VALUE.C_TRI_DEFAULT} ]
        set tmp [string match 0x* $value]
        set tmp1 [string length  $value]
        if {$tmp == 0 } {
                set_property errmsg "Please specify this value starting with 0x" ${PARAM_VALUE.C_TRI_DEFAULT}
                return false
        } else {
        if {$tmp1 != 10 } {
                set_property errmsg "There should be 8 character after 0x" ${PARAM_VALUE.C_TRI_DEFAULT}
                return false

        } else {
	if {$value < 0x00000000 || $value > 0xFFFFFFFF } {
		set_property errmsg "The value entered is out of range 0x00000000,0xFFFFFFFF"  ${PARAM_VALUE.C_TRI_DEFAULT} 
		return false
	} else {
		return true
	}
        }
}
}

proc validate_PARAM_VALUE.C_DOUT_DEFAULT { PARAM_VALUE.C_DOUT_DEFAULT} {
	set value [ get_property value ${PARAM_VALUE.C_DOUT_DEFAULT} ]
        set tmp [string match 0x* $value]
        set tmp1 [string length  $value]
        if {$tmp == 0 } {
                set_property errmsg "Please specify this value starting with 0x"  ${PARAM_VALUE.C_DOUT_DEFAULT} 
                return false
        } else {
        if {$tmp1 != 10 } {
                set_property errmsg "There should be 8 character after 0x" ${PARAM_VALUE.C_DOUT_DEFAULT}
                return false

        } else {
	if {$value < 0x00000000 || $value > 0xFFFFFFFF } {
		set_property errmsg "The value entered is out of range 0x00000000,0xFFFFFFFF"  ${PARAM_VALUE.C_DOUT_DEFAULT} 
		return false
	} else {
		return true
	}
        }
}
}

proc validate_PARAM_VALUE.C_TRI_DEFAULT_2 { PARAM_VALUE.C_TRI_DEFAULT_2} {
	set value [ get_property value ${PARAM_VALUE.C_TRI_DEFAULT_2} ]
        set tmp [string match 0x* $value]
        set tmp1 [string length  $value]
        if {$tmp == 0 } {
                set_property errmsg "Please specify this value starting with 0x"  ${PARAM_VALUE.C_TRI_DEFAULT_2}
                return false
        } else {
        if {$tmp1 != 10 } {
                set_property errmsg "There should be 8 character after 0x" ${PARAM_VALUE.C_TRI_DEFAULT_2}
                return false

        } else {
	if {$value < 0x00000000 || $value > 0xFFFFFFFF } {
		set_property errmsg "The value entered is out of range 0x00000000,0xFFFFFFFF"  ${PARAM_VALUE.C_TRI_DEFAULT_2} 
		return false
	} else {
		return true
	}
	return true
        }
}
}

proc validate_PARAM_VALUE.C_DOUT_DEFAULT_2 { PARAM_VALUE.C_DOUT_DEFAULT_2} {
	set value [ get_property value ${PARAM_VALUE.C_DOUT_DEFAULT_2} ]
        set tmp [string match 0x* $value]
        set tmp1 [string length  $value]
        if {$tmp == 0 } {
                set_property errmsg "Please specify this value starting with 0x"  ${PARAM_VALUE.C_DOUT_DEFAULT_2}
                return false
        } else {
        if {$tmp1 != 10 } {
                set_property errmsg "There should be 8 character after 0x" ${PARAM_VALUE.C_DOUT_DEFAULT_2}
                return false

        } else {
	if {$value < 0x00000000 || $value > 0xFFFFFFFF } {
		set_property errmsg "The value entered is out of range 0x00000000,0xFFFFFFFF"  ${PARAM_VALUE.C_DOUT_DEFAULT_2} 
		return false
	} else {
		return true
	}
        }
}
}

proc validate_PARAM_VALUE.GPIO_BOARD_INTERFACE { PARAM_VALUE.GPIO_BOARD_INTERFACE PARAM_VALUE.C_IS_DUAL PARAM_VALUE.GPIO2_BOARD_INTERFACE  
   PARAM_VALUE.USE_BOARD_FLOW IPINST PROJECT_PARAM.BOARD} {
	set gpio_vlnv [get_gpio_vlnv]
	set dual [ get_property value ${PARAM_VALUE.C_IS_DUAL} ]
	set intf2 [ get_property value ${PARAM_VALUE.GPIO2_BOARD_INTERFACE} ]
	set intf [ get_property value ${PARAM_VALUE.GPIO_BOARD_INTERFACE} ]
	set board ${PROJECT_PARAM.BOARD}
	if {$dual==1 && ($intf==$intf2) && ($intf ne "Custom")} {
		set_property errmsg "Board Interfaces cannot be same for both the channels."  ${PARAM_VALUE.GPIO_BOARD_INTERFACE} 
		return false
	} else {
		return true
	}
}

proc update_MODELPARAM_VALUE.C_TRI_DEFAULT { MODELPARAM_VALUE.C_TRI_DEFAULT PARAM_VALUE.C_TRI_DEFAULT} {
	set_property value [ get_property value ${PARAM_VALUE.C_TRI_DEFAULT} ]  ${MODELPARAM_VALUE.C_TRI_DEFAULT} 
}

proc update_MODELPARAM_VALUE.C_ALL_INPUTS_2 { MODELPARAM_VALUE.C_ALL_INPUTS_2 PARAM_VALUE.C_ALL_INPUTS_2} {
	set_property value [ get_property value ${PARAM_VALUE.C_ALL_INPUTS_2} ]  ${MODELPARAM_VALUE.C_ALL_INPUTS_2} 
}

proc update_MODELPARAM_VALUE.C_ALL_OUTPUTS { MODELPARAM_VALUE.C_ALL_OUTPUTS PARAM_VALUE.C_ALL_OUTPUTS} {
	set_property value [ get_property value ${PARAM_VALUE.C_ALL_OUTPUTS} ]  ${MODELPARAM_VALUE.C_ALL_OUTPUTS} 
}

proc update_MODELPARAM_VALUE.C_IS_DUAL { MODELPARAM_VALUE.C_IS_DUAL PARAM_VALUE.C_IS_DUAL} {
	set_property value [ get_property value ${PARAM_VALUE.C_IS_DUAL} ]  ${MODELPARAM_VALUE.C_IS_DUAL} 
}

proc update_MODELPARAM_VALUE.C_DOUT_DEFAULT_2 { MODELPARAM_VALUE.C_DOUT_DEFAULT_2 PARAM_VALUE.C_DOUT_DEFAULT_2} {
	set_property value [ get_property value ${PARAM_VALUE.C_DOUT_DEFAULT_2} ]  ${MODELPARAM_VALUE.C_DOUT_DEFAULT_2} 
}

proc update_MODELPARAM_VALUE.C_FAMILY { MODELPARAM_VALUE.C_FAMILY PROJECT_PARAM.ARCHITECTURE} {
	set_property value [string tolower ${PROJECT_PARAM.ARCHITECTURE}]  ${MODELPARAM_VALUE.C_FAMILY} 
}

proc update_MODELPARAM_VALUE.C_ALL_INPUTS { MODELPARAM_VALUE.C_ALL_INPUTS PARAM_VALUE.C_ALL_INPUTS} {
	set_property value [ get_property value ${PARAM_VALUE.C_ALL_INPUTS} ]  ${MODELPARAM_VALUE.C_ALL_INPUTS} 
}

proc update_MODELPARAM_VALUE.C_TRI_DEFAULT_2 { MODELPARAM_VALUE.C_TRI_DEFAULT_2 PARAM_VALUE.C_TRI_DEFAULT_2} {
	set_property value [ get_property value ${PARAM_VALUE.C_TRI_DEFAULT_2} ]  ${MODELPARAM_VALUE.C_TRI_DEFAULT_2} 
}

proc update_MODELPARAM_VALUE.C_ALL_OUTPUTS_2 { MODELPARAM_VALUE.C_ALL_OUTPUTS_2 PARAM_VALUE.C_ALL_OUTPUTS_2} {
	set_property value [ get_property value ${PARAM_VALUE.C_ALL_OUTPUTS_2} ]  ${MODELPARAM_VALUE.C_ALL_OUTPUTS_2} 
}

proc update_MODELPARAM_VALUE.C_INTERRUPT_PRESENT { MODELPARAM_VALUE.C_INTERRUPT_PRESENT PARAM_VALUE.C_INTERRUPT_PRESENT} {
	set_property value [ get_property value ${PARAM_VALUE.C_INTERRUPT_PRESENT} ]  ${MODELPARAM_VALUE.C_INTERRUPT_PRESENT} 
}

proc update_MODELPARAM_VALUE.C_GPIO_WIDTH { MODELPARAM_VALUE.C_GPIO_WIDTH PARAM_VALUE.C_GPIO_WIDTH} {
	set_property value [ get_property value ${PARAM_VALUE.C_GPIO_WIDTH} ]  ${MODELPARAM_VALUE.C_GPIO_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_GPIO2_WIDTH { MODELPARAM_VALUE.C_GPIO2_WIDTH PARAM_VALUE.C_GPIO2_WIDTH} {
	set_property value [ get_property value ${PARAM_VALUE.C_GPIO2_WIDTH} ]  ${MODELPARAM_VALUE.C_GPIO2_WIDTH} 
}

proc update_MODELPARAM_VALUE.C_DOUT_DEFAULT { MODELPARAM_VALUE.C_DOUT_DEFAULT PARAM_VALUE.C_DOUT_DEFAULT} {
	set_property value [ get_property value ${PARAM_VALUE.C_DOUT_DEFAULT} ]  ${MODELPARAM_VALUE.C_DOUT_DEFAULT} 
}
