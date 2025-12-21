`timescale 1ns / 1ps
module spi_state (
    input  wire        clk,        // System clock
    input  wire        reset,      // Asynchronous reset
    input  wire [15:0] datain,     // Parallel data input
    output wire        spi_cs_l,    // Active-low CS
    output wire        spi_sclk,    // SPI clock
    output wire        spi_data,    // MOSI
    output wire [4:0]  counter );

    // Internal registers

    reg [15:0] shift_reg;          // Shift register
    reg [4:0]  count;              // Bit counter
    reg        cs_l;
    reg        sclk;
    reg        mosi;
    reg [2:0]  state;

    // State encoding
    localparam IDLE  = 3'd0;
    localparam LOAD  = 3'd1;
    localparam CLK_H = 3'd2;
    localparam CLK_L = 3'd3;

    // Sequential FSM 
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 16'd0;
            count     <= 5'd15;
            cs_l      <= 1'b1;
            sclk      <= 1'b0;      // CPOL = 0
            mosi      <= 1'b0;
            state     <= IDLE;
        end
        else begin
            case (state)

                // ---------------- IDLE ----------------
                IDLE: begin
                    cs_l      <= 1'b1;
                    sclk      <= 1'b0;
                    count     <= 5'd15;
                    shift_reg <= datain;   // LOAD DATA ONCE
                    state     <= LOAD;
                end

                // -------- LOAD BIT & DRIVE MOSI --------
                LOAD: begin
                    cs_l  <= 1'b0;
                    mosi  <= shift_reg[count]; // MSB first
                    sclk  <= 1'b0;              // Data stable
                    state <= CLK_H;
                end

                // -------- CLOCK HIGH (Sample Edge) -----
                CLK_H: begin
                    sclk  <= 1'b1;
                    state <= CLK_L;
                end

                // -------- CLOCK LOW (Next Bit) ---------
                CLK_L: begin
                    sclk <= 1'b0;
                    if (count > 0) begin
                        count <= count - 1;
                        state <= LOAD;
                    end
                    else begin
                        cs_l  <= 1'b1;  // Deassert CS after last bit
                        state <= IDLE;
                    end
                end

                default: state <= IDLE;

            endcase
        end
    end

    // Outputs
    assign spi_cs_l = cs_l;
    assign spi_sclk = sclk;
    assign spi_data = mosi;
    assign counter  = count;

endmodule
