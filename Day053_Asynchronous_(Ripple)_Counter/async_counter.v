//D Flipflop 
`timescale 1ns/1ps
module d_ff (
    input clk, reset, d,
    output reg q);

always @(posedge clk or posedge reset) begin
        if (reset)
                q <= 1'b0;
        else
                q <= d;
    end
endmodule

//T Flipflop
module t_ff (
    input clk, reset, t,
    output q );
    wire d;
    assign d = t ^ q;
// D = T XOR Q (toggle logic)
d_ff dff_inst ( .clk(clk), .reset(reset), .d(d), .q(q));
endmodule

//Asyncronous Down Counter Module
module async_ripple (
    input clk, reset,
    output [3:0] q );

    // Stage 0 toggles every clock
t_ff tff0 (.clk(clk), .reset(reset), .t(1'b1), .q(q[0]));

    // Stage 1 toggles when q[0] rises
t_ff tff1 (.clk(q[0]), .reset(reset), .t(1'b1), .q(q[1]));

    // Stage 2 toggles when q[1] rises
 t_ff tff2 (.clk(q[1]),.reset(reset),.t(1'b1), .q(q[2]));

    // Stage 3 toggles when q[2] rises
 t_ff tff3 (.clk(q[2]), .reset(reset), .t(1'b1), .q(q[3]));
endmodule

