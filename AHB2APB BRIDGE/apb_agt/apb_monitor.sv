class apb_monitor extends uvm_monitor;

`uvm_components_utils(apb_monitor)

virtual apb_if.apb_MON_MP vif;

apb_config apb_cfg;
uvm_anylysis_port#(apb_xtn) apb;
apb_xtn xtn;

extern function new(string name="apb_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);

function apb_monitor::new(string name="apb_monitor", uvm_component parent);
super.new(name, parent);
apb=new("apb",this);
endfunction

function apb_monitor::build_phase(uvm_phase phase);
if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal("apb_monitor","cannot get config data");
		$display("%p",apb_cfg);
	super.build_phase(phase);
endfunction

function abh_monitor::connect_phase(uvm_phase phase);
super.connect_phase(phase);
	vif=apb_cfg.vif;
endfunction