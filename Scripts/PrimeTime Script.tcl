# PT script

source PrimeTime Setup.tcl

# Netlist Reading from ICC2
read_verilog $Netlist_files
link_design

# Reading parasitics & constrains
read_parasitics  $SPEF_files
read_sdc $constrains_file
update_timing

# Checks 

report_timing
report_analysis_coverage
report_global_timing
report_clocks

#If there were any violations, use the follwoing command
#fix_eco_timing -type hold -method insert_buffer -buffer_list {NBUFF2 NBUFFX4 NBUFFX8 NBUFFX16 NBUFFX32}

set report_dir "/home/vlsi/Desktop/ASIC_Final_Project/PnR/PrimeTime/Reports"
sh mkdir -p $report_dir

# Report timing
set timing_report_file "$report_dir/report_timing.rpt"
report_timing > $timing_report_file

# Report analysis coverage
set analysis_coverage_report_file "$report_dir/report_analysis_coverage.rpt"
report_analysis_coverage > $analysis_coverage_report_file

# Report global timing
set global_timing_report_file "$report_dir/report_global_timing.rpt"
report_global_timing > $global_timing_report_file

# Report clocks
set clocks_report_file "$report_dir/report_clocks.rpt"
report_clocks > $clocks_report_file

