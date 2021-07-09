onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_task2/dut2/CLOCK_50
add wave -noupdate /tb_task2/dut2/KEY
add wave -noupdate /tb_task2/dut2/SW
add wave -noupdate /tb_task2/dut2/fs/rst_n
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_task2/dut2/w_vgax
add wave -noupdate /tb_task2/dut2/w_vgay
add wave -noupdate /tb_task2/dut2/w_colour
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_task2/dut2/w_start
add wave -noupdate /tb_task2/dut2/w_done
add wave -noupdate /tb_task2/dut2/w_plot
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_task2/dut2/VGA_R
add wave -noupdate /tb_task2/dut2/VGA_G
add wave -noupdate /tb_task2/dut2/VGA_B
add wave -noupdate /tb_task2/dut2/VGA_HS
add wave -noupdate /tb_task2/dut2/VGA_VS
add wave -noupdate /tb_task2/dut2/VGA_CLK
add wave -noupdate /tb_task2/dut2/VGA_R_10
add wave -noupdate /tb_task2/dut2/VGA_G_10
add wave -noupdate /tb_task2/dut2/VGA_B_10
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 209
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
WaveRestoreZoom {38136 ps} {39046 ps}
