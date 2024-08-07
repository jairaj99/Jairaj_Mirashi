module enumm();

//enum{init, read,write,brd,bwr}fsm_state;
//fsm_state=init;
//fsm_state=read;

typedef enum{init,read=2,write,brd=7,bwr} fsm_state_et;
fsm_state_et pre_state, next_state;
fsm_state_et state=state.first;

initial
forever
begin
$display("%s : %d ", state.name, state);
if(state == state.last())
   break;
state=state.next();

end

endmodule
