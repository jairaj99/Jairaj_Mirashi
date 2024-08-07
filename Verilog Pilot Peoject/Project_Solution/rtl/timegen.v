/********************************************************************************************

Copyright 2018-2019 - Maven Silicon Softech Pvt Ltd. All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.
It is considered a trade secret and is not to be divulged or used by parties who 
have not received written authorization from Maven Silicon Softech Pvt Ltd.

Maven Silicon Softech Pvt Ltd
Bangalore - 560076

Webpage: www.maven-silicon.com

Filename:	timegen.v   

Description:	Timegen will generate one_minute and one_second pulses 
                based on 256Hz clock frequency. 
                When stop watch mode will be one, both the pulses, i.e.
                one minute and one second will be same.

Date:		01/05/2018

Author:		Maven Silicon

Email:		online@maven-silicon.com

Version:	1.0

*********************************************************************************************/
module timegen(clock,
               reset,
               reset_count,
               fastwatch,
               one_second,
               one_minute
               );
 // Define input and output port directions        
  input clock,
        reset,
        reset_count, //Resets the timegen whenever a new current time is set
        fastwatch;  

  output one_second,
         one_minute;
  // Define internal registers required
  reg [13:0] count;
  reg one_second;
  reg one_minute_reg;
  reg one_minute;
 

//One minute pulse generation
always@(posedge clock or posedge reset)
begin
   // Upon reset, set the one_minute_reg value to zero
   if (reset)
   begin
     count<=14'b0;
     one_minute_reg<=0;
   end
   // Else check if there is a reset from alarm controller and reset the one_minute_reg and count value
   else if (reset_count)
   begin
     count<=14'b0;
     one_minute_reg<=1'b0;
   end
   // Else check if the count value reaches 'd15359 to generate 1 minute pulse
   else if (count[13:0]== 14'd15359)
   begin
     count<=14'b0;
     one_minute_reg<=1'b1;      
   end
   // Else for every posedge of clock just increment the count. 
   else   
   begin
     count<=count+1'b1;
     one_minute_reg<=1'b0;
   end
end
                             
//One second pulse generation
always@(posedge clock or posedge reset)
begin
   // If reset is asserted, set one_second and counter_sec value to zero
   if (reset)
   begin
     one_second<=1'b0;
   end
   // Else check if there is reset from alarm_controller, and reset the one_second and counter_sec value    
   else if (reset_count)
   begin
     one_second<=1'b0;
   end
   // Else check if the count value reaches the 'd255 to generate and count 1 sec pulse        
   else if (count[7:0]==8'd255)
   begin
     one_second<=1'b1;
   end
   // Else set the one_second and counter_sec value to zero
   else     
   begin
     one_second<=1'b0;
   end
end

//Fastwatch Mode Logic that makes the counting faster

always@(*)
   begin
    // If fastwatch is asserted, make one_second equivalent to one_minute
    if(fastwatch)
      one_minute =one_second;
    // Else assert one_minute signal when one_minute_reg is asserted
    else
      one_minute =one_minute_reg; 
   end

endmodule 
