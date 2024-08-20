class base_seq extends uvm_sequence#(seq_item);
  `uvm_object_utils(base_seq)
  
  function new(string name="base_seq");
    super.new(name);
  endfunction
  
   virtual task body();
    `uvm_info(get_type_name(), $sformatf("******** Generate 16 Write REQs ********"), UVM_LOW)
    repeat(16) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {wn == 1;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 16 Read REQs ********"), UVM_LOW)
    repeat(16) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {rn == 1;});
      finish_item(req);
    end
    `uvm_info(get_type_name(), $sformatf("******** Generate 20 Random REQs ********"), UVM_LOW)
    repeat(20) begin
      req = seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask
  
  
endclass