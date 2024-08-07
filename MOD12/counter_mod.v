module counter_mod(input clk,rst,load, input [3:0] data_in, output reg [3 : 0] count);

always@(posedge clk)
begin
if(rst)
count <= 4'b0000;
else if(load)
count <= data_in;
else if(count == 4'd12)
count=0;
else
count <= count + 4'b0001;
end
endmodule