// Define the NOT gate module
module not_gate(
  input  in,     // Input signal
  output out     // Output signal
);

  // Assign the output as the logical negation of the input
  // The '~' operator performs the bitwise NOT operation
  assign out = ~in;

endmodule
