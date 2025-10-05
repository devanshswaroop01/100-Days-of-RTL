module gray_to_binary(
    input  [3:0] gray_in,     
    output [3:0] binary_out   
);
always @(*) begin
        // MSB remains same
        binary_out[3] = gray_in[3];
        binary_out[2] = gray_in[2] ^ binary_out[3];
        binary_out[1] = gray_in[1] ^ binary_out[2];
        binary_out[0] = gray_in[0] ^ binary_out[1];
    end
    endmodule

module binary_to_gray(bin, gray);
input  [3:0] bin;
output reg [3:0] gray;
  always @(*) begin
        gray[3] = bin[3];               // MSB same
        gray[2] = bin[3] ^ bin[2];      // XOR B3 and B2
        gray[1] = bin[2] ^ bin[1];      // XOR B2 and B1
        gray[0] = bin[1] ^ bin[0];      // XOR B1 and B0
    end

endmodule



