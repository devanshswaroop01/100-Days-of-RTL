//testbench:
module decoder3x8_tb;
  reg [2:0] sel;
  wire [7:0] y;
  decoder3x8 DUT(sel, y);

  initial begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0, decoder3x8_tb);
    $monitor("Time = %0t, sel = %b, y = %b", $time, sel, y);

    sel = 3'b000; #10;
    sel = 3'b001; #10;
    sel = 3'b010; #10;
    sel = 3'b011; #10;

    sel = 3'b100; #10;
    sel = 3'b101; #10;
    sel = 3'b110; #10;
    sel = 3'b111; #10;

    $finish;
  end
endmodule
