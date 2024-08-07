
module prencoder(input I0,I1,I2,I3,I4,I5,I6,I7, output H0,H1,H2,H3,H4,H5,H6,H7);

assign H7= I7;
assign H6= I6 & ~I7;
assign H5= I5 & ~I6 & ~I7;
assign H4=I4 & ~ I5 & ~I6 & ~I7;
assign H3=I3& ~I4 & ~ I5 & ~I6 & ~I7;
assign H2=I2 & ~I3& ~I4 & ~ I5 & ~I6 & ~I7;
assign H1=I1 & ~ I2 & ~I3& ~I4 & ~ I5 & ~I6 & ~I7;
assign H0=I0 & ~I1 & ~ I2 & ~I3 & ~I4 & ~ I5 & ~I6 & ~I7;
assign IDLE =~I0 & ~I1 & ~ I2 & ~I3 & ~I4 & ~ I5 & ~I6 & ~I7;

endmodule