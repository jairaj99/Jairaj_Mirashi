module arith_op();

reg [3 : 0] a,b,c;
integer d,e;
reg [3:0]   x,y,z;
integer k,l,m;

initial 
begin

a=4'b0010;
b=4'b0011;
c=4'b101x;
d=3;
e=8;

x= a * b;
y= a + b;
z= b - a;
l= e/d;
m= e % d;
k= c * a;

$display(" X=%b, Y=%b, Z=%b, l=%d, m=%d, k=%d ", x,y,z,l,m,k);

end
endmodule