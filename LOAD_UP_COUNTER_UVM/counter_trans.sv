class counter_trans extends uvm_sequence_item;
  `uvm_object_utils(counter_trans) // Register the class with UVM factory

  // Randomly generated signals for the transaction
  rand logic rst;       // Reset signal
  rand logic load;      // Load signal
  randc logic [3:0] data_in; // 4-bit data input
  logic [3:0] data_out; // 4-bit data output, not randomized

  // Static variable to keep track of the number of transactions
  static int no_of_xtn;

  // Constraints to control the values of the randomized signals
  constraint VALID_RST { rst dist {1 := 1, 0 := 15}; } // Reset signal with distribution
  constraint VALID_LOAD { load dist {1 := 1, 0 := 15}; } // Load signal with distribution
  constraint VALID_DATA { data_in inside {[0:15]}; } // Data input within the range [0, 15]

  // Constructor
  function new(string name = "counter_trans");
    super.new(name); // Call base class constructor
  endfunction : new

  // Function to compare this object with another UVM object
  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    counter_trans rhs_; // Cast the rhs object to counter_trans
    if (!$cast(rhs_, rhs)) begin
      `uvm_fatal("do_compare", "cast of the rhs object failed") // Report error if casting fails
      return 0; // Comparison failed
    end
    // Compare fields of this object with rhs_ and check if data_out matches
    return super.do_compare(rhs, comparer) && (data_out == rhs_.data_out);
  endfunction : do_compare

  // Function to print the contents of this object
  function void do_print(uvm_printer printer);
    super.do_print(printer); // Print base class fields
    printer.print_field("rst", rst, 1, UVM_DEC); // Print reset field
    printer.print_field("load", load, 1, UVM_DEC); // Print load field
    printer.print_field("data_in", data_in, 4, UVM_DEC); // Print data_in field
    printer.print_field("data_out", data_out, 4, UVM_DEC); // Print data_out field
  endfunction : do_print

  // Function called after randomization
  function void post_randomize();
    no_of_xtn++; // Increment the transaction count
    `uvm_info("randomized data", $sformatf("randomized transaction [%0d] is \n%s", no_of_xtn, this.sprint()), UVM_MEDIUM) // Print info about the randomized transaction
  endfunction : post_randomize
endclass
