interface uart_if(input bit clock);
  
//WISHINPUT SIGNALS
    
    logic [4:0] wb_addr_i;
    logic [7:0] wb_dat_i,wb_dat_o;
    bit [3:0] wb_sel_i;
    bit  wb_we_i, wb_stb_i, wb_cyc_i, wb_ack_o;
	bit wb_rst_i;
	bit wb_clk_i; 


//UART_EXTERNAL SIGNALS

    bit int_o;                        //interupt signal
//  bit baud_o;

    bit stx_pad_o, srx_pad_i;


//DRIVER 
clocking wr_cb @(posedge clock);
default input #1 output #0;

    output wb_addr_i;
    output wb_dat_i;
    output wb_we_i;
    output wb_sel_i;
    output wb_rst_i;
    output wb_cyc_i;
    output wb_stb_i;
    input wb_ack_o;
    input int_o;
    input wb_dat_o;

endclocking
    


//MONITOR
clocking wr_mon_cb @(posedge clock);
default input #1 output #0;
    //input wb_rst_i;
    input wb_addr_i;
    input wb_dat_i;
    input wb_we_i;
    input wb_sel_i;
    input wb_rst_i;
    input wb_cyc_i;
    input wb_stb_i;
    input wb_ack_o;
    input int_o;
    input wb_dat_o;

endclocking




modport UART_DRV(clocking wr_cb);
modport UART_MON(clocking wr_mon_cb);
 

endinterface