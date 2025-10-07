`timescale 1ns / 1ps

module test_bench;
  reg  [3:0] data;          // unsigned 4-bit input
  wire signed [3:0] out;    // signed 4-bit output (2's complement)

  // DUT instantiation
  complement_2s dut (
    .data(data),
    .out(out)
  );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);

    // Print input and output in both decimal and binary
    $monitor("Time=%0t | Input=%0d (%b) -> 2's Complement=%0d (%b)", 
              $time, data, data, out, out);

    data = 4'd0;  #10;
    data = 4'd1;  #10;
    data = 4'd2;  #10;
    data = 4'd3;  #10;
    data = 4'd4;  #10;
    data = 4'd5;  #10;
    data = 4'd6;  #10;
    data = 4'd7;  #10;
    data = 4'd8;  #10;
    data = 4'd9;  #10;
    data = 4'd10; #10;
    data = 4'd11; #10;
    data = 4'd12; #10;
    data = 4'd13; #10;
    data = 4'd14; #10;
    data = 4'd15; #10;

    #10 $finish;
  end
endmodule
