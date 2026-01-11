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
proc init { cellpath otherInfo } {
  set ip [get_bd_cells $cellpath]
#  bd::mark_propagate_overrideable $ip {RESET_TYPE}
  bd::mark_propagate_overrideable $ip {PRIM_IN_FREQ}
  bd::mark_propagate_overrideable $ip {SECONDARY_IN_FREQ}
}

#######
proc post_config_ip {cellpath otherInfo} {
# Any updates to interface properties based on user configuration
  set ip [get_bd_cells $cellpath]

  # define the clk pin objects and if object is expected to exist or not
  # use lindex $clkout_used 4 to see if clkout4 is used or not,
  # use lindex $clkout_objs 4 to get the bd pin object (it will be {} if not used)

  # nothing at index == 0
  set clkout_used [list false ]
  set clkout_objs [list {} ]

  for {set index 1} {$index < 8} {incr index} {
    set exist_config_name "CONFIG.CLKOUT${index}_USED"
    set pin_config_name "CONFIG.CLK_OUT${index}_PORT"

    set is_used true
    if {$index > 1} {
       set is_used [get_property $exist_config_name $ip] 
    }
    lappend clkout_used $is_used
    set out_pin_obj {}
    if { $is_used == true } {
      set out_pin_obj [get_bd_pins $ip/[get_property $pin_config_name $ip]]
    }
    lappend clkout_objs $out_pin_obj
  }

  if {  [get_property CONFIG.PRIM_SOURCE $ip] == "Differential_clock_capable_pin" } {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
     if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] == "USER" } {
        set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip])] [get_bd_intf_pins $ip/CLK_IN1_D]
     } else {
        set_property CONFIG.FREQ_HZ.VALUE_SRC DEFAULT [get_bd_intf_pins $ip/CLK_IN1_D]
     }
     }
     #set clkin1_phase [get_property CONFIG.PHASE  [get_bd_intf_pins $ip/CLK_IN1_D]]
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
     set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip])] [lindex $clkout_objs 1]
     }
     
     if { [lindex $clkout_used 2] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip])] [lindex $clkout_objs 2]
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 3] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip])] [lindex $clkout_objs 3]
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 4] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip])] [lindex $clkout_objs 4]
     }
     if { [lindex $clkout_used 5] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip])] [lindex $clkout_objs 5]
     }
     if { [lindex $clkout_used 6] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip])] [lindex $clkout_objs 6]
     }
     if { [lindex $clkout_used 7] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip])] [lindex $clkout_objs 7]
     }
  } else {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
        if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] == "USER" } {
           set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip])] [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]
        } else {
              set_property CONFIG.FREQ_HZ.VALUE_SRC DEFAULT [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]
        }
     }
        if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
        } else {
     set clkin1_phase [get_property CONFIG.PHASE  [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
     set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 1]
     }

     if { [lindex $clkout_used 2] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 2]
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 3] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 3]
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 4] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 4]
     }
     if { [lindex $clkout_used 5] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 5]
     }
     if { [lindex $clkout_used 6] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 6]
     }
     if { [lindex $clkout_used 7] == true } {
        set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 7]
     }
}
  
  if { [get_property CONFIG.USE_INCLK_SWITCHOVER $ip] == true } {
     if { [get_property CONFIG.SECONDARY_SOURCE $ip] == "Differential_clock_capable_pin" } {
        if { [get_property CONFIG.SECONDARY_IN_FREQ.VALUE_SRC $ip] == "USER" } {
           set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip])] [get_bd_intf_pins $ip/CLK_IN2_D]
        } else {
           set_property CONFIG.FREQ_HZ.VALUE_SRC DEFAULT [get_bd_intf_pins $ip/CLK_IN2_D]
        }
     } else {
        if { [get_property CONFIG.SECONDARY_IN_FREQ.VALUE_SRC $ip] == "USER" } {
           set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip])] [get_bd_pins $ip/clk_in2]
        } else {
           set_property CONFIG.FREQ_HZ.VALUE_SRC DEFAULT [get_bd_pins $ip/clk_in2]
        }
     }
  }
  
  if {[get_property CONFIG.USE_PHASE_ALIGNMENT $ip] == true } { 
  if { [get_property CONFIG.PRIM_SOURCE $ip] == "Differential_clock_capable_pin" } {
     set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
     set clk_domain_ctrl [get_param bd.enableClkDomainControl]
     if { [lindex $clkout_used 2] == true } {
        set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } else {
           bd::send_msg -of $cellpath -type WARNING -msg_id 1 -text  " CLK_DOMAIN ($clk_domain_2) of pin [lindex $clkout_objs 2] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock."
        }
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 3] == true } {
                set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } else {
            common::send_msg_id "clk_wiz-2" "WARNING" " CLK_DOMAIN ($clk_domain_3) of pin [lindex $clkout_objs 3] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }

     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 4] == true } {
        set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } else {
            common::send_msg_id "clk_wiz-3" "WARNING" " CLK_DOMAIN ($clk_domain_4) of pin [lindex $clkout_objs 4] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 5] == true } {
        set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } else {
            common::send_msg_id "clk_wiz-4" "WARNING" " CLK_DOMAIN ($clk_domain_5) of pin [lindex $clkout_objs 5] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 6] == true } {
        set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_6) of pin [lindex $clkout_objs 6] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 7] == true } {
        set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_7) of pin [lindex $clkout_objs 7] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
     }
  } else {
     if { [get_property CONFIG.PRIM_SOURCE $ip] == "No_buffer" } {
        set clk_domain [get_property CONFIG.CLK_DOMAIN [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
     } else {
        set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
     }
     set clk_domain_ctrl [get_param bd.enableClkDomainControl]
     if { [lindex $clkout_used 2] == true } {
        set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } else {
            common::send_msg_id "clk_wiz-1" "WARNING" " CLK_DOMAIN ($clk_domain_2) of pin [lindex $clkout_objs 2] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 3] == true } {
                set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } else {
            common::send_msg_id "clk_wiz-2" "WARNING" " CLK_DOMAIN ($clk_domain_3) of pin [lindex $clkout_objs 3] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }

     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 4] == true } {
        set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } else {
            common::send_msg_id "clk_wiz-3" "WARNING" " CLK_DOMAIN ($clk_domain_4) of pin [lindex $clkout_objs 4] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 5] == true } {
        set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } else {
            common::send_msg_id "clk_wiz-4" "WARNING" " CLK_DOMAIN ($clk_domain_5) of pin [lindex $clkout_objs 5] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 6] == true } {
        set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_6) of pin [lindex $clkout_objs 6] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }
     }
     if { [lindex $clkout_used 7] == true } {
        set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_7) of pin [lindex $clkout_objs 7] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with No_buffer input clock. Adjust it to avoid failures further in the flow"
        }
     }
  }
   } else {
        if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
        } else {
     set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
     set clk_domain_ctrl [get_param bd.enableClkDomainControl]
     }
     if { [lindex $clkout_used 2] == true } {
        set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } 
     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 3] == true } {
                set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } 

     }
     if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
          [lindex $clkout_used 4] == true } {
        set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } 
     }
     if { [lindex $clkout_used 5] == true } {
        set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } 
     }
     if { [lindex $clkout_used 6] == true } {
        set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } 
     }
     if { [lindex $clkout_used 7] == true } {
        set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } 
     }
 }

  if {  [get_property CONFIG.RELATIVE_INCLK $ip ] == "REL_PRIMARY" } {
        if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
        } else {
       set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT0_DIVIDE_F $ip]) )] [lindex $clkout_objs 1]
       }
  
       if { [lindex $clkout_used 2] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT1_DIVIDE $ip]) )] [lindex $clkout_objs 2]
       }
       if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
            [lindex $clkout_used 3] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT2_DIVIDE $ip]) )] [lindex $clkout_objs 3]
       }
       if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
            [lindex $clkout_used 4] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT3_DIVIDE $ip]) )] [lindex $clkout_objs 4]
       }
       if { [lindex $clkout_used 5] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT4_DIVIDE $ip]) )] [lindex $clkout_objs 5]
       }
       if { [lindex $clkout_used 6] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT5_DIVIDE $ip]) )] [lindex $clkout_objs 6]
       }
       if { [lindex $clkout_used 7] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT6_DIVIDE $ip]) )] [lindex $clkout_objs 7]
       }
  } else {
      set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT0_DIVIDE_F $ip]) )] [lindex $clkout_objs 1]
  
      if { [lindex $clkout_used 2] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT1_DIVIDE $ip]) )] [lindex $clkout_objs 2]
      }
      if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
           [lindex $clkout_used 3] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT2_DIVIDE $ip]) )] [lindex $clkout_objs 3]
      }
      if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
           [lindex $clkout_used 4] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT3_DIVIDE $ip]) )] [lindex $clkout_objs 4]
      }
      if { [lindex $clkout_used 5] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT4_DIVIDE $ip]) )] [lindex $clkout_objs 5]
      }
      if { [lindex $clkout_used 6] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT5_DIVIDE $ip]) )] [lindex $clkout_objs 6]
      }
      if { [lindex $clkout_used 7] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT6_DIVIDE $ip]) )] [lindex $clkout_objs 7]
      }
  }
}

proc propagate {cellpath otherInfo } {
    set ip [get_bd_cells $cellpath]
  bd::send_msg -of $cellpath -type INFO -msg_id 1 -text " clk_wiz propagate"
  #define the clk pin objects and if object is expected to exist or not
  # nothing at index == 0
  set clkout_used [list false ]
  set clkout_objs [list {} ]
  for {set index 1} {$index < 8} {incr index} {
    set exist_config_name "CONFIG.CLKOUT${index}_USED"
    set pin_config_name "CONFIG.CLK_OUT${index}_PORT"

    set is_used false
    if {$index == 1} {
       set is_used true
    } else {
       set is_used [get_property $exist_config_name $ip] 
    }
    lappend clkout_used $is_used
    set out_pin_obj {}
    if { $is_used == true } {
      set out_pin_obj [get_bd_pins $ip/[get_property $pin_config_name $ip]]
    }
    lappend clkout_objs $out_pin_obj
  }
 set clk_domain_ctrl [get_param bd.enableClkDomainControl]

  if {[get_property CONFIG.USE_PHASE_ALIGNMENT $ip] == true } { 
      if { [get_property CONFIG.PRIM_SOURCE $ip] == "Differential_clock_capable_pin" } {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
            set freq_in1_hz [get_property CONFIG.FREQ_HZ [get_bd_intf_pins $ip/CLK_IN1_D]]
            set freq_in1 [format "%3.3f" [expr $freq_in1_hz/1000000.000]]
          if { !([get_property CONFIG.USE_BOARD_FLOW $ip] == "true" && [get_property CONFIG.CLK_IN1_BOARD_INTERFACE $ip] == "sys_diff_clock") } {
               if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] != "USER" } {
                  set_property CONFIG.PRIM_IN_FREQ $freq_in1  $ip
	       }
	  }
          set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
     set clk_domain_ctrl [get_param bd.enableClkDomainControl]
     }
          if { [lindex $clkout_used 2] == true } {
             set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } else {
            common::send_msg_id "clk_wiz-1" "WARNING" " CLK_DOMAIN ($clk_domain_2) of pin [lindex $clkout_objs 2] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 3] == true } {
                     set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } else {
            common::send_msg_id "clk_wiz-2" "WARNING" " CLK_DOMAIN ($clk_domain_3) of pin [lindex $clkout_objs 3] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }

          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 4] == true } {
             set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } else {
            common::send_msg_id "clk_wiz-3" "WARNING" " CLK_DOMAIN ($clk_domain_4) of pin [lindex $clkout_objs 4] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 5] == true } {
             set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } else {
            common::send_msg_id "clk_wiz-4" "WARNING" " CLK_DOMAIN ($clk_domain_5) of pin [lindex $clkout_objs 5] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 6] == true } {
             set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_6) of pin [lindex $clkout_objs 6] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 7] == true } {
             set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_7) of pin [lindex $clkout_objs 7] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks with differential input clock. Adjust it to avoid failures further in the flow"
        }
          }
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
          set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip])] [lindex $clkout_objs 1]
          }
         
          if { [lindex $clkout_used 2] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip])] [lindex $clkout_objs 2]
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 3] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip])] [lindex $clkout_objs 3]
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 4] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip])] [lindex $clkout_objs 4]
          }
          if { [lindex $clkout_used 5] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip])] [lindex $clkout_objs 5]
          }
          if { [lindex $clkout_used 6] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip])] [lindex $clkout_objs 6]
          }
          if { [lindex $clkout_used 7] == true } {
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip])] [lindex $clkout_objs 7]
          }
      } else {
          ##bd::send_msg -of $cellpath -type INFO -msg_id 1 -text  " hi"
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
          set freq_in1_hz [get_property CONFIG.FREQ_HZ [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
          set freq_in1 [format "%3.3f" [expr $freq_in1_hz/1000000.000]]
	  
          if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] != "USER" } {
             set_property CONFIG.PRIM_IN_FREQ $freq_in1  $ip
	  }

          set clk_domain_1 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
          set clkDomainValSrc_1 [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 1]]

          if { [get_property CONFIG.PRIM_SOURCE $ip] == "No_buffer" } {
             set clk_domain [get_property CONFIG.CLK_DOMAIN [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]       
             puts "clk_domain: $clk_domain, clk_domain_1: $clk_domain_1, clkDomainValSrc_1: $clkDomainValSrc_1, clk_domain_ctrl: $clk_domain_ctrl"
             if { $clk_domain_1 == "" || $clkDomainValSrc_1 != "USER" || $clk_domain_ctrl == 0} {
	         set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 1]
             } else {
                 bd::send_msg -of $cellpath -type WARNING -msg_id 1 -text  " CLK_DOMAIN ($clk_domain_1) of pin [lindex $clkout_objs 1] must match the CLK_DOMAIN ($clk_domain) of pin [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]] in phase aligned clocks with no buffer source input clock. Adjust it to avoid failures further in the flow"
	     }
             set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
          } else {
             if { $clk_domain_1 == "" || $clkDomainValSrc_1 != "USER" || $clk_domain_ctrl == 0} {
                 set_property CONFIG.CLK_DOMAIN "${ip}_clk_out1" [lindex $clkout_objs 1]
             } 
             set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
          }
          
          set clkin1_phase [get_property CONFIG.PHASE  [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
          set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 1]
          }
         
          if { [lindex $clkout_used 2] == true } {
          set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
          set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } else {
            common::send_msg_id "clk_wiz-1" "WARNING" " CLK_DOMAIN ($clk_domain_2) of pin [lindex $clkout_objs 2] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 2]
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 3] == true } {
                     set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } else {
            common::send_msg_id "clk_wiz-2" "WARNING" " CLK_DOMAIN ($clk_domain_3) of pin [lindex $clkout_objs 3] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }

             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 3]
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 4] == true } {
             set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } else {
            common::send_msg_id "clk_wiz-3" "WARNING" " CLK_DOMAIN ($clk_domain_4) of pin [lindex $clkout_objs 4] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 4]
          }
          if { [lindex $clkout_used 5] == true } {
             set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } else {
            common::send_msg_id "clk_wiz-4" "WARNING" " CLK_DOMAIN ($clk_domain_5) of pin [lindex $clkout_objs 5] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 5]
          }
          if { [lindex $clkout_used 6] == true } {
             set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_6) of pin [lindex $clkout_objs 6] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 6]
          }
          if { [lindex $clkout_used 7] == true } {
             set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_7) of pin [lindex $clkout_objs 7] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] in phase aligned clocks. Adjust it to avoid failures further in the flow"
        }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 7]
          }
      }

   } else {
          if { [get_property CONFIG.PRIM_SOURCE $ip] == "Differential_clock_capable_pin" } {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
            #set clkin1_phase [get_property CONFIG.PHASE  [get_bd_intf_pins $ip/CLK_IN1_D]]
            set freq_in1_hz [get_property CONFIG.FREQ_HZ [get_bd_intf_pins $ip/CLK_IN1_D]]
            set freq_in1 [format "%3.3f" [expr $freq_in1_hz/1000000.000]]
            if { !([get_property CONFIG.USE_BOARD_FLOW $ip] == "true" && [get_property CONFIG.CLK_IN1_BOARD_INTERFACE $ip] == "sys_diff_clock") } {
		if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] != "USER" } {
               set_property CONFIG.PRIM_IN_FREQ $freq_in1  $ip
		}
            }
             set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip])] [lindex $clkout_objs 1]
             }
            
             if { [lindex $clkout_used 2] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip])] [lindex $clkout_objs 2]
             }
             if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
                  [lindex $clkout_used 3] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip])] [lindex $clkout_objs 3]
             }
             if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
                  [lindex $clkout_used 4] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip])] [lindex $clkout_objs 4]
             }
             if { [lindex $clkout_used 5] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip])] [lindex $clkout_objs 5]
             }
             if { [lindex $clkout_used 6] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip])] [lindex $clkout_objs 6]
             }
             if { [lindex $clkout_used 7] == true } {
                set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip])] [lindex $clkout_objs 7]
             }
          } else {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
          set freq_in1_hz [get_property CONFIG.FREQ_HZ [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
          set freq_in1 [format "%3.3f" [expr $freq_in1_hz/1000000.000]]
		
          if { [get_property CONFIG.PRIM_IN_FREQ.VALUE_SRC $ip] != "USER" } {
               set_property CONFIG.PRIM_IN_FREQ $freq_in1  $ip
		}
            set clkin1_phase [get_property CONFIG.PHASE  [get_bd_pins $ip/[get_property CONFIG.PRIMARY_PORT $ip]]]
            set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT1_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 1]
            }

            if { [lindex $clkout_used 2] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT2_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 2]
            }
            if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
                 [lindex $clkout_used 3] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT3_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 3]
            }
            if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
                 [lindex $clkout_used 4] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT4_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 4]
            }
            if { [lindex $clkout_used 5] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT5_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 5]
            }
            if { [lindex $clkout_used 6] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT6_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 6]
            }
            if { [lindex $clkout_used 7] == true } {
               set_property CONFIG.PHASE  [expr double([get_property CONFIG.CLKOUT7_REQUESTED_PHASE $ip] + $clkin1_phase)] [lindex $clkout_objs 7]
            }
          }
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
          set clk_domain [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 1]]
          }
               if { [lindex $clkout_used 2] == true } {
             set clk_domain_2 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 2]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 2]]
        
        if { $clk_domain_2 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 2]
        } else {
            common::send_msg_id "clk_wiz-1" "WARNING" " CLK_DOMAIN ($clk_domain_2) of pin [lindex $clkout_objs 2] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1]. Adjust it to avoid failures further in the flow"
        }
          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 3] == true } {
                     set clk_domain_3 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 3]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 3]]
        if { $clk_domain_3 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 3]
        } else {
            common::send_msg_id "clk_wiz-2" "WARNING" " CLK_DOMAIN ($clk_domain_3) of pin [lindex $clkout_objs 3] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1] . Adjust it to avoid failures further in the flow"
        }

          }
          if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
               [lindex $clkout_used 4] == true } {
             set clk_domain_4 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 4]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 4]]
        if { $clk_domain_4 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 4]
        } else {
            common::send_msg_id "clk_wiz-3" "WARNING" " CLK_DOMAIN ($clk_domain_4) of pin [lindex $clkout_objs 4] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1]. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 5] == true } {
             set clk_domain_5 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 5]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 5]]
        if { $clk_domain_5 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 5]
        } else {
            common::send_msg_id "clk_wiz-4" "WARNING" " CLK_DOMAIN ($clk_domain_5) of pin [lindex $clkout_objs 5] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1]. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 6] == true } {
             set clk_domain_6 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 6]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 6]]
        if { $clk_domain_6 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 6]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_6) of pin [lindex $clkout_objs 6] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1]. Adjust it to avoid failures further in the flow"
        }
          }
          if { [lindex $clkout_used 7] == true } {
             set clk_domain_7 [get_property CONFIG.CLK_DOMAIN [lindex $clkout_objs 7]] 
        set clkDomainValSrc [get_property CONFIG.CLK_DOMAIN.VALUE_SRC [lindex $clkout_objs 7]]
        if { $clk_domain_7 == "" || $clkDomainValSrc != "USER" || $clk_domain_ctrl == 0} {
            set_property CONFIG.CLK_DOMAIN $clk_domain [lindex $clkout_objs 7]
        } else {
            common::send_msg_id "clk_wiz-5" "WARNING" " CLK_DOMAIN ($clk_domain_7) of pin [lindex $clkout_objs 7] must match the CLK_DOMAIN ($clk_domain) of pin [lindex $clkout_objs 1]. Adjust it to avoid failures further in the flow"
        }
          }

   }


  if { [get_property CONFIG.USE_INCLK_SWITCHOVER $ip] == true } {
     if { [get_property CONFIG.SECONDARY_SOURCE $ip] == "Differential_clock_capable_pin" } { 
         set freq_in2_hz [get_property CONFIG.FREQ_HZ [get_bd_intf_pins $ip/CLK_IN2_D]]
         set freq_in2 [format "%3.3f" [expr $freq_in2_hz/1000000.000]]
          if { !([get_property CONFIG.USE_BOARD_FLOW $ip] == "true" && [get_property CONFIG.CLK_IN2_BOARD_INTERFACE $ip] == "sys_diff_clock") } {
	     if { [get_property CONFIG.SECONDARY_IN_FREQ.VALUE_SRC $ip] != "USER" } {
            set_property CONFIG.SECONDARY_IN_FREQ $freq_in2  $ip
	     }
	  }
     } else {
         set freq_in2_hz [get_property CONFIG.FREQ_HZ [get_bd_pins $ip/clk_in2]]
         set freq_in2 [format "%3.3f" [expr $freq_in2_hz/1000000.000]]
	     if { [get_property CONFIG.SECONDARY_IN_FREQ.VALUE_SRC $ip] != "USER" } {
            set_property CONFIG.SECONDARY_IN_FREQ $freq_in2  $ip
	     }
     }
  }

  if {  [get_property CONFIG.RELATIVE_INCLK $ip ] == "REL_PRIMARY" } {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
       set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT0_DIVIDE_F $ip]) )] [lindex $clkout_objs 1]
       }
  
       if { [lindex $clkout_used 2] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT1_DIVIDE $ip]) )] [lindex $clkout_objs 2]
       }
       if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
            [lindex $clkout_used 3] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT2_DIVIDE $ip]) )] [lindex $clkout_objs 3]
       }
       if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
            [lindex $clkout_used 4] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT3_DIVIDE $ip]) )] [lindex $clkout_objs 4]
       }
       if { [lindex $clkout_used 5] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT4_DIVIDE $ip]) )] [lindex $clkout_objs 5]
       }
       if { [lindex $clkout_used 6] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT5_DIVIDE $ip]) )] [lindex $clkout_objs 6]
       }
       if { [lindex $clkout_used 7] == true } {
          set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.PRIM_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT6_DIVIDE $ip]) )] [lindex $clkout_objs 7]
       }
  } else {
     if { [get_property CONFIG.PRIMITIVE $ip] == "None" } {
     } else {
      set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT0_DIVIDE_F $ip]) )] [lindex $clkout_objs 1]
      }
  
      if { [lindex $clkout_used 2] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT1_DIVIDE $ip]) )] [lindex $clkout_objs 2]
      }
      if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
           [lindex $clkout_used 3] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT2_DIVIDE $ip]) )] [lindex $clkout_objs 3]
      }
      if { [get_property CONFIG.USE_SPREAD_SPECTRUM $ip] == false && 
           [lindex $clkout_used 4] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT3_DIVIDE $ip]) )] [lindex $clkout_objs 4]
      }
      if { [lindex $clkout_used 5] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT4_DIVIDE $ip]) )] [lindex $clkout_objs 5]
      }
      if { [lindex $clkout_used 6] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT5_DIVIDE $ip]) )] [lindex $clkout_objs 6]
      }
      if { [lindex $clkout_used 7] == true } {
         set_property CONFIG.FREQ_HZ [expr int(1000000 * [get_property CONFIG.SECONDARY_IN_FREQ $ip] * [get_property CONFIG.MMCM_CLKFBOUT_MULT_F $ip] / ([get_property CONFIG.MMCM_DIVCLK_DIVIDE $ip] * [get_property CONFIG.MMCM_CLKOUT6_DIVIDE $ip]) )] [lindex $clkout_objs 7]
      }
  }
  
  #if { [get_property CONFIG.USE_DYN_RECONFIG $ip] == true && [get_property CONFIG.INTERFACE_SELECTION $ip] == "Enable_AXI" } {
  #} elseif { [get_property CONFIG.USE_RESET $ip] == true } {
  #       if { [get_property CONFIG.RESET_TYPE $ip] == "ACTIVE_HIGH" } {
  #          set rst_net [get_bd_nets -of_objects [get_bd_pins $ip/reset]]   
  #          set polarity_in [get_property CONFIG.POLARITY [get_bd_pins $ip/reset]]
  #          if { $polarity_in == "ACTIVE_LOW" }  {
  #             disconnect_bd_net $rst_net [get_bd_pins $ip/reset]
  #             set_property CONFIG.RESET_TYPE  "ACTIVE_LOW" $ip
  #             set_property CONFIG.POLARITY "ACTIVE_LOW" [get_bd_pins $ip/resetn]
  #             connect_bd_net -net [get_bd_net $rst_net]  [get_bd_pins $ip/resetn]
  #          } elseif { $polarity_in == "ACTIVE_HIGH" }  {
  #             set_property CONFIG.POLARITY "ACTIVE_HIGH" [get_bd_pins $ip/reset]
  #          }
  #       } elseif { [get_property CONFIG.RESET_TYPE $ip] == "ACTIVE_LOW" } {
  #             set rst_net [get_bd_nets -of_objects [get_bd_pins $ip/resetn]]   
  #             set polarity_in [get_property CONFIG.POLARITY [get_bd_pins $ip/resetn]]
  #             if { $polarity_in == "ACTIVE_HIGH" } {
  #                disconnect_bd_net $rst_net [get_bd_pins $ip/resetn]
  #                set_property CONFIG.RESET_TYPE  "ACTIVE_HIGH" $ip
  #                set_property CONFIG.POLARITY "ACTIVE_HIGH" [get_bd_pins $ip/reset]
  #                connect_bd_net -net [get_bd_net $rst_net]  [get_bd_pins $ip/reset]
  #             } elseif { $polarity_in == "ACTIVE_LOW" }  {
  #                set_property CONFIG.POLARITY "ACTIVE_LOW" [get_bd_pins $ip/resetn]
  #             }
  #       }
  # }
}
