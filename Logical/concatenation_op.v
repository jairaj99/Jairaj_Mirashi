module con_op();
reg a;
reg [2 : 0] b,c;
reg [7:0]   x,y,z;
reg [10:0] w;

initial 
begin

a=1'b1;
b=3'b100;
c=3'b110;

x= {a,b,c};
y= {b, 2'b01, a};
z= {x[1:0], b[2:0],c};

w= {{2{a}}, b, {2{c}}} ;     //relication

$display(" X=%b, Y=%b, Z=%b, w=%b ", x,y,z,w);

end
endmodule