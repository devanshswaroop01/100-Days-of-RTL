//testbench :
`timescale 1ns / 1ps
module pallindrome_tb;
    reg [15:0] number;
    wire is_palindrome;
    Palindrome dut(number, is_palindrome);

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, pallindrome_tb); 

        number = 16'd18681; #10;   // palindrome
        number = 16'd3453;  #10;   // not palindrome
        number = 16'd14441; #10;   // palindrome

        number = 16'd51125; #10;   // not palindrome
        number = 16'd12021; #10;   // palindrome
        number = 16'd35153; #10;   // palindrome

        number = 16'd8998;  #10;   // palindrome
        number = 16'd6196;  #10;   // palindrome
        #80 $finish;
    end
endmodule