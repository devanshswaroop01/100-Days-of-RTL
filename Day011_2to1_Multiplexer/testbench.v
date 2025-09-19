//Testbench:
`timescale 1ns / 1ps
module mux2to1_tb;
    reg a, b, sel;
    wire y;
  mux2to1 dut (.a(a),.b(b),.sel(sel),.y(y));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, mux2to1_tb);
    $display("sel a b | y");
    $monitor("%b  %b %b | %b", sel, a, b, y);

    sel = 0; a = 0; b = 0; #10;
    sel = 0; a = 1; b = 0; #10;
    sel = 1; a = 1; b = 0; #10;
    sel = 1; a = 0; b = 1; #10;

    $finish;
  end
endmodule
 

