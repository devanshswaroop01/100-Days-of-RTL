`timescale 1ns / 1ps
module tb_not;
    reg in;
    wire out;
    not_gate dut(in, out);

    initial in= 1'b0;
    initial forever #50 in = ~in;
    initial #600 $finish;

    initial begin
        $dumpfile("waveform.vcd");   
        $dumpvars(0, tb_not);      
        $monitor("Time = %0t | in = %b | out = %b", $time, in, out);
    end
endmodule