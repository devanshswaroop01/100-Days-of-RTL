//Four Bit Ripple Carry Adder 
module full_adder(input a, b, cin, output sum, cout);
  assign sum = a ^ b ^ cin;
  assign cout = (a & b) | (b & cin) | (cin & a);
endmodule

module adder4(A,B,cin, S,cout);
  input [3:0] A;
  input [3:0] B;
  input cin;
  output [3:0] S;
  output cout;
  wire c1, c2, c3;
 full_adder FA0(A[0], B[0], cin, S[0], c1);
  full_adder FA1(A[1], B[1], c1,  S[1], c2);
  full_adder FA2(A[2], B[2], c2,  S[2], c3);
  full_adder FA3(A[3], B[3], c3,  S[3], cout);
endmodule
