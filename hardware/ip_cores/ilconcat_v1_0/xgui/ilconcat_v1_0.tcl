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
# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
	set Page0 [ipgui::add_page $IPINST -name "Page 1" -layout vertical]
	set Component_Name [ipgui::add_param $IPINST -parent $Page0 -name Component_Name]
	set NUM_PORTS [ipgui::add_param $IPINST -parent $Page0 -name NUM_PORTS]
	set IN0_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN0_WIDTH]
	set IN1_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN1_WIDTH]
	set IN2_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN2_WIDTH]
	set IN3_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN3_WIDTH]
	set IN4_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN4_WIDTH]
	set IN5_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN5_WIDTH]
	set IN6_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN6_WIDTH]
	set IN7_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN7_WIDTH]
	set IN8_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN8_WIDTH]
	set IN9_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN9_WIDTH]
	set IN10_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN10_WIDTH]
	set IN11_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN11_WIDTH]
	set IN12_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN12_WIDTH]
	set IN13_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN13_WIDTH]
	set IN14_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN14_WIDTH]
	set IN15_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN15_WIDTH]
	set IN16_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN16_WIDTH]
	set IN17_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN17_WIDTH]
	set IN18_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN18_WIDTH]
	set IN19_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN19_WIDTH]
	set IN20_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN20_WIDTH]
	set IN21_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN21_WIDTH]
	set IN22_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN22_WIDTH]
	set IN23_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN23_WIDTH]
	set IN24_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN24_WIDTH]
	set IN25_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN25_WIDTH]
	set IN26_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN26_WIDTH]
	set IN27_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN27_WIDTH]
	set IN28_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN28_WIDTH]
	set IN29_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN29_WIDTH]
	set IN30_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN30_WIDTH]
	set IN31_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN31_WIDTH]
	set IN32_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN32_WIDTH]
	set IN33_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN33_WIDTH]
	set IN34_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN34_WIDTH]
	set IN35_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN35_WIDTH]
	set IN36_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN36_WIDTH]
	set IN37_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN37_WIDTH]
	set IN38_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN38_WIDTH]
	set IN39_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN39_WIDTH]
	set IN40_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN40_WIDTH]
	set IN41_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN41_WIDTH]
	set IN42_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN42_WIDTH]
	set IN43_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN43_WIDTH]
	set IN44_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN44_WIDTH]
	set IN45_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN45_WIDTH]
	set IN46_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN46_WIDTH]
	set IN47_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN47_WIDTH]
	set IN48_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN48_WIDTH]
	set IN49_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN49_WIDTH]
	set IN50_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN50_WIDTH]
	set IN51_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN51_WIDTH]
	set IN52_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN52_WIDTH]
	set IN53_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN53_WIDTH]
	set IN54_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN54_WIDTH]
	set IN55_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN55_WIDTH]
	set IN56_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN56_WIDTH]
	set IN57_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN57_WIDTH]
	set IN58_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN58_WIDTH]
	set IN59_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN59_WIDTH]
	set IN60_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN60_WIDTH]
	set IN61_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN61_WIDTH]
	set IN62_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN62_WIDTH]
	set IN63_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN63_WIDTH]
	set IN64_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN64_WIDTH]
	set IN65_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN65_WIDTH]
	set IN66_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN66_WIDTH]
	set IN67_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN67_WIDTH]
	set IN68_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN68_WIDTH]
	set IN69_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN69_WIDTH]
	set IN70_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN70_WIDTH]
	set IN71_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN71_WIDTH]
	set IN72_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN72_WIDTH]
	set IN73_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN73_WIDTH]
	set IN74_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN74_WIDTH]
	set IN75_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN75_WIDTH]
	set IN76_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN76_WIDTH]
	set IN77_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN77_WIDTH]
	set IN78_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN78_WIDTH]
	set IN79_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN79_WIDTH]
	set IN80_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN80_WIDTH]
	set IN81_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN81_WIDTH]
	set IN82_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN82_WIDTH]
	set IN83_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN83_WIDTH]
	set IN84_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN84_WIDTH]
	set IN85_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN85_WIDTH]
	set IN86_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN86_WIDTH]
	set IN87_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN87_WIDTH]
	set IN88_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN88_WIDTH]
	set IN89_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN89_WIDTH]
	set IN90_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN90_WIDTH]
	set IN91_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN91_WIDTH]
	set IN92_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN92_WIDTH]
	set IN93_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN93_WIDTH]
	set IN94_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN94_WIDTH]
	set IN95_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN95_WIDTH]
	set IN96_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN96_WIDTH]
	set IN97_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN97_WIDTH]
	set IN98_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN98_WIDTH]
	set IN99_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN99_WIDTH]
	set IN100_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN100_WIDTH]
	set IN101_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN101_WIDTH]
	set IN102_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN102_WIDTH]
	set IN103_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN103_WIDTH]
	set IN104_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN104_WIDTH]
	set IN105_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN105_WIDTH]
	set IN106_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN106_WIDTH]
	set IN107_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN107_WIDTH]
	set IN108_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN108_WIDTH]
	set IN109_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN109_WIDTH]
	set IN110_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN110_WIDTH]
	set IN111_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN111_WIDTH]
	set IN112_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN112_WIDTH]
	set IN113_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN113_WIDTH]
	set IN114_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN114_WIDTH]
	set IN115_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN115_WIDTH]
	set IN116_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN116_WIDTH]
	set IN117_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN117_WIDTH]
	set IN118_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN118_WIDTH]
	set IN119_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN119_WIDTH]
	set IN120_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN120_WIDTH]
	set IN121_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN121_WIDTH]
	set IN122_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN122_WIDTH]
	set IN123_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN123_WIDTH]
	set IN124_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN124_WIDTH]
	set IN125_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN125_WIDTH]
	set IN126_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN126_WIDTH]
	set IN127_WIDTH [ipgui::add_param $IPINST -parent $Page0 -name IN127_WIDTH]
	set dout_width [ipgui::add_param $IPINST -parent $Page0 -name dout_width]
    ipgui::add_static_text $IPINST -parent $Page0 -name ICT_STATIC_TEXT -text "<br>NOTE: The In0 port is connected to the LSB bits of the output, and \r\n the In\[Number of Ports - 1\] input port is connected to the MSB bits of the output." 
}


proc update_gui_for_PARAM_VALUE.NUM_PORTS { IPINST  PARAM_VALUE.NUM_PORTS } {
    
    set value_num_ports [get_property value ${PARAM_VALUE.NUM_PORTS}]
    #Enable all ports first
    for {set portIndex 0 } { $portIndex < 128 } { incr portIndex } {
    set port_name "IN${portIndex}_WIDTH"
    set_property enabled true [ ipgui::get_guiparamspec -name $port_name -of $IPINST ]
    set_property visible true [ ipgui::get_guiparamspec -name $port_name -of $IPINST ]
    }

    # disable the not slected ports now
    for {set portNum $value_num_ports } { $portNum < 128 } { incr portNum } {
    set port_name "IN${portNum}_WIDTH"
    set_property enabled false [ ipgui::get_guiparamspec -name $port_name -of $IPINST ]
    set_property visible false [ ipgui::get_guiparamspec -name $port_name -of $IPINST ]
    }

}

proc update_PARAM_VALUE.NUM_PORTS { PARAM_VALUE.NUM_PORTS } {
}

proc validate_PARAM_VALUE.NUM_PORTS { PARAM_VALUE.NUM_PORTS } {
	# Procedure called to validate NUM_PORTS
	return true
}

proc update_PARAM_VALUE.dout_width { PARAM_VALUE.dout_width PARAM_VALUE.NUM_PORTS PARAM_VALUE.IN0_WIDTH 
                                     PARAM_VALUE.IN1_WIDTH  PARAM_VALUE.IN2_WIDTH PARAM_VALUE.IN3_WIDTH  
                                     PARAM_VALUE.IN4_WIDTH  PARAM_VALUE.IN5_WIDTH PARAM_VALUE.IN6_WIDTH
                                     PARAM_VALUE.IN7_WIDTH  PARAM_VALUE.IN8_WIDTH PARAM_VALUE.IN9_WIDTH
                                     PARAM_VALUE.IN10_WIDTH PARAM_VALUE.IN11_WIDTH PARAM_VALUE.IN12_WIDTH
                                     PARAM_VALUE.IN13_WIDTH PARAM_VALUE.IN14_WIDTH PARAM_VALUE.IN15_WIDTH
                                     PARAM_VALUE.IN16_WIDTH PARAM_VALUE.IN17_WIDTH PARAM_VALUE.IN18_WIDTH
                                     PARAM_VALUE.IN19_WIDTH PARAM_VALUE.IN20_WIDTH PARAM_VALUE.IN21_WIDTH
                                     PARAM_VALUE.IN22_WIDTH PARAM_VALUE.IN23_WIDTH PARAM_VALUE.IN24_WIDTH 
                                     PARAM_VALUE.IN25_WIDTH PARAM_VALUE.IN26_WIDTH PARAM_VALUE.IN27_WIDTH 
                                     PARAM_VALUE.IN28_WIDTH PARAM_VALUE.IN29_WIDTH PARAM_VALUE.IN30_WIDTH 
                                     PARAM_VALUE.IN31_WIDTH PARAM_VALUE.IN32_WIDTH PARAM_VALUE.IN33_WIDTH 
				     PARAM_VALUE.IN34_WIDTH PARAM_VALUE.IN35_WIDTH PARAM_VALUE.IN36_WIDTH 
                                     PARAM_VALUE.IN37_WIDTH PARAM_VALUE.IN38_WIDTH PARAM_VALUE.IN39_WIDTH 
                                     PARAM_VALUE.IN40_WIDTH PARAM_VALUE.IN41_WIDTH PARAM_VALUE.IN42_WIDTH 
                                     PARAM_VALUE.IN43_WIDTH PARAM_VALUE.IN44_WIDTH PARAM_VALUE.IN45_WIDTH 
                                     PARAM_VALUE.IN46_WIDTH PARAM_VALUE.IN47_WIDTH PARAM_VALUE.IN48_WIDTH 
                                     PARAM_VALUE.IN49_WIDTH PARAM_VALUE.IN50_WIDTH PARAM_VALUE.IN51_WIDTH 
                                     PARAM_VALUE.IN52_WIDTH PARAM_VALUE.IN53_WIDTH PARAM_VALUE.IN54_WIDTH 
                                     PARAM_VALUE.IN55_WIDTH PARAM_VALUE.IN56_WIDTH PARAM_VALUE.IN57_WIDTH 
                                     PARAM_VALUE.IN58_WIDTH PARAM_VALUE.IN59_WIDTH PARAM_VALUE.IN60_WIDTH 
                                     PARAM_VALUE.IN61_WIDTH PARAM_VALUE.IN62_WIDTH PARAM_VALUE.IN63_WIDTH 
                                     PARAM_VALUE.IN64_WIDTH PARAM_VALUE.IN65_WIDTH PARAM_VALUE.IN66_WIDTH 
                                     PARAM_VALUE.IN67_WIDTH PARAM_VALUE.IN68_WIDTH PARAM_VALUE.IN69_WIDTH 
                                     PARAM_VALUE.IN70_WIDTH PARAM_VALUE.IN71_WIDTH PARAM_VALUE.IN72_WIDTH 
                                     PARAM_VALUE.IN73_WIDTH PARAM_VALUE.IN74_WIDTH PARAM_VALUE.IN75_WIDTH 
                                     PARAM_VALUE.IN76_WIDTH PARAM_VALUE.IN77_WIDTH PARAM_VALUE.IN78_WIDTH 
                                     PARAM_VALUE.IN79_WIDTH PARAM_VALUE.IN80_WIDTH PARAM_VALUE.IN81_WIDTH 
                                     PARAM_VALUE.IN82_WIDTH PARAM_VALUE.IN83_WIDTH PARAM_VALUE.IN84_WIDTH 
                                     PARAM_VALUE.IN85_WIDTH PARAM_VALUE.IN86_WIDTH PARAM_VALUE.IN87_WIDTH 
                                     PARAM_VALUE.IN88_WIDTH PARAM_VALUE.IN89_WIDTH PARAM_VALUE.IN90_WIDTH 
                                     PARAM_VALUE.IN91_WIDTH PARAM_VALUE.IN92_WIDTH PARAM_VALUE.IN93_WIDTH 
                                     PARAM_VALUE.IN94_WIDTH PARAM_VALUE.IN95_WIDTH PARAM_VALUE.IN96_WIDTH 
                                     PARAM_VALUE.IN97_WIDTH PARAM_VALUE.IN98_WIDTH PARAM_VALUE.IN99_WIDTH 
                                     PARAM_VALUE.IN100_WIDTH PARAM_VALUE.IN101_WIDTH PARAM_VALUE.IN102_WIDTH 
                                     PARAM_VALUE.IN103_WIDTH PARAM_VALUE.IN104_WIDTH PARAM_VALUE.IN105_WIDTH 
                                     PARAM_VALUE.IN106_WIDTH PARAM_VALUE.IN107_WIDTH PARAM_VALUE.IN108_WIDTH 
                                     PARAM_VALUE.IN109_WIDTH PARAM_VALUE.IN110_WIDTH PARAM_VALUE.IN111_WIDTH 
                                     PARAM_VALUE.IN112_WIDTH PARAM_VALUE.IN113_WIDTH PARAM_VALUE.IN114_WIDTH 
                                     PARAM_VALUE.IN115_WIDTH PARAM_VALUE.IN116_WIDTH PARAM_VALUE.IN117_WIDTH 
                                     PARAM_VALUE.IN118_WIDTH PARAM_VALUE.IN119_WIDTH PARAM_VALUE.IN120_WIDTH 
                                     PARAM_VALUE.IN121_WIDTH PARAM_VALUE.IN122_WIDTH PARAM_VALUE.IN123_WIDTH 
                                     PARAM_VALUE.IN124_WIDTH PARAM_VALUE.IN125_WIDTH PARAM_VALUE.IN126_WIDTH 
                                     PARAM_VALUE.IN127_WIDTH } {
    set doutWidth 0
    set value_num_ports [ get_property value ${PARAM_VALUE.NUM_PORTS}]
    for {set portIndex 0 } { $portIndex < $value_num_ports } { incr portIndex } {
      set port_name "PARAM_VALUE.IN${portIndex}_WIDTH"
      set portWidth [ get_property value [set $port_name] ]
      set doutWidth [expr { $doutWidth + $portWidth} ]
    }
    set_property value  $doutWidth  ${PARAM_VALUE.dout_width}
}

proc update_PARAM_VALUE.IN0_WIDTH { PARAM_VALUE.IN0_WIDTH } {
	# Procedure called to update IN0_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN0_WIDTH { PARAM_VALUE.IN0_WIDTH } {
	# Procedure called to validate IN0_WIDTH
	return true
}

proc update_PARAM_VALUE.IN1_WIDTH { PARAM_VALUE.IN1_WIDTH } {
	# Procedure called to update IN1_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN1_WIDTH { PARAM_VALUE.IN1_WIDTH } {
	# Procedure called to validate IN1_WIDTH
	return true
}

proc update_PARAM_VALUE.IN2_WIDTH { PARAM_VALUE.IN2_WIDTH } {
	# Procedure called to update IN2_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN2_WIDTH { PARAM_VALUE.IN2_WIDTH } {
	# Procedure called to validate IN2_WIDTH
	return true
}

proc update_PARAM_VALUE.IN3_WIDTH { PARAM_VALUE.IN3_WIDTH } {
	# Procedure called to update IN3_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN3_WIDTH { PARAM_VALUE.IN3_WIDTH } {
	# Procedure called to validate IN3_WIDTH
	return true
}

proc update_PARAM_VALUE.IN4_WIDTH { PARAM_VALUE.IN4_WIDTH } {
	# Procedure called to update IN4_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN4_WIDTH { PARAM_VALUE.IN4_WIDTH } {
	# Procedure called to validate IN4_WIDTH
	return true
}

proc update_PARAM_VALUE.IN5_WIDTH { PARAM_VALUE.IN5_WIDTH } {
	# Procedure called to update IN5_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN5_WIDTH { PARAM_VALUE.IN5_WIDTH } {
	# Procedure called to validate IN5_WIDTH
	return true
}

proc update_PARAM_VALUE.IN6_WIDTH { PARAM_VALUE.IN6_WIDTH } {
	# Procedure called to update IN6_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN6_WIDTH { PARAM_VALUE.IN6_WIDTH } {
	# Procedure called to validate IN6_WIDTH
	return true
}

proc update_PARAM_VALUE.IN7_WIDTH { PARAM_VALUE.IN7_WIDTH } {
	# Procedure called to update IN7_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN7_WIDTH { PARAM_VALUE.IN7_WIDTH } {
	# Procedure called to validate IN7_WIDTH
	return true
}

proc update_PARAM_VALUE.IN8_WIDTH { PARAM_VALUE.IN8_WIDTH } {
	# Procedure called to update IN8_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN8_WIDTH { PARAM_VALUE.IN8_WIDTH } {
	# Procedure called to validate IN8_WIDTH
	return true
}

proc update_PARAM_VALUE.IN9_WIDTH { PARAM_VALUE.IN9_WIDTH } {
	# Procedure called to update IN9_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN9_WIDTH { PARAM_VALUE.IN9_WIDTH } {
	# Procedure called to validate IN9_WIDTH
	return true
}

proc update_PARAM_VALUE.IN10_WIDTH { PARAM_VALUE.IN10_WIDTH } {
	# Procedure called to update IN10_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN10_WIDTH { PARAM_VALUE.IN10_WIDTH } {
	# Procedure called to validate IN10_WIDTH
	return true
}

proc update_PARAM_VALUE.IN11_WIDTH { PARAM_VALUE.IN11_WIDTH } {
	# Procedure called to update IN11_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN11_WIDTH { PARAM_VALUE.IN11_WIDTH } {
	# Procedure called to validate IN11_WIDTH
	return true
}

proc update_PARAM_VALUE.IN12_WIDTH { PARAM_VALUE.IN12_WIDTH } {
	# Procedure called to update IN12_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN12_WIDTH { PARAM_VALUE.IN12_WIDTH } {
	# Procedure called to validate IN12_WIDTH
	return true
}

proc update_PARAM_VALUE.IN13_WIDTH { PARAM_VALUE.IN13_WIDTH } {
	# Procedure called to update IN13_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN13_WIDTH { PARAM_VALUE.IN13_WIDTH } {
	# Procedure called to validate IN13_WIDTH
	return true
}

proc update_PARAM_VALUE.IN14_WIDTH { PARAM_VALUE.IN14_WIDTH } {
	# Procedure called to update IN14_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN14_WIDTH { PARAM_VALUE.IN14_WIDTH } {
	# Procedure called to validate IN14_WIDTH
	return true
}

proc update_PARAM_VALUE.IN15_WIDTH { PARAM_VALUE.IN15_WIDTH } {
	# Procedure called to update IN15_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN15_WIDTH { PARAM_VALUE.IN15_WIDTH } {
	# Procedure called to validate IN15_WIDTH
	return true
}

proc update_PARAM_VALUE.IN16_WIDTH { PARAM_VALUE.IN16_WIDTH } {
	# Procedure called to update IN16_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN16_WIDTH { PARAM_VALUE.IN16_WIDTH } {
	# Procedure called to validate IN16_WIDTH
	return true
}

proc update_PARAM_VALUE.IN17_WIDTH { PARAM_VALUE.IN17_WIDTH } {
	# Procedure called to update IN17_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN17_WIDTH { PARAM_VALUE.IN17_WIDTH } {
	# Procedure called to validate IN17_WIDTH
	return true
}

proc update_PARAM_VALUE.IN18_WIDTH { PARAM_VALUE.IN18_WIDTH } {
	# Procedure called to update IN18_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN18_WIDTH { PARAM_VALUE.IN18_WIDTH } {
	# Procedure called to validate IN18_WIDTH
	return true
}

proc update_PARAM_VALUE.IN19_WIDTH { PARAM_VALUE.IN19_WIDTH } {
	# Procedure called to update IN19_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN19_WIDTH { PARAM_VALUE.IN19_WIDTH } {
	# Procedure called to validate IN19_WIDTH
	return true
}

proc update_PARAM_VALUE.IN20_WIDTH { PARAM_VALUE.IN20_WIDTH } {
	# Procedure called to update IN20_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN20_WIDTH { PARAM_VALUE.IN20_WIDTH } {
	# Procedure called to validate IN20_WIDTH
	return true
}

proc update_PARAM_VALUE.IN21_WIDTH { PARAM_VALUE.IN21_WIDTH } {
	# Procedure called to update IN21_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN21_WIDTH { PARAM_VALUE.IN21_WIDTH } {
	# Procedure called to validate IN21_WIDTH
	return true
}

proc update_PARAM_VALUE.IN22_WIDTH { PARAM_VALUE.IN22_WIDTH } {
	# Procedure called to update IN22_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN22_WIDTH { PARAM_VALUE.IN22_WIDTH } {
	# Procedure called to validate IN22_WIDTH
	return true
}

proc update_PARAM_VALUE.IN23_WIDTH { PARAM_VALUE.IN23_WIDTH } {
	# Procedure called to update IN23_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN23_WIDTH { PARAM_VALUE.IN23_WIDTH } {
	# Procedure called to validate IN23_WIDTH
	return true
}

proc update_PARAM_VALUE.IN24_WIDTH { PARAM_VALUE.IN24_WIDTH } {
	# Procedure called to update IN24_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN24_WIDTH { PARAM_VALUE.IN24_WIDTH } {
	# Procedure called to validate IN24_WIDTH
	return true
}

proc update_PARAM_VALUE.IN25_WIDTH { PARAM_VALUE.IN25_WIDTH } {
	# Procedure called to update IN25_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN25_WIDTH { PARAM_VALUE.IN25_WIDTH } {
	# Procedure called to validate IN25_WIDTH
	return true
}

proc update_PARAM_VALUE.IN26_WIDTH { PARAM_VALUE.IN26_WIDTH } {
	# Procedure called to update IN26_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN26_WIDTH { PARAM_VALUE.IN26_WIDTH } {
	# Procedure called to validate IN26_WIDTH
	return true
}

proc update_PARAM_VALUE.IN27_WIDTH { PARAM_VALUE.IN27_WIDTH } {
	# Procedure called to update IN27_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN27_WIDTH { PARAM_VALUE.IN27_WIDTH } {
	# Procedure called to validate IN27_WIDTH
	return true
}

proc update_PARAM_VALUE.IN28_WIDTH { PARAM_VALUE.IN28_WIDTH } {
	# Procedure called to update IN28_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN28_WIDTH { PARAM_VALUE.IN28_WIDTH } {
	# Procedure called to validate IN28_WIDTH
	return true
}

proc update_PARAM_VALUE.IN29_WIDTH { PARAM_VALUE.IN29_WIDTH } {
	# Procedure called to update IN29_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN29_WIDTH { PARAM_VALUE.IN29_WIDTH } {
	# Procedure called to validate IN29_WIDTH
	return true
}

proc update_PARAM_VALUE.IN30_WIDTH { PARAM_VALUE.IN30_WIDTH } {
	# Procedure called to update IN30_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN30_WIDTH { PARAM_VALUE.IN30_WIDTH } {
	# Procedure called to validate IN30_WIDTH
	return true
}

proc update_PARAM_VALUE.IN31_WIDTH { PARAM_VALUE.IN31_WIDTH } {
	# Procedure called to update IN31_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN31_WIDTH { PARAM_VALUE.IN31_WIDTH } {
	# Procedure called to validate IN31_WIDTH
	return true
}

proc update_PARAM_VALUE.IN32_WIDTH { PARAM_VALUE.IN32_WIDTH } {
	# Procedure called to update IN32_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN32_WIDTH { PARAM_VALUE.IN32_WIDTH } {
	# Procedure called to validate IN32_WIDTH
	return true
}

proc update_PARAM_VALUE.IN33_WIDTH { PARAM_VALUE.IN33_WIDTH } {
	# Procedure called to update IN33_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN33_WIDTH { PARAM_VALUE.IN33_WIDTH } {
	# Procedure called to validate IN33_WIDTH
	return true
}

proc update_PARAM_VALUE.IN34_WIDTH { PARAM_VALUE.IN34_WIDTH } {
	# Procedure called to update IN34_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN34_WIDTH { PARAM_VALUE.IN34_WIDTH } {
	# Procedure called to validate IN34_WIDTH
	return true
}

proc update_PARAM_VALUE.IN35_WIDTH { PARAM_VALUE.IN35_WIDTH } {
	# Procedure called to update IN35_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN35_WIDTH { PARAM_VALUE.IN35_WIDTH } {
	# Procedure called to validate IN35_WIDTH
	return true
}

proc update_PARAM_VALUE.IN36_WIDTH { PARAM_VALUE.IN36_WIDTH } {
	# Procedure called to update IN36_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN36_WIDTH { PARAM_VALUE.IN36_WIDTH } {
	# Procedure called to validate IN36_WIDTH
	return true
}

proc update_PARAM_VALUE.IN37_WIDTH { PARAM_VALUE.IN37_WIDTH } {
	# Procedure called to update IN37_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN37_WIDTH { PARAM_VALUE.IN37_WIDTH } {
	# Procedure called to validate IN37_WIDTH
	return true
}

proc update_PARAM_VALUE.IN38_WIDTH { PARAM_VALUE.IN38_WIDTH } {
	# Procedure called to update IN38_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN38_WIDTH { PARAM_VALUE.IN38_WIDTH } {
	# Procedure called to validate IN38_WIDTH
	return true
}

proc update_PARAM_VALUE.IN39_WIDTH { PARAM_VALUE.IN39_WIDTH } {
	# Procedure called to update IN39_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN39_WIDTH { PARAM_VALUE.IN39_WIDTH } {
	# Procedure called to validate IN39_WIDTH
	return true
}

proc update_PARAM_VALUE.IN40_WIDTH { PARAM_VALUE.IN40_WIDTH } {
	# Procedure called to update IN40_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN40_WIDTH { PARAM_VALUE.IN40_WIDTH } {
	# Procedure called to validate IN40_WIDTH
	return true
}

proc update_PARAM_VALUE.IN41_WIDTH { PARAM_VALUE.IN41_WIDTH } {
	# Procedure called to update IN41_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN41_WIDTH { PARAM_VALUE.IN41_WIDTH } {
	# Procedure called to validate IN41_WIDTH
	return true
}

proc update_PARAM_VALUE.IN42_WIDTH { PARAM_VALUE.IN42_WIDTH } {
	# Procedure called to update IN42_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN42_WIDTH { PARAM_VALUE.IN42_WIDTH } {
	# Procedure called to validate IN42_WIDTH
	return true
}

proc update_PARAM_VALUE.IN43_WIDTH { PARAM_VALUE.IN43_WIDTH } {
	# Procedure called to update IN43_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN43_WIDTH { PARAM_VALUE.IN43_WIDTH } {
	# Procedure called to validate IN43_WIDTH
	return true
}

proc update_PARAM_VALUE.IN44_WIDTH { PARAM_VALUE.IN44_WIDTH } {
	# Procedure called to update IN44_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN44_WIDTH { PARAM_VALUE.IN44_WIDTH } {
	# Procedure called to validate IN44_WIDTH
	return true
}

proc update_PARAM_VALUE.IN45_WIDTH { PARAM_VALUE.IN45_WIDTH } {
	# Procedure called to update IN45_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN45_WIDTH { PARAM_VALUE.IN45_WIDTH } {
	# Procedure called to validate IN45_WIDTH
	return true
}

proc update_PARAM_VALUE.IN46_WIDTH { PARAM_VALUE.IN46_WIDTH } {
	# Procedure called to update IN46_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN46_WIDTH { PARAM_VALUE.IN46_WIDTH } {
	# Procedure called to validate IN46_WIDTH
	return true
}

proc update_PARAM_VALUE.IN47_WIDTH { PARAM_VALUE.IN47_WIDTH } {
	# Procedure called to update IN47_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN47_WIDTH { PARAM_VALUE.IN47_WIDTH } {
	# Procedure called to validate IN47_WIDTH
	return true
}

proc update_PARAM_VALUE.IN48_WIDTH { PARAM_VALUE.IN48_WIDTH } {
	# Procedure called to update IN48_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN48_WIDTH { PARAM_VALUE.IN48_WIDTH } {
	# Procedure called to validate IN48_WIDTH
	return true
}

proc update_PARAM_VALUE.IN49_WIDTH { PARAM_VALUE.IN49_WIDTH } {
	# Procedure called to update IN49_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN49_WIDTH { PARAM_VALUE.IN49_WIDTH } {
	# Procedure called to validate IN49_WIDTH
	return true
}

proc update_PARAM_VALUE.IN50_WIDTH { PARAM_VALUE.IN50_WIDTH } {
	# Procedure called to update IN50_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN50_WIDTH { PARAM_VALUE.IN50_WIDTH } {
	# Procedure called to validate IN50_WIDTH
	return true
}

proc update_PARAM_VALUE.IN51_WIDTH { PARAM_VALUE.IN51_WIDTH } {
	# Procedure called to update IN51_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN51_WIDTH { PARAM_VALUE.IN51_WIDTH } {
	# Procedure called to validate IN51_WIDTH
	return true
}

proc update_PARAM_VALUE.IN52_WIDTH { PARAM_VALUE.IN52_WIDTH } {
	# Procedure called to update IN52_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN52_WIDTH { PARAM_VALUE.IN52_WIDTH } {
	# Procedure called to validate IN52_WIDTH
	return true
}

proc update_PARAM_VALUE.IN53_WIDTH { PARAM_VALUE.IN53_WIDTH } {
	# Procedure called to update IN53_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN53_WIDTH { PARAM_VALUE.IN53_WIDTH } {
	# Procedure called to validate IN53_WIDTH
	return true
}

proc update_PARAM_VALUE.IN54_WIDTH { PARAM_VALUE.IN54_WIDTH } {
	# Procedure called to update IN54_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN54_WIDTH { PARAM_VALUE.IN54_WIDTH } {
	# Procedure called to validate IN54_WIDTH
	return true
}

proc update_PARAM_VALUE.IN55_WIDTH { PARAM_VALUE.IN55_WIDTH } {
	# Procedure called to update IN55_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN55_WIDTH { PARAM_VALUE.IN55_WIDTH } {
	# Procedure called to validate IN55_WIDTH
	return true
}

proc update_PARAM_VALUE.IN56_WIDTH { PARAM_VALUE.IN56_WIDTH } {
	# Procedure called to update IN56_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN56_WIDTH { PARAM_VALUE.IN56_WIDTH } {
	# Procedure called to validate IN56_WIDTH
	return true
}

proc update_PARAM_VALUE.IN57_WIDTH { PARAM_VALUE.IN57_WIDTH } {
	# Procedure called to update IN57_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN57_WIDTH { PARAM_VALUE.IN57_WIDTH } {
	# Procedure called to validate IN57_WIDTH
	return true
}

proc update_PARAM_VALUE.IN58_WIDTH { PARAM_VALUE.IN58_WIDTH } {
	# Procedure called to update IN58_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN58_WIDTH { PARAM_VALUE.IN58_WIDTH } {
	# Procedure called to validate IN58_WIDTH
	return true
}

proc update_PARAM_VALUE.IN59_WIDTH { PARAM_VALUE.IN59_WIDTH } {
	# Procedure called to update IN59_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN59_WIDTH { PARAM_VALUE.IN59_WIDTH } {
	# Procedure called to validate IN59_WIDTH
	return true
}

proc update_PARAM_VALUE.IN60_WIDTH { PARAM_VALUE.IN60_WIDTH } {
	# Procedure called to update IN60_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN60_WIDTH { PARAM_VALUE.IN60_WIDTH } {
	# Procedure called to validate IN60_WIDTH
	return true
}

proc update_PARAM_VALUE.IN61_WIDTH { PARAM_VALUE.IN61_WIDTH } {
	# Procedure called to update IN61_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN61_WIDTH { PARAM_VALUE.IN61_WIDTH } {
	# Procedure called to validate IN61_WIDTH
	return true
}

proc update_PARAM_VALUE.IN62_WIDTH { PARAM_VALUE.IN62_WIDTH } {
	# Procedure called to update IN62_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN62_WIDTH { PARAM_VALUE.IN62_WIDTH } {
	# Procedure called to validate IN62_WIDTH
	return true
}

proc update_PARAM_VALUE.IN63_WIDTH { PARAM_VALUE.IN63_WIDTH } {
	# Procedure called to update IN63_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN63_WIDTH { PARAM_VALUE.IN63_WIDTH } {
	# Procedure called to validate IN63_WIDTH
	return true
}

proc update_PARAM_VALUE.IN64_WIDTH { PARAM_VALUE.IN64_WIDTH } {
	# Procedure called to update IN64_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN64_WIDTH { PARAM_VALUE.IN64_WIDTH } {
	# Procedure called to validate IN64_WIDTH
	return true
}

proc update_PARAM_VALUE.IN65_WIDTH { PARAM_VALUE.IN65_WIDTH } {
	# Procedure called to update IN65_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN65_WIDTH { PARAM_VALUE.IN65_WIDTH } {
	# Procedure called to validate IN65_WIDTH
	return true
}

proc update_PARAM_VALUE.IN66_WIDTH { PARAM_VALUE.IN66_WIDTH } {
	# Procedure called to update IN66_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN66_WIDTH { PARAM_VALUE.IN66_WIDTH } {
	# Procedure called to validate IN66_WIDTH
	return true
}

proc update_PARAM_VALUE.IN67_WIDTH { PARAM_VALUE.IN67_WIDTH } {
	# Procedure called to update IN67_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN67_WIDTH { PARAM_VALUE.IN67_WIDTH } {
	# Procedure called to validate IN67_WIDTH
	return true
}

proc update_PARAM_VALUE.IN68_WIDTH { PARAM_VALUE.IN68_WIDTH } {
	# Procedure called to update IN68_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN68_WIDTH { PARAM_VALUE.IN68_WIDTH } {
	# Procedure called to validate IN68_WIDTH
	return true
}

proc update_PARAM_VALUE.IN69_WIDTH { PARAM_VALUE.IN69_WIDTH } {
	# Procedure called to update IN69_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN69_WIDTH { PARAM_VALUE.IN69_WIDTH } {
	# Procedure called to validate IN69_WIDTH
	return true
}

proc update_PARAM_VALUE.IN70_WIDTH { PARAM_VALUE.IN70_WIDTH } {
	# Procedure called to update IN70_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN70_WIDTH { PARAM_VALUE.IN70_WIDTH } {
	# Procedure called to validate IN70_WIDTH
	return true
}

proc update_PARAM_VALUE.IN71_WIDTH { PARAM_VALUE.IN71_WIDTH } {
	# Procedure called to update IN71_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN71_WIDTH { PARAM_VALUE.IN71_WIDTH } {
	# Procedure called to validate IN71_WIDTH
	return true
}

proc update_PARAM_VALUE.IN72_WIDTH { PARAM_VALUE.IN72_WIDTH } {
	# Procedure called to update IN72_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN72_WIDTH { PARAM_VALUE.IN72_WIDTH } {
	# Procedure called to validate IN72_WIDTH
	return true
}

proc update_PARAM_VALUE.IN73_WIDTH { PARAM_VALUE.IN73_WIDTH } {
	# Procedure called to update IN73_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN73_WIDTH { PARAM_VALUE.IN73_WIDTH } {
	# Procedure called to validate IN73_WIDTH
	return true
}

proc update_PARAM_VALUE.IN74_WIDTH { PARAM_VALUE.IN74_WIDTH } {
	# Procedure called to update IN74_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN74_WIDTH { PARAM_VALUE.IN74_WIDTH } {
	# Procedure called to validate IN74_WIDTH
	return true
}

proc update_PARAM_VALUE.IN75_WIDTH { PARAM_VALUE.IN75_WIDTH } {
	# Procedure called to update IN75_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN75_WIDTH { PARAM_VALUE.IN75_WIDTH } {
	# Procedure called to validate IN75_WIDTH
	return true
}

proc update_PARAM_VALUE.IN76_WIDTH { PARAM_VALUE.IN76_WIDTH } {
	# Procedure called to update IN76_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN76_WIDTH { PARAM_VALUE.IN76_WIDTH } {
	# Procedure called to validate IN76_WIDTH
	return true
}

proc update_PARAM_VALUE.IN77_WIDTH { PARAM_VALUE.IN77_WIDTH } {
	# Procedure called to update IN77_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN77_WIDTH { PARAM_VALUE.IN77_WIDTH } {
	# Procedure called to validate IN77_WIDTH
	return true
}

proc update_PARAM_VALUE.IN78_WIDTH { PARAM_VALUE.IN78_WIDTH } {
	# Procedure called to update IN78_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN78_WIDTH { PARAM_VALUE.IN78_WIDTH } {
	# Procedure called to validate IN78_WIDTH
	return true
}

proc update_PARAM_VALUE.IN79_WIDTH { PARAM_VALUE.IN79_WIDTH } {
	# Procedure called to update IN79_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN79_WIDTH { PARAM_VALUE.IN79_WIDTH } {
	# Procedure called to validate IN79_WIDTH
	return true
}

proc update_PARAM_VALUE.IN80_WIDTH { PARAM_VALUE.IN80_WIDTH } {
	# Procedure called to update IN80_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN80_WIDTH { PARAM_VALUE.IN80_WIDTH } {
	# Procedure called to validate IN80_WIDTH
	return true
}

proc update_PARAM_VALUE.IN81_WIDTH { PARAM_VALUE.IN81_WIDTH } {
	# Procedure called to update IN81_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN81_WIDTH { PARAM_VALUE.IN81_WIDTH } {
	# Procedure called to validate IN81_WIDTH
	return true
}

proc update_PARAM_VALUE.IN82_WIDTH { PARAM_VALUE.IN82_WIDTH } {
	# Procedure called to update IN82_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN82_WIDTH { PARAM_VALUE.IN82_WIDTH } {
	# Procedure called to validate IN82_WIDTH
	return true
}

proc update_PARAM_VALUE.IN83_WIDTH { PARAM_VALUE.IN83_WIDTH } {
	# Procedure called to update IN83_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN83_WIDTH { PARAM_VALUE.IN83_WIDTH } {
	# Procedure called to validate IN83_WIDTH
	return true
}

proc update_PARAM_VALUE.IN84_WIDTH { PARAM_VALUE.IN84_WIDTH } {
	# Procedure called to update IN84_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN84_WIDTH { PARAM_VALUE.IN84_WIDTH } {
	# Procedure called to validate IN84_WIDTH
	return true
}

proc update_PARAM_VALUE.IN85_WIDTH { PARAM_VALUE.IN85_WIDTH } {
	# Procedure called to update IN85_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN85_WIDTH { PARAM_VALUE.IN85_WIDTH } {
	# Procedure called to validate IN85_WIDTH
	return true
}

proc update_PARAM_VALUE.IN86_WIDTH { PARAM_VALUE.IN86_WIDTH } {
	# Procedure called to update IN86_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN86_WIDTH { PARAM_VALUE.IN86_WIDTH } {
	# Procedure called to validate IN86_WIDTH
	return true
}

proc update_PARAM_VALUE.IN87_WIDTH { PARAM_VALUE.IN87_WIDTH } {
	# Procedure called to update IN87_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN87_WIDTH { PARAM_VALUE.IN87_WIDTH } {
	# Procedure called to validate IN87_WIDTH
	return true
}

proc update_PARAM_VALUE.IN88_WIDTH { PARAM_VALUE.IN88_WIDTH } {
	# Procedure called to update IN88_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN88_WIDTH { PARAM_VALUE.IN88_WIDTH } {
	# Procedure called to validate IN88_WIDTH
	return true
}

proc update_PARAM_VALUE.IN89_WIDTH { PARAM_VALUE.IN89_WIDTH } {
	# Procedure called to update IN89_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN89_WIDTH { PARAM_VALUE.IN89_WIDTH } {
	# Procedure called to validate IN89_WIDTH
	return true
}

proc update_PARAM_VALUE.IN90_WIDTH { PARAM_VALUE.IN90_WIDTH } {
	# Procedure called to update IN90_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN90_WIDTH { PARAM_VALUE.IN90_WIDTH } {
	# Procedure called to validate IN90_WIDTH
	return true
}

proc update_PARAM_VALUE.IN91_WIDTH { PARAM_VALUE.IN91_WIDTH } {
	# Procedure called to update IN91_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN91_WIDTH { PARAM_VALUE.IN91_WIDTH } {
	# Procedure called to validate IN91_WIDTH
	return true
}

proc update_PARAM_VALUE.IN92_WIDTH { PARAM_VALUE.IN92_WIDTH } {
	# Procedure called to update IN92_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN92_WIDTH { PARAM_VALUE.IN92_WIDTH } {
	# Procedure called to validate IN92_WIDTH
	return true
}

proc update_PARAM_VALUE.IN93_WIDTH { PARAM_VALUE.IN93_WIDTH } {
	# Procedure called to update IN93_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN93_WIDTH { PARAM_VALUE.IN93_WIDTH } {
	# Procedure called to validate IN93_WIDTH
	return true
}

proc update_PARAM_VALUE.IN94_WIDTH { PARAM_VALUE.IN94_WIDTH } {
	# Procedure called to update IN94_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN94_WIDTH { PARAM_VALUE.IN94_WIDTH } {
	# Procedure called to validate IN94_WIDTH
	return true
}

proc update_PARAM_VALUE.IN95_WIDTH { PARAM_VALUE.IN95_WIDTH } {
	# Procedure called to update IN95_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN95_WIDTH { PARAM_VALUE.IN95_WIDTH } {
	# Procedure called to validate IN95_WIDTH
	return true
}

proc update_PARAM_VALUE.IN96_WIDTH { PARAM_VALUE.IN96_WIDTH } {
	# Procedure called to update IN96_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN96_WIDTH { PARAM_VALUE.IN96_WIDTH } {
	# Procedure called to validate IN96_WIDTH
	return true
}

proc update_PARAM_VALUE.IN97_WIDTH { PARAM_VALUE.IN97_WIDTH } {
	# Procedure called to update IN97_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN97_WIDTH { PARAM_VALUE.IN97_WIDTH } {
	# Procedure called to validate IN97_WIDTH
	return true
}

proc update_PARAM_VALUE.IN98_WIDTH { PARAM_VALUE.IN98_WIDTH } {
	# Procedure called to update IN98_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN98_WIDTH { PARAM_VALUE.IN98_WIDTH } {
	# Procedure called to validate IN98_WIDTH
	return true
}

proc update_PARAM_VALUE.IN99_WIDTH { PARAM_VALUE.IN99_WIDTH } {
	# Procedure called to update IN99_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN99_WIDTH { PARAM_VALUE.IN99_WIDTH } {
	# Procedure called to validate IN99_WIDTH
	return true
}

proc update_PARAM_VALUE.IN100_WIDTH { PARAM_VALUE.IN100_WIDTH } {
	# Procedure called to update IN100_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN100_WIDTH { PARAM_VALUE.IN100_WIDTH } {
	# Procedure called to validate IN100_WIDTH
	return true
}

proc update_PARAM_VALUE.IN101_WIDTH { PARAM_VALUE.IN101_WIDTH } {
	# Procedure called to update IN101_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN101_WIDTH { PARAM_VALUE.IN101_WIDTH } {
	# Procedure called to validate IN101_WIDTH
	return true
}

proc update_PARAM_VALUE.IN102_WIDTH { PARAM_VALUE.IN102_WIDTH } {
	# Procedure called to update IN102_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN102_WIDTH { PARAM_VALUE.IN102_WIDTH } {
	# Procedure called to validate IN102_WIDTH
	return true
}

proc update_PARAM_VALUE.IN103_WIDTH { PARAM_VALUE.IN103_WIDTH } {
	# Procedure called to update IN103_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN103_WIDTH { PARAM_VALUE.IN103_WIDTH } {
	# Procedure called to validate IN103_WIDTH
	return true
}

proc update_PARAM_VALUE.IN104_WIDTH { PARAM_VALUE.IN104_WIDTH } {
	# Procedure called to update IN104_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN104_WIDTH { PARAM_VALUE.IN104_WIDTH } {
	# Procedure called to validate IN104_WIDTH
	return true
}

proc update_PARAM_VALUE.IN105_WIDTH { PARAM_VALUE.IN105_WIDTH } {
	# Procedure called to update IN105_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN105_WIDTH { PARAM_VALUE.IN105_WIDTH } {
	# Procedure called to validate IN105_WIDTH
	return true
}

proc update_PARAM_VALUE.IN106_WIDTH { PARAM_VALUE.IN106_WIDTH } {
	# Procedure called to update IN106_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN106_WIDTH { PARAM_VALUE.IN106_WIDTH } {
	# Procedure called to validate IN106_WIDTH
	return true
}

proc update_PARAM_VALUE.IN107_WIDTH { PARAM_VALUE.IN107_WIDTH } {
	# Procedure called to update IN107_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN107_WIDTH { PARAM_VALUE.IN107_WIDTH } {
	# Procedure called to validate IN107_WIDTH
	return true
}

proc update_PARAM_VALUE.IN108_WIDTH { PARAM_VALUE.IN108_WIDTH } {
	# Procedure called to update IN108_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN108_WIDTH { PARAM_VALUE.IN108_WIDTH } {
	# Procedure called to validate IN108_WIDTH
	return true
}

proc update_PARAM_VALUE.IN109_WIDTH { PARAM_VALUE.IN109_WIDTH } {
	# Procedure called to update IN109_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN109_WIDTH { PARAM_VALUE.IN109_WIDTH } {
	# Procedure called to validate IN109_WIDTH
	return true
}

proc update_PARAM_VALUE.IN110_WIDTH { PARAM_VALUE.IN110_WIDTH } {
	# Procedure called to update IN110_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN110_WIDTH { PARAM_VALUE.IN110_WIDTH } {
	# Procedure called to validate IN110_WIDTH
	return true
}

proc update_PARAM_VALUE.IN111_WIDTH { PARAM_VALUE.IN111_WIDTH } {
	# Procedure called to update IN111_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN111_WIDTH { PARAM_VALUE.IN111_WIDTH } {
	# Procedure called to validate IN111_WIDTH
	return true
}

proc update_PARAM_VALUE.IN112_WIDTH { PARAM_VALUE.IN112_WIDTH } {
	# Procedure called to update IN112_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN112_WIDTH { PARAM_VALUE.IN112_WIDTH } {
	# Procedure called to validate IN112_WIDTH
	return true
}

proc update_PARAM_VALUE.IN113_WIDTH { PARAM_VALUE.IN113_WIDTH } {
	# Procedure called to update IN113_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN113_WIDTH { PARAM_VALUE.IN113_WIDTH } {
	# Procedure called to validate IN113_WIDTH
	return true
}

proc update_PARAM_VALUE.IN114_WIDTH { PARAM_VALUE.IN114_WIDTH } {
	# Procedure called to update IN114_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN114_WIDTH { PARAM_VALUE.IN114_WIDTH } {
	# Procedure called to validate IN114_WIDTH
	return true
}

proc update_PARAM_VALUE.IN115_WIDTH { PARAM_VALUE.IN115_WIDTH } {
	# Procedure called to update IN115_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN115_WIDTH { PARAM_VALUE.IN115_WIDTH } {
	# Procedure called to validate IN115_WIDTH
	return true
}

proc update_PARAM_VALUE.IN116_WIDTH { PARAM_VALUE.IN116_WIDTH } {
	# Procedure called to update IN116_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN116_WIDTH { PARAM_VALUE.IN116_WIDTH } {
	# Procedure called to validate IN116_WIDTH
	return true
}

proc update_PARAM_VALUE.IN117_WIDTH { PARAM_VALUE.IN117_WIDTH } {
	# Procedure called to update IN117_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN117_WIDTH { PARAM_VALUE.IN117_WIDTH } {
	# Procedure called to validate IN117_WIDTH
	return true
}

proc update_PARAM_VALUE.IN118_WIDTH { PARAM_VALUE.IN118_WIDTH } {
	# Procedure called to update IN118_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN118_WIDTH { PARAM_VALUE.IN118_WIDTH } {
	# Procedure called to validate IN118_WIDTH
	return true
}

proc update_PARAM_VALUE.IN119_WIDTH { PARAM_VALUE.IN119_WIDTH } {
	# Procedure called to update IN119_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN119_WIDTH { PARAM_VALUE.IN119_WIDTH } {
	# Procedure called to validate IN119_WIDTH
	return true
}

proc update_PARAM_VALUE.IN120_WIDTH { PARAM_VALUE.IN120_WIDTH } {
	# Procedure called to update IN120_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN120_WIDTH { PARAM_VALUE.IN120_WIDTH } {
	# Procedure called to validate IN120_WIDTH
	return true
}

proc update_PARAM_VALUE.IN121_WIDTH { PARAM_VALUE.IN121_WIDTH } {
	# Procedure called to update IN121_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN121_WIDTH { PARAM_VALUE.IN121_WIDTH } {
	# Procedure called to validate IN121_WIDTH
	return true
}

proc update_PARAM_VALUE.IN122_WIDTH { PARAM_VALUE.IN122_WIDTH } {
	# Procedure called to update IN122_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN122_WIDTH { PARAM_VALUE.IN122_WIDTH } {
	# Procedure called to validate IN122_WIDTH
	return true
}

proc update_PARAM_VALUE.IN123_WIDTH { PARAM_VALUE.IN123_WIDTH } {
	# Procedure called to update IN123_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN123_WIDTH { PARAM_VALUE.IN123_WIDTH } {
	# Procedure called to validate IN123_WIDTH
	return true
}

proc update_PARAM_VALUE.IN124_WIDTH { PARAM_VALUE.IN124_WIDTH } {
	# Procedure called to update IN124_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN124_WIDTH { PARAM_VALUE.IN124_WIDTH } {
	# Procedure called to validate IN124_WIDTH
	return true
}

proc update_PARAM_VALUE.IN125_WIDTH { PARAM_VALUE.IN125_WIDTH } {
	# Procedure called to update IN125_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN125_WIDTH { PARAM_VALUE.IN125_WIDTH } {
	# Procedure called to validate IN125_WIDTH
	return true
}

proc update_PARAM_VALUE.IN126_WIDTH { PARAM_VALUE.IN126_WIDTH } {
	# Procedure called to update IN126_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN126_WIDTH { PARAM_VALUE.IN126_WIDTH } {
	# Procedure called to validate IN126_WIDTH
	return true
}

proc update_PARAM_VALUE.IN127_WIDTH { PARAM_VALUE.IN127_WIDTH } {
	# Procedure called to update IN127_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IN127_WIDTH { PARAM_VALUE.IN127_WIDTH } {
	# Procedure called to validate IN127_WIDTH
	return true
}


proc validate_PARAM_VALUE.dout_width { PARAM_VALUE.dout_width } {
	# Procedure called to validate dout_width
	return true
}


proc update_MODELPARAM_VALUE.IN0_WIDTH { MODELPARAM_VALUE.IN0_WIDTH PARAM_VALUE.IN0_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN0_WIDTH}] ${MODELPARAM_VALUE.IN0_WIDTH}
}

proc update_MODELPARAM_VALUE.IN1_WIDTH { MODELPARAM_VALUE.IN1_WIDTH PARAM_VALUE.IN1_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN1_WIDTH}] ${MODELPARAM_VALUE.IN1_WIDTH}
}

proc update_MODELPARAM_VALUE.IN2_WIDTH { MODELPARAM_VALUE.IN2_WIDTH PARAM_VALUE.IN2_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN2_WIDTH}] ${MODELPARAM_VALUE.IN2_WIDTH}
}

proc update_MODELPARAM_VALUE.IN3_WIDTH { MODELPARAM_VALUE.IN3_WIDTH PARAM_VALUE.IN3_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN3_WIDTH}] ${MODELPARAM_VALUE.IN3_WIDTH}
}

proc update_MODELPARAM_VALUE.IN4_WIDTH { MODELPARAM_VALUE.IN4_WIDTH PARAM_VALUE.IN4_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN4_WIDTH}] ${MODELPARAM_VALUE.IN4_WIDTH}
}

proc update_MODELPARAM_VALUE.IN5_WIDTH { MODELPARAM_VALUE.IN5_WIDTH PARAM_VALUE.IN5_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN5_WIDTH}] ${MODELPARAM_VALUE.IN5_WIDTH}
}

proc update_MODELPARAM_VALUE.IN6_WIDTH { MODELPARAM_VALUE.IN6_WIDTH PARAM_VALUE.IN6_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN6_WIDTH}] ${MODELPARAM_VALUE.IN6_WIDTH}
}

proc update_MODELPARAM_VALUE.IN7_WIDTH { MODELPARAM_VALUE.IN7_WIDTH PARAM_VALUE.IN7_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN7_WIDTH}] ${MODELPARAM_VALUE.IN7_WIDTH}
}

proc update_MODELPARAM_VALUE.IN8_WIDTH { MODELPARAM_VALUE.IN8_WIDTH PARAM_VALUE.IN8_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN8_WIDTH}] ${MODELPARAM_VALUE.IN8_WIDTH}
}

proc update_MODELPARAM_VALUE.IN9_WIDTH { MODELPARAM_VALUE.IN9_WIDTH PARAM_VALUE.IN9_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN9_WIDTH}] ${MODELPARAM_VALUE.IN9_WIDTH}
}

proc update_MODELPARAM_VALUE.IN10_WIDTH { MODELPARAM_VALUE.IN10_WIDTH PARAM_VALUE.IN10_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN10_WIDTH}] ${MODELPARAM_VALUE.IN10_WIDTH}
}

proc update_MODELPARAM_VALUE.IN11_WIDTH { MODELPARAM_VALUE.IN11_WIDTH PARAM_VALUE.IN11_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN11_WIDTH}] ${MODELPARAM_VALUE.IN11_WIDTH}
}

proc update_MODELPARAM_VALUE.IN12_WIDTH { MODELPARAM_VALUE.IN12_WIDTH PARAM_VALUE.IN12_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN12_WIDTH}] ${MODELPARAM_VALUE.IN12_WIDTH}
}

proc update_MODELPARAM_VALUE.IN13_WIDTH { MODELPARAM_VALUE.IN13_WIDTH PARAM_VALUE.IN13_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN13_WIDTH}] ${MODELPARAM_VALUE.IN13_WIDTH}
}

proc update_MODELPARAM_VALUE.IN14_WIDTH { MODELPARAM_VALUE.IN14_WIDTH PARAM_VALUE.IN14_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN14_WIDTH}] ${MODELPARAM_VALUE.IN14_WIDTH}
}

proc update_MODELPARAM_VALUE.IN15_WIDTH { MODELPARAM_VALUE.IN15_WIDTH PARAM_VALUE.IN15_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN15_WIDTH}] ${MODELPARAM_VALUE.IN15_WIDTH}
}

proc update_MODELPARAM_VALUE.IN16_WIDTH { MODELPARAM_VALUE.IN16_WIDTH PARAM_VALUE.IN16_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN16_WIDTH}] ${MODELPARAM_VALUE.IN16_WIDTH}
}

proc update_MODELPARAM_VALUE.IN17_WIDTH { MODELPARAM_VALUE.IN17_WIDTH PARAM_VALUE.IN17_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN17_WIDTH}] ${MODELPARAM_VALUE.IN17_WIDTH}
}

proc update_MODELPARAM_VALUE.IN18_WIDTH { MODELPARAM_VALUE.IN18_WIDTH PARAM_VALUE.IN18_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN18_WIDTH}] ${MODELPARAM_VALUE.IN18_WIDTH}
}

proc update_MODELPARAM_VALUE.IN19_WIDTH { MODELPARAM_VALUE.IN19_WIDTH PARAM_VALUE.IN19_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN19_WIDTH}] ${MODELPARAM_VALUE.IN19_WIDTH}
}

proc update_MODELPARAM_VALUE.IN20_WIDTH { MODELPARAM_VALUE.IN20_WIDTH PARAM_VALUE.IN20_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN20_WIDTH}] ${MODELPARAM_VALUE.IN20_WIDTH}
}

proc update_MODELPARAM_VALUE.IN21_WIDTH { MODELPARAM_VALUE.IN21_WIDTH PARAM_VALUE.IN21_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN21_WIDTH}] ${MODELPARAM_VALUE.IN21_WIDTH}
}

proc update_MODELPARAM_VALUE.IN22_WIDTH { MODELPARAM_VALUE.IN22_WIDTH PARAM_VALUE.IN22_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN22_WIDTH}] ${MODELPARAM_VALUE.IN22_WIDTH}
}

proc update_MODELPARAM_VALUE.IN23_WIDTH { MODELPARAM_VALUE.IN23_WIDTH PARAM_VALUE.IN23_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN23_WIDTH}] ${MODELPARAM_VALUE.IN23_WIDTH}
}

proc update_MODELPARAM_VALUE.IN24_WIDTH { MODELPARAM_VALUE.IN24_WIDTH PARAM_VALUE.IN24_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN24_WIDTH}] ${MODELPARAM_VALUE.IN24_WIDTH}
}

proc update_MODELPARAM_VALUE.IN25_WIDTH { MODELPARAM_VALUE.IN25_WIDTH PARAM_VALUE.IN25_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN25_WIDTH}] ${MODELPARAM_VALUE.IN25_WIDTH}
}

proc update_MODELPARAM_VALUE.IN26_WIDTH { MODELPARAM_VALUE.IN26_WIDTH PARAM_VALUE.IN26_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN26_WIDTH}] ${MODELPARAM_VALUE.IN26_WIDTH}
}

proc update_MODELPARAM_VALUE.IN27_WIDTH { MODELPARAM_VALUE.IN27_WIDTH PARAM_VALUE.IN27_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN27_WIDTH}] ${MODELPARAM_VALUE.IN27_WIDTH}
}

proc update_MODELPARAM_VALUE.IN28_WIDTH { MODELPARAM_VALUE.IN28_WIDTH PARAM_VALUE.IN28_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN28_WIDTH}] ${MODELPARAM_VALUE.IN28_WIDTH}
}

proc update_MODELPARAM_VALUE.IN29_WIDTH { MODELPARAM_VALUE.IN29_WIDTH PARAM_VALUE.IN29_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN29_WIDTH}] ${MODELPARAM_VALUE.IN29_WIDTH}
}

proc update_MODELPARAM_VALUE.IN30_WIDTH { MODELPARAM_VALUE.IN30_WIDTH PARAM_VALUE.IN30_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN30_WIDTH}] ${MODELPARAM_VALUE.IN30_WIDTH}
}

proc update_MODELPARAM_VALUE.IN31_WIDTH { MODELPARAM_VALUE.IN31_WIDTH PARAM_VALUE.IN31_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN31_WIDTH}] ${MODELPARAM_VALUE.IN31_WIDTH}
}
proc update_MODELPARAM_VALUE.IN32_WIDTH { MODELPARAM_VALUE.IN32_WIDTH PARAM_VALUE.IN32_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN32_WIDTH}] ${MODELPARAM_VALUE.IN32_WIDTH}
}


proc update_MODELPARAM_VALUE.IN33_WIDTH { MODELPARAM_VALUE.IN33_WIDTH PARAM_VALUE.IN33_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN33_WIDTH}] ${MODELPARAM_VALUE.IN33_WIDTH}
}


proc update_MODELPARAM_VALUE.IN34_WIDTH { MODELPARAM_VALUE.IN34_WIDTH PARAM_VALUE.IN34_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN34_WIDTH}] ${MODELPARAM_VALUE.IN34_WIDTH}
}


proc update_MODELPARAM_VALUE.IN35_WIDTH { MODELPARAM_VALUE.IN35_WIDTH PARAM_VALUE.IN35_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN35_WIDTH}] ${MODELPARAM_VALUE.IN35_WIDTH}
}


proc update_MODELPARAM_VALUE.IN36_WIDTH { MODELPARAM_VALUE.IN36_WIDTH PARAM_VALUE.IN36_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN36_WIDTH}] ${MODELPARAM_VALUE.IN36_WIDTH}
}


proc update_MODELPARAM_VALUE.IN37_WIDTH { MODELPARAM_VALUE.IN37_WIDTH PARAM_VALUE.IN37_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN37_WIDTH}] ${MODELPARAM_VALUE.IN37_WIDTH}
}


proc update_MODELPARAM_VALUE.IN38_WIDTH { MODELPARAM_VALUE.IN38_WIDTH PARAM_VALUE.IN38_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN38_WIDTH}] ${MODELPARAM_VALUE.IN38_WIDTH}
}


proc update_MODELPARAM_VALUE.IN39_WIDTH { MODELPARAM_VALUE.IN39_WIDTH PARAM_VALUE.IN39_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN39_WIDTH}] ${MODELPARAM_VALUE.IN39_WIDTH}
}


proc update_MODELPARAM_VALUE.IN40_WIDTH { MODELPARAM_VALUE.IN40_WIDTH PARAM_VALUE.IN40_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN40_WIDTH}] ${MODELPARAM_VALUE.IN40_WIDTH}
}


proc update_MODELPARAM_VALUE.IN41_WIDTH { MODELPARAM_VALUE.IN41_WIDTH PARAM_VALUE.IN41_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN41_WIDTH}] ${MODELPARAM_VALUE.IN41_WIDTH}
}


proc update_MODELPARAM_VALUE.IN42_WIDTH { MODELPARAM_VALUE.IN42_WIDTH PARAM_VALUE.IN42_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN42_WIDTH}] ${MODELPARAM_VALUE.IN42_WIDTH}
}


proc update_MODELPARAM_VALUE.IN43_WIDTH { MODELPARAM_VALUE.IN43_WIDTH PARAM_VALUE.IN43_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN43_WIDTH}] ${MODELPARAM_VALUE.IN43_WIDTH}
}


proc update_MODELPARAM_VALUE.IN44_WIDTH { MODELPARAM_VALUE.IN44_WIDTH PARAM_VALUE.IN44_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN44_WIDTH}] ${MODELPARAM_VALUE.IN44_WIDTH}
}


proc update_MODELPARAM_VALUE.IN45_WIDTH { MODELPARAM_VALUE.IN45_WIDTH PARAM_VALUE.IN45_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN45_WIDTH}] ${MODELPARAM_VALUE.IN45_WIDTH}
}


proc update_MODELPARAM_VALUE.IN46_WIDTH { MODELPARAM_VALUE.IN46_WIDTH PARAM_VALUE.IN46_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN46_WIDTH}] ${MODELPARAM_VALUE.IN46_WIDTH}
}


proc update_MODELPARAM_VALUE.IN47_WIDTH { MODELPARAM_VALUE.IN47_WIDTH PARAM_VALUE.IN47_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN47_WIDTH}] ${MODELPARAM_VALUE.IN47_WIDTH}
}


proc update_MODELPARAM_VALUE.IN48_WIDTH { MODELPARAM_VALUE.IN48_WIDTH PARAM_VALUE.IN48_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN48_WIDTH}] ${MODELPARAM_VALUE.IN48_WIDTH}
}


proc update_MODELPARAM_VALUE.IN49_WIDTH { MODELPARAM_VALUE.IN49_WIDTH PARAM_VALUE.IN49_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN49_WIDTH}] ${MODELPARAM_VALUE.IN49_WIDTH}
}


proc update_MODELPARAM_VALUE.IN50_WIDTH { MODELPARAM_VALUE.IN50_WIDTH PARAM_VALUE.IN50_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN50_WIDTH}] ${MODELPARAM_VALUE.IN50_WIDTH}
}


proc update_MODELPARAM_VALUE.IN51_WIDTH { MODELPARAM_VALUE.IN51_WIDTH PARAM_VALUE.IN51_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN51_WIDTH}] ${MODELPARAM_VALUE.IN51_WIDTH}
}


proc update_MODELPARAM_VALUE.IN52_WIDTH { MODELPARAM_VALUE.IN52_WIDTH PARAM_VALUE.IN52_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN52_WIDTH}] ${MODELPARAM_VALUE.IN52_WIDTH}
}


proc update_MODELPARAM_VALUE.IN53_WIDTH { MODELPARAM_VALUE.IN53_WIDTH PARAM_VALUE.IN53_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN53_WIDTH}] ${MODELPARAM_VALUE.IN53_WIDTH}
}


proc update_MODELPARAM_VALUE.IN54_WIDTH { MODELPARAM_VALUE.IN54_WIDTH PARAM_VALUE.IN54_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN54_WIDTH}] ${MODELPARAM_VALUE.IN54_WIDTH}
}


proc update_MODELPARAM_VALUE.IN55_WIDTH { MODELPARAM_VALUE.IN55_WIDTH PARAM_VALUE.IN55_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN55_WIDTH}] ${MODELPARAM_VALUE.IN55_WIDTH}
}


proc update_MODELPARAM_VALUE.IN56_WIDTH { MODELPARAM_VALUE.IN56_WIDTH PARAM_VALUE.IN56_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN56_WIDTH}] ${MODELPARAM_VALUE.IN56_WIDTH}
}


proc update_MODELPARAM_VALUE.IN57_WIDTH { MODELPARAM_VALUE.IN57_WIDTH PARAM_VALUE.IN57_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN57_WIDTH}] ${MODELPARAM_VALUE.IN57_WIDTH}
}


proc update_MODELPARAM_VALUE.IN58_WIDTH { MODELPARAM_VALUE.IN58_WIDTH PARAM_VALUE.IN58_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN58_WIDTH}] ${MODELPARAM_VALUE.IN58_WIDTH}
}


proc update_MODELPARAM_VALUE.IN59_WIDTH { MODELPARAM_VALUE.IN59_WIDTH PARAM_VALUE.IN59_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN59_WIDTH}] ${MODELPARAM_VALUE.IN59_WIDTH}
}


proc update_MODELPARAM_VALUE.IN60_WIDTH { MODELPARAM_VALUE.IN60_WIDTH PARAM_VALUE.IN60_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN60_WIDTH}] ${MODELPARAM_VALUE.IN60_WIDTH}
}


proc update_MODELPARAM_VALUE.IN61_WIDTH { MODELPARAM_VALUE.IN61_WIDTH PARAM_VALUE.IN61_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN61_WIDTH}] ${MODELPARAM_VALUE.IN61_WIDTH}
}


proc update_MODELPARAM_VALUE.IN62_WIDTH { MODELPARAM_VALUE.IN62_WIDTH PARAM_VALUE.IN62_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN62_WIDTH}] ${MODELPARAM_VALUE.IN62_WIDTH}
}


proc update_MODELPARAM_VALUE.IN63_WIDTH { MODELPARAM_VALUE.IN63_WIDTH PARAM_VALUE.IN63_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN63_WIDTH}] ${MODELPARAM_VALUE.IN63_WIDTH}
}


proc update_MODELPARAM_VALUE.IN64_WIDTH { MODELPARAM_VALUE.IN64_WIDTH PARAM_VALUE.IN64_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN64_WIDTH}] ${MODELPARAM_VALUE.IN64_WIDTH}
}


proc update_MODELPARAM_VALUE.IN65_WIDTH { MODELPARAM_VALUE.IN65_WIDTH PARAM_VALUE.IN65_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN65_WIDTH}] ${MODELPARAM_VALUE.IN65_WIDTH}
}


proc update_MODELPARAM_VALUE.IN66_WIDTH { MODELPARAM_VALUE.IN66_WIDTH PARAM_VALUE.IN66_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN66_WIDTH}] ${MODELPARAM_VALUE.IN66_WIDTH}
}


proc update_MODELPARAM_VALUE.IN67_WIDTH { MODELPARAM_VALUE.IN67_WIDTH PARAM_VALUE.IN67_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN67_WIDTH}] ${MODELPARAM_VALUE.IN67_WIDTH}
}


proc update_MODELPARAM_VALUE.IN68_WIDTH { MODELPARAM_VALUE.IN68_WIDTH PARAM_VALUE.IN68_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN68_WIDTH}] ${MODELPARAM_VALUE.IN68_WIDTH}
}


proc update_MODELPARAM_VALUE.IN69_WIDTH { MODELPARAM_VALUE.IN69_WIDTH PARAM_VALUE.IN69_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN69_WIDTH}] ${MODELPARAM_VALUE.IN69_WIDTH}
}


proc update_MODELPARAM_VALUE.IN70_WIDTH { MODELPARAM_VALUE.IN70_WIDTH PARAM_VALUE.IN70_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN70_WIDTH}] ${MODELPARAM_VALUE.IN70_WIDTH}
}


proc update_MODELPARAM_VALUE.IN71_WIDTH { MODELPARAM_VALUE.IN71_WIDTH PARAM_VALUE.IN71_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN71_WIDTH}] ${MODELPARAM_VALUE.IN71_WIDTH}
}


proc update_MODELPARAM_VALUE.IN72_WIDTH { MODELPARAM_VALUE.IN72_WIDTH PARAM_VALUE.IN72_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN72_WIDTH}] ${MODELPARAM_VALUE.IN72_WIDTH}
}


proc update_MODELPARAM_VALUE.IN73_WIDTH { MODELPARAM_VALUE.IN73_WIDTH PARAM_VALUE.IN73_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN73_WIDTH}] ${MODELPARAM_VALUE.IN73_WIDTH}
}


proc update_MODELPARAM_VALUE.IN74_WIDTH { MODELPARAM_VALUE.IN74_WIDTH PARAM_VALUE.IN74_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN74_WIDTH}] ${MODELPARAM_VALUE.IN74_WIDTH}
}


proc update_MODELPARAM_VALUE.IN75_WIDTH { MODELPARAM_VALUE.IN75_WIDTH PARAM_VALUE.IN75_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN75_WIDTH}] ${MODELPARAM_VALUE.IN75_WIDTH}
}


proc update_MODELPARAM_VALUE.IN76_WIDTH { MODELPARAM_VALUE.IN76_WIDTH PARAM_VALUE.IN76_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN76_WIDTH}] ${MODELPARAM_VALUE.IN76_WIDTH}
}


proc update_MODELPARAM_VALUE.IN77_WIDTH { MODELPARAM_VALUE.IN77_WIDTH PARAM_VALUE.IN77_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN77_WIDTH}] ${MODELPARAM_VALUE.IN77_WIDTH}
}


proc update_MODELPARAM_VALUE.IN78_WIDTH { MODELPARAM_VALUE.IN78_WIDTH PARAM_VALUE.IN78_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN78_WIDTH}] ${MODELPARAM_VALUE.IN78_WIDTH}
}


proc update_MODELPARAM_VALUE.IN79_WIDTH { MODELPARAM_VALUE.IN79_WIDTH PARAM_VALUE.IN79_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN79_WIDTH}] ${MODELPARAM_VALUE.IN79_WIDTH}
}


proc update_MODELPARAM_VALUE.IN80_WIDTH { MODELPARAM_VALUE.IN80_WIDTH PARAM_VALUE.IN80_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN80_WIDTH}] ${MODELPARAM_VALUE.IN80_WIDTH}
}


proc update_MODELPARAM_VALUE.IN81_WIDTH { MODELPARAM_VALUE.IN81_WIDTH PARAM_VALUE.IN81_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN81_WIDTH}] ${MODELPARAM_VALUE.IN81_WIDTH}
}


proc update_MODELPARAM_VALUE.IN82_WIDTH { MODELPARAM_VALUE.IN82_WIDTH PARAM_VALUE.IN82_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN82_WIDTH}] ${MODELPARAM_VALUE.IN82_WIDTH}
}


proc update_MODELPARAM_VALUE.IN83_WIDTH { MODELPARAM_VALUE.IN83_WIDTH PARAM_VALUE.IN83_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN83_WIDTH}] ${MODELPARAM_VALUE.IN83_WIDTH}
}


proc update_MODELPARAM_VALUE.IN84_WIDTH { MODELPARAM_VALUE.IN84_WIDTH PARAM_VALUE.IN84_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN84_WIDTH}] ${MODELPARAM_VALUE.IN84_WIDTH}
}


proc update_MODELPARAM_VALUE.IN85_WIDTH { MODELPARAM_VALUE.IN85_WIDTH PARAM_VALUE.IN85_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN85_WIDTH}] ${MODELPARAM_VALUE.IN85_WIDTH}
}


proc update_MODELPARAM_VALUE.IN86_WIDTH { MODELPARAM_VALUE.IN86_WIDTH PARAM_VALUE.IN86_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN86_WIDTH}] ${MODELPARAM_VALUE.IN86_WIDTH}
}


proc update_MODELPARAM_VALUE.IN87_WIDTH { MODELPARAM_VALUE.IN87_WIDTH PARAM_VALUE.IN87_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN87_WIDTH}] ${MODELPARAM_VALUE.IN87_WIDTH}
}


proc update_MODELPARAM_VALUE.IN88_WIDTH { MODELPARAM_VALUE.IN88_WIDTH PARAM_VALUE.IN88_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN88_WIDTH}] ${MODELPARAM_VALUE.IN88_WIDTH}
}


proc update_MODELPARAM_VALUE.IN89_WIDTH { MODELPARAM_VALUE.IN89_WIDTH PARAM_VALUE.IN89_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN89_WIDTH}] ${MODELPARAM_VALUE.IN89_WIDTH}
}


proc update_MODELPARAM_VALUE.IN90_WIDTH { MODELPARAM_VALUE.IN90_WIDTH PARAM_VALUE.IN90_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN90_WIDTH}] ${MODELPARAM_VALUE.IN90_WIDTH}
}


proc update_MODELPARAM_VALUE.IN91_WIDTH { MODELPARAM_VALUE.IN91_WIDTH PARAM_VALUE.IN91_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN91_WIDTH}] ${MODELPARAM_VALUE.IN91_WIDTH}
}


proc update_MODELPARAM_VALUE.IN92_WIDTH { MODELPARAM_VALUE.IN92_WIDTH PARAM_VALUE.IN92_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN92_WIDTH}] ${MODELPARAM_VALUE.IN92_WIDTH}
}


proc update_MODELPARAM_VALUE.IN93_WIDTH { MODELPARAM_VALUE.IN93_WIDTH PARAM_VALUE.IN93_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN93_WIDTH}] ${MODELPARAM_VALUE.IN93_WIDTH}
}


proc update_MODELPARAM_VALUE.IN94_WIDTH { MODELPARAM_VALUE.IN94_WIDTH PARAM_VALUE.IN94_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN94_WIDTH}] ${MODELPARAM_VALUE.IN94_WIDTH}
}


proc update_MODELPARAM_VALUE.IN95_WIDTH { MODELPARAM_VALUE.IN95_WIDTH PARAM_VALUE.IN95_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN95_WIDTH}] ${MODELPARAM_VALUE.IN95_WIDTH}
}


proc update_MODELPARAM_VALUE.IN96_WIDTH { MODELPARAM_VALUE.IN96_WIDTH PARAM_VALUE.IN96_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN96_WIDTH}] ${MODELPARAM_VALUE.IN96_WIDTH}
}


proc update_MODELPARAM_VALUE.IN97_WIDTH { MODELPARAM_VALUE.IN97_WIDTH PARAM_VALUE.IN97_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN97_WIDTH}] ${MODELPARAM_VALUE.IN97_WIDTH}
}


proc update_MODELPARAM_VALUE.IN98_WIDTH { MODELPARAM_VALUE.IN98_WIDTH PARAM_VALUE.IN98_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN98_WIDTH}] ${MODELPARAM_VALUE.IN98_WIDTH}
}


proc update_MODELPARAM_VALUE.IN99_WIDTH { MODELPARAM_VALUE.IN99_WIDTH PARAM_VALUE.IN99_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN99_WIDTH}] ${MODELPARAM_VALUE.IN99_WIDTH}
}


proc update_MODELPARAM_VALUE.IN100_WIDTH { MODELPARAM_VALUE.IN100_WIDTH PARAM_VALUE.IN100_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN100_WIDTH}] ${MODELPARAM_VALUE.IN100_WIDTH}
}


proc update_MODELPARAM_VALUE.IN101_WIDTH { MODELPARAM_VALUE.IN101_WIDTH PARAM_VALUE.IN101_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN101_WIDTH}] ${MODELPARAM_VALUE.IN101_WIDTH}
}


proc update_MODELPARAM_VALUE.IN102_WIDTH { MODELPARAM_VALUE.IN102_WIDTH PARAM_VALUE.IN102_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN102_WIDTH}] ${MODELPARAM_VALUE.IN102_WIDTH}
}


proc update_MODELPARAM_VALUE.IN103_WIDTH { MODELPARAM_VALUE.IN103_WIDTH PARAM_VALUE.IN103_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN103_WIDTH}] ${MODELPARAM_VALUE.IN103_WIDTH}
}


proc update_MODELPARAM_VALUE.IN104_WIDTH { MODELPARAM_VALUE.IN104_WIDTH PARAM_VALUE.IN104_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN104_WIDTH}] ${MODELPARAM_VALUE.IN104_WIDTH}
}


proc update_MODELPARAM_VALUE.IN105_WIDTH { MODELPARAM_VALUE.IN105_WIDTH PARAM_VALUE.IN105_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN105_WIDTH}] ${MODELPARAM_VALUE.IN105_WIDTH}
}


proc update_MODELPARAM_VALUE.IN106_WIDTH { MODELPARAM_VALUE.IN106_WIDTH PARAM_VALUE.IN106_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN106_WIDTH}] ${MODELPARAM_VALUE.IN106_WIDTH}
}


proc update_MODELPARAM_VALUE.IN107_WIDTH { MODELPARAM_VALUE.IN107_WIDTH PARAM_VALUE.IN107_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN107_WIDTH}] ${MODELPARAM_VALUE.IN107_WIDTH}
}


proc update_MODELPARAM_VALUE.IN108_WIDTH { MODELPARAM_VALUE.IN108_WIDTH PARAM_VALUE.IN108_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN108_WIDTH}] ${MODELPARAM_VALUE.IN108_WIDTH}
}


proc update_MODELPARAM_VALUE.IN109_WIDTH { MODELPARAM_VALUE.IN109_WIDTH PARAM_VALUE.IN109_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN109_WIDTH}] ${MODELPARAM_VALUE.IN109_WIDTH}
}


proc update_MODELPARAM_VALUE.IN110_WIDTH { MODELPARAM_VALUE.IN110_WIDTH PARAM_VALUE.IN110_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN110_WIDTH}] ${MODELPARAM_VALUE.IN110_WIDTH}
}


proc update_MODELPARAM_VALUE.IN111_WIDTH { MODELPARAM_VALUE.IN111_WIDTH PARAM_VALUE.IN111_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN111_WIDTH}] ${MODELPARAM_VALUE.IN111_WIDTH}
}


proc update_MODELPARAM_VALUE.IN112_WIDTH { MODELPARAM_VALUE.IN112_WIDTH PARAM_VALUE.IN112_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN112_WIDTH}] ${MODELPARAM_VALUE.IN112_WIDTH}
}


proc update_MODELPARAM_VALUE.IN113_WIDTH { MODELPARAM_VALUE.IN113_WIDTH PARAM_VALUE.IN113_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN113_WIDTH}] ${MODELPARAM_VALUE.IN113_WIDTH}
}


proc update_MODELPARAM_VALUE.IN114_WIDTH { MODELPARAM_VALUE.IN114_WIDTH PARAM_VALUE.IN114_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN114_WIDTH}] ${MODELPARAM_VALUE.IN114_WIDTH}
}


proc update_MODELPARAM_VALUE.IN115_WIDTH { MODELPARAM_VALUE.IN115_WIDTH PARAM_VALUE.IN115_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN115_WIDTH}] ${MODELPARAM_VALUE.IN115_WIDTH}
}


proc update_MODELPARAM_VALUE.IN116_WIDTH { MODELPARAM_VALUE.IN116_WIDTH PARAM_VALUE.IN116_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN116_WIDTH}] ${MODELPARAM_VALUE.IN116_WIDTH}
}


proc update_MODELPARAM_VALUE.IN117_WIDTH { MODELPARAM_VALUE.IN117_WIDTH PARAM_VALUE.IN117_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN117_WIDTH}] ${MODELPARAM_VALUE.IN117_WIDTH}
}


proc update_MODELPARAM_VALUE.IN118_WIDTH { MODELPARAM_VALUE.IN118_WIDTH PARAM_VALUE.IN118_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN118_WIDTH}] ${MODELPARAM_VALUE.IN118_WIDTH}
}


proc update_MODELPARAM_VALUE.IN119_WIDTH { MODELPARAM_VALUE.IN119_WIDTH PARAM_VALUE.IN119_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN119_WIDTH}] ${MODELPARAM_VALUE.IN119_WIDTH}
}


proc update_MODELPARAM_VALUE.IN120_WIDTH { MODELPARAM_VALUE.IN120_WIDTH PARAM_VALUE.IN120_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN120_WIDTH}] ${MODELPARAM_VALUE.IN120_WIDTH}
}


proc update_MODELPARAM_VALUE.IN121_WIDTH { MODELPARAM_VALUE.IN121_WIDTH PARAM_VALUE.IN121_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN121_WIDTH}] ${MODELPARAM_VALUE.IN121_WIDTH}
}


proc update_MODELPARAM_VALUE.IN122_WIDTH { MODELPARAM_VALUE.IN122_WIDTH PARAM_VALUE.IN122_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN122_WIDTH}] ${MODELPARAM_VALUE.IN122_WIDTH}
}


proc update_MODELPARAM_VALUE.IN123_WIDTH { MODELPARAM_VALUE.IN123_WIDTH PARAM_VALUE.IN123_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN123_WIDTH}] ${MODELPARAM_VALUE.IN123_WIDTH}
}


proc update_MODELPARAM_VALUE.IN124_WIDTH { MODELPARAM_VALUE.IN124_WIDTH PARAM_VALUE.IN124_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN124_WIDTH}] ${MODELPARAM_VALUE.IN124_WIDTH}
}


proc update_MODELPARAM_VALUE.IN125_WIDTH { MODELPARAM_VALUE.IN125_WIDTH PARAM_VALUE.IN125_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN125_WIDTH}] ${MODELPARAM_VALUE.IN125_WIDTH}
}


proc update_MODELPARAM_VALUE.IN126_WIDTH { MODELPARAM_VALUE.IN126_WIDTH PARAM_VALUE.IN126_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN126_WIDTH}] ${MODELPARAM_VALUE.IN126_WIDTH}
}


proc update_MODELPARAM_VALUE.IN127_WIDTH { MODELPARAM_VALUE.IN127_WIDTH PARAM_VALUE.IN127_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IN127_WIDTH}] ${MODELPARAM_VALUE.IN127_WIDTH}
}



proc update_MODELPARAM_VALUE.dout_width { MODELPARAM_VALUE.dout_width PARAM_VALUE.dout_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.dout_width}] ${MODELPARAM_VALUE.dout_width}
}

proc update_MODELPARAM_VALUE.NUM_PORTS { MODELPARAM_VALUE.NUM_PORTS PARAM_VALUE.NUM_PORTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_PORTS}] ${MODELPARAM_VALUE.NUM_PORTS}
}

