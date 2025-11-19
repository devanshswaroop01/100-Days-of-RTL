`timescale 1ns / 1ps
module fsm_1011_tb;
    reg din, clk, rst;
    wire y; fsm_1011 dut(.clk(clk), .rst(rst), .din(din), .y(y));
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1'b1; din = 1'b0;
        #12 rst = 1'b0;
        #10 din = 1;  // 1  
        #10 din = 0;  // 10
        #10 din = 1;  // 101 
        #10 din = 1;  // 1011 => should detect (y=1)
        
        #10 din = 0;   
        #10 din = 1;  
        #10 din = 1;  //1011 => again detect (y=1)
        
        #10 din = 0;  
        #10 din = 1;  
        #10 din = 0; 
        #10 din = 1;  
        #10 din = 1;  // 1011 => again detect (y=1)
        #10 din = 0;
       #20 $finish;
    end
    
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, fsm_1011_tb);
        $monitor("T=%0t | clk=%b reset=%b din=%b | y=%b",$time, clk, rst, din, y);
    end
endmodule

