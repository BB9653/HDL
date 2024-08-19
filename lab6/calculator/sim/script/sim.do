vlib work
vcom -93 -work work ../../src/clock_synchronizer.vhd
vcom -93 -work work ../../src/add.vhd
vcom -93 -work work ../../src/sub.vhd
vcom -93 -work work ../../src/top_calc.vhd
vcom -93 -work work ../src/calculator_tb.vhd
vsim -voptargs=+acc calculator_tb
do wave.do
run 100 us