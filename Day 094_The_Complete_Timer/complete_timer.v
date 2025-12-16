
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    // State Encoding
    parameter [3:0] S = 4'd0, S1 = 4'd1, S11 = 4'd2, S110 = 4'd3, B0 = 4'd4,
 			 		          B1 = 4'd5, B2 = 4'd6, B3 = 4'd7, COUNT = 4'd8, WAIT = 4'd9;

    reg [3:0] current_state, next_state;

    // FSM state transition
    always @(posedge clk) begin
        if (reset)
            current_state <= S;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = S;
        case (current_state)
            S:     next_state = data ? S1 : S;
            S1:    next_state = data ? S11 : S;
            S11:   next_state = data ? S11 : S110;
            S110:  next_state = data ? B0 : S;
            B0:    next_state = B1;
            B1:    next_state = B2;
            B2:    next_state = B3;
            B3:    next_state = COUNT;
            COUNT: next_state = (count == 0 && end_cnt) ? WAIT : COUNT;
            WAIT:  next_state = ack ? S : WAIT;
            default: next_state = S;
        endcase
    end

    // 4-bit Shift Register to load delay from B0-B3
    reg [3:0] delay = 4'd0;
    always @(posedge clk) begin
        if (reset)
            delay <= 4'd0;
        else begin
            case (current_state)
                B0: delay <= {delay[2:0], data};
                B1: delay <= {delay[2:0], data};
                B2: delay <= {delay[2:0], data};
                B3: delay <= {delay[2:0], data};
                COUNT: begin
                    if (end_cnt)
                        delay <= delay - 1;
                end
            endcase
        end
    end

    // 10-bit Counter for 1000 clock cycles
    reg [9:0] cnt;
    wire add_cnt, end_cnt;

    always @(posedge clk) begin
        if (reset)
            cnt <= 10'd0;
        else if (add_cnt) begin
            if (end_cnt)
                cnt <= 10'd0;
            else
                cnt <= cnt + 1'b1;
        end
    end

    assign add_cnt = (current_state == COUNT) && (delay >= 0);
    assign end_cnt = add_cnt && (cnt == 10'd999);

    // Output logic
    assign count    = delay;
    assign counting = (current_state == COUNT);
    assign done     = (current_state == WAIT);

endmodule
