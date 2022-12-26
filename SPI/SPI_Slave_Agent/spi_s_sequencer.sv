      class spi_s_sequencer extends uvm_sequencer #(spi_s_xtn);

        //Factory registration
        `uvm_component_utils(spi_s_sequencer)

        //------Standard methods -------//
        extern function new(string name="spi_s_sequencer",uvm_component parent);

      endclass

        //------- Constructor new method  ------//
        function spi_s_sequencer::new(string name="spi_s_sequencer",uvm_component parent);

                super.new(name,parent);

        endfunction
