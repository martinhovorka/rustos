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
# cell initialization here
# Not needed, can be removed
    set clk_pin_handle [get_bd_pins $cellpath/s_axi_aclk]
    set_property CONFIG.FREQ_HZ 100000000 $clk_pin_handle

    set cell [get_bd_cells $cellpath]
    set paramList "AXI_ACLK_FREQ_MHZ"
    bd::mark_propagate_only $cell $paramList
}

proc post_config_ip {cellpath otherInfo } {
# Any updates to interface properties based on user configuration
# Not needed, can be removed
}

proc propagate {cellpath otherInfo } {

    set cell_handle [get_bd_cells $cellpath]
    set intf_handle [get_bd_intf_pins $cellpath/s_axi_aclk]

    ## Assign AXI clock frequency to parameter 
    set clk_pin_handle [get_bd_pins $cellpath/s_axi_aclk]
    set freq_Hz [get_property CONFIG.FREQ_HZ $clk_pin_handle]
    if { $freq_Hz == "" } {
      set_property MSG.ERROR "AXI IIC :: AXI CLOCK Frequency is not propagated from AXI Interface" $cell_handle
    } else {
      set freq_Hz_int [expr int($freq_Hz)] 
      set freq_MHz [expr {$freq_Hz_int/1000000.0}];
      set_property CONFIG.AXI_ACLK_FREQ_MHZ $freq_MHz $cell_handle
      #set_property CONFIG.C_S_AXI_ACLK_FREQ_HZ $freq_Hz $cell_handle
    }

    # standard parameter propagation here
}


