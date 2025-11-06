`timescale 1ns / 1ps
// T Flip-Flop Module
module T_FF (
    input T, clk, clr,
    output reg Q );

    always @(posedge clk or negedge clr) begin
        if (!clr)
            Q <= 1'b0;      // Asynchronous clear (active low)
        else if (T)
            Q <= ~Q;
        else
            Q <= Q;         //Toggle
    end
endmodule

// BCD Counter Module
module bcd_counter(
    input clk, reset,
    output [3:0] Q );
    wire clr;                   // Active low clear signal
    wire T0, T1, T2, T3;

    // Define T-input logic for each flip-flop
    assign T0 = 1'b1;                  // Always toggle
    assign T1 = Q[0];                  // Toggle when Q0=1
    assign T2 = Q[1] & Q[0];           // Toggle when Q1 & Q0=1
    assign T3 = Q[2] & Q[1] & Q[0];    // Toggle when Q2 & Q1 & Q0=1

    // Generate active low clear: CLR = ~(Q3 & Q1)
    assign clr = ~(Q[3] & Q[1]) & ~reset;

    // Instantiate 4 T flip-flops Modules
    T_FF tff0 (.T(T0), .clk(clk), .clr(clr), .Q(Q[0]));
    T_FF tff1 (.T(T1), .clk(clk), .clr(clr), .Q(Q[1]));
    T_FF tff2 (.T(T2), .clk(clk), .clr(clr), .Q(Q[2]));
    T_FF tff3 (.T(T3), .clk(clk), .clr(clr), .Q(Q[3]));

endmodule
















