//4 Bit Divider 
`timescale 1ns / 1ps
module divider(
    input  [3:0] dividend, divisor,
    output reg [3:0] quotient, remainder
);
    always @ (dividend, divisor) begin
        quotient  = 0;
        remainder = dividend;
        while (remainder >= divisor) begin
            remainder = remainder - divisor;
            quotient  = quotient + 1;
        end
    end
endmodule















