`timescale 1ns / 1ps
module vedic_4x4_tb;
reg [3:0] a,b;
wire [7:0] out;
vedic_4x4 dut(a,b,out);

always begin  
a=$random;
b=$random; #10;
end

initial begin
 $dumpfile("waveform.vcd");
 $dumpvars(0, vedic_4x4_tb);
$monitor("%d * %d = %d", a,b,out);
#60 $finish;
end
endmodule

