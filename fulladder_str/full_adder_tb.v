module full_adder_tb();

reg A,B,C;
wire Sum,Carry;

integer i;

full_adder DUT(A,B,C,Sum,Carry);

initial
begin
A=1'b0;
B=1'b0;
C=1'b0;
end

initial
begin
for(i=0;i<8;i=i+1)
begin
{A,B,C}=i;
#10;
end
end

initial
$monitor("Input A=%b, B=%b, C=%b  Output Sum=%b, Carry=%b", A,B,C,Sum,Carry);

initial
#100 $finish;

endmodule
