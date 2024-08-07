module fifo_tb();

reg clk,rst,we,re;
reg [7:0] data_in;
wire [7:0] data_out;
wire full,empty;
reg [3:0] rd_pt, wr_pt;
reg [7:0] mem[16:0];
integer i,j;
fifo dut (clk,rst,we,re,data_in, data_out,full, empty);

parameter t=10;

initial
begin
clk=1'b0;
forever #(t/2) clk=~clk;
end

task initialize();
begin
we=1'b0; 
re=1'b0;
data_in = 8'b0;
end
endtask

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

task delay;
begin
#10;
end
endtask

task write(input [7:0] j, input [3:0] w, input k);
begin
@(negedge clk)
data_in = j;
wr_pt =w;
we=k;
end
endtask

task read(input [3:0] r);
begin
@(negedge clk)
rd_pt=r;
re = 1'b1;
we=1'b0;
end
endtask

initial
begin
initialize;
reset;
delay;
if(empty==0)
for(wr_pt=0; wr_pt<16; wr_pt=wr_pt+1)
write(wr_pt,wr_pt,1'b1);
reset;
//repeat(18)
//write({$random}%256,{$random}%16,1'b1);
if(full==1)
for(rd_pt=0; rd_pt <16 ; rd_pt=rd_pt+1)
read(rd_pt);
$finish;
end
endmodule

