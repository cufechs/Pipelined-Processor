vsim work.pipe


onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipe/clk
add wave -noupdate /pipe/rst
add wave -noupdate /pipe/Reset
add wave -noupdate /pipe/inPort
add wave -noupdate /pipe/outPort
add wave -noupdate /pipe/stage2/I0/Register0Out
add wave -noupdate /pipe/stage2/I0/Register1Out
add wave -noupdate /pipe/stage2/I0/Register2Out
add wave -noupdate /pipe/stage2/I0/Register3Out
add wave -noupdate /pipe/stage2/I0/Register4Out
add wave -noupdate /pipe/stage2/I0/Register5Out
add wave -noupdate /pipe/stage2/I0/Register6Out
add wave -noupdate /pipe/stage2/I0/Register7Out
add wave -noupdate /pipe/stage3/cu/Z
add wave -noupdate /pipe/stage3/cu/N
add wave -noupdate /pipe/stage3/cu/C

add wave -noupdate /pipe/data1_execute
add wave -noupdate /pipe/data2_execute

add wave -noupdate /pipe/WBdata
add wave -noupdate /pipe/WbEnable_wb
add wave -noupdate /pipe/WBSignal_WB
add wave -noupdate /pipe/stage5/Memory
add wave -noupdate /pipe/alu_out_execute
add wave -noupdate /pipe/aluOp_execute
add wave -noupdate /pipe/stage3/Opcode
add wave -noupdate /pipe/PC_fetch
add wave -noupdate /pipe/InstructionBits
add wave -noupdate /pipe/Memory_addressZero
add wave -noupdate /pipe/stage4/SPOut
add wave -noupdate /pipe/FlushFetch
add wave -noupdate /pipe/StallFetch
add wave -noupdate /pipe/forward1
add wave -noupdate /pipe/forward2
add wave -noupdate /pipe/stage1/Mux5Out
add wave -noupdate /pipe/stage4/SPsignal
add wave -noupdate /pipe/stage4/MemSignal
add wave -noupdate /pipe/stage1/AdderOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {185 ps} 0}
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
WaveRestoreZoom {0 ps} {1085 ps}


force -freeze sim:/pipe/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/pipe/Reset 1 0
force -freeze sim:/pipe/rst 1 0
run 1 ps
force -freeze sim:/pipe/rst 0 0
run 99 ps
force -freeze sim:/pipe/Reset 0 0
force -freeze sim:/pipe/inPort 	00000000000000000000000000010011 0		
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
force -freeze sim:/pipe/inPort 	00000000000000001111111111111111 0	
run
force -freeze sim:/pipe/inPort 	00000000000000001111001100100000 0	
run
force -freeze sim:/pipe/inPort 	00000000000000000000000000001010 0	
run
run
run
run
run
run
run
run