create_workspace -flow exploration -technology /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/process/astro/tech/astroTechFile.tf NDM_Final_Project
change_selection [get_workspaces {NDM_Final_Project}]
set_app_options -list {lib.workspace.keep_all_physical_cells {true}}
set_app_options -list {lib.workspace.save_design_views {true}}
set_app_options -list {lib.workspace.save_layout_views {true}}
read_db { /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/synopsys/models/saed90nm_max_lth.db }
change_selection [get_workspaces {NDM_Final_Project}]
read_lef /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/lef/saed90nmEditted.lef
change_selection [get_workspaces {NDM_Final_Project}]
change_selection [get_libs {saed90nmEditted}]
current_block saed90nmEditted:AND2X1.design
group_libs
process_workspaces  -directory /home/vlsi/Desktop/ASIC_Final_Project/ndm
change_selection [get_workspaces {NDM_Final_Project}]
create_workspace -flow exploration -technology /home/vlsi/Desktop/ASIC_Final_Project/StandardCell/SAED_EDK90nm/Digital_Standard_cell_Library/process/astro/tech/astroTechFile.tf NDM_Final_Project