module full_adder(input A,B,C, output Sum,Carry);

assign Sum=A^B^C;
assign Carry=(A&B)| (B&C) | (C&A);

endmodule