module dualport_ram_tb();
parameter WIDTH=8;
parameter DEPTH=16;

reg clk,rst,write,read;
reg [3:0] wr_addr;
reg [3:0] rd_addr;
reg [WIDTH-1:0] data_in;
wire [WIDTH-1:0]data_out;

dualport_ram dut(clk,rst,write,read, data_in,wr_addr,rd_addr,data_out);

parameter t=10;

initial
begin
clk=1'b0;
forever #(t/2) clk = ~clk;
end 

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

task write_t(input [7:0]i, input [3:0]j,input w, r);
begin
@(negedge clk)
write=w;
read=r;
data_in=i;
wr_addr=j;
end
endtask

task read_t(input [3:0]k, input r, w);
begin
@(negedge clk)
read =r;
write =w;
rd_addr=k;
end
endtask

initial
begin
reset;
repeat(10)
write_t({$random}%256, {$random}%16,1'b1,1'b0);

repeat(10)
read_t({$random}%16,1'b1,1'b0);
#100 $finish;
end

initial
begin
$monitor("Input Write_data=%d, Read_data=%d", data_in, data_out);
end

endmodule





