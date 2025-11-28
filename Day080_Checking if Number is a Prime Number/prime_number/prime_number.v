module prime(
    input  [2:0] number,
    output reg   is_prime );
    localparam PRIME     = 1'b1,
               NOT_PRIME = 1'b0;

    always @(number) begin
        is_prime = check_prime(number);

        if (is_prime)
            $display("%d is a prime number", number);
        else
            $display("%d is NOT a prime number", number);
    end

    function automatic check_prime;
        input [2:0] num;
        integer i;
        begin
            // handle small non-primes
            if (num < 2) begin
                check_prime = NOT_PRIME;
            end
            else begin
                check_prime = PRIME;  // assume prime

                for (i = 2; i <= num/2; i = i + 1) begin
                    if (num % i == 0)
                        check_prime = NOT_PRIME;
                end
                end
            end
          endfunction
      endmodule



 



