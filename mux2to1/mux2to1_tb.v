module mux2to1_tb();

reg i0,i1,sel;
wire y;

integer i;

mux2to1 DUT (i0,i1,sel,y);

initial
begin
sel=1'b0;
i1=1'b0;
i0=1'b0;
end

initial 
begin
for(i=0;i<8;i=i+1)
begin
{sel,i1, i0}=i;
#10;
end
end

initial
$monitor("Inputs I0=%b, I1=%b, Sel=%b, Output y=%b", i0,i1,sel,y);
initial
#100 $finish;

endmodule

