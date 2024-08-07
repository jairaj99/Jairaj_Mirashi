module router_sync(detect_add, data_in, write_enb_reg,clock,
                   resetn,vld_out_0,vld_out_1,vld_out_2,read_enb_0,
				   read_enb_1,read_enb_2, write_enb,fifo_full,
				   empty_0,empty_1,empty_2, soft_reset_0,soft_reset_1,
				   soft_reset_2,full_0,full_1,full_2);
input detect_add,write_enb_reg,clock,resetn,read_enb_0,read_enb_1,read_enb_2;
input empty_0,empty_1,empty_2,full_0,full_1,full_2;
input [1:0]data_in;
output vld_out_0,vld_out_1,vld_out_2;
output reg soft_reset_0,soft_reset_1,soft_reset_2;
output reg fifo_full;
output [2:0] write_enb;
reg [4:0] count0 ;
reg [4:0] count1 ;
reg [4:0] count2 ;


// data about which fifo to connect 
always @(posedge clock)
 begin 
      if(detect_add)
	            begin 
				case (data_in)
				2'b00 : fifo_full = full_0;
				2'b01 : fifo_full = full_1;
				2'b10 : fifo_full = full_2;
				2'b11 : fifo_full = 0;
				default : fifo_full =0;
				endcase 
				end 
 end 
    
	
// about validity of empty status of fifos
 
assign vld_out_0 =  !empty_0;
assign vld_out_1 =  !empty_1;
assign vld_out_2 =  !empty_2;
 
// count logic for first FIFO
always @(posedge clock)
       begin 
	       if( ! resetn)
		          count0 <= 0;
				          begin 
						     if (vld_out_0)
							      begin 
								       if(! read_enb_0) 
									        begin 
											   if (count0 == 5'b11110)
											      begin 
												     soft_reset_0 <= 1;
													 count0       <= 0;
												  end 
											    else 
												   begin 
												      soft_reset_0<=0 ;
													  count0  <= count0 + 1;
												   end 
											end	
                                 end 
                         end
       end 
//count logic for second  FIFO	   
always @(posedge clock)
       begin 
	       if( ! resetn)
		          count1 <= 0;
				          begin 
						     if (vld_out_1)
							      begin 
								       if(! read_enb_1) 
									        begin 
											   if (count1 == 5'b11110)
											      begin 
												     soft_reset_1 <= 1;
													 count1 <= 0;
												  end 
											    else 
												   begin 
												      soft_reset_1<=0 ;
													  count1  <= count1 + 1;
												   end 
											end	
                                 end 
                         end
       end 
// Count logic for third FIFO	   
always @(posedge clock)
       begin 
	       if( ! resetn)
		          count2 <= 0;
				          begin 
						     if (vld_out_2)
							      begin 
								       if(! read_enb_2) 
									        begin 
											   if (count2 == 5'b11110)
											      begin 
												     soft_reset_2 <= 1;
													 count2       <= 0;
												  end 
											    else 
												   begin 
												      soft_reset_2<=0 ;
													  count2  <= count2 + 1;
												   end 
											end	
                                 end 
                         end
       end 
	   endmodule 