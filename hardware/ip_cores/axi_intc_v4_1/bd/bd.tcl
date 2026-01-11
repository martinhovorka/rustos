# (c) Copyright 2023,2025 Advanced Micro Devices, Inc. All rights reserved.
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
##      axi_intc v4.1
################################################################################

## below API calls are used to mask the user parameters when the core is used in IPI
proc init {cellpath otherInfo } {
        set cell_handle [get_bd_cells $cellpath]

        set paramList "C_NUM_INTR_INPUTS C_IVAR_RESET_VALUE C_ADDR_WIDTH"
        bd::mark_propagate_only $cell_handle $paramList

        set paramList "C_KIND_OF_INTR C_KIND_OF_LVL C_KIND_OF_EDGE C_ENABLE_ASYNC C_ASYNC_INTR"
        bd::mark_propagate_override $cell_handle $paramList
}
################################################################################

## below API is used for propagating the parameters
proc propagate { cellName dictArg } {
    set ip [get_bd_cells $cellName]

    set has_fast [get_property CONFIG.C_HAS_FAST $ip]
    if {$has_fast} {
        # Find out if processor_clk and processor_rst are connected
        set proc_clk        [get_bd_pins -quiet $ip/processor_clk]
        set proc_clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $proc_clk]

        set proc_rst        [get_bd_pins -quiet $ip/processor_rst]
        set proc_rst_driver [find_bd_objs -quiet -thru_hier -relation connected_to $proc_rst]

        set proc_clk_connected [expr [string length $proc_clk_driver] > 0]
        set proc_rst_connected [expr [string length $proc_rst_driver] > 0]
        set proc_connected     [expr $proc_clk_connected && $proc_rst_connected]

        # Check if AXI clock and processor clock are asynchronous
        set proc_async 0
        if {$proc_clk_connected} {
            set axi_clk        [get_bd_pins $ip/s_axi_aclk]
            set axi_clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $axi_clk]

            if {! [string equal "$axi_clk_driver" "$proc_clk_driver"]} {
              set proc_async 1
            }
        }

        # For user selected async mode or async clocks, error if not both processor clock and reset connected
        set enable_async [get_property CONFIG.C_ENABLE_ASYNC $ip]
        set user_async   [string equal "[get_property CONFIG.C_ENABLE_ASYNC.VALUE_SRC $ip]" "USER"]
        set async_mode   [expr ($user_async && $enable_async) || $proc_async]
        if {$async_mode && ! $proc_connected} {
            bd::send_msg -of $cellName -type ERROR -msg_id 2 -text ": Both processor_clk and processor_rst must be connected when using Fast Interrupt Mode with asynchronous clocks."
        }

        # Set async properties if not user selected
        if {! $user_async} {
            if {$proc_async} {
                set_property CONFIG.C_ENABLE_ASYNC 1 $ip
                set_property CONFIG.C_MB_CLK_NOT_CONNECTED 0 $ip
                set_property CONFIG.C_DISABLE_SYNCHRONIZERS 0 $ip
            } else {
                set_property CONFIG.C_ENABLE_ASYNC 0 $ip
                set_property CONFIG.C_MB_CLK_NOT_CONNECTED [expr 1 - $proc_connected] $ip
                set_property CONFIG.C_DISABLE_SYNCHRONIZERS 1 $ip
            }
        }

        # Output information about selected mode
        if {$async_mode} {
            bd::send_msg -of $cellName -type INFO -msg_id 1 -text ": The AXI INTC core has been configured to operate with asynchronous clocks."
        } else {
            bd::send_msg -of $cellName -type INFO -msg_id 1 -text ": The AXI INTC core has been configured to operate with synchronous clocks."
        }
    }
}
################################################################################

# Find connected slave interrupt interfaces through hierarchy
proc get_slave_interfaces { busif } {
  set filter {MODE==Master && VLNV=~xilinx.com:interface:mbinterrupt_rtl:*}

  set all_bifs [find_bd_objs -quiet -thru_hier -relation connected_to $busif]
  set bif_cells [get_bd_cells -quiet -of_objects $all_bifs]

  while {1} {
    set sbifs {}
    foreach bif_cell $bif_cells {
      set mbifs [get_bd_intf_pins -filter $filter -quiet -of_object "$bif_cell"]
      set bifs  [find_bd_objs -quiet -thru_hier -relation connected_to $mbifs]
      foreach bif $bifs {
        if {[lsearch $all_bifs $bif] == -1} { lappend sbifs $bif }
      }
    }
    if {[llength $sbifs] == 0} { break }
    set bif_cells [get_bd_cells -quiet -of_object $sbifs]
    set all_bifs [concat $all_bifs $sbifs]
  }
  return $all_bifs
}
################################################################################

proc post_propagate { cellName dictArg } {
    set ip [get_bd_cells $cellName]

    set intrPin [get_bd_pins ${cellName}/intr]
    set intrDriver [find_bd_objs -thru_hier -relation connected_to $intrPin]
    if { [string length $intrDriver] > 0 } {

       # Update C_NUM_INTR_INPUTS:
       # - Check for propagated PortWidth property
       # - Check for vector ports and pins on driver
       # - Assume single port or pin if properties LEFT and RIGHT are empty
       set width [get_property CONFIG.PortWidth $intrPin]
       set num_sw_intr [get_property CONFIG.C_NUM_SW_INTR $ip]
       set max_width [expr 32 - $num_sw_intr]
       if { [string length $width] > 0 && $width != 0 } {
          if {$width <= $max_width} {
             set_property CONFIG.C_NUM_INTR_INPUTS $width $ip
          }
       } elseif { [string length $width] == 0 } {
          set left  [get_property LEFT  $intrDriver]
          set right [get_property RIGHT $intrDriver]
          if { [string length $left] > 0 && [string length $right] > 0 } {
             set width [expr ($left > $right) ? $left - $right + 1 : $right - $left + 1]
          } else {
             set width 1
          }
          if {$width <=  $max_width} {
             set_property CONFIG.C_NUM_INTR_INPUTS $width $ip
          }
       }

       # Determine port type:
       # - Check for propagated PortType property
       # - Check for PortType property on driver
       # - Check for TYPE property on driver
       set PortType [get_property CONFIG.PortType $intrPin]
       if { [string length $PortType] == 0 } {
           set PortType [get_property CONFIG.PortType $intrDriver]
           if { [string length $PortType] == 0 } {
              set PortType [get_property TYPE $intrDriver]
           }
       }

       # Update IP property: C_KIND_OF_INTR, _LVL, _EDGE
       # - Error if maximum external interrupts exceeded
       # - Warning if neither PortType nor sensitivity set
       # - Allow one common sensitivity value for all interrupt inputs
       # - Warning if number of sensitivity values do not match number of interrupt inputs
       # - Assign properties, with warning if sensitivity value not recognized
       set nIntrKind    [get_property CONFIG.C_KIND_OF_INTR $ip]
       set nLvlKind     [get_property CONFIG.C_KIND_OF_LVL  $ip]
       set nEdgeKind    [get_property CONFIG.C_KIND_OF_EDGE $ip]
       set userIntrKind [string equal [get_property CONFIG.C_KIND_OF_INTR.VALUE_SRC $ip] "USER"]
       set userLvlKind  [string equal [get_property CONFIG.C_KIND_OF_LVL.VALUE_SRC  $ip] "USER"]
       set userEdgeKind [string equal [get_property CONFIG.C_KIND_OF_EDGE.VALUE_SRC $ip] "USER"]

       set mask [expr (1 << $width) - 1]

       set using_concat    0
       set using_concat_v1 0
       set intrDriverCell [get_bd_cells -quiet -of_objects $intrDriver]
       set using_driver_cell [expr [string length $intrDriverCell] > 0]
       if {$using_driver_cell} {
           set vlnv [get_property VLNV $intrDriverCell]
           set xlconcat [string first "xilinx.com:ip:xlconcat" "$vlnv"]
           set ilconcat [string first "xilinx.com:inline_hdl:ilconcat" "$vlnv"]
           set using_concat [expr $xlconcat == 0 || $ilconcat == 0]
           set xlconcat_v1 [string first "xilinx.com:ip:xlconcat:1" "$vlnv"]
           set using_concat_v1 [expr $xlconcat_v1 == 0]
       }
       set nCount [expr $width - 1]

       set auto [expr ! ($userIntrKind || $userLvlKind || $userEdgeKind)]
       set Sen_Value [get_property CONFIG.SENSITIVITY $intrPin]
       set msg "- using default interrupt type Rising Edge. Please change this manually if necessary."
       if {$width > $max_width} {
           bd::send_msg -of $cellName -type ERROR -msg_id 3 -text \
              ": Maximum number of available external interrupts exceeded ($width > $max_width)."
       } elseif { $PortType != "intr" || [string length ${Sen_Value}] == 0 } {
           if {$auto} {
              bd::send_msg -of $cellName -type WARNING -msg_id 4 -text \
                 ": Could not determine interrupt input port type ${msg}"
           }
       } else {
           set Sen_Value [string trim ${Sen_Value} :]
           set senArray [split ${Sen_Value} :]
           set senSize [llength $senArray]

           # Handle common sensitivity value for more than one interrupt
           if { ($width != $senSize) && ($senSize == 1) } {
              for {set i 1} {$i < $width} {incr i} {
                 lappend senArray $Sen_Value
              }
              set senSize [llength $senArray]
           }

           # Check width and update properties according to sensitivity
           set en_cascade_mode [get_property CONFIG.C_EN_CASCADE_MODE $ip]
           if { $width != $senSize } {
              if {$auto} {
                 bd::send_msg -of $cellName -type WARNING -msg_id 5 -text \
                    ": Number of interrupt inputs ($width) does not match property SENSITIVITY ($senSize items) ${msg}"
              }
           } else {
              foreach senStr $senArray {
                 set nBit [ expr 1 << $nCount ]
                 set senStr [string toupper $senStr]
                 if { $senStr == "LEVEL_HIGH" } {
                    set nIntrKind [ expr { $nIntrKind & (~ $nBit) } ]
                    set nLvlKind  [ expr { $nLvlKind  | $nBit } ]
                 } elseif { $senStr == "LEVEL_LOW" } {
                    set nIntrKind [ expr { $nIntrKind & (~ $nBit) } ]
                    set nLvlKind  [ expr { $nLvlKind & (~ $nBit) } ]
                 } elseif { $senStr == "EDGE_RISING" } {
                    set nIntrKind [ expr { $nIntrKind | $nBit } ]
                    set nEdgeKind [ expr { $nEdgeKind | $nBit } ]
                 } elseif { $senStr == "EDGE_FALLING" } {
                    set nIntrKind [ expr { $nIntrKind | $nBit } ]
                    set nEdgeKind [ expr { $nEdgeKind & (~ $nBit) } ]
                 } elseif {$auto} {
                    if {$en_cascade_mode && $nCount == 31} {
                      # Cascade mode, bit 31 from cascaded controller irq pin - use LEVEL HIGH
                      set nIntrKind [ expr { $nIntrKind & (~ $nBit) } ]
                      set nLvlKind  [ expr { $nLvlKind  | $nBit } ]
                    } else {
                      bd::send_msg -of $cellName -type WARNING -msg_id 6 -text \
                         ": Property SENSITIVITY = \"${senStr}\" for interrupt input ${nCount} not recognized ${msg}"
                    }
                 }
                 set nCount [expr $nCount - 1]
              }
           }

           # Cascade mode, bit 31 from cascaded controller irq pin, input on irq_in
           # Take nIntrKind and nEdgeKind from bus interface parameter and use LEVEL HIGH if not available
           if {$en_cascade_mode && $width == 31 && $auto} {
              set nCount 31
              set nBit [ expr 1 << $nCount ]
              set senStr [get_property -quiet CONFIG.SENSITIVITY [get_bd_intf_pins $cellName/cascade_interrupt]]
              set senStr [string toupper $senStr]
              if { $senStr == "LEVEL_LOW" } {
                 set nIntrKind [ expr { $nIntrKind & (~ $nBit) } ]
                 set nLvlKind  [ expr { $nLvlKind & (~ $nBit) } ]
              } elseif { $senStr == "EDGE_RISING" } {
                 set nIntrKind [ expr { $nIntrKind | $nBit } ]
                 set nEdgeKind [ expr { $nEdgeKind | $nBit } ]
              } elseif { $senStr == "EDGE_FALLING" } {
                 set nIntrKind [ expr { $nIntrKind | $nBit } ]
                 set nEdgeKind [ expr { $nEdgeKind & (~ $nBit) } ]
              } else {
                 set nIntrKind [ expr { $nIntrKind & (~ $nBit) } ]
                 set nLvlKind  [ expr { $nLvlKind  | $nBit } ]
              }
           }

           set msg "Please review the manual value or consider using Auto instead."
           set strIntrKind [format "0x%08X" $nIntrKind]
           if {$userIntrKind} {
              set curIntrKind [get_property CONFIG.C_KIND_OF_INTR $ip]
              if {($nIntrKind & $mask) != ($curIntrKind & $mask)} {
                 bd::send_msg -of $cellName -type WARNING -msg_id 7 -text \
                    ": Interrupts type manual value ($curIntrKind) does not match computed value ($strIntrKind). $msg"
              }
              set lvlmask  [expr $mask & (~ $curIntrKind)]
              set edgemask [expr $mask & $curIntrKind]
           } else {
              set_property CONFIG.C_KIND_OF_INTR $strIntrKind $ip
              set lvlmask  [expr $mask & (~ $nIntrKind)]
              set edgemask [expr $mask & $nIntrKind]
           }
           set strLvlKind  [format "0x%08X" $nLvlKind]
           if {$userLvlKind} {
              set curLvlKind [get_property CONFIG.C_KIND_OF_LVL $ip]
              if {($nLvlKind & $lvlmask) != ($curLvlKind & $lvlmask)} {
                 bd::send_msg -of $cellName -type WARNING -msg_id 8 -text \
                    ": Level type manual value ($curLvlKind) does not match computed value ($strLvlKind). $msg"
              }
           } else {
              set_property CONFIG.C_KIND_OF_LVL  $strLvlKind $ip
           }
           set strEdgeKind [format "0x%08X" $nEdgeKind]
           if {$userEdgeKind} {
              set curEdgeKind [get_property CONFIG.C_KIND_OF_EDGE $ip]
              if {($nEdgeKind & $edgemask) != ($curEdgeKind & $edgemask)} {
                 bd::send_msg -of $cellName -type WARNING -msg_id 9 -text \
                    ": Edge type manual value ($curEdgeKind) does not match computed value ($strEdgeKind). $msg"
              }
           } else {
              set_property CONFIG.C_KIND_OF_EDGE $strEdgeKind $ip
           }
       }

       # Update C_ASYNC_INTR from interrupt connections if no user override:
       # - If connected to concat, follow connections to driver for each input
       # - Use reversed order assignment if connected to xilinx.com:ip:xlconcat:1.x
       # - Check if all driver clock inputs are equal to the AXI clock, and assign bits accordingly
       set asyncIntrKind [string equal [get_property CONFIG.C_ASYNC_INTR.VALUE_SRC $ip] "USER"]
       if {! $asyncIntrKind} {
          set nAsyncIntr 0xFFFFFFFF
          set axi_clk        [get_bd_pins $ip/s_axi_aclk]
          set axi_clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $axi_clk]
          if {$using_concat} {
             set nCount [expr $using_concat_v1 ? $width - 1 : 0]
             set nPorts [get_property CONFIG.NUM_PORTS $intrDriverCell]
             for {set index 0} {$index < $nPorts} {incr index} {
                set intrPin [get_bd_pins "${intrDriverCell}/In${index}"]
                set nInWidth [get_property CONFIG.IN${index}_WIDTH $intrDriverCell]
                set intrPinDriver [find_bd_objs -thru_hier -relation connected_to $intrPin]
                if {[string length $intrPinDriver] > 0} {
                   set intrPinDriverCell [get_bd_cells -quiet -of_objects $intrPinDriver]
                   if {[string length $intrPinDriverCell] > 0} {
                      set clk_pins [get_bd_pins -filter {TYPE=~clk} [get_bd_pins -of_object $intrPinDriverCell]]
                      set clk_drivers_equal [expr [string length $clk_pins] > 0]
                      foreach clk_pin $clk_pins {
                         set clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $clk_pin]
                         set clk_drivers_equal [expr $clk_drivers_equal && [string equal "$axi_clk_driver" "$clk_driver"]]
                      }
                      if {$clk_drivers_equal} {
                         if {$using_concat_v1} {
                            set syncmask   [expr ((1 << $nInWidth) - 1) << ($nCount - $nInWidth + 1)]
                         } else {
                            set syncmask   [expr ((1 << $nInWidth) - 1) << $nCount]
                         }
                         set nAsyncIntr [expr $nAsyncIntr & ~$syncmask]
                      }
                   }
                }
                set nCount [expr $using_concat_v1 ? $nCount - $nInWidth : $nCount + $nInWidth]
             }
          } elseif {$using_driver_cell} {
             set clk_pins [get_bd_pins -filter {TYPE=~clk} [get_bd_pins -of_object $intrDriverCell]]
             set clk_drivers_equal [expr [string length $clk_pins] > 0]
             foreach clk_pin $clk_pins {
                set clk_driver [find_bd_objs -quiet -thru_hier -relation connected_to $clk_pin]
                set clk_drivers_equal [expr $clk_drivers_equal && [string equal "$axi_clk_driver" "$clk_driver"]]
             }
             if {$clk_drivers_equal} {
                set nAsyncIntr [expr ~$mask & 0xFFFFFFFF]
             }
          }
          set strAsyncIntr [format "0x%08X" $nAsyncIntr]
          set_property CONFIG.C_ASYNC_INTR $strAsyncIntr $ip
       }
    } else {
       set_property CONFIG.C_ASYNC_INTR "0xFFFFFFFF" $ip
    }

    # Check that C_EN_CASCADE_MODE is not set when C_NUM_INTR_INPUTS < 32
    # Check that C_EN_CASCADE_MODE is not set when C_NUM_SW_INTR > 0
    set en_cascade_mode [get_property CONFIG.C_EN_CASCADE_MODE $ip]
    set num_intr_inputs [get_property CONFIG.C_NUM_INTR_INPUTS $ip]
    set num_sw_intr     [get_property CONFIG.C_NUM_SW_INTR $ip]
    set busif           [get_bd_intf_pins -quiet $cellName/cascade_interrupt]
    set drive_intf      [find_bd_objs -quiet -thru_hier -relation connected_to $busif]
    set has_drive_intf  [expr [string length $drive_intf] > 0]
    if {($en_cascade_mode && $num_intr_inputs != 32 && ! $has_drive_intf) ||
        ($en_cascade_mode && $num_intr_inputs != 31 &&   $has_drive_intf)} {
       bd::send_msg -of $cellName -type ERROR -msg_id 11 -text ": When Cascade Interrupt Mode is enabled, the AXI INTC core must either have 31 interrupt inputs with the cascaded AXI INTC connected via the cascade_interrupt bus interface input, or 32 interrupt inputs with the most significant input connected from the cascaded AXI INTC irq pin."
    }
    if {$en_cascade_mode && $num_sw_intr > 0} {
       bd::send_msg -of $cellName -type ERROR -msg_id 12 -text ": When Cascade Interrupt Mode is enabled, the AXI INTC core cannot have any software interrupts."
    }

    # Update C_IVAR_RESET_VALUE from MicroBlaze C_BASE_VECTORS
    # Update C_ADDR_WIDTH from MicroBlaze C_ADDR_SIZE
    set has_fast [get_property CONFIG.C_HAS_FAST $ip]
    if {$has_fast} {
       set busif [get_bd_intf_pins -quiet $cellName/interrupt]
       set intfs [get_slave_interfaces $busif]
       set vectors {}
       set addr_width 32
       foreach intf $intfs {
          set connected_cells [get_bd_cells -quiet -of_object $intf]
          if {[llength $connected_cells] == 1} {
             set value [get_property -quiet CONFIG.C_BASE_VECTORS $connected_cells]
             if {[string length $value] > 0} { lappend vectors $value }
             set value [get_property -quiet CONFIG.C_ADDR_SIZE $connected_cells]
             set data_size [get_property -quiet CONFIG.C_DATA_SIZE $connected_cells]
             if {[string length $value] > 0 && [string length $data_size] > 0} {
                if {$value > $addr_width && $data_size > 32} { set addr_width $value }
             }
          }
       }
       set base_vectors 0
       if {[llength $vectors] > 0} { set base_vectors [lindex $vectors 0] }
       foreach vector $vectors {
          if {$base_vectors != $vector} {
             bd::send_msg -of $cellName -type WARNING -msg_id 10 -text ": Automatic assignment of C_IVAR_RESET_VALUE could not determine a unique value, since more than one MicroBlaze core with different values are connected. Please ensure that all connected MicroBlaze cores have the same C_BASE_VECTORS."
             break
          }
       }
       set_property CONFIG.C_IVAR_RESET_VALUE [format "0x%016lX" [expr $base_vectors + 0x10]] $ip
       set_property CONFIG.C_ADDR_WIDTH $addr_width $ip
    }

    # Update C_S_AXI_ACLK_FREQ_MHZ and C_PROCESSOR_CLK_FREQ_MHZ
    set pin [get_bd_pins $cellName/s_axi_aclk]
    set freq_hz [get_property CONFIG.FREQ_HZ $pin]
    set_property CONFIG.C_S_AXI_ACLK_FREQ_MHZ [expr $freq_hz / 1000000.0] $ip
    if {$has_fast} {
       set pin [get_bd_pins $cellName/processor_clk]
       set freq_hz [get_property CONFIG.FREQ_HZ $pin]
       set_property CONFIG.C_PROCESSOR_CLK_FREQ_MHZ [expr $freq_hz / 1000000.0] $ip
    }

    # Warn if irq pin in INTC_interrupt interface is connected to other interface
    set irq_connection [get_property CONFIG.C_IRQ_CONNECTION $ip]
    if {$irq_connection == 0} {
      set irqpin [get_bd_pins ${cellName}/irq]
      set other_end [find_bd_objs -quiet -thru_hier -relation connected_to $irqpin]
      set bif [get_bd_intf_pins -quiet ${cellName}/interrupt]
      if {[string length $other_end] > 0 && [string length $bif] > 0} {
        set other_end_vlnv [get_property -quiet VLNV $other_end]
        set bif_vlnv [get_property VLNV $bif]
        if {"$other_end_vlnv" != "$bif_vlnv"} {
          bd::send_msg -of $cellName -type WARNING -msg_id 13 -text ": Interrupt output connection Bus is selected, but the interrupt bus interface is not connected to a matching interface. Please consider selecting Single instead."
        }
      }
    }
}
###############################################################################

proc post_config_ip { cellName dictArg } {
    set ip [get_bd_cells $cellName]
    set Fast_Intr [ expr [get_property CONFIG.C_HAS_FAST $ip] ]
    set Irq_level [ expr [get_property CONFIG.C_IRQ_IS_LEVEL $ip] ]
    set Irq_active [ expr [get_property CONFIG.C_IRQ_ACTIVE $ip] ]

    ###########################################################################
    ## If C_IRQ_IS_LEVEL == 1, then check if Level High or Level Low with C_IRQ_ACTIVE
    ## If C_IRQ_IS_LEVEL == 0, then check if Edge Rising or Edge Falling with C_IRQ_ACTIVE

    set SenStr ""
    if { $Irq_level == 1 } {
        set Level_Type [ string tolower [get_property CONFIG.Sense_of_IRQ_Level_Type $ip] ]
        if { $Level_Type == "active_high" } {
            set SenStr "LEVEL_HIGH"
        } else {
            set SenStr "LEVEL_LOW"
        }
    } else {
        set Edge_Type [ string tolower [get_property CONFIG.Sense_of_IRQ_Edge_Type $ip] ]
        if { $Edge_Type == "rising" } {
            set SenStr "EDGE_RISING"
        } else {
            set SenStr "EDGE_FALLING"
        }
    }

    set irq_connection [get_property CONFIG.C_IRQ_CONNECTION $ip]

    if {$irq_connection == 0} {
      set irqPin [get_bd_intf_pins ${cellName}/interrupt]
      set_property CONFIG.SENSITIVITY $SenStr $irqPin
    } else {
      set irqPin [get_bd_pins ${cellName}/irq]
      set_property CONFIG.SENSITIVITY $SenStr $irqPin
    }

    ###########################################################################
    ## set the bus defintion for IRQ O/P port of AXI INTC
    ## If C_HAS_FAST = 1 then low latency, else with average latency

    if {$irq_connection == 0} {
      set_property CONFIG.LOW_LATENCY $Fast_Intr $irqPin
    }
    ###########################################################################

    # Set function of INTC_interrupt interface in case it is enabled
    if {$irq_connection == 0} {
      set bif [get_bd_intf_pins -quiet ${cellName}/interrupt]
    } else {
      set bif [get_bd_pins -quiet ${cellName}/irq]
    }
    if {[string length $bif] > 0} {
      set_property BD_ATTRIBUTE.FUNCTION INTR_CTRL $bif
    }
}
###############################################################################
