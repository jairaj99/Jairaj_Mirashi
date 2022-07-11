class env extends uvm_env;

`uvm_component_utils(env);

env_config e_cfg;
virtual_sequencer v_seqrh;
uart_agent_top u_ag_t[];
//scoreboard sb[];
uart_agent_config u_agt_cfg;

extern function new(string name = "env",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

endclass

// Constuctor
function env::new(string name = "env",uvm_component parent);
    super.new(name,parent);
    
endfunction 

// Build_phase
function void env::build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
        `uvm_fatal("ENV","cannot get e_cfg from uvm_config_db. Have you set it?")

    if(e_cfg.has_uart_agent)
		begin
			u_ag_t = new[e_cfg.no_of_uart_agents];
			foreach(u_ag_t[i])
				begin
					uvm_config_db #(uart_agent_config)::set(this,$sformatf("u_ag_t[%0d]*",i), "uart_agent_config", e_cfg.m_uart_agent_cfg[i]);
					u_ag_t[i] = uart_agent_top::type_id::create($sformatf("u_ag_t[%0d]",i),this);
				end
		end
    

    if(e_cfg.has_virtual_sequencer)
        v_seqrh = virtual_sequencer::type_id::create("v_seqrh",this);
    
	super.build_phase(phase);
	
 /*  if(e_cfg.has_scoreboard)
		begin
			sb = new[e_cfg.no_of_uart_agents];
			foreach(sb[i])
				sb[i] = scoreboard::type_id::create($sformatf("sb[%0d]",i),this);
		end
       
    */
endfunction

// Connect_phase
function void env::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	begin
		if(e_cfg.has_virtual_sequencer)
		begin
			if(e_cfg.has_uart_agent)
			begin
				foreach(u_ag_t[i])
					v_seqrh.u_seqrh[i] = u_ag_t[i].u_agt.u_seqrh;
			end
		end
    
/*		if(e_cfg.has_scoreboard)
		begin
			foreach(u_ag_t[i])
					u_ag_t[i].u_agt.u_monh.mon_port.connect(sb[i].fifo_uarth[i].analysis_export);
		end
		*/
	end 
endfunction

