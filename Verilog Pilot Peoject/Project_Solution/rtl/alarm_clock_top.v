/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	alarm_clock_top.v   

Description:	This is the top module of Alarm clock.
                It has instantiated all the sub-modules 
		which are connected via internal wires .

Date:		01/05/2018

Author:		Maven Silicon

Email:	        online@maven-silicon.com	

Version:	1.0

*********************************************************************************************/
module alarm_clock_top(clock,
	               key,
		       reset,
		       time_button,
		       alarm_button,
		       fastwatch,
		       ms_hour,
		       ls_hour,
		       ms_minute,
		       ls_minute,
		       alarm_sound);
// Define port directions for the signals
input clock,
      reset,
      time_button,
      alarm_button,
      fastwatch;

input [3:0] key;

output [7:0] ms_hour,
	     ls_hour,
	     ms_minute,
	     ls_minute;

output alarm_sound;

//Define the Interconnecting internal wires
wire one_second, 
     one_minute,
     load_new_c,
     load_new_a,
     show_current_time,
     show_a,
     shift,
     reset_count;
     
wire [3:0] key_buffer_ms_hr,
           key_buffer_ls_hr,
           key_buffer_ms_min,
           key_buffer_ls_min,
           current_time_ms_hr,
           current_time_ls_hr,
           current_time_ms_min,
           current_time_ls_min,
           alarm_time_ms_hr,
           alarm_time_ls_hr,
           alarm_time_ms_min,
           alarm_time_ls_min;

//Instantiate lower sub-modules. Use interconnect(Internal) signals for connecting the sub modules

// Instantiate the timing generator module
timegen tgen1   (.clock(clock),
                .reset(reset),
                .fastwatch(fastwatch),
                .one_second(one_second),
                .one_minute(one_minute),
                .reset_count(reset_count));

// Instantiate the counter module
counter count1 (.one_minute(one_minute),
                .new_current_time_ms_min(key_buffer_ms_min),
                .new_current_time_ls_min(key_buffer_ls_min),
                .new_current_time_ms_hr(key_buffer_ms_hr),
                .new_current_time_ls_hr(key_buffer_ls_hr),
                .load_new_c(load_new_c),
                .clk(clock),
                .reset(reset),
                .current_time_ms_min(current_time_ms_min),
                .current_time_ls_min(current_time_ls_min),
                .current_time_ms_hr(current_time_ms_hr),
                .current_time_ls_hr(current_time_ls_hr)
                );

// Instantiate the alarm register module
alarm_reg alreg1  (.new_alarm_ms_hr(key_buffer_ms_hr),
              .new_alarm_ls_hr(key_buffer_ls_hr),
              .new_alarm_ms_min(key_buffer_ms_min),
              .new_alarm_ls_min(key_buffer_ls_min),
              .load_new_alarm(load_new_a),
              .clock(clock),
              .reset(reset),
              .alarm_time_ms_hr(alarm_time_ms_hr),
              .alarm_time_ls_hr(alarm_time_ls_hr),
              .alarm_time_ms_min(alarm_time_ms_min),
              .alarm_time_ls_min(alarm_time_ls_min));

// Instantiate the key register module
keyreg keyreg1(.reset(reset),
               .clock(clock),
               .shift(shift),
               .key(key),
               .key_buffer_ls_min(key_buffer_ls_min),
               .key_buffer_ms_min(key_buffer_ms_min),
               .key_buffer_ls_hr(key_buffer_ls_hr),
               .key_buffer_ms_hr(key_buffer_ms_hr)
               );

// Instantiate the FSM controller
fsm   fsm1  (.clock(clock),
            .reset(reset),
            .one_second(one_second),
            .time_button(time_button),
            .alarm_button(alarm_button),
            .key(key),
            .load_new_a(load_new_a),
            .show_a(show_a),
            .reset_count(reset_count),
            .show_new_time(show_current_time),              
            .load_new_c(load_new_c),              
            .shift(shift)
             );
// Instantiate the lcd_driver_4 module
lcd_driver_4 lcd_disp  (.alarm_time_ms_hr(alarm_time_ms_hr),
               .alarm_time_ls_hr(alarm_time_ls_hr),
               .alarm_time_ms_min(alarm_time_ms_min),
               .alarm_time_ls_min(alarm_time_ls_min),
               .current_time_ms_hr(current_time_ms_hr),
               .current_time_ls_hr(current_time_ls_hr),
               .current_time_ms_min(current_time_ms_min),
               .current_time_ls_min(current_time_ls_min),
               .key_ms_hr(key_buffer_ms_hr),
               .key_ls_hr(key_buffer_ls_hr),
               .key_ms_min(key_buffer_ms_min),
               .key_ls_min(key_buffer_ls_min),
               .show_a(show_a),
               .show_current_time(show_current_time),
               .display_ms_hr(ms_hour),
               .display_ls_hr(ls_hour),
               .display_ms_min(ms_minute),
               .display_ls_min(ls_minute),
               .sound_a(alarm_sound));

endmodule


		   

