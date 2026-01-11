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
set mii_vlnv "xilinx.com:interface:mii_rtl:1.0"
set mdio_vlnv "xilinx.com:interface:mdio_rtl:1.0"
 set c_family [string tolower [get_project_property ARCHITECTURE]]

#Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
     #   variable c_family
	# set_property ip_complexity "simple" [ipgui::get_canvasspec -of $IPINST]
	set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]
    ###############################################################################################
    # BDM Demo  
    add_board_tab $IPINST
    ###############################################################################################
	set Page0 [ ipgui::add_page $IPINST  -name "IP Configuration" -layout vertical]
        set tabgroup1 [ipgui::add_group $IPINST -parent $Page0 -name {AXI Interface Parameters} -layout vertical] 
        set C_S_AXI_PROTOCOL [ipgui::add_param $IPINST -parent $tabgroup1 -name C_S_AXI_PROTOCOL -widget comboBox -layout horizontal]
	set_property display_name "AXI Interface Parameters" $tabgroup1
	set AXI_ACLK_FREQ_MHZ [ipgui::add_param $IPINST -parent $tabgroup1 -widget spinBox -name AXI_ACLK_FREQ_MHZ]
	set tabgroup2 [ipgui::add_group $IPINST -parent $Page0 -name {Ethernet Lite MAC Parameters} -layout vertical] 
	set C_DUPLEX [ipgui::add_param $IPINST -parent $tabgroup2 -name C_DUPLEX -widget comboBox -layout horizontal]
	set C_TX_PING_PONG [ipgui::add_param $IPINST -parent $tabgroup2 -name C_TX_PING_PONG -widget comboBox -layout horizontal]
	set C_RX_PING_PONG [ipgui::add_param $IPINST -parent $tabgroup2 -name C_RX_PING_PONG -widget comboBox -layout horizontal]
	set C_INCLUDE_INTERNAL_LOOPBACK [ipgui::add_param $IPINST -parent $tabgroup2 -name C_INCLUDE_INTERNAL_LOOPBACK -widget checkBox]
	set C_INCLUDE_GLOBAL_BUFFERS [ipgui::add_param $IPINST -parent $tabgroup2 -name C_INCLUDE_GLOBAL_BUFFERS -widget checkBox]
        set C_INCLUDE_MDIO [ipgui::add_param $IPINST -parent $tabgroup2 -name C_INCLUDE_MDIO -widget checkBox]

 set C_S_AXI_ID_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S_AXI_ID_WIDTH]
 set C_USE_INTERNAL [ipgui::add_param $IPINST -parent $Page0 -name C_USE_INTERNAL]
 set C_SELECT_XPM [ipgui::add_param $IPINST -name C_SELECT_XPM -parent $Page0]


	#set C_S_AXI_ID_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S_AXI_ID_WIDTH]
	#set C_S_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S_AXI_DATA_WIDTH]
	#set C_S_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_S_AXI_ADDR_WIDTH]
   #set_propert value 1 $C_INCLUDE_GLOBAL_BUFFERS
   #set_propert visible false $C_INCLUDE_GLOBAL_BUFFERS
   set_property visible false $C_USE_INTERNAL
   set_property visible false $C_SELECT_XPM
   
}

################################################################################
proc update_PARAM_VALUE.MII_BOARD_INTERFACE { PARAM_VALUE.MII_BOARD_INTERFACE IPINST PROJECT_PARAM.BOARD} {
	set param_range [get_board_interface_param_range $IPINST -name "MII_BOARD_INTERFACE"]
	set_property range $param_range ${PARAM_VALUE.MII_BOARD_INTERFACE}
}

proc update_PARAM_VALUE.MDIO_BOARD_INTERFACE { PARAM_VALUE.MDIO_BOARD_INTERFACE IPINST PROJECT_PARAM.BOARD} {
	set param_range [get_board_interface_param_range $IPINST -name "MDIO_BOARD_INTERFACE"]
	set_property range $param_range ${PARAM_VALUE.MDIO_BOARD_INTERFACE}
}

################################################################################
# End of Board Related tcl proc 
################################################################################
proc update_PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK { PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK PARAM_VALUE.C_DUPLEX } {
# Procedure called when C_DUPLEX is updated
   set duplex [ get_property value ${PARAM_VALUE.C_DUPLEX} ]

   if {$duplex == 0} {
     set_property value 0  ${PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} 
     set_property enabled false  ${PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} 
   } else {
     set_property enabled true  ${PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} 
   }

}

proc update_PARAM_VALUE.C_S_AXI_ID_WIDTH { PARAM_VALUE.C_S_AXI_ID_WIDTH PARAM_VALUE.C_S_AXI_PROTOCOL} {
# Procedure called when C_S_AXI_PROTOCOL is updated
    set protocol [ get_property value ${PARAM_VALUE.C_S_AXI_PROTOCOL} ]

   if {$protocol == "AXI4LITE"} {
     set_property value 0  ${PARAM_VALUE.C_S_AXI_ID_WIDTH} 
     set_property enabled false  ${PARAM_VALUE.C_S_AXI_ID_WIDTH} 
   } else {
     set_property enabled true  ${PARAM_VALUE.C_S_AXI_ID_WIDTH} 
   }
}

proc update_gui_for_PARAM_VALUE.C_S_AXI_PROTOCOL { IPINST PARAM_VALUE.C_S_AXI_ID_WIDTH PARAM_VALUE.C_S_AXI_PROTOCOL} {
# Procedure called when C_S_AXI_PROTOCOL is updated
    set protocol [ get_property value ${PARAM_VALUE.C_S_AXI_PROTOCOL} ]

   if {$protocol == "AXI4LITE"} {
     set_property visible false [ ipgui::get_guiparamspec C_S_AXI_ID_WIDTH -of $IPINST ]

   } else {
     set_property visible true [ ipgui::get_guiparamspec C_S_AXI_ID_WIDTH -of $IPINST ]
   }

}

proc validate_PARAM_VALUE.AXI_ACLK_FREQ_MHZ { PARAM_VALUE.AXI_ACLK_FREQ_MHZ} {

# Procedure called when AXI_ACLK_FREQ_MHZ is updated
	set axi_clk_val [ get_property value ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ} ]
        if {$axi_clk_val < 10} {
		set_property errmsg "AXI Clk should not be less than 10 Mhz"  ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ} 
	        return false
	} else {
		return true
	}

}

proc update_MODELPARAM_VALUE.C_INSTANCE { MODELPARAM_VALUE.C_INSTANCE PARAM_VALUE.Component_Name} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.Component_Name} ]  ${MODELPARAM_VALUE.C_INSTANCE} 

}

proc update_MODELPARAM_VALUE.C_S_AXI_ACLK_PERIOD_PS { MODELPARAM_VALUE.C_S_AXI_ACLK_PERIOD_PS PARAM_VALUE.AXI_ACLK_FREQ_MHZ} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

        set freq_MHz [ get_property value ${PARAM_VALUE.AXI_ACLK_FREQ_MHZ} ]
        set timeperiod_ps [expr int(round(double(1000000/$freq_MHz)))]
        #set timeperiod_ps [expr int(round(double($freq_MHz*100)))]
        
	set_property value $timeperiod_ps  ${MODELPARAM_VALUE.C_S_AXI_ACLK_PERIOD_PS} 

}

proc update_MODELPARAM_VALUE.C_S_AXI_ID_WIDTH { MODELPARAM_VALUE.C_S_AXI_ID_WIDTH PARAM_VALUE.C_S_AXI_ID_WIDTH} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
    if {[ get_property value ${PARAM_VALUE.C_S_AXI_ID_WIDTH} ] == 0} {
       set model_val 1
   } else {
       set model_val [ get_property value ${PARAM_VALUE.C_S_AXI_ID_WIDTH} ]
   }
   
	set_property value $model_val  ${MODELPARAM_VALUE.C_S_AXI_ID_WIDTH} 

}

proc update_MODELPARAM_VALUE.C_S_AXI_PROTOCOL { MODELPARAM_VALUE.C_S_AXI_PROTOCOL PARAM_VALUE.C_S_AXI_PROTOCOL} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.C_S_AXI_PROTOCOL} ]  ${MODELPARAM_VALUE.C_S_AXI_PROTOCOL} 

}

proc update_MODELPARAM_VALUE.C_INCLUDE_MDIO { MODELPARAM_VALUE.C_INCLUDE_MDIO PARAM_VALUE.C_INCLUDE_MDIO} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.C_INCLUDE_MDIO} ]  ${MODELPARAM_VALUE.C_INCLUDE_MDIO} 

}

proc update_MODELPARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK { MODELPARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} ]  ${MODELPARAM_VALUE.C_INCLUDE_INTERNAL_LOOPBACK} 

}

proc update_MODELPARAM_VALUE.C_INCLUDE_GLOBAL_BUFFERS { MODELPARAM_VALUE.C_INCLUDE_GLOBAL_BUFFERS PARAM_VALUE.C_INCLUDE_GLOBAL_BUFFERS} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	set_property value [get_property value  ${PARAM_VALUE.C_INCLUDE_GLOBAL_BUFFERS} ]  ${MODELPARAM_VALUE.C_INCLUDE_GLOBAL_BUFFERS} 

}

proc update_MODELPARAM_VALUE.C_DUPLEX { MODELPARAM_VALUE.C_DUPLEX PARAM_VALUE.C_DUPLEX} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value

	 set_property value [get_property value  ${PARAM_VALUE.C_DUPLEX} ]  ${MODELPARAM_VALUE.C_DUPLEX} 

}

proc update_MODELPARAM_VALUE.C_TX_PING_PONG { MODELPARAM_VALUE.C_TX_PING_PONG PARAM_VALUE.C_TX_PING_PONG} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
        set param_tx_ping_pong [ get_property value ${PARAM_VALUE.C_TX_PING_PONG} ]
        if {$param_tx_ping_pong == 1} {
           set value 1
        } else {
           set value 0
        }

	set_property value $value  ${MODELPARAM_VALUE.C_TX_PING_PONG} 

}

proc update_MODELPARAM_VALUE.C_RX_PING_PONG { MODELPARAM_VALUE.C_RX_PING_PONG PARAM_VALUE.C_RX_PING_PONG} {
# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
        set param_rx_ping_pong [ get_property value ${PARAM_VALUE.C_RX_PING_PONG} ]
        if {$param_rx_ping_pong == 1} {
           set value 1
        } else {
           set value 0
        }

	set_property value $value  ${MODELPARAM_VALUE.C_RX_PING_PONG} 

}

proc update_MODELPARAM_VALUE.C_SELECT_XPM { MODELPARAM_VALUE.C_SELECT_XPM PARAM_VALUE.C_SELECT_XPM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_SELECT_XPM}] ${MODELPARAM_VALUE.C_SELECT_XPM}
}

