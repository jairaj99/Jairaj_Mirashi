module reverse_number;
  // Declare variables to store remainder, reversed number, and number being evaluated
  int rem, a, num;
  // Initialize the count variable to 123 (the number to be reversed)
  int count = 123;
  
  // Initial block to start the simulation
  initial begin
    // Outer while loop to ensure that the number reversal logic runs once
    while (count) begin
      // Assign the current count value to num
      num = count;
      // Initialize a to 0 to store the reversed number
      a = 0;
      
      // Inner while loop to reverse the digits of num
      while (num) begin
        // Extract the last digit of num
        rem = num % 10;
        // Append the last digit to the reversed number
        a = (a * 10) + rem;
        // Remove the last digit from num
        num = num / 10;
      end
      
      // Break the loop after one complete reversal
      break;
    end
    
    // Display the original number and its reversed version
    $display("GIVEN = %0d REVERSE = %0d", count, a);
  end
endmodule
