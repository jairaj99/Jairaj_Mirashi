import uvm_pkg::*; // Import UVM package for base classes and utilities
`include "uvm_macros.svh" // Include UVM macros for logging and other utilities
`include "counter_inf.sv" // Include the interface definition for the DUT
`include "counter_pkg.sv" // Include the package containing other necessary definitions

import counter_pkg::*; // Import the package that includes transaction and environment classes

module counter_top;

    parameter int CYCLE = 10; // Clock cycle time in time units
    reg clk; // Clock signal

    // Declare interface instance
    counter_inf DUT_INF (clk); // Interface that connects to the DUT

    // Instantiate the DUT (Device Under Test)
    counter_load DUT (
        .clk(clk),                  // Connect the clock signal
        .rst(DUT_INF.rst),          // Connect reset from interface
        .load(DUT_INF.load),        // Connect load signal from interface
        .data_out(DUT_INF.data_out),// Connect data output from interface
        .data_in(DUT_INF.data_in)   // Connect data input from interface
    );

    // Initial block to set up UVM configuration and run the test
    initial begin
        // Set the interface instance in the UVM configuration database
        uvm_config_db #(virtual counter_inf)::set(uvm_root::get(), "*", "vif", DUT_INF);
        
        // Run the test case named "counter_base_test"
        run_test("counter_base_test"); // Ensure this matches the name of your test class
    end

    // Initial block to generate the clock signal
    initial begin
        clk = 1'b0; // Initialize clock to 0
        forever #(CYCLE/2) clk = ~clk; // Toggle clock every half cycle
    end
  
    // Initial block to dump waveforms for debugging
    initial begin
        $dumpfile("dump.vcd"); // Specify the VCD file for dumping waveforms
        $dumpvars; // Dump all variables to the VCD file
    end

endmodule
