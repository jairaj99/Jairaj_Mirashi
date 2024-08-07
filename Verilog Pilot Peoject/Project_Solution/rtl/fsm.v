/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	fsm.v   

Description:	This module is the functional description of
                controller unit.It generates control signals 
	        which controls the Alarm clock operation .

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/

module fsm (clock,
            reset,
            one_second,
            time_button,
            alarm_button,
            key,
            reset_count,
            load_new_a,
            show_a,
            show_new_time,              
            load_new_c,              
            shift);
// Define the input and output port direction
input clock, 
      reset, 
      one_second,
      time_button, 
      alarm_button;

input [3:0] key;

output load_new_a,
       show_a,
       show_new_time,
       load_new_c,
       shift,
       reset_count;
       
// Define internal register for present state and next state 
reg [2:0] pre_state,next_state;
// Define internal signal for timeout logic
wire time_out;
// Define registers for counting 10 secs in KEY_ENTRY and KEY_WAITED state
reg [3:0] count1,count2;

//states definition
parameter SHOW_TIME         = 3'b000;
parameter KEY_ENTRY         = 3'b001;
parameter KEY_STORED        = 3'b010; 
parameter SHOW_ALARM        = 3'b011;
parameter SET_ALARM_TIME    = 3'b100;
parameter SET_CURRENT_TIME  = 3'b101;
parameter KEY_WAITED        = 3'b110;
parameter NOKEY             = 10;

//Counts 10 seconds pulses for KEY_ENTRY state
always @ (posedge clock or posedge reset)
begin
  // Upon reset, set the count1 value to 1'b0
  if(reset)
     count1 <= 4'd0;
  // Else check if present state is a state other than KEY_ENTRY, then set the count1 value to 1'b0
  else if(!(pre_state == KEY_ENTRY))
     count1 <= 4'd0;
  // Else check if the count1 value reaches 'd9, then set the count1 to 1'b0
  else if (count1==9)
     count1 <= 4'd0;
  // Else increment the count for every one_second pulse
  else if(one_second)
     count1 <= count1 + 1'b1;
end

//Counts 10 seconds pulses for KEY_WAITED state
always @ (posedge clock or posedge reset)
begin
  // Upon reset, set the count2 value to 1'b0
  if(reset)
     count2 <= 4'd0;
  // Else check if present state is a state other than KEY_WAITED, then set the count2 value to 1'b0
  else if(!(pre_state == KEY_WAITED))
     count2 <= 4'd0;
  // Else check if the count2 value reaches 'd9, then set the count2 to 1'b0
  else if (count2==9)
     count2 <= 4'd0;
  // Else increment the count for every one_second pulse
  else if(one_second)
     count2 <= count2 + 1'b1;
end

//Time out logic  // Assert time_out signal whenever the count1 or count2 reaches 'd9
assign time_out=((count1==9) || (count2==9)) ? 0 : 1;

//Present state logic 
always @ (posedge clock or posedge reset) 
begin
  // Upon reset, assign the present_state as "SHOW_TIME"
  if(reset)
     pre_state <= SHOW_TIME;
  // Else if there is no reset then assign the present_state as next_state
  else
     pre_state <= next_state;
end

//Next state logic 
// Whenever there is a change in input, check for present_state and assign next_state with approriate state
always @ (pre_state or key or alarm_button or time_button or time_out)
begin
  case(pre_state)
       // State transition from SHOW_TIME to other state
       SHOW_TIME  : begin
                    // Check if alarm_button is pressed, then the next state is SHOW_ALARM
                     if (alarm_button)
                       next_state = SHOW_ALARM;
                    // Else check if the key is pressed or not, If key pressed, then next_state is KEY_STORED
                     else if (key != NOKEY)
                        next_state = KEY_STORED;
                    // Else if the key is not pressed, then next_state is SHOW_TIME state
		     else
                        next_state = SHOW_TIME; 						  
                    end
       // In KEY_STORED state assign next_state as KEY_WAITED 
       KEY_STORED : next_state = KEY_WAITED;
       // State transition from KEY_WAITED state
       KEY_WAITED : begin
                    // Check if the pressed key is released, If the key is released then next_state is KEY_ENTRY state
                     if (key == NOKEY)  
                       next_state = KEY_ENTRY;
                    // Else check if active low time_out signal is asserted, If asserted, then next_state is SHOW_TIME state
                     else if(time_out == 0)
                       next_state = SHOW_TIME;
                    // Else the next_state is KEY_WAITED state
                     else
                        next_state = KEY_WAITED;
	           end
       // State transition from KEY_ENTRY state
       KEY_ENTRY  : begin
                    // Check if the alarm_button is pressed, if pressed then set the next_state as SET_ALARM_TIME state     
                      if (alarm_button)
                       next_state = SET_ALARM_TIME;
                    // Else if the time_button is pressed, then set the next_state as SET_CURRENT_TIME state  
                      else if (time_button)
                       next_state = SET_CURRENT_TIME;
                    // Else if 10sec timeout is asserted, then set the next_state as SHOW_TIME state
                      else if (time_out == 0) 
                       next_state = SHOW_TIME;
                    // Else if the key is pressed, then set the next_state as KEY_STORED state
                      else if (key != NOKEY)
                       next_state =KEY_STORED;
                    // Else the next_state is KEY_ENTRY state
		      else
                       next_state = KEY_ENTRY;	  
                    end
      // State transition from SHOW_ALARM state
      SHOW_ALARM  : begin
                    // If alarm_button is pressed, then set next_state as SHOW_ALARM state else next_state is SHOW_TIME state
                      if (!alarm_button)
                       next_state = SHOW_TIME;
		      else
                       next_state = SHOW_ALARM;		  
                    end
   // In SET_ALARM_TIME state assign next_state as SHOW_TIME
   SET_ALARM_TIME : next_state = SHOW_TIME;
   // In SET_ALARM_TIME state assign next_state as SHOW_TIME
   SET_CURRENT_TIME : next_state = SHOW_TIME;
   // Set default state as SHOW_TIME state
          default : next_state = SHOW_TIME;

  endcase
end
       
//Moore FSM outputs 

// Assert show_new_time signal, when present state is either KEY_ENTRY or KEY_STORED or KEY_WAITED state       
assign show_new_time = (pre_state == KEY_ENTRY||
                        pre_state == KEY_STORED||
                        pre_state == KEY_WAITED) ? 1 : 0;
// Assert show_a signal when present state is SHOW_ALARM
assign show_a        = (pre_state == SHOW_ALARM) ? 1 : 0;
// Assert load_new_a signal when present state is SET_ALARM_TIME state
assign load_new_a    = (pre_state == SET_ALARM_TIME) ? 1 : 0;
// Assert load_new_c signal when present state is SET_CURRENT_TIME state
assign load_new_c    = (pre_state == SET_CURRENT_TIME) ? 1 : 0;
// Assert reset_count signal when present state is SET_CURRENT_TIME state
assign reset_count   = (pre_state == SET_CURRENT_TIME) ? 1 : 0;
// Assert shift signal when present state is KEY_STORED state
assign shift         = (pre_state == KEY_STORED) ? 1 : 0;

endmodule
