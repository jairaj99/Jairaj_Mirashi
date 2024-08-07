module mux4to1_tb();

reg [3:0] a;
reg [1:0] sel;
wire out;

integer i;
mux4to1 DUT(.a(a), .sel(sel), .out(out));

initial
begin
sel=2'b00;
a=4'b0000;
end
initial 
begin
for(i=0;i<16;i=i+1)
begin
sel=i;
a=i;
#10;
end
end

initial
$monitor("Inputs Sel=%b, a=%b, Output Out=%b ",sel,a, out);
initial
#100 $finish;

endmodule
