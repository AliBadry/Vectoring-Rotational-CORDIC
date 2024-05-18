onerror {resume}
radix define fixed#12#decimal#signed -fixed -fraction 12 -signed -base signed -precision 6
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/clk
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/rst_n
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/enable
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/theta_in
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/mag_in
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/final_real
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/final_imag
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/data_valid
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/direction
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/x_cond
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/x_cond_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/enable_del
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/mag_in_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/directions
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed -childformat {{{/rotation_cordic/x[0]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[1]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[2]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[3]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[4]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[5]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[6]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[7]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[8]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[9]} -radix fixed#12#decimal#signed} {{/rotation_cordic/x[10]} -radix fixed#12#decimal#signed}} -expand -subitemconfig {{/rotation_cordic/x[0]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[1]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[2]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[3]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[4]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[5]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[6]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[7]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[8]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[9]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/x[10]} {-height 15 -radix fixed#12#decimal#signed}} /rotation_cordic/x
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed -childformat {{{/rotation_cordic/y[0]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[1]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[2]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[3]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[4]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[5]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[6]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[7]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[8]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[9]} -radix fixed#12#decimal#signed} {{/rotation_cordic/y[10]} -radix fixed#12#decimal#signed}} -expand -subitemconfig {{/rotation_cordic/y[0]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[1]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[2]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[3]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[4]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[5]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[6]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[7]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[8]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[9]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/y[10]} {-height 15 -radix fixed#12#decimal#signed}} /rotation_cordic/y
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed -childformat {{{/rotation_cordic/theta[0]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[1]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[2]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[3]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[4]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[5]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[6]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[7]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[8]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[9]} -radix fixed#12#decimal#signed} {{/rotation_cordic/theta[10]} -radix fixed#12#decimal#signed}} -expand -subitemconfig {{/rotation_cordic/theta[0]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[1]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[2]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[3]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[4]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[5]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[6]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[7]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[8]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[9]} {-height 15 -radix fixed#12#decimal#signed} {/rotation_cordic/theta[10]} {-height 15 -radix fixed#12#decimal#signed}} /rotation_cordic/theta
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/arctan
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/directions_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/unfinal_real
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /rotation_cordic/unfinal_imag
add wave -noupdate -radix fixed#12#decimal#signed /rotation_cordic/pi
add wave -noupdate -radix fixed#12#decimal#signed /rotation_cordic/half_pi
add wave -noupdate -radix fixed#12#decimal#signed /rotation_cordic/cos_val
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 221
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {975 ns}
