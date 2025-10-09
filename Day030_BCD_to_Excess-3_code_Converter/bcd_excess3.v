module bcd_excess3(b,x);
input [3:0] b;
 output reg [3:0] x
  always@(*) begin
    case (b)
      4'b0000: x = 4'b0011; // 0 -> 3

      4'b0001: x = 4'b0100; // 1 -> 4

      4'b0010: x = 4'b0101; // 2 -> 5

      4'b0011: x = 4'b0110; // 3 -> 6

      4'b0100: x = 4'b0111; // 4 -> 7

      4'b0101: x = 4'b1000; // 5 -> 8

      4'b0110: x = 4'b1001; // 6 -> 9

      4'b0111: x = 4'b1010; // 7 -> 10

      4'b1000: x = 4'b1011; // 8 -> 11

      4'b1001: x = 4'b1100; // 9 -> 12

      default: x = 4'b0000; // Invalid BCD
    endcase
  end
endmodule
