/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	tb_alarm_clock.v   

Description:	This is the top Testbench  module of Alarm clock
                which is used to generate stimulus patterns for the DUT .

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/

module tb_alarm_clock();

reg clk,
    reset,
    fast_watch,
    alarm_button,
    time_button;

reg [3:0] key;

wire [7:0] display_ms_hr,
           display_ms_min,
           display_ls_hr,
           display_ls_min;

wire sound_alarm;

parameter cycle = 2;


alarm_clock_top DUV(.clock(clk),
                    .reset(reset),
                    .fastwatch(fast_watch),
                    .alarm_button(alarm_button),
                    .time_button(time_button),
                    .key(key),
                    .alarm_sound(sound_alarm),
                    .ms_hour(display_ms_hr),
                    .ls_hour(display_ls_hr),
                    .ms_minute(display_ms_min),
                    .ls_minute(display_ls_min));

 //Clock generation logic
 initial
  begin
     clk = 1'b0;
     forever
     #(cycle/2) clk = ~clk;
   end

 //

 //Stimulus logic 
 initial
  begin
   //Hard reset the design 
    reset = 1;
    #10;
    reset = 0;
   //Set fastwatch to 1 to make counting faster 
   fast_watch = 1;
   //Set  key time to current time :11:23
   key = 1;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 1;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 2;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 3;
   repeat(3)   
   @(negedge clk);
   key = 10;
   @(negedge clk);
   time_button = 1;
   @(negedge clk);
   time_button = 0;

   //Set  key time to alarm time :11:30
   key = 1;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 1;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 3;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   key = 0;
   repeat(3)
   @(negedge clk);
   key = 10;
   @(negedge clk);
   alarm_button = 1;
   @(negedge clk);
   alarm_button = 0;
   #(7*256*2);//7 -> 7minutes ->7seconds->7 *256 clock cycles ->7*256*2(Time period of clock)
   //Time out for Alarm clock 
    //key = 7;
    repeat(4*2564) //Wait for minimum 10second pulses i.e (10*256) clock cycles 
    @(negedge clk);
   $finish;
  end

 initial
  $monitor($time,"\-ns\t MAVEN SILICON : \tDISPLAY_MS_HR =%H >>> DISPLAY_LS_HR =%H>>> DISPLAY_MS_MIN =%H>>> DISPLAY_LS_MIN=%H",display_ms_hr[3:0],display_ls_hr[3:0],display_ms_min[3:0],display_ls_min[3:0]); 

endmodule
