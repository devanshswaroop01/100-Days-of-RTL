//Testbench :
module tb_mux4to1;
    reg  [3:0] d;
    reg  [1:0] sel;
    wire y;

    mux4to1    M1 (
.d0(d[0]),  .d1(d[1]),  .d2(d[2]),  .d3(d[3]), .s1(sel[1]),  .s0(sel[0]),  .y(y));
    initial begin
        $dumpfile("mux4to1.vcd");
        $dumpvars(0, tb_mux4to1);
        $monitor("Time=%0t | sel=%b | y=%b", $time, sel, y);
        d = 4'b1010; // pattern: D3=1, D2=0, D1=1, D0=0

        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;
        $finish;
    end
endmodule


