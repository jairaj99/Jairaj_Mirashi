module router_reg_tb;
reg clock,resetn,pkt_valid,fifo_full;
reg detect_add,ld_state,lfd_state,laf_state,full_state,rst_int_reg;
reg [7:0]data_in;
wire [7:0]dout;
wire err,parity_done,low_packet_valid;
reg [7:0]prty;
integer i;
router_reg DUT(clock,resetn,pkt_valid,fifo_full,detect_add,ld_state,lfd_state,laf_state,full_state,rst_int_reg,data_in,dout,err,parity_done,low_packet_valid);
initial
begin
clock=0;
forever #5 clock=~clock;
end
task initialize;
begin
{clock,resetn,pkt_valid,fifo_full,detect_add,ld_state,lfd_state,laf_state,full_state,rst_int_reg,data_in}=0;
end
endtask
task reset;
begin
@(negedge clock)
resetn=0;
@(negedge clock)
resetn=1;
end
endtask
initial
begin
initialize;
reset;
@(negedge clock)
detect_add=1;
rst_int_reg=1;
pkt_valid=1;
data_in={6'd13,2'd2};
prty=data_in;
@(negedge clock)
detect_add=0;
rst_int_reg=0;
lfd_state=1;
data_in=0;
for(i=0;i<14;i=i+1)
begin
@(negedge clock)
lfd_state=0;
laf_state=0;
ld_state=1;
if(i!=11||12)
begin
data_in={$random}%256;
prty=data_in^prty;
fifo_full=0;
end
if(i==11||i==12)
fifo_full=1;
end
@(negedge clock)
pkt_valid=0;
data_in=prty;
@(negedge clock)
ld_state=0;
#30 $stop;
end
endmodule
