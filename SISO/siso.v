module siso(clk, rst,si, s0);

input clk,rst,si;
output reg s0;
reg [3:0] temp;

always@(posedge clk)
begin
if(rst)
{s0, temp} <= 0;
else

temp[3] <= si;
temp[2] <= temp[3];
temp[1] <= temp[2];
temp[0] <= temp[1];
s0      <= temp[0];
end

endmodule