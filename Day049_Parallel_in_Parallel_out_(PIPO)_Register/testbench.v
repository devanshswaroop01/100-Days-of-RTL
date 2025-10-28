//Testbench: 
`timescale 1ns / 1ps
module pipo_tb;
  reg [3:0] parallel_in;
  reg clk, reset;
  wire [3:0] parallel_out;
  pipo DUT (.clk(clk), .reset(reset), .parallel_in(parallel_in), .parallel_out(parallel_out));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, pipo_tb);
    $monitor("Time=%0t | parallel_in=%b | reset=%b | parallel_out=%b", $time, parallel_in, reset, parallel_out);

    reset = 1; parallel_in = 4'b0001; #10;  // Reset active
    reset = 0; parallel_in = 4'b1010; #10;  // Load 1010
    parallel_in = 4'b1001; #10;
    parallel_in = 4'b0010; #10;
    parallel_in = 4'b1111; #10;
    reset = 1; #10;                         // Reset again
    reset = 0; parallel_in = 4'b1100; #10;  // Load 1100
    parallel_in = 4'b1000; #10;
    $finish;
  end 
endmodule
