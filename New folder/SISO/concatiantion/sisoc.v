module sisoc(clk, rst,si, s0);

input clk,rst,si;
output reg s0;
reg [3:0] temp;

always@(posedge clk)
begin
if(rst)
{temp,s0} <= 0;

else

temp<= ({si, temp[3:1]});

end 

endmodule