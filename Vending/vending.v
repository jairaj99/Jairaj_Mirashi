module vending(
input clk,rst_n,
input [1:0] coin,
output reg i, j);

reg [2:0] state,nx_state;

parameter [2:0] IDLE=3'd0;
parameter [2:0] S1=3'd1;
parameter [2:0] S2=3'd2; 
parameter [2:0] S3=3'd3;
parameter [2:0] S4=3'd4;

always @(posedge clk or negedge rst_n)

if(!rst_n)
state <= IDLE;
else
state <= nx_state;
always @(*) 
begin
nx_state = IDLE;
case(state)
IDLE: if (coin == 2'd1)    
      nx_state = S1;
else if(coin == 2'd2)
     nx_state = S2; 
else nx_state = IDLE;

S1: if(coin == 2'd1)    
      nx_state = S2;
else if(coin == 2'd2)
      nx_state = S3;	  
else  nx_state = S1;

S2: if(coin == 2'd1)    
    nx_state = S3;
else if(coin == 2'd2)
	nx_state = S4; 
else nx_state = S2;

S3: nx_state = IDLE;

S4: nx_state = IDLE;

default:nx_state=IDLE;
endcase
end

always @(posedge clk or negedge rst_n)
if(!rst_n)
{i, j}<='b0;
else
case(nx_state)
S3: {i, j}<=10;
S4: {i, j}<=11;
endcase
endmodule