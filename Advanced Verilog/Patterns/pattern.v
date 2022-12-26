module pattern(clk,rst,c,a);
input clk,rst;
output reg [7:0] c,a;

always@(posedge clk)
begin
if(rst)
c <= 8'b1;
else if(a[0]==1)
c <= c;
else if(c[7]==1)
c <= 8'd2;
else
c <= c << 1'b1;
end
always@(posedge clk)
begin
if(rst)
a <= 8'd0;
else if(a[0] == 1)
a <= c;
else
a <= 8'b1;
end

endmodule