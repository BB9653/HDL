vlib work
vmap altera_mf C:/intelFPGA_lite/18.1/modelsim_ase/altera/vhdl/altera_mf
vcom -93 -work work ../../src/rom/blink_rom.vhd
vcom -93 -work work ../../src/alu.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/memory.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/block_mem.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/tb_8bit.vhd
vsim -voptargs=+acc tb_8bit
do wave.do
run 5 us
