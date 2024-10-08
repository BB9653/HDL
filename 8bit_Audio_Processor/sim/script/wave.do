onerror {resume}
radix define States {
    "8'b000?????" "Play" -color "green",
    "8'b001?????" "Play Repeat" -color "purple",
    "8'b01??????" "Pause" -color "orange",
    "8'b10??????" "Seek" -color "blue",
    "8'b11??????" "Stop" -color "red",
    -default hexadecimal
    -defaultcolor white
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/clk
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/reset
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_btn
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/sync
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/led
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/audio_out
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/data_address
add wave -noupdate -radix States /dj_roomba_3000_tb/dj_roomba/instruction
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/clk
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/reset
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_btn
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/sync
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/led
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/audio_out
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/pc
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/data_address
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/state
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/next_state
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/execute_sig
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/play
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/pause
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/seek
add wave -noupdate /dj_roomba_3000_tb/dj_roomba/stop
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2012 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 202
configure wave -valuecolwidth 48
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
configure wave -timelineunits us
update
WaveRestoreZoom {5 ns} {2105 ns}
