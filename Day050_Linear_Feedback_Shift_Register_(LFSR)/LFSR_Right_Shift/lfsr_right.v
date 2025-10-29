//Linear Feedback Shift Register( Right Shift)
`timescale 1ns/1ps
module lfsr_right (
    input  clk,
    input  reset,        
    output  [7:0] lfsr_out );
    reg [7:0] data;
    wire feedback;
    assign feedback = data[0] ^ data[2] ^ data[4] ^ data[6];

always @(posedge clk or posedge reset) 
    begin
        if (reset)
            data <= 8'b01001001;    // Seed value
        else
            data <= {feedback, data[7:1]}; // Right shift with feedback into MSB
    end
 assign lfsr_out = data;
endmodule





