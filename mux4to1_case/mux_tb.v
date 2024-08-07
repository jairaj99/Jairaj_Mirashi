module mux_tb();

reg I0, I1, I2, I3;
reg  s0,s1;
wire Y;
integer i;

m41 DUT( .s0(s0), .s1(s1), .a(I0), .b(I1), .c(I2), .d(I3), .out(Y));

initial
begin
I0=1'b0;
I1=1'b0;
I2=1'b0;
I3=1'b0;
s0=1'b0;
s1=1'b0;
end

initial
begin
for(i=0;i<4;i=i+1)
begin
{s0,s1}=i;
#10;
end
end
always@(a or b or c or d or s0 or s1)
$monitor("input S0=%b, S1=%b", s0,s1);

endmodule