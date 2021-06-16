onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /execute/clk
add wave -noupdate /execute/rst
add wave -noupdate /execute/Opcode
add wave -noupdate /execute/Br_op
add wave -noupdate /execute/Br_type
add wave -noupdate /execute/SETC_sig
add wave -noupdate /execute/CLRC_sig
add wave -noupdate /execute/forward1
add wave -noupdate /execute/forward2
add wave -noupdate /execute/alu_op
add wave -noupdate /execute/outPort_en
add wave -noupdate -radix hexadecimal /execute/data1
add wave -noupdate -radix hexadecimal /execute/data2
add wave -noupdate -radix hexadecimal /execute/PC_in
add wave -noupdate /execute/Rdst_ex
add wave -noupdate /execute/Rdst_m
add wave -noupdate /execute/Br_taken
add wave -noupdate -radix hexadecimal /execute/alu_out
add wave -noupdate -radix hexadecimal /execute/PC_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {159 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 258
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {630 ps}


force -freeze sim:/execute/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/execute/rst 1 0
force -freeze sim:/execute/Opcode 010001 0
force -freeze sim:/execute/Br_op 0 0
force -freeze sim:/execute/SETC_sig 0 0
force -freeze sim:/execute/Br_type 00 0
force -freeze sim:/execute/CLRC_sig 0 0
force -freeze sim:/execute/forward1 00 0
force -freeze sim:/execute/forward2 00 0
force -freeze sim:/execute/alu_op 1 0
force -freeze sim:/execute/outPort_en 0 0
force -freeze sim:/execute/data1 32'h00000ff0 0
force -freeze sim:/execute/data2 32'h00ff0000 0
force -freeze sim:/execute/PC_in 32'hAAAAAAAA 0
force -freeze sim:/execute/Rdst_ex 32'hA0000000 0
force -freeze sim:/execute/Rdst_m 32'hBB000000 0

run 

force -freeze sim:/execute/rst 0 0

run

force -freeze sim:/execute/Opcode 010001 0

