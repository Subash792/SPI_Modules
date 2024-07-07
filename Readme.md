# Digital Design Project: SPI Master and Slave modules

## Table of Contents

- [Overview](#overview)
- [Initial Release](#initial-release)
  - [Installation](#installation)
  - [Usage](#usage)

## Overview

This project aims at the design and implementation of SPI master and slave modules. The initial aim of the project is to write the RTL code, perform functional simulation. Eventually, it aims at:

1. Performing verification using UVM.
2. Taking the project through the open-source automated RTL -> GDS-II pipeline (OpenLane) to obtain GDS files.
3. Submitting the project to EFabless.

## Initial Release

This release consists of RTL code for SPI slave and a linear testbench for verifying the functionality of the design.

### Installation

1. Download the source files to your local machine.
2. Download Dependencies:
   - a. Icarus Verilog: Open Source HDL compiler and simulator.
   - b. GTK wave: Waveform viewer.

### Usage

After having downloaded the repository to your local machine, you can test/run the design using a simulator of your choice. Alternatively, if you have followed the installation steps:

1. Run the shell script from the command line: `./simulate.sh`
