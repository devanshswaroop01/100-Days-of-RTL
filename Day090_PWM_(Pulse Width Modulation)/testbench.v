`timescale 1ns/1ps

module test_bench;

    reg clk;
    reg rst;
    wire dout;

    // Instantiate DUT
    PWM dut(
        .clk(clk),
        .rst(rst),
        .dout(dout)
    );

    // Clock generation : 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset logic
    initial begin
        rst = 1;
        #10;
        rst = 0;
    end

    // Simulation control
    initial begin
        // Dump waveform
      $dumpfile("waveform.vcd");
      $dumpvars(0, test_bench);

        // Display heading
        $display("TIME\tCLK\tRST\tPWM_OUT");

        // Monitor values
        $monitor("%0t\t%b\t%b\t%b", $time, clk, rst, dout);

        // Run enough cycles to see PWM sweep
        #1500;
        $finish;
    end

endmodule
