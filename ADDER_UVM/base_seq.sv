class base_seq extends uvm_sequence#(seq_item);
  seq_item req;              // Sequence item variable
  
  `uvm_object_utils(base_seq) // Macro for UVM object registration
  
  function new(string name = "base_seq");
    super.new(name);         // Call base class constructor
  endfunction

  task body();
    `uvm_info(get_type_name(), "Base seq: Inside Body", UVM_LOW); // Display message at low verbosity
    `uvm_do(req);           // Execute the sequence item req
  endtask
endclass
