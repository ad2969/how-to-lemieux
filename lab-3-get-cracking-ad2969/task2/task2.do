onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_task2/xswitch
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_task2/err
add wave -noupdate /tb_task2/xclk
add wave -noupdate /tb_task2/xrst
add wave -noupdate -divider states
add wave -noupdate /tb_task2/dut/state
add wave -noupdate /tb_task2/dut/assert_init
add wave -noupdate /tb_task2/dut/assert_ksa
add wave -noupdate -divider enable
add wave -noupdate /tb_task2/dut/i_wren
add wave -noupdate /tb_task2/dut/init_enable
add wave -noupdate /tb_task2/dut/init_ready
add wave -noupdate /tb_task2/dut/k_wren
add wave -noupdate /tb_task2/dut/ksa_enable
add wave -noupdate /tb_task2/dut/ksa_ready
add wave -noupdate /tb_task2/dut/write_enable
add wave -noupdate -divider data
add wave -noupdate /tb_task2/dut/i_address
add wave -noupdate /tb_task2/dut/i_wrdata
add wave -noupdate /tb_task2/dut/k_address
add wave -noupdate /tb_task2/dut/k_wrdata
add wave -noupdate /tb_task2/dut/mem_output
add wave -noupdate /tb_task2/dut/read_data
add wave -noupdate /tb_task2/dut/write_address
add wave -noupdate /tb_task2/dut/write_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {541 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 122
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
WaveRestoreZoom {518 ps} {643 ps}
