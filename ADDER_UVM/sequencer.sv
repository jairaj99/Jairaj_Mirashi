class seqcr extends uvm_sequencer#(seq_item);
  `uvm_component_utils(seqcr)  // Macro for UVM component utilities
  
  function new(string name = "seqcr", uvm_component parent = null);
    super.new(name, parent);   // Call base class constructor
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);  // Call base class build_phase method
  endfunction
endclass
