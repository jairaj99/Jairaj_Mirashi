`include "uvm_macros.svh" // Include UVM macros for UVM functionalities
import uvm_pkg::*;        // Import UVM package for UVM classes and methods

`include "interface.sv"   // Include the definition of the interface
`include "base_test.sv"   // Include the base test class definition

module tb_top;

  // Instantiate the interface
  not_if vif();  // Declare an instance of the interface not_if
   
  // Instantiate the Device Under Test (DUT)
  not_gate dut (
    .in(vif.in),  // Connect the input of the DUT to the input of the interface
    .out(vif.out) // Connect the output of the DUT to the output of the interface
  );
   
  initial begin
    // Set the interface instance in the UVM configuration database
    // This allows the test to access the interface instance via the config_db
    uvm_config_db#(virtual not_if)::set(uvm_root::get(), "*", "vif", vif);
  end

  initial begin
    // Run the testbench with the base test class
    run_test("base_test");
  end
   
endmodule
