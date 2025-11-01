//J K Flipflop
`timescale 1ns/1ps
module jk_ff (
    output reg q,
    output     qbar,
    input      J, K,  clear_n,clock );
    assign qbar = ~q;

  always @(posedge clock or negedge clear_n) begin
    if (!clear_n)
                q <= 1'b0; // asynchronous active-low clear
    else begin
      case ({J,K})
        2'b00: q <= q;            // no change
        2'b01: q <= 1'b0;         // reset
        2'b10: q <= 1'b1;         // set
        2'b11: q <= ~q;           // toggle
      endcase
    end
end
endmodule

// Syncronous Up Counter Module
module sync_counter (
    output [3:0] Q,
    input        clear_n,       // active-low clear
    input        clock,
    input        count_enable);
    wire [3:0] J, K;

// Dataflow: compute J and K (for an up counter)
  assign J[0] = count_enable;
  assign K[0] = count_enable;
  assign J[1] = count_enable & Q[0];
  assign K[1] = count_enable & Q[0];

  assign J[2] = count_enable & Q[0] & Q[1];
  assign K[2] = count_enable & Q[0] & Q[1];
  assign J[3] = count_enable&Q[0]&Q[1]&Q[2];
  assign K[3] = count_enable&Q[0]&Q[1]& Q[2];

  // Instantiate 4 JK flip-flops 
  jk_ff jk0 (.q(Q[0]), .qbar(), .J(J[0]), .K(K[0]), .clear_n(clear_n), .clock(clock));
  jk_ff jk1 (.q(Q[1]), .qbar(), .J(J[1]), .K(K[1]), .clear_n(clear_n), .clock(clock));
  jk_ff jk2 (.q(Q[2]), .qbar(), .J(J[2]), .K(K[2]), .clear_n(clear_n), .clock(clock));
  jk_ff jk3 (.q(Q[3]), .qbar(), .J(J[3]), .K(K[3]), .clear_n(clear_n), .clock(clock));
endmodule
