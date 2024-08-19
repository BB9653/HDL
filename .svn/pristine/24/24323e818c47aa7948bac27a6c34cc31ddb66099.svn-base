vlib work
vcom -93 -work work ../../../alu/src/alu.vhd
vcom -93 -work work ../../../memory/src/memory.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/calculator_tb.vhd
vsim -voptargs=+acc calculator_tb
do wave.do
run 100 us