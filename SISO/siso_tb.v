module siso_tb();

reg clk,rst,si;
wire s0;

siso dut(clk, rst,si, s0);

parameter T=10;

initial 
begin
clk=1'b0;
forever #(T/2) clk = ~clk;
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
si=0;
end
endtask

task si_input( input j);
begin
@(negedge clk) 
si=j;
end
endtask

initial
begin
initilize;
reset;
si_input(1'b0);
si_input(1'b0);
si_input(1'b1);
si_input(1'b1);
si_input(1'b0);
si_input(1'b1);
end

initial
$monitor("Input si=%b, output s0=%b", si, s0);

initial
#200 $stop;

endmodule

