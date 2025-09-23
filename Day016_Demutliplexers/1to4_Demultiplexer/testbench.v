//Testbench :
module demux_1to4_tb;
reg I, S0, S1;
wire Y0, Y1, Y2, Y3;
demux_1to4 uut (I, S0, S1, Y0, Y1, Y2, Y3);

initial begin
      $dumpfile("waveform.vcd");
      $dumpvars(0,demux_1to4_tb );
      $monitor("I=%b, S1=%b, S0=%b => Y0=%b Y1=%b Y2=%b Y3=%b",I, S1, S0, Y0, Y1, Y2, Y3);

    I = 1; S1=0; S0=0; #10;
    I = 1; S1=0; S0=1; #10;
    I = 1; S1=1; S0=0; #10;
    I = 1; S1=1; S0=1; #10;
    // check when input=0
    I = 0; S1=0; S0=0; #10; 
    $finish;
end
endmodule


