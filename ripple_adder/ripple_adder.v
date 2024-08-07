module ripple_adder(x,y,Cin,S,C);

input[3:0] x,y;
output [3:0] S;
input Cin;
output C;
wire w1,w2,w3;

full_adder FA1(.A(x[0]),.B(y[0]), .C(Cin), .Sum(S[0]), .Carry(w1));
full_adder FA2(.A(x[1]),.B(y[1]), .C(w1), .Sum(S[1]), .Carry(w2));
full_adder FA3(.A(x[2]),.B(y[2]), .C(w2), .Sum(S[2]), .Carry(w3));
full_adder FA4(.A(x[3]),.B(y[3]), .C(w3), .Sum(S[3]), .Carry(C));

endmodule 