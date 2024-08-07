module shift_op();

reg [3 : 0] a,b;
reg [3:0]   x,y,z,w,s,r;

initial 
begin

a=4'b0110;
b=4'b1100;

x= a<<1;
y= b>>1;
z= a>>3;
w= b<<2;
s= a>>>1;
r= b<<<1;

$display(" X=%b, Y=%b, Z=%b, w=%b, s=%b, r=%b ", x,y,z,w,s,r);

end
endmodule