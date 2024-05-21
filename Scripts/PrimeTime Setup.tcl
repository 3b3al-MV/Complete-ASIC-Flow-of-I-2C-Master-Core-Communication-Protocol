# Prime Time Setup
# Change the directories acc. to your project loaction

set Design_name i2c_master_top

set search_path /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm

set target_library $search_path/Digital_Standard_cell_Library/synopsys/models/saed90nm_max_lth.db

set link_path "* $target_library"

set Netlist_files  /home/vlsi/Desktop/ASIC_Final_Project/PnR/output/i2c_master_top_for_i2c_v.v

set SPEF_files     /home/vlsi/Desktop/ASIC_Final_Project/PnR/output/i2c_master_top.out.spef.spef_scenario 

set constrains_file  /home/vlsi/Desktop/ASIC_Final_Project/PnR/output/i2c_master_top.out.sdc


