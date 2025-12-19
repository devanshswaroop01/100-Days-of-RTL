// Rule 110 is a one-dimensional cellular automaton in which each cell is either 0 (off) or 1 (on). At each time step, every cell updates its value based solely on itself and its two immediate neighbors, according to the following rule table:

// Left	Center	Right	Next Center
// 1	1	1	0
// 1	1	0	1
// 1	0	1	1
// 1	0	0	0
// 0	1	1	1
// 0	1	0	1
// 0	0	1	1
// 0	0	0	0

// (The next-state column interpreted as a binary number 01101110₂ equals decimal 110, giving the rule its name.)

// Task
// Design a circuit that implements a 512-cell Rule-110 system:
// The current state of the automaton is held in a 512-bit register q[511:0].
// On each rising clock edge, the system must advance one time step, updating all 512 cells in parallel using Rule 110.

// Inputs:
// clk — clock
// load — when load = 1, the system must load the next state from data[511:0] instead of computing Rule 110
// data[511:0] — initial or externally supplied state

// Output:
// q[511:0] — current state of all 512 cells
// Assume the boundary cells outside the array are always 0:
// q[-1] = 0
// q[512] = 0

// Implement the logic to compute the next value of each cell based on its left, center, and right neighbors according to Rule 110.

module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q ); 

    reg [512:-1] q_next;
    reg [511:0] q_next_next;
    
    integer i;
    always @(*) begin
        q_next = 514'b0;
        q_next[511:0] = q;
        for(i = 0; i < 512;i=i+1) begin
            case({q_next[i-1], q_next[i], q_next[i+1]})
                3'b111: q_next_next[i] = 1'b0;
                3'b110: q_next_next[i] = 1'b1;
                3'b101: q_next_next[i] = 1'b1;
                3'b100: q_next_next[i] = 1'b1;
                3'b011: q_next_next[i] = 1'b1;
                3'b010: q_next_next[i] = 1'b1;
                3'b001: q_next_next[i] = 1'b0;
                3'b000: q_next_next[i] = 1'b0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if(load)
            q <= data;
        else
            q <= q_next_next;
    end
endmodule
