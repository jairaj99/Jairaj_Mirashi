class scoreboard extends uvm_scoreboard;
  uvm_analysis_imp #(seq_item, scoreboard) item_collect_export; // Analysis port for receiving sequence items
  seq_item item_q[$];         // Queue to store received sequence items
  `uvm_component_utils(scoreboard) // Macro for UVM component utilities
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);   // Call base class constructor
    item_collect_export = new("item_collect_export", this); // Initialize analysis port
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);  // Call base class build_phase method
  endfunction
  
  function void write(seq_item req);
    item_q.push_back(req);    // Store received sequence item in queue
  endfunction
  
  task run_phase(uvm_phase phase);
    seq_item sb_item;
    forever begin
      wait(item_q.size > 0);  // Wait until there are items in the queue
      
      if (item_q.size > 0) begin
        sb_item = item_q.pop_front(); // Retrieve front item from the queue
        $display("----------------------------------------------------------------------------------------------------------");
        if (sb_item.ip1 + sb_item.ip2 == sb_item.out) begin
          `uvm_info(get_type_name, $sformatf("Matched: ip1 = %0d, ip2 = %0d, out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out), UVM_LOW);
        end
        else begin
          `uvm_error(get_name, $sformatf("NOT matched: ip1 = %0d, ip2 = %0d, out = %0d", sb_item.ip1, sb_item.ip2, sb_item.out));
        end
        $display("----------------------------------------------------------------------------------------------------------");
      end
    end
  endtask
endclass
