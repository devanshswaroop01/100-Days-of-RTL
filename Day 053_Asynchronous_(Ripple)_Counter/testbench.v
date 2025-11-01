`timescale 1ns/1ps
module test_bench;
    reg clk, reset;
    wire [3:0] q;
    async_counter uut (.clk(clk), .reset(reset), .q(q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10 ns period
    end

    initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);
    $monitor("Time=%0t | Count=%b", $time, q);

        // Reset and run
        reset = 1; #12;   // async reset active
        reset = 0;
        #200;
        $finish;
    end 
endmodule
