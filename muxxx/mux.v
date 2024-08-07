module mux(input [1:0]sel,input a,b,c,d, output reg y);

always@(sel)
begin
if(sel==00)
y=a;
else if(sel==01)
y=b;
else if(sel==10)
y=c;
else
y=d;
end
endmodule