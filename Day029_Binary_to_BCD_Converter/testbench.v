`timescale 1ns / 1ps
module test_bench;
  reg  [7:0] data;        
  wire [3:0] bit0, bit1, bit2; 
  wire [11:0] BCD;        
  binary2bcd dut (.data(data),  .bit0(bit0),.bit1(bit1),  .bit2(bit2), .BCD(BCD) );

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);
    $monitor("Time=%0t | data=%0d -> BCD=%d%d%d (bits: %b %b %b)", $time, data, bit2, bit1, bit0, bit2, bit1, bit0);

    data = 8'd0;   #10;
    data = 8'd5;   #10;
    data = 8'd9;   #10;
    
    data = 8'd10;  #10;
    data = 8'd15;  #10;
    data = 8'd25;  #10;
    
    data = 8'd47;  #10;
    data = 8'd99;  #10;
    data = 8'd123; #10;
    data = 8'd255; #10;   // max 8-bit

    #20 $finish;
  end
endmodule 

