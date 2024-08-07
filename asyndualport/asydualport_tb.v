module asydualport_tb();
parameter WIDTH=16;
parameter DEPTH=8;

reg wr_clk,rd_clk,clr,write,read;
reg [3:0] wr_addr;
reg [3:0] rd_addr;
reg [WIDTH-1:0] data_in;
wire [WIDTH-1:0]data_out;

asydualport dut(wr_clk,rd_clk,clr,write,read, data_in,wr_addr,rd_addr,data_out);

parameter t=10;

initial
begin
wr_clk=1'b0;
forever #(t/2) wr_clk = ~wr_clk;
end 

initial
begin
rd_clk=1'b0;
forever #(t/4) rd_clk = ~rd_clk;
end

task clear;
begin
clr=1'b1;
#10;
clr=1'b0;
end
endtask

task write_t(input [2:0]i, input [15:0]j,input w, r);
begin
@(negedge wr_clk)
write=w;
read=r;
data_in=j;
wr_addr=i;
end
endtask

task read_t(input [2:0]k, input r, w);
begin
@(negedge rd_clk)
read =r;
write =w;
rd_addr=k;
end
endtask

initial
begin
clear;
repeat(10)
write_t({$random}%256, {$random}%16,1'b1,1'b0);
repeat(10)
read_t({$random}%16,1'b1,1'b0);
#200 $finish;
end

initial
begin
$monitor("Input Write_data=%d, Read_data=%d", data_in, data_out);
end

endmodule





