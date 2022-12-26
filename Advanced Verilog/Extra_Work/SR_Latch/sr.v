module sr(s,r,q,qb);
 
input s,r;
output q;
output qb;
 
nor x1(q, r, qb);
nor x2(qb, s, q);

endmodule