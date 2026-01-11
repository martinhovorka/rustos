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
#Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  set Component_Name [ ipgui::add_param  $IPINST  -name Component_Name ]
  set C_SIZE [ ipgui::add_param  $IPINST  -name C_SIZE ]
  set C_OPERATION [ ipgui::add_param  $IPINST  -name C_OPERATION ]
}

proc update_PARAM_VALUE.LOGO_FILE { PARAM_VALUE.LOGO_FILE PARAM_VALUE.C_OPERATION } {
	# Procedure called to update LOGO_FILE when any of the dependent parameters in the arguments change
   set opvalue [get_property value ${PARAM_VALUE.C_OPERATION}]
   if { [string compare $opvalue "and"] == 0 } {
      set_property value "data/sym_andgate.png" ${PARAM_VALUE.LOGO_FILE}
   } elseif { [string compare $opvalue "or"] == 0 } {   
      set_property value "data/sym_orgate.png" ${PARAM_VALUE.LOGO_FILE}
   } elseif { [string compare $opvalue "xor"] == 0 } {   
      set_property value "data/sym_xorgate.png" ${PARAM_VALUE.LOGO_FILE}
   } elseif { [string compare $opvalue "not"] == 0 } {   
      set_property value "data/sym_notgate.png" ${PARAM_VALUE.LOGO_FILE}
   }
}

proc validate_PARAM_VALUE.LOGO_FILE { PARAM_VALUE.LOGO_FILE } {
	# Procedure called to validate LOGO_FILE
	return true
}

proc update_PARAM_VALUE.C_SIZE { PARAM_VALUE.C_SIZE } {
	# Procedure called to update C_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_SIZE { PARAM_VALUE.C_SIZE } {
	# Procedure called to validate C_SIZE
	return true
}

proc update_PARAM_VALUE.C_OPERATION { PARAM_VALUE.C_OPERATION } {
	# Procedure called to update C_OPERATION when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_OPERATION { PARAM_VALUE.C_OPERATION } {
	# Procedure called to validate C_OPERATION
	return true
}


proc update_MODELPARAM_VALUE.C_OPERATION { MODELPARAM_VALUE.C_OPERATION PARAM_VALUE.C_OPERATION } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_OPERATION}] ${MODELPARAM_VALUE.C_OPERATION}
}

proc update_MODELPARAM_VALUE.C_SIZE { MODELPARAM_VALUE.C_SIZE PARAM_VALUE.C_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_SIZE}] ${MODELPARAM_VALUE.C_SIZE}
}

