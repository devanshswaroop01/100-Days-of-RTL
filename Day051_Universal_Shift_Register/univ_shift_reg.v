//Universal Shift Register
module univ_shift_reg(
    input clk, reset,
    input  [1:0] ctrl,
    input  [7:0] data_in,
    output [7:0] data_out );
    reg [7:0] r_reg, r_next;

// State transition logic (sequential)
always @(posedge clk or posedge reset) 
    begin
        if (reset)
            r_reg <= 8'b0;
        else
            r_reg <= r_next;
    end

// Next state logic (combinational)
always @(*) begin
    case (ctrl)
        2'b00: r_next = data_in;                    // Load parallel data
        2'b01: r_next = r_reg;                      // Hold (no change)
        2'b10: r_next = {r_reg[6:0], data_in[0]};   // Shift left
        2'b11: r_next = {data_in[7], r_reg[7:1]};   // Shift right
    default: r_next = r_reg;                        // Default hold
 endcase
end

assign data_out = r_reg; //output logic
endmodule