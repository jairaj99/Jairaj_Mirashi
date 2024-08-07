/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	alarm_reg.v   

Description:	This is a functional description of alarm register unit .
                It is a lodable register which stores the alarm time .

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/

module alarm_reg (new_alarm_ms_hr,
              new_alarm_ls_hr,
              new_alarm_ms_min,
              new_alarm_ls_min,
              load_new_alarm,
              clock,
              reset,
              alarm_time_ms_hr,
              alarm_time_ls_hr,
              alarm_time_ms_min,
              alarm_time_ls_min );

// Define input and output port directions
input [3:0]new_alarm_ms_hr,
           new_alarm_ls_hr,
           new_alarm_ms_min,
           new_alarm_ls_min;

input load_new_alarm;
input clock;
input reset;

output reg [3:0] alarm_time_ms_hr,
                 alarm_time_ls_hr,
                 alarm_time_ms_min,
                 alarm_time_ls_min;

//Lodable Register which stores alarm time  
always @ (posedge clock or posedge reset)
begin
  // Upon reset, store reset value(1'b0) to the alarm_time registers
  if(reset)
  begin
    alarm_time_ms_hr  <= 4'b0;
    alarm_time_ls_hr  <= 4'b0;
    alarm_time_ms_min <= 4'b0;
    alarm_time_ls_min <= 4'b0;
  end
// If no reset, check for load_new_alarm signal and load new_alarm time to alarm_time registers
  else if(load_new_alarm)
  begin
    alarm_time_ms_hr  <= new_alarm_ms_hr;
    alarm_time_ls_hr  <= new_alarm_ls_hr;
    alarm_time_ms_min <= new_alarm_ms_min;
    alarm_time_ls_min <= new_alarm_ls_min;
  end
end

endmodule
  
 
