onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary /alu/aluFunc
add wave -noupdate -radix binary /alu/data1
add wave -noupdate -radix binary /alu/data2
add wave -noupdate -radix binary /alu/result
add wave -noupdate /alu/z_flag_in
add wave -noupdate /alu/c_flag_in
add wave -noupdate /alu/n_flag_in
add wave -noupdate /alu/z_flag
add wave -noupdate /alu/c_flag
add wave -noupdate /alu/n_flag
add wave -noupdate /alu/temp_Cout_adder
add wave -noupdate -radix decimal /alu/temp_result
add wave -noupdate /alu/temp_f_shL
add wave -noupdate /alu/temp_f_shR
add wave -noupdate /alu/temp_Cout_shL
add wave -noupdate /alu/temp_Cout_shR
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {152 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 61
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
WaveRestoreZoom {0 ps} {352 ps}


