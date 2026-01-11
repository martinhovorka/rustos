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
proc init { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]
  bd::mark_propagate_only $cell {C_EXT_RESET_HIGH}
  bd::mark_propagate_overrideable $cell {C_AUX_RESET_HIGH}
}

proc post_config_ip {cellName otherInfo} {
    set cell [get_bd_cells $cellName]
    set aux_rst_pin  [get_bd_pins ${cellName}/aux_reset_in]
    set cell_aux_rst_val [get_property CONFIG.C_AUX_RESET_HIGH $cell]
    if {"USER" == [get_property CONFIG.C_AUX_RESET_HIGH.VALUE_SRC $cell] } {
        # cell param has been set by user. Use cell param value to update pin property
        if { $cell_aux_rst_val == 1} {
           set_property CONFIG.POLARITY "ACTIVE_HIGH" $aux_rst_pin
        } else {
           set_property CONFIG.POLARITY "ACTIVE_LOW" $aux_rst_pin
        }
    } else {
          set_property CONFIG.POLARITY.VALUE_SRC PROPAGATED $aux_rst_pin
    }
}
proc propagate {cellName otherInfo} {

if {[get_bd_nets -quiet -of_objects [get_bd_pins ${cellName}/ext_reset_in]] == "" && [get_bd_nets -quiet -of_objects [get_bd_pins ${cellName}/aux_reset_in]] == "" } {
            bd::send_msg -of $cellName -type WARNING -msg_id 1 -text " Input reset pins ext_reset_in and aux_reset_in are unconnected. Core will generate resets only on POWER ON."

    }

}
proc post_propagate {cellName otherInfo} {

    set ext_rst    [get_bd_pins ${cellName}/ext_reset_in           ]
    set polarity   [get_property CONFIG.POLARITY $ext_rst          ]
    set board_info [get_property CONFIG.RESET_BOARD_INTERFACE [get_bd_cells $cellName]]
        if { $board_info ne "Custom" } { 
        set_property CONFIG.POLARITY.VALUE_SRC USER $ext_rst
    } else {
        if {$polarity eq "ACTIVE_LOW"} {
            set_property CONFIG.C_EXT_RESET_HIGH 0 [get_bd_cells $cellName]
        } elseif {$polarity eq "ACTIVE_HIGH"} {
            set_property CONFIG.C_EXT_RESET_HIGH 1 [get_bd_cells $cellName]
        } else {
            bd::send_msg -of $cellName -type ERROR -msg_id 2 -text "Wrong Polarity value $polarity is defined on pin $ext_rst"
        }
    } 

    if {"USER" != [get_property CONFIG.C_AUX_RESET_HIGH.VALUE_SRC [get_bd_cells $cellName]] } {
        # cell param not set by user. Use pin property to update cell param value 
        set aux_rst  [get_bd_pins ${cellName}/aux_reset_in   ]
        set polarity [get_property CONFIG.POLARITY [get_bd_pins $aux_rst]]
        if {$polarity == "ACTIVE_LOW"} {
            set_property CONFIG.C_AUX_RESET_HIGH 0 [get_bd_cells $cellName]
        }
        if {$polarity == "ACTIVE_HIGH"} {
            set_property CONFIG.C_AUX_RESET_HIGH 1 [get_bd_cells $cellName]
        }
    }
}
