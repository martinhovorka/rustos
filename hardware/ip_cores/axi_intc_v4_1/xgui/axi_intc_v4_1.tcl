###############################################################################
# (c) Copyright 2016-2017,2021,2023-2024 Advanced Micro Devices, Inc. All rights reserved.
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
## axi_intc_v4_1.tcl
##
###############################################################################

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ ipgui::add_page $IPINST  -name "Basic" -layout vertical]

	set tabgroup0 [ipgui::add_group $IPINST -parent $Page0 -name "Interrupt Usage" -layout vertical]
	set C_NUM_INTR_INPUTS [ipgui::add_param $IPINST -parent $tabgroup0 -name C_NUM_INTR_INPUTS -widget comboBox]
	# set C_IRQ_ACTIVE [ipgui::add_param $IPINST -parent $tabgroup0 -name C_IRQ_ACTIVE]

	set tabgroup1 [ipgui::add_group $IPINST -parent $Page0 -name "Fast Interrupt Mode" -layout vertical]
	set C_HAS_FAST [ipgui::add_param $IPINST -parent $tabgroup1 -name C_HAS_FAST -widget checkBox]
	set C_IVAR_RESET_VALUE [ipgui::add_param $IPINST -parent $tabgroup1 -name C_IVAR_RESET_VALUE]

	set tabgroup2 [ipgui::add_group $IPINST -parent $Page0 -name "Peripheral Interrupts Type" -layout vertical]
	set C_KIND_OF_INTR [ipgui::add_param $IPINST -parent $tabgroup2 -name C_KIND_OF_INTR]
	set C_KIND_OF_LVL [ipgui::add_param $IPINST -parent $tabgroup2 -name C_KIND_OF_LVL]
	set C_KIND_OF_EDGE [ipgui::add_param $IPINST -parent $tabgroup2 -name C_KIND_OF_EDGE]

	set C_ASYNC_INTR   [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ASYNC_INTR]
	set C_NUM_SYNC_FF  [ipgui::add_param $IPINST -parent $tabgroup2 -name C_NUM_SYNC_FF -widget comboBox]
	set C_ADDR_WIDTH   [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ADDR_WIDTH]
	set_property visible false $C_ASYNC_INTR
	set_property visible false $C_NUM_SYNC_FF
	set_property visible false $C_ADDR_WIDTH

	set tabgroup3 [ipgui::add_group $IPINST -parent $Page0 -name "Processor Interrupt Type and Connection" -layout vertical]
	set C_IRQ_IS_LEVEL [ipgui::add_param $IPINST -parent $tabgroup3 -name C_IRQ_IS_LEVEL -widget comboBox -layout horizontal]
	set Sense_of_IRQ_Level_Type [ipgui::add_param $IPINST -parent $tabgroup3 -name Sense_of_IRQ_Level_Type -widget comboBox]
	set Sense_of_IRQ_Edge_Type [ipgui::add_param $IPINST -parent $tabgroup3 -name Sense_of_IRQ_Edge_Type -widget comboBox]
	set C_IRQ_CONNECTION [ipgui::add_param $IPINST -parent $tabgroup3 -name C_IRQ_CONNECTION -widget comboBox]

	set Page1 [ ipgui::add_page $IPINST  -name "Advanced" -layout vertical]
	set tabgroup4 [ipgui::add_group $IPINST -parent $Page1 -name "Register Usage" -layout vertical]
	set C_HAS_SIE [ipgui::add_param $IPINST -parent $tabgroup4 -name C_HAS_SIE -widget checkBox]
	set C_HAS_CIE [ipgui::add_param $IPINST -parent $tabgroup4 -name C_HAS_CIE -widget checkBox]
	set C_HAS_IVR [ipgui::add_param $IPINST -parent $tabgroup4 -name C_HAS_IVR -widget checkBox]
	set C_HAS_IPR [ipgui::add_param $IPINST -parent $tabgroup4 -name C_HAS_IPR -widget checkBox]
	set C_HAS_ILR [ipgui::add_param $IPINST -parent $tabgroup4 -name C_HAS_ILR -widget checkBox]

	set tabgroup5 [ipgui::add_group $IPINST -parent $Page1 -name "Cascade Mode" -layout horizontal]
	set C_EN_CASCADE_MODE [ipgui::add_param $IPINST -parent $tabgroup5 -name C_EN_CASCADE_MODE -widget checkBox]
	set C_CASCADE_MASTER [ipgui::add_param $IPINST -parent $tabgroup5 -name C_CASCADE_MASTER -widget checkBox]

	set tabgroup6 [ipgui::add_group $IPINST -parent $Page1 -name "Asynchronous Clocks" -layout vertical]
	set C_MB_CLK_NOT_CONNECTED [ipgui::add_param $IPINST -parent $tabgroup6 -name C_MB_CLK_NOT_CONNECTED -widget checkBox]
	set C_DISABLE_SYNCHRONIZERS [ipgui::add_param $IPINST -parent $tabgroup6 -name C_DISABLE_SYNCHRONIZERS -widget checkBox]
	set C_ENABLE_ASYNC  [ipgui::add_param $IPINST -parent $tabgroup6 -name C_ENABLE_ASYNC -widget checkBox]

	set tabgroup7 [ipgui::add_group $IPINST -parent $Page1 -name "Software Interrupts" -layout vertical]
	set C_NUM_SW_INTR [ipgui::add_param $IPINST -parent $tabgroup7 -name C_NUM_SW_INTR -widget comboBox]

	set_property visible false $C_MB_CLK_NOT_CONNECTED
	set_property visible false $C_DISABLE_SYNCHRONIZERS

	# Clocks tab for OOC clock frequencies
	set Page2 [ipgui::add_page $IPINST -name Clocks -layout vertical]
	set text [ipgui::add_static_text -name "Clock constraints" -text "Enter the target frequency for the input clock(s) for the IP.\nThese frequencies will be used during the default out-of-context synthesis flow" -parent $Page2 $IPINST]
	set C_S_AXI_ACLK_FREQ_MHZ [ipgui::add_param $IPINST -parent $Page2 -name C_S_AXI_ACLK_FREQ_MHZ]
	set C_PROCESSOR_CLK_FREQ_MHZ [ipgui::add_param $IPINST -parent $Page2 -name C_PROCESSOR_CLK_FREQ_MHZ]

	set_property tooltip "This check box should be set when the Interrupt Pending Register is required in the core." $C_HAS_IPR
	set_property tooltip "This check box should be set when the Set Interrupt Enable Register is required in the core." $C_HAS_SIE
	set_property tooltip "This check box should be set when the Clear Interrupt Enable Register is required in the core." $C_HAS_CIE
	set_property tooltip "This check box should be set when the Interrupt Vector Register is required in the core." $C_HAS_IVR
	set_property tooltip "This check box should be set when nested interrupt support using the Interrupt Level Register is required in the core." $C_HAS_ILR
	# set_property tooltip "This option should be set to define the IRQ port active logic level. 0 = Falling/Low, 1 = Rising/High." $C_IRQ_ACTIVE
	set_property tooltip "The setting of each bit in this option indicates the type of incoming interrupt for each bit. 0 = Level, 1 = Edge. Updates of these settings will affect C_KIND_OF_INTR parameter values." $C_KIND_OF_INTR
	set_property tooltip "The setting of this option indicates number of interrupts input to the core." $C_NUM_INTR_INPUTS
	set_property tooltip "Number of interrupts controlled by software in addition to the hardware interrupt inputs" $C_NUM_SW_INTR
	set_property tooltip "The setting of each bit in this option indicates type of logic level for the incoming interrupt of each bit. 0 = Low, 1 = High." $C_KIND_OF_LVL
	set_property tooltip "The setting of each bit in this option indicates whether the incoming interrupt is treated as asynchronous or not. 0 = Synchronous, 1 = Asynchronous." $C_ASYNC_INTR
	set_property tooltip "Number of synchronization flip-flops used to synchronize asynchronous interrupt inputs" $C_NUM_SYNC_FF
        set_property tooltip "Fast mode interrupt interrupt address width" $C_ADDR_WIDTH
	set_property tooltip "The setting of this option indicates the IRQ port active type. 0 = Active Edge, 1 = Active Level." $C_IRQ_IS_LEVEL
	set_property tooltip "The setting of each bit in this option indicates the type of edge for the incoming interrupt of each bit. 0 = Falling, 1 = Rising." $C_KIND_OF_EDGE
	set_property tooltip "This check box should be set when the core is configured with Fast Mode Interrupt. The processor uses this setting to automatically enable the low-latency interrupt functionality. Fast Mode Interrupt is not available when selecting Single interrupt output connection." $C_HAS_FAST
	set_property tooltip "This option determines the Interrupt Vector Address Register reset value. It should be set to the processor interrupt vector address, which is C_BASE_VECTORS + 0x10 for MicroBlaze. Only used when the core is configured with Fast Mode Interrupt." $C_IVAR_RESET_VALUE
	set_property tooltip "Set this option when the AXI clock is asynchronous to the processor clock. In this case the processor_clk and processor_rst inputs must be connected to the processor clock and reset, respectively. Only used when the core is configured with Fast Mode Interrupt." $C_ENABLE_ASYNC
	set_property tooltip "The setting of this parameter indicates the IRQ port type of level. 0 = Level Low, 1 = Level High." $Sense_of_IRQ_Level_Type
	set_property tooltip "The setting of this parameter indicates the IRQ port type of edge. 0 = Falling Edge, 1 = Rising Edge." $Sense_of_IRQ_Edge_Type
	set_property tooltip "This check box should be set only when the system has more than 32 interrupt sources. This setting is applicable for all instances of the AXI INTC core cascaded together to handle more than 32 interrupts." $C_EN_CASCADE_MODE
	set_property tooltip "This check box should be set only when the system has more than 32 interrupt sources. The setting of this check box is only applicable to the primary instance of the AXI INTC core with the IRQ output directly connected to the processor. For the remaining instances of the cascaded AXI INTC cores, this check box should be left un-checked." $C_CASCADE_MASTER
	set_property tooltip "This parameter should be set only when the core has the processor clock connected to its interrupt interface." $C_MB_CLK_NOT_CONNECTED
	set_property tooltip "This check box should be set only when the core has the processor clock connected to its interrupt interface and the core and processor clock are synchronous." $C_DISABLE_SYNCHRONIZERS
	set_property tooltip "Select interrupt output connection bus interface. Normally Bus is used when connecting to MicroBlaze and cascaded AXI Interrupt Controllers. Otherwise Single can be used when Fast Mode Interrupt is not enabled, and the target has a single interrupt input." $C_IRQ_CONNECTION
}


# Convert to bitstring
proc to_bitstring {value} {
  if {[regexp {([0-9]*)\'b([0-1]*)} $value match bitlen bitvalue]} {
    set len [string length $bitvalue]
    set bitvalue [format "%0${bitlen}s" [string range $bitvalue [expr ($len > $bitlen) ? $len - $bitlen : 0] end]]
  } elseif {[regexp {X\"([0-9A-Fa-f]*)\"} $value match hexvalue] || [regexp {0x([0-9A-Fa-f]*)} $value match hexvalue]} {
    binary scan [binary format H* $hexvalue] B* bitvalue
  } else {
    set bitvalue 0
    regexp {\"*([0-1]*)\"*} $value match bitvalue
  }
  return $bitvalue
}

# Convert to hex of given length: truncate if longer, prepend zeros if shorter
proc to_hex {value {length 32}} {
  set bitvalue [to_bitstring $value]
  set bitlen   [string length $bitvalue]
  set bitvalue [format "%0${length}s" [string range $bitvalue [expr ($bitlen > $length) ? $bitlen - $length : 0] end]]
  binary scan [binary format B* $bitvalue] H* hexvalue
  return "0x${hexvalue}"
}

proc update_PARAM_VALUE.C_NUM_SW_INTR { PARAM_VALUE.C_NUM_SW_INTR PARAM_VALUE.C_NUM_INTR_INPUTS} {
	set num_intr_inputs [get_property value ${PARAM_VALUE.C_NUM_INTR_INPUTS}]
	set max [expr 32 - $num_intr_inputs]
	set_property range "0,$max" ${PARAM_VALUE.C_NUM_SW_INTR}
}

proc update_PARAM_VALUE.C_IVAR_RESET_VALUE { PARAM_VALUE.C_IVAR_RESET_VALUE PARAM_VALUE.C_HAS_FAST} {
	set has_fast [get_property value ${PARAM_VALUE.C_HAS_FAST}]
	set ivar_reset ${PARAM_VALUE.C_IVAR_RESET_VALUE}
	set_property enabled [expr $has_fast ? true : false] $ivar_reset
}

proc update_PARAM_VALUE.Sense_of_IRQ_Level_Type { PARAM_VALUE.Sense_of_IRQ_Level_Type PARAM_VALUE.C_IRQ_IS_LEVEL} {
	set edge [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL} ]
	if {$edge == 0} {
		set_property value Active_High ${PARAM_VALUE.Sense_of_IRQ_Level_Type}
	}
}

proc update_gui_for_PARAM_VALUE.C_IRQ_IS_LEVEL { PARAM_VALUE.C_IRQ_IS_LEVEL \
                                                 PARAM_VALUE.Sense_of_IRQ_Level_Type \
                                                 PARAM_VALUE.Sense_of_IRQ_Edge_Type IPINST } {
	set edge [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL} ]
	if {$edge == 0} {
		set_property visible false [ipgui::get_guiparamspec -name Sense_of_IRQ_Level_Type -of $IPINST]
	} else {
		set_property visible true [ipgui::get_guiparamspec -name Sense_of_IRQ_Level_Type -of $IPINST]
	}
	if {$edge == 1} {
		set_property visible false [ipgui::get_guiparamspec -name Sense_of_IRQ_Edge_Type -of $IPINST]
	} else {
		set_property visible true [ipgui::get_guiparamspec -name Sense_of_IRQ_Edge_Type -of $IPINST]
	}
}

proc update_PARAM_VALUE.Sense_of_IRQ_Edge_Type { PARAM_VALUE.Sense_of_IRQ_Edge_Type PARAM_VALUE.C_IRQ_IS_LEVEL } {
	set edge [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL} ]
	if {$edge == 1} {
		set_property value Rising ${PARAM_VALUE.Sense_of_IRQ_Edge_Type}
	}
}

proc update_gui_for_PARAM_VALUE.Sense_of_IRQ_Edge_Type { PARAM_VALUE.Sense_of_IRQ_Edge_Type PARAM_VALUE.C_IRQ_IS_LEVEL IPINST } {
	set edge [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL} ]
	if {$edge == 1} {
		set_property visible false [ipgui::get_guiparamspec -name Sense_of_IRQ_Edge_Type -of $IPINST]
	}
	if {$edge == 0} {
		set_property visible true [ipgui::get_guiparamspec -name Sense_of_IRQ_Edge_Type -of $IPINST]
	}
}

proc update_PARAM_ENABLEMENT.C_IRQ_CONNECTION { PARAM_ENABLEMENT.C_IRQ_CONNECTION PARAM_VALUE.C_HAS_FAST} {
	set has_fast [get_property value ${PARAM_VALUE.C_HAS_FAST}]
	set irq_connection ${PARAM_ENABLEMENT.C_IRQ_CONNECTION}
	set_property enabled [expr $has_fast ? false : true] $irq_connection
}

proc update_PARAM_ENABLEMENT.C_PROCESSOR_CLK_FREQ_MHZ { PARAM_ENABLEMENT.C_PROCESSOR_CLK_FREQ_MHZ PARAM_VALUE.C_HAS_FAST } {
	set has_fast [get_property value ${PARAM_VALUE.C_HAS_FAST}]
	set processor_clk_freq_mhz ${PARAM_ENABLEMENT.C_PROCESSOR_CLK_FREQ_MHZ}
	set_property enabled [expr $has_fast ? true : false] $processor_clk_freq_mhz
}

proc update_PARAM_ENABLEMENT.C_HAS_FAST { PARAM_ENABLEMENT.C_HAS_FAST PARAM_VALUE.C_IRQ_CONNECTION} {
	set has_fast ${PARAM_ENABLEMENT.C_HAS_FAST}
	set irq_connection [get_property value ${PARAM_VALUE.C_IRQ_CONNECTION}]
	set_property enabled [expr $irq_connection ? false : true] $has_fast
}

proc update_PARAM_VALUE.C_DISABLE_SYNCHRONIZERS { PARAM_VALUE.C_DISABLE_SYNCHRONIZERS PARAM_VALUE.C_ENABLE_ASYNC } {
	if {[get_property value ${PARAM_VALUE.C_ENABLE_ASYNC}] == 1} {
		set value 0
	} else {
		set value 1
	}
	set_property value $value ${PARAM_VALUE.C_DISABLE_SYNCHRONIZERS}
}

proc update_PARAM_VALUE.C_MB_CLK_NOT_CONNECTED { PARAM_VALUE.C_MB_CLK_NOT_CONNECTED PARAM_VALUE.C_ENABLE_ASYNC } {
	if {[get_property value ${PARAM_VALUE.C_ENABLE_ASYNC}] == 1} {
		set value 1
	} else {
		set value 0
	}
	set value_not [expr 1 - $value]
	set_property value $value_not ${PARAM_VALUE.C_MB_CLK_NOT_CONNECTED}
}

proc update_MODELPARAM_VALUE.C_INSTANCE { MODELPARAM_VALUE.C_INSTANCE PARAM_VALUE.COMPONENT_NAME } {
	set val [get_property value ${PARAM_VALUE.COMPONENT_NAME}]
	set_property value $val ${MODELPARAM_VALUE.C_INSTANCE}
}

proc update_MODELPARAM_VALUE.C_NUM_SW_INTR { MODELPARAM_VALUE.C_NUM_SW_INTR PARAM_VALUE.C_NUM_SW_INTR } {
	set_property value [get_property value ${PARAM_VALUE.C_NUM_SW_INTR}] ${MODELPARAM_VALUE.C_NUM_SW_INTR}
}

proc update_MODELPARAM_VALUE.C_KIND_OF_INTR { MODELPARAM_VALUE.C_KIND_OF_INTR PARAM_VALUE.C_KIND_OF_INTR } {
	set_property bitstring_length 32 ${MODELPARAM_VALUE.C_KIND_OF_INTR}
	set val [string tolower [to_hex [get_property value ${PARAM_VALUE.C_KIND_OF_INTR}]]]
	set_property value $val ${MODELPARAM_VALUE.C_KIND_OF_INTR}
}

proc update_MODELPARAM_VALUE.C_KIND_OF_EDGE { MODELPARAM_VALUE.C_KIND_OF_EDGE PARAM_VALUE.C_KIND_OF_EDGE } {
	set_property bitstring_length 32  ${MODELPARAM_VALUE.C_KIND_OF_EDGE}
	set val [string tolower [to_hex [get_property value ${PARAM_VALUE.C_KIND_OF_EDGE}]]]
	set_property value $val ${MODELPARAM_VALUE.C_KIND_OF_EDGE}
}

proc update_MODELPARAM_VALUE.C_KIND_OF_LVL { MODELPARAM_VALUE.C_KIND_OF_LVL PARAM_VALUE.C_KIND_OF_LVL } {
	set_property bitstring_length 32 ${MODELPARAM_VALUE.C_KIND_OF_LVL}
	set val [string tolower [to_hex [get_property value ${PARAM_VALUE.C_KIND_OF_LVL}]]]
	set_property value $val ${MODELPARAM_VALUE.C_KIND_OF_LVL}
}

proc update_MODELPARAM_VALUE.C_ASYNC_INTR { MODELPARAM_VALUE.C_ASYNC_INTR PARAM_VALUE.C_ASYNC_INTR } {
	set_property value [get_property value ${PARAM_VALUE.C_ASYNC_INTR}] ${MODELPARAM_VALUE.C_ASYNC_INTR}
}

proc update_MODELPARAM_VALUE.C_NUM_SYNC_FF { MODELPARAM_VALUE.C_NUM_SYNC_FF PARAM_VALUE.C_NUM_SYNC_FF } {
	set_property value [get_property value ${PARAM_VALUE.C_NUM_SYNC_FF}] ${MODELPARAM_VALUE.C_NUM_SYNC_FF}
}

proc update_MODELPARAM_VALUE.C_ADDR_WIDTH { MODELPARAM_VALUE.C_ADDR_WIDTH PARAM_VALUE.C_ADDR_WIDTH } {
	set_property value [get_property value ${PARAM_VALUE.C_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_IVAR_RESET_VALUE { MODELPARAM_VALUE.C_IVAR_RESET_VALUE PARAM_VALUE.C_IVAR_RESET_VALUE } {
	set_property value [get_property value ${PARAM_VALUE.C_IVAR_RESET_VALUE}] ${MODELPARAM_VALUE.C_IVAR_RESET_VALUE}
}

proc update_MODELPARAM_VALUE.C_ENABLE_ASYNC { MODELPARAM_VALUE.C_ENABLE_ASYNC PARAM_VALUE.C_ENABLE_ASYNC } {
	set_property value [get_property value ${PARAM_VALUE.C_ENABLE_ASYNC}] ${MODELPARAM_VALUE.C_ENABLE_ASYNC}
}

proc update_MODELPARAM_VALUE.C_HAS_IPR { MODELPARAM_VALUE.C_HAS_IPR PARAM_VALUE.C_HAS_IPR } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_IPR}] ${MODELPARAM_VALUE.C_HAS_IPR}
}

proc update_MODELPARAM_VALUE.C_HAS_SIE { MODELPARAM_VALUE.C_HAS_SIE PARAM_VALUE.C_HAS_SIE } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_SIE}] ${MODELPARAM_VALUE.C_HAS_SIE}
}

proc update_MODELPARAM_VALUE.C_HAS_CIE { MODELPARAM_VALUE.C_HAS_CIE PARAM_VALUE.C_HAS_CIE } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_CIE}] ${MODELPARAM_VALUE.C_HAS_CIE}
}

proc update_MODELPARAM_VALUE.C_HAS_IVR { MODELPARAM_VALUE.C_HAS_IVR PARAM_VALUE.C_HAS_IVR } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_IVR}] ${MODELPARAM_VALUE.C_HAS_IVR}
}

proc update_MODELPARAM_VALUE.C_HAS_ILR { MODELPARAM_VALUE.C_HAS_ILR PARAM_VALUE.C_HAS_ILR } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_ILR}] ${MODELPARAM_VALUE.C_HAS_ILR}
}

proc update_MODELPARAM_VALUE.C_IRQ_IS_LEVEL { MODELPARAM_VALUE.C_IRQ_IS_LEVEL PARAM_VALUE.C_IRQ_IS_LEVEL } {
	set_property value [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL}] ${MODELPARAM_VALUE.C_IRQ_IS_LEVEL}
}

proc update_MODELPARAM_VALUE.C_IRQ_ACTIVE { MODELPARAM_VALUE.C_IRQ_ACTIVE \
                                            PARAM_VALUE.Sense_of_IRQ_Level_Type \
                                            PARAM_VALUE.Sense_of_IRQ_Edge_Type \
                                            PARAM_VALUE.C_IRQ_IS_LEVEL} {
	set edge [get_property value ${PARAM_VALUE.C_IRQ_IS_LEVEL} ]
	if {$edge == 1} {
		set irq_active [get_property value ${PARAM_VALUE.Sense_of_IRQ_Level_Type} ]
		if {$irq_active == "Active_High"} {
			set value "0x1"
		}
		if {$irq_active == "Active_Low"} {
			set value "0x0"
		}
	}
	if {$edge == 0} {
		set irq_active [get_property value ${PARAM_VALUE.Sense_of_IRQ_Edge_Type} ]
		if {$irq_active == "Rising"} {
			set value "0x1"
		}
		if {$irq_active == "Falling"} {
			set value "0x0"
		}
	}

	set_property value $value ${MODELPARAM_VALUE.C_IRQ_ACTIVE}
}

proc update_MODELPARAM_VALUE.C_DISABLE_SYNCHRONIZERS { MODELPARAM_VALUE.C_DISABLE_SYNCHRONIZERS PARAM_VALUE.C_DISABLE_SYNCHRONIZERS } {
	set_property value [get_property value ${PARAM_VALUE.C_DISABLE_SYNCHRONIZERS}] ${MODELPARAM_VALUE.C_DISABLE_SYNCHRONIZERS}
}

proc update_MODELPARAM_VALUE.C_MB_CLK_NOT_CONNECTED { MODELPARAM_VALUE.C_MB_CLK_NOT_CONNECTED PARAM_VALUE.C_ENABLE_ASYNC } {
	if {[get_property value ${PARAM_VALUE.C_ENABLE_ASYNC}] == 1} {
		set value 1
	} else {
		set value 0
	}
	set value_not [expr 1 - $value]
	set_property value $value_not ${MODELPARAM_VALUE.C_MB_CLK_NOT_CONNECTED}
}

proc update_MODELPARAM_VALUE.C_HAS_FAST { MODELPARAM_VALUE.C_HAS_FAST PARAM_VALUE.C_HAS_FAST } {
	set_property value [get_property value ${PARAM_VALUE.C_HAS_FAST}] ${MODELPARAM_VALUE.C_HAS_FAST}
}

proc update_MODELPARAM_VALUE.C_NUM_INTR_INPUTS { MODELPARAM_VALUE.C_NUM_INTR_INPUTS PARAM_VALUE.C_NUM_INTR_INPUTS } {
	set_property value [get_property value ${PARAM_VALUE.C_NUM_INTR_INPUTS}] ${MODELPARAM_VALUE.C_NUM_INTR_INPUTS}
}

proc update_MODELPARAM_VALUE.C_EN_CASCADE_MODE { MODELPARAM_VALUE.C_EN_CASCADE_MODE PARAM_VALUE.C_EN_CASCADE_MODE } {
	set_property value [get_property value ${PARAM_VALUE.C_EN_CASCADE_MODE}] ${MODELPARAM_VALUE.C_EN_CASCADE_MODE}
}

proc update_MODELPARAM_VALUE.C_CASCADE_MASTER { MODELPARAM_VALUE.C_CASCADE_MASTER PARAM_VALUE.C_CASCADE_MASTER } {
	set_property value [get_property value ${PARAM_VALUE.C_CASCADE_MASTER}] ${MODELPARAM_VALUE.C_CASCADE_MASTER}
}
