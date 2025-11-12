`timescale 1ns / 1ps
module D_flipflop(
    input clk, reset, d,
    output reg Q);
    always@(posedge clk) 
begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= d;
    end
endmodule

module mod4_counter(
    input clk, reset,
    output reg [1:0] count );
    always@(posedge clk)
 begin
        if (reset)
            count <= 2'b00;
        else 
            count <= count + 1;
    end
endmodule

module freq_div_by4(
    input clk, reset,
    output clk_by4 );
    
    wire [1:0] q;      
    wire dff_out; 
  // Instantiate mod-4 counter
    mod4_counter C1(clk, reset, q);
  // D-FF to store MSB of counter
    D_flipflop D1(clk, reset, q[1], dff_out);
  // Final output is DFF output (clean /4 clock)
    assign clk_by4 = dff_out;
endmodule
