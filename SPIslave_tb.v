// Code your testbench here
// or browse Examples
`timescale 1ns/1ps 
module spi_slave_tb;
  reg clk;
  reg sck;
  reg mosi;
  reg cs;
  
  reg [7:0] ds;
  
  wire miso;
  wire [7:0]dr;
  wire ack;
  
  spi_slave s1(clk, sck, mosi, miso, cs, dr, ds, ack);
  
  initial
    begin
      $dumpfile("results.vcd");
      $dumpvars;
      clk = 1'b1;
      cs = 1'b1;
      sck = 1'b0;
      mosi = 1'b1;
      ds = 8'b10101010;
    end
  
  initial
  	forever #0.500 clk <= ~clk;
  
  initial 
    forever #10 sck <= ~sck;
  
  initial
    #5 cs = 1'b0;
  
  initial
    #90 mosi = 1'b0;
 
  initial #200 $finish;
  
  
endmodule
