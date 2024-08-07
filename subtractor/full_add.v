module full_add(input a,b,c, output sum,z, output carry);

wire w1,w2,w3;
assign z= ~sum;
half_sub h1( .a(~a), .b(b), .diff(w1), .borrow(w2));
half_sub h2(.a(~w1), .b(c), .diff(z), .borrow(w3));
or o1(carry,w2,w3);

endmodule