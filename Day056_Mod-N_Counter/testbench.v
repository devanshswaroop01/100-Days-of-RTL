//Testbench:
`timescale 1ns / 1ps
module testbench;
    parameter N = 6;
    parameter LENGTH = 3;
    reg clk, reset;
    wire [LENGTH-1:0] counter;
    mod_N_counter #(.N(N), .LENGTH(LENGTH)) dut ( .clk(clk), .reset(reset),  .counter(counter));

initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 time units clock period 
    end

 initial begin
       $dumpfile("waveform.vcd");
       $dumpvars(0, testbench);
       $monitor("\t\t\t counter: %d",counter);
            reset = 1;
        #10 reset = 0;
#125 $finish;
end
endmodule
