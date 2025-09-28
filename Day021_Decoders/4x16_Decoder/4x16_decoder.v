//4:16 decoder using 2:4 decoder 
module decoder2x4(sel, y);
  input wire [1:0] sel;
  output reg [3:0] y;

  always @(*) begin
    y = 4'b0000;
    case (sel)
      2'b00: y = 4'b0001;
      2'b01: y = 4'b0010;
      2'b10: y = 4'b0100;
      2'b11: y = 4'b1000;
    endcase
  end
endmodule

module decoder_4x16(
  input [3:0] sel,
  output [15:0] y);
  wire [3:0] enable;
  wire [3:0] out0, out1, out2, out3;

  // MSB decoder: enables one of four LSB decoders
  decoder2x4 d0(.sel(sel[3:2]), .y(enable));

  // LSB decoders: generate 4 outputs each
  decoder2x4 d1(.sel(sel[1:0]), .y(out0));
  decoder2x4 d2(.sel(sel[1:0]), .y(out1));
  decoder2x4 d3(.sel(sel[1:0]), .y(out2));
  decoder2x4 d4(.sel(sel[1:0]), .y(out3));

  // Combine outputs based on enable lines
  assign y[3:0]    = enable[0] ? out0 : 4'b0000;
  assign y[7:4]    = enable[1] ? out1 : 4'b0000;
  assign y[11:8]   = enable[2] ? out2 : 4'b0000;
  assign y[15:12]  = enable[3] ? out3 : 4'b0000;

endmodule
