module router_fsm(input clock,resetn,pkt_valid,fifo_full,parity_done,low_packet_valid,
input [2:0]fifo_empty,soft_reset,
input [1:0]data_in,
output reg write_enb_reg,detect_add,ld_state,lfd_state,laf_state,full_state,
output reg reset_int_reg,busy);
parameter DECODE_ADDRESS=3'b000,
LOAD_FIRST_DATA        =3'b001,
WAIT_TILL_EMPTY         =3'b010,
LOAD_DATA               =3'b011,
FIFO_FULL_STATE        =3'b100,
LOAD_PARITY             =3'b101,
LOAD_AFTER_FULL         =3'b110,
CHECK_PARITY_ERROR      =3'b111;
reg [2:0]state,n_state;
integer t;
reg temp,full;
initial
{temp}=0;
always@
(negedge clock)
full=fifo_full;
always@
(posedge clock)
begin
temp<=pkt_valid;
if(!resetn)
state=DECODE_ADDRESS;
else
state=n_state;
end
always@(*)
begin
n_state=DECODE_ADDRESS;
case(state)
DECODE_ADDRESS :begin
{full_state,detect_add,ld_state,lfd_state,laf_state,write_enb_reg,busy,reset_int_reg}=0;
detect_add=1'b1;
if(pkt_valid==1&&temp==0)
begin
t=data_in;
if((pkt_valid&(data_in==0)&(~fifo_empty[0]))||(pkt_valid&(data_in==1)&(~fifo_empty[1]))||(pkt_valid&(data_in==2)&(~fifo_empty[2])))
n_state=WAIT_TILL_EMPTY;
else if((pkt_valid&(data_in==0)&fifo_empty[0])||(pkt_valid&(data_in==1)&fifo_empty[1])||(pkt_valid&(data_in==2)&fifo_empty[2]))
n_state=LOAD_FIRST_DATA;
end
end
WAIT_TILL_EMPTY:begin
busy=1'b1;
if(~(fifo_empty[t]))//data_in=00,fifo_empty[0],data_in=01,fifo_empty[1]
n_state=WAIT_TILL_EMPTY;
else if(fifo_empty[t])
n_state=LOAD_FIRST_DATA ;
end
LOAD_FIRST_DATA:{write_enb_reg,detect_add,lfd_state,busy,n_state}={4'b0011,LOAD_DATA};
LOAD_DATA:begin
{busy,laf_state,lfd_state,ld_state}=4'b0001;
write_enb_reg=1'b1;
if(fifo_full==1'b1) n_state=FIFO_FULL_STATE;
else if(fifo_full==1'b0&&pkt_valid==1'b0) n_state=LOAD_PARITY;
else n_state=LOAD_DATA;
end
LOAD_PARITY:{laf_state,ld_state,busy,write_enb_reg,n_state}={4'b0111,CHECK_PARITY_ERROR};
FIFO_FULL_STATE:begin
{full_state,busy,write_enb_reg,ld_state}={4'b1100};
if(fifo_full==1'b0) {write_enb_reg,n_state}={1'b0,LOAD_AFTER_FULL};
else n_state=FIFO_FULL_STATE;
end
LOAD_AFTER_FULL:begin
{full_state,ld_state,laf_state,busy,write_enb_reg}=5'b00111;
if(parity_done==1'b1) n_state=DECODE_ADDRESS;
else if(parity_done==1'b0&&low_packet_valid==1'b0) n_state=LOAD_DATA;
else if(parity_done==1'b0&&low_packet_valid==1'b1) n_state=LOAD_PARITY;
end
CHECK_PARITY_ERROR:begin
{reset_int_reg,busy,ld_state,write_enb_reg}=4'b1100;
if(full==1'b1) n_state=FIFO_FULL_STATE;
else if(full==1'b0) n_state=DECODE_ADDRESS;
end
endcase
if(soft_reset)begin
{n_state}=DECODE_ADDRESS;
end
end
/*assign busy=~((state==LOAD_DATA) || (state == DECODE_ADDRESS));
assign detect_add=(state== DECODE_ADDRESS);
assign ld_state=(state== LOAD_DATA);
assign laf_state=(state==LOAD_AFTER_FULL);
assign full_state=(state==FIFO_FULL_STATE);
assign write_enb_reg=(state==LOAD_DATA) ||(state==LOAD_AFTER_FULL) ||(state==LOAD_PARITY);
assign reset_int_reg= (low_packet_valid) ? 0 : (state==CHECK_PARITY_ERROR);
assign lfd_state=(state==LOAD_FIRST_DATA); */
endmodule