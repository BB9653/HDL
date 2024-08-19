vlib work
vcom -93 -work work ../../adderSingleBitStructural/adder_single_bit_structural.vhd
vcom -93 -work work ../src/adder_single_bit_tb.vhd
vsim -voptargs=+acc adder_single_bit_tb
do wave.do
run 500 ns
