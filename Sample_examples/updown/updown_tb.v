module updown_tb();

reg clk,rst,load,control;
reg [3:0] data_in;
wire [3 : 0] count;

updown dut (clk, rst, load,control,data_in,count);

parameter T=10;

initial
begin
clk= 1'b0;
forever #(T/2) clk = ~clk;
end

task reset;
begin
@(negedge clk)
rst = 1'b1;
@(negedge clk)
rst =1'b0;
end
endtask

task l_input(input l, input ctrl, input [3 : 0] d );
begin
@(negedge clk)
control=ctrl;
load = l;
data_in = d;
end
endtask

initial
begin
reset;
#10;
l_input(1'b1,1'b0, 4'd5);
//l_input(1'b0, 1'b1,4'd13);
end

initial
$monitor("Input data_in = %b, Load = %b Output count= %b", data_in, load,count);

initial
#300 $stop;

endmodule

