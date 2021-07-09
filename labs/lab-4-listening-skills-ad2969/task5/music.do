onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_music/err
add wave -noupdate /tb_music/xclk
add wave -noupdate /tb_music/xclk2
add wave -noupdate /tb_music/xrst
add wave -noupdate -divider sm
add wave -noupdate /tb_music/dut/state
add wave -noupdate -divider flashread
add wave -noupdate /tb_music/dut/clk
add wave -noupdate /tb_music/dut/sample
add wave -noupdate /tb_music/dut/flash_mem_read
add wave -noupdate /tb_music/dut/flash_mem_waitrequest
add wave -noupdate /tb_music/dut/flash_mem_address
add wave -noupdate /tb_music/dut/flash_mem_readdata
add wave -noupdate /tb_music/dut/flash_mem_readdatavalid
add wave -noupdate /tb_music/dut/flash_mem_byteenable
add wave -noupdate /tb_music/dut/read_ready
add wave -noupdate /tb_music/dut/write_ready
add wave -noupdate -divider codecwrite
add wave -noupdate /tb_music/dut/write_s
add wave -noupdate /tb_music/dut/read_s
add wave -noupdate /tb_music/dut/writedata_left
add wave -noupdate /tb_music/dut/writedata_right
add wave -noupdate /tb_music/dut/readdata_left
add wave -noupdate /tb_music/dut/readdata_right
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
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
WaveRestoreZoom {16 ps} {46 ps}
