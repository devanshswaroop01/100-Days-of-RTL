//Testbench:
module demux1x2_tb;
reg I, sel;
wire y0, y1;
demux1x2 DUT (I, sel , y0, y1);

 initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, demux1x2_tb);
  $monitor("Time = %0t, I = %b, sel = %b, y0 = %b, y1 = %b", $time, I, sel, y0, y1);

    I = 0; sel = 0; #10;
    I = 0; sel = 1; #10;
    I = 1; sel = 0; #10;
    I = 1; sel = 1; #10;

    $finish;
  end
endmodule  