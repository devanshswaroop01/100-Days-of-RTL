// The PS/2 mouse protocol transmits data in continuous streams of 3-byte packets. Only the first byte of each packet is identifiable, because bit[3] = 1 for the first byte but may be 0 or 1 for the remaining two bytes.

// Part 1 — FSM for Packet Detection
// Design a finite state machine that reads an 8-bit serial byte stream and detects valid 3-byte PS/2 packets.

// The FSM must:
// Ignore input bytes until it receives one with bit[3] = 1, which marks byte 1 of a packet.
// Then capture the next two bytes as byte 2 and byte 3 of the packet.
// Assert done = 1 for one cycle immediately after the third byte has been received.

// Part 2 — Add Datapath for Packet Output
// Extend the design so that whenever a full packet is received:
// The 3 bytes are output as a 24-bit value:
// out_bytes[23:16] = first byte  
// out_bytes[15:8]  = second byte  
// out_bytes[7:0]   = third byte


// out_bytes must be valid only when done = 1.
// At all other times, out_bytes may hold any value (don’t-care).

module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    parameter IDLE  = 4'b0001;
    parameter BYTE1 = 4'b0010;
    parameter BYTE2 = 4'b0100;
    parameter BYTE3 = 4'b1000;
    reg [3:0] state, next_state;

    // next state logic 
    always @(*)begin
        next_state = 4'd0;
        case(state)
            IDLE: next_state = in[3]? BYTE1:IDLE;
            BYTE1:next_state = BYTE2;
            BYTE2:next_state = BYTE3;
            BYTE3:next_state = in[3]? BYTE1:IDLE;
            default:next_state = IDLE;
        endcase
    end
    //state transition logic 
    always @(posedge clk)begin
        if(reset)begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    // Output logic
    reg [7:0] byte1,byte2,byte3;       //db=>data_byte
    assign done = (state == BYTE3);
    always @(posedge clk)begin
        if(reset)begin
            byte1 <= 8'd0;
            byte2 <= 8'd0;
            byte3 <= 8'd0;
        end
        else begin
            case(next_state)
                BYTE1:byte1 <= in;
                BYTE2:byte2 <= in;
                BYTE3:byte3 <= in;
            endcase
        end
    end
    assign out_bytes = {byte1,byte2,byte3};
endmodule
