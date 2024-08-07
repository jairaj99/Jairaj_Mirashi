module seq(clk,rst,y);

input clk,rst;
output [3:0] y;
reg [3:0] temp;

always@(posedge clk)
begin
if(rst)
temp <= 4'b1000;
else
temp <= temp>>1;
end
assign y = temp;

endmodule