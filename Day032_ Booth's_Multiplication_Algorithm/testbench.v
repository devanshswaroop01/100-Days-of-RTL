module Booths_Algo_tb;
  reg signed [3:0] Q, M;
  wire signed [7:0] Result;
  Booths_Algo dut(Q, M, Result);

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, Booths_Algo_tb);
    $monitor("%0d * %0d = %0d", Q, M, Result);

    Q = 3;  M = 7;   #10;
    Q = 3;  M = -7;  #10;
    Q = -3; M = 7;   #10;
    Q = -3; M = -7;  #10;

    #10 $finish;
  end
endmodule