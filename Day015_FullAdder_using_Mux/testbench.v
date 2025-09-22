//Testbench :
`timescale 1ns / 1ps
module fa_mux_tb;
  reg a, b, cin;
  wire sum, carry;
  full_adder dut(a, b, cin, sum, carry);

  initial begin
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
  end

    initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, fa_mux_tb);
    $monitor("a = %b, b = %b, cin = %b, sum = %b, carry = %b", a, b, cin, sum, carry);
    #80 $finish;
  end
endmodule

