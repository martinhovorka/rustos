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
##################################################################################################
# This TCL script is used to do basic project setup and clarify the DRP settings
#
# XAPP888 TCL commands: 
#       xapp888_create_project <> - Basic project setup. Adjust as needed 
#       xapp888_help <>           - Descriptions of added TCL commands 
# 
# XAPP888 TCL DRP Settings:
#       xapp888_drp_settings <CLKFBOUT_MULT>  <DIVCLK_DIVIDE> <PHASE> <HIGH|LOW|high|low> 
#            - Displays & Returns the ordered pairs of DRP addresses & Data
#     
#       xapp888_drp_clkout <DIVIDE>  <Duty Cycle e.g. 0.5> <Phase e.g.11.25> <CLKOUT0 to CLKOUT6>  
#            - Displays & Returns the ordered pairs of DRP addresses & Data
#     
#       xapp888_merge_drp_clkout <list> 
#            - Returns the ordered DRP addresses/data merging fractional address 07 & 13
#
# Revision History:
#       1/15/15 - Added TCL DRP commands
#       3/17/16 - Added min/max duty cycle checks
#
##################################################################################################
namespace eval top_mmcme3 {

#################################################################
# Load and initialize libIp_Clkwiz.
namespace export *
proc xapp888_create_project {} {
    create_project xapp888_ultrascale  -force xapp888_ultrascale -part xcku040-ffva1156-1-c
    add_files -norecurse {mmcme3_drp_func.h mmcme3_drp.v top_mmcme3.v  top_mmcme3.xdc}
    import_files -force -norecurse
    import_files -fileset sim_1 -norecurse {top_mmcme3_tb.v}
    update_compile_order -fileset sim_1
}

proc xapp888_merge_drp {list} {
    set count_07 0
    set merge_07 ""
    set count_13 0
    set merge_13 ""
    set drp_merged ""
    for {set i 0} { $i <= [expr [llength $list]/2] } {incr i} {
        if {[string match [lindex $list [expr $i*2]] 07]} {
            incr count_07; set merge_07 "$merge_07 [lindex $list [expr 2*$i + 1] ]"
        } elseif {[string match [lindex $list [expr $i*2]] 13]} {
            incr count_13; set merge_13 "$merge_13 [lindex $list [expr 2*$i + 1] ]"
        } else {
            set drp_merged "$drp_merged [lindex $list [expr $i * 2]] [lindex $list [expr $i * 2 + 1]]"
        }
    }
    
    if {[llength $merge_07] > 1 } {set drp_07_merged [format %04x [expr 0x[lindex $merge_07 0] | 0x[lindex $merge_07 1]]]} else {set drp_07_merged [lindex $merge_07 0]}
    if {[llength $merge_13] > 1} {set drp_13_merged  [format %04x [expr 0x[lindex $merge_13 0] | 0x[lindex $merge_13 1]]]} else {set drp_13_merged [lindex $merge_13 0]}
    if {$count_07 >2} {
            #puts "ERROR: Too many shared addresses for 07. Only the first 2 terms are being marged. $merge_07"
    } elseif {$count_07 > 0} {
        set drp_merged "$drp_merged  07 $drp_07_merged"
    }
    if {$count_13 >2} {
        #puts "ERROR: Too many shared addresses for 13. Only the first 2 terms are being merged. $merge_13"
    } elseif {$count_13 > 0} {
        set drp_merged "$drp_merged 13 $drp_13_merged"
    }   
    #puts "$list has been changed to $drp_merged" 
    return $drp_merged
}
proc xapp888_drp_clkout_frac {divide phase} {
    set divide_frac [expr fmod($divide, 1)]
    set divide_frac_8ths [scan [expr $divide_frac * 8] %d]
    set divide_int [scan [expr floor($divide)] %d]

    set even_part_high [scan [expr floor($divide_int / 2)] %d]
    set even_part_low $even_part_high
    
    set odd [expr $divide_int - $even_part_high - $even_part_low]
    set odd_and_frac [scan [expr 8 * $odd + $divide_frac_8ths] %d]

    if {$odd_and_frac <=9} {set lt_frac [expr $even_part_high - 1]} else {set lt_frac $even_part_high}
    if {$odd_and_frac <=8} {set ht_frac [expr $even_part_low - 1]} else {set ht_frac $even_part_low}
    
    set pmfall [scan [expr $odd * 4 + floor($divide_frac_8ths / 2)] %d]
    set pmrise 0
    set dt [scan [expr floor($phase * $divide / 360)] %d]
    set pmrise [scan [expr floor( 8 * (($phase * $divide /360 ) - $dt)+ 0.5 )] %d]
    set pmfall [scan [expr $pmfall + $pmrise] %d]

    #puts "Fractional Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "Fractional - Requested phase is: $phase; Actual Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "

    if {$odd_and_frac <=9 && $odd_and_frac >=2 || $divide == 2.125} {set wf_fall 1} else {set wf_fall 0}
    if {$odd_and_frac <=8 && $odd_and_frac >=1} {set wf_rise 1} else {set wf_rise 0}
    
    set dt [scan [expr $dt + floor($pmrise / 8)] %d]
    set pmrise [scan [expr fmod($pmrise , 8)] %d]
    set pmfall [scan [expr fmod($pmfall , 8)] %d]

    set reg1       "[xapp888_dec2bin $pmrise 3]1[xapp888_dec2bin $ht_frac 6][xapp888_dec2bin $lt_frac 6]"
    set reg2       "0[xapp888_dec2bin $divide_frac_8ths 3]1[expr $wf_rise]0000[xapp888_dec2bin $dt 6]"
#For olympus only return 4 bits as the leading 00 was causing problems due to CDDC_EN bits shifting everything
    set regshared  "[xapp888_dec2bin $pmfall 3][expr $wf_fall]"
    
    return "$reg1 $reg2 $regshared "
}

proc xapp888_drp_clkout {divide dutycycle phase clkout} {
    set clkout_lower [string tolower $clkout]
        switch -glob -- $clkout_lower {
            clkout0  {  set daddr_reg1 08
                        set daddr_reg2 09
                        }
            clkout1  {  set daddr_reg1 0A
                        set daddr_reg2 0B
                        }
            clkout2  {  set daddr_reg1 0C
                        set daddr_reg2 0D
                        }
            clkout3  {  set daddr_reg1 0E
                        set daddr_reg2 0F
                        }
            clkout4  {  set daddr_reg1 10
                        set daddr_reg2 11
                        }
            clkout5  {  set daddr_reg1 06
                        set daddr_reg2 07
                        }
            clkout6  {  set daddr_reg1 12
                        set daddr_reg2 13
                        }
    }    
        if {$phase < 0} {set phase [expr 360 + $phase]}
# -------  original ----------------------------
#        set phasecycles [expr int(($divide*$phase)/360)]
#        set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
#        set pmphasecycles [expr int(($pmphase *$divide)/ 45)]

# -------  new ----------------------------
        set phase_in_cycles [expr $phase / 360.0 * $divide]
        set phasecycles_dec [expr (8 * $phase_in_cycles)]
        set phasecycles_int [expr int($phasecycles_dec)]
        set phasecycles_rem [expr ($phasecycles_dec - $phasecycles_int )]
        if {$phasecycles_rem >= 0.5} {set phasecycles_int [expr ($phasecycles_int + 1)]}
        set phasecycles [expr int($phasecycles_int / 8)]
        set pmphasecycles [expr ($phasecycles_int - $phasecycles * 8)]
# ---------------------------------------------------------------------------

    #puts "Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "
        
# Duty cycle stuff        
       if {$divide < 64} {
            set min_dc [expr 1.0 / $divide]
            set max_dc [expr ($divide - 0.5) / $divide]
       } else {
            set min_dc [expr ($divide - 64.0) / $divide]
            set max_dc [expr (64 + 0.5) / $divide]
       }
        if {$dutycycle < $min_dc} {puts "\n\tWARNING: Min duty cycle violation $dutycycle < $min_dc\n\t         Changing dutycycle to $min_dc\n"; set dutycycle $min_dc}
        if {$dutycycle > $max_dc} {puts "\n\tWARNING: Max duty cycle is $dutycycle > $max_dc\n\t         Changing dutycycle to $max_dc\n"; set dutycycle $max_dc}
               
    #puts "Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "
    
#puts "[expr $pmphasecycles * 45 / $divide]"

        set ht [scan [expr int($dutycycle * [expr ($divide ) ])] %d]
    #puts "DEBUG ht is $ht"
        set lt [scan [expr $divide - $ht] %d]
    #puts "DEBUG lt is $lt"
        set even_high [scan [expr $divide / 2] %d]
        set odd [expr $divide - $even_high * 2]

        if {$divide == 1} {
             set drp_reg1 "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
             set drp_reg2 "[xapp888_bin2hex 00000000[expr $odd]1[xapp888_dec2bin $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1-[string toupper $clkout] Register 1" 
             #puts "DADDR_$daddr_reg2: $drp_reg2-[string toupper $clkout] Register 2" 
             return [list "$drp_reg1" "$drp_reg2" "0000"]
        } elseif {[expr fmod($divide,1)] == 0  }  {
             set drp_reg1 "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt]]"
             set drp_reg2 "[xapp888_bin2hex 00000000[expr $odd]0[xapp888_dec2bin $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]" 
             #puts "DADDR_$daddr_reg2: $drp_reg2-[string toupper $clkout] Register 2" 
             return [list "$drp_reg1" "$drp_reg2" "0000"]
        } elseif {[string tolower $clkout] == "clkout0" } {
            set drp_frac_registers [xapp888_drp_clkout_frac $divide $phase ]
            set drp_reg1 [xapp888_bin2hex [lindex $drp_frac_registers 0]]
            set drp_reg2 [xapp888_bin2hex [lindex $drp_frac_registers 1]]
            set drp_regshared [xapp888_bin2hex [lindex $drp_frac_registers 2]000000000000]
            #puts "DADDR_$daddr_reg2: $drp_reg2-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]" 
            #puts "DADDR_$daddr_reg1: $drp_reg1-[string toupper $clkout] Register 2" 
            #puts "DADDR_07: $drp_regshared-[string toupper $clkout] Register Shared with CLKOUT5" 
            return [list "$drp_reg1" "$drp_reg2" "$drp_regshared"]
        }  else {#puts "\nERROR: Fractional divide setting only supported for CLKOUT0. Output clock set to [string toupper $clkout] \n"
    }
}

proc xapp888_drp_calc_m {divide phase} {
    set phasecycles [expr int(($divide*$phase)/360)]
    set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
    set pmphasecycles [scan [expr int(($pmphase *$divide)/ 45)] %d]
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    set odd [expr $lt - $ht]
    set daddr_reg1 14
    set daddr_reg2 15
    set daddr_regshared 13
    if {$divide == 1} {
            set drp_reg1 "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
            set drp_reg2 "[xapp888_bin2hex 00000000[expr $odd]1[xapp888_dec2bin $phasecycles 6] ]"
            #puts "DADDR_$daddr_reg1: $drp_reg1-CLKFBOUT Register 1- "
            #puts "DADDR_$daddr_reg2: $drp_reg2-CLKFBOUT Register 2- "
            return "$drp_reg1 $drp_reg2 $drp_reg2"
    } elseif {[expr fmod($divide,1)] > 0} {
        set drp_frac_registers [xapp888_drp_clkout_frac $divide $phase ]
        set drp_reg1 [xapp888_bin2hex [lindex $drp_frac_registers 0]]
        set drp_reg2 [xapp888_bin2hex [lindex $drp_frac_registers 1]]
#        set drp_regshared [xapp888_bin2hex [lindex $drp_frac_registers 2]0000000000]
set drp_regshared [xapp888_bin2hex [lindex $drp_frac_registers 2]000000000000]
        #puts "DADDR_$daddr_reg1: $drp_reg1-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: $drp_reg2-CLKFBOUT Register 2- "
        #puts "DADDR_$daddr_regshared: $drp_regshared-CLKFBOUT Register Shared with CLKOUT6- "
        return "$drp_reg1 $drp_reg2 $drp_regshared"
    } else {
        #puts "DADDR_$daddr_reg1: [xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt]]-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: [xapp888_bin2hex 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]-CLKFBOUT Register 2- " 
        return "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt]]  [xapp888_bin2hex 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]  [xapp888_bin2hex 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ] "
    }
}

proc xapp888_drp_calc_d {divide} {
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    if {$divide == 1} {
        #puts "DADDR_16: [xapp888_bin2hex 0001000001000001]\t-DIVCLK Register $divide-"
        return "[xapp888_bin2hex 0001000001000001]"

    } else {
        #puts "DADDR_16: [xapp888_bin2hex 0000[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt] ]-DIVCLK Register $divide-" }
        return "[xapp888_bin2hex 0000[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt] ] "
}

proc xapp888_dec2bin4ltht {dec} { 
     binary scan [binary format c $dec] B* bin 
     string range $bin end-5 end  
}

proc xapp888_cpres {div bw} {
    #CP_RES_LFHF
    set div [scan $div %d]
    set bw_lower [string tolower $bw]
    if {$bw_lower == "low" } then {
        switch -glob -- $div {
            1   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            2   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            3   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            4   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            5   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            6   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            7   {set CP 0010 ; set RES 0111 ; set LFHF 11 }
            8   {set CP 0010 ; set RES 0111 ; set LFHF 11 }
            9   {set CP 0010 ; set RES 0111 ; set LFHF 11 }
            10   {set CP 0010 ; set RES 1101 ; set LFHF 11 }
            11   {set CP 0010 ; set RES 1101 ; set LFHF 11 }
            12   {set CP 0010 ; set RES 1101 ; set LFHF 11 }
            13   {set CP 0010 ; set RES 0011 ; set LFHF 11 }
            14   {set CP 0010 ; set RES 0101 ; set LFHF 11 }
            15   {set CP 0010 ; set RES 0101 ; set LFHF 11 }
            16   {set CP 0010 ; set RES 0101 ; set LFHF 11 }
            17   {set CP 0010 ; set RES 1001 ; set LFHF 11 }
            18   {set CP 0010 ; set RES 1001 ; set LFHF 11 }
            19   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            20   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            21   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            22   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            23   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            24   {set CP 0010 ; set RES 1110 ; set LFHF 11 }
            25   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            26   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            27   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            28   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            29   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            30   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            31   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            32   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            33   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            34   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            35   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            36   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            37   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            38   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            39   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            40   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            41   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            42   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            43   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            44   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            45   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            46   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            47   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            48   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            49   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            50   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            51   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            52   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            53   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            54   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            55   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            56   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            57   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            58   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            59   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            60   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            61   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            62   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            63   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            64   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
        }
    } else {
        switch -glob -- $div {
            1   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            2   {set CP 0010 ; set RES 1111 ; set LFHF 11 }
            3   {set CP 0010 ; set RES 1011 ; set LFHF 11 }
            4   {set CP 0011 ; set RES 1111 ; set LFHF 11 }
            5   {set CP 0100 ; set RES 1111 ; set LFHF 11 }
            6   {set CP 0100 ; set RES 1111 ; set LFHF 11 }
            7   {set CP 0101 ; set RES 1111 ; set LFHF 11 }
            8   {set CP 0110 ; set RES 1111 ; set LFHF 11 }
            9   {set CP 0111 ; set RES 1111 ; set LFHF 11 }
            10   {set CP 0111 ; set RES 1111 ; set LFHF 11 }
            11   {set CP 1100 ; set RES 1111 ; set LFHF 11 }
            12   {set CP 1101 ; set RES 1111 ; set LFHF 11 }
            13   {set CP 0001 ; set RES 1111 ; set LFHF 11 }
            14   {set CP 1111 ; set RES 1111 ; set LFHF 11 }
            15   {set CP 1111 ; set RES 1111 ; set LFHF 11 }
            16   {set CP 1110 ; set RES 0111 ; set LFHF 11 }
            17   {set CP 1110 ; set RES 1011 ; set LFHF 11 }
            18   {set CP 1111 ; set RES 0111 ; set LFHF 11 }
            19   {set CP 1111 ; set RES 1011 ; set LFHF 11 }
            20   {set CP 1111 ; set RES 1011 ; set LFHF 11 }
            21   {set CP 1110 ; set RES 1101 ; set LFHF 11 }
            22   {set CP 1111 ; set RES 1101 ; set LFHF 11 }
            23   {set CP 1111 ; set RES 1101 ; set LFHF 11 }
            24   {set CP 1111 ; set RES 0011 ; set LFHF 11 }
            25   {set CP 1111 ; set RES 0011 ; set LFHF 11 }
            26   {set CP 1111 ; set RES 0011 ; set LFHF 11 }
            27   {set CP 1110 ; set RES 0101 ; set LFHF 11 }
            28   {set CP 1110 ; set RES 0101 ; set LFHF 11 }
            29   {set CP 1110 ; set RES 0101 ; set LFHF 11 }
            30   {set CP 1111 ; set RES 0101 ; set LFHF 11 }
            31   {set CP 1111 ; set RES 0101 ; set LFHF 11 }
            32   {set CP 1111 ; set RES 0101 ; set LFHF 11 }
            33   {set CP 1111 ; set RES 1001 ; set LFHF 11 }
            34   {set CP 1111 ; set RES 1001 ; set LFHF 11 }
            35   {set CP 1111 ; set RES 1001 ; set LFHF 11 }
            36   {set CP 1111 ; set RES 1001 ; set LFHF 11 }
            37   {set CP 1111 ; set RES 1001 ; set LFHF 11 }
            38   {set CP 1110 ; set RES 1110 ; set LFHF 11 }
            39   {set CP 1110 ; set RES 1110 ; set LFHF 11 }
            40   {set CP 1110 ; set RES 1110 ; set LFHF 11 }
            41   {set CP 1110 ; set RES 1110 ; set LFHF 11 }
            42   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            43   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            44   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            45   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            46   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            47   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            48   {set CP 1111 ; set RES 1110 ; set LFHF 11 }
            49   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            50   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            51   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            52   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            53   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            54   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            55   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            56   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            57   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            58   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            59   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            60   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            61   {set CP 1100 ; set RES 1010 ; set LFHF 11 }
            62   {set CP 1100 ; set RES 1010 ; set LFHF 11 }
            63   {set CP 1100 ; set RES 1010 ; set LFHF 11 }
            64   {set CP 1100 ; set RES 1010 ; set LFHF 11 }
        }
    }
        #puts "DADDR_4F: [xapp888_bin2hex "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"]-Filter Register 1 M set to $div with $bw bandwidth-"
        #puts "DADDR_4E: [xapp888_bin2hex "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00000000"]-Filter Register 2 M set to $div with $bw bandwidth-" 
        return "[xapp888_bin2hex "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"] [xapp888_bin2hex "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00000000"]"
}

proc xapp888_locking {div} {
        # LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
        set div [scan $div %d]
        switch -glob -- $div {
            1 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            2 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            3 {set LockRefDly 01000 ; set LockFBDly 01000 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            4 {set LockRefDly 01011 ; set LockFBDly 01011 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            5 {set LockRefDly 01110 ; set LockFBDly 01110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            6 {set LockRefDly 10001 ; set LockFBDly 10001 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            7 {set LockRefDly 10011 ; set LockFBDly 10011 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            8 {set LockRefDly 10110 ; set LockFBDly 10110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            9 {set LockRefDly 11001 ; set LockFBDly 11001 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            10 {set LockRefDly 11100 ; set LockFBDly 11100 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            11 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1110000100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            12 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1100111001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            13 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1011101110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            14 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010111100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            15 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010001010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            16 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1001110001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            17 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000111111;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            18 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000100110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            19 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000001101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            20 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111110100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            21 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111011011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            22 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111000010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            23 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110101001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            24 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110010000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            25 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110010000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            26 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101110111;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            27 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101011110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            28 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101011110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            29 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101000101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            30 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101000101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            31 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            32 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            33 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            34 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            35 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            36 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            37 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            38 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            39 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            40 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            41 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            42 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            43 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            44 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            45 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            46 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            47 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            48 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            49 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            50 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            51 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            52 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            53 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            54 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            55 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            56 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            57 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            58 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            59 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            60 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            61 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            62 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            63 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            64 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
         }
#        #puts "debug: $LockRefDly\_$LockFBDly\_$LockCnt\_$LockSatHigh\_$UnlockCnt"
        #puts "DADDR_27: FFFF-Power register leaving all interpolators on - "
        #puts "DADDR_18: [xapp888_bin2hex 000000$LockCnt]-Lock Register 1for M set to $div -"
        #puts "DADDR_19: [xapp888_bin2hex 0$LockFBDly$UnlockCnt]-Lock Register 2 for M set to $div"
        #puts "DADDR_1A: [xapp888_bin2hex 0$LockRefDly$LockSatHigh]-Lock Register 3 for M set to $div"

        return "FFFF [xapp888_bin2hex 000000$LockCnt] [xapp888_bin2hex 0$LockFBDly$UnlockCnt] [xapp888_bin2hex 0$LockRefDly$LockSatHigh]"
}

proc xapp888_bin2hex {bits} {
    set abits ""
    for {set i 0} {$i <= [expr 15 - [string length $bits]] } {incr i} {
        append abits 0}
    append abits "$bits"
    set binValue [binary format B16 $abits]
    binary scan $binValue H4 hex 
    return $hex
    }

proc xapp888_hex2bin {hex} {
    for {set i 0} { $i <= [string length $hex]} { incr i 1} {
        append convert2bin [string map -nocase {
            0 0000 1 0001 2 0010 3 0011 4 0100 5 0101 6 0110 7 0111
            8 1000 9 1001 a 1010 b 1011 c 1100 d 1101 e 1110 f 1111
            } [string index $hex $i ] ]
        }
    return $convert2bin
}

proc xapp888_dec2hex {value} {
   # Creates a 16 bit hex number from a signed decimal number
   # Replace all non-decimal characters
   regsub -all {[^0-9\.\-]} $value {} newtemp
   set value [string trim $newtemp]
   if {$value < 65535 && $value >= 0} {
      set tempvalue [format "%#010X" [expr $value]]
      return [string range $tempvalue 6 9]
   } elseif {$value < 0} {
      #puts "Unsigned value"
      return "0000"
   } else {
      #puts "Violates 16 bit range"
      return "FFFF"
   }
}
proc xapp888_drp_settings {m d phase bw} {
    if {$phase < 0} {set phase [expr 360 + $phase]}
    set data_m [xapp888_drp_calc_m $m $phase]
    set data_d [xapp888_drp_calc_d $d]
    set data_cpres [xapp888_cpres $m $bw]
    set data_locking [xapp888_locking $m]
    return [concat "$data_m" "$data_d" "$data_cpres" "$data_locking"]
}
proc xapp888_dec2bin {dec bits} {
    return [binary scan [binary format I $dec] B32 var;string range $var end-[expr $bits-1] end]
}

proc xapp888_drp_clkout_pll {divide dutycycle phase clkout} {
    set clkout_lower [string tolower $clkout]
        switch -glob -- $clkout_lower {
            clkout0  {  set daddr_reg1 08
                        set daddr_reg2 09
                        }
            clkout1  {  set daddr_reg1 0A
                        set daddr_reg2 0B
                        }
    }
        if {$phase < 0} {set phase [expr 360 + $phase]}
        set phasecycles_float [expr (($divide*$phase)/360)]
        set phasecycles [format %0.f $phasecycles_float]
        set pmphase [expr ($phase - ($phasecycles *360.000)/$divide)]
        set pmphasecycles 0
        
        
    #puts "PLLE3 Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 360.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "
       set dc_step_size [expr  0.5 / $divide]
       if {$divide < 64} {
            set min_dc [expr 1.0 / $divide]
            set max_dc [expr ($divide - 0.5) / $divide]
       } else {
            set min_dc [expr ($divide - 64.0) / $divide]
            set max_dc [expr (64 + 0.5) / $divide]
       }
        if {$dutycycle < $min_dc} {puts "\n\tWARNING: Min duty cycle violation $dutycycle < $min_dc\n\t         Changing dutycycle to $min_dc\n"; set dutycycle $min_dc}
        if {$dutycycle > $max_dc} {puts "\n\tWARNING: Max duty cycle is $dutycycle > $max_dc\n\t         Changing dutycycle to $max_dc\n"; set dutycycle $max_dc}
        set ht [scan [expr int($dutycycle * [expr ($divide ) ])] %d]
        set lt [scan [expr $divide - $ht] %d]
        set even_high [scan [expr $divide / 2] %d]
        set odd [expr $divide - $even_high * 2]

        if {$divide == 1} {
             set drp_reg1 "[xapp888_bin2hex_pll [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
             set drp_reg2 "[xapp888_bin2hex_pll 00000000[expr $odd]1[xapp888_dec2bin_pll $phasecycles 6] ]"
             return "$drp_reg1" "$drp_reg2" "0000"
        } elseif {[expr fmod($divide,1)] == 0  }  {
             set drp_reg1 "[xapp888_bin2hex_pll [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_pll $ht][xapp888_dec2bin4ltht_pll $lt]]"
             set drp_reg2 "[xapp888_bin2hex_pll 00000000[expr $odd]0[xapp888_dec2bin_pll $phasecycles 6] ]"
            # PLLE3 only supports course phase shifts
             return "$drp_reg1" "$drp_reg2" "0000"
        } elseif {[string tolower $clkout] == "clkout0" } {
            set drp_frac_registers [xapp888_drp_clkout_frac $divide $phase ]
            set drp_reg1 [xapp888_bin2hex_pll [lindex $drp_frac_registers 0]]
            set drp_reg2 [xapp888_bin2hex_pll [lindex $drp_frac_registers 1]]
            set drp_regshared [xapp888_bin2hex_pll [lindex $drp_frac_registers 2]0000000000]
            # PLLE3 only supports course phase shifts
            return "$drp_reg1 $drp_reg2 $drp_regshared"
        }  else {#puts "\nERROR: Fractional divide setting only supported for CLKOUT0. Output clock set to [string toupper $clkout] \n"
    }
}

proc xapp888_drp_calc_m_pll {divide phase} {
    set phasecycles [expr int(($divide*$phase)/360)]
    set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
    set pmphasecycles 0

    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    set odd [expr $lt - $ht]
    set daddr_reg1 14
    set daddr_reg2 15
    set daddr_regshared 13
    


    
    if {$divide == 1} {
            set drp_reg1 "[xapp888_bin2hex_pll [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
            set drp_reg2 "[xapp888_bin2hex_pll 00000000[expr $odd]1[xapp888_dec2bin_pll $phasecycles 6] ]"
            #puts "DADDR_$daddr_reg1: $drp_reg1-CLKFBOUT Register 1- "
            #puts "DADDR_$daddr_reg2: $drp_reg2-CLKFBOUT Register 2- "
            return "$drp_reg1 $drp_reg2"
    } else {
        #puts "DADDR_$daddr_reg1: [xapp888_bin2hex_pll [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_pll $ht][xapp888_dec2bin4ltht_pll $lt]]-CLKFBOUT Register 1- Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + (0 * 45.000 / $divide) ] ]"
        #puts "DADDR_$daddr_reg2: [xapp888_bin2hex_pll 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]-CLKFBOUT Register 2- " 
        return "[xapp888_bin2hex_pll [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_pll $ht][xapp888_dec2bin4ltht_pll $lt]] [xapp888_bin2hex_pll 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]"
    }
}


proc xapp888_drp_calc_d_pll {divide} {
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    if {$divide == 1} {
        #puts "DADDR_16: [xapp888_bin2hex 0001000001000001]-DIVCLK Register $divide-"
        return "[xapp888_bin2hex 0001000001000001]"
    } else {
        #puts "DADDR_16: [xapp888_bin2hex 0000[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt] ]-DIVCLK Register $divide-" 
		}
        return "[xapp888_bin2hex 0000[xapp888_dec2bin4ltht $ht][xapp888_dec2bin4ltht $lt] ] "
}

proc xapp888_dec2bin4ltht_pll {dec} { 
     binary scan [binary format c $dec] B* bin 
     string range $bin end-5 end  
}

proc xapp888_cpres_pll {div} {
    #CP_RES_LFHF
    set div [scan $div %d]
        switch -glob -- $div {
            1   {set CP 0010 ; set RES 1111 ; set LFHF 01 }
            2   {set CP 0010 ; set RES 0011 ; set LFHF 11 }
            3   {set CP 0011 ; set RES 0011 ; set LFHF 11 }
            4   {set CP 0010 ; set RES 0001 ; set LFHF 11 }
            5   {set CP 0010 ; set RES 0110 ; set LFHF 11 }
            6   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            7   {set CP 0010 ; set RES 1010 ; set LFHF 11 }
            8   {set CP 0011 ; set RES 0110 ; set LFHF 11 }
            9   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            10   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            11   {set CP 0010 ; set RES 1100 ; set LFHF 11 }
            12   {set CP 0010 ; set RES 0010 ; set LFHF 11 }
            13   {set CP 0011 ; set RES 1100 ; set LFHF 11 }
            14   {set CP 0011 ; set RES 1100 ; set LFHF 11 }
            15   {set CP 0011 ; set RES 1100 ; set LFHF 11 }
            16   {set CP 0011 ; set RES 1100 ; set LFHF 11 }
            17   {set CP 0011 ; set RES 0010 ; set LFHF 11 }
            18   {set CP 0011 ; set RES 0010 ; set LFHF 11 }
            19   {set CP 0011 ; set RES 0010 ; set LFHF 11 }
    }
        #puts "DADDR_4F: [xapp888_bin2hex "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"]-Filter Register 1 M set to $div -"
        #puts "DADDR_4E: [xapp888_bin2hex "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00001000"]-Filter Register 2 M set to $div -" 
        return "[xapp888_bin2hex_pll "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"] [xapp888_bin2hex_pll "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00001000"]"
}

proc xapp888_locking_pll {div} {
        # LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
        set div [scan $div %d]
        switch -glob -- $div {
            1 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            2 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            3 {set LockRefDly 01000 ; set LockFBDly 01000 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            4 {set LockRefDly 01011 ; set LockFBDly 01011 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            5 {set LockRefDly 01110 ; set LockFBDly 01110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            6 {set LockRefDly 10001 ; set LockFBDly 10001 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            7 {set LockRefDly 10011 ; set LockFBDly 10011 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            8 {set LockRefDly 10110 ; set LockFBDly 10110 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            9 {set LockRefDly 11001 ; set LockFBDly 11001 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            10 {set LockRefDly 11100 ; set LockFBDly 11100 ; set LockCnt 1111101000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            11 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1110000100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            12 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1100111001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            13 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1011101110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            14 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010111100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            15 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010001010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            16 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1001110001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            17 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000111111;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            18 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000100110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            19 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000001101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            20 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111110100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            21 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111011011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            22 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111000010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            23 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110101001;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            24 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110010000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            25 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110010000;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            26 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101110111;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            27 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101011110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            28 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101011110;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            29 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101000101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            30 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101000101;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            31 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            32 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            33 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100101100;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            34 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            35 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            36 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100010011;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            37 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            38 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            39 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            40 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            41 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            42 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            43 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            44 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            45 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            46 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            47 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            48 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            49 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            50 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            51 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            52 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            53 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            54 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            55 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            56 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            57 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            58 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            59 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            60 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            61 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            62 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            63 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
            64 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001}
         }
#        #puts "debug: $LockRefDly\_$LockFBDly\_$LockCnt\_$LockSatHigh\_$UnlockCnt"
        #puts "DADDR_18: [xapp888_bin2hex 000000$LockCnt]-Lock Register 1for M set to $div -"
        #puts "DADDR_19: [xapp888_bin2hex 0$LockFBDly$UnlockCnt]-Lock Register 2 for M set to $div"
        #puts "DADDR_1A: [xapp888_bin2hex 0$LockRefDly$LockSatHigh]-Lock Register 3 for M set to $div"

        return "[xapp888_bin2hex_pll 000000$LockCnt] [xapp888_bin2hex_pll 0$LockFBDly$UnlockCnt] [xapp888_bin2hex_pll 0$LockRefDly$LockSatHigh]"
}

proc xapp888_bin2hex_pll {bits} {
    set abits ""
    for {set i 0} {$i <= [expr 15 - [string length $bits]] } {incr i} {
        append abits 0}
    append abits "$bits"
    set binValue [binary format B16 $abits]
    binary scan $binValue H4 hex 
    return $hex
    }

proc xapp888_hex2bin_pll {hex} {
    for {set i 0} { $i <= [string length $hex]} { incr i 1} {
        append convert2bin [string map -nocase {
            0 0000 1 0001 2 0010 3 0011 4 0100 5 0101 6 0110 7 0111
            8 1000 9 1001 a 1010 b 1011 c 1100 d 1101 e 1110 f 1111
            } [string index $hex $i ] ]
        }
    return $convert2bin
}

proc xapp888_dec2hex_pll {value} {
   # Creates a 16 bit hex number from a signed decimal number
   # Replace all non-decimal characters
   regsub -all {[^0-9\.\-]} $value {} newtemp
   set value [string trim $newtemp]
   if {$value < 65535 && $value >= 0} {
      set tempvalue [format "%#010X" [expr $value]]
      return [string range $tempvalue 6 9]
   } elseif {$value < 0} {
      #puts "Unsigned value"
      return "0000"
   } else {
      #puts "Violates 16 bit range"
      return "FFFF"
   }
}
proc xapp888_drp_settings_pll {m d phase } {
    if {$phase < 0} {set phase [expr 360 + $phase]}
    set data_m [xapp888_drp_calc_m_pll $m $phase]
    set data_d [xapp888_drp_calc_d_pll $d]
    set data_cpres [xapp888_cpres_pll $m ]
    set data_locking [xapp888_locking_pll $m]
    return [concat "$data_m $data_d $data_cpres $data_locking"]
}
proc xapp888_dec2bin_pll {dec bits} {
    return [binary scan [binary format I $dec] B32 var;string range $var end-[expr $bits-1] end]
}


proc xapp888_merge_drp_mmcme2 {list} {
    set count_07 0
    set merge_07 ""
    set count_13 0
    set merge_13 ""
    set drp_merged ""
    for {set i 0} { $i <= [expr [llength $list]/2] } {incr i} {
        if {[string match [lindex $list [expr $i*2]] 07]} {
            incr count_07; set merge_07 "$merge_07 [lindex $list [expr 2*$i + 1] ]"
        } elseif {[string match [lindex $list [expr $i*2]] 13]} {
            incr count_13; set merge_13 "$merge_13 [lindex $list [expr 2*$i + 1] ]"
        } else {
            set drp_merged "$drp_merged [lindex $list [expr $i * 2]] [lindex $list [expr $i * 2 + 1]]"
        }
    }
    
    if {[llength $merge_07] > 1 } {set drp_07_merged [format %x [expr 0x[lindex $merge_07 0] | 0x[lindex $merge_07 1]]]} else {set drp_07_merged [lindex $merge_07 0]}
    if {[llength $merge_13] > 1} {set drp_13_merged  [format %x [expr 0x[lindex $merge_13 0] | 0x[lindex $merge_13 1]]]} else {set drp_13_merged [lindex $merge_13 0]}
    if {$count_07 >2} {
            #puts "ERROR: Too many shared addresses for 07. Only the first 2 terms are being marged. $merge_07"
    } elseif {$count_07 > 0} {
        set drp_merged "$drp_merged  07 $drp_07_merged"
    }
    if {$count_13 >2} {
        #puts "ERROR: Too many shared addresses for 13. Only the first 2 terms are being merged. $merge_13"
    } elseif {$count_13 > 0} {
        set drp_merged "$drp_merged 13 $drp_13_merged"
    }   
    #puts "$list has been changed to $drp_merged" 
    return $drp_merged
}
proc xapp888_drp_clkout_frac_mmcme2 {divide phase} {
    set divide_frac [expr fmod($divide, 1)]
    set divide_frac_8ths [scan [expr $divide_frac * 8] %d]
    set divide_int [scan [expr floor($divide)] %d]

    set even_part_high [scan [expr floor($divide_int / 2)] %d]
    set even_part_low $even_part_high
    
    set odd [expr $divide_int - $even_part_high - $even_part_low]
    set odd_and_frac [scan [expr 8 * $odd + $divide_frac_8ths] %d]

    if {$odd_and_frac <=9} {set lt_frac [expr $even_part_high - 1]} else {set lt_frac $even_part_high}
    if {$odd_and_frac <=8} {set ht_frac [expr $even_part_low - 1]} else {set ht_frac $even_part_low}
    
    set pmfall [scan [expr $odd * 4 + floor($divide_frac_8ths / 2)] %d]
    set pmrise 0
    set dt [scan [expr floor($phase * $divide / 360)] %d]
    set pmrise [scan [expr floor( 8 * (($phase * $divide /360 ) - $dt)+ 0.5 )] %d]
    set pmfall [scan [expr $pmfall + $pmrise] %d]

    if {$odd_and_frac <=9 && $odd_and_frac >=2 || $divide == 2.125} {set wf_fall 1} else {set wf_fall 0}
    if {$odd_and_frac <=8 && $odd_and_frac >=1} {set wf_rise 1} else {set wf_rise 0}
    
    set dt [scan [expr $dt + floor($pmrise / 8)] %d]
    set pmrise [scan [expr fmod($pmrise , 8)] %d]
    set pmfall [scan [expr fmod($pmfall , 8)] %d]

    set reg1       "[xapp888_dec2bin_mmcme2 $pmrise 3]1[xapp888_dec2bin_mmcme2 $ht_frac 6][xapp888_dec2bin_mmcme2 $lt_frac 6]"
    set reg2       "0[xapp888_dec2bin_mmcme2 $divide_frac_8ths 3]1[expr $wf_rise]0000[xapp888_dec2bin_mmcme2 $dt 6]"
    set regshared  "00[xapp888_dec2bin_mmcme2 $pmfall 3][expr $wf_fall]"
    
    return "$reg1 $reg2 $regshared "
}

proc xapp888_drp_clkout_mmcme2 {divide dutycycle phase clkout} {
    set clkout_lower [string tolower $clkout]
        switch -glob -- $clkout_lower {
            clkout0  {  set daddr_reg1 08
                        set daddr_reg2 09
                        }
            clkout1  {  set daddr_reg1 0A
                        set daddr_reg2 0B
                        }
            clkout2  {  set daddr_reg1 0C
                        set daddr_reg2 0D
                        }
            clkout3  {  set daddr_reg1 0E
                        set daddr_reg2 0F
                        }
            clkout4  {  set daddr_reg1 10
                        set daddr_reg2 11
                        }
            clkout5  {  set daddr_reg1 06
                        set daddr_reg2 07
                        }
            clkout6  {  set daddr_reg1 12
                        set daddr_reg2 13
                        }
    }    
    
        if {$phase < 0} {set phase [expr 360 + $phase]}
# -------  original ----------------------------
#        set phasecycles [expr int(($divide*$phase)/360)]
#        set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
#        set pmphasecycles [expr int(($pmphase *$divide)/ 45)]

# -------  new ----------------------------
        set phase_in_cycles [expr $phase / 360.0 * $divide]
        set phasecycles_dec [expr (8 * $phase_in_cycles)]
        set phasecycles_int [expr int($phasecycles_dec)]
        set phasecycles_rem [expr ($phasecycles_dec - $phasecycles_int )]
        if {$phasecycles_rem >= 0.5} {set phasecycles_int [expr ($phasecycles_int + 1)]}
        set phasecycles [expr int($phasecycles_int / 8)]
        set pmphasecycles [expr ($phasecycles_int - $phasecycles * 8)]
# --------------------------------------------------------------------------- 

# Duty cycle stuff        
         if {$divide < 64} {
            set min_dc [expr 1.0 / $divide]
            set max_dc [expr ($divide - 0.5) / $divide]
       } else {
            set min_dc [expr ($divide - 64.0) / $divide]
            set max_dc [expr (64 + 0.5) / $divide]
       }
        if {$dutycycle < $min_dc} {set dutycycle $min_dc}
        if {$dutycycle > $max_dc} {set dutycycle $max_dc}


        set ht [scan [expr int($dutycycle * [expr ($divide ) ])] %d]
        set lt [scan [expr $divide - $ht] %d]
        set even_high [scan [expr $divide / 2] %d]
        set odd [expr $divide - $even_high * 2]

        if {$divide == 1} {
             set drp_reg1 "[xapp888_bin2hex_mmcme2 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
             set drp_reg2 "[xapp888_bin2hex_mmcme2 00000000[expr $odd]1[xapp888_dec2bin_mmcme2 $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[expr fmod($divide,1)] == 0  }  {
             set drp_reg1 "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_mmcme2 $ht][xapp888_dec2bin4ltht_mmcme2 $lt]]"
             set drp_reg2 "[xapp888_bin2hex 00000000[expr $odd]0[xapp888_dec2bin_mmcme2 $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[string tolower $clkout] == "clkout0" } {
            set drp_frac_registers [xapp888_drp_clkout_frac_mmcme2 $divide $phase ]
            set drp_reg1 [xapp888_bin2hex [lindex $drp_frac_registers 0]]
            set drp_reg2 [xapp888_bin2hex [lindex $drp_frac_registers 1]]
            set drp_regshared [xapp888_bin2hex [lindex $drp_frac_registers 2]0000000000]
            #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 1" 
            #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 2" 
            #puts "DADDR_07: $drp_regshared\t-[string toupper $clkout] Register Shared with CLKOUT5" 
            return "$drp_reg1 $drp_reg2 $drp_regshared"
        }  else {#puts "\nERROR: Fractional divide setting only supported for CLKOUT0. Output clock set to [string toupper $clkout] \n"
    }
}

proc xapp888_drp_calc_m_mmcme2 {divide phase} {
     set phase_in_cycles [expr $phase / 360.0 * $divide]
     set phasecycles_dec [expr (8 * $phase_in_cycles)]
     set phasecycles_int [expr int($phasecycles_dec)]
     set phasecycles_rem [expr ($phasecycles_dec - $phasecycles_int )]
     if {$phasecycles_rem >= 0.5} {set phasecycles_int [expr ($phasecycles_int + 1)]}
     set phasecycles [expr int($phasecycles_int / 8)]
     set pmphasecycles [expr ($phasecycles_int - $phasecycles * 8)]

    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    set odd [expr $lt - $ht]
    set daddr_reg1 14
    set daddr_reg2 15
    set daddr_regshared 13
    if {$divide == 1} {
            set drp_reg1 "[xapp888_bin2hex_mmcme2 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
            set drp_reg2 "[xapp888_bin2hex_mmcme2 00000000[expr $odd]1[xapp888_dec2bin_mmcme2 $phasecycles 6] ]"
            #puts "DADDR_$daddr_reg1: $drp_reg1\t-CLKFBOUT Register 1- "
            #puts "DADDR_$daddr_reg2: $drp_reg2\t-CLKFBOUT Register 2- "
            return "$drp_reg1 $drp_reg2 $drp_reg2"
    } elseif {[expr fmod($divide,1)] > 0} {
        set drp_frac_registers [xapp888_drp_clkout_frac_mmcme2 $divide $phase ]
        set drp_reg1 [xapp888_bin2hex_mmcme2 [lindex $drp_frac_registers 0]]
        set drp_reg2 [xapp888_bin2hex_mmcme2 [lindex $drp_frac_registers 1]]
        set drp_regshared [xapp888_bin2hex_mmcme2 [lindex $drp_frac_registers 2]0000000000]
        #puts "DADDR_$daddr_reg1: $drp_reg1\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: $drp_reg2\t-CLKFBOUT Register 2- "
        #puts "DADDR_$daddr_regshared: $drp_regshared\t-CLKFBOUT Register Shared with CLKOUT6- "
        return "$drp_reg1 $drp_reg2 $drp_regshared"
    } else {
        #puts "DADDR_$daddr_reg1: [xapp888_bin2hex_mmcme2 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_mmcme2 $ht][xapp888_dec2bin4ltht_mmcme2 $lt]]\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: [xapp888_bin2hex_mmcme2 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]\t-CLKFBOUT Register 2- " 
        return "[xapp888_bin2hex_mmcme2 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_mmcme2 $ht][xapp888_dec2bin4ltht_mmcme2 $lt]] [xapp888_bin2hex_mmcme2 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ] 0000"
    }
}

proc xapp888_drp_calc_d_mmcme2 {divide} {
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    if {$divide == 1} {
        #puts "DADDR_16: [xapp888_bin2hex_mmcme2 0001000001000001]\t-DIVCLK Register $divide-"
        return "[xapp888_bin2hex_mmcme2 0001000001000001]"
    } else {
        #puts "DADDR_16: [xapp888_bin2hex_mmcme2 0000[xapp888_dec2bin4ltht_mmcme2 $ht][xapp888_dec2bin4ltht_mmcme2 $lt] ]\t-DIVCLK Register $divide-" 
		}
        return "[xapp888_bin2hex_mmcme2 0000[xapp888_dec2bin4ltht_mmcme2 $ht][xapp888_dec2bin4ltht_mmcme2 $lt] ] "

}

proc xapp888_dec2bin4ltht_mmcme2 {dec} { 
     binary scan [binary format c $dec] B* bin 
     string range $bin end-5 end  
}

proc xapp888_cpres_mmcme2 {div bw} {
    #CP_RES_LFHF
    set div [scan $div %d]
    set bw_lower [string tolower $bw]
    if {$bw_lower == "low" } then {
        switch -glob -- $div {
            1   {set CP 0010 ; set RES 1111 ; set LFHF 00 }
            2   {set CP 0010 ; set RES 1111 ; set LFHF 00 }
            3   {set CP 0010 ; set RES 1111 ; set LFHF 00 }
            4   {set CP 0010 ; set RES 1111 ; set LFHF 00 }
            5   {set CP 0010 ; set RES 0111 ; set LFHF 00 }
            6   {set CP 0010 ; set RES 1011 ; set LFHF 00 }
            7   {set CP 0010 ; set RES 1101 ; set LFHF 00 }
            8   {set CP 0010 ; set RES 0011 ; set LFHF 00 }
            9   {set CP 0010 ; set RES 0101 ; set LFHF 00 }
            10  {set CP 0010 ; set RES 0101 ; set LFHF 00 }
            11  {set CP 0010 ; set RES 1001 ; set LFHF 00 }
            12  {set CP 0010 ; set RES 1110 ; set LFHF 00 }
            13  {set CP 0010 ; set RES 1110 ; set LFHF 00 }
            14  {set CP 0010 ; set RES 1110 ; set LFHF 00 }
            15  {set CP 0010 ; set RES 1110 ; set LFHF 00 }
            16  {set CP 0010 ; set RES 0001 ; set LFHF 00 }
            17  {set CP 0010 ; set RES 0001 ; set LFHF 00 }
            18  {set CP 0010 ; set RES 0001 ; set LFHF 00 }
            19  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            20  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            21  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            22  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            23  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            24  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            25  {set CP 0010 ; set RES 0110 ; set LFHF 00 }
            26  {set CP 0010 ; set RES 1010 ; set LFHF 00 }
            27  {set CP 0010 ; set RES 1010 ; set LFHF 00 }
            28  {set CP 0010 ; set RES 1010 ; set LFHF 00 }
            29  {set CP 0010 ; set RES 1010 ; set LFHF 00 }
            30  {set CP 0010 ; set RES 1010 ; set LFHF 00 }
            31  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            32  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            33  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            34  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            35  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            36  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            37  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            38  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            39  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            40  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            41  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            42  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            43  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            44  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            45  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            46  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            47  {set CP 0010 ; set RES 1100 ; set LFHF 00 }
            48  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            49  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            50  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            51  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            52  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            53  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            54  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            55  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            56  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            57  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            58  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            59  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            60  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            61  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            62  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            63  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
            64  {set CP 0010 ; set RES 0010 ; set LFHF 00 }
        }
    } else {
        switch -glob -- $div {
            1   {set CP 0010 ; set RES 1111 ; set LFHF 00 }
            2   {set CP 0100 ; set RES 1111 ; set LFHF 00 }
            3   {set CP 0101 ; set RES 1011 ; set LFHF 00 }
            4   {set CP 0111 ; set RES 0111 ; set LFHF 00 }
            5   {set CP 1101 ; set RES 0111 ; set LFHF 00 }
            6   {set CP 1110 ; set RES 1011 ; set LFHF 00 }
            7   {set CP 1110 ; set RES 1101 ; set LFHF 00 }
            8   {set CP 1111 ; set RES 0011 ; set LFHF 00 }
            9   {set CP 1110 ; set RES 0101 ; set LFHF 00 }
            10  {set CP 1111 ; set RES 0101 ; set LFHF 00 }
            11  {set CP 1111 ; set RES 1001 ; set LFHF 00 }
            12  {set CP 1101 ; set RES 0001 ; set LFHF 00 }
            13  {set CP 1111 ; set RES 1001 ; set LFHF 00 }
            14  {set CP 1111 ; set RES 1001 ; set LFHF 00 }
            15  {set CP 1111 ; set RES 1001 ; set LFHF 00 }
            16  {set CP 1111 ; set RES 1001 ; set LFHF 00 }
            17  {set CP 1111 ; set RES 0101 ; set LFHF 00 }
            18  {set CP 1111 ; set RES 0101 ; set LFHF 00 }
            19  {set CP 1100 ; set RES 0001 ; set LFHF 00 }
            20  {set CP 1100 ; set RES 0001 ; set LFHF 00 }
            21  {set CP 1100 ; set RES 0001 ; set LFHF 00 }
            22  {set CP 0101 ; set RES 1100 ; set LFHF 00 }
            23  {set CP 0101 ; set RES 1100 ; set LFHF 00 }
            24  {set CP 0101 ; set RES 1100 ; set LFHF 00 }
            25  {set CP 0101 ; set RES 1100 ; set LFHF 00 }
            26  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            27  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            28  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            29  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            30  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            31  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            32  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            33  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            34  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            35  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            36  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            37  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            38  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            39  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            40  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            41  {set CP 0011 ; set RES 0100 ; set LFHF 00 }
            42  {set CP 0010 ; set RES 1000 ; set LFHF 00 }
            43  {set CP 0010 ; set RES 1000 ; set LFHF 00 }
            44  {set CP 0010 ; set RES 1000 ; set LFHF 00 }
            45  {set CP 0010 ; set RES 1000 ; set LFHF 00 }
            46  {set CP 0010 ; set RES 1000 ; set LFHF 00 }
            47  {set CP 0111 ; set RES 0001 ; set LFHF 00 }
            48  {set CP 0111 ; set RES 0001 ; set LFHF 00 }
            49  {set CP 0100 ; set RES 1100 ; set LFHF 00 }
            50  {set CP 0100 ; set RES 1100 ; set LFHF 00 }
            51  {set CP 0100 ; set RES 1100 ; set LFHF 00 }
            52  {set CP 0100 ; set RES 1100 ; set LFHF 00 }
            53  {set CP 0110 ; set RES 0001 ; set LFHF 00 }
            54  {set CP 0110 ; set RES 0001 ; set LFHF 00 }
            55  {set CP 0101 ; set RES 0110 ; set LFHF 00 }
            56  {set CP 0101 ; set RES 0110 ; set LFHF 00 }
            57  {set CP 0101 ; set RES 0110 ; set LFHF 00 }
            58  {set CP 0010 ; set RES 0100 ; set LFHF 00 }
            59  {set CP 0010 ; set RES 0100 ; set LFHF 00 }
            60  {set CP 0010 ; set RES 0100 ; set LFHF 00 }
            61  {set CP 0010 ; set RES 0100 ; set LFHF 00 }
            62  {set CP 0100 ; set RES 1010 ; set LFHF 00 }
            63  {set CP 0011 ; set RES 1100 ; set LFHF 00 }
            64  {set CP 0011 ; set RES 1100 ; set LFHF 00 }
        }
    }
        #puts "DADDR_4F: [xapp888_bin2hex "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"]\t-Filter Register 1 M set to $div with $bw bandwidth-"
        #puts "DADDR_4E: [xapp888_bin2hex "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00000000"]\t-Filter Register 2 M set to $div with $bw bandwidth-" 
        return "[xapp888_bin2hex_mmcme2 "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"] [xapp888_bin2hex_mmcme2 "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00000000"]"
}

proc xapp888_locking_mmcme2 {div} {
        # LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
        set div [scan $div %d]
        switch -glob -- $div {
            1 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            2 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            3 {set LockRefDly 01000 ; set LockFBDly 01000 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            4 {set LockRefDly 01011 ; set LockFBDly 01011 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            5 {set LockRefDly 01110 ; set LockFBDly 01110 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            6 {set LockRefDly 10001 ; set LockFBDly 10001 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            7 {set LockRefDly 10011 ; set LockFBDly 10011 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            8 {set LockRefDly 10110 ; set LockFBDly 10110 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            9 {set LockRefDly 11001 ; set LockFBDly 11001 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            10 {set LockRefDly 11100 ; set LockFBDly 11100 ; set LockCnt 0111101000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            11 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110000100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            12 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100111001 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            13 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111101110 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            14 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110111100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            15 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0110001010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            16 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0101110001 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            17 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100111111 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            18 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100100110 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            19 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0100001101 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            20 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011110100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            21 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011011011 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            22 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011000010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            23 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0010101001 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            24 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0010010000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            25 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0010010000 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            26 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0001110111 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            27 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0001011110 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            28 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0001011110 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            29 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0001000101 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            30 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0001000101 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            31 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000101100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            32 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000101100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            33 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000101100 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            34 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000010011 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            35 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000010011 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            36 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0000010011 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            37 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            38 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            39 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            40 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            41 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            42 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            43 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            44 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            45 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            46 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            47 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            48 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            49 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            50 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            51 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            52 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            53 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            54 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            55 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            56 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            57 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            58 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            59 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            60 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            61 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            62 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            63 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
            64 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0011111010 ;set LockSatHigh 0111101001 ;set UnlockCnt 0000000001}
         }

        #puts "DADDR_28: FFFF\t-Power register leaving all interpolators on - "
        #puts "DADDR_18: [xapp888_bin2hex_mmcme2 000000$LockCnt]\t-Lock Register 1 for M set to $div -"
        #puts "DADDR_19: [xapp888_bin2hex_mmcme2 0$LockFBDly$UnlockCnt]\t-Lock Register 2 for M set to $div"
        #puts "DADDR_1A: [xapp888_bin2hex_mmcme2 0$LockRefDly$LockSatHigh]\t-Lock Register 3 for M set to $div"

        return "FFFF [xapp888_bin2hex_mmcme2 000000$LockCnt] [xapp888_bin2hex 0$LockFBDly$UnlockCnt] [xapp888_bin2hex 0$LockRefDly$LockSatHigh]"
}

proc xapp888_bin2hex_mmcme2 {bits} {
    set abits ""
    for {set i 0} {$i <= [expr 15 - [string length $bits]] } {incr i} {
        append abits 0}
    append abits "$bits"
    set binValue [binary format B16 $abits]
    binary scan $binValue H4 hex 
    return $hex
    }

proc xapp888_hex2bin_mmcme2 {hex} {
    for {set i 0} { $i <= [string length $hex]} { incr i 1} {
        append convert2bin [xapp888_hex2bin_ [string range $hex $i $i] ]
        }
    return $convert2bin
        
}
proc xapp888_hex2bin__mmcme2 {hex} {
        return [string map -nocase {
            0 0000 1 0001 2 0010 3 0011 4 0100 5 0101 6 0110 7 0111
            8 1000 9 1001 a 1010 b 1011 c 1100 d 1101 e 1110 f 1111
            } $hex ]
        
}

proc xapp888_dec2hex_mmcme2 {value} {
   # Creates a 16 bit hex number from a signed decimal number
   # Replace all non-decimal characters
   regsub -all {[^0-9\.\-]} $value {} newtemp
   set value [string trim $newtemp]
   if {$value < 65535 && $value >= 0} {
      set tempvalue [format "%#010X" [expr $value]]
      return [string range $tempvalue 6 9]
   } elseif {$value < 0} {
      #puts "Unsigned value"
      return "0000"
   } else {
      #puts "Violates 16 bit range"
      return "FFFF"
   }
}
proc xapp888_drp_settings_mmcme2 {m d phase bw} {
    if {$phase < 0} {set phase [expr 360 + $phase]}
    set data_m [xapp888_drp_calc_m_mmcme2 $m $phase]
    set data_d [xapp888_drp_calc_d_mmcme2 $d]
    set data_cpres [xapp888_cpres_mmcme2 $m $bw]
    set data_locking [xapp888_locking_mmcme2 $m]
    return "$data_m $data_d $data_cpres $data_locking"
}

proc xapp888_dec2bin_mmcme2 {dec bits} {return [binary scan [binary format I $dec] B32 var;string range $var end-[expr $bits-1] end]}

proc xapp888_dec2bindt_mmcme2 {dec} {
        return [string map { 0 000 1 001 2 010 3 011 4 100 5 101 6 110 7 111} $dec]
}



proc xapp888_merge_drp_mmcme4 {list} {
    set count_07 0
    set merge_07 ""
    set count_13 0
    set merge_13 ""
    set drp_merged ""
    for {set i 0} { $i <= [expr [llength $list]/2] } {incr i} {
        if {[string match [lindex $list [expr $i*2]] 07]} {
            incr count_07; set merge_07 "$merge_07 [lindex $list [expr 2*$i + 1] ]"
        } elseif {[string match [lindex $list [expr $i*2]] 13]} {
            incr count_13; set merge_13 "$merge_13 [lindex $list [expr 2*$i + 1] ]"
        } else {
            set drp_merged "$drp_merged [lindex $list [expr $i * 2]] [lindex $list [expr $i * 2 + 1]]"
        }
    }
    
    if {[llength $merge_07] > 1 } {set drp_07_merged [format %04x [expr 0x[lindex $merge_07 0] | 0x[lindex $merge_07 1]]]} else {set drp_07_merged [lindex $merge_07 0]}
    if {[llength $merge_13] > 1} {set drp_13_merged  [format %04x [expr 0x[lindex $merge_13 0] | 0x[lindex $merge_13 1]]]} else {set drp_13_merged [lindex $merge_13 0]}
    if {$count_07 >2} {
            #puts "ERROR: Too many shared addresses for 07. Only the first 2 terms are being marged. $merge_07"
    } elseif {$count_07 > 0} {
        set drp_merged "$drp_merged  07 $drp_07_merged"
    }
    if {$count_13 >2} {
        #puts "ERROR: Too many shared addresses for 13. Only the first 2 terms are being merged. $merge_13"
    } elseif {$count_13 > 0} {
        set drp_merged "$drp_merged 13 $drp_13_merged"
    }   
    #puts "$list has been changed to $drp_merged" 
    return $drp_merged
}
proc xapp888_drp_clkout_mmcme4_frac_mmcme4 {divide phase} {
    set divide_frac [expr fmod($divide, 1)]
    set divide_frac_8ths [scan [expr $divide_frac * 8] %d]
    set divide_int [scan [expr floor($divide)] %d]

    set even_part_high [scan [expr floor($divide_int / 2)] %d]
    set even_part_low $even_part_high
    
    set odd [expr $divide_int - $even_part_high - $even_part_low]
    set odd_and_frac [scan [expr 8 * $odd + $divide_frac_8ths] %d]

    if {$odd_and_frac <=9} {set lt_frac [expr $even_part_high - 1]} else {set lt_frac $even_part_high}
    if {$odd_and_frac <=8} {set ht_frac [expr $even_part_low - 1]} else {set ht_frac $even_part_low}
    
    set pmfall [scan [expr $odd * 4 + floor($divide_frac_8ths / 2)] %d]
    set pmrise 0
    set dt [scan [expr floor($phase * $divide / 360)] %d]
    set pmrise [scan [expr floor( 8 * (($phase * $divide /360 ) - $dt)+ 0.5 )] %d]
    set pmfall [scan [expr $pmfall + $pmrise] %d]

    #puts "Fractional Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "Fractional - Requested phase is: $phase; Actual Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "

    if {$odd_and_frac <=9 && $odd_and_frac >=2 || $divide == 2.125} {set wf_fall 1} else {set wf_fall 0}
    if {$odd_and_frac <=8 && $odd_and_frac >=1} {set wf_rise 1} else {set wf_rise 0}
    
    set dt [scan [expr $dt + floor($pmrise / 8)] %d]
    set pmrise [scan [expr fmod($pmrise , 8)] %d]
    set pmfall [scan [expr fmod($pmfall , 8)] %d]

    set reg1       "[xapp888_dec2bin_mmcme4 $pmrise 3]1[xapp888_dec2bin_mmcme4 $ht_frac 6][xapp888_dec2bin_mmcme4 $lt_frac 6]"
    set reg2       "0[xapp888_dec2bin_mmcme4 $divide_frac_8ths 3]1[expr $wf_rise]0000[xapp888_dec2bin_mmcme4 $dt 6]"
#For olympus only return 4 bits as the leading 00 was causing problems due to CDDC_EN bits shifting everything
    set regshared  "[xapp888_dec2bin_mmcme4 $pmfall 3][expr $wf_fall]"
    
    return "$reg1 $reg2 $regshared "
}

proc xapp888_drp_clkout_mmcme4 {divide dutycycle phase clkout} {
    set clkout_lower [string tolower $clkout]
        switch -glob -- $clkout_lower {
            clkout0  {  set daddr_reg1 08
                        set daddr_reg2 09
                        }
            clkout1  {  set daddr_reg1 0A
                        set daddr_reg2 0B
                        }
            clkout2  {  set daddr_reg1 0C
                        set daddr_reg2 0D
                        }
            clkout3  {  set daddr_reg1 0E
                        set daddr_reg2 0F
                        }
            clkout4  {  set daddr_reg1 10
                        set daddr_reg2 11
                        }
            clkout5  {  set daddr_reg1 06
                        set daddr_reg2 07
                        }
            clkout6  {  set daddr_reg1 12
                        set daddr_reg2 13
                        }
    }    
        if {$phase < 0} {set phase [expr 360 + $phase]}
# -------  original ----------------------------
#        set phasecycles [expr int(($divide*$phase)/360)]
#        set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
#        set pmphasecycles [expr int(($pmphase *$divide)/ 45)]

# -------  new ----------------------------
        set phase_in_cycles [expr $phase / 360.0 * $divide]
        set phasecycles_dec [expr (8 * $phase_in_cycles)]
        set phasecycles_int [expr int($phasecycles_dec)]
        set phasecycles_rem [expr ($phasecycles_dec - $phasecycles_int )]
        if {$phasecycles_rem >= 0.5} {set phasecycles_int [expr ($phasecycles_int + 1)]}
        set phasecycles [expr int($phasecycles_int / 8)]
        set pmphasecycles [expr ($phasecycles_int - $phasecycles * 8)]
# ---------------------------------------------------------------------------
        
    #puts "Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 45.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "
    
# Duty cycle stuff        
       if {$divide < 64} {
            set min_dc [expr 1.0 / $divide]
            set max_dc [expr ($divide - 0.5) / $divide]
       } else {
            set min_dc [expr ($divide - 64.0) / $divide]
            set max_dc [expr (64 + 0.5) / $divide]
       }
        if {$dutycycle < $min_dc} {puts "\n\tWARNING: Min duty cycle violation $dutycycle < $min_dc\n\t         Changing dutycycle to $min_dc\n"; set dutycycle $min_dc}
        if {$dutycycle > $max_dc} {puts "\n\tWARNING: Max duty cycle is $dutycycle > $max_dc\n\t         Changing dutycycle to $max_dc\n"; set dutycycle $max_dc}
 
        set ht [scan [expr int($dutycycle * [expr ($divide ) ])] %d]
        set lt [scan [expr $divide - $ht] %d]
        set even_high [scan [expr $divide / 2] %d]
        set odd [expr $divide - $even_high * 2]

        if {$divide == 1} {
             set drp_reg1 "[xapp888_bin2hex [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
             set drp_reg2 "[xapp888_bin2hex 00000000[expr $odd]1[xapp888_dec2bin $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[expr fmod($divide,1)] == 0  }  {
             set drp_reg1 "[xapp888_bin2hex_mmcme4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin_mmcme44ltht_mmcme4 $ht][xapp888_dec2bin_mmcme44ltht_mmcme4 $lt]]"
             set drp_reg2 "[xapp888_bin2hex_mmcme4 00000000[expr $odd]0[xapp888_dec2bin_mmcme4 $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[string tolower $clkout] == "clkout0" } {
            set drp_frac_registers [xapp888_drp_clkout_mmcme4_frac_mmcme4 $divide $phase ]
            set drp_reg1 [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 0]]
            set drp_reg2 [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 1]]
            #       For Olympus, CDDCEN shifts the PM_F/WF_F bits to be 15:12 instead of 13:10
            set drp_regshared [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 2]000000000000]
            #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]" 
            #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 2" 
            #puts "DADDR_07: $drp_regshared\t-[string toupper $clkout] Register Shared with CLKOUT5" 
            return "$drp_reg1 $drp_reg2 $drp_regshared"
        }  else {#puts "\nERROR: Fractional divide setting only supported for CLKOUT0. Output clock set to [string toupper $clkout] \n"
    }
}

proc xapp888_drp_calc_m_mmcme4 {divide phase} {
    set phasecycles [expr int(($divide*$phase)/360)]
    set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
    set pmphasecycles [scan [expr int(($pmphase *$divide)/ 45)] %d]

    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    set odd [expr $lt - $ht]
    set daddr_reg1 14
    set daddr_reg2 15
    set daddr_regshared 13
    if {$divide == 1} {
        set drp_reg1 "[xapp888_bin2hex_mmcme4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
        set drp_reg2 "[xapp888_bin2hex_mmcme4 00000000[expr $odd]1[xapp888_dec2bin_mmcme4 $phasecycles 6] ]"
        #puts "DADDR_$daddr_reg1: $drp_reg1\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: $drp_reg2\t-CLKFBOUT Register 2- "
        #puts " WARNING: M set to 1 is out of legal range"
        return "$drp_reg1 $drp_reg2 0000"
    } elseif {[expr fmod($divide,1)] > 0} {
        set drp_frac_registers [xapp888_drp_clkout_mmcme4_frac_mmcme4 $divide $phase ]
        set drp_reg1 [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 0]]
        set drp_reg2 [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 1]]
#       For Olympus, CDDC_EN shifts the PM_F/WF_F bits to be 15:12 instead of 13:10
        set drp_regshared [xapp888_bin2hex_mmcme4 [lindex $drp_frac_registers 2]000000000000]
        #puts "DADDR_$daddr_reg1: $drp_reg1\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: $drp_reg2\t-CLKFBOUT Register 2- "
        #puts "DADDR_$daddr_regshared: $drp_regshared\t-CLKFBOUT Register Shared with CLKOUT6- "
        return "$drp_reg1 $drp_reg2 $drp_regshared"
    } else {
        #puts "DADDR_$daddr_reg1: [xapp888_bin2hex_mmcme4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin_mmcme44ltht_mmcme4 $ht][xapp888_dec2bin_mmcme44ltht_mmcme4 $lt]]\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: [xapp888_bin2hex_mmcme4 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]\t-CLKFBOUT Register 2- " 
        return "[xapp888_bin2hex_mmcme4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin_mmcme44ltht_mmcme4 $ht][xapp888_dec2bin_mmcme44ltht_mmcme4 $lt]]  [xapp888_bin2hex_mmcme4 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ] 0000"
    }
}

proc xapp888_drp_calc_d_mmcme4 {divide} {
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    if {$divide == 1} {
        #puts "DADDR_16: [xapp888_bin2hex_mmcme4 0001000001000001]\t-DIVCLK Register $divide-"
        return "[xapp888_bin2hex_mmcme4 0001000001000001]"
    } else {
        #puts "DADDR_16: [xapp888_bin2hex_mmcme4 0000[xapp888_dec2bin_mmcme44ltht_mmcme4\
              $ht][xapp888_dec2bin_mmcme44ltht_mmcme4 $lt]]\t-DIVCLK Register $divide-" 
			  }

        return "[xapp888_bin2hex_mmcme4 0000[xapp888_dec2bin_mmcme44ltht_mmcme4 $ht][xapp888_dec2bin_mmcme44ltht_mmcme4 $lt] ] "
}

proc xapp888_dec2bin_mmcme44ltht_mmcme4 {dec} { 
     binary scan [binary format c $dec] B* bin 
     string range $bin end-5 end  
}

proc xapp888_cpres_mmcme4 {div bw} {
    #CP_RES_LFHF
    set div [scan $div %d]
    set bw_lower [string tolower $bw]
    if {$bw_lower == "low" } then {
        switch -glob -- $div {
       	1    {set CP 0011 ; set RES 1111  ; set LFHF 11 }
       	2    {set CP 0011 ; set RES 1111  ; set LFHF 11 }
       	3    {set CP 0011 ; set RES 1101  ; set LFHF 11 }
       	4    {set CP 0011 ; set RES 0101  ; set LFHF 11 }
       	5    {set CP 0011 ; set RES 1001  ; set LFHF 11 }  
       	6    {set CP 0011 ; set RES 1110  ; set LFHF 11 }
       	7    {set CP 0011 ; set RES 1110  ; set LFHF 11 }
       	8    {set CP 0011 ; set RES 0001  ; set LFHF 11 }
       	9    {set CP 0011 ; set RES 0110  ; set LFHF 11 }
       	10   {set CP 0011 ; set RES 0110  ; set LFHF 11 }
       	11   {set CP 0011 ; set RES 0110  ; set LFHF 11 }
       	12   {set CP 0011 ; set RES 1010  ; set LFHF 11 }
       	13   {set CP 0011 ; set RES 1010  ; set LFHF 11 }
       	14   {set CP 0011 ; set RES 1010  ; set LFHF 11 }
       	15   {set CP 0100 ; set RES 0110  ; set LFHF 11 }
       	16   {set CP 0011 ; set RES 1100  ; set LFHF 11 }
       	17   {set CP 1110 ; set RES 0110  ; set LFHF 11 }
       	18   {set CP 1111 ; set RES 0110  ; set LFHF 11 }
       	19   {set CP 1110 ; set RES 1010  ; set LFHF 11 }
       	20   {set CP 1110 ; set RES 1010  ; set LFHF 11 }
       	21   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
       	22   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
       	23   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
       	24   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
       	25   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
       	26   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
       	27   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
       	28   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
       	29   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
       	30   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
       	31   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
       	32   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	33   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	34   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	35   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	36   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	37   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
       	38   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
       	39   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
       	40   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
       	41   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
       	42   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	43   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	44   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	45   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	46   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	47   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	48   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	49   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	50   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	51   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	52   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	53   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	54   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	55   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	56   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	57   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	58   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	59   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	60   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	61   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	62   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
       	63   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	64   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	65   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	66   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	67   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	68   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	69   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	70   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
       	71   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	72   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	73   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	74   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	75   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	76   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	77   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
       	78   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	79   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	80   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	81   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	82   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	83   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	84   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	85   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
       	86   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	87   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	88   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	89   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	90   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	91   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	92   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	93   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	94   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	95   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	96   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	97   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	98   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	99   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	100  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	101  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	102  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	103  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	104  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	105  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	106  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	107  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	108  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	109  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	110  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	111  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	112  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	113  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	114  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	115  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	116  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	117  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	118  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	119  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
       	120  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	121  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	122  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	123  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	124  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	125  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	126  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
       	127  {set CP 1101 ; set RES 1000  ; set LFHF 11 } 
       	128  {set CP 1101 ; set RES 1000  ; set LFHF 11 } 
        }
    } else {
        switch -glob -- $div {
           1    {set CP 0111 ; set RES 1111  ; set LFHF 11 }
           2    {set CP 0111 ; set RES 1111  ; set LFHF 11 }
           3    {set CP 1110 ; set RES 1111  ; set LFHF 11 }
           4    {set CP 1111 ; set RES 1111  ; set LFHF 11 }
           5    {set CP 1111 ; set RES 1011  ; set LFHF 11 }
           6    {set CP 1111 ; set RES 1101  ; set LFHF 11 }
           7    {set CP 1111 ; set RES 0011  ; set LFHF 11 }
           8    {set CP 1110 ; set RES 0101  ; set LFHF 11 }
           9    {set CP 1111 ; set RES 1001  ; set LFHF 11 }
           10   {set CP 1111 ; set RES 1001  ; set LFHF 11 }
           11   {set CP 1110 ; set RES 1110  ; set LFHF 11 }
           12   {set CP 1111 ; set RES 1110  ; set LFHF 11 }
           13   {set CP 1111 ; set RES 0001  ; set LFHF 11 }
           14   {set CP 1111 ; set RES 0001  ; set LFHF 11 }
           15   {set CP 1111 ; set RES 0001  ; set LFHF 11 }
           16   {set CP 1110 ; set RES 0110  ; set LFHF 11 }
           17   {set CP 1110 ; set RES 0110  ; set LFHF 11 }
           18   {set CP 1111 ; set RES 0110  ; set LFHF 11 }
           19   {set CP 1110 ; set RES 1010  ; set LFHF 11 }
           20   {set CP 1110 ; set RES 1010  ; set LFHF 11 }
           21   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
           22   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
           23   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
           24   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
           25   {set CP 1111 ; set RES 1010  ; set LFHF 11 }
           26   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
           27   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
           28   {set CP 1101 ; set RES 1100  ; set LFHF 11 }
           29   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
           30   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
           31   {set CP 1110 ; set RES 1100  ; set LFHF 11 }
           32   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           33   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           34   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           35   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           36   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           37   {set CP 1111 ; set RES 1100  ; set LFHF 11 }
           38   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
           39   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
           40   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
           41   {set CP 1110 ; set RES 0010  ; set LFHF 11 }
           42   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           43   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           44   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           45   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           46   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           47   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           48   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           49   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           50   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           51   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           52   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           53   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           54   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           55   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           56   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           57   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           58   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           59   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           60   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           61   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           62   {set CP 1111 ; set RES 0010  ; set LFHF 11 }
           63   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           64   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           65   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           66   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           67   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           68   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           69   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           70   {set CP 1100 ; set RES 0100  ; set LFHF 11 }
           71   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           72   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           73   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           74   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           75   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           76   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           77   {set CP 1101 ; set RES 0100  ; set LFHF 11 }
           78   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           79   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           80   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           81   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           82   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           83   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           84   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           85   {set CP 1110 ; set RES 0100  ; set LFHF 11 }
           86   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           87   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           88   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           89   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           90   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           91   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           92   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           93   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           94   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           95   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           96   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           97   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           98   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           99   {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           100  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           101  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           102  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           103  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           104  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           105  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           106  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           107  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           108  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           109  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           110  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           111  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           112  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           113  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           114  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           115  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           116  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           117  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           118  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           119  {set CP 1111 ; set RES 0100  ; set LFHF 11 }
           120  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           121  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           122  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           123  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           124  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           125  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           126  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           127  {set CP 1101 ; set RES 1000  ; set LFHF 11 }
           128  {set CP 1101 ; set RES 1000  ; set LFHF 11 }           
       }
    }
        #puts "DADDR_4F: [xapp888_bin2hex_mmcme4 "[string index $RES 0]00[string range \
             $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string \
             index $LFHF 1]0000"]\t-Filter Register 1 M set to $div with $bw bandwidth-"
        #puts "DADDR_4E: [xapp888_bin2hex_mmcme4 "[string index $CP 0]00[string range \
             $CP 1 2]00[string index $CP 3]00000000"]\t-Filter Register 2 M \
             set to $div with $bw bandwidth-" 
        return "[xapp888_bin2hex_mmcme4 "[string index $RES 0]00[string range \
               $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string\
               index $LFHF 1]0000"] [xapp888_bin2hex_mmcme4 "[string index \
               $CP 0]00[string range $CP 1 2]00[string index $CP 3]00000000"]"
}

proc xapp888_locking_mmcme4 {div} {
        # LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
        set div [scan $div %d]
        switch -glob -- $div {
            1 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            2 {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            3 {set LockRefDly 01000 ; set LockFBDly 01000 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            4 {set LockRefDly 01011 ; set LockFBDly 01011 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            5 {set LockRefDly 01110 ; set LockFBDly 01110 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            6 {set LockRefDly 10001 ; set LockFBDly 10001 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            7 {set LockRefDly 10011 ; set LockFBDly 10011 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            8 {set LockRefDly 10110 ; set LockFBDly 10110 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            9 {set LockRefDly 11001 ; set LockFBDly 11001 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            10 {set LockRefDly 11100 ; set LockFBDly 11100 ; set LockCnt  1111101000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            11 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1110000100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            12 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1100111001 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            13 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1011101110 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            14 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1010111100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            15 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1010001010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            16 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1001110001 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            17 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1000111111 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            18 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1000100110 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            19 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  1000001101 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            20 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0111110100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            21 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0111011011 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            22 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0111000010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            23 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0110101001 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            24 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0110010000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            25 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0110010000 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            26 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0101110111 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            27 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0101011110 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            28 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0101011110 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            29 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0101000101 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            30 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0101000101 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            31 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100101100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            32 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100101100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            33 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100101100 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            34 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100010011 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            35 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100010011 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            36 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0100010011 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            37 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            38 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            39 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            40 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            41 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            42 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            43 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            44 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            45 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            46 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            47 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            48 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            49 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            50 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            51 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            52 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            53 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            54 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            55 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            56 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            57 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            58 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            59 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            60 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            61 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            62 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            63 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            64 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            65 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            66 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            67 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            68 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            69 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            70 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            71 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001} 
            72 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            73 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            74 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            75 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            76 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            77 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            78 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            79 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            80 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            81 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            82 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            83 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            84 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            85 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            86 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            87 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            88 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            89 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            90 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            91 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            92 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            93 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            94 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            95 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            96 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            97 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            98 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            99 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            100 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            101 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            102 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            103 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            104 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            105 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            106 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            107 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            108 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}                                                                    
            109 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            110 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            111 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            112 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            113 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            114 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            115 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            116 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            117 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            118 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            119 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            120 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}                                                                    
            121 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            122 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            123 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            124 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            125 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            126 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            127 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}
            128 {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt  0011111010 ; set LockSatHigh 1111101001 ; set UnlockCnt 0000000001}         
         }
        #puts "debug: $LockRefDly\_$LockFBDly\_$LockCnt\_$LockSatHigh\_$UnlockCnt"
        #puts "DADDR_27: FFFF\t-Power register leaving all interpolators on - "
        #puts "DADDR_18: [xapp888_bin2hex_mmcme4 000000$LockCnt]\t-Lock Register 1 for M set to $div -"
        #puts "DADDR_19: [xapp888_bin2hex_mmcme4 0$LockFBDly$UnlockCnt]\t-Lock Register 2 for M set to $div"
        #puts "DADDR_1A: [xapp888_bin2hex_mmcme4 0$LockRefDly$LockSatHigh]\t-Lock Register 3 for M set to $div"

        return "FFFF [xapp888_bin2hex_mmcme4 000000$LockCnt] [xapp888_bin2hex_mmcme4 0$LockFBDly$UnlockCnt] [xapp888_bin2hex_mmcme4 0$LockRefDly$LockSatHigh]"
}

proc xapp888_bin2hex_mmcme4 {bits} {
    set abits ""
    for {set i 0} {$i <= [expr 15 - [string length $bits]] } {incr i} {
        append abits 0}
    append abits "$bits"
    set binValue [binary format B16 $abits]
    binary scan $binValue H4 hex 
    return $hex
    }

proc xapp888_hex2bin_mmcme4 {hex} {
    for {set i 0} { $i <= [string length $hex]} { incr i 1} {
        append convert2bin [string map -nocase {
            0 0000 1 0001 2 0010 3 0011 4 0100 5 0101 6 0110 7 0111
            8 1000 9 1001 a 1010 b 1011 c 1100 d 1101 e 1110 f 1111
            } [string index $hex $i ] ]
        }
    return $convert2bin
}

proc xapp888_dec2hex_mmcme4 {value} {
   # Creates a 16 bit hex number from a signed decimal number
   # Replace all non-decimal characters
   regsub -all {[^0-9\.\-]} $value {} newtemp
   set value [string trim $newtemp]
   if {$value < 65535 && $value >= 0} {
      set tempvalue [format "%#010X" [expr $value]]
      return [string range $tempvalue 6 9]
   } elseif {$value < 0} {
      #puts "Unsigned value"
      return "0000"
   } else {
      #puts "Violates 16 bit range"
      return "FFFF"
   }
}
proc xapp888_drp_settings_mmcme4 {m d phase bw} {
    if {$phase < 0} {set phase [expr 360 + $phase]}
    set data_m [xapp888_drp_calc_m_mmcme4 $m $phase]
    set data_d [xapp888_drp_calc_d_mmcme4 $d]
    set data_cpres [xapp888_cpres_mmcme4 $m $bw]
    set data_locking [xapp888_locking_mmcme4 $m]
    return "$data_m $data_d $data_cpres $data_locking"
}
proc xapp888_dec2bin_mmcme4 {dec bits} {
    return [binary scan [binary format I $dec] B32 var;string range $var end-[expr $bits-1] end]
}

proc xapp888_drp_clkout_plle4 {divide dutycycle phase clkout} {
    set clkout_lower [string tolower $clkout]
        switch -glob -- $clkout_lower {
            clkout0  {  set daddr_reg1 08
                        set daddr_reg2 09
                        }
            clkout1  {  set daddr_reg1 0A
                        set daddr_reg2 0B
                        }
    }    
        if {$phase < 0} {set phase [expr 360 + $phase]}
        set phasecycles_float [expr (($divide*$phase)/360)]
        set phasecycles [format %0.f $phasecycles_float]
        set pmphase [expr ($phase - ($phasecycles *360.000)/$divide)]
        set pmphasecycles 0
        
        
    #puts "PLLE4 Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 360.000/$divide ]  ];  "
    #puts "DT will be $phasecycles, PM will be $pmphasecycles"
    #puts "Phase will be shifted by VCO period * $phasecycles.[expr 1000*$pmphasecycles / 8]"
    #puts "Phase will be shifted by [format %f [expr $phasecycles * 360.000 / $divide]] + [format %f  [expr $pmphasecycles * 45.000 / $divide]] = [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ]"
    #puts "Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + ($pmphasecycles * 45.000 / $divide) ] ];  "
    
       if {$divide < 64} {
            set min_dc [expr 1.0 / $divide]
            set max_dc [expr ($divide - 0.5) / $divide]
       } else {
            set min_dc [expr ($divide - 64.0) / $divide]
            set max_dc [expr (64 + 0.5) / $divide]
       }
        if {$dutycycle < $min_dc} {puts "\n\tWARNING: Min duty cycle violation $dutycycle < $min_dc\n\t         Changing dutycycle to $min_dc\n"; set dutycycle $min_dc}
        if {$dutycycle > $max_dc} {puts "\n\tWARNING: Max duty cycle is $dutycycle > $max_dc\n\t         Changing dutycycle to $max_dc\n"; set dutycycle $max_dc}

        set ht [scan [expr int($dutycycle * [expr ($divide ) ])] %d]
        set lt [scan [expr $divide - $ht] %d]
        set even_high [scan [expr $divide / 2] %d]
        set odd [expr $divide - $even_high * 2]

        if {$divide == 1} {
             set drp_reg1 "[xapp888_bin2hex_plle4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
             set drp_reg2 "[xapp888_bin2hex_plle4 00000000[expr $odd]1[xapp888_dec2bin_plle4 $phasecycles 6] ]"
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[expr fmod($divide,1)] == 0  }  {
             set drp_reg1 "[xapp888_bin2hex_plle4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_plle4 $ht][xapp888_dec2bin4ltht_plle4 $lt]]"
             set drp_reg2 "[xapp888_bin2hex_plle4 00000000[expr $odd]0[xapp888_dec2bin_plle4 $phasecycles 6] ]"
            # PLLE4 only supports course phase shifts
             #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + (0 * 45.000 / $divide) ] ]" 
             #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 2" 
             return "$drp_reg1 $drp_reg2 0000"
        } elseif {[string tolower $clkout] == "clkout0" } {
            set drp_frac_registers [xapp888_drp_clkout_plle4_frac $divide $phase ]
            set drp_reg1 [xapp888_bin2hex_plle4 [lindex $drp_frac_registers 0]]
            set drp_reg2 [xapp888_bin2hex_plle4 [lindex $drp_frac_registers 1]]
            set drp_regshared [xapp888_bin2hex_plle4 [lindex $drp_frac_registers 2]0000000000]
            # PLLE4 only supports course phase shifts
            #puts "DADDR_$daddr_reg2: $drp_reg2\t-[string toupper $clkout] Register 1: Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + (0 * 45.000 / $divide) ] ]" 
            #puts "DADDR_$daddr_reg1: $drp_reg1\t-[string toupper $clkout] Register 2" 
            #puts "DADDR_07: $drp_regshared\t-[string toupper $clkout] Register Shared with CLKOUT5" 
            return "$drp_reg1 $drp_reg2 $drp_regshared"
        }  else {#puts "\nERROR: Fractional divide setting only supported for CLKOUT0. Output clock set to [string toupper $clkout] \n"
    }
}

proc xapp888_drp_calc_m_plle4 {divide phase} {
    set phasecycles [expr int(($divide*$phase)/360)]
    set pmphase [expr ($phase - ($phasecycles *360)/$divide)]
    set pmphasecycles 0

    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    set odd [expr $lt - $ht]
    set daddr_reg1 14
    set daddr_reg2 15
    set daddr_regshared 13
    
#puts "PLLE4 Requested phase is: $phase; Given divide=$divide then phase increments in [format %f [expr 360.000/$divide ]  ];  "

    if {$divide == 1} {
        set drp_reg1 "[xapp888_bin2hex_plle4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1000001000001]"
        set drp_reg2 "[xapp888_bin2hex_plle4 00000000[expr $odd]1[xapp888_dec2bin_plle4 $phasecycles 6] ]"
        #puts "DADDR_$daddr_reg1: $drp_reg1\t-CLKFBOUT Register 1- "
        #puts "DADDR_$daddr_reg2: $drp_reg2\t-CLKFBOUT Register 2- "
        #puts " WARNING: M set to 1 is out of legal range"
        return "$drp_reg1 $drp_reg2"
    } else {
        #puts "DADDR_$daddr_reg1: [xapp888_bin2hex_plle4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_plle4 $ht][xapp888_dec2bin4ltht_plle4 $lt]]\t-CLKFBOUT Register 1- Requested Phase is: $phase; Actual: [format %f [expr ( $phasecycles * 360.000 / $divide) + (0 * 45.000 / $divide) ] ]"
        #puts "DADDR_$daddr_reg2: [xapp888_bin2hex_plle4 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]\t-CLKFBOUT Register 2- " 
        return "[xapp888_bin2hex_plle4 [binary scan [binary format I $pmphasecycles] B32 var;string range $var end-2 end]1[xapp888_dec2bin4ltht_plle4 $ht][xapp888_dec2bin4ltht_plle4 $lt]]  [xapp888_bin2hex_plle4 00000000[expr $odd]0[binary scan [binary format I $phasecycles] B32 var;string range $var end-5 end] ]"
    }
}


proc xapp888_drp_calc_d_plle4 {divide} {
    set ht [scan [expr ($divide ) / 2] %d]
    set lt [scan [expr $divide - $ht] %d]
    if {$divide == 1} {
        #puts "DADDR_16: [xapp888_bin2hex_plle4 0001000001000001]\t-DIVCLK Register $divide-"
        return "[xapp888_bin2hex_plle4 0001000001000001]"
    } else {
        #puts "DADDR_16: [xapp888_bin2hex_plle4 0000[xapp888_dec2bin4ltht_plle4 $ht][xapp888_dec2bin4ltht_plle4 $lt] ]\t-DIVCLK Register $divide-" 
		}
        return "[xapp888_bin2hex_plle4 0000[xapp888_dec2bin4ltht_plle4 $ht][xapp888_dec2bin4ltht_plle4 $lt] ] "
}

proc xapp888_dec2bin4ltht_plle4 {dec} { 
     binary scan [binary format c $dec] B* bin 
     string range $bin end-5 end  
}

proc xapp888_cpres_plle4 {div} {
    #CP_RES_LFHF
    set div [scan $div %d]
        switch -glob -- $div {
            1   {set CP 0011 ; set RES 0111 ; set LFHF 11 }
            2   {set CP 0011 ; set RES 0111 ; set LFHF 11 }
            3   {set CP 0011 ; set RES 0011 ; set LFHF 11 }
            4   {set CP 0011 ; set RES 1001 ; set LFHF 11 }
            5   {set CP 0011 ; set RES 0001 ; set LFHF 11 }
            6   {set CP 0100 ; set RES 1110 ; set LFHF 11 }
            7   {set CP 0011 ; set RES 0110 ; set LFHF 11 }
            8   {set CP 0011 ; set RES 1010 ; set LFHF 11 }
            9   {set CP 0111 ; set RES 1001 ; set LFHF 11 }
            10   {set CP 0111 ; set RES 1001 ; set LFHF 11 }
            11   {set CP 0101 ; set RES 0110 ; set LFHF 11 }
            12   {set CP 1100 ; set RES 0101 ; set LFHF 11 }
            13   {set CP 0101 ; set RES 1010 ; set LFHF 11 }
            14   {set CP 0110 ; set RES 0110 ; set LFHF 11 }
            15   {set CP 0110 ; set RES 1010 ; set LFHF 11 }
            16   {set CP 0111 ; set RES 0110 ; set LFHF 11 }
            17   {set CP 1111 ; set RES 0101 ; set LFHF 11 }
            18   {set CP 1100 ; set RES 0110 ; set LFHF 11 }
            19   {set CP 1110 ; set RES 0001 ; set LFHF 11 }
            20   {set CP 1101 ; set RES 0110 ; set LFHF 11 }
            21   {set CP 1111 ; set RES 0001 ; set LFHF 11 }
    }
        #puts "DADDR_4F: [xapp888_bin2hex_plle4 "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"]\t-Filter Register 1 M set to $div -"

        #puts "DADDR_4E: [xapp888_bin2hex_plle4 "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00001000"]\t-Filter Register 2 M set to $div -" 

        return "[xapp888_bin2hex_plle4 "[string index $RES 0]00[string range $RES 1 2]00[string index $RES 3][string index $LFHF 0]00[string index $LFHF 1]0000"] [xapp888_bin2hex_plle4 "[string index $CP 0]00[string range $CP 1 2]00[string index $CP 3]00001000"]"
}

proc xapp888_locking_plle4 {div} {
        # LockRefDly_LockFBDly_LockCnt_LockSatHigh_UnlockCnt
        set div [scan $div %d]
        switch -glob -- $div {
1        {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001}
2         {set LockRefDly 00110 ; set LockFBDly 00110 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 3        {set LockRefDly 01000 ; set LockFBDly 01000 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 4       {set LockRefDly 01011 ; set LockFBDly 01011 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 5       {set LockRefDly 01110 ; set LockFBDly 01110 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 6        {set LockRefDly 10001 ; set LockFBDly 10001 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 7        {set LockRefDly 10011 ; set LockFBDly 10011 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
8         {set LockRefDly 10110 ; set LockFBDly 10110 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
9         {set LockRefDly 11001 ; set LockFBDly 11001 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
10        {set LockRefDly 11100 ; set LockFBDly 11100 ; set LockCnt 1111101000 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
11         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1110000100 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 12        {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1100111001 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
 13        {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1011101110 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
14         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010111100 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
15         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1010001010 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
16         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1001110001 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
17         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000111111 ;set LockSatHigh 1111101001 ;set UnlockCnt 0000000001} 
 18        {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000100110 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
19         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 1000001101 ;set LockSatHigh  1111101001;set UnlockCnt 0000000001} 
20         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111110100 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001} 
21         {set LockRefDly 11111 ; set LockFBDly 11111 ; set LockCnt 0111011011 ;set LockSatHigh 1111101001;set UnlockCnt 0000000001}
      }
#        #puts "debug: $LockRefDly\_$LockFBDly\_$LockCnt\_$LockSatHigh\_$UnlockCnt"
        #puts "DADDR_18: [xapp888_bin2hex_plle4 000000$LockCnt]\t-Lock Register 1 for M set to $div -"
        #puts "DADDR_19: [xapp888_bin2hex_plle4 0$LockFBDly$UnlockCnt]\t-Lock Register 2 for M set to $div"
        #puts "DADDR_1A: [xapp888_bin2hex_plle4 0$LockRefDly$LockSatHigh]\t-Lock Register 3 for M set to $div"
        return "[xapp888_bin2hex_plle4 000000$LockCnt] [xapp888_bin2hex_plle4 0$LockFBDly$UnlockCnt] [xapp888_bin2hex_plle4 0$LockRefDly$LockSatHigh]"
}

proc xapp888_bin2hex_plle4 {bits} {
    set abits ""
    for {set i 0} {$i <= [expr 15 - [string length $bits]] } {incr i} {
        append abits 0}
    append abits "$bits"
    set binValue [binary format B16 $abits]
    binary scan $binValue H4 hex 
    return $hex
    }

proc xapp888_hex2bin_plle4 {hex} {
    for {set i 0} { $i <= [string length $hex]} { incr i 1} {
        append convert2bin [string map -nocase {
            0 0000 1 0001 2 0010 3 0011 4 0100 5 0101 6 0110 7 0111
            8 1000 9 1001 a 1010 b 1011 c 1100 d 1101 e 1110 f 1111
            } [string index $hex $i ] ]
        }
    return $convert2bin
}

proc xapp888_dec2hex_plle4 {value} {
   # Creates a 16 bit hex number from a signed decimal number
   # Replace all non-decimal characters
   regsub -all {[^0-9\.\-]} $value {} newtemp
   set value [string trim $newtemp]
   if {$value < 65535 && $value >= 0} {
      set tempvalue [format "%#010X" [expr $value]]
      return [string range $tempvalue 6 9]
   } elseif {$value < 0} {
      #puts "Unsigned value"
      return "0000"
   } else {
      #puts "Violates 16 bit range"
      return "FFFF"
   }
}
proc xapp888_drp_settings_plle4 {m d phase } {
    if {$phase < 0} {set phase [expr 360 + $phase]}
    if {$m > 21} {#puts "M value out of range. Greater than 21"; return
	}
    set data_m [xapp888_drp_calc_m_plle4 $m $phase]
    if {$d > 15} {#puts "D value out of range. Greater than 15"; return
	}
    set data_d [xapp888_drp_calc_d_plle4 $d]
    set data_cpres [xapp888_cpres_plle4 $m ]
    set data_locking [xapp888_locking_plle4 $m]
    return "$data_m $data_d $data_cpres $data_locking"
}
proc xapp888_dec2bin_plle4 {dec bits} {
    return [binary scan [binary format I $dec] B32 var;string range $var end-[expr $bits-1] end]
}


proc xapp888_help {} {
    #puts "\n\n   -------------------------------------------------------------------------------------\
    \n   NOTES:\n   The following TCL commands are being added to give example calculations\
    \n   for drp programming values for MMCME2 (7 series). For other architectures care\
    \n   should be taken due to VCO and programming addresses. This script can be altered\
    \n   to adjust for those differences but exact settings should be reviewed.\
    \n\n   Also please note that this is a subset of the full programming options.\
    \n   Fine phase shifting and dynamic phase shifting is not directly supported by\
    \n   these scripts.\
    \n\n      xapp888_drp_settings <CLKFBOUT_MULT>  <DIVCLK_DIVIDE> <PHASE> <HIGH|LOW|high|low>\
    \n      xapp888_drp_clkout <DIVIDE>  <Duty Cycle e.g. 0.5> <Phase e.g.11.25> <CLKOUT0 to CLKOUT6> \
    \n      xapp888_help <> 
    \n\n   For Example:\
    \n   xapp888_drp_settings <m> <d> <phase> <bw>;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout0;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout1;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout2;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout3;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout4;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout5;\
    \n   xapp888_drp_clkout <div> <dc> <phase> clkout6;\
    \n\n   To show how to use the xapp888_merg_drp command the following is an arbitrary example"
    #puts {          set drp "[xapp888_drp_settings 2.125 2 0 high]"}
    #puts {          set drp "$drp [xapp888_drp_clkout 3.75 0.5 90 clkout0]"}
    #puts {          for {set i 1} {$i <= 6} {incr i} {set drp "$drp [xapp888_drp_clkout 7 0.5 90 clkout$i]"} }
    #puts {          xapp888_merge_drp $drp}
    #puts "   -------------------------------------------------------------------------------------"
}

}

