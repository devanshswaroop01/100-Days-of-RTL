`timescale 1ns / 1ps

module tb_nor;
    reg Vin1, Vin2;
    wire Vout;
    nor_gate dut(Vin1, Vin2, Vout);
    initial Vin1= 1'b0;
    initial Vin2= 1'b0;
    initial forever #50 Vin1 = ~Vin1;
    initial forever #100 Vin2 = ~Vin2;
    initial #600 $finish;

      initial begin
        $dumpfile("waveform.vcd");   
        $dumpvars(0, tb_nor);      
        $monitor("Time = %0t | Vin1 = %b | Vin2 = %b | Vout = %b", $time, Vin1,Vin2, Vout);
    end
endmodule