module decoder2to4(S, Y);

input [1:0] S;
output [3:0] Y;

assign Y[3]= (~S[1] & ~S[0] );
assign Y[2]= (~S[1] & S[0] );
assign Y[1]= (S[1] & ~S[0] );
assign Y[0]= (S[1] & S[0] );

endmodule