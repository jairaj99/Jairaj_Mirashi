`include "uvm_macros.svh"
import uvm_pkg::*; // Import UVM package

`include "interface.sv" // Include interface file
`include "base_test.sv" // Include base_test file

module tb_top;
  bit clk;    // Clock signal
  bit reset;  // Reset signal
  
  always #2 clk = ~clk; // Clock generation
  
  initial begin
    // Initialize reset
    //clk = 0;  // Commented out since 'clk' is initialized in the always block
    reset = 1; // Assert reset
    #5;       // Wait for a few cycles
    reset = 0; // Deassert reset
  end
  
  add_if vif(clk, reset); // Instantiate interface 'vif' with clock and reset signals
  
  adder DUT(
    .clk(vif.clk),        // Connect interface signals to DUT ports
    .reset(vif.reset),
    .in1(vif.ip1),
    .in2(vif.ip2),
    .out(vif.out)
  );
  
  initial begin
    // Set interface in config_db for UVM
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
    
    // Dump waveform to VCD file
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
  
  initial begin
    run_test("base_test"); // Start running the UVM test 'base_test'
  end
endmodule
