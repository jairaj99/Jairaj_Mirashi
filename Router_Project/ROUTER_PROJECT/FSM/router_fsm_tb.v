module router_fsm_tb();

reg clock,resetn, pkt_valid;
reg [1:0]data_in;
reg fifo_full, fifo_empty_0, fifo_empty_1, fifo_empty_2, soft_reset_0, soft_reset_1, soft_reset_2, parity_done, low_pkt_valid;
wire write_enb_reg, detect_add, ld_state, laf_state, lfd_state, full_state, rst_int_reg, busy;

router_fsm DUT  ( clock,resetn,pkt_valid,busy,parity_done,data_in,
                  soft_reset_0,soft_reset_1,soft_reset_2,fifo_full,
				  low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2,
				  detect_add,ld_state,laf_state,full_state,write_enb_reg,
				  rst_int_reg,lfd_state  );
				  
				  
	//clock generation
	initial 
	begin
	clock = 1;
	forever 
	#5 clock=~clock;
	end
	
	
	task reset;
		begin
			resetn=1'b0;
			#10;
			resetn=1'b1;
		end
	endtask
	
	
	task task1();
	            begin 
				  pkt_valid    = 1'b1;
				  data_in      = 2'b01;
				  fifo_empty_1 = 1'b1;
				  @(negedge clock)
				  @(negedge clock)
				  fifo_full    = 1'b0;
				  pkt_valid    = 1'b0;
				  @(negedge clock)
				  @ (negedge clock)
				  fifo_full   = 1'b0;
			    end
	endtask 
	
	task task2();
	            begin 
				    pkt_valid    = 1'b1;
				    data_in      = 2'b10;
				    fifo_empty_2 = 1'b1;
	                @(negedge clock)
					@(negedge clock)
					fifo_full    = 1'b1;
					@(negedge clock)
					fifo_full    = 1'b0;
					@(negedge clock)
					parity_done  = 1'b0;
					low_pkt_valid= 1'b1;
					@(negedge clock)
					@ (negedge clock)
					fifo_full    =1'b0;
				end
	endtask	
	
	
	task task3();
	            begin 
				pkt_valid    = 1'b1;
				    data_in      = 2'b10;
				    fifo_empty_2 = 1'b1;
	                @(negedge clock)
					@(negedge clock)
					fifo_full    = 1'b1;
					@(negedge clock)
					fifo_full    = 1'b0;
					@(negedge clock)
					parity_done  = 1'b0;
					low_pkt_valid= 1'b0;
					@(negedge clock ) 
					fifo_full    = 1'b0;
					pkt_valid    = 1'b0;
					@(negedge clock)
					@(negedge clock)
					fifo_full    = 1'b0;
				end
	endtask
	task task4();
	             begin 
				  
				  pkt_valid    = 1'b1;
				  data_in      = 2'b01;
				  fifo_empty_1 = 1'b1;
				  @(negedge clock)
				  @(negedge clock)
				  fifo_full    = 1'b0;
				  pkt_valid    = 1'b0;
                    @(negedge clock)  // here we are at check parity error 
                   @(negedge clock)   // For Fifo full state 
				   fifo_full = 1'b1;
				   @(negedge clock)   //for load after full state
				   fifo_full = 1'b0;  
				   @(negedge clock) // for decoder address
				   parity_done =1'b1;
                 end
     endtask
	 
	
	
	initial 
		begin
			reset;
			#20;
			task1;
			#40;
			task2;
			#40;
			task3;
			#40;
			task4;
			#40;
			reset;
			#100;
			$finish;
		end
		
		endmodule 	
			
	
	
	
