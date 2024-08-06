// Define the driver class extending uvm_driver with a parameterized type seq_item
class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver) // Macro to register the class with the UVM factory

  // Virtual interface for communication with the DUT
  virtual not_if vif;

  // Constructor
  function new(string name="driver", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor with the given name and parent
  endfunction

  // Build phase of the driver
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
    
    // Check if the virtual interface (vif) is correctly set in the UVM configuration database
    if (!uvm_config_db#(virtual not_if)::get(this, "", "vif", vif)) begin
      // Report a fatal error if the virtual interface is not set
      `uvm_fatal(get_type_name(), "Virtual interface not set on top level")
    end
  endfunction

  // Run phase of the driver
  task run_phase(uvm_phase phase);
    seq_item req; // Sequence item to be driven
    forever begin
      // Get the next sequence item from the sequencer
      seq_item_port.get_next_item(req);
      
      /* Uncomment the following checks if needed:
      // Check if the received item is null
      if (req == null) begin
        `uvm_fatal(get_type_name(), "Received null item from sequencer.")
      end

      // Check if the virtual interface is null
      if (vif == null) begin
        `uvm_fatal(get_type_name(), "Virtual interface (vif) is not set.")
      end
      */

      // Log the input value of the sequence item
      `uvm_info(get_type_name(), $sformatf("IN = %0d", req.in), UVM_LOW);
      
      // Drive the value onto the DUT via the virtual interface
      vif.in <= req.in;
      
      // Indicate that the item has been processed
      seq_item_port.item_done();
      
      // Small delay to avoid simulation lockups
      #1ns;
    end
  endtask
  
endclass
