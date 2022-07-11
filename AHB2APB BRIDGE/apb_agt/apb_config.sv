class apb_config extends uvm_object;

// UVM Factory Registration Macro
`uvm_object_utils(apb_config)

//------------------------------------------
// Data Members
//------------------------------------------

// Declare the mon_rcvd_xtn_cnt as static int and initialize it to zero  
//static int mon_rcvd_xtn_cnt = 0;

// Declare the drv_data_sent_cnt as static int and initialize it to zero 
//static int drv_data_sent_cnt = 0;

virtual apb_if vif;

uvm_active_passive_enum is_active;

//------------------------------------------
// Methods
//------------------------------------------

// Standard UVM Methods:
extern function new(string name = "apb_config");

endclass
function ahb_config::new(string name = "apb_config");
  super.new(name);
endfunction

