//testbench :
`timescale 1ns / 1ps
module armstrong_tb;
    reg [8:0] number;
    wire is_armstrong;
    armstrong dut(number, is_armstrong);

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, armstrong_tb);

        number = 9'd153; #10;
        number = 9'd300; #10;
        number = 9'd370; #10;

        number = 9'd190; #10;
        number = 9'd407; #10;
        number = 9'd420; #10;
        #60 $finish;
    end
endmodule

