module tb;
  reg clk;
  reg en;
  wire sck;
  
  clk_divider_8 c(clk, sck, en);
  
   always begin
        #5 clk <= ~clk;
   end
  
  initial
    #120 $finish;
  
  initial
    begin
    clk<= 0;
    en <= 0;
    #1
    en <= 1;
    end
  
  initial
    begin
      $dumpfile("results_rough.vcd");
      $dumpvars;
    end
endmodule
