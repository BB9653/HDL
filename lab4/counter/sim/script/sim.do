vlib work
vcom -93 -work work ../../src/generic_counter.vhd
vcom -93 -work work ../../src/generic_adder_beh.vhd
vcom -93 -work work ../../../seven_seg/src/seven_seg.vhd
vcom -93 -work work ../../src/top_module.vhd
vcom -93 -work work ../src/counter_tb.vhd
vsim -voptargs=+acc counter_tb
do wave.do
run 100000000 us