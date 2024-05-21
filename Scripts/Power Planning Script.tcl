open_block /home/vlsi/Desktop/ASIC_Final_Project/PnR/I2C_Final.dlib:i2c_master_top.design
link_block

# copy block to a new block to work on it
copy_block -from_block I2C_Final.dlib:i2c_master_top.design -to_block power_plan_1
current_block power_plan_1.design

# remove ignored layer M8
report_ignored_layers
remove_ignored_layers -all -max_routing_layer -min_routing_layer
report_ignored_layers

set_app_option -name plan.pgroute.auto_connect_pg_net -value true
set_app_option -name plan.pgroute.connect_user_route_shapes -value true
#set_app_option -name plan.pgroute.disable_floating_removal -value true
set_app_option -name plan.pgroute.disable_trimming -value true

create_net -power GVDD
create_net -ground GVSS

# hierarchical [include top module + sub modules]
connect_pg_net -net GVDD [get_pins -hierarchical "*/VDD"]
connect_pg_net -net GVSS [get_pins -hierarchical "*/VSS"]

# create_pg_ring_pattern ring1  -horizontal_layer M9  -vertical_layer M8  -horizontal_width 3.0 -vertical_width 3.0  -vertical_spacing 1.0

# set_pg_strategy s1 -core -pattern {{name: ring1}{nets: {GVDD GVSS}}}

# compile_pg -strategies s1

# create_pg_mesh_pattern mesh1 -layers {{{horizontal_layer: M9} {width: 3} {pitch: 40}}
# {{vertical_layer: M8} {width: 3} {pitch: 40}}}

# set_pg_strategy s_top -core -pattern {{name: mesh1} {nets: {GVDD GVSS}}}

# compile_pg -strategies s_top

# create_pg_std_cell_conn_patter std_pat1 -layers {M1}

# set_pg_strategy s_std_cells -core -pattern { {name: std_pat1} {nets: {GVDD GVSS}}}

# compile_pg -strategies s_std_cells


create_pg_ring_pattern ring_pattern -horizontal_layer M9    -horizontal_width {3} -horizontal_spacing {1}     -vertical_layer M8 -vertical_width {3}     -vertical_spacing {1} 

set_pg_strategy core_ring -core -pattern \
    {{pattern: ring_pattern}{nets: {GVDD GVSS}}{offset: {0.6 0.6}}} \
    -extension {{stop: innermost_ring}}

compile_pg -strategies core_ring


## PG MESH CREATION

create_pg_mesh_pattern pg_mesh1    -parameters {w1 p1 w2 p2 f t}    -layers {{{vertical_layer: M8} {width: @w1} {spacing: interleaving}         {pitch: @p1} {offset: @f} {trim: @t}}            {{horizontal_layer: M9 } {width: @w2} {spacing: interleaving}         {pitch: @p2} {offset: @f} {trim: @t}}}


set_pg_strategy s_mesh1 \
   -pattern {{pattern: pg_mesh1} {nets: {GVDD GVSS GVSS GVDD}} \
{offset_start: 5 5} {parameters: 3 40 3 40 5 false}} \
   -core -extension {{stop: outermost_ring}}


compile_pg -strategies s_mesh1


## S T A N D A R D    C E L L    R A I L    I N S E R T I O N
create_pg_std_cell_conn_pattern     std_cell_rail      -layers {M1}     -rail_width 0.06

set_pg_strategy rail_strat -core \
    -pattern {{name: std_cell_rail} {nets: GVDD GVSS} }
    
compile_pg -strategies rail_strat    

save_block