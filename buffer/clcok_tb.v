module clockd_buffer_tb();

time t1,t2,t3,t4,tper1,tper2; 
reg master_clk; 
wire buff_clk; 
//real frequency,phase; 
parameter T=10; 
 
clcokd_buffer dut( master_clk, buf_clk); 
 
 
initial 
begin 
master_clk=1'b0; 
forever #(T) master_clk=~master_clk; 
end 
 
task tca1; 
begin 
@(posedge master_clk); 
t1=$time; 
@(posedge master_clk) 
t2=$time; 
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
$display("Same frequency"); 
else 
$display("frequency different"); 
end 
 
begin 
if(t1==t3) 
$display("Same phase"); 
else 
$display("phase different"); 
end

initial
#120 $finish; 
end 
endmodule