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

#Loading additional proc with user specified bodies to compute parameter values.
#source [file join [file dirname [file dirname [info script] ]] gui/axi_timebase_wdt_v3_0.gtcl ]
set c_family [string tolower [get_project_property ARCHITECTURE]]
#Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
        variable c_family
	#set_property ip_complexity "simple" [ipgui::get_canvasspec -of $IPINST]
	set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]
	set Page0 [ ipgui::add_page $IPINST  -name "Page0" -layout vertical]
	set C_WDT_INTERVAL [ipgui::add_param $IPINST -parent $Page0 -name C_WDT_INTERVAL ]
        set_property tooltip {WDT interval = 2^C_WDT_INTERVAL X Tclk} $C_WDT_INTERVAL
	set WDT_ENABLE_ONCE [ipgui::add_param $IPINST -parent $Page0 -name WDT_ENABLE_ONCE -widget comboBox -layout horizontal]
        set_property tooltip {WDT can be repeatedly enabled and disabled via software/WDT can only be enabled once(no disable possible after initial enable)} $WDT_ENABLE_ONCE
	set ENABLE_WINDOW_WDT [ipgui::add_param $IPINST -parent $Page0 -name ENABLE_WINDOW_WDT -widget checkBox]
        set_property tooltip {Enabling the window watchdog timer provides two adjustable window periods called First window time followed by another period called Second window time} $ENABLE_WINDOW_WDT
	set MAX_COUNT_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name MAX_COUNT_WIDTH]
        set_property tooltip {Maximum width of first Timer} $MAX_COUNT_WIDTH
	set SST_COUNT_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name SST_COUNT_WIDTH ]
        ##set_property tooltip {Width of second sequence Timer should be less than or equal to Maximum count width} $SST_COUNT_WIDTH
        set_property tooltip {Width of Second Sequence Timer (SST) ,once SST is enabled wdt_reset will be generated after its expiry } $SST_COUNT_WIDTH
}

# Procedure called when WDT_INTERVAL is updated
proc update_gui_for_PARAM_VALUE.ENABLE_WINDOW_WDT {IPINST PARAM_VALUE.ENABLE_WINDOW_WDT PARAM_VALUE.C_WDT_INTERVAL PARAM_VALUE.MAX_COUNT_WIDTH PARAM_VALUE.SST_COUNT_WIDTH PARAM_VALUE.WDT_ENABLE_ONCE } {
	set window  [get_property value ${PARAM_VALUE.ENABLE_WINDOW_WDT}]
    if {$window == 1} {
      set_property visible false [ipgui::get_guiparamspec C_WDT_INTERVAL -of $IPINST ]
      set_property visible false [ipgui::get_guiparamspec WDT_ENABLE_ONCE -of $IPINST ]
      ##set_property visible true [ipgui::get_guiparamspec MAX_COUNT_WIDTH -of $IPINST ]
      set_property visible false [ipgui::get_guiparamspec MAX_COUNT_WIDTH -of $IPINST ]
      set_property visible true [ipgui::get_guiparamspec SST_COUNT_WIDTH -of $IPINST ]
    } else {
      set_property visible true [ipgui::get_guiparamspec C_WDT_INTERVAL -of $IPINST ]
      set_property visible true [ipgui::get_guiparamspec WDT_ENABLE_ONCE -of $IPINST ]
      set_property visible false [ipgui::get_guiparamspec MAX_COUNT_WIDTH -of $IPINST ]
      set_property visible false [ipgui::get_guiparamspec SST_COUNT_WIDTH -of $IPINST ]
    }
}


proc update_PARAM_VALUE.SST_COUNT_WIDTH { PARAM_VALUE.SST_COUNT_WIDTH PARAM_VALUE.MAX_COUNT_WIDTH } {
#update_debug C_EN_AXI_DEBUG C_EN_LAST_WRITE_FLAG 0
set debug [get_property value ${PARAM_VALUE.MAX_COUNT_WIDTH}]
set_property range "8,$debug" ${PARAM_VALUE.SST_COUNT_WIDTH}
	return true
}



# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

proc update_MODELPARAM_VALUE.C_FAMILY { MODELPARAM_VALUE.C_FAMILY} {

variable c_family
set_property value $c_family  ${MODELPARAM_VALUE.C_FAMILY} 
	return true

}

proc update_MODELPARAM_VALUE.C_WDT_INTERVAL { MODELPARAM_VALUE.C_WDT_INTERVAL PARAM_VALUE.C_WDT_INTERVAL} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.C_WDT_INTERVAL} ]  ${MODELPARAM_VALUE.C_WDT_INTERVAL} 

	return true

}

proc update_MODELPARAM_VALUE.C_MAX_COUNT_WIDTH { MODELPARAM_VALUE.C_MAX_COUNT_WIDTH PARAM_VALUE.MAX_COUNT_WIDTH} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.MAX_COUNT_WIDTH} ]  ${MODELPARAM_VALUE.C_MAX_COUNT_WIDTH} 

	return true

}


proc update_MODELPARAM_VALUE.C_SST_COUNT_WIDTH { MODELPARAM_VALUE.C_SST_COUNT_WIDTH PARAM_VALUE.SST_COUNT_WIDTH} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.SST_COUNT_WIDTH} ]  ${MODELPARAM_VALUE.C_SST_COUNT_WIDTH} 

	return true

}

proc update_MODELPARAM_VALUE.C_ENABLE_WINDOW_WDT { MODELPARAM_VALUE.C_ENABLE_WINDOW_WDT PARAM_VALUE.ENABLE_WINDOW_WDT} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.ENABLE_WINDOW_WDT} ]  ${MODELPARAM_VALUE.C_ENABLE_WINDOW_WDT} 

	return true

}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.ENABLE_WINDOW_WDT} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
   set val [get_property value  ${PARAM_VALUE.ENABLE_WINDOW_WDT} ]
    if {$val == 0} {
   set add 4
   } else {
   set add 6
   }
	set_property value $add ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH} 
   
}

proc update_MODELPARAM_VALUE.C_WDT_ENABLE_ONCE { MODELPARAM_VALUE.C_WDT_ENABLE_ONCE PARAM_VALUE.WDT_ENABLE_ONCE} {

	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
       set enable [get_property value  ${PARAM_VALUE.WDT_ENABLE_ONCE} ]
       if {$enable == "Enable_repeatedly" } {
       set value 0
       }
       if {$enable == "Enable_only_once" } {
       set value 1
       }

	set_property value $value ${MODELPARAM_VALUE.C_WDT_ENABLE_ONCE} 

	return true

}



