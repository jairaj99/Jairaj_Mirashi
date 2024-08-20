class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  env env_o;
  base_seq bseq;
  
  function new(string name="base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env_o=env::type_id::create("env_o",this);
    bseq=base_seq::type_id::create("bseq",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq.start(env_o.agt.seqr);
    #30;
    phase.drop_objection(this);
  endtask
  
  
function void end_of_elaboration_phase (uvm_phase phase);
uvm_top.print_topology ();
endfunction
  
endclass
    