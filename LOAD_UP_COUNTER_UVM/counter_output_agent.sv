class counter_output_agent extends uvm_agent;
    `uvm_component_utils(counter_output_agent) // Register the component with the UVM factory

    // Environment configuration object
    counter_env_config m_cfg; 
    // Output monitor instance
    counter_output_monitor mon_h;

    // Constructor
    function new(string name = "counter_output_agent", uvm_component parent = null);
        super.new(name, parent); // Call the base class constructor with name and parent
    endfunction : new

    // Build phase to initialize components and retrieve configuration
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); // Call the base class build_phase

        // Retrieve the environment configuration from the UVM config database
        if (!uvm_config_db#(counter_env_config)::get(this, "", "counter_env_config", m_cfg)) begin
            `uvm_fatal("CONFIG", "Cannot get() m_cfg from uvm_config_db. Have you set() it?");
        end

        // Create an instance of the output monitor if the agent is passive
        if (m_cfg.output_agent_is_active == UVM_PASSIVE) begin
            mon_h = counter_output_monitor::type_id::create("mon_h", this);
        end
    endfunction : build_phase

endclass : counter_output_agent
