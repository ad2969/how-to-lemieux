onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ksa/switch
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_ksa/err
add wave -noupdate /tb_ksa/xclk
add wave -noupdate /tb_ksa/xrst
add wave -noupdate -divider signals
add wave -noupdate /tb_ksa/xen
add wave -noupdate /tb_ksa/xrdy
add wave -noupdate -divider readwrite
add wave -noupdate /tb_ksa/xwrite_enable
add wave -noupdate /tb_ksa/xread_data
add wave -noupdate -radix unsigned /tb_ksa/xwrite_addr
add wave -noupdate /tb_ksa/xwrite_data
add wave -noupdate -divider dut
add wave -noupdate /tb_ksa/dutksa/state
add wave -noupdate -radix unsigned /tb_ksa/dutksa/i
add wave -noupdate -radix unsigned /tb_ksa/dutksa/j
add wave -noupdate -divider dut-data
add wave -noupdate /tb_ksa/dutksa/read_data
add wave -noupdate /tb_ksa/dutksa/temp_data
add wave -noupdate /tb_ksa/dutksa/load_data
add wave -noupdate /tb_ksa/dutksa/sel_address
add wave -noupdate /tb_ksa/dutksa/keyindex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 182
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
WaveRestoreZoom {0 ps} {14 ps}
