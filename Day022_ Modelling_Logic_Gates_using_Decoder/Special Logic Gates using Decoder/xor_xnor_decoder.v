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

// xor and xnor using decoder
module decoder_xor_xnor(
    input  a, b,
    output xor_g, xnor_g);
    wire [3:0] w;
    decoder_2_4 gate (
        .i({a,b}),
        .y(w));

    assign xor_g  = w[1] | w[2];  // A'B + AB'
    assign xnor_g = w[0] | w[3];  // A'B' + AB
endmodule
