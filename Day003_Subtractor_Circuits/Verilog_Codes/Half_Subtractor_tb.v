//Testbench:
module half_subtractor_tb;
  reg a, b;
  wire diff, borrow;
half_subtractor DUT(.a(a), .b(b), .diff(diff), .borrow(borrow));

  initial begin
    $dumpfile("half_subtractor.vcd");
    $dumpvars(0, half_subtractor_tb);
    $monitor("a = %b, b = %b => diff = %b, borrow = %b", a, b, diff, borrow);
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
$finish;
  end
endmodule