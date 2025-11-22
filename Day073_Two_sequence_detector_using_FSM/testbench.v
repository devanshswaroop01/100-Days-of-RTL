`timescale 1ns / 1ps
module test_bench;
    reg din, clk, reset;
    wire y;
    fsm_101_0110 dut( .din(din), .clk(clk), .reset(reset), .y(y));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        din = 0;
        reset = 1;
        #10 reset = 0;

        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0; // detection 0110

        #10 din = 1;
        #10 din = 1;
        #10 din = 0; // detection 0110

        #10 din = 0; // detection 101
        #10 din = 1;
        #10 din = 0;
        #10 din = 1; // detection 101

        #10 din = 0;
        #10 din = 1;
        #10 din = 1;
        #10 din = 0; // detection 0110
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, test_bench);
        $monitor("Time=%0t | clk=%b | din=%b | y=%b | state=%d", $time, clk, din, y, dut.cst);
        #200 $finish;
    end
endmodule
