# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "calculator"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY top
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/add.vhd
set_global_assignment -name VHDL_FILE ../../src/sub.vhd
set_global_assignment -name VHDL_FILE ../../src/top.vhd

#50 MHz Clock
set_location_assignment PIN_AF14 -to clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to clk

#Button Inputs - Operation & Reset
set_location_assignment PIN_AD11 -to reset
set_location_assignment PIN_AA15 -to m_btn
set_location_assignment PIN_W15  -to p_btn
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to reset
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to m_btn
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to p_btn

#Operand Inputs
set_location_assignment PIN_AB12 -to input_a[0]
set_location_assignment PIN_AC12 -to input_a[1]
set_location_assignment PIN_AF9  -to input_a[2]
set_location_assignment PIN_AC9  -to input_b[0]
set_location_assignment PIN_AD10 -to input_b[1]
set_location_assignment PIN_AE12 -to input_b[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_a[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_a[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_a[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_b[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_b[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to input_b[2]


#Input A Display
set_location_assignment PIN_V25 -to HEX0[0]
set_location_assignment PIN_AA28 -to HEX0[1]
set_location_assignment PIN_Y27 -to HEX0[2]
set_location_assignment PIN_AB27 -to HEX0[3]
set_location_assignment PIN_AB26 -to HEX0[4]
set_location_assignment PIN_AA26 -to HEX0[5]
set_location_assignment PIN_AA25 -to HEX0[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX0[6]

#Input B Display 
set_location_assignment PIN_AD26 -to HEX1[0]
set_location_assignment PIN_AC27 -to HEX1[1]
set_location_assignment PIN_AD25 -to HEX1[2]
set_location_assignment PIN_AC25 -to HEX1[3]
set_location_assignment PIN_AB28 -to HEX1[4]
set_location_assignment PIN_AB25 -to HEX1[5]
set_location_assignment PIN_AB22 -to HEX1[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX1[6]

#Output Display
set_location_assignment PIN_AJ29 -to HEX2[0]
set_location_assignment PIN_AH29 -to HEX2[1]
set_location_assignment PIN_AH30 -to HEX2[2]
set_location_assignment PIN_AG30 -to HEX2[3]
set_location_assignment PIN_AF29 -to HEX2[4]
set_location_assignment PIN_AF30 -to HEX2[5]
set_location_assignment PIN_AD27 -to HEX2[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX2[6]

execute_flow -compile
project_close