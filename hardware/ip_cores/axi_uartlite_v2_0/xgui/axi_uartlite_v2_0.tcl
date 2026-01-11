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

proc init_gui { IPINST } {
	add_board_tab $IPINST

	set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]
	set Page0 [ ipgui::add_page $IPINST  -name "IP Configuration" -layout vertical]
	set panel1 [ ipgui::add_panel $IPINST  -name "AXI UARTLite" -parent $Page0 -layout horizontal]
	set C_S_AXI_ACLK_FREQ_HZ_d [ipgui::add_param $IPINST -parent $panel1 -widget textEdit -name C_S_AXI_ACLK_FREQ_HZ_d]
	ipgui::add_static_text  $IPINST -name ST1 -parent  $panel1 -text "[10-300]MHz" 
	ipgui::add_row $IPINST -parent $panel1 	
	set C_BAUDRATE [ipgui::add_param $IPINST -parent $panel1 -name C_BAUDRATE -widget comboBox]
	ipgui::add_row $IPINST -parent $panel1 	
	set C_DATA_BITS [ipgui::add_param $IPINST -parent $panel1 -name C_DATA_BITS ]
	set PARITY [ipgui::add_param $IPINST -parent $Page0 -name PARITY -widget radioGroup -layout horizontal]

	set C_USE_PARITY [ipgui::add_param $IPINST -name C_USE_PARITY]
	set_property visible false $C_USE_PARITY
	set C_ODD_PARITY [ipgui::add_param $IPINST -name C_ODD_PARITY]
	set_property visible false $C_ODD_PARITY
	set C_S_AXI_ACLK_FREQ_HZ [ipgui::add_param $IPINST -name C_S_AXI_ACLK_FREQ_HZ]
	set_property visible false $C_S_AXI_ACLK_FREQ_HZ

	set_property display_name "Baud Rate" $C_BAUDRATE
	set_property display_name "AXI CLK Frequency" $C_S_AXI_ACLK_FREQ_HZ_d
	set_property tooltip "AXI4-Lite clock frequency range should be in between 10 to 300MHz." $C_S_AXI_ACLK_FREQ_HZ_d
	set_property tooltip "AXI4-Lite clock frequency range should be in between 10 to 300MHz." $C_S_AXI_ACLK_FREQ_HZ
	set_property tooltip "Baud rate of the AXI UART Lite in bits per second." $C_BAUDRATE
	set_property display_name "Data Bits" $C_DATA_BITS
	set_property tooltip "The number of data bits in the serial frame." $C_DATA_BITS
	set_property tooltip "Determines whether parity is used or not. If used whether parity is odd or even." $PARITY

}

proc init_params {PARAM_VALUE.UARTLITE_BOARD_INTERFACE PROJECT_PARAM.ARCHITECTURE IPINST} {
	set param_range [get_board_interface_param_range $IPINST -name "UARTLITE_BOARD_INTERFACE"]
    if {[llength [split $param_range ","]] > 1} {
        set_property range $param_range [ipgui::get_paramspec UARTLITE_BOARD_INTERFACE -of $IPINST] 
    }
}

proc update_PARAM_VALUE.C_USE_PARITY { PARAM_VALUE.C_USE_PARITY PARAM_VALUE.PARITY IPINST} {
	set parity [get_property value ${PARAM_VALUE.PARITY}]
	set val [expr {$parity == "No_Parity" ? 0 : 1}]
	set_property value $val [ipgui::get_paramspec C_USE_PARITY -of $IPINST ]
}

proc update_PARAM_VALUE.C_ODD_PARITY { PARAM_VALUE.C_ODD_PARITY PARAM_VALUE.PARITY IPINST} {
	set parity [get_property value ${PARAM_VALUE.PARITY}]
	set val [expr {$parity == "Odd" ? 1 : 0}]
	set_property value $val [ipgui::get_paramspec C_ODD_PARITY -of $IPINST ]
}

proc update_PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ { PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d PROJECT_PARAM.ARCHITECTURE IPINST} {
    set value_clk_Mhz [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d}]
    set val_clk_hz [expr {int($value_clk_Mhz*1000000)} ]
    set_property value $val_clk_hz ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}
    # send_msg INFO 898 [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}]
}

proc validate_PARAM_VALUE.C_BAUDRATE { PARAM_VALUE.C_BAUDRATE PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d IPINST} {
	set value_baudrate [get_property value ${PARAM_VALUE.C_BAUDRATE}]
	set value_freq1 [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d}]
	set value_freq [expr {double($value_freq1) }];
	set baud_temp1 [expr {double($value_baudrate * 16)}];
	set baud_temp [expr {double($baud_temp1/1000000)} ];
	set va_freq [expr int(round($value_freq/$baud_temp))]
	set va_frequ [expr {double($value_freq/$va_freq)}]
	set valid_baud [expr {double((($baud_temp - $va_frequ)*100)/$baud_temp)}];
	if {$valid_baud > 3.0 || $valid_baud < -3.0}  {
		set_property errmsg "Baud error should be less than 3%" [ipgui::get_paramspec -name C_BAUDRATE -of $IPINST]	
		return false
	}							
	return true
}
proc update_PARAM_VALUE.C_BAUDRATE { PARAM_VALUE.C_BAUDRATE PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d PROJECT_PARAM.ARCHITECTURE IPINST} {
                set rangeValues [get_property default_range ${PARAM_VALUE.C_BAUDRATE}]

                set ValList [split $rangeValues ","]
                set RangeVals {}
                
                foreach var $ValList {
                                                set value_baudrate $var
                                                set value_freq1 [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ_d}]
                                                set value_freq [expr {double($value_freq1) }];
                                                set baud_temp1 [expr {double($value_baudrate * 16)}];
                                                set baud_temp [expr {double($baud_temp1/1000000)} ];
                                                set va_freq [expr int(round($value_freq/$baud_temp))]
                                                set va_frequ [expr {double($value_freq/$va_freq)}]
                                                set valid_baud [expr {double((($baud_temp - $va_frequ)*100)/$baud_temp)}];

                                                if {$valid_baud > 3.0 || $valid_baud < -3.0} {
                                                } else {
                                                                lappend RangeVals $var
                                }
                }
                set Val [join $RangeVals ","]
                set_property range $Val ${PARAM_VALUE.C_BAUDRATE}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ { MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ} {
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}] ${MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}
}

proc update_MODELPARAM_VALUE.C_BAUDRATE { MODELPARAM_VALUE.C_BAUDRATE PARAM_VALUE.C_BAUDRATE } {
	set_property value [get_property value ${PARAM_VALUE.C_BAUDRATE}] ${MODELPARAM_VALUE.C_BAUDRATE}
}

proc update_MODELPARAM_VALUE.C_DATA_BITS { MODELPARAM_VALUE.C_DATA_BITS PARAM_VALUE.C_DATA_BITS } {
	set_property value [get_property value ${PARAM_VALUE.C_DATA_BITS}] ${MODELPARAM_VALUE.C_DATA_BITS}
}

proc update_MODELPARAM_VALUE.C_USE_PARITY { MODELPARAM_VALUE.C_USE_PARITY PARAM_VALUE.PARITY PROJECT_PARAM.ARCHITECTURE} {
	set parity [get_property value ${PARAM_VALUE.PARITY}]
	set val [expr {$parity == "No_Parity" ? 0 : 1}]
	set_property value $val ${MODELPARAM_VALUE.C_USE_PARITY}
}

proc update_MODELPARAM_VALUE.C_ODD_PARITY { MODELPARAM_VALUE.C_ODD_PARITY PARAM_VALUE.PARITY PROJECT_PARAM.ARCHITECTURE} {
	set parity [get_property value ${PARAM_VALUE.PARITY}]
	set val [expr {$parity == "Odd" ? 1 : 0}]
	set_property value $val ${MODELPARAM_VALUE.C_ODD_PARITY}
}

