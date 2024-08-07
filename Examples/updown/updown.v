module updown(clk, rst, load, data_in, control, count);

input clk, control, load, rst;
input [3 : 0] data_in;
output reg [3:0] count;

always@(posedge clk)
if(rst)
count <= 4'b0000;
else if(load)
count <= data_in;

else if(control)
count <= count+1;
else
count <= count-1;
endmodule