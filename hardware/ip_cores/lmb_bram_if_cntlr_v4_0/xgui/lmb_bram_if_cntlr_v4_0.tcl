###############################################################################
# (c) Copyright 2011-2013,2015,2019,2022-2023,2025 Advanced Micro Devices, Inc. All rights reserved.
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
## lmb_bram_if_cntlr_v4_0.tcl
##
###############################################################################

proc init_gui { IPINST } {
  set Component_Name [ ipgui::add_param  $IPINST  -parent  $IPINST -name Component_Name ]

  set_property hide_disabled_pins true [ipgui::get_canvasspec -of $IPINST]

  set tabgroup0 [ipgui::add_page $IPINST -name Addresses -layout vertical] 
  set C_NUM_LMB [ipgui::add_param $IPINST -parent $tabgroup0 -name C_NUM_LMB -widget comboBox]
  set_property tooltip {This parameter defines the the number of LMB ports to be used} $C_NUM_LMB
  set C_ARBITRATION [ipgui::add_param $IPINST -parent $tabgroup0 -name C_ARBITRATION -widget comboBox]
  set_property tooltip {This parameter defines the arbitration scheme when more than one LMB port is used.  With STATIC PRIORITY, the lowest numbered port requesting an access is selected, whereas ROUND ROBIN selects the ports in circular order.} $C_ARBITRATION
  set C_WRITE_ACCESS [ipgui::add_param $IPINST -parent $tabgroup0 -name C_WRITE_ACCESS -widget comboBox]
  set_property tooltip {This parameter define the type of write accesses that will be used} $C_WRITE_ACCESS
  set C_BASEADDR [ipgui::add_param $IPINST -parent $tabgroup0 -name C_BASEADDR]
  set_property tooltip {This address specifies where the LMB BRAM controller's address space starts.  If this controller is where a MicroBlaze is booting from this should be set to the value of MicroBlaze C_BASE_VECTORS parameter, normally 0x0000000000000000.  By default this value is larger than the high address so that an error will be generated if this value is not specified.  If IP Integrator is used an address is automatically assigned.} $C_BASEADDR
  set C_HIGHADDR [ipgui::add_param $IPINST -parent $tabgroup0 -name C_HIGHADDR]
  set_property tooltip {This address specifies where the LMB BRAM controller's address space ends.  By default this value is smaller than the base address so that an error will be generated if this value is not specified.  If IP Integrator is used an address is automatically assigned.} $C_HIGHADDR
  set C_MASK [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK
  set C_MASK1 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK1]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB1.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK1
  set C_MASK2 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK2]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB2.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK2
  set C_MASK3 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK3]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB3.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK3
  set C_MASK4 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK4]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB4.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK4
  set C_MASK5 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK5]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB5.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK5
  set C_MASK6 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK6]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB6.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK6
  set C_MASK7 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_MASK7]
  set_property tooltip {IP Integrator automatically sets this value to the mask of bits used to decode this peripheral on SLMB7.  Any bits that are set to '1' in the mask indicate that the address bit in that position is used to decode a valid LMB access.  All other bits are considered don't cares for the purpose of decoding LMB accesses.} $C_MASK7

  set C_PROT_CFG [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG]
  set_property tooltip {Defines protection configuration on SLMB. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG1 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG1]
  set_property tooltip {Defines protection configuration on SLMB1. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB1_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG2 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG2]
  set_property tooltip {Defines protection configuration on SLMB2. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB2_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG3 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG3]
  set_property tooltip {Defines protection configuration on SLMB3. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB3_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG4 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG4]
  set_property tooltip {Defines protection configuration on SLMB4. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB4_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG5 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG5]
  set_property tooltip {Defines protection configuration on SLMB5. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB5_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG6 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG6]
  set_property tooltip {Defines protection configuration on SLMB6. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB6_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG
  set C_PROT_CFG7 [ipgui::add_param $IPINST -parent $tabgroup0 -name C_PROT_CFG7]
  set_property tooltip {Defines protection configuration on SLMB7. When protection is enabled, an access is only performed if the configuration bit corresponding to LMB7_Prot is set. The first nibble defines read access and the second defines write access.} $C_PROT_CFG

  set tabgroup2 [ipgui::add_page $IPINST -name ECC -layout vertical] 
  set C_ECC [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ECC -widget checkBox]
  set_property tooltip {This parameter enables Error Correction Codes to correct single bit errors and detect double bit errors in the BRAM} $C_ECC
  set C_INTERCONNECT [ipgui::add_param $IPINST -parent $tabgroup2 -name C_INTERCONNECT -widget comboBox]
  set_property tooltip {This parameter selects interface type for ECC register accesses. None = 0 and AXI4-Lite = 2} $C_INTERCONNECT
  set C_FAULT_INJECT [ipgui::add_param $IPINST -parent $tabgroup2 -name C_FAULT_INJECT -widget checkBox]
  set_property tooltip {This parameter enables Fault Inject registers to inject errors when writing to the BRAM} $C_FAULT_INJECT
  set C_CE_FAILING_REGISTERS [ipgui::add_param $IPINST -parent $tabgroup2 -name C_CE_FAILING_REGISTERS -widget checkBox]
  set_property tooltip {This parameter enables first failing register to store address and data for a correctable error} $C_CE_FAILING_REGISTERS
  set C_UE_FAILING_REGISTERS [ipgui::add_param $IPINST -parent $tabgroup2 -name C_UE_FAILING_REGISTERS -widget checkBox]
  set_property tooltip {This parameter enables first failing register to store address and data for a uncorrectable error} $C_UE_FAILING_REGISTERS
  set C_ECC_STATUS_REGISTERS [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ECC_STATUS_REGISTERS -widget checkBox]
  set_property tooltip {This parameter enables ECC Status and Control Register to control status and interrupt generation} $C_ECC_STATUS_REGISTERS
  set C_ECC_ONOFF_REGISTER [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ECC_ONOFF_REGISTER -widget checkBox]
  set_property tooltip {This parameter enables ECC On/Off Register to enable ECC checking being switched on/off} $C_ECC_ONOFF_REGISTER
  set C_ECC_ONOFF_RESET_VALUE [ipgui::add_param $IPINST -parent $tabgroup2 -name C_ECC_ONOFF_RESET_VALUE -widget comboBox]
  set_property tooltip {This parameter sets the reset value for the ECC On/Off Register} $C_ECC_ONOFF_RESET_VALUE
  set C_CE_COUNTER_WIDTH [ipgui::add_param $IPINST -parent $tabgroup2 -name C_CE_COUNTER_WIDTH ]
  set_property tooltip {This parameter implements a Correctable Error Counter Register to count occurances of correctable errors} $C_CE_COUNTER_WIDTH

  # Hidden parameters - added to avoid warnings
  set C_LMB_AWIDTH [ipgui::add_param $IPINST -parent $tabgroup2 -name C_LMB_AWIDTH -widget radioGroup]
  set_property visible false $C_LMB_AWIDTH
  set C_LMB_DWIDTH [ipgui::add_param $IPINST -parent $tabgroup2 -name C_LMB_DWIDTH -widget radioGroup]
  set_property visible false $C_LMB_DWIDTH
  set C_LMB_PROTOCOL [ipgui::add_param $IPINST -parent $tabgroup2 -name C_LMB_PROTOCOL -widget radioGroup]
  set_property visible false $C_LMB_PROTOCOL
  set C_LMB_HAS_PROT [ipgui::add_param $IPINST -parent $tabgroup2 -name C_LMB_HAS_PROT -widget checkBox]
  set_property visible false $C_LMB_HAS_PROT
  set C_S_AXI_CTRL_ADDR_WIDTH [ipgui::add_param $IPINST -parent $tabgroup2 -name C_S_AXI_CTRL_ADDR_WIDTH -widget radioGroup ]
  set_property visible false $C_S_AXI_CTRL_ADDR_WIDTH
  set C_S_AXI_CTRL_DATA_WIDTH [ipgui::add_param $IPINST -parent $tabgroup2 -name C_S_AXI_CTRL_DATA_WIDTH -widget radioGroup]
  set_property visible false $C_S_AXI_CTRL_DATA_WIDTH
  set C_S_AXI_CTRL_ACLK_FREQ_HZ [ipgui::add_param $IPINST -parent $tabgroup2 -name C_S_AXI_CTRL_ACLK_FREQ_HZ ]
  set_property visible false $C_S_AXI_CTRL_ACLK_FREQ_HZ
}

proc update_PARAM_VALUE.C_FAULT_INJECT {PARAM_VALUE.C_FAULT_INJECT PARAM_VALUE.C_ECC PARAM_VALUE.C_INTERCONNECT PARAM_VALUE.C_WRITE_ACCESS} {
  set ecc          [get_property value ${PARAM_VALUE.C_ECC}]
  set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  set write_access [get_property value ${PARAM_VALUE.C_WRITE_ACCESS}]
  if {$ecc == 1 && $interconnect != 0 && $write_access != 0} {
    set_property enabled true ${PARAM_VALUE.C_FAULT_INJECT}
  } else {
    set_property enabled false ${PARAM_VALUE.C_FAULT_INJECT}
  }
}

proc update_PARAM_VALUE.C_MASK1 {PARAM_VALUE.C_MASK1 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 1 } {
    set_property enabled true ${PARAM_VALUE.C_MASK1}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK1}
  }
}

proc update_PARAM_VALUE.C_MASK2 {PARAM_VALUE.C_MASK2 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 2 } {
    set_property enabled true ${PARAM_VALUE.C_MASK2}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK2}
  }
}

proc update_PARAM_VALUE.C_MASK3 {PARAM_VALUE.C_MASK3 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 3 } {
    set_property enabled true ${PARAM_VALUE.C_MASK3}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK3}
  }
}

proc update_PARAM_VALUE.C_MASK4 {PARAM_VALUE.C_MASK4 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 4 } {
    set_property enabled true ${PARAM_VALUE.C_MASK4}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK4}
  }
}

proc update_PARAM_VALUE.C_MASK5 {PARAM_VALUE.C_MASK5 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 5 } {
    set_property enabled true ${PARAM_VALUE.C_MASK5}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK5}
  }
}

proc update_PARAM_VALUE.C_MASK6 {PARAM_VALUE.C_MASK6 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 6 } {
    set_property enabled true ${PARAM_VALUE.C_MASK6}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK6}
  }
}

proc update_PARAM_VALUE.C_MASK7 {PARAM_VALUE.C_MASK7 PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 7 } {
    set_property enabled true ${PARAM_VALUE.C_MASK7}
  } else {
    set_property enabled false ${PARAM_VALUE.C_MASK7}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG {PARAM_VALUE.C_PROT_CFG PARAM_VALUE.C_LMB_HAS_PROT} {
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG1 {PARAM_VALUE.C_PROT_CFG1 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 1 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG1}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG1}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG2 {PARAM_VALUE.C_PROT_CFG2 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 2 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG2}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG2}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG3 {PARAM_VALUE.C_PROT_CFG3 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 3 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG3}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG3}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG4 {PARAM_VALUE.C_PROT_CFG4 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 4 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG4}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG4}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG5 {PARAM_VALUE.C_PROT_CFG5 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 5 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG5}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG5}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG6 {PARAM_VALUE.C_PROT_CFG6 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 6 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG6}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG6}
  }
}

proc update_PARAM_VALUE.C_PROT_CFG7 {PARAM_VALUE.C_PROT_CFG7 PARAM_VALUE.C_NUM_LMB PARAM_VALUE.C_LMB_HAS_PROT} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  set has_prot [get_property value ${PARAM_VALUE.C_LMB_HAS_PROT}]
  if {$value1 > 7 && $has_prot == 1} {
    set_property enabled true ${PARAM_VALUE.C_PROT_CFG7}
  } else {
    set_property enabled false ${PARAM_VALUE.C_PROT_CFG7}
  }
}

proc update_PARAM_VALUE.C_ARBITRATION {PARAM_VALUE.C_ARBITRATION PARAM_VALUE.C_NUM_LMB} {
  set value1 [get_property value ${PARAM_VALUE.C_NUM_LMB}]
  if {$value1 > 1 } {
    set_property enabled true ${PARAM_VALUE.C_ARBITRATION}
  } else {
    set_property enabled false ${PARAM_VALUE.C_ARBITRATION}
  }
}

# support proc1  
set param_validat {  
  proc update_PARAM_VALUE.<<pd>> {PARAM_VALUE.<<pd>> PARAM_VALUE.<<p1>>} {
    set value1 [get_property value ${PARAM_VALUE.<<p1>>}]
    if {$value1 != 0} {
      set_property enabled true ${PARAM_VALUE.<<pd>>}
    } else {
      set_property enabled false ${PARAM_VALUE.<<pd>>}
    }
  }
}

# substitution and evaluation of support proc1
foreach { param1 pram_dip } { C_ECC C_INTERCONNECT }  {
  set param_validat1 [regsub -all <<p1>> $param_validat $param1 ]
  set param_validatd [regsub -all <<pd>> $param_validat1 $pram_dip ]
  eval $param_validatd
}

# support proc2
set param_validat2 {
  proc update_PARAM_VALUE.<<pd>> {PARAM_VALUE.<<pd>> PARAM_VALUE.C_ECC PARAM_VALUE.C_INTERCONNECT } {
    set ecc          [get_property value ${PARAM_VALUE.C_ECC}]
    set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]

    if {$ecc == 1 && $interconnect != 0} {
      set_property enabled true ${PARAM_VALUE.<<pd>>}
    } else {
      set_property enabled false ${PARAM_VALUE.<<pd>>}
    }
  }
}

# substitution and evaluation of support proc2
foreach { pram_dip } { C_CE_FAILING_REGISTERS C_UE_FAILING_REGISTERS C_ECC_STATUS_REGISTERS C_ECC_ONOFF_REGISTER C_ECC_ONOFF_RESET_VALUE C_CE_COUNTER_WIDTH } {
  set param_validatd [regsub -all <<pd>> $param_validat2 $pram_dip ]
  eval $param_validatd
}

#
# Procedures called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
#
proc update_MODELPARAM_VALUE.C_FAMILY {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_FAMILY} {
  set xcovalue [string tolower ${PROJECT_PARAM.ARCHITECTURE}]
  set_property value $xcovalue ${MODELPARAM_VALUE.C_FAMILY}
}

# support model param proc
set model_proc {
  proc update_MODELPARAM_VALUE.<<p>>  { MODELPARAM_VALUE.<<p>>  PARAM_VALUE.<<p>> } {
    set_property value  [get_property value   ${PARAM_VALUE.<<p>>}] ${MODELPARAM_VALUE.<<p>>}
  }
}

# substitution and evaluation of support model param proc 
foreach { param } { C_HIGHADDR C_BASEADDR \
                    C_MASK C_MASK1 C_MASK2 C_MASK3 C_MASK4 C_MASK5 C_MASK6 C_MASK7 \
                    C_PROT_CFG C_PROT_CFG1 C_PROT_CFG2 C_PROT_CFG3 C_PROT_CFG4 C_PROT_CFG5 C_PROT_CFG6 C_PROT_CFG7 \
                    C_NUM_LMB C_ECC C_INTERCONNECT \
                    C_FAULT_INJECT C_CE_FAILING_REGISTERS C_UE_FAILING_REGISTERS C_ECC_STATUS_REGISTERS \
                    C_ECC_ONOFF_REGISTER C_ECC_ONOFF_RESET_VALUE C_CE_COUNTER_WIDTH C_WRITE_ACCESS      \
                    C_LMB_AWIDTH C_LMB_DWIDTH C_LMB_PROTOCOL C_LMB_HAS_PROT C_ARBITRARTION              \
                    C_S_AXI_CTRL_ADDR_WIDTH C_S_AXI_CTRL_DATA_WIDTH C_S_AXI_CTRL_ACLK_FREQ_HZ } {
  set model_proc_p [regsub -all <<p>> $model_proc $param ]
  eval $model_proc_p
}
