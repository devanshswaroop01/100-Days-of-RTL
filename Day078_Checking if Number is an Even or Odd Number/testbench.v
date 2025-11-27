//Testbench : 
`timescale 1ns / 1ps
module even_odd_tb;
    reg [3:0] number;
    wire even_odd;
    even_or_odd dut(number, even_odd);

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, even_odd_tb);

        // Apply test vectors
        number = 4'd6;  #10;
        number = 4'd3;  #10;
        number = 4'd14; #10;
        number = 4'd10; #10;
        number = 4'd11; #10;
        number = 4'd7;  #10;

        #10 $finish;
    end
endmodule

