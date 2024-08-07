module up_counter( t,rst, clk, q, qb);

input [3:0] t;
input rst,clk;
output [3:0] q;
output [3:0] qb;
wire w1,w2,w3;

t_ff t1(.t(t[0]), .rst(rst), .clk(clk), .q(q[0]), .qb(w1));
t_ff t2(.t(t[1]), .rst(rst), .clk(w1), .q(q[1]), .qb(w2));
t_ff t3(.t(t[2]), .rst(rst), .clk(w2), .q(q[2]), .qb(w3));
t_ff t4(.t(t[3]), .rst(rst), .clk(w3), .q(q[3]), .qb(qb[3]));

endmodule