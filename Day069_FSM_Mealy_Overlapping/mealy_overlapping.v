`timescale 1ns / 1ps
module fsm_11001(
    input  wire clk, reset, din,
    output reg  y );
  
  //state encoding
   reg[2:0] cst, nst;
   parameter S0=3'b000,
  	        S1=3'b001,
  	        S2=3'b010, 
            S3=3'b011,
  	        S4=3'b100;

  //  state transition logic (sequential)
  always @(posedge clk or posedge reset) begin
        if (reset)
            cst <= S0;
        else
            cst <= nst;
    end
  //  next state logic (combinational)
    always @(*) begin
        case (cst)
            S0:  nst = (din) ? S1 : S0;
            S1:  nst = (din) ? S2 : S0;
            S2:  nst = (din) ? S2 : S3;
            S3:  nst = (din) ? S1 : S4;
            S4:  nst = (din) ? S1 : S0;
            default: nst = S0;
        endcase
    end
    
  // output logic (combinational)
   always @(*) begin
        case (cst)
            S4:  y = (din) ? 1'b1 : 1'b0; // Sequence "11001" detected
            default: y = 1'b0;
        endcase
    end
endmodule

