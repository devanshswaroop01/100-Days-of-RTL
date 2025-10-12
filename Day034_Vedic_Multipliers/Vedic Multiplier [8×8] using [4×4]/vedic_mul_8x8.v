module half_adder(
    input a,b,
    output sum,carry );
    assign sum = a ^ b;
    assign carry = a & b;
endmodule


module vedic_2x2(
input [1:0] a,b,
output [3:0] out);
wire [3:0] w;

    and m1(out[0],a[0],b[0]);
    and m2(w[0],a[0],b[1]);
    and m3(w[1],a[1],b[0]);
    and m4(w[2],a[1],b[1]);

half_adder ha1(w[0],w[1],out[1],w[3]);
half_adder ha2(w[3],w[2],out[2],out[3]);
endmodule


module adder_4bit(
    input [3:0] x,y,
    output [3:0] z);

    assign z = x + y;
endmodule


module adder_6bit(
    input [5:0] x,y,
    output [5:0] z);

    assign z = x + y;
endmodule


module vedic_4x4(
input [3:0] a,b,
output [7:0] out );
wire [3:0] w3,w2,w1,w0,w;
wire [5:0] w4;

    vedic_2x2 m1(a[3:2],b[3:2],w3[3:0]);
    vedic_2x2 m2(a[1:0],b[3:2],w2[3:0]);
    vedic_2x2 m3(a[3:2],b[1:0],w1[3:0]);
    vedic_2x2 m4(a[1:0],b[1:0],w0[3:0]);

    adder_6bit m5({w3,2'b00},{2'b00,w2},w4);
    adder_4bit m6(w1,{2'b00,w0[3:2]},w);
    adder_6bit m7(w4,{2'b00,w},out[7:2]);

    assign out[1:0] = w0[1:0];
    endmodule


module adder_8bit(
    input [7:0] x,y,
    output [7:0] z);

    assign z = x + y;
endmodule

module adder_12bit(
    input [11:0] x,y,
    output [11:0] z);

    assign z = x + y;
endmodule


module vedic_8x8(
    input [7:0] a,b,
    output [15:0] c);
    wire [7:0] q0,q1,q2,q3;
    wire [7:0] q4;
    wire [11:0] temp2,temp3,temp4;
    wire [11:0] q5,q6;
vedic_4x4 z1(a[3:0], b[3:0], q0);   // Lowest Part
vedic_4x4 z2(a[7:4], b[3:0], q1);   // Cross Part 1
vedic_4x4 z3(a[3:0], b[7:4], q2);   // Cross aprt 2
vedic_4x4 z4(a[7:4], b[7:4], q3);   // Highest Part

// Step 1: Add shifted partial products from q1 and q0
adder_8bit z5(q1, {4'b0000, q0[7:4]}, q4);

// Step 2: Prepare 12-bit additions
    assign temp2 = {4'b0000, q4};   // Align q4 in lower bits

    assign temp3 = {q3, 4'b0000};   // Shift q3 left by 4

    adder_12bit z6(temp2, temp3, q5);

    assign temp4 = {4'b0000, q2};  // Align q2

    adder_12bit z7(temp4, q5, q6);
// Output
  assign c[3:0]   = q0[3:0]; // Lowest part of product

  assign c[15:4]  = q6;      // Upper part of product
endmodule
