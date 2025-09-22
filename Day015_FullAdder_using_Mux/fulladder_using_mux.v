`timescale 1ns / 1ps
module mux2_1(
    input m,n,
    input sel,
    output y_out );
    assign y_out= sel ? n : m;
endmodule

module full_adder(
    input a,b,cin,
    output sum, carry);
    wire [4:0]w;

    //sum = a ⊕ b ⊕ cin
    mux2_1 m0(1'b1, 1'b0, a, w[0]);          // w[0] = ~a
    mux2_1 m1(a, w[0], b, w[1]);             // w[1] = a ⊕ b
    mux2_1 m2(1'b1, 1'b0, w[1], w[2]);       // w[2] = ~(a ⊕ b)
    mux2_1 m3(w[1], w[2], cin, sum);         // sum = a ⊕ b ⊕ cin

    //carry = (a & b) + (cin & (a ⊕ b))
    mux2_1 m4(1'b0, w[1], cin, w[3]);        // w[3] = cin & (a ⊕ b)
    mux2_1 m5(1'b0, a, b, w[4]);             // w[4] = a & b
    mux2_1 m6(w[3], w[4], w[4], carry);      // carry = (a&b) + (cin & (a⊕b))
        
endmodule
