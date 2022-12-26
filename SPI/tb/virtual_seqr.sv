    class virtual_seqr extends uvm_sequencer #(uvm_sequence_item) ;

        //Factory registration
        `uvm_component_utils(virtual_seqr)

        // Handles for master & slave sequecer

        spi_m_sequencer m_seqrh;
        spi_s_sequencer s_seqrh;

        //---------Standard UVM Method --------//

        extern function new (string name ="virtual_seqr",uvm_component parent);
        extern function void build_phase(uvm_phase phase);
  endclass

        //-------Constructor new method --------//
        function virtual_seqr ::new(string name ="virtual_seqr",uvm_component parent);
                super.new(name,parent);
        endfunction

        //---------------- build phase -----------------//
        function void virtual_seqr::build_phase(uvm_phase phase);
                super.build_phase(phase);
        endfunction
