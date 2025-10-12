`timescale 1ns / 1ps
module test_bench;
  reg [7:0] a,b;
  wire [15:0] c;
  vedic_8x8 dut(a,b,c);

always begin
a=$random;
b=$random; #10;
end
initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, test_bench);
  $monitor("%d * %d = %d", a,b,c);
#60 $finish;
end
endmodule
