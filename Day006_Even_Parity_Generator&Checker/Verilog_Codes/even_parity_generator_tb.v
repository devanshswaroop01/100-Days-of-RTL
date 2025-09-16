//Testbench:
module tb_even;
  reg [3:0] in;
  wire p;
 even_parity DUT (.in(in), .p(p));

  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0, tb_even);
    $monitor("Time = %0t | in = %b, p = %b ", $time, in, p);
    in = 4'b1010; #10;
    in = 4'b0001; #10;
    in = 4'b1110; #10;
    in = 4'b1001; #10;

    $finish;
  end
endmodule
