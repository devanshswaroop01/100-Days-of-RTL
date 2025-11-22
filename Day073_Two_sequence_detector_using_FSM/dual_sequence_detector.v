`timescale 1ns / 1ps
module fsm_101_0110(
    input din, clk, reset,
    output reg y);
    reg [2:0] cst, nst;

    parameter S0 = 3'b000,
              S1 = 3'b001,
              S2 = 3'b010,
              S3 = 3'b011,
              S4 = 3'b100,
              S5 = 3'b101;

    // State Transition Block
    always @(posedge clk) begin
        if(reset)
            cst <= S0;
        else
            cst <= nst;
    end

    // Next-state + Output block 
    always @(cst or din) begin
        case(cst)

            S0: begin
                nst <= (din ? S1 : S2);
                y   <= 1'b0;
            end

            S1: begin
                nst <= (din ? S1 : S3);
                y   <= 1'b0;
            end

            S2: begin
                nst <= (din ? S4 : S2);
                y   <= 1'b0;
            end

            S3: begin
                nst <= (din ? S4 : S2);
                y   <= (din ? 1'b1 : 1'b0);   
            end

            S4: begin
                nst <= (din ? S5 : S3);
                y   <= 1'b0;
            end

            S5: begin
                nst <= (din ? S1 : S3);
                y   <= (din ? 1'b0 : 1'b1);   
            end

            default: begin
                nst <= S0;
                y   <= 1'b0;
            end
        endcase
    end
endmodule
