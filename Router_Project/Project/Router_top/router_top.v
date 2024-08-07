module router_top(input clock,resetn,pkt_valid,
				  input [2:0] read_enb,
				  input [7:0]data_in,
				  output [2:0]valid_out,
				  output err,busy,
				  output [7:0]data_out_0,data_out_1,data_out_2);

  wire [2:0]write_enb;
  wire [7:0]dout;
  wire [2:0]soft_reset,full,empty;

router_fifo f0(clock,resetn,soft_reset[0],write_enb[0],read_enb[0],lfd_state,dout,full[0],empty[0],data_out_0);
router_fifo f1(clock,resetn,soft_reset[1],write_enb[1],read_enb[1],lfd_state,dout,full[1],empty[1],data_out_1);
router_fifo f2(clock,resetn,soft_reset[2],write_enb[2],read_enb[2],lfd_state,dout,full[2],empty[2],data_out_2);

fsm a1(clock,resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,empty,soft_reset,data_in[1:0],write_enb_reg,detect_add,
ld_state,lfd_state,laf_state,full_state,rst_int_reg,busy);

sync a2(clock,resetn,detect_add,write_enb_reg,full,empty,read_enb,data_in[1:0],soft_reset,write_enb,valid_out,fifo_full);

register a3(clock,resetn,pkt_valid,fifo_full,detect_add,ld_state,lfd_state,laf_state,full_state,rst_int_reg,data_in,dout,
err,parity_done,low_packet_valid);

endmodule