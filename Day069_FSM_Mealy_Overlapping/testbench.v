`timescale 1ns / 1ps
module fsm_11001_tb;
  reg din, clk, reset;
  wire y;
  fsm_11001 dut ( .din(din), .clk(clk), .reset(reset), .y(y) );
 
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, fsm_11001_tb);
    $monitor("Time=%0t | clk=%b | din=%b | detect(y)=%b", $time, clk, din, y);
    reset = 1; din   = 0;
    #10 reset = 0;
    
    #10 din = 1; 
    #10 din = 1;  
    #10 din = 0;
    #10 din = 0;   
    #10 din = 1; // <-- detection here (11001) y= 1 
    
    #10 din = 1; 
    #10 din = 0; 
    #10 din = 0;
    #10 din = 1;  // <-- another detection y= 1
    
    #10 din = 0; 
    #10 din = 1;
    #10 din = 1;
    #10 din = 0; 
    #10 din = 0;
    #10 din = 1; // <-- another detection y= 1
  #100 $finish;
  end

endmodule

