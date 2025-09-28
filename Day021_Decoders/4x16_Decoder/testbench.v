
//testbench :
module decoder4x16_tb;
  reg [3:0] I;
  wire [15:0] Y;
  decoder_4x16  dut (.sel(I), .y(Y));

  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, decoder4x16_tb);
    $monitor("Time = %0t | I = %b | Y = %b", $time, I, Y);

    I = 4'b0000; #10;
    I = 4'b0001; #10;
    I = 4'b0101; #10;
    I = 4'b0111; #10;
    I = 4'b1111; #10;
$finish;
  end
endmodule


