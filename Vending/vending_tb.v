module vending_tb();
reg rst_n,clk;
reg [1:0]coin;
wire i, j;

vending dut(clk,rst_n,coin, i, j);

parameter t=10;

initial
begin
clk=1'b0;
forever #(t/2) clk=~clk;
end

task reset;
begin
@(negedge clk)
rst_n = 1'b0;
@(negedge clk)
rst_n = 1'b1;
end
endtask

task coin_in([1:0]l);
begin
@(negedge clk)
coin=l;
end
endtask

initial 
begin
reset;
#10;
coin_in(2'd1);
coin_in(2'd0);
coin_in(2'd1);
coin_in(2'd1);  
coin_in(2'd1);
coin_in(2'd2);  
coin_in(2'd2);
coin_in(2'd2);   
coin_in(2'd2);
end

initial
$monitor("Input Coin = %d, Output I=%d, J=%d", coin,i,j );
initial
#300 $finish;
endmodule