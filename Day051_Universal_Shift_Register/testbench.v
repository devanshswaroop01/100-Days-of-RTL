//Testbench:
module univ_shift_reg_tb;
    reg clk, reset;
    reg [1:0] ctrl;       // 00 = load, 01 = hold,10 = shift left, 11 = shift right
    reg [7:0] data_in;
    wire [7:0] data_out;
univ_shift_reg DUT ( .clk(clk), .reset(reset), .ctrl(ctrl), .data_in(data_in), .data_out(data_out));

always #5 clk = ~clk;
initial begin
    clk = 0;
    reset = 1;        // Apply rseset
    ctrl = 2'b00;
    data_in = 8'b01010101; #10;

  reset = 0; #10;    // Deassert reset

  ctrl = 2'b01; #10;

  ctrl = 2'b10; #10;

  ctrl = 2'b11; #10;
    $finish;
  end

 initial begin
      $dumpfile("waveform.vcd");
      $dumpvars(0, univ_shift_reg_tb);
      $monitor("Time=%0t | Ctrl=%b | Data_in=%b | Data_out=%b", $time, ctrl, data_in, data_out);
    end
endmodule
