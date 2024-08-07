/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 

All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   seq_det.v   

Description :      Sequence detector detecting "101"


Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module seq_det(seq_in,
	       clock,
	       reset,
	       det_o);
								 
   //Step1 : Declare the states as parameter "IDLE","STATE1","STATE2","STATE3"
   parameter IDLE   = 2'b00,
	     STATE1 = 2'b01,
	     STATE2 = 2'b10,
	     STATE3 = 2'b11;

   //Step2 : Write down the ports direction
   input seq_in,clock,reset;
   output det_o;

   //Internal registers
   reg [1:0]state,next_state;

   //Step3 : Write down the sequential logic for present state with active high asychronous reset
   always@(posedge clock,posedge reset)
      begin
	 if(reset)
	    state <= IDLE;
	 else
	    state <= next_state;
      end
			
   //Understand the combinational logic for next state
   always@(state,seq_in)
      begin
	 case(state)
	    IDLE   : 
                      if(seq_in==1) 
		         next_state=STATE1;
	              else
	                 next_state=IDLE;
	    STATE1 : 
                      if(seq_in==0)
	                 next_state=STATE2;
	              else
	                 next_state=STATE1;
	    STATE2 :
                      if(seq_in==1)
	                 next_state=STATE3;
	              else 
	                 next_state=IDLE;
	    STATE3 : 
                      if(seq_in==1)
	                 next_state=STATE1;
	              else 
	                 next_state=STATE2;
	    default: 
                      next_state=IDLE;
	 endcase
      end

   //Step4 : Write down the logic for Moore output det_o
   assign det_o = (state ==  STATE3) ? 1'b1:1'b0;

endmodule


