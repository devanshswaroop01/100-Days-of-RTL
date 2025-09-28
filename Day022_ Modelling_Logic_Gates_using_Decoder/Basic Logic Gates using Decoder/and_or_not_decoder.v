// 2-to-4 cecoder
`timescale 1ns / 1ps
module decoder_2_4(
    input  [1:0] i,
    output reg [3:0] y);

    always @(i) begin
        y = 4'b0000;
        case(i)
            2'b00: y[0] = 1'b1;
            2'b01: y[1] = 1'b1;
            2'b10: y[2] = 1'b1;
            2'b11: y[3] = 1'b1;
        endcase
    end
endmodule

// and, or, not using decoder
module decoder_and_or_not(
    input  a, b,
    output and_g, or_g, not_g);
    wire [3:0] w_and, w_or, w_not;

    // AND gate: output high only for 11
    decoder_2_4 dec_and (.i({a,b}), .y(w_and));
    assign and_g = w_and[3];

    // OR gate: output high for any input except 00
    decoder_2_4 dec_or (.i({a,b}), .y(w_or));
    assign or_g = w_or[1] | w_or[2] | w_or[3];

    // NOT gate: output high for input 0
    decoder_2_4 dec_not (.i({a,1'b0}), .y(w_not)); 
    assign not_g = w_not[0];

endmodule