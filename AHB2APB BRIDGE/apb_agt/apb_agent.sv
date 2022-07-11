class apb_agent extends uvm_agent;
`uvm_component_utils(apb_agent)
//factory reg
apb_monitor mon;
apb_driver drv;
apb_sequencer seq;
apb_config apb_cfg;
 extern function new(string name = "apb_agent", uvm_component parent = null);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass 
//-----------------  constructor new method  -------------------//

       function apb_agent::new(string name = "apb_agent", 
                               uvm_component parent = null);
         super.new(name, parent);
       endfunction
     
  
//-----------------  build() phase method  -------------------//
         // Call parent build phase
         // Create ram_wr_monitor instance
         // If is_active=UVM_ACTIVE, create ram_wr_driver and ram_wr_sequencer instances
	function void apb_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
                // get the config object using uvm_config_db 
	 if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db. Have you set() it?")  	
	                mon=apb_monitor::type_id::create("mon",this);	
		if(apb_cfg.is_active==UVM_ACTIVE)
		begin
		drv=apb_driver::type_id::create("drv",this);
		seq=apb_sequencer::type_id::create("seq",this);
		end
	endfunction

      //code for connect phase
function void apb_agent::connect_phase(uvm_phase phase);
super.connect_phase(phase);
	if(apb_cfg.is_active==UVM_ACTIVE)
		begin
		drv.seq_item_port.connect(seq.seq_item_export);
  		end
	endfunction