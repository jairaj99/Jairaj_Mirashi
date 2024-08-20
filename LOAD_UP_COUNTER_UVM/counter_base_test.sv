class counter_base_test extends uvm_test;
    `uvm_component_utils(counter_base_test) // Register the test class with the UVM factory

    // Configuration and environment handles
    counter_env_config m_cfg; // Environment configuration object
    counter_env counter_env_h; // Handle to the environment
    counter_seq counter_seq_h; // Handle to the sequence
  
    // Constructor
    function new(string name = "counter_base_test", uvm_component parent = null);
        super.new(name, parent); // Call the base class constructor
    endfunction : new

    // Build phase to set up the test environment
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        // Create the environment configuration object
        m_cfg = counter_env_config::type_id::create("m_cfg");

        // Retrieve the virtual interface from the UVM config database
        if (!uvm_config_db#(virtual counter_inf)::get(this, "", "vif", m_cfg.vif)) begin
            `uvm_fatal(get_type_name(), "Cannot get interface vif from uvm_config_db");
        end

        // Set the environment configuration in the UVM config database
        uvm_config_db#(counter_env_config)::set(this, "*", "counter_env_config", m_cfg);
      
        // Configure the environment settings
        m_cfg.has_input_agent = 1;
        m_cfg.has_output_agent = 1;
        m_cfg.has_scoreboard = 1;
        m_cfg.output_agent_is_active = UVM_PASSIVE;
        m_cfg.input_agent_is_active = UVM_ACTIVE;

        // Create the environment
        counter_env_h = counter_env::type_id::create("counter_env_h", this);
    endfunction : build_phase
    
    // Run phase to execute the test
    task run_phase(uvm_phase phase);
        phase.raise_objection(this); // Raise an objection to prevent the phase from ending

        // Check and validate the sequencer handle
        if (counter_env_h.input_agent_h.seqrh == null) begin
            `uvm_fatal(get_type_name(), "Sequencer handle is null");
        end

        // Create the sequence object
        counter_seq_h = counter_seq::type_id::create("counter_seq_h");

        // Ensure the sequence is started with a valid sequencer handle
        counter_seq_h.start(counter_env_h.input_agent_h.seqrh);

        // Wait for 30 time units
        #30;
        phase.drop_objection(this); // Drop the objection to allow the phase to end
    endtask : run_phase
endclass : counter_base_test
