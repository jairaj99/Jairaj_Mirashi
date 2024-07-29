class prime_number;
  // Declare a dynamic array to store prime numbers
  rand int prime[];

  // Define a constraint to populate the prime array with prime numbers
  constraint c_p { 
    // The size of the prime array should be 100
    prime.size == 100;

    // Iterate through each index of the prime array
    foreach (prime[i]) 
      // Check if the index `i` is a prime number
      if (i > 1 && 
          !((i % 2 == 0 && i != 2) || 
            (i % 3 == 0 && i != 3) || 
            (i % 4 == 0 && i != 4) || 
            (i % 5 == 0 && i != 5) || 
            (i % 6 == 0 && i != 6) || 
            (i % 7 == 0 && i != 7) || 
            (i % 8 == 0 && i != 8) || 
            (i % 9 == 0 && i != 9))) 
        // If `i` is prime, assign it to the prime array at index `i`
        prime[i] == i;
      else 
        // If `i` is not prime, assign the value 2 to the prime array at index `i`
        prime[i] == 2;
  }

  // Function to remove duplicates from the prime array after randomization
  function void post_randomize();
    // Make the prime array unique by removing duplicates
    prime = prime.unique();
  endfunction

endclass

module tb;
  initial begin
    // Declare an instance of the prime_number class
    prime_number pnum;
    // Create a new instance of the prime_number class
    pnum = new();
    // Randomize the instance to populate the prime array
    pnum.randomize();
    // Display the prime numbers stored in the prime array
    $display("Prime Numbers = %p", pnum.prime);
  end
endmodule
