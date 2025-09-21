//Design Logic Gates using MUX
// 2-to-1 Multiplexer Module
module mux_2_1(
    input [1:0] i,
    input select,
    output y_out    );
    assign y_out = select ? i[1] : i[0];
endmodule

module gates_mux(
    input a, b,
    output nand_out, nor_out );
    wire bbar;
mux_2_1 mbbar({1'b1, 1'b0}, b, bbar);       // Select=0 => 1, Select=1 => 0 // NOT b => bbar
mux_2_1 mnand({1'b1, bbar}, a, nand_out);   // NAND
mux_2_1 mnor ({bbar, 1'b0}, a, nor_out);    // NOR
endmodule




