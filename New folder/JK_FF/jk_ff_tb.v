module jk_ff_tb();

reg clk,rst,j,k;
wire q;

jk_ff dut(clk,rst, j, k, q);

parameter T=20;

initial
begin
clk=1'b0;
forever #(T/20) clk = ~clk;
end

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

task initilize;
begin
{j, k} = 0;
end
endtask

task jk_input(input l,m);
begin
@(negedge clk)
j=l;
k=m;
end
endtask

initial
begin
reset;
initilize;
jk_input(1'b0, 1'b1);
jk_input(1'b1, 1'b1);
jk_input (1'b1, 1'b0);

end

initial
$monitor("Input J = %b, K = %b, Output Q = %b", j,k,q);
initial
#500 $stop;

endmodule
