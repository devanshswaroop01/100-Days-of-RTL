// Testbench:
module full_subtractor_tb;
  reg a, b, bin;
  wire diff, borrow;
full_subtractor DUT (.a(a), .b(b),.bin(bin),.diff(diff),.borrow(borrow));

initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0, full_subtractor_tb);
    $monitor("a = %b, b = %b, bin = %b, diff = %b, borrow = %b", a, b, bin, diff, borrow);
    a = 0; b = 0; bin = 0; #10;
    a = 0; b = 0; bin = 1; #10;
    a = 0; b = 1; bin = 0; #10;
    a = 0; b = 1; bin = 1; #10;
    a = 1; b = 0; bin = 0; #10;
    a = 1; b = 0; bin = 1; #10;
    a = 1; b = 1; bin = 0; #10;
    a = 1; b = 1; bin = 1; #10;
 $finish;
  end
endmodule



