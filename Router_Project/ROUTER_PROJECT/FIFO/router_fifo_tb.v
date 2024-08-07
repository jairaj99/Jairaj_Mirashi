module router_fifo_tb();

reg clock, resetn, write_enb, read_enb, lfd_state, soft_reset;
reg [7:0]data_in;
wire full, empty;	
wire [7:0]data_out;


router_fifo DUT    (clock, resetn, write_enb, soft_reset, read_enb, data_in, lfd_state, empty, data_out, full);

	//clock generation
	initial begin
	clock = 1;
	forever 
	#5 clock=~clock;
	end
	


initial 
	begin
	resetn=1'b0;
	#10;
	resetn=1'b1;
	soft_reset=1'b0;
	lfd_state=1'b1;
	write_enb=1'b1;
	#10;
	repeat(17)
		begin
			data_in=$random;
			#10;
		end
	write_enb=1'b0;
	#5;
	
	read_enb=1'b1;
	#100;
	
 
	$finish; 
	end 
endmodule

