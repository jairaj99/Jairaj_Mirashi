module t_ff(input t, rst, clk, output q, qb);

wire w1;

d_ff d1(.d(w1), .rst(rst), .clk(clk), .q(q), .qb(qb) );
xor xor1(w1,t,q);

endmodule 