module arm;
  // Declare variables to store remainder, the number being evaluated, and the result of calculations
  int rem, num;
  // Initialize variable 'a' to accumulate the sum of cubes of digits
  int a = 0;
  // Initialize 'count' with the number to be checked (153)
  int count = 153;
  
  // Initial block to start the simulation
  initial begin
    // Assign the value of 'count' to 'num' for processing
    num = count;
    
    // Loop to calculate the sum of cubes of digits
    while (num) begin
      // Get the last digit of 'num'
      rem = num % 10;
      // Add the cube of the last digit to 'a'
      a = a + (rem * rem * rem);
      // Remove the last digit from 'num'
      num = num / 10;
    end
    
    // Check if the original number is equal to the sum of the cubes of its digits
    if (count == a)
      // Display if the number is an Armstrong number
      $display("ARMSTRONG NUMBER");
    else
      // Display if the number is not an Armstrong number
      $display("NOT ARMSTRONG NUMBER");
  end
endmodule
