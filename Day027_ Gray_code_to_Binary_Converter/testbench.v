module gray_to_binary_tb;
reg  [3:0] gray_in;      
 wire [3:0] binary_out;    
gray_to_binary uut (
        .gray_in(gray_in),
        .binary_out(binary_out));

    initial begin
        $dumpfile("waveform.vcd");         
        $dumpvars(0, gray_to_binary_tb);   
        $display("Time\tGray\tBinary");
        $monitor("%0dns\t%b\t%b", $time, gray_in, binary_out);
      
        gray_in = 4'b0011; #10;
        gray_in = 4'b0010; #10;
       gray_in = 4'b0101; #10;
        gray_in = 4'b0100; #10;
       
$finish;
end
endmodule
