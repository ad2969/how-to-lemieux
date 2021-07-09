onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_datapath/clk
add wave -noupdate /tb_datapath/xreset
add wave -noupdate -divider {Fast Clock}
add wave -noupdate /tb_datapath/fclk
add wave -noupdate /tb_datapath/dpdut/new_card
add wave -noupdate -divider Loaders
add wave -noupdate /tb_datapath/xpload1
add wave -noupdate /tb_datapath/xpload2
add wave -noupdate /tb_datapath/xpload3
add wave -noupdate /tb_datapath/xdload1
add wave -noupdate /tb_datapath/xdload2
add wave -noupdate /tb_datapath/xdload3
add wave -noupdate /tb_datapath/xpcard3
add wave -noupdate /tb_datapath/xddraw3
add wave -noupdate -divider Cards
add wave -noupdate /tb_datapath/dpdut/pcard1_w
add wave -noupdate /tb_datapath/dpdut/pcard2_w
add wave -noupdate /tb_datapath/dpdut/pcard3_w
add wave -noupdate /tb_datapath/dpdut/dcard1_w
add wave -noupdate /tb_datapath/dpdut/dcard2_w
add wave -noupdate /tb_datapath/dpdut/dcard3_w
add wave -noupdate -divider Scores
add wave -noupdate /tb_datapath/xpscore
add wave -noupdate /tb_datapath/xdscore
add wave -noupdate /tb_datapath/HEX5
add wave -noupdate /tb_datapath/HEX4
add wave -noupdate /tb_datapath/HEX3
add wave -noupdate /tb_datapath/HEX2
add wave -noupdate /tb_datapath/HEX1
add wave -noupdate /tb_datapath/HEX0
add wave -noupdate -divider {States & Err}
add wave -noupdate /tb_datapath/err
add wave -noupdate /tb_datapath/xstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 233
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
WaveRestoreZoom {0 ps} {8191 ps}
