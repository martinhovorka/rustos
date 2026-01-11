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
################################################################################
##      util_vector_logic
################################################################################
global ipName ""

array set g_property_list {
        clk         FREQ_HZ,PHASE,CLK_DOMAIN
        ce          FREQ_HZ,PHASE
        rst         POLARITY
        intr        SENSITIVITY
        data        ""
        undef       ""
 }
array set g_reverse_value {
        ACTIVE_HIGH     ACTIVE_LOW
        ACTIVE_LOW      ACTIVE_HIGH
        LEVEL_HIGH      LEVEL_LOW
        LEVEL_LOW       LEVEL_HIGH
        EDGE_RISING     EDGE_FALLING
        EDGE_FALLING    EDGE_RISING
    }

array set g_propagated_signal {
    undef,undef     undef,OK
    undef,data      data,INFO
    undef,rst       rst,INFO
    undef,clk       clk,INFO
    undef,intr      intr,INFO
    undef,ce        ce,INFO

    data,data       data,OK
    data,rst        rst,INFO
    data,clk        clk,INFO
    data,intr       intr,INFO
    data,ce         ce,INFO

    rst,rst         rst,OK
    rst,clk         undef,ERROR
    rst,intr        undef,CRITICAL_WARNING
    rst,ce          ce,CRITICAL_WARNING

    clk,clk         undef,ERROR
    clk,intr        undef,ERROR
    clk,ce          undef,ERROR

    intr,intr       intr,OK
    intr,ce         ce,CRITICAL_WARNING

    ce,ce           ce,ERROR
}
################################################################################
proc debug { msg } {
    variable ipName
    #::bd::send_msg -of $ipName -type INFO -msg_id 12 -text ":DEBUG:$msg"
}
################################################################################
proc get_type_props { type } {
 variable g_property_list
 set t [string tolower $type]
 if { [info exists g_property_list($t)] } {
     set props $g_property_list($t)
     set splitted_props [split $props ","]
     return $splitted_props
 }
 return ""
}
################################################################################
proc get_reverse_value { value } {

    variable g_reverse_value
    set t_v [string toupper $value]
    set reverse $value
    if { [info exists g_reverse_value($t_v) ] } {
        set reverse $g_reverse_value($t_v)
    }
    return $reverse
}
################################################################################
proc get_propagated_pin_type { cellName pin1type pin2type } {
    variable g_propagated_signal
    set pin1 [string tolower $pin1type]
    set pin2 [string tolower $pin2type]

    set outType ""
    if { [info exists g_propagated_signal($pin1,$pin2)] } {
        set outType $g_propagated_signal($pin1,$pin2)
    } elseif { [info exists g_propagated_signal($pin2,$pin1)] } {
        set outType $g_propagated_signal($pin2,$pin1)
    }


    if { [llength $outType ] == 0 }  {
        ::bd::send_msg -of $cellName -type INFO -msg_id 10 -text ": util_vector_logic IP does not support propagation when pin Op1 is connected to \"$pin1type\" type and  pin Op2 is connected to \"$pin2type\" type. For this case and output pin Res will be \"undef\" type"
        set outType "undef"
    } else {
        set splitted [split $outType ","]
        if { [llength $splitted] == 2 } {
            set outType [lindex $splitted 0]
            set anyIssue [lindex $splitted 1]
            set anyIssue [string toupper $anyIssue]
            switch -exact "$anyIssue" {
                "INFO" {
                    ::bd::send_msg -of $cellName -type INFO -msg_id 10 -text " IP set output pin Res type to \"$outType\" when Input pin Op1 type is \"$pin1type\" and Input pin Op2 type is \"$pin2type\"."
                }
                "ERROR" {
                    ::bd::send_msg -of $cellName -type ERROR -msg_id 10 -text " IP cannot do propagation when Input pin Op1 type is \"$pin1type\" and Input pin Op2 type is \"$pin2type\"."
                }
                "CRITICAL_WARNING" {
                    ::bd::send_msg -of $cellName -type CRITICAL_WARNING  -msg_id 10 -text " IP set output pin Res type to \"$outType\" when Input pin Op1 type is \"$pin1type\" and Input pin Op2 type is \"$pin2type\"."
               } 
                "OK" {
                    #no issue
                }
                default {
                    ::bd::send_msg -of $cellName -type WARNING  -msg_id 10 -text " IP set output pin Res type to \"$outType\" when Input pin Op1 type is \"$pin1type\" and Input pin Op2 type is \"$pin2type\"."
                }
            }
       } 
    }
    return $outType
}
################################################################################

proc get_other_end_pin { pinobj } {
   set endpin ""
   #set srcPins [find_bd_objs -relation connected_to $pinobj]
   #CR-1186148
   set srcPins [find_bd_objs -quiet -relation connected_to -thru_hier -stop_at_container $pinobj]
   foreach pin $srcPins {
     set pin_dir   [get_property DIR $pin]
     set pin_class [get_property CLASS $pin]
     if {("$pin_dir"  == "O" && "$pin_class" == "bd_pin") ||
         ("$pin_dir"  == "I" && "$pin_class" == "bd_port")} {
       set endpin $pin
       break;
     }
   } 
   return $endpin
}
################################################################################
proc get_pin_type { pinobj } {
    set pinType [string tolower [get_property TYPE $pinobj] ]
    if { $pinType == "undef"} {
        set pinType [string tolower [get_property CONFIG.PortType $pinobj]]
    }
    if {[llength $pinType] == 0 } {
        set pinType "undef"
    }
    return $pinType
}
################################################################################
proc get_pin_property { prop pinobj } {
    set pinType [get_pin_type $pinobj]
    set pinProps [get_type_props $pinType]
    set value ""
    foreach pinProp $pinProps {
        if { [string compare -nocase $prop $pinProp] == 0 } {
            set value [get_property CONFIG.$prop $pinobj]
        }
    }
    return $value
}
################################################################################
proc set_pin_type { pintype pinobj} {
    set prev_type [get_pin_type $pinobj]
    if { 0 != [string length $pintype] && [string tolower $pintype] != "undef" } {
        set_property CONFIG.PortType $pintype $pinobj
        set_property CONFIG.PortType.PROP_SRC false $pinobj
    } elseif {0 != [string length $prev_type] } {
        set_property CONFIG.PortType "undef" $pinobj
        set_property CONFIG.PortType.PROP_SRC false $pinobj
    }
}
################################################################################
proc get_pin_width { pinobj } {
    set width [get_property CONFIG.PortWidth $pinobj]
    if { 0 != [string length $width] && $width != 0 } {
    } else {
      set srcpin [get_other_end_pin $pinobj]
      if { 0 == [string length $srcpin] || $srcpin == 0 } {
        set srcpin $pinobj
      }
      set left [get_property LEFT  $srcpin] 
      if { 0 == [string length $left]} { set left 0 }
      set right [get_property RIGHT $srcpin]
      if { 0 == [string length $right]} { set right 0 }
      set width [expr ($left > $right) ? $left - $right + 1 : $right - $left + 1]
   }
}
################################################################################
proc propagate { cellName dictArg } {

    variable ipName
    set ipName $cellName

    set ip [get_bd_cells $cellName]

    set din1pin  [get_bd_pins $ip/Op1]
    set doutpin [get_bd_pins $ip/Res]
    set_pin_type "undef" $din1pin
    set_pin_type "undef" $doutpin

    set src1Pin [get_other_end_pin $din1pin]
    set op [get_property CONFIG.C_OPERATION $ip]
    if { $op eq "not" } {
        if {0 != [string length $src1Pin] } {
            set pinType [get_pin_type $src1Pin]
            set_pin_type $pinType $din1pin
        } else {
            #ignore when input pin is unconnected
            return
        }
        set props [get_type_props $pinType]
        foreach prop $props {
            set value [get_pin_property $prop $src1Pin]
            set reverse_value [get_reverse_value $value]
            set_property CONFIG.$prop $value $din1pin
           if { [string compare -nocase $prop PHASE] == 0 } {
               #special handling for Phase. It should be shifted by 180
               set reverse_value [expr $value + 180]
               if { $reverse_value >= 360 } {
                   set reverse_value [expr $reverse_value - 360]
               }
           }
            set_property CONFIG.$prop $reverse_value $doutpin
        }
        if { 0 ==[string length $pinType] || [string tolower $pinType] == "undef"} {
            set pinType "undef"
        }
        set_pin_type $pinType $doutpin
    } elseif { $op eq "and" || $op eq "or" || $op eq "xor" } {
        set din2pin [get_bd_pins $ip/Op2]
        set_pin_type "undef" $din2pin
        set src2Pin [get_other_end_pin $din2pin]
        if { 0 == [string length $src1Pin] && 0 == [string length $src2Pin] } {
            #ignore when both pin are unconnected
            return 
        } elseif { 0 == [string length $src1Pin] || 0 == [string length $src2Pin] } {
           ::bd::send_msg -of $cellName -type ERROR -msg_id 10 -text ": Both input pins Op1 and Op2 of ip \"$ip\" must be connected "
           return
        }
        set src1Type [get_pin_type $src1Pin]
        set src2Type [get_pin_type $src2Pin]
        set doutType [get_propagated_pin_type $cellName $src1Type $src2Type] 
        set_pin_type $src1Type $din1pin
        set_pin_type $src2Type $din2pin
        set_pin_type $doutType $doutpin
        set props [get_type_props $doutType]
        foreach prop $props {
           set prop_value1 [get_pin_property $prop $src1Pin]
           set prop_value2 [get_pin_property $prop $src2Pin]

           set prop_value $prop_value1
           if { [llength $prop_value1] && [llength $prop_value2]  } {
               #this is the case when property available in both pins. So here
               #it should be same otherwise error out.
               if { [string compare -nocase $prop_value1 $prop_value2] != 0 } {
                  ::bd::send_msg -of $cellName -type ERROR -msg_id 10 -text ": Both input pins should have same value for property $prop. Whereas Op1 $prop is $prop_value1 and Op2  $prop is $prop_value2"
               }
           } elseif { [llength $prop_value1] == 0 } {
               set prop_value $prop_value2
           }
           set_property CONFIG.$prop "$prop_value" $doutpin
        }
    } else {
       ::bd::send_msg -of $cellName -type INFO -msg_id 10 -text " util_vector_logic IP does not support propagation for operation \"$op\"."
       set_pin_type "undef" $doutpin
    }
}
################################################################################
