module asydualport( wr_clk,rd_clk,clr,write,read, data_in,wr_addr,rd_addr,data_out);

parameter WIDTH=16;
parameter DEPTH=8;
input wr_clk,rd_clk,clr,write,read;
input [WIDTH-1:0] data_in;
input [3 :0] wr_addr;
input [3:0] rd_addr;
output reg [WIDTH-1:0]data_out;
integer i;

reg[WIDTH-1:0]mem[DEPTH-1:0];

always@(posedge wr_clk or posedge clr)
begin
if(clr)
begin
for(i=0; i<DEPTH;i=i+1)
mem[i] <= 0;
end
else if(write)
begin
mem[wr_addr] <= data_in;
end
end
always@(posedge wr_clk or posedge clr)
if(clr)
begin
data_out <= 0;
end
else if(read)
begin
data_out <= mem[rd_addr];
end
endmodule
