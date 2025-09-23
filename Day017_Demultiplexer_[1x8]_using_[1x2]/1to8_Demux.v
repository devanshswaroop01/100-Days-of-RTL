//1to2 demultiplexer
`timescale 1ns / 1ps
module demux_1_2(
  input sel,
  input i,
  output y0, y1);

  assign {y0,y1} = sel?{1'b0,i}: {i,1'b0};
endmodule

//1to8 demultiplexer
module demux_1_8(
    input [2:0]sel,
    input  i,
    output y0, y1, y2, y3, y4, y5, y6, y7);
    wire [5:0]z;

  // Stage 1: Split input into two groups based on sel[2] (MSB)
    demux_1_2 d1(sel[2], i, z[0], z[1]);

  // Stage 2: Further split each group using sel[1]
    demux_1_2 d2(sel[1], z[0], z[2], z[3]);
    demux_1_2 d3(sel[1], z[1], z[4], z[5]);

  // Stage 3: Final split into 8 outputs using sel[0] (LSB)
    demux_1_2 d4(sel[0], z[2], y0, y1);
    demux_1_2 d5(sel[0], z[3], y2, y3);
    demux_1_2 d6(sel[0], z[4], y4, y5);
    demux_1_2 d7(sel[0], z[5], y6, y7);
endmodule