module logical_op();

reg [2:0] a,b,c;
reg x,y,z,w,s;

initial 
begin
a=5;
b=3'b111;
c='bx;
x=a || b;
y=a || 0;
z= b && b;
w= b && 1;
s= !a;
$display("X=%b, y=%b, z=%b, w=%b,s=%b", x,y,z,w,s);
end
endmodule