vlib work
vcom -93 -work work ../../../calculator/src/add.vhd
vcom -93 -work work ../../../calculator/src/sub.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../../calculator/src/clock_synchronizer.vhd
vcom -93 -work work ../../../calculator/src/top_calc.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/display_tb.vhd
vsim -voptargs=+acc display_tb
do wave.do
run 100 us