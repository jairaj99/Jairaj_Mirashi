module dualport_ram( clk,rst,write,read, data_in,wr_addr,rd_addr,data_out);

parameter WIDTH=8;
parameter DEPTH=16;
input clk,rst,write,read;
input [WIDTH-1:0] data_in;
input [3 :0] wr_addr;
input [3:0] rd_addr;
output reg [WIDTH-1:0]data_out;
integer i;

reg[WIDTH-1:0]mem[DEPTH-1:0];

always@(posedge clk)
if(rst)
begin
for(i=0; i<DEPTH;i=i+1)
begin
mem[i] <= 0;
data_out <= 0;
end
end
else
begin
if(write)
begin
mem[wr_addr] <= data_in;
end
if(read)
begin
data_out <= mem[rd_addr];
end
end
endmodule
