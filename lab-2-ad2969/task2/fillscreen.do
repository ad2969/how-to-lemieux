onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_fillscreen/clk
add wave -noupdate /tb_fillscreen/rst
add wave -noupdate -divider control
add wave -noupdate /tb_fillscreen/xstart
add wave -noupdate /tb_fillscreen/xdone
add wave -noupdate -divider {vga output}
add wave -noupdate /tb_fillscreen/xvga_x
add wave -noupdate /tb_fillscreen/xvga_y
add wave -noupdate /tb_fillscreen/xvga_colour
add wave -noupdate /tb_fillscreen/xvga_plot
add wave -noupdate -divider <NULL>
add wave -noupdate -radix decimal /tb_fillscreen/counter
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_fillscreen/err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {76874 ps} 0}
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
WaveRestoreZoom {76271 ps} {77224 ps}
