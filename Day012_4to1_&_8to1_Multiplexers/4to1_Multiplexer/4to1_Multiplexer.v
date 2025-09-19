//4:1 Multiplexer via Gate Level Modelling
module mux4to1 (d0, d1, d2, d3, s1 , s0 , y);
    input  d0, d1, d2, d3;
    input  s1, s0;
    output y;
    wire ns1, ns0;
    wire t0, t1, t2, t3;

    not (ns1, s1);
    not (ns0, s0);

    and (t0, d0, ns1, ns0); // Select D0  when s1=0, s0=0
    and (t1, d1, ns1, s0);  // Select D1  when s1=0, s0=1
    and (t2, d2, s1, ns0);  // Select D2  when s1=1, s0=0
    and (t3, d3, s1, s0);   // Select D3  when s1=1, s0=1

    or  (y, t0, t1, t2, t3);
endmodule














