# Load Quartus II Tcl project package
package require ::quartus::project

# Create project
project_new "rpn" -overwrite

# Assign family, device, and top-level entity
set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE15F23C8
set_global_assignment -name TOP_LEVEL_ENTITY rpn

# Default settings
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"
set_global_assignment -name NUM_PARALLEL_PROCESSORS 8
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files

# Get definitions of files and entities.
source ../scripts/files.tcl

# Set design files. (This adds ALL known .vhdl files.)
foreach ent $entities {
    set file [lsearch -inline -glob $files "*$ent.vhdl"]
    set_global_assignment -name VHDL_FILE $file
}

# Pin assignments. (Source: https://gecko-wiki.ti.bfh.ch/gecko4education:start)
source ../scripts/io_assignment/io_assignment.tcl

# Close project
export_assignments
project_close