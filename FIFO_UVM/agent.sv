class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  sequencer seqr;
  driver drv;
  monitor mon;
  
  function new(string name="agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(get_is_active==UVM_ACTIVE)
      begin
        drv=driver::type_id::create("drv",this);
        seqr=sequencer::type_id::create("seqr",this);
      end
    
    mon=monitor::type_id::create("mon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if(get_is_active == UVM_ACTIVE)
      begin
    drv.seq_item_port.connect(seqr.seq_item_export);
      end
  endfunction
  
endclass