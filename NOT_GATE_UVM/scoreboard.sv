// Define the scoreboard class extending uvm_scoreboard
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard) // Macro to register the class with the UVM factory
  
  // Analysis import port to receive monitored sequence items
  uvm_analysis_imp #(seq_item, scoreboard) item_collect_export;

  // Constructor
  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent); // Call the parent class constructor with the given name and parent
    item_collect_export = new("item_collect_export", this); // Create a new analysis import port for receiving data
  endfunction
  
  // Build phase of the scoreboard
  function void build_phase(uvm_phase phase);
    super.build_phase(phase); // Call the parent class build_phase method
  endfunction
  
  // Method to process and check received sequence items
  function void write(seq_item req);
    $display("-------------------------------------------");
    
    // Compare the received output with the expected value
    if (req.out == ~req.in) begin
      // Log a match if output is the bitwise negation of input
      `uvm_info(get_type_name(), $sformatf("MATCH IN=%0d, OUT=%0d", req.in, req.out), UVM_LOW);
    end else begin
      // Log a mismatch if the comparison fails
      `uvm_info(get_type_name(), $sformatf("NOT MATCH IN=%0d, OUT=%0d", req.in, req.out), UVM_LOW);
    end
    
    $display("-------------------------------------------");
  endfunction
  
endclass
