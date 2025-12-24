// You will build a complete serial-controlled timer by designing five components that work together. Each component builds on the previous one.

// 1. Shift Register / Down Counter

// Design a 4-bit shift register that also functions as a down counter.
// When shift_ena = 1, shift in serial data MSB-first.
// When count_ena = 1, decrement the current 4-bit value.
// The behavior when both enables are 1 simultaneously does not matter.

// 2. Sequence Recognizer FSM (Detect 1101)

// Design a finite-state machine that monitors a serial input stream and detects the bit sequence 1101.
// When detected, assert start_shifting = 1 and remain in that state until reset.
// This represents the trigger for starting the timer.

// 3. FSM to Enable Shift Register for 4 Cycles

// Design an FSM that asserts shift_ena = 1 for exactly four clock cycles whenever reset occurs.
// After these four cycles, shift_ena must remain 0 until the next reset.

// 4. Timer-Control FSM (Without Datapath)

// Extend your controller so that:
// Upon detecting the sequence 1101, shift_ena is asserted for 4 cycles (to load a delay value).
// After shifting is complete, assert counting = 1 while waiting for an external counter signal done_counting.
// When done_counting = 1, assert done = 1 and remain in this state until an external acknowledgment ack = 1.
// After acknowledgment, return to the initial "search for 1101" state.

// 5. Complete Timer (Final Integrated Component)

// Combine all previous components to create a full serial-controlled timer:
// The timer starts when the serial bit pattern 1101 is detected.
// The next 4 bits (MSB-first) form a delay value delay[3:0].
// The system then counts for exactly

// (delay+1)×1000 clock cycles.

// Examples:

// delay = 0 → count 1000 cycles
// delay = 5 → count 6000 cycles
// The output count[3:0] must show the remaining delay, updated every 1000 cycles:
// delay, delay−1, delay−2, … , 0


// each lasting exactly 1000 cycles.
// After finishing the countdown, assert done = 1.
// Remain in the done state until ack = 1, then return to searching for the next 1101 pattern.
// On reset, the system must return to the initial sequence-search state.

// Behavior Summary
// Input: serial bitstream
// Trigger pattern: 1101
// Next 4 bits: delay value
// Timer duration: (delay + 1) × 1000 cycles

// Output:
// count: remaining delay
// counting: timer running
// done: timer finished
// Ack resets system to wait for the next start pattern. 

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
