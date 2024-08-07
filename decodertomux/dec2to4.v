module decoder2_4(input S0,S1, output D1,D2,D3,D4);

assign D1= ~S0 & ~S1;
assign D2= ~S0 & S1;
assign D3= S0 & ~S1;
assign D4= S0 & S1;

endmodule