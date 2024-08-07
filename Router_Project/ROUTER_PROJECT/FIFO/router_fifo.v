module router_fifo (clock, resetn, write_enb, soft_reset, read_enb, data_in, lfd_state, empty, data_out, full);
input clock, resetn, write_enb, read_enb, soft_reset, lfd_state;
output reg [7:0] data_out;
input  [7:0] data_in;
output full , empty ; 
reg [3:0] wr_ptr, rd_ptr;
reg [7:0] mem [15:0];
reg [4:0] count ;
reg [5:0] bitcounter ;
reg templfd;
//full flag and empty flag 
assign full = (count == 16) ? 1'b1 :1'b0;
assign empty= (count == 0)  ? 1'b1 :1'b0;


//lfd_state
always@(posedge clock)
	begin
		if(!resetn)
			templfd<=1'b0;
		else 
			templfd<=lfd_state;
	end 



// write operation 
integer i =0 ; // mock reg to run in memory 
always @(posedge clock)
       begin 
	      
		           begin 
				          if(!resetn)                      // active low reset 
						       begin 

									wr_ptr   <= 4'b0000;
								end 
						  else if (soft_reset)             // Internal active high reset 
						        begin
							         wr_ptr   <= 4'b0000;       // Resets write pointer and removes all data from the memory 
									 for (i=0;i<16;i=i+1)
					                       begin
						                    mem[i] <=0;
						                   end
								end 
						  else 
						        if(write_enb && ! full)
						              begin 
						                   mem[wr_ptr]   <= {templfd,data_in};
								           wr_ptr        <= wr_ptr + 1'b1;
							          end
					end 
		end 
// Read operation		
always @(posedge clock)
       begin 
	       if(!resetn)
		          begin 
				       data_out <= 0;
					   rd_ptr   <= 0;
				  end 
		   else if (soft_reset)
		                   begin 
						         rd_ptr <=0;
								 data_out<=8'bz;
						   end 
			else 
			    if (read_enb && !empty)
			                     begin 
				                     data_out <= mem[rd_ptr];
					                 rd_ptr   <= rd_ptr + 1 ;
					   
				                  end  
				if(bitcounter == 0)                      // This is to represent that all the possible bit has been read 
				            begin 
							       data_out <= 8'bzzzzzzzz ;
							   end 
							
	  end 
	  
// Internal one word to another word count 
always @(posedge clock)
 begin
       if (!resetn)
	    begin 
		    count <=0;
        end 
       else  begin 
	             case ({write_enb,read_enb})
		 
					2'b00 : count <= count    ;
					2'b01 : count <= count - 1;
					2'b10 : count <= count + 1;
					2'b11 : count <= count    ;
					default : count <= count  ; 
				 endcase 
              end 
end 

// Internal counter for total possible combination of inputs 
always @(posedge clock)
         begin 
		       if (read_enb && !empty)
			          begin 
					       bitcounter <= mem [rd_ptr[3:0]][7:2]  +1'b1;
					  end  
               if(bitcounter != 6'b000000)
                        begin 
                           bitcounter <= bitcounter - 1'b1;
                        end  
          end 
endmodule 		  
	 
