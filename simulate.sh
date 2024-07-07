#! /bin/bash

# Shell scrip to build and simulate the project
iverilog -o simv -c build_list.txt # Compile the source files
vvp simv # simulate
gtkwave results.vcd # Open the waveform viewer.
 