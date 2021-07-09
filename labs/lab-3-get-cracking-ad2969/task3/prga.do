onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_prga/switch
add wave -noupdate /tb_prga/err
add wave -noupdate /tb_prga/xrst
add wave -noupdate /tb_prga/xclk
add wave -noupdate -divider <NULL>
add wave -noupdate /tb_prga/xrdy
add wave -noupdate /tb_prga/xen
add wave -noupdate -divider tb
add wave -noupdate /tb_prga/xct_addr
add wave -noupdate /tb_prga/xpt_addr
add wave -noupdate /tb_prga/xct_rddata
add wave -noupdate /tb_prga/xpt_rddata
add wave -noupdate /tb_prga/xpt_wrdata
add wave -noupdate /tb_prga/xpt_wren
add wave -noupdate /tb_prga/xs_addr
add wave -noupdate /tb_prga/xs_rddata
add wave -noupdate /tb_prga/xs_wrdata
add wave -noupdate /tb_prga/xs_wren
add wave -noupdate -divider dut
add wave -noupdate /tb_prga/dutp/i
add wave -noupdate /tb_prga/dutp/j
add wave -noupdate /tb_prga/dutp/k
add wave -noupdate /tb_prga/dutp/address
add wave -noupdate /tb_prga/dutp/s_address
add wave -noupdate -divider dut-info
add wave -noupdate /tb_prga/dutp/message_length
add wave -noupdate /tb_prga/dutp/s_idata
add wave -noupdate /tb_prga/dutp/s_jdata
add wave -noupdate /tb_prga/dutp/pad
add wave -noupdate -divider dut-signals
add wave -noupdate /tb_prga/dutp/s_rddata
add wave -noupdate /tb_prga/dutp/s_write_data
add wave -noupdate /tb_prga/dutp/s_write_enable
add wave -noupdate /tb_prga/dutp/p_write_data
add wave -noupdate /tb_prga/dutp/p_write_enable
add wave -noupdate /tb_prga/dutp/pt_rddata
add wave -noupdate /tb_prga/dutp/ct_rddata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 190
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
WaveRestoreZoom {0 ps} {130 ps}
