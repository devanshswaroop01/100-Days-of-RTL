`timescale 1ns / 1ps
module up_down_counter
(clk, reset, upordown, count);
    parameter N = 4; 
    input clk, reset, upordown;
    output reg [N-1:0] count;

    always @ (posedge clk) begin
        if (reset == 1)
        count <= 0;

        else if (upordown == 1)     // Up mode

            if (count == 2*N - 1)
                count <= 0;         // wrap around
            else
                count <= count + 1; // increment counter

        else                        // Down mode

            if (count == 0)
                count <= 2*N - 1;   // wrap around
            else
                count <= count - 1; // decrement counter
    end
endmodule







