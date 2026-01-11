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
############################################################################
##      ilconcat UUPP
############################################################################
############################################################################

proc init { cellpath otherInfo } {
  set cell [get_bd_cells $cellpath]
  bd::mark_propagate_only $cell {dout_width}

  for {set portIndex 0 } { $portIndex < 128 } { incr portIndex } {
    set port_name "IN${portIndex}_WIDTH"
    bd::mark_propagate_overrideable $cell $port_name
  }
}
 
############################################################################
proc get_display_strings { cellpath obj_path type } {

   set retStrs ""

   if { $type eq "CELL" } {
      set retStrs [get_display_strings_cell $cellpath]
   } elseif { $type eq "INTF" } {
      #set retStrs [get_display_strings_intf $cellpath $obj_path]
   } elseif { $type eq "PORT" } {
      set retStrs [get_display_strings_pin $cellpath $obj_path]
   }

   return $retStrs
}

proc get_display_strings_cell { cellpath } {

   set cell [get_bd_cells $cellpath]
   set pins [get_bd_pins -of_objects $cell]

   set retStrs ""
   set str1 "dout="
   set str2 "dout="

   set pins [get_bd_pins $cell/In*]
   set num_pins [llength $pins]
   set num_index 1

   foreach pin $pins {
      set name [get_property NAME $pin]
      set left [get_property LEFT $pin]
      set right [get_property RIGHT $pin]
      set src_pin [find_bd_objs -relation connected_to $pin]

      # Create first string
      set pin_str "${name}[$left:$right]" 
      set str1 "${str1}$pin_str"

      # For now, if any input pins not connected, we will set second string ""
      if { $src_pin eq "" } {
         set str2 ""
      } elseif { $str2 ne "" } {

         set src_name [get_property NAME $src_pin]
         set src_str "${src_name}[$left:$right]" 
         set str2 "${str2}$src_str"
      }
      
      if { $num_index < $num_pins } {
         set str1 "${str1},"

         if { $str2 ne "" } {
            set str2 "${str2},"
         }
      }

      incr num_index
   }


   lappend retStrs $str1
   lappend retStrs $str2

   return $retStrs
}

proc get_display_strings_pin { cellpath obj_path } {

   set retStrs ""

   set cell [get_bd_cells $cellpath]
   set pin [get_bd_pins $obj_path]

   # Make sure we have pin object
   if { $pin == "" || $pin == 0 } {
      return $retStrs
   }

   set pin_name [get_propert NAME $pin ]
   set pin_dir  [get_property DIR $pin]

   # If output pin, then use "CELL" proc to get strings
   if { "$pin_dir" eq "O" } {
      set retStrs [get_display_strings_cell $cellpath]
      return $retStrs
   } else {
      return ""
   }

   # Get connected pin if connected
   set pin_other [get_display_strings_other_end_pin $pin]
   if { $pin_other == 0 } {
      return $retStrs
   }

   set pin_src $pin
   set pin_snk $pin_other

   if { "$pin_dir" == "I" } {
      set pin_src $pin_other
      set pin_snk $pin
   }

   set src_name [get_property NAME $pin_src]
   set src_left [get_property LEFT $pin_src]
   set src_right [get_property RIGHT $pin_src]

   set snk_name [get_property NAME $pin_snk]
   set snk_left [get_property LEFT $pin_snk]
   set snk_right [get_property RIGHT $pin_snk]

   set str "$src_name[${src_left}:${src_right}]:$snk_name[${snk_left}:${snk_right}]"

   lappend retStrs $str

   return $retStrs
}

############################################################################
proc get_display_strings_other_end_pin { pinobj } {

   # Empty pin obj
   if { $pinobj == "" || $pinobj == 0 } {
      return 0
   }

   set endpin 0
   set pinobj_dir  [get_property DIR $pinobj]
   set pinobj_class [get_property CLASS $pinobj]

   set srcPins [find_bd_objs -thru_hier -relation connected_to $pinobj]
   foreach pin $srcPins {
      set pin_dir   [get_property DIR $pin]
      set pin_class [get_property CLASS $pin]

      if { "$pinobj_dir" == "O" && "$pinobj_class" == "bd_pin" } {

         if {("$pin_dir"  == "O" && "$pin_class" == "bd_port") ||
             ("$pin_dir"  == "I" && "$pin_class" == "bd_pin")} {
            set endpin $pin
            return $endpin
         }

      } elseif { "$pinobj_dir" == "O" && "$pinobj_class" == "bd_port" } {

         if {("$pin_dir"  == "O" && "$pin_class" == "bd_pin") ||
             ("$pin_dir"  == "I" && "$pin_class" == "bd_port")} {
            set endpin $pin
            return $endpin
         }

      } elseif { "$pinobj_dir" == "I" && "$pinobj_class" == "bd_pin" } {

         if {("$pin_dir"  == "O" && "$pin_class" == "bd_pin") ||
             ("$pin_dir"  == "I" && "$pin_class" == "bd_port")} {
            set endpin $pin
            return $endpin
         }

      } elseif { "$pinobj_dir" == "I" && "$pinobj_class" == "bd_port" } {

         if {("$pin_dir"  == "O" && "$pin_class" == "bd_port") ||
             ("$pin_dir"  == "I" && "$pin_class" == "bd_pin")} {
            set endpin $pin
            return $endpin
         }

      }
   }

   return $endpin
}

############################################################################
proc get_other_end_pin { pinobj } {
   set endpin 0
   #set netobj [get_bd_net -of_object $pinobj]
   #if { 0 != [string length $netobj] && $netobj != 0 } {
   #   set endpin [get_bd_pin -filter {DIR=~O} -of_object $netobj]
   #}
   set srcPins [find_bd_objs -thru_hier -relation connected_to $pinobj]
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

############################################################################
proc append_str { origStr newStr } {
    if { 0 == [string length $origStr] } {
       set origStr $newStr
    } else {
       set origStr "${origStr}:${newStr}"
    }
    return $origStr
}

############################################################################
proc updatePinWidth { ip pinobj outPinWidth } {
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
    set pname_full [get_property NAME $pinobj]
    set paths [split $pname_full /]
    set pname [lindex $paths end]
    set paramName "CONFIG.${pname}_width"
    # puts "set $paramName to $width\n"
    set_property $paramName $width $ip
    # CR804068. read back width again. the propagte width may ignored due to user_strength. 
    set width [get_property $paramName $ip]

    set myOutWidth [expr $outPinWidth + $width]
    return $myOutWidth
}

############################################################################
proc updatePinType { pinobj } {
    set pinType "undef"
    set srcPin [get_other_end_pin $pinobj]
    if { 0 != [string length $srcPin] && $srcPin != 0} {
       set pinType [string tolower [get_property TYPE $srcPin] ]
       if { $pinType == "undef" } {
          set pinType [string tolower [get_property CONFIG.PortType $srcPin]]
       }
       if { 0 != [string length $pinType] && $pinType != "undef" && $pinType != "null" } {
          set_property CONFIG.PortType $pinType $pinobj
          set_property CONFIG.PortType.PROP_SRC false $pinobj
       }
    }
    return $pinType
}

############################################################################
proc updateIntrPin { pinobj senValue priValue } {

    # puts "inside updateIntrPin\n"
    set senStr [get_property CONFIG.SENSITIVITY $pinobj]
    set senList [split $senStr :]
    set width [get_property CONFIG.PortWidth $pinobj]
    if { 0 != [string length $width] && $width != 0 &&  [llength $senList] == 1} {
       set sensitivity [lindex $senList 0]
       for {set i 1} { $i < $width} {incr i}  {
          set senStr [append_str $senStr $sensitivity]
       }
    } 

    set priStr [get_property CONFIG.SUGGESTED_PRIORITY $pinobj]

    if { 0 == [ string length $senStr ] } {
         set senStr "NULL"
    }
    if { 0 == [ string length $priStr ] } {
         set priStr "NULL"
    }

    set senValue [append_str $senValue $senStr]
    set priValue [append_str $priValue $priStr]

    set outValue "${senValue}|${priValue}" 
    return $outValue
}

############################################################################
proc updateClkPin { pinobj freqValue phaseValue } {
    # puts "inside updateClkPin\n"
    set freqStr [get_property CONFIG.FREQ_HZ $pinobj]
    set phaseStr [get_property CONFIG.PHASE $pinobj]

    if { 0 == [ string length $freqStr ] } {
         set freqStr "NULL"
    }
    if { 0 == [ string length $phaseStr ] } {
         set phaseStr "NULL"
    }

    set freqValue [append_str $freqValue $freqStr]
    set phaseValue [append_str $phaseValue $phaseStr]

    set outValue "${freqValue}|${phaseValue}" 
    return $outValue
}

############################################################################
proc updateResetPin { pinobj polValue typeValue } {
    # puts "inside updateResetPin\n"
    set polStr [get_property CONFIG.POLARITY $pinobj]
    set typeStr [get_property CONFIG.TYPE $pinobj]

    if { 0 == [ string length $polStr ] } {
         set polStr "NULL"
    }
    if { 0 == [ string length $typeStr ] } {
         set typeStr "NULL"
    }

    set polValue [append_str $polValue $polStr]
    set typeValue [append_str $typeValue $typeStr]

    set outValue "${polValue}|${typeValue}" 
    return $outValue
}

############################################################################
proc propagate { cellName dictArg } {

    # puts "in ilconcat propagate with cellName is $cellName\n"
    set ip [get_bd_cells $cellName]
    # puts "IP is $ip \n"

    set out_PortType "" 
    set senValue "";    # for Intr Pin
    set priValue "";    # for Intr Pin 
    set freqValue "";   # for Clk pin
    set phaseValue "";  # for Clk pin
    set polValue "";    # for rst pin
    set typeValue "";   # for rst pin
    set diffType 0 

    set outWidth 0
    set doutpin [get_bd_pins $ip/dout]
    set pinList [tcl::lsort -dictionary -decreasing [get_bd_pins $ip/in*]]
    foreach pinname $pinList {
        set pinobj [get_bd_pins $pinname]

        set outWidth [updatePinWidth $ip $pinobj $outWidth]  

        # puts "Before updatePinType $pinobj is $typeStr\n"
        set typeStr [string tolower [get_property CONFIG.PortType $pinobj] ]
        if { 0 == [string length $typeStr] || $typeStr == "undef" } {
           set typeStr [updatePinType $pinobj]
        }
        if { $out_PortType != "" && $out_PortType != $typeStr && $typeStr != "undef" && $typeStr != "" } {
            # puts "current type is $out_PortType, new type is $typeStr\n"
            incr diffType
        } elseif { $out_PortType == "" && $typeStr != "undef" } {
              set out_PortType $typeStr
        }
        # puts "After updatePinType $pinobj is $typeStr\n"

        if { $typeStr == "intr" } {
           set outValue [updateIntrPin $pinobj $senValue $priValue]
           set senAndPrio [split $outValue |]
           set senValue [lindex $senAndPrio 0]
           set priValue [lindex $senAndPrio 1]
        } elseif { $typeStr == "clk" } {
           set outValue [updateClkPin $pinobj $freqValue $phaseValue]
           set freqAndPhase [split $outValue |]
           set freqValue [lindex $freqAndPhase 0]
           set phaseValue [lindex $freqAndPhase 1]
        } elseif { $typeStr == "reset" } {
           set outValue [updateResetPin $pinobj $polValue $typeValue]
           set polAndType [split $outValue |]
           set polValue [lindex $polAndType 0]
           set typeValue [lindex $polAndType 1]
        } elseif { $typeStr == "" || $typeStr == "undef" } {
           set senValue [append_str $senValue "NULL"]           
           set priValue [append_str $priValue "NULL"]           
           set freqValue [append_str $freqValue "NULL"]           
           set phaseValue [append_str $phaseValue "NULL"]           
           set polValue [append_str $polValue "NULL"]           
           set typeValue [append_str $typeValue "NULL"]           
        }
    }


    # puts "set CONFIG.dout_width = $outWidth\n"
    set_property CONFIG.PortWidth $outWidth $doutpin

    if { $diffType > 0 } {
       ::bd::send_msg -of $cellName -type ERROR -msg_id 10 -text "Xlconcat input pins are connected to different type of pins"
       return
    }

    if { $out_PortType == "intr" } {
       set_property CONFIG.SENSITIVITY $senValue $doutpin
       #set_property CONFIG.SUGGESTED_PRIORITY $priValue $doutpin
       set_property CONFIG.PortType intr $doutpin
    } elseif { $out_PortType == "clk" } {
       set_property CONFIG.FREQ_HZ $freqValue $doutpin
       set_property CONFIG.PHASE $phaseValue $doutpin
       set_property CONFIG.PortType clk $doutpin
    } elseif { $out_PortType == "reset" } {
       set_property CONFIG.POLARITY $polValue $doutpin
       set_property CONFIG.TYPE $typeValue $doutpin
       set_property CONFIG.PortType reset $doutpin
    }
}
