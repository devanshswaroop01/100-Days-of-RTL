module jk_FF_tb;
  reg j, k, clk; 
  wire q;
  jk_FF dut (j, k, clk, q);  

  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10 time units period
  end

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, jk_FF_tb); 
    $monitor("Time=%0t | j=%b k=%b | q=%b", $time, j, k, q);

    j = 0; k = 0; #10;  // Hold
    j = 0; k = 1; #10;  // Reset
    j = 1; k = 0; #10;  // Set
    j = 1; k = 1; #10;  // Toggle
    $finish;
  end
endmodule
