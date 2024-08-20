class counter_input_driver extends uvm_driver#(counter_trans);
  `uvm_component_utils(counter_input_driver) // Register the component with the UVM factory

  virtual counter_inf.DRIVER drv_inf; // Virtual interface for driver operations
  counter_trans data2duv_pkt; // Transaction object
  counter_env_config m_cfg; // Environment configuration object

  // Constructor
  function new(string name = "counter_input_driver", uvm_component parent = null);
    super.new(name, parent); // Call the base class constructor
  endfunction : new

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the base class build_phase

    // Retrieve the environment configuration from the UVM config database
    if (!uvm_config_db#(counter_env_config)::get(this, "", "counter_env_config", m_cfg)) begin
      `uvm_fatal("CONFIG", "Cannot get() m_cfg from uvm_config_db. Have you set() it?");
    end
  endfunction : build_phase

  // Connect phase
  function void connect_phase(uvm_phase phase);
    // Connect the virtual interface to the driver
    drv_inf = m_cfg.vif;
  endfunction : connect_phase

  // Run phase
  task run_phase(uvm_phase phase);
    forever begin
      // Get the next item from the sequence
      seq_item_port.get_next_item(req);
      
      // Send the item to the DUT (Device Under Test)
      send_to_dut(req);
      
      // Indicate that the item has been processed
      seq_item_port.item_done();
    end
  endtask : run_phase

  // Task to send transaction data to DUT
  virtual task send_to_dut(counter_trans data2duv_pkt);
    @(drv_inf.driver_cb); // Synchronize with the driver's clocking block
    // Assign transaction data to the DUT
    drv_inf.driver_cb.data_in <= data2duv_pkt.data_in;
    `uvm_info(get_type_name(), $sformatf("DATA_IN = %0d", data2duv_pkt.data_in), UVM_MEDIUM);
    drv_inf.driver_cb.rst <= data2duv_pkt.rst;
    drv_inf.driver_cb.load <= data2duv_pkt.load;
  endtask : send_to_dut

endclass
