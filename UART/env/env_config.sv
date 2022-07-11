class env_config extends uvm_object;

`uvm_object_utils(env_config)

bit has_functional_coverage = 0;
//bit has_scoreboard = 1;
bit has_uart_agent = 1;
bit has_virtual_sequencer = 1;

//byte i = 8'b1100_0110;

int no_of_uart_agents = 2;
uart_agent_config m_uart_agent_cfg[];

extern function new(string name = "env_config");

endclass

// Constuctor 
function env_config::new(string name = "env_config");
    super.new(name);
    
endfunction
