class uart_driver extends uvm_driver#(uart_xtn);

`uvm_component_utils(uart_driver)

virtual uart_if.UART_DRV vif;
uart_agent_config u_agt_cfg;

extern function new(string name="uart_driver",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive(uart_xtn xtn);
extern function void report_phase(uvm_phase phase);

endclass 

// Constuctor
function uart_driver::new(string name="uart_driver",uvm_component parent);
    super.new(name,parent);
endfunction 

// Build_phase 
function void uart_driver::build_phase(uvm_phase phase);
    if(!uvm_config_db #(uart_agent_config)::get(this,"","uart_agent_config",u_agt_cfg))
        `uvm_fatal("agent_config","cannot get u_agt_cfg from uvm_config_db. Have you set it?")

    super.build_phase(phase);
endfunction

// Connect phase 
function void uart_driver::connect_phase(uvm_phase phase);
    vif=u_agt_cfg.vif;
    
endfunction

//Run_phase
task uart_driver::run_phase(uvm_phase phase);
    
    @(vif.wr_cb);
        vif.wr_cb.wb_rst_i<=1'b1;
    @(vif.wr_cb);
        vif.wr_cb.wb_rst_i<=1'b0;
    
    forever 
        begin
        seq_item_port.get_next_item(req);
        drive(req);
        seq_item_port.item_done();
        end
endtask

task uart_driver::drive(uart_xtn xtn);
    //print transaction 
    `uvm_info("UART_DRIVER",$sformatf("printing from driver \n  %s",xtn.sprint()),UVM_LOW)

    //logic
    repeat(2)
    @(vif.wr_cb);                 
        vif.wr_cb.wb_addr_i<=xtn.wb_addr_i;
        vif.wr_cb.wb_dat_i<=xtn.wb_dat_i;
        vif.wr_cb.wb_sel_i<=4'b0001;
        vif.wr_cb.wb_we_i<=xtn.wb_we_i;
        vif.wr_cb.wb_stb_i<=1'b1;
        vif.wr_cb.wb_cyc_i<=1'b1;
    wait(vif.wr_cb.wb_ack_o)
        vif.wr_cb.wb_stb_i<=1'b0;
        vif.wr_cb.wb_cyc_i<=1'b0;

if(xtn.wb_addr_i==2 && xtn.wb_we_i==0)
    begin
    wait(vif.wr_cb.int_o)

        repeat(5)
        @(vif.wr_cb);

        xtn.iir=vif.wr_cb.wb_dat_o;
        $display("The value of iir(bit error) is :%0b ",vif.wr_cb.wb_dat_o);
        seq_item_port.put_response(xtn);
        
    end

    //increment drv_data_sent_cnt
        u_agt_cfg.drv_data_sent_cnt++;

endtask


// Report_phase
function void uart_driver::report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Report: uart driver sent %0d transactions", u_agt_cfg.drv_data_sent_cnt), UVM_LOW)
    
endfunction