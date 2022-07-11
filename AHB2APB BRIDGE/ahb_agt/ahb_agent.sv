class ahb_agent extends uvm_agent;
`uvm_component_utils(ahb_agent)
//factory reg
ahb_monitor mon;
ahb_driver drv;
ahb_sequencer seq;
ahb_config ahb_cfg;
 extern function new(string name = "ahb_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//

       function ahb_agent::new(string name = "ahb_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
         // Call parent build phase
         // Create ram_wr_monitor instance
         // If is_active=UVM_ACTIVE, create ram_wr_driver and ram_wr_sequencer instances
	function void ahb_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
                // get the config object using uvm_config_db 
	 if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")  	
	                mon=ahb_monitor::type_id::create("mon",this);	
		if(ahb_cfg.is_active==UVM_ACTIVE)
		begin
		drv=ahb_driver::type_id::create("drv",this);
		seq=ahb_sequencer::type_id::create("seq",this);
		end
	endfunction

      //code for connect phase
function void ahb_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);
	if(ahb_cfg.is_active==UVM_ACTIVE)
		begin
		drv.seq_item_port.connect(seq.seq_item_export);
  		end
	endfunction