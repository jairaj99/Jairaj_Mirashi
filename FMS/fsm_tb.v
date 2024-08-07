module fsm_tb();

reg clk,rst;
reg go;
wire ds,rd;

fsm dut (ds,rd, go,clk,rst);

parameter t=10;

initial
begin
clk=1'b0;
forever #(t/2) clk=~clk;
end

task reset;
begin
@(negedge clk)
rst=1'b1;
@(negedge clk)
rst=1'b0;
end
endtask

task data_in(input i);
begin
@(negedge clk)
go=i;
end
endtask

initial
begin
reset;
#10;
data_in(1);
data_in(1);
data_in(0);
data_in(1);
data_in(1);
data_in(0);
data_in(1);
data_in(0);
data_in(1);
data_in(1);
end

initial
$monitor("Input Data=%b, Output SEQ=%b", go,ds);

initial
#200 $finish;

endmodule