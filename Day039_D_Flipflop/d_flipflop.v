// D Flip-Flop with asynchronous reset
module d_FF(d, clk, reset, q);
  input d, clk, reset;
  output reg q;

always @(posedge clk or posedge reset) 
begin 
    if (reset)
      q <= 0;
    else
      q <= d;
  end
endmodule


