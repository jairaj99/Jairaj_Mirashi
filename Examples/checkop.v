module chcekop();
reg clk; 
reg [1:0]a,b; 
//Stimulus block 
initial
begin
clk=1'b0;
forever #5 clk = ~clk;
end 
always@(posedge clk)
begin 
#1 a = 2'd3; 
#2 b = 2'd2; 
fork 
#3 b = 2'd1;
#4 b= 2'bx;
join 
#4 a=0;
#5 b=0; 
$finish;
end 
endmodule