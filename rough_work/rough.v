module clk_divider_8(
    input clk, 
    output sck, 
    input en);
  
  reg [2:0]divider;

  always@(posedge clk or negedge en)begin
  if(!en)
    divider <= 0;
  else
    divider <= divider+1;
  end
  assign sck = divider[2];
endmodule
