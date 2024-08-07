module router_fifo_tb;

reg clock,resetn,write_enb,read_enb,lfd_state,soft_reset;
reg [7:0]data_in;
wire [7:0]data_out;
wire full,empty;
integer i;

router_fifo DUT(clock,resetn,soft_reset,write_enb,read_enb,lfd_state,data_in,full,empty,data_out);

task initialize;
{resetn,write_enb,read_enb,data_in,lfd_state}=0;
endtask

task reset;
begin
@(negedge clock)
resetn=0;
@(negedge clock)
resetn=1;
end
endtask

task soft_rst;
begin
@(negedge clock)
soft_reset=1;
@(negedge clock)
soft_reset=0;
end
endtask

task write_enbite;
reg [7:0]payload_data,parity,header;
reg[5:0]payload_len;
reg[1:0]addr;
begin
@(negedge clock) 
lfd_state=1;
data_in=8'bx;
@(negedge clock)
payload_len=6'd14;
addr=2'b01;
header={payload_len,addr};
data_in=header;
lfd_state=1'b1;
write_enb=1;
for(i=0;i<5;i=i+1)
begin
@(negedge clock)
lfd_state=0;
data_in=({$random}%256);
end
@(negedge clock)
data_in={$random}%256;
end
endtask

task read;
begin
for(i=0;i<1;i=i+1)
begin
@(negedge clock)
read_enb=1;
write_enb=0;
end
end
endtask

always
begin
clock=1'b1;
#5;
clock=~clock;
#5;
end

initial
begin
initialize;
reset;
soft_rst;
write_enbite;
read;
#200 $stop;
end

endmodule