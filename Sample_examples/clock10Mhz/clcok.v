`timescale 100ns/1ns 
module clockgen(); 
reg clk; 
initial  
begin 
clk =0 ; 
forever #0.5 clk= (~clk); 
end
endmodule
