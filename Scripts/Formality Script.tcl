set synopsys_auto_setup true
set_svf -append { /home/vlsi/Desktop/ASIC_Final_Project/Syn/default.svf } 
read_verilog -container r -libname WORK -05 { /home/vlsi/Desktop/ASIC_Final_Project/RTL/i2c_master_bit_ctrl.v
                                              /home/vlsi/Desktop/ASIC_Final_Project/RTL/i2c_master_byte_ctrl.v
                                              /home/vlsi/Desktop/ASIC_Final_Project/RTL/i2c_master_defines.v 
                                              /home/vlsi/Desktop/ASIC_Final_Project/RTL/i2c_master_top.v 
                                              /home/vlsi/Desktop/ASIC_Final_Project/RTL/timescale.v }
set_top r:/WORK/i2c_master_top 
read_verilog -container i -libname WORK -05 { /home/vlsi/Desktop/ASIC_Final_Project/Syn/output/i2c_master_top.v } 
read_db { /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max_lth.db } 
set_top i:/WORK/i2c_master_top 
match
verify
analyze_points -all
