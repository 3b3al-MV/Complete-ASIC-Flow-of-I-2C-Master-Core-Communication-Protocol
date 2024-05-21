set design i2c_master_top

set_app_var search_path /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models

set_app_var target_library saed90nm_max_lth.db
set_app_var link_library "$target_library"

sh rm -rf work
sh mkdir -p work
define_design_lib work -path ./work

analyze -library work -format verilog {../RTL/i2c_master_top.v}
elaborate $design -lib work

current_design
check_design -summary

source -echo -verbose ./cons/Constraints.tcl

link
set_fix_multiple_port_nets -all

compile_ultra -exact_map

report_area > ./report/synth_area.rpt
report_cell > ./report/synth_cells.rpt
report_qor  > ./report/synth_qor.rpt
report_resources > ./report/synth_resources.rpt
report_timing -max_paths 10 > ./report/synth_timing.rpt

write_sdc  output/${design}.sdc

define_name_rules  no_case -case_insensitive
change_names -rule no_case -hierarchy
change_names -rule verilog -hierarchy

set verilogout_no_tri	 true
set verilogout_equation  false

write -hierarchy -format verilog -output output/${design}.v 
write -f ddc -hierarchy -output output/${design}.ddc