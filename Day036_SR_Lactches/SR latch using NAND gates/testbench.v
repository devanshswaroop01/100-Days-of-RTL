module sr_latch_tb;
  reg s, r, rst, en; 
  wire q, qbar;
  sr_latch dut (s, r, rst, en, q, qbar);

  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0, sr_latch_tb);
    $monitor("t=%0t | rst=%b en=%b | s=%b r=%b | q=%b qbar=%b", $time, rst, en, s, r, q, qbar);

    // Initial reset
    rst = 1; en = 0; s = 0; r = 0; #10;
    rst = 0; en = 1; #10;

   // --- NAND latch testing  ---
    s = 1; r = 1; #10;  // Hold for NAND
    s = 1; r = 0; #10;  // Reset
    s = 0; r = 1; #10;  // Set
    s = 0; r = 0; #10;  // Invalid for NAND

    // Disable latch (output hold)
    en = 0; s = 1; r = 0; #10;

    $finish;
  end
endmodule
