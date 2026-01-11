###############################################################################
# (c) Copyright 2012,2015,2019,2023,2025 Advanced Micro Devices, Inc. All rights reserved.
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
## lmb_v10_v3_0/bd/bd.tcl
##
###############################################################################

proc post_config_ip { cellpath otherInfo } {
  for {set index 0} {$index < 16} {incr index} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/LMB_Sl_${index}"]
    if {[string length $bif] > 0} {
      set_property BD_ATTRIBUTE.TYPE INTERIOR $bif
    }
  }
  set bif [get_bd_intf_pins -regexp "$cellpath/LMB_M"]
  if {[string length $bif] > 0} {
    set_property BD_ATTRIBUTE.TYPE INTERIOR $bif
  }
}

proc propagate {cellpath otherInfo} {
  # standard parameter propagation
  set cell [get_bd_cells $cellpath]

  # C_LMB_AWIDTH, C_LMB_DWIDTH, C_LMB_PROTOCOL, C_LMB_HAS_PROT
  set lmb_num_slaves [get_property "CONFIG.C_LMB_NUM_SLAVES" $cell]
  set busif [get_bd_intf_pins -quiet $cellpath/LMB_M]
  set addr_width [get_property -quiet "CONFIG.ADDR_WIDTH" $busif]
  set data_width [get_property -quiet "CONFIG.DATA_WIDTH" $busif]
  set protocol [get_property -quiet "CONFIG.PROTOCOL" $busif]
  set has_prot [get_property -quiet "CONFIG.HAS_PROT" $busif]
  for { set i 0 } { $i < $lmb_num_slaves }  { incr i } {
    set busif [get_bd_intf_pins -quiet $cellpath/LMB_Sl_${i}]
    if {[string length $addr_width] > 0} {
      set_property CONFIG.ADDR_WIDTH $addr_width $busif
    }
    if {[string length $data_width] > 0} {
      set_property CONFIG.DATA_WIDTH $data_width $busif
    }
    if {[string length $protocol] > 0} {
      set_property CONFIG.PROTOCOL $protocol $busif
    }
    if {[string length $has_prot] > 0} {
      set_property CONFIG.HAS_PROT $has_prot $busif
    }
  }
  if {[string length $addr_width] > 0} {
    set_property CONFIG.C_LMB_AWIDTH $addr_width $cell
  }
  if {[string length $data_width] > 0} {
    set_property CONFIG.C_LMB_DWIDTH $data_width $cell
  }
  set_property CONFIG.C_LMB_PROTOCOL [string equal "$protocol" "FREQUENCY"] $cell
  if {[string length $has_prot] > 0} {
    set_property CONFIG.C_LMB_HAS_PROT $has_prot $cell
  }
}
