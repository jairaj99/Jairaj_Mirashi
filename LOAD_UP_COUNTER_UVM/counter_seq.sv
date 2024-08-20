class counter_seq extends uvm_sequence#(counter_trans);

  `uvm_object_utils(counter_seq) // Register the class with UVM factory

  // Variable to keep track of the transaction number
  int xtn_num = 1;

  // Constructor
  function new(string name = "counter_seq");
    super.new(name); // Call base class constructor
  endfunction : new

  // Main task that executes the sequence
  task body();
    repeat (30) begin
      // Create a new instance of counter_trans
      req = counter_trans::type_id::create("req");
      // Start the sequence item
      start_item(req);

      // If it is the first transaction, force 'rst' to 1
      if (xtn_num == 1) begin
        assert(req.randomize() with {rst == 1;}); // Randomize transaction with 'rst' set to 1
        xtn_num++; // Increment transaction number
      end else begin
        // Randomize the rest of the transactions
        assert(req.randomize()); // Randomize transaction without constraints
      end
      
      // Finish the sequence item
      finish_item(req);
    end
  endtask : body
endclass
