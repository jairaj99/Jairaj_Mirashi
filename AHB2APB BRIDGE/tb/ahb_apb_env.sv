class ahb_apb_env extends uvm_env;
//factory reg
`uvm_component_utils(ahb_apb_env)
//handle declarations
ahb_agt_top ahb_top;
apb_agt_top apb_top;
ahb_apb_env_config m_cfg;
scoreboard sb;
 virtual_sequencer v_sequencer;
 
//uvm_methods
extern function new(string name = "ahb_apb_env", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass
// code for new
function ahb_apb_env::new(string name = "ahb_apb_env", uvm_component parent);
super.new(name,parent);
endfunction

//code for build_phase
function void ahb_apb_env::build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(ahb_apb_env_config)::get(this,"","ahb_apb_env_config",m_cfg))
`uvm_fatal(get_type_name(),"error in getting interface")
 if(m_cfg.has_ahbagent) 
  ahbagt_top=ahb_agt_top::type_id::create("ahbagt_top" ,this);

  if(m_cfg.has_apbagent) 
apbagt_top=apb_agt_top::type_id::create("apbagt_top",this);

if(m_cfg.has_scoreboard)
sb=scoreboard::type_id::create("scoreboard",this);
//sb.rd_fifo=new[m_cfg.no_of_agents];

if(m_cfg.has_virtual_sequencer)
v_sequencer=virtual_sequencer::type_id::create("virtual_sequencer",this);
endfunction

//code for connect phase
function void ahb_apb_env::connect_phase(uvm_phase phase);
super.connect_phase(phase);
//uvm_top.print_topology;