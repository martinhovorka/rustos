# (c) Copyright 2012-2013, 2023 Advanced Micro Devices, Inc. All rights reserved.
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
source [::bd::get_vlnv_dir xilinx.com:ip:sc_util:1.0]/xgui/sc_util_v1_0_constants.tcl
source [::bd::get_vlnv_dir xilinx.com:ip:sc_util:1.0]/tcl/sc_debug_util.tcl

proc xil_clog2 { i } {
  set l 1
  while {[expr 1<<$l] <= $i} { incr l }
  return $l
}

proc init { cell_name other_params } {
  ifx_debug_proc_header
  update_bridges $cell_name
  update_intf_type $cell_name
  ifx_debug_proc_footer
}

proc update_intf_type { cell_name } {
  ifx_debug_proc_header

  foreach i [get_bd_intf_pins -of_objects [get_bd_cells $cell_name]] {
    set_property BD_ATTRIBUTE.TYPE interior $i 
  }
  ifx_debug_proc_footer
}

proc update_bridges { cell_name } {
  ifx_debug_proc_header
  set ip [get_bd_cells $cell_name]
  foreach i [get_bd_intf_pins -of_objects [get_bd_cells $cell_name] -filter {MODE==Master}] {
    lappend v [get_property NAME $i]
  }
  foreach i [get_bd_intf_pins -of_objects [get_bd_cells $cell_name] -filter {MODE==Slave}] {
    set_property BRIDGES [join $v :] $i
  }
  ifx_debug_proc_footer
}

proc update_assoc_busif { cell_name } {
  ifx_debug_proc_header
  set ip [get_bd_cells $cell_name]
  foreach p [get_bd_pins $cell_name/*clk*] {  set_property CONFIG.ASSOCIATED_BUSIF "" $p }
  foreach i [get_bd_intf_pins $cell_name/*_AXI] { lappend assoc [get_property NAME $i] }
  set_property CONFIG.ASSOCIATED_BUSIF [join $assoc :] [get_bd_pins $cell_name/aclk]
  ifx_debug_proc_footer
}

proc post_config_ip { cell_name other_params} { 
  ifx_debug_proc_header

  update_bridges $cell_name
  update_intf_type $cell_name
  update_assoc_busif $cell_name

  ifx_debug_proc_footer
}

proc pre_propagate {cell_name other_params} {
  ifx_debug_proc_header

  foreach p [get_bd_pins $cell_name/*clk*] { set_property CONFIG.ASSOCIATED_BUSIF.VALUE_SRC DEFAULT $p }

  foreach i [get_bd_intf_pins $cell_name/*_AXI] {
    set obj [find_bd_objs -thru_hier -relation CONNECTED_TO $i]
    if {[llength $obj] == 1} {
      set c [get_property CLASS $obj] 
      if {[string match "bd_intf_pin" $c]} {
        set t [get_property BD_ATTRIBUTE.TYPE $obj]
        if {[string match "interior" $t]} {
          set cip [get_bd_cells -of $obj]
          set vlnv [get_property VLNV $cip]
          if {![string match "xilinx.com:ip:smartconnect:*" [get_property VLNV $cip]]} {
            set validated 1
            foreach p {PROTOCOL READ_WRITE_MODE ADDR_WIDTH DATA_WIDTH ID_WIDTH ARUSER_WIDTH AWUSER_WIDTH BUSER_WIDTH} {
              if {![string match "USER" [get_property CONFIG.${p}.VALUE_SRC $obj]]} {
                set validated 0
                break;
              }
            }
            if {!$validated} {
              send_msg_id {SMARTCONNECT-2} WARNING "Port [get_property name $i] of $cell_name is connected to an infrastructure IP ($cip).  It is recommended to attach AXI SmartConnect directly to endpoint IPs to avoid mismatches or other issues during validation.  If mismatches occur, manually assign values for AXI Interface properties of $cip."
            } else {
              send_msg_id {SMARTCONNECT-2} INFO "Port [get_property name $i] of $cell_name is connected to an infrastructure IP ($cip).   It is recommended to attach Smartconnect dirctly to endpoint IPs."
            }
          } 
        }
      }
    }
  }
  
  foreach r {S M} {
    set valid 0
    foreach i [get_bd_intf_pins $cell_name/${r}*_AXI] {
      if {[llength [find_bd_objs -thru_hier -relation CONNECTED_TO $i]] > 0} { set valid 1 }
    }
    if {$valid == 0} {
      send_msg_id {SMARTCONNECT-2} WARNING "The ${r}_AXI ports of $cell_name are not connected to any endpoints.   Please connect at least one ${r}_AXI port to an endpoint."
    }
  }

  ifx_debug_proc_footer
}
