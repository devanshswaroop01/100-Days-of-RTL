module one_hot_fsm (
  input clk, reset,
  output reg [3:0] state,
  output reg [1:0] out  );

 // state encoding
  parameter [3:0] IDLE   = 4'b0001,
                  STATE1 = 4'b0010,
                  STATE2 = 4'b0100,
                  STATE3 = 4'b1000;
  reg [3:0] present_state, next_state;

  // state transition (sequential)
always @(posedge clk or posedge reset) begin
    if (reset)
      present_state <= IDLE;
    else
      present_state <= next_state;
  end

// next state logic (combinational)
  always @(*) begin
    case (present_state)
      IDLE:    next_state = STATE1;
      STATE1:  next_state = STATE2;
      STATE2:  next_state = STATE3;
      STATE3:  next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end

  // output logic (combinational)
  always @(*) begin
    case (present_state)
      IDLE:    out = 2'b00;
      STATE1:  out = 2'b01;
      STATE2:  out = 2'b10;
      STATE3:  out = 2'b11;
      default: out = 2'b00;
    endcase 
  end
  
    always @(*) begin
      state = present_state;
  end
  endmodule

