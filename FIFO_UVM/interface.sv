interface fifo_if(input logic clock,reset);
  logic wn;
  logic rn;
  logic[7:0] data_in;
  logic[7:0] data_out;
  logic empty;
  logic full;
  
  clocking driver_cb@(posedge clock);
    default input #1 output #1;

    output wn;
    output rn;
    output data_in;
    input full;
    input empty;
    input data_out;
  endclocking
  
  clocking monitor_cb@(posedge clock);
    default input #1 output #1;
    
    input wn;
    input rn;
    input data_in;
    input full;
    input empty;
    input data_out;
  endclocking
  
  modport DRIVER(clocking driver_cb, input clock, reset);
    modport MONITOR(clocking monitor_cb, input clock, reset);
    
endinterface