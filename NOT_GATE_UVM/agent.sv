// Define the agent class extending uvm_agent
class agent extends uvm_agent;
  `uvm_component_utils(agent) // Macro to register the class with the UVM factory

  // Declare member variables for the sequencer, driver, and monitor
  sequencer seqr; // Sequencer component instance
  driver drv;     // Driver component instance
  monitor mon;    // Monitor component instance
  
  // Constructor
  function new(string name="agent", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor with the given name and parent
  endfunction
  
  // Build phase of the agent
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
    
    // Check if the agent is active before creating the sequencer and driver
    if(get_is_active == UVM_ACTIVE) begin
      // Create instances of the sequencer and driver components
      seqr = sequencer::type_id::create("seqr", this);
      drv = driver::type_id::create("drv", this);
    end
    
    // Create an instance of the monitor component (always created regardless of active state)
    mon = monitor::type_id::create("mon", this);
  endfunction
  
  // Connect phase of the agent
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); // Call the parent class connect_phase method
    
    // Connect the driver’s sequence item port to the sequencer’s sequence item export
    if(get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction

endclass
