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

proc init {cellpath otherInfo } {
# cell initialization here
# Not needed, can be removed
}

proc post_configure_ip {cellpath otherInfo } {
# Any updates to interface properties based on user configuration
# Not needed, can be removed
}

proc propagate {cellpath otherInfo } {
    set cell_handle [get_bd_cells $cellpath]
    set intf_handle [get_bd_intf_pins $cellpath/gpio]
    
	#set width [get_property CONFIG.WIDTH $intf_handle]
    #set_property CONFIG.C_GPIO_WIDTH $width $cell_handle

    #set all_inputs [get_property CONFIG.ALL_INPUTS $intf_handle]
    #set_property CONFIG.C_ALL_INPUTS $all_inputs $cell_handle

    #set dout_default [get_property CONFIG.DOUT_DEFAULT $intf_handle]
    #set_property CONFIG.C_DOUT_DEFAULT $dout_default $cell_handle

    #set tri_default [get_property CONFIG.TRI_DEFAULT $intf_handle]
    #set_property CONFIG.C_TRI_DEFAULT $tri_default $cell_handle

    # If gpio_2 interface is enabled, update properties for the second channel
	#if { [string compare -nocase [get_property CONFIG.C_IS_DUAL $cell_handle] "1"] == 0} {
	#	set intf_handle [get_bd_intf_pins $cellpath/gpio_2]
		
	#	set width_2 [get_property CONFIG.WIDTH $intf_handle]
		#set_property CONFIG.C_GPIO_WIDTH_2 $width_2 $cell_handle

		#set all_inputs_2 [get_property CONFIG.ALL_INPUTS $intf_handle]
		#set_property CONFIG.C_ALL_INPUTS_2 $all_inputs_2 $cell_handle

		#set dout_default_2 [get_property CONFIG.DOUT_DEFAULT $intf_handle]
		#set_property CONFIG.C_DOUT_DEFAULT_2 $dout_default_2 $cell_handle

		#set tri_default_2 [get_property CONFIG.TRI_DEFAULT $intf_handle]
		#set_property CONFIG.C_TRI_DEFAULT_2 $tri_default_2 $cell_handle
	#}

	# standard parameter propagation here
}
