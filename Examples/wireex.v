module wireex();
wire a,b,c;
reg x, y;

always@(*)
begin
y=  x | c;
x= a & b;
 end
endmodule