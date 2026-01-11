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
## mdm_riscv_v1_0.tcl
##
###############################################################################

proc init_gui { IPINST } {
  set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]

  set_property hide_disabled_pins true [ipgui::get_canvasspec -of $IPINST]

  set tabgroup0 [ipgui::add_page $IPINST -name User -layout vertical]
  set groupbox0 [ipgui::add_group $IPINST -parent $tabgroup0 -name "Debug" ]
  set C_MB_DBG_PORTS [ipgui::add_param $IPINST -parent $groupbox0 -name C_MB_DBG_PORTS ]
  set C_DBG_REG_ACCESS [ipgui::add_param $IPINST -parent $groupbox0 -name C_DBG_REG_ACCESS -widget checkBox]
  set C_DBG_MEM_ACCESS [ipgui::add_param $IPINST -parent $groupbox0 -name C_DBG_MEM_ACCESS -widget checkBox]
  set C_USE_CROSS_TRIGGER [ipgui::add_param $IPINST -parent $groupbox0 -name C_USE_CROSS_TRIGGER -widget checkBox]
  set groupbox1 [ipgui::add_group $IPINST -parent $tabgroup0 -name "UART" ]
  set C_USE_UART [ipgui::add_param $IPINST -parent $groupbox1 -name C_USE_UART -widget checkBox]
  set groupbox2 [ipgui::add_group $IPINST -parent $tabgroup0 -name "Trace" ]
  set C_TRACE_OUTPUT [ipgui::add_param $IPINST -parent $groupbox2 -name C_TRACE_OUTPUT -widget comboBox]
  set C_TRACE_DATA_WIDTH [ipgui::add_param $IPINST -parent $groupbox2 -name C_TRACE_DATA_WIDTH -widget comboBox]
  set groupbox3 [ipgui::add_group $IPINST -parent $tabgroup0 -name "Advanced" ]
  set C_JTAG_CHAIN [ipgui::add_param $IPINST -parent $groupbox3 -name C_JTAG_CHAIN -widget comboBox]
  set C_USE_BSCAN [ipgui::add_param $IPINST -parent $groupbox3 -name C_USE_BSCAN -widget comboBox]
  set C_BSCANID [ipgui::add_param $IPINST -parent $groupbox3 -name C_BSCANID]
  set_property visible false $C_BSCANID
  set C_USE_BSCAN_SWITCH [ipgui::add_param $IPINST -parent $groupbox3 -name C_USE_BSCAN_SWITCH]
  set_property visible false $C_USE_BSCAN_SWITCH
  set C_USE_JTAG_BSCAN [ipgui::add_param $IPINST -parent $groupbox3 -name C_USE_JTAG_BSCAN]
  set_property visible false $C_USE_JTAG_BSCAN
  set C_DEBUG_INTERFACE [ipgui::add_param $IPINST -parent $groupbox3 -name C_DEBUG_INTERFACE -widget comboBox]
  set_property visible false $C_DEBUG_INTERFACE
  set C_TRIG_IN_PORTS [ipgui::add_param $IPINST -parent $groupbox3 -name C_TRIG_IN_PORTS -widget comboBox]
  set C_TRIG_OUT_PORTS [ipgui::add_param $IPINST -parent $groupbox3 -name C_TRIG_OUT_PORTS -widget comboBox]
  set C_EXT_TRIG_RESET_VALUE [ipgui::add_param $IPINST -parent $groupbox0 -name C_EXT_TRIG_RESET_VALUE]
  set_property visible false $C_EXT_TRIG_RESET_VALUE

  set C_XMTC [ipgui::add_param $IPINST -parent $groupbox3 -name C_XMTC]
  set C_BRK [ipgui::add_param $IPINST -parent $groupbox3 -name C_BRK]

  set C_INTERCONNECT [ipgui::add_param $IPINST -parent $groupbox3 -name C_INTERCONNECT]
  set C_TRACE_CLK_FREQ_HZ [ipgui::add_param $IPINST -parent $groupbox3 -name C_TRACE_CLK_FREQ_HZ]
  set C_TRACE_CLK_OUT_PHASE [ipgui::add_param $IPINST -parent $groupbox3 -name C_TRACE_CLK_OUT_PHASE]
  set C_TRACE_ASYNC_RESET [ipgui::add_param $IPINST -parent $groupbox2 -name C_TRACE_ASYNC_RESET -widget checkBox]
  set C_TRACE_PROTOCOL [ipgui::add_param $IPINST -parent $groupbox2 -name C_TRACE_PROTOCOL -widget comboBox]
  set C_TRACE_ID [ipgui::add_param $IPINST -parent $groupbox2 -name C_TRACE_ID]
  set C_S_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_S_AXI_ADDR_WIDTH]
  set C_S_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_S_AXI_DATA_WIDTH]
  set C_S_AXI_ACLK_FREQ_HZ [ipgui::add_param $IPINST -parent $groupbox3 -name C_S_AXI_ACLK_FREQ_HZ]
  set C_M_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_M_AXI_ADDR_WIDTH]
  set C_M_AXI_DATA_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_M_AXI_DATA_WIDTH]
  set C_M_AXI_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_M_AXI_THREAD_ID_WIDTH]
  set C_ADDR_SIZE [ipgui::add_param $IPINST -parent $groupbox3 -name C_ADDR_SIZE]
  set C_DATA_SIZE [ipgui::add_param $IPINST -parent $groupbox3 -name C_DATA_SIZE]
  set C_LMB_PROTOCOL [ipgui::add_param $IPINST -parent $groupbox3 -name C_LMB_PROTOCOL]
  set C_M_AXIS_DATA_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_M_AXIS_DATA_WIDTH]
  set C_M_AXIS_ID_WIDTH [ipgui::add_param $IPINST -parent $groupbox3 -name C_M_AXIS_ID_WIDTH]
  set C_USE_CONFIG_RESET [ipgui::add_param $IPINST -parent $groupbox3 -name C_USE_CONFIG_RESET]
  set C_AVOID_PRIMITIVES [ipgui::add_param $IPINST -parent $groupbox3 -name C_AVOID_PRIMITIVES]

  # Visibility False
  set_property visible false $C_XMTC
  set_property visible false $C_BRK
  set_property visible false $C_INTERCONNECT
  set_property visible false $C_TRACE_CLK_FREQ_HZ
  set_property visible false $C_TRACE_CLK_OUT_PHASE
  set_property visible false $C_TRACE_ASYNC_RESET
  set_property visible false $C_TRACE_PROTOCOL
  set_property visible false $C_TRACE_ID
  set_property visible false $C_S_AXI_ADDR_WIDTH
  set_property visible false $C_S_AXI_DATA_WIDTH
  set_property visible false $C_S_AXI_ACLK_FREQ_HZ
  set_property visible false $C_M_AXI_ADDR_WIDTH
  set_property visible false $C_M_AXI_DATA_WIDTH
  set_property visible false $C_M_AXI_THREAD_ID_WIDTH
  set_property visible false $C_ADDR_SIZE
  set_property visible false $C_DATA_SIZE
  set_property visible false $C_LMB_PROTOCOL
  set_property visible false $C_M_AXIS_DATA_WIDTH
  set_property visible false $C_M_AXIS_ID_WIDTH
  set_property visible false $C_USE_CONFIG_RESET
  set_property visible false $C_AVOID_PRIMITIVES
}

proc init_params {PARAM_VALUE.C_TRACE_OUTPUT \
                  PARAM_VALUE.C_DBG_REG_ACCESS \
                  PARAM_VALUE.C_DEBUG_INTERFACE \
                  PARAM_VALUE.C_TRACE_OUTPUT} {
  set_property range "0,1,4" ${PARAM_VALUE.C_TRACE_OUTPUT}
  update_PARAM_VALUE.C_DBG_REG_ACCESS ${PARAM_VALUE.C_DBG_REG_ACCESS} \
                                      ${PARAM_VALUE.C_DEBUG_INTERFACE} \
                                      ${PARAM_VALUE.C_TRACE_OUTPUT}
}

proc update_PARAM_VALUE.C_DBG_REG_ACCESS { PARAM_VALUE.C_DBG_REG_ACCESS \
                                           PARAM_VALUE.C_DEBUG_INTERFACE \
                                           PARAM_VALUE.C_TRACE_OUTPUT } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  set trace_output    [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}]

  set enable [expr $debug_interface > 0 || $trace_output == 1]
  if {$enable} {
    set_property range "0,1" ${PARAM_VALUE.C_DBG_REG_ACCESS}
    set_property enabled true ${PARAM_VALUE.C_DBG_REG_ACCESS}
  } else {
    set_property range "0" ${PARAM_VALUE.C_DBG_REG_ACCESS}
    set_property enabled false ${PARAM_VALUE.C_DBG_REG_ACCESS}
  }
}

proc update_gui_for_PARAM_VALUE.C_USE_CROSS_TRIGGER {PARAM_VALUE.C_USE_CROSS_TRIGGER \
                                                     PARAM_VALUE.C_DEBUG_INTERFACE IPINST} {
  set param [ipgui::get_guiparamspec C_USE_CROSS_TRIGGER -of $IPINST]

  set tip "Enable Cross Trigger"
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  if {$debug_interface < 2} {
    set_property tooltip "$tip" $param
  } else {
    set_property tooltip "$tip<br/>Not available with AXI parallel debug interface" $param
  }
}

proc update_PARAM_ENABLEMENT.C_USE_CROSS_TRIGGER { PARAM_ENABLEMENT.C_USE_CROSS_TRIGGER PARAM_VALUE.C_DEBUG_INTERFACE } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  set value [expr $debug_interface < 2 ? true : false]
  set_property enabled $value ${PARAM_ENABLEMENT.C_USE_CROSS_TRIGGER}
}

proc update_PARAM_VALUE.C_TRIG_IN_PORTS { PARAM_VALUE.C_TRIG_IN_PORTS PARAM_VALUE.C_USE_CROSS_TRIGGER } {
  set use_cross_trigger [get_property value ${PARAM_VALUE.C_USE_CROSS_TRIGGER}]
  set value [expr $use_cross_trigger != 0 ? true : false]
  set_property enabled $value ${PARAM_VALUE.C_TRIG_IN_PORTS}
}

proc update_PARAM_VALUE.C_TRIG_OUT_PORTS { PARAM_VALUE.C_TRIG_OUT_PORTS PARAM_VALUE.C_USE_CROSS_TRIGGER } {
  set use_cross_trigger [get_property value ${PARAM_VALUE.C_USE_CROSS_TRIGGER}]
  set value [expr $use_cross_trigger != 0 ? true : false]
  set_property enabled $value ${PARAM_VALUE.C_TRIG_OUT_PORTS}
}

proc update_PARAM_VALUE.C_TRACE_OUTPUT { PARAM_VALUE.C_TRACE_OUTPUT PARAM_VALUE.C_DEBUG_INTERFACE } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  if {$debug_interface < 2} {
    set_property range "0,1,4" ${PARAM_VALUE.C_TRACE_OUTPUT}
  } else {
    set_property range "0,4" ${PARAM_VALUE.C_TRACE_OUTPUT}
  }
}

proc update_PARAM_ENABLEMENT.C_TRACE_DATA_WIDTH { PARAM_ENABLEMENT.C_TRACE_DATA_WIDTH \
                                                  PARAM_VALUE.C_TRACE_OUTPUT          \
                                                  PARAM_VALUE.C_DEBUG_INTERFACE } {
  set trace_output [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}]
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  set value [expr ($trace_output == 1 || $trace_output == 2) && ($debug_interface < 2) ? true : false]
  set_property enabled $value ${PARAM_ENABLEMENT.C_TRACE_DATA_WIDTH}
}

proc update_PARAM_VALUE.C_TRACE_DATA_WIDTH { PARAM_VALUE.C_TRACE_DATA_WIDTH PARAM_VALUE.C_TRACE_OUTPUT } {
  set trace_data_width [get_property value ${PARAM_VALUE.C_TRACE_DATA_WIDTH}]
  set trace_output     [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}]

  if {$trace_output == 2} {
    if {$trace_data_width < 8} {
      set_property range_value "8,8,16,32" ${PARAM_VALUE.C_TRACE_DATA_WIDTH}
    } else {
      set_property range "8,16,32" ${PARAM_VALUE.C_TRACE_DATA_WIDTH}
    }
  } elseif {$trace_output == 1} {
    set_property range "2,4,8,16" ${PARAM_VALUE.C_TRACE_DATA_WIDTH}
  } else {
    set_property range "2,4,8,16,32" ${PARAM_VALUE.C_TRACE_DATA_WIDTH}
  }
}

proc update_PARAM_VALUE.C_JTAG_CHAIN { PARAM_VALUE.C_JTAG_CHAIN PARAM_VALUE.C_USE_BSCAN } {
  set use_bscan [get_property value ${PARAM_VALUE.C_USE_BSCAN}]
  set value [expr $use_bscan == 0 ? true : false]
  set_property enabled $value ${PARAM_VALUE.C_JTAG_CHAIN}
}

proc update_PARAM_VALUE.C_USE_BSCAN { PARAM_VALUE.C_USE_BSCAN PARAM_VALUE.C_DEBUG_INTERFACE PROJECT_PARAM.ARCHITECTURE } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  set family [string tolower ${PROJECT_PARAM.ARCHITECTURE}]

  if {$debug_interface > 0} {
    set_property range_value "3,3" ${PARAM_VALUE.C_USE_BSCAN} 
  } else {
    if {$family == "versal"} {
      set_property range_value "4,2,4" ${PARAM_VALUE.C_USE_BSCAN} 
      set_property range_labels [join [dict create 2 {EXTERNAL} 4 {EXTERNAL_HIDDEN}] ,] ${PARAM_VALUE.C_USE_BSCAN}
    } else {
      set_property range "0,2,4" ${PARAM_VALUE.C_USE_BSCAN} 
      set_property range_labels [join [dict create 0 {INTERNAL} 2 {EXTERNAL} 4 {EXTERNAL_HIDDEN}] ,] ${PARAM_VALUE.C_USE_BSCAN}
    }
  }
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH \
                                             PARAM_VALUE.C_TRACE_OUTPUT     \
                                             PARAM_VALUE.C_DEBUG_INTERFACE  \
                                             PARAM_VALUE.C_USE_UART } {
  set trace_output    [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}]
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  set use_uart        [get_property value ${PARAM_VALUE.C_USE_UART}]

  if {$trace_output > 0 && $trace_output < 4} {
    set s_axi_addr_width 14
  } elseif {$debug_interface == 0} {
    set s_axi_addr_width 4
  } elseif {$use_uart == 0} {
    set s_axi_addr_width 9
  } else {
    set s_axi_addr_width 10
  }

  set_property value $s_axi_addr_width ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_PARAM_VALUE.C_M_AXIS_DATA_WIDTH { PARAM_VALUE.C_M_AXIS_DATA_WIDTH \
                                              PARAM_VALUE.C_TRACE_OUTPUT      \
                                              PARAM_VALUE.C_TRACE_DATA_WIDTH } {
  set trace_output     [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}]
  set trace_data_width [get_property value ${PARAM_VALUE.C_TRACE_DATA_WIDTH}]
  if {$trace_output == 2} {
    set_property value $trace_data_width ${PARAM_VALUE.C_M_AXIS_DATA_WIDTH}
  }
}

proc update_MODELPARAM_VALUE.C_FAMILY {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_FAMILY} {
  set xcovalue [string tolower ${PROJECT_PARAM.ARCHITECTURE}]
  set_property value $xcovalue ${MODELPARAM_VALUE.C_FAMILY}
}

proc update_MODELPARAM_VALUE.C_DEVICE {PROJECT_PARAM.DEVICE MODELPARAM_VALUE.C_DEVICE} {
  set xcovalue [string tolower ${PROJECT_PARAM.DEVICE}]
  set_property value $xcovalue ${MODELPARAM_VALUE.C_DEVICE}
}

proc update_MODELPARAM_VALUE.C_MB_DBG_PORTS { MODELPARAM_VALUE.C_MB_DBG_PORTS PARAM_VALUE.C_MB_DBG_PORTS } {
  set_property value [get_property value ${PARAM_VALUE.C_MB_DBG_PORTS}] ${MODELPARAM_VALUE.C_MB_DBG_PORTS}
}

proc update_MODELPARAM_VALUE.C_DBG_REG_ACCESS { MODELPARAM_VALUE.C_DBG_REG_ACCESS PARAM_VALUE.C_DBG_REG_ACCESS } {
  set_property value [get_property value ${PARAM_VALUE.C_DBG_REG_ACCESS}] ${MODELPARAM_VALUE.C_DBG_REG_ACCESS}
}

proc update_MODELPARAM_VALUE.C_DBG_MEM_ACCESS { MODELPARAM_VALUE.C_DBG_MEM_ACCESS PARAM_VALUE.C_DBG_MEM_ACCESS } {
  set_property value [get_property value ${PARAM_VALUE.C_DBG_MEM_ACCESS}] ${MODELPARAM_VALUE.C_DBG_MEM_ACCESS}
}

proc update_MODELPARAM_VALUE.C_USE_CROSS_TRIGGER { MODELPARAM_VALUE.C_USE_CROSS_TRIGGER \
                                                   PARAM_VALUE.C_USE_CROSS_TRIGGER      \
                                                   PARAM_VALUE.C_DEBUG_INTERFACE } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  if {$debug_interface < 2} {
    set_property value [get_property value ${PARAM_VALUE.C_USE_CROSS_TRIGGER}] ${MODELPARAM_VALUE.C_USE_CROSS_TRIGGER}
  } else {
    set_property value 0 ${MODELPARAM_VALUE.C_USE_CROSS_TRIGGER}
  }
}

proc update_MODELPARAM_VALUE.C_EXT_TRIG_RESET_VALUE { MODELPARAM_VALUE.C_EXT_TRIG_RESET_VALUE PARAM_VALUE.C_EXT_TRIG_RESET_VALUE } {
  set_property value [get_property value ${PARAM_VALUE.C_EXT_TRIG_RESET_VALUE}] ${MODELPARAM_VALUE.C_EXT_TRIG_RESET_VALUE}
}

proc update_MODELPARAM_VALUE.C_USE_UART { MODELPARAM_VALUE.C_USE_UART PARAM_VALUE.C_USE_UART } {
  set_property value [get_property value ${PARAM_VALUE.C_USE_UART}] ${MODELPARAM_VALUE.C_USE_UART}
}

proc update_MODELPARAM_VALUE.C_TRACE_OUTPUT { MODELPARAM_VALUE.C_TRACE_OUTPUT \
                                              PARAM_VALUE.C_TRACE_OUTPUT      \
                                              PARAM_VALUE.C_DEBUG_INTERFACE } {
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  if {$debug_interface < 2} {
    set_property value [get_property value ${PARAM_VALUE.C_TRACE_OUTPUT}] ${MODELPARAM_VALUE.C_TRACE_OUTPUT}
  } else {
    set_property value 0 ${MODELPARAM_VALUE.C_TRACE_OUTPUT}
  }
}

proc update_MODELPARAM_VALUE.C_TRACE_DATA_WIDTH { MODELPARAM_VALUE.C_TRACE_DATA_WIDTH PARAM_VALUE.C_TRACE_DATA_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_DATA_WIDTH}] ${MODELPARAM_VALUE.C_TRACE_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_JTAG_CHAIN { MODELPARAM_VALUE.C_JTAG_CHAIN PARAM_VALUE.C_JTAG_CHAIN } {
  set_property value [get_property value ${PARAM_VALUE.C_JTAG_CHAIN}] ${MODELPARAM_VALUE.C_JTAG_CHAIN}
}

proc update_MODELPARAM_VALUE.C_USE_BSCAN { MODELPARAM_VALUE.C_USE_BSCAN PARAM_VALUE.C_USE_BSCAN } {
  set_property value [get_property value ${PARAM_VALUE.C_USE_BSCAN}] ${MODELPARAM_VALUE.C_USE_BSCAN}
}

proc update_MODELPARAM_VALUE.C_BSCANID { MODELPARAM_VALUE.C_BSCANID PARAM_VALUE.C_BSCANID } {
  set_property value [get_property value ${PARAM_VALUE.C_BSCANID}] ${MODELPARAM_VALUE.C_BSCANID}
}

proc update_MODELPARAM_VALUE.C_USE_BSCAN_SWITCH { MODELPARAM_VALUE.C_USE_BSCAN_SWITCH PARAM_VALUE.C_USE_BSCAN_SWITCH } {
  set_property value [get_property value ${PARAM_VALUE.C_USE_BSCAN_SWITCH}] ${MODELPARAM_VALUE.C_USE_BSCAN_SWITCH}
}

proc update_MODELPARAM_VALUE.C_USE_JTAG_BSCAN { MODELPARAM_VALUE.C_USE_JTAG_BSCAN PARAM_VALUE.C_USE_JTAG_BSCAN } {
  set_property value [get_property value ${PARAM_VALUE.C_USE_JTAG_BSCAN}] ${MODELPARAM_VALUE.C_USE_JTAG_BSCAN}
}

proc update_MODELPARAM_VALUE.C_DEBUG_INTERFACE { MODELPARAM_VALUE.C_DEBUG_INTERFACE PARAM_VALUE.C_DEBUG_INTERFACE } {
  set_property value [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}] ${MODELPARAM_VALUE.C_DEBUG_INTERFACE}
}


proc update_MODELPARAM_VALUE.C_INTERCONNECT { MODELPARAM_VALUE.C_INTERCONNECT PARAM_VALUE.C_INTERCONNECT } {
  set_property value [get_property value ${PARAM_VALUE.C_INTERCONNECT}] ${MODELPARAM_VALUE.C_INTERCONNECT}
}

proc update_MODELPARAM_VALUE.C_TRACE_CLK_FREQ_HZ { MODELPARAM_VALUE.C_TRACE_CLK_FREQ_HZ PARAM_VALUE.C_TRACE_CLK_FREQ_HZ } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_CLK_FREQ_HZ}] ${MODELPARAM_VALUE.C_TRACE_CLK_FREQ_HZ}
}

proc update_MODELPARAM_VALUE.C_TRACE_CLK_OUT_PHASE { MODELPARAM_VALUE.C_TRACE_CLK_OUT_PHASE PARAM_VALUE.C_TRACE_CLK_OUT_PHASE } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_CLK_OUT_PHASE}] ${MODELPARAM_VALUE.C_TRACE_CLK_OUT_PHASE}
}

proc update_MODELPARAM_VALUE.C_TRACE_ASYNC_RESET { MODELPARAM_VALUE.C_TRACE_ASYNC_RESET PARAM_VALUE.C_TRACE_ASYNC_RESET } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_ASYNC_RESET}] ${MODELPARAM_VALUE.C_TRACE_ASYNC_RESET}
}

proc update_MODELPARAM_VALUE.C_TRACE_PROTOCOL { MODELPARAM_VALUE.C_TRACE_PROTOCOL PARAM_VALUE.C_TRACE_PROTOCOL } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_PROTOCOL}] ${MODELPARAM_VALUE.C_TRACE_PROTOCOL}
}

proc update_MODELPARAM_VALUE.C_TRACE_ID { MODELPARAM_VALUE.C_TRACE_ID PARAM_VALUE.C_TRACE_ID } {
  set_property value [get_property value ${PARAM_VALUE.C_TRACE_ID}] ${MODELPARAM_VALUE.C_TRACE_ID}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ { MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ } {
  set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}] ${MODELPARAM_VALUE.C_S_AXI_ACLK_FREQ_HZ}
}

proc update_MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH PARAM_VALUE.C_M_AXI_ADDR_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_M_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH PARAM_VALUE.C_M_AXI_DATA_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_M_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH { MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH}] ${MODELPARAM_VALUE.C_M_AXI_THREAD_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_ADDR_SIZE { MODELPARAM_VALUE.C_ADDR_SIZE PARAM_VALUE.C_ADDR_SIZE } {
  set_property value [get_property value ${PARAM_VALUE.C_ADDR_SIZE}] ${MODELPARAM_VALUE.C_ADDR_SIZE}
}

proc update_MODELPARAM_VALUE.C_DATA_SIZE { MODELPARAM_VALUE.C_DATA_SIZE PARAM_VALUE.C_DATA_SIZE } {
  set_property value [get_property value ${PARAM_VALUE.C_DATA_SIZE}] ${MODELPARAM_VALUE.C_DATA_SIZE}
}

proc update_MODELPARAM_VALUE.C_LMB_PROTOCOL { MODELPARAM_VALUE.C_LMB_PROTOCOL PARAM_VALUE.C_LMB_PROTOCOL } {
  set_property value [get_property value ${PARAM_VALUE.C_LMB_PROTOCOL}] ${MODELPARAM_VALUE.C_LMB_PROTOCOL}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH { MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH PARAM_VALUE.C_M_AXIS_DATA_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_DATA_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXIS_ID_WIDTH { MODELPARAM_VALUE.C_M_AXIS_ID_WIDTH PARAM_VALUE.C_M_AXIS_ID_WIDTH } {
  set_property value [get_property value ${PARAM_VALUE.C_M_AXIS_ID_WIDTH}] ${MODELPARAM_VALUE.C_M_AXIS_ID_WIDTH}
}

proc update_MODELPARAM_VALUE.C_USE_CONFIG_RESET { MODELPARAM_VALUE.C_USE_CONFIG_RESET PARAM_VALUE.C_USE_CONFIG_RESET } {
  set_property value [get_property value ${PARAM_VALUE.C_USE_CONFIG_RESET}] ${MODELPARAM_VALUE.C_USE_CONFIG_RESET}
}

proc update_MODELPARAM_VALUE.C_AVOID_PRIMITIVES { MODELPARAM_VALUE.C_AVOID_PRIMITIVES PARAM_VALUE.C_AVOID_PRIMITIVES } {
  set_property value [get_property value ${PARAM_VALUE.C_AVOID_PRIMITIVES}] ${MODELPARAM_VALUE.C_AVOID_PRIMITIVES}
}
