//Testbench:
`timescale 1ns / 1ps
module mux8x1_tb;
  reg [7:0] I;       
  reg [2:0] sel;     
  wire out;         
  mux8x1 DUT (.I(I), .sel(sel), .out(out));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, mux8x1_tb);
    $display(" sel | out");
    $monitor(" %b | %b  ", sel, out);

    I = 8'b10101010;
    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;
    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    $finish;
  end
endmodule
