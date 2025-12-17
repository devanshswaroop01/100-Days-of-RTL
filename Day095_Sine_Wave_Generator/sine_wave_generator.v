`timescale 1ns / 1ps

// 2x1 single-bit multiplexer
module mux(o,i1,i2,s);
input i1,i2,s;
output o;
wire sc;

not(sc,s);
assign o = (i1 & sc) | (i2 & s);
endmodule


// 2x1 multiplexer with 16-bit data
module mux_16(o,i1,i2,s);
input  [15:0] i1,i2;
input         s;
output [15:0] o;

mux m[15:0](o,i1,i2,s);
endmodule


// 8x1 multiplexer with 16-bit data
module mux_16_8(o,i1,i2,i3,i4,i5,i6,i7,i8,s);
input  [15:0] i1,i2,i3,i4,i5,i6,i7,i8;
input  [2:0]  s;
output [15:0] o;

wire [15:0] x1,x2,x3,x4,y1,y2;

mux_16 m1(x1,i1,i2,s[0]);
mux_16 m2(x2,i3,i4,s[0]);
mux_16 m3(x3,i5,i6,s[0]);
mux_16 m4(x4,i7,i8,s[0]);

mux_16 m5(y1,x1,x2,s[1]);
mux_16 m6(y2,x3,x4,s[1]);

mux_16 m7(o,y1,y2,s[2]);
endmodule


// 64x1 multiplexer with 16-bit data
module mux_16_64(o,
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,
i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,
i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,
i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64,
s);

input  [15:0]
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,
i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,
i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,
i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64;

input  [5:0]  s;
output [15:0] o;

wire [15:0] x1,x2,x3,x4,x5,x6,x7,x8;

mux_16_8 m1(x1,i1,i2,i3,i4,i5,i6,i7,i8,s[2:0]);
mux_16_8 m2(x2,i9,i10,i11,i12,i13,i14,i15,i16,s[2:0]);
mux_16_8 m3(x3,i17,i18,i19,i20,i21,i22,i23,i24,s[2:0]);
mux_16_8 m4(x4,i25,i26,i27,i28,i29,i30,i31,i32,s[2:0]);
mux_16_8 m5(x5,i33,i34,i35,i36,i37,i38,i39,i40,s[2:0]);
mux_16_8 m6(x6,i41,i42,i43,i44,i45,i46,i47,i48,s[2:0]);
mux_16_8 m7(x7,i49,i50,i51,i52,i53,i54,i55,i56,s[2:0]);
mux_16_8 m8(x8,i57,i58,i59,i60,i61,i62,i63,i64,s[2:0]);

mux_16_8 m9(o,x1,x2,x3,x4,x5,x6,x7,x8,s[5:3]);
endmodule


// Sine wave generator using 64-point LUT
module sine_wave_generator(o,t);
input  [9:0]  t;
output [15:0] o;

reg [15:0]
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,
i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,
i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,
i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64;

mux_16_64 m(o,
i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12,i13,i14,i15,i16,
i17,i18,i19,i20,i21,i22,i23,i24,i25,i26,i27,i28,i29,i30,i31,i32,
i33,i34,i35,i36,i37,i38,i39,i40,i41,i42,i43,i44,i45,i46,i47,i48,
i49,i50,i51,i52,i53,i54,i55,i56,i57,i58,i59,i60,i61,i62,i63,i64,
t[5:0]);

initial begin
//1000*sin(t*360/64)+1000 values recorded in order
i1=1000; i2=1098; i3=1195; i4=1290;
i5=1383; i6=1471; i7=1556; i8=1634;
i9=1707; i10=1773; i11=1831; i12=1882;
i13=1924; i14=1957; i15=1981; i16=1995;
i17=2000; i18=1995; i19=1981; i20=1957;
i21=1924; i22=1882; i23=1831; i24=1773;
i25=1707; i26=1634; i27=1556; i28=1471;
i29=1383; i30=1290; i31=1195; i32=1098;
i33=1000; i34=902;  i35=805;  i36=710;
i37=617;  i38=529;  i39=444;  i40=366;
i41=293;  i42=227;  i43=169;  i44=118;
i45=76;   i46=43;   i47=19;   i48=5;
i49=0;    i50=5;    i51=19;   i52=43;
i53=76;   i54=118;  i55=169;  i56=227;
i57=293;  i58=366;  i59=444;  i60=529;
i61=617;  i62=710;  i63=805;  i64=902;
end
endmodule

 
