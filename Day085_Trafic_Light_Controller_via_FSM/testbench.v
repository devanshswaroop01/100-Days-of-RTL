//Testbench:
`timescale 1ns/1ps
module test_bench;
  wire [1:0] MAIN_SIG, CNTRY_SIG;
  reg CLOCK, CLEAR, CAR_ON_CNTRY_ROAD;
  sig_control SC( MAIN_SIG , CNTRY_SIG, CAR_ON_CNTRY_ROAD, CLOCK, CLEAR);

  initial begin
    CLOCK = `FALSE;
    forever #5 CLOCK = ~CLOCK;
  end

  // Control clear signal
  initial begin
    CLEAR = `TRUE;
    repeat (5) @(negedge CLOCK);
    CLEAR = `FALSE;
  end

  initial begin 
    CAR_ON_CNTRY_ROAD = `FALSE;

    #200 CAR_ON_CNTRY_ROAD = `TRUE;

    #200 CAR_ON_CNTRY_ROAD = `FALSE;

    #200 CAR_ON_CNTRY_ROAD = `TRUE;

    #200 CAR_ON_CNTRY_ROAD = `FALSE;

    #200 CAR_ON_CNTRY_ROAD = `TRUE;

    #200 CAR_ON_CNTRY_ROAD = `FALSE;
    #100 $finish;
  end 

initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, test_bench);
  $monitor($time, " Main sig=%b ,Country sig=%b , Car on cntry road=%b",  MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_ROAD); 
  end
 endmodule
