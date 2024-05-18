onerror {resume}
radix define fixed#12#decimal#signed -fixed -fraction 12 -signed -base signed -precision 6
radix define fixed#16#decimal#signed -fixed -fraction 16 -signed -base signed -precision 6
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/clk
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/rst_n
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/enable
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/real_in
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/imag_in
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/final_theta
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/final_mag
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/data_valid
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/direction
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/y_sign
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/neg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/y_sign_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/neg_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/enable_del
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/directions
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/x
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/y
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/theta
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/arctan
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/directions_reg
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/unfinal_theta
add wave -noupdate -expand -group DUT -radix fixed#12#decimal#signed /vectoring_cordic/unfinal_mag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 214
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
WaveRestoreZoom {0 ns} {941 ns}
