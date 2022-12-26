module pattern_tb;
wire [7:0] c,a;
reg clk,rst;
pattern dut (clk,rst,c,a);

initial
begin
clk=1'b0;
forever #5 clk = ~clk;
end

initial
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end

initial
$monitor("  %b  ",a);

initial
#500 $stop;

endmodule