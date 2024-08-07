module dectomux_tb();

reg S0,S1,I0,I1,I2,I3;
wire w1,w2, w3, w4, Y;
integer i;

dectomux DUT(S0, S1,I0,I1,I2,I3,Y);

initial 
begin 
S1=1'b0;
S0=1'b0;
I0=1'b0;
I1=1'b0;
I2=1'b0;
I3=1'b0;
end

initial
begin
for(i=0;i<64;i=i+1)
begin
{S0,S1,I0,I1,I2,I3}=i;
#10;
end
end

initial
$monitor("Inputs S0=%b, S1=%b, Output I0=%b, I1=%b, I2=%b, I3=%b, Y=%b",S0, S1, I0, I1, I2, I3, Y);
initial
#100 $finish;

endmodule