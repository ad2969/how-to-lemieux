onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_crack/err
add wave -noupdate /tb_crack/xclk
add wave -noupdate /tb_crack/xen
add wave -noupdate /tb_crack/xrdy
add wave -noupdate /tb_crack/xrst
add wave -noupdate -divider ct
add wave -noupdate /tb_crack/ct_address
add wave -noupdate /tb_crack/ct_rddata
add wave -noupdate -divider output
add wave -noupdate /tb_crack/xkey
add wave -noupdate /tb_crack/xkey_valid
add wave -noupdate -divider arc4
add wave -noupdate /tb_crack/dut/state
add wave -noupdate /tb_crack/dut/ar_enable
add wave -noupdate /tb_crack/dut/ar_ready
add wave -noupdate -radix hexadecimal /tb_crack/dut/ar_key
add wave -noupdate -divider pt
add wave -noupdate /tb_crack/dut/pt_address
add wave -noupdate /tb_crack/dut/pt_rddata
add wave -noupdate /tb_crack/dut/pt_wrdata
add wave -noupdate /tb_crack/dut/pt_wren
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
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
WaveRestoreZoom {0 ps} {480 ps}
