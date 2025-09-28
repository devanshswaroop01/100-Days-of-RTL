// 1x2 demux
`timescale 1ns / 1ps
module demux_1_2(
    input  sel,
    input  i,
    output y0, y1);
    assign {y0, y1} = sel ? {1'b0, i} : {i, 1'b0};
endmodule

// nand and nor gates using 1x2 demux
module demux_gates(
    input  a, b,
    output nand_g, nor_g );
    wire na0, na1, na2;
    wire nb0, nb1, nb2, nb3, nb4;

    // NAND = ~(A & B)
    demux_1_2 and_demux ( .sel(b), .i(a), .y0(na0), .y1(na1));
    demux_1_2 not_demux (.sel(na1), .i(1'b1), .y0(nand_g), .y1(na2));

    // NOR = ~(A | B) = ~a & ~b
    demux_1_2 not_a (.sel(a), .i(1'b1), .y0(nb0), .y1(nb1)); 
    demux_1_2 not_b (.sel(b), .i(1'b1), .y0(nb2), .y1(nb3)); 
    demux_1_2 and_inv (.sel(nb2), .i(nb0), .y0(nb4), .y1(nor_g));
endmodule

