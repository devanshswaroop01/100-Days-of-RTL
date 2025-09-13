`timescale 1ns / 1ps
module logic_gates_tb;
    reg a, b;
    wire and_g, or_g,not_g,
         nand_g,nor_g,xor_g,xnor_g;
     logic_gates_b dut(a, b, and_g,or_g,not_g,nand_g,nor_g,xor_g,xnor_g);

    initial begin
      $dumpfile ("waveform.vcd");
      $dumpvars (0, logic_gates_tb);
      $monitor("Time=%0t | a=%b b=%b | AND=%b OR=%b NOT(a)=%b NAND=%b NOR=%b XOR=%b XNOR=%b",
      $time, a, b, and_g, or_g, not_g, nand_g, nor_g, xor_g, xnor_g);
        #10 a= 1'b0; b= 1'b0;
        #10 a= 1'b0; b= 1'b1;
        #10 a= 1'b1; b= 1'b0;
        #10 a= 1'b1; b= 1'b1;
        #10 $finish;
    end
endmodule
