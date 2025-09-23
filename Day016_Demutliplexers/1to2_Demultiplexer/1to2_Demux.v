//1:2 demultiplexer 
module demux1x2(I, sel , y0, y1);
  input wire I, sel;
  output wire y0, y1;
assign y0 = (sel == 1'b0) ? I : 1'b0;
assign y1 = (sel == 1'b1) ? I : 1'b0;  
endmodule



 
