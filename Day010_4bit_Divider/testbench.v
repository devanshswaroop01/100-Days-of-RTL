//Tesbench:
`timescale 1ns / 1ps
module divider_tb;
    reg signed  [3:0] dividend, divisor;
    wire signed [3:0] quotient, remainder;
divider dut(dividend, divisor, quotient, remainder);

initial begin
    $dumpfile("waveform.vcd");         
    $dumpvars(0, divider_tb);   

$monitor("%0d / %0d = %0d with remainder %0d ",  dividend, divisor, quotient, remainder);
        dividend =  4'd5;  divisor =  4'd8;  #10;   // 5 / 8 = 0, R=5
        dividend =  4'd10; divisor =  4'd2;  #10;   // 10 / 2 = 5, R=0
    
        dividend =  4'd7;  divisor = -4'd3;  #10;   //  7 / -3 = -2, R=1
        dividend = -4'd7;  divisor =  4'd3;  #10;   // -7 / 3 = -2, R=-1
    
        dividend = -4'd9;  divisor = -4'd3;  #10;   // -9 / -3 = 3, R=0
        dividend =  4'd5;  divisor =  4'd0;  #10;   // divide by 0
    
        dividend =  4'd7;  divisor =  4'd7;  #10;   // 7 / 7 = 1, R=0
        dividend = -4'd8;  divisor =  4'd1;  #10;   // -8 / 1 = -8, R=0

        #50 $finish;
    end
endmodule

