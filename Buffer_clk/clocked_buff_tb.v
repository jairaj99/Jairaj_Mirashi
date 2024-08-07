module clocked_buff_tb(); 
 
time t1,t2,t3,t4,tper1,tper2; 
reg master_clk; 
wire buff_clk;

parameter T=10; 
 
clocked_buff dut(master_clk,buff_clk); 
 
 
initial 
begin 
master_clk=1'b0; 
forever #(T) master_clk=~master_clk; 
end 
 
task tca1; 
begin 
@(posedge master_clk); 
t1= $realtime; 
@(posedge master_clk) 
t2= $realtime; 
end 
endtask 
 
task tca2; 
begin 
@(posedge buff_clk); 
t3=$time; 
@(posedge buff_clk) 
t4=$time; 
end 
endtask 
 
initial 
begin 
fork 
tca1; 
tca2; 
join 
 
tper1=t2-t1; 
 
tper2=t4-t3; 
 
begin 
if(tper1==tper2) 
$display("SAME FREQUENCY"); 
else 
$display("DIFFERENT FREQUENCY"); 
end 
 
begin 
if(t1==t3) 
$display("SAME PHASE"); 
else 
$display("DIFFERENT PHASE"); 
end 

#100 $finish; 
 
end 
endmodule