`include "package.sv" // Include the package file containing class and function definitions

// Define the base_test class, extending the uvm_test class
class base_test extends uvm_test;
  `uvm_component_utils(base_test) // Macro to register the class with the UVM factory

  // Declare member variables
  env env_o;           // Environment object instance
  base_seq bseq;      // Sequence object instance
  
  // Constructor
  function new(string name="base_test", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor
  endfunction
  
  // Build phase of the test
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
    
    // Create an instance of the environment component
    env_o = env::type_id::create("env", this);
  endfunction
  
  // Run phase of the test
  task run_phase(uvm_phase phase);
    
    // Raise an objection to prevent the test from ending
    phase.raise_objection(this);
    
    // Create an instance of the sequence
    bseq = base_seq::type_id::create("bseq");
    
    // Repeat the sequence execution 5 times with a 5-time unit delay between each
    repeat(5) begin
      #5; // Wait for 5 time units
      bseq.start(env_o.agt.seqr); // Start the sequence using the sequence driver
    end
    
    // Drop the objection to allow the test to end
    phase.drop_objection(this);
    
    // Print an informational message to the simulation log
    `uvm_info(get_type_name(), "END OF TESTCASE", UVM_LOW);
    
  endtask
  
endclass
