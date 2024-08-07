module router_reg(input clock,resetn,pkt_valid,
				  input [7:0] data_in,
				  input fifo_full,detect_add,ld_state,laf_state,full_state,lfd_state,rst_int_reg,
				  output reg err,parity_done,low_pkt_valid,
				  output reg [7:0] dout);
				  
reg [7:0] hold_header_byte,fifo_full_state_byte,internal_parity,packet_parity_byte;
//--------------------------------------------------------------------------------------------------------------
//parity done
always@(posedge clock)
	begin
		if(!resetn)
			begin
				parity_done<=1'b0;
			end
	
		else 
			begin
				if(ld_state && !fifo_full && !pkt_valid)
						parity_done<=1'b1;
				else if(laf_state && low_pkt_valid && !parity_done)
						parity_done<=1'b1;
				else
					begin
						if(detect_add)
							parity_done<=1'b0;
					end
			end
	end
//--------------------------------------------------------------------------------------------------------------------
//low_packet valid
always@(posedge clock)
	begin
		if(!resetn)
			low_pkt_valid<=1'b0;
		else 
			begin
				if(rst_int_reg)
					low_pkt_valid<=1'b0;
				if(ld_state==1'b1 && pkt_valid==1'b0)
					low_pkt_valid<=1'b1;
			end
	end
//----------------------------------------------------------------------------------------------------------
//dout
always@(posedge clock)

	begin
		if(!resetn)
			dout<=8'b0;
		else
		begin
			if(detect_add && pkt_valid)
				hold_header_byte<=data_in;
			else if(lfd_state)
				dout<=hold_header_byte;
			else if(ld_state && !fifo_full)
				dout<=data_in;
			else if(ld_state && fifo_full)
				fifo_full_state_byte<=data_in;
			else 
				begin
					if(laf_state)
						dout<=fifo_full_state_byte;
				end
		end
	end
//-----------------------------------------------------------------------------------------------------
// internal parity
always@(posedge clock)
	begin
		if(!resetn)
			internal_parity<=8'b0;
		else if(lfd_state)
			internal_parity<=internal_parity ^ hold_header_byte;
		else if(ld_state && pkt_valid && !full_state)
			internal_parity<=internal_parity ^ data_in;
		else 
			begin	
				if (detect_add)
					internal_parity<=8'b0;
			end
	end
//--------------------------------------------------------------------------------------------------------	
//error and packet_
always@(posedge clock)
	begin
		if(!resetn)
			packet_parity_byte<=8'b0;
		else 
			begin
				if(!pkt_valid && ld_state)
					packet_parity_byte<=data_in;
			end
	end
//-------------------------------------------------------------------------------------------------------------------------------------
//error
always@(posedge clock)
	begin
		if(!resetn)
			err<=1'b0;
		else 
			begin
				if(parity_done)
				begin
					if(internal_parity!=packet_parity_byte)
						err<=1'b1;
					else
						err<=1'b0;
				end
			end
	end

endmodule 
