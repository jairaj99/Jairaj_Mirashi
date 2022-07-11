class uart_agent_config extends uvm_object;

`uvm_object_utils(uart_agent_config)

virtual uart_if vif;

uvm_active_passive_enum is_active = UVM_ACTIVE;

static int mon_rcvd_xtn_cnt = 0;
static int drv_data_sent_cnt = 0;

extern function new(string name = "uart_agent_config");

endclass 


// Constructor 
function uart_agent_config::new(string name = "uart_agent_config");
  super.new(name);

endfunction

