class uart_agent_top extends uvm_env;
 
`uvm_component_utils(uart_agent_top)

	uart_agent u_agt;
	env_config e_cfg;


extern function new(string name="uart_agent_top",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

//Constuctor
function uart_agent_top::new(string name="uart_agent_top",uvm_component parent);
  super.new(name,parent);

endfunction


//Build_phase 
function  void uart_agent_top::build_phase(uvm_phase phase);
  super.build_phase(phase);

  u_agt = uart_agent::type_id::create("u_agt",this);
endfunction

task uart_agent_top::run_phase(uvm_phase phase);
            uvm_top.print_topology;
endtask






