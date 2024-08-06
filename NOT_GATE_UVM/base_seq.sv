// Define the base_seq class extending uvm_sequence with a parameterized type seq_item
class base_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(base_seq) // Macro to register the class with the UVM factory

  // Constructor
  function new(string name ="base_seq");
    super.new(name); // Call the parent class constructor
  endfunction
  
  // Task defining the sequence behavior
  task body();
    // Create an instance of the sequence item
    req = seq_item::type_id::create("req");
    
    // Start the sequence item and check for successful start
    start_item(req);
    
    // Randomize the sequence item and check for successful randomization
    assert(req.randomize());
    
    // Finish the sequence item, signaling completion
    finish_item(req);
  endtask
  
endclass
