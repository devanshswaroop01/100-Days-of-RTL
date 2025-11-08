//Testbench:
`timescale 1ns / 1ps
module ring_tb;
parameter N=4;
reg clk, reset;
wire [N-1:0] counter;
ring_counter dut (clk, reset, counter);

initial begin
    clk= 1'b0;
    forever #5 clk= ~clk;
    end
    
initial begin 
    reset = 1;
    #10;
    reset = 0;
    end

initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, ring_tb);
  $monitor("\t\t counter: %d", counter);
    #90 $finish;
end
endmodule
