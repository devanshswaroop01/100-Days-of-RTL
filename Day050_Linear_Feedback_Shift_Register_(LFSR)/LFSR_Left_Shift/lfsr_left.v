//Linear Feedback Shift Register( Left Shift)
`timescale 1ns / 1ps
module lfsr_left (
    input clk, reset,
    output [7:0] lfsr_out );
    reg [7:0] data;
    wire feedback;
    assign feedback = data[7] ^ data[5] ^ data[3] ^ data[1];
    always @(posedge clk or posedge reset)
     begin
        if (reset)
            data <= 8'h10000101;  // Seed value
        else
        data <= {data[6:0],feedback }; // LEFT shift with feedback into LSB
    end
  assign lfsr_out = data;
endmodule














