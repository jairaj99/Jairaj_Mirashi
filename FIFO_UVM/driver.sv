class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)
  
  // Virtual interface to connect to the FIFO
  virtual fifo_if vif;
  
  function new(string name="driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Virtual interface not set on top level");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    
    forever begin
      seq_item req;
      seq_item_port.get_next_item(req);
      
      if (req.wn == 1)
        main_write(req.data_in);
      else if (req.rn == 1)
        main_read();
      
      seq_item_port.item_done();
    end
  endtask
  
  virtual task main_write(input [7:0] din);
    @(posedge vif.clock); // Ensure you have the correct clock signal
    vif.wn <= 1'b1;
    vif.data_in <= din;
    
    `uvm_info("DRIVER", $psprintf("DRIVER data: \nwn= %0d \nDATA_IN= %0d", vif.wn, vif.data_in), UVM_LOW);
    
    // Wait for the FIFO to process the data
    @(posedge vif.clock); // Ensure the signal is properly synchronized with the clock
    vif.wn <= 1'b0;
  endtask

  virtual task main_read();
    @(posedge vif.clock); // Ensure you have the correct clock signal
    vif.rn <= 1'b1;
    
    // Wait for the read operation to complete
    @(posedge vif.clock); // Ensure the signal is properly synchronized with the clock
    
    // Log the output data after it has been read
    `uvm_info("DRIVER", $psprintf("DRIVER data: \nrn= %0d \nDATA_OUT= %0d", vif.rn, vif.data_out), UVM_LOW);
    
    vif.rn <= 1'b0;
  endtask

endclass
