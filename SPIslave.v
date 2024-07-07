// Code your design here
module spi_slave (
    input clk,

    input sck,
    input mosi,
    output miso,
    input cs,

    output [7:0] dr, 
    input [7:0] ds,
    output ack  
);

// Write a logic for detecting rising and falling edges of SCK
// I understood why we can't do this detection with a single ff, but why can't we do away with 2? and why use 3?

  reg [2:0]sckr;
    always@(posedge clk)
      sckr <= {sckr[1:0],sck};
    wire sck_rising_edge = (!sckr[2]) & sckr[1];
    wire sck_falling_edge = sckr[2] & (!sckr[1]);

//  Similarly for detecting rising and falling edges on cs

  reg [2:0]csr;
    always@(posedge clk)
      csr <= {csr[1:0],cs};
    wire cs_rising_edge = (!csr[2]) & csr[1];  // when this is asserted message stops
    wire cs_falling_edge = csr[2] & (!csr[1]); // when this is asserted message starts
    wire cs_active = ~csr[1];

// Synchronising mosi
    reg [1:0] MOSIr;  
    always @(posedge clk) 
      MOSIr <= {MOSIr[0], mosi};
    wire MOSI_data = MOSIr[1];

// Receiving data (MSB first)
    reg [2:0]bit_cnt; // 3 bit counter
    reg [7:0] r_byte; // received byte
    reg ack;
    
    always@(posedge clk)
        begin
            if(!cs_active)
                bit_cnt <= 3'b000;
            else
                if(sck_rising_edge)
                    begin
                        bit_cnt <= bit_cnt + 3'b001;
                        r_byte <= {r_byte[6:0],MOSI_data};
                    end
        end

    always@(posedge clk)
        ack <= (cs_active)&&(sck_rising_edge)&&(bit_cnt == 3'b111);

// if ack bit is high, output the data recieved.
// ack bit is goes high only for one clock cycle, in that clk cycle, the received data must be output.
    assign dr = ack? r_byte: (8'bz);
    
// Sending data
  reg [7:0]MISO_data;
    always@(posedge clk)
        if(cs_active)
            begin
                if(cs_falling_edge)
                    MISO_data <= ds;
                else
                begin
                    if(sck_falling_edge)
                        begin
                          if(bit_cnt == 3'b000)
                            MISO_data <= ds;
                          else
                          	MISO_data <= MISO_data<<1;
                        end
                end     
            end
    
    assign miso = cs_active? MISO_data[7]: 1'bz;

endmodule
