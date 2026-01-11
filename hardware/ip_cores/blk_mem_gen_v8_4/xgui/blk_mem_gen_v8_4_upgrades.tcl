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

namespace eval blk_mem_gen_v8_4_utils {

        proc upgrade_from_blk_mem_gen_v8_0 {xciValues} {

          upvar $xciValues valueArray
          namespace import ::xcoUpgradeLib::*

#		  if { [isParameter CTRL_ECC_ALGO valueArray] } {
#		     removeParameter CTRL_ECC_ALGO valueArray
#		  }

          return
        }

        proc upgrade_from_blk_mem_gen_v7_3 {xciValues} {

          upvar $xciValues valueArray
          namespace import ::xcoUpgradeLib::*

          switch [getParameter use_bram_block valueArray] {
                "0" {setParameter use_bram_block Stand_Alone valueArray}
                "1" {setParameter use_bram_block BRAM_Controller valueArray}
                }


          return
        }


        proc upgrade_from_blk_mem_gen_v7_2 {xciValues} {

          upvar $xciValues valueArray
          namespace import ::xcoUpgradeLib::*

          addParameter use_bram_block Stand_Alone valueArray
          addParameter mem_file no_Mem_file_loaded valueArray

          return
        }


        proc upgrade_from_blk_mem_gen_v7_1 {xciValues} {

          upvar $xciValues valueArray
          namespace import ::xcoUpgradeLib::*

          addParameter Enable_32bit_Address 0 valueArray

          return
        }

 } ;# end namespace



