//testbench:
`timescale 1ns / 1ps
module tb_demux_gates;
    reg a, b;
    wire nand_out, nor_out;
    demux_gates dut (
        .a(a),
        .b(b),
        .nand_g(nand_out),
        .nor_g(nor_out) );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb_demux_gates );
        $monitor("Time=%0t | a=%b b=%b | NAND=%b NOR=%b", $time, a, b, nand_out, nor_out);

        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end

endmodule