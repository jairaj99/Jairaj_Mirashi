class seq_item extends uvm_sequence_item;
  rand bit [7:0] ip1, ip2;  // Randomized 8-bit input variables
  bit [8:0] out;            // 9-bit output variable
  
  function new(string name = "seq_item");
    super.new(name);        // Call base class constructor
  endfunction
  
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(ip1,UVM_ALL_ON)  // Register ip1 for UVM field automation
    `uvm_field_int(ip2,UVM_ALL_ON)  // Register ip2 for UVM field automation
  `uvm_object_utils_end
  
  constraint ip_c {ip1 < 100; ip2 < 100;}  // Constraint: ip1 and ip2 must be less than 100
endclass
