//D_using_SR_JK_T FF 
`timescale 1ns / 1ps
module SR_flipflop(
    input clk,reset,S,R, 
    output reg Q);
    
    always@(posedge clk)
          begin
            if(reset)
            Q <= 1'b0;
            else
                begin
                case({S,R})
                2'b00:Q<=Q;
                2'b01:Q<=1'b0;
                2'b10:Q<=1'b1;
                default: Q<= 2'bxx;
                endcase
                end          
         end
endmodule


module JK_flipflop(
    input j,k,clk,reset,
    output reg Q );
    always@(posedge clk)
          begin
            if({reset})
            Q <= 1'b0;
            else
                begin
                case({j,k})
                2'b00:Q<=Q;
                2'b01:Q<=1'b0;
                2'b10:Q<=1'b1;
                2'b11:Q<=~Q;
                endcase
                end          
         end
endmodule


module T_flipflop(
    input t,clk,reset,
    output reg Q );
    always@(posedge clk)
          begin
            if(reset)
               Q <= 1'b0;
            else
                begin
                   if(t)
                    Q<= ~Q;
                   else
                    Q<= Q;                     
                end
          end
endmodule


module D_using_SR_JK_T(
    input clk, reset, D,
    output Q_sr, Q_jk, Q_t);
    wire w;
    
    SR_flipflop SR(clk, reset, D, ~D, Q_sr);
    
    JK_flipflop JK(D, ~D, clk, reset, Q_jk);

    assign w= D ^ Q_t;
    T_flipflop T(w, clk, reset, Q_t);
    
endmodule
