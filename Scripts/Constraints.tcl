# Reset Design
reset_design


# Clock Constraints for I2C
set CLOCK_NAME wb_clk_i 
create_clock -name wb_clk_i -period 2 [get_ports wb_clk_i]
set_input_delay -max 0.2 -clock [get_clocks wb_clk_i] [remove_from_collection [all_inputs] [get_ports wb_clk_i]]
set_output_delay -max 0.2 -clock [get_clocks wb_clk_i] [all_outputs]
set RISE_TRANSITION 0.2
set FALL_TRANSITION 0.2
set_clock_uncertainty -setup 0.3 [get_clocks $CLOCK_NAME] 
set_clock_transition -rise $RISE_TRANSITION [get_clocks $CLOCK_NAME] 
set_clock_transition -fall $FALL_TRANSITION [get_clocks $CLOCK_NAME]
set_clock_latency 0.25 [get_clocks wb_clk_i]
set_max_area 0


# False Path Constraints for I2C
# set_false_path -from [get_clocks wb_clk_i] -to [get_clocks *]
# set_false_path -hold -from [remove_from_collection [all_inputs] [get_ports wb_clk_i]]
# set_false_path -hold -to [all_outputs]

# Library Settings and Wire Load Model
set_min_library saed90nm_max_lth.db -min_version saed90nm_min_nt.db
set_wire_load_model -name "8000" -library saed90nm_max_lth
set_wire_load_mode enclosed

# Load Constraints
set_load -max [expr {2 * [load_of saed90nm_max_lth/NBUFFX8/INP]}] [all_outputs]

# Driving Cell for I2C Clock
set_driving_cell -no_design_rule -max -lib_cell TNBUFFX1 [remove_from_collection [all_inputs] [get_ports wb_clk_i]]

# Clock Constraints for Additional Clock
# create_clock -period 10 -name V_Clk
# set_input_delay -max 1 -clock V_Clk [get_ports wb_stb_i ]
# set_output_delay -max 1 -clock V_Clk [get_ports wb_ack_o]

# Grouping Paths
group_path -name INPUTS -from [remove_from_collection [all_inputs] [get_ports wb_clk_i]]
group_path -name OUTPUTS -to [all_outputs]
group_path -name COMB -from [all_inputs] -to [all_outputs]
