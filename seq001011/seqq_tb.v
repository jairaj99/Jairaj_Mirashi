module seqq_tb;

reg clk,rst;
wire seq;

seqq dut(clk,rst,seq);

parameter t=5;

initial
begin
clk=1'b0;
forever #t clk = ~clk;
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
#100 $finish;
end

endmodule
