class monitor extends uvm_monitor;
  virtual add_if vif;                             // Virtual interface instance for communication with DUT
  uvm_analysis_port #(seq_item) item_collect_port; // Analysis port to send sequence items to scoreboard
  seq_item mon_item;                              // Sequence item variable to collect DUT signals
  `uvm_component_utils(monitor)                   // Macro for UVM component utilities
  
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);                      // Call base class constructor
    item_collect_port = new("item_collect_port", this); // Initialize analysis port
    mon_item = new();                             // Initialize sequence item
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);                     // Call base class build_phase method
    if (!uvm_config_db#(virtual add_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level"); // Fatal error if vif is not configured
  endfunction
  
  task run_phase(uvm_phase phase);
    forever begin
      wait(!vif.reset);                          // Wait until reset is deasserted
      @(posedge vif.clk);                        // Wait for positive clock edge
      mon_item.ip1 = vif.ip1;                    // Capture input ip1 from virtual interface
      mon_item.ip2 = vif.ip2;                    // Capture input ip2 from virtual interface
      `uvm_info(get_type_name, $sformatf("ip1 = %0d, ip2 = %0d", mon_item.ip1, mon_item.ip2), UVM_HIGH); // Log inputs
      @(posedge vif.clk);                        // Wait for another clock edge
      mon_item.out = vif.out;                    // Capture output from virtual interface
      item_collect_port.write(mon_item);          // Write captured item to analysis port
    end
  endtask
endclass
