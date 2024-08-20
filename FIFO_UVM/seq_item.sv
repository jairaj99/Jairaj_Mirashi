class seq_item extends uvm_sequence_item;
 
  rand logic [7:0] data_in;
  rand bit  wn;
  rand bit  rn;
  bit empty;
  bit full;
  bit reset;
  logic [7:0] data_out;
  
  function new(string name="seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(seq_item)
  `uvm_field_int(data_in,UVM_ALL_ON)
  `uvm_field_int(wn,UVM_ALL_ON)
  `uvm_field_int(rn,UVM_ALL_ON)
  `uvm_field_int(full,UVM_ALL_ON)
  `uvm_field_int(data_out,UVM_ALL_ON)
  `uvm_object_utils_end
  
  constraint C{rn != wn;};
  constraint D{ data_in inside {[0:50]};};
  
  function string convert2string();
    return $psprintf("\n wn= %0d \n rn=%0d \n FULL= %0d \n EMPTY=%0d \n DATA_IN= %0d", wn,rn,full,empty,data_in);
endfunction
  
endclass