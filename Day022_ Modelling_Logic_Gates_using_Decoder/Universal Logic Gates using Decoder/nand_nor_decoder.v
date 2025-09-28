
// 2-to-4 decoder
`timescale 1ns / 1ps
module decoder_2_4(
    input  [1:0] i,
    output reg [3:0] y );

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

// nand and nor using decoder
module decoder_nand_nor(
    input  a, b,
    output nand_g, nor_g
);
    wire [3:0] w_nand, w_nor;

    // NAND = ~(A & B)
    decoder_2_4 dec_nand (.i({a,b}), .y(w_nand));
    assign nand_g = ~w_nand[3];  // only high for 11 → invert

    // NOR = ~(A | B)
    decoder_2_4 dec_nor (.i({a,b}), .y(w_nor));
    assign nor_g = ~ (w_nor[1] | w_nor[2] | w_nor[3]); // high only when 00

endmodule

