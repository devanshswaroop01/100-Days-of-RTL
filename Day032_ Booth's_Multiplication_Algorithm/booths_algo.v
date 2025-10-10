module Booths_Algo(Q, M, Result);
  input  signed [3:0] Q, M;
  output reg signed [7:0] Result;
  reg Q0;
  integer i;

always @(Q, M) begin
    Result = {4'd0, Q};   // A=0, Q as given
    Q0 = 1'b0;

     for (i = 0; i < 4; i = i + 1) begin
      case ({Result[0], Q0})
        2'b01: Result[7:4] = Result[7:4] + M;
        2'b10: Result[7:4] = Result[7:4] - M;
      endcase

    Q0 = Result[0];
    Result = {Result[7], Result[7:1]};  // Arithmetic right shift
    end
  end 
endmodule
