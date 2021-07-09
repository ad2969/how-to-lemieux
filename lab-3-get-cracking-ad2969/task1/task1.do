onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_task1/err
add wave -noupdate /tb_task1/xclk
add wave -noupdate /tb_task1/xrst
add wave -noupdate -divider dut
add wave -noupdate /tb_task1/dut/write_address
add wave -noupdate /tb_task1/dut/write_data
add wave -noupdate /tb_task1/dut/write_enable
add wave -noupdate /tb_task1/dut/mem_output
add wave -noupdate -divider {dut - init}
add wave -noupdate /tb_task1/dut/assert_init
add wave -noupdate /tb_task1/dut/init_ready
add wave -noupdate /tb_task1/dut/init_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {265 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 201
configure wave -valuecolwidth 100
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
WaveRestoreZoom {570 ps} {602 ps}
