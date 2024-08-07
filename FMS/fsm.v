module fsm(ds,rd, go,clk,rst );

input go,clk,rst;
output ds,rd;

parameter IDEL=2'b00;
parameter READ=2'b01;
parameter DLY =2'b10;
parameter DONE=2'b11;

reg [1:0] state,next_state;

always@(posedge clk or posedge rst)
if(rst)
state <= IDEL;
else
state <= next_state;

always@(state or go)
begin
case(state)
IDEL : if(go) next_state=READ;
		else next_state=IDEL;
READ : if(go) next_state=READ;
		else next_state=DLY;
DLY : if(go) next_state=DONE;
		else next_state=DLY;		
DONE : if(go) next_state=READ;
		else next_state=DLY;
endcase
end
//assign ds = (state == DONE) ? 1 : 0;
assign rd=(state==READ)|| (state == DLY)|| (state == DONE);
assign ds=(state==DONE);
endmodule