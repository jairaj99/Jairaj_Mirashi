module t_ff_tb();

reg t,rst,clk;
wire q;
wire qb;

t_ff DUT(t,rst,clk,q, qb);

parameter T=10;

initial
begin
clk=1'b0;
forever #(T/2) clk=~clk;
end

task initialize;
begin
t=1'b0;
end
endtask

task t_input(input j);
begin
@(negedge clk)
t=j;
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

initial
begin
initialize;
reset;
t_input(1'b0);
t_input(1'b1);
t_input(1'b1);
t_input(1'b0);
end

initial
$monitor("Input T=%b, Output Q=%b, Qb= %b",t,q,qb);

initial
#100 $finish;

endmodule





