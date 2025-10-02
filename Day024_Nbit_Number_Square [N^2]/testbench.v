`timescale 1ns / 1ps
module test_bench;
  parameter n = 4;
  reg [n-1:0] num;
  wire [2*n-1:0] result;
  n_bit_square dut ( .num(num), .result(result));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);
    $monitor("Time=%0t | %0d^2 = %0d", $time, num, result);

    num = 0;  #10;
    num = 1;  #10;
    num = 2;  #10;
    
    num = 3;  #10;
    num = 7;  #10;
    num = 9;  #10; 
    num = $random; #10;
    #20 $finish;
  end
endmodule
