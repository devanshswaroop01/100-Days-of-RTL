//Gray counter
`timescale 1ns / 1ps
module gray_counter(clk,rst,gray_count);
  input clk,rst;
  output reg [3:0] gray_count;
  reg [3:0] bin_count;

//0 -> 1 -> 3 -> 2 -> 6 -> 7 -> 5 -> 4 -> 12 -> 13 -> 15 -> 14 -> 10 -> 11 -> 9 -> 8 -> 0
    always@(posedge clk) begin 
        if(rst) begin
                gray_count=4'b0000;
                bin_count=4'b0000;
            end
        else
            begin
                bin_count = bin_count + 1;
                gray_count = {bin_count[3],
                              bin_count[3]^bin_count[2],
                              bin_count[2]^bin_count[1],
                              bin_count[1]^bin_count[0]};
            end
    end   
endmodule







