//Testbench:
`timescale 1ns / 1ps
module multiplier_tb;
    reg  [3:0] a, b;
    wire [7:0] mul_out;
    multiplier_4bit dut(a, b, mul_out);

    initial begin
        $dumpfile("waveform.vcd");         
        $dumpvars(0, multiplier_tb);   
        $monitor("%0d * %0d = %0d", a, b, mul_out);
        
        a = 4'b1010; b = 4'b1111;#10;
        a = 4'b0011; b = 4'b0101;#10;
        a = 4'b1111; b = 4'b1111;#10;
        
        $finish;
    end
endmodule
