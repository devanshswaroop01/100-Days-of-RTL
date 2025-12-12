`timescale 1ns/1ps
module parity (
    input clk,
    input reset,
    input in,
    output reg odd);

    always @(posedge clk)
        if (reset) odd <= 0;
        else if (in) odd <= ~odd;

endmodule

module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg  [7:0] out_byte,
    output reg done);

    parameter IDLE = 3'd0,START = 3'd1,DATA = 3'd2;
    parameter STOP = 3'd3,WAIT = 3'd4;

    reg [2:0] current_state,next_state;
    reg [3:0] counter;
    reg [8:0] data_in;
    reg odd_temp;
    wire Isdone;


    always @(*) begin
        case(current_state)
            IDLE:begin
                if(~in)begin
                    next_state = START;
                end
                else begin
                    next_state = IDLE;
                end
            end
            START:begin
                next_state = DATA;
            end
            DATA:begin
                if(counter == 4'd9)begin
                    next_state = in ? STOP : WAIT;
                end
                else begin
                    next_state = DATA;
                end
            end
            STOP:begin
                next_state = in ? IDLE : START;
            end
            WAIT:begin
                next_state = in ? IDLE : WAIT;
            end
            default:begin
                next_state = IDLE;
            end
        endcase
    end

    always @(posedge clk) begin
        if(reset)begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(posedge clk) begin
        if(reset)begin
            done <= 1'd0;
            out_byte <= 8'd0;
            counter <= 4'd0;
        end
        else begin
            case(next_state)
                IDLE:begin
                    done <= 1'd0;
                    out_byte <= 8'd0;
                    counter <= 4'd0;
                end
                START:begin
                    done <= 1'd0;
                    out_byte <= 8'd0;
                    counter <= 4'd0;
                end
                DATA:begin
                    done <= 1'd0;
                    out_byte <= 8'd0;
                    counter <= counter + 1'd1;
                    data_in[counter] <= in;
                end
                STOP:begin
                    done <= odd_temp ? 1'd1 : 1'd0;
                    out_byte <= odd_temp ? data_in[7:0] : 8'd0;
                    counter <= 4'd0;
                end
                WAIT:begin
                    done <= 1'd0;
                    out_byte <= 8'd0;
                    counter <= 4'd0;
                end
            endcase
        end
    end
    // Add parity checking.
    wire odd_temp1;
    assign Isdone = (next_state == START);
    parity u0 (clk ,Isdone,in,odd_temp1);
endmodule
