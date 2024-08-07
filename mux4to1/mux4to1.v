module mux4to1(input i0, i1, i2, i3, S1, S2, output Y);


assign Y= (~S1 & ~S2 & i0) |(~S1 & S2 & i1) |(S1 & ~S2 & i2) |(S1 & S2 & i3);

endmodule