onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_counter/clk_delay
add wave -noupdate /tb_counter/err
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_counter/xaddress
add wave -noupdate /tb_counter/xclk
add wave -noupdate /tb_counter/xread
add wave -noupdate -radix unsigned /tb_counter/xreaddata
add wave -noupdate /tb_counter/xrst
add wave -noupdate -divider dutc
add wave -noupdate -radix unsigned /tb_counter/dutc/counter
add wave -noupdate -radix unsigned /tb_counter/dutc/data
add wave -noupdate -radix unsigned /tb_counter/dutc/readdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 148
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
WaveRestoreZoom {0 ps} {8 ps}
