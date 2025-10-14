// Using NAND gates with reset and enable
module sr_latch (
  input s, r, rst, en,
  output reg q, qbar);
  
  always @(*) begin
    if (rst) begin
      q = 0;
      qbar = 1;
    end else if (en) begin
      q    = ~(s & qbar);
      qbar = ~(r & q);
    end
  end
endmodule
