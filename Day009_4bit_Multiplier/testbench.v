// Code your testbench here
// or browse Examples
//Testbench:
`timescale 1ns / 1ps
module multiplier_tb;
    reg  signed [3:0] a, b;
    wire  signed [7:0] mul_out;
    multiplier_4bit dut(a, b, mul_out);

    initial begin
        $dumpfile("waveform.vcd");         
        $dumpvars(0, multiplier_tb);   
        $monitor("%0d * %0d = %0d", a, b, mul_out);
        
        a = 4'b1010; b = 4'b1111; #10;   // -6 * -1 = +6
        a = 4'b0011; b = 4'b0101; #10;   //  3 * 5  = 15
        a = 4'b1111; b = 4'b1111; #10;   // -1 * -1 = 1

      	a = 4'b0010; b = 4'b1110; #10;   //  2 * -2 = -4
        a = 4'b0111; b = 4'b1001; #10;   //  7 * -7 = -49
      
      	a = 4'b1100; b = 4'b1101; #10;   // -4 * -3 = 12
        a = 4'b1011; b = 4'b1110; #10;   // -5 * -2 = 10
      
      	a = 4'b1000; b = 4'b1000;#10;  	 // -8 * -8 = 64
        a = 4'b1000; b = 4'b0111; #10;   // -8 *  7 = -56
      	
        $finish;
    end
endmodule
