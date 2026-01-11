###############################################################################
# (c) Copyright 2011-2012,2015,2019,2023,2025 Advanced Micro Devices, Inc. All rights reserved.
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
###############################################################################
##
## lmb_v10_v3_0.tcl
##
###############################################################################

proc init_gui { IPINST } {
  set Component_Name [ ipgui::add_param  $IPINST -name Component_Name ]

  set_property hide_disabled_pins true [ipgui::get_canvasspec -of $IPINST]

  set Page0 [ ipgui::add_page $IPINST  -name "User" -layout vertical]
  set C_LMB_NUM_SLAVES [ipgui::add_param $IPINST -parent $Page0 -name C_LMB_NUM_SLAVES -widget comboBox]
  set C_EXT_RESET_HIGH [ipgui::add_param $IPINST -parent $Page0 -name C_EXT_RESET_HIGH -widget checkBox]
  set_property tooltip {0=Active low reset, 1=Active high reset} $C_EXT_RESET_HIGH

  # Hidden parameters - added to avoid warnings
  set C_LMB_DWIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_LMB_DWIDTH -widget radioGroup]
  set_property visible false $C_LMB_DWIDTH
  set C_LMB_AWIDTH [ipgui::add_param $IPINST -parent $Page0 -name C_LMB_AWIDTH -widget radioGroup ]
  set_property visible false $C_LMB_AWIDTH
  set C_LMB_PROTOCOL [ipgui::add_param $IPINST -parent $Page0 -name C_LMB_PROTOCOL -widget radioGroup]
  set_property visible false $C_LMB_PROTOCOL
  set C_LMB_HAS_PROT [ipgui::add_param $IPINST -parent $Page0 -name C_LMB_HAS_PROT -widget checkBox]
  set_property visible false $C_LMB_HAS_PROT
}

	
#
# Procedures called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
#

set model_proc {
  proc update_MODELPARAM_VALUE.<<p>> { MODELPARAM_VALUE.<<p>> PARAM_VALUE.<<p>> } {
    set_property value [get_property value ${PARAM_VALUE.<<p>>}] ${MODELPARAM_VALUE.<<p>>}
  }
}

foreach { param } { C_LMB_NUM_SLAVES C_EXT_RESET_HIGH C_LMB_DWIDTH C_LMB_AWIDTH C_LMB_PROTOCOL C_LMB_HAS_PROT } {
  set model_proc_p [regsub -all <<p>> $model_proc $param ]
  eval $model_proc_p
}
