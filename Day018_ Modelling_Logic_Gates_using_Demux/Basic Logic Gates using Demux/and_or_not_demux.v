//1x2 demux
`timescale 1ns / 1ps
module demux_1_2(
    input sel,
    input i,
    output y0, y1);
    assign {y0,y1} = sel ? {1'b0, i} : {i, 1'b0};
endmodule

//and or not gates using 1x2 demux 
module demux_gates(
    input a, b,
    output and_g, or_g, not_g);
    wire w0, w1, w2;
  	wire t0, t1;

    demux_1_2 andgate(.sel(a),.i(b),.y0(w0),.y1(and_g)); 

    demux_1_2 notgate( .sel(a), .i(1'b1),.y0(not_g), .y1(w1));

    demux_1_2 orgate(.sel(a), .i(b), .y0(t0), .y1(t1));
    assign or_g = t0 | t1;   
endmodule
