//Testbench:
`timescale 1ns / 1ps
module test_bench;
    reg clk;
    reg rst;
    wire clk_0;
    wire clk_90, clk_180,  clk_270;
clk_phase dut( clk, rst, clk_0, clk_90, clk_180, clk_270);

initial begin
clk = 0;
forever #2 clk = ~clk;
end

initial begin
rst = 1;
#5 rst = 0;

    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);
    $monitor("clock: %b  clk_0: %b  clk_90: %b clk_180: %b clk_270: %b",clk, clk_0, clk_90, clk_180, clk_270);
#50 $finish;
end
endmodule
