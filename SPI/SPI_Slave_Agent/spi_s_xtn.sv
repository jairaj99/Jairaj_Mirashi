 class spi_s_xtn extends uvm_sequence_item;

        //Factory registration

        `uvm_object_utils (spi_s_xtn);

        //Declaring  the transaction items

                rand logic [127:0] miso_pad_i;
                rand logic [127:0] mosi_pad_o;
                     logic [31:0] ss_pad_o;
                   //   bit [31:0] ctrl;
         //------ Standard UVM Methods -------//
                extern function new (string name ="spi_s_xtn");
                extern function void do_print(uvm_printer printer);

     endclass

         //-----------------  constructor new method  -------------------//
                function spi_s_xtn :: new(string name ="spi_s_xtn");
                        super.new(name);
                endfunction

  //-----------------  do_print method  -------------------//
                function void spi_s_xtn :: do_print(uvm_printer printer);
                        super.do_print(printer);
                                printer.print_field("miso_pad_i",this.miso_pad_i, 128, UVM_DEC);
                                printer.print_field("mosi_pad_o",this.mosi_pad_o, 128, UVM_DEC);
                                printer.print_field("ss_pad_o",this.ss_pad_o, 8, UVM_DEC);
                        //       printer.print_field("ctrl",this.ctrl, 32, UVM_DEC);
                endfunction



