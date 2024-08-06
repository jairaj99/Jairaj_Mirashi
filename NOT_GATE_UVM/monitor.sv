// Define the monitor class extending uvm_monitor
class monitor extends uvm_monitor;
  `uvm_component_utils(monitor) // Macro to register the class with the UVM factory

  // Virtual interface to connect with the DUT
  virtual not_if vif;

  // Analysis port to send monitored items to the scoreboard
  uvm_analysis_port#(seq_item) item_collect_port;
  
  // Sequence item to hold monitored data
  seq_item mon_item;
  
  // Constructor
  function new(string name="monitor", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor with the given name and parent
    item_collect_port = new("item_collect_port", this); // Create a new analysis port for sending data
  endfunction
  
  // Build phase of the monitor
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
    
    // Check if the virtual interface is correctly set
    if (!uvm_config_db#(virtual not_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Virtual interface not set on top level") // Report an error if vif is not set
    end
    
    // Initialize the sequence item for monitoring
    mon_item = seq_item::type_id::create("mon_item");
  endfunction
  
  // Run phase of the monitor
  task run_phase(uvm_phase phase);
    forever begin
      // Monitor and log input and output values from the DUT
      mon_item.in <= vif.in; // Capture the input value from the DUT
      `uvm_info(get_type_name(), $sformatf("IN = %0d", mon_item.in), UVM_LOW); // Log the input value
      mon_item.out <= vif.out; // Capture the output value from the DUT
      `uvm_info(get_type_name(), $sformatf("OUT = %0d", mon_item.out), UVM_LOW); // Log the output value

      // Send the monitored item to the scoreboard
      item_collect_port.write(mon_item);

      // Small delay to avoid simulation lockups
      #1ns;
    end
  endtask
  
endclass
