#! /bin/bash

# Shell scrip to build and simulate the project
iverilog -o simv_master -c build_list_master.txt # Compile the source files
vvp simv_master # simulate
gtkwave results_m.vcd # Open the waveform viewer.

iverilog -o simv_slave -c build_list_slave.txt # Compile the source files
vvp simv_slave # simulate
gtkwave results_s.vcd # Open the waveform viewer.

