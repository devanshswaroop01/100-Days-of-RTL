//testbench: 
`timescale 1ns / 1ps
module prime_tb;
reg [7:0] number;
wire is_prime;
prime dut(number, is_prime);

initial  begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, prime_tb); 

    number=8'd36; #10;
    number=8'd71; #10;
    number=8'd49; #10;
    number=8'd11; #10;
    number=8'd3;  #10;
    number=8'd91; #10;

    #60 $finish;
end 
endmodule