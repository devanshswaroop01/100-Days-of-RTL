module Palindrome(
    input  [15:0] number,
    output reg    is_palindrome);
    localparam PALINDROME     = 1'b1;
    localparam NOT_PALINDROME = 1'b0;

    always @(*) begin
        is_palindrome = check_palindrome(number);
        
        if(is_palindrome)
            $display("%d is a palindrome", number);
        else
            $display("%d is NOT a palindrome", number);
    end

    function check_palindrome;
        input [15:0] num;
        reg [3:0] d0, d1, d2, d3, d4;  
        reg [15:0] temp;
      
        begin
            temp = num;
            d0 = temp % 10;   temp = temp / 10;
            d1 = temp % 10;   temp = temp / 10;
            d2 = temp % 10;   temp = temp / 10;
            d3 = temp % 10;   temp = temp / 10;
            d4 = temp % 10;

            // Check 5-digit palindrome patterns
            if ((d0 == d4) && (d1 == d3))
                check_palindrome = PALINDROME;
            else
                check_palindrome = NOT_PALINDROME;
        end
    endfunction
endmodule


