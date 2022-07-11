class ahb_apb_env_config extends uvm_object;

`uvm_object_utils(ahb_apb_env_config)

//------------------------------------------
// Data Members
//------------------------------------------
// Whether env analysis components are used:
//bit has_functional_coverage = 0;
///bit has_wagent_functional_coverage = 0;
bit has_scoreboard=1;
bit has_functional_coverage=0;
 Whether the various agents are used:
bit has_ahbagent = 1;
bit has_apbagent = 1;
// Whether the virtual sequencer is used:
bit has_virtual_sequencer=1;

ahb_config ahb_cfg[];
apb_config apb_cfg[];
int no_of_ahbagents=1;
int no_of_apbagents=1;

//------------------------------------------
// Methods
//------------------------------------------
// Standard UVM Methods:
extern function new(string name = "ahb_apb_env_config");

endclass
//-----------------  constructor new method  -------------------//

function ahb_apb_env_config::new(string name = "ahb_apb_env_config");
  super.new(name);
endfunction
