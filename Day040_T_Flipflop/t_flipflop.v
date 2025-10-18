// T Flip-Flop with asynchronous reset
module t_FF(t, clk, reset, q);
  input t, clk, reset;
  output reg q;

  always @(posedge clk or posedge reset) begin 
    if (reset)
      q <= 0;
    else if (t)
      q <= ~q; 
    else
      q <= q; // Hold state
  end
endmodule  



