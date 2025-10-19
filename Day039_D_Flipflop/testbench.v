module d_FF_tb;
  reg d, clk, reset;
  wire q;
  d_FF dut (d, clk, reset, q);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, d_FF_tb); 
    $monitor("Time=%0t | d=%b reset=%b | q=%b", $time, d, reset, q);

    reset = 0; d = 0; #10;   // Deactivate reset
    d = 1; #10;              // Apply D = 1
    d = 0; #10;              // Apply D = 1
    
    reset = 1; #5;           //  Activate reset
    
    reset = 0; #5;           // Deactivate reset
    d = 1; #10;              // Apply D = 1 
    d = 0; #10;              // Apply D = 0

    $finish;
  end
endmodule

