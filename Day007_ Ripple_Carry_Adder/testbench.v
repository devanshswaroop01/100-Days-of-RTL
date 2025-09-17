//Testbench:
`timescale 1ns/1ps
module adder4_tb;
  reg [3:0] A, B;
  reg cin;
  wire [3:0] S;
  wire cout;

  adder4 uut (.S(S), .cout(cout),.A(A), .B(B), .cin(cin));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, adder4_tb);

    $display("Time\tA\tB\tCin\t|\tS\tCout");
    $monitor("%0dns\t%b\t%b\t%b\t|\t%b\t%b", $time, A, B, cin, S, cout);

    A = 4'b0000; B = 4'b0000; cin = 0; #10;
    A = 4'b0001; B = 4'b0010; cin = 0; #10;
    A = 4'b0011; B = 4'b0011; cin = 1; #10;
    A = 4'b0101; B = 4'b0101; cin = 0; #10;
    A = 4'b1111; B = 4'b0001; cin = 1; #10;
    A = 4'b1010; B = 4'b0101; cin = 0; #10;
    A = 4'b1111; B = 4'b1111; cin = 1; #10;

    $finish;
  end
endmodule
 

