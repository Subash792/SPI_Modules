// SPI Master
module spi_master( 
    // Control Signals
    input clk,
    input en,
    output reg ack,
    // Data signals
    input [7:0] data_in,
    output [7:0] data_out,
    // SPI Interface signals
    output sck,
    output cs,
    output mosi,
    input miso
);
    // sck signal generation (using divide by 8 clock divider)
    reg [3:0] divider;
    always@(posedge clk or negedge en)begin
        if(!en)
        divider <= 0;
        else
        divider <= divider+1;
    end
    assign sck = divider[3];
    
    // cs signal 
    assign cs = en;

    // Logic for detecting rising and falling edges of SCK signal.
    reg [2:0]sckr;
    always@(posedge clk)
      sckr <= {sckr[1:0],sck};
    wire sck_rising_edge = (!sckr[2]) & sckr[1];
    wire sck_falling_edge = sckr[2] & (!sckr[1]);

    // en signal
    reg [2:0]enr;
    always@(posedge clk)
      enr <= {enr[1:0],en};
    assign en_rising_edge = (!enr[2]) & enr[1];
    assign en_falling_edge = enr[2] & (!enr[1]); 
    assign en_active = enr[1];

    // Synchronizing MISO data to SCK clock
    reg [1:0] MISOr;  
    always @(posedge clk) 
      MISOr <= {MISOr[0], miso};
    wire MISO_data = MISOr[1];

    // Receiving data (MSB first)
    reg [2:0]bit_cnt; // 3 bit counter
    reg [7:0] r_byte; // received byte
    
    always@(posedge clk)
        begin
            if(!en)
                bit_cnt <= 3'b000;
            else
                if(sck_rising_edge)
                    begin
                        bit_cnt <= bit_cnt + 3'b001;
                        r_byte <= {r_byte[6:0],MISO_data};
                    end
        end

    always@(posedge clk)
        ack <= (en)&&(sck_rising_edge)&&(bit_cnt == 3'b111);

// if ack bit is high, output the data recieved.
// ack bit is goes high only for one clock cycle, in that clk cycle, the received data must be output.
    assign data_out = ack? r_byte: (8'bz);
    
    // Sending Data
    reg [7:0] s_data;
    always@(posedge clk)
    begin
        if(en)
        begin
        if(en_rising_edge)
            s_data<=data_in;
        
        if(sck_falling_edge)
        begin
            if(bit_cnt == 0)
            s_data<=data_in;
            else
            s_data<={s_data[6:0], s_data[7]};
        end

        end
    end

    assign mosi = (en)?s_data[7]:1'bz;
    
endmodule