class agent extends uvm_agent;
  `uvm_component_utils(agent)  // Macro for UVM component utilities
  driver drv;                  // Driver instance
  seqcr seqr;                  // Sequencer instance
  monitor mon;                 // Monitor instance
  
  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);   // Call base class constructor
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);  // Call base class build_phase method
    
    if (get_is_active == UVM_ACTIVE) begin
      drv = driver::type_id::create("drv", this);    // Create driver instance
      seqr = seqcr::type_id::create("seqr", this);  // Create sequencer instance
    end
    
    mon = monitor::type_id::create("mon", this);    // Create monitor instance
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if (get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export); // Connect driver to sequencer via sequence item ports
    end
  endfunction
endclass
