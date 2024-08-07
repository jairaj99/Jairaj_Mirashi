module synchronizer(input clock,resetn,detect_add,write_enb_reg,

input [2:0]full,empty,read_enb,
input [1:0]data_in,
output reg [2:0]soft_reset,write_enb,
output [2:0]vld_out,
output reg fifo_full);
reg [4:0]count1,count2,count3;
reg [1:0]temp;

always@(posedge clock)
begin
if(!resetn)
{soft_reset, count1,count2,count3,temp }<=0;
else
begin
if(detect_add==1)
temp <= data_in;
if(vld_out[2]==1'b1)
begin
if(read_enb[2]!=1) 
count3=count3+1'b1;
else 
count3=1'b0;
if(count3==30) 
begin
count3=5'b0;
soft_reset[2]=1'b1;
end
else 
soft_reset[2]=0;
end

if(vld_out[1]==1'b1)
begin
if(read_enb[1]!=1'b1) 
count2=count2+1'b1;
else 
count2=1'b0;
if(count2==30) 
begin
count2=5'b0;
soft_reset[1]=1'b1;
end
else 
soft_reset[1]=0;
end

if(vld_out[0]==1'b1)
begin
if(read_enb[0]!=1'b1) 
count1=count1+1'b1;
else 
count1=5'b0;
if(count1==30) 
begin
count1=5'b0;
soft_reset[0]=1'b1;
end
else 
soft_reset[0]=0;
end
end
end

always@(*)
begin
if(!resetn) 
{fifo_full,write_enb}=0;
else
begin
case(temp)
2'b00:fifo_full=full[0];
2'b01:fifo_full=full[1];
2'b10:fifo_full=full[2];
default :fifo_full=full[0];
endcase

if(write_enb_reg==1)
begin
case(temp)
2'b00:write_enb=3'b001;
2'b01:write_enb=3'b010;
2'b10:write_enb=3'b100;
default :write_enb=3'b001;
endcase
end
else 
write_enb=3'b000;
end
end
assign vld_out[0]=~empty[0];
assign vld_out[1]=~empty[1];
assign vld_out[2]=~empty[2];
endmodule