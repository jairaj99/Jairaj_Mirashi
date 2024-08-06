class env extends uvm_env;
  `uvm_component_utils(env)  // Macro for UVM component utilities
  agent agt;                 // Agent instance
  scoreboard sb;             // Scoreboard instance
  
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent); // Call base class constructor
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call base class build_phase method
    
    agt = agent::type_id::create("agt", this);       // Create agent instance
    sb = scoreboard::type_id::create("sb", this);   // Create scoreboard instance
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agt.mon.item_collect_port.connect(sb.item_collect_export); // Connect monitor's analysis port to scoreboard's export
  endfunction
endclass
