module router_fsm(clock,resetn,pkt_valid,busy,parity_done,data_in,
                  soft_reset_0,soft_reset_1,soft_reset_2,fifo_full,
				  low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2,
				  detect_add,ld_state,laf_state,full_state,write_enb_reg,
				  rst_int_reg,lfd_state);

input clock, resetn, low_pkt_valid,pkt_valid,parity_done;
input [1:0] data_in;
input soft_reset_0,soft_reset_1,soft_reset_2;
input fifo_full;
input fifo_empty_0,fifo_empty_1,fifo_empty_2;

output busy;
output detect_add, ld_state, laf_state, full_state, rst_int_reg, write_enb_reg, lfd_state;


reg [2:0] present_state, next_state;

reg [1:0] tempreg;

parameter DECODE_ADDRESS    = 3'b000,
          LOAD_FIRST_DATA   = 3'b001,
		  LOAD_DATA         = 3'b010,
		  FIFO_FULL_STATE   = 3'b011,
		  LOAD_AFTER_FULL   = 3'b100,
		  LOAD_PARITY       = 3'b101,
		  CHECK_PARITY_ERROR= 3'b110,
		  WAIT_TILL_EMPTY   = 3'b111;
always @(posedge clock)
             begin 
			        if(!resetn)
					 tempreg <= 2'b00;
					else 
					  tempreg <= data_in;
			 end 
			 
always @(posedge clock)
begin 
        if(!resetn)
		  begin 
		       present_state <= DECODE_ADDRESS;
		  end
		else if (((soft_reset_0) && (tempreg==2'b00)) || ((soft_reset_1) && (tempreg==2'b01)) || ((soft_reset_2) && (tempreg==2'b10 )))
                             begin 
							   present_state <= DECODE_ADDRESS;
							 end 
		else 
		      begin 
			         present_state <= next_state;
			  end 
end 


always @(*)
           begin 
		       case(present_state)
			   
			   DECODE_ADDRESS : begin 
			                         
			                         if((pkt_valid && (data_in==2'b00) && fifo_empty_0)|| (pkt_valid && (data_in==2'b01) && fifo_empty_1)|| (pkt_valid && (data_in==2'b10) && fifo_empty_2))
					                             begin 
												  next_state = LOAD_FIRST_DATA;
												  
												  end
									   else if((pkt_valid && (data_in==2'b00) && !fifo_empty_0)||
									   (pkt_valid && (data_in==2'b01) && !fifo_empty_1)|| 
									   (pkt_valid && (data_in==2'b10) && !fifo_empty_2))
					                             begin 
												 next_state = WAIT_TILL_EMPTY;
												 end
										else 
										   begin 
										        next_state = DECODE_ADDRESS;
										   end 
								end 
			   LOAD_FIRST_DATA : begin 
			                          next_state = LOAD_DATA;
								 end 
				
			   LOAD_DATA       : begin 
			                             if (fifo_full)
										 next_state = FIFO_FULL_STATE;
										 else if (!fifo_full && !pkt_valid)
										 next_state = LOAD_PARITY;
										 else 
										 next_state = LOAD_DATA;
								 end 
			  
			  FIFO_FULL_STATE  : begin
			                             if(!fifo_full)
										 next_state = LOAD_AFTER_FULL;
										 else
										 next_state = FIFO_FULL_STATE;
								end 
			  LOAD_AFTER_FULL  : begin 
			                             if ((!parity_done) && (!low_pkt_valid))
										     next_state = LOAD_DATA;
										 else if ((!parity_done) && (low_pkt_valid))
										      next_state = LOAD_PARITY;
										  else if (parity_done)
										       next_state=DECODE_ADDRESS;
								 end 
			  LOAD_PARITY     :   next_state = CHECK_PARITY_ERROR;
			  
			CHECK_PARITY_ERROR: begin 
			                          if (!fifo_full)
									    next_state = DECODE_ADDRESS;
								end
			  WAIT_TILL_EMPTY :  begin 
			                        next_state = WAIT_TILL_EMPTY;
                                 end
			                           
		    default : next_state = DECODE_ADDRESS;
			endcase 
          end 
		  
// assign all the flags 
assign busy          = ((present_state == LOAD_FIRST_DATA) || (present_state== LOAD_PARITY) ||(present_state == LOAD_AFTER_FULL) || (present_state== CHECK_PARITY_ERROR))?1'b1:1'b0;
assign lfd_state     = (present_state == LOAD_FIRST_DATA)?1'b1:1'b0;
assign ld_state      = (present_state == LOAD_DATA)?1'b1:1'b0;
assign write_enb_reg = ((present_state == LOAD_DATA)|| (present_state == LOAD_PARITY) ||(present_state == LOAD_AFTER_FULL))?1'b1:1'b0;
                       
assign rst_int_reg   = (present_state == CHECK_PARITY_ERROR)?1'b1:1'b0;
assign full_state    = (present_state == FIFO_FULL_STATE)?1'b1:1'b0;
assign laf_state     = (present_state == LOAD_AFTER_FULL)?1'b1:1'b0;
assign detect_add    = (present_state == DECODE_ADDRESS)?1'b1 : 1'b0;

endmodule 
