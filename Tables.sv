module tables;
  // Declare and initialize variables a, b, and c with specific values
  int a = 24, b = 50, c = 29;
  // Declare variables X, Y, and Z to store multiplication results
  int X, Y, Z;

  // Initial block to start the simulation
  initial begin
    // Loop to print the multiplication table for 'a'
    for (int i = 0; i <= 10; i++) begin
      // Calculate the product of 'a' and 'i'
      X = a * i;
      // Display the result of the multiplication
      $display("%0d * %0d = %0d", a, i, X);
    end
    // Separator for readability
    $display("--------------------------");

    // Loop to print the multiplication table for 'b'
    for (int i = 0; i <= 10; i++) begin
      // Calculate the product of 'b' and 'i'
      Y = b * i;
      // Display the result of the multiplication
      $display("%0d * %0d = %0d", b, i, Y);
    end
    // Separator for readability
    $display("--------------------------");

    // Loop to print the multiplication table for 'c'
    for (int i = 0; i <= 10; i++) begin
      // Calculate the product of 'c' and 'i'
      Z = c * i;
      // Display the result of the multiplication
      $display("%0d * %0d = %0d", c, i, Z);
    end
    // Separator for readability
    $display("--------------------------");
  end
endmodule
