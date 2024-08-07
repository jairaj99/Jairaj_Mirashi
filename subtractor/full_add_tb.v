module full_add_tb();

reg a,b,c;
wire sum,z;
wire carry;
integer i;

full_add dut(a,b,c,sum,z,carry);

initial
begin
for(i=0; i<16;i=i+1)
begin
{a,b,c} = i;
#10;
end
end

initial
$monitor("Input a-%b, b=%b, c=%b outpur sum=%b, carry=%b", a,b,c,z,carry);

initial
#100 $finish;

endmodule