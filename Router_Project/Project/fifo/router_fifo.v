module router_fifo(input clock,resetn,soft_reset,write_enb,read_enb,lfd_state, input[7:0] data_in, output full,empty, output reg[7:0] data_out);

 reg[8:0]fifo[15:0];
 reg[3:0] wa,ra,count;
 reg[5:0] counter;
reg lfd;
 integer i;
always@(posedge clock)
 begin
if(resetn == 0)
lfd=0;
else
lfd=lfd_state;
end
 
 always@(posedge clock)
  begin
  if(resetn == 0)
   begin
    for(i=0;i<16;i=i+1)
     fifo[i]=0;
     {wa,ra,count,counter,data_out} =0;
   end
 
  else if(soft_reset == 1)
   begin
    for(i=0;i<16;i=i+1)
     fifo[i]=0;
    {wa,ra,counter,count,data_out} = {18'b0,8'hzz};
   end
  
   else
    begin
    if(write_enb && !full)
    begin
     fifo[wa] = {lfd,data_in};
     wa = wa+1;
	 count=count+1;
    end
     if (counter ==0&&~write_enb&&~read_enb) 
	   begin
        data_out=8'hzz;
        {wa,ra}=0;
       end
    if (read_enb && !empty)
    begin
	  if (counter==0)
	  begin
       data_out=fifo[ra];
	   counter =data_out[7:2]+1;
	   ra=ra+1;
	   count=count-1;
	   end
	   else
	   begin
     data_out = fifo[ra];
     ra = ra+1;
	 count=count-1;
	 counter = counter-1;
	 end
    end
  end

 end    
assign full = (count==15)?1'b1:1'b0;
assign empty = (count==0)?1'b1:1'b0;
   
endmodule