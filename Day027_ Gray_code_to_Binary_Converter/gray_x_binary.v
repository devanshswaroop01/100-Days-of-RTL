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