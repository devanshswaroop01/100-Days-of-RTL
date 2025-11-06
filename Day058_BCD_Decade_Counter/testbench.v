`timescale 1ns / 1ps
module bcd_counter_tb;
    reg clk;
    reg reset;
    wire [3:0] Q;
    bcd_counter uut (.clk(clk), .reset(reset), .Q(Q) );


    initial clk = 0;
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        reset = 1;
        #10;          // Hold reset 
        reset = 0;    // Release reset
        #200;
        $finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, bcd_counter_tb);
        $monitor("Time = %0t ns | Reset = %b | Count = %b (Decimal: %0d)", $time, reset, Q, Q);
    end

endmodule
