source ./Script/setup.tcl
open_block /home/vlsi/Desktop/ASIC_Final_Project/PnR/I2C_Final.dlib:i2c_master_top.design
link_block

set_parasitic_parameters -late_spec maxTLU -early_spec minTLU

initialize_floorplan -core_utilization 0.6 -side_ratio {1 1} -core_offset {10}

set_app_options -name place.coarse.fix_hard_macros -value false
set_app_options -name plan.place.auto_create_blockages -value auto
create_placement -floorplan

set_app_options -name plan.pins.incremental -value false -block [current_block]
place_pins -self