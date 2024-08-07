module seq_tb();

reg clk,rst;
wire [3:0] y;
seq dut (clk,rst,y);

parameter T=20;

initial
begin
clk=1'b0;
forever #(T/2) clk=~clk;
end

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

initial
begin
reset;
end

initial
$monitor("output y=%b",y);

initial 
#200 $stop;

endmodule