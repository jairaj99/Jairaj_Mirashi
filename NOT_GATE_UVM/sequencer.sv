// Define the sequencer class extending uvm_sequencer with a parameterized type seq_item
class sequencer extends uvm_sequencer#(seq_item);
  `uvm_component_utils(sequencer) // Macro to register the class with the UVM factory

  // Constructor
  function new(string name="sequencer", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor with the given name and parent
  endfunction
  
  // Build phase of the sequencer
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method for any necessary setup
  endfunction
  
endclass
