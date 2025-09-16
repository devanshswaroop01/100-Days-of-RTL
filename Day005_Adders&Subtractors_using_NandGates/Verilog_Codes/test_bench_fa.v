`timescale 1ns / 1ps
module test_bench_fa;
reg a, b, cin;
  wire sout, cout;
  reg clk;
  fa_nand dut(a, b, cin, sout, cout);

  always #5 clk = ~clk;
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench_fa);
    clk = 0;
    a = 0; b = 0; cin = 0;
    #10;
    a = 0; b = 0; cin = 1;
    #10;
    a = 0; b = 1; cin = 0;
    #10;
    a = 0; b = 1; cin = 1;
    #10;
    a = 1; b = 0; cin = 0;
    #10;
    a = 1; b = 0; cin = 1;
    #10;
    a = 1; b = 1; cin = 0;
    #10;
    a = 1; b = 1; cin = 1;
    #10;
    $finish;
  end
  
  always @(posedge clk) begin
    $display("a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sout, cout);
  end
endmodule