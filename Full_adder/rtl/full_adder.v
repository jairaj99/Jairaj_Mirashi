module full_adder(a_in,
                  b_in,
		  c_in,
		  sum_out,
		  carry_out);

   input a_in, b_in, c_in;
   output sum_out, carry_out;    								//Step1 : Write down the directions for the ports	      

   wire w1,w2,w3;               								//Step2 : Declare the internal wires    

   half_adder HA1(.a(a_in), .b(b_in), .sum(w1), .carry(w2));       	//Step3 : Instantiate the Half-Adders using name-based port mapping			 
   half_adder HA2(.a(w1), .b(c_in), .sum(sum_out), .carry(w3));
   or or1(carry_out, w2, w3);   									//Step4 : Instantiate the OR gate


endmodule

