module fifo_tb();

reg clk,rst,we,re;
reg [7:0] data_in;
wire [7:0] data_out;
wire full,empty;
//reg [3:0] rd_pt, wr_pt;
reg [7:0] mem[15:0];
integer i;
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

task write(input [7:0] j, input k);
begin
@(negedge clk)
data_in = j;
we=k;
end
endtask

task read();
begin
@(negedge clk)
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
for(i=0;i<16;i=i+1)
write(i,1'b1);
if(full==1)
read;
#200 $finish;
end
endmodule

