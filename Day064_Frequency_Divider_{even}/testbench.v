//Testbench
`timescale 1ns / 1ps
module test_bench;
    reg clk, reset;
    wire clk_by4;
   freq_div_by4 dut(clk, reset, clk_by4);
  
    initial begin
        clk = 1'b0;
     forever #10 clk = ~clk;// 20ns period => 50 MHz
    end
  
 initial begin
      $dumpfile("waveform.vcd"); 
      $dumpvars(0, test_bench );
      $monitor("\t\t clk: %d reset: %d clk_by4: %b ", clk,reset,clk_by4);
        reset = 1'b1;
        #20 reset = 1'b0;
        #220 $finish;
    end
endmodule
