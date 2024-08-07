module mux2to1(D0, D1, S, Y);

input D0, D1, S;
output Y;

assign Y=(~S & D0) | (S &D1);

endmodule