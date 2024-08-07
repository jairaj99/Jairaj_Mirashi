module clocked_buff_tb(); 
 
reg master_clk; 
wire buff_clk; 
//real frequency,phase; 
parameter T=10; 
 
clocked_buff dut(master_clk,buff_clk); 
 
 
initial 
begin 
master_clk=1'b0; 
forever #(T) master_clk=~master_clk; 
end 

endmodule