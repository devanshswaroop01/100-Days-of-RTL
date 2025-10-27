// Testbench :
`timescale 1ns / 1ps
module piso_tb;
    reg [3:0] parallel_in;
    reg clk, reset, shift;
    wire serial_out;
    psio DUT (.clk(clk), .reset(reset), .shift(shift), .parallel_in(parallel_in), .serial_out(serial_out));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns clock period
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, piso_tb);
        $monitor("Time=%0t | shift=%b | parallel_in=%b | reset=%b | serial_out=%b", $time, shift,parallel_in, reset, serial_out);
      // Apply reset
        reset = 1; shift = 0; parallel_in = 4'b0000; #10;
        reset = 0;

        shift = 0; parallel_in = 4'b1010; #10; // Load parallel data
        shift = 1; #40;                        // Shift 4 times

        shift = 0; parallel_in = 4'b1001; #10;
        shift = 1; #40;

        shift = 0; parallel_in = 4'b1100; #10;
        shift = 1; #40;
        $finish;
    end
endmodule
