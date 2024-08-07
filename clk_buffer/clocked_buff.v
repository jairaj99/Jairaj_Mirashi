module clocked_buff(master_clk,buff_clk); 
input master_clk; 
output buff_clk; 
 
buf z(buff_clk,master_clk); 
 
endmodule