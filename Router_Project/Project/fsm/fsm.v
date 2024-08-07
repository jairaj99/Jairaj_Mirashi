
module fsm(input clock,resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,
		   input [2:0]fifo_empty,soft_reset,
		   input [1:0]data_in, 
		   output reg  write_enb_reg,detect_add,ld_state,lfd_state,laf_state,full_state,
		   output reg reset_int_reg,busy);
  parameter decode_address=3'b000,
			load_first_data=3'b001,
			wait_till_empty=3'b010,
			load_data=3'b011,
			fifo_full_state=3'b100,
			load_parity=3'b101,
			load_after_full=3'b110,
			check_parity_error=3'b111;
  reg [2:0]state,n_state;
  integer t;
  reg temp,full;

 initial
  {temp}=0;

 always@(negedge clock)
  full=fifo_full;
 
 always@(posedge clock)
  begin
   temp<=pkt_valid;
    if(!resetn)
	 state=decode_address;
	else
	 state=n_state;
  end
  
 always@(*)//resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,fifo_empty,soft_reset,data_in,state,temp)
  begin
   n_state=decode_address;
  case(state)
   decode_address :begin
   {full_state,detect_add,ld_state,lfd_state,laf_state,write_enb_reg,busy,reset_int_reg}=0;
   detect_add=1'b1;
   if(pkt_valid==1&&temp==0) 
    begin
     t=data_in;
     if((pkt_valid&(data_in==0)&(~fifo_empty[0]))||(pkt_valid&(data_in==1)&(~fifo_empty[1]))||(pkt_valid&(data_in==2)&(~fifo_empty[2])))
      n_state=wait_till_empty;
     else if((pkt_valid&(data_in==0)&fifo_empty[0])||(pkt_valid&(data_in==1)&fifo_empty[1])||(pkt_valid&(data_in==2)&fifo_empty[2]))
      n_state=load_first_data ;
    end
  end
wait_till_empty:begin
     busy=1'b1;
    if(~(fifo_empty[t]))//data_in=00,fifo_empty[0],data_in=01,fifo_empty[1]
     n_state=wait_till_empty;
    else if(fifo_empty[t])
    n_state=load_first_data;
    end
load_first_data:{write_enb_reg,detect_add,lfd_state,busy,n_state}={4'b0011,load_data};
load_data:begin
    {busy,laf_state,lfd_state,ld_state}=4'b0001;
    write_enb_reg=1'b1;
    if(fifo_full==1'b1) n_state=fifo_full_state;
    else if(fifo_full==1'b0&&pkt_valid==1'b0) n_state=load_parity;
    else n_state=load_data;
    end
load_parity:{laf_state,ld_state,busy,write_enb_reg,n_state}={4'b0111,check_parity_error}; //ld_state =0
fifo_full_state:begin
    {full_state,busy,write_enb_reg,ld_state}={4'b1100};
    if(fifo_full==1'b0) {write_enb_reg,n_state}={1'b0,load_after_full}; //why write_enb_reg is 0 ,it's already defined in above line
    else n_state=fifo_full_state;
    end
load_after_full:begin
    {full_state,ld_state,laf_state,busy,write_enb_reg}=5'b00111;
    if(parity_done==1'b1) n_state=decode_address;
    else if(parity_done==1'b0&&low_packet_valid==1'b0) n_state=load_data;
    else if(parity_done==1'b0&&low_packet_valid==1'b1) n_state=load_parity;
    end
check_parity_error:begin
    {reset_int_reg,busy,ld_state,write_enb_reg}=4'b1100;
    if(full==1'b1) n_state=fifo_full_state;
    else if(full==1'b0) n_state=decode_address;
        end
endcase
if(soft_reset)begin
 {n_state}=decode_address;
end
end
endmodule