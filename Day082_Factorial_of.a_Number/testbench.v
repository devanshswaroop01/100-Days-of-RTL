//testbench :
`timescale 1ns / 1ps
module factorial_tb;
reg [3:0] n;
wire [31:0] result;
integer x;
factorial dut(n, result);

always for(x=0; x<11; x=x+1) #10 n=x;

initial begin 
   $dumpfile("waveform.vcd");
   $dumpvars(0, factorial_tb);

$monitor("\t\t factorial of %d is %0d",n, result);
#120 $finish;
end
endmodule
