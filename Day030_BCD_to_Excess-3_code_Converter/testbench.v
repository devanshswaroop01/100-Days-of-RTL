module bcd_excess3_tb;
  reg [3:0] b;
  wire [3:0] x;
  bcd_excess3 uut (b, x);  

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, bcd_excess3_tb);
    $monitor("BCD=%b  Excess-3=%b", b, x);
    b = 4'b0000; #10;
    b = 4'b0001; #10;
    b = 4'b0010; #10;
    b = 4'b0011; #10;
    b = 4'b0100; #10;
    b = 4'b0101; #10;
    b = 4'b0110; #10;
    b = 4'b0111; #10;
    b = 4'b1000; #10;
    b = 4'b1001; #10;
$finish;
  end
endmodule
