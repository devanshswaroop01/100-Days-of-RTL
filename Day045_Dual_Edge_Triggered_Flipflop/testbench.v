// Testbench:
`timescale 1ns / 1ps
module dual_edge_tb;
    reg clk, rst, d;
    wire Q;
    dual_edge_trig_ff dut (clk, rst, d, Q);

    initial begin 
        clk = 0;
        forever #10 clk = ~clk; 
    end

    initial begin
        rst = 1;
        d   = 0;
        #10;
        rst = 0;
        forever #5 d = ~d; // toggle D every 5 ns
    end
    
    initial begin
        $dumpfile("waveform.vcd");         
        $dumpvars(0, dual_edge_tb);
        $monitor("\t time=%0t | clk=%b | D=%b | Q=%b", $time, clk, d, Q);
        #120 $finish;  
    end
endmodule
