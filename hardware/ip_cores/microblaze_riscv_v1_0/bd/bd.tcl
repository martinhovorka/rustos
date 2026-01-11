###############################################################################
# (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
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
## microblaze_riscv_v1_0/bd/bd.tcl
##
###############################################################################

proc init { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  bd::mark_propagate_only $cell {C_INTERRUPT_IS_EDGE C_EDGE_IS_POSITIVE}
  bd::mark_propagate_overrideable $cell \
   {C_FAULT_TOLERANT C_USE_INTERRUPT
    C_DCACHE_BASEADDR C_DCACHE_HIGHADDR
    C_ICACHE_BASEADDR C_ICACHE_HIGHADDR
    C_BASE_VECTORS C_PC_WIDTH}
}

proc post_config_ip { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  # BD_ATTRIBUTE.FUNCTION
  foreach memory_mapped_intf {DLMB M_AXI_DP M_AXI_DC M_ACE_DC ILMB M_AXI_IP M_AXI_IC M_ACE_IC \
                              MON_DLMB MON_AXI_DP MON_AXI_DC MON_ACE_DC MON_ILMB MON_AXI_IP MON_AXI_IC MON_ACE_IC} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$memory_mapped_intf"]
    if {[string length $bif] > 0} {
      set_property BD_ATTRIBUTE.FUNCTION CPU $bif
    }
  }

  # MAX_BURST_LENGTH and HAS_BURST for cache interfaces
  foreach cache_intf {M_AXI_DC M_ACE_DC M_AXI_IC M_ACE_IC MON_AXI_DC MON_ACE_DC MON_AXI_IC MON_ACE_IC} x {D D I I D D I I} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$cache_intf"]
    if {[string length $bif] > 0} {
      set cache_data_width [get_property CONFIG.C_${x}CACHE_DATA_WIDTH $cell]
      set cache_line_len   [get_property CONFIG.C_${x}CACHE_LINE_LEN   $cell]
      set_property CONFIG.MAX_BURST_LENGTH [expr ($cache_data_width == 0) ? $cache_line_len : 1] $bif
      set_property CONFIG.MAX_BURST_LENGTH.VALUE_SRC CONSTANT $bif
    }
  }
  foreach cache_intf {M_AXI_DC M_AXI_IC MON_AXI_DC MON_AXI_IC} x {D I D I} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$cache_intf"]
    if {[string length $bif] > 0} {
      set cache_data_width [get_property CONFIG.C_${x}CACHE_DATA_WIDTH $cell]
      set_property CONFIG.HAS_BURST [expr ($cache_data_width == 0) ? 1 : 0] $bif
      set_property CONFIG.HAS_BURST.VALUE_SRC CONSTANT $bif
    }
  }

  # NUM_READ_OUTSTANDING for instruction cache interfaces
  foreach cache_intf {M_AXI_IC M_ACE_IC MON_AXI_IC MON_AXI_IC} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$cache_intf"]
    if {[string length $bif] > 0} {
      set icache_streams [get_property CONFIG.C_ICACHE_STREAMS $cell]
      set_property CONFIG.NUM_READ_OUTSTANDING [expr $icache_streams ? 8 : 2] $bif
      set_property CONFIG.NUM_READ_OUTSTANDING.VALUE_SRC CONSTANT $bif
    }
  }

  # ADDR_WIDTH for DLMB, MON_DLMB, ILMB and MON_ILMB interfaces
  # - Set to 32 for 32-bit ILMB and MON_ILMB if C_USE_MMU < 3
  # - Set to C_ADDR_SIZE if C_USE_MMU < 3
  # - Set to physical address size 34 or 56 if C_USE_MMU == 3
  set addr_size [get_property CONFIG.C_ADDR_SIZE $cell]
  set data_size [get_property CONFIG.C_DATA_SIZE $cell]
  set use_mmu [get_property CONFIG.C_USE_MMU $cell]
  foreach lmb_intf {DLMB MON_DLMB ILMB MON_ILMB} iside {0 0 1 1} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$lmb_intf"]
    if {[string length $bif] > 0} {
      set size $addr_size
      if {$use_mmu <  3 && $data_size == 32 && $iside == 1} { set size 32 }
      if {$use_mmu == 3 && $data_size == 32} { set size 34 }
      if {$use_mmu == 3 && $data_size == 64} { set size 56 }
      set_property CONFIG.ADDR_WIDTH $size $bif
      set_property CONFIG.ADDR_WIDTH.VALUE_SRC DEFAULT $bif
    }
  }

  # C_USE_BRANCH_TARGET_CACHE
  set optimization            [get_property CONFIG.C_OPTIMIZATION $cell]
  set use_branch_target_cache [get_property CONFIG.C_USE_BRANCH_TARGET_CACHE $cell]
  if {$optimization == 2 && $use_branch_target_cache == 0} {
    bd::send_msg -of $cellpath -type WARNING -msg_id 19 -text ": When using frequency optimization it is highly recommended to enable the branch target cache, in order to improve computational performance."
  }

  # C_ICACHE_BYTE_SIZE, C_DCACHE_BYTE_SIZE
  foreach busletter {I D} param {C_ICACHE_BYTE_SIZE C_DCACHE_BYTE_SIZE} icache {1 0} {
    set use_cache [get_property CONFIG.C_USE_${busletter}CACHE $cell]
    if {$use_cache} {
      set cache_line_len   [get_property CONFIG.C_${busletter}CACHE_LINE_LEN $cell]
      set cache_byte_size  [get_property CONFIG.$param $cell]
      set optimization     [get_property CONFIG.C_OPTIMIZATION $cell]
      set fault_tolerant   [get_property CONFIG.C_FAULT_TOLERANT $cell]
      set cache_data_width [get_property CONFIG.C_${busletter}CACHE_DATA_WIDTH $cell]
      set interconnect     [get_property CONFIG.C_INTERCONNECT $cell]
      set use_writeback    [get_property CONFIG.C_DCACHE_USE_WRITEBACK $cell]

      set use_wide [expr $use_writeback || $icache]
      if {$cache_data_width != 0 && $use_wide} {
        set allowed_size [expr 2048 * $cache_line_len]
        if {$optimization != 1 && $interconnect == 2 && $fault_tolerant == 0 && $cache_byte_size == $allowed_size} {
          bd::send_msg -of $cellpath -type WARNING -msg_id 21 -text ": Suboptimal use of ${busletter}-cache Block RAM. Please increase the cache size to [expr 2 * $cache_byte_size] bytes to fully utilize Block RAM."
        }
      } elseif {$cache_byte_size == 2048} {
        bd::send_msg -of $cellpath -type WARNING -msg_id 22 -text ": Suboptimal use of ${busletter}-cache Block RAM. Please increase the cache size to 4096 bytes to fully utilize Block RAM."
      }
    }
  }
}

proc pre_propagate { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  # C_M_AXI_DC_USER_SIGNALS, C_M_AXI_IC_USER_SIGNALS
  foreach cache_intf {M_AXI_DC M_AXI_IC MON_AXI_DC MON_AXI_IC} kind {D I D I} {
    set param CONFIG.C_M_AXI_${kind}C_USER_SIGNALS
    set value_src [get_property ${param}.VALUE_SRC $cell]
    if {$value_src != "USER"} {
      set_property $param 0 $cell
      set busif [get_bd_intf_pins -quiet $cellpath/$cache_intf]
      set slaveifs [find_bd_objs -quiet -relation ADDRESSABLE_SLAVE $busif]
      foreach slaveif $slaveifs {
        set aruser_width [get_property CONFIG.ARUSER_WIDTH $slaveif]
        set awuser_width [get_property CONFIG.AWUSER_WIDTH $slaveif]
        set buser_width  [get_property CONFIG.BUSER_WIDTH  $slaveif]
        set wuser_width  [get_property CONFIG.WUSER_WIDTH  $slaveif]
        set ruser_width  [get_property CONFIG.RUSER_WIDTH  $slaveif]
        if {$aruser_width == 5 && $awuser_width == 5 && $buser_width == 0 && $wuser_width == 0 && $ruser_width == 0} {
          set_property $param 1 $cell
        }
      }
    }
  }

  # ARUSER_WIDTH, AWUSER_WIDTH for M_AXI cache interfaces
  foreach cache_intf {M_AXI_DC M_AXI_IC MON_AXI_DC MON_AXI_IC} kind {D I D I} {
    set bif [get_bd_intf_pins -quiet -regexp "$cellpath/$cache_intf"]
    if {[string length $bif] > 0} {
      set user_signals [get_property CONFIG.C_M_AXI_${kind}C_USER_SIGNALS $cell]
      set_property CONFIG.ARUSER_WIDTH [expr $user_signals ? 5 : 0] $bif
      set_property CONFIG.AWUSER_WIDTH [expr $user_signals ? 5 : 0] $bif
    }
  }
}

proc post_propagate {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # C_FREQ
  set freq [get_property -quiet CONFIG.FREQ_HZ [get_bd_pins $cell/Clk]]
  if {[string length $freq] > 0 && $freq != 0} {
    set_property -quiet CONFIG.C_FREQ $freq $cell
  }

  # C_INTERRUPT_IS_EDGE, C_EDGE_IS_POSITIVE
  set_property -quiet CONFIG.C_INTERRUPT_IS_EDGE 0 $cell
  set_property -quiet CONFIG.C_EDGE_IS_POSITIVE  1 $cell
  set busif [get_bd_intf_pins -quiet [list $cellpath/INTERRUPT $cellpath/MON_INTERRUPT]]
  set drive_intf [find_bd_objs -quiet -thru_hier -relation connected_to $busif]
  if {[string length $drive_intf] > 0} {
    set sensitivity [get_property -quiet CONFIG.SENSITIVITY $busif]
  } else {
    set sensitivity [get_property -quiet CONFIG.SENSITIVITY [get_bd_pins $cellpath/Interrupt]]
  }
  if {[string length $sensitivity] > 0} {
    set_property -quiet CONFIG.C_INTERRUPT_IS_EDGE [expr [string first EDGE   $sensitivity] == 0] $cell
    set_property -quiet CONFIG.C_EDGE_IS_POSITIVE  [expr [string last  RISING $sensitivity]  > 0 || \
                                                         [string first LEVEL  $sensitivity] == 0 ] $cell
    if [string equal $sensitivity "LEVEL_LOW"] {
      bd::send_msg -of $cellpath -type ERROR -msg_id 17 -text ": Interrupt sensitivity Level Low not supported. Select either Level High. Edge Rising or Edge Falling."
    }
  }

  # C_FAULT_TOLERANT
  set ecc 0
  set mb_data_addr_space [get_bd_addr_spaces $cellpath/Data]
  set mb_data_addr_seg_list [get_bd_addr_segs -of_object $mb_data_addr_space]
  set mb_inst_addr_space [get_bd_addr_spaces $cellpath/Instruction]
  set mb_inst_addr_seg_list [get_bd_addr_segs -of_object $mb_inst_addr_space]
  foreach master_addr_seg [concat $mb_data_addr_seg_list $mb_inst_addr_seg_list] {
    set slave_addr_seg [get_bd_addr_seg -quiet -of_object $master_addr_seg]
    set slaveintf [get_bd_intf_pin -quiet -of_object $slave_addr_seg]
    if {[get_property -quiet BD_ATTRIBUTE.FUNCTION $slaveintf] == "BRAM_CTRL"} {
      set ip [get_bd_cells -of_object $slaveintf]
      if {"[get_property -quiet CONFIG.C_ECC $ip]" == "1"} { incr ecc }
    }
  }
  set fault_tolerant [get_property CONFIG.C_FAULT_TOLERANT $cell]
  set dcache_dw [get_property CONFIG.C_DCACHE_DATA_WIDTH $cell]
  set icache_dw [get_property CONFIG.C_ICACHE_DATA_WIDTH $cell]
  if {$fault_tolerant == 0 && $dcache_dw == 0 && $icache_dw == 0 && $ecc > 0} {
    bd::send_msg -of $cellpath -type INFO -msg_id 1 -text ": Enabling fault tolerance."
    set_property -quiet CONFIG.C_FAULT_TOLERANT 1 $cell
  }
  if {$fault_tolerant == 0 && ($dcache_dw != 0 || $icache_dw != 0) && $ecc > 0} {
    bd::send_msg -of $cellpath -type WARNING -msg_id 2 -text ": Cannot enable fault tolerance, since wide cache interfaces are used."
  }

  # C_USE_EXT_BRK
  set connected_net [get_bd_nets -of_object [get_bd_pins $cellpath/Ext_BRK]]
  set_property -quiet CONFIG.C_USE_EXT_BRK [expr [string length $connected_net] > 0] $cell

  # C_USE_EXT_NM_BRK
  set connected_net [get_bd_nets -of_object [get_bd_pins $cellpath/Ext_NM_BRK]]
  set_property -quiet CONFIG.C_USE_EXT_NM_BRK [expr [string length $connected_net] > 0] $cell

  # C_USE_SLEEP
  set connected_net_sleep     [get_bd_nets -of_object [get_bd_pins $cellpath/Sleep]]
  set connected_net_hibernate [get_bd_nets -of_object [get_bd_pins $cellpath/Hibernate]]
  set connected_net_suspend   [get_bd_nets -of_object [get_bd_pins $cellpath/Suspend]]
  set connected_net           [expr ([string length $connected_net_sleep]     > 0) * 1 + \
                                    ([string length $connected_net_hibernate] > 0) * 2 + \
                                    ([string length $connected_net_suspend]   > 0) * 4]
  set_property -quiet CONFIG.C_USE_SLEEP $connected_net $cell

  # C_USE_NON_SECURE
  set connected_net [get_bd_nets -of_object [get_bd_pins $cellpath/Non_Secure]]
  set_property -quiet CONFIG.C_USE_NON_SECURE [expr [string length $connected_net] > 0] $cell

  # C_LOCKSTEP_SLAVE
  set master_cell $cell
  set lockstep_select [get_property "CONFIG.C_LOCKSTEP_SELECT" $cell]
  if {$lockstep_select >= 2} {
    set lockstep_master [find_lockstep_master $cell]
    if {$lockstep_master != $cell} {
      set master_cell $lockstep_master
    } else {
      bd::send_msg -of $cellpath -type WARNING -msg_id 5 -text ": RISC-V is configured as a lockstep slave, but the corresponding lockstep master could not be found. Please ensure that all parameters in the master and slave are identical."
    }
  }

  # C_USE_INTERRUPT
  set busif [get_bd_intf_pins -quiet [list $master_cell/INTERRUPT]]
  set drive_intf [find_bd_objs -quiet -thru_hier -relation connected_to $busif]
  set use_interrupt [get_property CONFIG.C_USE_INTERRUPT $cell]
  set value_src [get_property CONFIG.C_USE_INTERRUPT.VALUE_SRC $cell]
  set msg "Please review the manual value or consider using Auto instead."
  if {[string length $drive_intf] > 0} {
    set low_latency [get_property CONFIG.LOW_LATENCY $drive_intf]
    if {$low_latency == "0" || $low_latency == "1"} {
      set_property -quiet CONFIG.LOW_LATENCY $low_latency $busif
      set new_value [expr 1 + $low_latency]
      if {$value_src != "USER"} {
        set_property -quiet CONFIG.C_USE_INTERRUPT $new_value $cell
      } elseif {$use_interrupt != $new_value} {
        bd::send_msg -of $cellpath -type WARNING -msg_id 25 -text ": Use Interrupt manual value ($use_interrupt) does not match computed value ($new_value). $msg"
      }
    }
  } else {
    set connected_net [get_bd_nets -of_object [get_bd_pins $master_cell/Interrupt]]
    if {[string length $busif] > 0} {
      set_property -quiet CONFIG.LOW_LATENCY 0 $busif
    }
    set new_value [expr [string length $connected_net] > 0]
    if {$value_src != "USER"} {
      set_property -quiet CONFIG.C_USE_INTERRUPT $new_value $cell
    } elseif {$use_interrupt != $new_value} {
      bd::send_msg -of $cellpath -type WARNING -msg_id 25 -text ": Use Interrupt manual value ($use_interrupt) does not match computed value ($new_value). $msg"
    }
  }

  # C_ASYNC_WAKEUP
  set wakeupPin [get_bd_pins $cellpath/Wakeup]
  set wakeupDriver [find_bd_objs -relation connected_to $wakeupPin]
  if { [string length $wakeupDriver] > 0 } {

    set width           2
    set mask            [expr (1 << $width) - 1]

    set using_concat    0
    set using_concat_v1 0
    set wakeupDriverCell [get_bd_cells -quiet -of_objects $wakeupDriver]
    set using_driver_cell [expr [string length $wakeupDriverCell] > 0]
    if {$using_driver_cell} {
      set vlnv [get_property VLNV $wakeupDriverCell]
      set xlconcat [string first "xilinx.com:ip:xlconcat" "$vlnv"]
      set ilconcat [string first "xilinx.com:inline_hdl:ilconcat" "$vlnv"]
      set using_concat [expr $xlconcat == 0 || $ilconcat == 0]
      set xlconcat_v1 [string first "xilinx.com:ip:xlconcat:1" "$vlnv"]
      set using_concat_v1 [expr $xlconcat_v1 == 0]
    }
    set nCount [expr $width - 1]

    # Update C_ASYNC_WAKEUP from Wakeup connections if no user override:
    # - If connected to concat, follow connections to driver for each input
    # - Use reversed order assignment if connected to xilinx.com:ip:xlconcat:1.x
    # - Check if driver has one clock in the same clock domain, and assign bits accordingly
    set asyncWakeupKind [string equal [get_property CONFIG.C_ASYNC_WAKEUP.VALUE_SRC $cell] "USER"]
    if {! $asyncWakeupKind} {
      set nAsyncWakeup 0x3
      set clk_domain [get_property CONFIG.CLK_DOMAIN [get_bd_pins $cell/Clk]]
      if {$using_concat} {
        set nCount [expr $using_concat_v1 ? $width - 1 : 0]
        set nPorts [get_property CONFIG.NUM_PORTS $wakeupDriverCell]
        for {set index 0} {$index < $nPorts} {incr index} {
          set wakeupPin [get_bd_pins "${wakeupDriverCell}/In${index}"]
          set nInWidth [get_property CONFIG.IN${index}_WIDTH $wakeupDriverCell]
          set wakeupPinDriver [find_bd_objs -relation connected_to $wakeupPin]
          if {[string length $wakeupPinDriver] > 0} {
            set wakeupPinDriverCell [get_bd_cells -quiet -of_objects $wakeupPinDriver]
            if {[string length $wakeupPinDriverCell] > 0} {
              set clk_pins [get_bd_pins -filter {TYPE=~clk} [get_bd_pins -of_object $wakeupPinDriverCell]]
              set clk_domains_equal [expr [string length $clk_pins] > 0]
              foreach clk_pin $clk_pins {
                set clk_wakeup_domain [get_property CONFIG.CLK_DOMAIN $clk_pin]
                set clk_domains_equal [expr $clk_domains_equal && [string equal "$clk_domain" "$clk_wakeup_domain"]]
              }
              if {$clk_domains_equal} {
                set syncmask     [expr ((1 << $nInWidth) - 1) << ($nCount - $nInWidth + 1)]
                set nAsyncWakeup [expr $nAsyncWakeup & ~$syncmask]
              }
            }
          }
          set nCount [expr $using_concat_v1 ? $nCount - $nInWidth : $nCount + $nInWidth]
        }
      } elseif {$using_driver_cell} {
        set clk_pins [get_bd_pins -filter {TYPE=~clk} [get_bd_pins -of_object $wakeupDriverCell]]
        set clk_domains_equal [expr [string length $clk_pins] > 0]
        foreach clk_pin $clk_pins {
          set clk_wakeup_domain [get_property CONFIG.CLK_DOMAIN $clk_pin]
          set clk_domains_equal [expr $clk_domains_equal && [string equal "$clk_domain" "$clk_wakeup_domain"]]
        }
        if {$clk_domains_equal} {
          set nAsyncWakeup [expr ~$mask & 0x3]
        }
      }
      set strAsyncWakeup [format "%u" $nAsyncWakeup]
      set_property CONFIG.C_ASYNC_WAKEUP $strAsyncWakeup $cell
    }
  } else {
    set_property CONFIG.C_ASYNC_WAKEUP "3" $cell
  }
  
  # C_xCACHE_BASEADDR and C_xCACHE_HIGHADDR: Set from address segments and check that I and D have the same values
  set dcache_ok [set_cache_addr $cell $master_cell "D"]
  set icache_ok [set_cache_addr $cell $master_cell "I" $dcache_ok]

  set use_dcache [get_property CONFIG.C_USE_DCACHE $cell]
  set dcache_baseaddr [get_property "CONFIG.C_DCACHE_BASEADDR" $cell]
  set dcache_highaddr [get_property "CONFIG.C_DCACHE_HIGHADDR" $cell]
  set use_icache [get_property CONFIG.C_USE_ICACHE $cell]
  set icache_baseaddr [get_property "CONFIG.C_ICACHE_BASEADDR" $cell]
  set icache_highaddr [get_property "CONFIG.C_ICACHE_HIGHADDR" $cell]
  if {$dcache_baseaddr != $icache_baseaddr && $use_dcache && $use_icache} {
    bd::send_msg -of $cellpath -type WARNING -msg_id 6 -text ": The data cache base address (${dcache_baseaddr}) is different from the corresponding instruction cache address (${icache_baseaddr}). Please set both addresses to the same value for full debug and software download support."
  }
  if {$dcache_highaddr != $icache_highaddr && $use_dcache && $use_icache} {
    bd::send_msg -of $cellpath -type WARNING -msg_id 7 -text ": The data cache high address (${dcache_highaddr}) is different from the corresponding instruction cache address (${icache_highaddr}). Please set both addresses to the same value for full debug and software download support."
  }

  # C_BASE_VECTORS: assign to LMB base address if available and otherwise to lowest memory base address
  set base_vectors [get_property "CONFIG.C_BASE_VECTORS" $cell]
  if {! [string equal [get_property CONFIG.C_BASE_VECTORS.VALUE_SRC $master_cell] "USER"]} {
    set found_lmb    0
    set found_other  0
    set offset_lmb   0x0
    set offset_other 0x0
    set bif_ilmb [get_bd_intf_pins -quiet -regexp "$master_cell/ILMB"]
    set mb_addr_seg_list [get_bd_addr_segs -of_objects $master_cell]
    foreach mb_addr_seg $mb_addr_seg_list {
      set bif      [get_bd_intf_pins -of_objects $mb_addr_seg]
      set offset   [get_property OFFSET $mb_addr_seg]
      set usage    [get_property USAGE   $mb_addr_seg]
      set memtype  [get_property MEMTYPE $mb_addr_seg]
      set is_mem   [string equal $usage   "memory"]
      set is_instr [string equal $memtype "instruction"]
      set is_both  [string equal $memtype "both"]
      if { $is_mem && $bif == $bif_ilmb && (! $found_lmb || $offset < $offset_lmb) } {
        set found_lmb 1
        set offset_lmb $offset
      } elseif { $is_mem && ($is_instr || $is_both) && ! $found_lmb && (! $found_other || $offset < $offset_other) } {
        set found_other 1
        set offset_other $offset
      }
    }
    if {$found_lmb} {
      set_property CONFIG.C_BASE_VECTORS $offset_lmb $cell
      bd::send_msg -of $cellpath -type INFO -msg_id 9 -text ": Setting C_BASE_VECTORS to $offset_lmb."
    } elseif {$found_other} {
      set_property CONFIG.C_BASE_VECTORS $offset_other $cell
      bd::send_msg -of $cellpath -type INFO -msg_id 9 -text ": Setting C_BASE_VECTORS to $offset_other."
    }
  }

  # C_BASE_VECTORS: Check that 7 LSB are 0 and that memory mapped at the base vector exists
  set base_vectors [get_property "CONFIG.C_BASE_VECTORS" $cell]
  if {($base_vectors & 0x7f) != 0} {
    bd::send_msg -of $cellpath -type WARNING -msg_id 8 -text ": The 7 least significant bits of C_BASE_VECTORS = $base_vectors should be set to 0."
  }

  set found 0
  set mb_addr_seg_list [get_bd_addr_segs -of_objects $master_cell]
  foreach mb_addr_seg $mb_addr_seg_list {
    set offset [get_property OFFSET $mb_addr_seg]
    set range  [get_property RANGE  $mb_addr_seg]
    if {$base_vectors >= $offset && ($base_vectors + 0x4f) < ($offset + $range)} {
      set found 1
      break
    }
  }
  if {! $found && $lockstep_select < 2} {
    set addr_size [get_property CONFIG.C_ADDR_SIZE $cell]
    set nibbles   [expr ($addr_size + 3) / 4]
    set base [format "0x%0${nibbles}lX" $base_vectors]
    set high [format "0x%0${nibbles}lX" [expr $base_vectors + 0x4f]]
    bd::send_msg -of $cellpath -type WARNING -msg_id 9 -text ": MicroBlaze V needs to have memory mapped to address range $base - $high. Your processor may function incorrectly without this memory. In most cases this memory would be local memory, connected to the Data and Instruction Local Memory Bus (LMB)."
  }

  # C_PC_WIDTH
  if {! [string equal [get_property CONFIG.C_PC_WIDTH.VALUE_SRC $master_cell] "USER"]} {
    set addr_segs {}
    set mb_addr_segs [get_bd_addr_segs -of_objects $master_cell]
    foreach mb_addr_seg $mb_addr_segs {
      set usage    [get_property USAGE   $mb_addr_seg]
      set memtype  [get_property MEMTYPE $mb_addr_seg]
      set is_mem   [string equal $usage   "memory"]
      set is_instr [string equal $memtype "instruction"]
      set is_both  [string equal $memtype "both"]
      if { $is_mem && ($is_instr || $is_both) } {
        lappend addr_segs [list [get_property OFFSET $mb_addr_seg] [get_property RANGE $mb_addr_seg]]
      }
    }
    if {[llength $addr_segs] > 0} {
      set width 32
      set addr_segs    [lsort -integer -index 0 $addr_segs]
      set min_addr_seg [lindex $addr_segs 0]
      set max_addr_seg [lindex $addr_segs end]
      set min_addr     [lindex $min_addr_seg 0]
      set max_addr     [expr [lindex $max_addr_seg 0] + [lindex $max_addr_seg 1] - 1]
      set xor_addr     [expr $min_addr ^ $max_addr]
      for {set bit 31} {$bit > 0} {incr bit -1} {
        if { ($xor_addr >> $bit) != 0} {
	  set width [expr $bit + 1]
          break
        }
      }
      set_property CONFIG.C_PC_WIDTH $width $cell
      bd::send_msg -of $cellpath -type INFO -msg_id 23 -text ": Setting C_PC_WIDTH to $width."
    }
  }

  # C_LOCKSTEP_SLAVE
  if {$lockstep_select >= 2 && $master_cell != $cell} {
    set params [list_property $master_cell]

    # Do not check constant parameters, C_INSTANCE and C_LOCKSTEP_SLAVE
    set checked_params { "HW_VER" \
      "C_FREQ" "C_FAMILY" "C_AVOID_PRIMITIVES" "C_FAULT_TOLERANT" "C_ECC_USE_CE_EXCEPTION"         \
      "C_OPTIMIZATION" "C_INTERCONNECT" "C_M_AXI_DP_DATA_WIDTH"                                    \
      "C_FSL_LINKS" "C_USE_EXTENDED_FSL_INSTR" "C_FSL_EXCEPTION"                                   \
      "C_M_AXI_DP_PROTOCOL" "C_M_AXI_DP_EXCLUSIVE_ACCESS" "C_M_AXI_IP_DATA_WIDTH"                  \
      "C_DEBUG_ENABLED" "C_NUMBER_OF_PC_BRK" "C_NUMBER_OF_RD_ADDR_BRK"                             \
      "C_NUMBER_OF_WR_ADDR_BRK" "C_INTERRUPT_IS_EDGE" "C_EDGE_IS_POSITIVE" "C_ICACHE_BASEADDR"     \
      "C_ICACHE_HIGHADDR" "C_USE_ICACHE" "C_ICACHE_BYTE_SIZE"                                      \
      "C_ICACHE_LINE_LEN" "C_ICACHE_VICTIMS" "C_ICACHE_STREAMS"                                    \
      "C_ICACHE_FORCE_TAG_LUTRAM" "C_ICACHE_DATA_WIDTH" "C_M_AXI_IC_DATA_WIDTH"                    \
      "C_DCACHE_BASEADDR" "C_DCACHE_HIGHADDR" "C_USE_DCACHE"                                       \
      "C_DCACHE_BYTE_SIZE" "C_DCACHE_LINE_LEN"                                                     \
      "C_DCACHE_USE_WRITEBACK" "C_DCACHE_VICTIMS" "C_DCACHE_FORCE_TAG_LUTRAM"                      \
      "C_DCACHE_DATA_WIDTH" "C_M_AXI_DC_DATA_WIDTH" "C_M_AXI_DC_EXCLUSIVE_ACCESS" "C_USE_MMU"      \
      "C_USE_INTERRUPT" "C_USE_EXT_BRK" "C_USE_EXT_NM_BRK" "C_USE_NON_SECURE"                      \
      "C_USE_BRANCH_TARGET_CACHE" "C_BRANCH_TARGET_CACHE_SIZE" }

    set checked_bus_params { "C_D_AXI" "C_D_LMB" "C_I_AXI" "C_I_LMB" }

    foreach param $params {
      if {[string first "CONFIG." $param] == 0} {
        set param_name   [string range $param 7 end]
        set master_value [get_property $param $lockstep_master]
        set slave_value  [get_property $param $cell]
        if {($slave_value != $master_value && [lsearch -exact $checked_params $param_name]     != -1) ||
            ($slave_value <  $master_value && [lsearch -exact $checked_bus_params $param_name] != -1) } {
          bd::send_msg -of $cellpath -type WARNING -msg_id 4 -text ": Parameter mismatch for RISC-V lockstep slave: ${param_name} = ${slave_value} changed to ${master_value}. Please update the parameter to the correct value."
        }
      }
    }
  }

  # C_DEBUG_ENABLED
  set debug_enabled [get_property CONFIG.C_DEBUG_ENABLED $cell]
  if {$debug_enabled > 0} {
    set mb_bif   [get_bd_intf_pins -quiet $cellpath/DEBUG]
    set mdm_bif  [find_bd_objs -quiet -thru_hier -relation connected_to $mb_bif]
    set mdm_cell [get_bd_cells -quiet -of_objects $mdm_bif]
    if {[string length $mdm_cell] > 0} {
      set mdm_vlnv [get_property VLNV $mdm_cell]
      if {[string first riscv $mdm_vlnv] < 0} {
        bd::send_msg -of $cellpath -type ERROR -msg_id 26 -text ": The connected debug module is not MDM V."
      }
    }
  }
}

# Get and adjust cache range or offset
proc adjusted_property { name obj width } {
  return [expr ([get_property $name $obj] >> 4) & ((1 << $width) - 1)]
}

# Get an address segment list given a list of bus interface names
# - Prune segments also visible from prune bus interface name
# - Prune segments with name matching prune segment name (such as "Reg"),
#   but don't prune external ports with usage set to memory
proc get_seg_list { cellpath x width bif_names {prune_bif_name ""} {prune_seg_name ""}} {
  set seg_list {}
  foreach bif_name $bif_names {
    set bif "${cellpath}/${bif_name}"
    set mb_bif [get_bd_intf_pins $bif]
    set mb_seg_list [get_bd_addr_segs -of_objects $mb_bif]
    array set exp {D Data I Instruction}
    foreach mb_seg $mb_seg_list {
      if {[regexp $exp($x) $mb_seg]} {
        set offset [adjusted_property OFFSET $mb_seg $width]
        set range  [adjusted_property RANGE  $mb_seg $width]
        set next   [expr $offset + $range]
        if {$prune_bif_name != ""} {
          set prune_bif       [get_bd_intf_pins ${cellpath}/${prune_bif_name}]
          set prune_slaveifs  [find_bd_obj -quiet -relation ADDRESSABLE_SLAVE $prune_bif]
          set prune_slavesegs [get_bd_addr_segs -of_objects $prune_slaveifs]
          set prune_segs      [get_bd_addr_segs -of_objects $prune_slavesegs]
          if {[lsearch -exact "$prune_segs" $mb_seg] >= 0} { continue }
        }
        if {$prune_seg_name != ""} {
          set prune_slaveseg [get_bd_addr_segs -of_objects $mb_seg]
          set prune_slaveseg_name [get_property NAME $prune_slaveseg]
          set prune_slaveseg_usage [get_property USAGE $prune_slaveseg]
          set prune_slaveseg_port [get_bd_intf_ports -quiet -of_objects $prune_slaveseg]
          set match [string equal $prune_slaveseg_name $prune_seg_name]
          set is_memory [string equal $prune_slaveseg_usage "memory"]
          set is_memory_port [expr $is_memory && [string length $prune_slaveseg_port] > 0]
          if {$match && !$is_memory_port} { continue }
        }
        if {([get_property OFFSET $mb_seg] >> ($width + 4)) != 0} { continue }
        lappend seg_list [list $offset $next $range $bif_name $mb_seg]
      }
    }
  }
  return $seg_list
}

# Get cache address ranges that do not overlap with other address segments
proc get_cache_ranges { other_seg_list cache_seg_list base next width} {
  # Check for overlap
  foreach seg $other_seg_list {
    set seg_base [lindex $seg 0]
    set seg_next [lindex $seg 1]
    if {$seg_base <= $base && $seg_next >= $next} {
      # Complete overlap
      return {}
    } elseif {($seg_base <= $base && $seg_next >  $base) ||
              ($seg_base <  $next && $seg_next >= $next) ||
              ($seg_base >  $base && $seg_next <  $next)} {
      # Low end, high end or internal overlap - handle each range recursively
      set base_high [expr $next - ($next - $base) / 2]
      set next_low  [expr $base + ($next - $base) / 2]
      set low_list  [get_cache_ranges $other_seg_list $cache_seg_list $base      $next_low $width]
      set high_list [get_cache_ranges $other_seg_list $cache_seg_list $base_high $next     $width]
      return [concat $low_list $high_list]
    }
  }

  # Check if reduced address range overlaps with any cache address segment
  set overlap 0
  foreach seg $cache_seg_list {
    set seg_base [lindex $seg 0]
    set seg_next [lindex $seg 1]
    if {! ($seg_base >= $next || $seg_next <= $base)} {
      set overlap_base $seg_base
      set overlap_next $seg_next
      set overlap_invalid [invalid_cache_addr $seg_base [expr $seg_next - 1] $width]
      incr overlap
    }
  }
  if {$overlap == 1 && ! $overlap_invalid} {
    set size [expr $overlap_next - $overlap_base]
    return [list [list $overlap_base $overlap_next $size]]
  } elseif {$overlap > 0} {
    set size [expr $next - $base]
    return [list [list $base $next $size]]
  }
  return {}
}

# Determine power-of-two for the range defined by base and next
proc power_of_two { base next width op {bit 0}} {
  if {$bit != 0} { upvar $bit b }

  set p2 1
  set size [expr $next - $base]
  set b 0
  while {$b < $width} {
    if [expr $p2 $op $size] { break }
    set p2 [expr 2 * $p2]
    incr b
  }
  return $p2
}

# Determine first bit set
proc first_bit_set { value width } {
  for {set n 0} {$n < $width} {incr n} {
    if {$value & 1} { return $n }
    set value [expr $value >> 1]
  }
  return $n
}

# Check if cache addresses are invalid
proc invalid_cache_addr { base high width} {
  set max [expr 2 ** $width - 1]
  if {$base == 0 && $high == $max} { return 0 }
  set next [expr $high + 1]
  set p2 [power_of_two $base $next $width "==" n]
  if {$n == $width || ($base & ($p2 - 1)) != 0} { return 1 }
  return 0
}

# Perform cache address design rule checks
proc check_cache_addr { cell x cache_seg_list other_seg_list base high userbase userhigh width {msg 1}} {
  if {$base > $high} {
    return 0
  }

  if {$userbase && $userhigh} {
    set text "To resolve this issue change user assigned parameters C_${x}CACHE_BASEADDR and C_${x}CACHE_HIGHADDR, or modify the address map."
  } elseif {$userbase} {
    set text "To resolve this issue change user assigned parameter C_${x}CACHE_BASEADDR, assign C_${x}CACHE_HIGHADDR manually, or modify the address map."
  } elseif {$userhigh} {
    set text "To resolve this issue assign C_${x}CACHE_BASEADDR manually, change user assigned parameter C_${x}CACHE_HIGHADDR or modify the address map."
  } else {
    set text "To resolve this issue assign parameters C_${x}CACHE_BASEADDR and C_${x}CACHE_HIGHADDR manually, or modify the address map."
  }

  set result 1
  set nibbles  [expr ($width + 3) / 4]
  set baseaddr [format "0x%0${nibbles}lX0" $base]
  set highaddr [format "0x%0${nibbles}lXF" $high]
  set next [expr $high + 1]
  if {! ($base == 0 && $high == (2 ** $width - 1))} {
    set p2 [power_of_two $base $next $width "==" n]
    if {$n == $width} {
      if {$msg} { bd::send_msg -of $cell -type ERROR -msg_id 10 -text  ": ${x}-cache cacheable segment size defined by ${baseaddr} - ${highaddr} must be a power-of-two. $text" }
      return 0
    }
    if {($base & ($p2 - 1)) != 0} {
      set bits [expr $n + 4]
      if {$bits < $width + 4} {
        if {$msg} { bd::send_msg -of $cell -type ERROR -msg_id 11 -text  ": The ${x}-cache ${bits} least significant bits of the base address ${baseaddr} are not zero, which must be the case when the cacheable segment size is 2^${bits}. $text" }
      } else {
        if {$msg} { bd::send_msg -of $cell -type ERROR -msg_id 11 -text  ": The ${x}-cache base address ${baseaddr} is not zero, which must be the case when the cacheable segment size is 2^${bits}. $text" }
      }
      return 0
    }
  }

  # Check cache size
  if {$x == "D"} {
    set cache_size [get_property CONFIG.C_DCACHE_BYTE_SIZE $cell]
  } else {
    set cache_size [get_property CONFIG.C_ICACHE_BYTE_SIZE $cell]
  }
  if {$cache_size > $highaddr - $baseaddr + 1} {
    if {$msg} { bd::send_msg -of $cell -type ERROR -msg_id 20 -text  ": The ${x}-cache cacheable segment size defined by base address ${baseaddr} and high address ${highaddr} cannot be less than the cache size $cache_size. $text" }
    return 0
  }

  # Check overlapping other address ranges
  foreach seg $other_seg_list {
    set seg_base [lindex $seg 0]
    set seg_next [lindex $seg 1]
    set seg_name [lindex $seg 3]
    set seg_baseaddr [format "0x%0${nibbles}lX0" $seg_base]
    set seg_highaddr [format "0x%0${nibbles}lXF" [expr $seg_next - 1]]
    if {$base <= $seg_base && $next >= $seg_next} {
      # Complete overlap
      if {$msg} { bd::send_msg -of $cell -type WARNING -msg_id 12 -text  ": The ${x}-cache cacheable segment ${baseaddr} - ${highaddr} overlaps with the $seg_name segment ${seg_baseaddr} - ${seg_highaddr}, which prevents this $seg_name segment from being accessed by RISC-V. $text" }
    } elseif {($base <= $seg_base && $next >  $seg_base) || \
              ($base <  $seg_next && $next >= $seg_next)} {
      # Partial overlap
      if {$msg} { bd::send_msg -of $cell -type WARNING -msg_id 13 -text  ": The ${x}-cache cacheable segment ${baseaddr} - ${highaddr} partly overlaps with the $seg_name segment ${seg_baseaddr} - ${seg_highaddr}, which prevents part of this $seg_name segment from being accessed by RISC-V. $text" }
    }
  }

  # Check non-overlapping cache address ranges
  foreach seg $cache_seg_list {
    set seg_base [lindex $seg 0]
    set seg_next [lindex $seg 1]
    set seg_name [lindex $seg 3]
    set seg_baseaddr [format "0x%0${nibbles}lX0" $seg_base]
    set seg_highaddr [format "0x%0${nibbles}lXF" [expr $seg_next - 1]]
    if {$seg_base >= $next || $seg_next <= $base} {
      # No overlap
      if {$msg} { bd::send_msg -of $cell -type WARNING -msg_id 14 -text  ": The ${x}-cache cacheable segment ${baseaddr} - ${highaddr} does not include the $seg_name segment ${seg_baseaddr}-${seg_highaddr}, which prevents this $seg_name segment from being accessed by the cache. $text" }
    } elseif {($seg_base < $base && $seg_next > $base) || \
              ($seg_base > $base && $seg_next > $next)} {
      # Partial overlap
      if {$msg} { bd::send_msg -of $cell -type WARNING -msg_id 15 -text  ": The ${x}-cache cacheable segment ${baseaddr} - ${highaddr} only partly includes the $seg_name segment ${seg_baseaddr} - ${seg_highaddr}, which prevents part of this $seg_name segment from being accessed by the cache. $text" }
    }
  }

  return 1
}

# Do a numeric decreasing sort on list index
# Replaces "lsort -index 2 -decreasing -integer" to avoid error on Windows
proc sort {lst {index 2}} {
  for {set i 1} {$i < [llength $lst]} {incr i} {
    set item [lindex $lst $i]
    set val [lindex $item $index]
    set j [expr $i - 1]
    while {$j >= 0 && [lindex [lindex $lst $j] $index] < $val} {
      lset lst [expr $j + 1] [lindex $lst $j]
      incr j -1
    }
    lset lst [expr $j + 1] $item
  }
  return $lst
}

# Set C_xCACHE_BASEADDR and C_xCACHE_HIGHADDR from address segments (if no user override)
proc set_cache_addr { cell master_cell x {cache_ok 1}} {
  set use_cache [get_property CONFIG.C_USE_${x}CACHE $cell]
  if {! $use_cache} { return 1 }

  # Set address size and width
  # Data: C_ADDR_SIZE
  # Instruction: C_ADDR_SIZE if C_USE_MMU = 3 or C_DATA_SIZE = 64
  set addr_size 32
  set use_mmu [get_property CONFIG.C_USE_MMU $cell]
  set data_size [get_property CONFIG.C_DATA_SIZE $cell]
  if {$x == "D"} {
    set addr_size [get_property CONFIG.C_ADDR_SIZE $cell]
  } elseif {$use_mmu == 3 || $data_size == 64} {
    set addr_size [get_property CONFIG.C_ADDR_SIZE $cell]
  }
  set width [expr $addr_size - 4]

  # Get segments for this interface and other interfaces
  # - Exclude register segments from cache segment list
  # - Exclude cache interfaces from other segment list
  set cache_seg_list [get_seg_list $master_cell $x $width "M_AXI_${x}C M_ACE_${x}C MON_AXI_${x}C MON_ACE_${x}C" "" "Reg"]
  set other_seg_list [get_seg_list $master_cell $x $width "${x}LMB M_AXI_${x}P MON_${x}LMB MON_AXI_${x}P" "M_AXI_${x}C MON_AXI_${x}C" ""]

  # Check that cache segment list is not empty (no cacheable memory available)
  set userbase [string equal [get_property CONFIG.C_${x}CACHE_BASEADDR.VALUE_SRC $cell] "USER"]
  set userhigh [string equal [get_property CONFIG.C_${x}CACHE_HIGHADDR.VALUE_SRC $cell] "USER"]
  if {[llength $cache_seg_list] == 0} {
    set severity "CRITICAL_WARNING"
    if {$userbase || $userhigh} {
      set severity "WARNING"
    }
    bd::send_msg -of $cell -type $severity -msg_id 24 -text ": No ${x}-cache cacheable memory was found in the address space. Please either turn off the cache, add an IP core with cacheable memory to the design, or set external port address segment usage to memory."
    return 0
  }

  # Determine smallest range encompassing all cache segments
  set base [expr 2 ** $width - 1]
  set next 0x1
  foreach seg $cache_seg_list {
    set seg_base [lindex $seg 0]
    set seg_next  [lindex $seg 1]
    if {$seg_base < $base} { set base $seg_base }
    if {$seg_next > $next} { set next $seg_next }
  }

  # Adjust range to nearest power-of-two
  set p2 [power_of_two $base $next $width ">="]
  set base [expr $base & (2 ** $width - $p2)]
  set next [expr $base + $p2]

  # Find largest cache range without overlap with other interfaces,
  # Pick largest cache address segment if none found
  set cache_range {}
  set cache_ranges [get_cache_ranges $other_seg_list $cache_seg_list $base $next $width]
  if {[llength $cache_ranges] > 0} {
    set cache_range [lindex [sort $cache_ranges] 0]
  } elseif {[llength $cache_seg_list] > 0} {
    set cache_range [lindex [sort $cache_seg_list] 0]
  }

  # Set values from range if found
  if {[llength $cache_range] > 0} {
    set base [lindex $cache_range 0]
    set next [lindex $cache_range 1]
  } else {
    set base [expr 2 ** $width - 1]
    set next 0x1
  }

  # Handle user assignment and set cache addresses
  set high [expr $next - 1]

  if {$userbase} {
    set base [expr ([get_property CONFIG.C_${x}CACHE_BASEADDR $cell] >> 4) & (2 ** $width - 1)]
  }
  if {$userhigh} {
    set high [expr ([get_property CONFIG.C_${x}CACHE_HIGHADDR $cell] >> 4) & (2 ** $width - 1)]
  }

  # Adjust base or high to be a valid power-of-two
  if {[invalid_cache_addr $base $high $width]} {
    if {! $userbase && $userhigh} {
      set fbs [first_bit_set [expr $high + 1] $width]
      set base [expr $high - ((1 << $fbs) - 1)]
    }
    if {$userbase && ! $userhigh} {
      set fbs [first_bit_set $base $width]
      set high [expr $base + ((1 << $fbs) - 1)]
    }
  }

  # Check for no overlap between D and I and adjust if possible
  set use_dcache [get_property CONFIG.C_USE_DCACHE $cell]
  if {$x == "I" && $use_dcache && $cache_ok} {
    set dbase [expr [get_property CONFIG.C_DCACHE_BASEADDR $cell] >> 4]
    set dhigh [expr [get_property CONFIG.C_DCACHE_HIGHADDR $cell] >> 4]
    if {(($dbase >> 28) == 0) && (($dhigh >> 28) == 0) && ($base > $dhigh || $high < $dbase)} {
      set ok [check_cache_addr $cell $x $cache_seg_list $other_seg_list $dbase $dhigh $userbase $userhigh $width 0]
      if {$ok} {
        set base $dbase
        set high $dhigh
      }
    }
  }

  set ok [check_cache_addr $cell $x $cache_seg_list $other_seg_list $base $high $userbase $userhigh $width]
  set nibbles  [expr ($width + 3) / 4]
  set highaddr [format "0x%0${nibbles}lXF" $high]
  set baseaddr [format "0x%0${nibbles}lX0" $base]
  if {$ok && $userbase} {
    set_property -quiet CONFIG.C_${x}CACHE_HIGHADDR $highaddr $cell
  }
  if {$ok && $userhigh} {
    set_property -quiet CONFIG.C_${x}CACHE_BASEADDR $baseaddr $cell
  }
  if {$ok && ! $userbase && ! $userhigh} {
    set_property -quiet -dict [list CONFIG.C_${x}CACHE_BASEADDR $baseaddr CONFIG.C_${x}CACHE_HIGHADDR $highaddr] $cell
    bd::send_msg -of $cell -type INFO -msg_id 16 -text  ": Setting ${x}-cache cacheable area base address C_${x}CACHE_BASEADDR to ${baseaddr} and high address C_${x}CACHE_HIGHADDR to ${highaddr}."
  } elseif {$ok && ! $userhigh} {
    bd::send_msg -of $cell -type INFO -msg_id 16 -text  ": Setting ${x}-cache cacheable area high address C_${x}CACHE_HIGHADDR to ${highaddr}. The user assigned base address C_${x}CACHE_BASEADDR is set to ${baseaddr}."
  } elseif {$ok && ! $userbase} {
    bd::send_msg -of $cell -type INFO -msg_id 16 -text  ": Setting ${x}-cache cacheable area base address C_${x}CACHE_BASEADDR to ${baseaddr}. The user assigned high address C_${x}CACHE_HIGHADDR is set to ${highaddr}."
  }

  return $ok
}

proc find_lockstep_master {mb_cell} {
  # Find lockstep master via direct connection through hierarchy
  set connected_pins [find_bd_objs -quiet -thru_hier -relation CONNECTED_TO [get_bd_pins $mb_cell/LOCKSTEP_SLAVE_IN]]
  if {[llength $connected_pins] == 1} {
    set connected_cell [get_bd_cells -quiet -of_object $connected_pins]
    if {$connected_cell != $mb_cell} {
      return $connected_cell
    }
  }

  # Find lockstep master by tracing the LOCKSTEP_Out connection
  set lockstep_masters {}
  set connected_pins [find_bd_objs -quiet -thru_hier -relation CONNECTED_TO [get_bd_pins /$mb_cell/LOCKSTEP_Out]]
  foreach connected_pin $connected_pins {
    set comparator_cell [get_bd_cells -quiet -of_objects $connected_pin]
    set comparator_pins [get_bd_pins -quiet $comparator_cell/LOCKSTEP*]
    foreach comparator_pin $comparator_pins {
      set other_connected_pin [find_bd_objs -quiet -thru_hier -relation CONNECTED_TO $comparator_pin]
      if {[string length $other_connected_pin] > 0} {
        set other_mb_cell [get_bd_cells -quiet -of_objects $connected_pin]
        if {$other_mb_cell != $mb_cell} {
          set other_lockstep_select [get_property "CONFIG.C_LOCKSTEP_SELECT" $other_mb_cell]
          if {"$other_lockstep_select" == "1"} {
            lappend lockstep_masters $other_mb_cell
          }
        }
      }
    }
  }
  set lockstep_master ""
  foreach master $lockstep_masters {
    if {[string length $lockstep_master] == 0} {
      set lockstep_master $master
    }
    if {$lockstep_master != $master} {
      set lockstep_master ""
      break
    }
  }
  if {[string length $lockstep_master] > 0} {
    return $lockstep_master
  }

  # Find lockstep master by finding only other master MicroBlaze RISC-V core
  set mb_cells [get_bd_cells -hierarchical -filter {VLNV=~xilinx.com:ip:microblaze_riscv:*} *]
  set lockstep_masters {}
  foreach cell $mb_cells {
    if {$cell != $mb_cell} {
      set other_lockstep_select [get_property "CONFIG.C_LOCKSTEP_SELECT" $cell]
      if {"$other_lockstep_select" == "1"} {
        lappend lockstep_masters $cell
      }
    }
  }
  if {[llength $lockstep_masters] == 1} {
    return [lindex $lockstep_masters 0]
  }

  return $mb_cell
}
