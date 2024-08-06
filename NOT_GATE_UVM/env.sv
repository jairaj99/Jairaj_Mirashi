// Define the env class extending uvm_env
class env extends uvm_env;
  `uvm_component_utils(env) // Macro to register the class with the UVM factory

  // Declare member variables
  agent agt;        // Agent component instance
  scoreboard sb;    // Scoreboard component instance
  
  // Constructor
  function new(string name="env", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor
  endfunction
  
  // Build phase of the environment
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
    
    // Create instances of the agent and scoreboard components
    agt = agent::type_id::create("agt", this);
    sb = scoreboard::type_id::create("sb", this);
  endfunction
  
  // Connect phase of the environment
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase); // Call the parent class connect_phase method
    
    // Connect the monitor's item collection port to the scoreboard's item collection export
    agt.mon.item_collect_port.connect(sb.item_collect_export);
  endfunction

endclass
