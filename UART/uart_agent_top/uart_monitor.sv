class uart_monitor extends uvm_monitor;

`uvm_component_utils(uart_monitor)

uart_xtn xtn;
uart_agent_config u_agt_cfg;
uvm_analysis_port #(uart_xtn) mon_port;

virtual uart_if.UART_MON vif;

extern function new(string name = "uart_monitor",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);


endclass

function uart_monitor::new(string name = "uart_monitor",uvm_component parent);
    super.new(name,parent);
    mon_port=new("mon_port",this);

endfunction

function void uart_monitor::build_phase(uvm_phase phase);
    if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_agent_config",u_agt_cfg))
    `uvm_fatal("UART_MONITOR","cannot get u_agt_cfg from uvm_config_db. Have you set it")

    super.build_phase(phase);
    
endfunction

function void uart_monitor::connect_phase(uvm_phase phase);
    vif=u_agt_cfg.vif;
    
endfunction

task uart_monitor::run_phase(uvm_phase phase);
xtn=uart_xtn::type_id::create("xtn");

forever 
    begin
    collect_data();
    end
endtask


task uart_monitor::collect_data();
    @(vif.wr_mon_cb);
    wait(vif.wr_mon_cb.wb_ack_o);
   // xtn.wb_rst_i=vif.wr_mon_cb.wb_rst_i;
    xtn.wb_addr_i=vif.wr_mon_cb.wb_addr_i;
    xtn.wb_dat_i=vif.wr_mon_cb.wb_dat_i;
    xtn.wb_we_i=vif.wr_mon_cb.wb_we_i;
    xtb.wb_stb_i=vif.wr_mon_cb.wb_stb_i;
    xtn.wb_cyc_i=vif.wr_mon_cb.wb_cyc_i;

    if(xtn.wb_addr_i==0 && xtn.wb_we_i==0 && xtn.lcr[7]==0)
    xtn.rb.push_back(vif.wr_mon_cb.wb_dat_o);

    if(xtn.wb_addr_i==0 && xtn.wb_we_i==1 && xtn.lcr[7]==0)
    xtn.thr.push_back(vif.wr_mon_cb.wb_dat_i);

    if(xtn.wb_addr_i==0 && xtn.wb_we_i==1 && xtn.lcr[7]==1)
    xtn.dlb1=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==0 && xtn.wb_we_i==1 && xtn.lcr[7]==1)
    xtn.dlb2=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==1 && xtn.wb_we_i==1)
    xtn.ier=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==2 && xtn.wb_we_i==0)
    xtn.iir=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==2 && xtn.wb_we_i==1)
    xtn.fcr=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==3 && xtn.wb_we_i==1)
    xtn.lcr=vif.wr_mon_cb.wb_dat_i;

    if(xtn.wb_addr_i==4 && xtn.wb_we_i==1)
    xtn.mcr=vif.wr_mon_cb.wb_dat_i;
    
    if(xtn.wb_addr_i==5 && xtn.wb_we_i==0)
    xtn.lsr=vif.wr_mon_cb.wb_dat_i;

    //increment 
    u_agt_cfg.mon_rcvd_xtn_cnt++;

endtask

function void uart_monitor::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: uart Monitor Collected %0d Transactions", u_agt_cfg.mon_rcvd_xtn_cnt), UVM_LOW)
    
endfunction