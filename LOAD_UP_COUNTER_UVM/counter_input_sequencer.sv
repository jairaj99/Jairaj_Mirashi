class counter_input_sequencer extends uvm_sequencer #(counter_trans);

  `uvm_component_utils(counter_input_sequencer) // Register the component with the UVM factory

  // Constructor
  function new(string name = "counter_input_sequencer", uvm_component parent = null);
    super.new(name, parent); // Call the base class constructor with the provided name and parent
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the base class build_phase
  endfunction : build_phase

endclass
