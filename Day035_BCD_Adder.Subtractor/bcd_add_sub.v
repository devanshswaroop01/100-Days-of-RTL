`timescale 1ns/1ps
module bcd_add_sub(a, b, cin, mode, sum, cout);
  input  [3:0] a, b;
  input  cin;
  input  mode;             // 0 = Addition, 1 = Subtraction
  output reg [3:0] sum;
  output reg cout;

  reg [4:0] sum_temp;
  reg [3:0] b_temp;

  always @(*) begin

    // Select B or its 9's complement for subtraction
    if (mode == 1'b1)
      b_temp = 4'd9 - b;
    else
      b_temp = b;

    // Perform addition or subtraction
    sum_temp = a + b_temp + cin;

    // BCD correction
    if (sum_temp > 9) begin
      sum_temp = sum_temp + 6;
      cout = 1;
    end
    else begin
      cout = 0;
    end

    // Assign final 4-bit result
    sum = sum_temp[3:0];
  end
endmodule
