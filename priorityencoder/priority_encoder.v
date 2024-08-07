module priority_encoder(input I0,I1,I2,I3,I4,I5,I6,I7, output Y0,Y1,Y2 );

wire w0,w1,w2,w3,w4,w5,w6,w7;

prencoder p1(.I0(I0),.I1(I1),.I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .H0(w0) , .H1(w1), .H2(w2), .H3(w3), .H4(w4), .H5(w5), .H6(w6), .H7(w7));
bencoder b1(.I0(w0), .I1(w1), .I2(w2), .I3(w3), .I4(w4), .I5(w5), .I6(w6), .I7(w7), .Y0(Y0), .Y1(Y1), .Y2(Y2));

endmodule