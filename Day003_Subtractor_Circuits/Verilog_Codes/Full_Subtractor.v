//Full Subtractor
 module full_subtractor(a, b, bin, diff, borrow);
  input a, b, bin;
  output diff, borrow;
assign diff = a ^ b ^ bin;
 assign borrow = (~a & b) | (~a & bin) | (b & bin);
endmodule















