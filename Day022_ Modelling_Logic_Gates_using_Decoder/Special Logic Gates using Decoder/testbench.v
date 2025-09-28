 // Testbench
 `timescale 1ns / 1ps
module tb_demux_gates;

    reg a, b;
    wire xor_g, xnor_g;

    demux_gates dut (
        .a(a),
        .b(b),
        .xor_g(xor_g),
        .xnor_g(xnor_g)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0,tb_demux_gates );
        $monitor("Time=%0t | a=%b b=%b | XOR=%b XNOR=%b", 
                  $time, a, b, xor_g, xnor_g);
        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end
endmodule