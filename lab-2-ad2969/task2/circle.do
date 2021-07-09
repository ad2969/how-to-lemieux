onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /tb_circle/repetitions
add wave -noupdate /tb_circle/clk
add wave -noupdate /tb_circle/rst
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_circle/xcolour
add wave -noupdate -radix unsigned /tb_circle/xcentre_x
add wave -noupdate -radix unsigned /tb_circle/xcentre_y
add wave -noupdate -divider yeet
add wave -noupdate -radix unsigned /tb_circle/xradius
add wave -noupdate -radix unsigned /tb_circle/dutc/offset_y
add wave -noupdate -radix unsigned /tb_circle/dutc/offset_x
add wave -noupdate -radix decimal /tb_circle/dutc/crit
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_circle/xstart
add wave -noupdate /tb_circle/xdone
add wave -noupdate -radix unsigned /tb_circle/xvga_x
add wave -noupdate -radix unsigned /tb_circle/xvga_y
add wave -noupdate /tb_circle/xvga_colour
add wave -noupdate /tb_circle/xvga_plot
add wave -noupdate -divider <NULL>
add wave -noupdate -radix unsigned /tb_circle/counter
add wave -noupdate /tb_circle/err
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
WaveRestoreCursors {{Cursor 1} {3624 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 181
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
WaveRestoreZoom {3587 ps} {3620 ps}
