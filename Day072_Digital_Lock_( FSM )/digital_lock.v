module digital_lock(
    input clk, reset,
    input key_in,
    output reg unlock );
    reg [2:0] state, next_state;

    // State Encoding
    parameter S0   = 3'b000,
              S1   = 3'b001,
              S2   = 3'b010,
              S3   = 3'b011,
              OPEN = 3'b100;

  // State Transition Logic (Sequential Block)
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

  //  Next State Logic (Combinational Block) 
    always @(*) begin
        case (state)
            S0:   next_state =  key_in  ? S1   : S0;
            S1:   next_state =  key_in  ? S2   : S0;
            S2:   next_state = ~key_in  ? S3   : S0;
            S3:   next_state =  key_in  ? OPEN : S0;
            OPEN: next_state =  key_in  ? S0   : OPEN;
            default: next_state = S0;
        endcase
    end

  // Output Logic (Combinational Block) 
    always @(*) begin
        unlock = (state == OPEN);
    end
endmodule
