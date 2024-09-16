#! /bin/bash

# Shell scrip to build and simulate the rough project
iverilog -o simv -c build_list_rough.txt # Compile the source files
vvp simv # simulate
gtkwave results_rough.vcd # Open the waveform viewer.