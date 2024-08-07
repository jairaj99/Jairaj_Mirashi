module router_fsm_tb;
reg clock,resetn,pkt_valid,fifo_full,parity_done,low_packet_valid;
reg [2:0]fifo_empty,soft_reset;
reg [1:0]data_in;
wire write_enb_reg,detect_add,ld_state,lfd_state,laf_state,full_state;
wire reset_int_reg,busy;
reg state;
integer i;
router_fsm DUT(clock,resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,fifo_empty,soft_reset,data_in,write_enb_reg,detect_add,ld_state,lfd_state,laf_state,full_state,reset_int_reg,busy);

parameter DECODE_ADDRESS=3'b000,
LOAD_FIRST_DATA        =3'b001,
WAIT_TILL_EMPTY         =3'b010,
LOAD_DATA               =3'b011,
FIFO_FULL_STATE        =3'b100,
LOAD_PARITY             =3'b101,
LOAD_AFTER_FULL         =3'b110,
CHECK_PARITY_ERROR      =3'b111;

reg [4*8:0]string_cmd;

initial
begin
clock=0;
forever #5 clock=~clock;
end
task initialize;
{resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,fifo_empty,soft_reset,data_in}=0;
endtask
task reset;
begin
@(negedge clock)
resetn=0;
@(negedge clock)
resetn=1;
end
endtask

task t1;
begin
@(negedge clock)
pkt_valid=1;
data_in=2'b01;
fifo_empty[1]=1'b1;
@(negedge clock)
@(negedge clock)
fifo_full=0;
pkt_valid=0;
@(negedge clock)
@(negedge clock)
fifo_full=0;
end
endtask
//begin
//@(negedge clock)
//if(i==13) {fifo_full}=2'b11;
//if(i==16) {fifo_full}=0;
//if(i==9) pkt_valid=0;
/*fifo_empty[1]=1;
end
#30;
@(negedge clock)
pkt_valid=1;
data_in=1;
#100;
@(negedge clock)
soft_reset=3'b000;
@(negedge clock)
soft_reset=0;
#30;
@(negedge clock)
pkt_valid=0;
@(posedge clock)
fifo_full=1;
@(posedge clock)
fifo_full=0;
@(negedge clock)
pkt_valid=0;
*/

task t2;
begin
@(negedge clock)
pkt_valid=1;
data_in=2'b00;
fifo_empty[0]=1'b1;
@(negedge clock)
@(negedge clock)
fifo_full=1'b1;
@(negedge clock)
parity_done=0;
low_packet_valid=1;
@(negedge clock)
@(negedge clock)
fifo_full=0;
end
endtask

task t3;
begin
@(negedge clock)
pkt_valid=1;
data_in=2'b10;
fifo_empty[2]=1'b1;
@(negedge clock)
@(negedge clock)
fifo_full=0;
pkt_valid=0;
@(negedge clock)
@(negedge clock)
fifo_full=1;
@(negedge clock)
fifo_full=0;
@(negedge clock)
parity_done=1;
end
endtask

task t4;
begin
@(negedge clock)
pkt_valid=1;
data_in=2'b01;
fifo_empty[1]=1'b1;
@(negedge clock)
@(negedge clock)
fifo_full=1;
@(negedge clock)
fifo_full=0;
@(negedge clock)
parity_done=0;
low_packet_valid=0;
@(negedge clock)
fifo_full=0;
pkt_valid=0;
@(negedge clock)
@(negedge clock)
fifo_full=0;
end
endtask


always@(state)
      begin
         case (state)
	    DECODE_ADDRESS     :  string_cmd = "DECODE_ADDRESS";
	    LOAD_FIRST_DATA    :  string_cmd = "LOAD_FIRST_DATA ";
	    WAIT_TILL_EMPTY    :  string_cmd = "WAIT_TILL_EMPTY";
	    LOAD_DATA          :  string_cmd = "LOAD_DATA";
	    FIFO_FULL_STATE    :  string_cmd = "FIFO_FULL_STATE";
	    LOAD_PARITY        :  string_cmd = "LOAD_PARITY";
	    LOAD_AFTER_FULL    :  string_cmd = "LOAD_AFTER_FULL";
	    CHECK_PARITY_ERROR :  string_cmd = "CHECK_PARITY_ERROR";
	 endcase
      end
	  
initial
begin
initialize;
reset;
#20;
t1;
t2;
t3;
t4;
#100 $stop;
end
endmodule