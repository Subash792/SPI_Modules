# read modules from Verilog file
read_verilog rough.v

# elaborate design hierarchy
hierarchy -check -top clk_divider_8

# translate processes to netlists
proc

# remove unused cells and wires
clean

show

# mapping to internal cell library
techmap

# mapping flip-flops to NangateOpenCellLibrary_typical.lib 
# for eg. always block
dfflibmap -liberty toy.lib 

# mapping logic to NangateOpenCellLibrary_typical.lib 
# for eg. assign block
abc -liberty toy.lib

# Write the current design to a Verilog file
write_verilog -noattr  synth_example.v 
