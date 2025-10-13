`timescale 1ns/1ps
module bcd_add_sub_tb;
  reg [3:0] a, b;
  reg cin;
  reg mode;                // 0 = Addition, 1 = Subtraction
  wire [3:0] sum;
  wire cout;
  bcd_add_sub uut (a, b, cin, mode, sum, cout);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, bcd_add_sub_tb);
    $monitor("mode=%b  a=%b  b=%b  cin=%b  sum=%b  cout=%b", mode, a, b, cin, sum, cout);

    // Addition Operations (mode = 0)
    mode = 1'b0; a = 4'b0000; b = 4'b1000; cin = 1'b0; #10;  // 0 + 8 = 8
    mode = 1'b0; a = 4'b0101; b = 4'b0110; cin = 1'b1; #10;  // 5 + 6 + 1 = 12 -> 2, carry = 1
    mode = 1'b0; a = 4'b1000; b = 4'b0001; cin = 1'b1; #10;  // 8 + 1 + 1 = 10 -> 0, carry = 1

    // Subtraction Operations (mode = 1)
    mode = 1'b1; a = 4'b0101; b = 4'b0011; cin = 1'b1; #10;  // 5 - 3 = 2
    mode = 1'b1; a = 4'b0110; b = 4'b1001; cin = 1'b1; #10;  // 6 - 9 = -3
    mode = 1'b1; a = 4'b0101; b = 4'b0101; cin = 1'b1; #10;  // 5 - 5 = 0

    $finish;
  end
endmodule
