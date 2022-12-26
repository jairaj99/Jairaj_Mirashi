/********************************************************************************************
Copyright 2019 - Maven Silicon Softech Pvt Ltd. 
 
All Rights Reserved.

This source code is an unpublished work belongs to Maven Silicon Softech Pvt Ltd.

It is not to be shared with or used by any third parties who have not enrolled for our paid training 

courses or received any written authorization from Maven Silicon.


Webpage     :      www.maven-silicon.com

Filename    :	   ram.v   

Description :      Asynchronous Single port Random access memory (16x8)

Author Name :      Susmita

Version     :      1.0
*********************************************************************************************/

module ram(input we_in,enable_in,
	   input [3:0]addr_in,
	   inout [7:0]data);
					
					 
   //Step1 : Declare a 8 bit wide memory having 16 locations.

   //Understand the logic for writing data into a memory location 
   always@(data,we_in,enable_in,addr_in)
      if(we_in && !enable_in)
	 mem[addr_in]=data;

   //Understand the logic of reading data from a memory location 
   assign data= (enable_in && !we_in) ? mem[addr_in] : 8'hzz;

endmodule 

