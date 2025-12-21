// A Lemming moves in a 2D world and behaves according to simple rules. 
// You will design an extended Moore finite state machine that models its behaviour.
// The FSM has inputs:
// bump_left
// bump_right
// ground
// dig

// and outputs:
// walk_left
// walk_right
// aaah (falling)
// digging

// The FSM is reset into a walking-left state.

// Part 1 — Walking Left/Right

// A Lemming can be in one of two states: walking left or walking right.
// If walking left and bump_left = 1 → switch to walking right.
// If walking right and bump_right = 1 → switch to walking left.
// If bumped on both sides simultaneously, still switch directions.
// Output is determined solely by the current state.
// Design a Moore FSM that models this behavior.

// Part 2 — Falling

// Extend the FSM so the Lemming can fall:
// If ground = 0 while walking → enter falling state and assert aaah = 1.
// While falling, bumps do not change direction.
// When ground = 1, stop falling and resume walking in the same direction as before.

// Part 3 — Digging

// Extend the FSM to support digging:
// If walking on ground (ground = 1) and dig = 1 → enter digging state and assert digging = 1.
// While digging, ignore bumps; continue digging as long as ground = 1.
// When ground = 0 during digging → begin falling (aaah).
// After falling ends, resume walking in the same direction as before digging.
// Precedence rules when walking:

// Fall (if ground = 0)
// Dig (if dig = 1 and ground = 1)
// Change direction (if bumped)

// Part 4 — Splattering After Long Falls

// Add the final rule: Lemmings can splatter.
// While falling, count how many clock cycles have passed.
// If the Lemming hits the ground after more than 20 cycles of falling → enter a permanent splatted state.
// A splatted Lemming produces no outputs (all outputs = 0) forever, until reset.
// Falling 20 cycles or fewer is survivable; falling 21+ cycles causes splatter.
// Splattering occurs only when hitting the ground, not mid-air.

// Goal

// Design the complete FSM with all states, transitions, and outputs that correctly models:
// Walking
// Changing direction
// Falling
// Digging
// Splattering after long falls
// according to the rules above.


module top_module(
    input clk,
    input areset,          // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    // State encoding
    parameter LEFT   = 3'b000, 
              RIGHT  = 3'b001, 
              FALL_L = 3'b010, 
              FALL_R = 3'b011,
              DIG_L  = 3'b100,
              DIG_R  = 3'b101,
              SPLAT  = 3'b110;

    reg [2:0] state, next_state;
    reg [31:0] fall_counter;

    // 1. State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;
            fall_counter <= 0;
        end else begin
            state <= next_state;

            // Update fall_counter only while falling
            if (state == FALL_L || state == FALL_R)
                fall_counter <= fall_counter + 1;
            else if (fall_counter > 20)
                fall_counter <= fall_counter;  // hold value to allow SPLAT on landing
            else
                fall_counter <= 0;
        end
    end

    // 2. Next-state logic
    always @(*) begin
        case (state)
            LEFT: begin
                if (!ground)
                    next_state = FALL_L;
                else if (dig)
                    next_state = DIG_L;
                else if (bump_left)
                    next_state = RIGHT;
                else
                    next_state = LEFT;
            end

            RIGHT: begin
                if (!ground)
                    next_state = FALL_R;
                else if (dig)
                    next_state = DIG_R;
                else if (bump_right)
                    next_state = LEFT;
                else
                    next_state = RIGHT;
            end

            FALL_L: begin
                if (ground && fall_counter >= 20)
                    next_state = SPLAT;
                else if (ground)
                    next_state = LEFT;
                else
                    next_state = FALL_L;
            end

            FALL_R: begin
                if (ground && fall_counter >= 20)
                    next_state = SPLAT;
                else if (ground)
                    next_state = RIGHT;
                else
                    next_state = FALL_R;
            end

            DIG_L: begin
                if (!ground)
                    next_state = FALL_L;
                else
                    next_state = DIG_L;
            end

            DIG_R: begin
                if (!ground)
                    next_state = FALL_R;
                else
                    next_state = DIG_R;
            end

            SPLAT: next_state = SPLAT;

            default: next_state = LEFT;
        endcase
    end

    // 3. Output logic (Moore)
    always @(*) begin
        // Default all outputs to 0
        walk_left  = 0;
        walk_right = 0;
        aaah       = 0;
        digging    = 0;

        case (state)
            LEFT:   walk_left  = 1;
            RIGHT:  walk_right = 1;
            FALL_L: aaah       = 1;
            FALL_R: aaah       = 1;
            DIG_L:  digging    = 1;
            DIG_R:  digging    = 1;
            SPLAT: ; // All outputs remain 0
        endcase
    end

endmodule
