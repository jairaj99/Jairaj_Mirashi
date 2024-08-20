class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(seq_item, scoreboard) item_collect_export;

  int expected_data_queue[$];
  
  // Declare the covergroup and the sequence item used for coverage
  seq_item cov_data_pkt;
  covergroup fifo_coverage;

    option.per_instance = 1; // Enable per-instance coverage

    // Coverage of data_in signal
    DATA_IN : coverpoint cov_data_pkt.data_in {
      bins MAX      = {[0:255]};
    }

    // Coverage of write enable signal (wn)
    WRITE_CMD : coverpoint cov_data_pkt.wn {
        bins write_dut = {0, 1};
    }
    
    // Coverage of Read enable signal (rn)
    READ_CMD : coverpoint cov_data_pkt.rn {
        bins write_dut = {0, 1};
    }

    // Coverage of empty signal (empty)
    EMPTY_CMD : coverpoint cov_data_pkt.empty {
        bins read_dut = {0, 1};
    }
    
    // Coverage of full signal (full)
    FULL_CMD : coverpoint cov_data_pkt.full {
        bins write_dut = {0, 1};
    }
    
    

    // Add cross-coverage if needed
    READxWRITE : cross WRITE_CMD, DATA_IN;

  endgroup : fifo_coverage

  function new(string name="scoreboard", uvm_component parent=null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);

    // Initialize the covergroup
    fifo_coverage = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  function void write(seq_item req);
    $display("-------------------------------------------");

    // Assign the transaction to the coverage packet
    cov_data_pkt = req;

    // Sample the covergroup with the current transaction
    fifo_coverage.sample();

    // Push the incoming data_in into the queue
    expected_data_queue.push_back(req.data_in);

    // Handle the latency, e.g., 2-cycle delay
    if (expected_data_queue.size() >= 2) begin
      int expected_data = expected_data_queue.pop_front();

      // Compare the received output with the expected value
      if (req.rn == 1'b1 && req.data_out == expected_data) begin
        `uvm_info(get_type_name(), $sformatf("MATCH : DATA_IN=%0d, DATA_OUT=%0d", expected_data, req.data_out), UVM_LOW);
      end else if (req.rn == 1'b1) begin
        `uvm_error(get_type_name(), $sformatf("NOT MATCH : Expected=%0d, Got=%0d", expected_data, req.data_out));
      end
    end
    
    $display("-------------------------------------------------");
    $display("Overall Coverage:                               %0.2f%%", $get_coverage());
    $display("Coverage of covergroup 'FIFO_coverage':         %0.2f%%", fifo_coverage.get_coverage());
    
    
    $display("Coverage of coverpoint 'DATA_IN' = %0f", fifo_coverage.DATA_IN.get_coverage());
        $display("Coverage of coverpoint 'WRITE_CMD' = %0f", fifo_coverage.WRITE_CMD.get_coverage());
        $display("Coverage of coverpoint 'READ_CMD' = %0f", fifo_coverage.READ_CMD.get_coverage());
    $display("Coverage of coverpoint 'EMPTY_CMD' = %0f", fifo_coverage.EMPTY_CMD.get_coverage());
    $display("Coverage of coverpoint 'FULL_CMD' = %0f", fifo_coverage.FULL_CMD.get_coverage());

    $display("-------------------------------------------------");

    $display("-------------------------------------------");
  endfunction
endclass
