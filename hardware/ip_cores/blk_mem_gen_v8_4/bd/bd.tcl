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

proc init {cellpath otherInfo} {
  set cell [get_bd_cells $cellpath]
  bd::mark_propagate_overrideable $cell {Enable_32bit_Address}
}

proc pre_propagate {cellName undefined_params } { 
  set ip [get_bd_cells $cellName]
  set busifa [get_bd_intf_pins $cellName/BRAM_PORTA]
  set busifb [get_bd_intf_pins $cellName/BRAM_PORTB]
  set mem_type [get_property CONFIG.MEMORY_TYPE $ip]
  set bmg_mode [get_property CONFIG.use_bram_block $ip]
    if {$mem_type == "Simple_Dual_Port_RAM"} {
       set_property CONFIG.READ_WRITE_MODE "WRITE_ONLY"  $busifa
       set_property CONFIG.READ_WRITE_MODE "READ_ONLY"  $busifb
    } elseif {$mem_type == "Dual_Port_ROM"} {
       set_property CONFIG.READ_WRITE_MODE "READ_ONLY"  $busifa
       set_property CONFIG.READ_WRITE_MODE "READ_ONLY"  $busifb
    } elseif {$mem_type == "Single_Port_ROM"} {
       set_property CONFIG.READ_WRITE_MODE "READ_ONLY"  $busifa
    } elseif {$mem_type == "Single_Port_RAM"} {
       set_property CONFIG.READ_WRITE_MODE "READ_WRITE"  $busifa
    } else {
       set_property CONFIG.READ_WRITE_MODE "READ_WRITE"  $busifa
       set_property CONFIG.READ_WRITE_MODE "READ_WRITE"  $busifb
    }
}


proc post_config_ip {cellName undefined_params} {
  set ip [get_bd_cells $cellName]
  set busif [get_bd_intf_pins $cellName/BRAM_PORTA]
  set busifb [get_bd_intf_pins $cellName/BRAM_PORTB]
  set value_src [get_property CONFIG.WRITE_DEPTH_A.VALUE_SRC $ip]
#  if { [string match -nocase $value_src "user"] eq 1 } {
#     set_property CONFIG.WRITE_DEPTH_A.VALUE_SRC DEFAULT [get_bd_cells $ip]
#  }
#  set value_src [get_property CONFIG.WRITE_DEPTH_A.VALUE_SRC $ip]
  set bmg_mode [get_property CONFIG.use_bram_block $ip]
  set tdp [get_property CONFIG.MEMORY_TYPE $ip]
  if { $bmg_mode == "BRAM_Controller" } {
     set_property CONFIG.MASTER_TYPE "BRAM_CTRL" $busif
     set port_master_type [get_property CONFIG.MASTER_TYPE $busif]
     if { $tdp == "True_Dual_Port_RAM" || $tdp == "Dual_Port_ROM"} {
        set_property CONFIG.MASTER_TYPE "BRAM_CTRL" $busifb
     }

  } else {
     set_property CONFIG.MASTER_TYPE "OTHER" $busif
     set port_master_type [get_property CONFIG.MASTER_TYPE $busif]
     if { $tdp == "True_Dual_Port_RAM" || $tdp == "Dual_Port_ROM"} {
        set_property CONFIG.MASTER_TYPE "OTHER" $busifb
     }
  }
}



proc post_propagate { cellName dictArg } { 
  set ip [get_bd_cells $cellName]
  set bmg_mode [get_property CONFIG.use_bram_block $ip]
  set portIntfA [get_bd_intf_pins $cellName/BRAM_PORTA]
  set portIntfB [get_bd_intf_pins $cellName/BRAM_PORTB]
  set tdp [get_property CONFIG.MEMORY_TYPE $ip]
  set PRIM_type [get_property CONFIG.PRIM_type_to_Implement $ip]

  if {$PRIM_type == "URAM"} {
    bd::send_msg -of $cellName -type WARNING -msg_id 1 -text " Block Memory Generator IP is configured to use UltraRAM, but UltraRAM does not support Memory Initialization, hence elf association or Initialization of the memory through .coe or .mem  files is not possible"
  }

  if {$bmg_mode == "BRAM_Controller" } {
    set mem_addr_mode_a ""
    set mem_width_a 32
    set mem_size_a  8192
    if {$portIntfA != ""} {
      set mem_addr_mode_a [get_property CONFIG.MEM_ADDRESS_MODE $portIntfA]
      set mem_width_a [get_property CONFIG.MEM_WIDTH $portIntfA]
      set mem_size_a  [get_property CONFIG.MEM_SIZE  $portIntfA]
      set mem_ecc_a  [get_property CONFIG.MEM_ECC  $portIntfA]
      set rd_latency_a [get_property CONFIG.READ_LATENCY $portIntfA]
      set_property CONFIG.READ_LATENCY_A $rd_latency_a $ip
    }

    set mem_addr_mode_b ""
    set mem_width_b 32
    set mem_size_b  8192
    if {$portIntfB != ""} {
      set mem_addr_mode_b [get_property CONFIG.MEM_ADDRESS_MODE $portIntfB]
      set mem_width_b [get_property CONFIG.MEM_WIDTH $portIntfB]
      set mem_size_b  [get_property CONFIG.MEM_SIZE $portIntfB]
      set rd_latency_b [get_property CONFIG.READ_LATENCY $portIntfB]
      set_property CONFIG.READ_LATENCY_B $rd_latency_b $ip
    } else {
      set mem_size_b  0
    }

    set mem_addr_mode $mem_addr_mode_a
    if { [string length $mem_addr_mode_a] && [string length $mem_addr_mode_b] && $mem_addr_mode_a ne $mem_addr_mode_b } {
      bd::send_msg -of $cellName -type ERROR -msg_id 1 -text " Embedded Memory Generator requires both ports to use the same address mode (BYTE_ADDRESS vs. WORD_ADDRESS)."
    } elseif { ![string length $mem_addr_mode] } {
      set mem_addr_mode $mem_addr_mode_b
    }
    
    if { $mem_addr_mode eq "BYTE_ADDRESS" } {
      set_property CONFIG.Enable_32bit_Address "true" $ip
    } elseif { $mem_addr_mode eq "WORD_ADDRESS" } {
      set_property CONFIG.Enable_32bit_Address "false" $ip
    } 

    if {$mem_ecc_a != "" } {
      set_property CONFIG.CTRL_ECC_ALGO $mem_ecc_a $ip
    } else {
      set_property CONFIG.CTRL_ECC_ALGO NONE $ip
    }
    if { 0 != [string length $mem_width_a] && $mem_width_a != 0 } {
       set_property CONFIG.WRITE_WIDTH_A $mem_width_a $ip
       set_property CONFIG.READ_WIDTH_A  $mem_width_a $ip
    }

    if { 0 != [string length $mem_size_a] && $mem_size_a != 0 && 
         0 != [string length $mem_size_b] && $mem_size_b != 0 } {
       set mem_size [expr ($mem_size_a > $mem_size_b) ? $mem_size_a : $mem_size_b]
    } elseif { 0 != [string length $mem_size_a] && $mem_size_a != 0} {
       set mem_size $mem_size_a
    } elseif { 0 != [string length $mem_size_b] && $mem_size_b != 0} {
       set mem_size $mem_size_b
    } else {
       set mem_size 0
    }

    if { $mem_size != 0 && 0 != [string length $mem_width_a] && $mem_width_a != 0 } {
       set value_src [get_property CONFIG.WRITE_DEPTH_A.VALUE_SRC $ip]
       if { [string match -nocase $value_src "user"] eq 1 } {
          set_property CONFIG.WRITE_DEPTH_A.VALUE_SRC DEFAULT [get_bd_cells $ip]
       }
       set value_src [get_property CONFIG.WRITE_DEPTH_A.VALUE_SRC $ip]

       set mem_depth_a [expr $mem_size / (($mem_width_a / 32) * 4)]
       set_property CONFIG.WRITE_DEPTH_A $mem_depth_a $ip
    }
    if { 0 != [string length $mem_width_b] && $mem_width_b != 0 && $tdp == "True_Dual_Port_RAM"} {
       set_property CONFIG.WRITE_WIDTH_B $mem_width_b $ip
       set_property CONFIG.READ_WIDTH_B  $mem_width_b $ip
    }
    
    # Calculate the depth of Port-B (possible data widths are 32,64)
    if {  ($mem_width_b > $mem_width_a) && ($mem_width_a <= 64 && $mem_width_b <= 64) } {
      set mem_size_b_int [expr $mem_depth_a / 2]     
    } elseif { ($mem_width_b < $mem_width_a) && ($mem_width_a <= 64 && $mem_width_b <= 64)} {
      set mem_size_b_int [expr $mem_depth_a * 2]     
    } else {
        set mem_size_b_int 0
    }

    if { (((($mem_width_a <= 64 && $mem_depth_a > 4096) && $mem_width_b > 64) || (($mem_width_a <= 64 && $mem_depth_a > 4096) && ($mem_width_b <= 64 && ($mem_size_b_int > 0 && $mem_size_b_int <= 4096) )) || (($mem_width_b <= 64 && $mem_size_b_int > 4096) && $mem_width_a > 64) || (($mem_width_b <= 64 && $mem_size_b_int > 4096) && ($mem_width_a <= 64 && $mem_depth_a <= 4096)) || ( ($mem_width_a <= 64 && $mem_width_b <= 64) && ($mem_width_a != $mem_width_b) && ($mem_depth_a > 16384 || $mem_size_b_int > 16384) )) && $tdp == "True_Dual_Port_RAM")} {
      bd::send_msg -of $cellName -type ERROR -msg_id 1 -text "Block Memory Generator v8.3 version currently does not support Asymmetry between two ports in IP Integrator for the selected data widths."
    }

  }
}

