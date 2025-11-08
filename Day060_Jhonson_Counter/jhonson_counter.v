//Jhonson counter
`timescale 1ns / 1ps
module jhonson_counter #(parameter N=4) ( clk, reset, counter ) ;
input clk, reset;
output reg [3:0] counter;

// 0 -> 8 -> 12 -> 14 -> 15 -> 7 -> 3 -> 1 -> 0...
always@(posedge clk)
    begin
        if(reset) 
         counter <= 0; 
        else 
         counter <= {~counter[0], counter[N-1:1]};  
    end 
endmodule














