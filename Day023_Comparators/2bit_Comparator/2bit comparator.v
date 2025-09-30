//2 bit comparator
module comparator_2bit (
    input  A1, A0,
    input  B1, B0,
    output A_gt_B,A_eq_B, A_lt_B );

    wire x1, x0;
    wire nA1, nA0, nB1, nB0;
    wire term1, term2;
    wire term3, term4;

    // xnor gates
    xnor (x1, A1, B1);
    xnor (x0, A0, B0);
    // inverters
    not (nA1, A1);
    not (nA0, A0);
    not (nB1, B1);
    not (nB0, B0);

    //  A_eq_B = x1 & x0
    and (A_eq_B, x1, x0);

    //  A_gt_B = (A1 & ~B1) | (x1 & A0 & ~B0)
    and (term1, A1, nB1);
    and (term2, x1, A0, nB0);
    or  (A_gt_B, term1, term2);

    //  A_lt_B = (~A1 & B1) | (x1 & ~A0 & B0)
    and (term3, nA1, B1);
    and (term4, x1, nA0, B0);
    or  (A_lt_B, term3, term4);
endmodule
