module TB;
  reg clk, rst_n, x;
  wire z;

  // Instantiate the sequence detector
  seq_detector_001011 dut (
    .clk(clk),
    .rst_n(rst_n),
    .x(x),
    .z(z)
  );

  // Clock generation
  initial clk = 0;   
  always #5 clk = ~clk;

  // Stimulus generation
  initial begin
    // Initialize signals
    rst_n = 0;
    x = 0;

    // Reset the system
    #10 rst_n = 1;

    // Apply stimulus to detect "001011" sequence
    #10 x = 0;  // Applying first '0'
    #10 x = 0;  // Applying second '0'
    #10 x = 1;  // Applying first '1'
    #10 x = 0;  // Applying '0'
    #10 x = 1;  // Applying second '1'
    #10 x = 1;  // Applying third '1' -> Should detect "001011"
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;

    // Apply additional sequences
    #10 x = 0;
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;  // Apply incorrect sequence "0011"
    #10 x = 1;
    #10 x = 1;
    #10 x = 0;
    #10 x = 0;
    #10 x = 1;
    #10 x = 0;
    #10 x = 1;
    #10 x = 1;
    #10 x = 1;

    // More test cases can be added to cover edge cases

    // End simulation
    #500 $finish;
  end

  // Monitor the signals
  initial begin
    $monitor(" x: %b | z: %b", x, z);
  end

  // Dump waveforms
  initial begin
    $dumpfile("seq_detector_001011_tb.vcd");
    $dumpvars(0, TB);
  end
endmodule
