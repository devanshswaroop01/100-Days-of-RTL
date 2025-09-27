//Testbench:
module priority_8x3_tb;
  reg [7:0] in;          
  wire [2:0] code;        
  priority_8x3 DUT(in, code); 

  initial begin 
    $dumpfile("waveform.vcd");      
    $dumpvars(0, priority_8x3_tb);       
    $monitor("Time = %0t, in = %b, code = %b", $time, in, code);

    in = 8'b00000001; #10;
    in = 8'b00000100; #10;
    in = 8'b00010000; #10;
    in = 8'b01000000; #10;
    
    $finish;
  end
endmodule
