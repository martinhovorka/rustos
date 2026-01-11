# (c) Copyright 2014, 2023 Advanced Micro Devices, Inc. All rights reserved.
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

source_subcore_ipfile xilinx.com:ip:sc_util:1.0 xgui/xgui2_util.tcl
source_subcore_ipfile xilinx.com:ip:sc_util:1.0 xgui/sc_util_v1_0_constants.tcl

#set c_family [string tolower [get_project_property ARCHITECTURE]]

set pepEnabled 1

proc init_meta_params { IPINST } {
  variable pepEnabled

  set filePath "./sc_post_elab.rld"
  set data {}
  set peps {}
  set pepEnabled 0

  set views {clocking functional timing}
  set meta {}
  dict set meta all ""
  foreach v $views {
    dict set meta $v ""
  }

  if {! [catch {set data [ipgui::load_elaborated_data_file $IPINST -file $filePath] } err] } {
    if {[llength $data] > 0} { 
      foreach l [split $data \n] { lappend peps $l }
      if {[llength $peps] > 0} { 
        dict set meta all $peps 
      }

      set common_cfg [lsearch -all -inline $peps "*/config*"]
      foreach t {clocking functional timing} {
        set cfg [lsearch -all -inline $peps "/$t*"] 
        if {[llength $cfg] > 0} {
          lappend cfg {*}$common_cfg
          dict set meta $t $cfg
        }
      }
      set pepEnabled 1
    }
  }
  dict for {k v} $meta {
    add_meta_param -name SC_CONFIG_[string toupper $k] -type list -value $v $IPINST
  }
}

proc init_gui { IPINST } {
  variable pepEnabled

  set ipview $IPINST
  set Page0           [ ipgui::add_page  $ipview -name "Settings" -layout vertical]
  set spgroup [ipgui::add_group $ipview -parent $Page0 -name {Standard Properties} -layout vertical]
  set Component_Name  [ ipgui::add_param $ipview -parent  $spgroup -name Component_Name ]
  set NUM_SI  [ ipgui::add_param $ipview -parent  $spgroup -name NUM_SI -widget comboBox]
  set NUM_MI  [ ipgui::add_param $ipview -parent  $spgroup -name NUM_MI -widget comboBox]
  set NUM_CLKS  [ ipgui::add_param $ipview -parent  $spgroup -name NUM_CLKS ]
  set HAS_ARESETN  [ ipgui::add_param $ipview -parent  $spgroup -name HAS_ARESETN -widget comboBox]
  set STRATEGY  [ ipgui::add_param $ipview -parent  $spgroup -name STRATEGY -widget comboBox]
  set_property visible false $STRATEGY

  set apgroup [ipgui::add_group $ipview -parent $Page0 -name {Advanced Properties} -layout horizontal]
    ipgui::add_custom_widget -parent $apgroup -name PostElabProperties -class_name SmartConnect -hierParam "ADVANCED_PROPERTIES" $IPINST  
    ipgui::add_row $ipview -parent $apgroup
    ipgui::add_static_text $ipview -parent $apgroup -name POST_ELAB_TEXT -text {Advanced Properties are available after validation.   Re-validate design after changes to advanced properties.}
}

proc update_gui_for_PARAM_VALUE.NUM_SI { IPINST PARAM_VALUE.NUM_SI PARAM_VALUE.NUM_MI} {
  set gs [ipgui::get_groupspec -of $IPINST {Advanced Properties}]
  set num_si [get_property value ${PARAM_VALUE.NUM_SI}]
  set num_mi [get_property value ${PARAM_VALUE.NUM_MI}]
  set v true 
  if {$num_si == 1 && $num_mi == 1} {
    set v false
  }
  set_property visible $v $gs
}

proc update_gui_for_PARAM_VALUE.NUM_MI { IPINST PARAM_VALUE.NUM_MI PARAM_VALUE.NUM_SI } {
  set gs [ipgui::get_groupspec -of $IPINST {Advanced Properties}]
  set num_si [get_property value ${PARAM_VALUE.NUM_SI}]
  set num_mi [get_property value ${PARAM_VALUE.NUM_MI}]
  set v true 
  if {$num_si == 1 && $num_mi == 1} {
    set v false
  }
  set_property visible $v $gs
}


proc update_PARAM_VALUE.NUM_MI { PARAM_VALUE.NUM_MI PARAM_VALUE.ADVANCED_PROPERTIES } {
   set d [get_property value ${PARAM_VALUE.ADVANCED_PROPERTIES}]
   set num_mi [get_property value ${PARAM_VALUE.NUM_MI}]
   if {[string match "*use_3d_mi_names 1*" $d]} {
     set_property range "1,256" ${PARAM_VALUE.NUM_MI}
    } else {
     set_property range "1,64" ${PARAM_VALUE.NUM_MI}
  }
}

proc update_PARAM_VALUE.NUM_SI { PARAM_VALUE.NUM_SI PARAM_VALUE.ADVANCED_PROPERTIES PARAM_VALUE.NUM_MI } {
   set d [get_property value ${PARAM_VALUE.ADVANCED_PROPERTIES}]
   set num_si [get_property value ${PARAM_VALUE.NUM_SI}]
   set mi [get_property value ${PARAM_VALUE.NUM_MI}]

   if {$mi > 16} {
     set_property range "1,1" ${PARAM_VALUE.NUM_SI}
   } else {
     set_property range "1,16" ${PARAM_VALUE.NUM_SI}
   }
}

proc update_PARAM_VALUE.NUM_CLKS { PARAM_VALUE.NUM_CLKS PARAM_VALUE.NUM_SI PARAM_VALUE.NUM_MI } {
  set num_si [get_property VALUE ${PARAM_VALUE.NUM_SI}]
  set num_mi [get_property VALUE ${PARAM_VALUE.NUM_MI}]

  if {$num_si==1 && $num_mi ==1} {
    set_property range "1,2" ${PARAM_VALUE.NUM_CLKS}
  } elseif {$num_mi > 64} {
    set_property range "1,66" ${PARAM_VALUE.NUM_CLKS}
  } else {
    set_property range "1,[expr $num_si + $num_mi + 1]" ${PARAM_VALUE.NUM_CLKS}
  } 
}

proc update_PARAM_VALUE.Component_Name {PARAM_VALUE.Component_Name } {
   return true
}

proc update_MODELPARAM_VALUE.TLM_COMPONENT_NAME { MODELPARAM_VALUE.TLM_COMPONENT_NAME PARAM_VALUE.Component_Name } {
  set_property value [get_property value ${PARAM_VALUE.Component_Name}] ${MODELPARAM_VALUE.TLM_COMPONENT_NAME}
}

proc update_MODELPARAM_VALUE.HAS_RESET { MODELPARAM_VALUE.HAS_RESET PARAM_VALUE.HAS_ARESETN } {
  set_property value [get_property value ${PARAM_VALUE.HAS_ARESETN}] ${MODELPARAM_VALUE.HAS_RESET}
}

proc update_MODELPARAM_VALUE.STRATEGY { MODELPARAM_VALUE.STRATEGY PARAM_VALUE.STRATEGY } {
  set_property value [get_property value ${PARAM_VALUE.STRATEGY}] ${MODELPARAM_VALUE.STRATEGY}
}

generate_map_model_procs {
  PARAM_VALUE.STRATEGY MODELPARAM_VALUE.STRATEGY {AUTOMATIC 0 LOW_AREA 1 PERFORMANCE 2}
}


#proc validate_PARAM_VALUE.ADVANCED_PROPERTIES { PARAM_VALUE.ADVANCED_PROPERTIES PARAM_VALUE.ADVANCED_PROPERTIES } {
#  set d [get_property value ${PARAM_VALUE.ADVANCED_PROPERTIES}]
#  set views {}
#  if {[dict exists $d __views__]} {
#    set views [dict get $d __views__]
#  }
#  if {[dict exists $d views]} {
#    set views [dict get $d views]
#  }
#
#  if {[llength $views] > 0} {
#    set viewSet [dict keys $views]
#    foreach v {functional timing clocking slr} {
#      set index [lsearch -exact $viewSet] 
#      if {$index != -1} {
#        set viewSet [lremove $viewSet $index $index]
#      }
#
#      if {[llength $viewSet] > 0} {
#        foreach i $viewSet {
#          lappend errors "$i is not a supported advanced property view name"
#        }
#
#      }
#      
#    }
#
#  }
#
#}
