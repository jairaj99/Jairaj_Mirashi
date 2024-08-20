module FIFO (
    output reg [7:0] data_out,
    output full, empty,
    input [7:0] data_in,
    input clock, reset, wn, rn
);
    reg [2:0] wptr, rptr;
    reg [7:0] memory [7:0];
    
    // Initialize FIFO memory and pointers
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset memory and pointers
            integer i;
            for (i = 0; i < 8; i = i + 1)
                memory[i] <= 0;
            data_out <= 0; 
            wptr <= 0; 
            rptr <= 0;
        end
        else begin
            // Write operation
            if (wn && !full) begin
                memory[wptr] <= data_in;
                wptr <= wptr + 1;
            end
            
            // Read operation
            if (rn && !empty) begin
                data_out <= memory[rptr];
                rptr <= rptr + 1;
            end
        end
    end
    
    // FIFO full condition
   // assign full = ((wptr[2:1] == rptr[2:1]) && (wptr[0] != rptr[0]));
 // assign full= (wptr==15 && !rn && wn);
  assign full = ((wptr+1'b1) == rptr);
    // FIFO empty condition
    assign empty = (wptr == rptr);

endmodule




//Testbench
/*module tb;
  reg clock;
  reg reset, wn, rn;
  reg [7:0] data_in;
  wire [7:0] data_out;
  wire full, empty;

  // Clock generation
  always #5 clock = ~clock;

  // Initialize signals
  initial begin
    clock = 0;
    reset = 1;
    wn = 0;
    rn = 0;
    data_in = 8'h00;

    // Release reset after some time
    #15 reset = 0;
  end

  // Instantiate the FIFO
  FIFO dut (
    .data_out(data_out), 
    .full(full), 
    .empty(empty), 
    .clock(clock), 
    .reset(reset), 
    .wn(wn), 
    .rn(rn), 
    .data_in(data_in)
  );

  // Test sequence
  initial begin
    // Wait for reset de-assertion
    @(negedge reset);

    // Write some data to the FIFO
    @(posedge clock);
    wn = 1;
    for (int i = 0; i < 10; i++) begin
      @(posedge clock); // Wait for clock edge before each write
      if (!full) begin
        data_in = i;
        $display("DATA_IN = %0d written to FIFO", data_in);
      end else begin
        $display("FIFO is full. Cannot write DATA_IN = %0d", i);
      end
    end
    wn = 0;

    // Read the data from the FIFO
    @(posedge clock);
    rn = 1;
    for (int i = 0; i < 8; i++) begin
      @(posedge clock); // Wait for clock edge before each read
      if (!empty) begin
        $display("DATA_OUT = %0d read from FIFO", data_out);
      end else begin
        $display("FIFO is empty. Cannot read data");
      end
    end
    rn = 0;

    #500 $finish; // End simulation after some delay
  end

  // Monitor data and output values
  initial begin
    $monitor("Time: %0t | DATA_IN = %0d | DATA_OUT = %0d | full = %b | empty = %b", 
             $time, data_in, data_out, full, empty);
  end

  // Dump waveform data for analysis
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
*/