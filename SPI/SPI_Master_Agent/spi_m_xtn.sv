class spi_m_xtn extends uvm_sequence_item ;

        //Factory registration
        `uvm_object_utils(spi_m_xtn);

        //Declaring transation items

                rand logic [4:0] wb_adr_i;
                rand logic [31:0]wb_dat_i;
                     logic [31:0]wb_dat_o;
                rand logic [3:0]wb_sel_i;
                rand logic wb_we_i;
                     logic wb_stb_i;
                     logic wb_cyc_i;
                     logic wb_ack_o;
                     logic wb_int_o;


	  //Internal registers

                bit [31:0] rx0;
                bit [31:0] rx1;
                bit [31:0] rx2;
                bit [31:0] rx3;
                bit [31:0] tx0;
                bit [31:0] tx1;
                bit [31:0] tx2;
                bit [31:0] tx3;
                bit [31:0] ctrl_reg;
                bit [31:0] divider;
                bit [31:0] ss;


	  //---------- Standard UVM Methods -------//
        extern function new (string name="spi_m_xtn");
        extern function void do_print (uvm_printer printer);

     endclass

      //---------- Constructor new Method --------//
        function spi_m_xtn::new(string name="spi_m_xtn");
                super.new(name);

        endfunction

	  //------- Do_print method--------//

        function void spi_m_xtn ::do_print(uvm_printer printer);
                super.do_print(printer);

                printer.print_field("wb_adr_i",this.wb_adr_i,5,UVM_DEC);
                printer.print_field("wb_dat_i",this.wb_dat_i,32,UVM_DEC);
                printer.print_field("wb_dat_o",this.wb_dat_o,32,UVM_DEC);
                printer.print_field("wb_sel_i",this.wb_sel_i,4,UVM_DEC);
                printer.print_field("wb_we_i",this.wb_we_i,1,UVM_DEC);
                printer.print_field("wb_stb_i",this.wb_stb_i,1,UVM_DEC);
                printer.print_field("wb_cyc_i",this.wb_cyc_i,1,UVM_DEC);
                printer.print_field("wb_ack_o",this.wb_ack_o,1,UVM_DEC);
                printer.print_field("wb_int_o",this.wb_int_o,1,UVM_DEC);
                printer.print_field("rx0",this.rx0,32,UVM_DEC);
                printer.print_field("rx1",this.rx1,32,UVM_DEC);
                printer.print_field("rx2",this.rx2,32,UVM_DEC);
                printer.print_field("rx3",this.rx3,32,UVM_DEC);
                printer.print_field("tx0",this.tx0,32,UVM_DEC);
                printer.print_field("tx1",this.tx1,32,UVM_DEC);
                printer.print_field("tx2",this.tx2,32,UVM_DEC);
                printer.print_field("tx3",this.tx3,32,UVM_DEC);
                printer.print_field("ctrl",this.ctrl_reg,32,UVM_DEC);
                printer.print_field("divider",this.divider,32,UVM_DEC);
                printer.print_field("ss",this.ss,32,UVM_DEC);

        endfunction
