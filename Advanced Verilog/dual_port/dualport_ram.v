module dual_port_ram( clock,resetn,wr_enb,re_enb, data_in,wr_addr,rd_addr,data_out);

parameter WIDTH=8;
parameter DEPTH=16;
input clock,resetn,wr_enb,re_enb;
input [WIDTH-1:0] data_in;
input [3 :0] wr_addr;
input [3:0] rd_addr;
output reg [WIDTH-1:0]data_out;
integer i;

reg[WIDTH-1:0]mem[DEPTH-1:0];

always@(posedge clock)
if(resetn)
begin
for(i=0; i<DEPTH;i=i+1)
begin
mem[i] <= 0;
data_out <= 0;
end
end
else
begin
if(wr_enb)
begin
mem[wr_addr] <= data_in;
end
if(re_enb)
begin
data_out <= mem[rd_addr];
end
end
endmodule
