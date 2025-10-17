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

    reset = 0; d = 0; #10;
    d = 1; #10;
    d = 0; #10;
    reset = 1; #5;
    reset = 0; #5;
    d = 1; #10;
    d = 0; #10;

    $finish;
  end
endmodule
