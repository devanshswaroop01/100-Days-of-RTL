module t_FF_tb;
  reg t, clk, reset; 
  wire q;
  t_FF dut (t, clk, reset, q);   

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock period = 10 time units
  end
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, t_FF_tb); 
    $monitor("Time=%0t | t=%b reset=%b | q=%b", $time, t, reset, q);
    
    reset = 0; t = 0; #10; 
    
    reset = 1; t = 1; #10;   // Reset active
    
    reset = 0; t = 1; #20;   // Toggle twice
    
    t = 0; #10;              // Hold
    
    t = 1; #10;              // Toggle
    
    reset = 1; #5;           // Async reset mid-cycle
    
    reset = 0; t = 1; #10;   // Resume toggling
    
    t = 0; #10;              // Hold

    $finish;
  end
endmodule

