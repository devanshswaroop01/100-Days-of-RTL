//Tesbench:
`timescale 1ns / 1ps
module divider_tb;
    reg  [3:0] dividend, divisor;
    wire [3:0] quotient, remainder;
divider dut(dividend, divisor, quotient, remainder);

initial begin
    $dumpfile("waveform.vcd");         
    $dumpvars(0, divider_tb);   

$monitor("%0d / %0d = %0d with remainder %0d ",  dividend, divisor, quotient, remainder);
 dividend = 4'b0101; divisor = 4'b1000; #10;
dividend = 4'b1010; divisor = 4'b0010; #10;
    end
endmodule
