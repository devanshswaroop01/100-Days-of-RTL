//testbench
module binary_to_gray_tb;
reg [3:0] bin;
wire [3:0] gray;

    binary_to_gray dut(bin, gray);

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, binary_to_gray_tb);
    $monitor("binary: %b -> gray: %b", bin, gray);

    bin= 4'd1; #10;
    bin= 4'd4; #10;
    bin= 4'd7; #10;
    bin= 4'd10; #10;
    bin= 4'd13; #10;
end
endmodule
 








