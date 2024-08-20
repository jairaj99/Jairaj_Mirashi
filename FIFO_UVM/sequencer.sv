class sequencer extends uvm_sequencer#(seq_item);
  `uvm_component_utils(sequencer)
  
  function new(string name="sequencer", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass