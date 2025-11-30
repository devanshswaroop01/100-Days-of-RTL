 module armstrong(
    input  [8:0] number,     
    output reg   is_armstrong );

    localparam ARMSTRONG     = 1'b1,
               NOT_ARMSTRONG = 1'b0;

    always @(*) begin
        is_armstrong = check_armstrong(number);
        if (is_armstrong)
            $display("%d is an Armstrong number", number);
        else
            $display("%d is NOT an Armstrong number", number);
    end

  
    function check_armstrong;
        input [8:0] num;
        reg [3:0] d0, d1, d2;   
        reg [8:0] sum;
        reg [8:0] temp;

        begin
            temp = num;
            d0 = temp % 10;       temp = temp / 10;   // units
            d1 = temp % 10;       temp = temp / 10;   // tens
            d2 = temp % 10;                           // hundreds
            sum = (d0*d0*d0) + (d1*d1*d1) + (d2*d2*d2);

            if (sum == num)
                check_armstrong = ARMSTRONG;
            else
                check_armstrong = NOT_ARMSTRONG;
        end
      endfunction
    endmodule
