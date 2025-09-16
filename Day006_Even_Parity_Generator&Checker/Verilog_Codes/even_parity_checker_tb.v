//Testbench:
module tb_even_parity_checker;
  reg [3:0] in;
  reg p;
  wire error;
even_parity_checker DUT (.in(in), .p(p), .error(error));

  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_even_parity_checker);
  $monitor("Time = %0t | in = %b | p = %b | error = %b", $time, in, p, error);

    in = 4'b1010; p = 1'b0; #10;
    in = 4'b0001; p = 1'b1; #10;
    in = 4'b1110; p = 1'b0; #10;
    in = 4'b1001; p = 1'b1; #10;

    $finish;
  end
endmodule
