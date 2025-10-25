//Testbench :
`timescale 1ns / 1ps
module siso_tb;
  reg serial_in, clk, reset;
  wire serial_out;
  siso DUT (.clk(clk), .reset(reset), .serial_in(serial_in), .serial_out(serial_out) );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns clock period
  end
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, siso_tb);
    $monitor("Time=%0t | serial_in=%b | reset=%b | serial_out=%b", $time, serial_in, reset, serial_out);
   
    reset = 1; serial_in = 1; #10;   // Apply reset
    reset = 0; serial_in = 1; #10;   // Input 1
    serial_in = 1; #10;             
    serial_in = 0; #10;           
    serial_in = 1; #10;              
    reset = 1; #10;                  // Reset again
    reset = 0; serial_in = 1; #10;   // Input 1 after reset
    serial_in = 0; #10;             

    $finish;
  end
endmodule

