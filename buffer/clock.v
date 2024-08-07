module clcokd_buffer( master_clk, buf_clk);

input master_clk;
output  buf_clk;
buf z(buff_clk,master_clk); 
 
endmodule
