`timescale 1ns / 1ps
module factorial(
    input      [3:0]  n,
    output reg [31:0] result);

    function automatic [31:0] fact;
        input [3:0] num;
        integer i;
        begin
            fact = 1;          // start value
            for (i = 2; i <= num; i = i + 1)
                fact = fact * i;
        end
    endfunction
    always @(n)
        result = fact(n);
endmodule



