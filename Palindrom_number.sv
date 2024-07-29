module palindrom_number;
  // Declare variables to store remainder, reversed number, and number being evaluated
  int rem, a, num;
  // Initialize the count variable to 100 (starting point of the range to be checked)
  int count = 100;
  
  // Initial block to start the simulation
  initial begin
    // Outer while loop to check numbers from 100 to 500
    while (count <= 500) begin
      // Assign the current count value to num for processing
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
      
      // Check if the original number is equal to the reversed number
      if (count == a) begin
        // Display the number if it is palindromic
        $display("%0d", count);
      end
      
      // Increment count to check the next number
      count++;
    end
  end
endmodule
