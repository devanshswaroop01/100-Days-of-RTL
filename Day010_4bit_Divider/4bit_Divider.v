`timescale 1ns / 1ps
module divider(
    input  signed [3:0] dividend, divisor,  
    output reg signed  [3:0] quotient,      
    output reg signed  [3:0] remainder );       

    always @ (dividend, divisor) begin
        quotient  = 0;
        remainder = dividend;
		   //divide by zero
        if (divisor == 0) begin
            quotient  = 0;          
            remainder = dividend;  
        end 

        else begin
            //  absolute values 
            reg [3:0] abs_dividend, abs_divisor, temp_rem;
            abs_dividend = (dividend < 0) ? -dividend : dividend;
            abs_divisor  = (divisor  < 0) ? -divisor  : divisor;
            // iterative subtraction loop 
            temp_rem = abs_dividend;
            quotient = 0;
            while (temp_rem >= abs_divisor) begin
                temp_rem  = temp_rem - abs_divisor;
                quotient  = quotient + 1;
            end
            // sign correction 
            if (dividend[3] ^ divisor[3])
                quotient = -quotient;
                remainder = (dividend < 0) ? -temp_rem : temp_rem;
            end
        end
endmodule
