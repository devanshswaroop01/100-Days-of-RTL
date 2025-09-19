//2:1 Multiplexer 
//Using Dataflow Modelling
module mux2to1(
  input wire a,
  input wire b,
  input wire sel,
  output wire y  );

assign y = sel ? b : a;
endmodule

//Using Behavioural  Modelling
module mux2to1(
  input wire a,
  input wire b,
  input wire sel,
  output reg y    );

always@(*) begin
    if (sel) y = b;
    else y = a;
  end
endmodule

// using Gate Level Modelling 
module mux2to1(a,b,sel,y);
  input a, b, sel;
  output y ;
  wire sel_n;
  wire and1, and2;

  not  u1(sel_n, sel);
  and  u2(and1, a, sel_n);
  and  u3(and2, b, sel);
  or   u4(y, and1, and2);  // y = (a & ~sel) | (b & sel)

endmodule

