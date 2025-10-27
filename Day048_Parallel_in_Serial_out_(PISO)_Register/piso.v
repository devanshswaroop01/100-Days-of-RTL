// D Flip-Flop with Synchronous Reset
`timescale 1ns / 1ps
module D_flipflop(
input d, clk, reset,
output reg Q);

  always @(posedge clk) begin
    if (reset)
      Q <= 1'b0;
    else
      Q <= d;
  end
endmodule

// 4-bit Parallel-In Serial-Out (PISO) Register
module piso(
input clk,
input reset,
input shift, // shift = 1 → shift mode, shift = 0 → load mode
input [3:0] parallel_in,
output serial_out );
wire q0, q1, q2, q3;
wire d0, d1, d2, d3;

  // AND-OR logic :
  assign d3 = (shift) ? q2 : parallel_in[3];
  assign d2 = (shift) ? q1 : parallel_in[2];
  assign d1 = (shift) ? q0 : parallel_in[1];
  assign d0 = (shift) ? serial_out : parallel_in[0];

  // Shift Register Chain
  D_flipflop FF0 (.d(d0), .clk(clk), .reset(reset), .Q(q0));
  D_flipflop FF1 (.d(d1), .clk(clk), .reset(reset), .Q(q1));
  D_flipflop FF2 (.d(d2), .clk(clk), .reset(reset), .Q(q2));
  D_flipflop FF3 (.d(d3), .clk(clk), .reset(reset), .Q(q3));

assign serial_out = q3; // MSB is shifted out
endmodule
