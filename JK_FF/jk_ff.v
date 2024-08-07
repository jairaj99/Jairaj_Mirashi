module jk_ff(clk, rst, j,k, q);

input clk,rst,j,k;
output reg q;

parameter HOLD = 0;
parameter RESET = 1;
parameter SET = 2;
parameter TOGGLE = 3;
always@(posedge clk or posedge rst)
begin
if(rst)
q <= 1'b0;
else
begin
case({j,k})
HOLD   : q <= q;
RESET  : q <= 1'b0;
SET    : q <= 1'b1;
TOGGLE : q <= ~q;
endcase
end
end

endmodule
