 // 2-to-1 Multiplexer
module mux_2_1(
    input [1:0] i,
    input select,
    output y_out    );
    assign y_out = select ? i[1] : i[0];
endmodule

module gates_mux(
    input a, b,
    output and_out, or_out, not_out );
 
 mux_2_1 mand({1'b0, b}, a, and_out);      // AND
 mux_2_1 mor({b, 1'b1}, a, or_out);        // OR
 mux_2_1 mnot({1'b1, 1'b0}, a, not_out);   // NOT a
  
endmodule






