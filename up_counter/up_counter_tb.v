module up_counter_tb();

reg [3:0] t;
reg rst,clk;
wire [3:0] q;
wire [3:0] qb;

up_counter(t,rst,clk,q,qb);

parameter T=20;

initial
begin
clk=1'b0;
forever #(T/2) clk=~clk;
end

task initilize;
begin
t=4'b0000;
end
endtask

task t_input(input [3:0] j)
begin
@(negedge clk)
t=j;
end
endtask

task reset;
begin
@(negedge clk)
clk=1'b1;
@(negedge clk)
clk=1'b0;
end
endtask

initial
begin
initilize;
reset;
t_input(4)










