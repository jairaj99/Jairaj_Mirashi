class spi_m_sequencer extends uvm_sequencer #(spi_m_xtn);

        //Factory registration
        `uvm_component_utils(spi_m_sequencer)

        //------Standard methods -------//
        extern function new(string name="spi_m_sequencer",uvm_component parent);

    endclass
        //------- Constructor new method  ------//
        function spi_m_sequencer::new(string name="spi_m_sequencer",uvm_component parent);

                super.new(name,parent);

        endfunction
