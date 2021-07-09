onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_arc4/err
add wave -noupdate /tb_arc4/xclk
add wave -noupdate /tb_arc4/xrst
add wave -noupdate /tb_arc4/xen
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/xkey
add wave -noupdate /tb_arc4/xready
add wave -noupdate -divider dut
add wave -noupdate /tb_arc4/dut/state
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/dut/s_addr
add wave -noupdate /tb_arc4/dut/s_output
add wave -noupdate /tb_arc4/dut/s_wrdata
add wave -noupdate /tb_arc4/dut/s_wren
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/dut/i_address
add wave -noupdate /tb_arc4/dut/i_wrdata
add wave -noupdate /tb_arc4/dut/i_wren
add wave -noupdate /tb_arc4/dut/init_enable
add wave -noupdate /tb_arc4/dut/init_ready
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/dut/k_address
add wave -noupdate /tb_arc4/dut/k_wrdata
add wave -noupdate /tb_arc4/dut/k_wren
add wave -noupdate /tb_arc4/dut/ksa_enable
add wave -noupdate /tb_arc4/dut/ksa_ready
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/dut/p_address
add wave -noupdate /tb_arc4/dut/p_wrdata
add wave -noupdate /tb_arc4/dut/p_wren
add wave -noupdate /tb_arc4/dut/prga_enable
add wave -noupdate /tb_arc4/dut/prga_ready
add wave -noupdate -divider DUT-PRGA
add wave -noupdate -radix unsigned /tb_arc4/dut/p/i
add wave -noupdate -radix unsigned /tb_arc4/dut/p/j
add wave -noupdate -radix unsigned /tb_arc4/dut/p/k
add wave -noupdate /tb_arc4/dut/p/state
add wave -noupdate -radix unsigned /tb_arc4/dut/p/message_length
add wave -noupdate -radix unsigned /tb_arc4/dut/p/pad
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_arc4/dut/p/ct_addr
add wave -noupdate -radix hexadecimal /tb_arc4/dut/p/ct_rddata
add wave -noupdate /tb_arc4/dut/p/pt_addr
add wave -noupdate -radix hexadecimal /tb_arc4/dut/p/pt_rddata
add wave -noupdate -radix hexadecimal /tb_arc4/dut/p/pt_wrdata
add wave -noupdate /tb_arc4/dut/p/pt_wren
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4116 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {4070 ps} {4326 ps}
