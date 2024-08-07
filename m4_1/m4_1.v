module m4_1(input I, S, output Y);
input [3:0] I;
input [1:0] S; 
output  Y;
wire w1,w2;

mux2to1 m1(.D0(I[0]), .D1(I[1]), .S(S[1]), .Y(w1));
mux2to1 m2(.D0(I[2]), .D1(I[3]), .S(S[1]), .Y(w2));
mux2to1 m3(.D0(w1), .D1(w2), .S(S[0]), .Y(Y));

endmodule