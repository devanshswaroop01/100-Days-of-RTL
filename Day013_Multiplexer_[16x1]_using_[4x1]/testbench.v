//Testbench:
`timescale 1ns / 1ps
module mux16x1_tb;
  reg [15:0] in;       
  reg [3:0] sel;      
  wire out;           
  mux16to1 DUT (.in(in), .sel(sel), .out(out));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, mux16x1_tb);
    $display("sel  | out");
    $monitor("%b |  %b", sel, out);

 in = 16'b1010010111110000;
    sel = 4'b0000; #10;
    sel = 4'b0001; #10;
    sel = 4'b0010; #10;
    sel = 4'b1001; #10;
    sel = 4'b1010; #10;
    sel = 4'b1111; #10;
$finish;
  end
endmodule 
