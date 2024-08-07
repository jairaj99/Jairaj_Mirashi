module d_ff_tb();

reg d,rst,clk;
wire q;

d_ff DUT(d,rst,clk,q);

parameter T=20;

initial
begin
clk=1'b0;
forever #(T/2) clk=~clk;
end

task initilize;
begin
d=1'b0;
end
endtask

task delay;
begin
#10;
end
endtask

task d_input(input j);
begin
@(negedge clk)
d=j;
end
endtask

task rst_input;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

initial
begin
initilize;
rst_input;
d_input(1'b1);
d_input(1'b0);
rst_input;
d_input(1'b1);
end


initial
$monitor("Input d_input=%b, Output q=%b",d,q );

initial
#100 $finish;

endmodule