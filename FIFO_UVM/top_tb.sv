import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "package.sv"


module tb_top;
  bit clock;
  bit reset;
  
  always #5 clock=~clock;
  
  initial
    begin
      clock=0;
      reset=1;
      #10 reset=0;
    end
  
  fifo_if vif(clock,reset);
  
  FIFO DUT (
    .data_out(vif.data_out), 
    .full(vif.full), 
    .empty(vif.empty), 
    .clock(vif.clock), 
    .reset(vif.reset), 
    .wn(vif.wn), 
    .rn(vif.rn), 
    .data_in(vif.data_in)
  );
  
  initial
    begin
      uvm_config_db #(virtual fifo_if)::set(uvm_root::get(),"*","vif",vif);
      $dumpvars;
  end
  
  initial
    begin
      run_test("base_test");
    end
endmodule

      
     
    