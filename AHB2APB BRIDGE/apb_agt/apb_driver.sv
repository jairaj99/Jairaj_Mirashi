class apb_driver extends uvm_driver#(ahb_xtn);
//factory reg
`uvm_component_utils(apb_driver)
//handle for interface
virtual apb_if.PDR_MP vif;
//declar ehandle for rd_config class
apb_config pcfg;
//uvm methods
	
	extern function new(string name ="apb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	extern task send_to_dut(apb_xtn xtn);
endclass

//CODE FOR NEW	
function apb_driver::new( string name="apb_driver",uvm_component parent);
super.new(name,parent);
endfunction

//code for build
function void apb_driver::build_phase(uvm_phase phase);
super.build_phase(phase);
//getiing config
	  if(!uvm_config_db #(apb_config)::get(this,"","apb_config",pcfg))
		`uvm_fatal("CONFIG","cannot get() hcfg from uvm_config_db. Have you set() it?")
$display("%p",pcfg);
  endfunction
//code for coneect phase
function void apb_driver::connect_phase(uvm_phase phase);
vif=pcfg.vif;
endfunction