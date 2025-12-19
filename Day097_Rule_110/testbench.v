`timescale 1ns/1ps
module tb_rule110;

    reg clk;
    reg load;
    reg [511:0] data;
    wire [511:0] q;
    top_module dut(.clk(clk), .load(load), .data(data), .q(q));

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    initial begin
        $dumpfile("rule110.vcd");
        $dumpvars(0, tb_rule110);
        load = 1;
        data = 512'b0;
        data[256] = 1'b1;   // Single seed in the middle
        #10;
        load = 0;
        repeat (20) begin
            #1;
            $display("t=%0t  q=%b", $time, q);
        end
        $finish;
    end
endmodule
