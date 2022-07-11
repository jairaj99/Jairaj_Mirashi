class uart_xtn extends uvm_sequence_item;
    `uvm_object_utils(uart_xtn)

    rand logic [4:0] wb_addr_i;
    rand logic [3:0]wb_sel_i; 
    rand logic [7:0] wb_dat_i;
    rand logic wb_we_i;
    rand logic wb_stb_i;
    rand logic wb_cyc_i;

    bit wb_rst_i;

//Internal registers   

    bit [7:0] rb[$];            //register_buffer_register
    bit [7:0] thr[$];           //transmitter_holding_register 
    bit [7:0] ier;              //interrupt_enable_register
    bit [7:0] iir;              //interrupt_identification_register 
    bit [7:0] fcr;              //FIFO_control_register 
    bit [7:0] lcr;              //line_control_register 
    bit [7:0] lsr;              //line_status_register
    bit [7:0] dlb1;             //divisor_latch_byte(LSB of lcr)
    bit [7:0] dlb2;             //divisor_latch_byte(MSB of lcr)
    bit [7:0] mcr;              //modem_control_register
    bit [7:0] msr;              //modem_status_register


extern function new(string name = "uart_xtn");
extern function void do_print(uvm_printer printer);

endclass

// Constuctor
function uart_xtn::new(string name = "uart_xtn");
    super.new(name);

endfunction

// Print 
function  void uart_xtn::do_print (uvm_printer printer);
    super.do_print(printer);

   
    printer.print_field( "wb_dat_i", 		            this.wb_dat_i, 	    64,		 UVM_DEC);
    printer.print_field( "wb_addr_i", 		            this.wb_addr_i, 	12,		 UVM_DEC);
    printer.print_field( "wb_stb_i", 		            this.wb_stb_i, 	    12,		 UVM_DEC);
    printer.print_field( "wb_we_i", 		            this.wb_we_i, 	    12,		 UVM_DEC);
    printer.print_field( "wb_rst_i", 		            this.wb_rst_i, 	    12,		 UVM_DEC);
    printer.print_field( "wb_cyc_i", 		            this.wb_cyc_i, 	    12,		 UVM_DEC);
    printer.print_field( "lcr", 		                this.lcr, 	        64,		 UVM_DEC);
    printer.print_field( "fcr", 		                this.fcr, 	        12,		 UVM_DEC);
    printer.print_field( "lsr", 		                this.lsr, 	        12,		 UVM_BIN);
    printer.print_field( "mcr", 		                this.mcr, 	        12,		 UVM_DEC);
    printer.print_field( "iir", 		                this.iir, 	        8,		 UVM_BIN);
    printer.print_field( "ier", 		                this.ier, 	        12,		 UVM_DEC);
    printer.print_field( "msr", 		                this.msr, 	        12,		 UVM_DEC);
    printer.print_field( "dlb1", 		                this.dlb1, 	        12,		 UVM_DEC);
    printer.print_field( "dlb2", 		                this.dlb2, 	        12,		 UVM_DEC);

foreach(thr[i])
    begin
    printer.print_field($sformatf("thr[%0d]",i),		this.thr[i], 	    12,		 UVM_DEC);
    
    end

foreach(rb[i])
    begin
    printer.print_field($sformatf("rb[%0d]",i),		    this.rb[i], 	    12,		 UVM_DEC);

    end 

endfunction
