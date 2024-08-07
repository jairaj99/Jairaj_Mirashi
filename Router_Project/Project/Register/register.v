module register(input clock,resetn,pkt_valid,fifo_full,
				input detect_add,ld_state,lfd_state,laf_state,full_state,rst_int_reg,
				input [7:0]data_in,
				output reg[7:0]dout,
				output reg err,parity_done,low_packet_valid);
  reg [7:0]header_byte,internal_parity,full,pkt_prty;
  reg pr;
 
 always@(posedge clock)
  begin
   if(!resetn)
    begin
     {err,parity_done,low_packet_valid,dout}=0;
	 {header_byte,internal_parity,full,pkt_prty}=0;
	end
   else
	begin
	 if(rst_int_reg==1'b1)//1
	  low_packet_valid=1'b0;
     else if(ld_state==1'b1&&pkt_valid==1'b0)//2
      begin
	   low_packet_valid=1'b1;
	   pkt_prty=data_in;
      end
      if(detect_add==1'b1)//3
       begin
        {parity_done}=1'b0;
	    {internal_parity,full,pkt_prty,err}=0;
	    header_byte=data_in;
	    internal_parity=header_byte;
	   end
	  if(lfd_state==1'b1)//45
        dout=header_byte;
      if(fifo_full==1'b0&&ld_state==1'b1&&pkt_valid==1'b1)//6
		dout=data_in;
	  else if(fifo_full==1'b0&&ld_state==1'b1&&pkt_valid==1'b0)//7
	   begin
		{dout,parity_done}={pkt_prty,1'b1};
		if(pkt_prty!=internal_parity)
		 err=1'b1;
		else
		 err=1'b0;
	   end
	  else if(fifo_full==1'b1&&ld_state==1'b1)//8
	   full=data_in;
	    if(laf_state==1'b1)
		 dout=full;
		if(full_state==1'b0&&ld_state==1&&pkt_valid==1'b1)//9
		 internal_parity={internal_parity^data_in};
		if(laf_state==1'b1&&low_packet_valid==1'b1&&pr==1'b0)//10
		begin
		 {dout,parity_done}={pkt_prty,1'b1};
		 if(pkt_prty!=internal_parity)
		  err=1'b1;
	 	 else
		  err=1'b0;
		end
     pr=parity_done;
	end
  end
endmodule
