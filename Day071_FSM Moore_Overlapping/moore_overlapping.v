`timescale 1ns / 1ps
module fsm_1011( 
  input clk,rst,din,
  output reg y);
  // state encoding 
  parameter S0 = 3'b000,
            S1 = 3'b001,
            S2 = 3'b010,
            S3 = 3'b011,
            S4 = 3'b100;
  reg [2:0] cs, nst;

// state transition logic (sequential)
  always @(posedge clk, posedge rst) begin
    if (rst)
      cs <= S0;
    else
      cs <= nst;
  end

// next state logic (combinational)
  always @(*) begin
    case (cs)
      S0: nst = (din) ? S1 : S0;
      S1: nst = (din) ? S1 : S2;
      S2: nst = (din) ? S3 : S0;
      S3: nst = (din) ? S4 : S2;
      S4: nst = (din) ? S1 : S2;
      default: nst = S0;
    endcase
  end

//output logic (combinational)
always @(cs) begin
  case(cs)
    S0: y<=0;
    S1: y<=0;
    S2: y<=0;
    S3: y<=0;
    S4: y<=1;
    default: y<=0;
  endcase
    end
  endmodule
