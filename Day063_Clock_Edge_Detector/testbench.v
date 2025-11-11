//Testbench:
`timescale 1ns / 1ps
module clk_edge_detector_tb;
reg clk, temp_clk;
wire posedge_detect, negedge_detect, dualedge_detect;
clk_edge_detector dut( clk,  temp_clk,  posedge_detect, negedge_detect, dualedge_detect );

initial begin 
clk= 1'b0;
forever #5 clk<= ~clk;
end

initial begin
temp_clk= 1'b0;
forever #5.5 temp_clk<= ~temp_clk;
end

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, clk_edge_detector_tb);
    $monitor("clock: %b  posedge: %b egedge: %b  dualedge: %b", clk, posedge_detect, negedge_detect, dualedge_detect);
#30 $finish;
end
endmodule
