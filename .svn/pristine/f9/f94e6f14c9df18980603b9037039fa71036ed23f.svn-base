onerror {resume}
radix define SSD {
    "7'b1000000" "0" -color "orange",
    "7'b1111001" "1" -color "orange",
    "7'b0100100" "2" -color "orange",
    "7'b0110000" "3" -color "orange",
    "7'b0011001" "4" -color "orange",
    "7'b0010010" "5" -color "orange",
    "7'b0000010" "6" -color "orange",
    "7'b1111000" "7" -color "orange",
    "7'b0000000" "8" -color "orange",
    "7'b0011000" "9" -color "orange",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_8bit/uut/clk
add wave -noupdate /tb_8bit/uut/reset
add wave -noupdate -radix SSD /tb_8bit/uut/HEX0
add wave -noupdate -radix SSD /tb_8bit/uut/HEX1
add wave -noupdate -radix SSD /tb_8bit/uut/HEX2
add wave -noupdate -radix unsigned /tb_8bit/uut/address_sig
add wave -noupdate -radix unsigned /tb_8bit/uut/q_sig
add wave -noupdate /tb_8bit/uut/execute
add wave -noupdate /tb_8bit/uut/ex_sig
add wave -noupdate /tb_8bit/uut/state
add wave -noupdate /tb_8bit/uut/op_code
add wave -noupdate -radix unsigned /tb_8bit/uut/input_2
add wave -noupdate -radix unsigned /tb_8bit/uut/alu_res
add wave -noupdate -radix unsigned /tb_8bit/uut/mem_din
add wave -noupdate -radix unsigned /tb_8bit/uut/mem_dout
add wave -noupdate /tb_8bit/uut/working_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2353 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 134
configure wave -valuecolwidth 41
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {5250 ns}
