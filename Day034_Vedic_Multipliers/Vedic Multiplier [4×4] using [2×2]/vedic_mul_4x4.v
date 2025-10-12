`timescale 1ns / 1ps
module half_adder(
    input a,b,
    output sum,carry);

    assign sum=a^b;
    assign carry=a&b;
endmodule

module vedic_2x2(
    input [1:0] a,b,
    output [3:0] out );
    wire [3:0] w;

        and m1(out[0],a[0],b[0]);           // LSB partial product

        and m2(w[0],a[0],b[1]);             // Cross product 1

        and m3(w[1],a[1],b[0]);             // Cross product 2

        and m4(w[2],a[1],b[1]);             // MSB partial product

    half_adder ha1(w[0],w[1],out[1],w[3]);  // Add cross products

    half_adder ha2(w[3],w[2],out[2],out[3]);// Add carry with MSB product
endmodule

module adder_4bit(
    input [3:0] x,y,
    output [3:0] z);

    assign z=x+y;
endmodule

module adder_6bit(
    input [5:0] x,y,
    output [5:0] z);

    assign z=x+y;
endmodule

module vedic_4x4(
    input [3:0] a,b,
    output [7:0] out  );
    wire [3:0] w3,w2,w1,w0,w;
    wire [5:0] w4;

        vedic_mul_2_2 m1(b[3:2],a[3:2],w3[3:0]);        // High × High

        vedic_mul_2_2 m2(b[3:2],a[1:0],w2[3:0]);        // High × Low

        vedic_mul_2_2 m3(b[1:0],a[3:2],w1[3:0]);        // Low × High

        vedic_mul_2_2 m4(b[1:0],a[1:0],w0[3:0]);        // Low × Low

    adder_6bit m5({w3[3:0],2'b00}, {2'b00,w2[3:0]}, w4);// Align & sum top products

    adder_4bit m6(w1[3:0], {2'b00,w0[3:2]}, w);         // Align & sum cross + low

    adder_6bit m7(w4, {2'b00,w[3:0]}, out[7:2]);        // Final top 6 bits

    assign out[1:0]=w0[1:0];                            // lower bits are obtained directly from w0
endmodule
