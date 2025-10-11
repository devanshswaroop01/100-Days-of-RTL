`timescale 1ns / 1ps
module vedic_2x2_tb ;
    reg [1:0] a, b;
    wire [3:0] out;
vedic_2x2 dut(a, b, out);

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, vedic_2x2_tb);
        $monitor("%d * %d = %d", a, b, out);

        a = 2'd2; b = 2'd1;  #10;
        a = 2'd3; b = 2'd2;  #10;
        a = 2'd0; b = 2'd1; #10;
       #60 $finish;
end
endmodule
