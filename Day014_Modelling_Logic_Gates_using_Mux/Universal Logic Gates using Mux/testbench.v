//Testbench:
module gates_mux_tb;
    reg a, b;
    wire  nand_out, nor_out;
    gates_mux dut(
        .a(a), .b(b),
        .nand_out(nand_out),
        .nor_out(nor_out));

 initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, gates_mux_tb);
        $monitor("Time=%0t | a=%b b=%b |  NAND=%b NOR=%b ",$time, a, b, nand_out, nor_out);
        a = 0; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 0;
        #10 a = 1; b = 1;
        #10 $finish;
    end
endmodule
