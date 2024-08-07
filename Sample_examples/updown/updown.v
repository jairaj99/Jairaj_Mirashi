module updown(input clk,rst,load,updown, input [3:0] data_in, output reg [3 : 0] count);

always@(posedge clk)
begin
if(rst)
count <= 4'b0000;
else if(load)
count <= data_in;
else if(updown)
count <= count + 1;
else
count <= count - 1;
end
endmodule
