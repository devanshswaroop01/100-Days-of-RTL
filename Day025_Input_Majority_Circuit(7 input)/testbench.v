`timescale 1ns / 1ps
module test_bench;
  reg [6:0] in;
  wire out;
  majority_input dut ( .in(in), .out(out));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);
    $monitor("Time=%0t | Input=%0d (%b) -> Majority Output=%b",$time, in, in, out);

    in = 7'd99;  #10;   // 1100011
    in = 7'd28;  #10;   // 0011100

    in = 7'd119; #10;   // 1110111
    in = 7'd101;  #10;  // 1100101

    in = 7'd32;   #10;  // 0100000
    in = 7'd48;   #10;  // 0110000

    in = 7'd75;   #10;  // 1001011
    #10 $finish;
  end
endmodule 
