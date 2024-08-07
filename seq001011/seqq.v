//001011
module seqq(input clk,rst,output seq);

reg [5:0] q;

always @ (posedge clk)
begin
if(rst)
q <= 6'b110100;
else
q <= {q[0], q[5:1]};
end
assign seq =q[0];
endmodule