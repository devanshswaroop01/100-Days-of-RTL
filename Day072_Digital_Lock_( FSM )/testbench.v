`timescale 1ns/1ps
module digital_lock_tb;
    reg clk, reset, key_in;
    wire unlock;
    digital_lock DUT (.clk(clk), .reset(reset), .key_in(key_in), .unlock(unlock));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 ns period
    end

    initial begin
        reset = 1; key_in = 0;
        #12 reset = 0;  // release reset

// --- Correct Sequence: 1,1,0,1 ---
    $display( "Applying correct sequence: 1,1,0,1");
        key_in = 1; #10;
        key_in = 1; #10;
        key_in = 0; #10;
        key_in = 1; #10; // Hold to observe OPEN state 
        #20;

// --- Wrong Sequence Test ---
    $display("Applying wrong sequence: 1,0,1");
        key_in = 1; #10;
        key_in = 0; #10;
        key_in = 1; #10;
        #50;
        $finish;
    end

    // Monitor outputs
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, digital_lock_tb);
        $monitor("T=%0t | reset=%b key_in=%b | state=%0b | unlock=%b",$time, reset, key_in, DUT.state,unlock);
    end
endmodule




