`timescale 1ns/1ps
module clock_timer_tb;
    reg clk,reset,ena;
    wire pm;
    wire [7:0] hh;
    wire [7:0] mm;
    wire [7:0] ss;

    integer hour_dec, min_dec, sec_dec; 
    reg [2*8-1:0] ampm_str; 
    clock_timer DUT (n.clk(clk), .reset(reset), .ena(ena), .pm(pm), .hh(hh), .mm(mm), .ss(ss));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period
    end

    initial begin
        reset = 1;
        ena   = 0;
        #20;
        reset = 0;
        ena   = 1;
        #200;  
        $finish;
    end

    // Compute readable values for $monitor
    always @(*) begin
        hour_dec = (hh[7:4] * 10) + hh[3:0];
        min_dec  = (mm[7:4] * 10) + mm[3:0];
        sec_dec  = (ss[7:4] * 10) + ss[3:0];
        ampm_str = (pm) ? "PM" : "AM";
    end

    initial begin
      $dumpfile("waveform.vcd");
      $dumpvars(0, clock_timer_tb);
      $monitor("Time=%0t | %0d:%0d:%0d %s", $time, hour_dec, min_dec, sec_dec, ampm_str);
    end
endmodule
