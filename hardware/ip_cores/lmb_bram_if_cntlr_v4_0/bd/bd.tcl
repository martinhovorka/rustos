###############################################################################
# (c) Copyright 2012-2015,2019,2022-2025 Advanced Micro Devices, Inc. All rights reserved.
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
## lmb_bram_if_cntlr_v4_0/bd/bd.tcl
##
###############################################################################

proc init { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  set bif [get_bd_intf_pins -regexp "$cellpath/SLMB"]
  set_property BD_ATTRIBUTE.FUNCTION BRAM_CTRL $bif

  bd::mark_propagate_only $cell {C_BASEADDR C_HIGHADDR}
  bd::mark_propagate_overrideable $cell {C_MASK C_MASK1 C_MASK2 C_MASK3 C_MASK4 C_MASK5 C_MASK6 C_MASK7}
}

proc post_config_ip { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]

  set num_lmb [get_property CONFIG.C_NUM_LMB $cell]
  foreach index {1 2 3 4 5 6 7} {
    set slmb SLMB$index
    if {$index >= $num_lmb} { break }
    set bif [get_bd_intf_pins -regexp "$cellpath/$slmb"]
    set_property BD_ATTRIBUTE.FUNCTION BRAM_CTRL $bif
  }
}

proc pre_propagate {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # Set range for BRAM_PORT to indicate memory size from SLMB
  set slave_seg [get_bd_addr_segs $cellpath/SLMB/Mem]
  set master_segs [get_bd_addr_segs -quiet -of_object $slave_seg]
  if {[string length $master_segs] > 0} {
    set slmb_base 0xFFFFF
    set slmb_high 0
    foreach master_seg $master_segs {
      set offset [expr ([get_property offset $master_seg] >> 12) & 0xFFFFF]
      set range  [expr ([get_property range  $master_seg] >> 12) & 0xFFFFF]
      set high   [expr $offset + $range - 1]
      if {$slmb_base > $offset} { set slmb_base $offset }
      if {$slmb_high < $high}   { set slmb_high $high   }
    }
    set range [expr ($slmb_high - $slmb_base + 1) << 12]
    set bram_busif [get_bd_intf_pins $cellpath/BRAM_PORT]
    set_property CONFIG.MEM_SIZE $range $bram_busif
  }
}

proc propagate {cellpath otherInfo} {
  # standard parameter propagation
  set cell [get_bd_cells $cellpath]

  # C_S_AXI_CTRL_ACLK_FREQ_HZ
  set freq [get_property -quiet CONFIG.FREQ_HZ [get_bd_pins $cell/S_AXI_CTRL_ACLK]]
  set interconnect [get_property CONFIG.C_INTERCONNECT $cell]
  if {[string length $freq] > 0 && $freq != 0 && $interconnect == 2} {
    set_property -quiet CONFIG.C_S_AXI_CTRL_ACLK_FREQ_HZ $freq $cell
  }

  # C_LMB_AWIDTH, C_LMB_DWIDTH, C_LMB_PROTOCOL, C_LMB_HAS_PROT
  set max_lmb_awidth 32
  set max_lmb_dwidth 32
  set lmb_protocol   0
  set lmb_has_prot   0
  set num_lmb [get_property "CONFIG.C_NUM_LMB" $cell]
  foreach slmb {SLMB SLMB1 SLMB2 SLMB3 SLMB4 SLMB5 SLMB6 SLMB7} {
    set busif [get_bd_intf_pins -quiet $cellpath/${slmb}]
    set addr_width [get_property -quiet "CONFIG.ADDR_WIDTH" $busif]
    if {[string length $addr_width] > 0} {
      set max_lmb_awidth [expr $max_lmb_awidth > $addr_width ? $max_lmb_awidth : $addr_width]
    }
    set data_width [get_property -quiet "CONFIG.DATA_WIDTH" $busif]
    if {[string length $data_width] > 0} {
      set max_lmb_dwidth [expr $max_lmb_dwidth > $data_width ? $max_lmb_dwidth : $data_width]
    }
    set protocol [get_property -quiet "CONFIG.PROTOCOL" $busif]
    if {[string length $protocol] > 0} {
      set protocol [string equal "$protocol" "FREQUENCY"]
      set lmb_protocol [expr $lmb_protocol > $protocol ? $lmb_protocol : $protocol]
    }
    set has_prot [get_property -quiet "CONFIG.HAS_PROT" $busif]
    if {[string length $has_prot] > 0} {
      set lmb_has_prot [expr $lmb_has_prot > $has_prot ? $lmb_has_prot : $has_prot]
    }
  }
  set_property CONFIG.C_LMB_AWIDTH   $max_lmb_awidth $cell
  set_property CONFIG.C_LMB_DWIDTH   $max_lmb_dwidth $cell
  set_property CONFIG.C_LMB_PROTOCOL $lmb_protocol   $cell
  set_property CONFIG.C_LMB_HAS_PROT $lmb_has_prot   $cell

  # Set ECC configuration
  set bram_busif [get_bd_intf_pins $cellpath/BRAM_PORT]
  set ecc [get_property CONFIG.C_ECC $cell]
  if {$ecc && $max_lmb_dwidth <= 32} {
    set_property CONFIG.MEM_ECC "ECCH32-7" $bram_busif
  } elseif {$ecc && $max_lmb_dwidth > 32} {
    set_property CONFIG.MEM_ECC "ECCH64-8" $bram_busif
  } else {
    set_property CONFIG.MEM_ECC "NONE" $bram_busif
  }

  # Set width for BRAM_PORT to indicate memory size from SLMB
  set_property CONFIG.MEM_WIDTH [expr $max_lmb_dwidth + 8 * $ecc] $bram_busif
}

proc set_base_high {cell} {
  # Get slave interfaces and slave segments
  set vSlvBifs [get_bd_intf_pins -of_object $cell -quiet -filter {Mode == "Slave" && Name =~ "SLMB*"}]
  set vSlvSegs [get_bd_addr_segs -of_objects $vSlvBifs]

  # Set base and high for each slave segment
  foreach slvSeg $vSlvSegs {
    ::bd::addr::cfg_base_high_of_slv $cell $slvSeg 0xFFFFFFFFFFFFFFFF 0x0000000000000000
  }
}

proc post_propagate {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]

  # Calculate C_MASK
  set lmb_awidth [get_property CONFIG.C_LMB_AWIDTH $cell]
  set num_lmb [get_property CONFIG.C_NUM_LMB $cell]
  foreach index {0 1 2 3 4 5 6 7} \
          mask {C_MASK C_MASK1 C_MASK2 C_MASK3 C_MASK4 C_MASK5 C_MASK6 C_MASK7} \
          slmb {SLMB SLMB1 SLMB2 SLMB3 SLMB4 SLMB5 SLMB6 SLMB7} {
    if {$index >= $num_lmb} { break }
    set value_src [get_property CONFIG.${mask}.VALUE_SRC $cell]
    if {$value_src == "USER"} {
      set usermask [get_property CONFIG.${mask} $cell]
      catch {
        if [calculate_validate_mask $cellpath $slmb $lmb_awidth $usermask] {
          bd::send_msg -of $cellpath -type WARNING -msg_id 6 -text ": Validation of the user assigned address mask ${mask} = [format {0x%lX} $usermask] failed. This means that the address decode mask assigned may not be valid. Consider using automatic assigment, or ensure that mask bits are set to provide a unique decoding of the LMB address."
        }
      }
    } else {
      set result [calculate_validate_mask $cellpath $slmb $lmb_awidth]
      set_property CONFIG.$mask $result $cell
    }
  }

  # Set C_BASEADDR, C_HIGHADDR
  set_base_high $cell

  # Assign C_BASEADDR (used in code) and C_HIGHADDR (to show in dialog) from SLMB
  set slave_seg [get_bd_addr_segs $cellpath/SLMB/Mem]
  set master_segs [get_bd_addr_segs -quiet -of_object $slave_seg]
  if {[string length $master_segs] > 0} {
    set nibbles   [expr ($lmb_awidth + 3) / 4 - 3]
    set max_value "0x[string repeat F $nibbles]"

    set slmb_base $max_value
    set slmb_high 0
    set slmb_segs {}
    foreach master_seg $master_segs {
      set offset [expr ([get_property offset $master_seg] >> 12) & $max_value]
      set range  [expr ([get_property range  $master_seg] >> 12) & $max_value]
      set high   [expr $offset + $range - 1]
      if {$slmb_base > $offset} { set slmb_base $offset }
      if {$slmb_high < $high}   { set slmb_high $high   }
      tcl::lappend slmb_segs [list $offset $high]
    }
    set_property CONFIG.C_BASEADDR [format "0x%013lX000" $slmb_base] $cell
    set_property CONFIG.C_HIGHADDR [format "0x%013lXFFF" $slmb_high] $cell

    # DRC to check that all used address segments have the same offset and range
    foreach index {1 2 3 4 5 6 7} {
      set slmb SLMB$index
      if {$index >= $num_lmb} { break }

      # Allow different offset when connected to AXI LMB Bridge
      set busif [get_bd_intf_pins -quiet $cell/$slmb]
      set all_bifs [find_bd_objs -quiet -thru_hier -relation connected_to $busif]
      set bif_cells [get_bd_cells -quiet -of_objects $all_bifs]
      set vlnv [get_property -quiet VLNV $bif_cells]
      if {[string first "xilinx.com:ip:axi_lmb_bridge" "$vlnv"] == 0} { break }

      set slave_seg [get_bd_addr_segs $cellpath/$slmb/Mem]
      set master_segs [get_bd_addr_segs -quiet -of_object $slave_seg]
      if {[string length $master_segs] > 0} {
        set slmbx_base $max_value
        set slmbx_high 0
        foreach master_seg $master_segs {
          set offset [expr ([get_property offset $master_seg] >> 12) & $max_value]
          set range  [expr ([get_property range  $master_seg] >> 12) & $max_value]
          set high   [expr $offset + $range - 1]
          if {$slmbx_base > $offset} { set slmbx_base $offset }
          if {$slmbx_high < $high}   { set slmbx_high $high   }
        }
        if {$slmbx_base != $slmb_base} {
          set msg_slmbx_base [format "0x%0${nibbles}lX000" $slmbx_base]
          set msg_slmb_base  [format "0x%0${nibbles}lX000" $slmb_base]
          bd::send_msg -of $cellpath -type ERROR -msg_id 3 -text ": The $slmb address offset ($msg_slmbx_base) must be the same as the SLMB address offset ($msg_slmb_base). Please change either the $slmb or SLMB address offset."
        } elseif {$slmbx_high != $slmb_high} {
          set msg_slmbx_high [format "0x%0${nibbles}lXFFF" $slmbx_high]
          set msg_slmb_high  [format "0x%0${nibbles}lXFFF" $slmb_high]
          bd::send_msg -of $cellpath -type ERROR -msg_id 4 -text ": The $slmb maximum address ($msg_slmbx_high) must be the same as the SLMB maximum address ($msg_slmb_high). Please change either the $slmb or SLMB address settings."
        }
      }
    }

    # DRC to check that all address segments are consecutive
    # Also allow address segments to be identical to handle lockstep configuration
    set slmb_segs [tcl::lsort -integer -index 0 $slmb_segs]
    set slmb_prev_seg [tcl::lindex $slmb_segs 0]
    for {set index 1} {$index < [tcl::llength $slmb_segs]} {incr index} {
      set slmb_seg         [tcl::lindex $slmb_segs $index]
      set slmb_prev_offset [tcl::lindex $slmb_prev_seg 0]
      set slmb_prev_high   [tcl::lindex $slmb_prev_seg 1]
      set slmb_offset      [tcl::lindex $slmb_seg 0]
      set slmb_high        [tcl::lindex $slmb_seg 1]
      if {($slmb_prev_high + 1 != $slmb_offset) && ($slmb_prev_offset != $slmb_offset || $slmb_prev_high != $slmb_high)} {
        set msg_slmb_prev_offset [format "0x%0${nibbles}lX000" $slmb_prev_offset]
        set msg_slmb_offset      [format "0x%0${nibbles}lX000" $slmb_offset]
        bd::send_msg -of $cellpath -type ERROR -msg_id 5 -text ": Address segments with offset $msg_slmb_prev_offset and $msg_slmb_offset are not consecutive. Please change the offset address and/or range of the segments to correct the issue."
      }
      set slmb_prev_seg $slmb_seg
    }

  }
}

proc calculate_validate_mask {cellpath slmb awidth {usermask ""}} {
    set slmb_intf [get_bd_intf_pin $cellpath/$slmb]

    # SLMB knows that it has only 1 addr seg, so in the cmd below, it treats the list as a single addr_seg.
    set slave_addr_seg [get_bd_addr_segs -of_object $slmb_intf]

    # SLMB slave addr seg can be mapped several times. Pick the first element in the returned list
    set master_addr_seg [lindex [get_bd_addr_segs -of_object $slave_addr_seg] 0]
    set master_intf [get_bd_intf_pin -quiet -of_object $master_addr_seg]

    set mb_cell ""
    set lmb_addr_seg_list {}
    set axi_addr_seg_list {}
    foreach master_if $master_intf {
      set addr_space [get_bd_addr_spaces -of_object $master_if]
      set mb_cell [get_bd_cells -of_object $master_if]

      # Check if this processor is a lockstep slave, and fetch the lockstep master processor in that case
      set lockstep_select [get_property "CONFIG.C_LOCKSTEP_SELECT" $mb_cell]
      if {$lockstep_select >= 2} {
        set lockstep_master [find_lockstep_master $mb_cell]
        if {$lockstep_master != $mb_cell} {
          bd::send_msg -of $cellpath -type INFO -msg_id 7 -text ": This controller is connected to a lockstep slave processor ($mb_cell). Address mask for $slmb is calculated from the corresponding lockstep master ($lockstep_master)."
          set busname [string range $master_if end-3 end]
          set lockstep_if [get_bd_intf_pins $lockstep_master/$busname]
          set addr_space [get_bd_addr_spaces -of_object $lockstep_if]
          set mb_cell $lockstep_master
        } else {
          bd::send_msg -of $cellpath -type WARNING -msg_id 8 -text ": This controller is connected to a lockstep slave processor ($mb_cell), but the corresponding lockstep master could not be found. Address mask for $slmb must be defined manually from the lockstep master value."
        }
      }

      # Find MDM or MDM V AXI interface (if any)
      set mdm_cell [get_bd_cells -of_object $master_if]
      set mdm_vlnv [get_property VLNV $mdm_cell]
      set mdm_intf_list {}
      if {[string first "ip:mdm" $mdm_vlnv] > 0} {
        set mdm_intf_list [get_bd_intf_pins -quiet $mdm_cell/M_AXI]
      }

      # Get the LMB and AXI address segments
      set master_intf_list [concat [get_bd_intf_pins -of_object $addr_space] $mdm_intf_list]
      foreach master_intf $master_intf_list {
        set addr_seg_list [get_bd_addr_segs -of_object $master_intf]
        foreach addr_seg $addr_seg_list {
          if {[string first $mb_cell $addr_seg] != -1} {
            if {[string first LMB $master_intf] != -1} {
              lappend lmb_addr_seg_list $addr_seg
            } else {
              lappend axi_addr_seg_list $addr_seg
            }
          }
        }
      }
    }

    # Populate LMB address sequence
    set ipinst_lmbname  ""
    set ipinst_baseaddr 0
    set ipinst_highaddr 0
    set ipinst_bitwidth 0
    set ipinst_name     ""
    set ipinst_lmbname  ""
    set lmbaddrseq {}
    foreach addr_seg $lmb_addr_seg_list {
      set offset [get_property OFFSET $addr_seg]
      set range  [get_property RANGE  $addr_seg]
      set high   [expr $offset + $range - 1]
      set width  [CalculateBitWidth $offset $high $awidth]

      set master_offset [get_property OFFSET $master_addr_seg]
      set master_range  [get_property RANGE  $master_addr_seg]
      if {$master_offset == $offset && $master_range == $range} {
        set busname [string range $master_if end-3 end]
        set ipinst_baseaddr $offset
        set ipinst_highaddr $high
        set ipinst_bitwidth $width
        set ipinst_name     $cellpath
        set ipinst_lmbname  $busname
        lappend lmbaddrseq [list $offset $high $width $cellpath $busname]
      } else {
        lappend lmbaddrseq [list $offset $high $width "" ""]
      }
    }

    # Populate AXI address sequence
    set extaddrseq {}
    foreach addr_seg $axi_addr_seg_list {
      set offset [get_property OFFSET $addr_seg]
      set range  [get_property RANGE  $addr_seg]
      set high   [expr $offset + $range - 1]
      set width  [CalculateBitWidth $offset $high $awidth]
      lappend extaddrseq [list $offset $high $width "" ""]
    }

    # Validate user mask (if any)
    if {[string length $usermask] > 0} {
      set compareec [CompareBitMask $usermask $lmbaddrseq $extaddrseq \
                     $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
      return $compareec
    }

    # Generate Bit Patterns
    set lmbormask [GenerateOrBitPattern $lmbaddrseq $awidth]
    set extormask [GenerateOrBitPattern $extaddrseq $awidth]

    set addrseq   [concat $lmbaddrseq $extaddrseq]
    set allormask [GenerateOrBitPattern $addrseq $awidth]

    # Check if mask is valid. It can be zero if no external bus addresses are used
    check_error [expr $lmbormask == 0 && $extormask == 0 && [llength $extaddrseq] > 0] \
                $cellpath $mb_cell $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr

    # Generate optimized mask
    set optmask [GenerateOptMask $allormask $lmbaddrseq $extaddrseq \
                 $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]

    # Validate final mask
    set compareec [CompareBitMask $optmask $lmbaddrseq $extaddrseq \
                   $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
    check_error [expr $compareec != 0] $cellpath $mb_cell $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr

    return [format "0x%016lx" $optmask]
}

proc CalculateBitWidth {baseaddr highaddr awidth} {
    set bitwidth $awidth
    for {set i 0} {$i < $awidth} {incr i} {
      if {(($baseaddr >> $i) & 1) == (($highaddr >> $i) & 1)} {
        set bitwidth $i
        break
      }
    }
    return $bitwidth
}

proc GenerateOrBitPattern {addrseq awidth} {
  set bitmask 0

  foreach addritr $addrseq {
    set bitwidth $awidth
    set addrand [expr [lindex $addritr 0] & [lindex $addritr 1]]
    set addrxor [expr [lindex $addritr 0] ^ [lindex $addritr 1]]

    set addr_mask 0

    for {set i 0} {$i < $bitwidth} {incr i} {
      set xorbit [expr ($addrxor >> $i) & 1]

      # If bit is 'x', then iterate the next bit
      if {$xorbit == 0} {
        set andbit [expr ($addrand >> $i) & 1]
        if {$andbit == 1} {
          set addr_mask [expr $addr_mask | (1 << $i)]
        }
      }
    }

    set bitmask [expr $bitmask | $addr_mask]
  }
  return $bitmask
}

proc GenerateOptMask {allmask lmbaddrseq extaddrseq \
                      ipinst_name ipinst_lmbname ipinst_baseaddr ipinst_highaddr ipinst_bitwidth awidth} {
    # Create list of bit positions (LSB=0, MSB=$awidth - 1) set to 1 in allmask
    set bitposlist {}
    for {set b $ipinst_bitwidth} {$b < $awidth} {incr b} {
      if {($allmask >> $b) & 1} {
        lappend bitposlist $b
      }
    }

    # Sweep one bit
    foreach bit $bitposlist {
      set mask [expr 1 << $bit]
      set ec [CompareBitMask $mask $lmbaddrseq $extaddrseq \
              $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
      if {$ec == 0} { return $mask }
    }

    # Sweep two bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        set ec [CompareBitMask $mask2 $lmbaddrseq $extaddrseq \
                $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
        if {$ec == 0} { return $mask2 }
      }
    }

    # Sweep three bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        foreach bit3 $bitposlist {
          set mask3 [expr $mask2 | (1 << $bit3)]
          set ec [CompareBitMask $mask3 $lmbaddrseq $extaddrseq \
                  $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
          if {$ec == 0} { return $mask3 }
        }
      }
    }

    # Sweep four bits
    foreach bit1 $bitposlist {
      set mask1 [expr 1 << $bit1]
      foreach bit2 $bitposlist {
        set mask2 [expr $mask1 | (1 << $bit2)]
        foreach bit3 $bitposlist {
          set mask3 [expr $mask2 | (1 << $bit3)]
          foreach bit4 $bitposlist {
            set mask4 [expr $mask3 | (1 << $bit4)]
            set ec [CompareBitMask $mask4 $lmbaddrseq $extaddrseq \
                    $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
            if {$ec == 0} { return $mask4 }
          }
        }
      }
    }

    # Create sweep mask that only includes more significant bits than ipinst_bitwidth
    set sweepmask [expr $allmask & ~((1 << $ipinst_bitwidth) - 1)]

    # Sweep clear four bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        foreach bit3 $bitposlist {
          if {$bit3 == $bit2 || $bit3 == $bit1} { continue }
          set mask3 [expr $mask2 & ~(1 << $bit3)]
          foreach bit4 $bitposlist {
            if {$bit4 == $bit3 || $bit4 == $bit2 || $bit4 == $bit1} { continue }
            set mask4 [expr $mask3 & ~(1 << $bit4)]
            set ec [CompareBitMask $mask4 $lmbaddrseq $extaddrseq \
                    $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
            if {$ec == 0} { return $mask4 }
          }
        }
      }
    }

    # Sweep clear three bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        foreach bit3 $bitposlist {
          if {$bit3 == $bit2 || $bit3 == $bit1} { continue }
          set mask3 [expr $mask2 & ~(1 << $bit3)]
          set ec [CompareBitMask $mask3 $lmbaddrseq $extaddrseq \
                  $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
          if {$ec == 0} { return $mask3 }
        }
      }
    }

    # Sweep clear two bits
    foreach bit1 $bitposlist {
      set mask1 [expr $sweepmask & ~(1 << $bit1)]
      foreach bit2 $bitposlist {
        if {$bit2 == $bit1} { continue }
        set mask2 [expr $mask1 & ~(1 << $bit2)]
        set ec [CompareBitMask $mask2 $lmbaddrseq $extaddrseq \
                $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
        if {$ec == 0} { return $mask2 }
      }
    }

    # Sweep clear one bit
    foreach bit $bitposlist {
      set mask [expr $sweepmask & ~(1 << $bit)]
      set ec [CompareBitMask $mask $lmbaddrseq $extaddrseq \
              $ipinst_name $ipinst_lmbname $ipinst_baseaddr $ipinst_highaddr $ipinst_bitwidth $awidth]
      if {$ec == 0} { return $mask }
    }

    return $sweepmask
}

proc CompareBitMask {mask lmbaddrseq extaddrseq \
                     ipinst_name ipinst_lmbname ipinst_baseaddr ipinst_highaddr ipinst_bitwidth awidth} {
    set ec 0

    foreach lmbaddr $lmbaddrseq {
      set baseaddr [lindex $lmbaddr 0]
      set highaddr [lindex $lmbaddr 1]
      set bitwidth [lindex $lmbaddr 2]
      set ipname   [lindex $lmbaddr 3]
      if {$ipname != $ipinst_name} {
        set unique 0
        for {set i [expr $awidth - 1]} {$i >= $bitwidth} {incr i -1} {
          set maskbit_i [expr $mask & (1 << $i)]
          if {($maskbit_i & $ipinst_baseaddr) != ($maskbit_i & $baseaddr)} {
            set unique 1
          }
        }
        if {(($mask & $ipinst_baseaddr) == ($mask & $baseaddr)) ||
            ((($mask & ($baseaddr ^ $highaddr)) != 0) && ! $unique) || 
            (($mask & ($ipinst_baseaddr ^ $ipinst_highaddr)) != 0) } {
          incr ec
        }
      }
    }

    foreach addritr $extaddrseq {
      set baseaddr [lindex $addritr 0]
      set highaddr [lindex $addritr 1]
      set bitwidth [lindex $addritr 2]

      set comparemask [expr $mask & ~((1 << $bitwidth) - 1)]
      if {($ipinst_baseaddr & $comparemask) == ($baseaddr & $comparemask)} {
        incr ec
      }
    }

    return $ec
}

proc check_error {found_error cellpath mb_cell ipinst_lmbname ipinst_baseaddr ipinst_highaddr} {
    if {$found_error && $mb_cell != "" && $ipinst_lmbname != ""} {
        set bus [string index $ipinst_lmbname 0]
        set use_cache [get_property "CONFIG.C_USE_${bus}CACHE" $mb_cell]
        set cache_baseaddr [get_property "CONFIG.C_${bus}CACHE_BASEADDR" $mb_cell]
        set cache_highaddr [get_property "CONFIG.C_${bus}CACHE_HIGHADDR" $mb_cell]

        if {$use_cache &&
            (($ipinst_baseaddr <  $cache_baseaddr && $ipinst_highaddr >= $cache_baseaddr) ||
             ($ipinst_baseaddr >= $cache_baseaddr && $ipinst_baseaddr <= $cache_highaddr))} {
            bd::send_msg -of $cellpath -type ERROR -msg_id 2 -text ": The ${ipinst_lmbname} address range ([format {0x%lX} $ipinst_baseaddr] - [format {0x%lX} $ipinst_highaddr]) overlaps with the ${bus}cache address range ([format {0x%lX} $cache_baseaddr] - [format {0x%lX} $cache_highaddr]). This means that an address decode mask can not be assigned to the ${ipinst_lmbname} peripheral. Please modify the ${bus}cache address range to remove the overlap."
        } else {
            bd::send_msg -of $cellpath -type ERROR -msg_id 1 -text ": Can not generate mask for the LMB peripherals. An address decode mask is assigned to all LMB peripherals connected to the MicroBlaze processor. The address decode mask is based on a set of decode bits that distinguish the LMB address space from the AXI address space. The error message indicates that a set of decode bits can not be found to generate a mask. Please modify the address map of the slaves connected to AXI to use a common address bit."
        }
    }
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

  # Find lockstep master by finding only other master MicroBlaze core
  set mb_cells [get_bd_cells -hierarchical -filter {VLNV=~xilinx.com:ip:microblaze:*} *]
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
