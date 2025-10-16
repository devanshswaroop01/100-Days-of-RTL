module sr_FF_tb;
  reg s, r, clk; 
  wire q, qbar;
  sr_FF dut (s, r, clk, q, qbar); 

  initial begin
    clk = 0;
forever #5 clk = ~clk; // Toggle every 5time units
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, sr_FF_tb); 
    $monitor("Time=%0t | s=%b r=%b | q=%b qbar=%b", $time, s, r, q, qbar);

    s = 0; r = 0; #10;  // Hold
    s = 0; r = 1; #10;  // Reset
    s = 1; r = 0; #10;  // Set
    s = 1; r = 1; #10;  // Invalid
    s = 0; r = 0; #10;  // Hold again

    $finish;
  end
endmodule
