`timescale 1ns/1ps
`define TRUE    1'b1
`define FALSE   1'b0

// delays 
`define Y2RDELAY 3 
`define R2GDELAY 2

module sig_control(hwy, cntry, sensor, clock, clear);
  input  sensor, clock, clear;
  output reg [1:0] hwy, cntry;

  // Light colors
  parameter  RED=2'd0, 
             YELLOW=2'd1,
             GREEN=2'd2;

  // STATE DEFINITIONS (HWY / CNTRY)
  parameter S0=3'd0,  // Hwy=GREEN , Cntry=RED
            S1=3'd1,  // Hwy=YELLOW, Cntry=RED
            S2=3'd2,  // Hwy=RED   , Cntry=RED
            S3=3'd3,  // Hwy=RED   , Cntry=GREEN
            S4=3'd4;  // Hwy=RED   , Cntry=YELLOW

  reg [2:0] state, next_state;

  initial begin 
    state      = S0;
    next_state = S0;
    hwy        = GREEN;
    cntry      = RED;
  end

  // State transition logic ( Sequential )
always @(posedge clock)
  if (clear)
    state <= S0;
  else
    state <= next_state;

  // State transition logic ( Combinational )
always @(state or clear or sensor) begin 
  if (clear)
    next_state = S0;
  else begin
    case (state)

      S0: next_state = (sensor) ? S1 : S0;

      S1: begin 
            repeat (`Y2RDELAY) @(posedge clock);
            next_state = S2;
          end

      S2: begin 
            repeat (`R2GDELAY) @(posedge clock);
            next_state = S3;
          end

      S3: next_state = (sensor) ? S3 : S4;

      S4: begin
            repeat (`Y2RDELAY) @(posedge clock);
            next_state = S0;
          end

      default: next_state = S0;
    endcase
  end  
end

  // Output logic ( Combinationlal )
always @(state) begin 
  case (state)
    S0: begin hwy = GREEN;  cntry = RED;    end
    S1: begin hwy = YELLOW; cntry = RED;    end
    S2: begin hwy = RED;    cntry = RED;    end
    S3: begin hwy = RED;    cntry = GREEN;  end
    S4: begin hwy = RED;    cntry = YELLOW; end
    default: begin hwy = GREEN; cntry = RED; end
  endcase 
end
endmodule
