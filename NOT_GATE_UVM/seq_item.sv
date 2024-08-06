// Define the seq_item class extending uvm_sequence_item
class seq_item extends uvm_sequence_item;
  
  // Randomizable fields
  rand bit in;  // Input value to be randomized
  bit out;      // Output value to be used in the sequence item

  // Constructor
  function new(string name = "seq_item");
    super.new(name); // Call the parent class constructor with the given name
  endfunction
  
  // UVM object utilities for sequence item
  `uvm_object_utils_begin(seq_item)
    // Register the fields for automatic reporting and recording
    `uvm_field_int(in, UVM_ALL_ON) // Register the 'in' field with full access for reporting
    `uvm_field_int(out, UVM_ALL_ON) // Register the 'out' field with full access for reporting
  `uvm_object_utils_end
  
endclass
