`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:50:08 12/28/2021
// Design Name:   full_adder
// Module Name:   C:/Users/User/OneDrive/Desktop/Sample_examples/full_adder/full_adder.v
// Project Name:  full_adder
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: full_adder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module full_adders();

	// Inputs
	reg a_in;
	reg b_in;
	reg c_in;

	// Outputs
	wire sum_out;
	wire carry_out;

integer i;
	// Instantiate the Unit Under Test (UUT)
	full_adder uut (
		.a_in(a_in), 
		.b_in(b_in), 
		.c_in(c_in), 
		.sum_out(sum_out), 
		.carry_out(carry_out)
	);

	initial begin
		// Initialize Inputs
		a_in = 1'b0;
		b_in = 1'b0;
		c_in = 1'b0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   initial
      begin 
	 for (i=0;i<8;i=i+1)
	    begin
	       {a_in,b_in,c_in}=i;
	       #10;
	    end
      end   
		
endmodule

