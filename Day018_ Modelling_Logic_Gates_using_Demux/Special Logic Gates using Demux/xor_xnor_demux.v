 // 1x2 demux
 `timescale 1ns / 1ps
module demux_1_2(
    input  sel,
    input  i,
    output y0, y1);
    assign {y0, y1} = sel ? {1'b0, i} : {i, 1'b0};
endmodule

// xor and xnor using 1x2 demux
module demux__gates(
    input  a, b,
    output xor_g, xnor_g);
    wire [3:0] w;

    // Using demux to generate partial signals
    demux_1_2 demux1 (.sel(b), .i(~a), .y0(w[0]), .y1(w[1]));
    demux_1_2 demux2 (.sel(b), .i(a),  .y0(w[2]), .y1(w[3]));

    assign xor_g  = w[1] | w[2];  // A'B + AB'
    assign xnor_g = w[0] | w[3];  // A'B' + AB

endmodule
