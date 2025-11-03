//Testbench:
`timescale 1ns / 1ps
module Up_Down_tb;
    reg clk,reset,upordown;
    wire [3:0] count;
    up_down_counter uut (.clk(clk),  .reset(reset), .upordown(upordown), .count(count) );

    initial begin
    clk = 0
    always #10 clk = ~clk;
    end

    initial begin
        clk = 0;
        reset = 1;     		    // Reset ON
        upordown = 0;  		    // Down mode
        #25 reset = 0; #100   // Reset OFF
        upordown = 1;  #100   // Up Mode
        upordown = 0;  #100   // Down Mode
        upordown = 1;  #100   // Up Mode
$finish;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, Up_Down_tb);
        $monitor("T=%0dns  UpOrDown=%b  Count=%d", $time  , upordown, count);
    end
endmodule
