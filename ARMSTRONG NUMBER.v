module arm;
  // Declare variables to store remainder, individual digit cube sum, and number being evaluated
  int rem, a, num;
  // Initialize the count variable to 100
  int count = 100;

  // Initial block to start the simulation
  initial begin
    // Iterate from 100 to 500
    while (count <= 500) begin
      // Assign the current count value to num
      num = count;
      // Initialize a to 0 to calculate the sum of the cubes of digits
      a = 0;

      // Loop to calculate the sum of the cubes of digits of num
      while (num) begin
        // Extract the last digit of num
        rem = num % 10;
        // Add the cube of the last digit to a
        a = a + (rem * rem * rem);
        // Remove the last digit from num
        num = num / 10;
      end

      // Check if the original number is equal to the sum of the cubes of its digits
      if (count == a) begin
        // Display the Armstrong number
        $display("%0d ARMSTRONG NUMBER", count);
      end

      // Increment the count to check the next number
      count++;
    end
  end
endmodule
