namespace eval smartconnect_v1_0_utils {

  proc upgrade_from_smartconnect_v1_0 {xciValues} {

       upvar $xciValues xco
       namespace import ::xcoUpgradeLib::*
       #if {![isParameter STRATEGY valueArray]} {       
       # addParameter STRATEGY "AUTOMATIC" xco
       # #setParameter ADVANCED_PROPERTIES "__experimental_features__ {legacy_low_area_mode 1}" xco
       #}
       namespace forget ::xcoUpgradeLib::*
  }

}
