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
source_ipfile "xgui/blk_mem_gen_v8_4_utils.tcl" 
#set partlist_file [ipgui::find_file  "[ipgui::get_coredir]/xgui" "partlist.tcl" ]

# set speedgrade            [get_project_property SPEEDGRADE] 
# set device_name           [get_project_property PART]
# set c_family              [get_project_property ARCHITECTURE]
# set family                [get_project_property FAMILY]

proc is_diablo { ARCHITECTURE } { 
set fam [string tolower $ARCHITECTURE  ]
	if  {($fam eq "virtexuplushbm" ) || ($fam eq "virtexuplus58g" ) || ($fam eq "zynquplusrfsoc" ) || ($fam eq "zynquplus" ) || ( $fam eq "virtexuplus" ) || ( $fam eq "kintexuplus" ) || ( $fam eq "spartanuplus" ) }  {  
      return 1 
	} else { 
      return 0 
	} 
#zynque  virtexum
} 
proc isDerivedFamilyOfV7 {c_family} {
	return true
	;# Commenting this line as it always returns true for 7 series and 8 series devices. Vivado supports only 7&8 Series 
	#return [expr {($c_family == "virtex7")?true:false || ($c_family == "kintex7")?true:false || ($c_family == "artix7")?true:false || ($c_family == "artix7l")?true:false || ($c_family == "aartix7")?true:false ||($c_family == "zynq")?true:false} ]
}

# set argumentList1(isFirstCall_9) true
# set argumentList1(isFirstCall_18) true
# set argumentList1(isFirstCall_36) true

proc init_meta_params {IPINST} {
	add_meta_param $IPINST -name fileData -type array
	add_meta_param $IPINST -name ecctype_previous_value -type list -value [list "No_ECC" "No_ECC"]
	add_meta_param $IPINST -name bram_bits  -type  string
	add_meta_param $IPINST -name uram_bits  -type  string -value 50 
}

proc get_bram_bits_count { } {

 return [get_metaparam_value bram_bits ] ;
 
}

proc get_uram_bits_count {} {

 return [get_metaparam_value uram_bits ] ;
 
}

proc update_uram_bits {IPINST PROJECT_PARAM.ARCHITECTURE  PROJECT_PARAM.PART PROJECT_PARAM.SPEEDGRADE PROJECT_PARAM.DEVICE} {
        
     if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] } {
        set uram_count [xit::get_device_data D_URAM_COUNT -of [xit::current_scope]]
			set uram_bits [expr {$uram_count*294912}]
     } else {
			set uram_bits 0
     }
  
 return $uram_bits ;
 
}

#set xmsg 1230
proc update_bram_bits {IPINST PROJECT_PARAM.ARCHITECTURE  PROJECT_PARAM.PART PROJECT_PARAM.SPEEDGRADE PROJECT_PARAM.DEVICE} {
  set pakage [getpackage_name ${PROJECT_PARAM.PART} ${PROJECT_PARAM.SPEEDGRADE} ${PROJECT_PARAM.DEVICE}]
  set complete_device_name [string tolower ${PROJECT_PARAM.PART}]
  set spd [string tolower ${PROJECT_PARAM.SPEEDGRADE}] 
  set indx [string last $spd $complete_device_name]
  set device_package [string range $complete_device_name 0 $indx-1 ]
    set device_package [regsub -all $pakage $device_package ""]
    set device_package [join [split $device_package -] "" ]
    set device_package [regsub -all " " $device_package ""] 
 	set fam [string tolower ${PROJECT_PARAM.ARCHITECTURE} ]
	 if  {($fam eq "virtexuplushbm" ) || ($fam eq "virtexuplus58g" ) || ($fam eq "zynquplusrfsoc" ) || ($fam eq "zynquplus" ) || ( $fam eq "virtexuplus" ) || ( $fam eq "kintexuplus" ) || ( $fam eq "spartanuplus" ) || ($fam eq "virtexu") || ( $fam eq "kintexu" ) || ( $fam eq "artixu") }  { 
				set is_ultrascale 1 
	 }  else { 
				set is_ultrascale 0 
	 }
#  set partlist_filename "xgui/partlist.tcl"
  
  #set complete_device_name [string tolower ${PROJECT_PARAM.PART}]
  #set spd [string tolower ${PROJECT_PARAM.SPEEDGRADE}] 
  #set indx [string last $spd $complete_device_name]
  #set device_package [string range $complete_device_name 0 $indx-1 ]
  #set device_package [split $device_package -]
  #set device_package [regsub -all " " $device_package ""]
	set bram_bits 0
	set k  0
	set bram_count 0 
	
#  while {1} {
#    set isEOF [gets_ipfile $partlist_filename partlistfile_data]
#    if {$isEOF < 0} {
#       break
#    }


#      set split_partlistdata [split $partlistfile_data "_"]
#      set device_identified [string tolower [lindex $split_partlistdata end-1]]
#	  set device_identified [split $device_identified -]
	#  set device_identified [regsub -all $pakage $device_identified ""]
#	  set device_identified [regsub -all " " $device_identified ""]
 
#variable xmsg	
	 #send_msg INFO $xmsg " device_package $device_package :: device_identified $device_identified :: pakage $pakage  " 
#	incr xmsg
#	  if {[regexp -nocase ^${device_package}(.*) $device_identified _  ] } {
	   #send_msg INFO $xmsg " found device_package $device_package :: device_identified $device_identified :: pakage $pakage   " 
	   #send_msg INFO 912 "$device_package eq from list $device_identified"
#        set bram_count [lindex $split_partlistdata end]
#		set k 1 
		 #send_msg INFO $xmsg " device_package $device_package :: device_identified $device_identified :: pakage $pakage with BRAMS $bram_count  " 
        
        set bram_count [xit::get_device_data D_BRAM_COUNT -of [xit::current_scope]]
		 if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
			set bram_bits [expr {($bram_count*36864)}]
		} else {
			set bram_bits [expr {$bram_count*36864}]
		}
  
#	  }
# }
#  close_ipfile $partlist_filename
  #send_msg INFO 955 "$bram_bits"
 return $bram_bits ;
 

}


proc init_gui {IPINST PROJECT_PARAM.ARCHITECTURE} {  
  set Component_Name [	ipgui::add_param  $IPINST  -name Component_Name ]
  ### Page1 ###
  set Page1 [	ipgui::add_page $IPINST -name "Page 1"]
  set newPanel0 [ipgui::add_panel $IPINST -parent $Page1 -name newPanel0 -layout horizontal]
  set newPanel1 [ipgui::add_panel $IPINST -parent $newPanel0 -name newPanel1 ]
  set Interface_Type [ipgui::add_param $IPINST -parent  $newPanel1  -name Interface_Type -widget comboBox]
  set use_bram_block  [ipgui::add_param $IPINST -parent $newPanel1 -name use_bram_block -widget comboBox]
  set_property visible false $use_bram_block
  set_property display_name "Mode" $use_bram_block
  set Memory_Type [	ipgui::add_param  $IPINST  -parent  $newPanel1  -name Memory_Type -widget comboBox ]
  set PRIM_type  [	ipgui::add_param  $IPINST  -parent  $newPanel1  -name PRIM_type_to_Implement -widget radioGroup -layout horizontal]
  set_property display_name "Select the Primitive Type to be Used" $PRIM_type
	if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] && [ipgui::get_xpg_context -of $IPINST] == "xpg_bd" } { 
      set_property visible true   $PRIM_type
	  #set_property visible false   $PRIM_type 
	} else {
      set_property visible false  $PRIM_type
	}
  set CTRL_ECC_ALGO [	ipgui::add_param  $IPINST  -parent  $newPanel1  -name CTRL_ECC_ALGO ]
  set_property visible false $CTRL_ECC_ALGO
  ### Page 3 >> Page 1  ###
  set Page3 $Page1
  set_property display_name "Basic"  $Page3
  
  set newPanel2 [ipgui::add_panel  $IPINST  -parent  $newPanel0  -name "newPanel2"]
  set Enable_32bit_Address [ipgui::add_param  $IPINST  -parent  $newPanel2  -name Enable_32bit_Address] 
  set Assume_Synchronous_Clk [	ipgui::add_param  $IPINST  -parent  $newPanel2  -name Assume_Synchronous_Clk ]

  set ECCOptionsGroupBox [	ipgui::add_group  $IPINST  -parent  $Page3  -name "ECCOptionsGroupBox" -layout horizontal]
  set_property display_name "ECC Options" $ECCOptionsGroupBox
  set ecctype [	ipgui::add_param  $IPINST  -parent  $ECCOptionsGroupBox  -name ecctype -widget comboBox]
  ipgui::add_row -parent $ECCOptionsGroupBox  $IPINST
  set ECC [	ipgui::add_param  $IPINST  -parent  $ECCOptionsGroupBox  -name ECC]
  ipgui::add_row -parent $ECCOptionsGroupBox  $IPINST
  set softecc [	ipgui::add_param  $IPINST  -parent  $ECCOptionsGroupBox  -name softecc]
  ipgui::add_row -parent $ECCOptionsGroupBox  $IPINST
  set Use_Error_Injection_Pins [	ipgui::add_param  $IPINST  -parent $ECCOptionsGroupBox  -name Use_Error_Injection_Pins]
  set Error_Injection_Type [	ipgui::add_param  $IPINST  -parent  $ECCOptionsGroupBox  -name Error_Injection_Type -widget comboBox -show_label false]

  set WriteEnableGroupBox [	ipgui::add_group  $IPINST  -parent  $Page3  -name "WriteEnableGroupBox" -layout horizontal]
  set_property display_name "Write Enable" $WriteEnableGroupBox
  set Use_Byte_Write_Enable [	ipgui::add_param  $IPINST  -parent  $WriteEnableGroupBox  -name Use_Byte_Write_Enable]
  ipgui::add_row -parent $WriteEnableGroupBox  $IPINST
  set newPanel3 [ipgui::add_panel  $IPINST  -parent  $WriteEnableGroupBox  -name "newPanel3"]
  set Byte_Size [	ipgui::add_param  $IPINST  -parent  $newPanel3 -name Byte_Size -widget comboBox]
 
  set Algorithm_Options [	ipgui::add_group  $IPINST  -parent  $Page3  -name "Algorithm_Options" -layout horizontal]
  set_property display_name "Algorithm Options" $Algorithm_Options
  ipgui::add_static_text $IPINST -name algoDescription -parent $Algorithm_Options -text "Defines the algorithm used to concatenate the block RAM primitives.\nRefer datasheet for more information."
  ipgui::add_row -parent $Algorithm_Options $IPINST
  set Algorithm [	ipgui::add_param  $IPINST  -parent  $Algorithm_Options  -name Algorithm -widget comboBox]
  ipgui::add_row -parent $Algorithm_Options  $IPINST
  set Primitive	 [	ipgui::add_param  $IPINST  -parent  $Algorithm_Options  -name Primitive	]
	
  ### Page 2 ###
  set Page2 [ipgui::add_page $IPINST -name "Page 2" -layout vertical]

  set_property display_name "AXI4"  $Page2
  set AXI_Type [ipgui::add_param $IPINST  -parent  $Page2  -name AXI_Type -widget radioGroup -layout horizontal]
  set AXI_Slave_Type [ipgui::add_param $IPINST  -parent  $Page2  -name AXI_Slave_Type -widget radioGroup -layout horizontal]
  set IDWidthGroupBox [ipgui::add_group $IPINST  -parent  $Page2  -name "IDWidthGroupBox" -layout horizontal]
  set_property display_name "ID Width Configuration" $IDWidthGroupBox
  set Use_AXI_ID [ipgui::add_param $IPINST  -parent $IDWidthGroupBox -name Use_AXI_ID]
  set AXI_ID_Width [ipgui::add_param $IPINST  -parent $IDWidthGroupBox -name AXI_ID_Width -show_label false]
  set Range_ID_Width [ipgui::add_static_text $IPINST -name Label_Range_ID_Width -parent $IDWidthGroupBox -text "Range:1 to 16" ]


  ### Page 4 ###
  set Page4 [	ipgui::add_page $IPINST   -name "Page 4" -layout horizontal]
  set_property display_name "Port A Options"  $Page4
  set Memory_Size_A [	ipgui::add_group  $IPINST  -parent  $Page4  -name "Memory_Size_A" -layout horizontal]
  set_property display_name "Memory Size" $Memory_Size_A
  set Write_Width_A_Meta [	ipgui::add_dynamic_text $IPINST -name "Write_Width_A_Meta" -parent  $Memory_Size_A  -tclproc "Write_Width_A_Meta_updated" ]
  set Write_Width_A [	ipgui::add_param  $IPINST  -parent  $Memory_Size_A -name Write_Width_A -widget textEdit -show_range false -show_label false]
  set Write_Width_A_Range [	ipgui::add_dynamic_text $IPINST -name Write_Width_A_Range -parent  $Memory_Size_A -tclproc "Write_Width_A_Range_updated" ]
  ipgui::add_static_text  $IPINST -name RangelableWrite_Width_A -parent  $Memory_Size_A  -text " "
  ipgui::add_row $IPINST -parent $Memory_Size_A
  set Read_Width_A [	ipgui::add_param  $IPINST  -parent  $Memory_Size_A -name Read_Width_A -widget comboBox]
  ipgui::add_row $IPINST -parent $Memory_Size_A
  set Write_Depth_A_Meta [	ipgui::add_dynamic_text $IPINST -name "Write_Depth_A_Meta" -parent  $Memory_Size_A  -tclproc "Write_Depth_A_Meta_updated" ]
  set Write_Depth_A [	ipgui::add_param  $IPINST  -parent  $Memory_Size_A -name Write_Depth_A -widget textEdit -show_range true -show_label false]
  set Write_Depth_A_Range [	ipgui::add_dynamic_text $IPINST -name Write_Depth_A_Range -parent  $Memory_Size_A -tclproc "Write_Depth_A_Range_updated" ]
  ipgui::add_row $IPINST -parent $Memory_Size_A
  ipgui::add_static_text $IPINST -name ReadDepthA -text "Read Depth" -parent $Memory_Size_A
  set Read_Depth_A [	ipgui::add_dynamic_text $IPINST -name Read_Depth_A -parent  $Memory_Size_A -tclproc "Read_Depth_A_updated" ]
  set_property display_border true $Read_Depth_A
  ipgui::add_row $IPINST -parent $Memory_Size_A
  set portA_Description [ipgui::add_dynamic_text $IPINST -name portA_Description -parent $Memory_Size_A -tclproc portA_Description_updated ]
  ipgui::add_row $IPINST -parent $Page4 
  set Operating_Mode_A 	[ipgui::add_param $IPINST  -parent  $Page4  -name Operating_Mode_A -widget comboBox] 
  ipgui::add_indent $IPINST -parent  $Page4
  set Enable_A [ipgui::add_param $IPINST -parent $Page4 -name Enable_A -widget comboBox]
	
  ipgui::add_row $IPINST -parent $Page4 
  set Port_A_Registers [ ipgui::add_group  $IPINST  -parent  $Page4  -name "Port_A_Registers" -layout horizontal]
  set_property display_name "Port A Optional Output Registers" $Port_A_Registers
  set Register_PortA_Output_of_Memory_Primitives [	ipgui::add_param  $IPINST  -parent  $Port_A_Registers  -name Register_PortA_Output_of_Memory_Primitives]
  set Register_PortA_Output_of_Memory_Core [	ipgui::add_param  $IPINST  -parent  $Port_A_Registers  -name Register_PortA_Output_of_Memory_Core]
  ipgui::add_row $IPINST -parent $Port_A_Registers
  set register_porta_input_of_softecc [ipgui::add_param  $IPINST  -parent  $Port_A_Registers  -name register_porta_input_of_softecc]
  set Use_REGCEA_Pin [	ipgui::add_param  $IPINST  -parent  $Port_A_Registers  -name Use_REGCEA_Pin]
  ipgui::add_row $IPINST -parent $Port_A_Registers
  set READ_LATENCY_A [	ipgui::add_param  $IPINST  -parent  $Port_A_Registers  -name READ_LATENCY_A]
  #set_property visible false $READ_LATENCY_A
	
  ipgui::add_row $IPINST -parent $Page4 
  set Output_Reset_A [	ipgui::add_group  $IPINST  -parent  $Page4  -name "Output_Reset_A" -layout horizontal]
  set_property display_name "Port A Output Reset Options" $Output_Reset_A
  set Use_RSTA_Pin [	ipgui::add_param  $IPINST  -parent  $Output_Reset_A  -name Use_RSTA_Pin]
  ipgui::add_indent $IPINST -parent  $Output_Reset_A
  set Output_Reset_Value_A [	ipgui::add_param  $IPINST  -parent  $Output_Reset_A  -name Output_Reset_Value_A]
  ipgui::add_row $IPINST -parent $Output_Reset_A
  set Reset_Memory_Latch_A [	ipgui::add_param  $IPINST  -parent  $Output_Reset_A  -name Reset_Memory_Latch_A]
  ipgui::add_indent $IPINST -parent  $Output_Reset_A
  set priorityAPanel [ipgui::add_panel $IPINST -name priorityAPanel -parent $Output_Reset_A]
  set Reset_Priority_A [	ipgui::add_param  $IPINST  -parent  $priorityAPanel  -name Reset_Priority_A -widget comboBox]
  ipgui::add_row $IPINST -parent $Output_Reset_A
  set Duration_of_Reset_Assertion_A [	ipgui::add_dynamic_text $IPINST -name Duration_of_Reset_Assertion_A -parent  $Output_Reset_A  -tclproc "Duration_of_Reset_Assertion_A_updated" ]
  ipgui::add_row $IPINST -parent $Page4
   set READ_Address_Change_A [ ipgui::add_group  $IPINST  -parent  $Page4  -name "READ_Address_Change_A" -layout horizontal]
  set RD_ADDR_CHNG_A   [ ipgui::add_param $IPINST  -parent  $READ_Address_Change_A  -name RD_ADDR_CHNG_A  -widget checkbox ]
  set_property display_name "Read Address Change A" $RD_ADDR_CHNG_A
  set Page5 [	ipgui::add_page $IPINST   -name "Page5"] 
  set_property display_name "Port B Options" $Page5
  set topPanel  [ipgui::add_panel $IPINST -name topPanel -parent $Page5 -layout horizontal]
  set Memory_Size_B [	ipgui::add_group  $IPINST  -parent  $topPanel  -name "Memory_Size_B" -layout horizontal]
  set_property display_name "Memory Size" $Memory_Size_B
  set Write_Width_B_Meta [	ipgui::add_dynamic_text $IPINST -name "Write_Width_B_Meta" -parent  $Memory_Size_B  -tclproc "Write_Width_B_Meta_updated" ]
  set Write_Width_B [	ipgui::add_param  $IPINST  -parent  $Memory_Size_B  -name Write_Width_B -show_label false -widget comboBox]
  ipgui::add_row -parent $Memory_Size_B  $IPINST
  set Read_Width_B_Meta [	ipgui::add_dynamic_text $IPINST -name "Read_Width_B_Meta" -parent  $Memory_Size_B  -tclproc "Read_Width_B_Meta_updated" ]
  set Read_Width_B [	ipgui::add_param  $IPINST  -parent  $Memory_Size_B  -name Read_Width_B -widget comboBox -show_label false]
  ipgui::add_row -parent $Memory_Size_B  $IPINST
  ipgui::add_row -parent $Memory_Size_B  $IPINST
  set panel_B [ipgui::add_panel $IPINST -parent $Memory_Size_B -name panel_B ]  
  set Write_Depth_B [	ipgui::add_dynamic_text $IPINST -name Write_Depth_B -parent  $panel_B  -tclproc "Write_Depth_B_updated" ]
  set Read_Depth_B [	ipgui::add_dynamic_text $IPINST -name Read_Depth_B -parent  $panel_B  -tclproc "Read_Depth_B_updated" ]
  set portB_Description [ipgui::add_dynamic_text $IPINST -name portB_Description -parent $panel_B -tclproc portB_Description_updated ]
  
  ipgui::add_row -parent $topPanel  $IPINST
  set Operating_Mode_B [	ipgui::add_param  $IPINST  -parent  $topPanel  -name Operating_Mode_B -widget comboBox]
  ipgui::add_indent $IPINST -parent  $topPanel
  set Enable_B [	ipgui::add_param  $IPINST  -parent  $topPanel  -name Enable_B -widget comboBox]
  ipgui::add_row $IPINST -parent $topPanel
  
  set Port_B_Registers [	ipgui::add_group  $IPINST  -parent  $topPanel  -name "Port_B_Registers" -layout horizontal]
  set_property display_name "Port B Optional Output Registers" $Port_B_Registers
  set Register_PortB_Output_of_Memory_Primitives [	ipgui::add_param  $IPINST  -parent  $Port_B_Registers  -name Register_PortB_Output_of_Memory_Primitives]
  set Register_PortB_Output_of_Memory_Core [	ipgui::add_param  $IPINST  -parent  $Port_B_Registers  -name Register_PortB_Output_of_Memory_Core]
  ipgui::add_row $IPINST -parent $Port_B_Registers
  set register_portb_output_of_softecc [ipgui::add_param  $IPINST  -parent  $Port_B_Registers  -name register_portb_output_of_softecc]
  set Use_REGCEB_Pin [	ipgui::add_param  $IPINST  -parent  $Port_B_Registers  -name Use_REGCEB_Pin]
  set EN_ECC_PIPE [ipgui::add_param $IPINST -parent $Port_B_Registers -name EN_ECC_PIPE]
  set_property display_name "Enable ECC PIPE" $EN_ECC_PIPE
  if { (${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") } {
	set_property visible true $EN_ECC_PIPE
  } else {
	set_property visible false $EN_ECC_PIPE
  }
  ipgui::add_row $IPINST -parent $Port_B_Registers
  set READ_LATENCY_B [	ipgui::add_param  $IPINST  -parent  $Port_B_Registers  -name READ_LATENCY_B]
  #set_property visible false $READ_LATENCY_B
  ipgui::add_row $IPINST -parent $topPanel

  set Output_Reset_B [	ipgui::add_group  $IPINST  -parent  $topPanel  -name "Output_Reset_B" -layout horizontal]
  set_property display_name "Port B Output Reset Options" $Output_Reset_B
  set Use_RSTB_Pin [	ipgui::add_param  $IPINST  -parent  $Output_Reset_B  -name Use_RSTB_Pin]
  ipgui::add_indent $IPINST -parent  $Output_Reset_B
  set Output_Reset_Value_B [	ipgui::add_param  $IPINST  -parent  $Output_Reset_B  -name Output_Reset_Value_B]
  ipgui::add_row $IPINST -parent $Output_Reset_B
  set Reset_Memory_Latch_B [	ipgui::add_param  $IPINST  -parent  $Output_Reset_B  -name Reset_Memory_Latch_B]
  ipgui::add_indent $IPINST -parent  $Output_Reset_B
  set priorityBPanel [ipgui::add_panel $IPINST -name priorityBPanel -parent $Output_Reset_B]
  set Reset_Priority_B [	ipgui::add_param  $IPINST  -parent  $priorityBPanel  -name Reset_Priority_B -widget comboBox]
  ipgui::add_row $IPINST -parent $Output_Reset_B
  set Duration_of_Reset_Assertion_B [	ipgui::add_dynamic_text $IPINST -name Duration_of_Reset_Assertion_B -parent  $Output_Reset_B  -tclproc "Duration_of_Reset_Assertion_B_updated" ]
  ipgui::add_row $IPINST -parent $Output_Reset_B
  set Reset_Type [	ipgui::add_param  $IPINST  -parent  $Output_Reset_B  -name Reset_Type]

  set Latency_PortA [	ipgui::add_dynamic_text $IPINST -name Latency_PortA -parent  $topPanel  -tclproc "Latency_PortA_updated" ]
  set Latency_PortB [	ipgui::add_dynamic_text $IPINST -name Latency_PortB -parent  $topPanel  -tclproc "Latency_PortB_updated" ]
  set_property visible false $Latency_PortA	
  set_property visible false $Latency_PortB	
   ipgui::add_row   $IPINST -parent $Page5
   set READ_Address_Change_B [ ipgui::add_group  $IPINST  -parent  $Page5  -name "READ_Address_Change_B" -layout horizontal]
  set RD_ADDR_CHNG_B  [ ipgui::add_param $IPINST  -parent  $READ_Address_Change_B  -name RD_ADDR_CHNG_B  -widget checkbox  ]
  set_property display_name "Read Address Change B" $RD_ADDR_CHNG_B
  ### Page other options ####
  set PageOtherOptions [ipgui::add_page $IPINST -name PageOtherOptions]
  set_property display_name "Other Options" $PageOtherOptions
  set Optional_Output_Registers_Panel [	ipgui::add_panel  $IPINST  -parent  $PageOtherOptions  -name "Optional_Output_Registers_Panel" -layout horizontal]
  set Pipeline_Stages [	ipgui::add_param  $IPINST  -parent  $Optional_Output_Registers_Panel  -name Pipeline_Stages -widget comboBox]
  set Pipeline_StagesDesc [	ipgui::add_dynamic_text $IPINST -name Pipeline_StagesDesc -parent  $Optional_Output_Registers_Panel  -tclproc "Pipeline_StagesDesc_updated" ]
  set Memory_InitializationGroup [	ipgui::add_group  $IPINST  -parent  $PageOtherOptions  -name "Memory_InitializationGroup" ]
  set_property display_name "Memory Initialization" $Memory_InitializationGroup
  set innerPanel1 [ipgui::add_panel $IPINST -parent $Memory_InitializationGroup -name innerPanel1 -layout horizontal]
  set Load_Init_File [	ipgui::add_param  $IPINST  -parent  $innerPanel1  -name Load_Init_File]
  ipgui::add_row $IPINST -parent $innerPanel1
  set innerPanel2 [ipgui::add_panel $IPINST -parent $innerPanel1 -name innerPanel2 -layout horizontal]
  set Coe_File [	ipgui::add_param  $IPINST  -parent  $innerPanel2  -name Coe_File -widget "fileOpenDialog"]
  set_property key_list "memory_initialization_radix,memory_initialization_vector" $Coe_File
  ipgui::add_row $IPINST -parent $innerPanel1
  set innerPanel3 [ipgui::add_panel $IPINST -parent $innerPanel1 -name innerPanel3 ]
  set MEM_FILE [	ipgui::add_param  $IPINST  -parent  $innerPanel3  -name MEM_FILE -widget "fileOpenDialog"]
  set_property display_name "Mem File"  $MEM_FILE
  set_property visible false $MEM_FILE
  ipgui::add_row $IPINST -parent $innerPanel1
  
  set Fill_Remaining_Memory_Locations [	ipgui::add_param  $IPINST  -parent  $Memory_InitializationGroup  -name Fill_Remaining_Memory_Locations]
  set Remaining_Memory_Locations [	ipgui::add_param  $IPINST  -parent  $Memory_InitializationGroup  -name Remaining_Memory_Locations]

  set Collision_Warnings_options [	ipgui::add_group  $IPINST  -parent  $PageOtherOptions  -name "Collision_Warnings_options" -layout vertical]
  set_property display_name "Structural/UniSim Simulation Model Options" $Collision_Warnings_options
  set LabelCollision_WarningsDescription [	ipgui::add_static_text  $IPINST -name LabelCollision_WarningsDescription -parent  $Collision_Warnings_options  -text "Defines the type of warnings and outputs are generated when a \nread-write or write-write collision occurs." ]
  set Collision_Warnings [	ipgui::add_param  $IPINST  -parent  $Collision_Warnings_options  -name Collision_Warnings -widget comboBox]
	
  set Behavioral_Simulation_Model_Options [	ipgui::add_group  $IPINST  -parent  $PageOtherOptions  -name "Behavioral_Simulation_Model_Options" -layout horizontal]
  set_property display_name "Behavioral Simulation Model Options" $Behavioral_Simulation_Model_Options
  set Disable_Collision_Warnings [	ipgui::add_param  $IPINST  -parent  $Behavioral_Simulation_Model_Options  -name Disable_Collision_Warnings]
  set Disable_Out_of_Range_Warnings [	ipgui::add_param  $IPINST  -parent  $Behavioral_Simulation_Model_Options  -name Disable_Out_of_Range_Warnings]
  
  set Dynamic_Power_Saving [	ipgui::add_group  $IPINST  -parent  $PageOtherOptions  -name "Dynamic_Power_Saving" -layout horizontal]
  set EN_SLEEP_PIN [ipgui::add_param $IPINST -parent $Dynamic_Power_Saving -name EN_SLEEP_PIN]
  set_property display_name "Sleep" $EN_SLEEP_PIN
   set EN_DEEPSLEEP_PIN [ipgui::add_param $IPINST -parent $Dynamic_Power_Saving -name EN_DEEPSLEEP_PIN]
    set_property display_name "Deep Sleep" $EN_DEEPSLEEP_PIN
   set EN_SHUTDOWN_PIN [ipgui::add_param $IPINST -parent $Dynamic_Power_Saving -name EN_SHUTDOWN_PIN]
    set_property display_name " Shutdown " $EN_SHUTDOWN_PIN
  if { (${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus"  || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") } {
	set_property visible true $Dynamic_Power_Saving
  } else {
	set_property visible false $Dynamic_Power_Saving
  }

	if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] } { 
      set_property visible false $EN_DEEPSLEEP_PIN
      set_property visible false $EN_SHUTDOWN_PIN	
	} else {
      set_property visible false $EN_DEEPSLEEP_PIN
      set_property visible false $EN_SHUTDOWN_PIN
	}

  set safety_circuit [	ipgui::add_group  $IPINST  -parent  $PageOtherOptions  -name "Safety_logic_to_minimize_BRAM_data_corruption" -layout horizontal]
  set EN_SAFETY_CKT [ipgui::add_param $IPINST -parent $safety_circuit -name EN_SAFETY_CKT]
  set_property display_name "Enable Safety Circuit" $EN_SAFETY_CKT

#	if {($Use_RSTA_Pin) || ($Use_RSTB_Pin)} { 
#      set_property visible true $safety_circuit
#	} else {
#      set_property visible false $safety_circuit
#	}

	### Page 7 ###
  set Page7 [	ipgui::add_page $IPINST   -name "Page 7" -layout vertical]
  set_property display_name "Summary" $Page7
  set Information_Group [	ipgui::add_group  $IPINST  -parent  $Page7  -name "Information_Group" -layout vertical]
  set_property display_name "Information" $Information_Group
  set LabelMemory_TypeDescription [	ipgui::add_dynamic_text $IPINST -name LabelMemory_TypeDescription -parent  $Information_Group  -tclproc "LabelMemory_TypeDescription_updated" ]
  set BlockRAM_Blocks_Used_18 [	ipgui::add_dynamic_text $IPINST -name BlockRAM_Blocks_Used_18 -parent  $Information_Group  -tclproc "BlockRAM_Blocks_Used_18_updated" ]
  set BlockRAM_Blocks_Used_36 [	ipgui::add_dynamic_text $IPINST -name BlockRAM_Blocks_Used_36 -parent  $Information_Group  -tclproc "BlockRAM_Blocks_Used_36_updated" ]
  #set URAM_Blocks_Used  [	ipgui::add_dynamic_text $IPINST -name URAM_Blocks_Used  -parent  $Information_Group  -tclproc "URAM_Blocks_Used_updated" ]
  # if {[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} {
    # set_property visible true $BlockRAM_Blocks_Used_36 
  # } else {
    # set_property visible false $BlockRAM_Blocks_Used_36 
  # }
    set_property visible true $BlockRAM_Blocks_Used_36 

  set BlockRAM_Power [	ipgui::add_dynamic_text $IPINST -name BlockRAM_Power -parent  $Information_Group  -tclproc "BlockRAM_Power_updated" ]
  set total_latency_portA [	ipgui::add_dynamic_text $IPINST -name total_latency_portA -parent  $Information_Group  -tclproc "total_latency_portA_updated" ]
  set total_latency_portB [	ipgui::add_dynamic_text $IPINST -name total_latency_portB -parent  $Information_Group  -tclproc "total_latency_portB_updated" ]
  set Address_Width_A [	ipgui::add_dynamic_text $IPINST -name Address_Width_A -parent  $Information_Group  -tclproc "Address_Width_A_updated" ]
  set Address_Width_B [	ipgui::add_dynamic_text $IPINST -name Address_Width_B -parent  $Information_Group  -tclproc "Address_Width_B_updated" ]
  set InformationLabel [ipgui::add_static_text  $IPINST -name InformationLabel -parent  $Information_Group  -text "The Block Memory Generator core is not backward compatible to the Single Port and\nDual Port Block Memory cores. Please see datasheet for more information." ]
  set_property visible false $InformationLabel
	### LHS Tab ###

  set Power_Estimation [	ipgui::add_page  $IPINST  -left  -name Power_Estimation -layout vertical]
  set_property display_name "Power Estimation" $Power_Estimation
  
  set Additional_Inputs_for_Power_Estimation [	ipgui::add_param  $IPINST  -parent  $Power_Estimation  -name Additional_Inputs_for_Power_Estimation]
  ipgui::add_row $IPINST -parent $Power_Estimation
  
  set LHSlabel [	ipgui::add_static_text  $IPINST -name LHSlabel -parent  $Power_Estimation  -text "Provides a rough estimate of power consumption for\nthe core based on read width, write width, clock rate,\nwrite rate and enabled rate of each port.The power\nconsumption calculation assumes a toggle rate of 50%.\nMore accurate estimates may be obtained on the\nrouted design using Vivado Report Power" ]
  ipgui::add_row $IPINST -parent $Power_Estimation
  set PortA_Group [	ipgui::add_group  $IPINST  -parent  $Power_Estimation  -name "PortA_Group" -layout vertical]
  set PortB_Group [	ipgui::add_group  $IPINST  -parent  $Power_Estimation  -name "PortB_Group" -layout vertical]
	
  set Port_A_Clock [	ipgui::add_param  $IPINST  -parent  $PortA_Group  -name Port_A_Clock ]
  set Port_A_Write_Rate [	ipgui::add_param  $IPINST  -parent  $PortA_Group  -name Port_A_Write_Rate ]
  set Port_A_Enable_Rate [	ipgui::add_param  $IPINST  -parent  $PortA_Group  -name Port_A_Enable_Rate ]
	
  set Port_B_Clock [	ipgui::add_param  $IPINST  -parent  $PortB_Group  -name Port_B_Clock ]
  set Port_B_Write_Rate [	ipgui::add_param  $IPINST  -parent  $PortB_Group  -name Port_B_Write_Rate ]
  set Port_B_Enable_Rate [	ipgui::add_param  $IPINST  -parent  $PortB_Group  -name Port_B_Enable_Rate ]
  #set_property visible false $Power_Estimation
  ##################################################################################	
  set Estimated_Power_for_IP [	ipgui::add_dynamic_text  $IPINST -name Estimated_Power_for_IP -parent  $Power_Estimation  -tclproc "Estimated_Power_for_IP_updated" ]
  
  # set_property visible [expr {([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}])? true:false }] $Use_Error_Injection_Pins
  # set_property visible [expr {([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}])? true:false }]  $Error_Injection_Type  
  set_property visible true $Use_Error_Injection_Pins
  set_property visible true  $Error_Injection_Type  

  set_property visible false $ECC 
  set_property visible false $softecc 
  set_property visible  false  [ipgui::get_textspec  BlockRAM_Power -of $IPINST]
	
  # if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
    # set_property visible  true  [ipgui::get_textspec  BlockRAM_Blocks_Used_36 -of $IPINST]
  # } else {
    # set_property visible  false  [ipgui::get_textspec  BlockRAM_Blocks_Used_36 -of $IPINST]
  # }
    set_property visible  true  [ipgui::get_textspec  BlockRAM_Blocks_Used_36 -of $IPINST]
  
	if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
		set_property visible false  $Interface_Type
		set_property visible true  $use_bram_block
	} else {
		set_property visible true  $Interface_Type
		set_property visible false  $use_bram_block
	}

#### Tool Tips ####
set_property tooltip  "Indicates the component name of the generated Block Memory core."  $Component_Name 
set_property tooltip  "Specifies the location of the COE file."  $Coe_File 
set_property tooltip  "Defines which read and write ports are generated. Memory type<br> dictates the options available in the following GUI pages.<br>The core will tie off any unused ports and signals."  $Memory_Type
set_property tooltip  "Select the primitive type to implement the memory structure"  $PRIM_type
set_property tooltip "The Simple Dual Port RAM memory type supports the ECC capability.<br>\
                                                          The ECC memory automatically detects single- and double-bit errors,<br>\
                                                          and is able to auto-correct the single-bit errors." $ECC 
set_property tooltip  "This option enables byte-writes, which update the memory contents on <br>\
                                                          a byte-to-byte basis. If this option is chosen, the write widths are <br>\
                                                          limited to 8-bit or 9-bit multiples depending on the byte size, and <br>\
                                                          generates a write enabled bus with a bit for each byte." $Use_Byte_Write_Enable 
set_property tooltip  "Defines the Byte Size"  $Byte_Size 
set_property tooltip  "Defines the type of primitive that will be used to generate the memory when\n using the Fixed Primitives Algorithm. This option may be limited by<br> the device architecture.The chosen primitive may limit the aspect ratios<br> between A and B port and between read and write ports."  $Primitive 
set_property tooltip  "Defines the Port A read width (DOUTA). This width can <br> \
                                                        be a ratio of the Port A write width. See the datasheet for supported aspect ratios." $Read_Width_A 
set_property tooltip  "Defines whether the configured memory has an enabled pin (ENA).<br>If there is no enable pin, the A port is always enabled."  $Enable_A 
set_property tooltip  "Defines the power-on value for the core and the reset<br>value if a set/reset pin (RSTA) is used."  $Output_Reset_Value_A 
set_property tooltip  "Defines the Port B write width (DINB). This width may be\na ratio from the port A write width. See the datasheet for supported aspect ratios."  $Write_Width_B 
set_property tooltip  "Defines the Port B read width (DOUTB). This width can <br> \
                                                          be a ratio of the Port A write width. See the datasheet for supported aspect ratios." $Read_Width_B 
set_property tooltip  "Defines whether the configured memory has an enabled pin (ENB).<br>If there is no enable pin, the B port is always enabled."  $Enable_B 
set_property tooltip  "Defines the power-on value for the core and the reset\nvalue if a set/reset pin (RSTB) is used."  $Output_Reset_Value_B 
set_property tooltip "Adds register stage at primitive output of port A. \
                                                          This enables the embedded output registers in the block RAM primitives. (See the data sheet for more information.)" $Register_PortA_Output_of_Memory_Primitives 
set_property tooltip  "Adds a register stage at core output of port A.<br>This register is implemented in FPGA fabric."  $Register_PortA_Output_of_Memory_Core 
set_property tooltip "Adds register stage at primitive output of port B. \
                                                          This enables the embedded output registers in the block RAM primitives. (See the data sheet for more information.)" $Register_PortB_Output_of_Memory_Primitives 
set_property tooltip  "Adds a register stage at core output of port B.<br>This register is implemented in FPGA fabric."  $Register_PortB_Output_of_Memory_Core 
set_property tooltip  "Disable warning messages in the case of<br>read-write and write-write collisions."  $Disable_Collision_Warnings 
set_property tooltip  "Disable warning messages regarding access to a memory<br>location (address) outside the defined memory depth."  $Disable_Out_of_Range_Warnings 
#set_property tooltip  "If CLKA and CLKB are synchronous, the behavioral model can<br> optimize its read-write and write-write collision detection.Must not be set if clocks are asynchronous"  $Assume_Synchronous_Clk
set_property tooltip  "Select the Common Clock option when the clock (CLKA and CLKB) inputs are driven by the same clock buffer"  $Assume_Synchronous_Clk
set_property tooltip  "Defines the number of Pipeline Stages embedded in muxes"  $Pipeline_Stages 
set_property tooltip  "Specifies if a memory initialization file is to be used or not <br>(See the data sheet for more information.)."  $Load_Init_File 
set_property tooltip "Determines the priority between CE and SR. " $Reset_Priority_A 
set_property tooltip "Determines the priority between CE and SR. " $Reset_Priority_B 
set_property tooltip "In the absence of output registers, the RSTA input always resets the memory latch.<br> \
                                                         If a primitive output register is used, (and core output register is not used) then <br> \
                                                         choosing this option causes the RSTA input to reset both the primitive register and<br> \
                                                         the memory latch." $Reset_Memory_Latch_A 
set_property tooltip "In the absence of output registers, the RSTB input always resets the memory latch.<br> \
                                                         If a primitive output register is used, (and core output register is not used) then <br> \
                                                         choosing this option causes the RSTB input to reset both the primitive register and<br> \
                                                         the memory latch." $Reset_Memory_Latch_B 
set_property tooltip "Defines whether the configured memory has a register enabled pin (REGCEA). If there is<br> \
                                                         no register enabled pin, the output register is enabled using the enable signal itself." $Use_REGCEA_Pin 
set_property tooltip "Defines whether the configured memory has a register enabled pin (REGCEB). If there is<br> \
                                                         no register enabled pin, the output register is enabled using the enable signal itself." $Use_REGCEB_Pin 
set_property tooltip "Defines whether the configured memory has a set-reset pin (RSTA). If there is no <br>\
                                                         set-reset pin, then the internal reset pins of the primitives are always tied to '0'." $Use_RSTA_Pin 
set_property tooltip "Defines whether the configured memory has a set-reset pin (RSTB). If there is no <br>\
                                                         set-reset pin, then the internal reset pins of the primitives are always tied to '0'." $Use_RSTB_Pin 


set_property tooltip  "Check this box to enter additional inputs for power estimation."  $Additional_Inputs_for_Power_Estimation 
set_property tooltip  "Operating frequency of the port"  $Port_A_Clock 
set_property tooltip  "Indicates the average rate of write operations."  $Port_A_Write_Rate 
set_property tooltip  "Operating frequency of the port"  $Port_B_Clock 
set_property tooltip  "Indicates the average rate of write operations."  $Port_B_Write_Rate 
set_property tooltip  "Indicates the average rate of port A Enable operations."  $Port_A_Enable_Rate 
set_property tooltip  "Indicates the average rate of port B Enable operations."  $Port_B_Enable_Rate 
set_property tooltip  "ALL,WARNING_ONLY,GENERATE_X_ONLY - Collision detection feature will be enabled in the models to handle collision under any condition<br> \
					   NONE - Collision detection feature will be disabled in the models and the behavior during collisions is<br>
					   left to the simulator to handle. The NONE option is intended for design with clocks never in phase.<br>
					   The output will be unpredictable if the clocks are in phase or from the same clock source or within<br>
					   3000 ps in skew and the addresses are the same for both ports"  $Collision_Warnings 
					   
set_property tooltip "Select to Generate BMG with Native interface or with AXI4 interface" $Interface_Type 
set_property tooltip "Adds register stage at the input ports of the design when Soft ECC is enabled" $register_porta_input_of_softecc 
set_property tooltip "Adds register stage at the output ports of the design when Soft ECC is enabled" $register_portb_output_of_softecc 
set_property tooltip "WRITE_FIRST: This mode is recommended when asynchronous clocks might cause simultaneous read/write operations on the same port address <br> \
                      NO_CHANGE : This mode ensures Lowest power however does not guarantee no collisions when both ports access same address at the same clock cycle <br> \
                      READ_FIRST:  This mode guarantees no collisions (read will access prior memory contents safely) at the cost of higher BRAM power" $Operating_Mode_A
set_property tooltip "WRITE_FIRST: This mode is recommended when asynchronous clocks might cause simultaneous read/write operations on the same port address <br> \
                      NO_CHANGE : This mode ensures Lowest power however does not guarantee no collisions when both ports access same address at the same clock cycle <br> \
                      READ_FIRST:  This mode guarantees no collisions (read will access prior memory contents safely) at the cost of higher BRAM power" $Operating_Mode_B

set_property tooltip "Select the Algorithm used to implement the memory" $Algorithm
set_property tooltip "Supports the generation of AWID/BID/ARID/RID singals when enabled" $AXI_ID_Width
set_property tooltip "Defines the PortA write width(DINA)" $Write_Width_A
set_property tooltip "BRAM Controller Mode : All the parameters except the `Memory Type` are greyed out as they will be propagated from the Master. Select this mode if Block Memory Generator(BMG) needs to be connected to either AXI BRAM Controller or LMB Controller IPs only. <br> \                          
                      Stand Alone Mode     : In this mode All the parameters are available for the user selection, but the parameters cannot be propagated from Master IP to BMG" $use_bram_block

set_property display_name "Component Name" $Component_Name  
	set_property display_name "Interface Type" $Interface_Type  
	set_property display_name "AXI Type" $AXI_Type  
	set_property display_name "AXI Slave Type" $AXI_Slave_Type  
	set_property display_name "AXI ID" $Use_AXI_ID  
	set_property display_name "AXI ID Width" $AXI_ID_Width  
	set_property display_name "Memory Type" $Memory_Type  
	set_property display_name "Generate address interface with 32 bits" $Enable_32bit_Address  
	set_property display_name "ECC Type" $ecctype  
	set_property display_name "ECC" $ECC  
	set_property display_name "softecc" $softecc  
	set_property display_name "Error Injection Pins" $Use_Error_Injection_Pins  
	set_property display_name "Error Injection Type" $Error_Injection_Type  
	set_property display_name "Byte Write Enable" $Use_Byte_Write_Enable  
	set_property display_name "Byte Size (bits)" $Byte_Size  
	set_property display_name "Algorithm" $Algorithm  
	set_property display_name "Primitive" $Primitive  
	set_property display_name "Common Clock" $Assume_Synchronous_Clk  
	set_property display_name "Defines the PortA Write Width(DINA)" $Write_Width_A  
	set_property display_name "Write Depth" $Write_Depth_A  
	set_property display_name "Read Width" $Read_Width_A  
	set_property display_name "Operating Mode" $Operating_Mode_A  
	set_property display_name "Enable Port Type" $Enable_A  
	set_property display_name "Write Width" $Write_Width_B  
	set_property display_name "Read Width" $Read_Width_B  
	set_property display_name "Operating Mode" $Operating_Mode_B  
	set_property display_name "Enable Port Type" $Enable_B  
	set_property display_name "Primitives Output Register" $Register_PortA_Output_of_Memory_Primitives  
	set_property display_name "Core Output Register" $Register_PortA_Output_of_Memory_Core  
	set_property display_name "REGCEA Pin" $Use_REGCEA_Pin  
	set_property display_name "Port A Read Latency" $READ_LATENCY_A  
	set_property display_name "Primitives Output Register" $Register_PortB_Output_of_Memory_Primitives  
	set_property display_name "Core Output Register" $Register_PortB_Output_of_Memory_Core  
	set_property display_name "REGCEB Pin" $Use_REGCEB_Pin  
	set_property display_name "Port B Read Latency" $READ_LATENCY_B  
	set_property display_name "SoftECC Input Register" $register_porta_input_of_softecc  
	set_property display_name "SoftECC Output Register" $register_portb_output_of_softecc  
	set_property display_name "Pipeline Stages within Mux" $Pipeline_Stages  
	set_property display_name "Load Init File" $Load_Init_File  
	set_property display_name "Coe File" $Coe_File  
	set_property display_name "Fill Remaining Memory Locations" $Fill_Remaining_Memory_Locations  
	set_property display_name "Remaining Memory Locations (Hex)" $Remaining_Memory_Locations  
	set_property display_name "RSTA Pin (set/reset pin)" $Use_RSTA_Pin  
	set_property display_name "Reset Memory Latch" $Reset_Memory_Latch_A  
	set_property display_name "Reset Priority" $Reset_Priority_A  
	set_property display_name "Output Reset Value (Hex)" $Output_Reset_Value_A  
	set_property display_name "RSTB Pin (set/reset pin)" $Use_RSTB_Pin  
	set_property display_name "Reset Memory Latch" $Reset_Memory_Latch_B  
	set_property display_name "Reset Priority" $Reset_Priority_B  
	set_property display_name "Output Reset Value (Hex)" $Output_Reset_Value_B  
	set_property display_name "Reset Type" $Reset_Type  
	set_property display_name "Additional Inputs for Power Estimation" $Additional_Inputs_for_Power_Estimation  
	set_property display_name "Port A Clock" $Port_A_Clock  
	set_property display_name "Port A Write Rate" $Port_A_Write_Rate  
	set_property display_name "Port B Clock" $Port_B_Clock  
	set_property display_name "Port B Write Rate" $Port_B_Write_Rate  
	set_property display_name "Port A Enable Rate" $Port_A_Enable_Rate  
	set_property display_name "Port B Enable Rate" $Port_B_Enable_Rate  
	set_property display_name "Collision Warnings" $Collision_Warnings  
	set_property display_name "Disable Collision Warnings" $Disable_Collision_Warnings  
	set_property display_name "Disable Out of Range Warnings" $Disable_Out_of_Range_Warnings  
	set_property display_name "ID Width" $Use_AXI_ID  								 
}
proc init_params {PARAM_VALUE.PRIM_type_to_Implement PROJECT_PARAM.ARCHITECTURE} {
  set PRIM_type ${PARAM_VALUE.PRIM_type_to_Implement}
  set uram_count [xit::get_device_data D_URAM_COUNT -of [xit::current_scope]]
  if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] && $uram_count != 0} { 
    set_property enabled true   $PRIM_type 
    set_property range "BRAM,URAM" $PRIM_type  
  } else {
    set_property value "BRAM"   $PRIM_type
    set_property enabled false  $PRIM_type 
  } 
}
proc init_xpg_bd { IPINST } {
  set param_list {}
  lappend param_list "PARAM_VALUE.INTERFACE_TYPE"
  lappend param_list "PARAM_VALUE.USE_BRAM_BLOCK"
  ipgui::update_params -params_list $param_list $IPINST 
}

proc update_PARAM_VALUE.READ_LATENCY_A { PARAM_VALUE.READ_LATENCY_A PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  if { $ramtype == "BRAM" } {
     set_property enabled false ${PARAM_VALUE.READ_LATENCY_A}   
  } else {
     #if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
     #    set_property enabled false ${PARAM_VALUE.READ_LATENCY_A}   
     #} else {
         set_property enabled true  ${PARAM_VALUE.READ_LATENCY_A}   
     #}
  }
}

proc update_PARAM_VALUE.READ_LATENCY_B { PARAM_VALUE.READ_LATENCY_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  if { $ramtype == "BRAM" } {
     set_property enabled false ${PARAM_VALUE.READ_LATENCY_B}   
  } else {
     #if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
     #    set_property enabled false ${PARAM_VALUE.READ_LATENCY_B}   
     #} else {
         set_property enabled true  ${PARAM_VALUE.READ_LATENCY_B}   
     #}
  }
}



proc update_MODELPARAM_VALUE.C_READ_LATENCY_A { MODELPARAM_VALUE.C_READ_LATENCY_A PARAM_VALUE.READ_LATENCY_A PROJECT_PARAM.ARCHITECTURE} {
    set rd_lat_a [get_property value ${PARAM_VALUE.READ_LATENCY_A} ]
	set_property value "$rd_lat_a"   ${MODELPARAM_VALUE.C_READ_LATENCY_A}   
}

proc update_MODELPARAM_VALUE.C_READ_LATENCY_B { MODELPARAM_VALUE.C_READ_LATENCY_B PARAM_VALUE.READ_LATENCY_B PROJECT_PARAM.ARCHITECTURE} {
	set_property value "[get_property value ${PARAM_VALUE.READ_LATENCY_B} ]"   ${MODELPARAM_VALUE.C_READ_LATENCY_B}   
}




proc update_PARAM_VALUE.INTERFACE_TYPE {PARAM_VALUE.INTERFACE_TYPE IPINST } {
	if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
		set_property range_value Native,Native  ${PARAM_VALUE.INTERFACE_TYPE} 
	}
}

proc update_PARAM_VALUE.USE_BRAM_BLOCK {PARAM_VALUE.USE_BRAM_BLOCK IPINST  } {
	if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
		set_property range_value "BRAM_Controller,BRAM_Controller,Stand_Alone"  ${PARAM_VALUE.USE_BRAM_BLOCK} 
	}
}

proc update_gui_for_PARAM_VALUE.ECC {PARAM_VALUE.ECC IPINST} {
	if { [ get_property value ${PARAM_VALUE.ECC}] } {
		set_property visible  false  [ipgui::get_groupspec  WriteEnableGroupBox -of $IPINST]
	} else {
		set_property visible  true  [ipgui::get_groupspec  WriteEnableGroupBox -of $IPINST]
	}
}
  
  
proc width_max { use_byte_write_enable byte_size } {

   if { $use_byte_write_enable && $byte_size == 8 } {
      return 4096
   } else {
      return 4608
   }
}

proc width_min { use_byte_write_enable byte_size Error_Injection_Type} {
   if { $use_byte_write_enable} {
      return $byte_size
   } elseif {$Error_Injection_Type == "Double_Bit_Error_Injection" || $Error_Injection_Type == "Single_and_Double_Bit_Error_Injection"} {
      return 2
   } else {
      return 1
   }
}

proc depth_max {} {

   # MAX_PRIMS * PRIM_DEPTH
   # 550 * 16k
   return 9011200
}

proc depth_min {} {
   return 2
}

proc min {a b {c ""}} {

   if {$c == ""} { set c $b}

   if {$a<=$b && $a<=$c} {return $a}
   if {$b<=$a && $b<=$c} {return $b}
   return $c
}

proc max {a b {c ""}} {

   if {$c == ""} { set c $b}

   if {$a>=$b && $a>=$c} {return $a}
   if {$b>=$a && $b>=$c} {return $b}
   return $c
}

proc update_gui_for_PARAM_VALUE.PRIM_type_to_Implement { PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.MEMORY_TYPE IPINST }  {
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  set Memory_InitializationGroup [ipgui::get_groupspec -name Memory_InitializationGroup -of $IPINST]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]

  if { $ramtype ne "BRAM" } {
     set_property visible  false  [ipgui::get_guiparamspec  EN_SHUTDOWN_PIN -of $IPINST]
     set_property visible  false  [ipgui::get_guiparamspec  EN_DEEPSLEEP_PIN -of $IPINST]
  # ECC Options should be made invisible
     set_property visible false [ipgui::get_groupspec  Algorithm_Options -of $IPINST]
  # Algorithm Options should be made invisible
  #   set_property visible false [ipgui::get_groupspec ECCOptionsGroupBox -of $IPINST]
  # Reset Options should be made invisible
     set_property visible false [ipgui::get_groupspec Output_Reset_A -of $IPINST]
     if { $Memory_Type_value != "Single_Port_RAM" && $Memory_Type_value != "Single_Port_ROM" } {
	   set_property visible false [ipgui::get_groupspec Output_Reset_B -of $IPINST]
       set_property visible false [ipgui::get_groupspec READ_Address_Change_B -of $IPINST]
     }
  # Read Address change options should be made invisible
     set_property visible false [ipgui::get_groupspec READ_Address_Change_A -of $IPINST]
  # Initializations tab should be made invisible
  #   set_property visible false $Memory_InitializationGroup
  # Collision warnings tab should be made invisible
     set_property visible false [ipgui::get_groupspec Collision_Warnings_options -of $IPINST]
     set_property visible false [ipgui::get_groupspec Behavioral_Simulation_Model_Options -of $IPINST]
  # safety logic should be made invisible
     #set_property visible false [ipgui::get_groupspec safety_circuit -of $IPINST]
  
     set_property visible  false  [ipgui::get_textspec BlockRAM_Blocks_Used_18   -of $IPINST]
     set_property visible  false  [ipgui::get_textspec BlockRAM_Blocks_Used_36   -of $IPINST]
     set_property visible  false  [ipgui::get_guiparamspec Additional_Inputs_for_Power_Estimation  -of $IPINST]
     if { $Memory_Type_value == "Simple_Dual_Port_RAM"} {
         set_property visible  false  [ipgui::get_guiparamspec  READ_LATENCY_A -of $IPINST]
     } else {
         set_property visible  true   [ipgui::get_guiparamspec  READ_LATENCY_A -of $IPINST]
     }
         set_property visible  true   [ipgui::get_guiparamspec  READ_LATENCY_B -of $IPINST]

  } else {
     set_property visible  false  [ipgui::get_guiparamspec  EN_SHUTDOWN_PIN -of $IPINST]
     set_property visible  false  [ipgui::get_guiparamspec  EN_DEEPSLEEP_PIN -of $IPINST]
     set_property visible true [ipgui::get_groupspec  Algorithm_Options -of $IPINST]
     set_property visible true [ipgui::get_groupspec ECCOptionsGroupBox -of $IPINST]
     set_property visible true [ipgui::get_groupspec Output_Reset_A -of $IPINST]
     if { $Memory_Type_value != "Single_Port_RAM" && $Memory_Type_value != "Single_Port_ROM"} {
	   set_property visible true [ipgui::get_groupspec Output_Reset_B -of $IPINST]
       set_property visible true [ipgui::get_groupspec READ_Address_Change_B -of $IPINST]
     }
     set_property visible true [ipgui::get_groupspec READ_Address_Change_A -of $IPINST]
     set_property visible true $Memory_InitializationGroup
     set_property visible true [ipgui::get_groupspec Collision_Warnings_options -of $IPINST]
     set_property visible true [ipgui::get_groupspec Behavioral_Simulation_Model_Options -of $IPINST]
     #set_property visible true [ipgui::get_groupspec safety_circuit -of $IPINST]
     set_property visible true  [ipgui::get_textspec BlockRAM_Blocks_Used_18   -of $IPINST]
     set_property visible true  [ipgui::get_textspec BlockRAM_Blocks_Used_36   -of $IPINST]
     set_property visible true  [ipgui::get_guiparamspec Additional_Inputs_for_Power_Estimation  -of $IPINST]
     set_property visible false  [ipgui::get_guiparamspec  READ_LATENCY_A -of $IPINST]
     set_property visible false  [ipgui::get_guiparamspec  READ_LATENCY_B -of $IPINST]
  }

} 

proc update_PARAM_VALUE.USE_AXI_ID {PARAM_VALUE.USE_AXI_ID PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE PARAM_VALUE.INTERFACE_TYPE } {

  set Use_AXI_ID_handle ${PARAM_VALUE.USE_AXI_ID}
 
  if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] ==  "AXI4" } {
    if { [ get_property value ${PARAM_VALUE.AXI_TYPE} ] ==  "AXI4_Full" && [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ] ==  "Memory_Slave" } {	
      set_property enabled false $Use_AXI_ID_handle
      set_property value true $Use_AXI_ID_handle
    } elseif { [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ] ==  "Peripheral_Slave" } {	 
      set_property enabled false $Use_AXI_ID_handle
      set_property value false $Use_AXI_ID_handle
    } else {
      set_property enabled true $Use_AXI_ID_handle
      set_property value false $Use_AXI_ID_handle
    }
  } else {
    set_property enabled false $Use_AXI_ID_handle
    set_property value false $Use_AXI_ID_handle
  } 
}

proc validate_PARAM_VALUE.COMPONENT_NAME { PARAM_VALUE.COMPONENT_NAME } {
   set errStr [ipgui::component_validate [ get_property value ${PARAM_VALUE.COMPONENT_NAME} ]]
   if  { $errStr == "" } { 
		return true 
	} else { 
		set_property errmsg $errStr ${PARAM_VALUE.COMPONENT_NAME}
		return false 
	}
}

proc cont_range_list {min max rel} {
 set min_multiplier [expr  $min/$rel]
 set max_multiplier [expr  $max/$rel]
 if {$min%$rel!=0} {
   incr $min_multiplier
 }

 if {$max%$rel!=0} {
   incr $max_multiplier -1
 }

 set diff [expr $max_multiplier -$min_multiplier]
 set start [expr $min_multiplier*$rel]
 set middle [expr $start+$rel]
 set end [expr $max_multiplier*$rel]
            
  if {$diff >3} {
   set ret_val "$start,$middle,..$end"
  } elseif {$diff >2} {
   set ret_val "$start,$middle,$end"
  } elseif {$diff >1} {
   set ret_val "$start,$middle"
  } else {
   set ret_val "$start"
  }

}

proc validate_PARAM_VALUE.WRITE_WIDTH_A { PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PRIM_type_to_Implement \
PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE IPINST PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  PARAM_VALUE.MEMORY_TYPE } {

  set Write_Width_A_handle ${PARAM_VALUE.WRITE_WIDTH_A}
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
 
	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI4"} {
		if {[ get_property value ${PARAM_VALUE.AXI_TYPE} ] == "AXI4_Full"} {
			if {[ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ] == "Memory_Slave"  } {
				if {$Write_Width_A_value != 32 && $Write_Width_A_value != 64 && $Write_Width_A_value != 128 && $Write_Width_A_value != 256} {
          set_property errmsg "Supported AXI Widths are 32,64,128 or 256" $Write_Width_A_handle
					return false
				}
			} else {
				if {$Write_Width_A_value != 8 && $Write_Width_A_value != 16 && $Write_Width_A_value != 32 && 
              $Write_Width_A_value != 64 && $Write_Width_A_value != 128 && $Write_Width_A_value != 256} {
          set_property errmsg "Supported AXI Widths are 8,16,32,64,128 or 256" $Write_Width_A_handle
					return false
				}
			}
		} else {
			if {[ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ] == "Memory_Slave"  } {
				if {$Write_Width_A_value != 32 && $Write_Width_A_value != 64 } {
          set_property errmsg "Supported AXI Widths are 32 or 64" $Write_Width_A_handle
					return false
				}
			} else {
				if {$Write_Width_A_value != 8 && $Write_Width_A_value != 16 && $Write_Width_A_value != 32 && $Write_Width_A_value != 64 } {
          set_property errmsg "Supported AXI Widths are 8,16,32 or 64" $Write_Width_A_handle
					return false
				}
			}
		}
  } else {
	  if {![write_width_a_valid ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} \
			${PARAM_VALUE.WRITE_WIDTH_A} $IPINST]} {
	    return false
	  }
  }
	set aspect_ratio [check_aspect_ration ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype ne "BRAM" ) && ( $aspect_ratio != 1 ) } { 
	  #set_property errmsg "Read Width A , Write Width A , Read Width B , Write Width B  must be equal for rams type URAM or AUTO  "   $Write_Width_A_handle
     #return false
	}   
  return true 

}

proc write_width_a_valid { BYTE_SIZE ENABLE_32BIT_ADDRESS SOFTECC USE_BYTE_WRITE_ENABLE Write_Width_A_handle IPINST} {

  if {[ get_property value $ENABLE_32BIT_ADDRESS ]  } {
  	set wwa [ get_property value $Write_Width_A_handle ]
  	 if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
	 	if {!($wwa == 32 || $wwa == 40 || $wwa == 64 || $wwa == 72 || $wwa == 128 || $wwa == 144 || $wwa == 256 || $wwa == 512 || $wwa == 1024)} {
    	        set_property errmsg "When Enable 32-bit Address is selected, Write_Width should accept only the values 32,40,64,72,128,144,256,512,1024" $Write_Width_A_handle

        	    return FALSE
	      } 
	 } else {
	   	 if {!($wwa == 32 || $wwa == 64 || $wwa == 128 || $wwa == 256 || $wwa == 512 || $wwa == 1024)} {
    	        set_property errmsg "When Enable 32-bit Address is selected, Write_Width should accept only the values 32,64,128,256,512,1024" $Write_Width_A_handle

        	    return FALSE
	      } else {
		  		if {[ get_property value $SOFTECC ] } {
					if {!([ get_property value $Write_Width_A_handle ] == 32 || [ get_property value $Write_Width_A_handle ] == 64)} {
						set_property errmsg "When softecc is selected for RSB32, acceptable values on write width are 32 or 64" $Write_Width_A_handle
						return FALSE
					}
				}
	  	}
   	}
  }

  if {[ get_property value $USE_BYTE_WRITE_ENABLE ]} {
    if {[ get_property value $BYTE_SIZE ] == 9} {
      if {[ expr {[ get_property value $Write_Width_A_handle ] % 9 }] != 0} {
        set_property errmsg "Write Width A must be a multiple of the Byte Size 9" $Write_Width_A_handle
        return false
      }
    } elseif {[ get_property value $BYTE_SIZE ] == 8} {
      if {[ expr {[ get_property value $Write_Width_A_handle ] % 8 }] != 0} {
        set_property errmsg "Write Width A must be a multiple of the Byte Size 8" $Write_Width_A_handle
        return false
      }
    }
  }
  return true

}

#proc update_PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE \
PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} {

#	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
#	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
#	set Register_PortA_Output_of_Memory_Primitives ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES}

#	if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
#		set_property value false 	$Register_PortA_Output_of_Memory_Primitives
#	} else {
#	}

#	if { $Memory_Type_value == "Simple_Dual_Port_RAM"} {
#		set_property value false $Register_PortA_Output_of_Memory_Primitives 
#		set_property enabled false $Register_PortA_Output_of_Memory_Primitives 
#	} else { 
#		if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
#         set_property enabled true $Register_PortA_Output_of_Memory_Primitives
#	    } else {
#        set_property enabled true $Register_PortA_Output_of_Memory_Primitives
#		set_property value true $Register_PortA_Output_of_Memory_Primitives }
#		}
#	}
#}

proc update_PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES { PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE \
PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set Register_PortA_Output_of_Memory_Primitives ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES}

	if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set_property value false 	$Register_PortA_Output_of_Memory_Primitives
	} else {
	}

   set PRIM_type [get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ]
   if {$PRIM_type == "URAM"} {
       set_property value false 	$Register_PortA_Output_of_Memory_Primitives
	    set_property enabled false $Register_PortA_Output_of_Memory_Primitives 
   } else {
	  if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {	
	    if { $Memory_Type_value == "Simple_Dual_Port_RAM"} {
	  	set_property value false $Register_PortA_Output_of_Memory_Primitives 
	  	set_property enabled false $Register_PortA_Output_of_Memory_Primitives 
	    } else {
	  	set_property enabled true $Register_PortA_Output_of_Memory_Primitives
	  #	set_property value true $Register_PortA_Output_of_Memory_Primitives 
	    }
      } else {
	    if { $Memory_Type_value == "Simple_Dual_Port_RAM"} {
	  	set_property value false $Register_PortA_Output_of_Memory_Primitives 
	  	set_property enabled false $Register_PortA_Output_of_Memory_Primitives 
	    } else {
	  	set_property enabled true $Register_PortA_Output_of_Memory_Primitives
	  	set_property value true $Register_PortA_Output_of_Memory_Primitives 
	    }
    }  
  }
            
}

#proc update_PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE \
PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} {

#  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
#  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
#  set Register_PortB_Output_of_Memory_Primitives ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES}

#   if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
#      set_property value false $Register_PortB_Output_of_Memory_Primitives
#   } else {
#   }

#  if { $Interface_Type_value == "AXI4" } {
#    set_property value false $Register_PortB_Output_of_Memory_Primitives 
#    set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
#  } else {
#	  if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
#      set_property value false $Register_PortB_Output_of_Memory_Primitives 
#      set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
#	  } else {
#		if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
#          set_property enabled true $Register_PortB_Output_of_Memory_Primitives
#		} else {
#        set_property enabled true $Register_PortB_Output_of_Memory_Primitives
#		set_property value true $Register_PortB_Output_of_Memory_Primitives
#		}
#	  }
#  }

#}

proc update_PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES { PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE \
PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Register_PortB_Output_of_Memory_Primitives ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES}
   if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
      set_property value false $Register_PortB_Output_of_Memory_Primitives
   } else {
   }

  set PRIM_type [get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ]
  if {$PRIM_type == "URAM"} {
      set_property value false 	$Register_PortB_Output_of_Memory_Primitives
      set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
  } else {
    if { $Interface_Type_value == "AXI4" } {
      set_property value false $Register_PortB_Output_of_Memory_Primitives 
      set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
    } else {

     if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
       if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
        set_property value false $Register_PortB_Output_of_Memory_Primitives 
        set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
       } else {
        set_property enabled true $Register_PortB_Output_of_Memory_Primitives
      # set_property value true $Register_PortB_Output_of_Memory_Primitives
       }
      } else {

       if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
        set_property value false $Register_PortB_Output_of_Memory_Primitives 
        set_property enabled false $Register_PortB_Output_of_Memory_Primitives 
       } else {
        set_property enabled true $Register_PortB_Output_of_Memory_Primitives
       set_property value true $Register_PortB_Output_of_Memory_Primitives
       }
    
      }
    
    }
  }
            

}

proc update_PARAM_VALUE.USE_BYTE_WRITE_ENABLE { PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.ECC PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS 
PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BRAM_BLOCK 
PARAM_VALUE.AXI_SLAVE_TYPE } {

  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Use_Byte_Write_Enable_handle ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}

  if {$Interface_Type_value == "AXI4" } {
    set_property enabled false $Use_Byte_Write_Enable_handle 
    set_property value true $Use_Byte_Write_Enable_handle 
  } else {
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller"} {
			# set valid_hardware [expr { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]}]
			set valid_hardware true
			if { $valid_hardware && ![ get_property value ${PARAM_VALUE.ECC} ]  && ![ get_property value ${PARAM_VALUE.SOFTECC} ] } {
				if { $Memory_Type_value != "Single_Port_ROM" && $Memory_Type_value != "Dual_Port_ROM" } {
					set_property enabled false $Use_Byte_Write_Enable_handle 
					set_property value true $Use_Byte_Write_Enable_handle 
				} else {
					set_property enabled false $Use_Byte_Write_Enable_handle 
					set_property value false $Use_Byte_Write_Enable_handle 
				}     

			} else {
				set_property value false $Use_Byte_Write_Enable_handle 
			} 
			
		} else {
			   # Only update this parameter's state
			# set valid_hardware [expr { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]}]
			set valid_hardware true
			if { $valid_hardware && ![ get_property value ${PARAM_VALUE.ECC} ]  && ![ get_property value ${PARAM_VALUE.SOFTECC} ] } {
			   if { $Memory_Type_value != "Single_Port_ROM" && $Memory_Type_value != "Dual_Port_ROM" } {
				   set_property enabled true $Use_Byte_Write_Enable_handle 
				   set_property value false $Use_Byte_Write_Enable_handle 
			   } else {
				   set_property enabled false $Use_Byte_Write_Enable_handle 
				   set_property value false $Use_Byte_Write_Enable_handle 
			   }        
			} else {
				set_property value false $Use_Byte_Write_Enable_handle 
			}
		}
  }

}

proc updateVisibilityOfUSE_BYTE_WRITE_ENABLE { PARAM_VALUE.ECC PARAM_VALUE.ENABLE_32BIT_ADDRESS 
PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BRAM_BLOCK IPINST } {

	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set Use_Byte_Write_Enable_handle [ipgui::get_guiparamspec Use_Byte_Write_Enable -of $IPINST]

	if {$Interface_Type_value == "AXI4" } {
		;# do nothing
	} else {
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller"} {
			# set valid_hardware [expr { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]}]
			set valid_hardware true
			if { $valid_hardware && ![ get_property value ${PARAM_VALUE.ECC} ]  && ![ get_property value ${PARAM_VALUE.SOFTECC} ] } {
				set_property visible true $Use_Byte_Write_Enable_handle 
			} else {
				set_property visible false $Use_Byte_Write_Enable_handle 
			} 
		} else {
			   # Only update this parameter's state
			# set valid_hardware [expr { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]}]
			set valid_hardware true
			if { $valid_hardware && ![ get_property value ${PARAM_VALUE.ECC} ]  && ![ get_property value ${PARAM_VALUE.SOFTECC} ] } {
			   set_property visible true $Use_Byte_Write_Enable_handle 
			} else {
				set_property visible false $Use_Byte_Write_Enable_handle 
			}
		}
	}
}


proc validate_PARAM_VALUE.DISABLE_COLLISION_WARNINGS { PARAM_VALUE.DISABLE_COLLISION_WARNINGS PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  
  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PROJECT_PARAM.SPEEDGRADE PROJECT_PARAM.PART
  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
   
;#Function written to compare BRAM count in FPGA Vs Estimated RAMs used for CR534626
  set complete_device_name [string tolower ${PROJECT_PARAM.PART}]
  set spd [string tolower ${PROJECT_PARAM.SPEEDGRADE}] 
  set indx [string last $spd $complete_device_name]
  set device_package [string range $complete_device_name 0 $indx-1 ]
  set device_package [split $device_package -]
  set device_package [regsub -all " " $device_package ""]
  
  set rams_used_18 [est_blk_ram_resource_x 18 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ]
  
  set rams_used_36 [est_blk_ram_resource_x 36 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ]
  set total_bram_bits [expr { $rams_used_18*18432 + $rams_used_36*36864}]
  #set total_uram_bits []
#  set partlist_filename "xgui/partlist.tcl"

#  while {1} {
#    set isEOF [gets_ipfile $partlist_filename partlistfile_data]
#    if {$isEOF < 0} {
#       break
#    }
#    foreach device_in_partlist {$partlistfile_data } {
#      set split_partlistdata [split $partlistfile_data "_"]
#      set device_identified [string tolower [lindex $split_partlistdata end-1]]
#	  set device_identified [split $device_identified -]
#	  set device_identified [regsub -all " " $device_identified ""]
#      if {$device_package == $device_identified} {
#        set bram_count [lindex $split_partlistdata end]
#		
#		if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
#			set bram_bits_count [expr {($bram_count*36864)}]
#		} else {
#			set bram_bits_count [expr {$bram_count*36864}]
#		}
#		
#  
#		if {$total_bram_bits > $bram_bits_count} {
#			set_property errmsg "User configuration exceeds BRAM count in the selected device"  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS} 
#                        close_ipfile $partlist_filename
#			return FALSE
#		}
#	  }
#	}
# }
# close_ipfile $partlist_filename
#   return TRUE
 set bram_bits_count [ get_bram_bits_count ]
 set uram_bits_count [ get_uram_bits_count ]
#send_msg INFO 9133 " BMG: bram_bits_count == $bram_bits_count"
#send_msg INFO 9134 " BMG: uram_bits_count == $uram_bits_count"
set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] } {
	if { ( $ramtype eq "BRAM" ) && (($total_bram_bits > $bram_bits_count))} {
	    set_property errmsg "User configuration exceeds BRAM count in the selected device 1"  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS}
		return false
	 } elseif { ( $ramtype eq "URAM" ) && ($rams_used_36 > $uram_bits_count)} {
	    set_property errmsg "User configuration exceeds URAM count in the selected device"  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS}
		return false
	 } elseif { ( $ramtype eq "AUTO" ) && ($total_bram_bits > [expr $bram_bits_count +  $uram_bits_count]) && 0 } {
	 # call to be given for auto caliculation of ram bits 
	    set_property errmsg "User configuration exceeds total RAM count in the selected device"  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS}
		return false
	 } else { 
		return true
	 }

   } else { 
  if {$total_bram_bits > $bram_bits_count} {
	    set_property errmsg "User configuration exceeds BRAM count in the selected device"  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS}
		return false
	 } else { 
		return true
	 }

   } 
 }

proc validate_PARAM_VALUE.Use_REGCEA_Pin {PARAM_VALUE.Use_REGCEA_Pin PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE  
  PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES } {

  set Use_REGCEA_Pin_value [ get_property value ${PARAM_VALUE.Use_REGCEA_Pin} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]

  if {$Memory_Type_value == "Simple_Dual_Port_RAM"  || ((!$Register_PortA_Output_of_Memory_Primitives_value) && (!$Register_PortA_Output_of_Memory_Core_value))} {

      if {$Use_REGCEA_Pin_value} {
         set_property errmsg "Use REGCEA is invalid"  ${PARAM_VALUE.Use_REGCEA_Pin} 
         return false
      }
  }
  return true

}

proc validate_PARAM_VALUE.USE_REGCEB_PIN {PARAM_VALUE.USE_REGCEB_PIN PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE  
  PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES } {

  set Use_REGCEB_Pin_value [ get_property value ${PARAM_VALUE.USE_REGCEB_PIN} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Register_PortB_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortB_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]

  if {($Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM") || ((!$Register_PortB_Output_of_Memory_Primitives_value) && (!$Register_PortB_Output_of_Memory_Core_value))} {
      if {$Use_REGCEB_Pin_value} {
         set_property errmsg "Use REGCEB is invalid"  ${PARAM_VALUE.USE_REGCEB_PIN} 
         return false
      }
  }
  return true

}

proc validate_PARAM_VALUE.READ_WIDTH_A { PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.ECC PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE  PARAM_VALUE.READ_WIDTH_B
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.PRIM_type_to_Implement } {
  
  set Read_Width_A_handle  ${PARAM_VALUE.READ_WIDTH_A} 
  set Read_Width_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
      
  if {$Interface_Type_value == "AXI4" && $AXI_Slave_Type_value == "Memory_Slave" && $Memory_Type_value == "Simple_Dual_Port_RAM" } {
	  if {[ expr {$Read_Width_value % 8 }] != 0} {
      set_property errmsg "Read Width A must be a multiple of the Byte Size 8" $Read_Width_A_handle
      return false
    }
  } else {
	 if {$Write_Width_A_value eq "" } {
	   # don't attempt to validate, as this would break the Tcl
	   return true
	 }
   if {$ECC_value} {
     if {$Read_Width_value != $Write_Width_A_value} {
       set_property errmsg "Read Width A must be equal to Write Width A for ECC memory" $Read_Width_A_handle
       return false
     }
   }
	
	 if {$Use_Byte_Write_Enable_value } {
	   if {[ expr {$Read_Width_value % $Byte_Size_value}] != 0} {
       set_property errmsg "Read Width A must be a multiple of the Byte Size $Byte_Size_value" $Read_Width_A_handle
	     return false
	   }
	 }
	
	 if {$Use_Byte_Write_Enable_value} {
	   set ratio_value 4
	 } else {
	   set ratio_value 32
	 }
	 if { ($Read_Width_value * $ratio_value < $Write_Width_A_value )
	     || ($Write_Width_A_value * $ratio_value < $Read_Width_value)} {
	   if { $Use_Byte_Write_Enable_value  } {
       set_property errmsg "The ratio between two data widths must not exceed 4:1 when byte writes are enabled" $Read_Width_A_handle
	   } else {
       set_property errmsg "The ratio between two data widths must not exceed 32:1" $Read_Width_A_handle
	   }
	   return false
	 }
  }
  
    	set aspect_ratio [check_aspect_ration ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype ne "BRAM" ) && ( $aspect_ratio != 1 ) } { 
	  set_property errmsg "Read Width A , Write Width A , Read Width B , Write Width B  must be equal for rams type URAM or AUTO  " $Read_Width_A_handle
     #return false
	} 
   
   
  return true 

}

proc validate_PARAM_VALUE.WRITE_WIDTH_B { PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_WIDTH_A  
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.PRIM_type_to_Implement  PARAM_VALUE.MEMORY_TYPE } {

  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Write_Width_B_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]

  if {$Use_Byte_Write_Enable_value} {
      set byteSize $Byte_Size_value
      if {[ expr {$Write_Width_B_value % $byteSize }] != 0} {
         set_property errmsg "Write Width B must be a multiple of the Byte Size $byteSize"  ${PARAM_VALUE.WRITE_WIDTH_B} 
         return false
      }

  }
  if {$ECC_value && ($Write_Width_B_value!=$Write_Width_A_value) } {
      set_property errmsg "If ECC is enabled, all port widths must be equal."  ${PARAM_VALUE.WRITE_WIDTH_B} 
      return false
  }
  
     	set aspect_ratio [check_aspect_ration ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype ne "BRAM" ) && ( $aspect_ratio != 1 ) } { 
	  set_property errmsg "Read Width A , Write Width A , Read Width B , Write Width B  must be equal for rams type URAM or AUTO  " ${PARAM_VALUE.WRITE_WIDTH_B}
     #return false
	} 
  return true

}

proc validate_PARAM_VALUE.RESET_PRIORITY_A { PARAM_VALUE.RESET_PRIORITY_A PARAM_VALUE.RESET_MEMORY_LATCH_A } {
  set Reset_Memory_Latch_A_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_A} ]
  set Reset_Priority_A_value [ get_property value ${PARAM_VALUE.RESET_PRIORITY_A} ]

  ;#[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] && $Reset_Memory_Latch_A_value  && $Reset_Priority_A_value == "SR"
  if { $Reset_Memory_Latch_A_value  && $Reset_Priority_A_value == "SR"} {
     set_property errmsg "For Virtex-6,Virtex-7,Kintex-7, Artix-7, Zynq and special reset behaviour, Reset_Priority should be CE"  ${PARAM_VALUE.RESET_PRIORITY_A} 
     return false
  }
  return true

}

proc validate_PARAM_VALUE.USE_RSTA_PIN { PARAM_VALUE.USE_RSTA_PIN PARAM_VALUE.ECC } {

  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]

   if {$ECC_value && $Use_RSTA_Pin_value } {
       set_property errmsg "Use RSTA Pin must be unchecked if ECC is selected."  ${PARAM_VALUE.USE_RSTA_PIN} 
      return false
   }
   return true

}

proc validate_PARAM_VALUE.READ_WIDTH_B { PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.AXI_TYPE PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.ECC PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_A  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.PRIM_type_to_Implement} {

  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Write_Width_B_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]
  set Read_Width_B_value [ get_property value ${PARAM_VALUE.READ_WIDTH_B} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  
  if {$Interface_Type_value != "AXI4" } {   
	  if {$Write_Width_A_value eq "" } {
	      # don't attempt to validate, as this would break the Tcl
	      return true
	  }
	
	  if {[string first "Single_Port" $Memory_Type_value]!=0} {
	    if {$Use_Byte_Write_Enable_value} {
	      set byteSize $Byte_Size_value
	      if {[expr {$Read_Width_B_value % $byteSize }] != 0} {
          set_property errmsg "Read Width B must be a multiple of the Byte Size $byteSize"  ${PARAM_VALUE.READ_WIDTH_B} 
	        return false
	      }
	    }
	
	    set port_widths {Read_Width_A Write_Width_A Read_Width_B Write_Width_B}
	
	    if {$Use_Byte_Write_Enable_value} {
	      set ratio_value 4
	    } else {
	      set ratio_value 32
	    }
	    foreach port_width_left $port_widths {
	      foreach port_width_right $port_widths {
          set first_value ${port_width_left}_value
          set second_value ${port_width_right}_value
	        if {[expr {[set $first_value]*$ratio_value}] < [set $second_value]} {
	          if {$Use_Byte_Write_Enable_value} {
              set_property errmsg "The ratio between two data widths must not exceed 4:1 when byte writes are enabled"  ${PARAM_VALUE.READ_WIDTH_B} 
	          } else {
              set_property errmsg "The ratio between two data widths must not exceed 32:1"  ${PARAM_VALUE.READ_WIDTH_B} 
	          }
	          return false
	        }
	      } 
	    }
    }
  }
  
  	set aspect_ratio [check_aspect_ration ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype ne "BRAM" ) && ( $aspect_ratio != 1 ) } { 
	  set_property errmsg "Read Width A , Write Width A , Read Width B , Write Width B  must be equal for rams type URAM or AUTO  "    ${PARAM_VALUE.READ_WIDTH_B} 
     #return false
	} 
  
  return true

}

proc validate_PARAM_VALUE.RESET_PRIORITY_B {PARAM_VALUE.RESET_PRIORITY_B PARAM_VALUE.RESET_MEMORY_LATCH_B  } {
  set Reset_Priority_B_value [ get_property value ${PARAM_VALUE.RESET_PRIORITY_B} ]
  set Reset_Memory_Latch_B_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_B} ]
	;#[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] && $Reset_Memory_Latch_B_value  && $Reset_Priority_B_value == "SR"
   if { $Reset_Memory_Latch_B_value  && $Reset_Priority_B_value == "SR"} {
     set_property errmsg "For Virtex-6,Virtex-7,Kintex-7, Artix-7, Zynq and special reset behaviour, Reset_Priority should be CE"  ${PARAM_VALUE.RESET_PRIORITY_B} 
     return false
   }
   return true

}

proc validate_PARAM_VALUE.USE_RSTB_PIN { PARAM_VALUE.USE_RSTB_PIN PARAM_VALUE.ECC PARAM_VALUE.MEMORY_TYPE} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]

   if {$ECC_value && $Use_RSTB_Pin_value  } {
      set_property errmsg "Use RSTB Pin must be unchecked if ECC is selected."  ${PARAM_VALUE.USE_RSTB_PIN} 
      return false
   }

   if { $Memory_Type_value == "Single_Port_RAM"  || $Memory_Type_value == "Single_Port_ROM" } {
      if {$Use_RSTB_Pin_value} {
         set_property errmsg "Use RSTB Pin must be unchecked if Memory Type is Single Port RAM or Single Port ROM"  ${PARAM_VALUE.USE_RSTB_PIN} 
         return false
      }
   }
   return true

}

proc validate_PARAM_VALUE.BYTE_SIZE { PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_BRAM_BLOCK} {

  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
   
  if {$Interface_Type_value != "AXI4"  } {
	   if {$ECC_value} {
	      if {$Byte_Size_value == 8} {
	         return true
	      } else {
           set_property errmsg "Byte Size must be 8 with ECC enabled"  ${PARAM_VALUE.BYTE_SIZE} 
	         return false
	      }
	   }
	   
	   if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {

	   } else {
	
	   if {($Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM")} {
	      if {$Byte_Size_value == 8} {
           set_property errmsg "The Byte Size feature is not available for Single Port ROM and Dual Port ROM, and must be set to 8"  ${PARAM_VALUE.BYTE_SIZE} 
	         return false
	      }
		 }
	   }
  }
  return true

}

proc validate_PARAM_VALUE.WRITE_DEPTH_A { PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.BYTE_SIZE} {

#	set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
	set wda [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
	set handle  ${PARAM_VALUE.WRITE_DEPTH_A} 
#	set byte_enable [get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}]
#	set byte_size [get_property value ${PARAM_VALUE.BYTE_SIZE}]
	
#	if {[ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "Native"} {
#		if { $byte_enable == false} {
#			if {$wwa >= 1 && $wwa <= 128 && $wda > [expr "128*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 128K " $handle
#				return false
#			} elseif {$wwa >= 129 && $wwa <= 256 && $wda > [expr "64*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 64K " $handle
#				return false
#			} elseif {$wwa >= 257 && $wwa <= 512 && $wda > [expr "32*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 32K " $handle
#				return false
#			} elseif {$wwa >= 513 && $wwa <= 1024 && $wda > [expr "16*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 16K " $handle
#				return false
#			} elseif {$wwa >= 1025 && $wwa <= 2048 && $wda > [expr "8*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 8K " $handle
#				return false
#			} elseif {$wwa > 2048 && $wda > [expr "4*1024"] } {
#				set_property errmsg "\nWrite/Read Depth should be less than 4K " $handle
#				return false
#			}
#		} else {
#			;# Fix for CR731985
#			if { $byte_size == 8 } {
#				if {$wwa >= 1 && $wwa <= 128 && $wda > [expr "128*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 128K " $handle
#					return false
#				} elseif {$wwa >= 129 && $wwa <= 256 && $wda > [expr "64*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 64K " $handle
#					return false
#				} elseif {$wwa >= 257 && $wwa <= 512 && $wda > [expr "32*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 32K " $handle
#					return false
#				} elseif {$wwa >= 513 && $wwa <= 1024 && $wda > [expr "16*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 16K " $handle
#					return false
#				} elseif {$wwa >= 1025 && $wwa <= 2048 && $wda > [expr "8*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 8K " $handle
#					return false
#				} elseif {$wwa > 2048 && $wda > [expr "4*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 4K " $handle
#					return false
#				}
#			} else {
#				if {$wwa >= 1 && $wwa <= 144 && $wda > [expr "128*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 128K " $handle
#					return false
#				} elseif {$wwa > 144 && $wwa <= 288 && $wda > [expr "64*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 64K " $handle
#					return false
#				} elseif {$wwa > 288 && $wwa <= 576 && $wda > [expr "32*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 32K " $handle
#					return false
#				} elseif {$wwa > 576 && $wwa <= 1152 && $wda > [expr "16*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 16K " $handle
#					return false
#				} elseif {$wwa > 1152 && $wwa <= 2304 && $wda > [expr "8*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 8K " $handle
#					return false
#				} elseif {$wwa > 2304 && $wda > [expr "4*1024"] } {
#					set_property errmsg "\nWrite/Read Depth should be less than 4K " $handle
#					return false
#				}
#			}
#		}
#	}


	

	#set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
	#set bram_bits_count [ get_bram_bits_count ]
	#set max_write_depth1 [expr $bram_bits_count / $wwa ]
    #set max_write_depth [  getMaxWriteDepthA ${PARAM_VALUE.WRITE_WIDTH_A} ]
	#if {$max_write_depth1 > $max_write_depth} { set max_write_depth $max_write_depth1 }
	
	set max_write_depth [getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]
	
  if {$wda > $max_write_depth} {
    set_property errmsg "\nWrite/Read Depth should be less than $max_write_depth " $handle 
    return false
	} else {
	  return true 
	}
	return true
}

proc validate_PARAM_VALUE.USE_BYTE_WRITE_ENABLE {PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.ECC  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]

   if {$Interface_Type_value == "AXI4" &&  $AXI_Slave_Type_value == "Memory_Slave"  } {	
	   if {$Memory_Type_value == "Single_Port_ROM" && $Use_Byte_Write_Enable_value} {
	         $Use_Byte_Write_Enable SetErrorMessage [ I18n "The Use Byte Write Enable feature is not available for Virtex2 and all its derivative architecture" ]
	         return false
	   }
   }  else {
	   if {$Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM"} {
	      if {$Use_Byte_Write_Enable_value} {
           set_property errmsg "The Use Byte Write Enable feature is not available for Single Port ROM and Dual Port ROM"  ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} 
	         return false
	      }
	   }
	   if {$ECC_value && $Use_Byte_Write_Enable_value} {
        set_property errmsg "The Use Byte Write Enable feature is not available when ECC is selected."  ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} 
	      return false
	   }
   }
   return true

}

proc validate_PARAM_VALUE.ENABLE_B { PARAM_VALUE.ENABLE_B PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Enable_B_value [ get_property value ${PARAM_VALUE.ENABLE_B} ]

  if { $Interface_Type_value == "Native" } {
	  if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
	      if {$Enable_B_value == "Use_ENB_Pin" } {
           set_property errmsg "Enable_B must be set Always_Enabled to if Memory Type is Single Port RAM or Single Port ROM"  ${PARAM_VALUE.ENABLE_B} 
	         return false
	      }
	   }
	}
  return true

}

proc validate_PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK { PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK PARAM_VALUE.MEMORY_TYPE} {
  set Assume_Synchronous_Clk_value [ get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]

   if {($Memory_Type_value == "Single_port_RAM" || $Memory_Type_value == "Single_Port_ROM")} {
      if {$Assume_Synchronous_Clk_value} {
         set_property errmsg "Assume Synchronous Clk is invalid"  ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} 
         return false
      }
   }
   return true

}

proc validate_PARAM_VALUE.LOAD_INIT_FILE { PARAM_VALUE.LOAD_INIT_FILE PARAM_VALUE.ECC PARAM_VALUE.SOFTECC} {

  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set softecc_value [ get_property value ${PARAM_VALUE.SOFTECC} ]
  set Load_Init_File_value [ get_property value ${PARAM_VALUE.LOAD_INIT_FILE} ]

  if {($ECC_value || $softecc_value) &&  $Load_Init_File_value} {
      set_property errmsg "If ECC is enabled, memory initialization is not available."  ${PARAM_VALUE.LOAD_INIT_FILE} 
      return false
  }
  return true

}

proc validate_PARAM_VALUE.OPERATING_MODE_A { PARAM_VALUE.OPERATING_MODE_A PARAM_VALUE.ECC } {
  set Operating_Mode_A_value [ get_property value ${PARAM_VALUE.OPERATING_MODE_A} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]

  ;#$ECC_value ==true &&  $Operating_Mode_A_value =="NO_CHANGE" && [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]
  if { $ECC_value &&  $Operating_Mode_A_value =="NO_CHANGE" } {
    set_property errmsg "Operating mode must not be \"No Change\" for ECC memory for family Virtex6."  ${PARAM_VALUE.OPERATING_MODE_A} 
    return false
  }
  
  return true 
}

proc validate_PARAM_VALUE.OPERATING_MODE_B { PARAM_VALUE.OPERATING_MODE_B  PARAM_VALUE.ECC} {
  set Operating_Mode_B_value [ get_property value ${PARAM_VALUE.OPERATING_MODE_B} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]

  ;#$ECC_value  && $Operating_Mode_B_value =="NO_CHANGE" && [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]
  if { $ECC_value && $Operating_Mode_B_value =="NO_CHANGE" } {
    set_property errmsg "Operating mode must be \"No Change\" for ECC memory for family Virtex6."  ${PARAM_VALUE.OPERATING_MODE_B} 
    return false
  }
  
  return true

}

proc validate_PARAM_VALUE.COE_FILE { PARAM_VALUE.COE_FILE PARAM_VALUE.LOAD_INIT_FILE  
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A IPINST} {

  set Load_Init_File_value [ get_property value ${PARAM_VALUE.LOAD_INIT_FILE} ]
  set Write_Depth_A_value [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Coe_File_value [ get_property value ${PARAM_VALUE.COE_FILE} ]

  set numberOfElement 0
  if {$Load_Init_File_value} {
    # Check that the core can't be generated with the 'Use COE' box checked and no COE specified
    if {$Coe_File_value == "no_coe_file_loaded"} {
      set_property errmsg "No COE file loaded"  ${PARAM_VALUE.COE_FILE} 
      return false
    }
    set errormsg ""
    set file_ptr [ipgui::load_coe_file $IPINST -file $Coe_File_value -listofkeys "memory_initialization_radix,memory_initialization_vector"]
    if {$file_ptr == "" } {
      set_property errmsg "Invalid COE File- [ipgui::get_last_coe_errmsg]" ${PARAM_VALUE.COE_FILE} 
      return FALSE
    }
	  set radix [ipgui::get_coe_val -obj $file_ptr  -key memory_initialization_radix]
	  set mem_vector [ipgui::get_coe_val -obj $file_ptr  -key memory_initialization_vector]
    set resvector [split $mem_vector " "]

    # validate the radix from the COE file
    if {($Coe_File_value != "no_coe_file_loaded") && ($radix != 2 && $radix != 10 && $radix != 16) } {
      set_property errmsg "Invalid radix in COE file - only 2, 10 or 16 are valid"  ${PARAM_VALUE.COE_FILE} 
      return false
    }

    set vector {}
    foreach elementValue $resvector {
      tcl::lappend vector [string trim $elementValue]
      incr numberOfElement
    }

    if {($numberOfElement < 1 || $numberOfElement > $Write_Depth_A_value)} {
      set_property errmsg "The Memory Initialization vector can contain between 1 to Write Depth A number of entires."  ${PARAM_VALUE.COE_FILE} 
     return false
    }

    if {$radix == 2} {
      foreach elementValue $vector {
        set binElementSize [ regexp -all {[0-1]} $elementValue ]
        if { $binElementSize > $Write_Width_A_value  } {
          set_property errmsg "The actual entries: $elementValue , for Memory Initialization vector should not be larger than Write Width A."  ${PARAM_VALUE.COE_FILE} 
          return false
        }
      }
    } elseif {$radix == 16} {
      foreach elementValue $vector {
        set binElementValue [ipgen::number_utils::hex2bin $elementValue ]
        set binElementSize [ regexp -all {[0-1]} $binElementValue ]
        if { $binElementSize > $Write_Width_A_value } {
          set_property errmsg "The actual entries: $elementValue , for Memory Initialization vector should not be larger than Write Width A."  ${PARAM_VALUE.COE_FILE} 
          return false
        }
      }
    } elseif {$radix == 10} {
      foreach elementValue $vector {
         set binElementValue [ ipgen::number_utils::dec2bin $elementValue]
         set binElementSize [ regexp -all {[0-1]} $binElementValue ]

         if { $binElementSize > $Write_Width_A_value } {
           set_property errmsg "The actual entries: $elementValue , for Memory Initialization vector should not be larger than Write Width A."  ${PARAM_VALUE.COE_FILE} 
           return false
         }
      }
    }
  }
  return true

}

proc update_PARAM_VALUE.Use_REGCEA_Pin {PARAM_VALUE.Use_REGCEA_Pin PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE  
  PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
  set Use_REGCEA_Pin  ${PARAM_VALUE.Use_REGCEA_Pin} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
    
  if { $Memory_Type_value == "Simple_Dual_Port_RAM"  ||
       ((!$Register_PortA_Output_of_Memory_Primitives_value) && (!$Register_PortA_Output_of_Memory_Core_value))} {
    set_property enabled false $Use_REGCEA_Pin
    set_property value false $Use_REGCEA_Pin
  } else {
    set_property enabled true $Use_REGCEA_Pin
  }  
	if { $ramtype ne "BRAM" } {
      if { $Register_PortA_Output_of_Memory_Primitives_value || $Register_PortA_Output_of_Memory_Core_value } {
        set_property enabled false $Use_REGCEA_Pin
        set_property value true $Use_REGCEA_Pin
      }
	}


}

proc update_PARAM_VALUE.USE_REGCEB_PIN {PARAM_VALUE.USE_REGCEB_PIN PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.PRIM_type_to_Implement } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Register_PortB_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortB_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]
  set Use_REGCEB_Pin  ${PARAM_VALUE.USE_REGCEB_PIN} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
   
  if { $Interface_Type_value == "AXI4" } {
	  set_property enabled false $Use_REGCEB_Pin
	  set_property value false $Use_REGCEB_Pin
	} else { 
	  if {($Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM") ||
	       ((!$Register_PortB_Output_of_Memory_Primitives_value) && (!$Register_PortB_Output_of_Memory_Core_value))} {
	    set_property enabled false $Use_REGCEB_Pin
	    set_property value false $Use_REGCEB_Pin
	   } else {
	    set_property enabled true $Use_REGCEB_Pin
	  }
  }
	if { $ramtype ne "BRAM" } {
      if { $Register_PortB_Output_of_Memory_Primitives_value || $Register_PortB_Output_of_Memory_Core_value } {
        set_property enabled false $Use_REGCEB_Pin
        set_property value true $Use_REGCEB_Pin
      }
	}


}

proc update_PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE { PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Register_PortA_Output_of_Memory_Core  ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} 

   if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
      set_property value false $Register_PortA_Output_of_Memory_Core
   } else {
   }

  set PRIM_type [get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ]
  if {$PRIM_type == "URAM"} {
      set_property value false 	$Register_PortA_Output_of_Memory_Core
      set_property enabled false $Register_PortA_Output_of_Memory_Core 
  } else {
    if { $Interface_Type_value == "AXI4" } {
      set_property value false $Register_PortA_Output_of_Memory_Core 
      set_property enabled false $Register_PortA_Output_of_Memory_Core 
    } else {
       if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
        set_property value false $Register_PortA_Output_of_Memory_Core 
        set_property enabled false $Register_PortA_Output_of_Memory_Core 
       } else {
        set_property enabled true $Register_PortA_Output_of_Memory_Core 
       }
    }
  }
            

}

proc update_PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE { PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Register_PortB_Output_of_Memory_Core  ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} 

   if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
      set_property value false $Register_PortB_Output_of_Memory_Core
   } 

  set PRIM_type [get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ]
  if {$PRIM_type == "URAM"} {
      set_property value false 	$Register_PortB_Output_of_Memory_Core
      set_property enabled false $Register_PortB_Output_of_Memory_Core 
  } else {
    if { $Interface_Type_value == "AXI4" } {
      set_property value false $Register_PortB_Output_of_Memory_Core 
      set_property enabled false $Register_PortB_Output_of_Memory_Core 
    } else {
       if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
        set_property value false $Register_PortB_Output_of_Memory_Core 
        set_property enabled false $Register_PortB_Output_of_Memory_Core 
       } else {
        set_property enabled true $Register_PortB_Output_of_Memory_Core 
       }
    }
  }
            
}

proc validate_PARAM_VALUE.REMAINING_MEMORY_LOCATIONS { PARAM_VALUE.REMAINING_MEMORY_LOCATIONS PARAM_VALUE.WRITE_WIDTH_A} {

  set Remaining_Memory_Locations  ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} 
  set Remaining_Memory_Locations_value [ get_property value ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} ]
  
  if { [regexp -all {[a-fA-F0-9]} $Remaining_Memory_Locations_value] != [ string length $Remaining_Memory_Locations_value ]} {
		set_property errmsg "Entered invalid Hexadecimal value $Remaining_Memory_Locations_value" ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS}
		return false
  }
  
  ;# Fix for CR: 733553
  set Write_Width_A_value [get_property value ${PARAM_VALUE.WRITE_WIDTH_A}]
  set hexLength [expr {int(ceil((double($Write_Width_A_value) / 4)))}]
  set maxValue ""
  for {set i 0} {$i<$hexLength} {incr i} {
      append maxValue "F"
  }
  if { [ string length $Remaining_Memory_Locations_value ] > $hexLength } {
	set_property errmsg "Value $Remaining_Memory_Locations_value is Out of Range (0..$maxValue)" ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS}
	return false
  }
  return true 

}

proc update_PARAM_VALUE.COE_FILE { PARAM_VALUE.COE_FILE PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.ECCTYPE PARAM_VALUE.LOAD_INIT_FILE PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B } {
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Load_Init_File_value [ get_property value ${PARAM_VALUE.LOAD_INIT_FILE} ]
  set Coe_File  ${PARAM_VALUE.COE_FILE} 

 # if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
 # } else {
 #   if {$Load_Init_File_value == "false"} {
 #     set_property enabled false $Coe_File
 #   } else {
 #     set_property enabled true $Coe_File
 #   }
 # }
  if {!$Load_Init_File_value} {
    set_property enabled false $Coe_File
	set_property value "no_coe_file_loaded" $Coe_File
  } else {
    set_property enabled true $Coe_File
  }
}

proc update_PARAM_VALUE.DISABLE_COLLISION_WARNINGS { PARAM_VALUE.DISABLE_COLLISION_WARNINGS PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  \
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  
  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.PRIM_type_to_Implement} {
set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" || ( $ramtype ne "BRAM" ) } {
		set_property value false  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS} 
		set_property enabled false  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS} 
	} else {
		set_property enabled true  ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS} 
	}
}

proc update_PARAM_VALUE.PRIMITIVE { PARAM_VALUE.PRIMITIVE PARAM_VALUE.ALGORITHM PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.USE_BRAM_BLOCK  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.PRIM_type_to_Implement} {

  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Primitive  ${PARAM_VALUE.PRIMITIVE} 
  
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
		set wda [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
		
		if { $wwa == 32 || $wwa == 64 || $wwa == 128 || $wwa == 256 || $wwa == 512 || $wwa ==1024} {
		} elseif { $wwa == 40 && $wda == 1024} {
			set_property value 2kx9  ${PARAM_VALUE.PRIMITIVE} 	
		} elseif { $wwa == 40 && $wda != 1024} {
			set_property value 2kx9  ${PARAM_VALUE.PRIMITIVE} 	
		} elseif { $wwa == 72 || $wwa == 144 } {
			set_property value 2kx9  ${PARAM_VALUE.PRIMITIVE} 	
		}
		
		if { [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property enabled false  ${PARAM_VALUE.PRIMITIVE} 	
		} else {
			if { $ecctype_value == "No_ECC" } {
				set_property enabled false $Primitive 
			} elseif { $ecctype_value == "Soft_ECC" } {
				set_property enabled true $Primitive 
			} else {
				set_property enabled false $Primitive 
			}
		}
		
		if {!(($Memory_Type_value eq "Simple_Dual_Port_RAM")
			 ||$Memory_Type_value eq "Single_Port_ROM"
			 ||$Memory_Type_value eq "Single_Port_RAM") && ($ecctype_value != "BuiltIn_ECC")} {
			 
			 set listValues [get_property range ${PARAM_VALUE.PRIMITIVE}]
			 set listValues [split $listValues ","]
			 set i [tcl::lsearch $listValues "256x72"]
			 if { $i != -1 } {
				set listValues [tcl::lreplace $listValues $i $i]
			 }
			 set listValues [regsub -all " " $listValues ","]
			set_property range $listValues ${PARAM_VALUE.PRIMITIVE}
		} 
	} else {
		if {$Use_Byte_Write_Enable_value} {
			set defaultValue 2kx9
			set listValues "2kx9,1kx18,512x36"
		} else {
			set defaultValue 8kx2
			set listValues "16kx1,8kx2,4kx4,2kx9,1kx18,512x36"
		}
		
		    # if { $ecctype_value == "No_ECC" } {
				# set_property enabled true $Primitive 
			# } elseif { $ecctype_value == "Soft_ECC" } {
				# set_property enabled true $Primitive 
			# } else {
				# set_property enabled false $Primitive 
			# }
			
		if {$Algorithm_value eq "Fixed_Primitives"} {
			if { $ecctype_value == "BuiltIn_ECC" } {
				set_property enabled false $Primitive
			} else {
				set_property enabled true $Primitive
			}
		} else {
			# Primitive not specified if the algorithm isn't "Fixed_Primitives"
			set_property enabled false $Primitive
			set defaultValue 8kx2
			set listValues "16kx1,8kx2,4kx4,2kx9,1kx18,512x36"
		}

		if {($Memory_Type_value eq "Simple_Dual_Port_RAM")
			 ||$Memory_Type_value eq "Single_Port_ROM"
			 ||$Memory_Type_value eq "Single_Port_RAM"} {
			 append listValues ",256x72"
		} 
		 
        set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
      	if { ($ecctype_value == "BuiltIn_ECC" ) || (( $ramtype ne "BRAM" ) && ($Algorithm_value eq "Fixed_Primitives") )} {
			set defaultValue "256x72"
			set listValues "256x72"
		}
		# set_property range_value "$defaultValue,$listValues" $Primitive
		set_property range "$listValues" $Primitive
	}
}

proc update_gui_for_PARAM_VALUE.Use_RSTA_Pin { PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Use_RSTB_Pin IPINST} {

    if {([ get_property value ${PARAM_VALUE.Use_RSTA_Pin} ] ) || ([ get_property value ${PARAM_VALUE.Use_RSTB_Pin} ] )  } {
			set_property visible true  [ipgui::get_groupspec Safety_logic_to_minimize_BRAM_data_corruption  -of $IPINST]
			set_property visible true  [ipgui::get_guiparamspec EN_SAFETY_CKT -of $IPINST]
		} else {
			set_property visible false  [ipgui::get_groupspec Safety_logic_to_minimize_BRAM_data_corruption -of $IPINST]
			set_property visible false  [ipgui::get_guiparamspec EN_SAFETY_CKT -of $IPINST]
		}
}

proc update_gui_for_PARAM_VALUE.Use_RSTB_Pin { PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Use_RSTA_Pin IPINST} {

    if {([ get_property value ${PARAM_VALUE.Use_RSTA_Pin} ] ) || ([ get_property value ${PARAM_VALUE.Use_RSTB_Pin} ] )  } {
			set_property visible true  [ipgui::get_groupspec Safety_logic_to_minimize_BRAM_data_corruption  -of $IPINST]
			set_property visible true  [ipgui::get_guiparamspec EN_SAFETY_CKT -of $IPINST]
		} else {
			set_property visible false  [ipgui::get_groupspec Safety_logic_to_minimize_BRAM_data_corruption -of $IPINST]
			set_property visible false  [ipgui::get_guiparamspec EN_SAFETY_CKT -of $IPINST]
		}
}

proc updateVisibilityOfCTRL_ECC_ALGO { PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_WIDTH_A IPINST} {
	if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
		set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
		if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" && ($wwa == 40 || $wwa == 72 || $wwa == 144)} {
			set_property visible true  [ipgui::get_guiparamspec  CTRL_ECC_ALGO  -of $IPINST]
		} else {
			set_property visible false  [ipgui::get_guiparamspec  CTRL_ECC_ALGO  -of $IPINST]
		}
	}
}

proc update_PARAM_VALUE.WRITE_WIDTH_A { PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.ERROR_INJECTION_TYPE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.SOFTECC  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Error_Injection_Type_value [ get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set Write_Width_A  ${PARAM_VALUE.WRITE_WIDTH_A} 
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]

   if {$Interface_Type_value == "AXI4" } {
	   if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
	    if {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Memory_Slave"} {
         set_property range "32,256" $Write_Width_A 
		   } elseif {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Peripheral_Slave"} {
         set_property range "8,256" $Write_Width_A 
		   } elseif {$AXI_Type_value == "AXI4_Lite" && $AXI_Slave_Type_value == "Memory_Slave"} {
         set_property range "32,64" $Write_Width_A 
		   } else {
         set_property range "8,64" $Write_Width_A 
		   }
	   } else {
	   }		
  } else {   
    if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		# Only update this parameter's state
		set MinValue 32
		
		;#([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]) && [ get_property value ${PARAM_VALUE.ECC} ]
		if { [ get_property value ${PARAM_VALUE.ECC} ]} {
			set MaxValue 4096      
		} elseif { [ get_property value ${PARAM_VALUE.SOFTECC} ]} {
			set MaxValue 64      
		} else  {
			set MaxValue 1024      
		}
		set_property range "$MinValue,$MaxValue" $Write_Width_A
		if { [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]  } {
			if {[ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ] % $Byte_Size_value} {
				set_property value [ expr {[ get_property value ${PARAM_VALUE.BYTE_SIZE} ] * 4} ] $Write_Width_A 
			}
		} else {
			#set_property value 32 $Write_Width_A 
		}
	} else {
		set min_value [width_min $Use_Byte_Write_Enable_value $Byte_Size_value $Error_Injection_Type_value]
		set max_value 0
		
		  ;#([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]) && ($ecctype_value == "BuiltIn_ECC")
		  if { ($ecctype_value == "BuiltIn_ECC")} {
		  set max_value 4096
		  } elseif { ($ecctype_value == "Soft_ECC")} {
		  set max_value 64
		  } else  {
		  set max_value [width_max $Use_Byte_Write_Enable_value $Byte_Size_value]      
		  }
		  set_property range "$min_value,$max_value" $Write_Width_A 
			
		  if { $Use_Byte_Write_Enable_value  } {
			if {[ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ] % $Byte_Size_value} {
				set_property value [ expr {$Byte_Size_value * 2} ] $Write_Width_A 
			}
		  } else {
			#set_property value 16 $Write_Width_A 
		  }
	}
  }

}

proc update_fileData {IPINST PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.ERROR_INJECTION_TYPE PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.WRITE_WIDTH_B
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.SOFTECC PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.WRITE_DEPTH_A
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.PRIMITIVE  
  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.ALGORITHM PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Error_Injection_Type_value [ get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Primitive_value [ get_property value ${PARAM_VALUE.PRIMITIVE} ]
  set Write_Depth_A_value [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Write_Width_B_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]
  
	if {$Interface_Type_value == "AXI4" } {
		if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
			set fileData(Write_Width_A) true
			set fileData(Read_Width_A) false
			set fileData(Read_Width_B) true
		} else {
			set fileData(Write_Width_A) false
			set fileData(Read_Width_A) true
			set fileData(Read_Width_B) false
		}		
		set fileData(Write_Width_B) false
	} else {   
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set fileData(Write_Width_A) true
		} else {
			set fileData(Write_Width_A) true
		}
		
		if {($ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC" ) && $Memory_Type_value == "Simple_Dual_Port_RAM"} {
			set fileData(Write_Width_B) true
		} elseif { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
			set fileData(Write_Width_B) false
		}  else {
			set fileData(Write_Width_B) true
		}
		
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Simple_Dual_Port_RAM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Single_Port_ROM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Dual_Port_ROM" } {
				set fileData(Read_Width_A) false
			} elseif {( [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Single_Port_RAM" && [ get_property value ${PARAM_VALUE.ECC} ])} {
				;# ([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] && [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Single_Port_RAM" && [ get_property value ${PARAM_VALUE.ECC} ])
				set fileData(Read_Width_A) true
			} else {
				set fileData(Read_Width_A) true
			}
		} else {
			if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM" } {
				set fileData(Read_Width_A) false
			} elseif {( $Memory_Type_value eq "Single_Port_RAM" && $ecctype_value == "BuiltIn_ECC") } {
				;#([isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] && $Memory_Type_value eq "Single_Port_RAM" && $ecctype_value == "BuiltIn_ECC")
				set fileData(Read_Width_A) true
			} else {
				set fileData(Read_Width_A) true
			}
		}
		
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Simple_Dual_Port_RAM"
		    || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Dual_Port_ROM"} {
				set fileData(Read_Width_B) false
			} else {
				set fileData(Read_Width_B) true
			}
		   
			if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
				set fileData(Read_Width_B) false
			}
		} else {
			if {$Memory_Type_value eq "Simple_Dual_Port_RAM"
		    || $Memory_Type_value eq "Dual_Port_ROM"} {
				set fileData(Read_Width_B) false
			} else {
				set fileData(Read_Width_B) true
			}
		
			if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
				set fileData(Read_Width_B) false
			}
		}
	}

	if {$Interface_Type_value == "AXI4" && ($AXI_Type_value == "AXI4_Full" || $AXI_Type_value == "AXI4_Lite") && $AXI_Slave_Type_value == "Memory_Slave" } {
		if {$Memory_Type_value == "Simple_Dual_Port_RAM" } { 
			set fileData(Write_Depth_A) true
		} else {
			set fileData(Write_Depth_A) false
		}	   
	} else {
		set fileData(Write_Depth_A) true
	}
	
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set fileData(Port_A_Clock) $Additional_Inputs_for_Power_Estimation_value
	set fileData(Port_B_Clock) $Additional_Inputs_for_Power_Estimation_value
	if {[string match "Single_Port_*" $Memory_Type_value]} {
		set fileData(Port_B_Clock) false
	}
	
	set fileData(Port_A_Write_Rate) $Additional_Inputs_for_Power_Estimation_value
	if {$Memory_Type_value eq "Single_Port_ROM" || $Memory_Type_value eq "Dual_Port_ROM" } {
    	set fileData(Port_A_Write_Rate) false
	}
	
	set var [expr ($Additional_Inputs_for_Power_Estimation_value && (![string match "Single_Port_*" $Memory_Type_value] || ![string match "Dual_Port_*" $Memory_Type_value]))?true:false]
	set fileData(Port_B_Write_Rate) $var
	if {[string match "Single_Port_*" $Memory_Type_value]} {
		set fileData(Port_B_Write_Rate) false
	}
	
	if {$Memory_Type_value eq "Single_Port_RAM" || $Memory_Type_value eq "Single_Port_ROM" || $Memory_Type_value eq "Dual_Port_ROM" } {
		set fileData(Port_B_Write_Rate) false
	}
	
	set fileData(Port_A_Enable_Rate) $Additional_Inputs_for_Power_Estimation_value
	set var1 [expr ($Additional_Inputs_for_Power_Estimation_value && ![string match "Single_Port_*" $Memory_Type_value])?true:false]
	set fileData(Port_B_Enable_Rate) $var1
	if {[string match "Single_Port_*" $Memory_Type_value]} {
		set fileData(Port_B_Enable_Rate) false
	}
	
	return [array get fileData]
}

proc update_ecctype_previous_value { PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.ECCTYPE} {
	set prevVal [tcl::lindex [split [get_metaparam_value ecctype_previous_value] " "] 0]
	set curVal [get_property value ${PARAM_VALUE.ECCTYPE}]
	
	return [list $curVal $prevVal]
}

proc updateVisibilityOfWRITE_WIDTH_A { PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE 
  PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_BRAM_BLOCK IPINST } {

	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
	set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
	set Write_Width_A  [ipgui::get_guiparamspec Write_Width_A -of $IPINST]

	if {$Interface_Type_value == "AXI4" } {
		if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
			set_property visible true $Write_Width_A 
			if {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Memory_Slave"} {
				set_property tooltip "32/64/128/256" $Write_Width_A
			} elseif {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Peripheral_Slave"} {
				set_property tooltip "8/16/32/64/128/256" $Write_Width_A 
			} elseif {$AXI_Type_value == "AXI4_Lite" && $AXI_Slave_Type_value == "Memory_Slave"} {
				set_property tooltip "32/64" $Write_Width_A 
			} else {
				set_property tooltip "8/16/32/64" $Write_Width_A 
			}
		} else {
			set_property visible false $Write_Width_A 
		}		
	} else {   
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property visible true $Write_Width_A
			set_property tooltip "" $Write_Width_A
		} else {
			set_property visible true $Write_Width_A 
			set_property tooltip "" $Write_Width_A
		}
	}
}

proc update_PARAM_VALUE.REMAINING_MEMORY_LOCATIONS { PARAM_VALUE.REMAINING_MEMORY_LOCATIONS PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_WIDTH_A} {

  set Fill_Remaining_Memory_Locations_value [ get_property value ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Remaining_Memory_Locations  ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} 

  if {$Fill_Remaining_Memory_Locations_value } {
    set_property enabled true $Remaining_Memory_Locations
	if { [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set_property value 0  ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} 
		set_property enabled false  ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} 
	} else {
		set_property enabled true  ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} 
		set hexLength [expr {int(ceil((double($Write_Width_A_value) / 4)))}]
		set maxValue ""
		for {set i 0} {$i<$hexLength} {incr i} {
			append maxValue "F"
		}
		set maxmemoryLocations [ipgen::number_utils::hex2dec $maxValue]
		if { [ipgen::number_utils::hex2dec [get_property value ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS}]] > $maxmemoryLocations} {
			set_property value $maxValue  $Remaining_Memory_Locations
		}
	}
  } else {
    set_property enabled false $Remaining_Memory_Locations
	set_property value 0  $Remaining_Memory_Locations
  }
}

proc update_PARAM_VALUE.ERROR_INJECTION_TYPE { PARAM_VALUE.ERROR_INJECTION_TYPE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.USE_ERROR_INJECTION_PINS } {

  set Use_Error_Injection_Pins_value [ get_property value ${PARAM_VALUE.USE_ERROR_INJECTION_PINS} ]
  set Error_Injection_Type_handle  ${PARAM_VALUE.ERROR_INJECTION_TYPE} 
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
 
  if { $Interface_Type_value == "AXI4" } {
    set_property value [get_property default_value $Error_Injection_Type_handle] $Error_Injection_Type_handle
  } else {
    if {$Use_Error_Injection_Pins_value } {
      set_property enabled true $Error_Injection_Type_handle
    } else {
      set_property enabled false $Error_Injection_Type_handle
      set_property value [get_property default_value $Error_Injection_Type_handle] $Error_Injection_Type_handle
    } 
  }
}

proc updateVisibilityOfERROR_INJECTION_TYPE { IPINST PARAM_VALUE.INTERFACE_TYPE } {
	set Error_Injection_Type_handle  [ipgui::get_guiparamspec Error_Injection_Type -of $IPINST]
	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
 
	if { $Interface_Type_value == "AXI4" } {
		set_property visible false $Error_Injection_Type_handle
	} else {
		# if {[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} { 
			# set_property visible true $Error_Injection_Type_handle
		# } else {
			# set_property visible false $Error_Injection_Type_handle
		# }
			set_property visible true $Error_Injection_Type_handle
	}
}

proc update_PARAM_VALUE.BYTE_SIZE { PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.USE_BRAM_BLOCK  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.MEMORY_TYPE} {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]  
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Byte_Size_handle  ${PARAM_VALUE.BYTE_SIZE} 
  
  if { $Interface_Type_value == "AXI4" } {
    set_property value 8 $Byte_Size_handle
	set_property enabled false $Byte_Size_handle
  } else {
    if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set_property enabled false $Byte_Size_handle 
		set_property value 8 $Byte_Size_handle 
	} else {
		if { [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]  } {
		  set_property enabled true $Byte_Size_handle 
		} else {
		  set_property enabled false $Byte_Size_handle 
		  if {[ get_property value ${PARAM_VALUE.ECC} ] } {
			 set_property value 8 $Byte_Size_handle 
		  } else {
			  set_property value 9 $Byte_Size_handle 
		  }
		}
		
	}
  } 
}

proc updateVisibilityOfMEM_FILE { IPINST PARAM_VALUE.USE_BRAM_BLOCK} {
	if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set_property visible true  [ipgui::get_guiparamspec MEM_FILE -of $IPINST]
	} else {
		set_property visible false  [ipgui::get_guiparamspec MEM_FILE -of $IPINST]
	}
}

proc update_PARAM_VALUE.ENABLE_32BIT_ADDRESS { PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.INTERFACE_TYPE} {

	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Enable_32bit_Address  ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} 
    if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
      set_property value true $Enable_32bit_Address
      set_property enabled false $Enable_32bit_Address
   } else {
      set_property value false $Enable_32bit_Address	
      set_property enabled true $Enable_32bit_Address
   }

	if {$Interface_Type_value == "AXI4" } {
		set_property enabled false $Enable_32bit_Address 
	} else {
		set_property enabled true $Enable_32bit_Address   ;
	}
   
}

proc updateVisibilityOfENABLE_32BIT_ADDRESS { IPINST PARAM_VALUE.INTERFACE_TYPE} {

	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Enable_32bit_Address  [ipgui::get_guiparamspec Enable_32bit_Address -of $IPINST]
	
	if {$Interface_Type_value == "AXI4" } {
		set_property visible false $Enable_32bit_Address 
	} else {
		set_property visible true $Enable_32bit_Address   ;#CR Fix 635430,655117
	}
}

proc update_PARAM_VALUE.ALGORITHM { PARAM_VALUE.ALGORITHM PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.ECCTYPE} {

	set algoHandle  ${PARAM_VALUE.ALGORITHM} 
    set_property enabled true $algoHandle	
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
		if { $wwa == 32 || $wwa == 64 || $wwa == 128 || $wwa == 256 || $wwa == 512 || $wwa == 1024} {
			set_property value Minimum_Area  $algoHandle
		} else {
			set_property value Fixed_Primitives  $algoHandle
		} 
		
		if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property enabled false $algoHandle
		} else {
			set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
			if { $ecctype_value == "No_ECC" } {
				set_property enabled false $algoHandle 
				set_property value Minimum_Area  $algoHandle
			} elseif { $ecctype_value == "Soft_ECC" } {
				set_property enabled true $algoHandle 
			} else {
				set_property enabled false $algoHandle 
				set_property value "Fixed_Primitives" $algoHandle 
			}
		}
	} else {
		set prev_value [tcl::lindex [split [get_metaparam_value ecctype_previous_value] " "] 1]
		set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
		
		if { $prev_value == $ecctype_value} { return; }
		if { $ecctype_value == "No_ECC" } {
			set_property enabled true $algoHandle 
			set_property value Minimum_Area  $algoHandle
		} elseif { $ecctype_value == "Soft_ECC" } {
			set_property enabled true $algoHandle 
		} else {
			set_property enabled false $algoHandle 
			set_property value "Fixed_Primitives" $algoHandle 
		}
	}
}

proc update_PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK { PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Assume_Synchronous_Clk  ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} 

	if { $Interface_Type_value == "Native" && ([ get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ] eq "BRAM" ) } {
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property value false $Assume_Synchronous_Clk
            if {$Memory_Type_value == "Dual_Port_ROM" || $Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "True_Dual_Port_RAM"} {
              set_property enabled true $Assume_Synchronous_Clk
            } else {
              set_property enabled false $Assume_Synchronous_Clk
            }
         } else {
			if {$Memory_Type_value == "Dual_Port_ROM" || $Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "True_Dual_Port_RAM"} {
				set_property enabled true $Assume_Synchronous_Clk
			} else {
				set_property enabled false $Assume_Synchronous_Clk
				set_property value false $Assume_Synchronous_Clk
			}
		}
	} else {
		set_property enabled false $Assume_Synchronous_Clk
		set_property value true $Assume_Synchronous_Clk
	}
	
	# if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		# set_property value false $Assume_Synchronous_Clk
		# set_property enabled false $Assume_Synchronous_Clk
	# } else {
		# set_property enabled true $Assume_Synchronous_Clk
	# }
	

}

proc update_PARAM_VALUE.USE_ERROR_INJECTION_PINS { PARAM_VALUE.USE_ERROR_INJECTION_PINS PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE } {

  set Use_Error_Injection_Pins_handle  ${PARAM_VALUE.USE_ERROR_INJECTION_PINS} 
  set Use_Error_Injection_Pins_value [ get_property value ${PARAM_VALUE.USE_ERROR_INJECTION_PINS} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
 
  if { $Interface_Type_value == "AXI4" } {
    set_property value [get_property default_value $Use_Error_Injection_Pins_handle] $Use_Error_Injection_Pins_handle
  } else {
    if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
      set_property enabled true $Use_Error_Injection_Pins_handle
    } else {
      set_property enabled false $Use_Error_Injection_Pins_handle
      set_property value [get_property default_value $Use_Error_Injection_Pins_handle] $Use_Error_Injection_Pins_handle
    }
  }
}

proc updateVisibilityOfUSE_ERROR_INJECTION_PINS { IPINST PARAM_VALUE.INTERFACE_TYPE } {
	set Use_Error_Injection_Pins_handle [ipgui::get_guiparamspec Use_Error_Injection_Pins -of $IPINST]
	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
 
	if { $Interface_Type_value == "AXI4" } {
		set_property visible false $Use_Error_Injection_Pins_handle
	} else {
		# if {  [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} { 
			# set_property visible true $Use_Error_Injection_Pins_handle
		# } else {
			# set_property visible false $Use_Error_Injection_Pins_handle
		# }
			set_property visible true $Use_Error_Injection_Pins_handle
	}
}

proc update_PARAM_VALUE.LOAD_INIT_FILE { PARAM_VALUE.LOAD_INIT_FILE  PARAM_VALUE.ECC PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BRAM_BLOCK
PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.ECCTYPE PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.MEMORY_TYPE} {
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	set memtype [get_property value ${PARAM_VALUE.MEMORY_TYPE}]

  	if {([ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" && ($memtype ne "Single_Port_ROM" && $memtype ne "Dual_Port_ROM")) || ( $ramtype ne "BRAM" ) } {
		set_property value false  ${PARAM_VALUE.LOAD_INIT_FILE} 
		set_property enabled false  ${PARAM_VALUE.LOAD_INIT_FILE} 
	} else {
		set_property enabled true  ${PARAM_VALUE.LOAD_INIT_FILE} 
		if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
			set_property value false  ${PARAM_VALUE.LOAD_INIT_FILE} 
		}
	}

}

proc update_PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS { PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.ECCTYPE PARAM_VALUE.PRIM_type_to_Implement } {
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	
	if { [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" || ( $ramtype ne "BRAM" ) } {
		set_property value false  ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} 
		set_property enabled false  ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} 
	} else {
		set_property enabled true  ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} 
		if { !($ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC") } {
			set_property value false ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} 
		}
	}
}

proc updateVisibilityOfFILL_REMAINING_MEMORY_LOCATIONS {IPINST PARAM_VALUE.ECCTYPE} {
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
		set_property visible false [ipgui::get_guiparamspec Fill_Remaining_Memory_Locations -of $IPINST] 
	} else {
		set_property visible true [ipgui::get_guiparamspec Fill_Remaining_Memory_Locations -of $IPINST] 
	}
}

proc update_gui_for_PARAM_VALUE.USE_BRAM_BLOCK {PARAM_VALUE.USE_BRAM_BLOCK IPINST} {
	if {[get_property value ${PARAM_VALUE.USE_BRAM_BLOCK}] == "BRAM_Controller" } {
		set_property enabled false [ipgui::get_textspec Read_Depth_A -of $IPINST]
		set_property display_name "Memory Size (in words)" [ipgui::get_groupspec Memory_Size_A -of $IPINST]
		set_property display_name "Memory Size (in words)" [ipgui::get_groupspec Memory_Size_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Enable_32bit_Address -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Enable_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Enable_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Register_PortA_Output_of_Memory_Core -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Register_PortB_Output_of_Memory_Core -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Operating_Mode_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Operating_Mode_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Output_Reset_Value_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Output_Reset_Value_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Read_Width_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Write_Width_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Read_Width_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Write_Depth_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Write_Width_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Use_RSTA_Pin -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Reset_Priority_A -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Reset_Priority_B -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Use_RSTB_Pin -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Register_PortA_Output_of_Memory_Primitives -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec Register_PortB_Output_of_Memory_Primitives -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec MEM_FILE -of $IPINST]
		set_property locked true [ipgui::get_guiparamspec CTRL_ECC_ALGO -of $IPINST]
	} else {
		set_property enabled true [ipgui::get_textspec Read_Depth_A -of $IPINST]
		set_property display_name "Memory Size" [ipgui::get_groupspec Memory_Size_A -of $IPINST]
		set_property display_name "Memory Size" [ipgui::get_groupspec Memory_Size_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Enable_32bit_Address -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Enable_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Enable_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Register_PortA_Output_of_Memory_Core -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Register_PortB_Output_of_Memory_Core -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Operating_Mode_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Operating_Mode_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Output_Reset_Value_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Output_Reset_Value_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Read_Width_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Write_Width_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Read_Width_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Write_Depth_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Write_Width_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Use_RSTA_Pin -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Reset_Priority_A -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Reset_Priority_B -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Use_RSTB_Pin -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Register_PortA_Output_of_Memory_Primitives -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec Register_PortB_Output_of_Memory_Primitives -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec MEM_FILE -of $IPINST]
		set_property locked false [ipgui::get_guiparamspec CTRL_ECC_ALGO -of $IPINST]
	}
	updateVisibilityOfMEM_FILE $IPINST ${PARAM_VALUE.USE_BRAM_BLOCK} 
}

proc update_PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS { PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
		set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]

	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" || ( $ramtype ne "BRAM" ) } {
		set_property value false  ${PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS} 
		set_property enabled false  ${PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS} 
	} else {
		set_property enabled true  ${PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS} 
	}

}

proc validate_PARAM_VALUE.OUTPUT_RESET_VALUE_A { PARAM_VALUE.OUTPUT_RESET_VALUE_A PARAM_VALUE.ECC 
  PARAM_VALUE.READ_WIDTH_A} {

  set Output_Reset_Value_A  ${PARAM_VALUE.OUTPUT_RESET_VALUE_A} 
  set Output_Reset_Value_A_value [ get_property value ${PARAM_VALUE.OUTPUT_RESET_VALUE_A} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]

  if {$ECC_value && $Output_Reset_Value_A_value != 0} {
    set_property errmsg "Output Reset value must be 0 for ECC memory."  ${PARAM_VALUE.OUTPUT_RESET_VALUE_A} 
    return false
  }

  set convert_value [binary format H* $Output_Reset_Value_A_value]

  if { $convert_value == "" } {
		set_property errmsg "Invalid Hexadecimal value" $Output_Reset_Value_A 
    return false
  }

  set OutputResetLength [expr {int(ceil((double($Read_Width_A_value ) / 4)))}]
	set maxValue ""
	for {set i 0} { $i < $OutputResetLength } {incr i} {
	      append maxValue "F"
	}

  set max_value_dec [expr 0x$maxValue]
  set value_dec [expr 0x$Output_Reset_Value_A_value]
  if { $value_dec > $max_value_dec } {
		set_property errmsg "Output_Reset_Value_A value is out of range" $Output_Reset_Value_A 
    return false
  }

  return true 

}

proc validate_PARAM_VALUE.OUTPUT_RESET_VALUE_B { PARAM_VALUE.OUTPUT_RESET_VALUE_B PARAM_VALUE.ECC PARAM_VALUE.READ_WIDTH_B} {

  set Output_Reset_Value_B  ${PARAM_VALUE.OUTPUT_RESET_VALUE_B} 
  set Output_Reset_Value_B_value [ get_property value ${PARAM_VALUE.OUTPUT_RESET_VALUE_B} ]
  set ECC_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Read_Width_B_value [ get_property value ${PARAM_VALUE.READ_WIDTH_B} ]

  if {$ECC_value && $Output_Reset_Value_B_value != 0} {
    set_property errmsg "Output Reset value must be 0 for ECC memory."  ${PARAM_VALUE.OUTPUT_RESET_VALUE_B} 
    return false
  }

  set convert_value [binary format H* $Output_Reset_Value_B_value]
  if { $convert_value == "" } {
		set_property errmsg "Invalid Hexadecimal value" $Output_Reset_Value_B 
    return false
  }

  set OutputResetLength [expr {int(ceil((double($Read_Width_B_value ) / 4)))}]
	set maxValue ""
	for {set i 0} { $i < $OutputResetLength } {incr i} {
	      append maxValue "F"
	}

  set max_value_dec [expr 0x$maxValue]
  set value_dec [expr 0x$Output_Reset_Value_B_value]
  if { $value_dec > $max_value_dec } {
		set_property errmsg "Output_Reset_Value_B value is out of range" $Output_Reset_Value_B 
    return false
  }

  return true 

}

proc update_PARAM_VALUE.OPERATING_MODE_A { PARAM_VALUE.OPERATING_MODE_A PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ECC
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.PRIM_type_to_Implement } {

  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Assume_Synchronous_Clk_value [ get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ]
  set Operating_Mode_A  ${PARAM_VALUE.OPERATING_MODE_A} 
  set use_bram_block [get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] 
  set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	set ecc_val [get_property value ${PARAM_VALUE.ECC}] 

if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") } {set is_ultrascale 1 } else { set is_ultrascale 0 }
  if { $Memory_Type_value eq "Simple_Dual_Port_RAM" && $Assume_Synchronous_Clk_value } {
    if { (!$ecc_val ) && ($use_bram_block != "BRAM_Controller") && ($Interface_Type_value != "AXI4")} {
	         ## changes for CR 811640
	  	#	;# Note: 707995 is done only when ecc = false. Tried the same when ecc = true (device- xc7a100tlffg1156-2L, SDP , builtinECC, wwa=100, rwa=100, wda=353)
#		;# but, found an ERROR "BRAM count exceed".  So, Fixed this CR only for ecc = false.
		set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_A ;# fix for CR 707995
		set_property enabled true $Operating_Mode_A ;# fix for CR 707995
		# set_property range "NO_CHANGE,READ_FIRST" $Operating_Mode_A ;# fix for CR 707995
		# set_property enabled true $Operating_Mode_A ;# fix for CR 707995
	} else {
		set_property range "READ_FIRST,READ_FIRST" $Operating_Mode_A
		set_property enabled false $Operating_Mode_A
	}
		
  } elseif { $Memory_Type_value eq "Simple_Dual_Port_RAM" && (!$Assume_Synchronous_Clk_value)} {

    if { (!$ecc_val) && ($use_bram_block != "BRAM_Controller") && ($Interface_Type_value != "AXI4")} {
	       ## changes for CR 811640
		set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_A ;# fix for CR 707995
		set_property enabled true $Operating_Mode_A
	} else {
		set_property range "WRITE_FIRST,WRITE_FIRST" $Operating_Mode_A
		set_property enabled false $Operating_Mode_A
	}
  } else {
    if {$Algorithm_value == "Low_Power"} {
      set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_A
      set_property enabled true $Operating_Mode_A
    }

    if {$Use_Byte_Write_Enable_value } {
      set_property range_value "WRITE_FIRST,WRITE_FIRST,READ_FIRST" $Operating_Mode_A
    } else {
      set_property range "WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_A
    }

    if { $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM" } {
      set_property enabled false $Operating_Mode_A
      set_property value [get_property default_value $Operating_Mode_A] $Operating_Mode_A
    } else {
      set_property enabled true $Operating_Mode_A
    }
 }
 if { $ramtype ne "BRAM" && $Memory_Type_value eq "True_Dual_Port_RAM" } { 
      set_property range_value "NO_CHANGE,NO_CHANGE" $Operating_Mode_A
      set_property enabled false $Operating_Mode_A
 }

}

proc update_gui_for_PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK { IPINST PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  PARAM_VALUE.MEMORY_TYPE  } {
	updateVisibilityOfOPERATING_MODE_A $IPINST ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  ${PARAM_VALUE.MEMORY_TYPE}  
	updateVisibilityOfOPERATING_MODE_B $IPINST ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  ${PARAM_VALUE.MEMORY_TYPE}  
}

proc updateVisibilityOfOPERATING_MODE_A { IPINST PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  PARAM_VALUE.MEMORY_TYPE  } {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	set Assume_Synchronous_Clk_value [ get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ]
	set Operating_Mode_A  [ipgui::get_guiparamspec Operating_Mode_A -of $IPINST]

	if { $Memory_Type_value eq "Simple_Dual_Port_RAM" && $Assume_Synchronous_Clk_value } {

		set_property visible true $Operating_Mode_A
	} elseif { $Memory_Type_value eq "Simple_Dual_Port_RAM" && (!$Assume_Synchronous_Clk_value)} {
		set_property visible true $Operating_Mode_A
	} else {
	}
}

proc update_PARAM_VALUE.OPERATING_MODE_B { PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ECC PARAM_VALUE.USE_BRAM_BLOCK  PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.USE_BYTE_WRITE_ENABLE PROJECT_PARAM.ARCHITECTURE} {
  if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") } {set is_ultrascale 1 } else { set is_ultrascale 0 }
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set ecc_value [ get_property value ${PARAM_VALUE.ECC} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Assume_Synchronous_Clk_value [ get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ]
  set Operating_Mode_B  ${PARAM_VALUE.OPERATING_MODE_B} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]

  if { $Memory_Type_value eq "Simple_Dual_Port_RAM" && $Assume_Synchronous_Clk_value} {
    ## changes for CR 811640
			 if { (!$ecc_value)&& ($is_ultrascale == 1) } {
				## changes for CR 811640
				
				# Note: 707995 is done only when ecc = false. Tried the same when ecc = true (device- xc7a100tlffg1156-2L, SDP , builtinECC, wwa=100, rwa=100, wda=353)
				## but, found an ERROR "BRAM count exceed".  So, Fixed this CR only for ecc = false.
				set_property range_value "READ_FIRST,READ_FIRST" $Operating_Mode_B
				set_property enabled false $Operating_Mode_B
				# set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_B ;# fix for CR 707995
				# set_property enabled true $Operating_Mode_B;# fix for CR 707995

			} else {
				set_property range_value "READ_FIRST,READ_FIRST" $Operating_Mode_B
				set_property enabled false $Operating_Mode_B
			}
			
    } elseif { $Memory_Type_value eq "Simple_Dual_Port_RAM" && (!$Assume_Synchronous_Clk_value)} {
		  if { (!$ecc_value )&& ($is_ultrascale == 1) } {
				## changes for CR 811640 undo 
				# Note: 707995 is done only when ecc = false. Tried the same when ecc = true (device- xc7a100tlffg1156-2L, SDP , builtinECC, wwa=100, rwa=100, wda=353)
				## but, found an ERROR "BRAM count exceed".  So, Fixed this CR only for ecc = false.
				#set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_B
				#set_property enabled true $Operating_Mode_B;# fix for CR 707995
				set_property enabled false $Operating_Mode_B
				set_property range_value "WRITE_FIRST,WRITE_FIRST" $Operating_Mode_B
				;# fix for CR 707995
			} else {
				## changes for CR 811640
				set_property range_value "WRITE_FIRST,WRITE_FIRST" $Operating_Mode_B
				set_property enabled false $Operating_Mode_B
			}
    } else {
		if {$Algorithm_value == "Low_Power"} {
		  set_property range_value "NO_CHANGE,WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_B
		  set_property enabled true $Operating_Mode_B
		}

    if {$Use_Byte_Write_Enable_value } {
      set_property range_value "WRITE_FIRST,WRITE_FIRST,READ_FIRST" $Operating_Mode_B
    } else {
      set_property range "WRITE_FIRST,READ_FIRST,NO_CHANGE" $Operating_Mode_B
    }

    if { $Memory_Type_value == "Single_Port_RAM" ||$Memory_Type_value == "Single_Port_ROM" ||$Memory_Type_value == "Dual_Port_ROM" } {
      set_property enabled false $Operating_Mode_B
      set_property value [get_property default_value $Operating_Mode_B] $Operating_Mode_B
    } else {
      set_property enabled true $Operating_Mode_B
    }
 }
 if { $ramtype ne "BRAM" && $Memory_Type_value eq "True_Dual_Port_RAM" } { 
      set_property range_value "NO_CHANGE,NO_CHANGE" $Operating_Mode_B
      set_property enabled false $Operating_Mode_B
 }

}

proc updateVisibilityOfOPERATING_MODE_B {IPINST PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK PARAM_VALUE.MEMORY_TYPE } {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	set Assume_Synchronous_Clk_value [ get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ]
	set Operating_Mode_B  [ipgui::get_guiparamspec Operating_Mode_B -of $IPINST]
   
	if { $Memory_Type_value eq "Simple_Dual_Port_RAM" && $Assume_Synchronous_Clk_value } {
		set_property visible true $Operating_Mode_B
	} elseif { $Memory_Type_value eq "Simple_Dual_Port_RAM" && !$Assume_Synchronous_Clk_value} {
		set_property visible true $Operating_Mode_B
	} else {
	}
}

proc update_PARAM_VALUE.OUTPUT_RESET_VALUE_A { PARAM_VALUE.OUTPUT_RESET_VALUE_A PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_RSTA_PIN PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.USE_BRAM_BLOCK} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Output_Reset_Value_A  ${PARAM_VALUE.OUTPUT_RESET_VALUE_A} 

  if {$Interface_Type_value == "AXI4" } {
    set_property enabled false $Output_Reset_Value_A
    set_property value [get_property default_value $Output_Reset_Value_A] $Output_Reset_Value_A
  } else {
	  ;# fix for CR: 733542
	  if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
		set_property enabled false $Output_Reset_Value_A
		set_property value [get_property default_value $Output_Reset_Value_A] $Output_Reset_Value_A
	  } else {
		if { [ get_property value ${PARAM_VALUE.USE_RSTA_PIN}] } {
			set_property enabled true $Output_Reset_Value_A
		} else {
			set_property enabled false $Output_Reset_Value_A
			set_property value [get_property default_value $Output_Reset_Value_A] $Output_Reset_Value_A
		}
	  }
	  if {$ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC"} {
      set_property value 0 $Output_Reset_Value_A
	  } else {
	  }
  }

}

proc update_gui_for_PARAM_VALUE.OUTPUT_RESET_VALUE_A { PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE  IPINST PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.MEMORY_TYPE IPINST} {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Output_Reset_A [ipgui::get_groupspec -name  Output_Reset_A -of $IPINST]
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]


  if {$Interface_Type_value == "AXI4" } {
  
  } else {
	  if {$ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC"} {
      set_property visible false $Output_Reset_A
	  } else {
	    if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
        set_property visible false $Output_Reset_A
	    } else {
        set_property visible true $Output_Reset_A
	    }
	  }
  }
  if { $ramtype ne "BRAM" } {
        set_property visible false $Output_Reset_A
    }

}

proc update_PARAM_VALUE.OUTPUT_RESET_VALUE_B { PARAM_VALUE.OUTPUT_RESET_VALUE_B PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE  PARAM_VALUE.USE_RSTB_PIN PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.ECC } {

  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Read_Width_B_value [ get_property value ${PARAM_VALUE.READ_WIDTH_B} ]
  set Output_Reset_Value_B  ${PARAM_VALUE.OUTPUT_RESET_VALUE_B} 
  
  if {$Interface_Type_value == "AXI4" } {
    set_property enabled false $Output_Reset_Value_B
    set_property value [get_property default_value $Output_Reset_Value_B] $Output_Reset_Value_B
  } else {
	  if {$ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC"} {
         set_property value 0 $Output_Reset_Value_B
		if { [ get_property value ${PARAM_VALUE.USE_RSTB_PIN}] } {
			set_property enabled true $Output_Reset_Value_B
		} else {
			set_property enabled false $Output_Reset_Value_B
			set_property value [get_property default_value $Output_Reset_Value_B] $Output_Reset_Value_B
		}
	  } 
    if {$Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" } {
      set_property enabled false $Output_Reset_Value_B
      set_property value [get_property default_value $Output_Reset_Value_B] $Output_Reset_Value_B
 	  } else {
        if {$ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC"} {
            set_property value 0 $Output_Reset_Value_B
            set_property enabled false $Output_Reset_Value_B
	    } else {
			if { [ get_property value ${PARAM_VALUE.USE_RSTB_PIN}] } {
                set_property enabled true $Output_Reset_Value_B
			} else {
				set_property enabled false $Output_Reset_Value_B
				set_property value [get_property default_value $Output_Reset_Value_B] $Output_Reset_Value_B
			}
		}
	  }
  }

}

proc update_PARAM_VALUE.WRITE_WIDTH_B {PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.ALGORITHM PARAM_VALUE.AXI_SLAVE_TYPE  
  PARAM_VALUE.AXI_TYPE PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.ERROR_INJECTION_TYPE PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.PRIMITIVE  PARAM_VALUE.ECC
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.USE_BRAM_BLOCK  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
  PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.WRITE_WIDTH_A } {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Error_Injection_Type_value [ get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Primitive_value [ get_property value ${PARAM_VALUE.PRIMITIVE} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Write_Depth_A_value [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Write_Width_B  ${PARAM_VALUE.WRITE_WIDTH_B} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]

  if {$Interface_Type_value == "AXI4" } {	    
    set new_range ""	
	  if {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Memory_Slave"} {
      set new_range { 32 64 128 256 }
      set_property range_value "32,32,64,128,256" $Write_Width_B 	
    } elseif {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Peripheral_Slave"} {
      set new_range { 8 16 32 64 128 256 }
      set_property range_value "8,8,16,32,64,128,256" $Write_Width_B 	
    } elseif {$AXI_Type_value == "AXI4_Lite" && $AXI_Slave_Type_value == "Memory_Slave"} {
      set new_range { 32 64 }
      set_property range_value "32,32,64" $Write_Width_B 	
    } else {
      set new_range { 8 16 32 64 }
      set_property range_value "8,8,16,32,64" $Write_Width_B 	
    }

    if {[lsearch $new_range $Write_Width_A_value] != -1 } {
       set_property value $Write_Width_A_value $Write_Width_B 	
    }

  } else {
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set Width_Min 32
		set Width_Max 1024
	} else {
		set Width_Min [width_min $Use_Byte_Write_Enable_value  $Byte_Size_value $Error_Injection_Type_value]
		set Width_Max [width_max $Use_Byte_Write_Enable_value $Byte_Size_value] 
	}
	
	  set write_width_b_list {} 
	
	  if {$Algorithm_value == "Minimum_Area" || $Algorithm_value == "Low_Power"} {
	    if {$Use_Byte_Write_Enable_value } {
	      set narrow_bound [expr 4]
	      set wide_bound [expr 4]
	    } else {
	      set narrow_bound [expr 32]
	      set wide_bound [expr 32]
	    }
	
	    set narrow_width [expr {[min $Write_Width_A_value $Read_Width_A_value]}]
	    set wide_width   [expr {[max $Write_Width_A_value $Read_Width_A_value]}]
		set rda_value [read_depth_a_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]
	    set narrow_depth [expr {[max $Write_Depth_A_value $rda_value]}]
	    set wide_depth   [expr {[min $Write_Depth_A_value $rda_value]}]

      set ratio [expr $wide_width / $narrow_width]
	  } elseif { $Algorithm_value == "Fixed_Primitives" } {
	    if {$Use_Byte_Write_Enable_value } {
	      #Narrow_Bound (Minimum Ratio):
	      #   2kx9  has a minimum ratio of 1:1  (narrow_bound=1)
	      #   1kx18 has a minimum ratio of 2:1  (narrow_bound=2)
	      # 512kx36 has a minimum ratio of 4:1  (narrow_bound=4)

	      #Wide_Bound (Maximum Ratio):
	      #   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
	      #   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
	      # 512kx36 has a maximum ratio of 1:1  (wide_bound=1)
	
	      switch $Primitive_value {
	        2kx9   { set narrow_bound 1; set wide_bound 4}
	        1kx18  { set narrow_bound 2; set wide_bound 2}
	        512x36 { set narrow_bound 4; set wide_bound 1}
	        default { set narrow_bound 1; set wide_bound 1}
	      }
	    } else {
	      #Narrow_Bound (Minimum Ratio):
	      #  16kx1  has a minimum ratio of 1:1  (narrow_bound=1)
	      #   8kx2  has a minimum ratio of 2:1  (narrow_bound=2)
	      #   4kx4  has a minimum ratio of 4:1  (narrow_bound=4)
	      #   2kx9  has a minimum ratio of 8:1  (narrow_bound=8)
	      #   1kx18 has a minimum ratio of 16:1 (narrow_bound=16)
	      # 512kx36 has a minimum ratio of 32:1 (narrow_bound=32)

        #Wide_Bound (Maximum Ratio):
        #  16kx1  has a maximum ratio of 1:32 (wide_bound=32)
        #   8kx2  has a maximum ratio of 1:16 (wide_bound=16)
        #   4kx4  has a maximum ratio of 1:8  (wide_bound=8)
        #   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
        #   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
        # 512kx36 has a maximum ratio of 1:1  (wide_bound=1)

        switch $Primitive_value {
          32kx1  { set narrow_bound 1;  set wide_bound 32}
	        16kx1  { set narrow_bound 1;  set wide_bound 32}
	        8kx2   { set narrow_bound 2;  set wide_bound 16}
	        4kx4   { set narrow_bound 4;  set wide_bound 8}
	        2kx9   { set narrow_bound 8;  set wide_bound 4}
	        1kx18  { set narrow_bound 16; set wide_bound 2}
	        512x36 { set narrow_bound 32; set wide_bound 1}
	        default { set narrow_bound 1; set wide_bound 1}
	      }
	    }
	
	    set narrow_width $Write_Width_A_value
	    set wide_width   $Write_Width_A_value

      set narrow_depth $Write_Depth_A_value
      set wide_depth   $Write_Depth_A_value
	
	    set ratio 1
	  }
	
	  # add primitives narrower than widest to the list
	  for {set i $narrow_bound} {$i >= 2} {set i [expr $i/2]} {
	    #Check to see if we can divide the width evenly
	    if {[ expr $wide_width % $i ] == 0} {
	      #Check if the new depth would be too large
	      if {[ expr $wide_depth * $i ] <= [depth_max]} {
	        #Check if the width is above the min width
	        if {[ expr $wide_width / $i ] >= $Width_Min} {
	          #If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
	          #Otherwise, just add it
	          if { ( ($Use_Byte_Write_Enable_value  && (($wide_width / $i) % $Byte_Size_value)==0) )
	                     || (!$Use_Byte_Write_Enable_value) } {
	            tcl::lappend write_width_b_list [expr { $wide_width / $i}]
	          }
	        }
	      }
	    }
	  }
	
	  # add primitives wider than narrowest to the list
	  for {set i $ratio} {$i <= $wide_bound} {set i [expr $i*2]} {
	    #Check to see if we can divide the depth evenly
	    if {[ expr {$narrow_depth % $i }] == 0} {
	      #Check if the new depth would be too small
	      if {[ expr {$narrow_depth / $i }] >= [depth_min]} {
	        #Check if the width is below the max width
	        if {[ expr {$narrow_width * $i }] <= $Width_Max} {
	          #If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
	          if { ( ($Use_Byte_Write_Enable_value && (($narrow_width * $i) % $Byte_Size_value)==0) )
	                     || (!$Use_Byte_Write_Enable_value) } {
	              tcl::lappend write_width_b_list [expr { $narrow_width * $i}]
	          }
	        }
	      }
	    }
	  }
    
    set values ""
    foreach val $write_width_b_list {
      append values "$val,"
    }
	
    if { $values != "" } {
      set_property range_value "$Write_Width_A_value,$values" $Write_Width_B	
    } elseif { [lsearch $write_width_b_list $Write_Width_A_value] != -1} {
      set_property value $Write_Width_A_value $Write_Width_B	
    }
	
	if {($ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC" ) && $Memory_Type_value == "Simple_Dual_Port_RAM"} {
		set_property value $Write_Width_A_value $Write_Width_B
		set_property enabled false $Write_Width_B
	} elseif { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
		set_property enabled false $Write_Width_B
	}  else {
		set_property enabled true $Write_Width_B
	}
  }
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.WRITE_WIDTH_B}
      set_property value $Write_Width_A_value $Write_Width_B 	
	}

}

proc updateVisibilityOfWRITE_WIDTH_BandWRITE_DEPTH_B {IPINST PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE } {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Write_Width_B  [ipgui::get_guiparamspec Write_Width_B -of $IPINST]
  set Write_Depth_B [ipgui::get_textspec -name Write_Depth_B -of $IPINST]


  if {$Interface_Type_value == "AXI4" } {	    
    set_property visible false $Write_Width_B	 
    set_property visible false $Write_Depth_B	
	set_property visible false [ipgui::get_textspec Write_Width_B_Meta -of $IPINST]
  } else {
    ;#set_property visible true $Write_Width_B	 
    set_property visible true $Write_Depth_B
	set_property visible true [ipgui::get_textspec Write_Width_B_Meta -of $IPINST]	

	if {($ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC" ) && $Memory_Type_value == "Simple_Dual_Port_RAM"} {
		set_property visible true $Write_Width_B
	} elseif { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
		set_property visible false $Write_Width_B
	}  else {
		set_property visible true $Write_Width_B
	}
 }
}

proc update_PARAM_VALUE.READ_WIDTH_A { PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.ALGORITHM PARAM_VALUE.AXI_SLAVE_TYPE  
  PARAM_VALUE.AXI_TYPE PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.ECC PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.ERROR_INJECTION_TYPE  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.PRIMITIVE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A } {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set Write_Depth_A_value [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
  set Primitive_value [ get_property value ${PARAM_VALUE.PRIMITIVE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Error_Injection_Type_value [ get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Read_Width_A  ${PARAM_VALUE.READ_WIDTH_A} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
   
  if {$Interface_Type_value == "AXI4" } {
 	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
      set newRange ""
		  if {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Memory_Slave"} {
        set newRange "32,64,128,256"
		  } elseif {$AXI_Type_value  == "AXI4_Full" && $AXI_Slave_Type_value == "Peripheral_Slave"} {
        set newRange "8,16,32,64,128,256"
		  } elseif {$AXI_Type_value == "AXI4_Lite" && $AXI_Slave_Type_value == "Memory_Slave"} {
        set newRange "32,64"
		  } else {
        set newRange "8,16,32,64"
		  }
      set_property range_value "$Write_Width_A_value,$newRange" $Read_Width_A
	  } else {		    	 
      set_property enabled true $Read_Width_A 
		  if {$AXI_Type_value == "AXI4_Full" } {
        set_property range_value "32,32,64,128,256" $Read_Width_A 
		  } else {
        set_property range_value "32,32,64" $Read_Width_A 
		  }  
	  }			   
  } else {
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Simple_Dual_Port_RAM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Single_Port_ROM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Dual_Port_ROM" } {
			  set_property enabled false $Read_Width_A 
			} elseif {( [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Single_Port_RAM" && [ get_property value ${PARAM_VALUE.ECC} ])} {
				set_property enabled false $Read_Width_A 
			} else {
			  set_property enabled true $Read_Width_A 
			}
			
			set_property range_value "[ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ],[ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]" $Read_Width_A  
	
	} else {
		if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM" } {
		  set_property enabled false $Read_Width_A 
		} elseif {(	$Memory_Type_value eq "Single_Port_RAM" && $ecctype_value == "BuiltIn_ECC") } {
		  set_property enabled true $Read_Width_A 
		} else {
		  set_property enabled true $Read_Width_A 
		}

			set read_width_a_list {}
			
			if {$Algorithm_value == "Minimum_Area" || $Algorithm_value == "Low_Power"} {
			  if {$Use_Byte_Write_Enable_value } {
				#Support ratios 4:1 to 1:4
				set narrow_bound [expr 4]
				set wide_bound [expr 4]
			  } else {
				#Support ratios 32:1 to 1:32
				set narrow_bound [expr 32]
				set wide_bound [expr 32]
			  }
			} elseif { $Algorithm_value  == "Fixed_Primitives" } {
			  if {$Use_Byte_Write_Enable_value } {
				#Narrow_Bound (Minimum Ratio):
				#   2kx9  has a minimum ratio of 1:1  (narrow_bound=1)
				#   1kx18 has a minimum ratio of 2:1  (narrow_bound=2)
				# 512kx36 has a minimum ratio of 4:1  (narrow_bound=4)
			
				#Wide_Bound (Maximum Ratio):
				#   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
				#   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
				# 512kx36 has a maximum ratio of 1:1  (wide_bound=1)
			
				switch $Primitive_value {
				  2kx9    { set narrow_bound 1; set wide_bound 4}
				  1kx18   { set narrow_bound 2; set wide_bound 2}
				  512x36  { set narrow_bound 4; set wide_bound 1}
				  default { set narrow_bound 1; set wide_bound 1}
				}
			  } else {
				#Narrow_Bound (Minimum Ratio):
				#  16kx1  has a minimum ratio of 1:1  (narrow_bound=1)
				#   8kx2  has a minimum ratio of 2:1  (narrow_bound=2)
				#   4kx4  has a minimum ratio of 4:1  (narrow_bound=4)
				#   2kx9  has a minimum ratio of 8:1  (narrow_bound=8)
				#   1kx18 has a minimum ratio of 16:1 (narrow_bound=16)
				# 512kx36 has a minimum ratio of 32:1 (narrow_bound=32)
			
				#Wide_Bound (Maximum Ratio):
				#  16kx1  has a maximum ratio of 1:32 (wide_bound=32)
				#   8kx2  has a maximum ratio of 1:16 (wide_bound=16)
				#   4kx4  has a maximum ratio of 1:8  (wide_bound=8)
				#   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
				#   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
				# 512kx36 has a maximum ratio of 1:1  (wide_bound=1)
			
				switch $Primitive_value {
				  32kx1  { set narrow_bound 1;  set wide_bound 32}
				  16kx1  { set narrow_bound 1;  set wide_bound 32}
				  8kx2   { set narrow_bound 2;  set wide_bound 16}
				  4kx4   { set narrow_bound 4;  set wide_bound 8}
				  2kx9   { set narrow_bound 8;  set wide_bound 4}
				  1kx18  { set narrow_bound 16; set wide_bound 2}
				  512x36 { set narrow_bound 32; set wide_bound 1}
				  default { set narrow_bound 1; set wide_bound 1}
				}
			  }
			}
		
		 # add primitives narrower than write_a to the list
		 for {set i $narrow_bound} {$i >= 2} {set i [expr $i/2]} {
		  #Check to see if we can divide the width evenly
			if {[ expr {$Write_Width_A_value % $i }] == 0} {
				#Check if the new depth would be too large
				if {[ expr {$Write_Depth_A_value  * $i }] <= [depth_max]} {
				  #Check if the width is above the min width
				  if {[ expr {$Write_Width_A_value / $i }] >= [width_min $Use_Byte_Write_Enable_value $Byte_Size_value $Error_Injection_Type_value]} {
						   #If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
						   if { ( ($Use_Byte_Write_Enable_value  && (($Write_Width_A_value / $i) % $Byte_Size_value)==0) )
								|| (!$Use_Byte_Write_Enable_value) } {
							  tcl::lappend read_width_a_list [expr { $Write_Width_A_value / $i}]
						   }
				  }
				}
			  }
			}
			tcl::lappend read_width_a_list $Write_Width_A_value
			
			# add primitives wider than write_a to the list
			for {set i 2} {$i <= $wide_bound} {set i [expr $i*2]} {
			  #Check to see if we can divide the depth evenly
			  if {[ expr {$Write_Depth_A_value  % $i }] == 0} {
				#Check if the new depth would be too small
				if {[ expr {$Write_Depth_A_value / $i }] >= [depth_min]} {
				  #Check if the width is below the max width
				  if {[ expr {$Write_Width_A_value * $i }] <= [width_max $Use_Byte_Write_Enable_value $Byte_Size_value]} {
					#If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
					if { ( ($Use_Byte_Write_Enable_value  && (($Write_Width_A_value * $i) % $Byte_Size_value)==0) )
					   || (!$Use_Byte_Write_Enable_value) } {
					   tcl::lappend read_width_a_list [expr { $Write_Width_A_value * $i}]
					}
				  }
				}
			  }
			}
			
		 set values ""
		 
		 foreach val $read_width_a_list {
		  append values "$val,"
		 }
			if { $values != "" && [lsearch $read_width_a_list $Write_Width_A_value] != -1 } {
			  set_property range_value "$Write_Width_A_value,$values" $Read_Width_A 
			}
	}
   }
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.READ_WIDTH_A}
      set_property value $Write_Width_A_value $Read_Width_A
	}

}

proc updateVisibilityOfREAD_WIDTH_A {IPINST PARAM_VALUE.AXI_TYPE 
  PARAM_VALUE.ECC PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.USE_BRAM_BLOCK } {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set Read_Width_A  [ipgui::get_guiparamspec Read_Width_A -of $IPINST]
   
	if {$Interface_Type_value == "AXI4" } {
 	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
		  set_property visible false $Read_Width_A 
	  } else {		    	 
		set_property visible true $Read_Width_A 
		  if {$AXI_Type_value == "AXI4_Full" } {
        set_property tooltip "32/64/128/256" $Read_Width_A 
		  } else {
        set_property tooltip "32/64" $Read_Width_A 
		  }  
	  }			   
	} else {
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Simple_Dual_Port_RAM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Single_Port_ROM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Dual_Port_ROM" } {
				  set_property visible false $Read_Width_A 
				} elseif {( [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Single_Port_RAM" && [ get_property value ${PARAM_VALUE.ECC} ])} {
					set_property visible true $Read_Width_A 
				} else {
				  set_property visible true $Read_Width_A 
				}
		} else {
			if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM" } {
			  set_property visible false $Read_Width_A 
			} elseif {( $Memory_Type_value eq "Single_Port_RAM" && $ecctype_value == "BuiltIn_ECC") } {
			  set_property visible true $Read_Width_A 
			} else {
			  set_property visible true $Read_Width_A 
			}
		}
	}
}

proc update_PARAM_VALUE.READ_WIDTH_B { PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.ALGORITHM PARAM_VALUE.AXI_SLAVE_TYPE  
  PARAM_VALUE.AXI_TYPE PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.ECC PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.ERROR_INJECTION_TYPE  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.PRIMITIVE PARAM_VALUE.READ_WIDTH_A  
  PARAM_VALUE.USE_BRAM_BLOCK  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
  PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B } {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Error_Injection_Type_value [ get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ]
  set Use_Byte_Write_Enable_value [ get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ]
  set Byte_Size_value [ get_property value ${PARAM_VALUE.BYTE_SIZE} ]
  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]
  set Primitive_value [ get_property value ${PARAM_VALUE.PRIMITIVE} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set Write_Depth_A_value [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
  set Read_Width_A_value [ get_property value ${PARAM_VALUE.READ_WIDTH_A} ]
  set Write_Width_B_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]
  set Read_Width_B  ${PARAM_VALUE.READ_WIDTH_B} 
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
   
  if {$Interface_Type_value == "AXI4" } {
	  if {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Memory_Slave"} {			  
		  set_property range_value "$Write_Width_A_value,32,64,128,256" $Read_Width_B
	  } elseif {$AXI_Type_value == "AXI4_Full" && $AXI_Slave_Type_value == "Peripheral_Slave"} {			   	
		  set_property range_value "$Write_Width_A_value,8,16,32,64,128,256" $Read_Width_B
	  } elseif {$AXI_Type_value == "AXI4_Lite" && $AXI_Slave_Type_value == "Memory_Slave"} {
		  set_property range_value "$Write_Width_A_value,32,64" $Read_Width_B
	  } else {
		  set_property range_value "$Write_Width_A_value,8,16,32,64" $Read_Width_B
	  }
    set_property enabled false $Read_Width_B      	
  } else {
	set_property enabled true $Read_Width_B 
	if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Simple_Dual_Port_RAM"
		    || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Dual_Port_ROM"} {
		      set_property enabled true $Read_Width_B 
		   } else {
		   }
		   
		   if { ([ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Simple_Dual_Port_RAM" && [ get_property value ${PARAM_VALUE.ECC} ]) } {
		      set_property enabled false $Read_Width_B 
		      set_property value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ] $Read_Width_B 
		   }
		   
		   if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
			set_property enabled false $Read_Width_B 
			}
		   set_property range_value "[ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ],[ get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]" $Read_Width_B  	
	} else {
		# Update this parameter's state
		set read_width_b_list {}
		
		if {$Algorithm_value == "Minimum_Area" || $Algorithm_value == "Low_Power"} {
		  if {$Use_Byte_Write_Enable_value } {
		    #Support ratios 4:1 to 1:4
		    set narrow_bound [expr 4]
		    set wide_bound [expr 4]
		  } else {
		    #Support ratios 32:1 to 1:32
		    set narrow_bound [expr 32]
		    set wide_bound [expr 32]
		  }
		
		  set narrow_width [expr {[min $Write_Width_A_value $Read_Width_A_value $Write_Width_B_value]}]
		  set wide_width   [expr {[max $Write_Width_A_value $Read_Width_A_value  $Write_Width_B_value]}]
		  set rda_value [read_depth_a_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]
		  set wdb_value [write_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]
		  set narrow_depth [expr {[max $Write_Depth_A_value $rda_value $wdb_value]}]
		  set wide_depth   [expr {[min $Write_Depth_A_value $rda_value $wdb_value]}]
		
		  set ratio [expr $wide_width / $narrow_width]
		
		} elseif { $Algorithm_value  == "Fixed_Primitives" } {
		  if {$Use_Byte_Write_Enable_value } {
		    #Narrow_Bound (Minimum Ratio):
		    #   2kx9  has a minimum ratio of 1:1  (narrow_bound=1)
		    #   1kx18 has a minimum ratio of 2:1  (narrow_bound=2)
		    # 512kx36 has a minimum ratio of 4:1  (narrow_bound=4)
		
		    #Wide_Bound (Maximum Ratio):
		    #   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
		    #   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
		    # 512kx36 has a maximum ratio of 1:1  (wide_bound=1)
		    switch $Primitive_value {
		      2kx9   { set narrow_bound 1; set wide_bound 4}
		      1kx18  { set narrow_bound 2; set wide_bound 2}
		      512x36 { set narrow_bound 4; set wide_bound 1}
		      default { set narrow_bound 1; set wide_bound 1}
		    }
		  } else {
		    #Narrow_Bound (Minimum Ratio):
		    #  16kx1  has a minimum ratio of 1:1  (narrow_bound=1)
		    #   8kx2  has a minimum ratio of 2:1  (narrow_bound=2)
		    #   4kx4  has a minimum ratio of 4:1  (narrow_bound=4)
		    #   2kx9  has a minimum ratio of 8:1  (narrow_bound=8)
		    #   1kx18 has a minimum ratio of 16:1 (narrow_bound=16)
		    # 512kx36 has a minimum ratio of 32:1 (narrow_bound=32)
		
		    #Wide_Bound (Maximum Ratio):
		    #  16kx1  has a maximum ratio of 1:32 (wide_bound=32)
		    #   8kx2  has a maximum ratio of 1:16 (wide_bound=16)
		    #   4kx4  has a maximum ratio of 1:8  (wide_bound=8)
		    #   2kx9  has a maximum ratio of 1:4  (wide_bound=4)
		    #   1kx18 has a maximum ratio of 1:2  (wide_bound=2)
		    # 512kx36 has a maximum ratio of 1:1  (wide_bound=1)

        switch $Primitive_value {
		      32kx1  { set narrow_bound 1;  set wide_bound 32}
		      16kx1  { set narrow_bound 1;  set wide_bound 32}
		      8kx2   { set narrow_bound 2;  set wide_bound 16}
		      4kx4   { set narrow_bound 4;  set wide_bound 8}
		      2kx9   { set narrow_bound 8;  set wide_bound 4}
		      1kx18  { set narrow_bound 16; set wide_bound 2}
		      512x36 { set narrow_bound 32; set wide_bound 1}
		      default { set narrow_bound 1; set wide_bound 1}
		    }
		  }
		
		  set narrow_width $Write_Width_A_value
		  set wide_width   $Write_Width_A_value
	
		  set narrow_depth $Write_Depth_A_value
		  set wide_depth   $Write_Depth_A_value

		  set ratio 1
		}

		# add primitives narrower than widest to the list
		for {set i $narrow_bound} {$i >= 2} {set i [expr $i/2]} {
		  #Check to see if we can divide the width evenly
		  if {[ expr $wide_width % $i ] == 0} {
		    #Check if the new depth would be too large
		    if {[ expr $wide_depth * $i ] <= [depth_max]} {
		      #Check if the width is above the min width
		      if {[ expr $wide_width / $i ] >= [width_min $Use_Byte_Write_Enable_value $Byte_Size_value $Error_Injection_Type_value]} {
		        #If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
		        if { ( ($Use_Byte_Write_Enable_value  && (($wide_width / $i) % $Byte_Size_value)==0) )
		                     || (!$Use_Byte_Write_Enable_value) } {
		          tcl::lappend read_width_b_list [expr { $wide_width / $i}]
		        }
		      }
		    }
		  }
		}
		
		# add primitives wider than narrowest to the list
		for {set i $ratio} {$i <= $wide_bound} {set i [expr $i*2]} {
		  #Check to see if we can divide the depth evenly
		  if {[ expr {$narrow_depth % $i }] == 0} {
		    #Check if the new depth would be too small
		    if {[ expr {$narrow_depth / $i }] >= [depth_min]} {
		      #Check if the width is below the max width
		      if {[ expr {$narrow_width * $i }] <= [width_max $Use_Byte_Write_Enable_value $Byte_Size_value]} {
		        #If we have byte_write enable, then verify that the width is a multiple of byte_size before adding it
		        if { ( ($Use_Byte_Write_Enable_value  && (($narrow_width * $i) % $Byte_Size_value)==0) )
		             || (!$Use_Byte_Write_Enable_value) } {
		          tcl::lappend read_width_b_list [expr { $narrow_width * $i}]
		        }
		      }
		    }
		  }
		}
		set values ""
		foreach val $read_width_b_list {
		  append values "$val,"
		}

		if {$values != "" && [lsearch $read_width_b_list $Write_Width_B_value] != -1  } {
			set_property range_value "$Write_Width_B_value,$values" $Read_Width_B 
		}
		
		if {$Memory_Type_value eq "Simple_Dual_Port_RAM"
		    || $Memory_Type_value eq "Dual_Port_ROM"} {
			set_property enabled true $Read_Width_B 
		} else {
		}
		
		if { ($Memory_Type_value eq "Simple_Dual_Port_RAM" && $ecctype_value == "BuiltIn_ECC" ) } {
			set_property enabled false $Read_Width_B 
			set_property value $Write_Width_A_value $Read_Width_B 
		}
		
		if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
			set_property enabled false $Read_Width_B 
		}
	}
  }

	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.READ_WIDTH_B}
      set_property value $Write_Width_A_value $Read_Width_B
	}

}

proc updateVisibilityOfREAD_WIDTH_B {IPINST PARAM_VALUE.ENABLE_32BIT_ADDRESS  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_BRAM_BLOCK  } {
  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Read_Width_B  [ipgui::get_guiparamspec Read_Width_B -of $IPINST]
  set Read_Width_B_Meta [ipgui::get_textspec Read_Width_B_Meta -of $IPINST]

	if {$Interface_Type_value == "AXI4" } {
		if {$Memory_Type_value eq "Simple_Dual_Port_RAM"   } {	
			set_property visible true $Read_Width_B  
			set_property visible true $Read_Width_B_Meta  
		} else {
			set_property visible false $Read_Width_B      	
			set_property visible false $Read_Width_B_Meta      	
		} 
	} else {
	
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Simple_Dual_Port_RAM"
				|| [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] eq "Dual_Port_ROM"} {
				set_property visible false $Read_Width_B 
				set_property visible false $Read_Width_B_Meta 
			} else {
				set_property visible true $Read_Width_B 
				set_property visible true $Read_Width_B_Meta 
			}
			   
			if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
			set_property visible false $Read_Width_B 
			set_property visible false $Read_Width_B_Meta 
			}

		} else {
			if {$Memory_Type_value eq "Simple_Dual_Port_RAM"
				|| $Memory_Type_value eq "Dual_Port_ROM"} {
				set_property visible false $Read_Width_B 
				set_property visible false $Read_Width_B_Meta 
			} else {
				set_property visible true $Read_Width_B 
				set_property visible true $Read_Width_B_Meta 
			}
			
			if { $Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM"} {
				set_property visible false $Read_Width_B 
				set_property visible false $Read_Width_B_Meta 
			}
		}
	}
}

proc update_PARAM_VALUE.RESET_TYPE { PARAM_VALUE.RESET_TYPE PARAM_VALUE.INTERFACE_TYPE 
  PARAM_VALUE.USE_RSTA_PIN PARAM_VALUE.USE_RSTB_PIN } {

  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Reset_Type  ${PARAM_VALUE.RESET_TYPE} 
      
  if {$Interface_Type_value == "Native" } {
      set_property enabled false $Reset_Type
      set_property value [get_property default_value $Reset_Type] $Reset_Type
  } else {
    set_property enabled false $Reset_Type
    set_property value "ASYNC" $Reset_Type
  }

}

proc update_PARAM_VALUE.USE_RSTA_PIN { PARAM_VALUE.USE_RSTA_PIN PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  PARAM_VALUE.ECC
  PARAM_VALUE.USE_BRAM_BLOCK} {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Use_RSTA_Pin  ${PARAM_VALUE.USE_RSTA_PIN} 

  if {$Interface_Type_value == "AXI4" } {
     set_property enabled false $Use_RSTA_Pin
     set_property value false $Use_RSTA_Pin
  } else { 
	   if {$ecctype_value == "BuiltIn_ECC" } {
       set_property enabled false $Use_RSTA_Pin
       set_property value false $Use_RSTA_Pin
	   } else {
       set_property enabled true $Use_RSTA_Pin
	   set_property value [get_property default_value $Use_RSTA_Pin] $Use_RSTA_Pin
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller"} {
			set_property value true $Use_RSTA_Pin
		}
	  }
	    if { [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Simple_Dual_Port_RAM" } {
			set_property value false $Use_RSTA_Pin
			set_property enabled false $Use_RSTA_Pin
	   } 
  }

}

proc update_PARAM_VALUE.RESET_PRIORITY_A { PARAM_VALUE.RESET_PRIORITY_A PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.RESET_MEMORY_LATCH_A PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_RSTA_PIN } {

# CR-520553
# The case Virtex-6 with special reset behaviour and Reset Priority set to SR
# can not be handled. Hence for this case Reset_Priority is set to CE
  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]
  set Reset_Memory_Latch_A_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_A} ]
  set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
  set Reset_Priority_A  ${PARAM_VALUE.RESET_PRIORITY_A} 

  if {$Interface_Type_value == "AXI4" && $Memory_Type_value == "Single_Port_ROM" } {
    set_property enabled false $Reset_Priority_A
    set_property value "CE" $Reset_Priority_A
  } else {
	  # This option is only available for the Virtex-6 and Spartan-6 architectures.
	  
	    # This option is selectable only if some output register stage has been
	    # selected ( Register Port A Output of Memory Primitive=1 and/or Register
	    # Port A Output of Memory Core=1) and if the Use RSTA Pin option is
	    # checked, otherwise it is grayed out.
	    if {( $Register_PortA_Output_of_Memory_Primitives_value ||
	      $Register_PortA_Output_of_Memory_Core_value) && $Use_RSTA_Pin_value } {
	      # For Virtex-6, if Reset Memory latch is selected i.e C_RSTRAM_A = 1,
	      #this option will not be selectable and have the value as "CE".
	      if { $Reset_Memory_Latch_A_value} {
          set_property enabled false $Reset_Priority_A
          set_property value "CE" $Reset_Priority_A
	      } else {
          set_property enabled true $Reset_Priority_A
	      }
	    } else {
        set_property enabled false $Reset_Priority_A
	    }
	
	
	  if {$Use_RSTA_Pin_value && ((( $Register_PortA_Output_of_Memory_Primitives_value ||
	            $Register_PortA_Output_of_Memory_Core_value
	         ) && !$Reset_Memory_Latch_A_value))} {
      set_property enabled true $Reset_Priority_A
	  } else {
      set_property enabled false $Reset_Priority_A
      set_property value "CE" $Reset_Priority_A
	  }
  }

}

proc updateVisibilityOfRESET_PRIORITY_A { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  IPINST } {

# CR-520553
# The case Virtex-6 with special reset behaviour and Reset Priority set to SR
# can not be handled. Hence for this case Reset_Priority is set to CE
  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Reset_Priority_A  [ipgui::get_guiparamspec Reset_Priority_A -of $IPINST]

	if {$Interface_Type_value == "AXI4" && $Memory_Type_value == "Single_Port_ROM" } {
	} else {
	  # This option is only available for the Virtex-6 and Spartan-6 architectures.
	  # if {[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} {
		# set_property visible true $Reset_Priority_A
	  # } else {
		# set_property visible false $Reset_Priority_A
	  # }
		set_property visible true $Reset_Priority_A
	}
}

proc update_PARAM_VALUE.USE_RSTB_PIN { PARAM_VALUE.USE_RSTB_PIN PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  PARAM_VALUE.ECC 
  PARAM_VALUE.USE_BRAM_BLOCK} {

  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set ecctype_value [ get_property value ${PARAM_VALUE.ECCTYPE} ]
  set Use_RSTB_Pin  ${PARAM_VALUE.USE_RSTB_PIN} 

  if {$Interface_Type_value == "AXI4" } {
    set_property enabled false $Use_RSTB_Pin
    set_property value true $Use_RSTB_Pin
    if {$Memory_Type_value == "Single_Port_ROM" } {
      set_property enabled false $Use_RSTB_Pin
      set_property value false $Use_RSTB_Pin
    }
  } else { 
	  if {$Memory_Type_value == "Single_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" 
       || $ecctype_value == "BuiltIn_ECC" || $ecctype_value == "Soft_ECC" } {
       set_property enabled false $Use_RSTB_Pin
       set_property value false $Use_RSTB_Pin
	  } else {
       set_property enabled true $Use_RSTB_Pin
	   set_property value [get_property default_value $Use_RSTB_Pin] $Use_RSTB_Pin
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property value true $Use_RSTB_Pin
		}
	  }
  }

}

proc update_PARAM_VALUE.RESET_PRIORITY_B { PARAM_VALUE.RESET_PRIORITY_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.RESET_MEMORY_LATCH_B PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_RSTB_PIN } {

# CR-520553
# The case Virtex-6 with special reset behaviour and Reset Priority set to SR
# can not be handled. Hence for this case Reset_Priority is set to CE
  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set Reset_Memory_Latch_B_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_B} ]
  set Reset_Priority_B  ${PARAM_VALUE.RESET_PRIORITY_B} 
   
  if {$Interface_Type_value == "AXI4" && $Memory_Type_value != "Single_Port_ROM" } {
    set_property enabled false $Reset_Priority_B
    set_property value "CE" $Reset_Priority_B
  } else {
	  # This option is only available for the Virtex-6 and Spartan-6 architectures.
	    
      if {$Use_RSTB_Pin_value && ( !$Reset_Memory_Latch_B_value) } {
        set_property enabled true $Reset_Priority_B
	    } else {
        set_property enabled false $Reset_Priority_B
        set_property value "CE" $Reset_Priority_B
      } 
    
  }

}

proc updateVisibilityOfRESET_PRIORITY_B { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  IPINST } {

# CR-520553
# The case Virtex-6 with special reset behaviour and Reset Priority set to SR
# can not be handled. Hence for this case Reset_Priority is set to CE
  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Reset_Priority_B  [ipgui::get_guiparamspec Reset_Priority_B -of $IPINST]
   
    if {$Interface_Type_value == "AXI4" && $Memory_Type_value != "Single_Port_ROM" } {
   
	} else {
	  # This option is only available for the Virtex-6 and Spartan-6 architectures.
		# if {[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} {
			# set_property visible true $Reset_Priority_B
        # } else {
			# set_property visible false $Reset_Priority_B
		# }
			set_property visible true $Reset_Priority_B
	}
}

proc update_PARAM_VALUE.RESET_MEMORY_LATCH_A { PARAM_VALUE.RESET_MEMORY_LATCH_A PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.USE_RSTA_PIN } {

  set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]
  set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
  set Reset_Memory_Latch_A  ${PARAM_VALUE.RESET_MEMORY_LATCH_A} 
#set Reset_Behaviour_A [ipgui::get_groupspec -name Reset_Behaviour_A -of $IPINST]

  if { $Use_RSTA_Pin_value && $Register_PortA_Output_of_Memory_Primitives_value
    &&!$Register_PortA_Output_of_Memory_Core_value} {
    set_property enabled true $Reset_Memory_Latch_A
#set_property enabled true $Reset_Behaviour_A
   } else {
#set_property enabled false $Reset_Behaviour_A
    set_property enabled false $Reset_Memory_Latch_A
    set_property value false $Reset_Memory_Latch_A
   }
}

proc update_gui_for_PARAM_VALUE.RESET_MEMORY_LATCH_A {PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.RESET_MEMORY_LATCH_A PARAM_VALUE.USE_RSTA_PIN IPINST } {
	set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]
	set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
	set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
	set Duration_of_Reset_Assertion_A [ipgui::get_textspec -name Duration_of_Reset_Assertion_A -of $IPINST]

   if { $Use_RSTA_Pin_value && $Register_PortA_Output_of_Memory_Primitives_value
    &&!$Register_PortA_Output_of_Memory_Core_value} {
   set_property visible true $Duration_of_Reset_Assertion_A
   set_property enabled true $Duration_of_Reset_Assertion_A
   } else {
    set_property visible false $Duration_of_Reset_Assertion_A
	set_property enabled false $Duration_of_Reset_Assertion_A
   }
}

proc update_PARAM_VALUE.RESET_MEMORY_LATCH_B { PARAM_VALUE.RESET_MEMORY_LATCH_B PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.USE_RSTB_PIN } {

  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set Register_PortB_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortB_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]
  set Reset_Memory_Latch_B  ${PARAM_VALUE.RESET_MEMORY_LATCH_B} 

  if { $Use_RSTB_Pin_value && $Register_PortB_Output_of_Memory_Primitives_value
    &&!$Register_PortB_Output_of_Memory_Core_value} {
    set_property enabled true $Reset_Memory_Latch_B
  } else {
    set_property enabled false $Reset_Memory_Latch_B
    set_property value false $Reset_Memory_Latch_B
  }

}

proc update_gui_for_PARAM_VALUE.RESET_MEMORY_LATCH_B {IPINST PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.USE_RSTB_PIN } {

  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set Register_PortB_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortB_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]
  set Duration_of_Reset_Assertion_B [ipgui::get_textspec -name Duration_of_Reset_Assertion_B -of $IPINST]

  if { $Use_RSTB_Pin_value && $Register_PortB_Output_of_Memory_Primitives_value
    &&!$Register_PortB_Output_of_Memory_Core_value} {
    set_property visible true $Duration_of_Reset_Assertion_B
	set_property enabled true $Duration_of_Reset_Assertion_B
  } else {
    set_property visible false $Duration_of_Reset_Assertion_B
	set_property enabled false $Duration_of_Reset_Assertion_B
  }

}

proc update_PARAM_VALUE.ENABLE_A { PARAM_VALUE.ENABLE_A PARAM_VALUE.ALGORITHM PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.USE_BRAM_BLOCK} {

  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]  
  set Enable_A  ${PARAM_VALUE.ENABLE_A}   
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  
  if {$Interface_Type_value == "AXI4" } {
    set_property value "Use_ENA_Pin" $Enable_A
    set_property enabled false $Enable_A
  } else {

	# Added_logic
		if {$Algorithm_value eq "Low_Power"} {
			set_property value "Use_ENA_Pin" $Enable_A
			set_property enabled false $Enable_A
		} else {

		if {([ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller")} {
			set_property value "Use_ENA_Pin" $Enable_A
			set_property enabled false $Enable_A
             } else {




			;# Fix for CR 708006
			set_property enabled true $Enable_A
			set_property range "Always_Enabled,Use_ENA_Pin" $Enable_A
			# set_property value [get_property default_value $Enable_A] $Enable_A
			# if {([ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller")} {
				# set_property value "Use_ENA_Pin" $Enable_A
			# }
		}
}
  }
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.ENABLE_A}
      set_property value "Use_ENA_Pin" $Enable_A
	}

}

proc update_PARAM_VALUE.ENABLE_B {PARAM_VALUE.ENABLE_B PARAM_VALUE.ALGORITHM PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.INTERFACE_TYPE  
  PARAM_VALUE.PRIM_type_to_Implement 
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_BRAM_BLOCK} {

  set Algorithm_value [ get_property value ${PARAM_VALUE.ALGORITHM} ]  
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]  
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]  
  set Enable_B  ${PARAM_VALUE.ENABLE_B}   
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  
  if {$Interface_Type_value == "AXI4" } {
    set_property value "Use_ENB_Pin" $Enable_B
    set_property enabled false $Enable_B
  } else {
    # Added_logic
    if {$Memory_Type_value eq "Single_Port_RAM" || $Memory_Type_value eq "Single_Port_ROM"} {
      set_property enabled false $Enable_B
      set_property value "Always_Enabled" $Enable_B
    } elseif {$Algorithm_value eq "Low_Power"} {
      set_property value "Use_ENB_Pin" $Enable_B
      set_property enabled false $Enable_B
    } else {
      if {([ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" )} {
        set_property enabled true $Enable_B
        set_property value "Use_ENB_Pin" $Enable_B
      } else {
        ;# Fix for CR 708006
        set_property enabled true $Enable_B
        set_property value "Use_ENB_Pin" $Enable_B
      }
    }
  }
	if { $ramtype ne "BRAM" } {
	  if {$Memory_Type_value ne "Single_Port_RAM" && $Memory_Type_value ne "Single_Port_ROM"} {
		set_property enabled false ${PARAM_VALUE.ENABLE_B}
      set_property value "Use_ENB_Pin" $Enable_B
     }
	}

}

proc update_PARAM_VALUE.COLLISION_WARNINGS { PARAM_VALUE.COLLISION_WARNINGS PARAM_VALUE.ENABLE_32BIT_ADDRESS  
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement } {

	set Collision_Warnings  ${PARAM_VALUE.COLLISION_WARNINGS} 
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	
	if {[ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Single_Port_ROM" || [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ] == "Dual_Port_ROM" || [ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller"} {
		set_property enabled false $Collision_Warnings 
		set_property value "ALL" $Collision_Warnings 
	} elseif { ( $ramtype ne "BRAM" )}  { 
 			set_property enabled false $Collision_Warnings 
	#	set_property value "NONE" $Collision_Warnings 
	} else {
		set_property enabled true $Collision_Warnings 
	}

}

#proc update_PARAM_VALUE.WRITE_DEPTH_A { PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
#  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE  
#  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_DEPTH_A  
#  PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.BYTE_SIZE} {
#
#  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
#  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
#  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
#  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
#  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
#  set Write_Depth_A  ${PARAM_VALUE.WRITE_DEPTH_A} 
#  
#  
#  if {$Interface_Type_value == "AXI4" && ($AXI_Type_value == "AXI4_Full" || $AXI_Type_value == "AXI4_Lite") && $AXI_Slave_Type_value == "Memory_Slave" } {
#	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } { 
#			switch $Write_Width_A_value {
#				32 {
#          set_property range_value "1024,1024,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A 
#					}
#				64 {
#          set_property range_value "512,512,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A 
#					}
#				128 {
#          set_property range_value "256,256,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A 
#					}
#				256 {
#          set_property range_value "128,128,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A 
#			   	}
#			}
#	  } else {
#	  }	   
#	} else {
#	    if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
#		set_property range "2,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A
#		set_property value 8192  ${PARAM_VALUE.WRITE_DEPTH_A} 
#	    } else {
#		set_property range "2,[getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]" $Write_Depth_A
#		#set_property value 16  ${PARAM_VALUE.WRITE_DEPTH_A}   ;# commented as fix for CR 724536
#   	    }
#		
#    		# set_property range "[depth_min],[getMaxWriteDepthA]" $Write_Depth_A
#	}
#}

proc update_PARAM_VALUE.WRITE_DEPTH_A { PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
   PARAM_VALUE.MEMORY_TYPE   PARAM_VALUE.USE_BRAM_BLOCK  
  PARAM_VALUE.WRITE_WIDTH_A  PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.BYTE_SIZE PROJECT_PARAM.ARCHITECTURE } {
  set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set Write_Width_A_value [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
  set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
  set Write_Depth_A  ${PARAM_VALUE.WRITE_DEPTH_A} 
  set bram_bits_count [ get_bram_bits_count ]
  #set max_write_depth [  getMaxWriteDepthA ${PARAM_VALUE.WRITE_WIDTH_A} ]
  set max_write_depth [getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]
 # set max_write_depth1 [ expr $bram_bits_count/  $Write_Width_A_value ]
 # if {$max_write_depth1 > $max_write_depth} { set max_write_depth $max_write_depth1 }
  #
   set bram_count [xit::get_device_data D_BRAM_COUNT -of [xit::current_scope]]
  if {$Interface_Type_value == "AXI4" && ($AXI_Type_value == "AXI4_Full" || $AXI_Type_value == "AXI4_Lite") && $AXI_Slave_Type_value == "Memory_Slave" } {
	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } { 
	
			switch $Write_Width_A_value {
				32 {
          set_property range_value "1024,1024,$max_write_depth" $Write_Depth_A 
					}
				64 {
          set_property range_value "512,512,$max_write_depth" $Write_Depth_A 
					}
				128 {
          set_property range_value "256,256,$max_write_depth" $Write_Depth_A 
					}
				256 {
          set_property range_value "128,128,$max_write_depth" $Write_Depth_A 
			   	}
			}
	  } else {
	  }	   
	} else {
	    if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		  set_property range "2 , $max_write_depth" $Write_Depth_A
          set writeDepthA [ get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]
          if {$writeDepthA == 16 || $writeDepthA < 2} {
              if {$bram_count < 6} {
                set_property value 1024  ${PARAM_VALUE.WRITE_DEPTH_A} 
              } else {
                set_property value 8192  ${PARAM_VALUE.WRITE_DEPTH_A} 
              }
          }
	    } else {
		set_property range "2 , $max_write_depth" $Write_Depth_A
   	    }
	}
}


proc updateVisibilityOfWRITE_DEPTH_A {IPINST PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
  PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE} {
	set Interface_Type_value [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	set AXI_Type_value [ get_property value ${PARAM_VALUE.AXI_TYPE} ]
	set AXI_Slave_Type_value [ get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ]
	set Write_Depth_A  [ipgui::get_guiparamspec Write_Depth_A -of $IPINST]
  
	if {$Interface_Type_value == "AXI4" && ($AXI_Type_value == "AXI4_Full" || $AXI_Type_value == "AXI4_Lite") && $AXI_Slave_Type_value == "Memory_Slave" } {
		if {$Memory_Type_value == "Simple_Dual_Port_RAM" } { 
			set_property visible true $Write_Depth_A 
		} else {
			set_property visible false $Write_Depth_A 
		}	   
	} else {
	    set_property visible true $Write_Depth_A 
	}
}

proc update_PARAM_VALUE.AXI_SLAVE_TYPE { PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE  
  PARAM_VALUE.INTERFACE_TYPE} {
 
  set AXI_Slave_Type_handle  ${PARAM_VALUE.AXI_SLAVE_TYPE} 
  
  
  if { [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] ==  "AXI4" } {	
    if { [ get_property value ${PARAM_VALUE.AXI_TYPE} ] !=  "AXI4_Full" } {	
      set_property value "Memory_Slave" $AXI_Slave_Type_handle    
    } else {
      set_property value "Memory_Slave" $AXI_Slave_Type_handle    
    }
  } else {
    set_property value "Memory_Slave" $AXI_Slave_Type_handle 
  }

}

proc update_PARAM_VALUE.AXI_ID_WIDTH { PARAM_VALUE.AXI_ID_WIDTH PARAM_VALUE.USE_AXI_ID PARAM_VALUE.INTERFACE_TYPE} {

  set AXI_ID_Width_handle  ${PARAM_VALUE.AXI_ID_WIDTH} 
  if { [get_property value ${PARAM_VALUE.INTERFACE_TYPE}] != "Native" } {
	  if { [ get_property value ${PARAM_VALUE.USE_AXI_ID} ] } {
    	set_property enabled true $AXI_ID_Width_handle
	  } else {
    	set_property enabled false $AXI_ID_Width_handle 
	  }
  } else {
  	set_property value [get_property default_value $AXI_ID_Width_handle] $AXI_ID_Width_handle
  }

}

proc update_PARAM_VALUE.PIPELINE_STAGES {PARAM_VALUE.PIPELINE_STAGES PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK   
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.OPERATING_MODE_A PARAM_VALUE.OPERATING_MODE_B  
  PARAM_VALUE.PRIMITIVE  
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
  PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.Operating_Mode_A PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
  PARAM_VALUE.Operating_Mode_B PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B } {
	
	set Pipeline_Stages ${PARAM_VALUE.PIPELINE_STAGES}
	set mux_size [getMuxSize ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A} ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}]

	set mem_type [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
	set regA [get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE}]
	set regB [get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE}]
  
	if { ($mux_size > 1) &&
		      (((($mem_type == "Single_Port_RAM") || ($mem_type == "Single_Port_ROM")) && $regA ) || (($mem_type == "Simple_Dual_Port_RAM") && $regB ) || ((($mem_type == "True_Dual_Port_RAM") || ($mem_type == "Dual_Port_ROM")) && ($regA && $regB )))} {
		# will add $rams_used (or an equivalent value from a new c function that returns the number of primitives in depth)
		# to the above condition later when the feature restriction is removed
		if {[ get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ] || [ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
			set_property enabled false $Pipeline_Stages
		} else {
			set_property enabled true $Pipeline_Stages
		}
       # set_property enabled true $Pipeline_Stages
	} else {
       set_property enabled false $Pipeline_Stages
       set_property value 0 $Pipeline_Stages
	}
}

proc update_PARAM_VALUE.MEMORY_TYPE {PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.USE_BRAM_BLOCK } {
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	#send_msg INFO 9123 "adf " 
	if {$Interface_Type_value == "AXI4" } {
		set_property range_value "Simple_Dual_Port_RAM,Simple_Dual_Port_RAM" ${PARAM_VALUE.MEMORY_TYPE}
	} else {
		if {[get_property value ${PARAM_VALUE.USE_BRAM_BLOCK}] == "BRAM_Controller" } {
			set_property range "Single_Port_RAM,True_Dual_Port_RAM,Single_Port_ROM,Dual_Port_ROM" ${PARAM_VALUE.MEMORY_TYPE}
		} else {
			set_property range "Single_Port_RAM,Simple_Dual_Port_RAM,True_Dual_Port_RAM,Single_Port_ROM,Dual_Port_ROM" ${PARAM_VALUE.MEMORY_TYPE}
		}
	}
}

proc update_PARAM_VALUE.PRIM_type_to_Implement {PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.MEMORY_TYPE PROJECT_PARAM.ARCHITECTURE} {
    set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
    set memtype [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
    set uram_count [xit::get_device_data D_URAM_COUNT -of [xit::current_scope]]
	if {($memtype == "Single_Port_ROM") || ($memtype == "Dual_Port_ROM") } {
		set_property value "BRAM" ${PARAM_VALUE.PRIM_type_to_Implement}
		set_property enabled false ${PARAM_VALUE.PRIM_type_to_Implement}
	} else {
    if {[ is_diablo ${PROJECT_PARAM.ARCHITECTURE} ] && $uram_count <= 0} { 
            set_property value "BRAM"  ${PARAM_VALUE.PRIM_type_to_Implement}
		set_property enabled false ${PARAM_VALUE.PRIM_type_to_Implement}
	} else {
		set_property enabled true ${PARAM_VALUE.PRIM_type_to_Implement}
        }
    }
}


proc update_PARAM_VALUE.EN_SHUTDOWN_PIN  {  PARAM_VALUE.EN_SHUTDOWN_PIN PARAM_VALUE.PRIM_type_to_Implement} {
set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
       if { $ramtype ne "BRAM" } {
       set_property enabled  false  ${PARAM_VALUE.EN_SHUTDOWN_PIN}  
        } else {
		set_property enabled  false  ${PARAM_VALUE.EN_SHUTDOWN_PIN} 
		}
}
proc update_PARAM_VALUE.EN_DEEPSLEEP_PIN  {   PARAM_VALUE.EN_DEEPSLEEP_PIN PARAM_VALUE.PRIM_type_to_Implement} {
set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
       if { $ramtype ne "BRAM" } { 
       set_property enabled  false  ${PARAM_VALUE.EN_DEEPSLEEP_PIN}  
        } else {
		set_property enabled  false  ${PARAM_VALUE.EN_DEEPSLEEP_PIN} 
		}
		

}

 proc update_param_value.RD_ADDR_CHNG_A { PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.Assume_Synchronous_Clk PARAM_VALUE.RD_ADDR_CHNG_A PROJECT_PARAM.ARCHITECTURE}  { 
    set com_clk [get_property value  ${PARAM_VALUE.Assume_Synchronous_Clk} ]

if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus") && ($com_clk) } {
			set_property enabled true  ${PARAM_VALUE.RD_ADDR_CHNG_A}
	} else { 
			set_property enabled false  ${PARAM_VALUE.RD_ADDR_CHNG_A}
			set_property value false    ${PARAM_VALUE.RD_ADDR_CHNG_A}
	} 
}
proc update_param_value.RD_ADDR_CHNG_B { PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.RD_ADDR_CHNG_A PARAM_VALUE.Assume_Synchronous_Clk PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.RD_ADDR_CHNG_B PROJECT_PARAM.ARCHITECTURE}  { 
    set com_clk [get_property value  ${PARAM_VALUE.Assume_Synchronous_Clk} ]
	set xcoValue [  get_property value ${PARAM_VALUE.MEMORY_TYPE} ] 
	set rd_addr_chg_a [  get_property value ${PARAM_VALUE.RD_ADDR_CHNG_A} ] 

  if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu"|| ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" ) && ($com_clk) && (($xcoValue ne "Single_Port_RAM" || $xcoValue ne "Single_Port_ROM")
 )  } {
    set_property enabled false  ${PARAM_VALUE.RD_ADDR_CHNG_B}
	set_property value $rd_addr_chg_a  ${PARAM_VALUE.RD_ADDR_CHNG_B}
  } else { 
    set_property enabled false  ${PARAM_VALUE.RD_ADDR_CHNG_B}
    set_property value false    ${PARAM_VALUE.RD_ADDR_CHNG_B}
  } 
}
proc update_PARAM_VALUE.ECCTYPE {PARAM_VALUE.ECCTYPE PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.PRIM_type_to_Implement } {
	
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Memory_Type_value [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
   set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
   set enable_32bit_address [get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS}]
	
	if {$Interface_Type_value == "AXI4" } {
		set_property range_value "No_ECC,No_ECC,BuiltIn_ECC" ${PARAM_VALUE.ECCTYPE} 
		set_property enabled true ${PARAM_VALUE.ECCTYPE}
	} else {
	  	if { !$enable_32bit_address} {
			# if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
			  # set_property range_value "No_ECC,No_ECC,Soft_ECC,BuiltIn_ECC"  ${PARAM_VALUE.ECCTYPE}
			# } else {
			  # set_property value [get_property default_value ${PARAM_VALUE.ECCTYPE}] ${PARAM_VALUE.ECCTYPE}
			# }
			  set_property range_value "No_ECC,No_ECC,Soft_ECC,BuiltIn_ECC"  ${PARAM_VALUE.ECCTYPE}
			} else {
			  set_property value [get_property default_value ${PARAM_VALUE.ECCTYPE}] ${PARAM_VALUE.ECCTYPE}
			}
	}
	
	if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
	  	if { !$enable_32bit_address} {
	  		set_property enabled true ${PARAM_VALUE.ECCTYPE} 
		} else {
	  		set_property enabled false ${PARAM_VALUE.ECCTYPE} 
		}
	} else {
		set_property enabled false ${PARAM_VALUE.ECCTYPE}
		set_property value [get_property default_value ${PARAM_VALUE.ECCTYPE}] ${PARAM_VALUE.ECCTYPE}
	}
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.ECCTYPE}
		set_property value [get_property default_value ${PARAM_VALUE.ECCTYPE}] ${PARAM_VALUE.ECCTYPE}
	}
}

proc update_PARAM_VALUE.AXI_TYPE {PARAM_VALUE.AXI_TYPE PARAM_VALUE.INTERFACE_TYPE } {
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set AXI_Type_handle ${PARAM_VALUE.AXI_TYPE}
	
	if {$Interface_Type_value == "AXI4" } {
		set_property value [get_property default_value $AXI_Type_handle] $AXI_Type_handle
	} else {
		set_property value [get_property value $AXI_Type_handle] $AXI_Type_handle
	}
}

proc update_PARAM_VALUE.SOFTECC {PARAM_VALUE.SOFTECC PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ECCTYPE} {
	set Memory_Type_value [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	
	if {$Interface_Type_value == "AXI4" } {
		set_property value false ${PARAM_VALUE.SOFTECC} 
	}
	
	if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
		set_property enabled true ${PARAM_VALUE.SOFTECC} 
	} else {
		set_property enabled false ${PARAM_VALUE.SOFTECC} 
		set_property value false ${PARAM_VALUE.SOFTECC} 
	}
	
	if { $ecctype_value == "No_ECC" } {
		set_property value false ${PARAM_VALUE.SOFTECC} 
	} elseif { $ecctype_value == "Soft_ECC" } {
		set_property value true ${PARAM_VALUE.SOFTECC} 
	} else {
		set_property value false ${PARAM_VALUE.SOFTECC} 
	}
}

proc update_PARAM_VALUE.ECC {PARAM_VALUE.ECC PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ECCTYPE} {
	set Memory_Type_value [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	
	if {$Interface_Type_value == "AXI4" } {
		set_property value false ${PARAM_VALUE.ECC} 
	}
	
	if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
		set_property enabled true ${PARAM_VALUE.ECC} 
	} else {
		set_property enabled false ${PARAM_VALUE.ECC} 
		set_property value  [get_property default_value ${PARAM_VALUE.ECC}] ${PARAM_VALUE.ECC} 
	}
	
	if { $ecctype_value == "No_ECC" } {
		set_property value false ${PARAM_VALUE.ECC} 
	} elseif { $ecctype_value == "Soft_ECC" } {
		set_property value false ${PARAM_VALUE.ECC} 
	} else {
		set_property value true ${PARAM_VALUE.ECC} 
	}
}

proc update_gui_for_PARAM_VALUE.INTERFACE_TYPE {PARAM_VALUE.INTERFACE_TYPE  IPINST PARAM_VALUE.ECCTYPE PARAM_VALUE.MEMORY_TYPE} {
	set ECCOptionsGroupBox_handle [ipgui::get_groupspec -name ECCOptionsGroupBox -of $IPINST]
	set Page2_handle [ipgui::get_pagespec -name "Page 2" -of $IPINST]
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Reset_Type [ipgui::get_guiparamspec Reset_Type -of $IPINST]
	
	if {$Interface_Type_value == "AXI4" } {
		set_property visible false $ECCOptionsGroupBox_handle
		set_property visible true $Page2_handle
		set_property visible false $Reset_Type
	} else {
		# set_property visible  [expr {( [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}])? true:false }]  $ECCOptionsGroupBox_handle
		set_property visible true $ECCOptionsGroupBox_handle
		set_property visible false $Page2_handle
		# if {[isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}]} {
			# set_property visible false $Reset_Type
		# }
			set_property visible false $Reset_Type
		}
	
	updateVisibilityOfWRITE_WIDTH_BandWRITE_DEPTH_B $IPINST ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} 
	updateVisibilityOfERROR_INJECTION_TYPE $IPINST ${PARAM_VALUE.INTERFACE_TYPE} 
	updateVisibilityOfENABLE_32BIT_ADDRESS $IPINST ${PARAM_VALUE.INTERFACE_TYPE} 
	updateVisibilityOfUSE_ERROR_INJECTION_PINS $IPINST ${PARAM_VALUE.INTERFACE_TYPE} 
	updateVisibilityOfRESET_PRIORITY_A ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} $IPINST 
	updateVisibilityOfRESET_PRIORITY_B ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} $IPINST 
}

proc updateread_depth_a {Memory_Type_value Interface_Type_value Read_Depth_A ReadDepthA} {
  if {$Interface_Type_value != "AXI4" } { 
	  if { $Memory_Type_value == "Single_Port_RAM"
	     || $Memory_Type_value == "True_Dual_Port_RAM" } {
      set_property visible true $Read_Depth_A 
      set_property visible true $ReadDepthA 
	  } else {
      set_property visible false $Read_Depth_A 
      set_property visible false $ReadDepthA 
	  }
  } else {
	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
      set_property visible false $Read_Depth_A 
      set_property visible false $ReadDepthA 
	  } else {
      set_property visible true $Read_Depth_A 
      set_property visible true $ReadDepthA 
	  }
  }
}

proc updateread_depth_b {Memory_Type_value Interface_Type_value Read_Depth_B} {
  if {$Interface_Type_value != "AXI4" } { 
	  if { $Memory_Type_value == "Simple_Dual_Port_RAM"
	     || $Memory_Type_value == "Dual_Port_ROM" } {
      set_property visible false $Read_Depth_B 
	  } else {
      set_property visible true $Read_Depth_B 
	  }
  } else {
	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
      set_property visible true $Read_Depth_B 
	  } else {
      set_property visible false $Read_Depth_B 
	  }
  }
}

proc update_meta_total_latency_portA {mem_type total_latency_portA} {
  if { ($mem_type == "Single_Port_RAM") || ($mem_type == "Single_Port_ROM") || ($mem_type == "True_Dual_Port_RAM") || ($mem_type == "Dual_Port_ROM")} {
    set_property visible true $total_latency_portA
  } else {
    set_property visible false $total_latency_portA
  }
}

proc update_meta_total_latency_portB {mem_type total_latency_portB} {
  if { ($mem_type == "Simple_Dual_Port_RAM") || ($mem_type == "True_Dual_Port_RAM") || ($mem_type == "Dual_Port_ROM") } {
    set_property visible true $total_latency_portB
  } else {
    set_property visible false $total_latency_portB
  }
}


proc update_gui {IPINST PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ECCTYPE PARAM_VALUE.ECC PARAM_VALUE.SOFTECC PARAM_VALUE.WRITE_WIDTH_A
	PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES  
   PARAM_VALUE.USE_RSTA_PIN PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK  PARAM_VALUE.AXI_SLAVE_TYPE PARAM_VALUE.AXI_TYPE PARAM_VALUE.PRIM_type_to_Implement} {
	
    set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	;# Reverted fix for CR: 733519
	if {[ipgui::get_xpg_context -of $IPINST] == "xpg_bd"} {
		set_property visible true [ipgui::get_guiparamspec Enable_32bit_Address -of $IPINST]
	} else {
		set_property visible true [ipgui::get_guiparamspec Enable_32bit_Address -of $IPINST]
	}
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Memory_Type_value [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
	set Read_Depth_A [ipgui::get_textspec -name "Read_Depth_A" -of $IPINST]
	set ReadDepthA [ipgui::get_textspec -name "ReadDepthA" -of $IPINST]
	updateread_depth_a $Memory_Type_value $Interface_Type_value $Read_Depth_A $ReadDepthA
	
	set Read_Depth_B [ipgui::get_textspec -name "Read_Depth_B" -of $IPINST]
	updateread_depth_b $Memory_Type_value $Interface_Type_value $Read_Depth_B
	
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
		set_property visible true [ipgui::get_groupspec -name Output_Reset_B -of $IPINST]
		set_property visible true [ipgui::get_pagespec -name "Page 4" -of $IPINST]
	} else {
		set memory_value [expr {![string match "Single_Port_*" $Memory_Type_value] ? true : false }]
        if {$ramtype ne "BRAM" } {	
		  set_property visible false [ipgui::get_groupspec -name Output_Reset_B -of $IPINST]
		} else {
          set_property visible $memory_value [ipgui::get_groupspec -name Output_Reset_B -of $IPINST]
		}
		set_property visible true [ipgui::get_pagespec -name "Page 4" -of $IPINST]
	}
	
	set WriteEnableGroupBox [ipgui::get_groupspec -name "WriteEnableGroupBox" -of $IPINST]
	set ECC_value [get_property value ${PARAM_VALUE.ECC}]
	set softecc_value [get_property value ${PARAM_VALUE.SOFTECC}]

	if {($ECC_value ) || ($softecc_value )} {
		set_property visible false $WriteEnableGroupBox 
	} else {
		set_property visible true $WriteEnableGroupBox 
	}
	
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Estimated_Power_for_IP [ipgui::get_textspec -name Estimated_Power_for_IP -of $IPINST]
	set PortA_Group [ipgui::get_groupspec -name PortA_Group -of $IPINST]
	set PortB_Group [ipgui::get_groupspec -name PortB_Group -of $IPINST]
	set Port_A_Enable_Rate  [ipgui::get_guiparamspec Port_A_Enable_Rate -of $IPINST]
	set Port_B_Enable_Rate  [ipgui::get_guiparamspec Port_B_Enable_Rate -of $IPINST]
	set Port_A_Write_Rate  [ipgui::get_guiparamspec Port_A_Write_Rate -of $IPINST]
	set Port_B_Write_Rate  [ipgui::get_guiparamspec Port_B_Write_Rate -of $IPINST]
	set Port_A_Clock  [ipgui::get_guiparamspec Port_A_Clock -of $IPINST]
	set Port_B_Clock  [ipgui::get_guiparamspec Port_B_Clock -of $IPINST]
	
	set use_calculator $Additional_Inputs_for_Power_Estimation_value
	set_property visible $use_calculator $Port_A_Clock 
	set_property visible $use_calculator $Port_A_Write_Rate
	set_property visible $use_calculator $Port_A_Enable_Rate
	set_property visible $use_calculator $PortA_Group 
	set_property visible $use_calculator $Port_B_Clock 
	set_property visible $use_calculator $PortB_Group
	
	set var [expr ($use_calculator && (![string match "Single_Port_*" $Memory_Type_value] || ![string match "Dual_Port_*" $Memory_Type_value]))?true:false]
	set_property visible $var $Port_B_Write_Rate
	set var1 [expr ($use_calculator && ![string match "Single_Port_*" $Memory_Type_value])?true:false]
	set_property visible $var1 $Port_B_Enable_Rate
	
	if {$Memory_Type_value eq "Single_Port_ROM" || $Memory_Type_value eq "Dual_Port_ROM" } {
		set_property visible false $Port_A_Write_Rate
	}
	if {[string match "Single_Port_*" $Memory_Type_value]} {
		set_property visible false $Port_B_Clock
		set_property visible false $PortB_Group
	}

	if {$Memory_Type_value eq "Single_Port_RAM" || $Memory_Type_value eq "Single_Port_ROM" || $Memory_Type_value eq "Dual_Port_ROM" } {
		set_property visible false $Port_B_Write_Rate
	}
	set_property visible [expr ${use_calculator}?true:false] $Estimated_Power_for_IP
	
	updateVisibilityOfUSE_BYTE_WRITE_ENABLE ${PARAM_VALUE.ECC} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BRAM_BLOCK} $IPINST 
	updateVisibilityOfCTRL_ECC_ALGO ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.WRITE_WIDTH_A} $IPINST
	updateVisibilityOfWRITE_WIDTH_A ${PARAM_VALUE.AXI_SLAVE_TYPE} ${PARAM_VALUE.AXI_TYPE} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.USE_BRAM_BLOCK} $IPINST
	updateVisibilityOfREAD_WIDTH_A $IPINST ${PARAM_VALUE.AXI_TYPE} ${PARAM_VALUE.ECC} ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.USE_BRAM_BLOCK} 
	updateVisibilityOfREAD_WIDTH_B $IPINST ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.USE_BRAM_BLOCK}
	updateVisibilityOfWRITE_DEPTH_A $IPINST ${PARAM_VALUE.AXI_SLAVE_TYPE} ${PARAM_VALUE.AXI_TYPE} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE}
}

proc update_gui_for_PARAM_VALUE.MEMORY_TYPE {PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.PRIM_type_to_Implement IPINST PARAM_VALUE.ECCTYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK } {
	set Memory_Type_value [get_property value ${PARAM_VALUE.MEMORY_TYPE}]
	set total_latency_portA [ipgui::get_textspec -name total_latency_portA -of $IPINST]
     set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	update_meta_total_latency_portA  $Memory_Type_value $total_latency_portA
	
	set total_latency_portB [ipgui::get_textspec -name total_latency_portB -of $IPINST]
	update_meta_total_latency_portB $Memory_Type_value $total_latency_portB
	
	set hidePortB [expr {![string match "Single_Port_*" $Memory_Type_value]?true:false}]
	# set_property visible $hidePortB [ipgui::get_groupspec -name Port_B_Options -of $IPINST]
	set_property visible $hidePortB [ipgui::get_pagespec -name Page5 -of $IPINST]
	set_property visible $hidePortB [ipgui::get_groupspec -name Memory_Size_B -of $IPINST]
	set_property visible $hidePortB [ipgui::get_guiparamspec -name Operating_Mode_B -of $IPINST]
	set_property visible $hidePortB [ipgui::get_guiparamspec -name Enable_B -of $IPINST]
	set_property visible $hidePortB [ipgui::get_groupspec -name Port_B_Registers -of $IPINST]

    if { $ramtype ne "BRAM" } {
	    set_property visible false [ipgui::get_groupspec -name Output_Reset_B -of $IPINST]
	    if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
	        set_property visible false [ipgui::get_guiparamspec -name READ_LATENCY_A -of $IPINST]
       } else {
	        set_property visible true [ipgui::get_guiparamspec -name READ_LATENCY_A -of $IPINST]
       }
	    set_property visible true [ipgui::get_guiparamspec -name READ_LATENCY_B -of $IPINST]
	} else {
	    set_property visible $hidePortB [ipgui::get_groupspec -name Output_Reset_B -of $IPINST]
	    set_property visible false  [ipgui::get_guiparamspec -name READ_LATENCY_A -of $IPINST]
	    set_property visible false  [ipgui::get_guiparamspec -name READ_LATENCY_B -of $IPINST]
    }	
	set_property visible $hidePortB [ipgui::get_textspec -name Address_Width_B -of $IPINST]
	updateVisibilityOfWRITE_WIDTH_BandWRITE_DEPTH_B $IPINST ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} 
	updateVisibilityOfOPERATING_MODE_A $IPINST ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  ${PARAM_VALUE.MEMORY_TYPE} 
	updateVisibilityOfOPERATING_MODE_B $IPINST ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  ${PARAM_VALUE.MEMORY_TYPE} 
	updateVisibilityOfRESET_PRIORITY_A ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} $IPINST 
	updateVisibilityOfRESET_PRIORITY_B ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} $IPINST 

	if { $Memory_Type_value == "Simple_Dual_Port_RAM" } {
		set_property tooltip "Defines the Port B width. This width may be a ratio from the port A write width. See the datasheet for supported aspect ratios." [ipgui::get_guiparamspec Write_Width_B -of $IPINST]
	} else {
		set_property tooltip "Defines the Port B write width (DINB). This width may be a ratio from the port A write width. See the datasheet for supported aspect ratios." [ipgui::get_guiparamspec Write_Width_B -of $IPINST]
	}
}

proc update_gui_for_PARAM_VALUE.ECCTYPE {PARAM_VALUE.ECCTYPE IPINST PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE} {
	set Algorithm_group [ipgui::get_groupspec -name "Algorithm_Options" -of $IPINST]
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
   set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	
	if { $ecctype_value == "No_ECC" } {
		set_property enabled true $Algorithm_group 
		set_property visible true $Algorithm_group
	} elseif { $ecctype_value == "Soft_ECC" } {
		set_property enabled true $Algorithm_group 
		set_property visible true $Algorithm_group
	} else {
		set_property enabled false $Algorithm_group 
		set_property visible false $Algorithm_group 
	}
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.ECCTYPE}
		set_property value [get_property default_value ${PARAM_VALUE.ECCTYPE}] ${PARAM_VALUE.ECCTYPE}
		set_property visible false $Algorithm_group
	}
	
	set Memory_InitializationGroup [ipgui::get_groupspec -name Memory_InitializationGroup -of $IPINST]

	if { $ecctype_value ==  "BuiltIn_ECC" || $ecctype_value ==  "Soft_ECC" } {
		set_property visible false $Memory_InitializationGroup
	} else {
		set_property visible true $Memory_InitializationGroup
	}
	updateVisibilityOfWRITE_WIDTH_BandWRITE_DEPTH_B $IPINST ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} 
	updateVisibilityOfFILL_REMAINING_MEMORY_LOCATIONS $IPINST ${PARAM_VALUE.ECCTYPE} 
}

proc update_PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC {PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC PARAM_VALUE.ECCTYPE } {
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	if { $ecctype_value != "Soft_ECC" } {
		set_property value false ${PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC} 
		set_property enabled false ${PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC} 
	} else {
		set_property enabled true ${PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC} 
	}
}

proc update_PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC {PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC PARAM_VALUE.ECCTYPE } {
	set ecctype_value [get_property value ${PARAM_VALUE.ECCTYPE}]
	if { $ecctype_value != "Soft_ECC" } {
		set_property value false ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC} 
		set_property enabled false ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC} 
	} else {
		set_property enabled true ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC} 
	}
}

proc update_PARAM_VALUE.PORT_A_CLOCK {PARAM_VALUE.PORT_A_CLOCK PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_A_Clock  ${PARAM_VALUE.PORT_A_CLOCK} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 100 $Port_A_Clock
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 100 $Port_A_Clock
	} elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 100 $Port_A_Clock
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 100 $Port_A_Clock
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 100 $Port_A_Clock
	}
}

proc update_PARAM_VALUE.PORT_B_CLOCK {PARAM_VALUE.PORT_B_CLOCK PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_B_Clock  ${PARAM_VALUE.PORT_B_CLOCK} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 0 $Port_B_Clock
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 100 $Port_B_Clock
    } elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 100 $Port_B_Clock
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 0 $Port_B_Clock
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 100 $Port_B_Clock
	}
}

proc update_PARAM_VALUE.PORT_A_WRITE_RATE {PARAM_VALUE.PORT_A_WRITE_RATE PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_A_Write_Rate  ${PARAM_VALUE.PORT_A_WRITE_RATE} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 50 $Port_A_Write_Rate
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 50 $Port_A_Write_Rate
	} elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 50 $Port_A_Write_Rate
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 0 $Port_A_Write_Rate
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 0 $Port_A_Write_Rate
	}
}

proc update_PARAM_VALUE.PORT_B_WRITE_RATE {PARAM_VALUE.PORT_B_WRITE_RATE PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_B_Write_Rate  ${PARAM_VALUE.PORT_B_WRITE_RATE} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 0 $Port_B_Write_Rate
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 0 $Port_B_Write_Rate
		set_property enabled false $Port_B_Write_Rate
	} elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 50 $Port_B_Write_Rate
		set_property enabled true $Port_B_Write_Rate
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 0 $Port_B_Write_Rate
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 0 $Port_B_Write_Rate
	}
}

proc update_PARAM_VALUE.PORT_A_ENABLE_RATE {PARAM_VALUE.PORT_A_ENABLE_RATE PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_A_Enable_Rate  ${PARAM_VALUE.PORT_A_ENABLE_RATE} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 100 $Port_A_Enable_Rate
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 100 $Port_A_Enable_Rate
	} elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 100 $Port_A_Enable_Rate
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 100 $Port_A_Enable_Rate
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 100 $Port_A_Enable_Rate
	}
}

proc update_PARAM_VALUE.PORT_B_ENABLE_RATE {PARAM_VALUE.PORT_B_ENABLE_RATE PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION PARAM_VALUE.MEMORY_TYPE} {
	set Port_B_Enable_Rate  ${PARAM_VALUE.PORT_B_ENABLE_RATE} 
	set Additional_Inputs_for_Power_Estimation_value [ get_property value ${PARAM_VALUE.ADDITIONAL_INPUTS_FOR_POWER_ESTIMATION} ]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value eq "Single_Port_RAM"} {
		set_property value 0 $Port_B_Enable_Rate
	} elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM" } {
		set_property value 100 $Port_B_Enable_Rate
	} elseif {$Memory_Type_value eq "True_Dual_Port_RAM" } {
		set_property value 100 $Port_B_Enable_Rate
	} elseif {$Memory_Type_value eq "Single_Port_ROM"} {
		set_property value 0 $Port_B_Enable_Rate
	} elseif {$Memory_Type_value eq "Dual_Port_ROM"} {
		set_property value 100 $Port_B_Enable_Rate
	}
}

proc update_PARAM_VALUE.EN_ECC_PIPE {PARAM_VALUE.EN_ECC_PIPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.ecctype PROJECT_PARAM.ARCHITECTURE} {
	if {(${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") && ([get_property value ${PARAM_VALUE.ecctype}] == "BuiltIn_ECC") && ([get_property value ${PARAM_VALUE.MEMORY_TYPE}] == "Simple_Dual_Port_RAM") } {
		set_property enabled true ${PARAM_VALUE.EN_ECC_PIPE}
	} else {
		set_property value false ${PARAM_VALUE.EN_ECC_PIPE}
		set_property enabled false ${PARAM_VALUE.EN_ECC_PIPE}
	}
}

proc update_PARAM_VALUE.EN_SLEEP_PIN {PARAM_VALUE.EN_SLEEP_PIN PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.ENABLE_A PARAM_VALUE.ENABLE_B PARAM_VALUE.MEMORY_TYPE PROJECT_PARAM.ARCHITECTURE} {
	
	set Interface_Type_value [get_property value ${PARAM_VALUE.INTERFACE_TYPE}]
	set Enable_A [get_property value ${PARAM_VALUE.ENABLE_A}]
	set Enable_B [get_property value ${PARAM_VALUE.ENABLE_B}]
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]

	if { (${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") } {
		#set_property enabled true ${PARAM_VALUE.EN_SLEEP_PIN}
	    if { ( $Enable_A == "Always_Enabled" || $Interface_Type_value == "AXI4" || ( $Enable_B == "Always_Enabled" && ($Memory_Type_value != "Single_Port_RAM" && $Memory_Type_value != "Single_Port_ROM") ) ) } {
          set_property enabled false ${PARAM_VALUE.EN_SLEEP_PIN} 
		} else {
		  set_property enabled true ${PARAM_VALUE.EN_SLEEP_PIN}
		}
	} else {
		set_property enabled true ${PARAM_VALUE.EN_SLEEP_PIN}
		set_property value false ${PARAM_VALUE.EN_SLEEP_PIN}
	}
}

proc update_PARAM_VALUE.EN_SAFETY_CKT {PARAM_VALUE.EN_SAFETY_CKT PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Use_RSTB_Pin} {
	
    set porta_core_reg [get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE}]
    set portb_core_reg [get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE}]
    set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
    set rsta_pin [get_property value ${PARAM_VALUE.Use_RSTA_Pin}]
    set rstb_pin [get_property value ${PARAM_VALUE.Use_RSTB_Pin}]

	if { ($rsta_pin) || ($rstb_pin) } {
      if { !($porta_core_reg || $portb_core_reg) } {
         set_property enabled true ${PARAM_VALUE.EN_SAFETY_CKT} 
         set_property value true ${PARAM_VALUE.EN_SAFETY_CKT} 
	   } else {
         set_property enabled false ${PARAM_VALUE.EN_SAFETY_CKT}
         set_property value false ${PARAM_VALUE.EN_SAFETY_CKT}
	   }
   } else {
		set_property enabled false ${PARAM_VALUE.EN_SAFETY_CKT}
      set_property value false ${PARAM_VALUE.EN_SAFETY_CKT}
   }
	if { $ramtype ne "BRAM" } {
		set_property enabled false ${PARAM_VALUE.EN_SAFETY_CKT}
      set_property value false ${PARAM_VALUE.EN_SAFETY_CKT}
	}
}



;# Model Param Update Procedures
proc update_MODELPARAM_VALUE.C_ADDRB_WIDTH { MODELPARAM_VALUE.C_ADDRB_WIDTH PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.MEMORY_TYPE} {
	set val [Address_Width_B_value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_ADDRB_WIDTH}   
}

proc update_MODELPARAM_VALUE.C_DEFAULT_DATA { MODELPARAM_VALUE.C_DEFAULT_DATA PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} {
	set_property value "[  get_property value ${PARAM_VALUE.REMAINING_MEMORY_LOCATIONS} ]"   ${MODELPARAM_VALUE.C_DEFAULT_DATA}   
}

proc update_MODELPARAM_VALUE.C_INTERFACE_TYPE {IPINST MODELPARAM_VALUE.C_INTERFACE_TYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK
   PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
   PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  
   PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PORT_A_CLOCK  
   PARAM_VALUE.PORT_A_ENABLE_RATE PARAM_VALUE.PORT_A_WRITE_RATE  
   PARAM_VALUE.PORT_B_CLOCK PARAM_VALUE.PORT_B_ENABLE_RATE  
   PARAM_VALUE.PORT_B_WRITE_RATE PARAM_VALUE.PRIMITIVE  
   PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
   PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
   PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.ECCTYPE PARAM_VALUE.SOFTECC } {
   
	#SummaryLog $IPINST ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECC} \
	${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A} ${PARAM_VALUE.OPERATING_MODE_B} \
    ${PARAM_VALUE.PORT_A_CLOCK} ${PARAM_VALUE.PORT_A_ENABLE_RATE}  \
	${PARAM_VALUE.PORT_A_WRITE_RATE} ${PARAM_VALUE.PORT_B_CLOCK}  \
	${PARAM_VALUE.PORT_B_ENABLE_RATE} ${PARAM_VALUE.PORT_B_WRITE_RATE} ${PARAM_VALUE.PRIMITIVE}  \
	${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} \
	${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
	${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.INTERFACE_TYPE} 
  
	set_property value "[expr { ([  get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] == "AXI4")?1:0 }]"  ${MODELPARAM_VALUE.C_INTERFACE_TYPE}   
}

proc update_MODELPARAM_VALUE.C_FAMILY { MODELPARAM_VALUE.C_FAMILY PROJECT_PARAM.ARCHITECTURE} {
	set_property value ${PROJECT_PARAM.ARCHITECTURE}  ${MODELPARAM_VALUE.C_FAMILY} 
}

proc update_MODELPARAM_VALUE.C_WRITE_WIDTH_A { MODELPARAM_VALUE.C_WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_A} {
	set_property value "[  get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]"  ${MODELPARAM_VALUE.C_WRITE_WIDTH_A}   
}

proc update_MODELPARAM_VALUE.C_HAS_SOFTECC_OUTPUT_REGS_B { MODELPARAM_VALUE.C_HAS_SOFTECC_OUTPUT_REGS_B PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC} {
   set C_HAS_SOFTECC_OUTPUT_REGS_B [get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_SOFTECC}]
	if {$C_HAS_SOFTECC_OUTPUT_REGS_B} {
		set result 1
	} else {
		set result 0
	}	
	set_property value $result  ${MODELPARAM_VALUE.C_HAS_SOFTECC_OUTPUT_REGS_B} 
}

proc update_MODELPARAM_VALUE.C_USE_SOFTECC { MODELPARAM_VALUE.C_USE_SOFTECC PARAM_VALUE.SOFTECC} {
   set c_use_softecc [get_property value ${PARAM_VALUE.SOFTECC}]
  if {$c_use_softecc} {
      set_property value 1 ${MODELPARAM_VALUE.C_USE_SOFTECC}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_USE_SOFTECC}  
  }
}

proc update_MODELPARAM_VALUE.C_WRITE_WIDTH_B { MODELPARAM_VALUE.C_WRITE_WIDTH_B PARAM_VALUE.WRITE_WIDTH_B} {
	set_property value "[  get_property value ${PARAM_VALUE.WRITE_WIDTH_B} ]"  ${MODELPARAM_VALUE.C_WRITE_WIDTH_B}   
}

proc update_MODELPARAM_VALUE.C_ALGORITHM { MODELPARAM_VALUE.C_ALGORITHM PARAM_VALUE.ALGORITHM} {
	set xcoValue [  get_property value ${PARAM_VALUE.ALGORITHM} ] 
	if {$xcoValue == "Minimum_Area"} {
		set_property value "1"  ${MODELPARAM_VALUE.C_ALGORITHM}   
   } elseif {$xcoValue == "Fixed_Primitives"} {
      set_property value "0"  ${MODELPARAM_VALUE.C_ALGORITHM}   
   } elseif {$xcoValue == "Low_Power"} {
      set_property value "2"  ${MODELPARAM_VALUE.C_ALGORITHM}   
   }
}

proc update_MODELPARAM_VALUE.C_WRITE_DEPTH_A { MODELPARAM_VALUE.C_WRITE_DEPTH_A PARAM_VALUE.WRITE_DEPTH_A} {
	set_property value "[  get_property value ${PARAM_VALUE.WRITE_DEPTH_A} ]"  ${MODELPARAM_VALUE.C_WRITE_DEPTH_A}   
}

proc update_MODELPARAM_VALUE.C_INITA_VAL { MODELPARAM_VALUE.C_INITA_VAL PARAM_VALUE.OUTPUT_RESET_VALUE_A} {
	set_property value "[  get_property value ${PARAM_VALUE.OUTPUT_RESET_VALUE_A} ]"  ${MODELPARAM_VALUE.C_INITA_VAL}   
}

proc update_MODELPARAM_VALUE.C_USE_BRAM_BLOCK { MODELPARAM_VALUE.C_USE_BRAM_BLOCK PARAM_VALUE.USE_BRAM_BLOCK} {
	if {[ get_property value ${PARAM_VALUE.USE_BRAM_BLOCK} ] == "BRAM_Controller"} {
		set value 1
	} else {
		set value 0
	}	
	set_property value $value  ${MODELPARAM_VALUE.C_USE_BRAM_BLOCK} 
}

proc update_MODELPARAM_VALUE.C_WRITE_DEPTH_B { MODELPARAM_VALUE.C_WRITE_DEPTH_B PARAM_VALUE.INTERFACE_TYPE \
										PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B} {
	set val [write_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_WRITE_DEPTH_B}   
}

proc update_MODELPARAM_VALUE.C_LOAD_INIT_FILE { MODELPARAM_VALUE.C_LOAD_INIT_FILE PARAM_VALUE.LOAD_INIT_FILE} {
   set c_load_init_file [get_property value ${PARAM_VALUE.LOAD_INIT_FILE}]
  if {$c_load_init_file} {
      set_property value 1 ${MODELPARAM_VALUE.C_LOAD_INIT_FILE}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_LOAD_INIT_FILE}  
  }
}

proc update_MODELPARAM_VALUE.C_DISABLE_WARN_BHV_COLL { MODELPARAM_VALUE.C_DISABLE_WARN_BHV_COLL PARAM_VALUE.DISABLE_COLLISION_WARNINGS} {
   set c_disable_warn_bhv_coll [get_property value ${PARAM_VALUE.DISABLE_COLLISION_WARNINGS}]
  if {$c_disable_warn_bhv_coll} {
      set_property value 1 ${MODELPARAM_VALUE.C_DISABLE_WARN_BHV_COLL}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_DISABLE_WARN_BHV_COLL}  
  }
}

proc update_MODELPARAM_VALUE.C_AXI_TYPE { MODELPARAM_VALUE.C_AXI_TYPE PARAM_VALUE.AXI_TYPE} {
	set_property value "[expr { ([  get_property value ${PARAM_VALUE.AXI_TYPE} ] == "AXI4_Full")?1:0 }]"  ${MODELPARAM_VALUE.C_AXI_TYPE}   
}

proc update_MODELPARAM_VALUE.C_ADDRA_WIDTH { MODELPARAM_VALUE.C_ADDRA_WIDTH PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_DEPTH_A
											PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.WRITE_WIDTH_A} {
	set val [Address_Width_A_value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.WRITE_DEPTH_A} \
			${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_ADDRA_WIDTH}   
}

proc update_MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_A { MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_A PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} {
   set c_has_mux_output_regs_a [get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE}]
  if {$c_has_mux_output_regs_a} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_A}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_A}  
  }
}

proc update_MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_B { MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_B PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} {
   set c_has_mux_output_regs_b [get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE}]
  if {$c_has_mux_output_regs_b} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_B}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_MUX_OUTPUT_REGS_B}  
  }
}

proc update_MODELPARAM_VALUE.C_HAS_SOFTECC_INPUT_REGS_A { MODELPARAM_VALUE.C_HAS_SOFTECC_INPUT_REGS_A PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC} {
   set c_has_softecc_input_regs_a [get_property value ${PARAM_VALUE.REGISTER_PORTA_INPUT_OF_SOFTECC}]
	if {$c_has_softecc_input_regs_a} {
		set result 1
	} else {
		set result 0
	}	
	set_property value $result  ${MODELPARAM_VALUE.C_HAS_SOFTECC_INPUT_REGS_A} 
}

proc update_MODELPARAM_VALUE.C_CTRL_ECC_ALGO { MODELPARAM_VALUE.C_CTRL_ECC_ALGO PARAM_VALUE.CTRL_ECC_ALGO} {
	set_property value "[  get_property value ${PARAM_VALUE.CTRL_ECC_ALGO} ]"   ${MODELPARAM_VALUE.C_CTRL_ECC_ALGO}   
}

proc update_MODELPARAM_VALUE.C_PRIM_TYPE { MODELPARAM_VALUE.C_PRIM_TYPE PARAM_VALUE.PRIMITIVE} {
   set c_prim_type 0
   set xcoValue [  get_property value ${PARAM_VALUE.PRIMITIVE} ]
   switch $xcoValue {
     "32kx1"  { set c_prim_type 0 }
     "16kx1"  { set c_prim_type 0 }
     "8kx2"   { set c_prim_type 1 }
     "4kx4"   { set c_prim_type 2 }
     "2kx9"   { set c_prim_type 3 }
     "1kx18"  { set c_prim_type 4 }
     "512x36" { set c_prim_type 5 }
     "256x72" { set c_prim_type 6 }
   }
	set_property value "$c_prim_type"  ${MODELPARAM_VALUE.C_PRIM_TYPE}   
}

proc update_MODELPARAM_VALUE.C_RSTRAM_A { MODELPARAM_VALUE.C_RSTRAM_A PARAM_VALUE.RESET_MEMORY_LATCH_A} {
   set c_rstram_a [get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_A}]
  if {$c_rstram_a} {
      set_property value 1 ${MODELPARAM_VALUE.C_RSTRAM_A}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_RSTRAM_A}  
  }
}

proc update_MODELPARAM_VALUE.C_RSTRAM_B { MODELPARAM_VALUE.C_RSTRAM_B PARAM_VALUE.RESET_MEMORY_LATCH_B} {
   set c_rstram_b [get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_B}]
  if {$c_rstram_b} {
      set_property value 1 ${MODELPARAM_VALUE.C_RSTRAM_B}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_RSTRAM_B}  
  }
}

proc update_MODELPARAM_VALUE.C_HAS_RSTA { MODELPARAM_VALUE.C_HAS_RSTA PARAM_VALUE.USE_RSTA_PIN} {
   set c_has_rsta [get_property value ${PARAM_VALUE.USE_RSTA_PIN}]
  if {$c_has_rsta} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_RSTA}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_RSTA}  
  }
}

proc update_MODELPARAM_VALUE.C_DISABLE_WARN_BHV_RANGE { MODELPARAM_VALUE.C_DISABLE_WARN_BHV_RANGE PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS} {
   set c_disable_warn_bhv_range [get_property value ${PARAM_VALUE.DISABLE_OUT_OF_RANGE_WARNINGS}]
  if {$c_disable_warn_bhv_range} {
      set_property value 1 ${MODELPARAM_VALUE.C_DISABLE_WARN_BHV_RANGE}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_DISABLE_WARN_BHV_RANGE}  
  }
}

proc update_MODELPARAM_VALUE.C_ELABORATION_DIR { MODELPARAM_VALUE.C_ELABORATION_DIR} {
  set result [ipgui::get_elaboration_dir -of $IPINST]
  set result "${result}/"
  set_property value ${result}   ${MODELPARAM_VALUE.C_ELABORATION_DIR} 
}

proc update_MODELPARAM_VALUE.C_BYTE_SIZE { MODELPARAM_VALUE.C_BYTE_SIZE PARAM_VALUE.BYTE_SIZE} {
	set_property value "[  get_property value ${PARAM_VALUE.BYTE_SIZE} ]"  ${MODELPARAM_VALUE.C_BYTE_SIZE}   
}

proc update_MODELPARAM_VALUE.C_HAS_RSTB { MODELPARAM_VALUE.C_HAS_RSTB PARAM_VALUE.USE_RSTB_PIN} {
   set c_has_rstb [get_property value ${PARAM_VALUE.USE_RSTB_PIN}]
  if {$c_has_rstb} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_RSTB}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_RSTB}  
  }
}

proc update_MODELPARAM_VALUE.C_ENABLE_32BIT_ADDRESS { MODELPARAM_VALUE.C_ENABLE_32BIT_ADDRESS PARAM_VALUE.ENABLE_32BIT_ADDRESS} {
   set c_enable_32bit_address [get_property value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS}]
  if {$c_enable_32bit_address} {
      set_property value 1 ${MODELPARAM_VALUE.C_ENABLE_32BIT_ADDRESS}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_ENABLE_32BIT_ADDRESS}  
  }
}

proc update_MODELPARAM_VALUE.C_HAS_INJECTERR { MODELPARAM_VALUE.C_HAS_INJECTERR PARAM_VALUE.ERROR_INJECTION_TYPE  
  PARAM_VALUE.USE_ERROR_INJECTION_PINS} {
	if {![  get_property value ${PARAM_VALUE.USE_ERROR_INJECTION_PINS} ] } {
		set_property value "0"  ${MODELPARAM_VALUE.C_HAS_INJECTERR}   
	} else {
		switch  -- [  get_property value ${PARAM_VALUE.ERROR_INJECTION_TYPE} ] {
        "Single_Bit_Error_Injection"            { set_property value 1  ${MODELPARAM_VALUE.C_HAS_INJECTERR}   }
        "Double_Bit_Error_Injection"            { set_property value 2  ${MODELPARAM_VALUE.C_HAS_INJECTERR}   }
        "Single_and_Double_Bit_Error_Injection" { set_property value 3  ${MODELPARAM_VALUE.C_HAS_INJECTERR}   }
		}
	}
}

proc update_MODELPARAM_VALUE.C_COMMON_CLK { MODELPARAM_VALUE.C_COMMON_CLK PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} {
   set c_common_clk [get_property value ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}]
  if {$c_common_clk} {
      set_property value 1 ${MODELPARAM_VALUE.C_COMMON_CLK}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_COMMON_CLK}  
  }
}

proc update_MODELPARAM_VALUE.C_XDEVICEFAMILY { MODELPARAM_VALUE.C_XDEVICEFAMILY PROJECT_PARAM.FAMILY} {
	set_property value ${PROJECT_PARAM.FAMILY}  ${MODELPARAM_VALUE.C_XDEVICEFAMILY} 
}

proc update_MODELPARAM_VALUE.C_INIT_FILE_NAME { MODELPARAM_VALUE.C_INIT_FILE_NAME PARAM_VALUE.COE_FILE  
  PARAM_VALUE.COMPONENT_NAME} {
	set Component_Name_value [ get_property value ${PARAM_VALUE.COMPONENT_NAME} ]  
	set Coe_File_value [ get_property value ${PARAM_VALUE.COE_FILE} ]  
  if {$Coe_File_value == "no_coe_file_loaded"} {
	  set_property value $Coe_File_value   ${MODELPARAM_VALUE.C_INIT_FILE_NAME}   
  } else {
    set miffile [string replace "n.mif" 0 0 $Component_Name_value]
	  set_property value $miffile  ${MODELPARAM_VALUE.C_INIT_FILE_NAME}   
  }
}

proc update_MODELPARAM_VALUE.C_MUX_PIPELINE_STAGES { MODELPARAM_VALUE.C_MUX_PIPELINE_STAGES PARAM_VALUE.PIPELINE_STAGES} {
	set_property value "[  get_property value ${PARAM_VALUE.PIPELINE_STAGES} ]"   ${MODELPARAM_VALUE.C_MUX_PIPELINE_STAGES}   
}

proc update_MODELPARAM_VALUE.C_AXI_SLAVE_TYPE { MODELPARAM_VALUE.C_AXI_SLAVE_TYPE PARAM_VALUE.AXI_SLAVE_TYPE} {
	set_property value "[expr { ([  get_property value ${PARAM_VALUE.AXI_SLAVE_TYPE} ] == "Memory_Slave")?0:1 }]"  ${MODELPARAM_VALUE.C_AXI_SLAVE_TYPE}   
}

proc update_MODELPARAM_VALUE.C_USE_ECC { MODELPARAM_VALUE.C_USE_ECC PARAM_VALUE.ECC} {
   set c_use_ecc [get_property value ${PARAM_VALUE.ECC}]
  if {$c_use_ecc} {
      set_property value 1 ${MODELPARAM_VALUE.C_USE_ECC}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_USE_ECC}  
  }
}

proc update_MODELPARAM_VALUE.C_HAS_AXI_ID { MODELPARAM_VALUE.C_HAS_AXI_ID PARAM_VALUE.USE_AXI_ID} {
   set c_has_axi_id [get_property value ${PARAM_VALUE.USE_AXI_ID}]
  if {$c_has_axi_id} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_AXI_ID}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_AXI_ID}  
  }
}

proc update_MODELPARAM_VALUE.C_RST_PRIORITY_A { MODELPARAM_VALUE.C_RST_PRIORITY_A PARAM_VALUE.RESET_PRIORITY_A} {
	set_property value "[  get_property value ${PARAM_VALUE.RESET_PRIORITY_A} ]"  ${MODELPARAM_VALUE.C_RST_PRIORITY_A}   
}

proc update_MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_A { MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_A PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} {
   set c_has_mem_output_regs_a [get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES}]
  if {$c_has_mem_output_regs_a} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_A}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_A}  
  }
}


proc update_MODELPARAM_VALUE.C_RST_PRIORITY_B { MODELPARAM_VALUE.C_RST_PRIORITY_B PARAM_VALUE.RESET_PRIORITY_B} {
	set_property value "[  get_property value ${PARAM_VALUE.RESET_PRIORITY_B} ]"  ${MODELPARAM_VALUE.C_RST_PRIORITY_B}   
}

proc update_MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_B { MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_B PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} {
   set c_has_mem_output_regs_b [get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES}]
  if {$c_has_mem_output_regs_b} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_B}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_MEM_OUTPUT_REGS_B}  
  }
}

proc update_MODELPARAM_VALUE.C_USE_BYTE_WEA { MODELPARAM_VALUE.C_USE_BYTE_WEA PARAM_VALUE.USE_BYTE_WRITE_ENABLE} {
   set c_use_byte_wea [get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}]
  if {$c_use_byte_wea} {
      set_property value 1 ${MODELPARAM_VALUE.C_USE_BYTE_WEA}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_USE_BYTE_WEA}  
  }
}

proc update_MODELPARAM_VALUE.C_USE_BYTE_WEB { MODELPARAM_VALUE.C_USE_BYTE_WEB PARAM_VALUE.USE_BYTE_WRITE_ENABLE} {
   set c_use_byte_web [get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}]
  if {$c_use_byte_web} {
      set_property value 1 ${MODELPARAM_VALUE.C_USE_BYTE_WEB}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_USE_BYTE_WEB}  
  }
}

proc update_MODELPARAM_VALUE.C_WEB_WIDTH { MODELPARAM_VALUE.C_WEB_WIDTH PARAM_VALUE.BYTE_SIZE PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_WIDTH_B} {
	set_property value "[expr { ([get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ])?([get_property value ${PARAM_VALUE.WRITE_WIDTH_B}]/[get_property value ${PARAM_VALUE.BYTE_SIZE}]):1 }]"  ${MODELPARAM_VALUE.C_WEB_WIDTH}   
}

proc update_MODELPARAM_VALUE.C_INITB_VAL { MODELPARAM_VALUE.C_INITB_VAL PARAM_VALUE.OUTPUT_RESET_VALUE_B} {
	set_property value "[  get_property value ${PARAM_VALUE.OUTPUT_RESET_VALUE_B} ]"  ${MODELPARAM_VALUE.C_INITB_VAL}   
}

proc update_MODELPARAM_VALUE.C_AXI_ID_WIDTH { MODELPARAM_VALUE.C_AXI_ID_WIDTH PARAM_VALUE.AXI_ID_WIDTH} {
	set_property value [ get_property value ${PARAM_VALUE.AXI_ID_WIDTH} ]   ${MODELPARAM_VALUE.C_AXI_ID_WIDTH}   
}

proc update_MODELPARAM_VALUE.C_WRITE_MODE_A { MODELPARAM_VALUE.C_WRITE_MODE_A PARAM_VALUE.OPERATING_MODE_A} {
	set_property value "[  get_property value ${PARAM_VALUE.OPERATING_MODE_A} ]"  ${MODELPARAM_VALUE.C_WRITE_MODE_A}   
}

proc update_MODELPARAM_VALUE.C_HAS_ENA { MODELPARAM_VALUE.C_HAS_ENA PARAM_VALUE.ENABLE_A} {
	set val [expr { ([  get_property value ${PARAM_VALUE.ENABLE_A} ] == "Always_Enabled")?0:1}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_HAS_ENA}   
}

proc update_MODELPARAM_VALUE.C_WRITE_MODE_B { MODELPARAM_VALUE.C_WRITE_MODE_B PARAM_VALUE.OPERATING_MODE_B} {
	set_property value "[  get_property value ${PARAM_VALUE.OPERATING_MODE_B} ]"  ${MODELPARAM_VALUE.C_WRITE_MODE_B}   
}

proc update_MODELPARAM_VALUE.C_HAS_ENB { MODELPARAM_VALUE.C_HAS_ENB PARAM_VALUE.ENABLE_B} {
	set val [expr { ([  get_property value ${PARAM_VALUE.ENABLE_B} ] == "Always_Enabled")?0:1}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_HAS_ENB}   
}

proc update_MODELPARAM_VALUE.C_HAS_REGCEA { MODELPARAM_VALUE.C_HAS_REGCEA PARAM_VALUE.Use_REGCEA_Pin} {
   set c_has_regcea [get_property value ${PARAM_VALUE.Use_REGCEA_Pin}]
  if {$c_has_regcea} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_REGCEA}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_REGCEA}  
  }

}

proc update_MODELPARAM_VALUE.C_INIT_FILE { MODELPARAM_VALUE.C_INIT_FILE PARAM_VALUE.COMPONENT_NAME  
  PARAM_VALUE.MEM_FILE} {
	set Component_Name_value [ get_property value ${PARAM_VALUE.COMPONENT_NAME} ]  
	set Init_File_value [ get_property value ${PARAM_VALUE.MEM_FILE} ]  
  if {$Init_File_value == "NONE"} {
	  set_property value $Init_File_value   ${MODELPARAM_VALUE.C_INIT_FILE}   
  } elseif {$Init_File_value == "no_init_file_loaded"} {
	  set_property value $Init_File_value   ${MODELPARAM_VALUE.C_INIT_FILE}   
  } else {
    set memfile [string replace "n.mem" 0 0 $Component_Name_value]
	  set_property value $memfile  ${MODELPARAM_VALUE.C_INIT_FILE}   
  }
}

proc update_MODELPARAM_VALUE.C_READ_WIDTH_A { MODELPARAM_VALUE.C_READ_WIDTH_A PARAM_VALUE.READ_WIDTH_A} {
	set_property value "[  get_property value ${PARAM_VALUE.READ_WIDTH_A} ]"  ${MODELPARAM_VALUE.C_READ_WIDTH_A}   
}

proc update_MODELPARAM_VALUE.C_HAS_REGCEB { MODELPARAM_VALUE.C_HAS_REGCEB PARAM_VALUE.USE_REGCEB_PIN} {
   set c_has_regceb [get_property value ${PARAM_VALUE.USE_REGCEB_PIN}]
  if {$c_has_regceb} {
      set_property value 1 ${MODELPARAM_VALUE.C_HAS_REGCEB}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_HAS_REGCEB}  
  }
}

proc update_MODELPARAM_VALUE.C_WEA_WIDTH { MODELPARAM_VALUE.C_WEA_WIDTH PARAM_VALUE.BYTE_SIZE  
  PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_WIDTH_A} {
	set_property value "[expr { ([  get_property value ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ])?([ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]/[ get_property value ${PARAM_VALUE.BYTE_SIZE} ]):1 }]"  ${MODELPARAM_VALUE.C_WEA_WIDTH}   
}

proc update_MODELPARAM_VALUE.C_READ_WIDTH_B { MODELPARAM_VALUE.C_READ_WIDTH_B PARAM_VALUE.READ_WIDTH_B} {
	set_property value "[  get_property value ${PARAM_VALUE.READ_WIDTH_B} ]"  ${MODELPARAM_VALUE.C_READ_WIDTH_B}   
}

proc update_MODELPARAM_VALUE.C_MEM_TYPE { MODELPARAM_VALUE.C_MEM_TYPE PARAM_VALUE.MEMORY_TYPE} {
	set xcoValue [  get_property value ${PARAM_VALUE.MEMORY_TYPE} ] 
	if {$xcoValue == "Single_Port_RAM"} {
      set_property value "0"  ${MODELPARAM_VALUE.C_MEM_TYPE}   
   } elseif {$xcoValue == "Simple_Dual_Port_RAM"} {
      set_property value "1"  ${MODELPARAM_VALUE.C_MEM_TYPE}   
   } elseif {$xcoValue == "True_Dual_Port_RAM"} {
      set_property value "2"  ${MODELPARAM_VALUE.C_MEM_TYPE}   
   } elseif {$xcoValue == "Single_Port_ROM"} {
      set_property value "3"  ${MODELPARAM_VALUE.C_MEM_TYPE}   
   } else {
     set_property value "4"  ${MODELPARAM_VALUE.C_MEM_TYPE}   
   }
}

proc update_MODELPARAM_VALUE.C_READ_DEPTH_A { MODELPARAM_VALUE.C_READ_DEPTH_A PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A} {
	set val [read_depth_a_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_READ_DEPTH_A}   
}

proc update_MODELPARAM_VALUE.C_SIM_COLLISION_CHECK { MODELPARAM_VALUE.C_SIM_COLLISION_CHECK PARAM_VALUE.COLLISION_WARNINGS} {
	set_property value "[  get_property value ${PARAM_VALUE.COLLISION_WARNINGS} ]"   ${MODELPARAM_VALUE.C_SIM_COLLISION_CHECK}   
}

proc update_MODELPARAM_VALUE.C_READ_DEPTH_B { MODELPARAM_VALUE.C_READ_DEPTH_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B} {
	set val [read_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]
	set_property value "$val"  ${MODELPARAM_VALUE.C_READ_DEPTH_B}   
}

proc update_MODELPARAM_VALUE.C_USE_DEFAULT_DATA { MODELPARAM_VALUE.C_USE_DEFAULT_DATA PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS} {
  set c_use_default_data [get_property value ${PARAM_VALUE.FILL_REMAINING_MEMORY_LOCATIONS}]
  if {$c_use_default_data} {
      set_property value 1 ${MODELPARAM_VALUE.C_USE_DEFAULT_DATA}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_USE_DEFAULT_DATA}  
  }
}

proc update_MODELPARAM_VALUE.C_EN_ECC_PIPE { MODELPARAM_VALUE.C_EN_ECC_PIPE PARAM_VALUE.EN_ECC_PIPE} {
  set c_en_ecc_pipe [get_property value ${PARAM_VALUE.EN_ECC_PIPE}]
  if {$c_en_ecc_pipe} {
      set_property value 1 ${MODELPARAM_VALUE.C_EN_ECC_PIPE}  
  } else {
      set_property value 0 ${MODELPARAM_VALUE.C_EN_ECC_PIPE}  
  }
}

proc update_MODELPARAM_VALUE.C_EN_SLEEP_PIN { MODELPARAM_VALUE.C_EN_SLEEP_PIN PARAM_VALUE.EN_SLEEP_PIN PROJECT_PARAM.ARCHITECTURE} {
	if { (${PROJECT_PARAM.ARCHITECTURE} == "virtexuplushbm" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus58g" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplusrfsoc" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "spartanuplus" || ${PROJECT_PARAM.ARCHITECTURE} == "zynquplus" || ${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu") && [get_property value ${PARAM_VALUE.EN_SLEEP_PIN}] } {
		set_property value 1 ${MODELPARAM_VALUE.C_EN_SLEEP_PIN}   
	} else {
		set_property value 0 ${MODELPARAM_VALUE.C_EN_SLEEP_PIN}   
	}
}

proc update_MODELPARAM_VALUE.C_EN_SAFETY_CKT { MODELPARAM_VALUE.C_EN_SAFETY_CKT PARAM_VALUE.EN_SAFETY_CKT PROJECT_PARAM.ARCHITECTURE} {
	if { [get_property value ${PARAM_VALUE.EN_SAFETY_CKT}] } {
		set_property value 1 ${MODELPARAM_VALUE.C_EN_SAFETY_CKT}   
	} else {
		set_property value 0 ${MODELPARAM_VALUE.C_EN_SAFETY_CKT}   
	}
}


#############
##
########
proc update_MODELPARAM_VALUE.C_USE_URAM { MODELPARAM_VALUE.C_USE_URAM PARAM_VALUE.PRIM_type_to_Implement } { 
		set PRIM_type [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}] 
		switch $PRIM_type { 
          BRAM {set xco 0 }
          URAM {set xco 1 }
          AUTO {set xco 2 }
		  }
		  
		set_property value $xco ${MODELPARAM_VALUE.C_USE_URAM} 
}

proc update_MODELPARAM_VALUE.C_EN_SHUTDOWN_PIN  { MODELPARAM_VALUE.C_EN_SHUTDOWN_PIN  PARAM_VALUE.EN_SHUTDOWN_PIN } {
       if {[get_property value ${PARAM_VALUE.EN_SHUTDOWN_PIN}]} {
        set xco 1 
        } else {
		set xco 0 
		}
		set_property value  $xco  ${MODELPARAM_VALUE.C_EN_SHUTDOWN_PIN} 

}
proc update_MODELPARAM_VALUE.C_EN_DEEPSLEEP_PIN  { MODELPARAM_VALUE.C_EN_DEEPSLEEP_PIN  PARAM_VALUE.EN_DEEPSLEEP_PIN } {
       if {[get_property value ${PARAM_VALUE.EN_DEEPSLEEP_PIN}]} {
        set xco 1 
        } else {
		set xco 0 
		}
		set_property value  $xco  ${MODELPARAM_VALUE.C_EN_DEEPSLEEP_PIN} 

}
proc update_MODELPARAM_VALUE.C_EN_RDADDRB_CHG  { PARAM_VALUE.MEMORY_TYPE MODELPARAM_VALUE.C_EN_RDADDRB_CHG  PARAM_VALUE.RD_ADDR_CHNG_B PARAM_VALUE.RD_ADDR_CHNG_A } {
       
	   set xcoValue [  get_property value ${PARAM_VALUE.MEMORY_TYPE} ]

	   if {[get_property value ${PARAM_VALUE.RD_ADDR_CHNG_B}]} {
        set xco_b 1 
        } else {
		set xco_b 0 
		}

	   if {[get_property value ${PARAM_VALUE.RD_ADDR_CHNG_A}]} {
        set xco_a 1 
        } else {
		set xco_a 0 
		}

		if {($xcoValue ne "Single_Port_RAM" || $xcoValue ne "Single_Port_ROM")} {
		  set_property value  $xco_b  ${MODELPARAM_VALUE.C_EN_RDADDRB_CHG} 
        } else {
          set_property value  $xco_a  ${MODELPARAM_VALUE.C_EN_RDADDRB_CHG}
		}
	#	set_property value  [get_property value ${PARAM_VALUE.RD_ADDR_CHNG_B}] ${MODELPARAM_VALUE.C_EN_RDADDRB_CHG} 

}
proc update_MODELPARAM_VALUE.C_EN_RDADDRA_CHG  { MODELPARAM_VALUE.C_EN_RDADDRA_CHG  PARAM_VALUE.RD_ADDR_CHNG_A } {
	   
	   if {[get_property value ${PARAM_VALUE.RD_ADDR_CHNG_A}]} {
        set xco 1 
        } else {
		set xco 0 
		}
		set_property value  $xco  ${MODELPARAM_VALUE.C_EN_RDADDRA_CHG}  
		#set_property value  [get_property value ${PARAM_VALUE.RD_ADDR_CHNG_A}] ${MODELPARAM_VALUE.C_EN_RDADDRA_CHG} 

}

###########################
;# Dynamic Text Procs and Other Common Procs
proc Write_Width_A_Range_updated { PARAM_VALUE.WRITE_WIDTH_A} {
	set min [lindex [split [get_property range  ${PARAM_VALUE.WRITE_WIDTH_A} ] ","] 0]
	set max [lindex [split [get_property range  ${PARAM_VALUE.WRITE_WIDTH_A} ] ","] 1]
	return "Range: $min to $max (bits)"
}

proc Write_Depth_A_Range_updated { PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A } {
	set min [lindex [split [get_property range  ${PARAM_VALUE.WRITE_DEPTH_A} ] ","] 0]
	set max [lindex [split [get_property range  ${PARAM_VALUE.WRITE_DEPTH_A} ] ","] 1]
	#set max [getMaxWriteDepthA ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.BYTE_SIZE}]
	#set max1 [getMaxWriteDepthA   ${PARAM_VALUE.WRITE_WIDTH_A}]
	return "Range: $min to $max "
}

proc Estimated_Power_for_IP_updated { PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK
   PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  
   PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  
   PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PORT_A_CLOCK  
   PARAM_VALUE.PORT_A_ENABLE_RATE PARAM_VALUE.PORT_A_WRITE_RATE  
   PARAM_VALUE.PORT_B_CLOCK PARAM_VALUE.PORT_B_ENABLE_RATE  
   PARAM_VALUE.PORT_B_WRITE_RATE PARAM_VALUE.PRIMITIVE  
   PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
   PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
   PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A  PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
  
  return [est_blk_ram_power ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECC}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PORT_A_CLOCK}  \
  ${PARAM_VALUE.PORT_A_ENABLE_RATE} ${PARAM_VALUE.PORT_A_WRITE_RATE}  \
  ${PARAM_VALUE.PORT_B_CLOCK} ${PARAM_VALUE.PORT_B_ENABLE_RATE}  \
  ${PARAM_VALUE.PORT_B_WRITE_RATE} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A}  \
  ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.PRIM_type_to_Implement}]
}

proc Pipeline_StagesDesc_updated {PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK 
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  
  PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.MEMORY_TYPE  
  PARAM_VALUE.OPERATING_MODE_A PARAM_VALUE.OPERATING_MODE_B  
  PARAM_VALUE.PRIMITIVE PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  
  PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE  
  PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.USE_BYTE_WRITE_ENABLE  
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PROJECT_PARAM.ARCHITECTURE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
  PARAM_VALUE.Operating_Mode_B PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B } {
  
	set mux_size [getMuxSize ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE} ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A} ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}]
	return "Mux Size: ${mux_size}x1"

}

#proc BlockRAM_Blocks_Used_36_updated {PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  \
#  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  \
#  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  \
#  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  \
#  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  \
#  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  \
#  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  \
#  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE } {
#  
#  return "Block RAM resource(s) (36K BRAMs): [est_blk_ram_resource_36 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
#  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
#  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
#  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
#  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
#  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
#  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
#  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ]"
#}
#
#proc BlockRAM_Blocks_Used_18_updated {PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  \
#  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  \
#  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  \
#  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  \
#  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  \
#  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  \
#  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  \
#  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE } {
#
#  return "Block RAM resource(s) (18K BRAMs): [est_blk_ram_resource_18 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
#  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
#  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
#  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
#  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
#  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
#  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
#  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} ]"
#
#}

proc BlockRAM_Blocks_Used_36_updated {MODELPARAM_VALUE.C_COUNT_36K_BRAM PARAM_VALUE.PRIM_type_to_Implement} {
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype eq "URAM" ) } { 
	set bram36k  "N/A"
	} else {
	set bram36k [get_property value ${MODELPARAM_VALUE.C_COUNT_36K_BRAM}]
	}
	
	return "Block RAM resource(s) (36K BRAMs): $bram36k"
}

proc BlockRAM_Blocks_Used_18_updated {MODELPARAM_VALUE.C_COUNT_18K_BRAM PARAM_VALUE.PRIM_type_to_Implement} {
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype eq "URAM" ) } { 
	set bram18k  "N/A"
	} else {
	set bram18k [get_property value ${MODELPARAM_VALUE.C_COUNT_18K_BRAM}]
	}
	return "Block RAM resource(s) (18K BRAMs): $bram18k"
}

proc URAM_Blocks_Used_updated {MODELPARAM_VALUE.C_COUNT_36K_BRAM PARAM_VALUE.PRIM_type_to_Implement} {
	set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
	if { ( $ramtype eq "BRAM" ) } { 
	set uram  "N/A"
	} else {
	set uram [get_property value ${MODELPARAM_VALUE.C_COUNT_36K_BRAM}]
	}
	return "Ultra RAM resource(s) (4kx72 URAMs): $uram"
}

proc update_MODELPARAM_VALUE.C_COUNT_36K_BRAM {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_COUNT_36K_BRAM PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  \
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  \
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  \
  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  \
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  \
  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  \
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  \
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK} {
  
  set value [est_blk_ram_resource_36 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ]
  
  set_property value $value ${MODELPARAM_VALUE.C_COUNT_36K_BRAM}
}

proc update_MODELPARAM_VALUE.C_COUNT_18K_BRAM {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_COUNT_18K_BRAM PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK  \
  PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECCTYPE  \
  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  \
  PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PRIMITIVE  \
  PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B  \
  PARAM_VALUE.SOFTECC PARAM_VALUE.USE_BYTE_WRITE_ENABLE  \
  PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A  \
  PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK} {

  set value [est_blk_ram_resource_18 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.USE_BRAM_BLOCK}]
  
  set_property value $value ${MODELPARAM_VALUE.C_COUNT_18K_BRAM}

}

proc update_MODELPARAM_VALUE.C_EST_POWER_SUMMARY {PROJECT_PARAM.ARCHITECTURE MODELPARAM_VALUE.C_EST_POWER_SUMMARY PARAM_VALUE.ALGORITHM PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK
   PARAM_VALUE.BYTE_SIZE PARAM_VALUE.ECC  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.OPERATING_MODE_A  
   PARAM_VALUE.OPERATING_MODE_B PARAM_VALUE.PORT_A_CLOCK  PARAM_VALUE.PORT_A_ENABLE_RATE PARAM_VALUE.PORT_A_WRITE_RATE  
   PARAM_VALUE.PORT_B_CLOCK PARAM_VALUE.PORT_B_ENABLE_RATE PARAM_VALUE.PORT_B_WRITE_RATE PARAM_VALUE.PRIMITIVE  
   PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.USE_BYTE_WRITE_ENABLE PARAM_VALUE.WRITE_DEPTH_A  
   PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A
   PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {
  
  set value [ est_blk_ram_power ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK} ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECC}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A} ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PORT_A_CLOCK}  \
  ${PARAM_VALUE.PORT_A_ENABLE_RATE} ${PARAM_VALUE.PORT_A_WRITE_RATE}  ${PARAM_VALUE.PORT_B_CLOCK} ${PARAM_VALUE.PORT_B_ENABLE_RATE}  \
  ${PARAM_VALUE.PORT_B_WRITE_RATE} ${PARAM_VALUE.PRIMITIVE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} \
  ${PARAM_VALUE.INTERFACE_TYPE}  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} ${PARAM_VALUE.Use_RSTB_Pin} \
  ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.PRIM_type_to_Implement}]

  set_property value $value ${MODELPARAM_VALUE.C_EST_POWER_SUMMARY}
 
}

proc SummaryLog {IPINST ALGORITHM ASSUME_SYNCHRONOUS_CLK BYTE_SIZE ECC MEMORY_TYPE OPERATING_MODE_A  OPERATING_MODE_B
  PORT_A_CLOCK PORT_A_ENABLE_RATE  
  PORT_A_WRITE_RATE PORT_B_CLOCK  
  PORT_B_ENABLE_RATE PORT_B_WRITE_RATE PRIMITIVE  
  READ_WIDTH_A READ_WIDTH_B  USE_BYTE_WRITE_ENABLE 
  WRITE_DEPTH_A WRITE_WIDTH_A  
  WRITE_WIDTH_B ECCTYPE SOFTECC INTERFACE_TYPE PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A  PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK} {
   
	set hidePortB [expr {![string match "Single_Port_*" [get_property value $MEMORY_TYPE]]?true:false}]
	
	set WriteText "\nUser Configuration\n-------------------------------------"
	set WriteText "$WriteText\nAlgorithm                  :     [ get_property value ${ALGORITHM} ]"
	set WriteText "$WriteText\nMemory Type                :     [ get_property value ${MEMORY_TYPE} ]"
	
	array set fileData [get_metaparam_value fileData]

	if {[info exists fileData(Read_Width_A)]} {
		if {$fileData(Read_Width_A)} {
			set WriteText "$WriteText\nPort A Read Width          :     [ get_property value ${READ_WIDTH_A} ]"
		}
	} elseif {[get_property visible  ${READ_WIDTH_A} ]} {
		set WriteText "$WriteText\nPort A Read Width          :     [ get_property value ${READ_WIDTH_A} ]"
	}
	
	if {[info exists fileData(Read_Width_B)] && [info exists hidePortB]} {
		if {$fileData(Read_Width_B) && (!$hidePortB)} {
			set WriteText "$WriteText\nPort B Read Width          :     [ get_property value ${READ_WIDTH_B} ]"
		}
	} elseif {[get_property visible  ${READ_WIDTH_B} ] } {
		set WriteText "$WriteText\nPort B Read Width          :     [ get_property value ${READ_WIDTH_B} ]"
	}
	
	if {[info exists fileData(Write_Width_A)]} {
		if {$fileData(Write_Width_A)} {
			set WriteText "$WriteText\nPort A Write Width         :     [ get_property value ${WRITE_WIDTH_A} ]" 
		}
	} elseif {[get_property visible  ${WRITE_WIDTH_A} ] } {
		set WriteText "$WriteText\nPort A Write Width         :     [ get_property value ${WRITE_WIDTH_A} ]" 
	}
	
	if {[info exists fileData(Write_Width_B)] && [info exists hidePortB]} {
		if {$fileData(Write_Width_B) && (!$hidePortB) } {
			set WriteText "$WriteText\nPort B Write Width         :     [ get_property value ${WRITE_WIDTH_B} ]"
		}
	} elseif {[get_property visible  ${WRITE_WIDTH_B} ] } {
		set WriteText "$WriteText\nPort B Write Width         :     [ get_property value ${WRITE_WIDTH_B} ]"
	}
	
	if {[info exists fileData(Write_Depth_A)]} {
		if { $fileData(Write_Depth_A)} {
			set WriteText "$WriteText\nMemory Depth               :     [ get_property value ${WRITE_DEPTH_A} ]"
		}
	} elseif {[get_property visible  ${WRITE_DEPTH_A} ] } {
		set WriteText "$WriteText\nMemory Depth               :     [ get_property value ${WRITE_DEPTH_A} ]"
	}
	
	set WriteText "$WriteText\n--------------------------------------------------------------\n"
	
	set WriteText "$WriteText\nBlock RAM resource(s) (18K BRAMs)    : [est_blk_ram_resource_18 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.USE_BRAM_BLOCK}]"
  
		set WriteText "$WriteText\nBlock RAM resource(s) (36K BRAMs)    : [est_blk_ram_resource_36 ${PARAM_VALUE.ALGORITHM} ${PARAM_VALUE.ASSUME_SYNCHRONOUS_CLK}  \
  ${PARAM_VALUE.BYTE_SIZE} ${PARAM_VALUE.ECCTYPE}  \
  ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.OPERATING_MODE_A}  \
  ${PARAM_VALUE.OPERATING_MODE_B} ${PARAM_VALUE.PRIMITIVE}  \
  ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.READ_WIDTH_B}  \
  ${PARAM_VALUE.SOFTECC} ${PARAM_VALUE.USE_BYTE_WRITE_ENABLE}  \
  ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}  \
  ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ]"
	
   
	set WriteText "$WriteText\n--------------------------------------------------------------"
   
	set WriteText "$WriteText\nClock A Frequency          :     [ get_property value ${PORT_A_CLOCK} ]"
	if {[info exists fileData(Port_B_Clock)]} {
		if {$fileData(Port_B_Clock)} {
			set WriteText "$WriteText\nClock B Frequency          :     [ get_property value ${PORT_B_CLOCK} ]"
		}
	} elseif {[get_property visible [ipgui::get_groupspec PortB_Group -of $IPINST]] } {
		set WriteText "$WriteText\nClock B Frequency          :     [ get_property value ${PORT_B_CLOCK} ]"
	}
	
	set WriteText "$WriteText\nPort A Enable Rate         :     [ get_property value ${PORT_A_ENABLE_RATE} ]"
	
	if {[info exists fileData(Port_B_Enable_Rate)]} {
		if {$fileData(Port_B_Enable_Rate)} {
			set WriteText "$WriteText\nPort B Enable Rate         :     [ get_property value ${PORT_B_ENABLE_RATE} ]"
		}
	} elseif {[get_property visible [ipgui::get_groupspec PortB_Group -of $IPINST]] } {
		set WriteText "$WriteText\nPort B Enable Rate         :     [ get_property value ${PORT_B_ENABLE_RATE} ]"
	}
	
	set WriteText "$WriteText\nPort A Write Rate          :     [ get_property value ${PORT_A_WRITE_RATE} ]"
	
	if {[info exists fileData(Port_B_Write_Rate)]} {
		if {$fileData(Port_B_Write_Rate)} {
			set WriteText "$WriteText\nPort B Write Rate          :     [ get_property value ${PORT_B_WRITE_RATE} ]"
		}
	} elseif {[get_property visible [ipgui::get_groupspec PortB_Group -of $IPINST]] } {
		set WriteText "$WriteText\nPort B Write Rate          :     [ get_property value ${PORT_B_WRITE_RATE} ]"
	}
	
	set WriteText "$WriteText\n----------------------------------------------------------"
   set WriteText "$WriteText\n[est_blk_ram_power $ALGORITHM $ASSUME_SYNCHRONOUS_CLK  \
  $BYTE_SIZE $ECC  \
  $MEMORY_TYPE $OPERATING_MODE_A  \
  $OPERATING_MODE_B $PORT_A_CLOCK  \
  $PORT_A_ENABLE_RATE $PORT_A_WRITE_RATE  \
  $PORT_B_CLOCK $PORT_B_ENABLE_RATE  \
  $PORT_B_WRITE_RATE $PRIMITIVE  \
  $READ_WIDTH_A $READ_WIDTH_B  \
  $USE_BYTE_WRITE_ENABLE $WRITE_DEPTH_A  \
  $WRITE_WIDTH_A $WRITE_WIDTH_B $INTERFACE_TYPE  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} \
  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} ${PARAM_VALUE.USE_BRAM_BLOCK}]"
   set WriteText "$WriteText\n----------------------------------------------------------"
   set f [::ipgen::add_ipfile -force summary.log ]
   ::ipgen::puts_ipfile  $f $WriteText
   ::ipgen::close_ipfile $f

}
proc check_aspect_ration  {WRITE_WIDTH_A WRITE_WIDTH_B READ_WIDTH_A READ_WIDTH_B PARAM_VALUE.MEMORY_TYPE } { 
  set wwa [  get_property value ${WRITE_WIDTH_A} ]
  set wwb [  get_property value ${WRITE_WIDTH_B} ]
  set rwa [  get_property value ${READ_WIDTH_A} ]
  set rwb [  get_property value ${READ_WIDTH_B} ]
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  set aspect_ratio 0
  if {$Memory_Type_value eq "True_Dual_Port_RAM" } {
  if {($wwa == $wwb ) && ( $rwa == $wwb) && ($rwa == $rwb)} {
		  set aspect_ratio 1
	  } else  {
	  	  set aspect_ratio 0
	  }
	  } elseif {$Memory_Type_value eq "Single_Port_RAM"  } { 
  if {($wwa == $rwa )} {
		  set aspect_ratio 1
	  } else  {
	  	  set aspect_ratio 0
	  }
	  } elseif {$Memory_Type_value eq "Simple_Dual_Port_RAM"  } {
	    if {($wwa == $rwb )} {
		  set aspect_ratio 1
		} else  {
	  	  set aspect_ratio 0
	  }
	  }
	  return $aspect_ratio
}
proc get_tmp_fam {WRITE_WIDTH_A WRITE_WIDTH_B READ_WIDTH_A READ_WIDTH_B WRITE_DEPTH_A PARAM_VALUE.Operating_Mode_A PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
                  PARAM_VALUE.Operating_Mode_B PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE USE_BRAM_BLOCK } { 
  set wwa [  get_property value ${WRITE_WIDTH_A} ]
  set wwb [  get_property value ${WRITE_WIDTH_B} ]
  set rwa [  get_property value ${READ_WIDTH_A} ]
  set rwb [  get_property value ${READ_WIDTH_B} ]
  set wda [  get_property value ${WRITE_DEPTH_A} ]
   set use_bram_block [get_property value ${USE_BRAM_BLOCK} ] 
  set Operating_Mode_A    [  get_property value ${PARAM_VALUE.Operating_Mode_A} ]
  set Operating_Mode_B    [  get_property value ${PARAM_VALUE.Operating_Mode_B} ]
  set Use_RSTA_Pin  [  get_property value ${PARAM_VALUE.Use_RSTA_Pin}]
  set Use_RSTB_Pin  [  get_property value ${PARAM_VALUE.Use_RSTB_Pin}]
  set Reset_Memory_Latch_A  [  get_property value ${PARAM_VALUE.Reset_Memory_Latch_A}] 
  set Reset_Memory_Latch_B  [  get_property value ${PARAM_VALUE.Reset_Memory_Latch_B}] 
 
  if {($wwa == $wwb ) && ( $rwa == $wwb) && ($rwa == $rwb)} {
		  set aspect_ratio 1
	  } else  {
	  	  set aspect_ratio 0
	  }
	  set fam [string tolower ${PROJECT_PARAM.ARCHITECTURE} ]
	 if  {($fam eq "virtexuplushbm" ) || ($fam eq "virtexuplus58g" ) || ($fam eq "zynquplusrfsoc" ) || ($fam eq "virtexuplus") || ($fam eq "kintexuplus") || ($fam eq "spartanuplus") || ($fam eq "zynquplus") || ($fam eq "virtexu") || ( $fam eq "kintexu" ) || ( $fam eq "artixu") }  { 
				set is_ultrascale 1 
	 }  else { 
				set is_ultrascale 0 
	 }
	 
	  if { ($is_ultrascale == 1 )&& ($aspect_ratio == 1 ) && ($use_bram_block != "BRAM_Controller" )} { 
	           if {(($Operating_Mode_A eq "NO_CHANGE")&&($Use_RSTA_Pin && $Reset_Memory_Latch_A) ) || (($Operating_Mode_B eq "NO_CHANGE")&&($Use_RSTB_Pin && $Reset_Memory_Latch_B) )} { 
  				set tmp_family 4
			  } else { 			  
				set tmp_family 5
			   }
			} else {
				set tmp_family 4
			}
			#send_msg INFO 9145 "tmp_fam = $tmp_family is_ultrascale $is_ultrascale fam $fam  use_bram_block $use_bram_block"
			return $tmp_family
}




proc getMuxSize { ALGORITHM ASSUME_SYNCHRONOUS_CLK  
  BYTE_SIZE ECCTYPE  
  ENABLE_32BIT_ADDRESS MEMORY_TYPE  
  OPERATING_MODE_A OPERATING_MODE_B  
  PRIMITIVE  READ_WIDTH_A READ_WIDTH_B  
  REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE  
  USE_BRAM_BLOCK USE_BYTE_WRITE_ENABLE  
  WRITE_DEPTH_A WRITE_WIDTH_A  WRITE_WIDTH_B INTERFACE_TYPE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
   PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE } {

  # variable argumentList3
  set regA [get_property value ${REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
  set regB [get_property value ${REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]
  set Algorithm_value [  get_property value ${ALGORITHM} ] 
  set Primitive_value [  get_property value ${PRIMITIVE} ] 
  set Use_Byte_Write_Enable_value [  get_property value ${USE_BYTE_WRITE_ENABLE} ] 
  set Byte_Size_value [  get_property value ${BYTE_SIZE} ] 
  set Operating_Mode_A_value [  get_property value ${OPERATING_MODE_A} ] 
  set ecctype_value [  get_property value ${ECCTYPE} ] 
  set Operating_Mode_B_value [  get_property value ${OPERATING_MODE_B} ]
  set Assume_Synchronous_Clk_value [  get_property value ${ASSUME_SYNCHRONOUS_CLK} ] 
  set mem_type [  get_property value ${MEMORY_TYPE} ]
  set wwa [  get_property value ${WRITE_WIDTH_A} ]
  set wwb [  get_property value ${WRITE_WIDTH_B} ]
  set rwa [  get_property value ${READ_WIDTH_A} ]
  set rwb [  get_property value ${READ_WIDTH_B} ]
  set wda [  get_property value ${WRITE_DEPTH_A} ]
  set wdb [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
  set rda [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
  set rdb [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
  set use_bram_block [get_property value ${USE_BRAM_BLOCK} ] 

	# if {[info exists argumentList3] && $argumentList3(Algorithm) == $Algorithm_value &&
		# $argumentList3(Primitive) == $Primitive_value &&
		# $argumentList3(Memory_Type) == $mem_type &&
		# $argumentList3(Use_Byte_Write_Enable) == $Use_Byte_Write_Enable_value &&
		# $argumentList3(Byte_Size) == $Byte_Size_value &&
		# $argumentList3(Write_Width_A) == $wwa &&
		# $argumentList3(Write_Width_B) == $wwb &&
		# $argumentList3(Read_Width_A) == $rwa &&
		# $argumentList3(Read_Width_B) == $rwb &&
		# $argumentList3(Write_Depth_A) == $wda &&
		# $argumentList3(Operating_Mode_A) == $Operating_Mode_A_value &&
		# $argumentList3(Operating_Mode_B) == $Operating_Mode_B_value &&
		# $argumentList3(ecctype) == $ecctype_value &&
		# $argumentList3(Assume_Synchronous_Clk) == $Assume_Synchronous_Clk_value &&
		# $argumentList3(write_depth_b_value) == $wdb &&
		# $argumentList3(read_depth_a_value) == $rda &&
		# $argumentList3(read_depth_b_value) == $rdb } {
		
			# set mux_size $argumentList3(mux_size)
	# } 
	
   
	  if { $Algorithm_value  == "Fixed_Primitives" } {
		set tmp_algo 0
	  } elseif {$Algorithm_value  == "Minimum_Area" } {
		set tmp_algo 1
	  } else {
		set tmp_algo 2
	  }

	  switch $Primitive_value {
		  16kx1  { set tmp_prim_type 0}
		  8kx2   { set tmp_prim_type 1}
		  4kx4   { set tmp_prim_type 2}
		  2kx9   { set tmp_prim_type 3}
		  1kx18  { set tmp_prim_type 4}
		  512x36 { set tmp_prim_type 5}
		  256x72 { set tmp_prim_type 6}
		  default { send_msg ERROR 7 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Primitive' value: $Primitive" }
	  }

	  # # if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
		# # set tmp_family 4
	  # # } else {
		# # set tmp_family 2
	  # # }
	  # if {($wwa == $wwb ) && ( $rwa == $wwb) && ($rwa == $rwb)} {
		  # set aspect_ratio 1
	  # } else  {
	  	  # set aspect_ratio 0
	  # }
	  
	 
	 # if{(${PROJECT_PARAM.ARCHITECTURE} == "virtexu" || ${PROJECT_PARAM.ARCHITECTURE} == "kintexu" || ${PROJECT_PARAM.ARCHITECTURE} == "artixu")} {set is_ultrascale 1 }  else {set is_ultrascale 0 }
	 
	  # if { $is_ultrascale && ($aspect_ratio == 1 ) && ($use_bram_block != "BRAM_Controller" )} {
	          # if  {0 } {
				# set tmp_family 4
			  # } else { 			  
				# set tmp_family 5
			   # }
			# } else {
				# set tmp_family 4
			# }
			set tmp_family [get_tmp_fam $WRITE_WIDTH_A $WRITE_WIDTH_B $READ_WIDTH_A $READ_WIDTH_B $WRITE_DEPTH_A $OPERATING_MODE_A ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} $OPERATING_MODE_B ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} $USE_BRAM_BLOCK]
		#send_msg INFO 9122 "tem_fam set to $tmp_family"	  
	  switch $mem_type {
		 "Single_Port_RAM"      { set tmp_mem_type 0 }
		 "Simple_Dual_Port_RAM" { set tmp_mem_type 1 }
		 "True_Dual_Port_RAM"   { set tmp_mem_type 2 }
		 "Single_Port_ROM"      { set tmp_mem_type 3 }
		 "Dual_Port_ROM"        { set tmp_mem_type 4 }
		 default { send_msg ERROR 8 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Memory_Type' value: $mem_type" }
	  }

	  if {$Use_Byte_Write_Enable_value} {
		set tmp_bytewe 1
	  } else {
		set tmp_bytewe 0
	  }

		set tmp_byte_size $Byte_Size_value
		
		switch $Operating_Mode_A_value {
		  "WRITE_FIRST" { set tmp_write_mode_a 0 }
		  "READ_FIRST"  { set tmp_write_mode_a 1 }
		  "NO_CHANGE"   { set tmp_write_mode_a 2 }
		  default { send_msg ERROR 9 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_A' value: $Operating_Mode_A" }
	   }

	   switch $Operating_Mode_B_value {
		  "WRITE_FIRST" { set tmp_write_mode_b 0}
		  "READ_FIRST"  { set tmp_write_mode_b 1}
		  "NO_CHANGE"   { set tmp_write_mode_b 2}
		  default { send_msg ERROR 10 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_B' value: $Operating_Mode_B" }
	   }

	   if {$ecctype_value == "BuiltIn_ECC"} {
		  set tmp_use_ecc 1
	   } else {
		  set tmp_use_ecc 0
	   }

	   if {$Assume_Synchronous_Clk_value} {
		 set tmp_use_common_clk 1
	   } else {
		 set tmp_use_common_clk 0
	   }
		
#		if { $wda > [getMaxWriteDepthA  ${PARAM_VALUE.WRITE_WIDTH_A}]} {
#			return ""
#		}

       set safe_algo_call [algo_call_safety_check $INTERFACE_TYPE $WRITE_WIDTH_A $WRITE_DEPTH_A $USE_BYTE_WRITE_ENABLE $BYTE_SIZE] 

	   if {$safe_algo_call == 1} {
	     set mux_size [ blk_mem_gen_v8_4_utils::GetPlacementAlgoMuxSize  80000  $tmp_algo  $tmp_prim_type  $tmp_family  $tmp_mem_type  $tmp_bytewe  $tmp_bytewe  $tmp_byte_size  $wwa  $wwb  $rwa  $rwb  $wda  $wdb  $rda  $rdb  $tmp_write_mode_a  $tmp_write_mode_b  $tmp_use_ecc  $tmp_use_common_clk ]
       } else {
          set mux_size 0
       }
		# set argumentList3(Algorithm)  $Algorithm_value 
		# set argumentList3(Primitive)  $Primitive_value 
		# set argumentList3(Memory_Type)  $mem_type 
		# set argumentList3(Use_Byte_Write_Enable)  $Use_Byte_Write_Enable_value 
		# set argumentList3(Byte_Size)  $Byte_Size_value 
		# set argumentList3(Write_Width_A)  $wwa 
		# set argumentList3(Write_Width_B)  $wwb 
		# set argumentList3(Read_Width_A)  $rwa 
		# set argumentList3(Read_Width_B)  $rwb 
		# set argumentList3(Write_Depth_A)  $wda 
		# set argumentList3(Operating_Mode_A)  $Operating_Mode_A_value 
		# set argumentList3(Operating_Mode_B)  $Operating_Mode_B_value 
		# set argumentList3(ecctype)  $ecctype_value 
		# set argumentList3(Assume_Synchronous_Clk)  $Assume_Synchronous_Clk_value 
		# set argumentList3(write_depth_b_value)  $wdb 
		# set argumentList3(read_depth_a_value)  $rda 
		# set argumentList3(read_depth_b_value)  $rdb 
		# set argumentList3(mux_size) $mux_size
	
	
	return $mux_size
}

proc algo_call_safety_check { INTERFACE_TYPE WRITE_WIDTH_A WRITE_DEPTH_A USE_BYTE_WRITE_ENABLE BYTE_SIZE} {
	set wwa [ get_property value ${WRITE_WIDTH_A} ]
	set wda [ get_property value ${WRITE_DEPTH_A} ]
	set byte_enable [get_property value ${USE_BYTE_WRITE_ENABLE}]
	set byte_size [get_property value ${BYTE_SIZE}]
       
     # call the algorithm only for valid set of values that are allowed by BMG
      if { [ get_property value ${INTERFACE_TYPE} ] == "Native"} {
        if { (!$byte_enable) || ($byte_enable  && $byte_size == 8)} {
          if { (( ($wwa >= 1 && $wwa <= 128) && $wda <= 1024*1024 ) || (($wwa >= 129 && $wwa <= 256) && $wda <= 512*1024) || (($wwa >= 257 && $wwa <= 512) && $wda <= 256*1024) || (($wwa >= 513 && $wwa <= 1024) && $wda <= 128*1024) || (($wwa >= 1025 && $wwa <= 2048) && $wda <= 64*1024) || ($wwa >2048 && $wda <= 32*1024)) } {
               set safe_algo_call 1
			} else {
               set safe_algo_call 0
            }
        } elseif { $byte_size == 9 } {
			if { ( ($wwa >= 1 && $wwa <= 144) && $wda <= 1024*1024 ) || (($wwa > 144 && $wwa <= 288) && $wda <= 512*1024) || (($wwa > 288 && $wwa <= 576) && $wda <= 256*1024) || (($wwa > 576 && $wwa <= 1152) && $wda <= 128*1024) || (($wwa > 1152 && $wwa <= 2304) && $wda <= 64*1024) || ($wwa > 2304 && $wda <= 32*1024) } {
               set safe_algo_call 1   
			} else {
               set safe_algo_call 0
            }
		} else {
          set safe_algo_call 0
		}    
	  } else {
         if { ( ($wwa >= 1 && $wwa <= 128) && $wda <= 1024*1024 ) || (($wwa >= 129 && $wwa <= 256) && $wda <= 512*1024) || (($wwa >= 257 && $wwa <= 512) && $wda <= 256*1024) || (($wwa >= 513 && $wwa <= 1024) && $wda <= 128*1024) || (($wwa >= 1025 && $wwa <= 2048) && $wda <= 64*1024) || ($wwa >2048 && $wda <= 32*1024) } {
            set safe_algo_call 1   
         } else {
            set safe_algo_call 0
         }
      }
	return $safe_algo_call
}
proc getMaxWriteDepthA { INTERFACE_TYPE WRITE_WIDTH_A USE_BYTE_WRITE_ENABLE BYTE_SIZE} {
	;# fix for CR : 733448
	set wwa [ get_property value ${WRITE_WIDTH_A} ]
	set byte_enable [get_property value ${USE_BYTE_WRITE_ENABLE}]
	set byte_size [get_property value ${BYTE_SIZE}]
	
	if {[ get_property value ${INTERFACE_TYPE} ] == "Native"} {
		if { (!$byte_enable)} {
			if {$wwa >= 1 && $wwa <= 128 } {
				return [expr "1024*1024"]
			} elseif {$wwa >= 129 && $wwa <= 256 } {
				return [expr "512*1024"]
			} elseif {$wwa >= 257 && $wwa <= 512  } {
				return [expr "256*1024"]
			} elseif {$wwa >= 513 && $wwa <= 1024 } {
				return [expr "128*1024"]
			} elseif {$wwa >= 1025 && $wwa <= 2048} {
				return [expr "64*1024"]
			} elseif {$wwa > 2048 } {
				return [expr "32*1024"]
			}
		} else {
			;# Fix for CR731985
			if { $byte_size == 8 } {
				if {$wwa >= 1 && $wwa <= 128 } {
					return [expr "1024*1024"]
				} elseif {$wwa >= 129 && $wwa <= 256 } {
					return [expr "512*1024"]
				} elseif {$wwa >= 257 && $wwa <= 512 } {
					return [expr "256*1024"]
				} elseif {$wwa >= 513 && $wwa <= 1024 } {
					return [expr "128*1024"]
				} elseif {$wwa >= 1025 && $wwa <= 2048} {
					return [expr "64*1024"]
				} elseif {$wwa > 2048 } {
					return [expr "32*1024"]
				}
			} else {
				if {$wwa >= 1 && $wwa <= 144 } {
					return [expr "1024*1024"]
				} elseif {$wwa > 144 && $wwa <= 288 } {
					return [expr "512*1024"]
				} elseif {$wwa > 288 && $wwa <= 576 } {
					return [expr "256*1024"]
				} elseif {$wwa > 576 && $wwa <= 1152 } {
					return [expr "128*1024"]
				} elseif {$wwa > 1152 && $wwa <= 2304 } {
					return [expr "64*1024"]
				} elseif {$wwa > 2304 } {
					return [expr "32*1024"]
				}
			}
		}
	} else {
		if {$wwa >= 1 && $wwa <= 128 } {
			return [expr "1024*1024"]
		} elseif {$wwa >= 129 && $wwa <= 256 } {
			return [expr "512*1024"]
		} elseif {$wwa >= 257 && $wwa <= 512 } {
			return [expr "256*1024"]
		} elseif {$wwa >= 513 && $wwa <= 1024 } {
			return [expr "128*1024"]
		} elseif {$wwa >= 1025 && $wwa <= 2048} {
			return [expr "64*1024"]
		} elseif {$wwa > 2048 } {
			return [expr "32*1024"]
		}
	}
}

#proc getMaxWriteDepthA { INTERFACE_TYPE WRITE_WIDTH_A USE_BYTE_WRITE_ENABLE BYTE_SIZE} {
#	;# fix for CR : 733448
#	set wwa [ get_property value ${WRITE_WIDTH_A} ]
#	set byte_enable [get_property value ${USE_BYTE_WRITE_ENABLE}]
#	set byte_size [get_property value ${BYTE_SIZE}]
#	
#	if {[ get_property value ${INTERFACE_TYPE} ] == "Native"} {
#		if { $byte_enable == false} {
#			if {$wwa >= 1 && $wwa <= 128 } {
#				return [expr "256*1024"]
#			} elseif {$wwa >= 129 && $wwa <= 256 } {
#				return [expr "128*1024"]
#			} elseif {$wwa >= 257 && $wwa <= 512  } {
#				return [expr "64*1024"]
#			} elseif {$wwa >= 513 && $wwa <= 1024 } {
#				return [expr "32*1024"]
#			} elseif {$wwa >= 1025 && $wwa <= 2048} {
#				return [expr "16*1024"]
#			} elseif {$wwa > 2048 } {
#				return [expr "8*1024"]
#			}
#		} else {
#			;# Fix for CR731985
#			if { $byte_size == 8 } {
#				if {$wwa >= 1 && $wwa <= 128 } {
#					return [expr "256*1024"]
#				} elseif {$wwa >= 129 && $wwa <= 256 } {
#					return [expr "128*1024"]
#				} elseif {$wwa >= 257 && $wwa <= 512 } {
#					return [expr "64*1024"]
#				} elseif {$wwa >= 513 && $wwa <= 1024 } {
#					return [expr "32*1024"]
#				} elseif {$wwa >= 1025 && $wwa <= 2048} {
#					return [expr "16*1024"]
#				} elseif {$wwa > 2048 } {
#					return [expr "8*1024"]
#				}
#			} else {
#				if {$wwa >= 1 && $wwa <= 144 } {
#					return [expr "256*1024"]
#				} elseif {$wwa > 144 && $wwa <= 288 } {
#					return [expr "128*1024"]
#				} elseif {$wwa > 288 && $wwa <= 576 } {
#					return [expr "64*1024"]
#				} elseif {$wwa > 576 && $wwa <= 1152 } {
#					return [expr "32*1024"]
#				} elseif {$wwa > 1152 && $wwa <= 2304 } {
#					return [expr "16*1024"]
#				} elseif {$wwa > 2304 } {
#					return [expr "8*1024"]
#				}
#			}
#		}
#	} else {
#		if {$wwa >= 1 && $wwa <= 128 } {
#			return [expr "256*1024"]
#		} elseif {$wwa >= 129 && $wwa <= 256 } {
#			return [expr "128*1024"]
#		} elseif {$wwa >= 257 && $wwa <= 512 } {
#			return [expr "64*1024"]
#		} elseif {$wwa >= 513 && $wwa <= 1024 } {
#			return [expr "32*1024"]
#		} elseif {$wwa >= 1025 && $wwa <= 2048} {
#			return [expr "16*1024"]
#		} elseif {$wwa > 2048 } {
#			return [expr "8*1024"]
#		}
#	}
#}

# proc getMaxWriteDepthA {  PARAM_VALUE.WRITE_WIDTH_A } {
  
  # set wwa [ get_property value ${PARAM_VALUE.WRITE_WIDTH_A} ]

  # set bram_bits_count [ get_bram_bits_count ]
  # return 262144
 # #return [expr 262144 / $wwa ]
 # # return [expr bram_bits_count / $wwa ]
  # }


proc est_blk_ram_resource_x { x ALGORITHM ASSUME_SYNCHRONOUS_CLK  
  BYTE_SIZE ECCTYPE  
  MEMORY_TYPE OPERATING_MODE_A  
  OPERATING_MODE_B PRIMITIVE  
  READ_WIDTH_A READ_WIDTH_B  
  SOFTECC USE_BYTE_WRITE_ENABLE  
  WRITE_DEPTH_A WRITE_WIDTH_A  
  WRITE_WIDTH_B INTERFACE_TYPE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE USE_BRAM_BLOCK} {

 # variable argumentList1
  
  set Algorithm_value [ get_property value ${ALGORITHM} ] 
  set Primitive_value [ get_property value ${PRIMITIVE} ] 
  set Memory_Type_value [ get_property value ${MEMORY_TYPE} ] 
  set Use_Byte_Write_Enable_value [ get_property value ${USE_BYTE_WRITE_ENABLE} ] 
  set Byte_Size_value [ get_property value ${BYTE_SIZE} ] 
  set ecctype_value [ get_property value ${ECCTYPE} ] 
  set softecc_value [ get_property value ${SOFTECC} ]
  set Operating_Mode_A_value [ get_property value ${OPERATING_MODE_A} ] 
  set Operating_Mode_B_value [ get_property value ${OPERATING_MODE_B} ] 
  set Assume_Synchronous_Clk_value [ get_property value ${ASSUME_SYNCHRONOUS_CLK} ] 
  set Write_Width_A_value [ get_property value ${WRITE_WIDTH_A} ] 
  set Write_Depth_A_value [ get_property value ${WRITE_DEPTH_A} ] 
  set Write_Width_B_value [ get_property value ${WRITE_WIDTH_B} ] 
  set Read_Width_A_value [ get_property value ${READ_WIDTH_A} ] 
  set Read_Width_B_value [ get_property value ${READ_WIDTH_B} ] 
	
	# if {$argumentList1(isFirstCall_$x) == false && $argumentList1(Algorithm_$x) == $Algorithm_value && 
	# $argumentList1(Primitive_$x) == $Primitive_value && $argumentList1(Memory_Type_$x) == $Memory_Type_value &&
	# $argumentList1(Use_Byte_Write_Enable_$x) == $Use_Byte_Write_Enable_value && 
	# $argumentList1(Byte_Size_$x) == $Byte_Size_value && $argumentList1(ecctype_$x) == $ecctype_value &&
	# $argumentList1(softecc_value_$x) == $softecc_value &&
	# $argumentList1(Operating_Mode_A_$x) == $Operating_Mode_A_value && $argumentList1(Operating_Mode_B_$x) == $Operating_Mode_B_value &&
	# $argumentList1(Assume_Synchronous_Clk_$x) == $Assume_Synchronous_Clk_value && $argumentList1(Write_Width_A_$x) == $Write_Width_A_value &&
	# $argumentList1(Write_Depth_A_$x) == $Write_Depth_A_value && $argumentList1(Write_Width_B_$x) == $Write_Width_B_value &&
	# $argumentList1(Read_Width_A_$x) == $Read_Width_A_value && $argumentList1(Read_Width_B_$x) == $Read_Width_B_value &&
	# $argumentList1(write_depth_b_value_$x) == [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}] && 
	# $argumentList1(read_depth_a_value_$x) == [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}] && 
	# $argumentList1(read_depth_b_value_$x) == [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}] } {
	
		# return $argumentList1(rams_used_$x)
	# }
	
	
	# if { $Write_Depth_A_value > [getMaxWriteDepthA  ${WRITE_WIDTH_A}]} {
		# return ""
	# }
  ###### GetPlacementAlgoNumPrims parameters:
  ###### c_max_prims, c_algorithm, c_prim_type, c_family,
  ###### c_mem_type, c_use_byte_wea, c_use_byte_web, c_byte_size
  ###### write_width_a, write_width_b, read_width_a, read_width_b
  ###### write_depth_a, write_depth_b, read_depth_a, read_depth_b
  if {$Algorithm_value == "Fixed_Primitives" } {
    set tmp_algo 0
  } elseif {$Algorithm_value == "Minimum_Area" } {
    set tmp_algo 1
  } else {
    set tmp_algo 2
  }

  switch $Primitive_value {
    16kx1  { set tmp_prim_type 0}
    8kx2   { set tmp_prim_type 1}
    4kx4   { set tmp_prim_type 2}
    2kx9   { set tmp_prim_type 3}
    1kx18  { set tmp_prim_type 4}
    512x36 { set tmp_prim_type 5}
    256x72 { set tmp_prim_type 6}
    default { send_msg ERROR 11 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Primitive' value: $Primitive_value" }
  }

  # if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
    # set tmp_family 4
  # } else {
    # set tmp_family 0
  # }
    set tmp_family [get_tmp_fam $WRITE_WIDTH_A $WRITE_WIDTH_B $READ_WIDTH_A $READ_WIDTH_B $WRITE_DEPTH_A ${OPERATING_MODE_A} ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} ${OPERATING_MODE_B} ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} $USE_BRAM_BLOCK]
  

  switch $Memory_Type_value {
    "Single_Port_RAM"      { set tmp_mem_type 0 }
    "Simple_Dual_Port_RAM" { set tmp_mem_type 1 }
    "True_Dual_Port_RAM"   { set tmp_mem_type 2 }
    "Single_Port_ROM"      { set tmp_mem_type 3 }
    "Dual_Port_ROM"        { set tmp_mem_type 4 }
    default { send_msg ERROR 0 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Memory_Type' value: $Memory_Type_value" }
  }

  if {$Use_Byte_Write_Enable_value} {
    set tmp_bytewe 1
  } else {
    set tmp_bytewe 0
  }

  set tmp_byte_size $Byte_Size_value

  set wwa $Write_Width_A_value 
  set wwb [  get_property value ${WRITE_WIDTH_B} ]
  set rwa [  get_property value ${READ_WIDTH_A} ]
  set rwb [  get_property value ${READ_WIDTH_B} ]
  set wda [  get_property value ${WRITE_DEPTH_A} ]

  set wdb [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
  set rda [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
  set rdb [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
  
  switch $Operating_Mode_A_value {
    "WRITE_FIRST" { set tmp_write_mode_a 0 }
    "READ_FIRST"  { set tmp_write_mode_a 1 }
    "NO_CHANGE"   { set tmp_write_mode_a 2 }
    default { send_msg ERROR 1 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_A' value: $Operating_Mode_A_value" }
  }

  switch $Operating_Mode_B_value {
    "WRITE_FIRST" { set tmp_write_mode_b 0}
    "READ_FIRST"  { set tmp_write_mode_b 1}
    "NO_CHANGE"   { set tmp_write_mode_b 2}
    default { send_msg ERROR 2 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_B' value: $Operating_Mode_B_value" }
  }

  if {$ecctype_value == "BuiltIn_ECC"} {
    set tmp_use_ecc 1
  } else {
    set tmp_use_ecc 0
  }

      
  if {$Assume_Synchronous_Clk_value} {
    set tmp_use_common_clk 1
  } else {
    set tmp_use_common_clk 0
  }

   if {$softecc_value} {
      if {$wwa > 57} {
      set write_width_a_softecc [expr $wwa + 8]
      set write_width_b_softecc [expr $wwb + 8]
      set read_width_a_softecc [expr $rwa + 8]
      set read_width_b_softecc [expr $rwb + 8]
      } elseif {$wwa > 26}  {
      set write_width_a_softecc [expr $wwa + 7]
      set write_width_b_softecc [expr $wwb + 7]
      set read_width_a_softecc [expr $rwa + 7]
      set read_width_b_softecc [expr $rwb + 7]
      } elseif {$wwa > 11}  {
      set write_width_a_softecc [expr $wwa + 6]
      set write_width_b_softecc [expr $wwb + 6]
      set read_width_a_softecc [expr $rwa + 6]
      set read_width_b_softecc [expr $rwb + 6]
      } elseif {$wwa > 4}  {
      set write_width_a_softecc [expr $wwa + 5]
      set write_width_b_softecc [expr $wwb + 5]
      set read_width_a_softecc [expr $rwa + 5]
      set read_width_b_softecc [expr $rwb + 5]
      } elseif {$wwa <5}  {
      set write_width_a_softecc [expr $wwa + 4]
      set write_width_b_softecc [expr $wwb + 4]
      set read_width_a_softecc [expr $rwa + 4]
      set read_width_b_softecc [expr $rwb + 4]
      } else { 
      set write_width_a_softecc $Write_Width_A_value
      set write_width_b_softecc [ get_property value ${WRITE_WIDTH_B} ]
      set read_width_a_softecc [ get_property value ${READ_WIDTH_A} ]
      set read_width_b_softecc [ get_property value ${READ_WIDTH_B} ]
      } 
   } else { 
      set write_width_a_softecc $Write_Width_A_value
      set write_width_b_softecc [ get_property value ${WRITE_WIDTH_B} ]
      set read_width_a_softecc [ get_property value ${READ_WIDTH_A} ]
      set read_width_b_softecc [ get_property value ${READ_WIDTH_B} ]
   }
      
       set safe_algo_call [algo_call_safety_check $INTERFACE_TYPE $WRITE_WIDTH_A $WRITE_DEPTH_A $USE_BYTE_WRITE_ENABLE $BYTE_SIZE] 

	   if { $safe_algo_call == 1} {
         set rams_used [ blk_mem_gen_v8_4_utils::GetPlacementAlgoNumPrims_$x  80000  $tmp_algo  $tmp_prim_type  $tmp_family  $tmp_mem_type  $tmp_bytewe  $tmp_bytewe  $tmp_byte_size  $write_width_a_softecc  $write_width_b_softecc  $read_width_a_softecc  $read_width_b_softecc  $wda  $wdb  $rda  $rdb  $tmp_write_mode_a  $tmp_write_mode_b  $tmp_use_ecc  $tmp_use_common_clk ]
       } else {
         set rams_used 0
       }
	
	# set argumentList1(Algorithm_$x) [ get_property value ${ALGORITHM} ]
	# set argumentList1(Primitive_$x) [ get_property value ${PRIMITIVE} ]
	# set argumentList1(Memory_Type_$x) [ get_property value ${MEMORY_TYPE} ]
	# set argumentList1(Use_Byte_Write_Enable_$x) [ get_property value ${USE_BYTE_WRITE_ENABLE} ]
	# set argumentList1(Byte_Size_$x) [ get_property value ${BYTE_SIZE} ]
	# set argumentList1(ecctype_$x) [ get_property value ${ECCTYPE} ]
	# set argumentList1(Operating_Mode_A_$x) [ get_property value ${OPERATING_MODE_A} ]
	# set argumentList1(Operating_Mode_B_$x) [ get_property value ${OPERATING_MODE_B} ]
	# set argumentList1(Assume_Synchronous_Clk_$x) [ get_property value ${ASSUME_SYNCHRONOUS_CLK} ]
	# set argumentList1(Write_Width_A_$x) [ get_property value ${WRITE_WIDTH_A} ]
	# set argumentList1(Write_Depth_A_$x) [ get_property value ${WRITE_DEPTH_A} ]
	# set argumentList1(Write_Width_B_$x) [ get_property value ${WRITE_WIDTH_B} ]
	# set argumentList1(Read_Width_A_$x) [ get_property value ${READ_WIDTH_A} ]
	# set argumentList1(Read_Width_B_$x) [ get_property value ${READ_WIDTH_B} ]
	# set argumentList1(write_depth_b_value_$x) [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
	# set argumentList1(read_depth_a_value_$x) [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
	# set argumentList1(read_depth_b_value_$x) [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
	# set argumentList1(softecc_value_$x) [ get_property value ${SOFTECC} ]
	# set argumentList1(rams_used_$x) $rams_used
	# set argumentList1(isFirstCall_$x) false
	
    return $rams_used


}

proc est_blk_ram_resource_36 {ALGORITHM ASSUME_SYNCHRONOUS_CLK  
  BYTE_SIZE ECCTYPE  
  MEMORY_TYPE OPERATING_MODE_A  
  OPERATING_MODE_B PRIMITIVE  
  READ_WIDTH_A READ_WIDTH_B  
  SOFTECC USE_BYTE_WRITE_ENABLE  
  WRITE_DEPTH_A WRITE_WIDTH_A  
  WRITE_WIDTH_B INTERFACE_TYPE PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
  PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE PARAM_VALUE.USE_BRAM_BLOCK} {
   
  return [est_blk_ram_resource_x 36 $ALGORITHM $ASSUME_SYNCHRONOUS_CLK \
  $BYTE_SIZE $ECCTYPE $MEMORY_TYPE \
  $OPERATING_MODE_A $OPERATING_MODE_B $PRIMITIVE $READ_WIDTH_A $READ_WIDTH_B \
  $SOFTECC $USE_BYTE_WRITE_ENABLE $WRITE_DEPTH_A $WRITE_WIDTH_A $WRITE_WIDTH_B $INTERFACE_TYPE  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK} ]

}

proc est_blk_ram_resource_18 {ALGORITHM ASSUME_SYNCHRONOUS_CLK  
  BYTE_SIZE ECCTYPE  
  MEMORY_TYPE OPERATING_MODE_A  
  OPERATING_MODE_B PRIMITIVE  
  READ_WIDTH_A READ_WIDTH_B  
  SOFTECC USE_BYTE_WRITE_ENABLE  
  WRITE_DEPTH_A WRITE_WIDTH_A  
  WRITE_WIDTH_B INTERFACE_TYPE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
   PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE  PARAM_VALUE.USE_BRAM_BLOCK } {

  return [est_blk_ram_resource_x 18 $ALGORITHM $ASSUME_SYNCHRONOUS_CLK \
  $BYTE_SIZE $ECCTYPE $MEMORY_TYPE $OPERATING_MODE_A \
  $OPERATING_MODE_B $PRIMITIVE $READ_WIDTH_A $READ_WIDTH_B $SOFTECC \
  $USE_BYTE_WRITE_ENABLE $WRITE_DEPTH_A $WRITE_WIDTH_A $WRITE_WIDTH_B $INTERFACE_TYPE  ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A}  ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE}  ${PARAM_VALUE.USE_BRAM_BLOCK}  ]

}

proc est_blk_ram_power { ALGORITHM ASSUME_SYNCHRONOUS_CLK  
  BYTE_SIZE ECC  
  MEMORY_TYPE OPERATING_MODE_A  
  OPERATING_MODE_B PORT_A_CLOCK  
  PORT_A_ENABLE_RATE PORT_A_WRITE_RATE  
  PORT_B_CLOCK PORT_B_ENABLE_RATE  
  PORT_B_WRITE_RATE PRIMITIVE  
  READ_WIDTH_A READ_WIDTH_B  
  USE_BYTE_WRITE_ENABLE WRITE_DEPTH_A  
  WRITE_WIDTH_A WRITE_WIDTH_B INTERFACE_TYPE  PARAM_VALUE.Use_RSTA_Pin PARAM_VALUE.Reset_Memory_Latch_A 
   PARAM_VALUE.Use_RSTB_Pin PARAM_VALUE.Reset_Memory_Latch_B PROJECT_PARAM.ARCHITECTURE USE_BRAM_BLOCK PARAM_VALUE.PRIM_type_to_Implement} {

  #variable argumentList2
	if { [get_property value $WRITE_DEPTH_A] > [getMaxWriteDepthA $INTERFACE_TYPE  $WRITE_WIDTH_A $USE_BYTE_WRITE_ENABLE $BYTE_SIZE]} {
		return ""
	}
	
   # if {[info exists argumentList2] && $argumentList2(Algorithm) == [ get_property value ${ALGORITHM} ] &&
		# $argumentList2(Primitive) == [ get_property value ${PRIMITIVE} ] &&
		# $argumentList2(Memory_Type) == [ get_property value ${MEMORY_TYPE} ] &&
		# $argumentList2(Use_Byte_Write_Enable) == [ get_property value ${USE_BYTE_WRITE_ENABLE} ] &&
		# $argumentList2(Byte_Size) == [ get_property value ${BYTE_SIZE} ] &&
		# $argumentList2(Write_Width_A) == [ get_property value ${WRITE_WIDTH_A} ] &&
		# $argumentList2(Write_Width_B) == [ get_property value ${WRITE_WIDTH_B} ] &&
		# $argumentList2(Read_Width_A) == [ get_property value ${READ_WIDTH_A} ] &&
		# $argumentList2(Read_Width_B) == [ get_property value ${READ_WIDTH_B} ] &&
		# $argumentList2(Write_Depth_A) == [ get_property value ${WRITE_DEPTH_A} ] &&
		# $argumentList2(Operating_Mode_A) == [ get_property value ${OPERATING_MODE_A} ] &&
		# $argumentList2(Operating_Mode_B) == [ get_property value ${OPERATING_MODE_B} ] &&
		# $argumentList2(ECC) == [ get_property value ${ECC} ] &&
		# $argumentList2(Assume_Synchronous_Clk) == [ get_property value ${ASSUME_SYNCHRONOUS_CLK} ] &&
		# $argumentList2(Port_A_Clock) == [ get_property value ${PORT_A_CLOCK} ] &&
		# $argumentList2(Port_A_Write_Rate) == [ get_property value ${PORT_A_WRITE_RATE} ] &&
		# $argumentList2(Port_A_Enable_Rate) == [ get_property value ${PORT_A_ENABLE_RATE} ] &&
		# $argumentList2(Port_B_Clock) == [ get_property value ${PORT_B_CLOCK} ] &&
		# $argumentList2(Port_B_Write_Rate) == [ get_property value ${PORT_B_WRITE_RATE} ] &&
		# $argumentList2(Port_B_Enable_Rate) == [ get_property value ${PORT_B_ENABLE_RATE} ] &&
		# $argumentList2(write_depth_b_value) == [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}] &&
		# $argumentList2(read_depth_a_value) == [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}] &&
		# $argumentList2(read_depth_b_value) == [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}] } {
			
			# set power $argumentList2(power)
			# return "Estimated Power for IP     :     [expr {$power/1000000.00}] mW"
   # }
   
   if {[  get_property value ${ALGORITHM} ] == "Fixed_Primitives" } {
     set tmp_algo 0
   } elseif {[  get_property value ${ALGORITHM} ] == "Minimum_Area" } {
     set tmp_algo 1
   } else {
     set tmp_algo 2
   }

   switch [  get_property value ${PRIMITIVE} ] {
      16kx1  { set tmp_prim_type 0}
      8kx2   { set tmp_prim_type 1}
      4kx4   { set tmp_prim_type 2}
      2kx9   { set tmp_prim_type 3}
      1kx18  { set tmp_prim_type 4}
      512x36 { set tmp_prim_type 5}
      256x72 { set tmp_prim_type 6}
      default { send_msg ERROR 3 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Primitive' value: [  get_property value ${PRIMITIVE} ]" }
   }

   # if { [isDerivedFamilyOfV7 ${PROJECT_PARAM.ARCHITECTURE}] } {
      # set tmp_family 4
   # } else {
      # set tmp_family 0
   # }
    #  set tmp_family 4
   set tmp_family [get_tmp_fam $WRITE_WIDTH_A $WRITE_WIDTH_B $READ_WIDTH_A $READ_WIDTH_B $WRITE_DEPTH_A $OPERATING_MODE_A ${PARAM_VALUE.Use_RSTA_Pin} ${PARAM_VALUE.Reset_Memory_Latch_A} $OPERATING_MODE_B ${PARAM_VALUE.Use_RSTB_Pin} ${PARAM_VALUE.Reset_Memory_Latch_B} ${PROJECT_PARAM.ARCHITECTURE} $USE_BRAM_BLOCK]

   switch [  get_property value ${MEMORY_TYPE} ] {
      "Single_Port_RAM"      { set tmp_mem_type 0 }
      "Simple_Dual_Port_RAM" { set tmp_mem_type 1 }
      "True_Dual_Port_RAM"   { set tmp_mem_type 2 }
      "Single_Port_ROM"      { set tmp_mem_type 3 }
      "Dual_Port_ROM"        { set tmp_mem_type 4 }
      default { send_msg ERROR 4 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Memory_Type' value: [  get_property value ${MEMORY_TYPE} ]" }
   }

   if {[  get_property value ${USE_BYTE_WRITE_ENABLE} ]} {
      set tmp_bytewe 1
   } else {
      set tmp_bytewe 0
   }
   set tmp_byte_size [  get_property value ${BYTE_SIZE} ]

   set wwa [  get_property value ${WRITE_WIDTH_A} ]
   set wwb [  get_property value ${WRITE_WIDTH_B} ]
   set rwa [  get_property value ${READ_WIDTH_A} ]
   set rwb [  get_property value ${READ_WIDTH_B} ]
   set wda [  get_property value ${WRITE_DEPTH_A} ]

   set wdb [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
   set rda [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
   set rdb [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]

   switch [  get_property value ${OPERATING_MODE_A} ] {
      "WRITE_FIRST" { set tmp_write_mode_a 0 }
      "READ_FIRST"  { set tmp_write_mode_a 1 }
      "NO_CHANGE"   { set tmp_write_mode_a 2 }
      default { send_msg ERROR 5 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_A' value: [  get_property value ${OPERATING_MODE_A} ]" }
   }
   switch [  get_property value ${OPERATING_MODE_B} ] {
      "WRITE_FIRST" { set tmp_write_mode_b 0}
      "READ_FIRST"  { set tmp_write_mode_b 1}
      "NO_CHANGE"   { set tmp_write_mode_b 2}
      default { send_msg ERROR 6 "ERROR: blk_mem_gen_v8_4::est_blk_ram_resource() detected unknown 'Operating_Mode_B' value: [  get_property value ${OPERATING_MODE_B} ]" }
   }

   if {[  get_property value ${ECC} ] } {
      set tmp_use_ecc 1
   } else {
      set tmp_use_ecc 0
   }
      
      if {[  get_property value ${ASSUME_SYNCHRONOUS_CLK} ]} {
       set tmp_use_common_clk 1
      } else {
       set tmp_use_common_clk 0
      }

   set cra [  get_property value ${PORT_A_CLOCK} ]
   set wra_temp [  get_property value ${PORT_A_WRITE_RATE} ]
   set wra [expr $wra_temp/100.0]
   set ena_temp [  get_property value ${PORT_A_ENABLE_RATE} ]
   set ena [expr $ena_temp/100.0]
   set crb [  get_property value ${PORT_B_CLOCK} ]
   set wrb_temp [  get_property value ${PORT_B_WRITE_RATE} ]
   set wrb [expr $wrb_temp/100.0]
   set enb_temp [  get_property value ${PORT_B_ENABLE_RATE} ]
   set enb [expr $enb_temp/100.0]

   set tmp_part_name [get_project_property PART]
   set PRIM_TYPE_TO_IMPLEMENT [  get_property value ${PARAM_VALUE.PRIM_type_to_Implement} ]
   
   set safe_algo_call [algo_call_safety_check $INTERFACE_TYPE $WRITE_WIDTH_A $WRITE_DEPTH_A $USE_BYTE_WRITE_ENABLE $BYTE_SIZE] 

   if { $PRIM_TYPE_TO_IMPLEMENT ne "BRAM"} {
      set power 0
   } else {
      if { $safe_algo_call == 1} {
        set power [ blk_mem_gen_v8_4_utils::GetPlacementAlgoPower  80000  $tmp_algo  $tmp_prim_type  4  $tmp_mem_type  $tmp_bytewe  $tmp_bytewe  $tmp_byte_size  $wwa  $wwb  $rwa  $rwb  $wda  $wdb  $rda  $rdb  $tmp_write_mode_a  $tmp_write_mode_b  $tmp_use_ecc  $tmp_part_name  $cra  $wra  $crb  $wrb  $ena  $enb  $tmp_use_common_clk ]
      } else {
        set power 0
      }
   }
	# set argumentList2(Algorithm)  [ get_property value ${ALGORITHM} ] 
	# set argumentList2(Primitive)  [ get_property value ${PRIMITIVE} ] 
	# set argumentList2(Memory_Type)  [ get_property value ${MEMORY_TYPE} ] 
	# set argumentList2(Use_Byte_Write_Enable)  [ get_property value ${USE_BYTE_WRITE_ENABLE} ] 
	# set argumentList2(Byte_Size)  [ get_property value ${BYTE_SIZE} ] 
	# set argumentList2(Write_Width_A)  [ get_property value ${WRITE_WIDTH_A} ] 
	# set argumentList2(Write_Width_B)  [ get_property value ${WRITE_WIDTH_B} ] 
	# set argumentList2(Read_Width_A)  [ get_property value ${READ_WIDTH_A} ] 
	# set argumentList2(Read_Width_B)  [ get_property value ${READ_WIDTH_B} ] 
	# set argumentList2(Write_Depth_A)  [ get_property value ${WRITE_DEPTH_A} ] 
	# set argumentList2(Operating_Mode_A)  [ get_property value ${OPERATING_MODE_A} ] 
	# set argumentList2(Operating_Mode_B)  [ get_property value ${OPERATING_MODE_B} ] 
	# set argumentList2(ECC)  [ get_property value ${ECC} ] 
	# set argumentList2(Assume_Synchronous_Clk)  [ get_property value ${ASSUME_SYNCHRONOUS_CLK} ] 
	# set argumentList2(Port_A_Clock)  [ get_property value ${PORT_A_CLOCK} ] 
	# set argumentList2(Port_A_Write_Rate)  [ get_property value ${PORT_A_WRITE_RATE} ] 
	# set argumentList2(Port_A_Enable_Rate)  [ get_property value ${PORT_A_ENABLE_RATE} ] 
	# set argumentList2(Port_B_Clock)  [ get_property value ${PORT_B_CLOCK} ] 
	# set argumentList2(Port_B_Write_Rate)  [ get_property value ${PORT_B_WRITE_RATE} ] 
	# set argumentList2(Port_B_Enable_Rate)  [ get_property value ${PORT_B_ENABLE_RATE} ] 
	# set argumentList2(write_depth_b_value)  [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
	# set argumentList2(read_depth_a_value)  [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
	# set argumentList2(read_depth_b_value)  [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
	# set argumentList2(power) $power
	  
   return "Estimated Power for IP     :     [expr {$power/1000000.00}] mW"
   

}

proc Duration_of_Reset_Assertion_A_updated { PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.RESET_MEMORY_LATCH_A PARAM_VALUE.USE_RSTA_PIN} {

  set Use_RSTA_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTA_PIN} ]
  set Register_PortA_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortA_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE} ]
  set Reset_Memory_Latch_A_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_A} ]

  if {!$Use_RSTA_Pin_value || $Register_PortA_Output_of_Memory_Core_value} {
    set myDuration 0
  } elseif {!$Register_PortA_Output_of_Memory_Primitives_value || !$Reset_Memory_Latch_A_value} {
    set myDuration 1
  } else { 
    ;# use_rsta_pin && output_mem_prims && !output_mem_core && latch_a
    set myDuration 2
  }
  return "Duration of Reset Assertion = $myDuration Clock Cycle(s)"

}

proc Duration_of_Reset_Assertion_B_updated { PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES  
  PARAM_VALUE.RESET_MEMORY_LATCH_B PARAM_VALUE.USE_RSTB_PIN} {

  set Use_RSTB_Pin_value [ get_property value ${PARAM_VALUE.USE_RSTB_PIN} ]
  set Register_PortB_Output_of_Memory_Primitives_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ]
  set Register_PortB_Output_of_Memory_Core_value [ get_property value ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE} ]
  set Reset_Memory_Latch_B_value [ get_property value ${PARAM_VALUE.RESET_MEMORY_LATCH_B} ]

  if {!$Use_RSTB_Pin_value || $Register_PortB_Output_of_Memory_Core_value} {
    set myDuration 0
  } elseif {!$Register_PortB_Output_of_Memory_Primitives_value || !$Reset_Memory_Latch_B_value} {
    set myDuration 1
  } else { ;# use_rstB_pin && output_mem_prims && !output_mem_core && latch_B
    set myDuration 2
  }
  return "Duration of Reset Assertion = $myDuration Clock Cycle(s)"

}

proc total_latency_portA_updated {PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.PIPELINE_STAGES PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES
		PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.READ_LATENCY_A} {
  set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
  set rd_lat_a  [get_property value ${PARAM_VALUE.READ_LATENCY_A}]
  if {$ramtype == "BRAM"} {
      return "Total Port A Read Latency : [total_Port_Read_Latency ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.PIPELINE_STAGES} ${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_PRIMITIVES} \
		${PARAM_VALUE.REGISTER_PORTA_OUTPUT_OF_MEMORY_CORE}] Clock Cycle(s)"
  } else {
      return "Total Port A Read Latency : $rd_lat_a Clock Cycle(s)"
  }
} 

proc total_latency_portB_updated {PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.PIPELINE_STAGES PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES
		PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE PARAM_VALUE.EN_ECC_PIPE PARAM_VALUE.PRIM_type_to_Implement PARAM_VALUE.READ_LATENCY_B} {
  
    set ramtype [get_property value ${PARAM_VALUE.PRIM_type_to_Implement}]
    set rd_lat_b  [get_property value ${PARAM_VALUE.READ_LATENCY_B}]
     
  if {$ramtype == "BRAM"} {
	   set latency_b 	[total_Port_Read_Latency ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.PIPELINE_STAGES} ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_PRIMITIVES} ${PARAM_VALUE.REGISTER_PORTB_OUTPUT_OF_MEMORY_CORE}]
	   if { [get_property value ${PARAM_VALUE.EN_ECC_PIPE}] } {
	     incr latency_b
	   } 
      return "Total Port B Read Latency (From Rising Edge of Read Clock):  $latency_b Clock Cycle(s)"
  } else {
      return "Total Port B Read Latency (From Rising Edge of Read Clock):  $rd_lat_b Clock Cycle(s)"
  }
} 

proc total_Port_Read_Latency {MEMORY_TYPE PIPELINE_STAGES  REGISTER_PORT_OUTPUT_OF_MEMORY_PRIMITIVES REGISTER_PORT_OUTPUT_OF_MEMORY_CORE  } {
	set Pipeline_Stages_value [ get_property value ${PIPELINE_STAGES} ]
	set mem_type [ get_property value ${MEMORY_TYPE} ]

	set latency_value [expr {1+$Pipeline_Stages_value}]
	if {[ get_property value $REGISTER_PORT_OUTPUT_OF_MEMORY_PRIMITIVES ]} {
		incr latency_value
	}
	if {[ get_property value $REGISTER_PORT_OUTPUT_OF_MEMORY_CORE ]} {
		incr latency_value
	}
	return $latency_value
}

proc read_depth_a_value { INTERFACE_TYPE MEMORY_TYPE READ_WIDTH_A WRITE_DEPTH_A WRITE_WIDTH_A} {
  set Interface_Type_value [ get_property value ${INTERFACE_TYPE} ]
  set Memory_Type_value [ get_property value ${MEMORY_TYPE} ]
  set Write_Width_A_value [ get_property value ${WRITE_WIDTH_A} ]
  set Write_Depth_A_value [ get_property value ${WRITE_DEPTH_A} ]
  set Read_Width_A_value [ get_property value ${READ_WIDTH_A} ]

  if {$Interface_Type_value != "AXI4" } { 
	  if {$Write_Width_A_value  >= $Read_Width_A_value} {   	
	    return [expr {($Write_Width_A_value / $Read_Width_A_value) * $Write_Depth_A_value}]
	  } else {
	    set ratio [expr {$Read_Width_A_value / $Write_Width_A_value}]
	    return [expr {int($Write_Depth_A_value / $ratio)}]
	  }
  } else {
	  if {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
		  return $Write_Depth_A_value
	  } else {
	    if {$Read_Width_A_value == 8 } {
			  return 4096		 
		  } elseif {$Read_Width_A_value == 16 } {
			  return  2048		   
		  } elseif {$Read_Width_A_value == 32 } {
			  return  1024		   
		  } elseif {$Read_Width_A_value == 64 } {
			  return  512		   
		  } elseif {$Read_Width_A_value == 128 } {
			  return 256		  
		  } else {
			  return 128		   
		  }
	  }	   
  }
}

proc read_depth_b_value { INTERFACE_TYPE READ_WIDTH_B WRITE_DEPTH_A WRITE_WIDTH_A WRITE_WIDTH_B} {
  set Write_Width_A_value [ get_property value ${WRITE_WIDTH_A} ]
  set Write_Width_B_value [ get_property value ${WRITE_WIDTH_B} ]
  set Read_Width_B_value [ get_property value ${READ_WIDTH_B} ]
  set Write_Depth_A_value [ get_property value ${WRITE_DEPTH_A} ]
  set Interface_Type_value [ get_property value ${INTERFACE_TYPE} ]

  if {$Interface_Type_value != "AXI4" } { 
	  if {$Write_Width_A_value >= $Read_Width_B_value} {
	    return [expr {($Write_Width_A_value / $Read_Width_B_value) * $Write_Depth_A_value}]
	  } else {
	    set ratio [expr {$Read_Width_B_value / $Write_Width_A_value}]
	    return [expr {int($Write_Depth_A_value/ $ratio)}]
	  }
  } else {
	  return $Write_Depth_A_value
  }
}

proc Address_Width_A_value { ENABLE_32BIT_ADDRESS USE_BRAM_BLOCK WRITE_DEPTH_A INTERFACE_TYPE MEMORY_TYPE READ_WIDTH_A WRITE_WIDTH_A} {

	if {[ get_property value ${ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set addrWidthA 32
	} else {
		set rda_value [read_depth_a_value ${INTERFACE_TYPE} ${MEMORY_TYPE} ${READ_WIDTH_A} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A}]
		if {[ get_property value ${WRITE_DEPTH_A} ] > $rda_value } {
		  set addrWidthA [expr {int(ceil(log([ get_property value ${WRITE_DEPTH_A} ])/log(2)))}]
		} else {
		  set addrWidthA [expr {int(ceil(log($rda_value)/log(2)))}]
		}
	}
  return $addrWidthA

}

proc Address_Width_A_updated {PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.INTERFACE_TYPE \
							  PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.WRITE_WIDTH_A} {
  return "Address Width A: [Address_Width_A_value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.WRITE_DEPTH_A} \
							${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]"
}

proc Read_Depth_A_updated {PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_A PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A} {
  return "[read_depth_a_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.MEMORY_TYPE} ${PARAM_VALUE.READ_WIDTH_A} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A}]"
}

proc portB_Description_updated { PARAM_VALUE.MEMORY_TYPE} {

	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value == "True_Dual_Port_RAM"} {
		#set val "The Width and Depth values are used for both Write and Read Operation" 
		set val "" 
	} elseif { $Memory_Type_value == "Dual_Port_ROM"} {
		set val "The Width and Depth values are used for Read Operation in Port B" 
	} elseif  {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
		set val "The Width and Depth values are used for Read Operation in Port B" 
	} else {
		set val "."
	}
	return $val

}

proc portA_Description_updated { PARAM_VALUE.MEMORY_TYPE} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	
	if {$Memory_Type_value == "True_Dual_Port_RAM"} {
		#return "The Width and Depth values are used for both Write and Read Operation" 
		return "" 
	} elseif {$Memory_Type_value == "Single_Port_ROM"} {
		return "The Width and Depth values are used for Read Operation in Port A"
	} elseif { $Memory_Type_value == "Dual_Port_ROM"} {
		return "The Width and Depth values are used for Read Operation in Port A"
	} elseif {$Memory_Type_value == "Simple_Dual_Port_RAM" } {
		return "The Width and Depth values are used for Write Operations in Port A"
	} 
}

proc Read_Depth_B_updated { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native"} {
		return "Port B Depth : [read_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WIDTH_B} \
		${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]"
	} else {
		return "Read Depth : [read_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WIDTH_B} \
		${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]"
	}
}

proc LabelMemory_TypeDescription_updated { PARAM_VALUE.MEMORY_TYPE} {
  set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
  if { $Memory_Type_value == "Single_Port_RAM"} {
    return "Memory Type: Single Port Memory"
  } elseif {$Memory_Type_value == "Simple_Dual_Port_RAM"} {
    return "Memory Type: Simple Dual Port RAM"
  } elseif {$Memory_Type_value  == "True_Dual_Port_RAM"} {
    return "Memory Type: True Dual Port RAM"
  } elseif {$Memory_Type_value == "Single_Port_ROM"} {
    return "Memory Type: Single Port ROM"
  } elseif {$Memory_Type_value == "Dual_Port_ROM"} {
    return "Memory Type: Dual Port ROM"
  }
}

proc Address_Width_B_updated {PARAM_VALUE.ENABLE_32BIT_ADDRESS PARAM_VALUE.USE_BRAM_BLOCK PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.READ_WIDTH_B PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B PARAM_VALUE.MEMORY_TYPE} {
  return "Address Width B : [Address_Width_B_value ${PARAM_VALUE.ENABLE_32BIT_ADDRESS} ${PARAM_VALUE.USE_BRAM_BLOCK} ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.READ_WIDTH_B} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B} ${PARAM_VALUE.MEMORY_TYPE}]"
}

proc Read_Width_B_Meta_updated { PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.MEMORY_TYPE} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" && [ get_property value ${PARAM_VALUE.INTERFACE_TYPE} ] != "Native"} {
		return "Port B Width"
	} else {
		return "Read Width"
	}
}

proc Write_Width_A_Meta_updated { PARAM_VALUE.MEMORY_TYPE} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM"} {
		return "Port A Width" 
	} else {
		return "Write Width" 
	}
}

proc Write_Depth_B_updated { PARAM_VALUE.MEMORY_TYPE PARAM_VALUE.INTERFACE_TYPE PARAM_VALUE.WRITE_DEPTH_A PARAM_VALUE.WRITE_WIDTH_A PARAM_VALUE.WRITE_WIDTH_B} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Dual_Port_ROM"} {
		set label "Port B Depth" 
	} else {
		set label "Write Depth"
	}
  return "$label : [write_depth_b_value ${PARAM_VALUE.INTERFACE_TYPE} ${PARAM_VALUE.WRITE_DEPTH_A} ${PARAM_VALUE.WRITE_WIDTH_A} ${PARAM_VALUE.WRITE_WIDTH_B}]" 
}

proc Write_Width_B_Meta_updated { PARAM_VALUE.MEMORY_TYPE} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Dual_Port_ROM"} {
		return "Port B Width" 
	} else {
		return "Write Width"
	}
}

proc Write_Depth_A_Meta_updated { PARAM_VALUE.MEMORY_TYPE} {
	set Memory_Type_value [ get_property value ${PARAM_VALUE.MEMORY_TYPE} ]
	if {$Memory_Type_value == "Simple_Dual_Port_RAM" || $Memory_Type_value == "Single_Port_ROM" || $Memory_Type_value == "Dual_Port_ROM"} {
		return "Port A Depth" 
	} else {
		return "Write Depth" 
	}
}

proc write_depth_b_value { INTERFACE_TYPE WRITE_DEPTH_A WRITE_WIDTH_A WRITE_WIDTH_B} {
  set Write_Width_A_value [ get_property value ${WRITE_WIDTH_A} ]
  set Write_Width_B_value [ get_property value ${WRITE_WIDTH_B} ]
  set Write_Depth_A_value [ get_property value ${WRITE_DEPTH_A} ]
  set Interface_Type_value [ get_property value ${INTERFACE_TYPE} ]

  if {$Interface_Type_value != "AXI4" } { 
	  if {$Write_Width_A_value >= $Write_Width_B_value} {
	    return [expr {($Write_Width_A_value / $Write_Width_B_value) * $Write_Depth_A_value}]
	  } else {
	    set ratio [expr {$Write_Width_B_value / $Write_Width_A_value}]
	    return [expr {int($Write_Depth_A_value / $ratio)}]
	  }
  } else {
	  return $Write_Depth_A_value
  }
}

proc Address_Width_B_value { ENABLE_32BIT_ADDRESS USE_BRAM_BLOCK INTERFACE_TYPE READ_WIDTH_B WRITE_DEPTH_A WRITE_WIDTH_A WRITE_WIDTH_B MEMORY_TYPE} {
	if {[ get_property value ${ENABLE_32BIT_ADDRESS} ]  || [ get_property value ${USE_BRAM_BLOCK} ] == "BRAM_Controller" } {
		set addrWidthB 32
	} else {
		set rdb_value [read_depth_b_value ${INTERFACE_TYPE} ${READ_WIDTH_B} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
		
		set wdb_value [write_depth_b_value ${INTERFACE_TYPE} ${WRITE_DEPTH_A} ${WRITE_WIDTH_A} ${WRITE_WIDTH_B}]
      set mem_type  [ get_property value ${MEMORY_TYPE} ]
      if {$mem_type == "Simple_Dual_Port_RAM" } {
			set addrWidthB [expr {int(ceil(log($rdb_value)/log(2)))}]
      } else {
         if {$rdb_value > $wdb_value } {
		   	set addrWidthB [expr {int(ceil(log($rdb_value)/log(2)))}]
		   } else {
		   	set addrWidthB [expr {int(ceil(log($wdb_value)/log(2)))}]
		   }
		}
	}
  return $addrWidthB
}
