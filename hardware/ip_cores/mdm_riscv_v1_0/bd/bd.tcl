###############################################################################
# (c) Copyright 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
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
## mdm_riscv_v1_0/bd/bd.tcl
##
###############################################################################

proc init { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  bd::mark_propagate_overrideable $cell {C_LMB_PROTOCOL C_ADDR_SIZE C_M_AXI_ADDR_WIDTH C_DEBUG_INTERFACE C_BSCANID}
}

proc post_config_ip {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # C_ADDR_SIZE, C_M_AXI_ADDR_WIDTH
  set addr_size_user [get_property CONFIG.C_ADDR_SIZE.VALUE_SRC $cell]
  set m_axi_addr_width_user [get_property CONFIG.C_M_AXI_ADDR_WIDTH.VALUE_SRC $cell]

  set addr_size 0
  set mb_dbg_ports [get_property CONFIG.C_MB_DBG_PORTS $cell]
  for {set i 0} {$i < $mb_dbg_ports} {incr i} {
    set mdm_bif [get_bd_intf_pins -quiet $cell/MBDEBUG_$i]
    set mb_bif  [find_bd_objs -quiet -thru_hier -relation connected_to $mdm_bif]
    set mb_cell [get_bd_cells -quiet -of_objects $mb_bif]
    if {[string length $mb_cell] > 0} {
      # Determine MDM bus master address size from the processor
      set mb_use_mmu   [get_property -quiet CONFIG.C_USE_MMU   $mb_cell]
      set mb_data_size [get_property -quiet CONFIG.C_DATA_SIZE $mb_cell]
      set mb_addr_size [get_property -quiet CONFIG.C_ADDR_SIZE $mb_cell]
      if {$mb_use_mmu == 3} {
        if {$mb_data_size == 64} {
          set mb_addr_size 56 ; # Physical address size defined by RISC-V Sv39, Sv48, Sv57
        } else {
          set mb_addr_size 34 ; # Physical address size defined by RISC-V Sv32
        }
      }
      if {[string length $mb_addr_size] > 0} {
        if {$addr_size_user != "USER" && $m_axi_addr_width_user != "USER"} {
          set addr_size [expr ($mb_addr_size > $addr_size) ? $mb_addr_size : $addr_size]
        }
      }
    }
  }
  if {$addr_size > 0} {
    set_property CONFIG.C_ADDR_SIZE $addr_size $cell
    set_property CONFIG.C_M_AXI_ADDR_WIDTH $addr_size $cell
  }
}

proc pre_propagate {cellpath otherInfo} {
  post_config_ip $cellpath $otherInfo
}

proc propagate {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # C_BSCANID - Set to 0 for Versal devices unless connected to a BSCAN Switch
  set use_bscan      [get_property CONFIG.C_USE_BSCAN $cell]
  set dbg_reg_access [get_property CONFIG.C_DBG_REG_ACCESS $cell]
  if {($use_bscan == 2 || $use_bscan == 4) && $dbg_reg_access == 0} {
    set value_src [get_property CONFIG.C_BSCANID.VALUE_SRC $cell]
    if {$value_src != "USER"} {
      set bscan [get_bd_intf_pins ${cellpath}/BSCAN]
      set driver [find_bd_objs -thru_hier -relation connected_to $bscan]
      set drivercell [get_bd_cells -quiet -of_objects $driver]
      set using_bs_switch 0
      if {[string length $drivercell] > 0} {
        set vlnv [get_property VLNV $drivercell]
        set using_bs_switch [expr [string first "xilinx.com:ip:bs_switch" "$vlnv" ] == 0]
      }
      set family [get_property ARCHITECTURE [get_property PART [current_project]]]
      if {$family == "versal" && ! $using_bs_switch} {
        set_property CONFIG.C_BSCANID 0 $cell
      } else {
        set_property CONFIG.C_BSCANID 76547328 $cell
      }
    }
  }
}

proc post_propagate {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # C_S_AXI_ACLK_FREQ_HZ
  set freq [get_property -quiet CONFIG.FREQ_HZ [get_bd_pins $cell/S_AXI_ACLK]]
  if {[string length $freq] > 0 && $freq != 0} {
    set_property -quiet CONFIG.C_S_AXI_ACLK_FREQ_HZ $freq $cell
  }

  # C_DEBUG_INTERFACE, C_LMB_PROTOCOL
  set use_uart [get_property CONFIG.C_USE_UART $cell]
  set dbg_reg_access [get_property CONFIG.C_DBG_REG_ACCESS $cell]

  set mdm_clk_connected 0
  if {$use_uart == 1 || $dbg_reg_access == 1} {
    set mdm_clk [get_bd_pins $cell/S_AXI_ACLK]
    set mdm_clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $mdm_clk]
    set mdm_clk_connected [expr [string length $mdm_clk_driver] > 0]
  }

  set mb_debug_external_trace 0
  set mb_debug_trace_profile 0
  set mb_s_axi 0
  set mdm_debug_interface [get_property CONFIG.C_DEBUG_INTERFACE $cell]
  set mdm_lmb_protocol [get_property CONFIG.C_LMB_PROTOCOL $cell]
  set mb_dbg_ports [get_property CONFIG.C_MB_DBG_PORTS $cell]
  for {set i 0} {$i < $mb_dbg_ports} {incr i} {
    set mdm_bif [get_bd_intf_pins -quiet $cell/MBDEBUG_$i]
    set mb_bif  [find_bd_objs -quiet -thru_hier -relation connected_to $mdm_bif]
    set mb_cell [get_bd_cells -quiet -of_objects $mb_bif]
    if {[string length $mb_cell] > 0} {
      # Set MDM debug interface from first processor, unless set by user
      set mb_debug_interface [get_property CONFIG.C_DEBUG_INTERFACE $mb_cell]
      if {[string length $mb_debug_interface] == 0} {
        set mb_debug_interface 0
      } else {
        set value_src [get_property CONFIG.C_DEBUG_INTERFACE.VALUE_SRC $cell]
        if {$value_src != "USER" && $mdm_debug_interface != $mb_debug_interface && $i == 0} {
          set mdm_debug_interface $mb_debug_interface
          set_property CONFIG.C_DEBUG_INTERFACE $mdm_debug_interface $cell
        }
      }

      # Check that MDM and processor has the same debug interface setting
      if {$mdm_debug_interface != $mb_debug_interface} {
        bd::send_msg -of $cellpath -type ERROR -msg_id 1 -text ": The MDM and connected MicroBlaze processors must have the same debug interface setting."
        break
      }

      # Check that MDM and processor has the same clock for parallel debug interface
      if {$mdm_debug_interface == 1 && $mdm_clk_connected} {
        set mb_clk [get_bd_pins $mb_cell/Clk]
        set mb_clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $mb_clk]
        set mb_clk_connected [expr [string length $mb_clk_driver] > 0]

        set mb_aclk [get_bd_pins -quiet $mb_cell/DEBUG_ACLK]
        set mb_aclk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $mb_aclk]
        set mb_aclk_connected [expr [string length $mb_aclk_driver] > 0]

        if {($mb_clk_connected  && $mdm_clk_driver != $mb_clk_driver) || \
            ($mb_aclk_connected && $mdm_clk_driver != $mb_aclk_driver)} {
          bd::send_msg -of $cellpath -type ERROR -msg_id 2 -text ": With parallel debug interface the MDM and connected MicroBlaze processors must use the same clock."
          break
        }
      }

      # Set MDM LMB protocol from first processor, unless set by user
      set mb_d_lmb_protocol [get_property CONFIG.C_D_LMB_PROTOCOL $mb_cell]
      set mb_i_lmb_protocol [get_property CONFIG.C_I_LMB_PROTOCOL $mb_cell]
      if {[string length $mb_d_lmb_protocol] == 0 || [string length $mb_i_lmb_protocol] == 0} {
        set mb_lmb_protocol 0
      } else {
        set mb_lmb_protocol [expr $mb_d_lmb_protocol == 1 || $mb_i_lmb_protocol == 1 ? 1 : 0]
      }
      set value_src [get_property CONFIG.C_LMB_PROTOCOL.VALUE_SRC $cell]
      if {$value_src != "USER" && $mdm_lmb_protocol != $mb_lmb_protocol && $i == 0} {
        set mdm_lmb_protocol $mb_lmb_protocol
        set_property CONFIG.C_LMB_PROTOCOL $mdm_lmb_protocol $cell
      }

      # Check that MDM and processor has the same LMB protocol
      if {$mdm_lmb_protocol != $mb_lmb_protocol} {
        bd::send_msg -of $cellpath -type ERROR -msg_id 3 -text ": The MDM and connected MicroBlaze processors must have the same LMB protocol setting."
        break
      }

      # Check for correct processor
      set mb_vlnv [get_property VLNV $mb_cell]
      if {[string first riscv $mb_vlnv] < 0} {
        bd::send_msg -of $cellpath -type ERROR -msg_id 4 -text ": The processor connected to MBDEBUG_$i is not MicroBlaze V."
      }

      # Check if any processor has debug external trace
      set debug_external_trace [get_property CONFIG.C_DEBUG_EXTERNAL_TRACE $mb_cell]
      if {$debug_external_trace > 0} {
        set mb_debug_external_trace 1
      }

      # Check if any processor has debug trace or profiling, with or without S_AXI
      set debug_trace_size [get_property CONFIG.C_DEBUG_TRACE_SIZE $mb_cell]
      set debug_profile_size [get_property CONFIG.C_DEBUG_PROFILE_SIZE $mb_cell]
      set s_axi [get_property CONFIG.C_S_AXI $mb_cell]
      if {$debug_trace_size > 0 || $debug_profile_size > 0} {
        incr mb_debug_trace_profile
        if {$s_axi > 0} { incr mb_s_axi }
      }
    }
  }

  # C_TRACE_OUTPUT
  set mdm_debug_interface [get_property CONFIG.C_DEBUG_INTERFACE $cell]
  set mdm_dbg_mem_access [get_property CONFIG.C_DBG_MEM_ACCESS $cell]
  set mdm_trace_output [get_property CONFIG.C_TRACE_OUTPUT $cell]
  if {$mdm_debug_interface == 0 && $mdm_dbg_mem_access == 0 && $mdm_trace_output == 0} {
    if {$mb_debug_trace_profile != $mb_s_axi} {
      bd::send_msg -of $cellpath -type WARNING -msg_id 5 -text ": To access processor Debug Trace or Profiling enable Trace Output, or alternatively enable and connect AXI Memory access from Debug and processor AXI Slave Interface."
    }
  }

  # C_TRACE_CLK_FREQ_HZ
  set trace_output [get_property CONFIG.C_TRACE_OUTPUT $cell]
  if {$trace_output == 1} {
    set value_src [get_property CONFIG.C_TRACE_CLK_FREQ_HZ.VALUE_SRC $cell]
    if {$value_src != "USER"} {
      set pin [get_bd_pins $cellpath/TRACE_CLK]
      set drive_pin [find_bd_objs -quiet -thru_hier -relation connected_to $pin]
      if {[string length $drive_pin] > 0} {
        set freq [get_property -quiet CONFIG.FREQ_HZ $drive_pin]
        if {[string length $freq] > 0} {
          set_property CONFIG.C_TRACE_CLK_FREQ_HZ $freq $cell
        }
      }
    }
  }

}
