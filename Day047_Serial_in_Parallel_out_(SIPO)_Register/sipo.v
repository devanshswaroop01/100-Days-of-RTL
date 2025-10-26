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


// 4-bit Serial-In Parallel-Out (SIPO) Register
module sipo(
    input clk, reset, serial_in,
    output [3:0] parallel_out );

    // Shift Register Chain
    D_flipflop D3 (.d(serial_in),        .clk(clk), .reset(reset), .Q(parallel_out[3]));
    D_flipflop D2 (.d(parallel_out[3]),  .clk(clk), .reset(reset), .Q(parallel_out[2]));
    D_flipflop D1 (.d(parallel_out[2]),  .clk(clk), .reset(reset), .Q(parallel_out[1]));
    D_flipflop D0 (.d(parallel_out[1]),  .clk(clk), .reset(reset), .Q(parallel_out[0]));
endmodule





