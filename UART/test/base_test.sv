class base_test extends uvm_test;

env_config e_cfg;
env env_h;
uart_agent_config u_agt_cfg[];

int has_uart_agent = 1;
int no_of_uart_agents = 2;
bit has_scoreboard = 1;
bit has_virtual_sequencer = 1;

`uvm_component_utils(base_test)

vseq1 half_duplex;
vseq2 full_duplex;
vseq3 loop_back;
vseq4 parity;
vseq5 framing;
vseq6 over_run;
vseq7 break_interrupt;
vseq8 time_out;
vseq9 thr_empty;

extern function new(string name = "base_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void config_uart();

endclass

function base_test::new(string name = "base_test",uvm_component parent);
  super.new(name,parent);

endfunction 

function void base_test::config_uart();
  if(has_uart_agent)
    begin
       u_agt_cfg=new[no_of_uart_agents];
       foreach(u_agt_cfg[i])
         begin
             u_agt_cfg[i] = uart_agent_config::type_id::create($sformatf("u_agt_cfg[%0d]",i));
         
       u_agt_cfg[i].is_active=UVM_ACTIVE;
       if(!uvm_config_db #(virtual uart_if)::get(this,"","uart_if",u_agt_cfg[i].vif))
            `uvm_fatal("BASE_TEST","cannot get interface from uvm_config_db, Have you set it?")
        e_cfg.m_uart_agent_cfg[i]=u_agt_cfg[i];
         end
    end      

  e_cfg.no_of_uart_agents=no_of_uart_agents;
  e_cfg.has_uart_agent=has_uart_agent;
  e_cfg.has_scoreboard=has_scoreboard;
  e_cfg.has_virtual_sequencer=has_virtual_sequencer;

endfunction


function void base_test::build_phase(uvm_phase phase);
  e_cfg = env_config::type_id::create("e_cfg");

  if(has_uart_agent)
    e_cfg.m_uart_agent_cfg = new[no_of_uart_agents];

    config_uart();
    
  uvm_config_db#(env_config)::set(this,"*","env_config",e_cfg);
  super.build_phase(phase);

  env_h=env::type_id::create("env_h",this);    

endfunction

/////////////////////////////////HALF_DUPLEX////////////////////////
class half_duplex_test extends base_test;

  `uvm_component_utils(half_duplex_test)


  extern function new(string name = "half_duplex_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function half_duplex_test::new(string name = "half_duplex_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void half_duplex_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task half_duplex_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    half_duplex=vseq1::type_id::create("half_duplex");

    half_duplex.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////FULL_DUPLEX////////////////////////
class full_duplex_test extends base_test;

  `uvm_component_utils(full_duplex_test)


  extern function new(string name = "full_duplex_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function full_duplex_test::new(string name = "full_duplex_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void full_duplex_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task full_duplex_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    full_duplex=vseq2::type_id::create("full_duplex");

    full_duplex.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////LOOP_BACK////////////////////////
class loop_back_test extends base_test;

  `uvm_component_utils(loop_back_test)


  extern function new(string name = "loop_back_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function loop_back_test::new(string name = "loop_back_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void loop_back_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task loop_back_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    loop_back=vseq3::type_id::create("loop_back");

    loop_back.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////PARITY////////////////////////
class parity_test extends base_test;

  `uvm_component_utils(parity_test)


  extern function new(string name = "parity_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function parity_test::new(string name = "parity_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void parity_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task parity_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    parity=vseq4::type_id::create("parity");

    parity.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////framing////////////////////////
class framing_test extends base_test;

  `uvm_component_utils(framing_test)


  extern function new(string name = "framing_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function framing_test::new(string name = "framing_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void framing_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task framing_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    framing=vseq5::type_id::create("framing");

    framing.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////OVER_RUN////////////////////////
class over_run_test extends base_test;

  `uvm_component_utils(over_run_test)


  extern function new(string name = "over_run_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function over_run_test::new(string name = "over_run_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void over_run_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task over_run_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    over_run=vseq6::type_id::create("over_run");

    over_run.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask



/////////////////////////////////BREAK_INTERRUPT////////////////////////
class break_interrupt_test extends base_test;

  `uvm_component_utils(break_interrupt_test)


  extern function new(string name = "break_interrupt_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function break_interrupt_test::new(string name = "break_interrupt_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void break_interrupt_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task break_interrupt_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    break_interrupt=vseq7::type_id::create("break_interrupt");

    break_interrupt.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////TIME_OUT////////////////////////
class time_out_test extends base_test;

  `uvm_component_utils(time_out_test)


  extern function new(string name = "time_out_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function time_out_test::new(string name = "time_out_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void time_out_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task time_out_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    time_out=vseq8::type_id::create("time_out");

    time_out.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


/////////////////////////////////THR_EMPTY////////////////////////
class thr_empty_test extends base_test;

  `uvm_component_utils(thr_empty_test)


  extern function new(string name = "thr_empty_test",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass

function thr_empty_test::new(string name = "thr_empty_test",uvm_component parent);
  super.new(name,parent);
  
endfunction

function void thr_empty_test::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
endfunction

task thr_empty_test::run_phase(uvm_phase phase);
    
    phase.raise_objection(this);

    thr_empty=vseq9::type_id::create("thr_empty");

    thr_empty.start(env_h.v_seqrh);

    phase.drop_objection(this);

endtask


