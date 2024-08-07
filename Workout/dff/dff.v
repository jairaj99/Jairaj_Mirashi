module dff(d,load,rst,q,clk);              
input load,rst,clk ;                                   
output reg [3:0] q;                                          
 input [3:0] d;                                                
              
always@(posedge clk)                                   
begin  
if (rst)                                     
q <= 0;                                             
else  
if (load)                                             
q<=d; 
else 
begin  
q <= q +1 ;                                              
end 
end 
endmodule        