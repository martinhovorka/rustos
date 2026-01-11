
################################################################
# This is a generated script based on design: mbv_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2025.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   if { [string compare $scripts_vivado_version $current_vivado_version] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2042 -severity "ERROR" " This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Sourcing the script failed since it was created with a future version of Vivado."}

   } else {
     catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   }

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mbv_system_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a35ticsg324-1L
   set_property BOARD_PART digilentinc.com:arty-a7-35:part0:1.1 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name mbv_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:microblaze_riscv:1.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:inline_hdl:ilconcat:1.0\
xilinx.com:ip:mdm_riscv:1.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:inline_hdl:ilvector_logic:1.0\
xilinx.com:ip:fit_timer:2.0\
xilinx.com:ip:axi_timebase_wdt:3.0\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:axi_quad_spi:3.2\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axi_ethernetlite:3.0\
xilinx.com:ip:axi_iic:2.1\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:blk_mem_gen:8.4\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: mbv_local_memory
proc create_hier_cell_mbv_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mbv_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: mbv_data_local_memory_bus, and set properties
  set mbv_data_local_memory_bus [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 mbv_data_local_memory_bus ]

  # Create instance: mbv_instruction_local_memory_bus, and set properties
  set mbv_instruction_local_memory_bus [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 mbv_instruction_local_memory_bus ]

  # Create instance: mbv_data_lmb_bram_controller, and set properties
  set mbv_data_lmb_bram_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 mbv_data_lmb_bram_controller ]
  set_property CONFIG.C_ECC {0} $mbv_data_lmb_bram_controller


  # Create instance: mbv_instruction_lmb_bram_controller, and set properties
  set mbv_instruction_lmb_bram_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 mbv_instruction_lmb_bram_controller ]
  set_property CONFIG.C_ECC {0} $mbv_instruction_lmb_bram_controller


  # Create instance: mbv_block_memory_generator, and set properties
  set mbv_block_memory_generator [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 mbv_block_memory_generator ]
  set_property -dict [list \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.use_bram_block {BRAM_Controller} \
  ] $mbv_block_memory_generator


  # Create interface connections
  connect_bd_intf_net -intf_net mbv_riscv_dlmb [get_bd_intf_pins mbv_data_local_memory_bus/LMB_M] [get_bd_intf_pins DLMB]
  connect_bd_intf_net -intf_net mbv_riscv_dlmb_bus [get_bd_intf_pins mbv_data_local_memory_bus/LMB_Sl_0] [get_bd_intf_pins mbv_data_lmb_bram_controller/SLMB]
  connect_bd_intf_net -intf_net mbv_riscv_dlmb_cntlr [get_bd_intf_pins mbv_data_lmb_bram_controller/BRAM_PORT] [get_bd_intf_pins mbv_block_memory_generator/BRAM_PORTA]
  connect_bd_intf_net -intf_net mbv_riscv_ilmb [get_bd_intf_pins mbv_instruction_local_memory_bus/LMB_M] [get_bd_intf_pins ILMB]
  connect_bd_intf_net -intf_net mbv_riscv_ilmb_bus [get_bd_intf_pins mbv_instruction_local_memory_bus/LMB_Sl_0] [get_bd_intf_pins mbv_instruction_lmb_bram_controller/SLMB]
  connect_bd_intf_net -intf_net mbv_riscv_ilmb_cntlr [get_bd_intf_pins mbv_instruction_lmb_bram_controller/BRAM_PORT] [get_bd_intf_pins mbv_block_memory_generator/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1  [get_bd_pins SYS_Rst] \
  [get_bd_pins mbv_data_local_memory_bus/SYS_Rst] \
  [get_bd_pins mbv_data_lmb_bram_controller/LMB_Rst] \
  [get_bd_pins mbv_instruction_local_memory_bus/SYS_Rst] \
  [get_bd_pins mbv_instruction_lmb_bram_controller/LMB_Rst]
  connect_bd_net -net mbv_riscv_Clk  [get_bd_pins LMB_Clk] \
  [get_bd_pins mbv_data_local_memory_bus/LMB_Clk] \
  [get_bd_pins mbv_data_lmb_bram_controller/LMB_Clk] \
  [get_bd_pins mbv_instruction_local_memory_bus/LMB_Clk] \
  [get_bd_pins mbv_instruction_lmb_bram_controller/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]

  set qspi_flash [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 qspi_flash ]

  set shield_dp0_dp19 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 shield_dp0_dp19 ]

  set shield_dp26_dp41 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 shield_dp26_dp41 ]

  set push_buttons_4bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 push_buttons_4bits ]

  set dip_switches_4bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 dip_switches_4bits ]

  set led_4bits [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 led_4bits ]

  set rgb_led [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 rgb_led ]

  set eth_mii [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mii_rtl:1.0 eth_mii ]

  set eth_mdio_mdc [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_rtl:1.0 eth_mdio_mdc ]

  set spi [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:spi_rtl:1.0 spi ]

  set i2c [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c ]

  set i2c_pullups [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 i2c_pullups ]


  # Create ports
  set sys_clock [ create_bd_port -dir I -type clk -freq_hz 100000000 sys_clock ]
  set_property -dict [ list \
   CONFIG.PHASE {0.0} \
 ] $sys_clock
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $reset

  # Create instance: mbv_microblaze_v, and set properties
  set mbv_microblaze_v [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze_riscv:1.0 mbv_microblaze_v ]
  set_property -dict [list \
    CONFIG.C_DEBUG_ENABLED {1} \
    CONFIG.C_DEBUG_EVENT_COUNTERS {13} \
    CONFIG.C_DEBUG_EXTERNAL_TRACE {1} \
    CONFIG.C_DEBUG_LATENCY_COUNTERS {8} \
    CONFIG.C_D_AXI {1} \
    CONFIG.C_D_LMB {1} \
    CONFIG.C_I_LMB {1} \
    CONFIG.C_NUMBER_OF_PC_BRK {8} \
    CONFIG.C_NUMBER_OF_RD_ADDR_BRK {4} \
    CONFIG.C_NUMBER_OF_WR_ADDR_BRK {4} \
    CONFIG.C_USE_ATOMIC {1} \
    CONFIG.C_USE_BITMAN_A {1} \
    CONFIG.C_USE_BITMAN_B {1} \
    CONFIG.C_USE_BITMAN_C {1} \
    CONFIG.C_USE_BITMAN_S {1} \
    CONFIG.C_USE_COMPRESSION {1} \
    CONFIG.C_USE_FPU {0} \
    CONFIG.C_USE_MMU {3} \
    CONFIG.C_USE_MULDIV {2} \
  ] $mbv_microblaze_v


  # Create instance: mbv_local_memory
  create_hier_cell_mbv_local_memory [current_bd_instance .] mbv_local_memory

  # Create instance: mbv_axi_smartconnect, and set properties
  set mbv_axi_smartconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 mbv_axi_smartconnect ]
  set_property -dict [list \
    CONFIG.NUM_MI {14} \
    CONFIG.NUM_SI {1} \
  ] $mbv_axi_smartconnect


  # Create instance: mbv_axi_interrupt_controller, and set properties
  set mbv_axi_interrupt_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 mbv_axi_interrupt_controller ]
  set_property CONFIG.C_HAS_FAST {1} $mbv_axi_interrupt_controller


  # Create instance: mbv_inline_concat, and set properties
  set mbv_inline_concat [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilconcat:1.0 mbv_inline_concat ]
  set_property CONFIG.NUM_PORTS {11} $mbv_inline_concat


  # Create instance: mbv_microblaze_debug_module_v, and set properties
  set mbv_microblaze_debug_module_v [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm_riscv:1.0 mbv_microblaze_debug_module_v ]
  set_property -dict [list \
    CONFIG.C_ADDR_SIZE {34} \
    CONFIG.C_M_AXI_ADDR_WIDTH {34} \
    CONFIG.C_TRACE_DATA_WIDTH {16} \
    CONFIG.C_TRACE_OUTPUT {1} \
  ] $mbv_microblaze_debug_module_v


  # Create instance: mbv_clocking_wizard, and set properties
  set mbv_clocking_wizard [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 mbv_clocking_wizard ]
  set_property -dict [list \
    CONFIG.CLKOUT1_JITTER {226.435} \
    CONFIG.CLKOUT1_PHASE_ERROR {236.795} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {75} \
    CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {40.125} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {13.375} \
    CONFIG.MMCM_DIVCLK_DIVIDE {4} \
    CONFIG.PRIM_SOURCE {Single_ended_clock_capable_pin} \
    CONFIG.RESET_BOARD_INTERFACE {reset} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_clocking_wizard


  # Create instance: mbv_processor_system_reset, and set properties
  set mbv_processor_system_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 mbv_processor_system_reset ]
  set_property -dict [list \
    CONFIG.RESET_BOARD_INTERFACE {reset} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_processor_system_reset


  # Create instance: mbv_inline_utility_vector_logic, and set properties
  set mbv_inline_utility_vector_logic [ create_bd_cell -type inline_hdl -vlnv xilinx.com:inline_hdl:ilvector_logic:1.0 mbv_inline_utility_vector_logic ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $mbv_inline_utility_vector_logic


  # Create instance: mbv_fixed_interval_timer_1_millisecond, and set properties
  set mbv_fixed_interval_timer_1_millisecond [ create_bd_cell -type ip -vlnv xilinx.com:ip:fit_timer:2.0 mbv_fixed_interval_timer_1_millisecond ]
  set_property CONFIG.C_NO_CLOCKS {75000} $mbv_fixed_interval_timer_1_millisecond


  # Create instance: mbv_axi_timebase_watchdog_timer, and set properties
  set mbv_axi_timebase_watchdog_timer [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_timebase_wdt:3.0 mbv_axi_timebase_watchdog_timer ]
  set_property CONFIG.ENABLE_WINDOW_WDT {1} $mbv_axi_timebase_watchdog_timer


  # Create instance: mbv_axi_uartlite, and set properties
  set mbv_axi_uartlite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 mbv_axi_uartlite ]
  set_property -dict [list \
    CONFIG.C_BAUDRATE {115200} \
    CONFIG.UARTLITE_BOARD_INTERFACE {usb_uart} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_uartlite


  # Create instance: mbv_axi_quad_spi_flash, and set properties
  set mbv_axi_quad_spi_flash [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 mbv_axi_quad_spi_flash ]
  set_property -dict [list \
    CONFIG.C_FIFO_DEPTH {256} \
    CONFIG.C_SPI_MEMORY {3} \
    CONFIG.C_TYPE_OF_AXI4_INTERFACE {1} \
    CONFIG.C_XIP_MODE {0} \
    CONFIG.QSPI_BOARD_INTERFACE {qspi_flash} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_quad_spi_flash


  # Create instance: mbv_axi_gpio_shield_pins_0_19, and set properties
  set mbv_axi_gpio_shield_pins_0_19 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_shield_pins_0_19 ]
  set_property -dict [list \
    CONFIG.GPIO_BOARD_INTERFACE {shield_dp0_dp19} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_shield_pins_0_19


  # Create instance: mbv_axi_gpio_shield_pins_26_41, and set properties
  set mbv_axi_gpio_shield_pins_26_41 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_shield_pins_26_41 ]
  set_property -dict [list \
    CONFIG.C_INTERRUPT_PRESENT {1} \
    CONFIG.GPIO_BOARD_INTERFACE {shield_dp26_dp41} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_shield_pins_26_41


  # Create instance: mbv_axi_gpio_push_buttons, and set properties
  set mbv_axi_gpio_push_buttons [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_push_buttons ]
  set_property -dict [list \
    CONFIG.C_INTERRUPT_PRESENT {1} \
    CONFIG.GPIO_BOARD_INTERFACE {push_buttons_4bits} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_push_buttons


  # Create instance: mbv_axi_gpio_dip_switches, and set properties
  set mbv_axi_gpio_dip_switches [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_dip_switches ]
  set_property -dict [list \
    CONFIG.C_INTERRUPT_PRESENT {1} \
    CONFIG.GPIO_BOARD_INTERFACE {dip_switches_4bits} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_dip_switches


  # Create instance: mbv_axi_gpio_led_4_bits, and set properties
  set mbv_axi_gpio_led_4_bits [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_led_4_bits ]
  set_property -dict [list \
    CONFIG.GPIO_BOARD_INTERFACE {led_4bits} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_led_4_bits


  # Create instance: mbv_axi_gpio_led_rgb, and set properties
  set mbv_axi_gpio_led_rgb [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_led_rgb ]
  set_property -dict [list \
    CONFIG.GPIO_BOARD_INTERFACE {rgb_led} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_led_rgb


  # Create instance: mbv_axi_ethernetlite, and set properties
  set mbv_axi_ethernetlite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernetlite:3.0 mbv_axi_ethernetlite ]
  set_property -dict [list \
    CONFIG.C_S_AXI_PROTOCOL {AXI4LITE} \
    CONFIG.MDIO_BOARD_INTERFACE {eth_mdio_mdc} \
    CONFIG.MII_BOARD_INTERFACE {eth_mii} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_ethernetlite


  # Create instance: mbv_axi_quad_spi, and set properties
  set mbv_axi_quad_spi [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_quad_spi:3.2 mbv_axi_quad_spi ]
  set_property -dict [list \
    CONFIG.C_BYTE_LEVEL_INTERRUPT_EN {0} \
    CONFIG.C_FIFO_DEPTH {256} \
    CONFIG.C_NUM_TRANSFER_BITS {32} \
    CONFIG.C_SCK_RATIO {16} \
    CONFIG.C_SPI_MEMORY {3} \
    CONFIG.C_SPI_MODE {0} \
    CONFIG.C_TYPE_OF_AXI4_INTERFACE {1} \
    CONFIG.QSPI_BOARD_INTERFACE {spi} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_quad_spi


  # Create instance: mbv_axi_iic, and set properties
  set mbv_axi_iic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 mbv_axi_iic ]
  set_property -dict [list \
    CONFIG.C_SCL_INERTIAL_DELAY {4} \
    CONFIG.C_SDA_INERTIAL_DELAY {4} \
    CONFIG.IIC_BOARD_INTERFACE {i2c} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_iic


  # Create instance: mbv_axi_gpio_iic_pullups, and set properties
  set mbv_axi_gpio_iic_pullups [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 mbv_axi_gpio_iic_pullups ]
  set_property -dict [list \
    CONFIG.GPIO_BOARD_INTERFACE {i2c_pullups} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $mbv_axi_gpio_iic_pullups


  # Create interface connections
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MDIO [get_bd_intf_ports eth_mdio_mdc] [get_bd_intf_pins mbv_axi_ethernetlite/MDIO]
  connect_bd_intf_net -intf_net axi_ethernetlite_0_MII [get_bd_intf_ports eth_mii] [get_bd_intf_pins mbv_axi_ethernetlite/MII]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO [get_bd_intf_ports shield_dp0_dp19] [get_bd_intf_pins mbv_axi_gpio_shield_pins_0_19/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO1 [get_bd_intf_ports push_buttons_4bits] [get_bd_intf_pins mbv_axi_gpio_push_buttons/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO2 [get_bd_intf_ports led_4bits] [get_bd_intf_pins mbv_axi_gpio_led_4_bits/GPIO]
  connect_bd_intf_net -intf_net axi_gpio_0_GPIO3 [get_bd_intf_ports rgb_led] [get_bd_intf_pins mbv_axi_gpio_led_rgb/GPIO]
  connect_bd_intf_net -intf_net axi_iic_0_IIC [get_bd_intf_ports i2c] [get_bd_intf_pins mbv_axi_iic/IIC]
  connect_bd_intf_net -intf_net axi_quad_spi_0_SPI_0 [get_bd_intf_ports qspi_flash] [get_bd_intf_pins mbv_axi_quad_spi_flash/SPI_0]
  connect_bd_intf_net -intf_net axi_quad_spi_0_SPI_1 [get_bd_intf_ports spi] [get_bd_intf_pins mbv_axi_quad_spi/SPI_0]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins mbv_axi_uartlite/UART]
  connect_bd_intf_net -intf_net mbv_axi_gpio_dip_switches_GPIO [get_bd_intf_ports dip_switches_4bits] [get_bd_intf_pins mbv_axi_gpio_dip_switches/GPIO]
  connect_bd_intf_net -intf_net mbv_axi_gpio_iic_pullups_GPIO [get_bd_intf_ports i2c_pullups] [get_bd_intf_pins mbv_axi_gpio_iic_pullups/GPIO]
  connect_bd_intf_net -intf_net mbv_axi_gpio_shield_pins_26_41_GPIO [get_bd_intf_ports shield_dp26_dp41] [get_bd_intf_pins mbv_axi_gpio_shield_pins_26_41/GPIO]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M01_AXI [get_bd_intf_pins mbv_axi_smartconnect/M01_AXI] [get_bd_intf_pins mbv_axi_timebase_watchdog_timer/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M02_AXI [get_bd_intf_pins mbv_axi_smartconnect/M02_AXI] [get_bd_intf_pins mbv_axi_uartlite/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M03_AXI [get_bd_intf_pins mbv_axi_smartconnect/M03_AXI] [get_bd_intf_pins mbv_axi_quad_spi_flash/AXI_FULL]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M04_AXI [get_bd_intf_pins mbv_axi_smartconnect/M04_AXI] [get_bd_intf_pins mbv_axi_gpio_shield_pins_0_19/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M05_AXI [get_bd_intf_pins mbv_axi_smartconnect/M05_AXI] [get_bd_intf_pins mbv_axi_gpio_shield_pins_26_41/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M06_AXI [get_bd_intf_pins mbv_axi_smartconnect/M06_AXI] [get_bd_intf_pins mbv_axi_gpio_push_buttons/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M07_AXI [get_bd_intf_pins mbv_axi_smartconnect/M07_AXI] [get_bd_intf_pins mbv_axi_gpio_dip_switches/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M08_AXI [get_bd_intf_pins mbv_axi_smartconnect/M08_AXI] [get_bd_intf_pins mbv_axi_gpio_led_4_bits/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M09_AXI [get_bd_intf_pins mbv_axi_smartconnect/M09_AXI] [get_bd_intf_pins mbv_axi_gpio_led_rgb/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M10_AXI [get_bd_intf_pins mbv_axi_smartconnect/M10_AXI] [get_bd_intf_pins mbv_axi_ethernetlite/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M11_AXI [get_bd_intf_pins mbv_axi_smartconnect/M11_AXI] [get_bd_intf_pins mbv_axi_quad_spi/AXI_FULL]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M12_AXI [get_bd_intf_pins mbv_axi_smartconnect/M12_AXI] [get_bd_intf_pins mbv_axi_iic/S_AXI]
  connect_bd_intf_net -intf_net mbv_axi_smartconnect_M13_AXI [get_bd_intf_pins mbv_axi_smartconnect/M13_AXI] [get_bd_intf_pins mbv_axi_gpio_iic_pullups/S_AXI]
  connect_bd_intf_net -intf_net mbv_riscv_axi_dp [get_bd_intf_pins mbv_axi_smartconnect/S00_AXI] [get_bd_intf_pins mbv_microblaze_v/M_AXI_DP]
  connect_bd_intf_net -intf_net mbv_riscv_debug [get_bd_intf_pins mbv_microblaze_debug_module_v/MBDEBUG_0] [get_bd_intf_pins mbv_microblaze_v/DEBUG]
  connect_bd_intf_net -intf_net mbv_riscv_dlmb_1 [get_bd_intf_pins mbv_microblaze_v/DLMB] [get_bd_intf_pins mbv_local_memory/DLMB]
  connect_bd_intf_net -intf_net mbv_riscv_ilmb_1 [get_bd_intf_pins mbv_microblaze_v/ILMB] [get_bd_intf_pins mbv_local_memory/ILMB]
  connect_bd_intf_net -intf_net mbv_riscv_intc_axi [get_bd_intf_pins mbv_axi_smartconnect/M00_AXI] [get_bd_intf_pins mbv_axi_interrupt_controller/s_axi]
  connect_bd_intf_net -intf_net mbv_riscv_interrupt [get_bd_intf_pins mbv_axi_interrupt_controller/interrupt] [get_bd_intf_pins mbv_microblaze_v/INTERRUPT]

  # Create port connections
  connect_bd_net -net axi_ethernetlite_0_ip2intc_irpt  [get_bd_pins mbv_axi_ethernetlite/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In8]
  connect_bd_net -net axi_gpio_0_ip2intc_irpt  [get_bd_pins mbv_axi_gpio_push_buttons/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In6]
  connect_bd_net -net axi_iic_0_iic2intc_irpt  [get_bd_pins mbv_axi_iic/iic2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In10]
  connect_bd_net -net axi_quad_spi_0_ip2intc_irpt  [get_bd_pins mbv_axi_quad_spi/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In9]
  connect_bd_net -net axi_timebase_watchdog_timer_wdt_interrupt  [get_bd_pins mbv_axi_timebase_watchdog_timer/wdt_interrupt] \
  [get_bd_pins mbv_inline_concat/In1]
  connect_bd_net -net axi_timebase_watchdog_timer_wdt_reset  [get_bd_pins mbv_axi_timebase_watchdog_timer/wdt_reset] \
  [get_bd_pins mbv_processor_system_reset/aux_reset_in]
  connect_bd_net -net clk_wiz_1_locked  [get_bd_pins mbv_clocking_wizard/locked] \
  [get_bd_pins mbv_processor_system_reset/dcm_locked]
  connect_bd_net -net mbv_axi_gpio_dip_switches_ip2intc_irpt  [get_bd_pins mbv_axi_gpio_dip_switches/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In7]
  connect_bd_net -net mbv_axi_gpio_shield_pins_0_19_ip2intc_irpt  [get_bd_pins mbv_axi_gpio_shield_pins_0_19/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In4]
  connect_bd_net -net mbv_axi_gpio_shield_pins_26_41_ip2intc_irpt  [get_bd_pins mbv_axi_gpio_shield_pins_26_41/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In5]
  connect_bd_net -net mbv_axi_quad_spi_ip2intc_irpt  [get_bd_pins mbv_axi_quad_spi_flash/ip2intc_irpt] \
  [get_bd_pins mbv_inline_concat/In3]
  connect_bd_net -net mbv_axi_uartlite_interrupt  [get_bd_pins mbv_axi_uartlite/interrupt] \
  [get_bd_pins mbv_inline_concat/In2]
  connect_bd_net -net mbv_fixed_interval_timer_Interrupt  [get_bd_pins mbv_fixed_interval_timer_1_millisecond/Interrupt] \
  [get_bd_pins mbv_inline_concat/In0]
  connect_bd_net -net mbv_processor_system_reset_peripheral_reset  [get_bd_pins mbv_processor_system_reset/peripheral_reset] \
  [get_bd_pins mbv_fixed_interval_timer_1_millisecond/Rst]
  connect_bd_net -net mbv_riscv_Clk  [get_bd_pins mbv_clocking_wizard/clk_out1] \
  [get_bd_pins mbv_microblaze_v/Clk] \
  [get_bd_pins mbv_axi_smartconnect/aclk] \
  [get_bd_pins mbv_axi_interrupt_controller/s_axi_aclk] \
  [get_bd_pins mbv_axi_interrupt_controller/processor_clk] \
  [get_bd_pins mbv_local_memory/LMB_Clk] \
  [get_bd_pins mbv_processor_system_reset/slowest_sync_clk] \
  [get_bd_pins mbv_microblaze_debug_module_v/M_AXI_ACLK] \
  [get_bd_pins mbv_fixed_interval_timer_1_millisecond/Clk] \
  [get_bd_pins mbv_axi_timebase_watchdog_timer/s_axi_aclk] \
  [get_bd_pins mbv_axi_uartlite/s_axi_aclk] \
  [get_bd_pins mbv_axi_quad_spi_flash/ext_spi_clk] \
  [get_bd_pins mbv_axi_gpio_shield_pins_0_19/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_shield_pins_26_41/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_push_buttons/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_dip_switches/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_led_4_bits/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_led_rgb/s_axi_aclk] \
  [get_bd_pins mbv_axi_ethernetlite/s_axi_aclk] \
  [get_bd_pins mbv_axi_quad_spi_flash/s_axi4_aclk] \
  [get_bd_pins mbv_axi_quad_spi/s_axi4_aclk] \
  [get_bd_pins mbv_axi_quad_spi/ext_spi_clk] \
  [get_bd_pins mbv_axi_iic/s_axi_aclk] \
  [get_bd_pins mbv_axi_gpio_iic_pullups/s_axi_aclk]
  connect_bd_net -net mbv_riscv_intr  [get_bd_pins mbv_inline_concat/dout] \
  [get_bd_pins mbv_axi_interrupt_controller/intr]
  connect_bd_net -net mdm_1_debug_sys_rst  [get_bd_pins mbv_microblaze_debug_module_v/Debug_SYS_Rst] \
  [get_bd_pins mbv_processor_system_reset/mb_debug_sys_rst]
  connect_bd_net -net reset_1  [get_bd_ports reset] \
  [get_bd_pins mbv_inline_utility_vector_logic/Op1] \
  [get_bd_pins mbv_processor_system_reset/ext_reset_in]
  connect_bd_net -net reset_inv_0_Res  [get_bd_pins mbv_inline_utility_vector_logic/Res] \
  [get_bd_pins mbv_clocking_wizard/reset]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset  [get_bd_pins mbv_processor_system_reset/bus_struct_reset] \
  [get_bd_pins mbv_local_memory/SYS_Rst]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset  [get_bd_pins mbv_processor_system_reset/mb_reset] \
  [get_bd_pins mbv_microblaze_v/Reset] \
  [get_bd_pins mbv_axi_interrupt_controller/processor_rst]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn  [get_bd_pins mbv_processor_system_reset/peripheral_aresetn] \
  [get_bd_pins mbv_axi_smartconnect/aresetn] \
  [get_bd_pins mbv_axi_interrupt_controller/s_axi_aresetn] \
  [get_bd_pins mbv_microblaze_debug_module_v/M_AXI_ARESETN] \
  [get_bd_pins mbv_axi_timebase_watchdog_timer/s_axi_aresetn] \
  [get_bd_pins mbv_axi_uartlite/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_shield_pins_0_19/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_shield_pins_26_41/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_push_buttons/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_dip_switches/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_led_4_bits/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_led_rgb/s_axi_aresetn] \
  [get_bd_pins mbv_axi_ethernetlite/s_axi_aresetn] \
  [get_bd_pins mbv_axi_quad_spi_flash/s_axi4_aresetn] \
  [get_bd_pins mbv_axi_quad_spi/s_axi4_aresetn] \
  [get_bd_pins mbv_axi_iic/s_axi_aresetn] \
  [get_bd_pins mbv_axi_gpio_iic_pullups/s_axi_aresetn]
  connect_bd_net -net sys_clock_1  [get_bd_ports sys_clock] \
  [get_bd_pins mbv_clocking_wizard/clk_in1]

  # Create address segments
  assign_bd_address -offset 0x40E00000 -range 0x00010000 -with_name SEG_axi_ethernetlite_0_Reg -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_ethernetlite/S_AXI/Reg] -force
  assign_bd_address -offset 0x40020000 -range 0x00010000 -with_name SEG_axi_gpio_0_Reg -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_push_buttons/S_AXI/Reg] -force
  assign_bd_address -offset 0x40040000 -range 0x00010000 -with_name SEG_axi_gpio_0_Reg_1 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_led_4_bits/S_AXI/Reg] -force
  assign_bd_address -offset 0x40050000 -range 0x00010000 -with_name SEG_axi_gpio_0_Reg_2 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_led_rgb/S_AXI/Reg] -force
  assign_bd_address -offset 0x40800000 -range 0x00010000 -with_name SEG_axi_iic_0_Reg -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_iic/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A10000 -range 0x00010000 -with_name SEG_axi_quad_spi_0_MEM0 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_quad_spi/aximm/MEM0] -force
  assign_bd_address -offset 0x41A00000 -range 0x00010000 -with_name SEG_axi_timebase_watchdog_timer_Reg -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_timebase_watchdog_timer/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -with_name SEG_dlmb_bram_if_cntlr_Mem -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_local_memory/mbv_data_lmb_bram_controller/SLMB/Mem] -force
  assign_bd_address -offset 0x40030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_dip_switches/S_AXI/Reg] -force
  assign_bd_address -offset 0x40060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_iic_pullups/S_AXI/Reg] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_shield_pins_0_19/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_gpio_shield_pins_26_41/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A00000 -range 0x00010000 -with_name SEG_mbv_axi_quad_spi_MEM0 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_quad_spi_flash/aximm/MEM0] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_uartlite/S_AXI/Reg] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -with_name SEG_mbv_riscv_axi_intc_Reg -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Data] [get_bd_addr_segs mbv_axi_interrupt_controller/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00020000 -with_name SEG_ilmb_bram_if_cntlr_Mem -target_address_space [get_bd_addr_spaces mbv_microblaze_v/Instruction] [get_bd_addr_segs mbv_local_memory/mbv_instruction_lmb_bram_controller/SLMB/Mem] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


