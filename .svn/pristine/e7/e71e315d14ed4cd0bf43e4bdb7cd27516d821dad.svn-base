radix define States {
"7'b1000000" "0" -color "red",
"7'b1111001" "1" -color "red",
"7'b0100100" "2" -color "red",
"7'b0110000" "3" -color "red",
"7'b0011001" "4" -color "red",
"7'b0010010" "5" -color "red",
"7'b0000010" "6" -color "red",
"7'b1111000" "7" -color "red",
"7'b0000000" "8" -color "red",
"7'b0010000" "9" -color "red",
"7'b0001000" "A" -color "red",
"7'b0000011" "B" -color "red",
"7'b1000110" "C" -color "red",
"7'b0100001" "D" -color "red",
"7'b0000110" "E" -color "red",
"7'b0001110" "F" -color "red",
-default default
}

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /calculator_tb/uut/clk
add wave -noupdate /calculator_tb/uut/reset
add wave -noupdate /calculator_tb/uut/ms
add wave -noupdate /calculator_tb/uut/mr
add wave -noupdate /calculator_tb/uut/op
add wave -noupdate -radix unsigned /calculator_tb/uut/input_2
add wave -noupdate -radix unsigned /calculator_tb/uut/alu_res
add wave -noupdate /calculator_tb/uut/execute
add wave -noupdate /calculator_tb/uut/state
add wave -noupdate /calculator_tb/uut/ex_sig
add wave -noupdate -radix unsigned /calculator_tb/uut/current_val
add wave -noupdate -radix unsigned /calculator_tb/uut/mem_din
add wave -noupdate -radix unsigned /calculator_tb/uut/mem_dout
add wave -noupdate -radix States /calculator_tb/uut/HEX0
add wave -noupdate -radix States /calculator_tb/uut/HEX1
add wave -noupdate -radix States /calculator_tb/uut/HEX2

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
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
WaveRestoreZoom {400250 ps} {505250 ps}

