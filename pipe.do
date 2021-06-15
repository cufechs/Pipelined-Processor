vsim work.pipe


onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipe/clk
add wave -noupdate /pipe/rst
add wave -noupdate /pipe/Reset
add wave -noupdate /pipe/data1_execute
add wave -noupdate /pipe/data2_execute
add wave -noupdate /pipe/data1_decode
add wave -noupdate /pipe/data2_decode
add wave -noupdate /pipe/WBdata
add wave -noupdate /pipe/Memory_output_WB
add wave -noupdate /pipe/ALU_output_WB
add wave -noupdate /pipe/WbEnable_wb
add wave -noupdate /pipe/WBSignal_WB
add wave -noupdate /pipe/alu_out_execute
add wave -noupdate /pipe/aluOp_execute
add wave -noupdate /pipe/RdstData_out_execute
add wave -noupdate /pipe/PC_fetch
add wave -noupdate /pipe/StallFetch
add wave -noupdate /pipe/InstructionBits
add wave -noupdate /pipe/forward1
add wave -noupdate /pipe/forward2
add wave -noupdate /pipe/stage1/mux5sel
add wave -noupdate /pipe/stage1/Mux5Out
add wave -position 15  sim:/pipe/ALUoutput_in_memory
add wave -position 16  sim:/pipe/MemSignal
add wave -position 19  sim:/pipe/Callop
add wave -position 18  sim:/pipe/FlushFetch
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {973 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 187
configure wave -valuecolwidth 217
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
WaveRestoreZoom {309 ps} {1563 ps}


force -freeze sim:/pipe/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/pipe/Reset 1 0
force -freeze sim:/pipe/rst 1 0
run
force -freeze sim:/pipe/rst 0 0
force -freeze sim:/pipe/Reset 0 0

run
run
run
run
run
run
run
run
run
run
run
run
run