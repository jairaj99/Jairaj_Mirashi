class driver extends uvm_driver#(seq_item);
  virtual add_if vif;        // Virtual interface instance for communication with DUT
  `uvm_component_utils(driver) // Macro for UVM component utilities
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);  // Call base class constructor
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call base class build_phase method
    if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level"); // Fatal error if vif is not configured
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      // Driver to the DUT
      seq_item_port.get_next_item(req); // Get next sequence item from sequence
      `uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", req.ip1, req.ip2), UVM_LOW); // Log sequence item details
      vif.ip1 <= req.ip1;     // Drive ip1 to DUT via virtual interface
      vif.ip2 <= req.ip2;     // Drive ip2 to DUT via virtual interface
      seq_item_port.item_done(); // Notify sequencer that item processing is done
    end
  endtask
endclass
