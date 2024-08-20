class counter_input_monitor extends uvm_monitor;
  `uvm_component_utils(counter_input_monitor) // Register the component with the UVM factory

  virtual counter_inf.INPUT_MON mon_if; // Virtual interface for input monitoring
  counter_trans drv2mon_pkt; // Transaction object to capture monitored data
  counter_env_config m_cfg; // Environment configuration object

  uvm_analysis_port#(counter_trans) monitor_port; // Analysis port for exporting captured transactions

  // Constructor
  function new(string name = "counter_input_monitor", uvm_component parent = null);
    super.new(name, parent); // Call the base class constructor
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the base class build_phase

    // Retrieve the environment configuration from the UVM config database
    if (!uvm_config_db#(counter_env_config)::get(this, "", "counter_env_config", m_cfg)) begin
      `uvm_fatal(get_type_name(), "cannot get() m_cfg from uvm_config_db");
    end

    // Initialize the analysis port
    monitor_port = new("monitor_port", this); 
  endfunction : build_phase

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connect the virtual interface for input monitoring
    mon_if = m_cfg.vif;
  endfunction : connect_phase

  // Run phase
  task run_phase(uvm_phase phase);
    // Synchronize with the monitor's clocking block
    @(mon_if.input_mon_cb);
    forever begin
      // Continuously monitor the input
      monitor();
    end
  endtask : run_phase

  // Task to monitor and capture transactions
  task monitor(); 
    begin
      // Synchronize with the monitor's clocking block
      @(mon_if.input_mon_cb);
      
      // Create a new transaction object
      drv2mon_pkt = counter_trans::type_id::create("drv2mon_pkt");
      
      // Capture the monitored data into the transaction object
      drv2mon_pkt.load = mon_if.input_mon_cb.load; 
      drv2mon_pkt.rst = mon_if.input_mon_cb.rst;
      drv2mon_pkt.data_in = mon_if.input_mon_cb.data_in;
      
      // Log the captured data
      `uvm_info(get_type_name(), $sformatf("DATA_IN = %0d", drv2mon_pkt.data_in), UVM_MEDIUM);
      `uvm_info(get_type_name(), $sformatf("Input monitor has captured the following transaction:\n%s", drv2mon_pkt.sprint()), UVM_MEDIUM);
      
      // Write the transaction data to the analysis port
      monitor_port.write(drv2mon_pkt);
    end
  endtask : monitor

endclass
