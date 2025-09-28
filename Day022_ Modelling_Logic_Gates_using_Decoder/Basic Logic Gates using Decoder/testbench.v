//testbench
`timescale 1ns / 1ps
module tb_decoder;
    reg a, b;
    wire and_out, or_out, not_out;
    decoder_logic_gates dut (
        .a(a),
        .b(b),
        .and_g(and_out),
        .or_g(or_out),
        .not_g(not_out) );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_decoder);
        $monitor("Time=%0t | a=%b b=%b | AND=%b OR=%b NOT(a)=%b",$time, a, b, and_out, or_out, not_out);

        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end


endmodule