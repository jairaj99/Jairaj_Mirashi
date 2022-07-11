class ahb_monitor extends uvm_monitor;

`uvm_components_utils(ahb_monitor)

virtual ahb_if.AHB_MON_MP vif;

ahb_config ahb_cfg;
uvm_anylysis_port#(ahb_xtn) ahb;
ahb_xtn xtn;

extern function new(string name="ahb_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
function ahb_monitor::new(string name="ahb_monitor", uvm_component parent);
super.new(name, parent);
ahb=new("ahb",this);
endfunction

function ahb_monitor::build_phase(uvm_phase phase);
if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal("ahb_monitor","cannot get config data");
		$display("%p",ahb_cfg);
	super.build_phase(phase);
endfunction

function abh_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
	vif=ahb_cfg.vif;
endfunction