module dff_tb;

reg d0,d1,sel,rst,clk;
wire q;

dff dff1(d0,d1,sel,rst,clk,q);

parameter thold=5;
parameter tsetup=5;
parameter cycle=100;
		  
always
begin
#(cycle/2);
clk=1'b0;
#(cycle/2);
clk=1'b1;
end

task sync_reset;
begin
rst=1'b1;
d0=1'b1;
d1=1'b1;
sel=$random;

@(posedge clk)
#(thold);
if(q!==1'b0)
begin
$display("Reset is not working");
$display("Error at time %t", $time);
$stop;
end
$display("Reset is perfect");
{rst,d0,d1,sel}=4'bx;
#(cycle - thold -tsetup);
end
endtask

task load_d0;
input data;
begin
rst=1'b0;
d0=data;
d1=~data;
sel=1'b0;
@(posedge clk);
#(thold);
if(q!==data)
begin
$display("Input D0 is not working");
$display("Error at time %t", $time);
$stop;
end
$display("Input D0 is perfect");
{rst,d0,d1,sel}=4'bx;
#(cycle - thold -tsetup);
end
endtask

task load_d1;
input data;
begin
rst=1'b0;
d0=~data;
d1=data;
sel=1'b1;
@(posedge clk)
#(thold)
if(q!==data)
begin
$display("Input D1 is not working");
$display("Error at time %t", $time);
$stop;
end
$display("Input D1 is perfect");
{rst,d0,d1,sel}=4'bx;
#(cycle - thold -tsetup);
end
endtask

initial
begin
sync_reset;
load_d0(1'b1);
sync_reset;
load_d1(1'b1);
load_d0(1'b0);
load_d1(1'b0);
sync_reset;
#100 $stop;
end
endmodule
