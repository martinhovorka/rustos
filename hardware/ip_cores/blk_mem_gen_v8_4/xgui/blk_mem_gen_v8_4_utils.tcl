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
namespace export *

  load librdi_iptasks[info sharedlibextension]

   ;# load and initialise librdi_iptasks shared library

   proc GetPlacementAlgoPower { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      part_num \
      freq_a \
      write_rate_a \
      freq_b \
      write_rate_b \
      enable_rate_a \
      enable_rate_b \
      use_common_clk } {

#      return 0 
      # TODO: check syntax and implement.
      # Returns zero for now, because apparently this function does not yet exist!
      ;# perform C function call on the librdi_iptasks  shared library
      return [Ip_blk_mem_gen_v8_4_placement_algo_power_report \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
         $write_mode_a \
         $write_mode_b \
         $use_ecc \
         1 \
         $part_num \
         $freq_a \
         $write_rate_a \
         $freq_b \
         $write_rate_b \
         $enable_rate_a \
         $enable_rate_b \
         $use_common_clk ]
#      return 0
#
   } ;# end GetPlacementAlgoPower

   proc GetPlacementAlgoNumPrims { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      use_common_clk } {

        #return 0 
      ;# perform C function call on the librdi_iptasks shared library
      return [Ip_blk_mem_gen_v8_4_placement_algo_num_prims \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
           $write_mode_a \
           $write_mode_b \
         $use_ecc \
         1 \
         $use_common_clk ]

   } ;# end GetPlacementAlgoNumPrims

   proc GetPlacementAlgoNumPrims_9 { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      use_common_clk } {

        #return 0 
      return [Ip_blk_mem_gen_v8_4_placement_algo_num_prims_9 \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
           $write_mode_a \
           $write_mode_b \
         $use_ecc \
         1 \
         $use_common_clk  ]

   } ;# end GetPlacementAlgoNumPrims_9
   proc GetPlacementAlgoNumPrims_18 { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      use_common_clk } {

        #return 0 
      ;# perform C function call on the librdi_iptasks shared library
      return [Ip_blk_mem_gen_v8_4_placement_algo_num_prims_18 \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
           $write_mode_a \
           $write_mode_b \
         $use_ecc \
         1 \
         $use_common_clk ] 

   } ;# end GetPlacementAlgoNumPrims_18
   proc GetPlacementAlgoNumPrims_36 { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      use_common_clk } {

        #return 0 
      ;# perform C function call on the librdi_iptasks shared library
      return [Ip_blk_mem_gen_v8_4_placement_algo_num_prims_36 \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
           $write_mode_a \
           $write_mode_b \
         $use_ecc \
         1 \
         $use_common_clk ]

   } ;# end GetPlacementAlgoNumPrims_36

   proc GetPlacementAlgoMuxSize { \
      c_max_prims \
      c_algorithm \
      c_prim_type \
      c_xdevicefamily \
      c_mem_type \
      c_use_byte_wea \
      c_use_byte_web \
      c_byte_size \
      write_width_a \
      write_width_b \
      read_width_a \
      read_width_b \
      write_depth_a \
      write_depth_b \
      read_depth_a \
      read_depth_b \
      write_mode_a \
      write_mode_b \
      use_ecc \
      use_common_clk } {

        #return 0 
      ;# perform C function call on the librdi_iptasks shared library
      return [Ip_blk_mem_gen_v8_4_placement_algo_mux_size \
         $c_max_prims \
         $c_algorithm \
         $c_prim_type \
         $c_xdevicefamily \
         $c_mem_type \
         $c_use_byte_wea \
         $c_use_byte_web \
         $c_byte_size \
         $write_width_a \
         $write_width_b \
         $read_width_a \
         $read_width_b \
         $write_depth_a \
         $write_depth_b \
         $read_depth_a \
         $read_depth_b \
           $write_mode_a \
           $write_mode_b \
         $use_ecc \
         1 \
         $use_common_clk ] 

   } ;# end GetPlacementAlgoMuxSize

   proc GetActualPrimitiveUsed { family primitive } {

      set actual_primitive "unknown"

      if {$family eq "virtex2" } {
         switch $primitive {
           "16kx1"   { set actual_primitive "16kx1" }
           "8kx2"    { set actual_primitive "8kx2"}
           "4kx4"    { set actual_primitive "4kx4" }
           "2kx9"    { set actual_primitive "2kx9" }
           "1kx18"   { set actual_primitive "1kx18" }
           "512x36"  { set actual_primitive "512x36" }
           "256x72"  { set actual_primitive "256x72" }
           default   { send_msg ERROR 12 "ERROR: blk_mem_gen_v8_4_utils::GetActualPrimitiveUsed() detected unknown 'Primitive' value: $primitive" }
         }

      } elseif { $family eq "virtex4" } {
         switch $primitive {
           "16kx1"   { set actual_primitive "32kx1, 16kx1" }
           "8kx2"    { set actual_primitive "8kx2"}
           "4kx4"    { set actual_primitive "4kx4" }
           "2kx9"    { set actual_primitive "2kx9" }
           "1kx18"   { set actual_primitive "1kx18" }
           "512x36"  { set actual_primitive "512x36" }
           "256x72"  { set actual_primitive "256x72" }
           default   { send_msg ERROR 13 "ERROR: blk_mem_gen_v8_4_utils::GetActualPrimitiveUsed() detected unknown 'Primitive' value: $primitive" }
         }

      } elseif { $family eq "virtex5" || $family eq "virtex6" || $family eq "virtex7" || $family eq "kintex7" || $family eq "artix7" || $family eq "artix7l" || $family eq "aartix7" || $family eq "zynq" || $family eq "virtexu" || $family eq "kintexu" || $family eq "artixu" } {
         ;# Virtex-5
         switch $primitive {
           "16kx1"   { set actual_primitive "64kx1, 32kx1, 16kx1" }
           "8kx2"    { set actual_primitive "16kx2, 8kx2"}
           "4kx4"    { set actual_primitive "8kx4, 4kx4" }
           "2kx9"    { set actual_primitive "4kx9, 2kx9" }
           "1kx18"   { set actual_primitive "2kx18, 1kx18" }
           "512x36"  { set actual_primitive "1kx36" }
           "256x72"  { set actual_primitive "512x72" }
           default   { send_msg ERROR 14 "ERROR: blk_mem_gen_v8_4_utils::GetActualPrimitiveUsed() detected unknown 'Primitive' value: $primitive" }
         }

      } elseif {$family eq "spartan6"} {
         switch  -- $primitive {
	         "16kx1"   { set actual_primitive "8kx1, 16kx1"}
	         "8kx2"   { set actual_primitive "4kx2, 8kx2"}
	         "4kx4"   { set actual_primitive "2kx4, 4kx4"}
	         "2kx9"   { set actual_primitive "1kx9, 2kx9"}
	         "1kx18"   { set actual_primitive "512x18, 1kx18"}
	         "512x36"   { set actual_primitive "512x36"}
	         "256x72"   { set actual_primitive "256x72"}
	         "256x36"   { set actual_primitive "256x36"}
            default   { send_msg ERROR 15 "ERROR: blk_mem_gen_v8_4_utils::GetActualPrimitiveUsed() detected unknown 'Primitive' value: $primitive" }
         }
      } else {
		send_msg ERROR 16 "ERROR: blk_mem_gen_v8_4_utils::GetActualPrimitiveUsed() detected unknown family type: $family"
      }

      return $actual_primitive

   } ;# end GetActualPrimitiveUsed
} ;# end namespace

