module bencoder(input I0,I1,I2,I3,I4,I5,I6,I7 , output Y0,Y1,Y2);

assign Y0= I1 | I3 | I5 | I7;
assign Y1= I2 | I3 | I6 | I7;
assign Y2= I4 | I5 | I6 | I7;

endmodule