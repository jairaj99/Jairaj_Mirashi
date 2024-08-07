module dectomux(S0, S1,I0,I1,I2,I3,Y);

input S0, S1, I0,I1,I2,I3;
output Y;
wire w1,w2,w3,w4;

decoder2_4 d1(.S1(S1), .S0(S0), .D1(w1), .D2(w2), .D3(w3), .D4(w4));


bufif1 b1(Y,I0, w1);
bufif1 b2(Y,I1, w2);
bufif1 b3(Y,I2, w3);
bufif1 b4(Y,I3, w4);
endmodule