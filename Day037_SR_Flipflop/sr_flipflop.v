module sr_FF(s, r, clk, q, qbar);
  input s, r, clk;
  output reg q;
  output qbar;

  always @(posedge clk) begin
    case ({s, r})
      2'b00: q <= q;        // Hold
      2'b01: q <= 1'b0;     // Reset
      2'b10: q <= 1'b1;     // Set
      2'b11: q <= 1'bx;     // Invalid
    endcase
  end
assign qbar = ~q;
endmodule

