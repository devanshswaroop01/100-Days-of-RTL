module seg7_tb;
  reg [3:0] D;
  wire a, b, c, d, e, f, g;
  bcd_to_7segment uut (D, a, b, c, d, e, f, g);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, seg7_tb);
    D = 4'b0000; #10;
    D = 4'b0101; #10;
    D = 4'b1010; #10; 
    D = 4'b1000; #10;
    $finish;
  end
endmodule
