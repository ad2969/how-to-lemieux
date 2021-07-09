onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider err
add wave -noupdate /tb_flash_reader/xclk
add wave -noupdate /tb_flash_reader/xrst
add wave -noupdate -radix binary /tb_flash_reader/dut/state
add wave -noupdate -divider dut
add wave -noupdate /tb_flash_reader/dut/flash_mem_byteenable
add wave -noupdate /tb_flash_reader/dut/flash_mem_read
add wave -noupdate /tb_flash_reader/dut/flash_mem_waitrequest
add wave -noupdate /tb_flash_reader/dut/flash_mem_readdatavalid
add wave -noupdate -radix hexadecimal /tb_flash_reader/dut/flash_mem_readdata
add wave -noupdate -divider transf
add wave -noupdate -radix unsigned /tb_flash_reader/dut/flash_mem_address
add wave -noupdate -radix hexadecimal /tb_flash_reader/dut/flash_mem_readdata1
add wave -noupdate -radix hexadecimal /tb_flash_reader/dut/flash_mem_readdata2
add wave -noupdate -divider {memory (to write)}
add wave -noupdate -radix unsigned /tb_flash_reader/dut/mem_address
add wave -noupdate -radix hexadecimal /tb_flash_reader/dut/mem_writedata
add wave -noupdate -radix hexadecimal /tb_flash_reader/dut/mem_output
add wave -noupdate /tb_flash_reader/dut/mem_wren
add wave -noupdate -divider err
add wave -noupdate /tb_flash_reader/err
add wave -noupdate -radix binary /tb_flash_reader/dut/flash_inst/readstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 284
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
WaveRestoreZoom {0 ps} {67 ps}
