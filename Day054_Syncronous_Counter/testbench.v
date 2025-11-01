`timescale 1ns/1ps
module test_bench;
  reg clear_n;
  reg clock;
  reg count_enable;
  wire [3:0] Q;
  sync_counter uut (.Q(Q), .clear_n(clear_n), .clock(clock),.count_enable(count_enable) );

  
  initial begin
    clock = 0;
    forever #5 clock = ~clock; // clock period  =  10 time units
  end

  initial begin
    $display("time\tclear_n\tcount_en\tQ[3:0]");
    $monitor("%0t \t %b \t %b \t \t %b %0d ",$time, clear_n, count_enable, Q , Q);
    $dumpfile("waveform.vcd");
    $dumpvars(0, test_bench);

    //  reset assert (active-low)
    clear_n = 0; count_enable = 0;#10;

    clear_n = 1; #10;   // release reset

    count_enable = 1;   #185; // enable counting

    count_enable = 0; #10; // disable counting

    clear_n = 0; #10;

    clear_n = 1;  #20;

    $finish;
  end
endmodule

