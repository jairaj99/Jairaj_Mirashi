/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   mux4_1_tb.v   

Description :      Mux 4:1 Testbench

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module mux4_1_tb();

   //Step1 : Write down the variables required for testbench
   reg [3:0]d;
   reg [1:0]sel;
   wire y;

   //Step2 : Instantiate the Design 
   mux4_1 DUT(d,
	      sel,
	      y);

   //Step3 : Declare a task to initialize inputs of DUT to 0 
   task initialize;
      begin
	 {d,sel} = 0;
      end
   endtask

   //Step4 : Declare  tasks with arguments for driving stimulus to DUT 
   task stimulus(input [3:0]i,input [1:0]j);
      begin
	 #10;
	 d = i;
	 sel = j;
      end
   endtask

   //Step5 : Call the tasks from procedural process 
   initial
      begin
	 initialize;
	 stimulus(4'd5,2'd2);
	 stimulus(4'd15,2'd3);
	 stimulus(4'd6,2'd1);
      end

   //Step6 : Use $monitor task to display inputs and outputs
   initial
      begin
	 $monitor("Values of data=%b,sel=%b,Output=%b",d,sel,y);
      end

   //Step7 : Use $finish task to terminate the simulation at 100ns
   initial
      begin
	 #100 $finish;
      end
			
   
endmodule

