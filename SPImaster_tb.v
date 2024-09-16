`timescale 1ns/1ps 
module SPI_master_tb;
    // Control signals
    reg clk;
    reg en;
    wire ack;
    // Data signals
    wire [7:0] data_recevied;
    reg [7:0] data_sent;
    // SPI inteface signals
    wire sck;
    wire mosi;
    reg miso;
    wire cs;

    // Instantiation
    spi_master master(clk, en, ack, data_sent, data_recevied, sck, cs, mosi, miso);

    // Signal initiation and monitoring
      initial
    begin
      $dumpfile("results_m.vcd");
      $dumpvars;
      clk = 1'b0;
      en = 1'b0;
      data_sent = 8'b1011_1001;
      miso = 1'b1;
    end

    initial
        forever
            #1 clk <= ~clk;
    
    initial
        #12.5 en <= 1'b1;

    initial
        #100 miso <= 1'b0;

    initial
        #500 $finish;

endmodule