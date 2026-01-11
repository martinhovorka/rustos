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
## riscv_v1_0.tcl
##
###############################################################################

proc init_gui { IPINST } {
  variable hw_parameter_array

  set Component_Name [ ipgui::add_param  $IPINST  -name Component_Name ]
  set_property hide_disabled_pins true [ipgui::get_canvasspec -of $IPINST]

  set_property allow_viewchange true [ipgui::get_canvasspec -of $IPINST]
  set_property show_wizard true [ipgui::get_canvasspec -of $IPINST]

  set AdvancedPage $IPINST
  set WizardPage $IPINST

  # Wizard Page 1: Welcome
  set PageW1 [ ipgui::add_page $IPINST -name "PageW1" -parent $WizardPage -layout vertical]
  set_property display_name "Welcome to the MicroBlaze V Configuration Wizard" $PageW1

  set iconfile [ipgui::find_file [ipgui::get_coredir] "data/riscv_logo.png"]
  set image [ipgui::add_image -width 265 -height 90 -parent $PageW1 -name $iconfile $IPINST]
  set_property load_image $iconfile $image

  set group_1_pagew_1 [ipgui::add_group $IPINST -parent $PageW1 -name "Usage Information" -layout vertical]
  set text  [ipgui::add_static_text -name "Welcome" -text "<ul><li>Select a predefined configuration with <i>Select Configuration</i> below. Information about the selected configuration <br/>can be found in the tooltip.</li><br/><li>To modify the configuration, click on the <i>Next</i> button, click on the <i>Advanced</i> button at the top to directly <br/>access parameters in a tabbed interface, or click <i>OK</i> to accept the configuration and close the dialog.</li></ul>" -parent $group_1_pagew_1 $IPINST]

  set group_2_pagew_1 [ipgui::add_group $IPINST -parent $PageW1 -name "Template" -layout horizontal]
  set_property display_name "Predefined Configurations" $group_2_pagew_1
  set_property tooltip {<html>Here you can select a predefined configuration. Each <br/>item in the list defines a RISC-V ISA subset.</html>} $group_2_pagew_1
  set G_TEMPLATE_LIST [ipgui::add_param $IPINST -parent $group_2_pagew_1 -name G_TEMPLATE_LIST -widget comboBox]
  set panel_1_pagew_1 [ipgui::add_panel $IPINST -parent $group_2_pagew_1 -name "User Modified" -layout horizontal]
  set text  [ipgui::add_dynamic_text $IPINST -name "User Modified" -parent $panel_1_pagew_1 -tclproc gui_set_modified]

  set C_DATA_SIZE [ipgui::add_param $IPINST -parent $PageW1 -name C_DATA_SIZE -widget radioGroup -layout horizontal]
  set_property tooltip {Select either the 32-bit RV32 or 64-bit RV64 system processor implementation.} $C_DATA_SIZE

  set group_3_pagew_1 [ipgui::add_group $IPINST -parent $PageW1 -name "General Settings" -layout vertical]

  set C_OPTIMIZATION [ipgui::add_param $IPINST -parent $group_3_pagew_1 -name C_OPTIMIZATION -widget comboBox]
  set_property tooltip {Select optimization: <ul><li> When set to PERFORMANCE, the implementation is selected to optimize computational performance, using a five-stage pipeline. <br/><br/> This setting is normally recommended, unless optimizing area or system frequency is critical. <br/><br/></li><li> When set to AREA, the implementation is selected to optimize area, using a three-stage pipeline with lower instruction throughput. <br/><br/> It is recommended to enable area optimization on architectures with limited resources, such as Artix or Spartan-7. <br/><br/></li><li> When set to FREQUENCY, the implementation is selected to optimize frequency, using an eight-stage pipeline. <br/><br/> It is recommended to use this optimization to reach system frequency targets, particularly with cache-based external memory and/or large LMB memory. <br/><br/></li><li> When set to THROUGHPUT, the implementation is selected to maximize computational performance, using a four-stage pipeline, which may result in lower system frequency than the five-stage pipeline.</ul>} $C_OPTIMIZATION

  set C_USE_ICACHE [ipgui::add_param $IPINST -parent $group_3_pagew_1 -name C_USE_ICACHE -widget checkBox]
  set_property tooltip {Enable the instruction cache.  The cache is only used once it is also enabled in software by setting the instruction cache enable (ICE) bit in the machine status register (MSR).} $C_USE_ICACHE

  set C_USE_DCACHE [ipgui::add_param $IPINST -parent $group_3_pagew_1 -name C_USE_DCACHE -widget checkBox]
  set_property tooltip {Enable the data cache.  The cache is only used once it is also enabled in software by setting the data cache enable (DCE) bit in the machine status register (MSR).} $C_USE_DCACHE

  set C_ENABLE_DISCRETE_PORTS [ipgui::add_param $IPINST -parent $group_3_pagew_1 -name C_ENABLE_DISCRETE_PORTS -widget checkBox]
  set_property tooltip {Enable discrete ports on the instance, useful for generating additional interrupts (Ext_BRK, Ext_NM_BRK), managing processor sleep and wakeup (Sleep, Wakeup, Dbg_Wakeup), handling debug events (Debug_Stop, Halted), and signaling error when using fault tolerance (Error).} $C_ENABLE_DISCRETE_PORTS

  # Page 1: General
  set Page1 [ ipgui::add_page $IPINST  -name "Page1" -parent $AdvancedPage -layout vertical]
  set_property display_name "General" $Page1
  set groupBox_1 [ipgui::add_group $IPINST -parent $Page1 -name Instructions]
  set panel_1_groupbox_1_page_1 [ipgui::add_panel $IPINST -parent $groupBox_1 -name "Instructions " -layout vertical ]
  set C_USE_ATOMIC [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_USE_ATOMIC -widget checkBox]
  set_property tooltip { Enable the RISC-V A Standard Extension for Atomic Instructions.} $C_USE_ATOMIC
  set C_USE_MULDIV [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_USE_MULDIV -widget comboBox]
  set_property tooltip { Enable the RISC-V M Standard Extension for Integer Multiplication and Division.  When set to STANDARD, a fixed latency radix-1 division is used.  When set to OPTIMIZED, a faster variable latency division algorithm is used.} $C_USE_MULDIV
  set C_USE_FPU [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_USE_FPU -widget comboBox]
  set_property tooltip {Setting this parameter to SINGLE enables the RISC-V F Standard Extension for Single-Precision Floating-Point.  With the 64-bit processor, setting it to DOUBLE also enables the D Standard Extension for Double-Precision Floating-Point.  Using the FPU will significantly improve the floating point performance of the application and significantly increase the core size.  Floating-point is only available when Integer Multiply and Divide is enabled.} $C_USE_FPU
  set C_USE_COMPRESSION [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_USE_COMPRESSION -widget checkBox]
  set_property tooltip { Enable the RISC-V C Standard Extension for Compressed Instructions.} $C_USE_COMPRESSION

  set panel_2_page_1 [ipgui::add_panel $IPINST -parent $panel_1_groupbox_1_page_1 -name "bitman" -layout horizontal]
  set text [ipgui::add_static_text -name "bit_manipulation" -text "Enable Bit Manipulation Extension:" -parent $panel_2_page_1 $IPINST]
  set C_USE_BITMAN_A [ipgui::add_param $IPINST -parent $panel_2_page_1 -name C_USE_BITMAN_A -widget checkBox]
  set C_USE_BITMAN_B [ipgui::add_param $IPINST -parent $panel_2_page_1 -name C_USE_BITMAN_B -widget checkBox]
  set C_USE_BITMAN_C [ipgui::add_param $IPINST -parent $panel_2_page_1 -name C_USE_BITMAN_C -widget checkBox]
  set C_USE_BITMAN_S [ipgui::add_param $IPINST -parent $panel_2_page_1 -name C_USE_BITMAN_S -widget checkBox]
  set_property tooltip { Enable the RISC-V Zba Extension for Bit Manipulation for Address Generation Instructions.} $C_USE_BITMAN_A
  set_property tooltip { Enable the RISC-V Zbb Extension for Bit Manipulation for Basic Bit-Manipulation.} $C_USE_BITMAN_B
  set_property tooltip { Enable the RISC-V Zbc Extension for Bit Manipulation for Carry-Less Multiplication.} $C_USE_BITMAN_C
  set_property tooltip { Enable the RISC-V Zbs Extension for Bit Manipulation for Single-bit Instructions.} $C_USE_BITMAN_S

  set C_PMP_ENTRIES [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ENTRIES -widget comboBox]
  set_property tooltip {Enable Physical Memory Protection (PMP) by selecting number of entries.  PMP is not available when supervisor-mode is enabled or with address size greater than 32 bits for RV32.} $C_PMP_ENTRIES
  set C_PMP_GRANULARITY [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_GRANULARITY -widget comboBox]
  set_property tooltip {Set Physical Memory Protection (PMP) granularity.  If caches are used, the minimum granularity is determined by the maximum cache line length.  Otherwise, the minimum granularity is 0 for RV32 systems and 1 for RV64 systems.} $C_PMP_GRANULARITY
  set C_PMP_ENHANCEMENTS [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ENHANCEMENTS -widget checkBox]
  set_property tooltip {Enable PMP enhancements for memory access and execution prevention on Machine mode (Smepmp)} $C_PMP_ENHANCEMENTS
  set_property visible [ea] $C_PMP_ENHANCEMENTS
  set C_PMP_CFG0 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG0]
  set_property visible false $C_PMP_CFG0
  set C_PMP_CFG1 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG1]
  set_property visible false $C_PMP_CFG1
  set C_PMP_CFG2 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG2]
  set_property visible false $C_PMP_CFG2
  set C_PMP_CFG3 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG3]
  set_property visible false $C_PMP_CFG3
  set C_PMP_CFG4 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG4]
  set_property visible false $C_PMP_CFG4
  set C_PMP_CFG5 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG5]
  set_property visible false $C_PMP_CFG5
  set C_PMP_CFG6 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG6]
  set_property visible false $C_PMP_CFG6
  set C_PMP_CFG7 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG7]
  set_property visible false $C_PMP_CFG7
  set C_PMP_CFG8 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG8]
  set_property visible false $C_PMP_CFG8
  set C_PMP_CFG9 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG9]
  set_property visible false $C_PMP_CFG9
  set C_PMP_CFG10 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG10]
  set_property visible false $C_PMP_CFG10
  set C_PMP_CFG11 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG11]
  set_property visible false $C_PMP_CFG11
  set C_PMP_CFG12 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG12]
  set_property visible false $C_PMP_CFG12
  set C_PMP_CFG13 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG13]
  set_property visible false $C_PMP_CFG13
  set C_PMP_CFG14 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG14]
  set_property visible false $C_PMP_CFG14
  set C_PMP_CFG15 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_CFG15]
  set_property visible false $C_PMP_CFG15
  set C_PMP_ADDR0 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR0]
  set_property visible false $C_PMP_ADDR0
  set C_PMP_ADDR1 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR1]
  set_property visible false $C_PMP_ADDR1
  set C_PMP_ADDR2 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR2]
  set_property visible false $C_PMP_ADDR2
  set C_PMP_ADDR3 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR3]
  set_property visible false $C_PMP_ADDR3
  set C_PMP_ADDR4 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR4]
  set_property visible false $C_PMP_ADDR4
  set C_PMP_ADDR5 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR5]
  set_property visible false $C_PMP_ADDR5
  set C_PMP_ADDR6 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR6]
  set_property visible false $C_PMP_ADDR6
  set C_PMP_ADDR7 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR7]
  set_property visible false $C_PMP_ADDR7
  set C_PMP_ADDR8 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR8]
  set_property visible false $C_PMP_ADDR8
  set C_PMP_ADDR9 [ipgui::add_param $IPINST  -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR9]
  set_property visible false $C_PMP_ADDR9
  set C_PMP_ADDR10 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR10]
  set_property visible false $C_PMP_ADDR10
  set C_PMP_ADDR11 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR11]
  set_property visible false $C_PMP_ADDR11
  set C_PMP_ADDR12 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR12]
  set_property visible false $C_PMP_ADDR12
  set C_PMP_ADDR13 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR13]
  set_property visible false $C_PMP_ADDR13
  set C_PMP_ADDR14 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR14]
  set_property visible false $C_PMP_ADDR14
  set C_PMP_ADDR15 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR15]
  set_property visible false $C_PMP_ADDR15
  set C_PMP_ADDR16 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR16]
  set_property visible false $C_PMP_ADDR16
  set C_PMP_ADDR17 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR17]
  set_property visible false $C_PMP_ADDR17
  set C_PMP_ADDR18 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR18]
  set_property visible false $C_PMP_ADDR18
  set C_PMP_ADDR19 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR19]
  set_property visible false $C_PMP_ADDR19
  set C_PMP_ADDR20 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR20]
  set_property visible false $C_PMP_ADDR20
  set C_PMP_ADDR21 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR21]
  set_property visible false $C_PMP_ADDR21
  set C_PMP_ADDR22 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR22]
  set_property visible false $C_PMP_ADDR22
  set C_PMP_ADDR23 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR23]
  set_property visible false $C_PMP_ADDR23
  set C_PMP_ADDR24 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR24]
  set_property visible false $C_PMP_ADDR24
  set C_PMP_ADDR25 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR25]
  set_property visible false $C_PMP_ADDR25
  set C_PMP_ADDR26 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR26]
  set_property visible false $C_PMP_ADDR26
  set C_PMP_ADDR27 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR27]
  set_property visible false $C_PMP_ADDR27
  set C_PMP_ADDR28 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR28]
  set_property visible false $C_PMP_ADDR28
  set C_PMP_ADDR29 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR29]
  set_property visible false $C_PMP_ADDR29
  set C_PMP_ADDR30 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR30]
  set_property visible false $C_PMP_ADDR30
  set C_PMP_ADDR31 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR31]
  set_property visible false $C_PMP_ADDR31
  set C_PMP_ADDR32 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR32]
  set_property visible false $C_PMP_ADDR32
  set C_PMP_ADDR33 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR33]
  set_property visible false $C_PMP_ADDR33
  set C_PMP_ADDR34 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR34]
  set_property visible false $C_PMP_ADDR34
  set C_PMP_ADDR35 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR35]
  set_property visible false $C_PMP_ADDR35
  set C_PMP_ADDR36 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR36]
  set_property visible false $C_PMP_ADDR36
  set C_PMP_ADDR37 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR37]
  set_property visible false $C_PMP_ADDR37
  set C_PMP_ADDR38 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR38]
  set_property visible false $C_PMP_ADDR38
  set C_PMP_ADDR39 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR39]
  set_property visible false $C_PMP_ADDR39
  set C_PMP_ADDR40 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR40]
  set_property visible false $C_PMP_ADDR40
  set C_PMP_ADDR41 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR41]
  set_property visible false $C_PMP_ADDR41
  set C_PMP_ADDR42 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR42]
  set_property visible false $C_PMP_ADDR42
  set C_PMP_ADDR43 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR43]
  set_property visible false $C_PMP_ADDR43
  set C_PMP_ADDR44 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR44]
  set_property visible false $C_PMP_ADDR44
  set C_PMP_ADDR45 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR45]
  set_property visible false $C_PMP_ADDR45
  set C_PMP_ADDR46 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR46]
  set_property visible false $C_PMP_ADDR46
  set C_PMP_ADDR47 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR47]
  set_property visible false $C_PMP_ADDR47
  set C_PMP_ADDR48 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR48]
  set_property visible false $C_PMP_ADDR48
  set C_PMP_ADDR49 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR49]
  set_property visible false $C_PMP_ADDR49
  set C_PMP_ADDR50 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR50]
  set_property visible false $C_PMP_ADDR50
  set C_PMP_ADDR51 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR51]
  set_property visible false $C_PMP_ADDR51
  set C_PMP_ADDR52 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR52]
  set_property visible false $C_PMP_ADDR52
  set C_PMP_ADDR53 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR53]
  set_property visible false $C_PMP_ADDR53
  set C_PMP_ADDR54 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR54]
  set_property visible false $C_PMP_ADDR54
  set C_PMP_ADDR55 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR55]
  set_property visible false $C_PMP_ADDR55
  set C_PMP_ADDR56 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR56]
  set_property visible false $C_PMP_ADDR56
  set C_PMP_ADDR57 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR57]
  set_property visible false $C_PMP_ADDR57
  set C_PMP_ADDR58 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR58]
  set_property visible false $C_PMP_ADDR58
  set C_PMP_ADDR59 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR59]
  set_property visible false $C_PMP_ADDR59
  set C_PMP_ADDR60 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR60]
  set_property visible false $C_PMP_ADDR60
  set C_PMP_ADDR61 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR61]
  set_property visible false $C_PMP_ADDR61
  set C_PMP_ADDR62 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR62]
  set_property visible false $C_PMP_ADDR62
  set C_PMP_ADDR63 [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_ADDR63]
  set_property visible false $C_PMP_ADDR63
  set C_PMP_READ_ONLY [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_READ_ONLY]
  set_property visible false $C_PMP_READ_ONLY
  set C_PMP_DEBUG_INHIBIT [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_PMP_DEBUG_INHIBIT]
  set_property visible false $C_PMP_DEBUG_INHIBIT
  set C_USE_MMU [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_USE_MMU -widget comboBox]
  set_property tooltip {Select privilege mode.  When selecting MACHINE, only RISC-V machine-mode is available according to the Machine-Level ISA.  When selecting USER, the additional user-mode features are also enabled. When selecting SUPERVISOR, both supervisor-mode and user-mode features are enabled.} $C_USE_MMU
  set C_ADDR_SIZE [ipgui::add_param $IPINST -parent $panel_1_groupbox_1_page_1 -name C_ADDR_SIZE -widget comboBox]
  set_property tooltip {Set desired memory addressing capability.  With RV32 additional custom load/store instructions are enabled to be able to access a larger address space than 4GB (32-bit address). With RV64 the extended address is handled by normal load/store instructions.<br/><br/>The LMB and AXI bus addresses are extended to the number of address bits corresponding to the selected addressing.<br/><br/>With RV32 machine and user mode, the address can be set from 4GB to 16EB, but can only be 4GB with Physical Memory Protection enabled.<br/><br/>With RV64 machine and user mode, the address can be set from 4GB to 16EB, but is limited to 64PB with Physical Memory Protection enabled.<br/><br/>With supervisor mode, SV32 provides a 32-bit virtual and 34-bit physical address for RV32 systems, while SV39, SV48, SV57 provide 39-bit, 48-bit or 57-bit virtual and 56-bit physical address for RV64 systems.} $C_ADDR_SIZE

  set groupBox_2 [ipgui::add_group $IPINST -parent $Page1 -name "Custom Instructions"]
  set C_USE_EXTENDED_FSL_INSTR [ipgui::add_param $IPINST -parent $groupBox_2 -name C_USE_EXTENDED_FSL_INSTR -widget checkBox]
  set_property tooltip {Enable additional custom instructions.  These instructions provide additional functionality when using Advanced eXtensible Interface (AXI) stream links, including dynamic access instructions that use registers to select the interface.  The instructions are also extended with variants that provide: <ul><li> Atomic access instructions. </li><li> Test-only instructions. </li><li> Instructions that generate an exception if the control bit is not set. The stream exception must also be enabled to use these instructions. </li></ul> At least one stream link must be selected to use these instructions.} $C_USE_EXTENDED_FSL_INSTR

  set groupBox_3 [ipgui::add_group $IPINST -parent $Page1 -name "Resources"]
  set C_USE_BARREL [ipgui::add_param $IPINST -parent $groupBox_3 -name C_USE_BARREL -widget comboBox]
  set_property tooltip {Select Barrel Shifter implementation.  When this parameter is set to PERFORMANCE, the barrel shifter computes the result in one cycle. It can be set to AREA, to save resources, but then it takes longer to compute the result, depending on the shift amount.} $C_USE_BARREL
  set C_USE_COUNTERS [ipgui::add_param $IPINST -parent $groupBox_3 -name C_USE_COUNTERS -widget checkBox]
  set_property tooltip {Enable RISC-V Base Counters and Timers.  If the software does not use counters or performance monitoring, they can be disabled to save resources.} $C_USE_COUNTERS
  set C_USE_SSTC [ipgui::add_param $IPINST -parent $groupBox_3 -name C_USE_SSTC -widget checkBox]
  set_property tooltip {Enable RISC-V Supervisor Time Compare (SSTC) extension.  This extension is only available when supervisor mode is enabled.} $C_USE_SSTC
  set_property visible false $C_USE_SSTC

  set groupBox_4 [ipgui::add_group $IPINST -parent $Page1 -name Optimization]
  set C_USE_BRANCH_TARGET_CACHE [ipgui::add_param $IPINST -parent $groupBox_4 -name C_USE_BRANCH_TARGET_CACHE -widget checkBox]
  set_property tooltip {Enable Branch Target Cache.  When this parameter is set, the branch target cache is implemented, which improves branch performance by predicting conditional branches and caching branch targets.} $C_USE_BRANCH_TARGET_CACHE
  set panel_2_groupBox_4_page_1 [ipgui::add_panel $IPINST -parent $groupBox_4 -name "Optimization " -layout vertical ]
  set C_BRANCH_TARGET_CACHE_SIZE [ipgui::add_param $IPINST -parent $panel_2_groupBox_4_page_1 -name C_BRANCH_TARGET_CACHE_SIZE -widget comboBox]
  set_property tooltip {This parameter specifies the Branch Target Cache size.  The DEFAULT value, which uses two Block RAMs, gives 1024 cache entries.  This value is recommended, unless Block RAM use must be avoided or further performance increase is desired.  Values from 8 to 64 entries are implemented with Distributed RAM, and other values use Block RAM.} $C_BRANCH_TARGET_CACHE_SIZE

  set groupBox_5 [ipgui::add_group $IPINST -parent $Page1 -name "Fault Tolerance"]
  set C_FAULT_TOLERANT [ipgui::add_param $IPINST -parent $groupBox_5 -name C_FAULT_TOLERANT -widget checkBox]
  set_property tooltip {When fault tolerance support is enabled, the core protects internal Block RAM with parity, and supports Error Correcting Codes (ECC) in LMB Block RAM, including exception handling of ECC errors. This prevents a bit flip in Block RAM from affecting the processor function. <ul><li> If this value is auto computed (by not overriding it), fault tolerance is automatically enabled in the core when ECC is enabled in connected LMB BRAM controllers. </li><li> If fault tolerance is explicitly enabled here, ECC is automatically enabled in connected LMB BRAM controllers. </li><li> If fault tolerance is explicitly disabled here, ECC in connected LMB BRAM controllers is not affected. </li></ul> Note that fault tolerance is not available with write-back data cache or frequency optimization when victim caches are enabled.} $C_FAULT_TOLERANT

  # Page 2: Exceptions
  set Page2 [ ipgui::add_page $IPINST -name "Page2" -parent $AdvancedPage]
  set_property display_name "Exception" $Page2
  set groupBox_5 [ipgui::add_group $IPINST -parent $Page2 -name "Bus Exceptions"  -layout vertical]
  set C_M_AXI_I_BUS_EXCEPTION [ipgui::add_param $IPINST -parent $groupBox_5 -name C_M_AXI_I_BUS_EXCEPTION -widget checkBox]
  set_property tooltip {Enable the instruction-side Advanced eXtensible Interconnect (AXI) exception.  This causes an Instruction access fault exception if there is an error on the instruction-side AXI bus.  The user must provide their own exception handler.} $C_M_AXI_I_BUS_EXCEPTION
  set C_M_AXI_D_BUS_EXCEPTION [ipgui::add_param $IPINST -parent $groupBox_5 -name C_M_AXI_D_BUS_EXCEPTION -widget checkBox]
  set_property tooltip {Enable the data-side Advanced eXtensible Interconnect (AXI) exception.  This causes an Load access fault or Store/AMO access fault exception if there is an error on the data-side AXI bus.  The user must provide their own exception handler.} $C_M_AXI_D_BUS_EXCEPTION
  set groupBox_6 [ipgui::add_group $IPINST -parent $Page2 -name "Other Exceptions" -layout vertical]
  set C_ILL_INSTR_EXCEPTION [ipgui::add_param $IPINST -parent $groupBox_6 -name C_ILL_INSTR_EXCEPTION -widget comboBox]
  set_property tooltip {Enable the illegal instruction exception.  This causes an exception if the instruction is illegal.  BASIC only checks the opcode, to save resources. COMPLETE detects all illegal instructions.  The user must provide their own exception handler.} $C_ILL_INSTR_EXCEPTION
  set C_MISALIGNED_EXCEPTIONS [ipgui::add_param $IPINST -parent $groupBox_6 -name C_MISALIGNED_EXCEPTIONS -widget checkBox]
  set_property tooltip {Enable misaligned access exceptions.  This causes an exception if an instruction, load or store address is misaligned.  The Standalone BSP provides transparent misaligned exception handling.  Misaligned access exceptions are required by the RISC-V standard, but can be turned off to save resources if the software never performs misaligned accesses.} $C_MISALIGNED_EXCEPTIONS
  set C_FSL_EXCEPTION [ipgui::add_param $IPINST -parent $groupBox_6 -name C_FSL_EXCEPTION -widget checkBox]
  set_property tooltip {Enable stream exception handling for Advanced eXtensible Interface (AXI) read accesses. <br/><br/> Additional custom instructions must be enabled to use stream exception handling.} $C_FSL_EXCEPTION
  set C_IMPRECISE_EXCEPTIONS [ipgui::add_param $IPINST -parent $groupBox_6 -name C_IMPRECISE_EXCEPTIONS -widget comboBox]
  set_property visible false $C_IMPRECISE_EXCEPTIONS

  # Page 3: Cache
  set Page3 [ ipgui::add_page $IPINST -name "Page3" -parent $AdvancedPage]
  set_property display_name "Cache" $Page3
  set panel_1_page_2 [ipgui::add_panel $IPINST -parent $Page3 -name "panel1_P_2"  -layout horizontal]
  set panel_ic_page_2 [ipgui::add_panel $IPINST -parent $panel_1_page_2 -name "panelic_P_2"  -layout vertical]
  set panel_dc_page_2 [ipgui::add_panel $IPINST -parent $panel_1_page_2 -name "paneldc_P_2"  -layout vertical]
  set I_cache_group_wizard [ipgui::add_group $IPINST -parent $panel_ic_page_2 -name "Instruction Cache Feature" ]
  set C_ICACHE_BYTE_SIZE [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_BYTE_SIZE -widget comboBox]
  set_property tooltip {Specifies the size of the instruction cache if C_USE_ICACHE is enabled.  Not all sizes are permitted on all architectures.} $C_ICACHE_BYTE_SIZE
  set C_ICACHE_LINE_LEN [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_LINE_LEN -widget comboBox]
  set_property tooltip {Select between 4, 8 or 16 word cache line length for cache miss transfers from external instruction memory.} $C_ICACHE_LINE_LEN
  set C_ICACHE_BASEADDR [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_BASEADDR ]
  set_property tooltip {Specifies the base address of the instruction cache.   This parameter is only used if C_USE_ICACHE is enabled.} $C_ICACHE_BASEADDR
  set C_ICACHE_HIGHADDR [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_HIGHADDR ]
  set_property tooltip {Specifies the high address of the instruction cache.   This parameter is only used if C_USE_ICACHE is enabled.} $C_ICACHE_HIGHADDR
  set I_cache_group_panel [ipgui::add_panel $IPINST -parent $I_cache_group_wizard -name "I_cache_group_panel"  -layout vertical]
  set C_ICACHE_FORCE_TAG_LUTRAM [ipgui::add_param $IPINST -parent $I_cache_group_panel -name C_ICACHE_FORCE_TAG_LUTRAM -widget checkBox]
  set_property tooltip {The instruction cache tags are used to hold the address and a valid bit for each cache line. When this parameter is enabled the instruction cache tags are stored in Distributed RAM instead of Block RAM. This saves Block RAM, and usually also increases the maximum frequency.} $C_ICACHE_FORCE_TAG_LUTRAM
  set C_ICACHE_DATA_WIDTH [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_DATA_WIDTH -widget comboBox]
  set_property tooltip {Specifies the instruction cache bus width when using AXI interconnect. The width can be set to: <ul><li> 32-bit - Bursts are used to transfer cache lines, either four or eight 32-bit words depending on cache line length, </li><li> Full Cacheline - A single transfer is performed for each cache line, with data width 128 or 256 bits depending on cache line length, </li><li> 512-bit - A single transfer is performed, but only 128 or 256 bits are used depending on cache line length. </li></ul> The two wide settings require that the cache size is at least 8kB or 16kB depending on cache line length. To reduce the AXI interconnect size, this setting should match the interconnect data width. In most cases, best performance is obtained with the wide settings. <br/><br/> Note that this setting is not available with AXI Coherency Extension (ACE) and when fault tolerance is enabled.} $C_ICACHE_DATA_WIDTH
  set C_ICACHE_STREAMS [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_STREAMS -widget comboBox]
  set_property tooltip {Specifies the number of stream buffers used by the instruction cache.  A stream buffer is used to speculatively prefetch instructions, before the processor requests them.  This often improves performance, since the processor spends less time waiting for instructions to be fetched from memory. <br/><br/> Note that to be able to use instruction cache streams AXI Coherency Extension (ACE) must not be enabled.} $C_ICACHE_STREAMS
  set C_ICACHE_VICTIMS [ipgui::add_param $IPINST -parent $I_cache_group_wizard -name C_ICACHE_VICTIMS -widget comboBox]
  set_property tooltip {Specifies the number of instruction cache victims that are saved.  A victim is a cache line that is evicted from the cache.  If no victims are saved, all evicted lines must be read from memory again, when they are needed.  By saving the most recent lines, they can be fetched much faster, thus improving performance.  It is possible to save 2, 4, or 8 cache lines.  The more cache lines that are saved, the better performance becomes.  The recommended value is 8 lines. <br/><br/> Note that to be able to use instruction cache victims AXI Coherency Extension (ACE) must not be enabled.} $C_ICACHE_VICTIMS
  set D_cache_group_wizard [ipgui::add_group $IPINST -parent $panel_dc_page_2 -name "Data Cache Feature" ]
  set C_DCACHE_BYTE_SIZE [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_BYTE_SIZE -widget comboBox]
  set_property tooltip {Specifies the size of the data cache if C_USE_DCACHE is enabled.  Not all sizes are permitted on all architectures.} $C_DCACHE_BYTE_SIZE
  set C_DCACHE_LINE_LEN [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_LINE_LEN -widget comboBox]
  set_property tooltip {Select between 4, 8 or 16 word cache line length for cache miss transfers from external data memory} $C_DCACHE_LINE_LEN
  set C_DCACHE_BASEADDR [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_BASEADDR ]
  set_property tooltip { Specifies the base address of the data cache.   This parameter is only used if C_USE_DCACHE is enabled.} $C_DCACHE_BASEADDR
  set C_DCACHE_HIGHADDR [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_HIGHADDR ]
  set_property tooltip {Specifies the high address of the data cache.   This parameter is only used if C_USE_DCACHE is enabled.} $C_DCACHE_HIGHADDR
  set D_cache_group_panel_1 [ipgui::add_panel $IPINST -parent $D_cache_group_wizard -name "D_cache_group_panel1"  -layout vertical]
  set C_DCACHE_FORCE_TAG_LUTRAM [ipgui::add_param $IPINST -parent $D_cache_group_panel_1 -name C_DCACHE_FORCE_TAG_LUTRAM -widget checkBox]
  set_property tooltip {The data cache tags are used to hold the address and valid bits for each cache line. When write-back storage policy is used, each tag also contains a dirty bit. When this parameter is enabled the data cache tags are stored in Distributed RAM instead of Block RAM. This saves Block RAM, and usually also increases the maximum frequency.} $C_DCACHE_FORCE_TAG_LUTRAM
  set C_DCACHE_DATA_WIDTH [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_DATA_WIDTH -widget comboBox]
  set_property tooltip {Specifies the data cache bus width when using AXI interconnect. The width can be set to: <ul><li> 32-bit - Bursts are used to transfer cache lines, either four or eight 32-bit words depending on cache line length, </li><li> Full Cacheline - A single transfer is performed for each cache line, with data width 128 or 256 bits depending on cache line length, </li><li> 512-bit - A single transfer is performed, but only 128 or 256 bits are used depending on cache line length. </li></ul> The two wide settings require that the cache size is at least 8kB or 16kB depending on cache line length. To reduce the AXI interconnect size, this setting should match the interconnect data width. In most cases, best performance is obtained with the wide settings. <br/><br/> Note that this setting is not available with write-through cache and when fault tolerance is enabled.} $C_DCACHE_DATA_WIDTH
  set D_cache_group_panel_2 [ipgui::add_panel $IPINST -parent $D_cache_group_wizard -name "D_cache_group_panel2"  -layout vertical]
  set C_DCACHE_USE_WRITEBACK [ipgui::add_param $IPINST -parent $D_cache_group_panel_2 -name C_DCACHE_USE_WRITEBACK -widget checkBox]
  set_property tooltip {This parameter enables use of a write-back data storage policy. When this policy is in effect, the data cache only writes data to memory when necessary, which in most cases improves performance. Otherwise a write-through policy is used, which always writes data to memory immediately. With write-back enabled, data is stored by writing an entire cache line. Using write-back also requires that the cache is flushed by software when appropriate, to ensure that data is available in memory, for example when using Direct Memory Access. When the MMU is enabled, setting this parameter allows individual selection of storage policy for each TLB entry. <br/><br/> Note that write-back is not available when fault tolerance or AXI Coherency Extension (ACE) is enabled.} $C_DCACHE_USE_WRITEBACK
  set C_DCACHE_VICTIMS [ipgui::add_param $IPINST -parent $D_cache_group_wizard -name C_DCACHE_VICTIMS -widget comboBox]
  set_property tooltip {Specifies the number of data cache victims that are saved.  A victim is a cache line that is evicted from the cache.  If no victims are saved, all evicted lines must be read from memory again, when they are needed. By saving the most recent lines, they can be fetched much faster, thus improving performance.  It is possible to save 2, 4, or 8 cache lines.  The more cache lines that are saved, the better performance becomes.  The recommended value is 8 lines. <br/><br/> Note that to be able to use data cache victims, write-back storage policy must be enabled, and AXI Coherency Extension (ACE) must not be enabled.} $C_DCACHE_VICTIMS

  # Page 4: Debug
  set Page4 [ ipgui::add_page $IPINST -name "Page4" -parent $AdvancedPage]
  set_property display_name "Debug" $Page4
  set C_DEBUG_ENABLED [ipgui::add_param $IPINST -parent $Page4 -name C_DEBUG_ENABLED -widget checkBox]
  set_property tooltip {Enable the Debug Module interface to the core for debugging.  With this option the user can debug the processor over the Joint Test Action Group (JTAG) boundary-scan interface.  This option can be disabled after debugging is finished to reduce the size of the core.} $C_DEBUG_ENABLED

  set groupBox_8 [ipgui::add_group $IPINST -parent $Page4 -name "Hardware Breakpoints" ]
  set C_NUMBER_OF_PC_BRK [ipgui::add_param $IPINST -parent $groupBox_8 -name C_NUMBER_OF_PC_BRK ]
  set_property tooltip {Specifies the number of program counter (PC) hardware breakpoints for debugging.  This parameter controls the number of hardware breakpoints the debugger can set.  This option only has meaning if C_DEBUG_ENABLED is turned on.  The core will take a noticeable frequency hit the larger this parameter is set.} $C_NUMBER_OF_PC_BRK
  set C_NUMBER_OF_WR_ADDR_BRK [ipgui::add_param $IPINST -parent $groupBox_8 -name C_NUMBER_OF_WR_ADDR_BRK ]
  set_property tooltip {Specifies the number of write address breakpoints for debugging.  This parameter controls the number of write watchpoints the debugger can set.  This option only has meaning if C_DEBUG_ENABLED is turned on.  The core will take a noticeable frequency hit the larger this parameter is set.  It is recommended that this be set to 0 if one will not be using watch points for debugging.} $C_NUMBER_OF_WR_ADDR_BRK
  set C_NUMBER_OF_RD_ADDR_BRK [ipgui::add_param $IPINST -parent $groupBox_8 -name C_NUMBER_OF_RD_ADDR_BRK ]
  set_property tooltip {Specifies the number of read address breakpoints for debugging.  This parameter controls the number of read watchpoints the debugger can set.  This option only has meaning if C_DEBUG_ENABLED is turned on.  The core will take a noticeable frequency hit the larger this parameter is set.  It is recommended that this be set to 0 if one will not be using watch points for debugging. } $C_NUMBER_OF_RD_ADDR_BRK
  set groupBox_8b [ipgui::add_group $IPINST -parent $Page4 -name "Performance Monitoring" ]
  set C_DEBUG_EVENT_COUNTERS [ipgui::add_param $IPINST -parent $groupBox_8b -name C_DEBUG_EVENT_COUNTERS ]
  set_property tooltip {Specifies the number of event counters for performance monitoring.  Event counters are only available when Base Counters and Timers and Debug are enabled.} $C_DEBUG_EVENT_COUNTERS
  set C_DEBUG_LATENCY_COUNTERS [ipgui::add_param $IPINST -parent $groupBox_8b -name C_DEBUG_LATENCY_COUNTERS ]
  set_property tooltip {Specifies the number of latency counters for performance monitoring.  Each latency counter uses two hardware performance monitor CSRs.  Latency counters are only available when Base Counters and Timers and Debug are enabled.} $C_DEBUG_LATENCY_COUNTERS
  set C_DEBUG_COUNTER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_8b -name C_DEBUG_COUNTER_WIDTH -widget comboBox]
  set_property tooltip {Specifies the counter size (32, 48 or 64 bits) for performance monitoring.} $C_DEBUG_COUNTER_WIDTH
  set_property visible false $C_DEBUG_COUNTER_WIDTH
  set groupBox_8c [ipgui::add_group $IPINST -parent $Page4 -name "Trace & Profiling" ]
  set C_DEBUG_EXTERNAL_TRACE [ipgui::add_param $IPINST -parent $groupBox_8c -name C_DEBUG_EXTERNAL_TRACE -widget checkBox]
  set_property tooltip {Specifies that external trace output via the MDM should be used instead of the embedded trace buffer.} $C_DEBUG_EXTERNAL_TRACE
  set C_DEBUG_TRACE_SIZE [ipgui::add_param $IPINST -parent $groupBox_8c -name C_DEBUG_TRACE_SIZE -widget comboBox]
  set_property tooltip {Specifies the size of the trace buffer: NONE, 4KB - 128KB for embedded Program Trace.} $C_DEBUG_TRACE_SIZE
  set C_DEBUG_PROFILE_SIZE [ipgui::add_param $IPINST -parent $groupBox_8c -name C_DEBUG_PROFILE_SIZE -widget comboBox]
  set_property tooltip {Specifies the size of the profiler buffer (NONE, 4KB - 128KB) for Non-intrusive Profiling.} $C_DEBUG_PROFILE_SIZE
  set groupBox_8d [ipgui::add_group $IPINST -parent $Page4 -name "Interface" ]
  set C_DEBUG_INTERFACE [ipgui::add_param $IPINST -parent $groupBox_8d -name C_DEBUG_INTERFACE -widget comboBox]
  set_property tooltip {Select type of interface for connecting the MicroBlaze Debug Module (MDM V): <ul><li>SERIAL is the default JTAG interface, which is generally recommended and uses the least amount of resources.</li><li>PARALLEL provides synchronous parallel access to MicroBlaze V debug registers, with better performance and timing.</li><li>AXI is a subset of PARALLEL, providing an AXI4-Lite interface that can be connected via AXI register slices or AXI clock converters to further improve timing.</li></ul>} $C_DEBUG_INTERFACE
  set C_DEBUG_NUM_PROGBUF [ipgui::add_param $IPINST -parent $groupBox_8d -name C_DEBUG_NUM_PROGBUF -widget comboBox]
  set_property tooltip {Select number of implemented debug program buffer registers. The default value is PERFORMANCE (2 registers), which gives fast debug download and memory access.  For reduced resource usage at the expense of speed, select AREA (1 register).} $C_DEBUG_NUM_PROGBUF
  set_property visible false $C_DEBUG_NUM_PROGBUF

  # Page 5: Interrupt and Reset
  set Page5 [ ipgui::add_page $IPINST -name "Page5" -parent $AdvancedPage]
  set_property display_name "Interrupt & Reset" $Page5
  set groupBox_9 [ipgui::add_group $IPINST -parent $Page5 -name "Interrupt" ]
  set C_INTERRUPT_IS_EDGE [ipgui::add_param $IPINST -parent $groupBox_9 -name C_INTERRUPT_IS_EDGE -widget checkBox]
  set_property tooltip {Specifies whether the core senses interrupts on edge or level.  If this parameter is enabled, then the core only detects an interrupt on the edge specified by C_EDGE_IS_POSITIVE.  If this parameter is disabled, whenever the interrupt is high an interrupt will be triggered: if an interrupt is generated and handled while the interrupt input remains high an interrupt will again be generated.} $C_INTERRUPT_IS_EDGE
  set C_EDGE_IS_POSITIVE [ipgui::add_param $IPINST -parent $groupBox_9 -name C_EDGE_IS_POSITIVE -widget checkBox]
  set_property tooltip {Specifies whether the core detects interrupts on rising or falling edges if C_INTERRUPT_IS_EDGE is set to 1.} $C_EDGE_IS_POSITIVE
  set panel_1_groupbox_9_page_4 [ipgui::add_panel $IPINST -name panel_1_groupbox_9_page_4 -parent $groupBox_9]
  set C_USE_INTERRUPT [ipgui::add_param $IPINST -parent $panel_1_groupbox_9_page_4 -name C_USE_INTERRUPT -widget comboBox]
  set_property tooltip {Specifies whether the core interrupt input is enabled. Selecting NORMAL enables interrupts. Selecting FAST also enables low-latency interrupt handling.} $C_USE_INTERRUPT
  set C_INTERRUPT_MON [ipgui::add_param $IPINST -parent $panel_1_groupbox_9_page_4 -name C_INTERRUPT_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for the interrupt interface.  This can be used to simplify connection of interrupt for a lockstep slave processor when a common interrupt source is used.} $C_INTERRUPT_MON
  set C_TRAP_ENHANCEMENT [ipgui::add_param $IPINST -parent $groupBox_9 -name C_TRAP_ENHANCEMENT]
  set_property visible false $C_TRAP_ENHANCEMENT
  set C_USE_EXT_BRK [ipgui::add_param $IPINST -parent $groupBox_9 -name C_USE_EXT_BRK]
  set_property visible false $C_USE_EXT_BRK
  set C_USE_EXT_NM_BRK [ipgui::add_param $IPINST -parent $groupBox_9 -name C_USE_EXT_NM_BRK]
  set_property visible false $C_USE_EXT_NM_BRK
  set C_USE_SLEEP [ipgui::add_param $IPINST -parent $groupBox_9 -name C_USE_SLEEP]
  set_property visible false $C_USE_SLEEP
  set C_USE_NON_SECURE [ipgui::add_param $IPINST -parent $groupBox_9 -name C_USE_NON_SECURE]
  set_property visible false $C_USE_NON_SECURE
  set groupBox_10b [ipgui::add_group $IPINST -parent $Page5 -name "Identification" ]
  set C_ARCHID [ipgui::add_param $IPINST -parent $groupBox_10b -name C_ARCHID]
  set_property tooltip {Change the RISC-V architecture id. The id uniquely identifies the core architecture. The default value is 0x1.} $C_ARCHID
  set C_IMPID [ipgui::add_param $IPINST -parent $groupBox_10b -name C_IMPID]
  set_property tooltip {Change the RISC-V implementation id. The id uniquely identifies the core implementation. The default value is 0x1.} $C_IMPID
  set C_HARTID [ipgui::add_param $IPINST -parent $groupBox_10b -name C_HARTID]
  set_property tooltip {Change the RISC-V hardware thread id. The id uniquely identifies the core in a multiprocessor system.} $C_HARTID
  set groupBox_10c [ipgui::add_group $IPINST -parent $Page5 -name "Vectors" ]
  set C_BASE_VECTORS [ipgui::add_param $IPINST -parent $groupBox_10c -name C_BASE_VECTORS]
  set_property tooltip {Change the base address used for RISC-V vectors. This affects the vectors for reset and traps. Normally the base address is 0x80000000 in Local Memory, but if this address is used for other purposes, this parameter allows the vector to be moved to another address. The 7 least significant bits in the address must be zero.<br/><br/> The address is automatically set to the Local Memory base address, or to the lowest memory base address if Local Memory is not used, but can be changed manually if necessary.} $C_BASE_VECTORS

  # Page 6: Buses: LMB, AXI, TRACE
  set Page6 [ ipgui::add_page $IPINST -name "Page6" -parent $AdvancedPage]
  set_property display_name "Buses" $Page6
  set groupBox_12 [ipgui::add_group $IPINST -parent $Page6 -name "Local Memory Bus Interfaces" -layout horizontal]

  set panel_1_groupbox_12_page_5 [ipgui::add_panel $IPINST -name panel_1_groupbox_12_page_5 -parent $groupBox_12]
  set C_I_LMB [ipgui::add_param $IPINST -parent $panel_1_groupbox_12_page_5 -name C_I_LMB -widget checkBox]
  set_property tooltip {Enable LMB instruction interface.  If this parameter is set, the Local Memory Bus (LMB) instruction interface is available.  This interface is almost always used in a typical system, to provide fast local memory for instructions. Normally it is connected to an LMB bus using an LMB Bus Interface Controller to access a common Block RAM.} $C_I_LMB
  set C_I_LMB_PROTOCOL [ipgui::add_param $IPINST -parent $panel_1_groupbox_12_page_5 -name C_I_LMB_PROTOCOL -widget comboBox]
  set_property tooltip {LMB instruction interface protocol. Is normally set to STANDARD, but can be set to FREQUENCY to improve timing.} $C_I_LMB_PROTOCOL
  set_property visible false $C_I_LMB_PROTOCOL
  set C_I_LMB_HAS_PROT [ipgui::add_param $IPINST -parent $panel_1_groupbox_12_page_5 -name C_I_LMB_HAS_PROT -widget checkBox]
  set_property tooltip {Enable LMB instruction interface protection signal} $C_I_LMB_HAS_PROT
  set_property visible false $C_I_LMB_HAS_PROT
  set panel_2_groupbox_12_page_5 [ipgui::add_panel $IPINST -name panel_2_groupbox_12_page_5 -parent $panel_1_groupbox_12_page_5 -layout horizontal]
  set C_D_LMB [ipgui::add_param $IPINST -parent $panel_2_groupbox_12_page_5 -name C_D_LMB -widget checkBox]
  set_property tooltip {Enable LMB data interface.  If this parameter is set, the Local Memory Bus (LMB) data interface is available.  This interface is almost always used in a typical system, to provide fast local memory for data and vectors. Normally it is connected to an LMB bus using an LMB Bus Interface Controller to access a common Block RAM.} $C_D_LMB
  set C_LMB_DATA_SIZE [ipgui::add_param $IPINST -parent $panel_2_groupbox_12_page_5 -name C_LMB_DATA_SIZE -widget comboBox]
  set_property tooltip {LMB data interface data width. Is normally set to 32, but can also be set to 64 when RV64 is used to improve performance.} $C_LMB_DATA_SIZE
  set C_D_LMB_PROTOCOL [ipgui::add_param $IPINST -parent $panel_2_groupbox_12_page_5 -name C_D_LMB_PROTOCOL -widget comboBox]
  set_property tooltip {LMB data interface protocol. Is normally set to STANDARD, but can be set to FREQUENCY to improve timing.} $C_D_LMB_PROTOCOL
  set_property visible false $C_D_LMB_PROTOCOL
  set C_D_LMB_HAS_PROT [ipgui::add_param $IPINST -parent $panel_2_groupbox_12_page_5 -name C_D_LMB_HAS_PROT -widget checkBox]
  set_property tooltip {Enable LMB data interface protection signal} $C_D_LMB_HAS_PROT
  set_property visible false $C_D_LMB_HAS_PROT

  set panel_3_groupbox_12_page_5 [ipgui::add_panel $IPINST -name panel_3_groupbox_12_page_5 -parent $groupBox_12]
  set C_I_LMB_MON [ipgui::add_param $IPINST -parent $panel_3_groupbox_12_page_5 -name C_I_LMB_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for LMB instruction interface.  This can be used to simplify connection of LMB for a lockstep slave processor when private LMB memory is not used.} $C_I_LMB_MON
  set C_D_LMB_MON [ipgui::add_param $IPINST -parent $panel_3_groupbox_12_page_5 -name C_D_LMB_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for LMB data interface.  This can be used to simplify connection of LMB for a lockstep slave processor when private LMB memory is not used.} $C_D_LMB_MON

  if [ea] {
    set groupBox_13 [ipgui::add_group $IPINST -parent $Page6 -name "AXI and ACE Interfaces" ]
  } else {
    set groupBox_13 [ipgui::add_group $IPINST -parent $Page6 -name "AXI Interfaces" ]
  }
  set C_INTERCONNECT [ipgui::add_param $IPINST -parent $groupBox_13 -name C_INTERCONNECT -widget comboBox]
  set_property tooltip {Select bus interfaces.  If this parameter is set to AXI, the Advanced eXtensible Interface (AXI) is selected for both peripheral and cache access.  If this parameter is set to ACE, AXI is selected for peripheral access and AXI Coherency Extension (ACE) is selected for cache access, providing cache coherency support. <br/><br/> Note that to be able to select ACE, frequency optimization, write-back data cache, instruction cache streams or victims, and cache data widths other than 32-bit must not be set. Use Cache for All Memory Accesses must also be set for both caches.} $C_INTERCONNECT
  set_property visible [ea] $C_INTERCONNECT

  set panel_1_groupbox_13_page_5 [ipgui::add_panel $IPINST -name panel_1_groupbox_13_page_5 -parent $groupBox_13 -layout horizontal]

  set panel_2_groupbox_13_page_5 [ipgui::add_panel $IPINST -name panel_1_groupbox_13_page_5 -parent $panel_1_groupbox_13_page_5]
  set C_I_AXI [ipgui::add_param $IPINST -parent $panel_2_groupbox_13_page_5 -name C_I_AXI -widget checkBox]
  set_property tooltip {Enable AXI peripheral instruction interface.  If this parameter is set, the peripheral AXI4-Lite instruction interface is available.  In many cases, this interface is not needed, in particular if the Instruction Cache is enabled.} $C_I_AXI
  set panel_3_groupbox_13_page_5 [ipgui::add_panel $IPINST -name panel_3_groupbox_13_page_5 -parent $panel_2_groupbox_13_page_5 -layout horizontal]
  set C_D_AXI [ipgui::add_param $IPINST -parent $panel_3_groupbox_13_page_5 -name C_D_AXI -widget checkBox]
  set_property tooltip {Enable AXI peripheral data interface.  If this parameter is set, the peripheral AXI data interface is available.  This interface is usually connected to peripheral I/O using AXI4-Lite, but can also be connected to memory.  If exclusive access is enabled, the full AXI4 protocol is used.} $C_D_AXI
  set C_M_AXI_DP_DATA_WIDTH [ipgui::add_param $IPINST -parent $panel_3_groupbox_13_page_5 -name C_M_AXI_DP_DATA_WIDTH -widget comboBox]
  set_property tooltip {AXI peripheral data interface data width.  Is normally set to 32, but can also be set to 64 when RV64 is enabled.  Using 32 is normally recommended, except when connected slaves have 64-bit data width.} $C_M_AXI_DP_DATA_WIDTH
  set panel_4_groupbox_13_page_5 [ipgui::add_panel $IPINST -name panel_2_groupbox_13_page_5 -parent $panel_1_groupbox_13_page_5]
  set C_IP_AXI_MON [ipgui::add_param $IPINST -parent $panel_4_groupbox_13_page_5 -name C_IP_AXI_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for AXI peripheral instruction interface.  This can be used to simplify connection of AXI for a lockstep slave processor.} $C_IP_AXI_MON
  set C_DP_AXI_MON [ipgui::add_param $IPINST -parent $panel_4_groupbox_13_page_5 -name C_DP_AXI_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for AXI peripheral data interface.  This can be used to simplify connection of AXI for a lockstep slave processor.} $C_DP_AXI_MON
  set C_IC_AXI_MON [ipgui::add_param $IPINST -parent $panel_4_groupbox_13_page_5 -name C_IC_AXI_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for AXI cache instruction interface.  This can be used to simplify connection of AXI for a lockstep slave processor.} $C_IC_AXI_MON
  set C_DC_AXI_MON [ipgui::add_param $IPINST -parent $panel_4_groupbox_13_page_5 -name C_DC_AXI_MON -widget checkBox]
  set_property tooltip {Select Monitor Interface for AXI cache data interface.  This can be used to simplify connection of AXI for a lockstep slave processor.} $C_DC_AXI_MON
  update_gui_for_PARAM_VALUE.C_DATA_SIZE $IPINST $C_USE_MMU $C_ADDR_SIZE $C_DATA_SIZE $C_LMB_DATA_SIZE $C_M_AXI_DP_DATA_WIDTH

  set panel_5_groupbox_13_page_5 [ipgui::add_panel $IPINST -name panel_5_groupbox_13_page_5 -parent $groupBox_13]
  set C_S_AXI [ipgui::add_param $IPINST -parent $panel_5_groupbox_13_page_5 -name C_S_AXI -widget checkBox]
  set_property tooltip {Enable AXI slave interface.  If this parameter is set, the AXI slave interface is available.  This interface can be used to access Debug Trace and Debug Profiling registers, instead of using the default MDM System Bus.} $C_S_AXI

  set groupBox_14 [ipgui::add_group $IPINST -parent $Page6 -name "Stream Interfaces" ]
  set C_FSL_LINKS [ipgui::add_param $IPINST -parent $groupBox_14 -name C_FSL_LINKS ]
  set_property tooltip {Specifies the number of MicroBlaze Advanced eXtensible Interface (AXI) stream link interface pairs.  Each pair contains a master and a slave interface.  The interface provides a uni-directional point-to-point communication channel between MicroBlaze and a hardware accelerator or coprocessor using custom instructions.  This is a low-latency interface that provides a generic custom instruction interface.  When selecting one or more links, basic custom instructions are available and additional custom instructions can be enabled.} $C_FSL_LINKS

  set groupBox_15 [ipgui::add_group $IPINST -parent $Page6 -name "Other Interfaces" ]
  set C_TRACE [ipgui::add_param $IPINST -parent $groupBox_15 -name C_TRACE -widget checkBox]
  set_property tooltip {Enable the Trace bus interface.  If this parameter is set, the Trace bus interface is available. This interface is useful for debugging, execution statistics and performance analysis. In particular, connecting this interface to a ChipScope Integrated Logic Analyzer (ILA) allows tracing program execution with clock cycle accuracy.} $C_TRACE
  set panel_1_groupbox_15_page_5 [ipgui::add_panel $IPINST -parent $groupBox_15 -name "Lockstep" -layout vertical ]
  set C_LOCKSTEP_SELECT [ipgui::add_param $IPINST -parent $panel_1_groupbox_15_page_5 -name C_LOCKSTEP_SELECT -widget comboBox]
  set_property tooltip {When lockstep support is enabled, two cores run the same program in lockstep, and their outputs can be compared to detect errors. <ul><li> When NONE is selected, no lockstep interfaces are enabled. </li><li> When LOCKSTEP_MASTER is selected, the Lockstep_Master_Out and Lockstep_Out output ports are enabled. </li><li> When LOCKSTEP_SLAVE is selected, the Lockstep_Slave_In input port and Lockstep_Out output port are enabled, and the C_LOCKSTEP_SLAVE parameter is set to 1. The slave processor is visible as a CPU, and can have private LMB memory.</li><li> LOCKSTEP_HIDDEN_SLAVE behaves the same way as LOCKSTEP_SLAVE, except that the slave processor is not visible as a CPU. This setting is recommended, except when using private LMB memory.</li></ul> } $C_LOCKSTEP_SELECT
  set C_TEMPORAL_DEPTH [ipgui::add_param $IPINST -parent $panel_1_groupbox_15_page_5 -name C_TEMPORAL_DEPTH -widget comboBox]
  set_property tooltip {Define the temporal delay in clock cycles for the lockstep slave debug interface.} $C_TEMPORAL_DEPTH
  update_gui_for_PARAM_VALUE.C_LOCKSTEP_SELECT $IPINST $C_LOCKSTEP_SELECT \
                                               $C_I_LMB_MON $C_D_LMB_MON $C_IP_AXI_MON $C_DP_AXI_MON $C_IC_AXI_MON $C_DC_AXI_MON \
                                               $C_INTERRUPT_MON \
                                               $C_TEMPORAL_DEPTH $C_DEBUG_ENABLED

  # Hidden parameters - added to avoid warnings
  set C_FREQ [ipgui::add_param $IPINST -parent $groupBox_15 -name C_FREQ]
  set_property visible false $C_FREQ
  set C_ECC_USE_CE_EXCEPTION [ipgui::add_param $IPINST -parent $groupBox_15 -name C_ECC_USE_CE_EXCEPTION]
  set_property visible false $C_ECC_USE_CE_EXCEPTION
  set C_LOCKSTEP_SLAVE [ipgui::add_param $IPINST -parent $groupBox_15 -name C_LOCKSTEP_SLAVE]
  set_property visible false $C_LOCKSTEP_SLAVE
  set C_AVOID_PRIMITIVES [ipgui::add_param $IPINST -parent $groupBox_15 -name C_AVOID_PRIMITIVES]
  set_property visible false $C_AVOID_PRIMITIVES
  set C_USE_CONFIG_RESET [ipgui::add_param $IPINST -parent $groupBox_15 -name C_USE_CONFIG_RESET]
  set_property visible false $C_USE_CONFIG_RESET
  set C_NUM_SYNC_FF_CLK [ipgui::add_param $IPINST -parent $groupBox_15 -name C_NUM_SYNC_FF_CLK]
  set_property visible false $C_NUM_SYNC_FF_CLK
  set C_NUM_SYNC_FF_CLK_IRQ [ipgui::add_param $IPINST -parent $groupBox_15 -name C_NUM_SYNC_FF_CLK_IRQ]
  set_property visible false $C_NUM_SYNC_FF_CLK_IRQ
  set C_NUM_SYNC_FF_CLK_DEBUG [ipgui::add_param $IPINST -parent $groupBox_15 -name C_NUM_SYNC_FF_CLK_DEBUG]
  set_property visible false $C_NUM_SYNC_FF_CLK_DEBUG
  set C_NUM_SYNC_FF_DBG_CLK [ipgui::add_param $IPINST -parent $groupBox_15 -name C_NUM_SYNC_FF_DBG_CLK]
  set_property visible false $C_NUM_SYNC_FF_DBG_CLK
  set C_NUM_SYNC_FF_DBG_TRACE_CLK [ipgui::add_param $IPINST -parent $groupBox_15 -name C_NUM_SYNC_FF_DBG_TRACE_CLK]
  set_property visible false $C_NUM_SYNC_FF_DBG_TRACE_CLK
  set C_DEBUG_TRACE_ASYNC_RESET [ipgui::add_param $IPINST -parent $groupBox_15 -name C_DEBUG_TRACE_ASYNC_RESET]
  set_property visible false $C_DEBUG_TRACE_ASYNC_RESET
  set C_M_AXI_DP_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DP_THREAD_ID_WIDTH]
  set_property visible false $C_M_AXI_DP_THREAD_ID_WIDTH
  set C_M_AXI_DP_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DP_ADDR_WIDTH]
  set_property visible false $C_M_AXI_DP_ADDR_WIDTH
  set C_M_AXI_DP_EXCLUSIVE_ACCESS [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DP_EXCLUSIVE_ACCESS]
  set_property visible false $C_M_AXI_DP_EXCLUSIVE_ACCESS
  set C_USE_AXI_DP_EXT_ADDR [ipgui::add_param $IPINST -parent $groupBox_15 -name C_USE_AXI_DP_EXT_ADDR]
  set_property visible false $C_USE_AXI_DP_EXT_ADDR
  set C_M_AXI_IP_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IP_THREAD_ID_WIDTH]
  set_property visible false $C_M_AXI_IP_THREAD_ID_WIDTH
  set C_M_AXI_IP_DATA_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IP_DATA_WIDTH]
  set_property visible false $C_M_AXI_IP_DATA_WIDTH
  set C_M_AXI_IP_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IP_ADDR_WIDTH]
  set_property visible false $C_M_AXI_IP_ADDR_WIDTH
  set C_PC_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_PC_WIDTH]
  set_property visible false $C_PC_WIDTH
  set C_ASYNC_INTERRUPT [ipgui::add_param $IPINST -parent $groupBox_15 -name C_ASYNC_INTERRUPT]
  set_property visible false $C_ASYNC_INTERRUPT
  set C_ASYNC_WAKEUP [ipgui::add_param $IPINST -parent $groupBox_15 -name C_ASYNC_WAKEUP]
  set_property visible false $C_ASYNC_WAKEUP
  set C_M_AXI_IC_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_THREAD_ID_WIDTH]
  set_property visible false $C_M_AXI_IC_THREAD_ID_WIDTH
  set C_M_AXI_IC_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_ADDR_WIDTH]
  set_property visible false $C_M_AXI_IC_ADDR_WIDTH
  set C_M_AXI_IC_USER_VALUE [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_USER_VALUE]
  set_property visible false $C_M_AXI_IC_USER_VALUE
  set C_M_AXI_IC_AWUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_AWUSER_WIDTH]
  set_property visible false $C_M_AXI_IC_AWUSER_WIDTH
  set C_M_AXI_IC_ARUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_ARUSER_WIDTH]
  set_property visible false $C_M_AXI_IC_ARUSER_WIDTH
  set C_M_AXI_IC_WUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_WUSER_WIDTH]
  set_property visible false $C_M_AXI_IC_WUSER_WIDTH
  set C_M_AXI_IC_RUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_RUSER_WIDTH]
  set_property visible false $C_M_AXI_IC_RUSER_WIDTH
  set C_M_AXI_IC_BUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_BUSER_WIDTH]
  set_property visible false $C_M_AXI_IC_BUSER_WIDTH
  set C_M_AXI_IC_USER_SIGNALS [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_IC_USER_SIGNALS]
  set_property visible false $C_M_AXI_IC_USER_SIGNALS
  set C_M_AXI_DC_THREAD_ID_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_THREAD_ID_WIDTH]
  set_property visible false $C_M_AXI_DC_THREAD_ID_WIDTH
  set C_M_AXI_DC_ADDR_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_ADDR_WIDTH]
  set_property visible false $C_M_AXI_DC_ADDR_WIDTH
  set C_M_AXI_DC_EXCLUSIVE_ACCESS [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_EXCLUSIVE_ACCESS]
  set_property visible false $C_M_AXI_DC_EXCLUSIVE_ACCESS
  set C_M_AXI_DC_USER_VALUE [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_USER_VALUE]
  set_property visible false $C_M_AXI_DC_USER_VALUE
  set C_M_AXI_DC_AWUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_AWUSER_WIDTH]
  set_property visible false $C_M_AXI_DC_AWUSER_WIDTH
  set C_M_AXI_DC_ARUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_ARUSER_WIDTH]
  set_property visible false $C_M_AXI_DC_ARUSER_WIDTH
  set C_M_AXI_DC_WUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_WUSER_WIDTH]
  set_property visible false $C_M_AXI_DC_WUSER_WIDTH
  set C_M_AXI_DC_RUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_RUSER_WIDTH]
  set_property visible false $C_M_AXI_DC_RUSER_WIDTH
  set C_M_AXI_DC_BUSER_WIDTH [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_BUSER_WIDTH]
  set_property visible false $C_M_AXI_DC_BUSER_WIDTH
  set C_M_AXI_DC_USER_SIGNALS [ipgui::add_param $IPINST -parent $groupBox_15 -name C_M_AXI_DC_USER_SIGNALS]
  set_property visible false $C_M_AXI_DC_USER_SIGNALS
  set C_MMU_PRIVILEGED_INSTR [ipgui::add_param $IPINST -parent $groupBox_15 -name C_MMU_PRIVILEGED_INSTR]
  set_property visible false $C_MMU_PRIVILEGED_INSTR

  # Resource estimates
  set Resource_Estimates_tab [ipgui::add_page  $IPINST  -left -name "Resource Estimates"]
  set_property default_page "Resource Estimates" [ipgui::get_canvasspec -of $IPINST]

  set Resource_Estimates [ipgui::add_panel $IPINST -parent $Resource_Estimates_tab -name "Resource Graph" -layout horizontal]
  set_property tooltip {<html>Here the resource estimates for frequency, <br/>area and performance are shown.</html>} $Resource_Estimates
  set Resource_Graph [ipgui::add_graph $IPINST  -name Resource_Graph -display_name "Resource Estimates" -type "BAR" -parent $Resource_Estimates]

  ipgui::add_xaxis -parent $Resource_Graph -value "0,4" -name " "
  ipgui::add_yaxis -parent $Resource_Graph -value "0,100" -name "Percent (%)" -step 10
  set_property width 30 $Resource_Graph

  set BRAM_DSP48_Usage [ipgui::add_group $IPINST -parent $Resource_Estimates_tab -name "Resource Usage" -layout horizontal]
  set_property tooltip {<html>These values are the total number of Block RAMs and DSP48 used by the core. <br/><br/>Block RAMs are used by the instruction and data caches, and the Branch Target <br/>Cache. <br/><br/>DSP48 are used by the Integer Multiplier, and by the Floating Point Unit <br/>to implement float multiplication.</html>} $BRAM_DSP48_Usage
  set BRAM_Text [ipgui::add_dynamic_text $IPINST -name LUTs -parent $BRAM_DSP48_Usage -tclproc gui_set_bram_size]
  set_property tooltip {This value is the total number of Block RAMs used by the core. <br/>Block RAMs are used by the instruction and data caches, and the Branch Target Cache.} $BRAM_Text
  set DSP48_Text [ipgui::add_dynamic_text $IPINST -name DSPs -parent $BRAM_DSP48_Usage -tclproc gui_set_dsp48_size]
  set_property tooltip {This value is the total number of DSP48 used by the core. <br/>They are used by the Integer Multiplier, and by the Floating Point Unit to implement float multiplication.} $DSP48_Text

  foreach param {C_USE_MMU C_OPTIMIZATION C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN C_USE_ICACHE C_USE_ATOMIC       \
                 C_USE_MULDIV C_USE_FPU C_USE_COMPRESSION C_FAULT_TOLERANT C_USE_BRANCH_TARGET_CACHE           \
                 C_FSL_LINKS C_USE_EXTENDED_FSL_INSTR C_FSL_EXCEPTION C_IMPRECISE_EXCEPTIONS C_DATA_SIZE       \
                 C_ICACHE_VICTIMS C_ICACHE_STREAMS C_ICACHE_DATA_WIDTH C_DCACHE_USE_WRITEBACK                  \
                 C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_USE_DCACHE C_USE_BARREL C_USE_COUNTERS C_DEBUG_ENABLED \
                 C_LOCKSTEP_SELECT C_INTERCONNECT C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK                   \
                 C_NUMBER_OF_WR_ADDR_BRK C_DEBUG_EVENT_COUNTERS C_DEBUG_LATENCY_COUNTERS                       \
                 C_DEBUG_COUNTER_WIDTH C_DEBUG_TRACE_SIZE C_DEBUG_EXTERNAL_TRACE C_DEBUG_PROFILE_SIZE          \
                 C_ARCHID C_IMPID C_HARTID C_BASE_VECTORS C_ICACHE_BASEADDR C_ICACHE_HIGHADDR                  \
                 C_ICACHE_FORCE_TAG_LUTRAM C_DCACHE_BASEADDR C_DCACHE_HIGHADDR C_DCACHE_VICTIMS                \
                 C_DCACHE_FORCE_TAG_LUTRAM C_DCACHE_DATA_WIDTH C_BRANCH_TARGET_CACHE_SIZE                      \
                 C_M_AXI_I_BUS_EXCEPTION C_M_AXI_D_BUS_EXCEPTION C_ILL_INSTR_EXCEPTION C_MISALIGNED_EXCEPTIONS \
                 C_PMP_ENTRIES C_PMP_GRANULARITY C_PMP_ENHANCEMENTS C_USE_EXT_BRK C_USE_EXT_NM_BRK C_USE_SLEEP \
		 C_USE_NON_SECURE C_USE_INTERRUPT C_USE_BITMAN_A C_USE_BITMAN_B C_USE_BITMAN_C C_USE_BITMAN_S  \
                 C_TRAP_ENHANCEMENT} {
    set hw_parameter_array($param) [get_property value [set $param]]
  }
}

proc init_params {IPINST PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE PARAM_VALUE.C_DEBUG_ENABLED   \
                         PARAM_VALUE.C_ADDR_SIZE PARAM_VALUE.C_USE_MMU                       \
                         PARAM_VALUE.C_PMP_ENTRIES PARAM_VALUE.C_DATA_SIZE                   \
                         PARAM_ENABLEMENT.C_S_AXI PARAM_VALUE.C_DEBUG_TRACE_SIZE             \
                         PARAM_VALUE.C_DEBUG_PROFILE_SIZE PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE \
                         PARAM_VALUE.C_USE_FPU PARAM_VALUE.C_USE_MULDIV                      \
                         PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR PARAM_ENABLEMENT.C_PMP_ENTRIES    \
                         PARAM_ENABLEMENT.C_PMP_GRANULARITY                                  \
                         PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS PARAM_VALUE.G_TEMPLATE_LIST} {
        # Initalize necessary parameters to avoid mismatch between pre-init and post-init
        update_PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE \
            ${PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE} \
            ${PARAM_VALUE.C_DEBUG_ENABLED}

        update_PARAM_VALUE.C_ADDR_SIZE   \
            ${PARAM_VALUE.C_ADDR_SIZE}   \
            ${PARAM_VALUE.C_USE_MMU}     \
            ${PARAM_VALUE.C_PMP_ENTRIES} \
            ${PARAM_VALUE.C_DATA_SIZE}   \
            ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}

        update_PARAM_ENABLEMENT.C_S_AXI         \
            ${PARAM_ENABLEMENT.C_S_AXI}         \
            ${PARAM_VALUE.C_DEBUG_ENABLED}      \
            ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}   \
            ${PARAM_VALUE.C_DEBUG_PROFILE_SIZE} \
            ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE}

        update_PARAM_VALUE.C_USE_FPU    \
            ${PARAM_VALUE.C_USE_FPU}    \
            ${PARAM_VALUE.C_USE_MULDIV} \
            ${PARAM_VALUE.C_DATA_SIZE}  \
            ${PARAM_VALUE.G_TEMPLATE_LIST}

        update_PARAM_ENABLEMENT.C_USE_FPU \
            ${PARAM_VALUE.C_USE_FPU}      \
            ${PARAM_VALUE.C_USE_MULDIV}

        update_PARAM_ENABLEMENT.C_PMP_ENTRIES \
	    ${PARAM_ENABLEMENT.C_PMP_ENTRIES} \
            ${PARAM_VALUE.C_USE_MMU}          \
            ${PARAM_VALUE.C_DATA_SIZE}        \
            ${PARAM_VALUE.C_ADDR_SIZE}        \
	    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}

        update_PARAM_ENABLEMENT.C_PMP_GRANULARITY \
	    ${PARAM_ENABLEMENT.C_PMP_GRANULARITY} \
            ${PARAM_VALUE.C_USE_MMU}              \
            ${PARAM_VALUE.C_DATA_SIZE}            \
            ${PARAM_VALUE.C_ADDR_SIZE}            \
	    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}

        update_PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS \
	    ${PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS} \
            ${PARAM_VALUE.C_USE_MMU}               \
            ${PARAM_VALUE.C_DATA_SIZE}             \
            ${PARAM_VALUE.C_ADDR_SIZE}             \
	    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}

        # Initialize wizard
        gui_ipconfig_init $IPINST

        set param_list {}
        lappend param_list "MODELPARAM_VALUE.C_FAMILY"
        ipgui::update_params -params_list $param_list $IPINST
}


#***--------------------------------***------------------------------------***
#
# Support procedures
#
#***--------------------------------***------------------------------------***

# Convert to bitstring: valid syntax is 8'b11111111 X"FF" 0xFF "11111111" 11111111
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

proc get_param_hexvalue {parameter {length 32}} {
  return [to_hex [get_property value $parameter] $length]
}

proc gui_get_family {} {
  return [string tolower [get_project_property ARCHITECTURE]]
}

proc gui_set_enabled {parameter value} {
  if {$value != 0} {
    set_property enabled true $parameter
  } else {
    set_property enabled false $parameter
  }
}

# Set the bitstring length and model parameter to hex value
proc model_set_gui_hexvalue {parameter modelparameter paramlength modellength} {
  set_property bitstring_length $modellength $modelparameter
  set_property value [get_param_hexvalue $parameter $paramlength] $modelparameter
}

# Evaluate substition of parameters
proc EvalSubstituting {parameters procedure {numlevels 1}} {
    set paramlist {}
    if {[string index $numlevels 0] != "#"} {
        set numlevels [expr $numlevels + 1]
    }
    foreach parameter $parameters {
        upvar 1 $parameter $parameter\_value
        tcl::lappend paramlist \$$parameter [set $parameter\_value]
    }
    uplevel $numlevels [string map $paramlist $procedure]
}


#***--------------------------------***------------------------------------***
#
# IP-Level Design Rule Check (DRC) procedures
#
#***--------------------------------***------------------------------------***

# Check bitstring length and syntax
proc check_bitstring {param {length 32} {syntax 0}} {
  set value [get_property value $param]
  set bitvalue [to_bitstring $value]
  if {[string length $bitvalue] > $length} {
    set_property errmsg "The number of bits in [get_property name $param] cannot be more than $length" $param
    return false
  }
  if {$syntax == 0 && ! [regexp {0x([0-9A-Fa-f]*)} $value]} {
    set_property errmsg "Invalid Hexadecimal Value '$value' for parameter '[get_property name $param]'. Valid values are of type 0x1A" $param
    return false
  }
  return true
}

# Check IP-level cache parameter settings: baseaddr and highaddr
proc check_cache_basehigh {sizeparameter busletter baseaddr highaddr C_ADDR_SIZE C_DATA_SIZE {errmsgparam ""}} {
   set addr_size 32
   set bit_width 64
   if {$busletter == "D"} {
     set addr_size [get_property value $C_ADDR_SIZE]
   } elseif {[get_property value $C_DATA_SIZE] == 64} {
     set addr_size [get_property value $C_ADDR_SIZE]
   }

   set baseaddrName [get_property name $baseaddr]
   set highaddrName [get_property name $highaddr]
   if {! [check_bitstring $baseaddr $bit_width]} {
      return false
   }
   if {! [check_bitstring $highaddr $bit_width]} {
      return false
   }

   set baseaddrValueSrc [get_property VALUE_SRC $baseaddr]
   set highaddrValueSrc [get_property VALUE_SRC $highaddr]
   set baseaddrAuto [string equal $baseaddrValueSrc AUTO]
   set highaddrAuto [string equal $highaddrValueSrc AUTO]
   set oneauto [expr $baseaddrAuto ^ $highaddrAuto]

   set cache_base_0 [get_param_hexvalue $baseaddr $bit_width]
   set cache_high_0 [get_param_hexvalue $highaddr $bit_width]

   # TCL does not do unsigned
   set cache_base $cache_base_0
   set cache_high $cache_high_0
   if {$cache_high < 0} {
      set cache_high [expr $cache_high & (2 ** ($addr_size - 1) - 1)]
      if {$cache_base < 0} {
        # Strip out MSB in both of them
        set cache_base [expr $cache_base & (2 ** ($addr_size - 1) - 1)]
      }
   }

   if {$cache_base < 0} {
      # MSB in cache_base is high, and MSB was not high in cache_high
      if {! $oneauto} {
         if {$errmsgparam != ""} {
            set msg "$baseaddrName $cache_base_0 >= $highaddrName $cache_high_0"
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
   } elseif {$cache_base >= $cache_high} {
      if {! $oneauto} {
         if {$errmsgparam != ""} {
            set msg "$baseaddrName $cache_base_0 >= $highaddrName $cache_high_0"
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
   }

   # Check that the cacheable segment size must be 2**N, where N is a positive integer.
   # Check that the range specified by C_DCACHE_BASEADDR and C_DCACHE_HIGHADDR must comprise a
   # complete power-of-two range, such that range = 2**N and the N least significant bits of
   # C_DCACHE_BASEADDR must be zero.
   if {$cache_base != 0 || $cache_high != (2 ** $addr_size - 1)} {
      set power_of_two 1
      set size [expr $cache_high - $cache_base + 1]
      set n 0
      while {$n < $addr_size - 1} {
         if {$power_of_two == $size} { break }
         set power_of_two [expr 2 * $power_of_two]
         incr n
      }
      if {$n == ($addr_size - 1) && $size != (2 ** ($addr_size - 1)) && ! $oneauto} {
         if {$errmsgparam != ""} {
            set msg "Cacheable segment size defined by $baseaddrName = $cache_base and $highaddrName = $cache_high must be a power-of-two."
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
      if {($cache_base & ($power_of_two - 1)) != 0 && ! $oneauto} {
         if {$errmsgparam != ""} {
            set_property errmsg "The $n least significant bits of $baseaddrName are not zero, which must be the case when the cacheable segment size defined by $baseaddrName = $cache_base and $highaddrName = $cache_high is 2^$n." $errmsgparam
         }
         return false
      }
      set cache_byte_size [get_property value $sizeparameter]
      if {$size < $cache_byte_size && ! $oneauto} {
         if {$errmsgparam != ""} {
            set msg "Cacheable segment size defined by $baseaddrName = $cache_base and $highaddrName = $cache_high cannot be less than the cache size."
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
   }
   return true
}

# Check IP-level cache parameter settings: data width
proc check_cache_width {sizeparameter busletter line_len data_width \
                        C_OPTIMIZATION C_FAULT_TOLERANT C_INTERCONNECT {errmsgparam ""} {use_wide 1}} {
   # Check that wide caches are not used with fault tolerant features
   # Check that wide caches have cache size greater than 8/16/32K with 4/8/16 word cache line lengths
   # Warn for suboptimal Block RAM utilization

   set cache_line_len   [get_property value $line_len]
   set cache_byte_size  [get_property value $sizeparameter]
   set fault_tolerant   [get_property value $C_FAULT_TOLERANT]
   set cache_data_width [get_property value $data_width]
   set interconnect     [get_property value $C_INTERCONNECT]

   if {$cache_data_width != 0 && $use_wide != 0} {
      if {$interconnect != 2} {
         if {$errmsgparam != ""} {
            set msg "Full ${busletter}-cache cacheline data width is only available with AXI interconnect."
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
      if {$fault_tolerant > 0} {
         if {$errmsgparam != ""} {
            set msg "Full ${busletter}-cache cacheline data width is not available when fault tolerant features are enabled."
            set_property errmsg $msg $errmsgparam
         }
         return false
      }

      set allowed_size [expr 2048 * $cache_line_len]
      if {$cache_byte_size < $allowed_size} {
         if {$errmsgparam != ""} {
            set msg "Full ${busletter}-cache cacheline data width is not available with cache size $cache_byte_size. Please change the ${busletter}-cache size to at least $allowed_size."
            set_property errmsg $msg $errmsgparam
         }
         return false
      }
   }
   return true
}

# Check IP-level cache parameter settings: byte size
proc check_cache_size {sizeparameter busletter line_len force_tag {errmsgparam ""}} {
   # Check that used cache sizes are less than or equal to 8/16/32K with 4/8/16 word cache line lengths with force tag LUTRAM
   set force_tag_lutram [get_property value $force_tag]
   set cache_byte_size  [get_property value $sizeparameter]
   set cache_line_len   [get_property value $line_len]
   set allowed_size     [expr 2048 * $cache_line_len]

   if {($force_tag_lutram != 0) && ($cache_byte_size > $allowed_size)} {
      if {$errmsgparam != ""} {
         set msg "Using distributed RAM for ${busletter}-cache tags is not available with cache size $cache_byte_size. Please change the ${busletter}-cache size to at most $allowed_size."
         set_property errmsg $msg $errmsgparam
      }
      return false
   }
   return true
}

# Check IP-level cache parameter settings: line length
proc check_cache_line_len {sizeparameter busletter line_len {errmsgparam ""}} {
   # Do not allow 64B cache size with 16-word line length
   set cache_line_len  [get_property value $line_len]
   set cache_byte_size [get_property value $sizeparameter]
   if {$cache_line_len == 16 && $cache_byte_size == 64} {
      if {$errmsgparam != ""} {
         set msg "${busletter}-cache size 64B is not available with 16-word cache line length."
         set_property errmsg $msg $errmsgparam
      }
      return false
   }
   return true
}

proc check_base_vectors { C_BASE_VECTORS } {
  if {! [check_bitstring $C_BASE_VECTORS 64]} {
    return false
  }

  set hexvalue [get_param_hexvalue $C_BASE_VECTORS 64]
  if {($hexvalue & 0x7f) != 0} {
    set_property errmsg "The 7 least significants bits in C_BASE_VECTORS must be zero" $C_BASE_VECTORS
    return false
  }
  return true
}

proc check_pmp { C_PMP C_PMP_ENTRIES C_USE_MMU C_DATA_SIZE C_ADDR_SIZE C_USE_AXI_DP_EXT_ADDR } {
  set pmp_entries [get_property value $C_PMP_ENTRIES]
  set use_mmu     [get_property value $C_USE_MMU]
  set data_size   [get_property value $C_DATA_SIZE]
  set addr_size   [get_property value $C_ADDR_SIZE]
  set use_axi_ea  [get_property value $C_USE_AXI_DP_EXT_ADDR]
  if {$pmp_entries == 0} {
    return true
  }
  if {$use_mmu > 1} {
    set_property errmsg "PMP is not available when supervisor-mode is selected." $C_PMP
    return false
  }
  if {$data_size == 32 && $addr_size > 32 && $use_axi_ea == 0} {
    set_property errmsg "PMP is not available with address size greater than 32 bits for RV32." $C_PMP
    return false
  }
  return true
}

#***--------------------------------***------------------------------------***
#
# Procedures called to validate parameter values
#
#***--------------------------------***------------------------------------***

proc validate_PARAM_VALUE.C_OPTIMIZATION {PARAM_VALUE.C_OPTIMIZATION PARAM_VALUE.C_DCACHE_USE_WRITEBACK   \
                                          PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_USE_DCACHE               \
                                          PARAM_VALUE.C_ICACHE_BYTE_SIZE PARAM_VALUE.C_DCACHE_BYTE_SIZE   \
                                          PARAM_VALUE.C_ICACHE_LINE_LEN PARAM_VALUE.C_DCACHE_LINE_LEN     \
                                          PARAM_VALUE.C_ICACHE_DATA_WIDTH PARAM_VALUE.C_DCACHE_DATA_WIDTH \
                                          PARAM_VALUE.C_FAULT_TOLERANT PARAM_VALUE.C_INTERCONNECT } {
  set icache_result "true"
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_icache != "0"} {
  set icache_result [check_cache_width ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" ${PARAM_VALUE.C_ICACHE_LINE_LEN} \
                                       ${PARAM_VALUE.C_ICACHE_DATA_WIDTH} ${PARAM_VALUE.C_OPTIMIZATION}       \
                                       ${PARAM_VALUE.C_FAULT_TOLERANT} ${PARAM_VALUE.C_INTERCONNECT}          \
                                       ${PARAM_VALUE.C_OPTIMIZATION}]
  }
  set dcache_result "true"
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_dcache != "0"} {
    set use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
    set dcache_result [check_cache_width ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" ${PARAM_VALUE.C_DCACHE_LINE_LEN} \
                                         ${PARAM_VALUE.C_DCACHE_DATA_WIDTH} ${PARAM_VALUE.C_OPTIMIZATION}       \
                                         ${PARAM_VALUE.C_FAULT_TOLERANT} ${PARAM_VALUE.C_INTERCONNECT}          \
                                         ${PARAM_VALUE.C_OPTIMIZATION} $use_writeback]
  }
  if {$icache_result != true || $dcache_result != true} {
    return false
  }
  return true
}

proc validate_PARAM_VALUE.C_INTERCONNECT {PARAM_VALUE.C_INTERCONNECT PARAM_VALUE.C_OPTIMIZATION     \
                                          PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_ICACHE_DATA_WIDTH  \
                                          PARAM_VALUE.C_ICACHE_STREAMS PARAM_VALUE.C_ICACHE_VICTIMS \
                                          PARAM_VALUE.C_USE_DCACHE PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set interconnect         [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  set optimization         [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
  set use_icache           [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_data_width    [get_property value ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}]
  set icache_streams       [get_property value ${PARAM_VALUE.C_ICACHE_STREAMS}]
  set icache_victims       [get_property value ${PARAM_VALUE.C_ICACHE_VICTIMS}]
  set use_dcache           [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]

  set icache_ace           [expr $use_icache == 0 || ($icache_data_width == 0 && $icache_streams == 0 && $icache_victims == 0)]
  set dcache_ace           [expr $use_dcache == 0 || $dcache_use_writeback == 0]

  set msg "The ACE bus interface is not available with frequency optimization, write-back data cache, instruction cache streams or victims, and cache data widths other than 32 bits. Use Cache for All Memory Accesses must also be set for both caches."

  if {$optimization == 0 && $icache_ace && $dcache_ace} {
    return true
  } elseif {$interconnect == 3} {
    set_property errmsg $msg ${PARAM_VALUE.C_INTERCONNECT}
    return false
  } else {
    return true
  }
}

proc validate_PARAM_VALUE.C_FAULT_TOLERANT {PARAM_VALUE.C_FAULT_TOLERANT PARAM_VALUE.C_DCACHE_USE_WRITEBACK \
                                            PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_USE_DCACHE               \
                                            PARAM_VALUE.C_ICACHE_BYTE_SIZE PARAM_VALUE.C_DCACHE_BYTE_SIZE   \
                                            PARAM_VALUE.C_ICACHE_LINE_LEN PARAM_VALUE.C_DCACHE_LINE_LEN     \
                                            PARAM_VALUE.C_ICACHE_DATA_WIDTH PARAM_VALUE.C_DCACHE_DATA_WIDTH \
                                            PARAM_VALUE.C_OPTIMIZATION PARAM_VALUE.C_INTERCONNECT } {
  set icache_result "true"
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_icache != "0"} {
    set icache_result [check_cache_width ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" ${PARAM_VALUE.C_ICACHE_LINE_LEN} \
                                         ${PARAM_VALUE.C_ICACHE_DATA_WIDTH} ${PARAM_VALUE.C_OPTIMIZATION}       \
                                         ${PARAM_VALUE.C_FAULT_TOLERANT} ${PARAM_VALUE.C_INTERCONNECT}          \
                                         ${PARAM_VALUE.C_FAULT_TOLERANT}]
  }
  set dcache_result "true"
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_dcache != "0"} {
    set use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
    set dcache_result [check_cache_width ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" ${PARAM_VALUE.C_DCACHE_LINE_LEN} \
                                         ${PARAM_VALUE.C_DCACHE_DATA_WIDTH} ${PARAM_VALUE.C_OPTIMIZATION}       \
                                         ${PARAM_VALUE.C_FAULT_TOLERANT} ${PARAM_VALUE.C_INTERCONNECT}          \
                                         ${PARAM_VALUE.C_FAULT_TOLERANT} $use_writeback]
  }
  if {$icache_result != true || $dcache_result != true} {
    return false
  }
  return true
}

proc validate_PARAM_VALUE.C_PMP_ENTRIES {PARAM_VALUE.C_PMP_ENTRIES PARAM_VALUE.C_USE_MMU \
                                         PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.C_ADDR_SIZE \
                                         PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  return [check_pmp ${PARAM_VALUE.C_PMP_ENTRIES} \
                    ${PARAM_VALUE.C_PMP_ENTRIES} ${PARAM_VALUE.C_USE_MMU} \
                    ${PARAM_VALUE.C_DATA_SIZE} ${PARAM_VALUE.C_ADDR_SIZE} \
                    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]
}

proc validate_PARAM_VALUE.C_PMP_GRANULARITY {PARAM_VALUE.C_PMP_GRANULARITY PARAM_VALUE.C_PMP_ENTRIES \
                                             PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE           \
                                             PARAM_VALUE.C_ADDR_SIZE PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  return [check_pmp ${PARAM_VALUE.C_PMP_GRANULARITY} \
                    ${PARAM_VALUE.C_PMP_ENTRIES} ${PARAM_VALUE.C_USE_MMU} \
                    ${PARAM_VALUE.C_DATA_SIZE} ${PARAM_VALUE.C_ADDR_SIZE} \
                    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]
}

proc validate_PARAM_VALUE.C_PMP_ENHANCEMENTS {PARAM_VALUE.C_PMP_ENHANCEMENTS PARAM_VALUE.C_PMP_ENTRIES \
                                              PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE            \
                                              PARAM_VALUE.C_ADDR_SIZE PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  return [check_pmp ${PARAM_VALUE.C_PMP_ENHANCEMENTS} \
                    ${PARAM_VALUE.C_PMP_ENTRIES} ${PARAM_VALUE.C_USE_MMU} \
                    ${PARAM_VALUE.C_DATA_SIZE} ${PARAM_VALUE.C_ADDR_SIZE} \
                    ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]
}

foreach busletter { "I" "D" } K { "I" "D"} {
  EvalSubstituting { busletter K } {
    proc validate_PARAM_VALUE.C_$busletterCACHE_BASEADDR {PARAM_VALUE.C_$busletterCACHE_BASEADDR \
                                                          PARAM_VALUE.C_$busletterCACHE_HIGHADDR \
                                                          PARAM_VALUE.C_USE_$busletterCACHE      \
                                                          PARAM_VALUE.C_$KCACHE_BYTE_SIZE        \
                                                          PARAM_VALUE.C_ADDR_SIZE                \
                                                          PARAM_VALUE.C_DATA_SIZE} {
      set use_cache [get_property value ${PARAM_VALUE.C_USE_$busletterCACHE}]
      if {$use_cache == "0"} {
        return true
      }
      return [check_cache_basehigh [set PARAM_VALUE.C_$KCACHE_BYTE_SIZE] $busletter \
                                   [set PARAM_VALUE.C_$busletterCACHE_BASEADDR]     \
                                   [set PARAM_VALUE.C_$busletterCACHE_HIGHADDR]     \
                                   ${PARAM_VALUE.C_ADDR_SIZE}                       \
                                   ${PARAM_VALUE.C_DATA_SIZE}                       \
                                   [set PARAM_VALUE.C_$busletterCACHE_BASEADDR]]
    }

    proc validate_PARAM_VALUE.C_$busletterCACHE_HIGHADDR {PARAM_VALUE.C_$busletterCACHE_HIGHADDR \
                                                          PARAM_VALUE.C_$busletterCACHE_BASEADDR \
                                                          PARAM_VALUE.C_USE_$busletterCACHE      \
                                                          PARAM_VALUE.C_$KCACHE_BYTE_SIZE        \
                                                          PARAM_VALUE.C_ADDR_SIZE                \
                                                          PARAM_VALUE.C_DATA_SIZE} {
      set use_cache [get_property value ${PARAM_VALUE.C_USE_$busletterCACHE}]
      if {$use_cache == "0"} {
        return true
      }
      return [check_cache_basehigh [set PARAM_VALUE.C_$KCACHE_BYTE_SIZE] $busletter \
                                   [set PARAM_VALUE.C_$busletterCACHE_BASEADDR]     \
                                   [set PARAM_VALUE.C_$busletterCACHE_HIGHADDR]     \
                                   ${PARAM_VALUE.C_ADDR_SIZE}                       \
                                   ${PARAM_VALUE.C_DATA_SIZE}                       \
                                   [set PARAM_VALUE.C_$busletterCACHE_HIGHADDR]]
    }

    proc validate_PARAM_VALUE.C_$busletterCACHE_FORCE_TAG_LUTRAM {PARAM_VALUE.C_$busletterCACHE_FORCE_TAG_LUTRAM \
                                                                  PARAM_VALUE.C_USE_$busletterCACHE              \
                                                                  PARAM_VALUE.C_$KCACHE_BYTE_SIZE                \
                                                                  PARAM_VALUE.C_$busletterCACHE_LINE_LEN} {
      set use_cache [get_property value ${PARAM_VALUE.C_USE_$busletterCACHE}]
      if {$use_cache == "0"} {
        return true
      }
      return [check_cache_size [set PARAM_VALUE.C_$KCACHE_BYTE_SIZE] $busletter     \
                               [set PARAM_VALUE.C_$busletterCACHE_LINE_LEN]         \
                               [set PARAM_VALUE.C_$busletterCACHE_FORCE_TAG_LUTRAM] \
                               [set PARAM_VALUE.C_$busletterCACHE_FORCE_TAG_LUTRAM]]
    }

  } 0
}

proc validate_PARAM_VALUE.C_ICACHE_DATA_WIDTH {PARAM_VALUE.C_ICACHE_DATA_WIDTH \
                                               PARAM_VALUE.C_USE_ICACHE        \
                                               PARAM_VALUE.C_ICACHE_BYTE_SIZE  \
                                               PARAM_VALUE.C_ICACHE_LINE_LEN   \
                                               PARAM_VALUE.C_OPTIMIZATION      \
                                               PARAM_VALUE.C_FAULT_TOLERANT    \
                                               PARAM_VALUE.C_INTERCONNECT} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_cache == "0"} {
    return true
  }
  return [check_cache_width ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                            ${PARAM_VALUE.C_ICACHE_LINE_LEN}      \
                            ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}    \
                            ${PARAM_VALUE.C_OPTIMIZATION}         \
                            ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                            ${PARAM_VALUE.C_INTERCONNECT}         \
                            ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}]
}

proc validate_PARAM_VALUE.C_ICACHE_BYTE_SIZE {PARAM_VALUE.C_ICACHE_BYTE_SIZE        \
                                              PARAM_VALUE.C_USE_ICACHE              \
                                              PARAM_VALUE.C_ICACHE_LINE_LEN         \
                                              PARAM_VALUE.C_ICACHE_DATA_WIDTH       \
                                              PARAM_VALUE.C_OPTIMIZATION            \
                                              PARAM_VALUE.C_FAULT_TOLERANT          \
                                              PARAM_VALUE.C_INTERCONNECT            \
                                              PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM \
                                              PARAM_VALUE.C_ICACHE_BASEADDR         \
                                              PARAM_VALUE.C_ICACHE_HIGHADDR         \
                                              PARAM_VALUE.C_ADDR_SIZE               \
                                              PARAM_VALUE.C_USE_MMU                 \
                                              PARAM_VALUE.C_DATA_SIZE} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_cache == "0"} {
    return true
    }
  set a [check_cache_width ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}      \
                           ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}    \
                           ${PARAM_VALUE.C_OPTIMIZATION}         \
                           ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                           ${PARAM_VALUE.C_INTERCONNECT}         \
                           ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]
  set b [check_cache_size  ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I"    \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}         \
                           ${PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM} \
                           ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]
  set c [check_cache_basehigh ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                              ${PARAM_VALUE.C_ICACHE_BASEADDR}      \
                              ${PARAM_VALUE.C_ICACHE_HIGHADDR}      \
                              ${PARAM_VALUE.C_ADDR_SIZE}            \
                              ${PARAM_VALUE.C_DATA_SIZE}            \
                              ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]
  set d [check_cache_line_len ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                              ${PARAM_VALUE.C_ICACHE_LINE_LEN}      \
                              ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]
  if {$a && $b && $c && $d} {
    return true
  }
  return false
}

proc validate_PARAM_VALUE.C_ICACHE_STREAMS {PARAM_VALUE.C_ICACHE_STREAMS \
                                            PARAM_VALUE.C_USE_ICACHE     \
                                            PARAM_VALUE.C_INTERCONNECT} {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_icache == "0"} {
    return true
  }
  set icache_streams [get_property value ${PARAM_VALUE.C_ICACHE_STREAMS}]
  set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  if {$interconnect == 2 || $icache_streams == 0} {
    return true
  }
  set msg "I-cache Streams are not available with ACE bus interface."
  set_property errmsg $msg ${PARAM_VALUE.C_ICACHE_STREAMS}
  return false
}

proc validate_PARAM_VALUE.C_ICACHE_VICTIMS {PARAM_VALUE.C_ICACHE_VICTIMS \
                                            PARAM_VALUE.C_USE_ICACHE     \
                                            PARAM_VALUE.C_INTERCONNECT} {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_icache == "0"} {
    return true
  }
  set icache_victims [get_property value ${PARAM_VALUE.C_ICACHE_VICTIMS}]
  set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  if {$interconnect == 2 || $icache_victims == 0} {
    return true
  }
  set msg "I-cache Victims are not available with ACE bus interface."
  set_property errmsg $msg ${PARAM_VALUE.C_ICACHE_VICTIMS}
  return false
}

proc validate_PARAM_VALUE.C_ICACHE_LINE_LEN {PARAM_VALUE.C_ICACHE_LINE_LEN         \
                                             PARAM_VALUE.C_USE_ICACHE              \
                                             PARAM_VALUE.C_ICACHE_BYTE_SIZE        \
                                             PARAM_VALUE.C_ICACHE_DATA_WIDTH       \
                                             PARAM_VALUE.C_OPTIMIZATION            \
                                             PARAM_VALUE.C_FAULT_TOLERANT          \
                                             PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM \
                                             PARAM_VALUE.C_INTERCONNECT} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  if {$use_cache == "0"} {
    return true
  }
  set a [check_cache_width ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}      \
                           ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}    \
                           ${PARAM_VALUE.C_OPTIMIZATION}         \
                           ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                           ${PARAM_VALUE.C_INTERCONNECT}         \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  set b [check_cache_size  ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I"    \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}         \
                           ${PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM} \
                           ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  set c [check_cache_line_len ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} "I" \
                              ${PARAM_VALUE.C_ICACHE_LINE_LEN}      \
                              ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  if {$a && $b && $c} {
    return true
    }
  return false
}

proc validate_PARAM_VALUE.C_DCACHE_DATA_WIDTH {PARAM_VALUE.C_DCACHE_DATA_WIDTH \
                                               PARAM_VALUE.C_USE_DCACHE        \
                                               PARAM_VALUE.C_DCACHE_BYTE_SIZE  \
                                               PARAM_VALUE.C_DCACHE_LINE_LEN   \
                                               PARAM_VALUE.C_OPTIMIZATION      \
                                               PARAM_VALUE.C_FAULT_TOLERANT    \
                                               PARAM_VALUE.C_INTERCONNECT      \
                                               PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_cache == "0"} {
    return true
  }
  set use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  return [check_cache_width ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                            ${PARAM_VALUE.C_DCACHE_LINE_LEN}      \
                            ${PARAM_VALUE.C_DCACHE_DATA_WIDTH}    \
                            ${PARAM_VALUE.C_OPTIMIZATION}         \
                            ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                            ${PARAM_VALUE.C_INTERCONNECT}         \
                            ${PARAM_VALUE.C_DCACHE_DATA_WIDTH} $use_writeback]
}

proc validate_PARAM_VALUE.C_DCACHE_BYTE_SIZE {PARAM_VALUE.C_DCACHE_BYTE_SIZE        \
                                              PARAM_VALUE.C_USE_DCACHE              \
                                              PARAM_VALUE.C_DCACHE_LINE_LEN         \
                                              PARAM_VALUE.C_DCACHE_DATA_WIDTH       \
                                              PARAM_VALUE.C_OPTIMIZATION            \
                                              PARAM_VALUE.C_FAULT_TOLERANT          \
                                              PARAM_VALUE.C_INTERCONNECT            \
                                              PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM \
                                              PARAM_VALUE.C_DCACHE_BASEADDR         \
                                              PARAM_VALUE.C_DCACHE_HIGHADDR         \
                                              PARAM_VALUE.C_ADDR_SIZE               \
                                              PARAM_VALUE.C_USE_MMU                 \
                                              PARAM_VALUE.C_DCACHE_USE_WRITEBACK    \
                                              PARAM_VALUE.C_DATA_SIZE} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_cache == "0"} {
    return true
  }
  set use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set a [check_cache_width ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN}      \
                           ${PARAM_VALUE.C_DCACHE_DATA_WIDTH}    \
                           ${PARAM_VALUE.C_OPTIMIZATION}         \
                           ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                           ${PARAM_VALUE.C_INTERCONNECT}         \
                           ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} $use_writeback]
  set b [check_cache_size  ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D"    \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN}         \
                           ${PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM} \
                           ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}]
  set c [check_cache_basehigh ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                              ${PARAM_VALUE.C_DCACHE_BASEADDR}      \
                              ${PARAM_VALUE.C_DCACHE_HIGHADDR}      \
                              ${PARAM_VALUE.C_ADDR_SIZE}            \
                              ${PARAM_VALUE.C_DATA_SIZE}            \
                              ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}]
  set d [check_cache_line_len ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                              ${PARAM_VALUE.C_DCACHE_LINE_LEN}      \
                              ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}]
  if {$a && $b && $c && $d} {
    return true
  }
  return false
}

proc validate_PARAM_VALUE.C_DCACHE_LINE_LEN {PARAM_VALUE.C_DCACHE_LINE_LEN         \
                                             PARAM_VALUE.C_USE_DCACHE              \
                                             PARAM_VALUE.C_DCACHE_BYTE_SIZE        \
                                             PARAM_VALUE.C_DCACHE_DATA_WIDTH       \
                                             PARAM_VALUE.C_OPTIMIZATION            \
                                             PARAM_VALUE.C_FAULT_TOLERANT          \
                                             PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM \
                                             PARAM_VALUE.C_INTERCONNECT            \
                                             PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set use_cache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_cache == "0"} {
    return true
  }
  set use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set a [check_cache_width ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN}      \
                           ${PARAM_VALUE.C_DCACHE_DATA_WIDTH}    \
                           ${PARAM_VALUE.C_OPTIMIZATION}         \
                           ${PARAM_VALUE.C_FAULT_TOLERANT}       \
                           ${PARAM_VALUE.C_INTERCONNECT}         \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN} $use_writeback]
  set b [check_cache_size  ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D"    \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN}         \
                           ${PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM} \
                           ${PARAM_VALUE.C_DCACHE_LINE_LEN}]
  set c [check_cache_line_len ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} "D" \
                              ${PARAM_VALUE.C_DCACHE_LINE_LEN}      \
                              ${PARAM_VALUE.C_DCACHE_LINE_LEN}]
  if {$a && $b && $c} {
    return true
  }
  return false
}

proc validate_PARAM_VALUE.C_DCACHE_USE_WRITEBACK {PARAM_VALUE.C_DCACHE_USE_WRITEBACK \
                                                  PARAM_VALUE.C_USE_DCACHE           \
                                                  PARAM_VALUE.C_INTERCONNECT} {
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  if {$use_dcache == "0"} {
    return true
  }
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  if {$interconnect == 2 || $dcache_use_writeback == 0} {
    return true
  }
  set msg "D-cache write-back storage policy is not available with ACE bus interface."
  set_property errmsg $msg ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}
  return false
}

proc validate_PARAM_VALUE.C_BASE_VECTORS {PARAM_VALUE.C_BASE_VECTORS} { return [check_base_vectors ${PARAM_VALUE.C_BASE_VECTORS}] }

#***--------------------------------***------------------------------------***
#
# Procedures called when any parameter value, in the args list, is changed
#
#***--------------------------------***------------------------------------***

update_group {PARAM_VALUE.G_TEMPLATE_LIST} \
             {PARAM_VALUE.C_INTERCONNECT   \
              PARAM_VALUE.C_OPTIMIZATION}  {
  set interconnect [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  set optimization [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]

  setTemplateValue C_OPTIMIZATION ${PARAM_VALUE.C_OPTIMIZATION} ${PARAM_VALUE.G_TEMPLATE_LIST}
  setTemplateValue C_INTERCONNECT ${PARAM_VALUE.C_INTERCONNECT} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_gui_for_PARAM_VALUE.C_OPTIMIZATION {IPINST \
                                                PARAM_VALUE.C_OPTIMIZATION  \
                                                PARAM_VALUE.C_USE_MMU       \
                                                PARAM_VALUE.C_USE_ICACHE    \
                                                PARAM_VALUE.C_USE_DCACHE    \
                                                PARAM_VALUE.C_DEBUG_ENABLED } {
  gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                ${PARAM_VALUE.C_DEBUG_ENABLED}  1
  gui_set C_OPTIMIZATION [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
}

proc update_PARAM_VALUE.C_DEBUG_ENABLED {PARAM_VALUE.C_DEBUG_ENABLED PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DEBUG_ENABLED ${PARAM_VALUE.C_DEBUG_ENABLED} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_gui_for_PARAM_VALUE.C_DEBUG_ENABLED {IPINST \
                                                 PARAM_VALUE.C_OPTIMIZATION   \
                                                 PARAM_VALUE.C_USE_MMU        \
                                                 PARAM_VALUE.C_USE_ICACHE     \
                                                 PARAM_VALUE.C_USE_DCACHE     \
                                                 PARAM_VALUE.C_DEBUG_ENABLED  } {
  gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                ${PARAM_VALUE.C_DEBUG_ENABLED}  1
  gui_set C_DEBUG_ENABLED [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
}

proc update_PARAM_VALUE.C_USE_ICACHE {PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_ICACHE ${PARAM_VALUE.C_USE_ICACHE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_DCACHE {PARAM_VALUE.C_USE_DCACHE PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_DCACHE ${PARAM_VALUE.C_USE_DCACHE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_MMU {PARAM_VALUE.C_USE_MMU  \
                                   PARAM_VALUE.C_PMP_ENTRIES \
                                   PARAM_VALUE.C_OPTIMIZATION \
                                   PARAM_VALUE.G_TEMPLATE_LIST} {
  set pmp_entries  [get_property value ${PARAM_VALUE.C_PMP_ENTRIES}]
  set optimization [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
  if {$pmp_entries > 0} {
    set_property range "0,1" ${PARAM_VALUE.C_USE_MMU}
  } elseif {$optimization == 0 || [ea]} {
    set_property range "0,1,3" ${PARAM_VALUE.C_USE_MMU}
  } else {
    set_property range "0,1" ${PARAM_VALUE.C_USE_MMU}
  }
  setTemplateValue C_USE_MMU ${PARAM_VALUE.C_USE_MMU} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_gui_for_PARAM_VALUE.C_USE_MMU {IPINST \
                                           PARAM_VALUE.C_OPTIMIZATION   \
                                           PARAM_VALUE.C_USE_MMU        \
                                           PARAM_VALUE.C_USE_ICACHE     \
                                           PARAM_VALUE.C_USE_DCACHE     \
                                           PARAM_VALUE.C_DEBUG_ENABLED} {
  gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                ${PARAM_VALUE.C_DEBUG_ENABLED}  1
  gui_set C_USE_MMU [get_property value ${PARAM_VALUE.C_USE_MMU}]
}

proc update_gui_for_PARAM_VALUE.C_USE_ICACHE {IPINST \
                                              PARAM_VALUE.C_OPTIMIZATION   \
                                              PARAM_VALUE.C_USE_MMU        \
                                              PARAM_VALUE.C_USE_ICACHE     \
                                              PARAM_VALUE.C_USE_DCACHE     \
                                              PARAM_VALUE.C_DEBUG_ENABLED  } {
  gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                ${PARAM_VALUE.C_DEBUG_ENABLED}  1
  gui_set C_USE_ICACHE [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
}

proc update_gui_for_PARAM_VALUE.C_USE_DCACHE {IPINST \
                                              PARAM_VALUE.C_OPTIMIZATION   \
                                              PARAM_VALUE.C_USE_MMU        \
                                              PARAM_VALUE.C_USE_ICACHE     \
                                              PARAM_VALUE.C_USE_DCACHE     \
                                              PARAM_VALUE.C_DEBUG_ENABLED  } {
  gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}     \
                                ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE}  \
                                ${PARAM_VALUE.C_DEBUG_ENABLED}  1
  gui_set C_USE_DCACHE [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
}


proc update_PARAM_VALUE.C_FSL_EXCEPTION {PARAM_ENABLEMENT.C_FSL_EXCEPTION \
                                         PARAM_VALUE.C_FSL_EXCEPTION PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_FSL_EXCEPTION ${PARAM_VALUE.C_FSL_EXCEPTION} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_FSL_EXCEPTION {PARAM_ENABLEMENT.C_FSL_EXCEPTION \
                                              PARAM_VALUE.C_FSL_LINKS          \
                                              PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR} {
  set fsl_links              [get_property value ${PARAM_VALUE.C_FSL_LINKS}]
  set use_extended_fsl_instr [get_property value ${PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_FSL_EXCEPTION} [expr $fsl_links >= 1 && $use_extended_fsl_instr >= 1]
}

proc update_PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR {PARAM_ENABLEMENT.C_USE_EXTENDED_FSL_INSTR \
                                                  PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_EXTENDED_FSL_INSTR ${PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_USE_EXTENDED_FSL_INSTR {PARAM_ENABLEMENT.C_USE_EXTENDED_FSL_INSTR PARAM_VALUE.C_FSL_LINKS } {
  set fsl_links [get_property value ${PARAM_VALUE.C_FSL_LINKS}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_USE_EXTENDED_FSL_INSTR} [expr $fsl_links >= 1]
}

proc update_PARAM_VALUE.C_USE_BARREL {PARAM_VALUE.C_USE_BARREL PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_BARREL ${PARAM_VALUE.C_USE_BARREL} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_COUNTERS {PARAM_VALUE.C_USE_COUNTERS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_COUNTERS ${PARAM_VALUE.C_USE_COUNTERS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE {PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_BRANCH_TARGET_CACHE ${PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_FAULT_TOLERANT {PARAM_ENABLEMENT.C_FAULT_TOLERANT \
                                               PARAM_VALUE.C_OPTIMIZATION        \
                                               PARAM_VALUE.C_USE_ICACHE          \
                                               PARAM_VALUE.C_ICACHE_VICTIMS      \
                                               PARAM_VALUE.C_USE_DCACHE          \
                                               PARAM_VALUE.C_DCACHE_VICTIMS      \
                                               PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set optimization         [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
  set use_icache           [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_victims       [get_property value ${PARAM_VALUE.C_ICACHE_VICTIMS}]
  set no_ivictims          [expr $use_icache == 0 || $icache_victims == 0]
  set use_dcache           [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_victims       [get_property value ${PARAM_VALUE.C_DCACHE_VICTIMS}]
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set no_dvictims          [expr $use_dcache == 0 || $dcache_victims == 0]

  set no_freq_victims      [expr $optimization != 2 || ($no_ivictims && $no_dvictims)]
  set no_writeback         [expr $use_dcache == 0 || $dcache_use_writeback == 0]

  gui_set_enabled ${PARAM_ENABLEMENT.C_FAULT_TOLERANT} [expr $no_freq_victims && $no_writeback]
}

proc update_PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE {PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE \
                                                    PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_BRANCH_TARGET_CACHE_SIZE ${PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_IMPRECISE_EXCEPTIONS {PARAM_ENABLEMENT.C_IMPRECISE_EXCEPTIONS \
                                                     PARAM_VALUE.C_OPTIMIZATION} {
  set optimization [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_IMPRECISE_EXCEPTIONS} [expr $optimization == 0 || $optimization == 2]
}

proc update_PARAM_VALUE.C_ICACHE_BASEADDR {PARAM_ENABLEMENT.C_ICACHE_BASEADDR \
                                           PARAM_VALUE.C_ICACHE_BASEADDR PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_BASEADDR ${PARAM_VALUE.C_ICACHE_BASEADDR} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_BASEADDR {PARAM_ENABLEMENT.C_ICACHE_BASEADDR PARAM_VALUE.C_USE_ICACHE } {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on  [expr $use_icache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_BASEADDR} $icache_on
}

proc update_PARAM_VALUE.C_ICACHE_HIGHADDR {PARAM_ENABLEMENT.C_ICACHE_HIGHADDR \
                                           PARAM_VALUE.C_ICACHE_HIGHADDR PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_HIGHADDR ${PARAM_VALUE.C_ICACHE_HIGHADDR} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_HIGHADDR {PARAM_ENABLEMENT.C_ICACHE_HIGHADDR PARAM_VALUE.C_USE_ICACHE } {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on  [expr $use_icache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_HIGHADDR} $icache_on
}

proc update_PARAM_VALUE.C_ICACHE_BYTE_SIZE {PARAM_ENABLEMENT.C_ICACHE_BYTE_SIZE \
                                           PARAM_VALUE.C_ICACHE_BYTE_SIZE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_BYTE_SIZE ${PARAM_VALUE.C_ICACHE_BYTE_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_BYTE_SIZE {PARAM_ENABLEMENT.C_ICACHE_BYTE_SIZE PARAM_VALUE.C_USE_ICACHE} {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on  [expr $use_icache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_BYTE_SIZE} $icache_on
}

proc update_PARAM_VALUE.C_ICACHE_LINE_LEN {PARAM_ENABLEMENT.C_ICACHE_LINE_LEN \
                                           PARAM_VALUE.C_ICACHE_LINE_LEN PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_LINE_LEN ${PARAM_VALUE.C_ICACHE_LINE_LEN} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_LINE_LEN {PARAM_ENABLEMENT.C_ICACHE_LINE_LEN PARAM_VALUE.C_USE_ICACHE} {
  set use_icache [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on  [expr $use_icache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_LINE_LEN} $icache_on
}

proc update_PARAM_ENABLEMENT.C_ICACHE_DATA_WIDTH {PARAM_ENABLEMENT.C_ICACHE_DATA_WIDTH \
                                                  PARAM_VALUE.C_USE_ICACHE             \
                                                  PARAM_VALUE.C_FAULT_TOLERANT         \
                                                  PARAM_VALUE.C_ICACHE_BYTE_SIZE       \
                                                  PARAM_VALUE.C_ICACHE_LINE_LEN} {
  set use_icache      [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set fault_tolerant  [get_property value ${PARAM_VALUE.C_FAULT_TOLERANT}]
  set cache_byte_size [get_property value ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]

  set icache_on       [expr $use_icache == 1]
  set icache_line_len [get_property value ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  set icache_dw       [expr $icache_on && $fault_tolerant == 0 && \
                            $cache_byte_size >= (2048 * $icache_line_len)]

  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_DATA_WIDTH} $icache_dw
}

proc update_PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM {PARAM_ENABLEMENT.C_ICACHE_FORCE_TAG_LUTRAM \
                                                   PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_FORCE_TAG_LUTRAM ${PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_FORCE_TAG_LUTRAM {PARAM_ENABLEMENT.C_ICACHE_FORCE_TAG_LUTRAM \
                                                        PARAM_VALUE.C_USE_ICACHE                   \
                                                        PARAM_VALUE.C_ICACHE_BYTE_SIZE             \
                                                        PARAM_VALUE.C_ICACHE_LINE_LEN} {
  set use_icache      [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set cache_byte_size [get_property value ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}]
  set icache_line_len [get_property value ${PARAM_VALUE.C_ICACHE_LINE_LEN}]

  set icache_on       [expr $use_icache == 1]
  set icache_ftag     [expr $icache_on && $cache_byte_size <= (2048 * $icache_line_len)]

  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_FORCE_TAG_LUTRAM} $icache_ftag
}

proc update_PARAM_VALUE.C_ICACHE_STREAMS {PARAM_VALUE.C_ICACHE_STREAMS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_STREAMS ${PARAM_VALUE.C_ICACHE_STREAMS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_STREAMS {PARAM_ENABLEMENT.C_ICACHE_STREAMS \
                                               PARAM_VALUE.C_USE_ICACHE} {
  set use_icache     [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on      [expr $use_icache == 1]

  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_STREAMS} $icache_on
}

proc update_PARAM_VALUE.C_ICACHE_VICTIMS {PARAM_VALUE.C_ICACHE_VICTIMS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ICACHE_VICTIMS ${PARAM_VALUE.C_ICACHE_VICTIMS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_ICACHE_VICTIMS {PARAM_ENABLEMENT.C_ICACHE_VICTIMS \
                                               PARAM_VALUE.C_USE_ICACHE} {
  set use_icache     [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set icache_on      [expr $use_icache == 1]

  gui_set_enabled ${PARAM_ENABLEMENT.C_ICACHE_VICTIMS} $icache_on
}

proc update_PARAM_VALUE.C_DCACHE_LINE_LEN {PARAM_VALUE.C_DCACHE_LINE_LEN PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_LINE_LEN ${PARAM_VALUE.C_DCACHE_LINE_LEN} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_LINE_LEN {PARAM_ENABLEMENT.C_DCACHE_LINE_LEN PARAM_VALUE.C_USE_DCACHE} {
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_on  [expr $use_dcache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_LINE_LEN} $dcache_on
}

proc update_PARAM_VALUE.C_DCACHE_BASEADDR {PARAM_ENABLEMENT.C_DCACHE_BASEADDR \
                                           PARAM_VALUE.C_DCACHE_BASEADDR PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_BASEADDR ${PARAM_VALUE.C_DCACHE_BASEADDR} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_BASEADDR {PARAM_ENABLEMENT.C_DCACHE_BASEADDR PARAM_VALUE.C_USE_DCACHE} {
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_on  [expr $use_dcache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_BASEADDR} $dcache_on
}

proc update_PARAM_VALUE.C_DCACHE_HIGHADDR {PARAM_ENABLEMENT.C_DCACHE_HIGHADDR \
                                           PARAM_VALUE.C_DCACHE_HIGHADDR PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_HIGHADDR ${PARAM_VALUE.C_DCACHE_HIGHADDR} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_HIGHADDR {PARAM_ENABLEMENT.C_DCACHE_HIGHADDR PARAM_VALUE.C_USE_DCACHE} {
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_on  [expr $use_dcache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_HIGHADDR} $dcache_on
}

proc update_PARAM_VALUE.C_DCACHE_BYTE_SIZE {PARAM_VALUE.C_DCACHE_BYTE_SIZE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_BYTE_SIZE ${PARAM_VALUE.C_DCACHE_BYTE_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_BYTE_SIZE {PARAM_ENABLEMENT.C_DCACHE_BYTE_SIZE PARAM_VALUE.C_USE_DCACHE} {
  set use_dcache [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_on  [expr $use_dcache == 1]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_BYTE_SIZE} $dcache_on
}

proc update_PARAM_ENABLEMENT.C_DCACHE_DATA_WIDTH {PARAM_ENABLEMENT.C_DCACHE_DATA_WIDTH \
                                                  PARAM_VALUE.C_USE_DCACHE             \
                                                  PARAM_VALUE.C_FAULT_TOLERANT         \
                                                  PARAM_VALUE.C_DCACHE_USE_WRITEBACK   \
                                                  PARAM_VALUE.C_DCACHE_BYTE_SIZE       \
                                                  PARAM_VALUE.C_DCACHE_LINE_LEN} {
  set use_dcache           [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set fault_tolerant       [get_property value ${PARAM_VALUE.C_FAULT_TOLERANT}]
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set dcache_byte_size     [get_property value ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}]
  set dcache_line_len      [get_property value ${PARAM_VALUE.C_DCACHE_LINE_LEN}]

  set dcache_on            [expr $use_dcache == 1]

  set dcache_dw [expr $dcache_on && $fault_tolerant == 0 && \
                      $dcache_use_writeback == 1 && $dcache_byte_size >= (2048 * $dcache_line_len)]

  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_DATA_WIDTH} $dcache_dw
}

proc update_PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM  {PARAM_ENABLEMENT.C_DCACHE_FORCE_TAG_LUTRAM \
                                                    PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_FORCE_TAG_LUTRAM ${PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_FORCE_TAG_LUTRAM {PARAM_ENABLEMENT.C_DCACHE_FORCE_TAG_LUTRAM \
                                                        PARAM_VALUE.C_USE_DCACHE                   \
                                                        PARAM_VALUE.C_DCACHE_BYTE_SIZE             \
                                                        PARAM_VALUE.C_DCACHE_LINE_LEN } {
  set use_dcache       [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_byte_size [get_property value ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}]
  set dcache_line_len  [get_property value ${PARAM_VALUE.C_DCACHE_LINE_LEN}]

  set dcache_on        [expr $use_dcache == 1]
  set dcache_ftag      [expr $dcache_on && $dcache_byte_size <= (2048 * $dcache_line_len)]

  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_FORCE_TAG_LUTRAM} $dcache_ftag
}

proc update_PARAM_VALUE.C_DCACHE_USE_WRITEBACK {PARAM_VALUE.C_DCACHE_USE_WRITEBACK PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_USE_WRITEBACK ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_USE_WRITEBACK {PARAM_ENABLEMENT.C_DCACHE_USE_WRITEBACK \
                                                     PARAM_VALUE.C_USE_DCACHE                \
                                                     PARAM_VALUE.C_FAULT_TOLERANT} {
  set use_dcache     [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set fault_tolerant [get_property value ${PARAM_VALUE.C_FAULT_TOLERANT}]

  set dcache_on      [expr $use_dcache == 1]

  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_USE_WRITEBACK} [expr $dcache_on && $fault_tolerant == 0]
}

proc update_PARAM_VALUE.C_DCACHE_VICTIMS {PARAM_VALUE.C_DCACHE_VICTIMS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DCACHE_VICTIMS ${PARAM_VALUE.C_DCACHE_VICTIMS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DCACHE_VICTIMS {PARAM_ENABLEMENT.C_DCACHE_VICTIMS  \
                                               PARAM_VALUE.C_USE_DCACHE           \
                                               PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set use_dcache           [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set dcache_on            [expr $use_dcache == 1]

  gui_set_enabled ${PARAM_ENABLEMENT.C_DCACHE_VICTIMS} [expr $dcache_on && $dcache_use_writeback == 1]
}

proc update_PARAM_ENABLEMENT.C_DEBUG_INTERFACE {PARAM_ENABLEMENT.C_DEBUG_INTERFACE PARAM_VALUE.C_DEBUG_ENABLED} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_INTERFACE}  [expr $debug_enabled > 0]
}

proc update_PARAM_VALUE.C_NUMBER_OF_PC_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_PC_BRK \
                                            PARAM_VALUE.C_NUMBER_OF_PC_BRK PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_NUMBER_OF_PC_BRK ${PARAM_VALUE.C_NUMBER_OF_PC_BRK} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_NUMBER_OF_PC_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_PC_BRK PARAM_VALUE.C_DEBUG_ENABLED} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_NUMBER_OF_PC_BRK}  [expr $debug_enabled > 0]
}

proc update_PARAM_VALUE.C_NUMBER_OF_RD_ADDR_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_RD_ADDR_BRK \
                                                 PARAM_VALUE.C_NUMBER_OF_RD_ADDR_BRK PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_NUMBER_OF_RD_ADDR_BRK ${PARAM_VALUE.C_NUMBER_OF_RD_ADDR_BRK} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_NUMBER_OF_RD_ADDR_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_RD_ADDR_BRK \
                                                      PARAM_VALUE.C_DEBUG_ENABLED} {
    set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
    gui_set_enabled ${PARAM_ENABLEMENT.C_NUMBER_OF_RD_ADDR_BRK}  [expr $debug_enabled > 0]
}

proc update_PARAM_VALUE.C_NUMBER_OF_WR_ADDR_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_WR_ADDR_BRK \
                                                 PARAM_VALUE.C_NUMBER_OF_WR_ADDR_BRK PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_NUMBER_OF_WR_ADDR_BRK ${PARAM_VALUE.C_NUMBER_OF_WR_ADDR_BRK} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_NUMBER_OF_WR_ADDR_BRK {PARAM_ENABLEMENT.C_NUMBER_OF_WR_ADDR_BRK \
                                                      PARAM_VALUE.C_DEBUG_ENABLED} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_NUMBER_OF_WR_ADDR_BRK}  [expr $debug_enabled > 0]
}

proc update_PARAM_VALUE.C_DEBUG_EVENT_COUNTERS {PARAM_ENABLEMENT.C_DEBUG_EVENT_COUNTERS \
                                                PARAM_VALUE.C_DEBUG_EVENT_COUNTERS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DEBUG_EVENT_COUNTERS ${PARAM_VALUE.C_DEBUG_EVENT_COUNTERS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_EVENT_COUNTERS {PARAM_ENABLEMENT.C_DEBUG_EVENT_COUNTERS \
                                                     PARAM_VALUE.C_DEBUG_ENABLED \
                                                     PARAM_VALUE.C_USE_COUNTERS} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set use_counters [get_property value ${PARAM_VALUE.C_USE_COUNTERS}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_EVENT_COUNTERS}  [expr $debug_enabled > 0 && $use_counters > 0]
}

proc update_PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS {PARAM_ENABLEMENT.C_DEBUG_LATENCY_COUNTERS \
                                                  PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS \
                                                  PARAM_VALUE.C_DEBUG_EVENT_COUNTERS PARAM_VALUE.G_TEMPLATE_LIST} {
  set debug_event_counters [get_property value ${PARAM_VALUE.C_DEBUG_EVENT_COUNTERS}]

  set max [expr ($debug_event_counters < 14) ? 8 : 14 - $debug_event_counters / 2]
  set_property range "0,$max" ${PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS}

  setTemplateValue C_DEBUG_LATENCY_COUNTERS ${PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_LATENCY_COUNTERS {PARAM_ENABLEMENT.C_DEBUG_LATENCY_COUNTERS \
                                                       PARAM_VALUE.C_DEBUG_ENABLED \
                                                       PARAM_VALUE.C_USE_COUNTERS} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set use_counters [get_property value ${PARAM_VALUE.C_USE_COUNTERS}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_LATENCY_COUNTERS}  [expr $debug_enabled > 0 && $use_counters > 0]
}

proc update_PARAM_VALUE.C_DEBUG_COUNTER_WIDTH {PARAM_ENABLEMENT.C_DEBUG_COUNTER_WIDTH \
                                               PARAM_VALUE.C_DEBUG_COUNTER_WIDTH PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DEBUG_COUNTER_WIDTH ${PARAM_VALUE.C_DEBUG_COUNTER_WIDTH} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_COUNTER_WIDTH {PARAM_ENABLEMENT.C_DEBUG_COUNTER_WIDTH \
                                                    PARAM_VALUE.C_DEBUG_ENABLED} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_COUNTER_WIDTH}  [expr $debug_enabled > 0]
}

proc update_PARAM_VALUE.C_DEBUG_TRACE_SIZE {PARAM_VALUE.C_DEBUG_TRACE_SIZE \
                                            PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE PARAM_VALUE.G_TEMPLATE_LIST} {
  set debug_trace_size [get_property value ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}]
  set debug_external_trace [get_property value ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE}]

  if {$debug_external_trace} {
    set_property range "0" ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}
  } else {
    set_property range "0,4096,8192,16384,32768,65536,131072" ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}
  }

  setTemplateValue C_DEBUG_TRACE_SIZE ${PARAM_VALUE.C_DEBUG_TRACE_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_TRACE_SIZE {PARAM_ENABLEMENT.C_DEBUG_TRACE_SIZE PARAM_VALUE.C_DEBUG_ENABLED \
                                                 PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set debug_external_trace [get_property value ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_TRACE_SIZE}  [expr $debug_enabled > 0 && $debug_external_trace == 0]
}

proc update_PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE {PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DEBUG_EXTERNAL_TRACE ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_EXTERNAL_TRACE {PARAM_ENABLEMENT.C_DEBUG_EXTERNAL_TRACE \
                                                     PARAM_VALUE.C_DEBUG_ENABLED \
                                                     PARAM_VALUE.C_DEBUG_INTERFACE} {
  set debug_enabled   [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set debug_interface [get_property value ${PARAM_VALUE.C_DEBUG_INTERFACE}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_EXTERNAL_TRACE} [expr $debug_enabled > 0 && $debug_interface < 2]
}

proc update_PARAM_VALUE.C_DEBUG_PROFILE_SIZE {PARAM_VALUE.C_DEBUG_PROFILE_SIZE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DEBUG_PROFILE_SIZE ${PARAM_VALUE.C_DEBUG_PROFILE_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE {PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE \
                                                   PARAM_VALUE.C_DEBUG_ENABLED} {
  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_DEBUG_PROFILE_SIZE}  [expr $debug_enabled > 0]
}

foreach param {C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN                                                      \
               C_USE_MULDIV C_USE_ATOMIC C_USE_FPU C_USE_COMPRESSION C_USE_MMU                           \
               C_FSL_LINKS C_USE_EXTENDED_FSL_INSTR C_FSL_EXCEPTION C_FAULT_TOLERANT                     \
               C_USE_BARREL C_USE_COUNTERS C_USE_BRANCH_TARGET_CACHE C_ICACHE_VICTIMS C_ICACHE_STREAMS   \
               C_ICACHE_DATA_WIDTH C_DCACHE_USE_WRITEBACK C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN           \
               C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK C_NUMBER_OF_WR_ADDR_BRK                        \
               C_DEBUG_EVENT_COUNTERS C_DEBUG_LATENCY_COUNTERS C_DEBUG_COUNTER_WIDTH                     \
               C_DEBUG_TRACE_SIZE C_DEBUG_EXTERNAL_TRACE C_DEBUG_PROFILE_SIZE                            \
               C_ARCHID C_IMPID C_HARTID C_BASE_VECTORS C_ICACHE_BASEADDR C_ICACHE_HIGHADDR              \
               C_ICACHE_FORCE_TAG_LUTRAM C_DCACHE_BASEADDR C_DCACHE_HIGHADDR                             \
               C_DCACHE_VICTIMS C_DCACHE_FORCE_TAG_LUTRAM C_DCACHE_DATA_WIDTH  C_MISALIGNED_EXCEPTIONS   \
               C_M_AXI_I_BUS_EXCEPTION C_M_AXI_D_BUS_EXCEPTION C_ILL_INSTR_EXCEPTION                     \
               C_USE_BITMAN_A C_USE_BITMAN_B C_USE_BITMAN_C C_USE_BITMAN_S C_TRAP_ENHANCEMENT            \
               C_PMP_ENTRIES C_PMP_GRANULARITY C_PMP_ENHANCEMENTS C_BRANCH_TARGET_CACHE_SIZE             \
               C_USE_EXT_BRK C_USE_EXT_NM_BRK C_USE_SLEEP C_USE_NON_SECURE C_USE_INTERRUPT               \
               C_IMPRECISE_EXCEPTIONS} {
  set configParam "PARAM_VALUE.$param"
  EvalSubstituting {configParam} {
    proc update_gui_for_$configParam {IPINST $configParam} {
      set pName $configParam
      set pName [lindex [split $pName .] 1]
      gui_set $pName [get_property value [set $configParam]]
    }
  } 0
}

proc update_gui_for_PARAM_VALUE.G_TEMPLATE_LIST {IPINST PARAM_VALUE.G_TEMPLATE_LIST} {
  variable config_template_data

  set current_row [get_property value ${PARAM_VALUE.G_TEMPLATE_LIST}]
  set template_info_item [tcl::lindex [tcl::lindex $config_template_data $current_row] 0]
  set name     [tcl::lindex $template_info_item 0]
  set tooltip  [tcl::lindex $template_info_item 1]
  set iconname [tcl::lindex $template_info_item 2]
  set_property tooltip $tooltip [ipgui::get_guiparamspec G_TEMPLATE_LIST -of $IPINST]
}

proc update_PARAM_VALUE.C_ADDR_SIZE {PARAM_VALUE.C_ADDR_SIZE   \
                                     PARAM_VALUE.C_USE_MMU     \
                                     PARAM_VALUE.C_PMP_ENTRIES \
                                     PARAM_VALUE.C_DATA_SIZE   \
                                     PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  set data_size   [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set use_mmu     [get_property value ${PARAM_VALUE.C_USE_MMU}]
  set pmp_entries [get_property value ${PARAM_VALUE.C_PMP_ENTRIES}]
  set use_axi_ea  [get_property value ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]
  if {$data_size == 64} {
    if {$use_mmu == 3} {
      set_property range "39,48,57" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 39 {SV39} 48 {SV48} 57 {SV57}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    } elseif {$pmp_entries > 0} {
      set_property range "32,36,40,44,48,52,56" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 32 {4GB (32 bits)}   36 {64GB (36 bits)} \
                                                   40 {1TB (40 bits)}   44 {16TB (44 bits)} \
                                                   48 {256TB (48 bits)} 52 {4PB (52 bits)}  \
                                                   56 {64PB (56 bits)}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    } else {
      set_property range "32,36,40,44,48,52,56,64" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 32 {4GB (32 bits)}   36 {64GB (36 bits)} \
                                                   40 {1TB (40 bits)}   44 {16TB (44 bits)} \
                                                   48 {256TB (48 bits)} 52 {4PB (52 bits)}  \
                                                   56 {64PB (56 bits)}  64 {64EB (64 bits)}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    }
  } elseif {$use_mmu == 3} {
    # data_size == 32
    set_property range_value "32,32" ${PARAM_VALUE.C_ADDR_SIZE}
    set_property range_labels [join [dict create 32 {SV32}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
  } else {
    # data_size == 32, use_mmu < 3
    if {$pmp_entries > 0 && $use_axi_ea == 0} {
      set_property range_value "32,32" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 32 {4GB (32 bits)}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    } elseif {$pmp_entries > 0} {
      set_property range "32,36,40,44,48,52,56" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 32 {4GB (32 bits)}   36 {64GB (36 bits)} \
                                                   40 {1TB (40 bits)}   44 {16TB (44 bits)} \
                                                   48 {256TB (48 bits)} 52 {4PB (52 bits)}  \
                                                   56 {64PB (56 bits)}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    } else {
      set_property range "32,36,40,44,48,52,56,64" ${PARAM_VALUE.C_ADDR_SIZE}
      set_property range_labels [join [dict create 32 {4GB (32 bits)}   36 {64GB (36 bits)} \
                                                   40 {1TB (40 bits)}   44 {16TB (44 bits)} \
                                                   48 {256TB (48 bits)} 52 {4PB (52 bits)}  \
                                                   56 {64PB (56 bits)}  64 {64EB (64 bits)}] ,] ${PARAM_VALUE.C_ADDR_SIZE}
    }
  }
}

proc update_gui_for_PARAM_VALUE.C_ADDR_SIZE {IPINST PARAM_VALUE.C_ADDR_SIZE \
                                             PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE} {
  set addr_size [get_property value ${PARAM_VALUE.C_ADDR_SIZE}]
  set_property bitstring_display_width $addr_size [ipgui::get_guiparamspec C_DCACHE_BASEADDR -of $IPINST]
  set_property bitstring_display_width $addr_size [ipgui::get_guiparamspec C_DCACHE_HIGHADDR -of $IPINST]

  set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set base_vectors_size $addr_size
  if {$data_size != 64} { set base_vectors_size 32 }
  set_property bitstring_display_width $base_vectors_size [ipgui::get_guiparamspec C_BASE_VECTORS -of $IPINST]

  set use_mmu [get_property value ${PARAM_VALUE.C_USE_MMU}]
  if {$use_mmu != 3 && $data_size != 64} { set addr_size 32 }
  set_property bitstring_display_width $addr_size [ipgui::get_guiparamspec C_ICACHE_BASEADDR -of $IPINST]
  set_property bitstring_display_width $addr_size [ipgui::get_guiparamspec C_ICACHE_HIGHADDR -of $IPINST]
}

proc update_PARAM_VALUE.C_DATA_SIZE {PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_DATA_SIZE ${PARAM_VALUE.C_DATA_SIZE} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_gui_for_PARAM_VALUE.C_DATA_SIZE {IPINST PARAM_VALUE.C_USE_MMU \
                                             PARAM_VALUE.C_ADDR_SIZE PARAM_VALUE.C_DATA_SIZE \
                                             PARAM_VALUE.C_LMB_DATA_SIZE PARAM_VALUE.C_M_AXI_DP_DATA_WIDTH} {
  update_gui_for_PARAM_VALUE.C_ADDR_SIZE $IPINST ${PARAM_VALUE.C_ADDR_SIZE} \
                                         ${PARAM_VALUE.C_USE_MMU} ${PARAM_VALUE.C_DATA_SIZE}

  set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  gui_set C_DATA_SIZE $data_size

  set C_LMB_DATA_SIZE       [ipgui::get_guiparamspec C_LMB_DATA_SIZE       -of $IPINST]
  set C_M_AXI_DP_DATA_WIDTH [ipgui::get_guiparamspec C_M_AXI_DP_DATA_WIDTH -of $IPINST]
  if {$data_size == 64} {
    set_property visible true $C_LMB_DATA_SIZE
    set_property visible true $C_M_AXI_DP_DATA_WIDTH
  } else {
    set_property visible false $C_LMB_DATA_SIZE
    set_property visible false $C_M_AXI_DP_DATA_WIDTH
  }
}

proc update_gui_for_PARAM_VALUE.C_LOCKSTEP_SELECT {IPINST PARAM_VALUE.C_LOCKSTEP_SELECT              \
                                                   PARAM_VALUE.C_I_LMB_MON  PARAM_VALUE.C_D_LMB_MON  \
                                                   PARAM_VALUE.C_IP_AXI_MON PARAM_VALUE.C_DP_AXI_MON \
                                                   PARAM_VALUE.C_IC_AXI_MON PARAM_VALUE.C_DC_AXI_MON \
                                                   PARAM_VALUE.C_INTERRUPT_MON                       \
                                                   PARAM_VALUE.C_TEMPORAL_DEPTH PARAM_VALUE.C_DEBUG_ENABLED} {
  set lockstep_select [get_property value ${PARAM_VALUE.C_LOCKSTEP_SELECT}]
  gui_set C_LOCKSTEP_SELECT $lockstep_select

  set C_I_LMB_MON [ipgui::get_guiparamspec C_I_LMB_MON -of $IPINST]
  set C_D_LMB_MON [ipgui::get_guiparamspec C_D_LMB_MON -of $IPINST]

  set C_IP_AXI_MON [ipgui::get_guiparamspec C_IP_AXI_MON -of $IPINST]
  set C_DP_AXI_MON [ipgui::get_guiparamspec C_DP_AXI_MON -of $IPINST]
  set C_IC_AXI_MON [ipgui::get_guiparamspec C_IC_AXI_MON -of $IPINST]
  set C_DC_AXI_MON [ipgui::get_guiparamspec C_DC_AXI_MON -of $IPINST]

  set C_INTERRUPT_MON [ipgui::get_guiparamspec C_INTERRUPT_MON -of $IPINST]

  if {$lockstep_select >= 2} {
    set_property visible true $C_I_LMB_MON
    set_property visible true $C_D_LMB_MON
    set_property visible true $C_IP_AXI_MON
    set_property visible true $C_DP_AXI_MON
    set_property visible true $C_IC_AXI_MON
    set_property visible true $C_DC_AXI_MON
    set_property visible true $C_INTERRUPT_MON
  } else {
    set_property visible false $C_I_LMB_MON
    set_property visible false $C_D_LMB_MON
    set_property visible false $C_IP_AXI_MON
    set_property visible false $C_DP_AXI_MON
    set_property visible false $C_IC_AXI_MON
    set_property visible false $C_DC_AXI_MON
    set_property visible false $C_INTERRUPT_MON
  }

  set debug_enabled [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set C_TEMPORAL_DEPTH [ipgui::get_guiparamspec C_TEMPORAL_DEPTH -of $IPINST]

  if {$lockstep_select >= 2 && $debug_enabled > 0} {
    set_property visible true $C_TEMPORAL_DEPTH
  } else {
    set_property visible false $C_TEMPORAL_DEPTH
  }
}

proc update_PARAM_VALUE.C_D_AXI {PARAM_VALUE.C_D_AXI PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_D_AXI ${PARAM_VALUE.C_D_AXI} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_M_AXI_DP_DATA_WIDTH {PARAM_VALUE.C_M_AXI_DP_DATA_WIDTH PARAM_VALUE.C_DATA_SIZE} {
  set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  if {$data_size == 32} {
    set_property range_value "32,32" ${PARAM_VALUE.C_M_AXI_DP_DATA_WIDTH}
  } else {
    set_property range "32,64" ${PARAM_VALUE.C_M_AXI_DP_DATA_WIDTH}
  }
}

proc update_PARAM_VALUE.C_LMB_DATA_SIZE {PARAM_VALUE.C_LMB_DATA_SIZE PARAM_VALUE.C_DATA_SIZE} {
  set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  if {$data_size == 32} {
    set_property range_value "32,32" ${PARAM_VALUE.C_LMB_DATA_SIZE}
  } else {
    set_property range "32,64" ${PARAM_VALUE.C_LMB_DATA_SIZE}
  }
}

proc update_PARAM_ENABLEMENT.C_S_AXI {PARAM_ENABLEMENT.C_S_AXI            \
                                      PARAM_VALUE.C_DEBUG_ENABLED         \
                                      PARAM_VALUE.C_DEBUG_TRACE_SIZE      \
                                      PARAM_VALUE.C_DEBUG_PROFILE_SIZE    \
                                      PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE} {
  set debug_enabled        [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set debug_trace_size     [get_property value ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}]
  set debug_profile_size   [get_property value ${PARAM_VALUE.C_DEBUG_PROFILE_SIZE}]
  set debug_external_trace [get_property value ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE}]

  gui_set_enabled ${PARAM_ENABLEMENT.C_S_AXI} \
    [expr $debug_enabled > 0 && ($debug_trace_size > 0 || $debug_profile_size > 0 || $debug_external_trace > 0)]
}

proc update_PARAM_VALUE.C_FSL_LINKS {PARAM_VALUE.C_FSL_LINKS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_FSL_LINKS ${PARAM_VALUE.C_FSL_LINKS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_M_AXI_D_BUS_EXCEPTION {PARAM_ENABLEMENT.C_M_AXI_D_BUS_EXCEPTION \
                                                      PARAM_VALUE.C_D_AXI                      \
                                                      PARAM_VALUE.C_FAULT_TOLERANT             \
                                                      PARAM_VALUE.C_USE_DCACHE} {
  set d_axi          [get_property value ${PARAM_VALUE.C_D_AXI}]
  set fault_tolerant [get_property value ${PARAM_VALUE.C_FAULT_TOLERANT}]
  set use_dcache     [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_M_AXI_D_BUS_EXCEPTION} [expr $d_axi > 0 || $fault_tolerant > 0 || $use_dcache > 0]
}

proc update_PARAM_ENABLEMENT.C_M_AXI_I_BUS_EXCEPTION {PARAM_ENABLEMENT.C_M_AXI_I_BUS_EXCEPTION \
                                                      PARAM_VALUE.C_I_AXI                      \
                                                      PARAM_VALUE.C_FAULT_TOLERANT             \
                                                      PARAM_VALUE.C_USE_ICACHE} {
  set i_axi          [get_property value ${PARAM_VALUE.C_I_AXI}]
  set fault_tolerant [get_property value ${PARAM_VALUE.C_FAULT_TOLERANT}]
  set use_icache     [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_M_AXI_I_BUS_EXCEPTION} [expr $i_axi > 0 || $fault_tolerant > 0 || $use_icache > 0]
}

proc update_PARAM_VALUE.C_ILL_INSTR_EXCEPTION {PARAM_VALUE.C_ILL_INSTR_EXCEPTION PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_ILL_INSTR_EXCEPTION ${PARAM_VALUE.C_ILL_INSTR_EXCEPTION} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_MISALIGNED_EXCEPTIONS {PARAM_VALUE.C_MISALIGNED_EXCEPTIONS PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_MISALIGNED_EXCEPTIONS ${PARAM_VALUE.C_MISALIGNED_EXCEPTIONS} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_PMP_ENTRIES {PARAM_ENABLEMENT.C_PMP_ENTRIES PARAM_VALUE.C_USE_MMU \
                                            PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.C_ADDR_SIZE \
                                            PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  set use_mmu     [get_property value ${PARAM_VALUE.C_USE_MMU}]
  set data_size   [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set addr_size   [get_property value ${PARAM_VALUE.C_ADDR_SIZE}]
  set use_axi_ea  [get_property value ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]

  gui_set_enabled ${PARAM_ENABLEMENT.C_PMP_ENTRIES} \
    [expr $use_mmu <= 1 && ($data_size == 64 || $addr_size == 32 || $use_axi_ea > 0)]
}

proc update_PARAM_VALUE.C_PMP_ENTRIES {PARAM_VALUE.C_PMP_ENTRIES PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_PMP_ENTRIES ${PARAM_VALUE.C_PMP_ENTRIES} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_PMP_GRANULARITY {PARAM_ENABLEMENT.C_PMP_GRANULARITY PARAM_VALUE.C_USE_MMU \
                                                PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.C_ADDR_SIZE \
                                                PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  set use_mmu     [get_property value ${PARAM_VALUE.C_USE_MMU}]
  set data_size   [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set addr_size   [get_property value ${PARAM_VALUE.C_ADDR_SIZE}]
  set use_axi_ea  [get_property value ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]

  gui_set_enabled ${PARAM_ENABLEMENT.C_PMP_GRANULARITY} \
    [expr $use_mmu <= 1 && ($data_size == 64 || $addr_size == 32 || $use_axi_ea > 0)]
}

proc update_PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS {PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS PARAM_VALUE.C_USE_MMU \
                                                PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.C_ADDR_SIZE \
                                                PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR} {
  set use_mmu     [get_property value ${PARAM_VALUE.C_USE_MMU}]
  set data_size   [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set addr_size   [get_property value ${PARAM_VALUE.C_ADDR_SIZE}]
  set use_axi_ea  [get_property value ${PARAM_VALUE.C_USE_AXI_DP_EXT_ADDR}]

  gui_set_enabled ${PARAM_ENABLEMENT.C_PMP_ENHANCEMENTS} \
    [expr $use_mmu <= 1 && ($data_size == 64 || $addr_size == 32 || $use_axi_ea > 0)]
}

proc update_PARAM_VALUE.C_PMP_GRANULARITY {PARAM_VALUE.C_PMP_GRANULARITY PARAM_VALUE.C_DATA_SIZE       \
                                           PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_USE_DCACHE           \
                                           PARAM_VALUE.C_ICACHE_LINE_LEN PARAM_VALUE.C_DCACHE_LINE_LEN \
                                           PARAM_VALUE.G_TEMPLATE_LIST } {
  set data_size       [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  set use_icache      [get_property value ${PARAM_VALUE.C_USE_ICACHE}]
  set use_dcache      [get_property value ${PARAM_VALUE.C_USE_DCACHE}]
  set icache_line_len [get_property value ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  set dcache_line_len [get_property value ${PARAM_VALUE.C_DCACHE_LINE_LEN}]

  set data_min [expr ($data_size == 64)]
  set icache_min 0
  if {$use_icache != "0"} {
    set icache_min [expr int(log($icache_line_len) / log(2))]
  }
  set dcache_min 0
  if {$use_dcache != "0"} {
    set dcache_min [expr int(log($dcache_line_len) / log(2))]
  }
  set cache_min [expr ($icache_min > $dcache_min) ? $icache_min : $dcache_min]
  set min [expr ($data_min > $cache_min) ? $data_min : $cache_min]

  set_property range "$min,14" ${PARAM_VALUE.C_PMP_GRANULARITY}

  setTemplateValue C_PMP_GRANULARITY ${PARAM_VALUE.C_PMP_GRANULARITY} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_MULDIV {PARAM_VALUE.C_USE_MULDIV PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_MULDIV ${PARAM_VALUE.C_USE_MULDIV} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_ATOMIC {PARAM_VALUE.C_USE_ATOMIC PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_ATOMIC ${PARAM_VALUE.C_USE_ATOMIC} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_FPU {PARAM_VALUE.C_USE_FPU PARAM_VALUE.C_USE_MULDIV PARAM_VALUE.C_DATA_SIZE PARAM_VALUE.G_TEMPLATE_LIST} {
  set use_muldiv [get_property value ${PARAM_VALUE.C_USE_MULDIV}]
  set data_size  [get_property value ${PARAM_VALUE.C_DATA_SIZE}]

  if {$use_muldiv == 0} {
    set_property range "0" ${PARAM_VALUE.C_USE_FPU}
  } elseif {$data_size == 64} {
    set_property range "0,1,2" ${PARAM_VALUE.C_USE_FPU}
  } else {
    set_property range "0,1" ${PARAM_VALUE.C_USE_FPU}
  }
  setTemplateValue C_USE_FPU ${PARAM_VALUE.C_USE_FPU} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_ENABLEMENT.C_USE_FPU {PARAM_ENABLEMENT.C_USE_FPU PARAM_VALUE.C_USE_MULDIV} {
  set use_muldiv [get_property value ${PARAM_VALUE.C_USE_MULDIV}]
  gui_set_enabled ${PARAM_ENABLEMENT.C_USE_FPU} [expr $use_muldiv > 0]
}

proc update_PARAM_VALUE.C_USE_COMPRESSION {PARAM_VALUE.C_USE_COMPRESSION PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_COMPRESSION ${PARAM_VALUE.C_USE_COMPRESSION} ${PARAM_VALUE.G_TEMPLATE_LIST}
}

proc update_PARAM_VALUE.C_USE_INTERRUPT {PARAM_VALUE.C_USE_INTERRUPT PARAM_VALUE.G_TEMPLATE_LIST} {
  setTemplateValue C_USE_INTERRUPT ${PARAM_VALUE.C_USE_INTERRUPT} ${PARAM_VALUE.G_TEMPLATE_LIST}
}


#***--------------------------------***------------------------------------***
#
# Procedures called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
#
#***--------------------------------***------------------------------------***
proc update_MODELPARAM_VALUE.C_FAMILY {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_FAMILY} {
  set value [gui_get_family]
  set_property value $value ${MODELPARAM_VALUE.C_FAMILY}
}

proc update_MODELPARAM_VALUE.C_PART {PROJECT_PARAM.PART MODELPARAM_VALUE.C_PART} {
  set value [string tolower [get_project_property PART]]
  set_property value $value ${MODELPARAM_VALUE.C_PART}
}

proc update_MODELPARAM_VALUE.C_LOCKSTEP_SLAVE {MODELPARAM_VALUE.C_LOCKSTEP_SLAVE PARAM_VALUE.C_LOCKSTEP_SELECT} {
  set lockstep_select [get_property value ${PARAM_VALUE.C_LOCKSTEP_SELECT}]
  set value 0
  if {$lockstep_select >= 2} { set value 1 }
  set_property value $value ${MODELPARAM_VALUE.C_LOCKSTEP_SLAVE}
}

proc update_MODELPARAM_VALUE.C_LOCKSTEP_MASTER {MODELPARAM_VALUE.C_LOCKSTEP_MASTER PARAM_VALUE.C_LOCKSTEP_SELECT} {
  set lockstep_select [get_property value ${PARAM_VALUE.C_LOCKSTEP_SELECT}]
  set value 0
  if {$lockstep_select == 1} { set value 1 }
  set_property value $value ${MODELPARAM_VALUE.C_LOCKSTEP_MASTER}
}

proc update_MODELPARAM_VALUE.C_TEMPORAL_DEPTH {MODELPARAM_VALUE.C_TEMPORAL_DEPTH PARAM_VALUE.C_TEMPORAL_DEPTH PARAM_VALUE.C_LOCKSTEP_SELECT PARAM_VALUE.C_DEBUG_ENABLED} {
  set lockstep_select [get_property value ${PARAM_VALUE.C_LOCKSTEP_SELECT}]
  set debug_enabled   [get_property value ${PARAM_VALUE.C_DEBUG_ENABLED}]
  set value 0
  if {$lockstep_select >= 2 && $debug_enabled > 0} {
    set value [get_property value ${PARAM_VALUE.C_TEMPORAL_DEPTH}]
  }
  set_property value $value ${MODELPARAM_VALUE.C_TEMPORAL_DEPTH}
}

proc update_MODELPARAM_VALUE.C_INSTANCE {MODELPARAM_VALUE.C_INSTANCE PARAM_VALUE.Component_Name} {
  set value [get_property value ${PARAM_VALUE.Component_Name}]
  set_property value $value ${MODELPARAM_VALUE.C_INSTANCE}
}

proc update_MODELPARAM_VALUE.C_ENDIANNESS {MODELPARAM_VALUE.C_ENDIANNESS PARAM_VALUE.C_ENDIANNESS} {
  set value [get_property value ${PARAM_VALUE.C_ENDIANNESS}]
  set_property value $value ${MODELPARAM_VALUE.C_ENDIANNESS}
}

proc update_MODELPARAM_VALUE.C_M_AXI_DP_PROTOCOL {MODELPARAM_VALUE.C_M_AXI_DP_PROTOCOL \
                                                  MODELPARAM_VALUE.C_INTERCONNECT      \
                                                  MODELPARAM_VALUE.C_M_AXI_DP_EXCLUSIVE_ACCESS} {
  set interconnect              [get_property value ${MODELPARAM_VALUE.C_INTERCONNECT}]
  set m_axi_dp_exclusive_access [get_property value ${MODELPARAM_VALUE.C_M_AXI_DP_EXCLUSIVE_ACCESS}]
  set value "AXI4LITE"
  if {$interconnect >= 2 && $m_axi_dp_exclusive_access == 1} { set value "AXI4" }
  set_property value $value ${MODELPARAM_VALUE.C_M_AXI_DP_PROTOCOL}
}

# C_INTERRUPT_IS_EDGE, C_EDGE_IS_POSITIVE

proc update_MODELPARAM_VALUE.C_M_AXI_IC_DATA_WIDTH {MODELPARAM_VALUE.C_M_AXI_IC_DATA_WIDTH \
                                                    MODELPARAM_VALUE.C_INTERCONNECT        \
                                                    PARAM_VALUE.C_ICACHE_LINE_LEN          \
                                                    PARAM_VALUE.C_ICACHE_DATA_WIDTH} {
  set interconnect      [get_property value ${MODELPARAM_VALUE.C_INTERCONNECT}]
  set icache_line_len   [get_property value ${PARAM_VALUE.C_ICACHE_LINE_LEN}]
  set icache_data_width [get_property value ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}]
  set width 32
  if {$interconnect >= 2 && $icache_data_width == 2} {set width 512}
  if {$interconnect >= 2 && $icache_data_width == 1} {set width [expr 32 * $icache_line_len]}
  set_property value $width ${MODELPARAM_VALUE.C_M_AXI_IC_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M_AXI_DC_DATA_WIDTH {MODELPARAM_VALUE.C_M_AXI_DC_DATA_WIDTH \
                                                    MODELPARAM_VALUE.C_INTERCONNECT        \
                                                    PARAM_VALUE.C_DCACHE_LINE_LEN          \
                                                    PARAM_VALUE.C_DCACHE_DATA_WIDTH        \
                                                    PARAM_VALUE.C_DCACHE_USE_WRITEBACK} {
  set interconnect         [get_property value ${MODELPARAM_VALUE.C_INTERCONNECT}]
  set dcache_line_len      [get_property value ${PARAM_VALUE.C_DCACHE_LINE_LEN}]
  set dcache_data_width    [get_property value ${PARAM_VALUE.C_DCACHE_DATA_WIDTH}]
  set dcache_use_writeback [get_property value ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}]
  set width 32
  if {$interconnect >= 2 && $dcache_use_writeback == 1 && $dcache_data_width == 2} {
    set width 512
  }
  if {$interconnect >= 2 && $dcache_use_writeback == 1 && $dcache_data_width == 1} {
    set width [expr 32 * $dcache_line_len]
  }
  set_property value $width ${MODELPARAM_VALUE.C_M_AXI_DC_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_INTERCONNECT {MODELPARAM_VALUE.C_INTERCONNECT \
                                             PARAM_VALUE.C_OPTIMIZATION      \
                                             PARAM_VALUE.C_INTERCONNECT} {
  set optimization [get_property value ${PARAM_VALUE.C_OPTIMIZATION}]
  if {$optimization == 2} {
    set value 2
  } else {
    set value [get_property value ${PARAM_VALUE.C_INTERCONNECT}]
  }
  set_property value $value ${MODELPARAM_VALUE.C_INTERCONNECT}
}

proc update_MODELPARAM_VALUE.C_USE_BITMAN {MODELPARAM_VALUE.C_USE_BITMAN                            \
                                           PARAM_VALUE.C_USE_BITMAN_A PARAM_VALUE.C_USE_BITMAN_B  \
                                           PARAM_VALUE.C_USE_BITMAN_C PARAM_VALUE.C_USE_BITMAN_S } {
  set A [get_property value ${PARAM_VALUE.C_USE_BITMAN_A}]
  set B [get_property value ${PARAM_VALUE.C_USE_BITMAN_B}]
  set C [get_property value ${PARAM_VALUE.C_USE_BITMAN_C}]
  set S [get_property value ${PARAM_VALUE.C_USE_BITMAN_S}]

  set value [expr ($S << 3) | ($C << 2) | ($B << 1) | $A ]
  set value [format {%d} $value]

  set_property value $value ${MODELPARAM_VALUE.C_USE_BITMAN}
}

# C_USE_EXT_BRK, C_USE_EXT_NM_BRK, C_USE_SLEEP, C_USE_NON_SECURE

foreach param {C_OPTIMIZATION C_USE_MULDIV C_USE_ATOMIC C_USE_FPU C_USE_COMPRESSION C_M_AXI_I_BUS_EXCEPTION           \
               C_M_AXI_D_BUS_EXCEPTION C_USE_MMU C_DEBUG_ENABLED C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK           \
               C_NUMBER_OF_WR_ADDR_BRK C_DEBUG_EVENT_COUNTERS C_DEBUG_LATENCY_COUNTERS C_DEBUG_COUNTER_WIDTH          \
               C_DEBUG_TRACE_SIZE C_DEBUG_EXTERNAL_TRACE C_DEBUG_PROFILE_SIZE C_USE_INTERRUPT C_USE_ICACHE            \
               C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN C_ICACHE_VICTIMS C_ICACHE_STREAMS C_ICACHE_FORCE_TAG_LUTRAM       \
               C_ICACHE_DATA_WIDTH C_USE_DCACHE C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_USE_WRITEBACK           \
               C_DCACHE_VICTIMS C_DCACHE_FORCE_TAG_LUTRAM  C_DCACHE_DATA_WIDTH C_IMPRECISE_EXCEPTIONS C_FSL_LINKS     \
               C_USE_EXTENDED_FSL_INSTR C_FSL_EXCEPTION C_ILL_INSTR_EXCEPTION C_PMP_ENTRIES C_PMP_GRANULARITY         \
               C_PMP_ENHANCEMENTS C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE C_FREQ C_ECC_USE_CE_EXCEPTION  \
               C_FAULT_TOLERANT C_DATA_SIZE C_DEBUG_INTERFACE C_AVOID_PRIMITIVES C_USE_CONFIG_RESET C_NUM_SYNC_FF_CLK \
               C_NUM_SYNC_FF_CLK_IRQ C_NUM_SYNC_FF_CLK_DEBUG C_NUM_SYNC_FF_DBG_CLK C_NUM_SYNC_FF_DBG_TRACE_CLK        \
               C_DEBUG_TRACE_ASYNC_RESET C_M_AXI_DP_THREAD_ID_WIDTH C_M_AXI_DP_DATA_WIDTH C_M_AXI_DP_EXCLUSIVE_ACCESS \
               C_M_AXI_IP_THREAD_ID_WIDTH C_M_AXI_IP_DATA_WIDTH C_USE_EXT_BRK C_USE_EXT_NM_BRK C_USE_SLEEP            \
               C_USE_NON_SECURE C_PC_WIDTH C_INTERRUPT_IS_EDGE C_EDGE_IS_POSITIVE C_ASYNC_INTERRUPT C_ASYNC_WAKEUP    \
               C_M_AXI_IC_THREAD_ID_WIDTH C_LMB_DATA_SIZE C_M_AXI_IC_USER_VALUE C_M_AXI_IC_AWUSER_WIDTH               \
               C_M_AXI_IC_ARUSER_WIDTH C_M_AXI_IC_WUSER_WIDTH C_M_AXI_IC_RUSER_WIDTH C_M_AXI_IC_BUSER_WIDTH           \
               C_M_AXI_DC_THREAD_ID_WIDTH C_M_AXI_DC_EXCLUSIVE_ACCESS C_M_AXI_DC_USER_VALUE C_M_AXI_DC_AWUSER_WIDTH   \
               C_M_AXI_DC_ARUSER_WIDTH C_M_AXI_DC_WUSER_WIDTH C_M_AXI_DC_RUSER_WIDTH C_M_AXI_DC_BUSER_WIDTH           \
               C_MMU_PRIVILEGED_INSTR C_MISALIGNED_EXCEPTIONS C_USE_BARREL C_USE_COUNTERS C_USE_SSTC C_S_AXI          \
               C_USE_AXI_DP_EXT_ADDR C_DEBUG_NUM_PROGBUF C_TRAP_ENHANCEMENT} {
  set paramConfig "PARAM_VALUE.$param"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig} {
      set_property value [get_property value [set $paramConfig]] [set $modelParamConfig]
    }
  } 0
}

foreach param {C_D_AXI C_D_LMB C_D_LMB_PROTOCOL C_D_LMB_HAS_PROT C_I_AXI C_I_LMB C_I_LMB_PROTOCOL C_I_LMB_HAS_PROT} {
  set paramConfig "PARAM_VALUE.$param"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig} {
      set value [expr ([get_property value [set $paramConfig]] > 0) ? 1 : 0]
      set_property value $value [set $modelParamConfig]
    }
  } 0
}

foreach param {C_DADDR_SIZE} {
  set paramConfig "PARAM_VALUE.C_ADDR_SIZE"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig} {
      set_property value [get_property value [set $paramConfig]] [set $modelParamConfig]
    }
  } 0
}

foreach param {C_M_AXI_DP_ADDR_WIDTH C_M_AXI_DC_ADDR_WIDTH C_PDADDR_SIZE} {
  set paramConfig "PARAM_VALUE.C_ADDR_SIZE"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig \
                                   PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE} {
      set use_mmu   [get_property value ${PARAM_VALUE.C_USE_MMU}]
      set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
      if {$use_mmu == 3} {
        if {$data_size == 64} {
          set addr_width 56 ; # Physical address size defined by RISC-V Sv39, Sv48, Sv57
        } else {
          set addr_width 34 ; # Physical address size defined by RISC-V Sv32
        }
      } elseif {$data_size == 64} {
        set addr_width [get_property value [set $paramConfig]]
      } else {
        set addr_width [get_property value [set $paramConfig]]
      }
      set_property value $addr_width [set $modelParamConfig]
    }
  } 0
}

foreach param {C_M_AXI_IP_ADDR_WIDTH C_M_AXI_IC_ADDR_WIDTH C_PIADDR_SIZE} {
  set paramConfig "PARAM_VALUE.C_ADDR_SIZE"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig \
                                   PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE} {
      set use_mmu   [get_property value ${PARAM_VALUE.C_USE_MMU}]
      set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
      if {$use_mmu == 3} {
        if {$data_size == 64} {
          set addr_width 56 ; # Physical address size defined by RISC-V Sv39, Sv48, Sv57
        } else {
          set addr_width 34 ; # Physical address size defined by RISC-V Sv32
        }
      } elseif {$data_size == 64} {
        set addr_width [get_property value [set $paramConfig]]
      } else {
        set addr_width 32
      }
      set_property value $addr_width [set $modelParamConfig]
    }
  } 0
}

foreach param {C_M_AXI_DP_ADDR_WIDTH C_M_AXI_DC_ADDR_WIDTH} {
  set paramConfig "PARAM_VALUE.C_ADDR_SIZE"
  set addrParamConfig "PARAM_VALUE.$param"
  EvalSubstituting {paramConfig addrParamConfig} {
    proc update_$addrParamConfig {$addrParamConfig $paramConfig \
                                  PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE} {
      set use_mmu   [get_property value ${PARAM_VALUE.C_USE_MMU}]
      set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
      if {$use_mmu == 3} {
        if {$data_size == 64} {
          set addr_width 56 ; # Physical address size defined by RISC-V Sv39, Sv48, Sv57
        } else {
          set addr_width 34 ; # Physical address size defined by RISC-V Sv32
        }
      } elseif {$data_size == 64} {
        set addr_width [get_property value [set $paramConfig]]
      } else {
        set addr_width [get_property value [set $paramConfig]]
      }
      set_property value $addr_width [set $addrParamConfig]
    }
  } 0
}

foreach param {C_M_AXI_IP_ADDR_WIDTH C_M_AXI_IC_ADDR_WIDTH} {
  set paramConfig "PARAM_VALUE.C_ADDR_SIZE"
  set addrParamConfig "PARAM_VALUE.$param"
  EvalSubstituting {paramConfig addrParamConfig} {
    proc update_$addrParamConfig {$addrParamConfig $paramConfig \
                                  PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_DATA_SIZE} {
      set use_mmu   [get_property value ${PARAM_VALUE.C_USE_MMU}]
      set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
      if {$use_mmu == 3} {
        if {$data_size == 64} {
          set addr_width 56 ; # Physical address size defined by RISC-V Sv39, Sv48, Sv57
        } else {
          set addr_width 34 ; # Physical address size defined by RISC-V Sv32
        }
      } elseif {$data_size == 64} {
        set addr_width [get_property value [set $paramConfig]]
      } else {
        set addr_width 32
      }
      set_property value $addr_width [set $addrParamConfig]
    }
  } 0
}

proc update_MODELPARAM_VALUE.C_IADDR_SIZE {MODELPARAM_VALUE.C_IADDR_SIZE \
                                           PARAM_VALUE.C_ADDR_SIZE       \
                                           PARAM_VALUE.C_DATA_SIZE} {
  set data_size [get_property value ${PARAM_VALUE.C_DATA_SIZE}]
  if {$data_size == 64} {
    set iaddr_size [get_property value ${PARAM_VALUE.C_ADDR_SIZE}]
  } else {
    set iaddr_size 32
  }
  set_property value $iaddr_size ${MODELPARAM_VALUE.C_IADDR_SIZE}
}

foreach param {C_ARCHID C_IMPID C_HARTID C_BASE_VECTORS C_PMP_READ_ONLY  C_PMP_DEBUG_INHIBIT \
               C_PMP_ADDR0  C_PMP_ADDR1  C_PMP_ADDR2  C_PMP_ADDR3  C_PMP_ADDR4  C_PMP_ADDR5  C_PMP_ADDR6  C_PMP_ADDR7 \
               C_PMP_ADDR8  C_PMP_ADDR9  C_PMP_ADDR10 C_PMP_ADDR11 C_PMP_ADDR12 C_PMP_ADDR13 C_PMP_ADDR14 C_PMP_ADDR15 \
               C_PMP_ADDR16 C_PMP_ADDR17 C_PMP_ADDR18 C_PMP_ADDR19 C_PMP_ADDR20 C_PMP_ADDR21 C_PMP_ADDR22 C_PMP_ADDR23 \
               C_PMP_ADDR24 C_PMP_ADDR25 C_PMP_ADDR26 C_PMP_ADDR27 C_PMP_ADDR28 C_PMP_ADDR29 C_PMP_ADDR30 C_PMP_ADDR31 \
               C_PMP_ADDR32 C_PMP_ADDR33 C_PMP_ADDR34 C_PMP_ADDR35 C_PMP_ADDR36 C_PMP_ADDR37 C_PMP_ADDR38 C_PMP_ADDR39 \
               C_PMP_ADDR40 C_PMP_ADDR41 C_PMP_ADDR42 C_PMP_ADDR43 C_PMP_ADDR44 C_PMP_ADDR45 C_PMP_ADDR46 C_PMP_ADDR47 \
               C_PMP_ADDR48 C_PMP_ADDR49 C_PMP_ADDR50 C_PMP_ADDR51 C_PMP_ADDR52 C_PMP_ADDR53 C_PMP_ADDR54 C_PMP_ADDR55 \
               C_PMP_ADDR56 C_PMP_ADDR57 C_PMP_ADDR58 C_PMP_ADDR59 C_PMP_ADDR60 C_PMP_ADDR61 C_PMP_ADDR62 C_PMP_ADDR63 \
               C_ICACHE_BASEADDR C_ICACHE_HIGHADDR C_DCACHE_BASEADDR C_DCACHE_HIGHADDR} {
  set paramConfig "PARAM_VALUE.$param"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig} {
      model_set_gui_hexvalue [set $paramConfig] [set $modelParamConfig] 64 64
    }
  } 0
}

foreach param {C_PMP_CFG0 C_PMP_CFG1 C_PMP_CFG2 C_PMP_CFG3 C_PMP_CFG4 C_PMP_CFG5 C_PMP_CFG6 C_PMP_CFG7\
               C_PMP_CFG8 C_PMP_CFG9 C_PMP_CFG10 C_PMP_CFG11 C_PMP_CFG12 C_PMP_CFG13 C_PMP_CFG14 C_PMP_CFG15} {
  set paramConfig "PARAM_VALUE.$param"
  set modelParamConfig "MODELPARAM_VALUE.$param"
  EvalSubstituting {paramConfig modelParamConfig} {
    proc update_$modelParamConfig {$modelParamConfig $paramConfig} {
      model_set_gui_hexvalue [set $paramConfig] [set $modelParamConfig] 32 32
    }
  } 0
}


#***--------------------------------***------------------------------------***
#
#                   GUI PROC (Configuration Wizard)
#
#***--------------------------------***------------------------------------***

# Template Data sourced from TCL
# Each template-item consists of: name, tooltip, icon, info-list
# An info-list consists of: parameter, value
set config_template_data {}

# Area data for all supported families sourced from TCL
# Each area-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set config_area_data {}

# Frequency data for all supported families sourced from TCL
# Each frequency-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set config_frequency_data {}

# Performance data for all parameters sourced from TCL
# The only performance-data-item consists of: family-list reference-list parameters-list
# A parameters-list item consists of: parameter-list expressions-list
# An expressions-list item consists of: conditional-expression value-expression
set config_performance_data {}

# Display information for template data parameters
array set display_info {
  C_DCACHE_BYTE_SIZE         {22 {Cache}      {Data Cache Features}         {Size in bytes}}
  C_DCACHE_FORCE_TAG_LUTRAM  {24 {Cache}      {Data Cache Features}         {Use Distributed RAM for Tags}}
  C_DCACHE_LINE_LEN          {23 {Cache}      {Data Cache Features}         {Line Length}}
  C_DCACHE_USE_WRITEBACK     {25 {Cache}      {Data Cache Features}         {Enable Write-back Storage Policy}}
  C_DCACHE_VICTIMS           {26 {Cache}      {Data Cache Features}         {Number of Victims}}
  C_DEBUG_ENABLED            {28 {Debug}      {}                            {Enable Debug Module Interface}}
  C_DEBUG_EVENT_COUNTERS     {32 {Debug}      {Performance Monitoring}      {Number of Performance Monitor Event Counters}}
  C_DEBUG_LATENCY_COUNTERS   {33 {Debug}      {Performance Monitoring}      {Number of Performance Monitor Latency Counters}}
  C_D_AXI                    {36 {Buses}      {AXI and ACE Interfaces}      {Enable Peripheral AXI Data Interface}}
  C_FSL_EXCEPTION            {14 {Exceptions} {Other Exceptions}            {Enable Stream Exception}}
  C_FSL_LINKS                {37 {Buses}      {Stream Interfaces}           {Number of Stream Links}}
  C_ICACHE_BYTE_SIZE         {16 {Cache}      {Instruction Cache Features}  {Size in bytes}}
  C_ICACHE_FORCE_TAG_LUTRAM  {18 {Cache}      {Instruction Cache Features}  {Use Distributed RAM for Tags}}
  C_ICACHE_LINE_LEN          {17 {Cache}      {Instruction Cache Features}  {Line Length}}
  C_ICACHE_STREAMS           {19 {Cache}      {Instruction Cache Features}  {Number of Streams}}
  C_ICACHE_VICTIMS           {20 {Cache}      {Instruction Cache Features}  {Number of Victims}}
  C_ILL_INSTR_EXCEPTION      {13 {Exceptions} {Other Exceptions}            {Enable Illegal Instruction Exception}}
  C_INTERCONNECT             {35 {Buses}      {AXI and ACE Interfaces}      {Select Bus Interface}}
  C_M_AXI_D_BUS_EXCEPTION    {12 {Exceptions} {Bus Exceptions}              {Enable Data-side AXI Exception}}
  C_M_AXI_I_BUS_EXCEPTION    {11 {Exceptions} {Bus Exceptions}              {Enable Instruction-side AXI Exception}}
  C_MISALIGNED_EXCEPTIONS    {13 {Exceptions} {Other Exceptions}            {Enable Misaligned Exceptions}}
  C_NUMBER_OF_PC_BRK         {29 {Debug}      {Hardware Breakpoints}        {Number of PC Breakpoints}}
  C_NUMBER_OF_RD_ADDR_BRK    {31 {Debug}      {Hardware Breakpoints}        {Number of Read Address Watchpoints}}
  C_NUMBER_OF_WR_ADDR_BRK    {30 {Debug}      {Hardware Breakpoints}        {Number of Write Address Watchpoints}}
  C_OPTIMIZATION             {7  {General}    {Optimization}                {Select implementation optimization}}
  C_PMP_ENTRIES              {10 {General}    {}                            {Enable Physical Memory Protection}}
  C_USE_ATOMIC               {2  {General}    {Instructions}                {Enable Atomic Instructions (A extension)}}
  C_USE_BARREL               {5  {General}    {Optimization}                {Select Barrel Shifter Implementation}}
  C_USE_BITMAN               {5  {General}    {Instructions}                {Enable Bit Manipulation (Zb extensions)}}
  C_USE_BRANCH_TARGET_CACHE  {8  {General}    {Optimization}                {Enable Branch Target Cache}}
  C_USE_COMPRESSION          {4  {General}    {Instructions}                {Enable Compressed Instructions (C extension)}}
  C_USE_COUNTERS             {8  {General}    {Optimization}                {Enable Base Counters and Timers}}
  C_USE_DCACHE               {21 {Cache}      {}                            {Enable Data Cache}}
  C_USE_EXTENDED_FSL_INSTR   {6  {General}    {Instructions}                {Enable Additional Custom Instructions}}
  C_USE_FPU                  {3  {General}    {Instructions}                {Enable Floating Point Unit (F extension)}}
  C_USE_ICACHE               {15 {Cache}      {}                            {Enable Instruction Cache}}
  C_USE_INTERRUPT            {34 {Interrupt & Reset} {Interrupt}            {Use Interupt}}
  C_USE_MMU                  {27 {Mode}       {}                            {Select Privilege Mode}}
  C_USE_MULDIV               {1  {General}    {Instructions}                {Enable Multiplier and Divider (M extension)}}
}

# Currently selected mode (advanced (tabbed) = 0, basic (wizard) = 1)
set gui_current_mode 1

# Information about defined buses
set icache_bus 1
set dcache_bus 1

proc config_get_data_items {dataitem_ele current_family} {
  set item_data {}
  foreach dataitem $dataitem_ele {
    set families [tcl::lindex $dataitem 0]
    if {[tcl::lsearch -exact $families $current_family] != -1} {
      tcl::lappend item_data $dataitem
      break
    }
  }
  return $item_data
}

proc config_read_data {IPINST family} {
  variable config_template_data
  variable config_area_data
  variable config_frequency_data
  variable config_performance_data

  source -notrace [ipgui::find_file [ipgui::get_coredir] "data/riscv_cw_data.tcl"]

  # Extract data items for current family for area and frequency
  set config_area_data        [config_get_data_items $config_area_data $family]
  set config_frequency_data   [config_get_data_items $config_frequency_data $family]
}

# Check if a family is included in a family list
proc config_find {family familylist} {
  foreach item $familylist {
    if {[regexp -nocase "^${item}\$" $family]} { return 1 }
  }
  return 0
}

# Determine the number of BRAMs for a family, given data width, address width and if BRAM is forced
# This algorithm corresponds to the VHDL code in "ram_module.vhd"
proc config_ram_module_brams {family data_width addr_width force_bram force_lutram use_parity} {
  # 0: !force_bram
  # 1:  force_bram
  set ram_select_lookup {
    {0  1  2  3  4  5  6  7  8 15 16 17 18 19 20}
    {0 15 15 15 15 15 15 15 15 15 16 17 18 19 20}}

  set bram_type_lookup {
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"DISTRAM"  8}
    {"B16_S36" 36}
    {"B16_S18" 18}
    {"B16_S9"   9}
    {"B16_S4"   4}
    {"B16_S2"   2}
    {"B16_S1"   1}
    {"B36_S36" 36}
    {"B36_S36" 36}
    {"B36_S18" 18}
    {"B36_S9"   9}
    {"B36_S4"   4}
    {"B36_S2"   2}
    {"B36_S1"   1}}

  set ram_select [tcl::lindex $ram_select_lookup $force_bram]
  if {$addr_width > 0} {
    set what_bram [tcl::lindex $bram_type_lookup [expr [tcl::lindex $ram_select $addr_width] - 1]]
  } else {
    set what_bram [tcl::lindex $bram_type_lookup 0]
  }
  set bram_type  [tcl::lindex $what_bram 0]
  set bram_full_data_width [tcl::lindex $what_bram 1]

  set extra_parity_brams 0
  if {$bram_full_data_width == 2 || $bram_full_data_width == 4} {
    set extra_parity_brams [expr (4 - 4 / $bram_full_data_width) * $use_parity]
  }

  set nr_of_brams [expr ($data_width + $bram_full_data_width - 1) / $bram_full_data_width + $extra_parity_brams]
  # send_dbg_msg 1 "DEBUG: ram select = $ram_select $what_bram $bram_type $bram_full_data_width $nr_of_brams"

  if {$bram_type == "DISTRAM" || $force_lutram} { set nr_of_brams 0 }

  return $nr_of_brams
}

# Calculate the number of BRAMs in a system. Depends on the following parameters:
#  C_FAMILY C_FAULT_TOLERANT C_USE_ICACHE C_USE_DCACHE C_USE_MMU
#  C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN
#  C_DCACHE_USE_WRITEBACK C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE,
#  C_DEBUG_ENABLED C_DEBUG_TRACE_SIZE, C_DEBUG_EXTERNAL_TRACE, C_DEBUG_PROFILE_SIZE
proc config_calculate_brams {IPINST C_USE_ICACHE C_USE_DCACHE C_USE_MMU C_USE_BRANCH_TARGET_CACHE     \
                             C_FAULT_TOLERANT C_INTERCONNECT C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN     \
                             C_ICACHE_FORCE_TAG_LUTRAM C_ICACHE_DATA_WIDTH C_DEBUG_ENABLED            \
                             C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_USE_WRITEBACK              \
                             C_DCACHE_FORCE_TAG_LUTRAM C_DCACHE_DATA_WIDTH C_BRANCH_TARGET_CACHE_SIZE \
                             C_DEBUG_ENABLED C_DEBUG_TRACE_SIZE C_DEBUG_EXTERNAL_TRACE C_DEBUG_PROFILE_SIZE} {
   set total_brams 0

   set family         [gui_get_family]
   set use_icache     [get_property value $C_USE_ICACHE]
   set use_dcache     [get_property value $C_USE_DCACHE]
   set use_mmu        [get_property value $C_USE_MMU]
   set use_btc        [get_property value $C_USE_BRANCH_TARGET_CACHE]
   set use_parity     [expr [get_property value $C_FAULT_TOLERANT] > 0]
   set interconnect   [get_property value $C_INTERCONNECT]
   set debug_enabled  [get_property value $C_DEBUG_ENABLED]

   # icache
   if {$use_icache} {
     set cache_byte_size [get_property value $C_ICACHE_BYTE_SIZE]
     set icache_line_len [get_property value $C_ICACHE_LINE_LEN]

     set tag_word_size   [expr $icache_line_len + 1 + $use_parity]
     set nr_of_tag_words [expr $cache_byte_size / ($icache_line_len * 4)]
     set tag_addr_size   [expr int(log($nr_of_tag_words) / log(2))]
     set data_word_size  [expr 32 + $use_parity]
     set data_addr_size  [expr int(log($cache_byte_size / 4) / log(2))]
     set force_lutram    [get_property value $C_ICACHE_FORCE_TAG_LUTRAM]
     set force_bram      [expr $data_addr_size >= 9 && ! $force_lutram]

     set wide_data    [expr [get_property value $C_ICACHE_DATA_WIDTH] > 0]
     set allowed_size [expr 2048 * $icache_line_len]
     if {$interconnect >= 2 && $use_parity == 0 && $cache_byte_size >= $allowed_size} {
       set data_addr_size [expr $data_addr_size - int(log($icache_line_len) / log(2)) * $wide_data]
       set data_word_size [expr 32 + 32 * ($icache_line_len - 1) * $wide_data]
     }

     set icache_tag_brams  [config_ram_module_brams $family $tag_word_size $tag_addr_size $force_bram $force_lutram 0]
     set icache_data_brams [config_ram_module_brams $family $data_word_size $data_addr_size 0 0 0]

     # send_dbg_msg 1 "DEBUG: icache_tag_brams = \"${icache_tag_brams}\", icache_data_brams = \"$icache_data_brams\""
     set total_brams [expr $total_brams + $icache_tag_brams + $icache_data_brams]
   }

   # dcache
   if {$use_dcache} {
     set dcache_byte_size     [get_property value $C_DCACHE_BYTE_SIZE]
     set dcache_line_len      [get_property value $C_DCACHE_LINE_LEN]
     set dcache_use_writeback [get_property value $C_DCACHE_USE_WRITEBACK]

     set tag_word_size   [expr $dcache_line_len + 1 + $dcache_use_writeback + $use_parity]
     set nr_of_tag_words [expr $dcache_byte_size / ($dcache_line_len * 4)]
     set tag_addr_size   [expr int(log($nr_of_tag_words) / log(2))]
     set data_word_size  [expr 32 + 4 * $use_parity]
     set data_addr_size  [expr int(log($dcache_byte_size / 4) / log(2))]
     set force_lutram    [get_property value $C_DCACHE_FORCE_TAG_LUTRAM]
     set force_bram      [expr $data_addr_size >= 9 && ! $force_lutram]

     set wide_data    [expr [get_property value $C_DCACHE_DATA_WIDTH] > 0]
     set allowed_size [expr 2048 * $dcache_line_len]
     if {$dcache_use_writeback == 1 && \
         $interconnect >= 2 && $use_parity == 0 && $dcache_byte_size >= $allowed_size} {
       set data_addr_size [expr $data_addr_size - int(log($dcache_line_len) / log(2)) * $wide_data]
       set data_word_size [expr 32 + 32 * ($dcache_line_len - 1) * $wide_data]
     }

     set dcache_tag_brams  [config_ram_module_brams $family $tag_word_size $tag_addr_size $force_bram $force_lutram 0]
     set dcache_data_brams [config_ram_module_brams $family $data_word_size $data_addr_size 0 0 $use_parity]

     # send_dbg_msg 1 "DEBUG: dcache_tag_brams = \"${dcache_tag_brams}\", dcache_data_brams = \"$dcache_data_brams\""
     set total_brams [expr $total_brams + $dcache_tag_brams + $dcache_data_brams]
   }

   # mmu
   if {$use_mmu >= 2} { incr total_brams }

   # btc
   if {$use_btc} {
     set btc_size [get_property value $C_BRANCH_TARGET_CACHE_SIZE]
     if {$btc_size == 0} { incr total_brams 2 }
     if {$btc_size == 5} { incr total_brams 2 }
     if {$btc_size == 6} { incr total_brams 3 }
     if {$btc_size == 7} { incr total_brams 6 }
   }

   # debug
   if {$debug_enabled > 0} {
     set debug_trace_size     [get_property value $C_DEBUG_TRACE_SIZE]
     set debug_external_trace [get_property value $C_DEBUG_EXTERNAL_TRACE]
     set debug_profile_size   [get_property value $C_DEBUG_PROFILE_SIZE]

     if {$debug_trace_size == 4096   && ! $debug_external_trace} { incr total_brams 1  }
     if {$debug_trace_size == 8192   && ! $debug_external_trace} { incr total_brams 2  }
     if {$debug_trace_size == 16384  && ! $debug_external_trace} { incr total_brams 4  }
     if {$debug_trace_size == 32768  && ! $debug_external_trace} { incr total_brams 8  }
     if {$debug_trace_size == 65536  && ! $debug_external_trace} { incr total_brams 24 }
     if {$debug_trace_size == 131072 && ! $debug_external_trace} { incr total_brams 40 }

     if {$debug_profile_size == 4096}   { incr total_brams 1  }
     if {$debug_profile_size == 8192}   { incr total_brams 2  }
     if {$debug_profile_size == 16384}  { incr total_brams 4  }
     if {$debug_profile_size == 32768}  { incr total_brams 8  }
     if {$debug_profile_size == 65536}  { incr total_brams 16 }
     if {$debug_profile_size == 131072} { incr total_brams 32 }
   }

   # send_dbg_msg 1 "DEBUG: total_brams = \"${total_brams}\""
   return $total_brams
}

# Calculate the number of DSP48 in a system. Depends on the following parameters:
#  C_USE_MULDIV, C_USE_FPU, C_DATA_SIZE, C_DEBUG_ENABLED, C_DEBUG_LATENCY_COUNTERS
proc config_calculate_dsp48 {C_USE_MULDIV C_USE_FPU C_DATA_SIZE C_DEBUG_ENABLED C_DEBUG_LATENCY_COUNTERS} {
   set total 0

   set use_muldiv    [get_property value $C_USE_MULDIV]
   set use_fpu       [get_property value $C_USE_FPU]
   set debug_enabled [get_property value $C_DEBUG_ENABLED]

   # Integer multiply
   if {$use_muldiv > 0} {
     incr total 4
   }

   # Float multiply
   if {$use_fpu > 0} {
     incr total 2
   }

   # Debug latency counters
   if {$debug_enabled > 0} {
     set debug_latency_counters [get_property value $C_DEBUG_LATENCY_COUNTERS]
     incr total $debug_latency_counters
   }

   return $total
}

# Evaluate a parameter expression string
proc config_evalexpr {IPINST expr} {
  variable icache_bus
  variable dcache_bus
  variable hw_parameter_array

  set expritemlist [split $expr]
  set evallist {}

  foreach expritem $expritemlist {

    if {[string first "C_" $expritem] == 0} {
        set value $hw_parameter_array($expritem)
        if {$value == ""} {
          set value 0
        }
        tcl::lappend evallist $value
      # send_msg INFO 95 "$expritem  = $value"
    } else {
      if {$expritem != ""} {
        tcl::lappend evallist $expritem
      }
    }
  }

  return [expr [join $evallist]]
}

# Calculate percentage
proc config_calculate_percentage {numerator denominator} {
  set percentage 0
  if {$denominator > 0} {
    set percentage [expr round($numerator * 100 / $denominator)]
    if {$percentage > 100} { set percentage 100 }
    if {$percentage <   0} { set percentage   0 }
  }
  return $percentage
}

# Calculate the expected area in a system. Depends on the following parameters:
#  C_FAMILY C_OPTIMIZATION C_INTERCONNECT C_D_AXI C_D_LMB C_I_AXI C_I_LMB
#  C_USE_MULDIV C_USE_ATOMIC C_USE_FPU C_M_AXI_I_BUS_EXCEPTION
#  C_FSL_LINKS C_USE_EXTENDED_FSL_INSTR C_FSL_EXCEPTION C_ILL_INSTR_EXCEPTION
#  C_MISALIGNED_EXCEPTIONS C_USE_BARRREL C_USE_COUNTERS
#  C_PMP_ENTRIES C_M_AXI_D_BUS_EXCEPTION C_USE_MMU C_DEBUG_ENABLED
#  C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK C_NUMBER_OF_WR_ADDR_BRK
#  C_USE_ICACHE C_ICACHE_BYTE_SIZE C_ICACHE_LINE_LEN
#  C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN
#  C_DCACHE_USE_WRITEBACK C_DCACHE_VICTIMS
#  C_USE_MMU C_USE_INTERRUPT C_USE_EXT_BRK C_USE_EXT_NM_BRK C_USE_SLEEP C_USE_NON_SECURE
#  C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
proc config_calculate_area {IPINST} {
  variable config_area_data

  set total_area 0
  set family [gui_get_family]

  set limits {0}
  foreach dataitem $config_area_data {
    set familylist [tcl::lindex $dataitem 0]
    if {[tcl::lsearch -exact $familylist $family] != -1} {
      # send_dbg_msg 1 "DEBUG: found family $family"
      set limits [tcl::lindex $dataitem 2]
      set paramlist [tcl::lindex $dataitem 3]
      foreach paramitem $paramlist {
        set exprlist [tcl::lindex $paramitem 1]
        foreach expritem $exprlist {
          set boolexpr [tcl::lindex $expritem 0]
          # send_dbg_msg 1 "DEBUG: boolean expression: \"$boolexpr\""
          if {[config_evalexpr $IPINST $boolexpr]} {
            set valueexpr [tcl::lindex $expritem 1]
            incr total_area [config_evalexpr $IPINST $valueexpr]
          }
        }
      }
      break
    }
  }

  set maximum_area [tcl::lindex $limits end]

  set percentage [config_calculate_percentage $total_area $maximum_area]
  # send_dbg_msg 1 "DEBUG: total area: $total_area ($percentage %)"
  return $percentage
}

# Calculate the expected frequency in a system. Depends on the following
# parameters:
#  C_FAMILY C_OPTIMIZATION C_INTERCONNECT
#  C_D_AXI C_D_LMB C_I_AXI C_I_LMB
#  C_USE_MULDIV C_USE_ATOMIC C_USE_FPU C_M_AXI_I_BUS_EXCEPTION
#  C_FSL_LINKS C_USE_EXTENDED_FSL_INSTR C_FSL_EXCEPTION C_ILL_INSTR_EXCEPTION
#  C_MISALIGNED_EXCEPTIONS C_USE_BARRREL C_USE_COUNTERS
#  C_PMP_ENTRIES C_M_AXI_D_BUS_EXCEPTION C_USE_MMU
#  C_DEBUG_ENABLED C_NUMBER_OF_PC_BRK C_NUMBER_OF_RD_ADDR_BRK
#  C_NUMBER_OF_WR_ADDR_BRK C_USE_ICACHE C_ICACHE_BYTE_SIZE
#  C_ICACHE_LINE_LEN C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN C_DCACHE_USE_WRITEBACK
#  C_DCACHE_VICTIMS C_USE_INTERRUPT C_USE_EXT_BRK C_USE_EXT_NM_BRK C_USE_SLEEP
#  C_USE_NON_SECURE C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
# Frequency also depends on speed grade, but the percentage can be considered
# independent of the speed grade.
proc config_calculate_frequency {IPINST} {
  variable config_frequency_data
  variable hw_parameter_array

  # DEBUG: return [expr int(rand() * 100.0)]
  set best_fit 0
  set best_fit_freq 0
  set family [gui_get_family]
  set index [expr $hw_parameter_array(C_DATA_SIZE) == 64]

  set limits {0}
  foreach dataitem $config_frequency_data {
    set familylist [tcl::lindex $dataitem 0]
    if {[tcl::lsearch -exact $familylist $family] != -1} {
      # send_dbg_msg 1 "DEBUG: found family $family"
      set limits [tcl::lindex $dataitem 2]
      set paramlist [tcl::lindex $dataitem 3]
      foreach paramitem $paramlist {
        set exprlist [tcl::lindex $paramitem 1]
        foreach expritem $exprlist {
          set fit_expr [tcl::lindex $expritem 0]
          # send_dbg_msg 1 "DEBUG: fit expression: \"$fit_expr\""
          if {$fit_expr != ""} {
            set current_fit [config_evalexpr $IPINST $fit_expr]
          } else {
            set current_fit 0
          }
          set current_fit_freq [tcl::lindex [tcl::lindex $expritem 1] $index]
          if {$current_fit > $best_fit} {
            set best_fit $current_fit
            set best_fit_freq $current_fit_freq
          }
          if {$current_fit == $best_fit && $current_fit_freq > $best_fit_freq} {
            set best_fit $current_fit
            set best_fit_freq $current_fit_freq
          }
          # send_dbg_msg 1 "DEBUG: current: \"$current_fit\", best: \"$best_fit\", best freq: \"$best_fit_freq\""
        }
      }
      break
    }
  }

  set maximum_freq [tcl::lindex $limits end]
  set percentage [config_calculate_percentage $best_fit_freq $maximum_freq]
  # send_dbg_msg 1 "DEBUG: best fit freq: $best_fit_freq ($percentage %), max freq: $maximum_freq"
  return $percentage
}

# Calculate the expected performance in a system. Depends on the following parameters:
#  C_OPTIMIZATION
#  C_USE_MULDIV C_USE_ATOMIC C_USE_FPU C_USE_ICACHE C_ICACHE_BYTE_SIZE
#  C_ICACHE_LINE_LEN C_ICACHE_STREAMS C_ICACHE_VICTIMS C_USE_DCACHE
#  C_DCACHE_BYTE_SIZE C_DCACHE_LINE_LEN  C_DCACHE_USE_WRITEBACK
#  C_DCACHE_VICTIMS C_USE_MMU
#  C_USE_BRANCH_TARGET_CACHE C_BRANCH_TARGET_CACHE_SIZE
proc config_calculate_performance {IPINST} {
  variable config_performance_data

  set total_perf 0.0

  set dataitem [tcl::lindex $config_performance_data 0]
  set limits [tcl::lindex $dataitem 2]
  set paramlist [tcl::lindex $dataitem 3]
  foreach paramitem $paramlist {
    set exprlist [tcl::lindex $paramitem 1]
    foreach expritem $exprlist {
      set boolexpr [tcl::lindex $expritem 0]
      # send_dbg_msg 1 "DEBUG: boolean expression: \"$boolexpr\""
      if {[config_evalexpr $IPINST $boolexpr]} {
        set valueexpr [tcl::lindex $expritem 1]
        set value [config_evalexpr $IPINST $valueexpr]
        if {$value != 0.0} {
          set total_perf [expr $total_perf + $value - 1.0]
        }
      }
    }
  }
  set total_perf   [expr 1.0 + $total_perf]

  set minimum_perf [tcl::lindex $limits 0]
  set maximum_perf [tcl::lindex $limits end]
  set numerator    [expr pow(2.0, $minimum_perf - $total_perf)]
  set denominator  [expr pow(2.0, $minimum_perf - $maximum_perf)]

  set percentage [config_calculate_percentage  [expr 0.1 * $denominator + 0.9 * $numerator] $denominator]
  # send_dbg_msg 1 "DEBUG: total performance: $total_perf ($percentage %)"

  return $percentage
}

# Change BRAM information shown in the configuration dialog
proc gui_set_bram_size {IPINST PARAM_VALUE.C_OPTIMIZATION PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_USE_DCACHE      \
                        PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE PARAM_VALUE.C_FAULT_TOLERANT \
                        PARAM_VALUE.C_INTERCONNECT PARAM_VALUE.C_ICACHE_BYTE_SIZE PARAM_VALUE.C_ICACHE_LINE_LEN  \
                        PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM                                                    \
                        PARAM_VALUE.C_ICACHE_DATA_WIDTH PARAM_VALUE.C_DEBUG_ENABLED                              \
                        PARAM_VALUE.C_DCACHE_BYTE_SIZE PARAM_VALUE.C_DCACHE_LINE_LEN                             \
                        PARAM_VALUE.C_DCACHE_USE_WRITEBACK PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM                 \
                        PARAM_VALUE.C_DCACHE_DATA_WIDTH PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE                   \
                        PARAM_VALUE.C_DEBUG_ENABLED PARAM_VALUE.C_DEBUG_TRACE_SIZE                               \
                        PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE PARAM_VALUE.C_DEBUG_PROFILE_SIZE} {
  set bram_size [config_calculate_brams $IPINST ${PARAM_VALUE.C_USE_ICACHE}               \
                                                ${PARAM_VALUE.C_USE_DCACHE}               \
                                                ${PARAM_VALUE.C_USE_MMU}                  \
                                                ${PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE}  \
                                                ${PARAM_VALUE.C_FAULT_TOLERANT}           \
                                                ${PARAM_VALUE.C_INTERCONNECT}             \
                                                ${PARAM_VALUE.C_ICACHE_BYTE_SIZE}         \
                                                ${PARAM_VALUE.C_ICACHE_LINE_LEN}          \
                                                ${PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM}  \
                                                ${PARAM_VALUE.C_ICACHE_DATA_WIDTH}        \
                                                ${PARAM_VALUE.C_DEBUG_ENABLED}            \
                                                ${PARAM_VALUE.C_DCACHE_BYTE_SIZE}         \
                                                ${PARAM_VALUE.C_DCACHE_LINE_LEN}          \
                                                ${PARAM_VALUE.C_DCACHE_USE_WRITEBACK}     \
                                                ${PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM}  \
                                                ${PARAM_VALUE.C_DCACHE_DATA_WIDTH}        \
                                                ${PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE} \
                                                ${PARAM_VALUE.C_DEBUG_ENABLED}            \
                                                ${PARAM_VALUE.C_DEBUG_TRACE_SIZE}         \
                                                ${PARAM_VALUE.C_DEBUG_EXTERNAL_TRACE}     \
                                                ${PARAM_VALUE.C_DEBUG_PROFILE_SIZE}]
  # send_dbg_msg 1 "DEBUG: total_brams = \"${bram_size}\""
  return "<h3>BRAM:  <b>${bram_size}</b></h3>"
}

# Change dsp48 information shown in the configuration dialog
proc gui_set_dsp48_size {IPINST                      \
                         PARAM_VALUE.C_USE_MULDIV    \
                         PARAM_VALUE.C_USE_FPU       \
                         PARAM_VALUE.C_DATA_SIZE     \
                         PARAM_VALUE.C_DEBUG_ENABLED \
                         PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS} {
  set dsp48_size [config_calculate_dsp48 ${PARAM_VALUE.C_USE_MULDIV}    \
                                         ${PARAM_VALUE.C_USE_FPU}       \
                                         ${PARAM_VALUE.C_DATA_SIZE}     \
                                         ${PARAM_VALUE.C_DEBUG_ENABLED} \
                                         ${PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS} ]
  return "<h3>DSP48E:  <b>${dsp48_size}</b></h3>"
  # send_dbg_msg 1 "DEBUG: total_dsp48=$dsp48_size"
}

proc gui_set_resource_data {IPINST} {
  set Resource_Graph [ipgui::get_graphspec "Resource_Graph" -of $IPINST]

  set frequency_tooltip {<html><p>This value is the estimated frequency percentage relative<br/>to the maximum achievable frequency with this architecture<br/>and speed grade, which gives an indication of the relative<br/>frequency that can be achieved with the current settings.</p><br/><p><i>Please note that this is an estimate based on a set of<br/>predefined benchmark systems, which can deviate up to 30%<br/>from the actual value, and should not be taken as a guarantee<br/>that the system can reach a corresponding frequency</i>.</p></html>}
  set area_tooltip {<html><p>This value is the estimated area percentage in LUTs relative<br/>to the maximum area using this architecture, which gives an<br/>indication of the relative area that can be achieved<br/>with the current settings.</p><br/><p><i>Please note that this is an estimate, which can deviate up to 5%<br/>from the actual value, and should not be taken as a guarantee that<br/>the implemented area matches this value</i>.</p></html>}
  set performance_tooltip {<html><p>This value indicates the relative performance<br/>that can be achieved with the current settings, relative<br/>to the maximum possible performance.</p><br/><p><i>Please note that this is an estimate based on a set of<br/>benchmarks, and actual performance can vary significantly<br/>depending on the user application</i>.</p></html>}

  set frequency_value   [config_calculate_frequency $IPINST]
  set area_value        [config_calculate_area $IPINST]
  set performance_value [config_calculate_performance $IPINST]

  # send_msg INFO 5679 "$frequency_value  $area_value  $performance_value"
  ipgui::add_graph_data -name "Frequency"   -parent $Resource_Graph -color "LIGHTGRAY" -list "0 $frequency_value"   -tooltip $frequency_tooltip
  ipgui::add_graph_data -name "Area"        -parent $Resource_Graph -color "GRAY"      -list "0 $area_value"        -tooltip $area_tooltip
  ipgui::add_graph_data -name "Performance" -parent $Resource_Graph -color "DARKGRAY"  -list "0 $performance_value" -tooltip $performance_tooltip
}

# setting current_template to default value
set current_template(template_name) 0
set current_template(canSetValue) 0

# Change parameters, due to selection of a new template by the user, indicated by current_row
proc fillTemplateArray {current_row} {
  variable config_template_data
  variable current_template

  set template_item [tcl::lindex [tcl::lindex $config_template_data $current_row] 1]
  foreach item $template_item {
    set pname   [tcl::lindex $item 0]
    set value  [tcl::lindex $item 1]
        set current_template($pname) $value
  }
}

proc setTemplateValue {name handle G_TEMPLATE_LIST} {
  variable current_template

  set newTemplate [get_property value $G_TEMPLATE_LIST]
  if {$current_template(template_name) != $newTemplate} {
    set current_template(template_name) $newTemplate
    fillTemplateArray $newTemplate
    set current_template(canSetValue) 1
  }

  if {$current_template(canSetValue) && [info exists current_template($name)]} {
    set_property value $current_template($name) $handle
    unset current_template($name)
    if {[llength [array names current_template]] == 2} {
      set current_template(canSetValue) 0
    }
    return true
  } elseif { $current_template(canSetValue)} {
    return true
  }
  return false
}

# Indicate when template is modified in the configuration dialog
proc gui_set_modified {IPINST PARAM_VALUE.G_TEMPLATE_LIST                     \
    PARAM_VALUE.C_BRANCH_TARGET_CACHE_SIZE PARAM_VALUE.C_DCACHE_BYTE_SIZE     \
    PARAM_VALUE.C_DCACHE_FORCE_TAG_LUTRAM PARAM_VALUE.C_DCACHE_LINE_LEN       \
    PARAM_VALUE.C_DCACHE_USE_WRITEBACK PARAM_VALUE.C_DCACHE_VICTIMS           \
    PARAM_VALUE.C_DEBUG_ENABLED PARAM_VALUE.C_DEBUG_EVENT_COUNTERS            \
    PARAM_VALUE.C_DEBUG_LATENCY_COUNTERS PARAM_VALUE.C_D_AXI                  \
    PARAM_VALUE.C_FSL_EXCEPTION PARAM_VALUE.C_FSL_LINKS                       \
    PARAM_VALUE.C_ICACHE_BYTE_SIZE PARAM_VALUE.C_ICACHE_FORCE_TAG_LUTRAM      \
    PARAM_VALUE.C_ICACHE_LINE_LEN PARAM_VALUE.C_ICACHE_STREAMS                \
    PARAM_VALUE.C_ICACHE_VICTIMS PARAM_VALUE.C_ILL_INSTR_EXCEPTION            \
    PARAM_VALUE.C_MISALIGNED_EXCEPTIONS PARAM_VALUE.C_USE_BARREL              \
    PARAM_VALUE.C_INTERCONNECT PARAM_VALUE.C_M_AXI_D_BUS_EXCEPTION            \
    PARAM_VALUE.C_M_AXI_I_BUS_EXCEPTION PARAM_VALUE.C_NUMBER_OF_PC_BRK        \
    PARAM_VALUE.C_NUMBER_OF_RD_ADDR_BRK PARAM_VALUE.C_NUMBER_OF_WR_ADDR_BRK   \
    PARAM_VALUE.C_OPTIMIZATION PARAM_VALUE.C_PMP_ENTRIES                      \
    PARAM_VALUE.C_USE_ATOMIC PARAM_VALUE.C_USE_BITMAN_A                       \
    PARAM_VALUE.C_USE_BITMAN_B PARAM_VALUE.C_USE_BITMAN_C                     \
    PARAM_VALUE.C_USE_BITMAN_S                                                \
    PARAM_VALUE.C_USE_BRANCH_TARGET_CACHE PARAM_VALUE.C_USE_COMPRESSION       \
    PARAM_VALUE.C_USE_DCACHE PARAM_VALUE.C_USE_EXTENDED_FSL_INSTR             \
    PARAM_VALUE.C_USE_FPU PARAM_VALUE.C_USE_ICACHE PARAM_VALUE.C_USE_COUNTERS \
    PARAM_VALUE.C_USE_INTERRUPT PARAM_VALUE.C_USE_MMU PARAM_VALUE.C_USE_MULDIV } {
  variable config_template_data
  variable current_template
  variable display_info

  set panel [ipgui::get_panelspec "User Modified" -of $IPINST]

  # Determine any changed values compared to the template
  set modified {}
  set current_row [get_property value ${PARAM_VALUE.G_TEMPLATE_LIST}]
  if {$current_row != 0 && ! $current_template(canSetValue)} {
    set template_item [tcl::lindex [tcl::lindex $config_template_data $current_row] 1]
    foreach item $template_item {
      set pname  [tcl::lindex $item 0]
      set pvalue [tcl::lindex $item 1]
      set param [set PARAM_VALUE.$pname]
      if {[info exist param]} {
        set value [get_property value $param]
        if {$value != $pvalue} {
          set range_labels [split [get_property range_labels $param] ","]
          if {[tcl::llength $range_labels] > 0} {
            set range [split [get_property range $param] ","]
            set index [tcl::lsearch $range $value]
            set value [tcl::lindex $range_labels $index]
            if {$value == "true" } { set value "On"  }
            if {$value == "false"} { set value "Off" }
          }
          tcl::lappend modified [list $pname $value]
        }
      }
    }
  }

  # Update tooltip
  set len [tcl::llength $modified]
  if {$len > 0} {
    set data {}
    foreach item $modified {
      set pname [tcl::lindex $item 0]
      set value [tcl::lindex $item 1]
      if {[info exist display_info($pname)]} {
        tcl::lappend data [list {*}$display_info($pname) $value]
      }
    }
    set tooltip "<html><p>User modified configuration settings:</p><br/><table>"
    foreach item [lsort -integer -index 0 $data] {
      set page  [tcl::lindex $item 1]
      set group [tcl::lindex $item 2]
      set desc  [tcl::lindex $item 3]
      set value [tcl::lindex $item 4]
      set name "$page - $group - $desc:"
      if {$group == ""} { set name "$page - $desc:" }
      append tooltip "  <tr><td>$name</td><td align=\"right\">$value</td></tr>"
    }
    append tooltip "</table></html>"
    set text "<html><table><tr><td>User Modified</td></tr></table></html>"
    set_property tooltip $tooltip $panel
    set_property visible true $panel
  } else {
    set text ""
    set_property visible false $panel
  }

  return $text
}

# Change information shown in the configuration dialog, due to a user change
proc gui_set {pName value} {
  variable hw_parameter_array

  set hw_parameter_array($pName) $value
}

proc update_gui {IPINST} {
  gui_set_resource_data $IPINST
}

# Change visible pages in the wizard
proc gui_set_visible_pages {IPINST C_OPTIMIZATION C_USE_MMU C_USE_ICACHE \
                            C_USE_DCACHE C_DEBUG_ENABLED {change 0}} {
  variable gui_current_mode

  set show_wizard [get_property show_wizard [ipgui::get_canvasspec -of $IPINST]]
  set switch_to_tabbed [expr $gui_current_mode != $show_wizard && $gui_current_mode == 1]
  set switch_to_wizard [expr $gui_current_mode != $show_wizard && $gui_current_mode == 0]

  if {$switch_to_tabbed} {
    set gui_current_mode 0
    for {set i 2} {$i <= 6} {incr i} { set_property visible true  [ipgui::get_pagespec "Page${i}"  -of $IPINST] }
    set_property visible false [ipgui::get_pagespec "PageW1" -of $IPINST]
  }

  if {$switch_to_wizard || ($change && ($gui_current_mode != 0))} {
    set gui_current_mode 1

    set use_icache     [get_property value $C_USE_ICACHE]
    set use_dcache     [get_property value $C_USE_DCACHE]
    set debug          [expr [get_property value $C_DEBUG_ENABLED] > 0]
    set use_caches     [expr $use_icache || $use_dcache]

    set page_visible_list [list 1 1 $use_caches $debug 0 1]

    set index 1
    foreach value $page_visible_list {
      set_property visible [expr $value ? true : false] [ipgui::get_pagespec "Page$index"  -of $IPINST]
      incr index
    }
    set_property visible true [ipgui::get_pagespec "PageW1" -of $IPINST]
  }
  # send_dbg_msg 1 "DEBUG: gui_set_visible_pages $switch_to_tabbed $switch_to_wizard"
}

# Check if caches and debug are enabled, and save information for use in performance calculation
proc gui_init_buses {IPINST} {
  variable icache_bus
  variable dcache_bus

  set icache_bus [get_param_value "C_USE_ICACHE"]
  set dcache_bus [get_param_value "C_USE_DCACHE"]
}

# Initialization procedures for wizard
proc gui_ipconfig_init {IPINST} {
  config_read_data $IPINST [gui_get_family]
  if [ea] {
    set_property range "2,3" [ipgui::get_paramspec C_INTERCONNECT -of $IPINST]
    set_property range "0,1" [ipgui::get_paramspec C_PMP_ENHANCEMENTS -of $IPINST]
    set_property range "0,1,2,3" [ipgui::get_paramspec C_TRAP_ENHANCEMENT -of $IPINST]
  } else {
    set_property range "2" [ipgui::get_paramspec C_INTERCONNECT -of $IPINST]
    set_property range "0" [ipgui::get_paramspec C_PMP_ENHANCEMENTS -of $IPINST]
    set_property range "0" [ipgui::get_paramspec C_TRAP_ENHANCEMENT -of $IPINST]
  }
}

proc xpg_view_mode_updated {IPINST VIEWMODE              \
                            PARAM_VALUE.C_OPTIMIZATION   \
                            PARAM_VALUE.C_USE_MMU        \
                            PARAM_VALUE.C_USE_ICACHE     \
                            PARAM_VALUE.C_USE_DCACHE     \
                            PARAM_VALUE.C_DEBUG_ENABLED  } {
  variable gui_current_mode

  # send_dbg_msg 1 "Called xpg_view_mode_updated with \"$VIEWMODE\""

  if {$VIEWMODE == "basic" && $gui_current_mode == 0} {
    # Show pages that are visible in wizard mode
    set_property show_wizard true [ipgui::get_canvasspec -of $IPINST]
    gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                  ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                  ${PARAM_VALUE.C_DEBUG_ENABLED}
    set gui_current_mode 1
  }
  if {$VIEWMODE == "advanced" && $gui_current_mode == 1} {
    # Show pages that are visible in tabbed mode
    set_property show_wizard false [ipgui::get_canvasspec -of $IPINST]
    gui_set_visible_pages $IPINST ${PARAM_VALUE.C_OPTIMIZATION}   ${PARAM_VALUE.C_USE_MMU}    \
                                  ${PARAM_VALUE.C_USE_ICACHE}     ${PARAM_VALUE.C_USE_DCACHE} \
                                  ${PARAM_VALUE.C_DEBUG_ENABLED}
    set gui_current_mode 0
  }
}

proc update_PARAM_VALUE.C_PMP_ENHANCEMENTS {PARAM_VALUE.C_PMP_ENHANCEMENTS} {
  if [ea] {
    set_property range "0,1" ${PARAM_VALUE.C_PMP_ENHANCEMENTS}
  } else {
    set_property range "0" ${PARAM_VALUE.C_PMP_ENHANCEMENTS}
  }
}

proc update_PARAM_VALUE.C_TRAP_ENHANCEMENT {PARAM_VALUE.C_TRAP_ENHANCEMENT} {
  if [ea] {
    set_property range "0,1,2,3" ${PARAM_VALUE.C_TRAP_ENHANCEMENT}
  } else {
    set_property range "0" ${PARAM_VALUE.C_TRAP_ENHANCEMENT}
  }
}

# Early access handling
proc ea {} {
  if {[llength [array get ::env AMD_VIVADO_MICROBLAZE_V_EA]] > 0} { return true }
  return false
}
