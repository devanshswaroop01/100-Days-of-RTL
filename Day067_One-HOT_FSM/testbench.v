module one_hot_fsm_tb;
  reg clk, reset;
  wire [3:0] state;
  wire [1:0] out;
  one_hot_fsm dut (.clk(clk),  .reset(reset), .state(state), .out(out)  );

 initial begin
    clk = 0;
    forever #10 clk = ~clk; 
  end 

initial begin
     reset = 1;   
    #20 reset = 0; 
    $dumpfile("waveform.vcd");         
    $dumpvars(0, one_hot_fsm_tb);   
    $monitor("Time=%0t | State=%b | Output=%b", $time, state, out);
     #120 $finish;  
  end 
   endmodule
