onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_statemachine/clk
add wave -noupdate /tb_statemachine/xreset
add wave -noupdate /tb_statemachine/fsmdut/state
add wave -noupdate /tb_statemachine/fsmdut/next_state
add wave -noupdate -divider Scores
add wave -noupdate -radix unsigned /tb_statemachine/xdscore
add wave -noupdate -radix unsigned /tb_statemachine/xpscore
add wave -noupdate -radix unsigned /tb_statemachine/xpcard3
add wave -noupdate -divider Loaders
add wave -noupdate /tb_statemachine/xpload1
add wave -noupdate /tb_statemachine/xpload2
add wave -noupdate /tb_statemachine/xpload3
add wave -noupdate /tb_statemachine/xdload1
add wave -noupdate /tb_statemachine/xdload2
add wave -noupdate /tb_statemachine/xdload3
add wave -noupdate -divider {Win Indicators}
add wave -noupdate /tb_statemachine/xpwin
add wave -noupdate /tb_statemachine/xdwin
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_statemachine/err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {650 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 255
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
WaveRestoreZoom {241 ps} {558 ps}
