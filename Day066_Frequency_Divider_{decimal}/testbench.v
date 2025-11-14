`timescale 1ns / 1ps
module test_bench;
reg clk, reset;
wire new_clk;
freq_div dut(clk, reset, new_clk);

initial begin
clk= 1'b0;
forever #10 clk= ~clk;
end
  
initial begin
reset= 1'b1; #20
reset= 1'b0;
  $dumpfile("waveform.vcd");
  $dumpvars(0, test_bench);
  $monitor("clk: %b  reset: %b  new clk: %b ",clk, reset, new_clk);
#200 $finish;
end
endmodule
