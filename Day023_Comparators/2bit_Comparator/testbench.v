//testbench:
module tb_comparator_2bit;
reg A1, A0, B1, B0;
wire A_gt_B, A_eq_B, A_lt_B;
comparator_2bit uut (.A1(A1), .A0(A0), .B1(B1), .B0(B0),
                    .A_gt_B(A_gt_B), .A_eq_B(A_eq_B), .A_lt_B(A_lt_B));

integer i, j;
initial begin
  $dumpfile("waveform.vcd");
  $dumpvars (0,tb_comparator_2bit);
$display(" A1A0 | B1B0 || A_gt_B A_eq_B A_lt_B ");
$display("------------------------------------");
   for (i = 0; i < 4; i = i + 1) begin {A1, A0} = i;
   for (j = 0; j < 4; j = j + 1) begin {B1, B0} = j;#5; 
$display("   %b%b|   %b%b||   %b   %b     %b",A1, A0, B1, B0, A_gt_B, A_eq_B, A_lt_B);
                end 
            end
        $finish;
    end
endmodule
