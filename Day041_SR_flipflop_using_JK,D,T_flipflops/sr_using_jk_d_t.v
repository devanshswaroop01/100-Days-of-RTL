//SR FF using D  T JK FF 
`timescale 1ns / 1ps
module D_flipflop(
    input clk, reset, d,
    output reg Q );
    
    always@(posedge clk)
          begin
            if({reset})
                Q<= 1'b0;
            else 
                Q <= d;
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


module SR_using_JK_D_T(
    input S, R, clk, rst,
    output Q_jk, Q_d, Q_t );
    wire w1, w2, w3, w4, w5;

    JK_flipflop JK(S, R, clk, rst, Q_jk);
    
    assign w1= ~R & Q_d;
    assign w2= S | w1;
    D_flipflop D(w2, clk, rst, Q_d);
   
    assign w3= S & ~Q_t;
    assign w4= R & Q_t;
    assign w5= w3 | w4;
    T_flipflop T(w5, clk, rst, Q_t);

endmodule
