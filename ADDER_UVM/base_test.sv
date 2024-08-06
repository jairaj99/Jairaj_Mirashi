`include "package.sv"

class base_test extends uvm_test;
  env env_o;                     // Environment instance
  base_seq bseq;                 // Sequence instance
  `uvm_component_utils(base_test) // Macro for UVM component utilities
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);     // Call base class constructor
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);    // Call base class build_phase method
    env_o = env::type_id::create("env_o", this); // Create environment instance
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this); // Raise objection to start the test
    
    bseq = base_seq::type_id::create("bseq"); // Create sequence instance
    
    repeat (10) begin
      #5; bseq.start(env_o.agt.seqr); // Start sequence with the sequencer from the agent
    end
    
    phase.drop_objection(this);   // Drop objection to end the test
    `uvm_info(get_type_name, "End of testcase", UVM_LOW); // Display end of testcase info
  endtask
endclass
