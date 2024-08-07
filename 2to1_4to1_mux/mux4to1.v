module mux4to1(a,sel,out);
	input [3:0] a;
	input [1:0] sel;
	output out;

	wire mux[2:0];

	mux2to1 m1 (a[3],a[2],sel[0],mux_1),
	        m2 (a[1],a[0],sel[0],mux_2),
	        m3 (mux_1,mux_2,sel[1],out);
endmodule