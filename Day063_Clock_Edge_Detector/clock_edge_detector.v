//Clock edge detector
`timescale 1ns / 1ps
module clk_edge_detector(
    input clk, temp_clk, 
    output posedge_detect, negedge_detect, dualedge_detect );

// Requires previous state storage 
assign posedge_detect= clk & (~temp_clk);
 //0 → 1

  assign negedge_detect= (~clk) & temp_clk; 
// 1 → 0

 assign dualedge_detect= clk ^ temp_clk; 
//any change
endmodule















