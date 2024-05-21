open_block /home/vlsi/Desktop/ASIC_Final_Project/PnR/I2C_Final.dlib:power_plan_1.design
link_block

copy_block -from_block I2C_Final.dlib:power_plan_1.design -to_block placement_1
current_block placement_1.design

report_qor -summary
report_design -summary
report_utilization

check_design -checks pre_placement_stage

report_lib saed90nm_max_lth

set_voltage 1.08

set_parasitic_parameters -early_spec maxTLU -late_spec minTLU

set_app_options -name place.coarse.continue_on_missing_scandef -value true
# Run 5 stages of placement : .coarse placement  .initial_drc-HFS .running initial optimization .final_place
#  . final_optomization
place_opt
legalize_placement

#View congestion map
report_congestion -rerun_global_router

# check legalizaation of all cells [no overlapping cells ....]
check_legality -verbose

report_utilization

report_qor

save_block




