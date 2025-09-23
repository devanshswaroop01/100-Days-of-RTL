// 1:4 Demux using Gate-Level Modeling
module demux_1to4 (
    input I,
    input S0, S1,
    output Y0, Y1, Y2, Y3 );
    wire S0_bar, S1_bar;

not (S0_bar, S0);
not (S1_bar, S1);

and (Y0, I, S0_bar, S1_bar); // Y0 = I & ~S1 & ~S0
and (Y1, I, S0,     S1_bar); // Y1 = I & ~S1 &  S0
and (Y2, I, S0_bar, S1);     // Y2 = I &  S1 & ~S0
and (Y3, I, S0,     S1);     // Y3 = I &  S1 &  S0
endmodule










