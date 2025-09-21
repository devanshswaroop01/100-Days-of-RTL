//Testbench:
module gates_mux_tb;
    reg a, b;
    wire  xor_out, xnor_out;
    gates_mux dut(
                .a(a), .b(b),
                .xor_out(xor_out),
                .xnor_out(xnor_out));

 initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, gates_mux_tb);
        $monitor("Time=%0t | a=%b b=%b |  XOR=%b XNOR=%b ",$time, a, b,xor_out, xnor_out);
        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end
endmodule
