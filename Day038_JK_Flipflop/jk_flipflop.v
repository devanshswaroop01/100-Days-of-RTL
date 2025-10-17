module jk_FF(j, k, clk, q);
  input j, k, clk;
  output reg q;

  always @(posedge clk) begin
    case ({j, k})
      2'b00: q <= q;        // Hold
      2'b01: q <= 1'b0;     // Reset
      2'b10: q <= 1'b1;     // Set
      2'b11: q <= ~q;       // Toggle
    endcase
  end
endmodule
